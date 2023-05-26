import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		orderAll oa = new orderAll();
		HttpSession session = request.getSession();
		
		if(oa.all) {
			oa.all = false;
			oa.doOrderAll();
		}
		else {
			OrderItemServlet ois = new OrderItemServlet();
			ois.doOrder();
		}
		
		session.setAttribute("payment", true);
		
		System.out.print("Order");
		response.sendRedirect("Payment.jsp");
	}
}