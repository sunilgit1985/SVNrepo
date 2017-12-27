package com.invessence.web.service.custody;

import java.util.List;

import com.invessence.custody.uob.data.CustodyFileRequest;
import com.invessence.service.bean.*;

/**
 * Created by abhangp on 3/22/2016.
 */
public interface AOWebLayer
{
   public WSCallResult processAORequest(ServiceRequest serviceRequest, Long acctNum, Integer eventNum, List<CustodyFileRequest> updFileLst);
//   public WSCallResult processAORequest(ServiceRequest serviceRequest, List<AORequest> aoRequests, Object dataObject)throws Exception;
}
