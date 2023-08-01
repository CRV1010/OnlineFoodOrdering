import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class OrderItemServlet
 */

@WebServlet("/OrderItemServlet")
public class OrderItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	static String action,order_title,totprice,details,qty,address,pincode,user;
	static HttpServletRequest req;
	static HttpServletResponse res;
	static HttpSession s;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		req = request;
		res = response;
		action = request.getParameter("btnaction");
		order_title = request.getParameter("fetchtitle");
		totprice = request.getParameter("fetchtotprice");
		details = request.getParameter("fetchdetails");
		qty = request.getParameter("fetchqty");
		address = request.getParameter("address");
		pincode = request.getParameter("pincode");
		
		s = request.getSession();
		user = s.getAttribute("username").toString();
		System.out.println(user);
		
		boolean vpin = validatePincode(pincode);
		
		if("order now".equals(action) && vpin)
		{
			try {
				request.setAttribute("totalprice", totprice);
				RequestDispatcher rd = request.getRequestDispatcher("Payment.jsp");
				rd.forward(request, response);
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());	
			}
		}
		else if("cart".equals(action) && vpin)
		{
			int totalcost = Integer.parseInt(totprice);
			int totalitem = Integer.parseInt(qty);
	        int price = totalcost/totalitem;
	        
    		try {
    			Class.forName("com.mysql.jdbc.Driver");
 				System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
 				
 				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
 				System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
 				
 				Statement st = con.createStatement();
 				
 				int rows = st.executeUpdate("insert into cart values('"+order_title+"',"+price+","+totalitem+","+totalcost+",'"+user+"','"+address+"','"+pincode+"')");
 				
 				CartDao cd = new CartDao(user);
 				CartItem fi[] = cd.getFoodItem();
 				int Cartlength = fi.length;
	 				
	 			request.setAttribute("cartitem", fi);
	 			request.setAttribute("Cartlength",Cartlength);
	 			System.out.println("in cart "+fi[0].title);
	 				
	 			s.setAttribute("addCart", true);
	 			response.sendRedirect("home.jsp");				
    		 }
    		 catch(Exception e) {
    		    s.setAttribute("errorCart", true);
	 			response.sendRedirect("home.jsp");
    		 }
		}
		else if(!vpin) {
			s.setAttribute("invalidePincode", true);
			response.sendRedirect("home.jsp");
		}
	}

	private boolean validatePincode(String pincode) {
		// TODO Auto-generated method stub
		if (pincode.length() == 6) {
            return true;
        }
		
		return false;
	}
	
	public void doOrder() {
		try {
			OrderItemJdbc oij = new OrderItemJdbc();
			int check = oij.StoreOrder(order_title,totprice,qty,address,pincode,user);
			if(check>0)
			{
				System.out.println("inserted");
			}
			else
			{
				System.out.println("i dont know");
			}
			
			SendMail sm = new SendMail();
			if(sm.check(user,order_title,qty,totprice,address,pincode))
			{
				System.out.println("email sent successfully");
			}
			else {
				System.out.println("there is some error");
			}
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
