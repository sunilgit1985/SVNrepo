package com.invessence.web.service.custody;

import com.invessence.service.bean.*;

/**
 * Created by abhangp on 3/22/2016.
 */
public interface AOWebLayer
{
   public WSCallResult processAORequest(ServiceRequest serviceRequest, Long acctNum, Integer eventNum);
//   public WSCallResult processAORequest(ServiceRequest serviceRequest, List<AORequest> aoRequests, Object dataObject)throws Exception;
}
