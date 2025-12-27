<?php
include "../connectDb.php";
include "../functionImg.php";

$note_id=$_POST['note_id'];
$note_title=$_POST['note_title'];
$note_content=$_POST['note_content'];
$note_image=$_POST['note_image'];

if(isset($_FILES['note_file'])){
    deleteImg('../upload',$note_image);
    $note_image=uploadImg('note_file');
}

$sql="UPDATE `notes` SET `note_title`='$note_title',`note_content`='$note_content',`note_image`='$note_image' WHERE note_id='$note_id'";
$stmt=$con->prepare($sql);
$stmt->execute();
if ($stmt->rowCount() === 1) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'fail']);
}

?>