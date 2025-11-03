-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 14, 2025 at 12:50 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `horobo`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminsignup`
--

CREATE TABLE `adminsignup` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `number` varchar(20) NOT NULL,
  `hotelname` varchar(100) NOT NULL,
  `hotelpin` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adminsignup`
--

INSERT INTO `adminsignup` (`id`, `name`, `email`, `password`, `number`, `hotelname`, `hotelpin`, `created_at`) VALUES
(1, 'Admin', 'admin1@example.com', '$2y$10$1lhCvDlwofvmRzi3pHk1xOgxJBUeMRTkIXJ1GcZn5GrM9a2l9Hvvi', '9876543210', 'Hotel XYZ', 'XYZ1234', '2025-07-08 04:43:32'),
(3, 'Jjjjjj', 'Jjj@gmail.com', '$2y$10$drEg1UpcGVOEp4u0XaWebuXMNJc168beHR.tR3qnZnA9sRCCtwJZ.', '9759423844', 'Accord Chrome', 'AN987', '2025-07-08 06:09:43'),
(4, 'Bhuvi', 'Bhuvi@gmail.com', '$2y$10$IWclfDQ1krVFI/EuQMyWaOwZT0m1k/ooJ1rx8FdzU7yAPt.WqPQBu', '999999999', 'Chippy Inn', 'BH999VI', '2025-07-08 08:45:59'),
(7, 'Sharing', 'Sharini@gmail.com', '$2y$10$J43tZo/orxYyr4T3OAeNvOgFzUmuVZ/AycsYv0tgePOK7Aykmdh3u', '7896542556', 'FabHotel Vijaylakshmi', 'VB852', '2025-07-08 09:48:20'),
(11, 'Bccs', 'Hsvh@gmail.com', '$2y$10$4sjvndBPPU5nV1KonnZlWe8mpzQcgxXBi9GGFMXIwA1vUUsyo5m2i', '4758961235', 'FabHotel HomeTreeService Apartment', 'FA456', '2025-07-14 04:50:19'),
(12, '', '', '$2y$10$ThC8Vl1sC8gPGaFOye8cZe34OwTif8/Ne/0y2xl5b/8L8fo8BB996', '', '', '', '2025-07-14 04:56:41'),
(13, 'Fghbfcn', 'Sdb@gmail.com', '$2y$10$NuaqztOvOoYjeg4X.S6JKOfr1BQFSPVwqiDeMVqd8sRBiyzm0swR2', '4563217895', '', '', '2025-07-14 04:58:21'),
(14, 'Hjgfzgxv', 'Jxbsgc@gmail.com', '$2y$10$m2Nopt5GMHQ3wQKLU1LDduxH9GzQt1IHqqpV/5b2sdtKwBvl67peG', '1452665789', 'ITC Grand Chola', 'IT456', '2025-07-14 08:43:23'),
(15, 'Relief', 'Bg@gamil.com', '$2y$10$Ed4dTdhfFp2G/OVCeyxIyuN1J8a1gjyMGPK9QJxR7joc1JdV/cj.2', '4785123654', 'Hilton Chennai', 'HI89', '2025-07-14 08:47:24'),
(16, 'Kvfxnkj', 'Bhx@gamil.com', '$2y$10$a/m5zWEBMZl5.tvHjauOh.MnnNnHWKwXBm3wVuIo8TJS.BDbV1g/m', '4785123654', '', '', '2025-07-14 08:50:10'),
(17, 'Sdad', 'Xna@gmail.com', '$2y$10$EO7YMfCEgIOMNF4y/6ki7uKXHaFFiRb3rv0WozWqnjNdIOdN4howC', '4785123654', 'Novotel Chennai', 'NO16', '2025-07-14 09:49:55'),
(18, 'Cjgdjyc', 'Jxmhd@gamil.com', '$2y$10$HTW8GcV5cOyn9Q2amT9i3eq3.xRibC05j5BbLERYy6jEuIjEL4odG', '1452367895', 'Accord Chrome', 'AC34', '2025-07-14 10:19:08'),
(19, 'Dang', 'Fhdfd@gmail.com', '$2y$10$lUG8lMzkC95HzEDNEPzsyO4rw54.16QiVooXCH/s7TiODoAqMIEtS', '7845123695', 'ITC Grand Chola', 'IT567', '2025-07-14 10:26:57');

