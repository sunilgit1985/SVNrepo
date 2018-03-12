package com.invessence.data;

/**
 * Created by abhangp on 12/15/2017.
 */
public class ZipFile
{
   private String fileName;
   private String fileLocation;

   public String getFileName()
   {
      return fileName;
   }

   public void setFileName(String fileName)
   {
      this.fileName = fileName;
   }

   public String getFileLocation()
   {
      return fileLocation;
   }

   public void setFileLocation(String fileLocation)
   {
      this.fileLocation = fileLocation;
   }

   public ZipFile(String fileName, String fileLocation)
   {
      this.fileName = fileName;
      this.fileLocation = fileLocation;
   }

   @Override
   public String toString()
   {
      return "ZipFile{" +
         "fileName='" + fileName + '\'' +
         ", fileLocation='" + fileLocation + '\'' +
         '}';
   }
}
