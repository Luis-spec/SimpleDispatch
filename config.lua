Config = {}
Strings = {}

-- Notification Pictures: https://wiki.rage.mp/index.php?title=Notification_Pictures
Config.Dispatches = {
    {number = '911', label = 'LSPD', picture = 'CHAR_CALL911', job = 'police'},
    {number = '900', label = 'L.S. Customs', picture = 'CHAR_LS_CUSTOMS', job = 'lsc'},

}

Config.DispatchBlip = {
    Sprite = 119,
    Colour = 3,
    Size = 1.0,
}

Config.BlipTimer = 15 -- seconds, until the blip disappears

Strings = {
    ['dispatch_subtitle'] = 'New Dispatch',
    ['dispatch_sent'] = 'Dispatch sent',
    ['dispatch_infotext'] = 'We got your dispatch! \nA ~y~unit is on the way ~s~to your current location!',
    ['blip_dispatch'] = 'Dispatch',
    ['location'] = '~w~Location: ~y~',
}