-- --------------------------------------------------------

--
-- Table structure for table `hotelbooking`
--

CREATE TABLE `hotelbooking` (
  `email` varchar(300) NOT NULL DEFAULT '""',
  `hotelname` varchar(300) NOT NULL DEFAULT '""',
  `rooms` int(255) NOT NULL DEFAULT 0,
  `aadhar` varchar(300) NOT NULL DEFAULT '""',
  `address` varchar(300) NOT NULL DEFAULT '""',
  `date` varchar(300) NOT NULL DEFAULT '""',
  `price` varchar(300) NOT NULL DEFAULT '""',
  `id` varchar(300) NOT NULL DEFAULT '""',
  `guest` varchar(300) NOT NULL DEFAULT '""'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelbooking`
--

INSERT INTO `hotelbooking` (`email`, `hotelname`, `rooms`, `aadhar`, `address`, `date`, `price`, `id`, `guest`) VALUES
('bhuvi@gmail.com', 'paramount Inn', 2, '2345 456 456', 'no,34 sr', '09-07-2025', '5000', '19', '2'),
('bhuvi@gmail.com', 'paramount Inn', 2, '2345 625 324', 'No,45 kjsdjkkdjs', '2025-07-10', '36000', 'E6F1898C-A0E8-44CD-8B14-1A2515731715', '3'),
('bhuvi@gmail.com', 'paramount Inn', 1, '7868 687 686', 'No,76 fsdbhdm', '2025-07-11', '6000', '923A57AC-52A6-4893-9270-4AD623987714', '2'),
('bhuvi@gmail.com', 'paramount Inn', 1, '1254 548 544', 'No,45 mkfjvjnnkbshbc', '2025-07-14', '3000', '5DCBB39B-BE89-48E1-B0FD-BD6BB74801E8', '2'),
('bhuvi@gmail.com', 'paramount Inn', 2, '3456 675 766', 'No,09 hdwhgdhgwan', '2025-07-14', '6000', 'FDBA0BD0-F4DA-4A75-A769-CC2781C6761B', '2');

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `price` varchar(50) NOT NULL,
  `main_image` varchar(255) DEFAULT NULL,
  `room_image1` varchar(255) DEFAULT NULL,
  `room_image2` varchar(255) DEFAULT NULL,
  `room_image3` varchar(255) DEFAULT NULL,
  `nearby_place1` varchar(255) DEFAULT NULL,
  `nearby_place2` varchar(255) DEFAULT NULL,
  `nearby_image1` varchar(255) DEFAULT NULL,
  `nearby_image2` varchar(255) DEFAULT NULL,
  `rooms_available` int(11) DEFAULT 0,
  `added_on` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`id`, `name`, `address`, `price`, `main_image`, `room_image1`, `room_image2`, `room_image3`, `nearby_place1`, `nearby_place2`, `nearby_image1`, `nearby_image2`, `rooms_available`, `added_on`) VALUES
(8, 'The Saibaba Hotel', 'Main Road', '2500', 'uploads/686cef285dedf_main_image.jpg', 'uploads/686cef285e05e_room_image1.jpg', 'uploads/686cef285e09e_room_image2.jpg', 'uploads/686cef285e0d5_room_image3.jpg', 'Temple', 'Market', 'uploads/686cef285e108_nearby_image1.jpg', 'uploads/686cef285e13c_nearby_image2.jpg', 5, '2025-07-08 10:12:56'),
(18, 'The RainTree', 'No.34 perusal look street,Chennai', '3000', 'uploads/686e08634e7c5_main_image.jpg', 'uploads/686e08634ebd8_room_image1.jpg', 'uploads/686e08634ec2a_room_image2.jpg', 'uploads/686e08634ec6f_room_image3.jpg', 'Temple', 'Market', 'uploads/686e08634ecb9_nearby_image1.jpg', 'uploads/686e08634ecf5_nearby_image2.jpg', 5, '2025-07-09 06:12:51'),
(19, 'paramount Inn', 'No89,Bengaluru_chennai Road,Sriperumbudur', '12000', 'uploads/686e10d453f1c_main_image.jpg', 'uploads/686e10d454163_room_image1.jpg', 'uploads/686e10d4541a6_room_image2.jpg', 'uploads/686e10d454250_room_image3.jpg', 'Temple', 'Market', 'uploads/686e10d45428a_nearby_image1.jpg', 'uploads/686e10d4542c5_nearby_image2.jpg', 5, '2025-07-09 06:48:52'),
(50, 'Hilton Chennai', 'No34, bsavxcs', '4000', 'uploads/6874d9c785313_main_image.jpg', 'uploads/6874d9c78562d_room_image1.jpg', 'uploads/6874d9c785679_room_image2.jpg', 'uploads/6874d9c7856bc_room_image3.jpg', 'Temple', 'Market', 'uploads/6874d9c7856f7_nearby_image1.jpg', 'uploads/6874d9c785732_nearby_image2.jpg', 5, '2025-07-14 10:19:51');

-- --------------------------------------------------------

--
-- Table structure for table `room_availability`
--

CREATE TABLE `room_availability` (
  `id` int(11) NOT NULL,
  `hotel_name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `available_rooms` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_availability`
--

INSERT INTO `room_availability` (`id`, `hotel_name`, `date`, `available_rooms`) VALUES
(1, 'ITC Grand Chola', '2025-07-08', 15);

-- --------------------------------------------------------

--
-- Table structure for table `signup`
--

CREATE TABLE `signup` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `number` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `signup`
--

INSERT INTO `signup` (`id`, `name`, `email`, `password`, `number`, `role`, `created_at`) VALUES
(1, 'bhuvi', 'bhuvi@gmail.com', '$2y$10$p79E8vPqGaZM/NfsCrX1xu.eL2oWvHzT4HXxv/7Qnzabzzon8tmou', '1234567899', 'user', '2025-07-08 04:42:08'),
(7, 'John', 'John@gmail.com', '$2y$10$FG2.PtumBq19PEYLHpjU2O.Fo6fJ4TRAIiI4rxiGSbBtsQEyY.eUe', '9688771508', 'user', '2025-07-09 05:58:42'),
(8, 'Gfhfb', 'Kolkka@gmail.com', '$2y$10$AUHNGXH7vteHS028FztvFuVqkY3ouK1qX/wgqMSvMFIDrTY76lfra', '4567892341', 'user', '2025-07-09 10:44:40'),
(17, 'Bccs', 'Ba@gmail.com', '$2y$10$YjZ3Wc3plhoO3OAbIVL7dORZdf3hXYEzSlg2MEqssHBKSJ3v2t5D6', '4758961235', 'user', '2025-07-14 04:49:53'),
(18, 'Fghbfcn', 'Sdb@gmail.com', '$2y$10$7oBChODGHsqUcr6mqvWDA.zb/8Tmtd59n66pqMKdSgFFz8xo0/x3e', '4563217895', 'user', '2025-07-14 04:57:34'),
(20, 'bhuvi99', '90@gmail.com', '1234', '1234567899', 'user', '2025-07-14 05:19:42'),
(21, 'Cow', 'Cow@gmail.com', '1234', '963852741', 'user', '2025-07-14 05:48:52'),
(22, 'Adds', 'Sfg@gmail.com', '1234', '1452365123', 'user', '2025-07-14 06:28:05'),
(23, 'Relief', 'Bg@gamil.com', '2345', '4785123654', 'user', '2025-07-14 08:47:39');

-- --------------------------------------------------------

--
-- Table structure for table `validatepin`
--

CREATE TABLE `validatepin` (
  `id` int(11) NOT NULL,
  `hotel_name` varchar(255) NOT NULL,
  `hotel_pin` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adminsignup`
--
ALTER TABLE `adminsignup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_availability`
--
ALTER TABLE `room_availability`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_hotel_date` (`hotel_name`,`date`);

--
-- Indexes for table `signup`
--
ALTER TABLE `signup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `validatepin`
--
ALTER TABLE `validatepin`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adminsignup`
--
ALTER TABLE `adminsignup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `room_availability`
--
ALTER TABLE `room_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `signup`
--
ALTER TABLE `signup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `validatepin`
--
ALTER TABLE `validatepin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
