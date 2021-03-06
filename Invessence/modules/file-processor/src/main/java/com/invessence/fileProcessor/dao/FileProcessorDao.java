package com.invessence.fileProcessor.dao;

import java.sql.SQLException;
import java.util.*;

import com.invessence.fileProcessor.bean.*;
import com.invessence.service.bean.*;
import com.invessence.service.bean.docuSign.*;

/**
 * Created by abhangp on 1/19/2016.
 */
public interface FileProcessorDao
{
//   public Object getCommonDetails(String product, String service, String type, String infoType) throws SQLException;;
   public Object dbCall(String product, String service, String type, String procedureName) throws SQLException;
   public Object dbCallAudit(FileProcessAudit fileProcessAudit) throws SQLException;
   public Map<String, DBParameters> getDBParametres()  throws SQLException;

   public boolean insertBatch(final List<String[]> dataArrLst, String sql, String proc) throws SQLException;
   public boolean insertBatch(final List<List<String>> dataArrLst, String sql, String proc, String str) throws SQLException;

   public void truncateTable(String tableName) throws SQLException;
   public void callProcedure(String proc) throws SQLException;

//Added to skip file procesing if Processing File is not available because of previous day holiday.
   public boolean isBussdtHoliday(String country ,String businessdt) throws SQLException;
}
