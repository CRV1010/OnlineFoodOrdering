import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Base64;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

public class SendMail
{
	MimeMessage message;
	public boolean check(String user,String title,String qty,String totprice,String address,String pincode) throws SQLException
	{
		String encode = null;
		boolean result = false;
		try {
			String sql1 = "select * from users where username='"+user+"'";
			String sql2 = "select * from foodItem where food_title='"+title+"'";
			
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			
			String to=null,price=null;
			
			Statement st = con.createStatement();
			ResultSet rs1 = st.executeQuery(sql1);
			if(rs1.next())
			{
				to = rs1.getString(3);
			}
			
			ResultSet rs2 = st.executeQuery(sql2);
			Blob poster=null;
			byte[] imgData = null;
			InputStream inputStream = null;
			if(rs2.next())
			{
				imgData = rs2.getBytes(4); 
			    encode = Base64.getEncoder().encodeToString(imgData);
				price = rs2.getString(3);
			}
			
			File f = new File("D:\\Java Project\\OnlineFoodOrdering\\OnlineFoodOrdering\\src\\main\\webapp\\images\\Food Frenzy.jpg");
			OutputStream os = new FileOutputStream(f);
			os.write(imgData);
			
			String from = "**********@gmail.com" ;  // mail id
			String password = "**************" ;	// 2 step verification password
			String sub = "Online Food Ordering \n Thank You "+user+" For using Food Frenzy" ;
			String msg = "Your Bill: \n You have orderd : " + title + "\n Price = " + price + "\n Quantity = " + qty + "\n Total Bill = " + totprice +	"\n Your Address : " + address + "\n Your Pincode :  " + pincode;
			
			Properties props = new Properties();    
	        props.put("mail.smtp.host", "smtp.gmail.com"); 
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.connectiontimeout", "60000");
            props.put("mail.smtp.auth", "true");    
	        props.put("mail.smtp.port", "587");    
	          
	        Session session = Session.getDefaultInstance(props,    
	        	new Authenticator() {    
	        		protected PasswordAuthentication getPasswordAuthentication() {    
	        			return new PasswordAuthentication(from,password);  
	        		}    
	          	});    
  
	        try {    
	        	message = new MimeMessage(session);    
	        	message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));    
	        	message.setSubject(sub);  
	           
	        	MimeBodyPart part1 = new MimeBodyPart();
	        	part1.attachFile(f);
	           
	        	MimeBodyPart part2 = new MimeBodyPart();
	        	part2.setText(msg);
	           
	        	MimeMultipart part = new MimeMultipart();
	        	part.addBodyPart(part1);
	        	part.addBodyPart(part2);
	            
	        	message.setContent(part);    
	           
	        	Transport.send(message);    
	        	System.out.println("message sent successfully");
	        	result = true;
	        } 
	        catch (Exception e) {
	        	System.out.println(e);
	        }    
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		return result;
	}
}
