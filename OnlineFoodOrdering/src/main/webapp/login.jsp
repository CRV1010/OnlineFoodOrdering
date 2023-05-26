<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>

<% 	
if(session.getAttribute("username") != null)
{
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	response.sendRedirect("home.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Food Frenzy | Sign In </title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
    
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"    integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body style="background-color: #e7edf4;">
	<div>
    	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        	<div class="container-fluid">
 				<a  href="home.jsp">
 					<img src="images/logo_re.png" style="width:120; height:4rem">
 				</a>
            	<a href="home.jsp" class="mx-0" style="">
            		<i style="color: orange;"> Food Frenzy </i>
            	</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                	<span class="navbar-toggler-icon"></span>
            	</button>
            
            	<div class="collapse navbar-collapse" id="navbarSupportedContent">
                 	<ul class="navbar-nav  mb-2 mb-lg-0">
                    	<li class="nav-item">
                        	<a class="nav-link active" href="home.jsp">Home</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link " href="about.jsp">About</a>
	                    </li>
	                </ul>
	                
	                <form class="d-flex mx-auto" visiblity="false">
	                    <input id="searchTxt" class="form-control me-2" type="hidden" placeholder="Search">
	                    <button class="btn btn-outline-success" hidden="true" type="submit"> Search</button>
	                </form>
	                
	                <ul class="navbar-nav  mb-2 mb-lg-0 ">
	                	<%
	                    if(session.getAttribute("username")==null)
	                    {
	                    	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	                    	out.println("<li class='nav-item'>");
	                    	out.println("<a class='nav-link' href='login.jsp'> Login </a>");
	                    	out.println("</li>");
	                    	out.println("<li class='nav-item'>");
	                    	out.println("<a class='nav-link' href='register.jsp'> Sign Up </a>");
	                    	out.println("</li>");
	                    }
	                    else if(session.getAttribute("username")!=null)
	                	{
	                    	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	                    	out.println("<li class='nav-item'>");
	                    	out.println("<a class='nav-link' href='LogoutServlet'> Logout </a>");
	                    	out.println("</li>");
	                	}
                    	%>
                    </ul>
	            </div>
	        </div>
	    </nav>
	</div>

    <div class="d-flex container my-5 aligns-items-center justify-content-center mx-auto;">
        <div class="card" style="width: 30rem; box-shadow: 0px 0px 20px 4px #4e79b0">
        	<ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a href="register.jsp" style="color: black; ">
                    	<button class="nav-link" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" style="color: black;"> Sign Up </button>
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a href="login.jsp">
                    	<button class="nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" > Login </button>
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a href="adminLogin.jsp">
                    	<button class="nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab"> Admin Login </button>
                    </a>
                </li>
            </ul>
            
            <div class="container mt-4">
                <p class="h3 mx-5" style="text-align: center;">Already have an account?</p>
            </div>
            
            <div class="tab-content container mt-3" id="myTabContent">
          		<div class="tab-pane fade show active mx-5" id="home-tab-pane" role="tabpanel" tabindex="0">
                    <form action="LoginServlet" method="post">
                        <div class="mb-3 ">
                            <label for="Input1" class="form-label mx-0"> Username:
                            	<span style="color: red;"> * </span>
                            </label>
                            <input type="text" class="form-control" id="exampleFormControlInput1" name="username" placeholder="Type Username..." required>
                        </div>
                        <div class="mb-3">
                            <label for="inputPassword5" class="form-label"> Password:
								<span style="color: red;"> * </span>
							</label>
                            <input type="password" id="inputPassword5" class="form-control input-sm" name="password" placeholder="Type Password..." required>
                       	</div>
						<div class="mt-4">
							<input class="btn btn-primary" type="submit" value="Login">
		                    <p style="margin-left: 25%; margin-top:-8%; margin-bottom: 2%"> Create New Account: &nbsp; 
		               			<a href="register.jsp"> Sign Up </a>
		                   	</p>
		               	</div>
                    </form>
                    <br> <br>
				</div>
            </div>
        </div>
    </div>
    
    <% 
	HttpSession hs = request.getSession();
    Boolean error = (Boolean) hs.getAttribute("error");
	if (error != null && error) {
	%>
	<script type="text/javascript">
		alert("Username and Password not verified. Please try again...");
	</script>
	<% 	
	session.setAttribute("error",false);
	} 
	%>
</body>
</html>