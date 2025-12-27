<?php
include "../connectDb.php";

$email=$_POST['email'];
$password=$_POST['password'];


$sql="SELECT * FROM `users` WHERE email ='$email' AND `password`='$password'";

$stmt=$con->prepare($sql);
$stmt->execute();
if ($stmt->rowCount() === 1) {
    $data=$stmt->fetch(PDO ::FETCH_ASSOC);
    echo json_encode(['status' => 'success','data'=>$data]);
} else {
    echo json_encode(['status' => 'fail']);
}

?>