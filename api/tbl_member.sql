-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2024 at 08:54 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_cart`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_member`
--

CREATE TABLE `tbl_member` (
  `mem_id` int(8) NOT NULL,
  `mem_name` varchar(50) NOT NULL,
  `mem_address` varchar(255) NOT NULL,
  `mem_tel` varchar(20) NOT NULL,
  `mem_username` varchar(20) NOT NULL,
  `mem_password` varchar(50) NOT NULL,
  `mem_email` varchar(30) NOT NULL,
  `mem_img` varchar(50) DEFAULT NULL,
  `datesave` timestamp NOT NULL DEFAULT current_timestamp(),
  `mem_type` varchar(1) NOT NULL,
  `answer` varchar(1) NOT NULL,
  `mem_code` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_member`
--

INSERT INTO `tbl_member` (`mem_id`, `mem_name`, `mem_address`, `mem_tel`, `mem_username`, `mem_password`, `mem_email`, `mem_img`, `datesave`, `mem_type`, `answer`, `mem_code`) VALUES
(3, 'เต้ย', '999 แลนซีโอนอฟ ซ.40 ถนนคู้บอน แขวงบางชัน  เขตคลองสามวา กรุงเทพฯ 10510', '095 8899 2', 'jay', '945a63f8184f204671284f1ac79b6917ab62ab73', 'jaythitiwat@gmail.com', 'member119728252220231028_143854.jpeg', '2022-02-22 15:04:27', '0', '', '3'),
(4, 'Thitwat Akarawattanasak', '999 แลนซีโอนอฟ ซ.40 ถนนคู้บอน แขวงบางชัน  เขตคลองสามวา กรุงเทพฯ 10510', '0958899219', 'Jayjay', '30ff8eccfb8a4ab361a1b29b115f6f456bd23498', 'jaythitiwat@gmail.com', 'member19973971420220414_020427.jpg', '2022-03-20 17:24:32', '1', '', '00000004'),
(85, 'บอย', '999', '095 8899 289', 'BOY', '5d2fb257fef15b1ecfcccb25f9720d88a77249f8', 'bebe@gmail.com', 'member126297622620231029_233140.jpg', '2023-10-29 16:31:40', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_member`
--
ALTER TABLE `tbl_member`
  ADD PRIMARY KEY (`mem_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_member`
--
ALTER TABLE `tbl_member`
  MODIFY `mem_id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
