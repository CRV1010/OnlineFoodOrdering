<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>  
<%@ page import="java.util.Base64" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="ruchir" %>  

<% 	
if(session.getAttribute("username") == null)
{
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	response.sendRedirect("login.jsp");
}
%>

<%
	HttpSession s1 = request.getSession();
	String username = (String) s1.getAttribute("username");
	
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinefoodordering","root","");
	Statement st = con.createStatement() ;
	ResultSet rs2 = st.executeQuery("select * from cart where username='"+username+"'");
	
	int totalrecord=0;
	while(rs2.next()){
		totalrecord++;
	}
		  
	ResultSet rs = st.executeQuery("select * from cart where username='"+username+"'");
	String titles[] = new String[totalrecord]; 	  
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<title> Food Frenzy | Cart </title>
<link rel="stylesheet" href="css/index.css">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript" src="js/cartitem.js"></script>

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
 	   	<div class="container-fluid">
       		<a href="home.jsp">
       			<img src="images/logo_re.png" style="width:120; height:4rem">
       		</a>
            <a href="home.jsp" class="mx-0">
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
                            Connection con11 = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlineFoodOrdering","root","");
                            String query = "select orderId,food_title,food_poster,price,quantity from orderItem where customerName = ?";
                            PreparedStatement ps = con.prepareStatement(query);
                			ps.setString(1, (String)session.getAttribute("username"));
                			
                      	    ResultSet rs11 = ps.executeQuery();
                      	  
                        	while(rs11.next()){ 
                      
	                        	byte[] imgData = rs11.getBytes("food_poster"); 
							    String encode = java.util.Base64.getEncoder().encodeToString(imgData);
						        request.setAttribute("food_poster", encode); 
                        	%>
                        	<tr>
								<th> <%= rs11.getString("orderid") %> </th>
                                <td> <%= rs11.getString("food_title") %> </td>
                                <td> 
                                	 <img src="data:foodPoster/jpg;base64,${food_poster}" alt="" width="50%" /> 
                                </td>
                                <td> <%= rs11.getInt("price") %> </td>
                                <td> <%= rs11.getInt("quantity") %> </td>
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
    
    
    <% int i=0;  
    while(rs.next()){  
    	titles[i++] = rs.getString("title"); 
    }
    rs.close();
    %>
       
	<div class="container">
		<h2 class="mt-5 row" style="justify-content: center;color: blue;">Your Cart</h2>
		<br>
       	<div class="row" style="justify-content: center;">
	        <% 
	       	try{
	  		%>
	  		<table class="table table-bordered table-hover">
	  			<tbody>
	  				<tr>
			  			<td>Item</td>
			  			<td>Price</td>
			  			<td>Quantity</td>
			  			<td>Image</td>
			  			<td>Total Price</td>
			  			<td>Action</td>
	  				</tr>
		  			<% int k=0,j=0; 
		        	request.setAttribute("count", k);
		        	%>
	  				<ruchir:forEach items="${cartitem}" var="s">
		  				<tr>
		        			<form action="deleteCart" method="post">
			        			<input type="hidden" name="cart_item_count" value="${count}">
			        			<input type="hidden" name="cart_title${count}" id="cart_title${count}" value="${s.getCart_title()}">
			        			<td name="title${count}" id="title${count}">
			        				<ruchir:out value="${s.getCart_title().toUpperCase()}"></ruchir:out>
			        			</td>
			             		<%   
			             		ResultSet rs1 = st.executeQuery("select food_poster from fooditem where food_title = '"+titles[j]+"'");
						        if(rs1.next()){
						       		byte[] imgData = rs1.getBytes("food_poster"); 
									String encode = Base64.getEncoder().encodeToString(imgData);
								    request.setAttribute("foodPoster", encode); 
								    j++;
						        }
		             			%>
		             			<input type="hidden" name="cart_price${count}" id="cart_price${count}">
		        				<td name="price${count}" id="price${count}">
		        					<ruchir:out value="${s.getCart_price()}"></ruchir:out>
		        				</td>
		             		
								<input type="hidden" name="cart_quantity${count}" id="cart_quantity${count}">
		        				<td name="quantity${count}" id="quantity${count}">
		        					<ruchir:out value="${s.getCart_Quentity()}"></ruchir:out>
		        				</td>
		         				
		         			 	<td width="10%"> 
		                        	<img src="data:food_poster/jpg;base64,${foodPoster}" alt="" width="100%" />  
		                        </td>
		         				    		
		             			<input type="hidden" name="cart_totalcost${count}" id="cart_totalcost${count}">
		        				<td name="totalcost${count}" id="totalcost${count}">	
		        					<ruchir:out value="${s.getCart_totalcost()}"></ruchir:out>
		        				</td>
		             			
		             			<td>
		             				<input type="submit"  name="action" class="btn btn-primary" value="Delete" onclick=cartItem(${count})>
		             			</td>
		        			</form>
	             		</tr>
	        		</ruchir:forEach>
	       		</tbody>
	  		</table>	
  		
	  		<% if(totalrecord > 0){ %>
		        <form action="orderAll" method="post">
		        	<button type="submit" class="btn btn-success"> Order All </button>        
		        </form>
		    <% } %>
	        <% }catch(Exception e){ e.printStackTrace(); } %>       
	    </div>
    </div>
    
    
    <% 
		HttpSession hs = request.getSession();
	    Boolean delete = (Boolean) hs.getAttribute("deleteCart");
		if (delete != null && delete) {
	%>
		<script type="text/javascript">
			alert("Cart item deleted successfully...");
		</script>
	<% 	session.setAttribute("deleteCart",false);
		} 
	%>
</body>
</html>
