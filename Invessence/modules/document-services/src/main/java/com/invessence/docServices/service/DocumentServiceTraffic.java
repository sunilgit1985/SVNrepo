package com.invessence.docServices.service;

import java.util.List;

import com.invessence.custody.data.AORequest;
import com.invessence.custody.uob.data.CustodyFileRequest;
import com.invessence.service.bean.*;

/**
 * Created by abhangp on 3/11/2016.
 */
public interface DocumentServiceTraffic
{
   public WSCallResult createDoc(ServiceRequest serviceRequest, Object object, List<AORequest> aoRequests, List<CustodyFileRequest> updFileLst, StringBuilder requestIds);
   public WSCallResult sendDoc(ServiceRequest serviceRequest, Object object);
}
