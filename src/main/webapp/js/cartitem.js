console.log("chirag");

function cartItem(i){
	
	var food_title = document.getElementById("title"+i).innerText;
	document.getElementById("cart_title"+i).value=food_title;
	
	var food_details = document.getElementById("quantity"+i).innerText;
	document.getElementById("cart_quantity"+i).value=food_details;
	
	var food_price = document.getElementById("price"+i).innerText;
	document.getElementById("cart_price"+i).value=food_price;
	
	var food_details = document.getElementById("details"+i).innerText;
	document.getElementById("cart_details"+i).value=food_details;
	
	var food_cost = document.getElementById("totalcost"+i).innerText;
	document.getElementById("cart_totalcost"+i).value=food_cost;
}

