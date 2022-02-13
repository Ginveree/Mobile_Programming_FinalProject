<?php
include_once("dbconnector.php");
$email = $_POST['email'];
$prid = $_POST['pID'];

$sqlcheckstock = "SELECT * FROM products WHERE pID = '$pID' "; //check product in stock
$resultstock = $conn->query($sqlcheckstock);
if ($resultstock->num_rows > 0) {
     while ($row = $resultstock ->fetch_assoc()){
        $quantity = $row['pStockLeft'];
        if ($quantity == 0) { //product is out of stock
            echo "failed"; 
            return;
        } else {
           echo $sqlcheckcart = "SELECT * FROM cart WHERE pID = '$prid' AND email = '$email'"; //check if the product is already in cart
            $resultcart = $conn->query($sqlcheckcart);
            if ($resultcart->num_rows == 0) {//product is not in the cart proceed with insert new
                 echo $sqladdtocart = "INSERT INTO cart (email, pID, cartqty) VALUES ('$email','$pID','1')";
                if ($conn->query($sqladdtocart) === TRUE) {
                    echo "success";
                } else {
                    echo "failed";
                }
            } else { //if the product is in the cart, proceed with update
                echo $sqlupdatecart = "UPDATE _cart SET cartqty = cartqty +1 WHERE pID = '$pID' AND email = '$email'";
                if ($conn->query($sqlupdatecart) === TRUE) {
                    echo "success";
                } else {
                    echo "failed";
                }
            }
        }
    }
}else{
    echo "failed";
}

?>