package com.invessence.controller;

import java.io.IOException;
import javax.faces.application.FacesMessage;
import javax.faces.bean.*;
import javax.faces.context.*;
import javax.faces.event.*;
import javax.servlet.*;

import com.invessence.constant.*;
import com.invessence.data.*;
import com.invessence.data.common.UserInfoData;
import com.invessence.util.*;
import org.apache.commons.logging.*;
import org.springframework.security.authentication.*;
import org.springframework.security.web.WebAttributes;

import static javax.faces.context.FacesContext.getCurrentInstance;

@ManagedBean(name = "loginController")
@ViewScoped
public class LoginController implements PhaseListener
{

   protected final Log logger = LogFactory.getLog(getClass());
   private Long logonid;
   private WebUtil webutil = new WebUtil();
   private String userID, password, question, answer, savedAnswer;
   private Boolean needAdditionalInfo = false;
   private UserInfoData uid;
   @ManagedProperty("#{uiLayout}")
   private UILayout uiLayout;

   public void setUiLayout(UILayout uiLayout)
   {
      this.uiLayout = uiLayout;
   }

/*
   @ManagedProperty("#{emailMessage}")
   private EmailMessage emailMessage;
   public void setEmailMessage(EmailMessage emailMessage)
   {
      this.emailMessage = emailMessage;
   }
*/

   /**
    * Redirects the login request directly to spring security check.
    * Leave this method as it is to properly support spring security.
    *
    * @return
    * @throws ServletException
    * @throws IOException
    */

   public void doLogin() throws ServletException, IOException
   {
      ExternalContext context = FacesContext.getCurrentInstance().getExternalContext();

      if (answer != null && !answer.isEmpty())
      {
         uid = (UserInfoData) getCurrentInstance().getExternalContext().getSessionMap().get(WebConst.USER_INFO);
         if (uid != null)
         {
            uid.setAnswer(answer);
         }
      }

      RequestDispatcher dispatcher = ((ServletRequest) context.getRequest())
         .getRequestDispatcher("/j_spring_security_check");

      dispatcher.forward((ServletRequest) context.getRequest(),
                         (ServletResponse) context.getResponse());

      FacesContext.getCurrentInstance().responseComplete();
   }

   public void updateMessages()
   {
      Exception e = (Exception) FacesContext.getCurrentInstance().
         getExternalContext().getSessionMap().get(WebAttributes.AUTHENTICATION_EXCEPTION);

      if (e != null)
      {
         if (e instanceof BadCredentialsException)
         {
            FacesContext.getCurrentInstance().addMessage(null,
                                                         new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                                                          "Invalid Password.",
                                                                          "Invalid Password."));
         }
         else if (e instanceof CredentialsExpiredException)
         {
            FacesContext.getCurrentInstance().addMessage(null,
                                                         new FacesMessage(FacesMessage.SEVERITY_WARN,
                                                                          "Need additional Credential",
                                                                          "Need additional Credential"));
         }
         else if (e instanceof LockedException)
         {
            FacesContext.getCurrentInstance().addMessage(null,
                                                         new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                                                          "Account is locked",
                                                                          "Account is locked"));
         }
         else if (e instanceof AuthenticationServiceException)
         {
            String msg = e.getMessage();
            // System.out.println(msg);
            FacesContext.getCurrentInstance().addMessage(null,
                                                         new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                                                          msg,
                                                                          msg));

         }
         else
         {
            System.out.println("Exception during login time: " + e.getMessage());
            String msg = e.getMessage();
            // System.out.println(msg);
            FacesContext.getCurrentInstance().addMessage(null,
                                                         new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                                                          msg,
                                                                          msg));
         }
      }
   }

   public void afterPhase(PhaseEvent event)
   {
   }

   /* (non-Javadoc)
    * @see javax.faces.event.PhaseListener#beforePhase(javax.faces.event.PhaseEvent)
    *
    * Do something before rendering phase.
    */
   public void beforePhase(PhaseEvent event)
   {
      Exception e = (Exception) FacesContext.getCurrentInstance().
         getExternalContext().getSessionMap().get(WebAttributes.AUTHENTICATION_EXCEPTION);

      if (e instanceof BadCredentialsException)
      {
         logger.debug("Found exception in session map: " + e);
         FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put(
            WebAttributes.AUTHENTICATION_EXCEPTION, null);
         FacesContext.getCurrentInstance().addMessage(null,
                                                      new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                                                       "", "Username or password not valid"));
      }
   }

   /* (non-Javadoc)
    * @see javax.faces.event.PhaseListener#getPhaseId()
    *
    * In which phase you want to interfere?
    */
   public PhaseId getPhaseId()
   {
      return PhaseId.RENDER_RESPONSE;
   }

   public String getRedirect()
   {
      FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put(WebConst.USERLOGON_ATTEMPTS, 0);
      uiLayout.goToStartPage();
      return "success";
   }


   public void logout()
   {
      try
      {
         uiLayout.logout();
      }
      catch (Exception ex)
      {

      }
      webutil.redirect("/j_spring_security_logout", null);
   }

   public Long getLogonid()
   {
      return logonid;
   }

   public void setLogonid(Long logonid)
   {
      this.logonid = logonid;
   }

   public String getUserID()
   {
      return userID;
   }

   public void setUserID(String userID)
   {
      this.userID = userID;
   }

   public String getPassword()
   {
      return password;
   }

   public void setPassword(String password)
   {
      this.password = password;
   }

   public String getQuestion()
   {
      return question;
   }

   public void setQuestion(String question)
   {
      this.question = question;
   }

   public String getAnswer()
   {
      return answer;
   }

   public void setAnswer(String answer)
   {
      this.answer = answer;
   }

   public Boolean getNeedAdditionalInfo()
   {
      //return needAdditionalInfo;
      return false;
   }

   public void setNeedAdditionalInfo(Boolean needAdditionalInfo)
   {
      this.needAdditionalInfo = needAdditionalInfo;
   }

   public String getSavedAnswer()
   {
      return savedAnswer;
   }

   public void setSavedAnswer(String savedAnswer)
   {
      this.savedAnswer = savedAnswer;
   }
}
