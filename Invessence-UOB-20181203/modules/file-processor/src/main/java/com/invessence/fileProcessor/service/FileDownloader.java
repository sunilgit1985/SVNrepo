package com.invessence.fileProcessor.service;

import java.io.*;
import java.nio.file.*;
import java.text.SimpleDateFormat;
import java.util.*;

import com.invessence.converter.*;
import com.invessence.fileProcessor.bean.DBParameters;
import com.invessence.fileProcessor.dao.FileProcessorDao;
import com.invessence.fileProcessor.util.FileProcessorUtil;
import com.invessence.service.bean.ServiceRequest;
import com.invessence.service.bean.fileProcessor.*;
import com.invessence.service.util.*;
import com.jcraft.jsch.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Created by abhangp on 4/25/2017.
 */
@Component
public class FileDownloader
{
   private static final Logger logger = Logger.getLogger(FileDownloader.class);
   @Autowired
   FileProcessorDao fileProcessorDao;

   @Autowired
   FileProcessorUtil fileProcessorUtil;

   SQLData convert = new SQLData();

   public boolean download(ServiceRequest serviceRequest, FileDetails fileDetails, LinkedHashMap<String,FileRules> fileRules, StringBuilder mailAlertMsg, Map<String, DBParameters> dbParamMap){
      boolean returnValue=false;
      try
      {
         System.out.println("FileDownloader.download");
//         fileProcessorUtil.executeInstruction(fileDetails,"PARENTPRE", mailAlertMsg, serviceRequest);

         System.out.println("serviceRequest = [" + serviceRequest + "], fileDetails = [" + fileDetails + "], fileRules = [" + fileRules + "]");
         ArrayList<LinkedHashMap<String, Object>> rows=(ArrayList<LinkedHashMap<String, Object>>)fileProcessorDao.dbCall(serviceRequest.getProduct(), Constant.SERVICES.FILE_PROCESS.toString(),
                                 Constant.ADDITIONAL_DETAILS.FILE_DETAILS.toString(), fileDetails.getPreDBProcess());
         if(rows==null || rows.size()==0){
            System.out.println("Data not available in "+fileDetails.getPreDBProcess()+" for File Processor  for File sequence "+fileDetails.getSeqNo());
            mailAlertMsg.append("Data not available in "+fileDetails.getPreDBProcess()+" for File Processor for File sequence"+fileDetails.getSeqNo()+"\n");

         }else{
            Iterator<LinkedHashMap<String, Object>> itr = rows.iterator();
            List<String> fileData=new ArrayList<String>();
            if(fileDetails.getContainsHeader().equalsIgnoreCase("Y")){
               StringBuilder fileHeader=new StringBuilder();
               Iterator<Map.Entry<String, FileRules>> entries = fileRules.entrySet().iterator();
               while (entries.hasNext())
               {
                  Map.Entry<String, FileRules> entry6 = entries.next();
                  FileRules fileRules1=(FileRules) entry6.getValue();
                  fileHeader.append(entry6.getKey()).append(fileRules1.getDelimiter());
//                  if(fileRules1.getIsDelimited().equalsIgnoreCase("N")){
//                     return appendSpace(entry6.getKey().toString(), fileRules1.getLength());
//                  }else if(fileRules1.getIsDelimited().equalsIgnoreCase("Y")){
//                     return val+fileRules1.getDelimiter();
//                  }
               }
               if(fileDetails.getLoadFormat().equalsIgnoreCase("DELIMITED")){
                  if((fileHeader.lastIndexOf(fileDetails.getDelimiter())+1)==fileHeader.length()){
                     fileData.add(fileHeader.substring(0,fileHeader.length()-1));
                  }else
                  {
                     fileData.add(fileHeader.toString());
                  }
               }else
               {
                  fileData.add(fileHeader.toString());
               }
            }
            while (itr.hasNext())
            {
               StringBuilder fileRow=new StringBuilder();
               LinkedHashMap<String, Object> map = itr.next();
               Iterator<Map.Entry<String, FileRules>> entries = fileRules.entrySet().iterator();
               while (entries.hasNext())
               {
                  Map.Entry<String,FileRules> entry6 = entries.next();
                  FileRules fileRules1=(FileRules) entry6.getValue();
//                  System.out.println(fileRules1.getSeqNo()+" : "+fileRules1.getDataField()+" : "+fileRules1.getDbColumn()+" : "+convert.getIntData(map.get(fileRules1.getDbColumn())));
                  fileRow.append(getValue(map.get(fileRules1.getDbColumn())==null?"":""+map.get(fileRules1.getDbColumn()), fileRules1));
               }
               if(fileRow.length()>0){
                  System.out.println(fileRow.lastIndexOf(fileDetails.getDelimiter()));
                  System.out.println(fileRow.length());
                  if(fileDetails.getLoadFormat().equalsIgnoreCase("DELIMITED")){
                     if((fileRow.lastIndexOf(fileDetails.getDelimiter())+1)==fileRow.length()){
                        fileData.add(fileRow.substring(0,fileRow.length()-1));
                     }else
                     {
                        fileData.add(fileRow.toString());
                     }
                  }else
                  {
                     fileData.add(fileRow.toString());
                  }
               }
//               System.out.println("-------------------------------------------------");
            }

            if(fileData.size()>0){
               return generateFile(fileData, fileDetails, serviceRequest, dbParamMap.get("BUSINESS_DATE").getValue().toString(), mailAlertMsg);
            }else{
               logger.warn("Data not available for "+fileDetails.getFileName()+" file.");
            }
         }
      }catch(Exception e){
         mailAlertMsg.append("Issue while processing file " + fileDetails.getFileName() + " from processId "+fileDetails.getProcessId()+ " for File sequence "+fileDetails.getSeqNo()+" \n");
         e.printStackTrace();
      }
      return  returnValue;
   }

