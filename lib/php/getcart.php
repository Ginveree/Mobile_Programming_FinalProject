<?php
include_once("dbconnector.php");
$email = $_POST['email'];

$sqlcart = "SELECT * FROM cart WHERE email = '$email'";
$result = $conn->query($sqlcart);
$total = 0;
if ($result->num_rows > 0) {
     while ($row = $result ->fetch_assoc()){
        $total = $total+ $row['cartqty'];
     } 
} 
echo $total;

?>