<!doctype html>
<html lang="cn">
<head>
<title></title>
<meta charset="UTF-8">
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<style type="text/css">
</style>
<script language="JavaScript" type="text/javascript">
<!--
function showCookie(){
	alert('js read cooie:'+document.cookie);
}
showCookie();
//-->
</script> 
</head>
<body>
<?php 
	
$value = "php write my cookie value";
setcookie("TestPHPWriteCookie",$value,time()+3600*24);


echo "php read cookie"; 
print_r($_COOKIE); 

?> 
<button onclick="showCookie()">showCookie</button>
</body>

</html>