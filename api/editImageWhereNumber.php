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
			
		$number = $_GET['number'];

		$img_bill = $_GET['img_bill'];

		$inv_status = $_GET['inv_status'];

		$nonComplete = $_GET['nonComplete'];

		$latt1 = $_GET['latt1'];

		$long1 = $_GET['long1'];

		$WEBSCAN = $_GET['WEBSCAN'];

		$WEBSCANDATE = $_GET['WEBSCANDATE'];

		$WEBSCANBY = $_GET['WEBSCANBY'];
		
		
		
							
		$sql = "UPDATE `tbl_invfile` SET `img_bill` = '$img_bill', `inv_status` = '$inv_status', `nonComplete` = '$nonComplete', `latt1` = '$latt1', `long1` = '$long1', `WEBSCAN` = '$WEBSCAN', `WEBSCANDATE` = '$WEBSCANDATE', `WEBSCANBY` = '$WEBSCANBY' WHERE number = '$number'";

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