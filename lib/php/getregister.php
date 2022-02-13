<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    echo "failed";
    die();
}
include_once("dbconnector.php");

$email = $_POST['reg_email'];
$password = sha1($_POST['reg_password']);
$sqllogin = "SELECT * FROM register WHERE reg_email = '$email' AND reg_password = '$password'";

$result = $conn->query($sqllogin);
if ($result->num_rows > 0) {
while ($row = $result->fetch_assoc()) {
        $userlist = array();
        $userlist['id'] = $row['reg_id'];
        $userlist['name'] = $row['reg_name'];
        $userlist['email'] = $row['reg_email'];
        $userlist['phone'] = $row['reg_phone'];
        $userlist['address'] = $row['reg_address'];
        $userlist['otp'] = $row['reg_otp'];
        $userlist['credit'] = $row['reg_credit'];
        echo json_encode($userlist);
        $conn->close();
        return;
    }
}else{
    echo "failed";
}
?>