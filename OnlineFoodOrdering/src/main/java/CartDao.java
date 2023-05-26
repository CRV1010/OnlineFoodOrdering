import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

public class CartDao extends HttpServlet {
	HttpSession s1;
	CartItem[] fi = null;
	int len = 10;
	int i=0;
	String username;
	
	CartDao(String username){
		this.username = username;
	}
	
	public CartItem[] getFoodItem()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("\n DRIVER REGISTERED SUCCESSFULLY....");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
			System.out.println("\n DATABASE CONNECTED SUCCESSFULLY....");
	
			Statement st = con.createStatement();
			ResultSet rs1 = st.executeQuery("select * from cart where username='"+username+"'");
			len =0;
			while(rs1.next())
			{
				len++;
			}
			System.out.println("CartDao lenght :"+len+" cartdao : "+username);
			
			ResultSet rs = st.executeQuery("select * from cart where username='"+username+"'");
			fi=  new CartItem[len];
			while(rs.next())
			{
				System.out.println("chirag");
				fi[i] = new CartItem();
				String title = rs.getString("title");
				int price = Integer.parseInt(rs.getString("price"));
				int quentity = Integer.parseInt(rs.getString("quantity"));
				int totalcost = Integer.parseInt(rs.getString("totalcost"));
				String username = rs.getString("username");
	
		        fi[i].setCart_title(title);
		        fi[i].setCart_price(price);
		        fi[i].setCart_Quentity(quentity);
		        fi[i].setCart_totalcost(totalcost);
		        fi[i].setCart_username(username);
				
				System.out.println(fi[i].totalcost);
				i++;
			}
		}
		catch(Exception e){   
			System.out.println(e.getMessage());   
		}
		
		return fi;	
	}
}
