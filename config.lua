Config = {}

Config.Locale = GetConvar('esx:locale', 'en') -- Select your language 'de', 'en'

-- Marker
Config.DrawDistance = 10.0
Config.MarkerSize   = {x = 0.6, y = 0.6, z = 0.5}
Config.MarkerColor  = {r = 30, g = 144, b = 255}
Config.MarkerType   = 21

-- Admin Command
Config.EnableAdminCommand = true -- Enable the command to open the wardrobe anywhere?
Config.AdminCommand = 'wardrobe' -- Command to open the wardrobe
Config.AdminGroups = 'admin' -- Add your admins here that should have access to the wardrobe command

-- General
Config.EnableSaveCurrentOutfit = true -- Enable the Save Current Outfit selection

-- Locations
Config.WardrobePositions = { -- Add more positions here
    {coords = vec3(429.7014, -811.3698, 29.4911)},
    {coords = vec3(71.1883, -1387.8079, 29.3761)},
    {coords = vec3(-820.0474, -1067.3770, 11.3281)},
    {coords = vec3(-1182.0992, -765.1116, 17.3267)},
    {coords = vec3(-1446.7981, -242.7872,  49.8227)},
    {coords = vec3(-703.7148, -151.2709, 37.4151)},
    {coords = vec3(-168.9946, -232.2905, 39.7333)},
    {coords = vec3(118.1551, -232.2905, 54.5578)},
    {coords = vec3(-3178.6782, 1035.7823, 20.8632)},
    {coords = vec3(-3178.6782, 1035.7823, 20.8632)},
    {coords = vec3(-1100.2936, 2717.1482, 19.1078)},
    {coords = vec3(617.6683, 2773.5955, 42.0881)},
    {coords = vec3(1201.9600, 2714.4006, 38.2226)},
    {coords = vec3(1698.7163, 4818.1343, 42.0631)},
    {coords = vec3(3.8752, 6505.8486, 31.8778)}
}
