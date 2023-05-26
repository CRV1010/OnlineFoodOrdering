import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateStatusServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) {
		try
		{			
			PrintWriter pw = res.getWriter();
			res.setContentType("text/html");
			
			Class.forName("com.mysql.jdbc.Driver"); 
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinefoodordering","root","");
    
		    String name = req.getParameter("sn");
			String status = req.getParameter(name);
			String query = "update orderItem set delStatus = ? where orderId = ?";
			
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, status);
			ps.setString(2, name);
			
			int rs = ps.executeUpdate();
			
			req.setAttribute("status", status);
			pw.print("<html><body>");
			pw.print("<script type='text/javascript'> window.alert('Delivery Status Updated Successfully...');");
			pw.print("</script> ");
			pw.print("</body> </html>");

			RequestDispatcher rd = req.getRequestDispatcher("admin.jsp");
			rd.include(req, res);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
