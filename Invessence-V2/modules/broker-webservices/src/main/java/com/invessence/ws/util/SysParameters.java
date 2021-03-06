package com.invessence.ws.util;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;

/**
 * Created by abhangp on 4/4/2016.
 */
@Configuration
//@PropertySource("classpath:systemParameters.properties")
public class SysParameters
{

   private static final Logger logger = Logger.getLogger(SysParameters.class);
//   @Bean
//   public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
//      return new PropertySourcesPlaceholderConfigurer();
//   }

  // public static String BROKER_WEBSERVICE_API;
//   public static String BROKER_WEBSERVICES_GEMINI_WS_END_POINT_URL;
//   public static String tdEndPointUrl;


   //public static final String BROKER_SERVICES_GEMINI_ENCRY_DECRY_KEY="aRXDugfr4WQpVrxu";
   //String BROKER_SERVICES_GEMINI_ENCRY_DECRY_KEY="GEMINI-KEY";
//   public static String BROKER_WEBSERVICES_GEMINI_FUND_GROUP_NAME;

   public static int wsResIssueCode;
   public static String wsResIssueMsg;

   public static int wsOperationNACode;
   public static String wsOperationNAMsg;

   public static int wsIGenErrCode;
   public static String wsIGenErrMsg;

   public static int wsEGenErrCode;
   public static String wsEGenErrMsg;

   public static int wsUserRegIssueCode;
   public static String wsUserRegIssueMsg;

   public static int wsDBErrCode;
   public static String wsDBErrMsg;

   @Autowired
   public void setWsOperationNAMsgCode(@Value("${wsOperationNACode}")int wsOperationNACode)
   {
      SysParameters.wsOperationNACode = wsOperationNACode;
   }
   @Autowired
   public void setWsOperationNAMsg(@Value("${wsOperationNAMsg}")String wsOperationNAMsg)
   {
      SysParameters.wsOperationNAMsg = wsOperationNAMsg;
   }
   @Autowired
   public void setWsUserRegIssueCode(@Value("${wsUserRegIssueCode}")int wsUserRegIssueCode)
   {
      SysParameters.wsUserRegIssueCode = wsUserRegIssueCode;
   }
   @Autowired
   public void setWsUserRegIssueMsg(@Value("${wsUserRegIssueMsg}") String wsUserRegIssueMsg)
   {
      SysParameters.wsUserRegIssueMsg = wsUserRegIssueMsg;
   }
   @Autowired
   public void setWsDBErrCode(@Value("${wsDBErrCode}")int wsDBErrCode)
   {
      SysParameters.wsDBErrCode = wsDBErrCode;
   }
   @Autowired
   public void setWsDBErrMsg(@Value("${wsDBErrMsg}")String wsDBErrMsg)
   {
      SysParameters.wsDBErrMsg = wsDBErrMsg;
   }
   @Autowired
   public void setWsResIssueCode(@Value("${wsResIssueCode}") int wsResIssueCode)
   {
      SysParameters.wsResIssueCode = wsResIssueCode;
   }
   @Autowired
   public void setWsResIssueMsg(@Value("${wsResIssueMsg}") String wsResIssueMsg)
   {
      SysParameters.wsResIssueMsg = wsResIssueMsg;
   }
   @Autowired
   public void setWsIGenErrCode(@Value("${wsIGenErrCode}")int wsIGenErrCode)
   {
      SysParameters.wsIGenErrCode = wsIGenErrCode;
   }
   @Autowired
   public void setWsIGenErrMsg(@Value("${wsIGenErrMsg}")String wsIGenErrMsg)
   {
      SysParameters.wsIGenErrMsg = wsIGenErrMsg;
   }
   @Autowired
   public void setWsEGenErrCode(@Value("${wsEGenErrCode}")int wsEGenErrCode)
   {
      SysParameters.wsEGenErrCode = wsEGenErrCode;
   }
   @Autowired
   public void setWsEGenErrMsg(@Value("${wsEGenErrMsg}")String wsEGenErrMsg)
   {
      SysParameters.wsEGenErrMsg = wsEGenErrMsg;
   }

   public static String dcSuccessMsg;
   public static int dcSuccessCode;
   public static String dcReqDataIssueMsg;
   public static int dcReqDataIssueCode;
   public static String dcEGenErrMsg;
   public static int dcEGenErrCode;
   public static String dcIGenErrMsg;
   public static int dcIGenErrCode;
   public static String dcTechIssueMsg;
   public static int dcTechIssueCode;
   @Autowired
   public void setDcSuccessMsg(@Value("${dcSuccessMsg}")String dcSuccessMsg)
   {
      SysParameters.dcSuccessMsg = dcSuccessMsg;
   }
   @Autowired
   public void setDcSuccessCode(@Value("${dcSuccessCode}")int dcSuccessCode)
   {
      SysParameters.dcSuccessCode = dcSuccessCode;
   }

