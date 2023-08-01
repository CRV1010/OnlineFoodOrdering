import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FoodItemJdbc{
	String query = "insert into FoodItem values(?,?,?,?)";
	int result = 0;
	java.sql.Blob imageBlob;
	byte[] imageBytes;
	ResultSet rs;
	FoodItem fi = null;

	public int AddFoodItem(String food_title,String food_details,String food_price,InputStream food_poster)
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, food_title);
			st.setString(2, food_details);
			st.setString(3, food_price);
			
			if(food_poster!=null)
			{
				st.setBlob(4, food_poster);
			}
			result=st.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return result;
	}
}
