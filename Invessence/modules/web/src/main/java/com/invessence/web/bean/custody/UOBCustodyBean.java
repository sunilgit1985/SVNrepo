package com.invessence.web.bean.custody;

import java.io.*;
import java.lang.reflect.*;
import java.text.*;
import java.util.*;
import java.util.List;
import java.util.regex.*;
import javax.faces.bean.*;
import javax.faces.context.FacesContext;

import com.invessence.custody.uob.UOBDataMaster;
import com.invessence.custody.uob.data.*;
import com.invessence.service.bean.*;
import com.invessence.service.util.*;
import com.invessence.util.AddressSplitter;
import com.invessence.web.constant.WebConst;
import com.invessence.web.dao.consumer.ConsumerListDataDAO;
import com.invessence.web.data.common.CustomerData;
import com.invessence.web.service.custody.*;
import com.invessence.web.util.*;
import com.invessence.web.util.Impl.PagesImpl;
import com.invessence.service.bean.Generic.Country;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.parser.PdfTextExtractor;
import org.apache.commons.collections.iterators.ObjectArrayIterator;
import org.apache.commons.logging.*;
import org.primefaces.event.*;
import org.primefaces.model.*;

/**
 * Created by sagarp on 11/11/2017.
 */
@ManagedBean(name = "uobCustodyBean")
@SessionScoped
public class UOBCustodyBean implements  Serializable
{
   protected final Log logger = LogFactory.getLog(getClass());
   @ManagedProperty("#{uobCustodyService}")
   private CustodyService custodyService;

   @ManagedProperty("#{webutil}")
   private WebUtil webutil;

   @ManagedProperty("#{consumerListDataDAO}")
   private ConsumerListDataDAO listDAO;

   @ManagedProperty("#{aoWebLayer}")
   private AOWebLayer aoWebLayer;


   @ManagedProperty("#{uiLayout}")
   private UILayout uiLayout;
   public void setUiLayout(UILayout uiLayout)
   {
      this.uiLayout = uiLayout;
   }
   public UILayout getUiLayout()
   {
      return uiLayout;
   }
   private UOBDataMaster uobDataMaster;
   private PagesImpl pagemanager = new PagesImpl(10);
   private long beanAcctNum, beanLogonId;
   private boolean  dsplExtIndAcctInp = false,  dsplExtJntAcctInp = false, dsplAcctTyp = false;
   private boolean dsplExtIndAcctQue=false,dsplExtJntAcctQue=false;
   private boolean dspExtAcctPnl = false, dspNewAcctPnl = false, dspIntroAcctPnl = false, dsblSubmtBtn = true, dspJntTab = false;
   private String extAcctJnt, clientAcctId, slsPrsnNm, selIndAcctTyp, selJntAcctTyp;
   private Integer activeTab = 0;
   private boolean dsplOtrCntry = false, dsplIcNoInp = false, dsplPspNoInp = false, dsplSrcIncOtrs = false;
   private Date dtPriHldrDob;
   private boolean dsplNwPriRelDtl = false, dsplNwPriInfDtl = false, dsplNwPriCtrlDtl = false;
   String introError, taxError;
   private String priHldrEmpAddr;
   private boolean dsplNwPriEmpOtrDtlPnl = false, dsplNwPriEmpMnPnl = false,dsplNwPriUnEmpRsnPnl=false;
   private String priHldrPhyAddr, priHldrMlAddr,priHldrBnkAddr;

   private boolean dsplPriHldrMlPnl = false, dsplSingNricInp = false, dsplNricInp = false;
   private boolean dsplPriHldrObjPnl1 = false, dsplPriHldrObjPnl2 = false, dsplPriHldrObjPnl3 = false, dsplPriHldrObjPnl4 = false;
   private OwnerTaxationDetails owTaxDtls = null;
   private boolean dsplPriHldrTaxTab = false, dsplPriHldrTaxDtl = false, dsplPriHldrTaxRsn = false, dsplPriHldrTaxTin = false, dsplPriHldrTaxRsnPnl = false, disTaxBtn = false, dispTaxAddBtn = false, dispTaxUpdBtn = true;
   ;
   Map<String, Country> countryDetails = (Map<String, Country>) ServiceDetails.genericDetails.get(Constant.GENERIC_DETAILS.COUNTRY.toString());
   private List<String> countries, repList;
   private Map<String, String> repMap = new HashMap<String, String>();
   private boolean dspDocUpdPnl = false;
   private List<CustodyFileDetails> updFileMstrLst = new ArrayList<CustodyFileDetails>();
   private List<CustodyFileDetails> dwnFileMstrLst = new ArrayList<CustodyFileDetails>();
   private List<CustodyFileRequest> updFileLst = new ArrayList<CustodyFileRequest>();
   private String cstdyUpdPath = null;
   private String cstdyDwnPath = null;
   private boolean dsblUpdSubmtBtn = true;
   private boolean dsplDwnlFile=false;
   private String currentAcctHolder = null;
   private String beanAccount=null;
   private String saveandOpenError;
   private String reqType;
   private boolean dsblRepList=false;
   private String hasRepDtlY=null,hasRepDtlN=null;
   private Map<String, String> fileupdSucc = new HashMap<String, String>();
   private boolean consentCallFlag=false,consentMsgFlag=false;
   private boolean dwnlDsclFlag=false,dwnlGudFlag=false,dsblAcptBtn=true,dwnlMstrTrdAggrFlag=false;

   private StreamedContent contentDsclre,contentGuide,contentMstrTrdAggr;

   public void cleanUpAll()
   {
      dsplPriHldrMlPnl = false;
      priHldrPhyAddr = null;
      priHldrMlAddr = null;
      dsplExtIndAcctInp = false;
      dsplExtJntAcctInp = false;
      dsplExtIndAcctQue=false;
      dsplExtJntAcctQue=false;
      dsplAcctTyp = false;
      dspExtAcctPnl = false;
      dspNewAcctPnl = false;
      dspIntroAcctPnl = false;
      dsblSubmtBtn = true;
      dspJntTab = false;
      dsplNricInp = false;
      dsplSingNricInp = false;
      dsplOtrCntry = false;
      dsplIcNoInp = false;
      dsplPspNoInp = false;
      extAcctJnt = null;
      clientAcctId = null;
      slsPrsnNm = null;
      selIndAcctTyp = null;
      selJntAcctTyp = null;
      introError = null;
      setActiveTab(0);
      dtPriHldrDob = new Date();
      dspIntroAcctPnl = true;
      dsblSubmtBtn = true;
      dspJntTab = false;
      dsplSrcIncOtrs = false;
      dsplNwPriRelDtl = false;
      dsplNwPriInfDtl = false;
      dsplNwPriCtrlDtl = false;
      dsplNwPriEmpOtrDtlPnl = false;
      dsplNwPriEmpMnPnl = false;
      priHldrEmpAddr = null;
      dsplPriHldrObjPnl1 = false;
      dsplPriHldrObjPnl2 = false;
      dsplPriHldrObjPnl3 = false;
      dsplPriHldrObjPnl4 = false;
      owTaxDtls = new OwnerTaxationDetails();
      dsplPriHldrTaxTab = false;
      dsplPriHldrTaxDtl = false;
      dsplPriHldrTaxRsn = false;
      dsplPriHldrTaxTin = false;
      dsplPriHldrTaxRsnPnl = false;
      disTaxBtn = false;
      dispTaxAddBtn = false;
      dispTaxUpdBtn = false;
      dspDocUpdPnl = false;
      cstdyUpdPath = null;
      cstdyDwnPath = null;
      fileupdSucc = new HashMap<String, String>();
      dsblUpdSubmtBtn = true;
      currentAcctHolder = null;
      beanAccount=null;
      dsplNwPriUnEmpRsnPnl=false;
      priHldrBnkAddr=null;
      dsblRepList=false;
      hasRepDtlY=null;
      hasRepDtlN=null;
      dsplDwnlFile=false;
      dwnlDsclFlag=false;
      dwnlGudFlag=false;
      dsblAcptBtn=true;
      dwnlMstrTrdAggrFlag=false;
   }

   public void initCustody()
   {
      String msgheader;
      try
      {
         if (!FacesContext.getCurrentInstance().isPostback())
         {
            if (getBeanAccount() == null || getBeanAccount().isEmpty())
            {
               msgheader = "dctd.200";
               getWebutil().redirecttoMessagePage("ERROR", "Access Denied", msgheader);
               return;
            }
            if (getWebutil().getWebprofile() == null)
            {

               getWebutil().accessdenied();
               return;
            }
            setBeanAcctNum(Long.parseLong(getBeanAccount()));

               String valOutput = isValidAcctNum();

               // If account is managed
               if (valOutput.equalsIgnoreCase("ACCOUNTMANAGED"))
               {
                  msgheader = "dctd.103";
                  getWebutil().redirecttoMessagePage("ERROR", "Access Denied", msgheader);
                  return;
               }

               if (!valOutput.equalsIgnoreCase("success"))
               {
                  // msgheader = "dctd.102";
                  // webutil.redirecttoMessagePage("ERROR", "Access Denied", msgheader);
                  getWebutil().accessdenied();
                  return;
               }

            cleanUpAll();
            uobDataMaster = custodyService.fetch(getBeanAcctNum(), false);
            uobDataMaster.getAccountDetails().setAcctnum(getBeanAcctNum());
            repMap = custodyService.fetchSalesRepList(getWebutil().getWebprofile().getWebInfo().get("DEFAULT.ADVISOR").toString());
            cstdyUpdPath = getWebutil().getWebprofile().getWebInfo().get("CUSTODY.UPLOAD.PATH").toString();
            cstdyDwnPath = getWebutil().getWebprofile().getWebInfo().get("CUSTODY.DOWNLOAD.PATH").toString();
            if (repMap != null && repMap.size() > 0)
            {
               repList = new ArrayList<String>(repMap.keySet());
            }
            onChngNation(false);
            onChngOtrCntry();
            loadIntroPage();
            onChngRelDtls();
            onChngEmplt();
            onChngAddr();
            onChngObj();
            onChngSrcOfInc();
            loadPrsnlPage();
            if(getReqType()!=null)
            {
               updFileMstrLst = custodyService.fetchFileMasterList(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(), beanAcctNum, getReqType(), "Upload");
               updFileLst = custodyService.fetchUploadedFiles(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(), beanAcctNum, getReqType());
               dwnFileMstrLst = custodyService.fetchFileMasterList(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(), beanAcctNum, getReqType(), "Download");
            }

            if(updFileLst!=null && updFileMstrLst!=null && updFileMstrLst.size()==updFileLst.size()){
               dsblUpdSubmtBtn=false;
            }else{
               dsblUpdSubmtBtn=true;
            }

            if(dwnFileMstrLst!=null && dwnFileMstrLst.size()>0){
               dsplDwnlFile = true;
               getFileData();
            }
            owTaxDtls = new OwnerTaxationDetails();
            countries = new ArrayList<String>();
            countries = new ArrayList<String>(countryDetails.keySet());
            setCurrentAcctHolder("Individual");

            if (uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails() != null &&
               uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails().size() > 0)
            {
               dsplPriHldrTaxTab = true;
               disTaxBtn = false;
            }
            else if (uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails() == null ||
               uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails().size() == 0)
            {
               dsplPriHldrTaxDtl = true;
               dispTaxAddBtn = true;
            }

            priHldrEmpAddr = getCstmaddrEmp(uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails());
            priHldrPhyAddr = getCstmaPhyAddr(uobDataMaster.getIndividualOwnersDetails());
            priHldrMlAddr = getCstmaMalAddr(uobDataMaster.getIndividualOwnersDetails());
            priHldrBnkAddr=getCstmaBnkAddr(uobDataMaster.getIndividualOwnersDetails().getOwnerBankDetails());

            if (uobDataMaster.getIndividualOwnersDetails().getDob() == null ||
               uobDataMaster.getIndividualOwnersDetails().getDob().equalsIgnoreCase(""))
            {
               dtPriHldrDob = null;
            }
            else
            {
               DateFormat df = new SimpleDateFormat("MM-dd-yyyy");
               dtPriHldrDob = df.parse(uobDataMaster.getIndividualOwnersDetails().getDob());
            }

            saveandOpenError = null;
         }
      }
      catch (Exception ex)
      {
         logger.info("Exception: raised during Starting TD CTO process.");
      }
   }

   public Boolean validateAllPage()
   {
      Integer currentPage = getPagemanager().getPage();
      Boolean status;
      saveandOpenError = null;

      getPagemanager().setPage(0);
      status = true;
      while (getPagemanager().getPage() <= getPagemanager().getMaxNoofPages())
      {
         if (validate(getPagemanager().getPage(), uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct(), false))
         {
            if (getPagemanager().isLastPage())
            {
               break;
            }
            getPagemanager().nextPage();
            pageControl(getPagemanager().getPage());
         }
         else
         {
            currentPage = getPagemanager().getPage();
            status = false;
            break;
         }
      }

      getPagemanager().setPage(currentPage);
      resetActiveTab(getPagemanager().getPage());
      if (!status)
      {
         saveandOpenError = "Please fill appropriate forms above.";
      }

      return status;
   }

   private String isValidAcctNum()
   {
      String retValue = "";
      ArrayList<CustomerData> selAccountList = null;
      if (getWebutil().getUserInfoData() == null)
      {
         selAccountList = listDAO.getClientProfileList(getBeanLogonId(), getBeanAcctNum(), null, webutil.getWebprofile().getDefaultAdvisor(), webutil.getWebprofile().getDefaultRep());
      }
      else
      {
         beanLogonId = getWebutil().getUserInfoData().getLogonID();
         selAccountList = listDAO.getClientProfileList(getBeanLogonId(), getBeanAcctNum(), null, webutil.getUserInfoData().getAdvisor(), webutil.getUserInfoData().getRep());
      }
      if (selAccountList == null || selAccountList.size() == 0)
      {

         retValue = "NOACCOUNTMAP";
         return retValue;
      }
      if (selAccountList != null
         && selAccountList.get(0).getUnopened())
      {
         retValue = "success";
         return retValue;
      }
      else
      {
         retValue = "ACCOUNTMANAGED";
         return retValue;
      }
   }

   public String getCstmaddrEmp(OwnerEmploymentDetails ownerEmploymentDetails)
   {
      StringBuilder sb = new StringBuilder();
      if (ownerEmploymentDetails.getEmployerStreetAddress1() != null)
      {
         sb.append(ownerEmploymentDetails.getEmployerStreetAddress1() + "");
      }
      if (ownerEmploymentDetails.getEmployerStreetAddress2() != null)
      {
         sb.append(ownerEmploymentDetails.getEmployerStreetAddress2() + "");
      }
      if (ownerEmploymentDetails.getEmployerStreetAddress3() != null)
      {
         sb.append(ownerEmploymentDetails.getEmployerStreetAddress3() + "");
      }
      if (sb.length() > 0)
      {
         return sb.toString();
      }
      return null;
   }

   public String getCstmaPhyAddr(OwnerDetails ownerDetails)
   {
      StringBuilder sb = new StringBuilder();
      if (ownerDetails.getPhysicalAddressStreet1() != null)
      {
         sb.append(ownerDetails.getPhysicalAddressStreet1() + "");
      }
      if (ownerDetails.getPhysicalAddressStreet2() != null)
      {
         sb.append(ownerDetails.getPhysicalAddressStreet2() + "");
      }
      if (ownerDetails.getPhysicalAddressStreet3() != null)
      {
         sb.append(ownerDetails.getPhysicalAddressStreet3() + "");
      }
      if (sb.length() > 0)
      {
         return sb.toString();
      }
      return null;
   }

   public String getCstmaMalAddr(OwnerDetails ownerDetails)
   {
      StringBuilder sb = new StringBuilder();
      if (ownerDetails.getMailingAddressStreet1() != null)
      {
         sb.append(ownerDetails.getMailingAddressStreet1() + "");
      }
      if (ownerDetails.getMailingAddressStreet2() != null)
      {
         sb.append(ownerDetails.getMailingAddressStreet2() + "");
      }
      if (ownerDetails.getMailingAddressStreet3() != null)
      {
         sb.append(ownerDetails.getMailingAddressStreet3() + "");
      }
      if (sb.length() > 0)
      {
         return sb.toString();
      }
      return null;
   }

