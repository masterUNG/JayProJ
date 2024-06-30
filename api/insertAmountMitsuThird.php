<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$code = $_GET['code'];
		$name = $_GET['name'];
		$qty = $_GET['qty'];
		$userId = $_GET['userId'];
		$lat = $_GET['lat'];
		$lng = $_GET['lng'];
							
		$sql = "INSERT INTO `tbl_amount_mitsu_third`(`id`, `code`, `name`, `qty`, `userId`, `lat`, `lng`, `status`) VALUES (Null,'$code','$name','$qty','$userId','$lat','$lng','0')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>