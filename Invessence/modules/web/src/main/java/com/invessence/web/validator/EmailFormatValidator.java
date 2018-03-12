package com.invessence.web.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
import javax.faces.application.FacesMessage;
import javax.faces.bean.SessionScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.*;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;


 
@Component
@SessionScoped
@FacesValidator(value="EmailFormatValidator")
public class EmailFormatValidator implements Validator {
 
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-]+(\\." +
			"[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*" +
			"(\\.[A-Za-z]{2,})$";
 
	private Pattern pattern;
	private Matcher matcher;
	

 
	public EmailFormatValidator(){
		pattern = Pattern.compile(EMAIL_PATTERN);
	}

	public Boolean validate(String emailID)
	{
		if ((emailID == null) || (emailID.isEmpty())) {
			return false;
		}

		if ((emailID.indexOf('.') == -1) ||
			(emailID.indexOf('@') == -1))
		{
			return false;
		}

		matcher = pattern.matcher(emailID);
		return matcher.matches();
	}
 
	@Override
	public void validate(FacesContext context, UIComponent component,
			Object value) throws ValidatorException {

		
		String emailID = (String)value.toString();
		matcher = pattern.matcher(emailID);
		
		FacesMessage msg = null;

		if (! validate(emailID)) {
			msg =  new FacesMessage("E-mail validation failed.", "Invalid E-mail format.");
			msg.setSeverity(FacesMessage.SEVERITY_ERROR);
			throw new ValidatorException(msg);
		}
	

	}
	

}