   public String getCstmaBnkAddr(OwnerBankDetails ownerBankDetails)
   {
      StringBuilder sb = new StringBuilder();
      if (ownerBankDetails.getBankAddressStreet1() != null)
      {
         sb.append(ownerBankDetails.getBankAddressStreet1() + "");
      }
      if (ownerBankDetails.getBankAddressStreet2() != null)
      {
         sb.append(ownerBankDetails.getBankAddressStreet2() + "");
      }
      if (ownerBankDetails.getBankAddressStreet3() != null)
      {
         sb.append(ownerBankDetails.getBankAddressStreet3() + "");
      }
      if (sb.length() > 0)
      {
         return sb.toString();
      }
      return null;
   }
public void onChngRpDtls(String flag){
      if(flag.equalsIgnoreCase("Yes") ){
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setHavingRepDtls("Yes");
         hasRepDtlN=null;
         hasRepDtlY="Yes";
         dsblRepList=false;
      }else  if(flag.equalsIgnoreCase("No")){
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setHavingRepDtls("No");
         dsblRepList=true;
         hasRepDtlN="No";
         hasRepDtlY=null;
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setSalesPersonName(null);
      }else{
         dsblRepList=true;
         hasRepDtlN=null;
         hasRepDtlY=null;
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setSalesPersonName(null);
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setHavingRepDtls(null);
      }
}
   public void onChangeValue()
   {
      try
      {
         if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct() != null)
         {
            if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("yes"))
            {
               if (uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACINDIV"))
               {
                  dsplExtIndAcctQue = true;
                  dsplExtIndAcctInp = true;
                  dsplExtJntAcctQue = false;
                  dsplExtJntAcctInp = false;
               }
               else if (uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACJOINT"))
               {
                  dsplExtIndAcctQue = false;
                  dsplExtIndAcctInp = false;
                  dsplExtJntAcctQue = true;
                  dsplExtJntAcctInp = true;
               }
            }
            else if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("No"))
            {
               if (uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACINDIV"))
               {
                  dsplExtIndAcctQue = true;
                  dsplExtIndAcctInp = false;
                  dsplExtJntAcctQue = false;
                  dsplExtJntAcctInp = false;
               }
               else if (uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACJOINT"))
               {
                  dsplExtIndAcctQue = false;
                  dsplExtIndAcctInp = false;
                  dsplExtJntAcctQue = true;
                  dsplExtJntAcctInp = false;
               }
            }
         }
         else
         {
//            dsplExtIndAcctCat = false;
            dsplExtIndAcctInp = false;
//            dsplExtJntAcctCat = false;
            dsplExtJntAcctInp = false;
         }
      }
      catch (Exception e)
      {
         System.out.println("Error " + e);
         e.printStackTrace();
      }
   }

   public void onChangeValue0()
   {
      try
      {
         if(uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct()!=null)
         {
            if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("yes"))
            {
               if (uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACINDIV"))
               {
//                  dsplExtIndAcctCat = true;
//                  dsplExtJntAcctCat = false;
                  dsplExtIndAcctInp=true;
                  dsplExtJntAcctInp=false;
               }
               if (uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACJOINT"))
               {
//                  dsplExtIndAcctCat = false;
//                  dsplExtJntAcctCat = true;
                  dsplExtIndAcctInp=false;
                  dsplExtJntAcctInp=true;
               }
               setReqType("ACCT_OPEN_EXISTING_USER");
            }
            else if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("no"))
            {
//               dsplExtIndAcctCat = false;
//               dsplExtJntAcctCat = false;
               dsplExtIndAcctInp=false;
               dsplExtJntAcctInp=false;
               setReqType("ACCT_OPEN_NEW_USER");
            }
         }else{
//            dsplExtIndAcctCat = false;
//            dsplExtJntAcctCat = false;
            dsplExtIndAcctInp=false;
            dsplExtJntAcctInp=false;
            setReqType(null);
         }
//         uobDataMaster.getAccountDetails().getAccountMiscDetails().setIsExistingIndividualAcct(null);
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setSalesPersonName(null);
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setExistingTradeAcctNumber(null);
//         dsplExtIndAcctInp = false;
//         dsplExtJntAcctInp = false;
      }
      catch (Exception e)
      {
         System.out.println("Error " + e);
         e.printStackTrace();
      }
   }

   public void loadIntroPage()
   {
      if (uobDataMaster.getAccountDetails().getAcctTypeId() != null && uobDataMaster.getAccountDetails().getAcctTypeId() != "")
      {
         if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getExistingTradeAcctNumber() == null ||
            uobDataMaster.getAccountDetails().getAccountMiscDetails().getExistingTradeAcctNumber() == "")
         {
            setReqType("ACCT_OPEN_NEW_USER");
            uobDataMaster.getAccountDetails().getAccountMiscDetails().setIsExistingIndividualAcct("No");
         }
         else
         {
            setReqType("ACCT_OPEN_EXISTING_USER");
            uobDataMaster.getAccountDetails().getAccountMiscDetails().setIsExistingIndividualAcct("Yes");

         }
         setSelIndAcctTyp("Individual");
         onChangeValue();
         if(uobDataMaster.getAccountDetails().getAccountMiscDetails().getHavingRepDtls() != null)
         {
            onChngRpDtls(uobDataMaster.getAccountDetails().getAccountMiscDetails().getHavingRepDtls());
         }else{
            onChngRpDtls("");
         }
      }else
      {
         onChngRpDtls("");
      }
   }
   public void getFileData()
   {
      try
      {
         for(int j = 0; j < dwnFileMstrLst.size(); j++)
         {
            PdfReader reader;
            reader = new PdfReader(cstdyDwnPath+dwnFileMstrLst.get(j).getFileName());
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            int n = reader.getNumberOfPages();
            Document document = new Document();
            PdfCopy copy = new PdfCopy(document, out);
            document.open();
            for (int i = 0; i < n; )
            {
               copy.addPage(copy.getImportedPage(reader, ++i));
            }
            document.close();
            if(dwnFileMstrLst.get(j).getReqType().equalsIgnoreCase("ACCT_DSCL"))            {
               contentDsclre = new DefaultStreamedContent(new ByteArrayInputStream(out.toByteArray()), "application/pdf");
            }else if(dwnFileMstrLst.get(j).getReqType().equalsIgnoreCase("ACCT_GUD")){
               contentGuide = new DefaultStreamedContent(new ByteArrayInputStream(out.toByteArray()), "application/pdf");
            }else if(dwnFileMstrLst.get(j).getReqType().equalsIgnoreCase("ACCT_MSTR_AGGR")){
               contentMstrTrdAggr= new DefaultStreamedContent(new ByteArrayInputStream(out.toByteArray()), "application/pdf");
            }
         }
      }
      catch (Exception e)
      {
         System.out.println("getFileData Error " + e);
         e.printStackTrace();

      }
   }


   public StreamedContent getContentDsclre()
   {
      return contentDsclre;
   }

   public void setContentDsclre(StreamedContent contentDsclre)
   {
      this.contentDsclre = contentDsclre;
   }

   public StreamedContent getContentGuide()
   {
      return contentGuide;
   }

   public void setContentGuide(StreamedContent contentGuide)
   {
      this.contentGuide = contentGuide;
   }

   public void onSelAcctTypAsInd(String strAcctType)
   {
      if(strAcctType.equalsIgnoreCase("ACINDIV"))
      {
         setSelIndAcctTyp("Individual");
         setSelJntAcctTyp(null);
         dsplExtIndAcctQue=true;
         dsplExtJntAcctQue=false;
         uobDataMaster.getAccountDetails().setAcctTypeId("ACINDIV");
         uobDataMaster.getIndividualOwnersDetails().setOwnership("Individual");
         uobDataMaster.getJointOwnersDetails().setOwnership(null);
      }else if(strAcctType.equalsIgnoreCase("ACJOINT")){
         setSelIndAcctTyp(null);
         setSelJntAcctTyp("Joint");
         dsplExtIndAcctQue=false;
         dsplExtJntAcctQue=true;
         uobDataMaster.getAccountDetails().setAcctTypeId("ACJOINT");
         uobDataMaster.getIndividualOwnersDetails().setOwnership("Individual");
         uobDataMaster.getJointOwnersDetails().setOwnership("Joint");
      }
      uobDataMaster.getAccountDetails().getAccountMiscDetails().setIsExistingIndividualAcct(null);
      onChangeValue0();
//      System.out.println("selIndAcctTyp " + selIndAcctTyp);
//      System.out.println("selJntAcctTyp " + selJntAcctTyp);
   }

   public void onChngObj()
   {
      try
      {
//         if (!hasRequiredData(uobDataMaster.getIndividualOwnersDetails().getOwnersFinancialDetails().getPreviousInvestingExperience(), "No"))
//         {
//            dsplPriHldrObjPnl1 = false;
//         }
//         else
//         {
//            dsplPriHldrObjPnl1 = true;
//         }
//         dsplPriHldrObjPnl2 = false;
//         if (hasRequiredData(uobDataMaster.getIndividualOwnersDetails().getOwnersFinancialDetails().getInvestmentObjectives()))
//         {
//            if (uobDataMaster.getIndividualOwnersDetails().getOwnersFinancialDetails().getInvestmentObjectives().equalsIgnoreCase("Others"))
//            {
//               dsplPriHldrObjPnl2 = true;
//            }
//         }

         if (!hasRequiredData(uobDataMaster.getIndividualOwnersDetails().getOwnersFinancialDetails().getAreYouUnableToPayYouDebts(), "No"))
         {
            dsplPriHldrObjPnl3 = false;
         }
         else
         {
            dsplPriHldrObjPnl3 = true;
         }

         if (!hasRequiredData(uobDataMaster.getIndividualOwnersDetails().getOwnersFinancialDetails().getDoYouHaveAnyDisputedAccount(), "No"))
         {
            dsplPriHldrObjPnl4 = false;
         }
         else
         {
            dsplPriHldrObjPnl4 = true;
         }
      }
      catch (Exception e)
      {
      }
   }

   public void onChngTin()
   {
      try
      {
         if (owTaxDtls.getIsTINAvailable() != null)
         {
            if (owTaxDtls.getIsTINAvailable().equalsIgnoreCase("Yes"))
            {
               dsplPriHldrTaxTin = true;
               dsplPriHldrTaxRsnPnl = false;
            }
            else
            {
               dsplPriHldrTaxTin = false;
               dsplPriHldrTaxRsnPnl = true;
            }
         }
         else
         {
            dsplPriHldrTaxTin = false;
            dsplPriHldrTaxRsnPnl = false;
         }
      }
      catch (Exception e)
      {
      }
   }

   public void onChngRsn()
   {
      try
      {
         if (owTaxDtls.getTinUnavailableReason() != null && owTaxDtls.getTinUnavailableReason().equalsIgnoreCase("B"))
         {
            dsplPriHldrTaxRsn = true;
         }
         else
         {
            dsplPriHldrTaxRsn = false;
         }
      }
      catch (Exception e)
      {
      }
   }

   public void showTaxDtlPnl()
   {
      try
      {
         dsplPriHldrTaxDtl = true;
         onChngTin();
         onChngRsn();
         if (uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails() != null &&
            uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails().size() > 0)
         {
            disTaxBtn = true;
         }
         dispTaxAddBtn = true;
         dispTaxUpdBtn = false;
      }
      catch (Exception e)
      {
      }
   }

   public void hideTaxDtlPnl()
   {
      try
      {
         dsplPriHldrTaxTab = true;
         dsplPriHldrTaxDtl = false;
         owTaxDtls = new OwnerTaxationDetails();
         dsplPriHldrTaxTin = false;
         disTaxBtn = false;
         onChngTin();
         onChngRsn();
         owTaxDtls = new OwnerTaxationDetails();
         dsplPriHldrTaxTin = false;
         if (uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails() != null &&
            uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails().size() > 0)
         {
            dsplPriHldrTaxTab = true;
            dsplPriHldrTaxDtl = false;
            disTaxBtn = false;
         }
         else if (uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails() == null ||
            uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails().size() == 0)
         {
            dsplPriHldrTaxDtl = true;
            dsplPriHldrTaxTab = false;
         }
      }
      catch (Exception e)
      {
      }
   }

   public void onSelAcctTypAsJnt()
   {
      setSelIndAcctTyp(null);
      System.out.println("selIndAcctTyp " + selIndAcctTyp);
      System.out.println("selJntAcctTyp " + selJntAcctTyp);
   }

