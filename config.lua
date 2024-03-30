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

-- Locations
Config.WardrobePositions = { -- Add more positions here
    {x = 429.7014, y = -811.3698, z = 29.4911},
    {x = 71.1883, y = -1387.8079, z = 29.3761},
    {x = -820.0474, y = -1067.3770, z = 11.3281},
    {x = -1182.0992, y = -765.1116, z = 17.3267},
    {x = -1446.7981, y = -242.7872, z =  49.8227},
    {x = -703.7148, y = -151.2709, z = 37.4151},
    {x = -168.9946, y = -232.2905, z = 39.7333},
    {x = 118.1551, y = -232.2905, z = 54.5578},
    {x = -3178.6782, y = 1035.7823, z = 20.8632},
    {x = -1100.2936, y = 2717.1482, z = 19.1078},
    {x = 617.6683, y = 2773.5955, z = 42.0881},
    {x = 1201.9600, y = 2714.4006, z = 38.2226},
    {x = 1698.7163, y = 4818.1343, z = 42.0631},
    {x = 3.8752, y = 6505.8486, z = 31.8778}
}