   @Autowired
   public void setDcReqDataIssueMsg(@Value("${dcReqDataIssueMsg}")String dcReqDataIssueMsg)
   {
      SysParameters.dcReqDataIssueMsg = dcReqDataIssueMsg;
   }
   @Autowired
   public void setDcReqDataIssueCode(@Value("${dcReqDataIssueCode}")int dcReqDataIssueCode)
   {
      SysParameters.dcReqDataIssueCode = dcReqDataIssueCode;
   }
   @Autowired
   public void setDcEGenErrMsg(@Value("${dcEGenErrMsg}")String dcEGenErrMsg)
   {
      SysParameters.dcEGenErrMsg = dcEGenErrMsg;
   }
   @Autowired
   public void setDcEGenErrCode(@Value("${dcEGenErrCode}")int dcEGenErrCode)
   {
      SysParameters.dcEGenErrCode = dcEGenErrCode;
   }
   @Autowired
   public void setDcIGenErrMsg(@Value("${dcIGenErrMsg}")String dcIGenErrMsg)
   {
      SysParameters.dcIGenErrMsg = dcIGenErrMsg;
   }
   @Autowired
   public void setDcIGenErrCode(@Value("${dcIGenErrCode}")int dcIGenErrCode)
   {
      SysParameters.dcIGenErrCode = dcIGenErrCode;
   }
   @Autowired
   public void setDcTechIssueMsg(@Value("${dcTechIssueMsg}")String dcTechIssueMsg)
   {
      SysParameters.dcTechIssueMsg = dcTechIssueMsg;
   }
   @Autowired
   public void setDcTechIssueCode(@Value("${dcTechIssueCode}")int dcTechIssueCode)
   {
      SysParameters.dcTechIssueCode = dcTechIssueCode;
   }

