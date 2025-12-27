<?php
include "../connectDb.php";
$user_id=$_POST['user_id'];


$sql="SELECT * FROM `notes` WHERE user_id=$user_id";
$stmt=$con->prepare($sql);
$stmt->execute();


$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
if (count($data) > 0) {
    echo json_encode([
        'status' => 'success',
        'data' => $data
    ]);
} else {
    echo json_encode([
        'status' => 'fail',
        'message' => 'No notes found'
    ]);
}

?>