   public String getValue(String val, FileRules fileRules){
      if(fileRules.getType().equalsIgnoreCase("TEXT")){
         if(fileRules.getIsDelimited().equalsIgnoreCase("N")){
            return appendSpace(val, fileRules.getLength(), fileRules.getJustified());
         }else if(fileRules.getIsDelimited().equalsIgnoreCase("Y")){
            return val+fileRules.getDelimiter();
         }
      }else if(fileRules.getType().equalsIgnoreCase("NUMERIC")){
         if(fileRules.getIsDelimited().equalsIgnoreCase("N")){
            return appendSpace(val, fileRules.getLength(), fileRules.getJustified());
         }else if(fileRules.getIsDelimited().equalsIgnoreCase("Y")){
            return val+fileRules.getDelimiter();
         }
      }else if(fileRules.getType().equalsIgnoreCase("DATE")){
         if(fileRules.getIsDelimited().equalsIgnoreCase("N")){
            if(fileRules.getFormat()==null || fileRules.getFormat().trim().equals(""))
            {
               return appendSpace(val, fileRules.getLength(), fileRules.getJustified());
            }else{
               return appendSpace(DateUtil.parseDate(val, "yyyyMMdd", fileRules.getFormat()), fileRules.getLength(), fileRules.getJustified());
            }
         }else if(fileRules.getIsDelimited().equalsIgnoreCase("Y")){
            if(fileRules.getFormat()==null || fileRules.getFormat().trim().equals(""))
            {
               return val+fileRules.getDelimiter();
            }else{
               return DateUtil.parseDate(val, "yyyyMMdd", fileRules.getFormat())+fileRules.getDelimiter();
            }
         }
      }else{
         System.out.println("Condition not mapped for format "+ fileRules.getType());
      }
      return val;
   }

