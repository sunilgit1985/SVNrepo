// DocuSign API Walkthrough 01 in Java - Request Signature from Template
import java.io.*;
import java.net.URL;
import java.net.HttpURLConnection;

import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.xpath.*;
import org.xml.sax.InputSource;

public class RequestSignatureTemplate
{	
	// Enter your info:
	static String email = "***";				// account email
	static String password = "***";				// account password
	static String integratorKey = "***";			// integrator key (found on Preferences -> API page)
	static String templateId = "***";			// valid template id copied from Console
	static String roleName = "***";				// valid template role name
	static String recipientName = "***";			// recipient (signer) name
	
	// construct the DocuSign authentication header
	static String authenticationHeader = 
				"<DocuSignCredentials>" + 
					"<Username>" + email + "</Username>" +
					"<Password>" + password + "</Password>" + 
					"<IntegratorKey>" + integratorKey + "</IntegratorKey>" + 
				"</DocuSignCredentials>";
	
	static String baseURL = "";		// we will retrieve this
	static String accountId = "";		// will retrieve
	static String envelopeId = "";		// will retrieve
	
	//***********************************************************************************************
	// main()
	//***********************************************************************************************
	public static void main(String[] args) throws Exception
	{	
		
		HttpURLConnection conn = null;		// connection object used for each request
		String url = "";			// end-point for each api call
		String body = "";			// request body
		String response = "";			// response body
		int status;				// response status
		
		//============================================================================
		// STEP 1 - Login API Call
		//============================================================================
		
		url = "https://demo.docusign.net/restapi/v2/login_information";
		body = "";	// no request body for the login call
		
		// create connection object, set request method, add request headers
		conn = InitializeRequest(url, "GET", body);
		
		// send the request
		System.out.println("Sending Login request...\n");
		status = conn.getResponseCode();
		if( status != 200 )	// 200 = OK
		{
			errorParse(conn, status);
			return;
		}
		
		// obtain baseUrl and accountId values from response body 
		response = getResponseBody(conn);
		baseURL = parseXMLBody(response, "baseUrl");
		accountId = parseXMLBody(response, "accountId");
		System.out.println("-- Login response --\n\n" + prettyFormat(response, 2) + "\n");
		
		//============================================================================
		// STEP 2 - Signature Request from Template API Call
		//============================================================================
		
		url = baseURL + "/envelopes";	// append "/envelopes" to baseUrl for signature request call
		
		// this example uses XML formatted requests, JSON format is also accepted
		body = "<envelopeDefinition xmlns=\"http://www.docusign.com/restapi\">" +
				"<accountId>" + accountId + "</accountId>" +
				"<status>sent</status>" + 	// "sent" to send envelope, "created" to save as draft envelope
				"<emailSubject>DocuSign API Call - Signature request from template</emailSubject>" +
				"<templateId>" + templateId + "</templateId>" + 
				"<templateRoles>" + 
				"<templateRole>" + 
				"<email>" + email + "</email>" +	
				"<name>" + recipientName + "</name>" + 				
				"<roleName>" + roleName + "</roleName>" + 
				"</templateRole>" + 
				"</templateRoles>" + 
				"</envelopeDefinition>";
		
		// re-use connection object for second request...
		conn = InitializeRequest(url, "POST", body);
		
		System.out.println("Sending signature request from template...\n");
		status = conn.getResponseCode(); // triggers the request
		if( status != 201 )	// 201 = Created
		{
			errorParse(conn, status);
			return;
		}
		
		// obtain envelopeId value from response body 
		response = getResponseBody(conn);
		envelopeId = parseXMLBody(response, "envelopeId");
		System.out.println("-- Signature Request response --\n\n" + prettyFormat(response, 2));
		System.out.println("Signature request has been sent to " + email  + "!\n");
	} //end main()
	
	//***********************************************************************************************
	//***********************************************************************************************
	// --- HELPER FUNCTIONS ---
	//***********************************************************************************************
	//***********************************************************************************************
	public static HttpURLConnection InitializeRequest(String url, String method, String body) {
		HttpURLConnection conn = null;
		try {
			conn = (HttpURLConnection)new URL(url).openConnection();
			
			conn.setRequestMethod(method);
			conn.setRequestProperty("X-DocuSign-Authentication", authenticationHeader);
			conn.setRequestProperty("Content-Type", "application/xml");
			conn.setRequestProperty("Accept", "application/xml");
			if (method.equalsIgnoreCase("POST"))
			{
				conn.setRequestProperty("Content-Length", Integer.toString(body.length()));
				conn.setDoOutput(true);
				// write body of the POST request 
				DataOutputStream dos = new DataOutputStream( conn.getOutputStream() );
				dos.writeBytes(body); dos.flush(); dos.close();
			}
			return conn;
			
		} catch (Exception e) {
	        	throw new RuntimeException(e); // simple exception handling, please review it
	    }
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public static String parseXMLBody(String body, String searchToken) {
		String xPathExpression;
		try {
	        	// we use xPath to parse the XML formatted response body
			xPathExpression = String.format("//*[1]/*[local-name()='%s']", searchToken);
 			XPath xPath = XPathFactory.newInstance().newXPath();
 			return (xPath.evaluate(xPathExpression, new InputSource(new StringReader(body))));
		} catch (Exception e) {
	        	throw new RuntimeException(e); // simple exception handling, please review it
	    }
	}	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public static String getResponseBody(HttpURLConnection conn) {
		BufferedReader br = null;
		StringBuilder body = null;
		String line = "";
		try {
	        // we use xPath to get the baseUrl and accountId from the XML response body
 			br = new BufferedReader(new InputStreamReader( conn.getInputStream()));
 			body = new StringBuilder();
 			while ( (line = br.readLine()) != null)
 				body.append(line);
 			return body.toString();
		} catch (Exception e) {
	        	throw new RuntimeException(e); // simple exception handling, please review it
	    }
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public static void errorParse(HttpURLConnection conn, int status) { 
		BufferedReader br;
		String line;
		StringBuilder responseError;
		try {
			System.out.print("API call failed, status returned was: " + status);
			InputStreamReader isr = new InputStreamReader( conn.getErrorStream() );
			br = new BufferedReader(isr);
			responseError = new StringBuilder();
			line = null;
			while ( (line = br.readLine()) != null)
				responseError.append(line);
			System.out.println("\nError description:  " + responseError);
			return;
		}
		catch (Exception e) {
			throw new RuntimeException(e); // simple exception handling, please review it
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	public static String prettyFormat(String input, int indent) { 
		try {
	    		Source xmlInput = new StreamSource(new StringReader(input));
	        	StringWriter stringWriter = new StringWriter();
	        	StreamResult xmlOutput = new StreamResult(stringWriter);
	        	TransformerFactory transformerFactory = TransformerFactory.newInstance();
	        	transformerFactory.setAttribute("indent-number", indent);
	        	Transformer transformer = transformerFactory.newTransformer(); 
	        	transformer.setOutputProperty(OutputKeys.INDENT, "yes");
	        	transformer.transform(xmlInput, xmlOutput);
	        	return xmlOutput.getWriter().toString();
	    	} catch (Exception e) {
	        	throw new RuntimeException(e); // simple exception handling, please review it
	    	}
	}
} // end class