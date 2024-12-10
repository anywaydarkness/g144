<?php

	include_once('config.php');
	
	if(!isset($_GET['userId']))
		displayResponse('error', array());

	$sql = "select user_cards.id, cards.title, cards.icon_id, user_cards.amount, concat(users.fname,' ',users.lname) as uname, user_cards.card_numb
			from user_cards join cards on cards.id = user_cards.card_id join users on user_cards.user_id = users.id 
			where user_cards.user_id = :userId order by user_cards.id;";
	
	$response = $db->query($sql, array('userId' => $_GET['userId']));
	
	if(!$response)
		displayResponse('error', array());
	
	displayResponse('success', $response);
	
	function displayResponse($status, $data)
	{
		$xmlDoc = new DOMDocument();
		
		$root = $xmlDoc->appendChild($xmlDoc->createElement('root'));
		
		$root->appendChild($xmlDoc->createElement('status', $status));
		
		$items = $root->appendChild($xmlDoc->createElement('cards'));
		
		foreach($data as $item)
		{
			$el = $items->appendChild($xmlDoc->createElement('card'));
			
			foreach($item as $key => $val)
				$el->appendChild($xmlDoc->createElement($key, $val));
		}
		
		header("Content-Type: text/plain");
		$xmlDoc->formatOutput = true;
		
		echo $xmlDoc->saveXml();
		
		die();
	}

?>