   private String appendSpace(String val, Integer len, String position){
      StringBuilder sb=new StringBuilder();
      if(position==null  || position.equalsIgnoreCase("LEFT"))
      {
         sb.append(val);
         for (int i = 0; i < len - val.length(); i++)
         {
            sb.append(" ");
         }
      }else  if(position.equalsIgnoreCase("RIGHT"))
      {
         for (int i = 0; i < len - val.length(); i++)
         {
            sb.append(" ");
         }
         sb.append(val);
      }
      return sb.toString();
   }
   private boolean generateFile(List<String> fileData, FileDetails fileDetails, ServiceRequest serviceRequest, String businessDate, StringBuilder mailAlertMsg)throws Exception{
      System.out.println("FileDownloader.generateFile");
      boolean result=false;
      try{
         Iterator<String> fileDataItr=fileData.iterator();

         File file = new File(fileProcessorUtil.getFilePath(serviceRequest,fileDetails,"LOCAL",businessDate));
         if (!file.getParentFile().exists())
         {
            try
            {
               logger.info("Creating local upload directory :" + file);
               file.getParentFile().mkdirs();
            }
            catch (Exception e)
            {
               logger.error("Creating local upload directory :" + file + " \n" + e.getMessage());
            }
         }
         FileWriter fr = null;
         BufferedWriter br = null;
         //String dataWithNewLine=data+System.getProperty("line.separator");
         try{
            fr = new FileWriter(file);
            br = new BufferedWriter(fr);

            while(fileDataItr.hasNext()){
               String row=fileDataItr.next();
               br.write(row);
               br.newLine();
            }
            br.close();
            fr.close();
            if(fileDetails.getFileProcessType()!=null && !fileDetails.getFileProcessType().equals("")&& fileDetails.getFileProcessType().equals("SFTP")){
               copyFileToSFTPServer(serviceRequest, file, fileDetails, businessDate, mailAlertMsg);
            }
            fileProcessorUtil.deleteFilesFromLocal(fileDetails, fileProcessorUtil.getListOfFiles(file.getParent(), fileDetails.getFileName()), businessDate, file.getParent(), mailAlertMsg);

            result=true;
         } catch (IOException e) {
            mailAlertMsg.append("Issue while creating file " + fileDetails.getFileName() + " to local directory from processId "+fileDetails.getProcessId()+" \n");
            e.printStackTrace();
         }finally{
            try {
               br.close();
               fr.close();
            } catch (IOException e) {
               e.printStackTrace();
            }
         }

      }catch(Exception e){
         e.printStackTrace();
      }
      return result;
   }