   //   public static String getUserAccDetailsByAccNumber;
//   public static String getPendingUserAccDetails;
//   public static String updatePendingUserAccDetailsOnSuccess;
//   public static String updatePendingUserAccDetailsOnFailure;
//   public static String updateUserEmail;
//   public static String getAccountExtInfo;

//   @Autowired
//   private WSCommonDao wsCommonDao;

//   public static Map<String, Map<String, List<ServiceDetails>>> serviceDetailsMap;
//   public void saveWSRequest(String apiServiceStatus, String clientAccountID, String tempOperation, String remarks, Date reqTime, String reqXml, Date resTime, String resXml, String requestType){
//      try{
//         wsCommonDao.insertWSRequest(new WSRequest(apiServiceStatus, clientAccountID, tempOperation, remarks, reqTime, reqXml, resTime, resXml, requestType));}
//      catch(Exception e){
//         e.printStackTrace();
//         logger.error(e.getMessage());
//      }
//   }
//   @Autowired
//   public void setServiceOperationDetails() {
//      try{
//         List<ServiceDetails> serviceDetailsList=wsCommonDao.getServiceOperationDetails(Const.COMPANY_NAME);
//         Iterator<ServiceDetails>itr=serviceDetailsList.iterator();
//         Map<String, Map<String, List<ServiceDetails>>> serviceDetails=new LinkedHashMap<String, Map<String, List<ServiceDetails>>>();
//         Map<String, List<ServiceDetails>> apiDetails=null;
//         List<ServiceDetails> listOfOperation=null;
//         String serviceKey=null, apiKey=null;
//         ServiceDetails servDetails=null;
//         while (itr.hasNext()) {
//             servDetails = (ServiceDetails) itr.next();
//
//            if(serviceKey==null){
//               serviceKey=servDetails.getService();
//               apiKey=servDetails.getVendor();
//               apiDetails=new LinkedHashMap<>();
//
//               listOfOperation=new ArrayList<>();
//               listOfOperation.add(servDetails);
//
//            }else if(servDetails.getService().equalsIgnoreCase(serviceKey)){
//               if(servDetails.getVendor().equalsIgnoreCase(apiKey)){
//                  listOfOperation.add(servDetails);
//               }else if(!servDetails.getVendor().equalsIgnoreCase(apiKey)){
//                  apiDetails.put(apiKey,listOfOperation);
//
//                  apiKey=servDetails.getVendor();
//                  listOfOperation=new ArrayList<>();
//                  listOfOperation.add(servDetails);
//               }
//
//            }else if(! servDetails.getService().equalsIgnoreCase(serviceKey)){
////               apiDetails=new LinkedHashMap<>();
//               apiDetails.put(apiKey,listOfOperation);
//               serviceDetails.put(serviceKey, apiDetails);
//
//               serviceKey=servDetails.getService();
////               apiDetails=new HashMap<>();
////               apiDetails.put(apiKey,listOfOperation);
//
//               apiKey=servDetails.getVendor();
//               apiDetails=new LinkedHashMap<>();
//               listOfOperation=new ArrayList<>();
//               listOfOperation.add(servDetails);
//
//            }
//            //System.out.println("servDetails = " + servDetails);
//
//         }
//         apiDetails.put(apiKey,listOfOperation);
//         serviceDetails.put(serviceKey, apiDetails);
//
//         System.out.println("*****************************");
//         System.out.println("Size of ServiceDetails Map = "+serviceDetails.size());
//
//         Iterator<Map.Entry<String, Map<String, List<ServiceDetails>>>> entries = serviceDetails.entrySet().iterator();
//         while (entries.hasNext()) {
//            Map.Entry<String, Map<String, List<ServiceDetails>>> entry = entries.next();
//            System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
//         }
//
//         System.out.println("*****************************");
//         SysParameters.serviceDetailsMap =serviceDetails;
//
//         setWebServiceAPI(); // setting  broker-webservice vendor
//      }catch(Exception e){
//         logger.error("Exception while loading service details");
//         logger.error(e.getMessage());
//      }
//
//   }
//
//   public void setWebServiceAPI()
//   {
//      System.out.println("SysParameters.setWebServiceAPI");
//      if(SysParameters.serviceDetailsMap.containsKey(Const.SERVICES.BROKER_WEBSERVICES.toString())){
//         Map<String, List<ServiceDetails>>sd= SysParameters.serviceDetailsMap.get(Const.SERVICES.BROKER_WEBSERVICES.toString());
//         if(sd==null || sd.size()==0){
//            System.out.println("Expecting single API vendor for "+Const.SERVICES.BROKER_WEBSERVICES.toString()+" service but it gets none");
//         }else if(sd.size()>1){
//            System.out.println("Expecting single API vendor for "+Const.SERVICES.BROKER_WEBSERVICES.toString()+" service but it gets more the one");
//            SysParameters.BROKER_WEBSERVICE_API =sd.keySet().toArray()[0].toString();
//         }else if(sd.size()==1){
//            SysParameters.BROKER_WEBSERVICE_API =sd.keySet().toArray()[0].toString();
//         }
//      }
//      //SysParameters.BROKER_WEBSERVICE_API = BROKER_WEBSERVICE_API;
//      System.out.println("BROKER_WEBSERVICE_API = " + BROKER_WEBSERVICE_API);
//   }

//   @Autowired
//   public void setFundGroupName(@Value("${BROKER_WEBSERVICES_GEMINI_FUND_GROUP_NAME}")String BROKER_WEBSERVICES_GEMINI_FUND_GROUP_NAME)
//   {
//      SysParameters.BROKER_WEBSERVICES_GEMINI_FUND_GROUP_NAME = BROKER_WEBSERVICES_GEMINI_FUND_GROUP_NAME;
//   }
//   @Autowired
//   public void setGetAccountExtInfo(@Value("${getAccountExtInfo}")String getAccountExtInfo)
//   {
//      SysParameters.getAccountExtInfo = getAccountExtInfo;
//   }
//   @Autowired
//   public void setGetPendingUserAccDetails(@Value("${getPendingUserAccDetails}")String getPendingUserAccDetails)
//   {
//      SysParameters.getPendingUserAccDetails = getPendingUserAccDetails;
//   }
//   @Autowired
//   public void setGetUserAccDetailsByAccNumber(@Value("${getUserAccDetailsByAccNumber}")String getUserAccDetailsByAccNumber)
//   {
//      SysParameters.getUserAccDetailsByAccNumber = getUserAccDetailsByAccNumber;
//   }
//   @Autowired
//   public void setUpdatePendingUserAccDetailsOnSuccess(@Value("${updatePendingUserAccDetailsOnSuccess}")String updatePendingUserAccDetailsOnSuccess)
//   {
//      SysParameters.updatePendingUserAccDetailsOnSuccess = updatePendingUserAccDetailsOnSuccess;
//   }


//   @Autowired
//   public void setUpdatePendingUserAccDetailsOnFailure(@Value("${updatePendingUserAccDetailsOnFailure}")String updatePendingUserAccDetailsOnFailure)
//   {
//      SysParameters.updatePendingUserAccDetailsOnFailure = updatePendingUserAccDetailsOnFailure;
//   }



//   @Autowired
//   public void setUpdateUserEmail(@Value("${updateUserEmail}")String updateUserEmail)
//   {
//      SysParameters.updateUserEmail = updateUserEmail;
//   }

//   @Autowired
//   public void setGeminiEndPointUrl(@Value("${BROKER_WEBSERVICES_GEMINI_WS_END_POINT_URL}")String BROKER_WEBSERVICES_GEMINI_WS_END_POINT_URL)
//   {
//      SysParameters.BROKER_WEBSERVICES_GEMINI_WS_END_POINT_URL = BROKER_WEBSERVICES_GEMINI_WS_END_POINT_URL;
//   }
//
//   @Autowired
//   public void setTdEndPointUrl(@Value("${tdEndPointUrl}")String tdEndPointUrl)
//   {
//      SysParameters.tdEndPointUrl = tdEndPointUrl;
//   }
//

}
