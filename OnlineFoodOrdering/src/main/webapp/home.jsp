<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="ruchir" %>  


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"     integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
       
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    
    <link rel="stylesheet" href="css/index.css">
    <script src="js/readMoreReadLess.js"></script>
    <script src="js/fooditemjs.js"></script>
    
    <title> Food Frenzy | Home </title>
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
            	<ul class="navbar-nav mb-2 mb-lg-0">
      	        	<li class="nav-item">
                        <a class="nav-link active" href="home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " href="about.jsp">About</a>
                    </li>
                </ul>
                
                <form class="d-flex mx-auto">
                    <input id="searchTxt" class="form-control me-2" type="search" id="searchBox" placeholder="Search" onFocus="searchItem()">
                    <button class="btn btn-outline-success" type="submit"> Search </button>
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
    
    <div class="container">
        <div class="placeImgCont">
            <div class="my-5 mx-5">
                <div style="margin-top: 100px;">
                    <h1 style="font-size: 45px;">
                    	<b> Make your day <i style="color: orange;"> fabulous, </i> <br> with our <i style="color: orange;"> delicious </i> food </b>
                    </h1>
                    <p class="my-5"> From swanky upscale restaurants to the cosiest hidden gems serving the most incredible food, our system covers it all. Explore menus, and see the photos of various food item and reviews from users just like you, to find your next great order. For over a decade now, we’ve been empowering our customers in discovering new tastes and experiences. By putting together meticulous information for our customers, we enable them to make an informed choice.
                        <span id="dots">...</span> 
                        <span id="more"> From our website you can put the order in cart and after whenever you want you can order all the item or remove any number of item from that. So, let's go into drive of delicious food... Yummy!!!
                        </span>
                        <button onclick="myFunction()" id="myBtn"> Read More </button>
                     </p>
                </div>
            </div>

            <div class="mx-5 mt-5 mb-5 d-block w-100">
                <div id="carouselExampleFade" class="carousel slide carousel-fade placeCarouse" data-bs-ride="carousel">
                    <div class="carousel-inner my-3 mx-5">
                        <div class="carousel-item active my-5">
                            <img src="images/main_img.png" class="d-block w-100" alt="..." />
                        </div>
                        <div class="carousel-item my-5">
                            <img src="images/s.webp" class="d-block w-100" alt="..." style="height: 450px;" />
                        </div>
                        <div class="carousel-item my-5">
                            <img src="images/v.jpg" class="d-block w-100" alt="..." style="height: 450px;" />
                        </div>
                        <div class="carousel-item my-5">
                            <img src="images/b.jpg" class="d-block w-100" alt="..."
                                style="height: 450px;">
                        </div>
                        <div class="carousel-item my-5">
                            <img src="images/pizza.jpg" class="d-block w-100" alt="..." style="height: 450px;">
                        </div>
                        <div class="carousel-item my-5">
                            <img src="images/da.jpg" class="d-block w-100" alt="..." style="height: 450px;" />
                        </div>
                        <div class="carousel-item my-5">
                            <img src="images/chocolate.png" class="d-block w-100" alt="..." style="height: 450px;" />
                        </div>
                        <div class="carousel-item my-5">
                            <img src="images/d.webp" class="d-block w-100" alt="..." style="height: 450px;" />
                        </div>
                        <div class="carousel-item my-5">
                            <img src="images/n.webp" class="d-block w-100" alt="..." style="height: 450px;" />
                        </div>
                         <div class="carousel-item my-5">
                            <img src="images/rolls.webp" class="d-block w-100" alt="..." style="height: 450px;" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<!-- Menu -->
    <div class="container" id="menuSection">
        <h2 class="mt-2 row" style="justify-content: center;">Menu</h2>
       	<div class="row" style="justify-content: center;">
	        <% int i=0; 
	        	request.setAttribute("count", i);
	        %>
        
        	<ruchir:forEach items="${fooditem}" var="s">

	        	<% if(s.equals(userField))
	    		{
	            	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	            %>
             	<div id="eventImgPadding" class="noteCard card mx-3 my-4" style="width: 18rem;">
                	<form action="DeleteFoodItemServlet" name="form${count}" method="post">
	                	<input type="hidden" name="food_item_poster${count}" id="food_item_poster${count}">
	                	<img src="data:food_poster/jpg;base64,${s.base64Image}" class="card-img-top" alt="..." name="poster${count}" style="height: 15rem">
	                	<div class="card-body">
	                		<input type="hidden" name="food_item_count" value="${count}">
	                		<input type="hidden" name="food_item_title${count}" id="food_item_title${count}">
	                    	<h5 class="card-title" name="title${count}" id="title${count}"> <ruchir:out value="${s.food_title.toUpperCase()}"> </ruchir:out> </h5>
	                    	<input type="hidden" name="food_item_details${count}" id="food_item_details${count}">
	                    	<p class="card-text" name="details${count}" id="details${count}"> <ruchir:out value="Descrption : ${s.food_details}"> </ruchir:out> </p>
	                    	<input type="hidden" name="food_item_price${count}" id="food_item_price${count}">
	                    	<h5 class="card-text" name="price${count}" id="price${count}"> <ruchir:out value="Price : ${s.food_price}"></ruchir:out> </h5>
	                    	<input type="submit" class="btn btn-primary" onclick="foodItem(${count})" value="Delete"/>
                		</div>
                	</form>
            	</div>
	            <% } else {
	            %>
	            <div id="eventImgPadding" class="noteCard card mx-3 my-4" style="width: 18rem;">
                	<form action="FoodItemPage" name="form${count}" method="post">
	                	<input type="hidden" name="food_item_poster${count}" id="food_item_poster${count}">
	                	<img src="data:food_poster/jpg;base64,${s.base64Image}" class="card-img-top" alt="..." name="poster${count}" style="height: 15rem">
	                	<div class="card-body">
		                	<input type="hidden" name="food_item_count" value="${count}">
		                	<input type="hidden" name="food_item_title${count}" id="food_item_title${count}">
		                    <h5 class="card-title" name="title${count}" id="title${count}"> <ruchir:out value="${s.food_title.toUpperCase()}"></ruchir:out> </h5>
		                    <input type="hidden" name="food_item_details${count}" id="food_item_details${count}">
		                    <p class="card-text" name="details${count}" id="details${count}"> <ruchir:out value="Descrption : ${s.food_details}"></ruchir:out> </p>
		                    <input type="hidden" name="food_item_price${count}" id="food_item_price${count}">
		                    <h5 class="card-text" name="price${count}" id="price${count}"> <ruchir:out value="Price : ${s.food_price}"></ruchir:out> </h5>
		                    <input type="submit" class="btn btn-primary" onclick="foodItem(${count})" value="order" name="btnaction" />
		                </div>
	                </form>
            	</div>
            	<% } %>
            
	            <% int count = (int)request.getAttribute("count");
	           		count++;
	           		request.setAttribute("count",count);
	           		
	           	%>
        	</ruchir:forEach>
    	</div>        
	</div>
	
    <%
    
    Statement st = con.createStatement() ;
    rs = st.executeQuery("select count(*) from comment");
    rs.next();
    int total = rs.getInt(1);
    ResultSet rs1 = st.executeQuery("select * from comment") ;
    
	%> 
    <div class="mt-5 mx-5">
        <div class="container">
            <h2 class="mt-2 row" style="justify-content: center;">Review</h2>
            <div class="row mx-5 my-4 overflow-auto " style="height:300px">
	            <%
	            	while(rs1.next())
	            	{					
	            %>
	            <div class="col-12 col-md-6 col-lg-4 py-3 mb-5 containercomment ">
	            	<img src="images/user_logo.png" alt="" class="mb-4">
		            <span><a href=""> <i class="fa-sharp fa-solid fa-image-user"></i> </a> </span>
	                <div>
	                	<div> <%= rs1.getString(1) %> </div>
	                	<div> 
	                		<strong> Item: <%= rs1.getString(2) %></strong>
	                	</div>
	                    <div class="commenttext">
	                    		<p> <%= rs1.getString(3) %> </p>
	                   	</div>
	                </div>
           		</div>
            	<% } %>
                
       		</div>
        	<button type="button" id="popUp"> <a href="comment.jsp"> Add Comment </a> </button>
    	</div>
    </div>
    
    
    <%
		HttpSession hs = request.getSession();
    	Boolean pub = (Boolean) hs.getAttribute("published");
		if (pub != null && pub) {
	%>
		<script type="text/javascript">
			alert("Your Comment is Published Now. Thank you...");
		</script>
	<% 	
		session.setAttribute("published",false);
		} 
	%>
	
    <%
    	Boolean di = (Boolean) hs.getAttribute("deleteItem");
		if (di != null && di) {
	%>
		<script type="text/javascript">
			alert("Item deleted Successfully...");
		</script>
	<% 	
		session.setAttribute("deleteItem",false);
		} 
	%>
	
	<%
    	Boolean ed = (Boolean) hs.getAttribute("errorOnDelete");
		if (ed != null && ed) {
	%>
		<script type="text/javascript">
			alert("Error: 404! Connection error. Somrthing went wrong...");
		</script>
	<% 	
		session.setAttribute("errorOnDelete",false);
		} 
	%>
	
	<%
    	Boolean ac = (Boolean) hs.getAttribute("addCart");
		if (ac != null && ac) {
	%>
		<script type="text/javascript">
			alert("Item add into cart successfully...");
		</script>
	<% 	
		session.setAttribute("addCart",false);
		} 
	%>
	
	<%
    	Boolean ec = (Boolean) hs.getAttribute("errorCart");
		if (ec != null && ec) {
	%>
		<script type="text/javascript">
			alert("You already add this item into cart...");
		</script>
	<% 	
		session.setAttribute("errorCart",false);
		} 
	%>
	
	<%
    	Boolean ip = (Boolean) hs.getAttribute("invalidePincode");
		if (ip != null && ip) {
	%>
		<script type="text/javascript">
			alert("Invalid Pincode!!! Pincode must be 6 character long...");
		</script>
	<% 	
		session.setAttribute("invalidePincode",false);
		} 
	%>
	
	<%
    	Boolean ai = (Boolean) hs.getAttribute("addItem");
		if (ai != null && ai) {
	%>
		<script type="text/javascript">
			alert("New item added to Menu section...");
		</script>
	<% 	
		session.setAttribute("addItem",false);
		} 
	%>
	
	<script type="text/javascript">
		function searchItem(){
	
			var search = document.getElementById('searchBox');
			var targetId = '#menuSection';
		    var targetSection = document.querySelector(targetId);
		    console.log(targetSection);
		    
		    if (targetSection) {
		      	var targetPosition = targetSection.offsetTop - 100;
		      
		      	window.scroll({
		        	top: targetPosition,
		        	behavior: 'smooth'
		      	});
		    }
		}
	</script>
	
	<script src="js/search.js"></script>
</body>

</html>