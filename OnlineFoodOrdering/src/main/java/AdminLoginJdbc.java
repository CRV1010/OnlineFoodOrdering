import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminLoginJdbc {
	String query = "select * from Admin where username=? and password=?";
	public boolean CheckUser(String user,String pass)
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, user);
			st.setString(2, pass);
			
			ResultSet rs = st.executeQuery();
			if(rs.next())
			{
				return true;
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return false;
	}
}
