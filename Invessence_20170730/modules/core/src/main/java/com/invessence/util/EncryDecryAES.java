package com.invessence.util;

/**
 * Created by abhangp on 3/14/2016.
 */

import java.security.*;
import java.util.Arrays;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.*;

public class EncryDecryAES
{

   private static final String ALGO = "AES";

   public static String encrypt(String Data, String keyValue) throws Exception
   {
      //System.out.println("EncryDecryAES.encrypt()");
      Key key = generateKey(keyValue);
      Cipher c = Cipher.getInstance(ALGO);
      c.init(Cipher.ENCRYPT_MODE, key);
      byte[] encVal = c.doFinal(Data.getBytes());
      String encryptedValue = new BASE64Encoder().encode(encVal);
      return encryptedValue;
   }

   public static String decrypt(String encryptedData, String keyValue) throws Exception
   {
      //System.out.println("EncryDecryAES.decrypt()");
      Key key = generateKey(keyValue);
      Cipher c = Cipher.getInstance(ALGO);
      c.init(Cipher.DECRYPT_MODE, key);
      byte[] decordedValue = new BASE64Decoder().decodeBuffer(encryptedData);
      byte[] decValue = c.doFinal(decordedValue);
      String decryptedValue = new String(decValue);
      return decryptedValue;
   }

   private static Key generateKey(String keyValue) throws Exception
   {
      MessageDigest sha1 = MessageDigest.getInstance("SHA-1");
      byte[] key1 = sha1.digest(keyValue.getBytes());
      key1 = Arrays.copyOf(key1, 16);
      Key key = new SecretKeySpec(key1, ALGO);
      return key;
   }

}

