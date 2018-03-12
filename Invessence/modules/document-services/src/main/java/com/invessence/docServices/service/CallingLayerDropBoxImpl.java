package com.invessence.docServices.service;

import com.invessence.custody.data.AORequest;
import com.invessence.service.bean.*;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

/**
 * Created by abhangp on 3/11/2016.
 */
@Service("dopboxDocService")
public class CallingLayerDropBoxImpl implements CallingLayer
{
   private static final Logger logger = Logger.getLogger(CallingLayerDropBoxImpl.class);
   @Override
   public WSCallResult createDoc(ServiceRequest serviceRequest, Object object, AORequest aoRequest)
   {
      return null;
   }

   @Override
   public WSCallResult sendDoc(ServiceRequest serviceRequest, Object object)
   {
      return null;
   }
}
