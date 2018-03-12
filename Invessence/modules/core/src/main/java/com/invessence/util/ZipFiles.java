package com.invessence.util;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import com.invessence.data.ZipFile;

/**
 * Created by abhangp on 7/21/2017.
 */
public class ZipFiles {

   public static void main(String[] args) {

      try {
         FileOutputStream fos = new FileOutputStream("atest.zip");
         ZipOutputStream zos = new ZipOutputStream(fos);

         String file1Name = "file1.txt";
         String file2Name = "file2.txt";
         String file3Name = "folder/file3.txt";
         String file4Name = "folder/file4.txt";
         String file5Name = "f1/f2/f3/file5.txt";

         addToZipFile(file1Name, zos);
         addToZipFile(file2Name, zos);
         addToZipFile(file3Name, zos);
         addToZipFile(file4Name, zos);
         addToZipFile(file5Name, zos);

         zos.close();
         fos.close();

      } catch (FileNotFoundException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      }

   }

   public static void createZipFile(
      String zipFileName,
      String zipFileLocation, List<ZipFile> files) throws IOException
   {
         File file = new File(zipFileLocation);
         if(!file.getParentFile().exists()){
            Files.createDirectory(file.toPath());
         }
         FileOutputStream fos = new FileOutputStream(zipFileLocation+"/"+zipFileName+".zip");
         ZipOutputStream zos = new ZipOutputStream(fos);

         for (ZipFile zipFile:files){
            addToZipFile(zipFile.getFileName(), zos);
         }
         zos.close();
         fos.close();
   }

   private static void addToZipFile(String fileName, ZipOutputStream zos) throws FileNotFoundException, IOException {

      System.out.println("Writing '" + fileName + "' to zip file");

      File file = new File(fileName);
      FileInputStream fis = new FileInputStream(file);
      ZipEntry zipEntry = new ZipEntry(file.getName());
      zos.putNextEntry(zipEntry);

      byte[] bytes = new byte[1024];
      int length;
      while ((length = fis.read(bytes)) >= 0) {
         zos.write(bytes, 0, length);
      }

      zos.closeEntry();
      fis.close();
   }

}
