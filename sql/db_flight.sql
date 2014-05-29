-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 29, 2014 at 01:25 PM
-- Server version: 5.5.37
-- PHP Version: 5.3.10-1ubuntu3.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE IF NOT EXISTS `airport` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `longitude` double(9,6) NOT NULL,
  `latitude` double(8,6) NOT NULL,
  `country_id` int(11) unsigned NOT NULL,
  `timezone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=521 ;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`id`, `name`, `location`, `longitude`, `latitude`, `country_id`, `timezone`) VALUES
(101, 'Taipei Touyuan International Airport', 'TPE', 120.500000, 23.500000, 2, '+08:00'),
(103, 'kaohsiung International Airport', 'KHH', 121.559834, 26.984000, 2, '+08:00'),
(105, 'Taichung Airport', 'TCH', 122.547000, 34.612305, 2, '+08:00'),
(107, 'Chubu Centrair International Airport', 'NGO', 130.452670, 35.876410, 4, '+09:00'),
(108, 'London City Airport', 'LCY', 10.570630, 25.147000, 5, '+00:00'),
(109, 'Tokyo International Airport', 'HND', 131.267490, 32.149670, 4, '+09:00'),
(110, 'London Luton Airport', 'LTN', 0.917000, -5.349000, 5, '+00:00'),
(111, 'Narita International Airport', 'NRT', 136.289470, 42.167851, 4, '+09:00'),
(113, 'Manchester Airport', 'MAN', 0.364790, 25.479000, 5, '+00:00'),
(115, 'London Heathrow Airport', 'LHR', 0.631792, 11.349000, 5, '+00:00'),
(149, 'Singapore International Airport', 'SIN', 110.428700, 26.471000, 7, '+08:00'),
(157, 'Doha International Airport', 'DOH', -64.287160, -63.124700, 6, '+04:00'),
(161, 'Hong Kong International Airport', 'HKG', 115.634790, 26.419700, 3, '+08:00'),
(211, 'Aeroport Pulkovo', 'LED', 93.257900, 0.146280, 8, '+04:00');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `abbre` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `name`, `abbre`) VALUES
(1, 'United State', 'US'),
(2, 'Taiwan', 'TWN'),
(3, 'China', 'CN'),
(4, 'Japan', 'JP'),
(5, 'United Kingdom', 'UK'),
(6, 'Doha', 'DOH'),
(7, 'Singapore', 'SIN'),
(8, 'Russian Federation', 'RUS');

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE IF NOT EXISTS `favorite` (
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `flight_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`flight_id`),
  KEY `user_id` (`user_id`),
  KEY `flight_id` (`flight_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE IF NOT EXISTS `flight` (
  `id` int(15) unsigned NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `departure` int(11) unsigned NOT NULL,
  `destination` int(11) unsigned NOT NULL,
  `departure_date` datetime DEFAULT NULL,
  `arrival_date` datetime DEFAULT NULL,
  `price` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `destination` (`destination`),
  KEY `departure` (`departure`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7907 ;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`id`, `flight_number`, `departure`, `destination`, `departure_date`, `arrival_date`, `price`) VALUES
(105, 'JP-123', 101, 109, '2014-05-01 10:00:00', '2014-05-01 12:00:00', 6000),
(123, 'JPM-123', 109, 113, '2014-05-01 14:00:00', '2014-05-01 23:00:00', 15000),
(148, 'HG-148', 211, 161, '2014-04-27 09:00:00', '2014-04-27 22:07:00', 14960),
(151, 'TP-721', 149, 101, '2014-05-01 17:01:00', '2014-05-01 21:32:00', 16875),
(177, 'TM-123', 101, 113, '2014-05-01 10:00:00', '2014-05-01 19:00:00', 20000),
(311, 'HK-328', 105, 161, '2014-04-10 15:22:00', '2014-04-10 16:53:00', 3500),
(325, 'HN-325', 105, 109, '2014-04-16 14:20:00', '2014-04-16 18:27:00', 6999),
(327, 'SI-327', 105, 149, '2014-04-27 10:00:00', '2014-04-27 14:10:00', 8000),
(333, 'HKD-123', 161, 157, '2014-05-01 15:00:00', '2014-05-01 23:00:00', 10000),
(421, 'TP-421', 107, 101, '2014-04-30 17:00:00', '2014-04-30 19:27:00', 5123),
(428, 'HK-428', 107, 161, '2014-04-21 11:07:00', '2014-04-21 14:07:00', 6543),
(429, 'DH-429', 107, 157, '2014-04-20 12:00:00', '2014-04-20 19:00:00', 20000),
(513, 'LC-413', 107, 108, '2014-04-20 10:00:00', '2014-04-20 14:00:00', 21355),
(521, 'TP-521', 109, 101, '2014-04-24 10:00:00', '2014-04-24 13:07:00', 1630),
(555, 'HG-128', 101, 161, '2014-04-15 06:10:00', '2014-04-15 07:41:00', 2980),
(581, 'THK-123', 101, 161, '2014-05-01 13:00:00', '2014-05-01 20:22:00', 13000),
(611, 'JP-124', 101, 107, '2014-04-13 09:00:00', '2014-04-13 12:27:00', 1200),
(617, 'SI-927', 157, 149, '2014-04-25 10:00:00', '2014-04-25 20:15:00', 19387),
(621, 'NR-526', 109, 111, '2014-04-15 10:15:00', '2014-04-15 11:16:00', 1980),
(623, 'DM-123', 157, 113, '2014-05-02 02:00:00', '2014-05-02 06:30:00', 8000),
(631, 'HN-225', 103, 109, '2014-04-10 12:17:00', '2014-04-10 16:44:00', 3998),
(718, 'HK-228', 103, 161, '2014-04-16 14:20:00', '2014-04-16 15:51:00', 6000),
(722, 'KH-722', 149, 103, '2014-04-29 16:13:00', '2014-04-29 20:23:00', 12377),
(747, 'TH-123', 101, 161, '2014-05-01 10:00:00', '2014-05-01 11:30:00', 4000),
(796, 'JP-725', 149, 109, '2014-04-17 06:00:00', '2014-04-17 13:00:00', 4830),
(814, 'LE-814', 161, 211, '2014-04-20 13:00:00', '2014-04-20 19:00:00', 16875),
(822, 'TP-822', 161, 103, '2014-05-01 12:00:00', '2014-05-01 13:35:00', 3999),
(823, 'TC-823', 161, 105, '2014-04-26 10:12:00', '2014-04-26 11:47:00', 4895),
(851, 'HK-728', 149, 161, '2014-04-18 07:25:00', '2014-04-18 11:07:00', 13333),
(861, 'NR-146', 211, 111, '2014-04-25 04:00:00', '2014-04-25 19:32:00', 17992),
(882, 'JHK-123', 109, 161, '2014-05-01 15:08:00', '2014-05-01 19:00:00', 12000),
(911, 'TP-821', 161, 101, '2014-04-23 10:50:00', '2014-04-23 12:21:00', 6111),
(922, 'SI-827', 161, 149, '2014-04-13 17:00:00', '2014-04-13 20:42:00', 16999);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=230 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `account`, `password`, `is_admin`) VALUES
(190, 'joyqul', '7872a74bcbf298a1e77d507cd95d4f8d96131cbbd4cdfc571e776c8a', 1),
(197, 'qwer', '7872a74bcbf298a1e77d507cd95d4f8d96131cbbd4cdfc571e776c8a', 1),
(198, 'hmlin', 'c34adf3fda09c1b4fee705a40bd9fb4d7875f9718f31f25d8401be4a', 1),
(211, 'TA1', '409ba6c7efae36f672813706d70071e44fc27d385301366c3f952bf8', 0),
(212, 'TA2', '409ba6c7efae36f672813706d70071e44fc27d385301366c3f952bf8', 0),
(221, 'robin', '5cbd56b920def4d0868743f540e65272c6cb294517a215624b47784f', 1),
(224, 'userA', '78d8045d684abd2eece923758f3cd781489df3a48e1278982466017f', 1),
(225, 'userC', 'd05d903618dbb10013e4bcf4f17496c8d12a4f39d5909395fa8e69c5', 1),
(226, 'userD', '5ac26b3ca1923bbd345e2f7513b29344a97d97f03a6679a74765d611', 0),
(227, 'test', '7872a74bcbf298a1e77d507cd95d4f8d96131cbbd4cdfc571e776c8a', 1),
(229, 'asdf', '7872a74bcbf298a1e77d507cd95d4f8d96131cbbd4cdfc571e776c8a', 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `airport`
--
ALTER TABLE `airport`
  ADD CONSTRAINT `airport_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `favorite_ibfk_4` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`departure`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`destination`) REFERENCES `airport` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
