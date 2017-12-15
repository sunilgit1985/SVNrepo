package com.invessence.custody.dao;

import java.sql.SQLException;
import java.util.List;

import com.docusign.esign.model.EnvelopeSummary;
import com.invessence.custody.data.AORequest;
import com.invessence.ws.provider.td.bean.*;

/**
 * Created by abhangp on 8/17/2016.
 */
public interface CustodyDaoLayer
{
   public List<AORequest> getAORequests(Long acctNum, Integer eventNum)throws SQLException;
}
