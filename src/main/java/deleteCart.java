import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/deleteCart")
public class deleteCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		String cnt = request.getParameter("cart_item_count");
		String title = request.getParameter("cart_title"+cnt);
		
	    try {
	    	Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
				
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			System.out.println(title);
			
			String query = "delete from cart where title=?";
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, title);
			int res = st.executeUpdate();
			if(res>0)
			{
				System.out.println("Succesfully deleted");
			}
	    }
	    catch(Exception e)
	    {
	    	System.out.println(e.getMessage());
	    }
	    
	    HttpSession session = request.getSession();
		session.setAttribute("deleteCart",true);
	    response.sendRedirect("Mycart.jsp");
	}
}
