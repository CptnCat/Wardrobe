CREATE TABLE IF NOT EXISTS `user_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `clothesData` longtext DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1775 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
