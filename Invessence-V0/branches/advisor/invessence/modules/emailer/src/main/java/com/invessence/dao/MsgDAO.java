package com.invessence.dao;

import java.sql.*;
import java.util.List;

import com.invessence.data.MsgData;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.simple.*;

public class MsgDAO extends SimpleJdbcDaoSupport
{
   public List<MsgData> getMsgList(int status) throws DataAccessException
   {

      String sql = "select source, messageid, sender, receiver, cc, bcc, subject, msg, status, " +
         "category, priority, created, lastupdated, sentdate " +
         "from vw_email_alerts " +
         "order by created";


      ParameterizedRowMapper<MsgData> mapper = new ParameterizedRowMapper<MsgData>()
      {
         public MsgData mapRow(ResultSet rs, int rowNum) throws SQLException
         {

            MsgData data = new MsgData();
            data.setSource(rs.getString("source"));
            data.setMsgID(rs.getInt("messageid"));
            data.setSender(rs.getString("sender"));
            data.setReceiver(rs.getString("receiver"));
            data.setCc(rs.getString("cc"));
            data.setBcc(rs.getString("bcc"));
            data.setSubject(rs.getString("subject"));
            data.setMsg(rs.getString("msg"));
            data.setStatus(rs.getInt("status"));
            data.setCategory(rs.getInt("category"));
            data.setPriority(rs.getInt("priority"));
            data.setEnteredDate(rs.getString("created"));
            data.setUpdatedDate(rs.getString("lastupdated"));
            data.setSentDate(rs.getString("sentdate"));

            return data;
         }
      };

      // System.out.println(sql);

      return getSimpleJdbcTemplate().query(sql, mapper);

   }


   public List<MsgData> getEmailMsgList() throws DataAccessException
   {

      String sql = "select messageid, sender, receiver, cc, bcc, subject, msg, status, " +
         "category, priority, created, lastupdated, " +
         "sentdate from email_messages  " +
         "order by created limit 0, 10";

      ParameterizedRowMapper<MsgData> mapper = new ParameterizedRowMapper<MsgData>()
      {
         public MsgData mapRow(ResultSet rs, int rowNum) throws SQLException
         {

            MsgData data = new MsgData();
            data.setSource("User");
            data.setMsgID(rs.getInt("messageid"));
            data.setSender(rs.getString("sender"));
            data.setReceiver(rs.getString("receiver"));
            data.setCc(rs.getString("cc"));
            data.setBcc(rs.getString("bcc"));
            data.setSubject(rs.getString("subject"));
            data.setMsg(rs.getString("msg"));
            data.setStatus(rs.getInt("status"));
            data.setCategory(rs.getInt("category"));
            data.setPriority(rs.getInt("priority"));
            data.setEnteredDate(rs.getString("created"));
            data.setUpdatedDate(rs.getString("lastupdated"));
            data.setSentDate(rs.getString("sentdate"));

            return data;
         }
      };

      System.out.println(sql);

      return getSimpleJdbcTemplate().query(sql, mapper);

   }

   public void updMsgStatus(int msgID, int status, String comment, String source)
   {
      String sql = null;
      if (source != null || source.equals("Internal"))  {
         sql = "update email_alerts set status = ?, comment = ?, lastupdated = now() where messageid = ? and lastupdated is null";
      }
      else {
         sql = "update email_messages set status = ?, comment = ?, lastupdated = now() where messageid = ? and lastupdated is null";
      }

      if (sql != null)
         getJdbcTemplate().update(sql, new Object[]{status, comment, msgID});

   }

   public void updMsgStatusSuccess(int msgID, String source)
   {
      String sql = null;
      if (source != null && source.equals("Internal"))  {
         sql = "update email_alerts set status = 5, sentdate = now(), lastupdated = now() where messageid = ? and lastupdated is null";
      }
      else {
         sql = "update email_messages set status = 5, sentdate = now(), lastupdated = now() where messageid = ? and lastupdated is null";
      }

      if (sql != null)
         getJdbcTemplate().update(sql, new Object[]{msgID});

   }

   public void saveMsg(MsgData msgData)
   {

      //LOG.info("Entered EmailJob:saveMsg()..."  );

      try
      {
         MsgSP msgSP = new MsgSP(getDataSource());
         msgSP.execute("A", msgData);

      }
      catch (Exception e)
      {
         System.out.println("EmailJob:run():" + e);
      }
   }

}

