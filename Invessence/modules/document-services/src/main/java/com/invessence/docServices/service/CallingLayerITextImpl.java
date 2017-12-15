package com.invessence.docServices.service;

import java.util.*;

import com.invessence.custody.data.AORequest;
import com.invessence.docServices.iText.pdf.*;
import com.invessence.service.bean.*;
import com.invessence.service.bean.documentServices.iText.*;
import com.invessence.service.bean.fileProcessor.FileDetails;
import com.invessence.service.util.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.invessence.custody.uob.*;

/**
 * Created by abhangp on 3/11/2016.
 */
@Service("itextDocService")
public class CallingLayerITextImpl implements CallingLayer
{
   @Autowired
   UOBPDFWriter uobPDFWriter;
   private static final Logger logger = Logger.getLogger(CallingLayerITextImpl.class);
   @Override
   public WSCallResult createDoc(ServiceRequest serviceRequest, Object dataObject, AORequest aoRequest)
   {
      LinkedHashMap<String, LinkedList<PDFFileDetails>> pdfFileDetails = (LinkedHashMap<String, LinkedList<PDFFileDetails>>) ServiceDetails.getAdditionalDetails(serviceRequest.getProduct(), Constant.SERVICES.DOCUMENT_SERVICES.toString(), serviceRequest.getMode(), Constant.ADDITIONAL_DETAILS.PDF_FILE_DETAILS.toString());

      Map<String, ServiceOperationDetails> dcOperationDetails = ServiceDetails.getOperationDetails(serviceRequest.getProduct(),Constant.SERVICES.DOCUMENT_SERVICES.toString());
      Map<String,Map<String, List<PDFFileRules>>> pdfFileRulesDetails=(Map<String,Map<String, List<PDFFileRules>>>) ServiceDetails.getCommonDetails(serviceRequest.getProduct(), Constant.SERVICES.DOCUMENT_SERVICES.toString(), Constant.COMMON_DETAILS.PDF_FILE_RULES.toString());
      String pdfCode=dcOperationDetails.get(aoRequest.getReqType()).getRefValue();
      if(pdfFileRulesDetails.containsKey(pdfCode)&& pdfFileDetails.containsKey(pdfCode)){
         uobPDFWriter.writPDF(pdfFileDetails.get(pdfCode).get(0),pdfFileRulesDetails.get(pdfCode), dataObject);
      }else if(!pdfFileRulesDetails.containsKey(pdfCode)&& pdfFileDetails.containsKey(pdfCode)){
         uobPDFWriter.copyPDF(pdfFileDetails.get(pdfCode).get(0), dataObject);
      }else{
         System.out.println("PDF Rules are not available for  :"+pdfCode);
      }


//      Map<String,Country> countryDetails=(Map<String,Country>) ServiceDetails.genericDetails.get(Constant.GENERIC_DETAILS.COUNTRY.toString());
//      Map<String, Object> data=null;
//      try
//      {
//         data= Reflection.getFieldNamesAndValues(object, false);
//
//      }
//      catch (IllegalAccessException e)
//      {
//         e.printStackTrace();
//      }
      return null;
   }

//   public WSCallResult copyDoc(ServiceRequest serviceRequest, Object dataObject, AORequest aoRequest)
//   {
//      LinkedHashMap<String, LinkedList<PDFFileDetails>> pdfFileDetails = (LinkedHashMap<String, LinkedList<PDFFileDetails>>) ServiceDetails.getAdditionalDetails(serviceRequest.getProduct(), Constant.SERVICES.DOCUMENT_SERVICES.toString(), serviceRequest.getMode(), Constant.ADDITIONAL_DETAILS.PDF_FILE_DETAILS.toString());
//
//      Map<String, ServiceOperationDetails> dcOperationDetails = ServiceDetails.getOperationDetails(serviceRequest.getProduct(),Constant.SERVICES.DOCUMENT_SERVICES.toString());
//      Map<String,Map<String, List<PDFFileRules>>> pdfFileRulesDetails=(Map<String,Map<String, List<PDFFileRules>>>) ServiceDetails.getCommonDetails(serviceRequest.getProduct(), Constant.SERVICES.DOCUMENT_SERVICES.toString(), Constant.COMMON_DETAILS.PDF_FILE_RULES.toString());
//      String pdfCode=dcOperationDetails.get(aoRequest.getReqType()).getRefValue();
//      if(pdfFileRulesDetails.containsKey(pdfCode)&& pdfFileDetails.containsKey(pdfCode)){
//         uobPDFWriter.writPDF(pdfFileRulesDetails.get(pdfCode), dataObject);
//      }else if(!pdfFileRulesDetails.containsKey(pdfCode)&& pdfFileDetails.containsKey(pdfCode)){
////         uobPDFWriter.copyPDF(pdfFileDetails.get(pdfCode), dataObject);
//      }else{
//         System.out.println("PDF Rules are not available for  :"+pdfCode);
//      }
//
//
////      Map<String,Country> countryDetails=(Map<String,Country>) ServiceDetails.genericDetails.get(Constant.GENERIC_DETAILS.COUNTRY.toString());
////      Map<String, Object> data=null;
////      try
////      {
////         data= Reflection.getFieldNamesAndValues(object, false);
////
////      }
////      catch (IllegalAccessException e)
////      {
////         e.printStackTrace();
////      }
//      return null;
//   }

   @Override
   public WSCallResult sendDoc(ServiceRequest serviceRequest, Object object)
   {
      return null;
   }
}
