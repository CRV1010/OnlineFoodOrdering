import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class OrderItemJdbc {
	
	public int StoreOrder(String title,String totprice,String qty,String address,String pincode,String username){
		int result = 0;
		int count = 0;
		
		try {
			String sql1 = "select * from users where username='"+username+"'";
			String sql2 = "select * from foodItem where food_title='"+title+"'";
			String sql3 = "insert into orderitem values(?,?,?,?,?,?,?,?,?,?,?)";
			String sql4 = "select count(*) from orderitem";
			
			String user = null,email = null,phone = null;
			int quantity = Integer.parseInt(qty);
			int totp = Integer.parseInt(totprice);
			
			Blob poster = null;
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			
			Statement st = con.createStatement();
			ResultSet rs1 = st.executeQuery(sql1);
			if(rs1.next())
			{
				user = rs1.getString(1);
				email = rs1.getString(3);
				phone = rs1.getString(4);
			}
			
			ResultSet rs2 = st.executeQuery(sql2);
			InputStream inputStream = null;
			if(rs2.next())
			{
				poster = rs2.getBlob(4);
				inputStream = poster.getBinaryStream();
			}
			
			ResultSet rs3 = st.executeQuery(sql4);
			if(rs3.next())
			{
				count = rs3.getInt(1);
				count++;
			}
			
			PreparedStatement pst = con.prepareStatement(sql3);
			pst.setInt(1,count);
			pst.setString(2,user);
			pst.setString(3, email);
			pst.setString(4,phone);
			pst.setBlob(5, inputStream);
			pst.setString(6,title);
			pst.setInt(7, quantity);
			pst.setInt(8, totp);
			pst.setString(9, "pending");
			pst.setString(10, address);
			pst.setString(11, pincode);
			
			result = pst.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		return result;
	}
}
