<?php
$datos = array(
'server' => 'localhost' ,
'user' => 'kotsifi_1' ,
'pass' => '123456rlz' ,
'db' => 'kotsifi_1'
) ;
$DB = new BaseDeDatos( $datos , 'mysql') ;
date_default_timezone_set('America/Lima');
date_default_timezone_set('GMT-5');
?>