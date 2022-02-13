<?php

try{
$connection = new PDO('mysql:host=localhost;dbname=id18068456_mhdatabase','id18068456_mhdb','}VO8o+KCeA1#}RM5');
$connection -> setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
echo "Connected";
}catch(PDOException $exc){
echo $exc -> getMessage();
die("could not connect");
}
?>