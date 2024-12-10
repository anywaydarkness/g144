-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2024 at 12:45 AM
-- Server version: 5.5.25
-- PHP Version: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `g144`
--

-- --------------------------------------------------------

--
-- Table structure for table `atm`
--

CREATE TABLE IF NOT EXISTS `atm` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `addr` varchar(30) NOT NULL,
  `moneys` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `atm`
--

INSERT INTO `atm` (`id`, `addr`, `moneys`) VALUES
(1, '666 Hell Av', 336163);

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE IF NOT EXISTS `bank_accounts` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `user_id` int(5) NOT NULL,
  `acc_type` enum('main','deposit','addit') NOT NULL,
  `amount` int(10) NOT NULL DEFAULT '0',
  `money_type` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `user_id`, `acc_type`, `amount`, `money_type`) VALUES
(1, 1, 'main', 4560, 1),
(2, 1, 'deposit', 145, 1),
(3, 1, 'addit', 146, 2),
(4, 2, 'main', 686, 1),
(5, 2, 'deposit', 0, 1),
(6, 2, 'addit', 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE IF NOT EXISTS `cards` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `icon_id` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `title`, `icon_id`) VALUES
(1, 'metal', 0),
(2, 'bronze', 1),
(3, 'silver', 2),
(4, 'gold', 3),
(5, 'platinum', 4),
(6, 'diamond', 5);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `cat_id` int(3) DEFAULT NULL,
  `icon_id` int(3) NOT NULL,
  `weight` int(11) NOT NULL,
  `price` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `title`, `cat_id`, `icon_id`, `weight`, `price`) VALUES
(1, 'chips', 0, 0, 110, 10),
(2, 'cigarettes', 1, 1, 40, 4),
(3, 'lighter ', 2, 2, 25, 1);

-- --------------------------------------------------------

--
-- Table structure for table `items_cat`
--

CREATE TABLE IF NOT EXISTS `items_cat` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `items_cat`
--

INSERT INTO `items_cat` (`id`, `title`) VALUES
(1, 'fastfood'),
(2, 'tabacco'),
(3, 'tourism');

-- --------------------------------------------------------

--
-- Table structure for table `money_types`
--

CREATE TABLE IF NOT EXISTS `money_types` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `symb` varchar(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `money_types`
--

INSERT INTO `money_types` (`id`, `title`, `symb`) VALUES
(1, 'dollars', '$'),
(2, 'bitcoin', 'BTC');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `fname` varchar(16) NOT NULL,
  `lname` varchar(16) NOT NULL,
  `email` varchar(24) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  `sec_quest` varchar(20) NOT NULL,
  `sec_answ` varchar(20) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `lname`, `email`, `passwd`, `sec_quest`, `sec_answ`, `state`) VALUES
(1, 'sam', 'halleman', '*****@ukr.net', '*****', 'quest', 'answer', 1),
(2, 'lilith', 'crowley', '*****@ukr.net', '*****', 'quest', 'answ', 1);

-- --------------------------------------------------------

--
-- Table structure for table `userwaitconfirms`
--

CREATE TABLE IF NOT EXISTS `userwaitconfirms` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `user_id` int(3) NOT NULL,
  `code_confirm` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_cards`
--

CREATE TABLE IF NOT EXISTS `user_cards` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `user_id` int(5) NOT NULL,
  `card_id` int(5) NOT NULL,
  `amount` int(8) NOT NULL,
  `card_numb` varchar(20) NOT NULL,
  `pass` varchar(4) NOT NULL DEFAULT '0000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `user_cards`
--

INSERT INTO `user_cards` (`id`, `user_id`, `card_id`, `amount`, `card_numb`, `pass`) VALUES
(1, 1, 6, 25, '0893984001733426453', '0000'),
(2, 1, 1, 17640, '0316604001733426485', '0000'),
(3, 1, 4, 214, '0245505001733426474', '0000'),
(4, 1, 2, 95952, '0837224001733426490', '0000'),
(5, 1, 5, 100, '0765660001733426465', '0000'),
(6, 1, 3, 40, '0020753001733426480', '0000'),
(7, 2, 2, 2863, '0837221001733326490', '0000'),
(8, 2, 5, 527, '0837221391733326490', '0000');

-- --------------------------------------------------------

--
-- Table structure for table `user_items`
--

CREATE TABLE IF NOT EXISTS `user_items` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_item` int(5) NOT NULL,
  `id_user` int(5) NOT NULL,
  `cord` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `user_items`
--

INSERT INTO `user_items` (`id`, `id_item`, `id_user`, `cord`) VALUES
(1, 1, 1, '{"x":0,"y":0}'),
(2, 2, 1, '{"x":0,"y":1}'),
(3, 3, 1, '{"x":0,"y":2}'),
(4, 1, 1, '{"x":0,"y":0}'),
(5, 2, 1, '{"x":0,"y":1}'),
(6, 3, 1, '{"x":0,"y":2}'),
(7, 2, 1, '{"x":0,"y":3}'),
(8, 1, 1, '{"x":0,"y":4}'),
(9, 2, 1, '{"x":0,"y":5}'),
(10, 1, 1, '{"x":0,"y":6}');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
