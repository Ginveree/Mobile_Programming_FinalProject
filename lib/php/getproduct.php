<?php
require('dbconnector.php');
$makeQuery = "SELECT * FROM products";

$statement = $connection->prepare($makeQuery);

$statement -> execute();

$array = array();

while($resultFrom = $statement->fetch()){
    array_push(
        $myarray,array(
            "id"=>$resultFrom['pID'],
            "username"=>$resultFrom['pModel'],
            "password"=>$resultFrom['pPrice'],
            "stockLeft"=>$resultFrom['pStockLeft'],
            "fuel"=>$resultFrom['pFuel'],
            "colour"=>$resultFrom['pColour'],
            )
    );
}
echo json_encode($myarray);
?>