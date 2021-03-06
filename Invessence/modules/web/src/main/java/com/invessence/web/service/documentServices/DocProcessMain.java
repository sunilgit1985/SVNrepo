package com.invessence.web.service.documentServices;

import java.lang.reflect.*;
import java.util.*;

import com.invessence.custody.dao.*;
import com.invessence.custody.data.*;
import com.invessence.custody.uob.UOBDataMaster;
import com.invessence.custody.uob.dao.*;
import com.invessence.custody.uob.data.CustodyFileRequest;
import com.invessence.docServices.service.*;
import com.invessence.service.bean.ServiceRequest;
import com.invessence.web.service.custody.UOBCustodyServiceImpl;
import com.invessence.ws.bean.WSCallResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by abhangp on 11/22/2017.
 */
public class DocProcessMain
{
   public static void main(String[] args) throws NoSuchFieldException, IllegalAccessException
   {
      StringBuilder requestIds= new StringBuilder();
      Date reqTime = new Date();
//      Long acctNum = new Long(3203); //3203 3367  3552  3204
      Long acctNum = new Long(4016); // 3367  3552  3204
      int eventNum = 1;
      ServiceRequest serviceRequest = new ServiceRequest("UOB", "DEV");
      CustodyDaoLayerImpl custodyDaoLayer=null;
      try
      {

//      (new String[] {"Spring-Common.xml","Spring-Connection.xml","Spring-ModuleA.xml"}) //D:\Project\Abhang\work\trunc\latest\Invessence\modules\web\src\main\webapp\WEB-INF\applicationContext.xml
         ConfigurableApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"custodyConfig.xml", "documentServicesConfig.xml",});




         custodyDaoLayer = (CustodyDaoLayerImpl) context.getBean("custodyDaoLayerImpl");
         List<AORequest> aoRequests = custodyDaoLayer.getAORequests(acctNum, eventNum);
         UOBDaoImpl uobDao = (UOBDaoImpl) context.getBean("uobDaoImpl");
         UOBDataMaster uobDataMaster = (UOBDataMaster) uobDao.fetch(acctNum);
//         System.out.println("uobDataMaster = " + uobDataMaster);


// ACCT_OPEN_NEW_USER          ACCT_OPEN_EXISTING_USER
         List<CustodyFileRequest> updFileLst=custodyDaoLayer.fetchUploadedFiles(serviceRequest.getProduct(), acctNum,"ACCT_OPEN_EXISTING_USER");

         DocumentServiceTraffic dst = (DocumentServiceTrafficImpl) context.getBean("documentServices");

         System.out.println(dst.createDoc(serviceRequest, uobDataMaster, aoRequests, updFileLst, requestIds));

         AORequestAudit aoRequestAudit = new AORequestAudit(serviceRequest.getProduct(), serviceRequest.getMode(), requestIds.toString(), acctNum, eventNum, "", "", "S", reqTime, "" );
         custodyDaoLayer.callDCAuditSP(aoRequestAudit);
//         for(AORequest aoRequest:aoRequests){
//            System.out.println("aoRequest = " + aoRequest);
//            UOBDataMaster uobDataMaster = (UOBDataMaster) uobDao.fetch(acctNum);
////            System.out.println("uobDataMaster = " + uobDataMaster);
//            DocumentServiceTraffic dst = (DocumentServiceTrafficImpl) context.getBean("documentServices");
//            dst.createDoc(serviceRequest, uobDataMaster, aoRequests);
//         }



         context.close();


         WSCallResult wsCallResult = null;


      }catch (Exception e){
         e.printStackTrace();
         AORequestAudit dcRequestAudit = new AORequestAudit(serviceRequest.getProduct(), serviceRequest.getMode(),requestIds.toString(), acctNum, eventNum,"", e.toString(), "E", reqTime, "");
         custodyDaoLayer.callDCAuditSP(dcRequestAudit);
      }
