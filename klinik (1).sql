-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 03, 2025 at 03:11 PM
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
-- Database: `klinik`
--

-- --------------------------------------------------------

--
-- Table structure for table `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` varchar(10) NOT NULL,
  `nama_dokter` varchar(100) DEFAULT NULL,
  `spesialisasi` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `no_telepon` varchar(15) DEFAULT NULL,
  `id_user` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dokter`
--

INSERT INTO `dokter` (`id_dokter`, `nama_dokter`, `spesialisasi`, `email`, `no_telepon`, `id_user`) VALUES
('DG001', 'dr.Diana', 'dr.Sp Gigi', 'diana@gmail.com', '082345678901', 'D002'),
('DG002', 'dr.Rudi', 'dr.Sp Gigi', 'rudi@gmail.com', '086789012345', 'D006'),
('DK001', 'dr.Eva', 'dr.Sp Kulit dan Kelamin', 'eva@gmail.com', '084324514215', 'D004'),
('DU001', 'dr.Arief', 'dr.Umum', 'arief@gmail.com', '081234567890', 'D001'),
('DU002', 'dr.Budi', 'dr.Umum', 'Budi@gmail.com', '083456789012', 'D003'),
('DU003', 'dr.Siti', 'dr.Umum', 'siti@gmail.com', '085672327632', 'D005');

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id_pasien` varchar(10) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `nomor_telepon` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id_pasien`, `nama`, `tanggal_lahir`, `jenis_kelamin`, `alamat`, `nomor_telepon`) VALUES
('P0001', 'Santoso', '1990-01-10', 'Laki-laki', 'Jl. Merdeka No. 5', '081234567890'),
('P0002', 'Aminah', '2001-08-15', 'Perempuan', 'Jl. Sukarno No. 8', '082345678901'),
('P0003', 'Nugroho', '2010-03-20', 'Laki-laki', 'Jl. Sudirman No. 10', '083456789012'),
('P0004', 'Wijaya', '1993-07-25', 'Perempuan', 'Jl. Merdeka No. 15', '084567890123'),
('P0005', 'Lestari', '1980-02-12', 'Perempuan', 'Jl. Raya No. 5', '085678901234'),
('P0006', 'Tio Pratama', '1991-06-17', 'Laki-laki', 'Jl. Pahlawan No. 7', '086789012345'),
('P0007', 'Putri', '2017-09-30', 'Perempuan', 'Jl. Bahagia No. 2', '087890123456'),
('P0008', 'Nanda', '1988-11-03', 'Laki-laki', 'Jl. Melati No. 6', '088901234567'),
('P0009', 'Rudi Kurniawan', '1995-05-25', 'Laki-laki', 'Jl. Merdeka No. 25', '089012345678'),
('P0010', 'Tina Ayu', '2015-12-10', 'Perempuan', 'Jl. Anggrek No. 20', '081234567890'),
('P0011', 'Rahman', '1999-07-05', 'Laki-laki', 'Jl. Proklamasi No. 12', '082345678901'),
('P0012', 'Lina', '1992-08-22', 'Perempuan', 'Jl. Merdeka No. 30', '083456789012'),
('P0013', 'Doni', '1998-01-17', 'Laki-laki', 'Jl. Raya No. 3', '084567890123'),
('P0014', 'Widya', '2002-04-02', 'Perempuan', 'Jl. Cendana No. 4', '085678901234'),
('P0015', 'Joko', '1994-10-28', 'Laki-laki', 'Jl. Sejahtera No. 8', '086789012345'),
('P0016', 'Sunani', '1990-07-01', 'Laki-laki', 'jl.Imam Bonjol, Jakarta', '08351889912'),
('P0018', 'Ilham', '2001-01-23', 'Laki-laki', 'jl.kanan kiri, depok', '08218878312'),
('P0030', 'Susanti', '2006-09-10', 'Perempuan', 'Jakarta', '07437672623');

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran`
--

