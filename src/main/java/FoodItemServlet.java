import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/FoodItemServlet")

@MultipartConfig(maxFileSize=16177215)

public class FoodItemServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession hs = request.getSession();
		String food_name,food_details,food_price,image;
		Part food_poster;
		
		try
		{
			food_name = request.getParameter("food_title");
			food_details = request.getParameter("food_details");
			food_price = request.getParameter("food_price");
			
			food_poster = request.getPart("food_poster");
			System.out.println(food_poster.getName());
			System.out.println(food_poster.getSize());
			System.out.println(food_poster.getContentType());
			
			InputStream is = food_poster.getInputStream();
			
			FoodItemJdbc fij = new FoodItemJdbc();
			
			try {
				int row = fij.AddFoodItem(food_name, food_details, food_price, is);
				if(row>0)
				{
					System.out.println("inserted");
				}
				
				FoodDao fd = new FoodDao();
				FoodItem fi[] = fd.getFoodItem();
				int length = fi.length;
				
				request.setAttribute("fooditem", fi);
				request.setAttribute("length", length);
				System.out.println("length : "+length);
				
				hs.setAttribute("addItem", true);
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.forward(request, response);
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
