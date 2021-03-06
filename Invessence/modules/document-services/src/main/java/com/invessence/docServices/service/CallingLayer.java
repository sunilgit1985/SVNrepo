package com.invessence.docServices.service;

import com.invessence.custody.data.AORequest;
import com.invessence.service.bean.*;

/**
 * Created by abhangp on 3/22/2016.
 */
public interface CallingLayer
{
   public WSCallResult createDoc(ServiceRequest serviceRequest, Object dataObject, AORequest aoRequest) throws Exception;
   public WSCallResult sendDoc(ServiceRequest serviceRequest, Object dataObject);
}
