<?php
include_once("dbconnector.php");
$email = $_POST['email'];

$sqluser = "SELECT * FROM user WHERE user_email = '$email'";
$result = $conn->query($sqluser);

if ($result->num_rows > 0) {
while ($row = $result->fetch_assoc()) {
        $userlist = array();
        $userlist['id'] = $row['user_id'];
        $userlist['name'] = $row['user_name'];
        $userlist['email'] = $row['user_email'];
        $userlist['password'] = $row['user_password'];
        $userlist['phone'] = $row['user_phone'];
        $userlist['address'] = $row['user_address'];
        $userlist['otp'] = $row['user_otp'];
        $userlist['credit'] = $row['user_credit'];
        echo json_encode($userlist);
        $conn->close();
        return;
    }
}else{
    echo "failed";
}
?>