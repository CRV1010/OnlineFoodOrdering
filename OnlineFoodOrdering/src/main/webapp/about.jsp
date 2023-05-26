<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Food Frenzy | About </title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link rel="stylesheet" href="css/index.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="js/readMoreReadLess.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
   		<div class="container-fluid">
       		<a href="home.jsp">
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
                        <a class="nav-link" href="about.jsp"> About </a>
                    </li>
                </ul>
                
                <form class="d-flex mx-auto" visiblity="false">
                	<input id="searchTxt" class="form-control me-2" hidden="true" type="search" placeholder="Search">
                    <button class="btn btn-outline-success" hidden="true" type="submit">Search</button>
                </form>
                
                <ul class="navbar-nav  mb-2 mb-lg-0 ">
                	<%
					String  s = ""+ session.getAttribute("username");
            		
                	Class.forName("com.mysql.jdbc.Driver");
                	Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineFoodOrdering","root","");
                    String query1 = "select username from admin where username = ?";
                    PreparedStatement ps1 = con1.prepareStatement(query1);
        			ps1.setString(1, s);
        			ResultSet rs12 = ps1.executeQuery();
              	    
        			int ct = 0;
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
    
    
    <div>
        <div class="container my-5">
            <h2 style="text-align: center;">About Us</h2>
            <div class="card mt-4" style="width: 100%; box-shadow: 0 0 0.8rem rgb(255, 183, 0)">
                <div class="card-body">
                    <p class="card-text"> <b>Vision</b>
                    <p>To be the most trusted online Food brand to celebrate the joy of giving and eating
                    </p> <br>

                    <b>Why us ?</b> <br> <br>
                    <p>
                        Our mission is to give healthy and delicious food to our customer in online mode very fast. We try to give best delivery. Convenience is what makes us tick. It's what makes us get out of bed and say, "Let's eat this."
                    </p> <br>
                    <b>Services we provide: </b> <br> <br>
                    <p>
                        Perfect test of home made food with user convenience support by their comments. This trait your journey of eating with congratulating us. Smooth ordering process and more user interactive process with confirmation mail is the main features of this website. It's like a virtual restaurant without customer-owner physical communication.  We offer contactless delivery as a convenient and secure option.  <br> <br> We always waiting to solve your query, please comment it and enjoy your special day with Food Frenzy!!!
                    </p> <br> 
                    <b> Quality & Sources: </b> <br> <br>
                    <p>
                        At Food Frenzy, we are committed to delivering the fantastic quality and freshest ingredients to your doorstep. We believe that great food starts with exceptional ingredients, and that's why we go above and beyond to ensure that every dish we prepare is made with care and precision.
                        <br> <br>
                        Our dedicated team of chefs experts is passionate about delivering exceptional flavors in every dish. They meticulously inspect and handpick each ingredient to ensure that only the finest quality items make it into your meals. We have strict quality control processes in place to maintain the highest standards of taste, freshness, and presentation. Our main motove is you to feel confident and informed about the food you are enjoying.
                        <br> <br>
                        We take our ingredients from trusted suppliers who share our commitment to quality. Our team carefully selects fresh and vegiterian food that are bursting with flavor and nutrition. We believe in supporting local farmers and businesses, as it not only promotes sustainability but also allows us to bring you the freshest ingredients available. Our ingredients travel the shortest distance possible from the farm to your plate. So, it most probability of healthy food.
                    </p>
                    <span id="dots">...</span><span id="more">
                    <br>
                        <b> What we provide:</b>
                        <p>
                            <br> => Security by various validation on account sign-in.
                            <br> => List of Delicious Menu Items.
                            <br> => User suggestion/query by Comment box.
                            <br> => Searching items from menu box.
                            <br> => Historical order see user perspective.
                            <br> => Order specific item with multipal quantity.
                            <br> => Add, Delete and Order more items from cart.
                            <br> => Receive Payment Bill via E-mail.
                            <br> => Manage user orders and menu items on admin panel.
                            <br> => Smooth and User interactive website.
                        </p>
                    </span>
                    <button onclick="myFunction()" id="myBtn">Read more</button> </p>

                </div>
            </div>
        </div>


        
    </div>
</body>

</html>