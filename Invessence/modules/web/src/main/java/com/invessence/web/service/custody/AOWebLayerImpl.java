package com.invessence.web.service.custody;

import java.util.*;

import com.invessence.custody.dao.*;
import com.invessence.custody.data.AORequest;
import com.invessence.custody.uob.dao.*;
import com.invessence.service.bean.ServiceRequest;
import com.invessence.ws.bean.*;
import com.invessence.ws.provider.td.bean.*;
import com.invessence.ws.provider.td.dao.TDDaoLayer;
import com.invessence.ws.service.ServiceLayer;
import com.invessence.ws.util.*;
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


   @Override
   public WSCallResult processAORequest(ServiceRequest serviceRequest, Long acctNum, Integer eventNum)throws Exception
   {
      logger.info("AOWebLayerImpl.processAORequest");
      logger.info("serviceRequest = [" + serviceRequest + "], acctNum = [" + acctNum + "], eventNum = [" + eventNum + "]");

      WSCallResult wsCallResult=null;
      List<AORequest> aoRequests= custodyDaoLayer.getAORequests(acctNum, eventNum);

      if(aoRequests.size()>0){
         uobDao.fetch(acctNum);
      }

//      wsCallResult=processITextRequest(dcRequests);
//      if(wsCallResult.getWSCallStatus().getErrorCode()==0){
//         wsCallResult = serviceLayer.processDCRequest(serviceRequest,(List<AORequest>)wsCallResult.getGenericObject());//processDCRequest(serviceRequest,(List<DCRequest>)wsCallResult.getGenericObject());
//      }
      return wsCallResult;
   }

}
