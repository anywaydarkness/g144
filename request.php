<?php

	/*
	
		codes:
		
		0 - access denied
		1 - incorent login or passsowrd
		2 - success login-in
	
	*/

	$data = $_GET; // change to $_POST
	
	include_once('config.php');
	
	if(!isset($data['request']))
		displayResult(0, 'access denied');
	
	switch($data['request'])
	{
		case 'login':
		
			// VALIDATION DATA // isset, empty, correct format - regex
			
			$result = $db->query('SELECT id FROM users WHERE email=:login AND passwd=:pass', 
								array('login' => $data['login'], 'pass' => md5($data['pass']) ) );
								
			if(!$result)
				displayResult(1, 'incorrect login or password' );
			else
				displayResult(2,  $result[0]['id']);
		
		break;
		
		case 'getUserItems':
		
			$sql = 'SELECT items.id AS id, items.title, items.icon_id, items.weight, user_items.cord
					FROM user_items INNER JOIN items ON user_items.id_item = items.id WHERE user_items.id_user = :userId';
		
			$result = $db->query($sql, array( 'userId' => $data['userId'] ));

			if(!$result)
				generateResponse('error', array());
			else
				generateResponse('success', $result);
		
		break;
		
		case 'getBasicInfo':
		
			$sql = 'SELECT CONCAT(users.fname,\' \',users.lname) AS uname, bank_accounts.amount, money_types.symb FROM users
					INNER JOIN bank_accounts ON users.id = bank_accounts.user_id 
					INNER JOIN money_types ON bank_accounts.money_type = money_types.id 
					WHERE users.id = :userId AND bank_accounts.acc_type = \'main\';';
			
			generateResponse('success', $db->query($sql, array('userId' => $data['userId'])));
			//generateResponse('success', $db->query($sql, $array('userId' => $data['userId'])));
		
		break;
		
		case 'getAllBanckAccounts':
		
			$sql = 'SELECT acc_type, amount, title, symb FROM back_accoutns INNER JOIN money_types 
					ON back_accoutns.money_type = money_types.id WHERE user_id = :userId;';

			generateResponse('success', $db->query($sql, array('userId' => $data['userId'])));
		
		break;
		
		case 'getItemInfo':
		
			$sql = 'SELECT * FROM items WHERE id = :itemId';
			
			$result = $db->query($sql, array( 'itemId' => $data['itemId']));
			
			if(!$result)
				generateResponse('error');
			else
				generateResponse('success', $result);
		
		break;
		
		// INSERT COMMAND BLOCKS
		
		default:
			displayResult(400, 'bad request');
		break;
	}
	
	function generateResponse($status, $data)
	{
		$xmlDoc = new DOMDocument();
		
		$root = $xmlDoc->appendChild($xmlDoc->createElement('root'));
		
		$root->appendChild($xmlDoc->createElement('status', $status));
		
		$items = $root->appendChild($xmlDoc->createElement('items'));
		
		foreach($data as $item)
		{
			$el = $items->appendChild($xmlDoc->createElement('item'));
			
			foreach($item as $key => $val)
				$el->appendChild($xmlDoc->createElement($key, $val));
		}
		
		header("Content-Type: text/plain");
		$xmlDoc->formatOutput = true;
		
		echo $xmlDoc->saveXml();
	}
	
	function displayResult($code, $info)
	{
		die(json_encode(array('code' => $code, 'info' => $info)));
	}

?>