CREATE TABLE `pendaftaran` (
  `id_pendaftaran` varchar(10) NOT NULL,
  `id_pasien` varchar(10) DEFAULT NULL,
  `id_dokter` varchar(10) DEFAULT NULL,
  `tanggal_pendaftaran` date DEFAULT NULL,
  `antrian` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pendaftaran`
--

INSERT INTO `pendaftaran` (`id_pendaftaran`, `id_pasien`, `id_dokter`, `tanggal_pendaftaran`, `antrian`) VALUES
('D0012', 'P0030', 'DU001', '2025-01-03', '2'),
('DF0001', 'P0030', 'DK001', '2025-01-03', '1'),
('PD001', 'P0001', 'DU001', '2024-09-19', '1'),
('PD002', 'P0002', 'DK001', '2024-12-15', '2'),
('PD003', 'P0003', 'DG001', '2024-12-15', ''),
('PD004', 'P0004', 'DU002', '2024-09-19', ''),
('PD005', 'P0005', 'DK001', '2024-09-19', ''),
('PD006', 'P0005', 'DK001', '2024-09-10', ''),
('PD007', 'P0006', 'DG002', '2024-08-11', ''),
('PD008', 'P0007', 'DU003', '2024-09-19', ''),
('PD009', 'P0008', 'DK001', '2024-10-20', ''),
('PD010', 'P0009', 'DG002', '2024-08-11', ''),
('PD011', 'P0010', 'DU001', '2024-11-11', ''),
('PD012', 'P0011', 'DK001', '2024-05-05', ''),
('PD013', 'P0012', 'DG002', '2024-05-05', ''),
('PD014', 'P0013', 'DU003', '2024-12-21', ''),
('PD015', 'P0014', 'DK001', '2024-12-21', ''),
('PD016', 'P0003', 'DG001', '2024-12-21', ''),
('PD017', 'P0009', 'DU001', '2024-11-11', ''),
('PD019', 'P0008', 'DK001', '2024-10-27', ''),
('PD020', 'P0008', 'DG002', '2024-09-10', ''),
('PD021', 'P0018', 'DK001', '2025-01-03', '1');

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id_user` varchar(10) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('Admin','Dokter') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id_user`, `nama`, `email`, `password`, `role`) VALUES
('A001', 'Admin', 'admin@gmail.com', 'Admin', 'Admin'),
('D001', 'Dr. Arief', 'arief@gmail.com', 'Arief', 'Dokter'),
('D002', 'Dr. Diana', 'diana@gmail.com', 'Diana', 'Dokter'),
('D003', 'Dr. Budi', 'Budi@gmail.com', 'Budi', 'Dokter'),
('D004', 'Dr. Eva', 'eva@gmail.com', 'Eva', 'Dokter'),
('D005', 'Dr. Siti', 'siti@gmail.com', 'Siti', 'Dokter'),
('D006', 'Dr. Rudi', 'rudi@gmail.com', 'Rudi', 'Dokter');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_pasien`
--

CREATE TABLE `riwayat_pasien` (
  `id_riwayat` varchar(10) NOT NULL,
  `id_pasien` varchar(10) DEFAULT NULL,
  `id_dokter` varchar(10) DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `pengobatan` text DEFAULT NULL,
  `total_biaya` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `riwayat_pasien`
--

INSERT INTO `riwayat_pasien` (`id_riwayat`, `id_pasien`, `id_dokter`, `diagnosis`, `pengobatan`, `total_biaya`) VALUES
('R001', 'P0001', 'DU001', 'Flu dan demam', 'Obat penurun panas (Paracetamol) dan banyak istirahat', 0),
('R002', 'P0002', 'DK001', 'Dermatitis atopik', 'Penggunaan krim kortikosteroid dan pelembap kulit', 0),
('R003', 'P0003', 'DG001', 'Penyakit gusi (gingivitis)', 'Pembersihan karang gigi dan penggunaan obat kumur antiseptik', 0),
('R004', 'P0004', 'DU002', 'Infeksi saluran pernapasan atas', 'Antibiotik dan obat batuk', 0),
('R005', 'P0005', 'DK001', 'Jerawat ringan', 'Krim topikal dengan asam salisilat dan rutinitas perawatan kulit', 0),
('R006', 'P0005', 'DK001', 'Jerawat ringan', 'Krim topikal dengan asam salisilat dan rutinitas perawatan kulit', 0),
('R007', 'P0006', 'DG002', 'Gigi sensitif', 'Penggunaan pasta gigi desensitisasi dan kontrol suhu makanan', 0),
('R008', 'P0007', 'DU003', 'Penyakit maag', 'Obat antasida dan pengaturan pola makan', 0),
('R009', 'P0008', 'DK001', 'Infeksi jamur pada kulit', 'Obat antifungal oral dan krim topikal', 0),
('R010', 'P0009', 'DG002', 'Gigi berlubang pada gigi geraham', 'Tambal gigi dan perawatan saluran akar', 0),
('R011', 'P0010', 'DU001', 'Sakit kepala migrain', 'Obat antiinflamasi non-steroid (Ibuprofen) dan pengaturan pola tidur', 0),
('R012', 'P0011', 'DK001', 'Infeksi jamur pada kulit', 'Obat antifungal oral dan krim topikal', 0),
('R013', 'P0012', 'DG002', 'Periodontitis', 'Pembersihan karang gigi, antibiotik, dan pembedahan gusi', 0),
('R014', 'P0013', 'DU003', 'Flu dan demam', 'Obat penurun panas (Paracetamol) dan banyak istirahat', 0),
('R015', 'P0014', 'DK001', 'Infeksi jamur pada kulit', 'Obat antifungal oral dan krim topikal', 0),
('R016', 'P0003', 'DG001', 'Periodontitis', 'Pembersihan karang gigi, antibiotik, dan pembedahan gusi', 0),
('R017', 'P0009', 'DU001', 'Hipertensi', 'Obat antihipertensi (Amlodipine) dan diet rendah garam', 0),
('R018', 'P0008', 'DK001', 'Psoriasis', 'Krim kortikosteroid dan fototerapi', 0),
('R019', 'P0008', 'DG002', 'Penyakit gusi (gingivitis)', 'Pembersihan karang gigi dan penggunaan obat kumur antiseptik', 0),
('R020', 'P0015', 'DU001', 'Eksim', 'Obat Oles', 0);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` varchar(10) NOT NULL,
  `id_pasien` varchar(10) DEFAULT NULL,
  `id_dokter` varchar(10) DEFAULT NULL,
  `biaya_dokter` int(11) DEFAULT NULL,
  `tanggal_transaksi` date DEFAULT NULL,
  `biaya_obat` int(11) NOT NULL,
  `total_biaya` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_pasien`, `id_dokter`, `biaya_dokter`, `tanggal_transaksi`, `biaya_obat`, `total_biaya`) VALUES
('TF001', 'P0001', 'DU001', 150000, '2024-09-19', 0, 0),
('TF002', 'P0002', 'DK001', 300000, '2024-12-15', 0, 0),
('TF003', 'P0003', 'DG001', 890000, '2024-12-15', 0, 0),
('TF004', 'P0004', 'DU002', 350000, '2024-09-19', 0, 0),
('TF005', 'P0005', 'DK001', 550000, '2024-09-19', 0, 0),
('TF006', 'P0005', 'DK001', 550000, '2024-09-10', 0, 0),
('TF007', 'P0006', 'DG002', 350000, '2024-08-11', 0, 0),
('TF008', 'P0007', 'DU003', 150000, '2024-09-19', 0, 0),
('TF009', 'P0008', 'DK001', 270000, '2024-10-20', 0, 0),
('TF010', 'P0009', 'DG002', 1850000, '2024-08-11', 0, 0),
('TF011', 'P0010', 'DU001', 230000, '2024-11-11', 0, 0),
('TF012', 'P0011', 'DK001', 270000, '2024-05-05', 0, 0),
('TF013', 'P0012', 'DG002', 3500000, '2024-05-05', 0, 0),
('TF014', 'P0013', 'DU003', 150000, '2024-12-21', 0, 0),
('TF015', 'P0014', 'DK001', 270000, '2024-12-21', 0, 0),
('TF016', 'P0003', 'DG001', 3500000, '2024-12-21', 0, 0),
('TF017', 'P0009', 'DU001', 350000, '2024-11-11', 0, 0),
('TF018', 'P0008', 'DK001', 400000, '2024-10-27', 0, 0),
('TF019', 'P0008', 'DG002', 890000, '2024-09-10', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id_pasien`);

--
-- Indexes for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD PRIMARY KEY (`id_pendaftaran`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `riwayat_pasien`
--
ALTER TABLE `riwayat_pasien`
  ADD PRIMARY KEY (`id_riwayat`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dokter`
--
ALTER TABLE `dokter`
  ADD CONSTRAINT `dokter_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `pengguna` (`id_user`);

--
-- Constraints for table `pendaftaran`
--
ALTER TABLE `pendaftaran`
  ADD CONSTRAINT `pendaftaran_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`),
  ADD CONSTRAINT `pendaftaran_ibfk_2` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`);

--
-- Constraints for table `riwayat_pasien`
--
ALTER TABLE `riwayat_pasien`
  ADD CONSTRAINT `riwayat_pasien_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`),
  ADD CONSTRAINT `riwayat_pasien_ibfk_2` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
