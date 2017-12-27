package com.invessence.docServices.service;

import java.util.*;

import com.invessence.custody.data.*;
import com.invessence.custody.uob.UOBDataMaster;
import com.invessence.custody.uob.data.CustodyFileRequest;
import com.invessence.data.ZipFile;
import com.invessence.emailer.util.EmailCreator;
import com.invessence.service.bean.*;
import com.invessence.service.util.*;
import com.invessence.util.ZipFiles;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.Service;

/**
 * Created by abhangp on 3/11/2016.
 */

@Service("documentServiceTraffic")
public class DocumentServiceTrafficImpl implements DocumentServiceTraffic
{
   private static final Logger logger = Logger.getLogger(DocumentServiceTrafficImpl.class);
//   @Autowired
//   private CustodyService custodyService;

   @Autowired
   EmailCreator emailCreator;

   @Autowired @Qualifier("itextDocService")
   CallingLayer itextCallingLayer;

   @Autowired @Qualifier("docusignDocService")
   CallingLayer docuSignCallingLayer;

   @Autowired @Qualifier("dopboxDocService")
   CallingLayer dropBoxCallingLayer;


   CallingLayer callingLayer;

   private CallingLayer getCallingLayer(String product){
      System.out.println("******------------------");
      String documentServiceAPI=ServiceDetails.getServiceProvider(product,Constant.SERVICES.DOCUMENT_SERVICES.toString());//getServiceProvider();
      if(documentServiceAPI==null){
         logger.error(Constant.SERVICES.DOCUMENT_SERVICES.toString()+" API is not available");
      }else if(documentServiceAPI.equals("iText")){
         System.out.println("iText");
         callingLayer = itextCallingLayer;
      }else if(documentServiceAPI.equals("DOCUSIGN")){
         System.out.println("DOCUSIGN");
         callingLayer = docuSignCallingLayer;
      }else if(documentServiceAPI.equals("DROPBOX")){
         System.out.println("DROPBOX");
         callingLayer = dropBoxCallingLayer;
      }else{
         logger.error(documentServiceAPI+" API is not available");
      }
      return callingLayer;
   }

//   private CallingLayer getCallingLayer(){
//      //SysParameters.BROKER_WEBSERVICE_API
//      System.out.println("******------------------");
//      String webServiceAPI=ServiceParameters.BROKER_WEBSERVICE_API;//getServiceProvider();
//      if(webServiceAPI==null){
//         logger.error(Constant.SERVICES.BROKER_WEBSERVICES.toString()+" API is not available");
//      }else if(webServiceAPI.equals("GEMINI")){
//         System.out.println("Gemini");
//         callingLayer = itextCallingLayer; //new CallingLayerGeminiImpl(commonDao);
//      }else if(webServiceAPI.equals("TD")){
//         System.out.println("TD");
//         callingLayer = docuSignCallingLayer;//new CallingLayerTDImpl();
//      }else{
//         logger.error(webServiceAPI+" API is not available");
//      }
//      return callingLayer;
//   }

   @Override
   public WSCallResult createDoc(ServiceRequest serviceRequest, Object object, List<AORequest> aoRequests, List<CustodyFileRequest> updFileLst, StringBuilder requestIds)throws  Exception
   {
      WSCallResult wsCallResult=null;
      List<ZipFile> filesForZip= new LinkedList<>();
      System.out.println("serviceRequest = " + serviceRequest);
      callingLayer=getCallingLayer(serviceRequest.getProduct());
      UOBDataMaster uobDataMaster = (UOBDataMaster) object;
      for(AORequest aoRequest:aoRequests){
         System.out.println("aoRequest = " + aoRequest);
         wsCallResult=callingLayer.createDoc(serviceRequest, object, aoRequest);
//         List<CustodyFileRequest> updFileLst=custodyService.fetchUploadedFiles(serviceRequest.getProduct(), aoRequest.getAcctnum(), aoRequest.getReqType());
         requestIds.append(aoRequest.getReqId()+",");
         if(wsCallResult.getWSCallStatus().getErrorCode()==1)
         {
            filesForZip.add(new ZipFile(wsCallResult.getGenericObject().toString(),wsCallResult.getGenericObject().toString()));
         }else{
            return wsCallResult;
         }
      }
      if(wsCallResult!=null && wsCallResult.getWSCallStatus().getErrorCode()==1)
      {
         for(CustodyFileRequest custodyFileRequest: updFileLst){
            filesForZip.add(new ZipFile(custodyFileRequest.getFilePath()+"/"+custodyFileRequest.getFileName(),custodyFileRequest.getFilePath()+"/"+custodyFileRequest.getFileName()));
         }
         if (filesForZip.size() > 0)
         {
            String zipDirectory=ServiceDetails.getConfigProperty(serviceRequest.getProduct(), Constant.SERVICES.DOCUMENT_SERVICES.toString(), serviceRequest.getMode(), "ZIP_FILES_DIRECTORY");
            String zipFileName=uobDataMaster.getAccountDetails().getAcctnum().toString();
            ZipFiles.createZipFile(zipFileName, zipDirectory, filesForZip);
            emailCreator.createEmail(serviceRequest, uobDataMaster.getIndividualOwnersDetails().getEmailAddress(), "Account Opening Files", "Files related Account Opening Process.", zipDirectory+"/"+zipFileName+".zip");

         }

      }
      return wsCallResult;
   }

