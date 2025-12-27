-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 27 déc. 2025 à 18:32
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `testrestapi`
--

-- --------------------------------------------------------

--
-- Structure de la table `notes`
--

CREATE TABLE `notes` (
  `note_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note_title` varchar(250) NOT NULL,
  `note_content` text NOT NULL,
  `note_image` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `notes`
--

INSERT INTO `notes` (`note_id`, `user_id`, `note_title`, `note_content`, `note_image`) VALUES
(31, 0, 'fgdg........................', 'dfdfdf get', '718_scaled_c3e55b22-4e67-4337-9f13-70f3692be9b2.jpg'),
(32, 0, 'fgdg........................', 'dfdfdf get', '294_scaled_c3e55b22-4e67-4337-9f13-70f3692be9b2.jpg'),
(34, 20, 'ooo----------===', 'oooo-----------', '305_scaled_dd0096b3-ec1d-4b88-a01c-7d86dc71c7fa.jpg'),
(35, 20, 'opiop.........', 'kjkjkt', '679_scaled_c3e55b22-4e67-4337-9f13-70f3692be9b2.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `user_name`) VALUES
(8, 'soumia@gmail.com', '123456', 'soumia'),
(13, 'uuuuuu@gmail.com', '123456', 'soumia'),
(16, 'goum@gmail.com', '123456', 'goum'),
(17, 'first.com', 'first', 'first'),
(18, '11@gmail.com', '111', '11'),
(19, 'eee@gmail.com', 'eeee', 'eee'),
(20, 'goumgoum@gmail.com', '123456', 'goumgoum');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`note_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `notes`
--
ALTER TABLE `notes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
