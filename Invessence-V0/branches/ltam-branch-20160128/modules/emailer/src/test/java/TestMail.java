import java.io.*;
import java.net.InetAddress;
import java.util.Properties;
import java.util.Date;

import javax.mail.*;

import javax.mail.internet.*;

import com.sun.mail.smtp.*;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 1/16/16
 * Time: 10:57 PM
 * To change this template use File | Settings | File Templates.
 */
public class TestMail
{

      public static void main(String args[]) throws Exception {
         Properties props = System.getProperties();
         props.put("mail.smtps.host","smtp.mailgun.org");
         props.put("mail.smtps.auth","true");
         Session session = Session.getInstance(props, null);
         Message msg = new MimeMessage(session);
         msg.setFrom(new InternetAddress("noreply@symbil.com"));
         msg.setRecipients(Message.RecipientType.TO,
                           InternetAddress.parse("prashant@invessence.com", false));
         msg.setSubject("Hello");
         msg.setText("Testing some Mailgun awesomness");
         msg.setSentDate(new Date());
         SMTPTransport t =
            (SMTPTransport)session.getTransport("smtps");
         t.connect("smtp.mailgun.com", "postmaster@symbil.com", "G3n3r@l89");
         t.sendMessage(msg, msg.getAllRecipients());
         System.out.println("Response: " + t.getLastServerResponse());
         t.close();
      }

}
