
console.log("chirag");
function foodItem(i){

	var food_title = document.getElementById("title"+i).innerText;
	document.getElementById("food_item_title"+i).value=food_title;
	
	var food_details = document.getElementById("details"+i).innerText;
	document.getElementById("food_item_details"+i).value=food_details;
	
	var food_price = document.getElementById("price"+i).innerText;
	document.getElementById("food_item_price"+i).value=food_price;

}