   public void introNextPage()
   {
      if (validateIntroPage())
      {
         String repid = null;
         String repDtls[] = null;
         String inpSalesPrnNm=null;
         if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getHavingRepDtls() == "Yes")
         {
            inpSalesPrnNm = uobDataMaster.getAccountDetails().getAccountMiscDetails().getSalesPersonName();

            if (repMap.get(inpSalesPrnNm) != null )
            {
               repDtls = repMap.get(inpSalesPrnNm).split("~");
               uobDataMaster.getAccountDetails().setRepId(repDtls[0]);
               uobDataMaster.getAccountDetails().setAdvisorId(Long.parseLong(repDtls[1]));
            }else{
               uobDataMaster.getAccountDetails().setRepId("CATCHALL");
               uobDataMaster.getAccountDetails().setAdvisorId(null);
            }
         }
         else
         {
            uobDataMaster.getAccountDetails().setRepId("CATCHALL");
            uobDataMaster.getAccountDetails().setAdvisorId(custodyService.getDefaultAdvisor());
         }
         custodyService.saveAcctDetails(uobDataMaster.getAccountDetails(), "" + getBeanLogonId());
         saveActAdditionalDtls(uobDataMaster.getAccountDetails().getAccountMiscDetails(), uobDataMaster.getAccountDetails().getAcctnum(), "ao_acct_misc_details");
         dspIntroAcctPnl = false;
         getPagemanager().setPage(0);
//         if (getAcctCat().equalsIgnoreCase("yes") &&
//            uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct() != null &&
//            uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("No"))
//         {
//            setAcctCat("No");
//         }

         if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("yes"))
         {
            dspExtAcctPnl = true;
            dspNewAcctPnl = false;
            setPagemanager(new PagesImpl(4));
            Integer currentPage = getPagemanager().getPage();
            getPagemanager().initPage();
            getPagemanager().setLastPageVisited(currentPage);
            getPagemanager().clearAllErrorMessage();
         }
         else if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("no"))
         {
            setPagemanager(new PagesImpl(10));
            Integer currentPage = getPagemanager().getPage();
            getPagemanager().initPage();
            getPagemanager().setLastPageVisited(currentPage);
            getPagemanager().clearAllErrorMessage();
            dspExtAcctPnl = false;
            dspNewAcctPnl = true;
         }
         else
         {
            System.out.println("Need to add in validation condition");
         }

         Boolean status = validateAllPage();
         if (status)
         {
            dsblSubmtBtn = false;
         }
         else
         {
            dsblSubmtBtn = true;
         }
         Integer currentPage = getPagemanager().getPage();
         getPagemanager().initPage();
         resetActiveTab(0);
         getPagemanager().setLastPageVisited(currentPage);
         getPagemanager().clearAllErrorMessage();
         saveandOpenError = null;
         inpSalesPrnNm = null;
         repid = null;
      }
   }

   public boolean validateIntroPage()
   {
      Boolean dataOK = true;
      StringBuilder sb = new StringBuilder();
      if (!hasRequiredData(uobDataMaster.getAccountDetails().getAcctTypeId()))
      {
         sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.actTyp", "Type of account like to open is required.", null));
//         dataOK = false;
//         introError= webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.actTyp", "Type of account like to open is required.", null);
      }
      if (hasRequiredData(uobDataMaster.getAccountDetails().getAcctTypeId()) &&
         !hasRequiredData(uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct()))
      {
         if(uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACINDIV")){
            sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.actTypIndiv", "Please select Existing Individual Securities trading account on UOBKH Yes/No.", null));
//            dataOK = false;
//            introError= webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.actTypIndiv", "Please select Existing Individual Securities trading account on UOBKH Yes/No.", null);
         }else if(uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACJOINT")){
            sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.actTypJoint", "Please select Existing Joint Securities trading account on UOBKH Yes/No.", null));
//            dataOK = false;
//            introError= webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.actTypJoint", "Please select Existing Joint Securities trading account on UOBKH Yes/No.", null);
         }
      }
      if(uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct() != null &&
         uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("Yes") &&
         !hasRequiredData(uobDataMaster.getAccountDetails().getAccountMiscDetails().getExistingTradeAcctNumber())){
         if (uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACINDIV"))
         {
            sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.extIndivActNum", "Enter your existing Individual UOBKH Securities Trading account number.", null));
//            dataOK = false;
//            introError= webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.extIndivActNum", "Enter your existing Individual UOBKH Securities Trading account number.", null);
         }
         else if (uobDataMaster.getAccountDetails().getAcctTypeId().equalsIgnoreCase("ACJOINT"))
         {
            sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.extJointActNum", "Enter your existing Joint UOBKH Securities Trading account number.", null));
//            dataOK = false;
//            introError= webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.extJointActNum", "Enter your existing Joint UOBKH Securities Trading account number.", null);
         }
      }
      if (!hasRequiredData(uobDataMaster.getAccountDetails().getAccountMiscDetails().getHavingRepDtls()))
      {
         sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.tradeRep", "Trading Representative details are required.", null));
//         dataOK = false;
//         introError= webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.tradeRep", "Trading Representative details are required.", null);
      }
      if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getHavingRepDtls() != null &&
         uobDataMaster.getAccountDetails().getAccountMiscDetails().getHavingRepDtls().trim().equalsIgnoreCase("Yes"))
      {
         if (!hasRequiredData(uobDataMaster.getAccountDetails().getAccountMiscDetails().getSalesPersonName()))
         {
            sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.tradeRepNm", "Trading Representative Name is required.", null));
//            dataOK = false;
//            introError= webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.tradeRepNm", "Trading Representative Name is required.", null);
         }
         else if (!repList.contains(uobDataMaster.getAccountDetails().getAccountMiscDetails().getSalesPersonName()))
         {
            sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.tradeRepNmInv", "Trading Representative Name is not valid.", null));
//            dataOK = false;
//            introError= webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.intro.tradeRepNmInv", "Trading Representative Name is not valid.", null);
         }
      }
      if (sb.length() > 0)
      {
         dataOK = false;
         introError = sb.toString();
      }
      else
      {
         dataOK = true;
         introError = null;
      }
      sb=null;
      return dataOK;
   }

   public void updateTaxPnl()
   {
      if (validateTaxPnl())
      {
         custodyService.deleteSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "Taxation");
         List<OwnerTaxationDetails> lst = uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails();
         for (int i = 0; i < lst.size(); i++)
         {
            OwnerTaxationDetails owTaxDtl = lst.get(i);
            if (i == owTaxDtls.getId() - 1)
            {
               owTaxDtl = owTaxDtls;
            }
            if (hasRequiredData(owTaxDtl.getIsTINAvailable()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "isTINAvailable", owTaxDtl.getIsTINAvailable());
            }
            if (hasRequiredData(owTaxDtl.getJurisdictionOfTaxResidence()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "jurisdictionOfTaxResidence", owTaxDtl.getJurisdictionOfTaxResidence());
            }
            if (hasRequiredData(owTaxDtl.getTaxIdentificationNumber()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "taxIdentificationNumber", owTaxDtl.getTaxIdentificationNumber());
            }
            if (hasRequiredData(owTaxDtl.getTinUnavailableReason()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "tinUnavailableReason", owTaxDtl.getTinUnavailableReason());
            }
            if (hasRequiredData(owTaxDtl.getTinUnavailableValue()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "tinUnavailableValue", owTaxDtl.getTinUnavailableValue());
            }
         }
         dsplPriHldrTaxTab = true;
         dsplPriHldrTaxDtl = false;
         owTaxDtls = new OwnerTaxationDetails();
         dsplPriHldrTaxTin = false;
         disTaxBtn = false;
         lst = null;
      }
   }

   public void saveTaxPnl()
   {
      if (validateTaxPnl())
      {
         custodyService.deleteSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "Taxation");
         List<OwnerTaxationDetails> lst = uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails();
         if (lst != null && lst.size() > 0)
         {
            owTaxDtls.setId(lst.size() + 1);
         }
         else
         {
            owTaxDtls.setId(1);
         }
         lst.add(owTaxDtls);
         for (int i = 0; i < lst.size(); i++)
         {
            OwnerTaxationDetails owTaxDtl = lst.get(i);
            if (hasRequiredData(owTaxDtl.getIsTINAvailable()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "isTINAvailable", owTaxDtl.getIsTINAvailable());
            }
            if (hasRequiredData(owTaxDtl.getJurisdictionOfTaxResidence()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "jurisdictionOfTaxResidence", owTaxDtl.getJurisdictionOfTaxResidence());
            }
            if (hasRequiredData(owTaxDtl.getTaxIdentificationNumber()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "taxIdentificationNumber", owTaxDtl.getTaxIdentificationNumber());
            }
            if (hasRequiredData(owTaxDtl.getTinUnavailableReason()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "tinUnavailableReason", owTaxDtl.getTinUnavailableReason());
            }
            if (hasRequiredData(owTaxDtl.getTinUnavailableValue()))
            {
               custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "tinUnavailableValue", owTaxDtl.getTinUnavailableValue());
            }
         }
         dsplPriHldrTaxTab = true;
         dsplPriHldrTaxDtl = false;
         owTaxDtls = new OwnerTaxationDetails();
         dsplPriHldrTaxTin = false;
         disTaxBtn = false;
         lst = null;
      }
   }

   public boolean validateTaxPnl()
   {
      Boolean dataOK = true;
      StringBuilder sb = new StringBuilder();
      taxError = null;
      if (!hasRequiredData(owTaxDtls.getJurisdictionOfTaxResidence()) || owTaxDtls.getJurisdictionOfTaxResidence().trim().equalsIgnoreCase(""))
      {
         sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.taxPnl.cntryDtl", "Country / Jurisdiction of tax residence is required.", null));
      }
      if (owTaxDtls.getJurisdictionOfTaxResidence()!=null && owTaxDtls.getJurisdictionOfTaxResidence().trim().equalsIgnoreCase("United States"))
      {
         sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.invCtry", "Particulars with US indicia are not permitted to open an account.", null));
      }
      if (!hasRequiredData(owTaxDtls.getIsTINAvailable()))
      {
         sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.taxPnl.havTaxNum", "Tax Identification Number (Yes / No ) is required.", null));
      }
      if (owTaxDtls.getIsTINAvailable() != null && owTaxDtls.getIsTINAvailable().equalsIgnoreCase("Yes") && !hasRequiredData(owTaxDtls.getTaxIdentificationNumber()))
      {
         sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.taxPnl.taxNum", "Tax Identification Number is required.", null));
      }
      if (owTaxDtls.getIsTINAvailable() != null && owTaxDtls.getIsTINAvailable().equalsIgnoreCase("No") && !hasRequiredData(owTaxDtls.getTinUnavailableReason()))
      {
         sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.taxPnl.rsnTaxNum", "Reason for no Tax identification number is required.", null));
      }
      if (owTaxDtls.getIsTINAvailable() != null && owTaxDtls.getIsTINAvailable().equalsIgnoreCase("No") &&
         (owTaxDtls.getTinUnavailableReason() != null && owTaxDtls.getTinUnavailableReason().equalsIgnoreCase("B")) &&
         !hasRequiredData(owTaxDtls.getTinUnavailableValue()))
      {
         sb.append(webutil.getMessageText().getDisplayMessage("validator.uob.acctOpen.taxPnl.rsnTaxNumExpl", "Explaination for Reason B is required.", null));
      }
      if (sb.length() > 0)
      {
         dataOK = false;
         taxError = sb.toString();
      }
      else
      {
         dataOK = true;
         taxError = null;
      }
      sb = null;
      return dataOK;
   }

   public void nextPage()
   {
      System.out.println("page current" + getPagemanager().getPage());
      if (validate(getPagemanager().getPage(), uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct(), false))
      {
         saveDetails(getPagemanager().getPage(), uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct(), false);
         getPagemanager().clearAllErrorMessage();
         Boolean nextPageFlag=false;
         if (getPagemanager().getPage() + 1 == getPagemanager().getMaxNoofPages())
         {
            dsblSubmtBtn = !validateAllPage();
            nextPageFlag=false;
//            finalSubmit=true;
         }
         else
         {
            dsblSubmtBtn = true;
            nextPageFlag=true;
//            finalSubmit=false;
         }
         if (getPagemanager().isLastPage() ||
            (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("No") && getPagemanager().getPage() == 9) ||
            (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("Yes") && getPagemanager().getPage() == 4))
         {
            if(!dsblSubmtBtn)
            {
               if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("Yes"))
               {
                  resetActiveTab(4);
               }
               else if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("No"))
               {
                  resetActiveTab(10);
               }
            }
         }
         else
         {
            if(nextPageFlag)
            {
               getPagemanager().nextPage();
               resetActiveTab(getPagemanager().getPage());
            }
         }
         System.out.println("page next" + getPagemanager().getPage());
      }else{
         dsblSubmtBtn = true;
      }
   }

   public void prevPage()
   {
      System.out.println("page current" + getPagemanager().getPage());
      getPagemanager().prevPage();
      System.out.println("page prev" + getPagemanager().getPage());
      setActiveTab(getPagemanager().getPage());
   }

   public void onChngNation(boolean bflag)
   {
      try
      {
         if (uobDataMaster.getIndividualOwnersDetails().getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Singaporean"))
         {
            dsplNricInp = true;
            dsplOtrCntry = false;
            dsplIcNoInp = false;
            dsplPspNoInp = false;
            dsplSingNricInp = false;
         }
         else if (uobDataMaster.getIndividualOwnersDetails().getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Singapore PR"))
         {
            dsplNricInp = false;
            dsplOtrCntry = false;
            dsplIcNoInp = false;
            dsplPspNoInp = false;
            dsplSingNricInp = true;
         }
         else
         {
            dsplNricInp = false;
            dsplSingNricInp = false;
            dsplOtrCntry = true;
            dsplIcNoInp = false;
            dsplPspNoInp = false;
         }
         if (bflag)
         {
            if (getCurrentAcctHolder().equalsIgnoreCase("Individual"))
            {
               uobDataMaster.getIndividualOwnersDetails().getOwnerIdentificationDetails().setNric(null);
               uobDataMaster.getIndividualOwnersDetails().getOwnerCitizenshipDetails().setNationalitySpecify(null);
               uobDataMaster.getIndividualOwnersDetails().getOwnerIdentificationDetails().setIcno(null);
               uobDataMaster.getIndividualOwnersDetails().getOwnerIdentificationDetails().setPassport(null);
            }
            else if (getCurrentAcctHolder().equalsIgnoreCase("Joint"))
            {
               uobDataMaster.getJointOwnersDetails().getOwnerIdentificationDetails().setNric(null);
               uobDataMaster.getJointOwnersDetails().getOwnerCitizenshipDetails().setNationalitySpecify(null);
               uobDataMaster.getJointOwnersDetails().getOwnerIdentificationDetails().setIcno(null);
               uobDataMaster.getJointOwnersDetails().getOwnerIdentificationDetails().setPassport(null);
            }
         }
      }
      catch (Exception e)
      {
      }
   }

   public void onChngEmplt()
   {
      try
      {
         if (uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().getEmplTypeId() == null ||
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().getEmplTypeId().equalsIgnoreCase("UnEmployed"))
         {
            if(uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().getEmplTypeId() != null){
               dsplNwPriUnEmpRsnPnl=true;
            }else{
               dsplNwPriUnEmpRsnPnl=false;
            }
            dsplNwPriEmpMnPnl = false;

            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setOccupation(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setEmployerName(null);
            priHldrEmpAddr = null;
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setEmployerZipCode(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setEmployerCity(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setEmployerZipCountry(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerContactDetails().setOfficeTelNumberCD(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerContactDetails().setOfficeTelNumber(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setEmployerStreetAddress1(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setEmployerStreetAddress2(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setEmployerStreetAddress3(null);
            uobDataMaster.getIndividualOwnersDetails().getOwnerEmploymentDetails().setEmployerStreetAddress4(null);
         }
         else
         {
            uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().setReasonForUnemployment(null);
            dsplNwPriEmpMnPnl = true;
            dsplNwPriUnEmpRsnPnl=false;
         }

         if (uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getQualifications() != null &&
            uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getQualifications().equalsIgnoreCase("Others"))
         {
            dsplNwPriEmpOtrDtlPnl = true;
         }
         else
         {
            dsplNwPriEmpOtrDtlPnl = false;
         }
      }
      catch (Exception e)
      {
      }
   }

   public void onChngAddr()
   {
      try
      {
         if (uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getMailAddressSameAsPhysical() == null ||
            uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getMailAddressSameAsPhysical().equalsIgnoreCase("Yes"))
         {
            dsplPriHldrMlPnl = false;
            uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().setReasonForMailAddreDiffer(null);
            setPriHldrMlAddr(null);
            uobDataMaster.getIndividualOwnersDetails().setMailingAddressCity(null);
            uobDataMaster.getIndividualOwnersDetails().setMailingAddressCountry(null);
            uobDataMaster.getIndividualOwnersDetails().setMailingAddressState(null);
            uobDataMaster.getIndividualOwnersDetails().setMailingAddressZipCode(null);
            uobDataMaster.getIndividualOwnersDetails().setMailingAddressStreet1(null);
            uobDataMaster.getIndividualOwnersDetails().setMailingAddressStreet2(null);
            uobDataMaster.getIndividualOwnersDetails().setMailingAddressStreet3(null);
            uobDataMaster.getIndividualOwnersDetails().setMailingAddressStreet4(null);

         }
         else
         {
            dsplPriHldrMlPnl = true;
            if (!hasRequiredData(uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getReasonForMailAddreDiffer()))
            {
               uobDataMaster.getIndividualOwnersDetails().setMailingAddressCity(null);
               uobDataMaster.getIndividualOwnersDetails().setMailingAddressCountry(null);
               uobDataMaster.getIndividualOwnersDetails().setMailingAddressState(null);
               uobDataMaster.getIndividualOwnersDetails().setMailingAddressZipCode(null);
            }
         }

      }
      catch (Exception e)
      {

      }
   }


   public void onChngSrcOfInc()
   {
      try
      {
         if (uobDataMaster.getIndividualOwnersDetails().getOwnersFinancialDetails().getSourceOfFundsWealth().equalsIgnoreCase("Others"))
         {
            dsplSrcIncOtrs = true;
         }
         else
         {
            dsplSrcIncOtrs = false;
         }
      }
      catch (Exception e)
      {
      }
   }

   private void loadPrsnlPage(){

      if(uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getConsentCallContact()!=null &&
         uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getConsentCallContact().equalsIgnoreCase("Yes")){
         setConsentCallFlag(true);
      }else{
         setConsentCallFlag(false);
      }
      if(uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getConsentTextContact()!=null &&
         uobDataMaster.getIndividualOwnersDetails().getOwnerMiscDetails().getConsentTextContact().equalsIgnoreCase("Yes")){
         setConsentMsgFlag(true);
      }else{
         setConsentMsgFlag(false);
      }
   }

   public void onChngRelDtls()
   {
      try
      {
         if (uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getRelatedToAnyEmplfUOB() == null ||
            uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getRelatedToAnyEmplfUOB().trim().equalsIgnoreCase("") ||
            uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getRelatedToAnyEmplfUOB().equalsIgnoreCase("No"))
         {
            dsplNwPriRelDtl = false;
         }
         else
         {
            dsplNwPriRelDtl = true;
         }

//         if (uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getControlOverUOBAcct() == null ||
//            uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getControlOverUOBAcct().trim().equalsIgnoreCase("") ||
//            uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getControlOverUOBAcct().equalsIgnoreCase("No"))
//         {
//            dsplNwPriInfDtl = false;
//         }
//         else
//         {
//            dsplNwPriInfDtl = true;
//         }
//
//         if (uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcct() == null ||
//            uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcct().trim().equalsIgnoreCase("") ||
//            uobDataMaster.getIndividualOwnersDetails().getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcct().equalsIgnoreCase("No"))
//         {
//            dsplNwPriCtrlDtl = false;
//         }
//         else
//         {
//            dsplNwPriCtrlDtl = true;
//         }
      }
      catch (Exception e)
      {
      }
   }


   public void onChngOtrCntry()
   {
      try
      {
         if (uobDataMaster.getIndividualOwnersDetails().getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others"))
         {
            dsplNricInp = false;
            dsplSingNricInp = false;
            if (uobDataMaster.getIndividualOwnersDetails().getOwnerCitizenshipDetails().getNationalitySpecify().equalsIgnoreCase("malaysia"))
            {
               dsplIcNoInp = true;
               dsplPspNoInp = false;
               uobDataMaster.getIndividualOwnersDetails().getOwnerIdentificationDetails().setPassport(null);
            }
            else
            {
               dsplIcNoInp = false;
               dsplPspNoInp = true;
               uobDataMaster.getIndividualOwnersDetails().getOwnerIdentificationDetails().setIcno(null);
            }
         }
      }
      catch (Exception e)
      {
      }
   }

   public Boolean validate(int pagenum, String isNewForm, boolean isJoint)
   {
      Boolean dataOK = true;
      pagemanager.clearErrorMessage(pagenum);
      OwnerDetails OwnDtls = null;
      if (!isJoint)
      {
         OwnDtls = uobDataMaster.getIndividualOwnersDetails();
      }
      else
      {
         OwnDtls = uobDataMaster.getJointOwnersDetails();
      }
      if (isNewForm.equalsIgnoreCase("NO"))
      {
         switch (pagenum)
         {
            case 0:// New Account ACCOUNT HOLDER
               dataOK = validateAcctHldr(OwnDtls, dtPriHldrDob);
               break;
            case 1:// New Account ADDRESS
               dataOK = validateAddrDtls(OwnDtls);
               break;
            case 2:// Remittance Screen
               dataOK=validateRemittanceDetails(OwnDtls);
               break;
            case 3:// New Account TAX RESIDENCE INFORMATION
               dataOK = validateTaxMnPnl(OwnDtls);
               break;
            case 4:// New Account EMPLOYMENT
               dataOK = validateEmpDtls(OwnDtls,dtPriHldrDob);
               break;
            case 5:// New Account SECURITY QUESTION
               dataOK = validateSecDtls(OwnDtls);
               break;
            case 6:// New Account FINANCIAL INFORMATION
               dataOK = validateFinDtls(OwnDtls);
               break;
            case 7:// New Account ACCOUNT RELATIONSHIP DETAILS
               dataOK = validateRelDtls(OwnDtls);
               break;
            case 8:// New Account TRADING HISTORY/OBJECTIVES
               dataOK = validateObjDtls(OwnDtls);
               break;
            case 9:// Personal Data Protection Consent
               dataOK = true;
               break;
            default:
               break;
         }
      }
      else
      {
         switch (pagenum)
         {
            case 0:// Existing Account ACCOUNT HOLDER
               dataOK = validateAcctHldr1(OwnDtls, dtPriHldrDob);
               break;
            case 1:// Remittance Screen
               dataOK=validateRemittanceDetails(OwnDtls);
               break;
            case 2:// Existing Account TAX RESIDENCE INFORMATION
               dataOK = validateTaxMnPnl(OwnDtls);
               break;
            case 3:// New Account SECURITY QUESTION
               dataOK = validateSecDtls(OwnDtls);
            default:
               break;
         }

      }
      return dataOK;
   }

   public Boolean saveDetails(int pagenum, String isNewForm, boolean isJoint)
   {
      Boolean dataOK = true;
      pagemanager.clearErrorMessage(pagenum);
      OwnerDetails ownDtls = null;
      if (!isJoint)
      {
         ownDtls = uobDataMaster.getIndividualOwnersDetails();
      }
      else
      {
         ownDtls = uobDataMaster.getJointOwnersDetails();
      }
      if (isNewForm.equalsIgnoreCase("NO"))
      {
         switch (pagenum)
         {
            case 0:// New Account ACCOUNT HOLDER
               if (!isJoint)
               {
                  SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
                  uobDataMaster.getIndividualOwnersDetails().setDob(sdf.format(dtPriHldrDob));
                  uobDataMaster.getIndividualOwnersDetails().setOwnership("Individual");
                  if(ownDtls.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Singapore PR")){
                     ownDtls.getOwnerMiscDetails().setPermanentRsdntOfSingapore("Yes");
                  }else if(ownDtls.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")){
                     ownDtls.getOwnerMiscDetails().setPermanentRsdntOfSingapore("No");
                  }
                  if(!ownDtls.getOwnerMiscDetails().getQualifications().equalsIgnoreCase("Others")){
                     ownDtls.getOwnerMiscDetails().setQualificationsSpecify(null);
                  }
                  saveAcctHldrDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "" + getBeanLogonId(), ownDtls);
               }
               else
               {
                  SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
                  uobDataMaster.getJointOwnersDetails().setDob(sdf.format(dtPriHldrDob));
                  uobDataMaster.getJointOwnersDetails().setOwnership("Joint");
                  if(ownDtls.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Singapore PR")){
                     ownDtls.getOwnerMiscDetails().setPermanentRsdntOfSingapore("Yes");
                  }else if(ownDtls.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")){
                     ownDtls.getOwnerMiscDetails().setPermanentRsdntOfSingapore("No");
                  }
                  if(!ownDtls.getOwnerMiscDetails().getQualifications().equalsIgnoreCase("Others")){
                     ownDtls.getOwnerMiscDetails().setQualificationsSpecify(null);
                  }
                  saveAcctHldrDtls(uobDataMaster.getAccountDetails().getAcctnum(), 2, "" + getBeanLogonId(), ownDtls);
               }
               break;
            case 1:// New Account ADDRESS
               saveAddrDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "" + getBeanLogonId(), ownDtls);
               break;
            case 2:// Remittance Screen
               dataOK=saveAcctHldrBankDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "" + getBeanLogonId(), ownDtls);
               break;
            case 3:// New Account TAX RESIDENCE INFORMATION
               dataOK=true;
               break;
            case 4:// New Account EMPLOYMENT
               dataOK=saveEmpDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "" + getBeanLogonId(), ownDtls);
               break;
            case 5:// New Account SECURITY QUESTION
//               saveSecDtls(ownDtls); Need changes for joint
               dataOK=saveSecDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, ownDtls);
               break;
            case 6:// New Account FINANCIAL INFORMATION
               dataOK=saveFinDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, ownDtls);
               break;
            case 7:// New Account ACCOUNT RELATIONSHIP DETAILS
               dataOK=saveRelDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, ownDtls);
               break;
            case 8:// New Account TRADING HISTORY/OBJECTIVES
               dataOK=saveObjDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, ownDtls);
               break;
            case 9:// Personal Data Protection Consent
               if(isConsentCallFlag()){
                  ownDtls.getOwnerMiscDetails().setConsentCallContact("Yes");
               }else{
                  ownDtls.getOwnerMiscDetails().setConsentCallContact("No");
               }
               if(isConsentMsgFlag()){
                  ownDtls.getOwnerMiscDetails().setConsentTextContact("Yes");
               }else{
                  ownDtls.getOwnerMiscDetails().setConsentTextContact("No");
               }
               dataOK=savePrsnlConseDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, ownDtls);
               break;
            default:
               break;
         }
      }
      else
      {
         switch (pagenum)
         {
            case 0:// Existing Account ACCOUNT HOLDER
               if (!isJoint)
               {
                  SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
                  // uobDataMaster.getIndividualOwnersDetails().setDob(sdf.format(dtPriHldrDob));
                  uobDataMaster.getIndividualOwnersDetails().setOwnership("Individual");

                  if(ownDtls.getOwnerMiscDetails().getQualifications()!=null && !ownDtls.getOwnerMiscDetails().getQualifications().equalsIgnoreCase("Others")){
                     ownDtls.getOwnerMiscDetails().setQualificationsSpecify(null);
                  }
                  saveAcctHldrDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "" + getBeanLogonId(), ownDtls);
               }
               else
               {
                  SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
//                  uobDataMaster.getJointOwnersDetails().setDob(sdf.format(dtPriHldrDob));
                  uobDataMaster.getJointOwnersDetails().setOwnership("Joint");
                  if(ownDtls.getOwnerMiscDetails().getQualifications()!=null && !ownDtls.getOwnerMiscDetails().getQualifications().equalsIgnoreCase("Others")){
                     ownDtls.getOwnerMiscDetails().setQualificationsSpecify(null);
                  }
                  saveAcctHldrDtls(uobDataMaster.getAccountDetails().getAcctnum(), 2, "" + getBeanLogonId(), ownDtls);
               }
               break;
            case 1:// Remittance Screen
               dataOK=saveAcctHldrBankDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "" + getBeanLogonId(), ownDtls);
               break;
            case 2:// Existing Account TAX RESIDENCE INFORMATION
               break;
            case 3:// New Account SECURITY QUESTION
//               saveSecDtls(ownDtls); Need changes for joint
               dataOK=saveSecDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, ownDtls);
               break;
            default:
               break;
         }

      }
      return dataOK;
   }

   public boolean saveAcctHldrDtls(Long acctNum, int acctOwnerId, String p_logonId, OwnerDetails ownerDetails)
   {
      custodyService.saveAccountHolderDtls(acctNum, acctOwnerId, p_logonId, ownerDetails);
      saveAdditionalDtls(ownerDetails.getOwnerContactDetails(), acctNum, acctOwnerId, "ao_owners_contact_details");
      saveAdditionalDtls(ownerDetails.getOwnerCitizenshipDetails(), acctNum, acctOwnerId, "ao_owners_citizenship_details");
      saveAdditionalDtls(ownerDetails.getOwnerIdentificationDetails(), acctNum, acctOwnerId, "ao_owners_indentification_details");
      saveAdditionalDtls(ownerDetails.getOwnerMiscDetails(), acctNum, acctOwnerId, "ao_owners_misc_details");
      return true;
   }

   public boolean saveAcctHldrBankDtls(Long acctNum, int acctOwnerId, String p_logonId, OwnerDetails ownerDetails)
   {
      if (hasRequiredData(priHldrBnkAddr))
      {
         AddressSplitter addressSplitter = new AddressSplitter();

         String[] addrdtls = addressSplitter.addressSplitter(priHldrBnkAddr, 3, 30);

         ownerDetails.getOwnerBankDetails().setBankAddressStreet1(addrdtls[0]);
         ownerDetails.getOwnerBankDetails().setBankAddressStreet2(addrdtls[1]);
         ownerDetails.getOwnerBankDetails().setBankAddressStreet3(addrdtls[2]);
//         ownerDetails.getOwnerBankDetails().setBankAddressStreet4(addrdtls[3]);
         addressSplitter=null;
      }
      custodyService.saveAccountHolderBankDtls(acctNum, acctOwnerId, p_logonId, ownerDetails);
      return true;
   }

   public boolean saveEmpDtls(Long acctNum, int acctOwnerId, String p_logonId, OwnerDetails ownerDetails)
   {
      if (hasRequiredData(priHldrEmpAddr))
      {
         AddressSplitter addressSplitter = new AddressSplitter();

         String[] addrdtls = addressSplitter.addressSplitter(priHldrEmpAddr, 3, 30);

         ownerDetails.getOwnerEmploymentDetails().setEmployerStreetAddress1(addrdtls[0]);
         ownerDetails.getOwnerEmploymentDetails().setEmployerStreetAddress2(addrdtls[1]);
         ownerDetails.getOwnerEmploymentDetails().setEmployerStreetAddress3(addrdtls[2]);
//         ownerDetails.getOwnerEmploymentDetails().setEmployerStreetAddress4(addrdtls[3]);
      }

      custodyService.saveEmploymentDtls(acctNum, acctOwnerId, p_logonId, ownerDetails);
      saveAdditionalDtls(ownerDetails.getOwnerMiscDetails(), acctNum, acctOwnerId, "ao_owners_misc_details");
      saveAdditionalDtls(ownerDetails.getOwnerContactDetails(), acctNum, acctOwnerId, "ao_owners_contact_details");
      return true;
   }

   public boolean saveAddrDtls(Long acctNum, int acctOwnerId, String p_logonId, OwnerDetails ownerDetails)
   {
      if (hasRequiredData(priHldrPhyAddr))
      {
         AddressSplitter addressSplitter = new AddressSplitter();

         String[] addrdtls = addressSplitter.addressSplitter(priHldrPhyAddr, 3, 30);

         ownerDetails.setPhysicalAddressStreet1(addrdtls[0]);
         ownerDetails.setPhysicalAddressStreet2(addrdtls[1]);
         ownerDetails.setPhysicalAddressStreet3(addrdtls[2]);
//         ownerDetails.setPhysicalAddressStreet4(addrdtls[3]);
      }
      if (hasRequiredData(priHldrMlAddr))
      {
         AddressSplitter addressSplitter = new AddressSplitter();

         String[] addrdtls = addressSplitter.addressSplitter(priHldrMlAddr, 3, 30);

         ownerDetails.setMailingAddressStreet1(addrdtls[0]);
         ownerDetails.setMailingAddressStreet2(addrdtls[1]);
         ownerDetails.setMailingAddressStreet3(addrdtls[2]);
//         ownerDetails.setMailingAddressStreet4(addrdtls[3]);
      }

      if(ownerDetails.getOwnerMiscDetails().getMailAddressSameAsPhysical().equalsIgnoreCase("Yes")){
         ownerDetails.setMailingAddressStreet1(ownerDetails.getPhysicalAddressStreet1());
         ownerDetails.setMailingAddressStreet2(ownerDetails.getPhysicalAddressStreet2());
         ownerDetails.setMailingAddressStreet3(ownerDetails.getPhysicalAddressStreet3());
         ownerDetails.setMailingAddressStreet4(ownerDetails.getPhysicalAddressStreet4());
         ownerDetails.setMailingAddressZipCode(ownerDetails.getPhysicalAddressZipCode());
         ownerDetails.setMailingAddressState(ownerDetails.getPhysicalAddressState());
         ownerDetails.setMailingAddressCity(ownerDetails.getPhysicalAddressCity());
         ownerDetails.setMailingAddressCountry(ownerDetails.getPhysicalAddressCountry());
      }
//      else{
//         ownerDetails.setMailingAddressStreet1(null);
//         ownerDetails.setMailingAddressStreet2(null);
//         ownerDetails.setMailingAddressStreet3(null);
//         ownerDetails.setMailingAddressStreet4(null);
//         ownerDetails.setMailingAddressZipCode(null);
//         ownerDetails.setMailingAddressState(null);
//         ownerDetails.setMailingAddressCity(null);
//         ownerDetails.setMailingAddressCountry(null);
//      }
      custodyService.saveAddressDtls(acctNum, acctOwnerId, p_logonId, ownerDetails);
      saveAdditionalDtls(ownerDetails.getOwnerMiscDetails(), acctNum, acctOwnerId, "ao_owners_misc_details");
      return true;
   }

   public boolean saveSecDtls(Long acctNum, int acctOwnerId, OwnerDetails ownerDetails)
   {
      saveAdditionalDtls(ownerDetails.getOwnerMiscDetails(), acctNum, acctOwnerId, "ao_owners_misc_details");
      return true;
   }

   public boolean savePrsnlConseDtls(Long acctNum, int acctOwnerId, OwnerDetails ownerDetails)
   {
      if((ownerDetails.getPhysicalAddressCountry()!=null && ownerDetails.getPhysicalAddressCountry().equalsIgnoreCase("Singapore") )||
         (ownerDetails.getOwnerEmploymentDetails().getEmployerZipCountry()!=null && ownerDetails.getOwnerEmploymentDetails().getEmployerZipCountry().equalsIgnoreCase("Singapore"))){
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setHavingGST("Yes");
      }else{
         uobDataMaster.getAccountDetails().getAccountMiscDetails().setHavingGST("No");
      }
      saveAdditionalDtls(ownerDetails.getOwnerMiscDetails(), acctNum, acctOwnerId, "ao_owners_misc_details");
      saveActAdditionalDtls(uobDataMaster.getAccountDetails().getAccountMiscDetails(), acctNum, "ao_acct_misc_details");
      return true;
   }

   public boolean saveFinDtls(Long acctNum, int acctOwnerId, OwnerDetails ownerDetails)
   {
      if(!ownerDetails.getOwnersFinancialDetails().getSourceOfFundsWealth().equalsIgnoreCase("Others")){
         ownerDetails.getOwnersFinancialDetails().setSourceOfFundsWealthSpecify(null);
      }
      saveAdditionalDtls(ownerDetails.getOwnersFinancialDetails(), acctNum, acctOwnerId, "ao_owners_finacial_details");
      return true;
   }

   public boolean saveRelDtls(Long acctNum, int acctOwnerId, OwnerDetails ownerDetails)
   {
      if(ownerDetails.getOwnerRegularityDetails().getRelatedToAnyEmplfUOB().equalsIgnoreCase("No")){
         ownerDetails.getOwnerRegularityDetails().setRelatedToAnyEmplName1(null);
         ownerDetails.getOwnerRegularityDetails().setRelatedToAnyEmplName2(null);
         ownerDetails.getOwnerRegularityDetails().setRelatedToAnyEmplRelation1(null);
         ownerDetails.getOwnerRegularityDetails().setRelatedToAnyEmplRelation2(null);
      }
      saveAdditionalDtls(ownerDetails.getOwnerRegularityDetails(), acctNum, acctOwnerId, "ao_owners_regularity_details");
      return true;
   }

   public boolean saveObjDtls(Long acctNum, int acctOwnerId, OwnerDetails ownerDetails)
   {
      if(ownerDetails.getOwnersFinancialDetails().getAreYouUnableToPayYouDebts().equalsIgnoreCase("No")){
         ownerDetails.getOwnersFinancialDetails().setAreYouUnableToPayYouDebtsDescribe(null);
      }
      if(ownerDetails.getOwnersFinancialDetails().getDoYouHaveAnyDisputedAccount().equalsIgnoreCase("No")){
         ownerDetails.getOwnersFinancialDetails().setDoYouHaveAnyDisputedAccountDescribe(null);
      }
      saveAdditionalDtls(ownerDetails.getOwnersFinancialDetails(), acctNum, acctOwnerId, "ao_owners_finacial_details");
      return true;
   }

   public void saveAdditionalDtls(Object obj, Long acctNum, int acctOwnerId, String table)
   {
      try
      {
         Map<String, Object> obMap = getFieldNames(obj, false);
         System.out.print("Query gen" + getAddtnlFldsInsrtQry(obj, false, table, acctNum, acctOwnerId));
         for (Map.Entry<String, Object> entry : obMap.entrySet())
         {
            String name = entry.getKey();
            Object value = entry.getValue();
            if (value == null)
            {
               custodyService.saveAdditionalDtls(acctNum, acctOwnerId, name, null, table);
            }
            else
            {
               custodyService.saveAdditionalDtls(acctNum, acctOwnerId, name, value.toString(), table);
            }
         }

      }
      catch (Exception e)
      {

      }
   }

   public void saveActAdditionalDtls(Object obj, Long acctNum, String table)
   {
      try
      {
         Map<String, Object> obMap = getFieldNames(obj, false);
         for (Map.Entry<String, Object> entry : obMap.entrySet())
         {
            String name = entry.getKey();
            Object value = entry.getValue();
            if (value == null)
            {
               custodyService.saveAcctAdditionalDtls(acctNum, name, null, table);
            }
            else
            {
               custodyService.saveAcctAdditionalDtls(acctNum, name, value.toString(), table);
            }
         }

      }
      catch (Exception e)
      {

      }
   }

   public Boolean validateAcctHldr1(OwnerDetails ownerDetails, Date dob)
   {
      Boolean dataOK = true;
      if (ownerDetails.getFullName() == null || ownerDetails.getFullName().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.fullName", "Full Name is required!", null));
      }
      if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("No"))
      {
         if (ownerDetails.getGender() == null || ownerDetails.getGender().equalsIgnoreCase("select"))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.gender", "Gender is required!", null));
         }
