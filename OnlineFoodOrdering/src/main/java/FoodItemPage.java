import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FoodItemPage
 */

@WebServlet("/FoodItemPage")
public class FoodItemPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String count = request.getParameter("food_item_count");
			String title = request.getParameter("food_item_title"+count);
	        String details = request.getParameter("food_item_details"+count);
	        String price = request.getParameter("food_item_price"+count);
	        FoodItem fi = null;
	        
	        try {
	        	Class.forName("com.mysql.jdbc.Driver");
				System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
				
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
				System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
				
				Statement st = con.createStatement();
				String query = "select food_poster from fooditem where food_title='"+title+"'";
				ResultSet rs = st.executeQuery(query);
				
				if(rs.next())
				{
					fi = new FoodItem();
					Blob blob = rs.getBlob(1);
					
					InputStream inputStream = blob.getBinaryStream();
		            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		            byte[] buffer = new byte[4096];
		            int bytesRead = -1;
		             
		            while ((bytesRead = inputStream.read(buffer)) != -1) {
		                outputStream.write(buffer, 0, bytesRead);                  
		            }
		             
		            byte[] imageBytes = outputStream.toByteArray();
		            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
		             
		             
		            inputStream.close();
		            outputStream.close();
		             
		            fi.setFood_title(title);
		            fi.setFood_details(details);
		            fi.setFood_price(price);
		            fi.setBase64Image(base64Image);
					
				}
	        }
	        catch(Exception e)
	        {
	        	System.out.println(e.getMessage());
	        }
	        
	        request.setAttribute("fooditemobj", fi);
	        
	        RequestDispatcher rd = request.getRequestDispatcher("foodItemPage.jsp");
			rd.forward(request, response);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
