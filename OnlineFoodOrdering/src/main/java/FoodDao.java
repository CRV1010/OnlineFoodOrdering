import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Base64;

public class FoodDao {
	ResultSet rs;
	FoodItem[] fi = null;
	int len = 10;
	int i=0;
	
	public FoodItem[] getFoodItem()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			
			PreparedStatement pst = con.prepareStatement("select * from FoodItem"); 
			rs = pst.executeQuery();
			
			Statement st = con.createStatement();
			ResultSet rs1 = st.executeQuery("select food_title from FoodItem");
			len =0;
			
			while(rs1.next())
			{
				len++;
			}
			System.out.println("lenght :"+len);
			
			fi=  new FoodItem[len];
			while(rs.next())
			{
				fi[i] = new FoodItem();
				String food_titles = rs.getString(1);
				String food_detailss = rs.getString(2);
				String food_prices = rs.getString(3);
				Blob blob = rs.getBlob(4);
				
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
		             
		        fi[i].setFood_title(food_titles);
		        fi[i].setFood_details(food_detailss);
		        fi[i].setFood_price(food_prices);
		        fi[i].setBase64Image(base64Image);
				i++;
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		return fi;		
	}
}
