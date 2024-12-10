<?php

	include_once('db.class.php');
	
	$connInfo = array('user' => 'root', 'pass' => '', 'host' => 'localhost', 'name' => 'g144');
	
	$db = new Db($connInfo);
	
	function response($status, $data = array())
	{
		$xmlDoc = new DOMDocument();
		
		$root = $xmlDoc->appendChild($xmlDoc->createElement('root'));
		
		$root->appendChild($xmlDoc->createElement('status', $status));
		$root->appendChild($xmlDoc->createElement('info', $data['info']));
		
		header("Content-Type: text/plain");
		$xmlDoc->formatOutput = true;
		
		die($xmlDoc->saveXml());
	}

?>