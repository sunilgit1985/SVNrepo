package com.invessence.web.service.custody;

import java.util.*;

import com.invessence.custody.dao.*;
import com.invessence.custody.data.*;
import com.invessence.custody.uob.UOBDataMaster;
import com.invessence.custody.uob.dao.*;
import com.invessence.custody.uob.data.CustodyFileRequest;
import com.invessence.docServices.service.*;
import com.invessence.service.bean.*;;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by abhangp on 3/11/2016.
 */

@Service("aoWebLayer")
public class AOWebLayerImpl implements AOWebLayer
{
   private static final Logger logger = Logger.getLogger(AOWebLayerImpl.class);

   @Autowired
   CustodyDaoLayer custodyDaoLayer;

   @Autowired
   UOBDao uobDao;

   @Autowired
   DocumentServiceTraffic documentServiceTraffic;


   @Override
   public WSCallResult processAORequest(ServiceRequest serviceRequest, Long acctNum, Integer eventNum,List<CustodyFileRequest> updFileLst)
   {
      WSCallResult wsCallResult = null;
      StringBuilder requestIds= new StringBuilder();
      Date reqTime = new Date();

      try
      {
         logger.info("AOWebLayerImpl.processAORequest");
         logger.info("serviceRequest = [" + serviceRequest + "], acctNum = [" + acctNum + "], eventNum = [" + eventNum + "]");

         List<AORequest> aoRequests = custodyDaoLayer.getAORequests(acctNum, eventNum);

         if (aoRequests.size() > 0)
         {
            UOBDataMaster uobDataMaster = (UOBDataMaster) uobDao.fetch(acctNum);
         }else{
            System.out.println("Account Opening requests for acctnum :"+acctNum+" are not available for processing!!");
         }

         UOBDataMaster uobDataMaster = (UOBDataMaster) uobDao.fetch(acctNum);
         wsCallResult = documentServiceTraffic.createDoc(serviceRequest, uobDataMaster, aoRequests, updFileLst, requestIds);
         AORequestAudit aoRequestAudit = new AORequestAudit(serviceRequest.getProduct(), serviceRequest.getMode(), requestIds.toString(), acctNum, eventNum, "", "", "S", reqTime, "" );
         custodyDaoLayer.callDCAuditSP(aoRequestAudit);

//      wsCallResult=processITextRequest(dcRequests);
//      if(wsCallResult.getWSCallStatus().getErrorCode()==0){
//         wsCallResult = serviceLayer.processDCRequest(serviceRequest,(List<AORequest>)wsCallResult.getGenericObject());//processDCRequest(serviceRequest,(List<DCRequest>)wsCallResult.getGenericObject());
//      }
      }catch(Exception ex){
         wsCallResult = new WSCallResult(new WSCallStatus(0, "Failure"), ex.getMessage());
         AORequestAudit dcRequestAudit = new AORequestAudit(serviceRequest.getProduct(), serviceRequest.getMode(),requestIds.toString(), acctNum, eventNum,"", ex.toString(), "E", reqTime, "");
         custodyDaoLayer.callDCAuditSP(dcRequestAudit);
      }
      return wsCallResult;
   }

}
