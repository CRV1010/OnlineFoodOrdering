<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="chirag" %>
<%@ page import="java.sql.*" %>

<% 
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
if(session.getAttribute("username")==null)
{
	response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"  crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/quantity.css">
    <script src="js/readMoreReadLess.js"></script>
    <script src="js/orderitemjs.js"></script>
   
    <title> Food Frenzy | Order </title>
</head>

<body>
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a  href="home.jsp">
            	<img src="images/logo_re.png" style="width:120; height:4rem">
            </a>
            <a href="home.jsp" class="mx-0" style="">
            	<i style="color: orange;"> Food Frenzy </i>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent">
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
                
                <ul class="navbar-nav  mb-2 mb-lg-0 d-flex">
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
	                		out.println("<a class='nav-link' href='Mycart.jsp'>Cart</a>");
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

	
    <div class="container">
        <div class="placeImgCont noteCard">
            <div class="mx-5 my-5">
                <img src="data:food_poster/jpg;base64,${fooditemobj.base64Image}" class="card-img-top" alt="..." name="poster${count}">
            </div>
            <div class="my-5 mx-5">
                <div class="card" style="width: 36rem;">
                    <form action="OrderItemServlet" method="post">
                        <div class="card-header text-center">
                        	<input type="hidden" name="fetchtitle" id="fetchtitle">
                            <h2 id="titleorder">
                            	<chirag:out value="${fooditemobj.food_title}"> </chirag:out>
                            </h2>
                        </div>
                       
                        <ul class="list-group list-group-flush">
                        	<input type="hidden" name="fetchdetails" id="fetchdetails">
                            <li class="list-group-item" id="details" style="font-size: 19px;">
                            	<strong> <chirag:out value="${fooditemobj.food_details}"> </chirag:out> </strong>
                            </li>
                            <li class="list-group-item" style="font-size: 19px;">
                                <h3 id="fetchPrice">
                                	<chirag:out value="${fooditemobj.food_price}"> </chirag:out> /- 
                                </h3>
                            </li>
                            <li class="list-group-item plusminusmenu">
                                <div class="wrapper  text-center">
                                    <span id="btplus">+</span>
                                    <input type="hidden" id="fetchqty" name="fetchqty"> 
                                    <span id="quantity">01</span>
                                    <span id="btminus">-</span>
                                </div> 
                            </li>
                       		
                           	<li class="list-group-item plusminusmenu">
                                <div style="font-weight:bold; font-size:25px ">
                                   <label for="">Total Price:</label>
                                   <input type="hidden" id="fetchtotprice" name="fetchtotprice">
                                   <span id="totprice" name="price">  
                                   		<chirag:out value="${fooditemobj.food_price}"> </chirag:out>
                                   </span>
                                </div> 
                            </li>
                            <li class="list-group-item" style="font-size: 19px;">
                                <div class="mb-3">
                                    <label for="address" class="form-label mt-3">Address:
                                    	<span style="color: red">*</span>
                                    </label>
                                    <textarea  class="form-control" id="address" name="address" placeholder="Your Address" required></textarea>
                                    <label for="pincode" class="form-label mt-3">Pincode:
										<span style="color: red">*</span>
									</label>
                                    <input type="number" class="form-control" name="pincode" id="pincode" required>
                                </div>
                                <input type="submit" class="btn btn-primary" value="order now" onclick="fetchval()" name="btnaction">
                                <input type="submit" class="btn btn-primary" onclick="fetchval()" value="cart" name="btnaction">
                            </li>
                        </ul>
                    </form>
                </div>
            </div>
        </div>
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
    
    <script src="js/search.js"></script>
 	<script src="js/qunatity.js"></script>
 	<script>
	 	var foodPriceElement = document.getElementById('totprice').innerHTML;
	 	var regex = /[0-9]+/;
	 	var match = foodPriceElement.match(regex);
	 	var price = match ? match[0] : "";
	 	document.getElementById('totprice').innerHTML = price;
 	</script>
	
</body>
</html>