<?php
include "../connectDb.php";
include "../functionImg.php";
$user_id=$_POST['user_id'];
$note_title=$_POST['note_title'];
$note_content=$_POST['note_content'];
$note_image=uploadImg('note_file');

if($note_image!="fail"){
    $sql="INSERT INTO `notes`( `user_id`, `note_title`, `note_content`,`note_image`) VALUES ('$user_id','$note_title','$note_content','$note_image')";
$stmt=$con->prepare($sql);
$stmt->execute();
if ($stmt->rowCount() === 1) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'fail']);
}
}
else {
    echo json_encode(['status' => 'fail']);
}


?>