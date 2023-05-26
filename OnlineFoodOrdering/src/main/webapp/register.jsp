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
    <title> Food Frenzy | Sign Up </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    
    <!-- CSS only -->
   	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"  integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"  crossorigin="anonymous"></script>
   	<link rel="stylesheet" href="css/index.css">
</head>
<body style="background-color: #e7edf4;">
	<div>
    	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        	<div class="container-fluid">
         		<a href="home.jsp">
         			<img src="images/logo_re.png" style="width:120; height:4rem">
         		</a>
            	<a href="home.jsp" class="mx-0" style="">
            		<i style="color: orange;"> Food Frenzy </i>
            	</a>
              	<button class="navbar-toggler" type="button" data-bs-toggle="collapse"    data-bs-target="#navbarSupportedContent">
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
                    	<button class="btn btn-outline-success" hidden="true" type="submit"> Search </button>
                	</form>
                
                	<ul class="navbar-nav  mb-2 mb-lg-0 ">
                	<%
                	if(session.getAttribute("username")==null)
                    {
                    	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
                    	out.println("<li class='nav-item'>");
                    	out.println("<a class='nav-link' href='login.jsp'>Login</a>");
                    	out.println("</li>");
                    	out.println("<li class='nav-item'>");
                    	out.println("<a class='nav-link' href='register.jsp'>Sign Up </a>");
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

	<div>
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
            		<p class="h3 mx-5" style="text-align: center;"> Create User Account </p>
		       	</div>
		                
		       	<div class="tab-content container mt-3" id="myTabContent">
		       		<div class="tab-pane fade show active mx-5" id="home-tab-pane" role="tabpanel" tabindex="0">
						<form action="RegisterServlet" method="post">
		                	<div class="mb-3">
		                    	<label for="Input1" class="form-label mx-0"> Username: 
		                        	<span style="color: red;">*</span>
								</label>
								<div>
									<input type="text" class="form-control" id="exampleFormControlInput1" name="username" placeholder="Chirag_28" required style="width: 88%;">
		                   			<div id="passwordHelpBlock" class="form-text" style=" float: right;margin-top: -11%">
										<a class="btn btn-default" style="border-color: blue" title="Help" data-toggle='modal' data-target='#username'> <b> ? </b> </a>
		                       		</div>
								</div>
		                  	</div> 
		                   	<div class="mb-3">
								<label for="dateOfBirth" class="form-label mx-0"> DOB:
									<span style="color: red;">*</span>
		                      	</label>
		                   		<input type="date" class="form-control" id="exampleFormControlInput1" name="dob" placeholder="10/10/2001" required>
		                   	</div> 
		                  	<div class="mb-3 ">
		                  		<label for="exampleFormControlInput1" class="form-label mx-0"> Email address: 
									<span style="color: red;">*</span>
		                       	</label>
								<input type="email" class="form-control" id="exampleFormControlInput1" name="email" placeholder="name@example.com" required>
		                    </div>
		                 	<div class="mb-3">
								<label for="phone" class="form-label mx-0"> Phone no:
		                        	<span style="color: red;"> *</span>
		                    	</label>
		                      	<input type="number" class="form-control" id="exampleFormControlInput1" name="phone" placeholder="9911223388" required>
		               		</div> 
		             		<hr style="color: gray;">
		                 	<div class="mb-3">
		                       	<label for="inputPassword5" class="form-label"> Password:
									<span style="color: red;"> * </span>
								</label>
								<div>
									<input type="password" id="inputPassword5" class="form-control input-sm pre" name="password" required style="width: 88%;">
									<div id="passwordHelpBlock" class="form-text" style=" float: right;margin-top: -11%">
			                       		<a class="btn btn-default" style="border-color: blue" title="Help" data-toggle='modal' data-target='#password'> <b> ? </b> </a>
		                        	</div> 
								</div>
		                  	</div>  
		                    <div class="mb-3">
		             			<label for="inputPassword5" class="form-label"> Confirm Password:
									<span style="color: red;">*</span>
								</label>
								<div>
									<input type="password" id="inputPassword5" class="form-control input-sm next" name="cfmpassword" required style="width: 88%;">
			              			<div id="passwordHelpBlock" class="form-text" style=" float: right;margin-top: -11%">
										<a class="btn btn-default" style="border-color: blue" title="Help" data-toggle='modal' data-target='#cfmPassword'> <b> ? </b> </a>
		                       		</div> 
								</div>
							</div> 
		             		<div class="mt-4">
								<input class="btn btn-primary" type="submit" value="Register"> 
		                     	<p style="margin-left: 28%; margin-top:-12%"> Already Have an Account? 
		                     		<br>
		                       		<a href="login.jsp"> Login Here </a>
		                       	</p>
		                  	</div>
		              		<br> <br>
		       			</form>
					</div>
				</div>
        	</div>        
        </div>
    </div>
    
    <!--  Username  -->
	<div class="modal fade" id="username">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header" style="background-color: rgb(187, 247, 208);">
                    <h4 class="modal-title"> Username </h4>
                    <button type="button" class="close" data-dismiss="modal"> &times; </button>
                </div>

                <div class="modal-body">
                	<br>
                    <p> <strong> Rules: </strong> </p>
                    <p> 1. => Must be 2 to 12 characters long. </p>
                    <p> 2. => Must end with a letter or number. </p>
                    <p> 3. => Must not contain special symbol other than underscore.</p>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" > OK </button>
                </div>
            </div>
        </div>
    </div>
    
    <!--  Password  -->
	<div class="modal fade" id="password">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header" style="background-color: rgb(187, 247, 208);">
                    <h4 class="modal-title"> Password </h4>
                    <button type="button" class="close" data-dismiss="modal"> &times; </button>
                </div>

                <div class="modal-body">
                	<br>
                    <p> <strong> Rules: </strong> </p>
                    <p> 1. => Must be at least 6 characters long. </p>
                    <p> 2. => Must contain one upercase and one lowercase letter. </p>
                    <p> 3. => Must contain one digit and one special symbol.</p>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" > OK </button>
                </div>
            </div>
        </div>
    </div>
    
    <!--  Confirm Password  -->
	<div class="modal fade" id="cfmPassword">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header" style="background-color: rgb(187, 247, 208);">
                    <h4 class="modal-title"> Confirm Password </h4>
                    <button type="button" class="close" data-dismiss="modal"> &times; </button>
                </div>

                <div class="modal-body">
                	<br>
                    <p> <strong> Rules: </strong> </p>
                    <p> 1. => Must be at least 6 characters long. </p>
                    <p> 2. => Must contain one upercase and one lowercase letter. </p>
                    <p> 3. => Must contain one digit and one special symbol.</p>
                    <p> 4. => Must be same as Password.</p>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" > OK </button>
                </div>
            </div>
        </div>
    </div>
    

	<%
		HttpSession hs = request.getSession();
	    Boolean dun = (Boolean) hs.getAttribute("duplicateUsername");
		if (dun != null && dun) {
	%>
		<script type="text/javascript">
			alert('Select other username. Username must be unique...');
		</script>
	<% 	
		session.setAttribute("duplicateUsername",false);
		} 
	%>	
	
	<%
	    Boolean iun = (Boolean) hs.getAttribute("invalidUsername");
		if (iun != null && iun) {
	%>
		<script type="text/javascript">
			alert('Username not satisfied with criteria...');
		</script>
	<% 	
		session.setAttribute("invalidUsername",false);
		}	
	%>
	
	<%
	    Boolean idb = (Boolean) hs.getAttribute("invalidDOB");
		if (idb != null && idb) {
	%>
		<script type="text/javascript">
			alert('Date of Birth must be before Today...');
		</script>
	<% 	
		session.setAttribute("invalidDOB",false);
		}	
	%>
	
	<%
	    Boolean iph = (Boolean) hs.getAttribute("invalidPhone");
		if (iph != null && iph) {
	%>
		<script type="text/javascript">
			alert('Phone number must be of 10 digits and should start with 6,7,8 or 9...');
		</script>
	<% 	
		session.setAttribute("invalidPhone",false);
		}	
	%>
	
	<%
	    Boolean ipass = (Boolean) hs.getAttribute("invalidPass");
		if (ipass != null && ipass) {
	%>
		<script type="text/javascript">
			alert('Password not satisfied required criteria...');
		</script>
	<% 	
		session.setAttribute("invalidPass",false);
		}	
	%>
	
	<%
	    Boolean icmp = (Boolean) hs.getAttribute("invalidcmp");
		if (icmp != null && icmp) {
	%>
		<script type="text/javascript">
			alert('Password and Confirm Password are not match...');
		</script>
	<% 	
		session.setAttribute("invalidcmp",false);
		}	
	%>
	
	<%
    	Boolean error = (Boolean) hs.getAttribute("error");
		if (error != null && error) {
	%>
		<script type="text/javascript">
			alert("ERROR: 404 ! Connection error. Something went wrong...");
		</script>
	<% 	
		session.setAttribute("error",false);
		} 
	%>
</body>
</html>