//      Pending for Date of birth
         if (dob == null)
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.dob", "Date of birth is required!", null));
         }
         if (ownerDetails.getCountryOfBirth() == null || ownerDetails.getCountryOfBirth().equalsIgnoreCase("select"))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryOfBrth", "Country of birth is required!", null));
         }
         if (ownerDetails.getOwnerCitizenshipDetails().getNationality() == null ||
            ownerDetails.getOwnerCitizenshipDetails().getNationality().trim().equalsIgnoreCase(""))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.natioanlity", "Nationality is required!", null));
         }
         if (ownerDetails.getOwnerCitizenshipDetails().getNationality() != null &&
            !ownerDetails.getOwnerCitizenshipDetails().getNationality().trim().equalsIgnoreCase(""))
         {
            if (!ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && !hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getNric()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.nric", "NRIC number is required!", null));
            }
            if (!ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getNric()) &&
               validateDataByPattern(WebConst.UOB_PATTERN_SINGAPORE_NRIC, ownerDetails.getOwnerIdentificationDetails().getNric().trim()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.nricPtrn", "NRIC number format is not valid!", null));
            }
         }
         if (ownerDetails.getOwnerCitizenshipDetails().getNationality() != null &&
            !ownerDetails.getOwnerCitizenshipDetails().getNationality().trim().equalsIgnoreCase(""))
         {
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && !hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.otrNatCtry", "Other nationality country is required!", null));
            }
         }
         if (hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationality()))
         {
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify()) &&
               ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().equalsIgnoreCase("Malaysia")
               && !hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getIcno()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malayIcNum", "Malaysian NRIC number is required!", null));
            }

            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify()) &&
               ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().equalsIgnoreCase("Malaysia")
               && hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getIcno()) &&
               validateDataByPattern(WebConst.UOB_PATTERN_MALAYSIAN_NRIC,ownerDetails.getOwnerIdentificationDetails().getIcno()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malayIcNumPtrn", "Malaysian NRIC number format is not valid!", null));
            }
         }
         if (ownerDetails.getOwnerCitizenshipDetails().getNationality() != null &&
            !ownerDetails.getOwnerCitizenshipDetails().getNationality().trim().equalsIgnoreCase(""))
         {
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify()) &&
               !ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().equalsIgnoreCase("Malaysia")
               && (ownerDetails.getOwnerIdentificationDetails().getPassport() == null ||
               ownerDetails.getOwnerIdentificationDetails().getPassport().trim().equalsIgnoreCase("")))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.psprtNum", "Passport number is required is required!", null));
            }
         }
      }
      else
      {
         if (!hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getNric()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.nric", "NRIC number is required!", null));
         }
         if (hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getNric()) &&
               validateDataByPattern(WebConst.UOB_PATTERN_SINGAPORE_NRIC, ownerDetails.getOwnerIdentificationDetails().getNric().trim()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.nricPtrn", "NRIC number format is not valid!", null));
         }
      }

