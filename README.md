# ✍️ Description
This FiveM script is a wardrobe for your ESX server.

# ⭐ Features
- Save your current outfit
- Share a outfit from your wardrobe
- Name a outfit in your wardrobe
- Favorite outfits in your wardrobe
- Delete a outfit from your wardrobe

# 👀 Usage
This script is used to save players outfits and let them manage them.

# 💾 Database
For the script to work, you have to insert the following SQL into your database.
```
CREATE TABLE IF NOT EXISTS `user_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `clothesData` longtext DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1775 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
```

## 🔗 Dependencies
- [es_extended](https://github.com/esx-framework/esx_core/releases)
- esx_menu_default
- [ox_lib](https://github.com/overextended/ox_lib)

# 🤖 Discord
If you need assistance with the script, join my discord and I will help you.
[Discord](https://discord.gg/wPCTtQP7UT)
