-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2025 at 11:27 AM
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
(4, 1, '2025-12-02', '2025-12-03', 1, 3),
(5, 1, '2025-12-18', '2025-12-25', 1, 3),
(6, 2, '2025-12-10', '2025-12-11', 1, 3),
(7, 2, '2025-12-18', '2025-12-31', 1, 3),
(8, 1, '2025-12-18', '2025-12-31', 1, 2),
(9, 4, '2025-12-24', '2026-01-08', 1, 4);

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
(1, 'E-112', 'Single', 'Economy', 1, 100),
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
  `more` varchar(1000) NOT NULL,
  `rating` float NOT NULL,
  `reviews` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_details`
--

INSERT INTO `room_details` (`room_id`, `sq_m`, `wifi`, `air_conditioning`, `bed_number`, `more`, `rating`, `reviews`) VALUES
(1, 10, 'Free Wi-Fi', 1, 1, 'Shower\r\nSafe\r\nToilet\r\nTowels\r\nPower outlet near the bed\r\nCleaning supplies\r\nDesk\r\nTV\r\nHair dryer\r\nCable channels\r\nWardrobe\r\nToilet paper', 4, 4),
(2, 16, 'Free Wi-Fi', 1, 2, 'Shower\r\nSafe\r\nToilet\r\nTowels\r\nPower outlet near the bed\r\nCleaning supplies\r\nDesk\r\nTV\r\nHair dryer\r\nCable channels\r\nWardrobe\r\nToilet paper', 3, 2),
(3, 16, 'Free Wi-Fi', 1, 2, 'Shower\r\nSafe\r\nToilet\r\nTowels\r\nPower outlet near the bed\r\nCleaning supplies\r\nDesk\r\nTV\r\nHair dryer\r\nCable channels\r\nWardrobe\r\nToilet paper', 3, 1),
(4, 20, 'Free Wi-Fi', 1, 3, 'Shower\r\nSafe\r\nToilet\r\nTowels\r\nPower outlet near the bed\r\nCleaning supplies\r\nDesk\r\nTV\r\nHair dryer\r\nCable channels\r\nWardrobe\r\nToilet paper', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `room_reviews`
--

CREATE TABLE `room_reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_reviews`
--

INSERT INTO `room_reviews` (`id`, `user_id`, `room_id`, `rating`, `comment`, `created_at`) VALUES
(1, 3, 1, 5, 'Very good!', '2025-12-15 06:09:32'),
(2, 2, 1, 4, 'Not the best, but also good!', '2025-12-15 06:21:48'),
(3, 4, 1, 2, 'reffff', '2025-12-15 06:24:32'),
(4, 5, 1, 5, 'I like this room so much!', '2025-12-15 06:37:35'),
(5, 3, 4, 4, 'Good!\r\n', '2025-12-15 07:05:16'),
(6, 3, 2, 1, 'очень плохо', '2025-12-15 07:14:53'),
(7, 3, 3, 3, 'Not bad', '2025-12-15 07:15:28'),
(8, 4, 2, 5, 'very\r\ngoooooooood', '2025-12-15 07:16:20');

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
(3, 'new', '1', 'USER'),
(4, 'seder', '2', 'USER'),
(5, 'klin', '1234', 'USER');

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
-- Indexes for table `room_reviews`
--
ALTER TABLE `room_reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_room` (`user_id`,`room_id`),
  ADD KEY `fk_review_room` (`room_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `room_reviews`
--
ALTER TABLE `room_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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

--
-- Constraints for table `room_reviews`
--
ALTER TABLE `room_reviews`
  ADD CONSTRAINT `fk_review_room` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
