<?php
error_reporting(0);
include_once("dbconnector.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqllogin = "SELECT * FROM user WHERE user_email = '$email' AND user_password = '$password'";
$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo $data = "success,".$row["user_name"].",".$row["user_email"];
    }
}else{
    echo "failed";
}

?>