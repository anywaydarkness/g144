<?php

	include_once('config.php');

	if(!isset($_POST['cardNumb']) || empty($_POST['cardNumb']) || 
		!isset($_POST['cardPass']) || empty($_POST['cardPass']))
			response('error', array('info' => 'invalid params'));
			
	$sql = 'SELECT id FROM user_cards WHERE card_numb = :cardNumb AND pass = :cardPass';
	$response = $db->query($sql, $_POST);
	
	if(!$response)
		response('error', array('info' => 'invalid password'));
	else
		response('success', array('info' => 'success'));
		

?>