//      if (ownerDetails.getOwnerContactDetails().getHomeTelNumberCD() == null ||
//         ownerDetails.getOwnerContactDetails().getHomeTelNumberCD().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdHmNum", "Country code for home tel number is required!", null));
//      }
//      if (ownerDetails.getOwnerContactDetails().getHomeTelNumber() == null ||
//         ownerDetails.getOwnerContactDetails().getHomeTelNumber().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.hmNum", "Home tel number is required!", null));
//      }
//
      if (ownerDetails.getOwnerContactDetails().getMobNumberCD() == null ||
         ownerDetails.getOwnerContactDetails().getMobNumberCD().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdMblNum", "Country code for mobile number is required!", null));
      }

      if (ownerDetails.getOwnerContactDetails().getMobNumber() == null ||
         ownerDetails.getOwnerContactDetails().getMobNumber().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.mblNum", "Mobile number is required!", null));
      }

//      if (ownerDetails.getOwnerContactDetails().getOfficeTelNumberCD() == null ||
//         ownerDetails.getOwnerContactDetails().getOfficeTelNumberCD().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdOffNum", "Country code for office tel number is required!", null));
//      }
//
//      if (ownerDetails.getOwnerContactDetails().getOfficeTelNumber() == null ||
//         ownerDetails.getOwnerContactDetails().getOfficeTelNumber().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.offNum", "Office tel number is required!", null));
//      }

//      if (ownerDetails.getOwnerContactDetails().getFaxNumberCD() == null ||
//         ownerDetails.getOwnerContactDetails().getFaxNumberCD().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdFaxNum", "Country code for fax number is required!", null));
//      }
//
//      if (ownerDetails.getOwnerContactDetails().getFaxNumber() == null ||
//         ownerDetails.getOwnerContactDetails().getFaxNumber().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.faxNum", "Fax number is required!", null));
//      }

      if (!hasRequiredData(ownerDetails.getEmailAddress()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.email.requiredMsg", "Email address is required!", null));
      }
      if (validateEmailPattern(ownerDetails.getEmailAddress()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.emlAddrs", "Valid email address is required!", null));
      }

      if(!hasRequiredData(ownerDetails.getOwnerMiscDetails().getConfirmEmail())){
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.emailCnf.requiredMsg", "Confirm Email address is required!", null));
      }
      if(hasRequiredData(ownerDetails.getOwnerMiscDetails().getConfirmEmail()) && !ownerDetails.getEmailAddress().equals(ownerDetails.getOwnerMiscDetails().getConfirmEmail())){
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.emailCnfMtch.requiredMsg", "Email address and Confirm Email address not matched!", null));
      }
      System.out.println("validtion output " + dataOK);
      return dataOK;
   }

   public Boolean validateAcctHldr(OwnerDetails ownerDetails, Date dob)
   {
      Boolean dataOK = true;
      if (ownerDetails.getTitle() == null || ownerDetails.getTitle().equalsIgnoreCase("select"))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.title", "Title is required!", null));
      }
      if (ownerDetails.getFullName() == null || ownerDetails.getFullName().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.fullName", "Full Name is required!", null));
      }
      if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("No"))
      {
         if (ownerDetails.getGender() == null || ownerDetails.getGender().equalsIgnoreCase("select"))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.gender", "Gender is required!", null));
         }
//      Pending for Date of birth
         if (dob == null)
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.dob", "Date of birth is required!", null));
         }

         if(dob !=null && calculateAge(dob)<21){
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.dobCond", "Young Investor below 21 years old is not allowed to open Account!", null));
         }


         if (ownerDetails.getCountryOfBirth() == null || ownerDetails.getCountryOfBirth().equalsIgnoreCase("select"))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryOfBrth", "Country of birth is required!", null));
         }

         if (ownerDetails.getCountryOfBirth() != null && !ownerDetails.getCountryOfBirth().equalsIgnoreCase("select")
            && ownerDetails.getCountryOfBirth().equalsIgnoreCase("United States"))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryOfBrthUS", "Application denied, if client’s country of birth is US.", null));
         }


         if (ownerDetails.getOwnerCitizenshipDetails().getNationality() == null ||
            ownerDetails.getOwnerCitizenshipDetails().getNationality().trim().equalsIgnoreCase(""))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.natioanlity", "Nationality is required!", null));
         }
         if (ownerDetails.getOwnerCitizenshipDetails().getNationality() != null &&
            !ownerDetails.getOwnerCitizenshipDetails().getNationality().trim().equalsIgnoreCase(""))
         {
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Singapore Pr")
               && ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().trim().equalsIgnoreCase(""))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctry", "Country of nationality is required!", null));
            }
         }
         if (hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationality()))
         {
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Singapore Pr")
               && ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().trim().equalsIgnoreCase(""))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctry", "Country of nationality is required!", null));
            }else if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Singapore Pr")
               && ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().trim().equalsIgnoreCase("United States"))
            {
//               ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().trim().equalsIgnoreCase("Singapore") ||
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.invCtry", "US Citizen is not eligible to open Robo account.", null));
            }
         }

         if (hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationality()))
         {
            if (!ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && !hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getNric()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.nric", "NRIC number is required!", null));
            }
            if (!ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getNric()) &&
                  validateDataByPattern(WebConst.UOB_PATTERN_SINGAPORE_NRIC, ownerDetails.getOwnerIdentificationDetails().getNric().trim()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.nricPtrn", "NRIC number format is not valid!", null));
            }
         }
         if (ownerDetails.getOwnerCitizenshipDetails().getNationality() != null &&
            !ownerDetails.getOwnerCitizenshipDetails().getNationality().trim().equalsIgnoreCase(""))
         {
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && !hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.otrNatCtry", "Other nationality country is required!", null));
            }else if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               &&
               ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().trim().equalsIgnoreCase("United States"))
            {
//               (ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().trim().equalsIgnoreCase("Singapore") ||
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.invCtry", "US Citizen is not eligible to open Robo account.", null));
            }
         }
         if (hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationality()))
         {
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify()) &&
               ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().equalsIgnoreCase("Malaysia")
               && !hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getIcno()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malayIcNum", "Malaysian NRIC number is required!", null));
            }
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify()) &&
               ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().equalsIgnoreCase("Malaysia")
               && hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getIcno()) &&
               validateDataByPattern(WebConst.UOB_PATTERN_MALAYSIAN_NRIC,ownerDetails.getOwnerIdentificationDetails().getIcno()))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malayIcNumPtrn", "Malaysian NRIC number format is not valid!", null));
            }
         }
         if (ownerDetails.getOwnerCitizenshipDetails().getNationality() != null &&
            !ownerDetails.getOwnerCitizenshipDetails().getNationality().trim().equalsIgnoreCase(""))
         {
            if (ownerDetails.getOwnerCitizenshipDetails().getNationality().equalsIgnoreCase("Others")
               && hasRequiredData(ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify()) &&
               !ownerDetails.getOwnerCitizenshipDetails().getNationalitySpecify().equalsIgnoreCase("Malaysia")
               && (ownerDetails.getOwnerIdentificationDetails().getPassport() == null ||
               ownerDetails.getOwnerIdentificationDetails().getPassport().trim().equalsIgnoreCase("")))
            {
               dataOK = false;
               pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.psprtNum", "Passport number is required is required!", null));
            }
         }
         if(validateCstmCond( ownerDetails,  dob)){
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.crtErr1",
                                                                                   "You are not permitted to open an account at this time, due to age is over 62 and retired and only has primary school as education.", null));
         }
      }
      else
      {
         if (!hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getNric()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.nric", "NRIC number is required!", null));
         }

         if (hasRequiredData(ownerDetails.getOwnerIdentificationDetails().getNric())&&
            validateDataByPattern(WebConst.UOB_PATTERN_SINGAPORE_NRIC, ownerDetails.getOwnerIdentificationDetails().getNric().trim()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.nricPtrn", "NRIC number format is not valid!", null));
         }
      }

//      if (ownerDetails.getOwnerContactDetails().getHomeTelNumberCD() == null ||
//         ownerDetails.getOwnerContactDetails().getHomeTelNumberCD().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdHmNum", "Country code for home tel number is required!", null));
//      }
//      if (ownerDetails.getOwnerContactDetails().getHomeTelNumber() == null ||
//         ownerDetails.getOwnerContactDetails().getHomeTelNumber().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.hmNum", "Home tel number is required!", null));
//      }
//
      if (!hasRequiredData(ownerDetails.getOwnerMiscDetails().getQualifications()) || ownerDetails.getOwnerMiscDetails().getQualifications().equalsIgnoreCase("Select"))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.eduQual", "Education qualification is required!", null));
      }
      if (ownerDetails.getOwnerMiscDetails().getQualifications() != null && ownerDetails.getOwnerMiscDetails().getQualifications().equalsIgnoreCase("Others")
         && !hasRequiredData(ownerDetails.getOwnerMiscDetails().getQualificationsSpecify()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.eduQualOtr", "Other qualification detail is required!", null));
      }
      if (ownerDetails.getOwnerContactDetails().getMobNumberCD() == null ||
         ownerDetails.getOwnerContactDetails().getMobNumberCD().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdMblNum", "Country code for mobile number is required!", null));
      }

      if (ownerDetails.getOwnerContactDetails().getMobNumber() == null ||
         ownerDetails.getOwnerContactDetails().getMobNumber().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.mblNum", "Mobile number is required!", null));
      }

//      if (ownerDetails.getOwnerContactDetails().getOfficeTelNumberCD() == null ||
//         ownerDetails.getOwnerContactDetails().getOfficeTelNumberCD().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdOffNum", "Country code for office tel number is required!", null));
//      }
//
//      if (ownerDetails.getOwnerContactDetails().getOfficeTelNumber() == null ||
//         ownerDetails.getOwnerContactDetails().getOfficeTelNumber().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.offNum", "Office tel number is required!", null));
//      }

//      if (ownerDetails.getOwnerContactDetails().getFaxNumberCD() == null ||
//         ownerDetails.getOwnerContactDetails().getFaxNumberCD().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdFaxNum", "Country code for fax number is required!", null));
//      }
//
//      if (ownerDetails.getOwnerContactDetails().getFaxNumber() == null ||
//         ownerDetails.getOwnerContactDetails().getFaxNumber().trim().equalsIgnoreCase(""))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.faxNum", "Fax number is required!", null));
//      }

      if (!hasRequiredData(ownerDetails.getEmailAddress()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.email.requiredMsg", "Email address is required!", null));
      }
      if (validateEmailPattern(ownerDetails.getEmailAddress()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.emlAddrs", "Valid email address is required!", null));
      }
      if(!hasRequiredData(ownerDetails.getOwnerMiscDetails().getConfirmEmail())){
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.emailCnf.requiredMsg", "Confirm Email address is required!", null));
      }
      if(hasRequiredData(ownerDetails.getOwnerMiscDetails().getConfirmEmail()) && !ownerDetails.getEmailAddress().equals(ownerDetails.getOwnerMiscDetails().getConfirmEmail())){
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.emailCnfMtch.requiredMsg", "Email address and Confirm Email address not matched!", null));
      }

      System.out.println("validtion output " + dataOK);
      return dataOK;
   }

   public boolean validateSecDtls(OwnerDetails ownerDetails)
   {
      Boolean dataOK = true;
      if (ownerDetails.getOwnerMiscDetails().getMotherMaidenName() == null || ownerDetails.getOwnerMiscDetails().getMotherMaidenName().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.momNm", "Mother's Maiden Name is required!", null));
      }
      if (ownerDetails.getOwnerMiscDetails().getFatherName() == null || ownerDetails.getOwnerMiscDetails().getFatherName().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.dadNm", "Father's Name is required!", null));
      }
      if (ownerDetails.getOwnerMiscDetails().getNameOfPrimarySchool() == null || ownerDetails.getOwnerMiscDetails().getNameOfPrimarySchool().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.sclNm", "Name of Primary School Attended is required!", null));
      }
      return dataOK;
   }

   public boolean validateTaxMnPnl(OwnerDetails ownerDetails)
   {
      Boolean dataOK = true;
      if (ownerDetails.getOwnerTaxationDetails() == null || ownerDetails.getOwnerTaxationDetails().size() == 0)
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.txtMnPnl", "Taxation detail is required!", null));
      }

      return dataOK;
   }

   public boolean validateEmpDtls(OwnerDetails ownerDetails,Date dob)
   {
      Boolean dataOK = true;
      if (!hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmplTypeId()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.empStat", "Employment status is required!", null));
      }

      if (hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmplTypeId()) && hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmplTypeId()) &&
         ownerDetails.getOwnerEmploymentDetails().getEmplTypeId().equalsIgnoreCase("UnEmployed") &&
         (ownerDetails.getOwnerMiscDetails().getReasonForUnemployment() == null || ownerDetails.getOwnerMiscDetails().getReasonForUnemployment().equalsIgnoreCase("select")))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.unEmpRsn", "Reason for Unemployment is required!", null));
      }


      if (hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmplTypeId()) && !ownerDetails.getOwnerEmploymentDetails().getEmplTypeId().equalsIgnoreCase("UnEmployed"))
      {
         if (!hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getOccupation()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.empOcc", "Occupation is required!", null));
         }
         if (!hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmployerName()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.empNm", "Name of Employer is required!", null));
         }
         if (!hasRequiredData(priHldrEmpAddr))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.empAddr", "Employer Address is required!", null));
         }
         if (!hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmployerZipCode()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.empPoCd", "Postal code is required!", null));
         }
         if (!hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmployerCity()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.empCty", "City/State is required!", null));
         }
         if (!hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmployerZipCountry()) || ownerDetails.getOwnerEmploymentDetails().getEmployerZipCountry().trim().equalsIgnoreCase(""))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.empCtry", "Country is required!", null));
         }

         if(hasRequiredData(ownerDetails.getOwnerEmploymentDetails().getEmployerZipCountry()) &&ownerDetails.getOwnerEmploymentDetails().getEmployerZipCountry().equalsIgnoreCase("United States")){
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.invCtryEmp", "US Citizen is not eligible to open Robo account.", null));
         }

         if (!hasRequiredData(ownerDetails.getOwnerContactDetails().getOfficeTelNumberCD()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctryCdOffNum", "Country code for office tel number is required!", null));
         }

         if (!hasRequiredData(ownerDetails.getOwnerContactDetails().getOfficeTelNumber()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.offNum", "Office tel number is required!", null));
         }
      }

      if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("No"))
      {
         if (validateCstmCond(ownerDetails, dob))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.crtErr1",
                                                                                   "You are not permitted to open an account at this time, due to age is over 62 and retired and only has primary school as education.", null));
         }
      }

      return dataOK;
   }

   public boolean validateAddrDtls(OwnerDetails ownerDetails)
   {
      Boolean dataOK = true;
      if (!hasRequiredData(priHldrPhyAddr))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.phyAddr", "Residential Address is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getPhysicalAddressZipCode()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.phyPoCd", "Residential postal code is required!", null));
      }

      if (!hasRequiredData(ownerDetails.getPhysicalAddressCity()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.phyCty", "Residential City / State is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getPhysicalAddressCountry()) || ownerDetails.getPhysicalAddressCountry().trim().equalsIgnoreCase(""))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.phyCtry", "Residential country is required!", null));
      }
      if(hasRequiredData(ownerDetails.getPhysicalAddressCountry()) && ownerDetails.getPhysicalAddressCountry().equalsIgnoreCase("United States")){
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.invCtryResPhy", "US Resident is not eligible to open Robo account.", null));
      }
      if (!hasRequiredData(ownerDetails.getOwnerMiscDetails().getMailAddressSameAsPhysical()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malFlag", "Mailing address same as Residential address is required!", null));
      }

      if (ownerDetails.getOwnerMiscDetails().getMailAddressSameAsPhysical() != null && ownerDetails.getOwnerMiscDetails().getMailAddressSameAsPhysical().equalsIgnoreCase("No"))
      {
         if (!hasRequiredData(ownerDetails.getOwnerMiscDetails().getReasonForMailAddreDiffer()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malAddrDffRsn", "Reason Of Different Mailing Address is required!", null));
         }
         if (!hasRequiredData(priHldrMlAddr))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malAddr", "Mailing Address is required!", null));
         }
         if (!hasRequiredData(ownerDetails.getMailingAddressZipCode()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malPoCd", "Mailing postal code is required!", null));
         }

         if (!hasRequiredData(ownerDetails.getMailingAddressCity()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malCty", "Mailing City / State is required!", null));
         }
         if (!hasRequiredData(ownerDetails.getMailingAddressCountry()) || ownerDetails.getMailingAddressCountry().trim().equalsIgnoreCase(""))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.malCtry", "Mailing country is required!", null));
         }

         if(hasRequiredData(ownerDetails.getMailingAddressCountry()) && ownerDetails.getMailingAddressCountry().equalsIgnoreCase("United States")){
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.invCtryResMail", "US Resident is not eligible to open Robo account.", null));
         }
      }
      return dataOK;
   }

   public boolean validateRemittanceDetails(OwnerDetails ownerDetails)
   {
      Boolean dataOK = true;
      if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getBankAccountHolderName()) )
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.bnkAcctHldrNm", "Account Holder Name is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getBankName()) )
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.bnkNm", "Bank Name is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getBankAccountNo()) )
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.bnkAcctNum", "Bank Account No is required!", null));
      }
      if (!hasRequiredData(getPriHldrBnkAddr()) )
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.bnkAddr", "Bank Address is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getBankAddressZipCode()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.bnkAddrPoCd", "Bank address Postal Code is required!", null));
      }

      if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getBankAddressCity()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.bnkAddrCty","Bank address City/State is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getBankAddressCountry()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.bnkAddrCtry","Bank address Country is required!", null));
      }
      if(hasRequiredData(ownerDetails.getOwnerBankDetails().getBankAddressCountry()) &&
         ownerDetails.getOwnerBankDetails().getBankAddressCountry().equalsIgnoreCase("United States")){
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.invCtryBnkAddr","US Citizen is not eligible to open Robo account", null));
      }
      /*if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getSwiftBic()) )
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.swiftBic", "Swift Bic is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getCorrespondentBank()) )
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.corrBnk", "Correspondent Bank Name is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getOwnerBankDetails().getCorrespondentBankSwiftBic()) )
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.corrBnkSwiftBic", "Correspondent Bank Swift Bic is required!", null));
      }*/
      return dataOK;
   }

   public boolean validateFinDtls(OwnerDetails ownerDetails)
   {
      Boolean dataOK = true;
      if (ownerDetails.getOwnersFinancialDetails().getAnnualIncome() == null ||
         ownerDetails.getOwnersFinancialDetails().getAnnualIncome().equalsIgnoreCase("select"))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.anlInc", "Mother's Maiden Name is required!", null));
      }
      if (ownerDetails.getOwnersFinancialDetails().getNetworth() == null ||
         ownerDetails.getOwnersFinancialDetails().getNetworth().equalsIgnoreCase("select"))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.netWrth", "NetWorth is required!", null));
      }
      if (ownerDetails.getOwnersFinancialDetails().getSourceOfFundsWealth() == null ||
         ownerDetails.getOwnersFinancialDetails().getSourceOfFundsWealth().equalsIgnoreCase("select"))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.src", "Source of Funds / Wealth is required!", null));
      }
      if (ownerDetails.getOwnersFinancialDetails().getSourceOfFundsWealth() != null &&
         ownerDetails.getOwnersFinancialDetails().getSourceOfFundsWealth().equalsIgnoreCase("Others") &&
         (ownerDetails.getOwnersFinancialDetails().getSourceOfFundsWealthSpecify() == null ||
            ownerDetails.getOwnersFinancialDetails().getSourceOfFundsWealthSpecify().trim().equalsIgnoreCase("")))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.srcOtrs", "Please specify Source of Funds/Weath!", null));
      }
      return dataOK;
   }

   public boolean validateRelDtls(OwnerDetails ownerDetails)
   {
      Boolean dataOK = true;
      if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getRelatedToAnyEmplfUOB()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.relChc",
                                                                                "Related to any employee / trading details are required!", null));
      }
      if (ownerDetails.getOwnerRegularityDetails().getRelatedToAnyEmplfUOB() != null &&
         ownerDetails.getOwnerRegularityDetails().getRelatedToAnyEmplfUOB().trim().equalsIgnoreCase("Yes"))
      {
         if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getRelatedToAnyEmplName1()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.relNm1",
                                                                                   "Name related to any employee / trading details is required!", null));
         }
         if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getRelatedToAnyEmplRelation1()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.relNum1",
                                                                                   "Account Number related to any employee / trading details is required!", null));
         }
         if (hasRequiredData(ownerDetails.getOwnerRegularityDetails().getRelatedToAnyEmplName2()) &&
            !hasRequiredData(ownerDetails.getOwnerRegularityDetails().getRelatedToAnyEmplRelation2()))
         {
            dataOK = false;
            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.relNum1",
                                                                                   "Account Number related to any employee / trading details is required!", null));
         }
      }

