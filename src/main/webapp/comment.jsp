<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
	String  s = ""+ session.getAttribute("username");
                
    if(session.getAttribute("username")== null)
	{
    	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
  		response.sendRedirect("login.jsp");
   	}           	
%>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title> Food Frenzy | Comments</title>
    

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
	<link rel="stylesheet" href="css/index.css">
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
</head>
<body>
	
	<div>
    	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        	<div class="container-fluid">
            	<a  href="home.jsp"><img src="images/logo_re.png" style="width:120; height:4rem"></a>
            	<a href="home.jsp" class="mx-0" style=""><i style="color: orange;"> Food Frenzy </i></a>
            	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" >
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
						String  str = ""+ session.getAttribute("username");
	            		
	                	Class.forName("com.mysql.jdbc.Driver");
	                	Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineFoodOrdering","root","");
	                    String query1 = "select username from admin where username = ?";
	                    PreparedStatement ps1 = con1.prepareStatement(query1);
	        			ps1.setString(1, s);
	        			ResultSet rs12 = ps1.executeQuery();
	        			
	              	    int ct =0;
	            		String userField = "";
	        			while(rs12.next()){
	        				ct++;
	        				userField = rs12.getString("username");
		                	if(s.equals(rs12.getString("username")))
		            		{
		                		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		                		out.println("<li class='nav-item'>");
		                		out.println("<a class='nav-link' href='admin.jsp'> Admin </a>");
		                		out.println("</li>");
		            		}
	        			}
	        			
	        			if(ct == 0){
	        				if(session.getAttribute("username")!= null)
		                	{
		                		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
		                		out.println("<li class='nav-item'>");
		                		out.println("<a class='nav-link' href='Mycart.jsp'> Cart </a>");
		                		out.println("</li>");
		                		out.println("<li class='nav-item'>");
		                   		out.println("<div  data-toggle='modal' data-target='#myOrder'> <a class='nav-link' href='#'> Order </a> </div>");
		                   		out.println("</li>");
		                	}
	        			}
	        				
	                	
	                    if(session.getAttribute("username")==null)
	                    {
	                    	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	                    	out.println("<li class='nav-item'>");
	                    	out.println("<a class='nav-link' href='login.jsp'>Login</a>");
	                    	out.println("</li>");
	                    	out.println("<li class='nav-item'>");
	                    	out.println("<a class='nav-link' href='register.jsp'>Sign Up</a>");
	                    	out.println("</li>");
	                    }
	                    else if(session.getAttribute("username")!=null)
	                	{
	                    	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	                    	out.println("<li class='nav-item'>");
	                    	out.println("<a class='nav-link' href='LogoutServlet'>Logout</a>");
	                    	out.println("</li>");
	                	}
	                    %>
                	</ul>
            	</div>
        	</div>
    	</nav>
    </div>
	
	<!--  My Order  -->
	<div class="modal fade" id="myOrder">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header" style="background-color: lightskyblue;">
                    <h4 class="modal-title"> Total Order </h4>
                    <button type="button" class="close" data-dismiss="modal"> &times; </button>
                </div>

                <div class="modal-body">
                    <table class="table table-bordered table-hover text-center">
                        <thead style="background-color: cadetblue;">
                            <tr>
                                <th> Order Id</th>
                                <th> Food Title </th>
                                <th> Food Poster </th>
                                <th> Price </th>
                                <th> Quantity </th>
                            </tr>
                        </thead>
                        <tbody>
                        	<% 
                        	Class.forName("com.mysql.jdbc.Driver"); 
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineFoodOrdering","root","");
                            String query = "select orderId,food_title,food_poster,price,quantity from orderItem where customerName = ?";
                            PreparedStatement ps = con.prepareStatement(query);
                			ps.setString(1, (String)session.getAttribute("username"));
                			
                      	    ResultSet rs = ps.executeQuery();
                      	    
                        	while(rs.next()){ 
                        		
	                        	byte[] imgData = rs.getBytes("food_poster"); 
							    String encode = java.util.Base64.getEncoder().encodeToString(imgData);
						        request.setAttribute("food_poster", encode); 
                        	%>
                        	<tr>
								<th> <%= rs.getString("orderid") %> </th>
                                <td> <%= rs.getString("food_title") %> </td>
                                <td> 
                                	 <img src="data:foodPoster/jpg;base64,${food_poster}" alt="" width="50%" /> 
                                </td>
                                <td> <%= rs.getInt("price") %> </td>
                                <td> <%= rs.getInt("quantity") %> </td>
                            </tr>
                        	<% } %>
						</tbody>
                    </table>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" > Close </button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-5" >
		<h1>Welcome To Comment Section</h1>
		<br>
        <div class="card mb-4">
			<div class="card-body">
               <form action="CommentServlet" method="post">
					<h5 class="card-title"> Add Item Name <span style="color: red;">*</span> </h5>
                    <input type="text" class="form-control" id="addTitle" name="title" placeholder="Enter Item Name..." required>
	                <h5 class="card-title my-2"> Add a Comment <span style="color: red;">*</span> </h5>
	                <div class="form-group">
	                    <textarea class="form-control" id="addTxt" rows="5" name="txt" placeholder="Give Your Valuable Comments Here..." required></textarea>
	                </div>
	                <div class="mt-4">
	                       <input class="btn btn-primary" type="submit" value="Add Comment">
	                </div>             
               	</form>        
            </div>
        </div>
    </div>
	
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"  integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="js/comment.js"></script>

</body>
</html>
