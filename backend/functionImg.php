<?php
define("MB", 1048576); 

function uploadImg($file){
$msgError = "";
$imageName=rand(100,1000). "_" . $_FILES[$file]['name'];
$imageTmp=$_FILES[$file]['tmp_name'];
$imageSize=$_FILES[$file]['size'];
$allowExt=array("jpg","png","gif","mp3");
$stringToArray=explode(".",$imageName);
$extention=strtolower(end($stringToArray)) ;

if(!empty($imageName)&&!in_array($extention,$allowExt)){
    $msgError="Extention";
}
if($imageSize>2*MB){
       $msgError="Size";
}
//-----------------------
if(empty($msgError)){
    move_uploaded_file($imageTmp,"../upload/".$imageName);
    return $imageName;
}
else{
    return "fail";
}
}
//-----------------------
function deleteImg($dir,$imageName){
if(file_exists($dir."/".$imageName)){
    unlink($dir."/".$imageName);
}
}

?>