   private boolean copyFileToSFTPServer(ServiceRequest serviceRequest, File f, FileDetails fileDetails, String businessDate, StringBuilder mailAlertMsg){
      logger.info("FileDownloader.copyFileToSFTPServer");
      Session session = null;
//      Channel channel = null;
      boolean result=false;
      ChannelSftp channel = null;
      try{
         JSch jsch = new JSch();
         session = jsch.getSession(ServiceDetails.getConfigProperty(serviceRequest.getProduct(), Constant.SERVICES.FILE_PROCESS.toString(), serviceRequest.getMode(), "DOWNLOAD_SFTP_USERNAME"),
                                   ServiceDetails.getConfigProperty(serviceRequest.getProduct(), Constant.SERVICES.FILE_PROCESS.toString(), serviceRequest.getMode(), "DOWNLOAD_SFTP_HOST"), 22);
         session.setPassword(ServiceDetails.getConfigProperty(serviceRequest.getProduct(), Constant.SERVICES.FILE_PROCESS.toString(), serviceRequest.getMode(), "DOWNLOAD_SFTP_PASSWORD"));
         session.setConfig("StrictHostKeyChecking", "no");
         session.connect();

         logger.info("Established the connection with host server");

         channel = (ChannelSftp) session.openChannel("sftp");
         channel.connect();

//         String serverPath = ServiceDetails.getConfigProperty(serviceRequest.getProduct(), Constant.SERVICES.FILE_PROCESS.toString(), serviceRequest.getMode(), "DOWNLOAD_SFTP_SRC_DIRECTORY")+fileDetails.getUploadDir();
//         System.out.println("*FILE PATH :"+FileProcessor.getFilePath(serviceRequest,fileDetails,"SFTP",businessDate));
//         System.out.println("serverPath = " + serverPath);

         Path p= Paths.get(fileProcessorUtil.getFilePath(serviceRequest,fileDetails,"SFTP",businessDate));

         String fileName = p.getFileName().toString();
         String directory = p.getParent().toString().replaceAll("\\\\","/");
         logger.debug("directory = " + directory+ " fileName = " + fileName);

         //channel.mkdir(directory);
         channel.cd(directory);
         channel.put(new FileInputStream(f), fileName);

         List<String> fileNameLst = new ArrayList<String>();
         StringBuilder searchString=new StringBuilder();
         if(fileDetails.getFileNameAppender().equalsIgnoreCase("PREFIX")){
            searchString.append("*_").append(fileDetails.getFileName()).append("."+fileDetails.getFileExtension());
         }else if(fileDetails.getFileNameAppender().equalsIgnoreCase("POSTFIX")){
            searchString.append(fileDetails.getFileName()).append("_*").append("."+fileDetails.getFileExtension());
         }else{
            searchString.append(fileDetails.getFileName()).append("."+fileDetails.getFileExtension());
         }
         logger.debug("SearchString = " + searchString +" to fetch files from Server.");
         Vector v = channel.ls(searchString.toString());

         logger.debug("Fetching list of " + searchString.toString() + " files from server" + v.size());
         ChannelSftp.LsEntry entry = null;
         for (int i = 0; i < v.size(); i++)
         {
            entry = (ChannelSftp.LsEntry) v.get(i);
            fileNameLst.add(entry.getFilename());
         }
         logger.debug("Fetching list of " + fileDetails.getFileName() + " files from server" + v.size());
         if (fileNameLst == null || fileNameLst.size() == 0)
         {
            logger.info(fileDetails.getFileName() + " files are not available on server for delete, for Advisor " + fileDetails.getVendor() + "\n");
         }
         else
         {
            Collections.sort(fileNameLst);
            fileProcessorUtil.deleteFilesFromServer(fileDetails, fileNameLst, channel, businessDate, mailAlertMsg);
         }

         result=true;
         channel.disconnect();
         session.disconnect();

      }catch(Exception e){
         mailAlertMsg.append("Issue while coping file " + fileDetails.getFileName() + " to SFTP server from processId "+fileDetails.getProcessId()+" \n");
         e.printStackTrace();
      }finally {

         channel.disconnect();
         System.out.println("Channel disconnected.");
         session.disconnect();
         System.out.println("Host Session disconnected.");
      }
      return result;
   }

   private String createFileName(FileDetails fileDetails){
      System.out.println("FileDownloader.createFileName");
      StringBuilder fileName=new StringBuilder();

      try{
         if(fileDetails.getFileNameAppender()==null || fileDetails.getFileNameAppender().equalsIgnoreCase(""))
         {
            return fileName.append(fileDetails.getFileName()).append(".").append(fileDetails.getFileExtension()).toString();
         }else
         {
            if (fileDetails.getFileNameAppender().equalsIgnoreCase("PREFIX"))
            {
               String formattedDate = getFormatedDate(fileDetails.getAppenderFormat());
               if (formattedDate != null)
               {
                  return fileName.append(formattedDate).append(fileDetails.getFileName()).append(".").append(fileDetails.getFileExtension()).toString();
               }
            }
            if (fileDetails.getFileNameAppender().equalsIgnoreCase("POSTFIX"))
            {
               String formattedDate = getFormatedDate(fileDetails.getAppenderFormat());
               if (formattedDate != null)
               {
                  return fileName.append(fileDetails.getFileName()).append(formattedDate).append(".").append(fileDetails.getFileExtension()).toString();
               }
            }
         }
      }catch(Exception e){
         e.printStackTrace();
      }
      return fileName.append(fileDetails.getFileName()).append(".").append(fileDetails.getFileExtension()).toString();
   }


   private String getFormatedDate(String dateFormat){

      try{
         if(dateFormat==null){
            logger.warn("DateFormat is not available!");
         }else
         {
            SimpleDateFormat mdyFormat = new SimpleDateFormat(dateFormat);
            Date myDate = new Date();
            return mdyFormat.format(myDate);
         }
      }catch(Exception e){
         logger.error(e.getMessage());
         e.printStackTrace();
      }
      return null;
   }

}
