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

/**
 * Servlet implementation class DeleteFoodItemServlet
 */
@WebServlet("/DeleteFoodItemServlet")
public class DeleteFoodItemServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String count = request.getParameter("food_item_count");
		String title = request.getParameter("food_item_title"+count);
		String query = "delete from foodItem where food_title=?";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, title);
			int result = st.executeUpdate();
			if(result>0)
			{
				session.setAttribute("deleteItem",true);
				System.out.println("Deleted succesfully");
			}
			else {
				session.setAttribute("errorOnDelete",true);
				System.out.println("not deleted");
			}
			response.sendRedirect("home.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
