package com.invessence.dao.common;

import com.invessence.data.common.UserInfoData;
import com.invessence.util.*;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.*;
import org.springframework.security.core.authority.*;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.*;

import com.invessence.constant.*;

public class CustomJdbcDaoImpl extends JdbcDaoImpl
{

   private String lockUserSql = null;
   private String listofQAQuery = null;
   private WebUtil webutl = new WebUtil();
   boolean enabled = true;
   boolean accountNonLocked = true;
   boolean accountNonExpired = true;
   boolean credentialsNonExpired = true;

   public String getLockUserSql()
   {
      return lockUserSql;
   }

   public void setLockUserSql(String lockUserSql)
   {
      this.lockUserSql = lockUserSql;
   }

   public String getListofQAQuery()
   {
      return listofQAQuery;
   }

   public void setListofQAQuery(String listofQAQuery)
   {
      this.listofQAQuery = listofQAQuery;
   }

   public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException
   {

      UserInfoData userInfo = getUserInfo(username);

      if (userInfo == null)
      {
         throw new UsernameNotFoundException(username + " is not found");
      }
      else
      {
         return userInfo;
      }
   }

   private UserInfoData getUserInfo(String username)
   { //username is email

      UserInfoData userInfo;

      long logonID = 0;
      String userid = null;
      String savedemail = null;
      String savedpassword = null;
      String logonStatus = null;
      Integer attempts = 0;
      String cid=null;
      String advisor = null;
      Long rep = null;
      Collection<GrantedAuthority> authorities;
      String firstname, lastname;
      String ip, resetID;
      String stateRegistered;
      Integer randomQuestion;
      Integer rnumber;
      String sql;
      Map qa;
      Boolean fetchData;
      String emailmsgtype = null;
      String access = "User";

      String myIP = webutl.getClientIpAddr((HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest());
      System.out.println("Attempting Logon >> " + username + " from: " + myIP);
      userInfo =  (UserInfoData) FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get(Const.USER_INFO);

      if (userInfo != null)
         if (username.equalsIgnoreCase(userInfo.getUserID()))
            attempts =  (Integer) FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get(Const.USERLOGON_ATTEMPTS);
         else
            attempts = 0;
      else
         attempts = 0;


         // We need to fetch data all the time (for username and password)...
         // Don't use the buffered session data.
         sql = getUsersByUsernameQuery();
         SqlRowSet rs = getJdbcTemplate().queryForRowSet(sql, new Object[]{username});

            if ((rs != null) && (rs.next()))
            {

               logonID = rs.getLong("logonid");
               userid = rs.getString("userid");
               logonStatus = rs.getString("logonstatus");
               savedemail = rs.getString("email");
               savedpassword = rs.getString("pwd");
               // attempts = rs.getInt("attempts");
               ip = rs.getString("ip");
               firstname = rs.getString("firstname");
               lastname = rs.getString("lastname");
               stateRegistered = rs.getString("stateRegistered");
               resetID = rs.getString("resetID");
               cid=rs.getString("cid");
               advisor = rs.getString("advisor");
               rep =  rs.getLong("rep");
               emailmsgtype = rs.getString("emailmsgtype");
               access = rs.getString("access");
               // get List of questions...
               qa = getQA(username);
               authorities = getAuthorities(username);
               // Note: it is either set with number of attempts or it was set in past attempt.
               randomQuestion = webutl.randomGenerator(0,2);
               enabled=true;
            }
         else {
               logonStatus = "X";
               savedemail = "";
               savedpassword = "";
               // attempts = rs.getInt("attempts");
               firstname = "";
               lastname = "";
               ip = "";
               resetID = "";
               cid="";
               advisor="";
               rep=null;
               stateRegistered="";
               emailmsgtype="";
               access = "User";
               qa=null;
               authorities = null;
               // Note: it is either set with number of attempts or it was set in past attempt.
               randomQuestion = 0;
               enabled=false;
               throw new BadCredentialsException("Username is not valid!");
            }

      if (attempts == null)
         attempts = 0;

     accountNonLocked=true;
      if ((logonStatus != null) && (logonStatus.equalsIgnoreCase("L"))) {
         accountNonLocked = false;
      }
      else if (logonStatus != null) {
         // If userStatus is empty and it is not locked then add attempts made.
         attempts = attempts + 1;
         if (attempts > Const.MAX_ATTEMPTS) {
            // if more then MAX_ATTEMPTS are made, then get a resetID and lock the user.
            logonStatus = "L";
            // Create new ResetID

            rnumber = webutl.randomGenerator(0,578965);
            resetID=rnumber.toString();
            sql = getLockUserSql();
            getJdbcTemplate().update(sql,new Object[]{logonStatus, rnumber, username});
         }
      }


      // Note:  We are always re-createating userINFO
      credentialsNonExpired = true; // Reset for now.  We need logic to redirect.
      accountNonExpired=true;
      userInfo = new UserInfoData(logonID, userid, username, savedemail, savedpassword,
                                  enabled, accountNonExpired, credentialsNonExpired, accountNonLocked,authorities,
                                  lastname, firstname,
                                  ip, resetID,
                                  cid, advisor, rep, stateRegistered,
                                  qa, attempts, access, logonStatus, randomQuestion,emailmsgtype);


      FacesContext.getCurrentInstance().getExternalContext().getSessionMap().remove(Const.USER_INFO);
      FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put(Const.USER_INFO, userInfo);
      FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put(Const.USERLOGON_ATTEMPTS, attempts);

      return userInfo;
   }

   private Map getQA(String username)
   {
      Map<Integer,String[]> qa = new HashMap<Integer,String[]>();
      String[]questAns=new String[2];
      String sql = getListofQAQuery();
      String question, answer;
      SqlRowSet rs2 = getJdbcTemplate().queryForRowSet(sql, new Object[]{username});
      if ((rs2 != null) && (rs2.next()))
      {
         question =  rs2.getString("question1");
         answer =    rs2.getString("answer1");

         if (question == null || question.isEmpty()) {
            this.credentialsNonExpired = false;
         }
         if (answer == null || answer.isEmpty()) {
            this.credentialsNonExpired = false;
         }
         questAns[0] = question;
         questAns[1] = answer;
         qa.put(0, questAns);

         question =  rs2.getString("question2");
         answer =    rs2.getString("answer2");

         if (question == null || question.isEmpty()) {
            this.credentialsNonExpired = false;
         }
         if (answer == null || answer.isEmpty()) {
            this.credentialsNonExpired = false;
         }
         questAns[0] = question;
         questAns[1] = answer;
         qa.put(1, questAns);

         question =  rs2.getString("question3");
         answer =    rs2.getString("answer3");

         if (question == null || question.isEmpty()) {
            this.credentialsNonExpired = false;
         }
         if (answer == null || answer.isEmpty()) {
            this.credentialsNonExpired = false;
         }
         questAns[0] = question;
         questAns[1] = answer;
         qa.put(2, questAns);
      }
      return qa;
   }

   private Collection<GrantedAuthority> getAuthorities(String username)
   {

      String sql = getAuthoritiesByUsernameQuery();
      SqlRowSet rs = getJdbcTemplate().queryForRowSet(sql, new Object[]{username});
      Collection<GrantedAuthority> list = new ArrayList<GrantedAuthority>();

      if (rs == null)
      {
         list.add(new SimpleGrantedAuthority(Const.ROLE_USER));
         return list;
      }


      while (rs.next())
      {
         String auth = rs.getString(1);
         list.add(new SimpleGrantedAuthority(auth));
      }


      return list;
   }

   protected List<Integer> getList(String sql) throws DataAccessException
   {
      return getJdbcTemplate().query(sql,
                                     new ParameterizedRowMapper<Integer>()
                                     {
                                        public Integer mapRow(ResultSet rs, int rowNum) throws SQLException
                                        {
                                           return rs.getInt(1);
                                        }
                                     });
   }

}