   @Override
   public WSCallResult sendDoc(ServiceRequest serviceRequest, Object object)
   {
      return null;
   }

//   public WSCallStatus createUser(String clientAccountID, String securityQuestion, String securityAnswer)
//   {
//      try
//      {
//         StringBuilder emailAlertMessage=new StringBuilder();
//
//         UserAcctDetails userAcctDetails=commonDao.getUserAccDetailsByAccNumber(clientAccountID);
//         if(userAcctDetails==null){
//            System.out.println("User Account Details not available in DB");
//         }else{
//            String password="test01";
//            String userId="inv_"+userAcctDetails.getClientAccountID();
//
//            WSCallStatus callStatus = callingLayer.loginUser(userAcctDetails);
//            if (callStatus == null)
//            {
//
//            }else{
//               if(callStatus.getErrorCode()==0){
//                  userAcctDetails.setUserID(userId);
//                  userAcctDetails.setPwd(password);
//                  userAcctDetails.setSecurityQuestion(securityQuestion);
//                  userAcctDetails.setSecurityAnswer(securityAnswer);
//                  userAcctDetails.setFundGroupName(SysParameters.BROKER_WEBSERVICES_GEMINI_FUND_GROUP_NAME);
//                  userAcctDetails.setStatus("S");
//                  userAcctDetails.setRemarks(callStatus.getErrorMessage());
//               }else{
//                  userAcctDetails.setStatus("E");
//                  userAcctDetails.setRemarks(callStatus.getErrorMessage());
//                  emailAlertMessage.append(userAcctDetails.getClientAccountID()+":"+userAcctDetails.getRemarks()+"\n");
//                }
//            }
//            try
//            {
//               commonDao.updatePendingUserAccDetails(userAcctDetails);
//            }
//            catch (Exception e)
//            {
//               e.printStackTrace();
//            }
//            return callStatus;
//         }
//      }
//      catch (Exception e)
//      {
//         e.printStackTrace();
//      }
//      return null;
//   }

//   public WSCallStatus isUserExist(String userId)
//   {
//      return null;
//   }

// public WSCallStatus getMailingAddress(String clientAccountID)
//   {
//      try
//      {
//         StringBuilder emailAlertMessage=new StringBuilder();
//         callingLayer=getCallingLayer();
//
//         UserAcctDetails userAcctDetails=commonDao.getUserAccDetailsByAccNumber(clientAccountID);
//         if(userAcctDetails==null){
//            System.out.println("User Account Details not available in DB");
//         }else{
//
//            WSCallStatus callStatus = callingLayer.getMailingAddress(userAcctDetails);
//            if (callStatus == null)
//            {
//
//            }else{
//               if(callStatus.getErrorCode()==0){
//
//               }else{
//                  emailAlertMessage.append(userAcctDetails.getClientAccountID()+":"+userAcctDetails.getRemarks()+"\n");
//               }
//            }
//
//            return callStatus;
//         }
//      }
//      catch (Exception e)
//      {
//         e.printStackTrace();
//      }
//      return null;
//   }

}
