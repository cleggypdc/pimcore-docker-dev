<?php


chdir(__DIR__);
include_once("startup.php");
echo "\n";
use Pimcore\Model\Tool;

$setup = new Tool\Setup();
$setup->database();
$setup->contents([
	"username" => "admin",
	"password" => "Dev_password123"
]);


?>
