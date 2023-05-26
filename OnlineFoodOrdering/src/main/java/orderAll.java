import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/orderAll")
public class orderAll extends HttpServlet {
	static String username;
	static boolean all = false;
	static HttpSession sh;
	static HttpServletRequest request;
	static HttpServletResponse response;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		request = req;
		response = res;
		
		sh = req.getSession();
		username = (String)sh.getAttribute("username");
		
		all = true;
		
		OrderAllJDBC oadb = new OrderAllJDBC();
		int totalCost = oadb.getTotalPrice(username);
		System.out.println("in order all :"+totalCost);
		
		req.setAttribute("totalprice", totalCost);
		RequestDispatcher rd = req.getRequestDispatcher("Payment.jsp");
		rd.include(req, res);
	}
	
	public void doOrderAll() {
		try {
			OrderAllJDBC oadb = new OrderAllJDBC();
			int totalCost = oadb.inserIntoOrderItem(request, response, username);
			System.out.println("in doOrder all :"+totalCost);
			
			request.setAttribute("totalprice", totalCost);
			RequestDispatcher rd = request.getRequestDispatcher("Payment.jsp");
			rd.include(request, response);
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
