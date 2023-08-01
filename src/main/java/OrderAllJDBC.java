import java.io.File;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

public class OrderAllJDBC {
	int sum =0;
	String OrderTitle="";
	String OrderQuantity = "";
	String OrderPrice = "";
	String OrderAddress = "";
	String OrderPincode = "";
	MimeMessage message=null;
	String to = null;
	
	int inserIntoOrderItem(HttpServletRequest req, HttpServletResponse res, String username) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinefoodordering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			
			PreparedStatement ps = con.prepareStatement("select username,email,phone from users where username = ?");
			ps.setString(1, username);
			System.out.println("in jdbc");
			
			ResultSet rs1 = ps.executeQuery();
			
			String cname = null, email = null, foodTitle=null, address = null, pincode = null;
			String mobile = null;
			int qty = 0, price = 0;
			Blob foodPoster = null;
		
			if(rs1.next()) {
				cname = rs1.getString(1);
				email = rs1.getString(2);
				to = email;
				mobile = rs1.getString(3);
				System.out.println(cname);
			}
			
			PreparedStatement ps1 = con.prepareStatement("select * from cart where username = ?");
			ps1.setString(1, username);
			ResultSet rs = ps1.executeQuery();
			boolean flag = true;
			
			while(rs.next()) {
				if(flag) {
					flag = false;
					foodTitle = rs.getString("title");
					OrderTitle += foodTitle;
					qty = Integer.parseInt(rs.getString("quantity"));
					OrderQuantity += qty;
					price = Integer.parseInt(rs.getString("price"));
					OrderPrice += price;
					System.out.println(price);
				}
				else {
					foodTitle = rs.getString("title");
					OrderTitle +=" , "+foodTitle;
					qty = Integer.parseInt(rs.getString("quantity"));
					OrderQuantity +=" , "+qty;
					price = Integer.parseInt(rs.getString("price"));
					OrderPrice +=" , "+price;
				}
				
				System.out.println(price);
				address = rs.getString("address");
				OrderAddress += "\n\t-  " + address;
				pincode = rs.getString("pincode");
				OrderPincode += "\n\t-  " + pincode;
			
				PreparedStatement ps2 = con.prepareStatement("select food_poster from foodItem where food_title = ?");
				ps2.setString(1, foodTitle);
				ResultSet rs2 = ps2.executeQuery();
				Blob blob=null;
				byte[] imgData = null;
				
				if(rs2.next()) {
					blob = rs2.getBlob("food_poster"); 
					System.out.println("blob");
				}
			
				System.out.println("hello");	
				Statement st = con.createStatement();
				ResultSet rsorder = st.executeQuery("Select count(*) from orderitem");
				int cnt = 0;
				if(rsorder.next())
				{
					cnt = (rsorder.getInt(1));
					cnt++;
				}
			
				System.out.println("blob"+cnt+cname+email+mobile+foodTitle+qty+price);
				String sql3 = "insert into orderitem values(?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement pst = con.prepareStatement(sql3);
				pst.setInt(1,cnt);
				pst.setString(2,cname);
				pst.setString(3, email);
				pst.setString(4,mobile);
				pst.setBlob(5, blob);
				pst.setString(6,foodTitle);
				pst.setInt(7, qty);
				pst.setInt(8, price);
				pst.setString(9, "pending");
				pst.setString(10, address);
				pst.setString(11, pincode);
			
				int result = pst.executeUpdate();
				
				System.out.print("Hii");
				
				sum += Integer.parseInt(rs.getString("totalcost"));
			}
			
			PreparedStatement psd = con.prepareStatement("delete from cart where username='"+username+"'");
			int del = psd.executeUpdate();
			System.out.println("deleted : "+del);
		
			String from = "************@gmail.com" ;    // mail id
			String password = "*************" ;			// 2-step verification password
			String sub = "Online Food Ordering \n Thank You "+username+" For using Food Frenzy" ;
			String msg = "Your Bill: \n You have orderd : " + OrderTitle + "\n Respective Prices = " + OrderPrice + "\n Quantity = " + OrderQuantity + "\n Total Bill = " + sum + "\n Your Address : " + OrderAddress + "\n Your Pincode : " + OrderPincode;
		
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
	        File f = new File("D:\\Java Project\\OnlineFoodOrdering\\OnlineFoodOrdering\\src\\main\\webapp\\images\\Food Frenzy Combo.jpg");
           
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
        }
		catch(Exception e) {
			e.getMessage();
		}
		
		return sum;
	}
	
	public int getTotalPrice(String username) {
		
		int totalPrice = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinefoodordering","root","");
			
			PreparedStatement ps1 = con.prepareStatement("select * from cart where username = ?");
			ps1.setString(1, username);
			ResultSet rs = ps1.executeQuery();
			
			while(rs.next()) {
				totalPrice += Integer.parseInt(rs.getString("totalcost"));
			}			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return totalPrice;	
	}
}
