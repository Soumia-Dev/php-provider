<?php
include "../connectDb.php";

$email=$_POST['email'];
$password=$_POST['password'];
$userName=$_POST['userName'];

$sql="INSERT INTO `users`( `email`, `password`, `user_name`) VALUES ('$email','$password','$userName')";
$stmt=$con->prepare($sql);
$stmt->execute();
if ($stmt->rowCount() === 1) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'fail']);
}

?>