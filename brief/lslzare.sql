-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 15 mars 2021 à 13:45
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `lslzare`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `num_cat` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(10) DEFAULT NULL,
  `salair` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `employer`
--

DROP TABLE IF EXISTS `employer`;
CREATE TABLE IF NOT EXISTS `employer` (
  `num_emp` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(10) DEFAULT NULL,
  `sexe` varchar(10) DEFAULT NULL,
  `num_cat` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_emp`),
  KEY `num_cat` (`num_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `local_`
--

DROP TABLE IF EXISTS `local_`;
CREATE TABLE IF NOT EXISTS `local_` (
  `num_local` int(11) NOT NULL AUTO_INCREMENT,
  `num_pay` int(11) DEFAULT NULL,
  `num_part` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_local`),
  KEY `num_pay` (`num_pay`,`num_part`),
  KEY `num_part` (`num_part`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `partenaires`
--

DROP TABLE IF EXISTS `partenaires`;
CREATE TABLE IF NOT EXISTS `partenaires` (
  `num_part` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(10) DEFAULT NULL,
  `budget` double DEFAULT NULL,
  `num_t` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_part`),
  KEY `num_t` (`num_t`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `payes`
--

DROP TABLE IF EXISTS `payes`;
CREATE TABLE IF NOT EXISTS `payes` (
  `num_pay` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`num_pay`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

DROP TABLE IF EXISTS `projet`;
CREATE TABLE IF NOT EXISTS `projet` (
  `num_pro` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(10) DEFAULT NULL,
  `budget` int(11) DEFAULT NULL,
  `num_emp` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_pro`),
  KEY `num_emp` (`num_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `realisation`
--

DROP TABLE IF EXISTS `realisation`;
CREATE TABLE IF NOT EXISTS `realisation` (
  `num_realisation` int(11) NOT NULL AUTO_INCREMENT,
  `num_part` int(11) DEFAULT NULL,
  `num_pro` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_realisation`),
  KEY `num_part` (`num_part`,`num_pro`),
  KEY `num_pro` (`num_pro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `num_ser` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(10) DEFAULT NULL,
  `num_emp` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_ser`),
  KEY `num_emp` (`num_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `travail`
--

DROP TABLE IF EXISTS `travail`;
CREATE TABLE IF NOT EXISTS `travail` (
  `num_trav` int(11) NOT NULL AUTO_INCREMENT,
  `num_emp` int(11) DEFAULT NULL,
  `num_ser` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_trav`),
  KEY `num_emp` (`num_emp`,`num_ser`),
  KEY `num_ser` (`num_ser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `travail_p`
--

DROP TABLE IF EXISTS `travail_p`;
CREATE TABLE IF NOT EXISTS `travail_p` (
  `num_travp` int(11) NOT NULL AUTO_INCREMENT,
  `num_emp` int(11) DEFAULT NULL,
  `num_pro` int(11) DEFAULT NULL,
  PRIMARY KEY (`num_travp`),
  KEY `num_emp` (`num_emp`,`num_pro`),
  KEY `num_pro` (`num_pro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `num_type` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`num_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `employer`
--
ALTER TABLE `employer`
  ADD CONSTRAINT `employer_ibfk_1` FOREIGN KEY (`num_cat`) REFERENCES `categorie` (`num_cat`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `local_`
--
ALTER TABLE `local_`
  ADD CONSTRAINT `local__ibfk_1` FOREIGN KEY (`num_part`) REFERENCES `partenaires` (`num_part`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `local__ibfk_2` FOREIGN KEY (`num_pay`) REFERENCES `payes` (`num_pay`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `partenaires`
--
ALTER TABLE `partenaires`
  ADD CONSTRAINT `partenaires_ibfk_1` FOREIGN KEY (`num_t`) REFERENCES `type` (`num_type`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `projet`
--
ALTER TABLE `projet`
  ADD CONSTRAINT `projet_ibfk_1` FOREIGN KEY (`num_emp`) REFERENCES `employer` (`num_emp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `realisation`
--
ALTER TABLE `realisation`
  ADD CONSTRAINT `realisation_ibfk_1` FOREIGN KEY (`num_part`) REFERENCES `partenaires` (`num_part`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `realisation_ibfk_2` FOREIGN KEY (`num_pro`) REFERENCES `projet` (`num_pro`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `service_ibfk_1` FOREIGN KEY (`num_emp`) REFERENCES `employer` (`num_emp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `travail`
--
ALTER TABLE `travail`
  ADD CONSTRAINT `travail_ibfk_1` FOREIGN KEY (`num_ser`) REFERENCES `service` (`num_ser`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `travail_ibfk_2` FOREIGN KEY (`num_emp`) REFERENCES `employer` (`num_emp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `travail_p`
--
ALTER TABLE `travail_p`
  ADD CONSTRAINT `travail_p_ibfk_1` FOREIGN KEY (`num_emp`) REFERENCES `employer` (`num_emp`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `travail_p_ibfk_2` FOREIGN KEY (`num_pro`) REFERENCES `projet` (`num_pro`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
