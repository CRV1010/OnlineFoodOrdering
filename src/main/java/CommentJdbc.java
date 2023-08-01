import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CommentJdbc
{
	int result=0;
	public int commentUser(String uname, String title,String txt) throws ClassNotFoundException, SQLException
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
			
			String check = "insert into comment values(?,?,?)";
			PreparedStatement pst = con.prepareStatement(check);
			pst.setString(1, uname);
			pst.setString(2, title);
			pst.setString(3, txt);
			
			result=pst.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return result;
	}
}
