console.log("Ruchir");
var x = 1;

let quantity = document.getElementById("quantity");
let plus = document.getElementById("btplus");
let minus = document.getElementById("btminus");
let totprice = document.getElementById("totprice");

plus.addEventListener("click", function(){
    x++;
    x = (x<10) ? "0" + x:x;
    quantity.innerText = x;
    console.log(x);
    
    var fetchPrice = document.getElementById("fetchPrice").innerText;
    let price = fetchPrice.substring(8,12);
    let totalprice = parseInt(price);
    
    document.getElementById("fetchqty").value=x;
    document.getElementById("fetchtotprice").value=totalprice;
    
    totprice.innerText = totalprice*x;
});


minus.addEventListener("click", function(){
    if(x>1)
    {
        x--;
        x = (x<10) ? "0" + x:x;
        quantity.innerText = x;
    }
    var fetchPrice = document.getElementById("fetchPrice").innerText;
    let price = fetchPrice.substring(8,12);
    let totalprice = parseInt(price);
    
    document.getElementById("fetchqty").value=x;
    document.getElementById("fetchtotprice").value=totalprice;
    
    totprice.innerText = totalprice*x;
});

