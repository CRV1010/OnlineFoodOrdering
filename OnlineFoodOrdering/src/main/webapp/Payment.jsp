<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title> Food Frenzy | Payment </title>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"> </script>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
</head>
<% 	
if(session.getAttribute("username") == null)
{
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	response.sendRedirect("login.jsp");
}
%>
<body>
   	<div class="col-md-6 offset-md-3">
  		<span class="anchor" id="formPayment"></span>
        <hr class="my-5">

        <!-- form card cc payment -->
     	<div class="card card-outline-secondary">
        	<div class="card-body">
          		<h3 class="text-center"> Credit Card Payment</h3>
                <hr>
                <div class="alert alert-info p-2 pb-3">
                	<a class="close font-weight-normal initialism" data-dismiss="alert" href="#"> 
                		<samp> Ã —</samp>
                	</a> CVV code is required.
              	</div>
              	
              	<form action="PaymentServlet" method="Post">
              		<div class="form">
		               	<div class="form-group">
		                   	<label for="cc_name">Card Holder's Name: 
		                   		<span style="color: red">*</span>
		               		</label>
		                    <input type="text" class="form-control" name="cardHolderName" id="cc_name" pattern="\w+ \w+.*" title="First and Last name" placeholder="Add Account Name Here..." required>
		               	</div>
		           		<div class="form-group">
							<label>Card Number: 
								<span style="color: red">*</span>
							</label>
		               		<input type="text" class="form-control" id="cc_number" name="cardNumber" autocomplete="off" maxlength="16" pattern="\d{16}" title="Credit card number" placeholder="Add Card Number Here..." required>
		             	</div>
		           		<div class="form-group row">
		               		<label class="col-md-12">Card Exp. Date:
		               			<span style="color: red">*</span>
		               		</label>
		                    <div class="col-md-4">
		                      	<select class="form-control" name="cardExpMonth" id="month" size="0" required>
		                			<option value="01">01</option>
		                          	<option value="02">02</option>
		                           	<option value="03">03</option>
		                          	<option value="04">04</option>
		                            <option value="05">05</option>
		                         	<option value="06">06</option>
		                       		<option value="07">07</option>
		                           	<option value="08">08</option>
	                    			<option value="09">09</option>
		                            <option value="10">10</option>
		                          	<option value="11">11</option>
		                          	<option value="12">12</option>
		                   		</select>
		              	    </div>
		              		<div class="col-md-4">
		                       	<select class="form-control" name="cardExpYear" id="year" size="0" required>
			                     	<option>2023</option>
		                           	<option>2024</option>
		                          	<option>2025</option>
		                           	<option>2026</option>
	                        	    <option>2027</option>
									<option>2028</option>
		                      		<option>2029</option>
		                      	</select>
			                </div>
			           		<div class="col-md-4">
		                		<input type="text" class="form-control" id="cvv" name="cvc" autocomplete="off" maxlength="3" pattern="\d{3}" title="Three digits at back of your card" required placeholder="Add CVV Here...">
		                    </div>
		              	</div>
						<div class="row">
		               		<label class="col-md-12"> Amount: 
		                  		<span style="color: red">*</span>
		                  	</label>
		                </div>
		              	<div class="form-inline">
							<div class="input-group">
		                     	<div class="input-group-prepend">
		                    		<span class="input-group-text"> &#8377 </span>
		                  		</div>
		                       	<input type="text" class="form-control text-right" name="amount" value="${totalprice}" id="exampleInputAmount" disabled="disabled" placeholder="39" required>
		                       	<div class="input-group-append">
		                       		<span class="input-group-text">.00</span>
		                       	</div>
		               		</div>
	              		</div>
		            	<hr>
		             	<div class="form-group row">
		                	<div class="col-md-6">
		                   		<button type="reset" class="btn btn-default btn-lg btn-block" onclick="reset()"> Reset </button>
		                    </div>
		                    <div class="col-md-6">
								<button type="submit" class="btn btn-default btn-lg btn-block" data-toggle="modal" data-target="#processing"> Submit </button> 
		                	</div>
		               	</div>
	             	</div>
              	</form>
           	</div>   
    	</div> 
    	
    	<!-- Payment Process -->
    	<div class="modal fade" id="processing" tabindex="-1" role="dialog">
	  		<div class="modal-dialog modal-dialog-centered" role="document">
	    		<div class="modal-content">
				   	
      				<div class="modal-body text-center">
      					<h3> Payment Processing...</h3>
				        <h5> wait for some time...</h5>
				        <br> <br> <br>
     					<img class="card-img-top" src="images/Payment_Processing.gif" alt="" style="width: 80%">				        
     					<br> <br>
				 	</div>
			    </div>
	 		</div>
		</div>
	
		<!-- Payment Done -->
    	<button id="modalTrigger" type="button" style="display: none;" data-toggle="modal" data-target="#exampleModalCenter">Open Modal</button>
    	
		<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog">
	  		<div class="modal-dialog modal-dialog-centered" role="document">
	    		<div class="modal-content">
	      			<div class="modal-header" style="background-color: #8FBC8B">
				        <h5 class="modal-title" id="exampleModalLongTitle"> Payment Done </h5>
				        <button type="button" class="close" data-dismiss="modal" >
				        	<span aria-hidden="true">&times;</span>
				        </button>
				   	</div>
      				<div class="modal-body">
     					<img class="card-img-top" src="images/payment_successful.gif" alt="" >
				        <h2 class="center"> Thank You. </h2>
				        <h5> Your Payment Successfully Done...</h5>
				        <h5> Order Bill send to you on registered E-mail...</h5>
				 	</div>
      				<div class="modal-footer">
	      				<a href="home.jsp" type="button" class="btn btn-primary">Okay</a>
				    </div>
			    </div>
	 		</div>
		</div>
	</div>
	
	<%
		HttpSession hs = request.getSession();
    	Boolean pmt = (Boolean) hs.getAttribute("payment");
			
		if (pmt != null && pmt) {
	%>
		<script>
			window.addEventListener('load', function() {
			    var modalTrigger = document.getElementById('modalTrigger');
			        
			    modalTrigger.click();
			});
		</script>
	<% 	
		session.setAttribute("payment",false);
		} 
	%>
	
	<script>
		function reset(){
			document.getElementById("cc_name").value = "";
			document.getElementById("cc_number").value = "";
			document.getElementById("month").value = "";
			document.getElementById("year").value = "";
			document.getElementById("cc_number").value = "";
			document.getElementById("cvv").value = "";
		}
	</script>
</body>
</html>