//      if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getControlOverUOBAcct()))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.inflAct",
//                                                                                "Details of trading account(s) in UOB Kay Hian in which you have control or influence is required!", null));
//      }
//
//      if (ownerDetails.getOwnerRegularityDetails().getControlOverUOBAcct() != null &&
//         ownerDetails.getOwnerRegularityDetails().getControlOverUOBAcct().trim().equalsIgnoreCase("Yes"))
//      {
//         if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getControlOverUOBAcctName1()))
//         {
//            dataOK = false;
//            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.inflNm1",
//                                                                                   "Name related to trading account(s) in UOB Kay Hian in which you have control or influence is required!", null));
//         }
//         if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getControlOverUOBAcctNumber1()))
//         {
//            dataOK = false;
//            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.inflNum1",
//                                                                                   "Account Number related to trading account(s) in UOB Kay Hian in which you have control or influence is required!", null));
//         }
//         if (hasRequiredData(ownerDetails.getOwnerRegularityDetails().getControlOverUOBAcctName2()) &&
//            !hasRequiredData(ownerDetails.getOwnerRegularityDetails().getControlOverUOBAcctNumber2()))
//         {
//            dataOK = false;
//            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.inflNum2",
//                                                                                   "Account Number related to trading account(s) in UOB Kay Hian in which you have control or influence is required!", null));
//         }
//      }
//
//
//      if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcct()))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctrlAct",
//                                                                                "Details related account holder in UOB Kay Hian, who has control or influence over this trading account is required!", null));
//      }
//
//      if (ownerDetails.getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcct() != null &&
//         ownerDetails.getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcct().trim().equalsIgnoreCase("Yes"))
//      {
//         if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcctName1()))
//         {
//            dataOK = false;
//            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctrlNm1",
//                                                                                   "Name related to trading account(s) in UOB Kay Hian in which you have control or influence is required!", null));
//         }
//         if (!hasRequiredData(ownerDetails.getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcctNumber1()))
//         {
//            dataOK = false;
//            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctrlNum1",
//                                                                                   "Account Number related to account holder in UOB Kay Hian, who has control or influence over this trading account is required!", null));
//         }
//         if (hasRequiredData(ownerDetails.getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcctName2()) &&
//            !hasRequiredData(ownerDetails.getOwnerRegularityDetails().getUobAcctHolderControlOverTradeAcctNumber2()))
//         {
//            dataOK = false;
//            pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.ctrlNum2",
//                                                                                   "Account Number related to account holder in UOB Kay Hian, who has control or influence over this trading account is required!", null));
//         }
//      }

      return dataOK;
   }


   public boolean validateObjDtls(OwnerDetails ownerDetails)
   {
      Boolean dataOK = true;
//      if (!hasRequiredData(ownerDetails.getOwnersFinancialDetails().getPreviousInvestingExperience()))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.preExp",
//                                                                                "Previous experience in investing in financial product(s) is required!", null));
//      }
//      if (ownerDetails.getOwnersFinancialDetails().getPreviousInvestingExperience() != null &&
//         ownerDetails.getOwnersFinancialDetails().getPreviousInvestingExperience().equalsIgnoreCase("Yes") &&
//         !hasRequiredData(ownerDetails.getOwnersFinancialDetails().getPreviousInvestingExperienceSpecify()))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.preExpSpf",
//                                                                                "Please specify previous experience in investing in financial product(s) is required!", null));
//      }
//      if (!hasRequiredData(ownerDetails.getOwnersFinancialDetails().getInvestmentObjectives(), "Select"))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.instObj",
//                                                                                "Investment objective is required!", null));
//      }
//      if (ownerDetails.getOwnersFinancialDetails().getInvestmentObjectives() != null &&
//         ownerDetails.getOwnersFinancialDetails().getInvestmentObjectives().equalsIgnoreCase("Others") &&
//         !hasRequiredData(ownerDetails.getOwnersFinancialDetails().getInvestmentObjectiveSpecify()))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.instObjDtl",
//                                                                                "Other investment objective detail is required!", null));
//      }
//      if (!hasRequiredData(ownerDetails.getOwnersFinancialDetails().getNameOfOtherFinancialInstitution()))
//      {
//         dataOK = false;
//         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.namFinIst",
//                                                                                "Name of other financial institution is required!", null));
//      }

      if (!hasRequiredData(ownerDetails.getOwnersFinancialDetails().getAreYouUnableToPayYouDebts()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.debt",
                                                                                "Debt detail is required!", null));
      }
      if (ownerDetails.getOwnersFinancialDetails().getAreYouUnableToPayYouDebts() != null &&
         ownerDetails.getOwnersFinancialDetails().getAreYouUnableToPayYouDebts().equalsIgnoreCase("Yes") &&
         !hasRequiredData(ownerDetails.getOwnersFinancialDetails().getAreYouUnableToPayYouDebtsDescribe()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.debtDsc",
                                                                                "Debt specification is required!", null));
      }
      if (!hasRequiredData(ownerDetails.getOwnersFinancialDetails().getDoYouHaveAnyDisputedAccount()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.disp",
                                                                                "Disputed account detail is required!", null));
      }
      if (ownerDetails.getOwnersFinancialDetails().getDoYouHaveAnyDisputedAccount() != null &&
         ownerDetails.getOwnersFinancialDetails().getDoYouHaveAnyDisputedAccount().equalsIgnoreCase("Yes") &&
         !hasRequiredData(ownerDetails.getOwnersFinancialDetails().getDoYouHaveAnyDisputedAccountDescribe()))
      {
         dataOK = false;
         pagemanager.setErrorMessage(webutil.getMessageText().getDisplayMessage("validator.uob.new.pri.acctHldr.dispDsc",
                                                                                "Disputed account specification is required!", null));
      }
      return dataOK;
   }


   public Boolean hasRequiredData(String value)
   {

      if (value == null || value.isEmpty())
      {
         return false;
      }

      return true;
   }

   public Boolean hasData(String value)
   {

      if (value != null && !value.isEmpty())
      {
         return true;
      }

      return false;
   }

   public Boolean hasRequiredData(String element, String defValue)
   {

      if (element == null || element.isEmpty() || element.equalsIgnoreCase(defValue))
      {
         return false;
      }

      return true;
   }

   public String getErrorMessage(Integer pagenum)
   {
      return pagemanager.getErrorMessage(pagenum);
   }

   public Boolean isAccordianDisabled(Integer pageno)
   {
      if (pageno != null)
      {
         if (pageno > 0 && pageno < getPagemanager().getMaxNoofPages())
         {
            if (getPagemanager().getLastPageVisited() >= pageno)
            {
               return false;
            }
         }
      }
      return true;
   }

   private void resetActiveTab(Integer pagenum)
   {
      Integer nextTab = pageControl(pagenum);
      setActiveTab(nextTab);
   }

   private Integer pageControl(Integer pagenum)
   {
      Integer newTab;
      if (pagenum == null)
      {
         return 1;
      }
      switch (pagenum) // Note: The switch is based on pagenum
      {
         case 0:
            newTab = 0;
            break;
         case 1:
            newTab = 1;
            break;
         case 2:
            newTab = 2;
            break;
         case 3:
            newTab = 3;
            break;
         case 4:
            newTab = 4;
            break;
         case 5:
            newTab = 5;
            break;
         case 6:
            newTab = 6;
            break;
         case 7:
            newTab = 7;
            break;
         case 8 :
            newTab=8;
            break;
         case 9 :
            newTab=9;
            break;
         case 10 :
            newTab=10;
            break;
         default:
            newTab = null;
            break;
      }
      return newTab;
   }


   public void onTabChange(TabChangeEvent event)
   {
      try
      {

         if (event != null)
         {
            String tabname = event.getTab().getId();
            String tabnum = tabname.substring(3);
            Integer num = getWebutil().getConverter().getIntData(tabnum);
//            subtab = 0;
            switch (num)
            {
               case 0:
                  getPagemanager().setPage(0);
                  break;
               case 1:
                  getPagemanager().setPage(1);
                  break;
               case 2:
                  getPagemanager().setPage(2);
                  break;
               case 3:
                  getPagemanager().setPage(3);
                  break;
               case 4:
                  getPagemanager().setPage(4);
                  break;
               case 5:
                  getPagemanager().setPage(5);
                  break;
               case 6:
                  getPagemanager().setPage(6);
                  break;
               case 7:
                  getPagemanager().setPage(7);
                  break;
               case 8:
                  getPagemanager().setPage(8);
                  break;
               case 9:
                  getPagemanager().setPage(9);
                  break;
               default:
                  getPagemanager().setPage(0);

            }
            setActiveTab(getPagemanager().getPage());
         }

      }

      catch (Exception ex)
      {
         getPagemanager().setPage(0);
         //setActiveTab(0);

      }
   }

   public static Map<String, Object> getFieldNames(final Object obj, boolean publicOnly)
      throws IllegalArgumentException, IllegalAccessException
   {
      StringBuilder sb = new StringBuilder();
      Class<? extends Object> c1 = obj.getClass();
      Map<String, Object> lst = new HashMap<String, Object>();
      Field[] fields = c1.getDeclaredFields();
      for (int i = 0; i < fields.length; i++)
      {
         String name = fields[i].getName();
         if (publicOnly)
         {
            if (Modifier.isPublic(fields[i].getModifiers()))
            {
               Object value = fields[i].get(obj);
               lst.put(name, value);
            }
         }
         else
         {
            fields[i].setAccessible(true);
            Object value = fields[i].get(obj);
            lst.put(name, value);
         }
      }
      return lst;
   }

   public static String getAddtnlFldsInsrtQry(final Object obj, boolean publicOnly, String table, long acctnum, int acctOwnerId)
      throws IllegalArgumentException, IllegalAccessException
   {
      Class<? extends Object> c1 = obj.getClass();
      Field[] fields = c1.getDeclaredFields();
      StringBuilder sb = new StringBuilder();
      sb.append("insert into ").append(table).append("(acctnum,acctOwnerId,name,value) values ");
      for (int i = 0; i < fields.length; i++)
      {
         String name = fields[i].getName();
         if (publicOnly)
         {
            if (Modifier.isPublic(fields[i].getModifiers()))
            {
               Object value = fields[i].get(obj);
               if (value != null)
               {
                  sb.append("(" + acctnum).append(",").append(acctOwnerId).append(",'").append(name).append("','").append(value).append("'),");
               }
            }
         }
         else
         {
            fields[i].setAccessible(true);
            Object value = fields[i].get(obj);
            if (value != null)
            {
               sb.append("(" + acctnum).append(",").append(acctOwnerId).append(",'").append(name).append("','").append(value).append("'),");
            }
         }
      }
      String retString = sb.toString();
      int ind1 = retString.lastIndexOf(",");
      retString = retString.substring(0, ind1);
      retString = retString + ";";
      return retString;
   }

   public Boolean validateEmailPattern(String emailID)
   {

      final String EMAIL_PATTERN = "^[_A-Za-z0-9-]+(\\." +
         "[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*" +
         "(\\.[A-Za-z]{2,})$";

      Pattern pattern;
      Matcher matcher;
      pattern = Pattern.compile(EMAIL_PATTERN);
      Boolean msg = false;
      if ((emailID == null) || (emailID.trim().equals("")) ||
         (emailID.indexOf('.') == -1) ||
         (emailID.indexOf('@') == -1))
      {
         msg = true;
      }

      if (emailID != null)
      {
         matcher = pattern.matcher(emailID);
         if (!matcher.matches())
         {

            msg = true;
         }
      }
      return msg;
   }

   public static Boolean validateDataByPattern(String regex,String strToValid)
   {
      Pattern pattern;
      Matcher matcher;
      pattern = Pattern.compile(regex);
      Boolean msg = false;
      matcher = pattern.matcher(strToValid);
      if (!matcher.matches())
      {
         msg = true;
      }
      return msg;
   }

   public List<String> completeText(String query)
   {
      List<String> MySortStrings = new ArrayList<String>();
      if (query.length() > 2)
      {
         for (int i = 0; i < countries.size(); i++)
         {
            if (countries.get(i).toLowerCase().contains(query.toLowerCase()))
            {
               MySortStrings.add(countries.get(i));
            }
         }
      }
      return MySortStrings;
   }

   public List<String> getOtherCountries(String query)
   {
      List<String> MySortStrings = new ArrayList<String>();
      if (query.length() > 2)
      {
         for (int i = 0; i < countries.size(); i++)
         {
            if (countries.get(i).toLowerCase().contains(query.toLowerCase()) && !countries.get(i).equalsIgnoreCase("Singapore"))
            {
               MySortStrings.add(countries.get(i));
            }
         }
      }
      return MySortStrings;
   }

   public List<String> completeRepText(String query)
   {
      List<String> MySortStrings = new ArrayList<String>();
      if (query.length() > 2)
      {
         for (int i = 0; i < repList.size(); i++)
         {
            if (repList.get(i).toLowerCase().contains(query.toLowerCase()))
            {
               MySortStrings.add(repList.get(i));
            }
         }
      }
      return MySortStrings;
   }


   public void updTaxDtls(OwnerTaxationDetails ownerTaxationDetails)
   {
      try
      {
         System.out.println("updTaxDtls " + ownerTaxationDetails);
         owTaxDtls = ownerTaxationDetails;
         dsplPriHldrTaxTab = true;
         dsplPriHldrTaxDtl = true;
         onChngTin();
         onChngRsn();
         dispTaxAddBtn = false;
         dispTaxUpdBtn = true;
         disTaxBtn = true;
      }
      catch (Exception e)
      {

      }
   }

   public void delTaxDtls(OwnerTaxationDetails ownerTaxationDetails)
   {
      try
      {
         System.out.println("delTaxDtls " + ownerTaxationDetails);

         custodyService.deleteSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, "Taxation");
         List<OwnerTaxationDetails> lst = uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails();
         if (lst != null && lst.size() > 0)
         {
            lst.remove(ownerTaxationDetails.getId() - 1);
            for (int i = 0; i < lst.size(); i++)
            {
               OwnerTaxationDetails owTaxDtl = lst.get(i);
               if (hasRequiredData(owTaxDtl.getIsTINAvailable()))
               {
                  custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "isTINAvailable", owTaxDtl.getIsTINAvailable());
               }
               if (hasRequiredData(owTaxDtl.getJurisdictionOfTaxResidence()))
               {
                  custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "jurisdictionOfTaxResidence", owTaxDtl.getJurisdictionOfTaxResidence());
               }
               if (hasRequiredData(owTaxDtl.getTaxIdentificationNumber()))
               {
                  custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "taxIdentificationNumber", owTaxDtl.getTaxIdentificationNumber());
               }
               if (hasRequiredData(owTaxDtl.getTinUnavailableReason()))
               {
                  custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "tinUnavailableReason", owTaxDtl.getTinUnavailableReason());
               }
               if (hasRequiredData(owTaxDtl.getTinUnavailableValue()))
               {
                  custodyService.saveSetMiscDtls(uobDataMaster.getAccountDetails().getAcctnum(), 1, i + 1, "Taxation", "tinUnavailableValue", owTaxDtl.getTinUnavailableValue());
               }
            }
         }

