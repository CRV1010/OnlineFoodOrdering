
function fetchval()
{
	var title = document.getElementById("titleorder").innerText;
	document.getElementById("fetchtitle").value=title;
	
	var y = document.getElementById("details").innerText;
	document.getElementById("fetchdetails").value=y;
	
	var x = document.getElementById("quantity").innerText;
	document.getElementById("fetchqty").value=x;
	
	var totprice = document.getElementById("totprice").innerText;
	document.getElementById("fetchtotprice").value=totprice;

}
