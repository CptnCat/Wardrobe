# ✍️ Description
This FiveM script is a wardrobe for your ESX server.

# ⭐ Features
- Save your current outfit
- Share a outfit from your wardrobe
- Name a outfit in your wardrobe
- Favorite outfits in your wardrobe
- Delete a outfit from your wardrobe

# 👀 Usage
Dieses Script ist dafür da um Outfits von Spielern zu speichern und diese zu verwalten zu lassen. 

# 💾 Database
Damit das Script funktioniert, musst du folgende SQL in deine Datenbank einfügen.
`CREATE TABLE IF NOT EXISTS `user_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `clothesData` longtext DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1775 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;`