//      System.out.println(UOBDataMaster.class.getField("previousInvestingExperience "));
//
//      try
//      {
////         getMemberFields1(uobDataMaster);
//         abhang(uobDataMaster);
////         getMemberMethods(uobDataMaster);
//      }
//      catch (NoSuchMethodException e)
//      {
//         e.printStackTrace();
//      }
//

//      try
//      {
////         getMemberFields1(uobDataMaster);
//         getMemberMethods(uobDataMaster);
//      }
//      catch (NoSuchMethodException e)
//      {
//         e.printStackTrace();
//      }
//      catch (InvocationTargetException e)
//      {
//         e.printStackTrace();
//      }

//      for (Method method : UOBDataMaster.class.getMethods()) {
//         Class returnClass = method.getReturnType();
//         if (Collection.class.isAssignableFrom(returnClass)) {
//            Type returnType = method.getGenericReturnType();
//
//            if(returnType.toString().equalsIgnoreCase("java.util.List<com.invessence.custody.uob.data.OwnerTaxationDetails>")){
//               System.out.println("Its List");
//            }
//            System.out.println(returnType.toString());
//            if (returnType instanceof ParameterizedType) {
//               ParameterizedType paramType = (ParameterizedType) returnType;
//               Type[] argTypes = paramType.getActualTypeArguments();
//               if (argTypes.length > 0) {
//                  System.out.println("Generic type is " + argTypes[0]);
//               }
//            }
//         }
//      }
   }

   public static void abhang(Object obj) throws IllegalAccessException, NoSuchFieldException, NoSuchMethodException
   {
      Class<?> objClass = obj.getClass();
      System.out.println("obj: " + obj.getClass());


      Field[] fields = objClass.getDeclaredFields();
      List<Field> fLst = Arrays.asList(fields);
      for (Field field : fields)
      {
         field.setAccessible(true);
//         System.out.println("Field: " + field.getName() + " value: " + field.get(obj));

         Field[] innerFields = {};
         if (field.getType().getName().contains("java.lang"))
         {
//            Method meth = objClass.getMethod(, null);
            innerFields = field.getType().getDeclaredFields();
            System.out.println("Its Normal field :"+field.getName());
         }else if (field.getType().getName().contains("com.invessence.custody.uob.data"))
         {
            innerFields = field.getType().getDeclaredFields();
            System.out.println("Its Object field :"+field.getName());
            String fieldName="get"+field.getName().substring(0, 1).toUpperCase() + field.getName().substring(1);
            Method method1 = objClass.getMethod(fieldName, null);

            Object returnValue = null;
            try
            {
               returnValue = method1.invoke(obj, null);
               abhang(returnValue);
            }
            catch (InvocationTargetException e)
            {
               System.out.println(e.getMessage());
               //e.printStackTrace();
            }
//            System.out.println("returnValue = " + returnValue);

//            if(method.getReturnType().toString().contains("java.lang")){
//               System.out.println("returnValue = " + returnValue);
//            }else
//            if(method.getReturnType().toString().contains("java.util.List")){
//               System.out.println("Its List");
//            }else{
//               System.out.println("NOT PRIMITIVE");
//               getMemberMethods(returnValue);
////               abhang(returnValue);
//            }
         }else{
            System.out.println("");
         }


      }
   }



   public static void getMemberFields1(Object obj) throws IllegalAccessException, NoSuchFieldException, NoSuchMethodException
   {
      Class<?> objClass = obj.getClass();
      System.out.println("obj: " + obj.getClass());



      Field[] fields = objClass.getDeclaredFields();
      List<Field> fLst=Arrays.asList(fields);
      for(Field field : fields) {
         field.setAccessible(true);
         System.out.println("Field: " + field.getName() + " value: " + field.get(obj));

         Field[] innerFields = {};
         if (!field.getType().getName().contains("java.lang")) {
//            Method meth = objClass.getMethod(, null);
            innerFields = field.getType().getDeclaredFields();
         }
//         if(field.getName()){
//
//         }

         for (Field innerField: innerFields) {
            if (!innerField.getName().contains("java.lang")) {
               Object subObj = field.getType();

               innerField.setAccessible(true);
               System.out.println("");

               System.out.println("Sub Field: " + innerField.getName());

//               System.out.println( "Sub Field value: " + innerField.get(new Bar()));
            }

         }
      }
   }
   public static void getMemberFields2(Object obj) throws IllegalAccessException, NoSuchFieldException, NoSuchMethodException
   {
      Class<?> objClass = obj.getClass();
      System.out.println("obj: " + obj.getClass());

      Field[] fields = objClass.getDeclaredFields();
      for(Field field : fields) {
         field.setAccessible(true);
         System.out.println("Field: " + field.getName() + " value: " + field.get(obj));

         Field[] innerFields = {};
         if (!field.getType().getName().contains("java.lang")) {
            innerFields = field.getType().getDeclaredFields();
         }
      }
   }
   public static void getMemberMethods(Object obj) throws IllegalAccessException, NoSuchFieldException, NoSuchMethodException, InvocationTargetException
   {
      Class<?> objClass = obj.getClass();
      System.out.println("obj: " + obj.getClass());

      Method[] methods = objClass.getDeclaredMethods();
      for(Method method : methods) {
         method.setAccessible(true);

         if(isGetter(method)){
            System.out.println("getter: " + method);
            Method method1 = objClass.getMethod(method.getName(), null);

            Object returnValue = method1.invoke(obj, null);

            if(method.getReturnType().toString().contains("java.lang")){
               System.out.println("returnValue = " + returnValue);
            }else
            if(method.getReturnType().toString().contains("java.util.List")){
               System.out.println("Its List");
            }else{
               System.out.println("NOT PRIMITIVE");
               getMemberMethods(returnValue);
//               abhang(returnValue);
            }
//            getMemberFields(returnValue);
//            getMemberMethods(returnValue);
//            Object retobj = method.invoke();
//            System.out.println("retobj = " + retobj);
         }
        // if(isSetter(method)) System.out.println("setter: " + method);

//         Field[] innerFields = {};
//         if (!method.getType().getName().contains("java.lang")) {
////            Method meth = objClass.getMethod(, null);
//            innerFields = method.getType().getDeclaredFields();
//         }
////         if(field.getName()){
////
////         }
//
//         for (Field innerField: innerFields) {
//            if (!innerField.getName().contains("java.lang")) {
//               Object subObj = method.getType();
//
//               innerField.setAccessible(true);
//               System.out.println("");
//
//               System.out.println("Sub Field: " + innerField.getName());
//
////               System.out.println( "Sub Field value: " + innerField.get(new Bar()));
//            }
//
//         }
      }
   }

   private static HashMap<String, Object> getMemberFields(Object obj) throws IllegalAccessException,
      NoSuchFieldException
   {
      HashMap<String, Object> fieldValues = new HashMap<String, Object>();
      Class<?> objClass = obj.getClass();

      Field[] fields = objClass.getDeclaredFields();
      for (Field field : fields)
      {
         field.setAccessible(true);
         fieldValues.put(field.getName(), field.get(obj));
         if (!field.getType().isPrimitive() && !field.getType().getName().contains("java.lang"))
         {
            getMemberFields(field.get(obj));
         }
      }
      return fieldValues;
   }

   public static boolean isGetter(Method method){
      if(!method.getName().startsWith("get"))      return false;
      if(method.getParameterTypes().length != 0)   return false;
      if(void.class.equals(method.getReturnType())) return false;
      return true;
   }

   public static boolean isSetter(Method method){
      if(!method.getName().startsWith("set")) return false;
      if(method.getParameterTypes().length != 1) return false;
      return true;
   }
}
