import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public RegisterServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username,dob,email,phone,password,cfmpass;
		username = request.getParameter("username");
		dob = request.getParameter("dob");
		email = request.getParameter("email");
		phone = request.getParameter("phone");
		password = request.getParameter("password");
		cfmpass = request.getParameter("cfmpassword");
		
		try {
			RegisterJdbc rj = new RegisterJdbc();
			
			HttpSession session = request.getSession();
			boolean vuname = validateUser(username);
			boolean vdob = validateDOB(dob);
			boolean vphone = validatePhone(phone);
			boolean vpass = validatePass(password);
			boolean vcfmpass = validateConfirmPass(cfmpass, password);
			
			if(vuname && !vdob && vphone && vpass && vcfmpass) {
				boolean res = rj.registerUser(username,dob,email,phone,password);
				
				if(res)
				{
					session.setAttribute("username",username);
					response.sendRedirect("home.jsp");
				}
				else
				{
					session.setAttribute("duplicateUsername", true);
					response.sendRedirect("register.jsp");	
				}
			}
			else if(!vuname) {
				session.setAttribute("invalidUsername", true);
				response.sendRedirect("register.jsp");
			}
			else if(vdob) {
				session.setAttribute("invalidDOB", true);
				response.sendRedirect("register.jsp");
			}
			else if(!vphone) {
				session.setAttribute("invalidPhone", true);
				response.sendRedirect("register.jsp");
			}
			else if(!vpass) {
				session.setAttribute("invalidPass", true);
				response.sendRedirect("register.jsp");
			}
			else if(!vcfmpass) {
				session.setAttribute("invalidcmp", true);
				response.sendRedirect("register.jsp");
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
	}

	private boolean validateUser(String username) {
		// TODO Auto-generated method stub
		int minLength = 2;
	    int maxLength = 12;
	    String pattern = "^[a-zA-Z0-9_]+$";

	    if (username.length() < minLength || username.length() > maxLength) {
	        return false;
	    }

	    if (!Character.isLetterOrDigit(username.charAt(username.length() - 1))) {
	        return false;
	    }

	    if (!username.matches(pattern)) {
	        return false;
	    }

	    return true;
	}
	
	private boolean validateDOB(String dob) {
		// TODO Auto-generated method stub
		
		LocalDate currentDate = LocalDate.now();
        LocalDate parsedDate = LocalDate.parse(dob, DateTimeFormatter.ISO_LOCAL_DATE);
        return parsedDate.isAfter(currentDate);
	}
	
	private boolean validatePhone(String phone) {
		// TODO Auto-generated method stub
		if (phone.length() != 10) {
            return false;
        }
		
		char firstDigit = phone.charAt(0);
        if (firstDigit != '6' && firstDigit != '7' && firstDigit != '8' && firstDigit != '9') {
            return false;
        }
        
		return true;
	}
	
	private boolean validatePass(String password) {
		// TODO Auto-generated method stub
		if (password.length() < 6) {
            return false;
        }
        
        boolean f1 = false, f2 = false;
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                f1 = true;
            }
            if (Character.isLowerCase(c)) {
                f2 = true;
            }
        }
        if (!f1 || !f2) {
            return false;
        }

        boolean f3 = false, f4 = false;
        for (char c : password.toCharArray()) {
            if (Character.isDigit(c)) {
                f3 = true;
            }
            if (!Character.isLetterOrDigit(c)) {
                f4 = true;
            }
        }
        if (!f3 || !f4) {
            return false;
        }
        
        return true;
	}
	
	private boolean validateConfirmPass(String cfmpass, String password) {
		// TODO Auto-generated method stub
		if(cfmpass.equals(password))
			return true;
		return false;
	}
}
