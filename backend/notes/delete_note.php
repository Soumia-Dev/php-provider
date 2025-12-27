<?php
include "../connectDb.php";
include "../functionImg.php";

$note_id=$_POST['note_id'];
$note_img=$_POST['note_img'];

$sql="DELETE FROM `notes` WHERE note_id='$note_id'";
$stmt=$con->prepare($sql);
$stmt->execute();
if ($stmt->rowCount() === 1) {
    deleteImg('../upload',$note_img);
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'fail']);
}

?>