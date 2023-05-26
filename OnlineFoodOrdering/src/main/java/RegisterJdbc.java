import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class RegisterJdbc
{
	public Boolean registerUser(String username,String dob,String email,String phone,String password) throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.jdbc.Driver");
		System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
		
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
		System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
		
		String check = "select * from Users where username=? and email=?";
		PreparedStatement pst = con.prepareStatement(check);
		pst.setString(1, username);
		pst.setString(2, email);
		
		ResultSet rs = pst.executeQuery();
		if(rs.next())
		{
			return false;
		}
		else {
			Statement st = con.createStatement();
			int rows=1;
			try {
				rows = st.executeUpdate("insert into Users values('"+username+"','"+dob+"','"+email+"','"+phone+"','"+password+"')");
			}
			catch(Exception e) {
				rows=0;
			}
			
			if(rows > 0)
				return true;
			else 
				return false;
		}
	}
}