//         dsplPriHldrTaxTab = true;
//         dsplPriHldrTaxDtl = false;
         owTaxDtls = new OwnerTaxationDetails();
         dsplPriHldrTaxTin = false;

         if (uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails() != null &&
            uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails().size() > 0)
         {
            dsplPriHldrTaxTab = true;
            dsplPriHldrTaxDtl = false;
            disTaxBtn = false;
         }
         else if (uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails() == null ||
            uobDataMaster.getIndividualOwnersDetails().getOwnerTaxationDetails().size() == 0)
         {
            dsplPriHldrTaxDtl = true;
            dsplPriHldrTaxTab = false;
         }
      }
      catch (Exception e)
      {
      }
   }

   public void submitDataForm()
   {
      dspDocUpdPnl = true;
      dspNewAcctPnl = false;
      dspExtAcctPnl = false;
      dspIntroAcctPnl = false;
      dwnFileMstrLst = custodyService.fetchFileMasterList(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(), beanAcctNum, getReqType(), "Download");
      if(dwnFileMstrLst!=null && dwnFileMstrLst.size()>0){
         dsplDwnlFile = true;
         getFileData();
      }
      updFileMstrLst = custodyService.fetchFileMasterList(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(), beanAcctNum,getReqType(),"Upload");

      fileupdSucc=new HashMap<String,String>();
      if(updFileLst!=null && updFileLst.size()>0){
         for(int i=0;i<updFileLst.size();i++){

            fileupdSucc.put(updFileLst.get(i).getReqType(), updFileLst.get(i).getReqType());
         }
      }

      if(getWebutil().hasRole("Test") || updFileLst.size()==updFileMstrLst.size()){
         dsblUpdSubmtBtn=false;
      }else{
         dsblUpdSubmtBtn=true;
      }
   }

   public void  submitUploadFrm(){
      if(dwnFileMstrLst!=null && dwnFileMstrLst.size()>0){
         if(dwnlDsclFlag && dwnlGudFlag && dwnlMstrTrdAggrFlag){
            genCustodyDocRequest();
         }else
         {
            dsplDwnlFile = true;
         }
      }else{
         genCustodyDocRequest();
      }
   }

   public void onChngAccept(){
      if(dwnlDsclFlag && dwnlGudFlag && dwnlMstrTrdAggrFlag){
         dsblAcptBtn=false;
      }else{
         dsblAcptBtn=true;
      }
   }

   public void onChngAccept1(){
      if(dwnlDsclFlag && dwnlGudFlag && dwnlMstrTrdAggrFlag){
         dsblAcptBtn=false;
      }else{
         dsblAcptBtn=true;
      }
   }

   public void  submitAccceptFrm(){
      if(dwnlDsclFlag && dwnlGudFlag && dwnlMstrTrdAggrFlag){
         genCustodyDocRequest();
      }
   }
   public void closeAcptFrm(){
      dsplDwnlFile=false;
   }

   public void genCustodyDocRequest(){

      String eventRef = custodyService.saveCustodyDocReq(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(),
                                                         beanAcctNum,custodyService.getDefaultAdvisor(),getReqType());

      WSCallResult wsCallResult;
      System.out.println("Custody Doc Request Return " + eventRef);
      if (eventRef != null)
      {
         String eventDtl[] = eventRef.split(",");
         int reqId=Integer.parseInt(eventDtl[0]);
         int eventNum=Integer.parseInt(eventDtl[1]);
//         for (int i = 0; i < eventNo.length; i++)
//         {
//            int eventnum = Integer.parseInt(eventNo[i]);
         System.out.println("Custody event No " + eventNum);
         System.out.println("Custody req Id " + reqId);
         try
         {
            String msg;
            wsCallResult = aoWebLayer.processAORequest(new ServiceRequest(getWebutil().getWebprofile().getInfo("SERVICE.PRODUCT").toString(),
                                                                          getWebutil().getWebprofile().getMode("SERVICE.DOCUMENT.MODE").toString()),
                                                       beanAcctNum, eventNum, updFileLst);
            System.out.println("Custody wsCallResult " + wsCallResult);
            if (wsCallResult.getWSCallStatus().getErrorCode() != 1)
            {
               msg = wsCallResult.getWSCallStatus().getErrorMessage();
               getWebutil().redirecttoMessagePage("ERROR", "Failed to Save", msg);
            }
            else
            {
//               msg = wsCallResult.getWSCallStatus().getErrorMessage();
//               getWebutil().redirecttoMessagePage("SUCCESS", "Document generated successfully", "Success");
//               sendAlertMessage("P");
               custodyService.mangeUserProfile(beanAcctNum,"P",getBeanLogonId());
               getUiLayout().doMenuAction("custody", "custodyConfirmation.xhtml");

//               msg = wsCallResult.getWSCallStatus().getErrorMessage();
//               getWebutil().redirecttoMessagePage("ERROR", "Failed to Save", msg);
            }
         }
         catch (Exception e)
         {
            e.printStackTrace();
         }
      }
      else
      {
         getWebutil().redirecttoMessagePage("ERROR", "Failed to Save", "Error occurred while document request generation");
      }
   }

   public void prevDataForm()
   {
      dspDocUpdPnl = false;
      if (uobDataMaster.getAccountDetails().getAccountMiscDetails().getIsExistingIndividualAcct().equalsIgnoreCase("yes"))
      {
         dspExtAcctPnl = true;
         dspNewAcctPnl = false;
      }
      else
      {
         dspExtAcctPnl = false;
         dspNewAcctPnl = true;
      }
      dspIntroAcctPnl = false;

         updFileMstrLst = custodyService.fetchFileMasterList(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(), beanAcctNum, getReqType(), "Upload");

      Boolean status = validateAllPage();
      if(status){
         dsblSubmtBtn=false;
      }else{
         dsblSubmtBtn=true;
      }
      Integer currentPage = getPagemanager().getPage();
      getPagemanager().initPage();
      resetActiveTab(0);
      getPagemanager().setLastPageVisited(currentPage);
      getPagemanager().clearAllErrorMessage();
      saveandOpenError = null;
   }

   public void handleFileUpload(FileUploadEvent event)
   {
      try
      {
         System.out.println("File NAme " + event.getFile().getFileName());
         InputStream is = null;
         is = event.getFile().getInputstream();
         String updFileTyp = (String) event.getComponent().getAttributes().get("updFileTyp");
         int updFileSqNo = (Integer) event.getComponent().getAttributes().get("updFileSqNo");
         String tempFileName= event.getFile().getFileName();
         String fileArray[]=tempFileName.split("\\.");

         String fileName=getBeanAcctNum() + "_" + updFileTyp+"."+fileArray[1];
         File targetFile = new File(cstdyUpdPath + "" +fileName);
         OutputStream outStream = new FileOutputStream(targetFile);
         byte[] buffer = new byte[8 * 1024];
         int bytesRead;

         while ((bytesRead = is.read(buffer)) != -1)
         {
            outStream.write(buffer, 0, bytesRead);
         }
         outStream.close();
         fileupdSucc.put(updFileTyp, updFileTyp);
         CustodyFileRequest objCustodyFileRequest=new CustodyFileRequest();
         boolean bflag=true;
         if(updFileLst!=null && updFileLst.size()>0){
            for(int i=0;i<updFileLst.size();i++){
               if(updFileLst.get(i).getReqType().equalsIgnoreCase(updFileTyp)){
                  objCustodyFileRequest=updFileLst.get(i);
                  File file = new File(objCustodyFileRequest.getFilePath()+""+objCustodyFileRequest.getFileName());
                  file.delete();
                  objCustodyFileRequest.setFilePath(cstdyUpdPath);
                  objCustodyFileRequest.setSeqno(updFileSqNo);
                  objCustodyFileRequest.setFileName(fileName);
                  bflag=false;
                  break;
               }
            }
         }else{
            bflag=true;
         }
         if(bflag){
            objCustodyFileRequest.setAcctnum(beanAcctNum);
            objCustodyFileRequest.setAction(getReqType());
            objCustodyFileRequest.setRequestFor("Upload");
            objCustodyFileRequest.setFileName(fileName);
            objCustodyFileRequest.setFilePath(cstdyUpdPath);
            objCustodyFileRequest.setReqType(updFileTyp);
            objCustodyFileRequest.setSeqno(updFileSqNo);
         }
         custodyService.saveCustodyFiles(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(), beanAcctNum,
                                         ""+getBeanLogonId(),objCustodyFileRequest);
         updFileLst=custodyService.fetchUploadedFiles(getWebutil().getWebprofile().getWebInfo().get("SERVICE.PRODUCT").toString(), beanAcctNum,getReqType());
         System.out.println("File Write [" + updFileTyp+ "]");


         if (updFileMstrLst.size() == fileupdSucc.size())
         {
            dsblUpdSubmtBtn = false;
         }
      }
      catch (Exception e)
      {
         System.out.println("Exception " + e);
      }
   }

   public boolean isFileUpd(String fileType)
   {
      if (!fileupdSucc.isEmpty() && fileupdSucc.containsKey(fileType))
      {
         return true;
      }
      return false;
   }

   public int calculateAge(Date birthDate)
   {
      int years = 0;
      int months = 0;
      int days = 0;
      //create calendar object for birth day
      Calendar birthDay = Calendar.getInstance();
      birthDay.setTimeInMillis(birthDate.getTime());
      //create calendar object for current day
      long currentTime = System.currentTimeMillis();
      Calendar now = Calendar.getInstance();
      now.setTimeInMillis(currentTime);
      //Get difference between years
      years = now.get(Calendar.YEAR) - birthDay.get(Calendar.YEAR);
      int currMonth = now.get(Calendar.MONTH) + 1;
      int birthMonth = birthDay.get(Calendar.MONTH) + 1;
      //Get difference between months
      months = currMonth - birthMonth;
      //if month difference is in negative then reduce years by one and calculate the number of months.
      if (months < 0)
      {
         years--;
         months = 12 - birthMonth + currMonth;
         if (now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
            months--;
      } else if (months == 0 && now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
      {
         years--;
         months = 11;
      }
//      Calculate the days
      if (now.get(Calendar.DATE) > birthDay.get(Calendar.DATE))
         days = now.get(Calendar.DATE) - birthDay.get(Calendar.DATE);
      else if (now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
      {
         int today = now.get(Calendar.DAY_OF_MONTH);
         now.add(Calendar.MONTH, -1);
         days = now.getActualMaximum(Calendar.DAY_OF_MONTH) - birthDay.get(Calendar.DAY_OF_MONTH) + today;
      } else
      {
         days = 0;
         if (months == 12)
         {
            years++;
            months = 0;
         }
      }
      return years;
   }

   public boolean validateCstmCond(OwnerDetails ownerDetails, Date dob){
      if(dob !=null && calculateAge(dob)>62 &&
         ownerDetails.getOwnerMiscDetails().getQualifications()!=null && ownerDetails.getOwnerMiscDetails().getQualifications().equalsIgnoreCase("Primary") &&
         ownerDetails.getOwnerEmploymentDetails().getEmplTypeId()!=null && ownerDetails.getOwnerEmploymentDetails().getEmplTypeId().equalsIgnoreCase("Unemployed") &&
         ownerDetails.getOwnerMiscDetails().getReasonForUnemployment()!=null && ownerDetails.getOwnerMiscDetails().getReasonForUnemployment().equalsIgnoreCase("Retired") ){
         return true;
      }
      return false;
   }

   public WebUtil getWebutil()
   {
      return webutil;
   }

   public void setWebutil(WebUtil webutil)
   {
      this.webutil = webutil;
   }

   public long getBeanAcctNum()
   {
      return beanAcctNum;
   }

   public void setBeanAcctNum(long beanAcctNum)
   {
      this.beanAcctNum = beanAcctNum;
   }

   public CustodyService getCustodyService()
   {
      return custodyService;
   }

   public void setCustodyService(CustodyService custodyService)
   {
      this.custodyService = custodyService;
   }

//   public boolean isDsplExtIndAcctCat()
//   {
//      return dsplExtIndAcctCat;
//   }
//
//   public void setDsplExtIndAcctCat(boolean dsplExtIndAcctCat)
//   {
//      this.dsplExtIndAcctCat = dsplExtIndAcctCat;
//   }

//   public boolean isDsplExtJntAcctCat()
//   {
//      return dsplExtJntAcctCat;
//   }
//
//   public void setDsplExtJntAcctCat(boolean dsplExtJntAcctCat)
//   {
//      this.dsplExtJntAcctCat = dsplExtJntAcctCat;
//   }

//   public String getAcctCat()
//   {
//      return acctCat;
//   }
//
//   public void setAcctCat(String acctCat)
//   {
//      this.acctCat = acctCat;
//   }

   public boolean isDsplAcctTyp()
   {
      return dsplAcctTyp;
   }

   public void setDsplAcctTyp(boolean dsplAcctTyp)
   {
      this.dsplAcctTyp = dsplAcctTyp;
   }

   public String getExtAcctJnt()
   {
      return extAcctJnt;
   }

   public void setExtAcctJnt(String extAcctJnt)
   {
      this.extAcctJnt = extAcctJnt;
   }

   public boolean isDsplExtIndAcctInp()
   {
      return dsplExtIndAcctInp;
   }

   public void setDsplExtIndAcctInp(boolean dsplExtIndAcctInp)
   {
      this.dsplExtIndAcctInp = dsplExtIndAcctInp;
   }

   public boolean isDsplExtJntAcctInp()
   {
      return dsplExtJntAcctInp;
   }

   public void setDsplExtJntAcctInp(boolean dsplExtJntAcctInp)
   {
      this.dsplExtJntAcctInp = dsplExtJntAcctInp;
   }

   public String getClientAcctId()
   {
      return clientAcctId;
   }

   public void setClientAcctId(String clientAcctId)
   {
      this.clientAcctId = clientAcctId;
   }

   public String getSlsPrsnNm()
   {
      return slsPrsnNm;
   }

   public void setSlsPrsnNm(String slsPrsnNm)
   {
      this.slsPrsnNm = slsPrsnNm;
   }

   public String getSelIndAcctTyp()
   {
      return selIndAcctTyp;
   }

   public void setSelIndAcctTyp(String selIndAcctTyp)
   {
      this.selIndAcctTyp = selIndAcctTyp;
   }

   public String getSelJntAcctTyp()
   {
      return selJntAcctTyp;
   }

   public void setSelJntAcctTyp(String selJntAcctTyp)
   {
      this.selJntAcctTyp = selJntAcctTyp;
   }

   public PagesImpl getPagemanager()
   {
      return pagemanager;
   }

   public void setPagemanager(PagesImpl pagemanager)
   {
      this.pagemanager = pagemanager;
   }

   public boolean isDspExtAcctPnl()
   {
      return dspExtAcctPnl;
   }

   public void setDspExtAcctPnl(boolean dspExtAcctPnl)
   {
      this.dspExtAcctPnl = dspExtAcctPnl;
   }

   public boolean isDspNewAcctPnl()
   {
      return dspNewAcctPnl;
   }

   public void setDspNewAcctPnl(boolean dspNewAcctPnl)
   {
      this.dspNewAcctPnl = dspNewAcctPnl;
   }

   public boolean isDspIntroAcctPnl()
   {
      return dspIntroAcctPnl;
   }

   public void setDspIntroAcctPnl(boolean dspIntroAcctPnl)
   {
      this.dspIntroAcctPnl = dspIntroAcctPnl;
   }

   public boolean isDsblSubmtBtn()
   {
      return dsblSubmtBtn;
   }

   public void setDsblSubmtBtn(boolean dsblSubmtBtn)
   {
      this.dsblSubmtBtn = dsblSubmtBtn;
   }

   public boolean isDspJntTab()
   {
      return dspJntTab;
   }

   public void setDspJntTab(boolean dspJntTab)
   {
      this.dspJntTab = dspJntTab;
   }

   public Integer getActiveTab()
   {
      return activeTab;
   }

   public void setActiveTab(Integer activeTab)
   {
      this.activeTab = activeTab;
   }

   public UOBDataMaster getUobDataMaster()
   {
      return uobDataMaster;
   }

   public void setUobDataMaster(UOBDataMaster uobDataMaster)
   {
      this.uobDataMaster = uobDataMaster;
   }

   public boolean isDsplNricInp()
   {
      return dsplNricInp;
   }

   public void setDsplNricInp(boolean dsplNricInp)
   {
      this.dsplNricInp = dsplNricInp;
   }

   public boolean isDsplOtrCntry()
   {
      return dsplOtrCntry;
   }

   public void setDsplOtrCntry(boolean dsplOtrCntry)
   {
      this.dsplOtrCntry = dsplOtrCntry;
   }

   public boolean isDsplIcNoInp()
   {
      return dsplIcNoInp;
   }

   public void setDsplIcNoInp(boolean dsplIcNoInp)
   {
      this.dsplIcNoInp = dsplIcNoInp;
   }

   public boolean isDsplPspNoInp()
   {
      return dsplPspNoInp;
   }

   public void setDsplPspNoInp(boolean dsplPspNoInp)
   {
      this.dsplPspNoInp = dsplPspNoInp;
   }

   public Date getDtPriHldrDob()
   {
      return dtPriHldrDob;
   }

   public void setDtPriHldrDob(Date dtPriHldrDob)
   {
      this.dtPriHldrDob = dtPriHldrDob;
   }

   public String getIntroError()
   {
      return introError;
   }

   public void setIntroError(String introError)
   {
      this.introError = introError;
   }

   public boolean isDsplSrcIncOtrs()
   {
      return dsplSrcIncOtrs;
   }

   public void setDsplSrcIncOtrs(boolean dsplSrcIncOtrs)
   {
      this.dsplSrcIncOtrs = dsplSrcIncOtrs;
   }

   public boolean isDsplNwPriRelDtl()
   {
      return dsplNwPriRelDtl;
   }

   public void setDsplNwPriRelDtl(boolean dsplNwPriRelDtl)
   {
      this.dsplNwPriRelDtl = dsplNwPriRelDtl;
   }

   public boolean isDsplNwPriInfDtl()
   {
      return dsplNwPriInfDtl;
   }

   public void setDsplNwPriInfDtl(boolean dsplNwPriInfDtl)
   {
      this.dsplNwPriInfDtl = dsplNwPriInfDtl;
   }

   public boolean isDsplNwPriCtrlDtl()
   {
      return dsplNwPriCtrlDtl;
   }

   public void setDsplNwPriCtrlDtl(boolean dsplNwPriCtrlDtl)
   {
      this.dsplNwPriCtrlDtl = dsplNwPriCtrlDtl;
   }

   public String getPriHldrEmpAddr()
   {
      return priHldrEmpAddr;
   }

   public void setPriHldrEmpAddr(String priHldrEmpAddr)
   {
      this.priHldrEmpAddr = priHldrEmpAddr;
   }

   public boolean isDsplNwPriEmpMnPnl()
   {
      return dsplNwPriEmpMnPnl;
   }

   public void setDsplNwPriEmpMnPnl(boolean dsplNwPriEmpMnPnl)
   {
      this.dsplNwPriEmpMnPnl = dsplNwPriEmpMnPnl;
   }

   public boolean isDsplNwPriEmpOtrDtlPnl()
   {
      return dsplNwPriEmpOtrDtlPnl;
   }

   public void setDsplNwPriEmpOtrDtlPnl(boolean dsplNwPriEmpOtrDtlPnl)
   {
      this.dsplNwPriEmpOtrDtlPnl = dsplNwPriEmpOtrDtlPnl;
   }

   public String getPriHldrPhyAddr()
   {
      return priHldrPhyAddr;
   }

   public void setPriHldrPhyAddr(String priHldrPhyAddr)
   {
      this.priHldrPhyAddr = priHldrPhyAddr;
   }

   public String getPriHldrMlAddr()
   {
      return priHldrMlAddr;
   }

   public void setPriHldrMlAddr(String priHldrMlAddr)
   {
      this.priHldrMlAddr = priHldrMlAddr;
   }

   public boolean isDsplPriHldrMlPnl()
   {
      return dsplPriHldrMlPnl;
   }

   public void setDsplPriHldrMlPnl(boolean dsplPriHldrMlPnl)
   {
      this.dsplPriHldrMlPnl = dsplPriHldrMlPnl;
   }

   public boolean isDsplPriHldrObjPnl1()
   {
      return dsplPriHldrObjPnl1;
   }

   public void setDsplPriHldrObjPnl1(boolean dsplPriHldrObjPnl1)
   {
      this.dsplPriHldrObjPnl1 = dsplPriHldrObjPnl1;
   }

   public boolean isDsplPriHldrObjPnl2()
   {
      return dsplPriHldrObjPnl2;
   }

   public void setDsplPriHldrObjPnl2(boolean dsplPriHldrObjPnl2)
   {
      this.dsplPriHldrObjPnl2 = dsplPriHldrObjPnl2;
   }

   public boolean isDsplPriHldrObjPnl3()
   {
      return dsplPriHldrObjPnl3;
   }

   public void setDsplPriHldrObjPnl3(boolean dsplPriHldrObjPnl3)
   {
      this.dsplPriHldrObjPnl3 = dsplPriHldrObjPnl3;
   }

   public boolean isDsplPriHldrObjPnl4()
   {
      return dsplPriHldrObjPnl4;
   }

   public void setDsplPriHldrObjPnl4(boolean dsplPriHldrObjPnl4)
   {
      this.dsplPriHldrObjPnl4 = dsplPriHldrObjPnl4;
   }

   public OwnerTaxationDetails getOwTaxDtls()
   {
      return owTaxDtls;
   }

   public void setOwTaxDtls(OwnerTaxationDetails owTaxDtls)
   {
      this.owTaxDtls = owTaxDtls;
   }

   public boolean isDsplPriHldrTaxTab()
   {
      return dsplPriHldrTaxTab;
   }

   public void setDsplPriHldrTaxTab(boolean dsplPriHldrTaxTab)
   {
      this.dsplPriHldrTaxTab = dsplPriHldrTaxTab;
   }

   public boolean isDsplPriHldrTaxDtl()
   {
      return dsplPriHldrTaxDtl;
   }

   public void setDsplPriHldrTaxDtl(boolean dsplPriHldrTaxDtl)
   {
      this.dsplPriHldrTaxDtl = dsplPriHldrTaxDtl;
   }

   public boolean isDsplPriHldrTaxRsn()
   {
      return dsplPriHldrTaxRsn;
   }

   public void setDsplPriHldrTaxRsn(boolean dsplPriHldrTaxRsn)
   {
      this.dsplPriHldrTaxRsn = dsplPriHldrTaxRsn;
   }

   public boolean isDsplPriHldrTaxTin()
   {
      return dsplPriHldrTaxTin;
   }

   public void setDsplPriHldrTaxTin(boolean dsplPriHldrTaxTin)
   {
      this.dsplPriHldrTaxTin = dsplPriHldrTaxTin;
   }

   public boolean isDsplPriHldrTaxRsnPnl()
   {
      return dsplPriHldrTaxRsnPnl;
   }

   public void setDsplPriHldrTaxRsnPnl(boolean dsplPriHldrTaxRsnPnl)
   {
      this.dsplPriHldrTaxRsnPnl = dsplPriHldrTaxRsnPnl;
   }

   public String getTaxError()
   {
      return taxError;
   }

   public void setTaxError(String taxError)
   {
      this.taxError = taxError;
   }

   public Map<String, Country> getCountryDetails()
   {
      return countryDetails;
   }

   public void setCountryDetails(Map<String, Country> countryDetails)
   {
      this.countryDetails = countryDetails;
   }

   public List<String> getCountries()
   {
      return countries;
   }

   public void setCountries(List<String> countries)
   {
      this.countries = countries;
   }

   public boolean isDsplSingNricInp()
   {
      return dsplSingNricInp;
   }

   public void setDsplSingNricInp(boolean dsplSingNricInp)
   {
      this.dsplSingNricInp = dsplSingNricInp;
   }

   public boolean isDisTaxBtn()
   {
      return disTaxBtn;
   }

   public void setDisTaxBtn(boolean disTaxBtn)
   {
      this.disTaxBtn = disTaxBtn;
   }

   public boolean isDispTaxAddBtn()
   {
      return dispTaxAddBtn;
   }

   public void setDispTaxAddBtn(boolean dispTaxAddBtn)
   {
      this.dispTaxAddBtn = dispTaxAddBtn;
   }

   public boolean isDispTaxUpdBtn()
   {
      return dispTaxUpdBtn;
   }

   public void setDispTaxUpdBtn(boolean dispTaxUpdBtn)
   {
      this.dispTaxUpdBtn = dispTaxUpdBtn;
   }

   public List<String> getRepList()
   {
      return repList;
   }

   public void setRepList(List<String> repList)
   {
      this.repList = repList;
   }

   public Map<String, String> getRepMap()
   {
      return repMap;
   }

   public void setRepMap(Map<String, String> repMap)
   {
      this.repMap = repMap;
   }

   public boolean isDspDocUpdPnl()
   {
      return dspDocUpdPnl;
   }

   public void setDspDocUpdPnl(boolean dspDocUpdPnl)
   {
      this.dspDocUpdPnl = dspDocUpdPnl;
   }

   public List<CustodyFileDetails> getUpdFileMstrLst()
   {
      return updFileMstrLst;
   }

   public void setUpdFileMstrLst(List<CustodyFileDetails> updFileMstrLst)
   {
      this.updFileMstrLst = updFileMstrLst;
   }

   public long getBeanLogonId()
   {
      return beanLogonId;
   }

   public void setBeanLogonId(long beanLogonId)
   {
      this.beanLogonId = beanLogonId;
   }

   public ConsumerListDataDAO getListDAO()
   {
      return listDAO;
   }

   public void setListDAO(ConsumerListDataDAO listDAO)
   {
      this.listDAO = listDAO;
   }

   public String getCstdyUpdPath()
   {
      return cstdyUpdPath;
   }

   public void setCstdyUpdPath(String cstdyUpdPath)
   {
      this.cstdyUpdPath = cstdyUpdPath;
   }

   public Map<String, String> getFileupdSucc()
   {
      return fileupdSucc;
   }

   public void setFileupdSucc(Map<String, String> fileupdSucc)
   {
      this.fileupdSucc = fileupdSucc;
   }

   public boolean isDsblUpdSubmtBtn()
   {
      return dsblUpdSubmtBtn;
   }

   public void setDsblUpdSubmtBtn(boolean dsblUpdSubmtBtn)
   {
      this.dsblUpdSubmtBtn = dsblUpdSubmtBtn;
   }

   public String getCurrentAcctHolder()
   {
      return currentAcctHolder;
   }

   public void setCurrentAcctHolder(String currentAcctHolder)
   {
      this.currentAcctHolder = currentAcctHolder;
   }

   public String getBeanAccount()
   {
      return beanAccount;
   }

   public void setBeanAccount(String beanAccount)
   {
      this.beanAccount = beanAccount;
   }

   public List<CustodyFileRequest> getUpdFileLst()
   {
      return updFileLst;
   }

   public void setUpdFileLst(List<CustodyFileRequest> updFileLst)
   {
      this.updFileLst = updFileLst;
   }

   public String getReqType()
   {
      return reqType;
   }

   public void setReqType(String reqType)
   {
      this.reqType = reqType;
   }

   public AOWebLayer getAoWebLayer()
   {
      return aoWebLayer;
   }

   public void setAoWebLayer(AOWebLayer aoWebLayer)
   {
      this.aoWebLayer = aoWebLayer;
   }

   public String getPriHldrBnkAddr()
   {
      return priHldrBnkAddr;
   }

   public void setPriHldrBnkAddr(String priHldrBnkAddr)
   {
      this.priHldrBnkAddr = priHldrBnkAddr;
   }

   public boolean isDsplNwPriUnEmpRsnPnl()
   {
      return dsplNwPriUnEmpRsnPnl;
   }

   public void setDsplNwPriUnEmpRsnPnl(boolean dsplNwPriUnEmpRsnPnl)
   {
      this.dsplNwPriUnEmpRsnPnl = dsplNwPriUnEmpRsnPnl;
   }

   public boolean isDsplExtIndAcctQue()
   {
      return dsplExtIndAcctQue;
   }

   public void setDsplExtIndAcctQue(boolean dsplExtIndAcctQue)
   {
      this.dsplExtIndAcctQue = dsplExtIndAcctQue;
   }

   public boolean isDsplExtJntAcctQue()
   {
      return dsplExtJntAcctQue;
   }

   public void setDsplExtJntAcctQue(boolean dsplExtJntAcctQue)
   {
      this.dsplExtJntAcctQue = dsplExtJntAcctQue;
   }

   public boolean isDsblRepList()
   {
      return dsblRepList;
   }

   public void setDsblRepList(boolean dsblRepList)
   {
      this.dsblRepList = dsblRepList;
   }

   public String getHasRepDtlY()
   {
      return hasRepDtlY;
   }

   public void setHasRepDtlY(String hasRepDtlY)
   {
      this.hasRepDtlY = hasRepDtlY;
   }

   public String getHasRepDtlN()
   {
      return hasRepDtlN;
   }

   public void setHasRepDtlN(String hasRepDtlN)
   {
      this.hasRepDtlN = hasRepDtlN;
   }

   public boolean isConsentCallFlag()
   {
      return consentCallFlag;
   }

   public void setConsentCallFlag(boolean consentCallFlag)
   {
      this.consentCallFlag = consentCallFlag;
   }

   public boolean isConsentMsgFlag()
   {
      return consentMsgFlag;
   }

   public void setConsentMsgFlag(boolean consentMsgFlag)
   {
      this.consentMsgFlag = consentMsgFlag;
   }

   public List<CustodyFileDetails> getDwnFileMstrLst()
   {
      return dwnFileMstrLst;
   }

   public void setDwnFileMstrLst(List<CustodyFileDetails> dwnFileMstrLst)
   {
      this.dwnFileMstrLst = dwnFileMstrLst;
   }

   public String getCstdyDwnPath()
   {
      return cstdyDwnPath;
   }

   public void setCstdyDwnPath(String cstdyDwnPath)
   {
      this.cstdyDwnPath = cstdyDwnPath;
   }

   public boolean isDsplDwnlFile()
   {
      return dsplDwnlFile;
   }

   public void setDsplDwnlFile(boolean dsplDwnlFile)
   {
      this.dsplDwnlFile = dsplDwnlFile;
   }

   public boolean isDwnlDsclFlag()
   {
      return dwnlDsclFlag;
   }

   public void setDwnlDsclFlag(boolean dwnlDsclFlag)
   {
      this.dwnlDsclFlag = dwnlDsclFlag;
   }

   public boolean isDwnlGudFlag()
   {
      return dwnlGudFlag;
   }

   public void setDwnlGudFlag(boolean dwnlGudFlag)
   {
      this.dwnlGudFlag = dwnlGudFlag;
   }

   public boolean isDsblAcptBtn()
   {
      return dsblAcptBtn;
   }

   public void setDsblAcptBtn(boolean dsblAcptBtn)
   {
      this.dsblAcptBtn = dsblAcptBtn;
   }

   public boolean isDwnlMstrTrdAggrFlag()
   {
      return dwnlMstrTrdAggrFlag;
   }

   public void setDwnlMstrTrdAggrFlag(boolean dwnlMstrTrdAggrFlag)
   {
      this.dwnlMstrTrdAggrFlag = dwnlMstrTrdAggrFlag;
   }

   public StreamedContent getContentMstrTrdAggr()
   {
      return contentMstrTrdAggr;
   }

   public void setContentMstrTrdAggr(StreamedContent contentMstrTrdAggr)
   {
      this.contentMstrTrdAggr = contentMstrTrdAggr;
   }
}