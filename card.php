<?php

	include_once('config.php');

	if(!isset($_POST['action']))
		response('error', array('invalid params'));
	
	switch($_POST['action'])
	{
		case 'getBalance':
			
			$sql = 'SELECT amount FROM user_cards WHERE card_numb = :cardNumb';
			$response = $db->query($sql, array( 'cardNumb' => $_POST['cardNumb'] ));
			
			if(!$response)
				response('error', array('info' => 'no card finded'));
			else
				response('success',  array('info' => $response[0]['amount']));
			
			print_r($response);
			
		break;
		
		case 'reciving':
		
			$sql = 'UPDATE user_cards SET amount = amount - :amount WHERE card_numb = :cardNumb;';
			$db->query($sql, array('amount' => $_POST['amount'], 'cardNumb' => $_POST['cardNumb']));
			
			$sql = 'UPDATE bank_accounts SET amount = amount + :amount  WHERE acc_type = \'main\' AND user_id = (SELECT user_id FROM user_cards WHERE card_numb = :cardNumb);';
			$db->query($sql, array('amount' => $_POST['amount'], 'cardNumb' => $_POST['cardNumb']));
			
			$sql = 'UPDATE atm SET moneys = moneys - :amount WHERE id = :atmId;';
			$db->query($sql, array('amount' => $_POST['amount'], 'atmId' => $_POST['atmId']));
			
			response('success', array('success', 'success'));
		
		break;
		
		case 'transfer':
		
			$sql = 'UPDATE user_cards SET amount = amount - :amount WHERE card_numb = :fromCardNumb;';
			$db->query($sql, array('amount' => $_POST['amount'], 'fromCardNumb' => $_POST['fromCardNumb']));
			
			$sql = 'UPDATE user_cards SET amount = amount + :amount WHERE card_numb = :toCardNumb;';
			$db->query($sql, array('amount' => $_POST['amount'], 'toCardNumb' => $_POST['toCardNumb']));
			
			$sql = 'SELECT CONCAT(fname, \' \', lname) AS uname FROM users WHERE id = (SELECT user_id FROM user_cards WHERE card_numb = :toCardNumb)';
			$response = $db->query($sql, array('toCardNumb' => $_POST['toCardNumb']));
			
			response('success', array('info' =>  $response[0]['uname']));
		
		break;
	}

?>