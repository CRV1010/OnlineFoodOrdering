<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<% 	
if(session.getAttribute("username") == null)
{
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	response.sendRedirect("home.jsp");
}
%>

<%
    Class.forName("com.mysql.jdbc.Driver"); 
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineFoodOrdering","root","");
    Statement st = con.createStatement() ;
    ResultSet rs = st.executeQuery("select count(*) from users");
    rs.next();
    int total = rs.getInt(1);
   
    ResultSet rs2 = st.executeQuery("select count(*) from orderItem");
	rs2.next();
	int totalOrder = rs2.getInt(1);
	 
%>   

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Food Frenzy | Admin </title>

	<link rel="stylesheet" href="css/admin.css">
	<link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"> </script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"> </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"> </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"> </script>
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
                    <button class="btn btn-outline-success" hidden="true" type="submit"> Search</button>
                </form>
                
                <ul class="navbar-nav  mb-2 mb-lg-0 ">
                	<%
                	String  s = ""+ session.getAttribute("username");
                	Class.forName("com.mysql.jdbc.Driver");
                	Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineFoodOrdering","root","");
                    String query1 = "select username from admin where username = ?";
                    PreparedStatement ps1 = con1.prepareStatement(query1);
        			ps1.setString(1, s);
        			ResultSet rs_admin = ps1.executeQuery();
              	    
            		String userField = "";
            		while(rs_admin.next()){
        				userField = rs_admin.getString("username");
	                	if(s.equals(rs_admin.getString("username")))
	            		{
	                		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	                		out.println("<li class='nav-item'>");
	                		out.println("<a class='nav-link' href='admin.jsp'> Admin </a>");
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
                    	out.println("<a class='nav-link'href='register.jsp'>Sign Up </a>");
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

    <div class="container" style="margin-top: 5%;">
    	<h1 id="tc" class="text-center"> <span id="admin_header"> Admin Desk </span> </h1>
        <br>

        <div class="card-deck">
        	<div class="card" style="border: 3px solid blueviolet;" data-toggle="modal" data-target="#admin1">
                <img class="card-img-top" src="images/admin_users.jpg" alt="">
                <div class="card-body text-center">
                    <br>
                    <h3><%= total %> </h3>
                    <p style="font-size: 30px; "> <b> USERS </b></p>
                    <a href="#" class="stretched-link"></a>
                </div>
            </div>

            <div class="card" style="border: 3px solid blueviolet;" data-toggle="modal" data-target="#admin2">
                <img class="card-img-top" src="images/admin_order.png" alt="">
                <div class="card-body text-center">
                    <br>
                    <h3> <%= totalOrder %> </h3>
                    <p style="font-size: 30px;"> <b> TOTAL ORDER </b></p>
                    <a href="#" class="stretched-link"></a>
                </div>
            </div>

            <div class="card" style="border: 3px solid blueviolet;" data-toggle="modal" data-target="#admin3">
                <img class="card-img-top" src="images/admin_add.png" alt="">
                <div class="card-body text-center" >
                    <br>
                    <h4> Add new food details here </h4>
                    <p style="font-size: 30px;"> <b> ADD FOOD </b></p>
                    <a href="#" class="stretched-link"></a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="admin1">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header" style="background-color: lightskyblue;">
                    <h4 class="modal-title"> User Information </h4>
                    <button type="button" class="close" data-dismiss="modal"> &times; </button>
                </div>

                <div class="modal-body">
                    <table class="table table-bordered table-hover">
                        <thead style="background-color: cadetblue;">
                            <tr>
                                <th> User Id</th>
                                <th> Customer Name </th>
                                <th> DOB </th>
                                <th> Email Id </th>
                                <th> Mobile No. </th>
                            </tr>
                        </thead>
                        <tbody>
                            <% ResultSet rs1 = st.executeQuery("select * from users");
                            int count=1;   
                            while(rs1.next()){    
	                            String dateString = rs1.getString("dob");
								SimpleDateFormat inputDate = new SimpleDateFormat("yyyy-MM-dd");
								Date date = null;
                            	try {
                            		date = inputDate.parse(dateString);
                            	} catch (Exception e) {
                            		e.printStackTrace();
                            	}
								SimpleDateFormat outputDate = new SimpleDateFormat("dd MMM, yyyy");
								String formattedDate = outputDate.format(date);                            	    
                            %>
							<tr>
								<td> <%= count++ %></td>
								<td> <%= rs1.getString("username") %></td>
								<td> <%= formattedDate %></td>
						        <td> <%= rs1.getString("email") %></td>
								<td> <%= rs1.getString("phone") %></td>
							</tr>
							<% } %>
                        </tbody>
                    </table>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"> Close </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="admin2">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
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
                                <th> Customer Name </th>
                                <th> Email ID </th>
                                <th> Mobile No. </th>
                                <th> Food Poster </th>
                                <th> Food Title </th>
                                <th> Qnty </th>
                                <th> Price </th>
                                <th> Delivery Status </th>
                                <th> Action </th>
                            </tr>
                        </thead>
                        <tbody>
                        	<% 
                            ResultSet rs12 = st.executeQuery("select * from orderItem where delStatus = 'pending'");
                        	while(rs12.next()){ 
	                        	try{
	                        		byte[] imgData = rs12.getBytes("food_poster"); 
	    						    String encode = Base64.getEncoder().encodeToString(imgData);
	    						    request.setAttribute("foodPoster", encode); 
	                        	}
	                        	catch(Exception e)
	                        	{
	                        		e.printStackTrace();
	                        	}
                        	%>
                        	<tr>
								<th> <%= rs12.getInt("orderId") %> </th>
                                <td> <%= rs12.getString("customerName") %> </td>
                                <td> <%= rs12.getString("emailId") %> </td>
                                <td> <%= rs12.getString("mobile") %> </td>
                                <td> 
                                	 <img src="data:food_poster/jpg;base64,${foodPoster}" alt="" width="100%" /> 
                                </td>
                                <td> <%= rs12.getString("food_title") %> </td>
                                <td> <%= rs12.getInt("quantity") %> </td>
                                <td> <%= rs12.getInt("price") %> </td>
                                <td style="color: blue;"> <strong> <%= rs12.getString("delStatus") %> </strong> </td>
                                
                                <td align="center"> 
                                	<form action="UpdateStatusServlet" method="POST">
                                		<%
                                		String sn = rs12.getString("orderId");
                                		%>
                                		<input type="hidden" name="sn" value="<%= sn %>"/>
                                		<select id="" name="<%= sn %>">
	                                        <option value="Pending"> Pending </option>
	                                        <option value="Delivered"> Delivered </option>
	                                    </select>
	                                    <br> <br>
                                		<% if(rs12.getString("delStatus").equalsIgnoreCase("pending")){ %>
	                                    <button type="submit" class="btn btn-success"> Update </button>
	                                    <% } else { %>
	                                    <button type="submit" class="btn btn-success" disabled> Update </button>
	                                    <% } %>
                                    </form>
                                </td>
                            </tr>
                        	<% } 
                        	
                        	ResultSet rs13 = st.executeQuery("select * from orderItem where delStatus = 'Delivered'");
                        	while(rs13.next()){ 
	                        	try{
	                        		byte[] imgData = rs13.getBytes("food_poster"); 
	    						    String encode = Base64.getEncoder().encodeToString(imgData);
	    						    request.setAttribute("foodPoster", encode); 
	                        	}
	                        	catch(Exception e)
	                        	{
	                        		e.printStackTrace();
	                        	}
                        	%>
                        	<tr>
								<th> <%= rs13.getInt("orderId") %> </th>
                                <td> <%= rs13.getString("customerName") %> </td>
                                <td> <%= rs13.getString("emailId") %> </td>
                                <td> <%= rs13.getString("mobile") %> </td>
                                <td> 
                                	 <img src="data:food_poster/jpg;base64,${foodPoster}" alt="" width="100%" /> 
                                </td>
                                <td> <%= rs13.getString("food_title") %> </td>
                                <td> <%= rs13.getInt("quantity") %> </td>
                                <td> <%= rs13.getInt("price") %> </td>
                                <td style="color: blue;"> <strong> <%= rs13.getString("delStatus") %> </strong> </td>
                                
                                <td align="center"> 
                                	<form action="UpdateStatusServlet" method="POST">
                                		<%
                                		String sn = rs13.getString("orderId");
                                		%>
                                		<input type="hidden" name="sn" value="<%= sn %>"/>
                                		<select id="" name="<%= sn %>">
	                                        <option value="Pending"> Pending </option>
	                                        <option value="Delivered"> Delivered </option>
	                                    </select>
	                                    <br> <br>
                                		<% if(rs13.getString("delStatus").equalsIgnoreCase("pending")){ %>
	                                    <button type="submit" class="btn btn-success"> Update </button>
	                                    <% } else { %>
	                                    <button type="submit" class="btn btn-success" disabled> Update </button>
	                                    <% } %>
                                    </form>
                                </td>
                                <% } %>
                            </tr>
						</tbody>
                    </table>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"> Close </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="admin3">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header" style="background-color: lightskyblue;">
                    <h4 class="modal-title"> Add Food Details </h4>
                    <button type="button" class="close" data-dismiss="modal"> &times; </button>
                </div>

                <div class="modal-body">
                    <form action="FoodItemServlet" enctype='multipart/form-data' method="post">
                        <label for="food_title"> Food Title: 
                        	<span style="color:red"> * </span> 
                        </label> &emsp;
                        <input type="text" name="food_title" id="food_title" placeholder="Mention Food Title Here..." style="min-width: 85%;" required>
                        <br> <br>

                        <div style="display: flex;">
                            <label for="food_details"> Food Details:
                            	<span style="color:red">*</span> 
                            </label> &nbsp;
                            <textarea name="food_details" id="food_details" rows="5" cols="30" placeholder="Mention Testy Caption About Food Here..." style="min-width: 85%; resize: none;" required></textarea>
                        </div>
                        <br> 

                        <label for="food_price"> Food Price:
                        	<span style="color:red">*</span> 
                        </label> &emsp;
                        <input type="number" name="food_price" id="food_price" placeholder="Provide Resonable Price Here..." style="min-width: 85%;" required> 
                        <br> <br>

                        <label for="food_poster"> Food Poster: 
                        	<span style="color:red">*</span> 
                        </label> &emsp;
                        <input type="file" name="food_poster" id="food_poster" required> 
                        <br> <br>

                        <div align="center">
                            <button type="submit" class="btn btn-success" id="addBtn"> Add Food </button>
                        </div>
                    </form>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" >Close</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="js/addFood.js"></script>
</body>
</html>