-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 12, 2024 at 01:36 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kampeling`
--

-- --------------------------------------------------------

--
-- Table structure for table `sampah`
--

CREATE TABLE `sampah` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(255) DEFAULT NULL,
  `harga_nasabah` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sampah`
--

INSERT INTO `sampah` (`id`, `nama_barang`, `harga_nasabah`) VALUES
(1, 'Aki', 4500.00),
(2, 'Alumunium/kaleng minuman', 6500.00),
(3, 'Babed', 2000.00),
(4, 'Besi/Besi krom', 1500.00),
(5, 'Beling/botol beling', 1500.00),
(6, 'Botol kecap', 2500.00),
(7, 'Botol bir import', 500.00),
(8, 'Botol plastik Bersih tanpa label', 2500.00),
(9, 'Botol kotor', 1500.00),
(10, 'Boncos', 250.00),
(11, 'Buku campur', 800.00),
(12, 'Ember campur', 1500.00),
(13, 'Gelas plastik bening bersih', 2000.00),
(14, 'Gelas plastik kotor', 1000.00),
(15, 'Impact/Kaset tape', 500.00),
(16, 'Kaleng seng', 1800.00),
(17, 'Kardus', 1500.00),
(18, 'Karpet/Talaniar', 600.00),
(19, 'Keping CD', 1800.00),
(20, 'Kristal putih', 1800.00),
(21, 'Koran', 1000.00),
(22, 'Kertas putihan (HVS/SWL)', 1000.00),
(23, 'Kertas Semen', 1000.00),
(24, 'Kuningan', 12000.00),
(25, 'Kabel/Selang air/Paralon', 600.00),
(26, 'Majalah', 1000.00),
(27, 'PE/Plastik bening', 500.00),
(28, 'Kawat', 300.00),
(29, 'Tembaga', 30000.00),
(30, 'Tutup Botol', 1800.00),
(31, 'Tutup Galon LD', 1500.00),
(32, 'TV (per unit)', 18000.00),
(33, 'Tetrapack', 400.00),
(34, 'Minyak Jelantah', 2000.00),
(35, 'ASOY', 150.00),
(36, 'KRESEK', 150.00),
(37, 'LABEL', 150.00),
(38, 'Ember Hitam', 650.00),
(39, 'Mesin Cuci', 15000.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'jawa', '$2y$10$o9oxxS1hgfi.hrDPwW8ao.oLX522boru1A58rbMGr5MdqrFfIPJHe', 'admin'),
(2, 'user1', '$2y$10$iO8Gd5/ItAhL6YUXrK73Be5h1XS/wOSFBxAe8JHa7zA55fLiNMj5m', 'user'),
(3, 'farrel', '$2y$10$LVbwTkIXrEcLu2tyjwaNwu3gZme7fPQUXJlQZVH1p9C6uKWSQ9wJq', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `user_saldo`
--

CREATE TABLE `user_saldo` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_berat` decimal(10,2) DEFAULT NULL,
  `total_saldo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_saldo`
--

INSERT INTO `user_saldo` (`id`, `user_id`, `total_berat`, `total_saldo`) VALUES
(1, 2, 14.00, 35100.00),
(2, 3, 69.00, 73500.00);

-- --------------------------------------------------------

--
-- Table structure for table `user_sampah`
--

CREATE TABLE `user_sampah` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nama_barang` varchar(255) DEFAULT NULL,
  `harga_nasabah` decimal(10,2) DEFAULT NULL,
  `berat_kg` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `tanggal_setor` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_sampah`
--

INSERT INTO `user_sampah` (`id`, `user_id`, `nama_barang`, `harga_nasabah`, `berat_kg`, `total`, `tanggal_setor`) VALUES
(1, 1, 'Aki', 4500.00, 3.00, 13500.00, '2024-10-08'),
(2, 2, 'Aki', 4500.00, 2.00, 9000.00, '2024-10-08'),
(3, 2, 'Gelas plastik bening bersih', 2000.00, 5.00, 10000.00, '2024-10-08'),
(4, 2, 'Kardus', 1500.00, 4.00, 6000.00, '2024-10-08'),
(5, 3, 'Kardus', 1500.00, 10.00, 15000.00, '2024-10-09'),
(6, 3, 'Botol kotor', 1500.00, 5.00, 7500.00, '2024-10-09'),
(7, 3, 'Botol bir import', 500.00, 50.00, 25000.00, '2024-10-09'),
(8, 2, 'Keping CD', 1800.00, 2.00, 3600.00, '2024-10-10'),
(9, 2, 'Alumunium/kaleng minuman', 6500.00, 1.00, 6500.00, '2024-10-10'),
(10, 3, 'Alumunium/kaleng minuman', 6500.00, 4.00, 26000.00, '2024-10-10'),
(11, 2, 'Alumunium/kaleng minuman', 6500.00, 2.00, 13000.00, '2024-10-12'),
(12, 2, 'Babed', 2000.00, 2.00, 4000.00, '2024-10-12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sampah`
--
ALTER TABLE `sampah`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_saldo`
--
ALTER TABLE `user_saldo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_sampah`
--
ALTER TABLE `user_sampah`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sampah`
--
ALTER TABLE `sampah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_saldo`
--
ALTER TABLE `user_saldo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_sampah`
--
ALTER TABLE `user_sampah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_saldo`
--
ALTER TABLE `user_saldo`
  ADD CONSTRAINT `user_saldo_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_sampah`
--
ALTER TABLE `user_sampah`
  ADD CONSTRAINT `user_sampah_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
