package com.invessence.docServices.service;

import com.invessence.custody.data.AORequest;
import com.invessence.service.bean.*;

/**
 * Created by abhangp on 3/11/2016.
 */
public interface DocumentServiceTraffic
{
   public WSCallResult createDoc(ServiceRequest serviceRequest, Object object, AORequest aoRequest);
   public WSCallResult sendDoc(ServiceRequest serviceRequest, Object object);
}
