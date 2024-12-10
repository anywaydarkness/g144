<?php

	include_once('config.php');
	
	$data = $_GET;

	if(!isset($data['action']) || empty($data['action']))
		response('error', array('info' => 'invalid params'));
	
	switch($data['action'])
	{
		case 'info':
		
			if(!isset($data['id']) || empty($data['id']))
				response('error', array( 'info' => 'invalid atm id' ));
		
			$sql = 'SELECT addr, moneys FROM atm WHERE id = :id';
			$response = $db->query($sql, array( 'id' => $data['id'] ));
			
			//print_r($response); die();
			
			if(!$response)
				response('error', array('info' => 'no finded ATM'));
			else
				generateResponse('success', array('info' => $response[0]));
		
		break;
		default:
			response('error', array('info' => 'invalid key request'));
		break;
	}
	
	function generateResponse($status, $data)
	{
		$xmlDoc = new DOMDocument();
		
		$root = $xmlDoc->appendChild($xmlDoc->createElement('root'));
		
		$root->appendChild($xmlDoc->createElement('status', $status));
		
		foreach($data as $item)
		{
			foreach($item as $key => $val)
				$root->appendChild($xmlDoc->createElement($key, $val));
		}
		
		header("Content-Type: text/plain");
		$xmlDoc->formatOutput = true;
		
		echo $xmlDoc->saveXml();
	}

?>