import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public CommentServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title,txt,uname;
		
		HttpSession sh = request.getSession();
		uname = (String)sh.getAttribute("username");
		
		title = request.getParameter("title");
		txt = request.getParameter("txt");
		System.out.println(title);
		System.out.println(txt);
		
		try {
			CommentJdbc rj = new CommentJdbc();
			int res = rj.commentUser(uname, title, txt);
			
			if(res>0)
			{
				sh.setAttribute("published", true);
				System.out.println("Inserted");
				response.sendRedirect("home.jsp");
			}
			else
			{
				sh.setAttribute("error", true);
				response.sendRedirect("register.jsp");	
			}
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
	}
}
