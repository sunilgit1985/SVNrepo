package com.invessence.custody.dao;

import java.sql.SQLException;
import java.util.List;

import com.docusign.esign.model.EnvelopeSummary;
import com.invessence.custody.data.*;
import com.invessence.custody.uob.data.CustodyFileRequest;
import com.invessence.ws.provider.td.bean.*;

/**
 * Created by abhangp on 8/17/2016.
 */
public interface CustodyDaoLayer
{
   public List<CustodyFileRequest> fetchUploadedFiles(String Product, Long acctNum, String action);
   public List<AORequest> getAORequests(Long acctNum, Integer eventNum)throws SQLException;
   public boolean callDCAuditSP(AORequestAudit aoRequest);
}
