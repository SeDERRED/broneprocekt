-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2025 at 12:21 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel2`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `canceled` tinyint(1) DEFAULT 0,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `room_id`, `start_date`, `end_date`, `canceled`, `user_id`) VALUES
(3, 1, '2025-12-01', '2025-12-02', 1, 3),
(4, 1, '2025-12-02', '2025-12-03', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `Type` varchar(150) NOT NULL,
  `Room` varchar(150) NOT NULL,
  `Vacant` tinyint(1) NOT NULL,
  `Price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `Name`, `Type`, `Room`, `Vacant`, `Price`) VALUES
(1, 'E-112', 'Single', 'Economy', 0, 100),
(2, 'E-212', 'Double', 'Economy', 1, 200),
(3, 'E-213', 'Single', 'Luxary', 1, 200),
(4, 'E-312', 'Triple', 'President Lux', 1, 500);

-- --------------------------------------------------------

--
-- Table structure for table `room_details`
--

CREATE TABLE `room_details` (
  `room_id` int(11) NOT NULL,
  `sq_m` int(11) NOT NULL,
  `wifi` varchar(150) NOT NULL,
  `air_conditioning` tinyint(1) NOT NULL,
  `bed_number` int(11) NOT NULL,
  `more` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_details`
--

INSERT INTO `room_details` (`room_id`, `sq_m`, `wifi`, `air_conditioning`, `bed_number`, `more`) VALUES
(1, 10, 'Free Wi-Fi', 1, 1, 'Shower\r\nSafe\r\nToilet\r\nTowels\r\nPower outlet near the bed\r\nCleaning supplies\r\nDesk\r\nTV\r\nHair dryer\r\nCable channels\r\nWardrobe\r\nToilet paper'),
(2, 16, 'Free Wi-Fi', 1, 2, 'Shower\r\nSafe\r\nToilet\r\nTowels\r\nPower outlet near the bed\r\nCleaning supplies\r\nDesk\r\nTV\r\nHair dryer\r\nCable channels\r\nWardrobe\r\nToilet paper'),
(3, 16, 'Free Wi-Fi', 1, 2, 'Shower\r\nSafe\r\nToilet\r\nTowels\r\nPower outlet near the bed\r\nCleaning supplies\r\nDesk\r\nTV\r\nHair dryer\r\nCable channels\r\nWardrobe\r\nToilet paper'),
(4, 20, 'Free Wi-Fi', 1, 3, 'Shower\r\nSafe\r\nToilet\r\nTowels\r\nPower outlet near the bed\r\nCleaning supplies\r\nDesk\r\nTV\r\nHair dryer\r\nCable channels\r\nWardrobe\r\nToilet paper');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('USER','ADMIN') DEFAULT 'USER'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'admin', '1234', 'ADMIN'),
(2, 'babyjom', 'f', 'USER'),
(3, 'new', '1', 'USER');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `owner` (`user_id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_details`
--
ALTER TABLE `room_details`
  ADD KEY `rooms_id` (`room_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  ADD CONSTRAINT `owner` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `room_details`
--
ALTER TABLE `room_details`
  ADD CONSTRAINT `rooms_id` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
