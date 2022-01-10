# nicoo_charcreator
Fivem Character Creator

[demo of script](https://www.youtube.com/watch?v=pv_06-KRCCs)

## Requirements

• [skinchanger](https://github.com/esx-framework/skinchanger)

• [esx_skin](https://github.com/esx-framework/esx_skin)

## Installation  
  
1. Install [esx_skin](https://github.com/esx-framework/esx_skin) 1.1.0 & [skinchanger](https://github.com/esx-framework/skinchanger) 1.0.3.
Be sure you have the right versions of esx_skin and esx_skinchanger, otherwise it will not work!
  
2. Add in your server.cfg "ensure nicoo_charcreator" (Make sure the resource is started after the 'esx_skin' & 'skinchanger' resources).

3. To open nicoo_charcreator after registration with esx_identity you have to change the following lines in esx_skin/client/main.lua:

```
	261		TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)

	to

    	261		--TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
	262		TriggerEvent('nicoo_charcreator:CharCreator')
```
__and__
```
	287		TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)

	to

    	287		--TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
	288		TriggerEvent('nicoo_charcreator:CharCreator')
```

Now nicoo_charcreator opens after the registration with esx_identity!
Same applies if you are not using esx_identiy (But who would do that?).

4. Configure, if you wish, the "config.lua" file.
5. If you have problems saving the Inheritance data (mom and dad info) edit the skinchanger/client/main.lua and search for this line: 
```
SetPedHeadBlendData			(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
```
and replace with:
```
if Character['dad'] and Character['mom'] and Character['shape_mx'] and Character['skin_mx'] then
	SetPedHeadBlendData(playerPed, Character['dad'], Character['mom'], 0, Character['dad'], Character['mom'], 0, Character['shape_mx'], Character['skin_mx'], 0.0, true)
else
	SetPedHeadBlendData(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
end
for k,v in pairs(Face) do
	SetPedFaceFeature(playerPed, k, Character[v])
end
```

## Installation with esx_multichar from thelindat -- https://github.com/thelindat/esx_multicharacter

1. Follow steps 1 - 3 from above.

2. Change the following line in esx_multichar/client/main.lua:

```
	281		TriggerEvent('esx_skin:openSaveableMenu')
	
	to
	
	281		--TriggerEvent('esx_skin:openSaveableMenu')
	282		TriggerEvent('nicoo_charcreator:CharCreator')
```

Now nicoo_charcreator opens after the registration with esx_identity and esx_multichar!

4. Configure, if you wish, the "config.lua" file.

## After the Multichar Update to 1.2.0 the new added feature for the heading correction at spawning brokes the char creator.
## If you are using esx_multicharacter 1.2.0 you MUST use this fix to get the charcreator working!

From line __267 to 301__ do this:

```
--[[if isNew or not skin or #skin == 1 then
		local sex = skin.sex or 0
		if sex == 0 then model = `mp_m_freemode_01` else model = `mp_f_freemode_01` end
		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
		skin = Config.Default
		skin.sex = sex
		TriggerEvent('skinchanger:loadSkin', skin, function()
			playerPed = PlayerPedId()
			SetPedAoBlobRendering(playerPed, true)
			ResetEntityAlpha(playerPed)
			TriggerEvent('esx_skin:openSaveableMenu', function()
				finished = true end, function() finished = true
			end)
			SetEntityHeading(playerPed, spawn.heading)
		end)
		while not finished do Citizen.Wait(200) end
	else
		local playerPed = PlayerPedId()
		SetEntityHeading(playerPed, spawn.heading)
		TriggerEvent('skinchanger:loadSkin', skin or Characters[Spawned].skin)
		playerPed = PlayerPedId()
		SetEntityVisible(playerPed, true, 0)
	end
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned')
	TriggerEvent('esx:restoreLoadout')
	Characters, hidePlayers = {}, false
end)]]--
```

And right underneath paste this:

```
if isNew or not skin or #skin == 1 then
		local sex = skin.sex or 0
		if sex == 0 then model = `mp_m_freemode_01` else model = `mp_f_freemode_01` end
		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
		skin = Config.Default
		skin.sex = sex
		TriggerEvent('skinchanger:loadSkin', skin, function()
			Citizen.CreateThread(function()
				playerped = PlayerPedId()
				SetPedAoBlobRendering(playerPed, true)
				ResetEntityAlpha(playerPed)
				Citizen.Wait(1500)
				--TriggerEvent('esx_skin:openSaveableMenu')
				TriggerEvent('nicoo_charcreator:CharCreator')
				SetEntityHeading(playerPed, spawn.heading)
			end)
		end)
	else
		TriggerEvent('skinchanger:loadSkin', skin or Characters[Spawned].skin)
		Citizen.Wait(1500)
	end
	Characters = {}
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned')
	TriggerEvent('esx:restoreLoadout')
	playerPed = PlayerPedId()
	FreezeEntityPosition(playerPed, false)
	SetEntityHeading(PlayerPed, spawn.heading)
	Citizen.Wait(500)
	RenderScriptCams(false, true, 500, true, true)
	PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
	SetCamActive(cam, false)
	DestroyAllCams(true)
	DisplayHud(true)
	DisplayRadar(true)
	hidePlayers = false
end)
```

Now the char creator works again!

## Changelog:

__18-06-2021__
```
- Forked Repo from NicooPasPris - https://github.com/NicooPasPris/nicoo_charcreator the original creator of this char creator.
- Added fix for issue with color selection and mouse movement. Thanks to STARMEET https://github.com/STARMEET/Corrections.
- Dragged stream folder from inside of RageUI folder to main folder to fix some issues with the UI.
- Changed default language in config to en.
- Added up to date installation instructions.
- Added installation instruction for esx_multichsr from thelindat https://github.com/thelindat/esx_multicharacter.
- Updated fxmanifest.lua.
- Updated README file... ;)
```

__19-06-2021__
```
- Added german language.
- Fixed translation isues in UI.
- Added notification when player spawns the first time. (needs t-notify for work)
See client.lua line __348__ for the notification. Comment out by default! Heres a screen of it: https://i.imgur.com/95srWZV.png
- Added more outfits. (Casual, Aztecas, Ballas, Mara-Bunta and Biker)
- Updated README file... ;)
```

__1.4.2__
```
- Added fix for sometimes falling down half a meter from air and improvement in checking current position. (Thank's to GROMO in Discord for that.)
- Added fix for sometimes glitching of char when changing clothes. (Thank's to GROMO in Discord for that.)
```


## Outdated Installation!
## Don't use this installation until you use old esx_skinchanger and esx_skin! With newest skinchanger (1.0.3) this changes underneath already implemented.

1. Install [esx_skin](https://github.com/esx-framework/esx_skin) & [skinchanger](https://github.com/esx-framework/skinchanger)

Note: The nicoo_charcreator script requires a slight modification of the 'skinchanger' script. A 'skinchanger' resource is already configured for you if you wish otherwise, go to [configuration part](https://github.com/NicooPasPris/nicoo_charcreator#configuration)

2. Add in your server.cfg "ensure nicoo_charcreator" (Make sure the resource is started after the 'esx_skin' & 'skinchanger' resources)

3. Configure if you wish the "config.lua" file

## Configuration

### esx_skin Configuration
Edit client file (esx_skin/client/main.lua), replaces line 295 : `TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)`
by 
```
TriggerEvent('nicoo_charcreator:CharCreator')
```


### skinchanger Configuration
In the client file (skinchanger/client/main.lua) at first line, you need to change the `local Components` by

```
local Components = {
	{label = _U('sex'),						name = 'sex',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('face'),					name = 'face',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('skin'),					name = 'skin',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_1'),					name = 'hair_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_2'),					name = 'hair_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_color_1'),			name = 'hair_color_1',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_color_2'),			name = 'hair_color_2',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('tshirt_1'),				name = 'tshirt_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 8},
	{label = _U('tshirt_2'),				name = 'tshirt_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'tshirt_1'},
	{label = _U('torso_1'),					name = 'torso_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 11},
	{label = _U('torso_2'),					name = 'torso_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'torso_1'},
	{label = _U('decals_1'),				name = 'decals_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 10},
	{label = _U('decals_2'),				name = 'decals_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'decals_1'},
	{label = _U('arms'),					name = 'arms',				value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('arms_2'),					name = 'arms_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('pants_1'),					name = 'pants_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.5,	componentId	= 4},
	{label = _U('pants_2'),					name = 'pants_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.5,	textureof	= 'pants_1'},
	{label = _U('shoes_1'),					name = 'shoes_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8,	componentId	= 6},
	{label = _U('shoes_2'),					name = 'shoes_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8,	textureof	= 'shoes_1'},
	{label = _U('mask_1'),					name = 'mask_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 1},
	{label = _U('mask_2'),					name = 'mask_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'mask_1'},
	{label = _U('bproof_1'),				name = 'bproof_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 9},
	{label = _U('bproof_2'),				name = 'bproof_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bproof_1'},
	{label = _U('chain_1'),					name = 'chain_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 7},
	{label = _U('chain_2'),					name = 'chain_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'chain_1'},
	{label = _U('helmet_1'),				name = 'helmet_1',			value = -1,		min = -1,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 0 },
	{label = _U('helmet_2'),				name = 'helmet_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'helmet_1'},
	{label = _U('glasses_1'),				name = 'glasses_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 1},
	{label = _U('glasses_2'),				name = 'glasses_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'glasses_1'},
	{label = _U('watches_1'),				name = 'watches_1',			value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 6},
	{label = _U('watches_2'),				name = 'watches_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'watches_1'},
	{label = _U('bracelets_1'),				name = 'bracelets_1',		value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 7},
	{label = _U('bracelets_2'),				name = 'bracelets_2',		value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bracelets_1'},
	{label = _U('bag'),						name = 'bags_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	componentId	= 5},
	{label = _U('bag_color'),				name = 'bags_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bags_1'},
	{label = _U('eye_color'),				name = 'eye_color',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_size'),			name = 'eyebrows_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_type'),			name = 'eyebrows_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_color_1'),			name = 'eyebrows_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_color_2'),			name = 'eyebrows_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_type'),				name = 'makeup_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_thickness'),		name = 'makeup_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_color_1'),			name = 'makeup_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_color_2'),			name = 'makeup_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_type'),			name = 'lipstick_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_thickness'),		name = 'lipstick_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_color_1'),		name = 'lipstick_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_color_2'),		name = 'lipstick_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('ear_accessories'),			name = 'ears_1',			value = -1,		min = -1,	zoomOffset = 0.4,		camOffset = 0.65,	componentId	= 2},
	{label = _U('ear_accessories_color'),	name = 'ears_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65,	textureof	= 'ears_1'},
	{label = _U('chest_hair'),				name = 'chest_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('chest_hair_1'),			name = 'chest_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('chest_color'),				name = 'chest_3',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bodyb'),					name = 'bodyb_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bodyb_size'),				name = 'bodyb_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('wrinkles'),				name = 'age_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('wrinkle_thickness'),		name = 'age_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blemishes'),				name = 'blemishes_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blemishes_size'),			name = 'blemishes_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush'),					name = 'blush_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush_1'),					name = 'blush_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush_color'),				name = 'blush_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('complexion'),				name = 'complexion_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('complexion_1'),			name = 'complexion_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('sun'),						name = 'sun_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('sun_1'),					name = 'sun_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('freckles'),				name = 'moles_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('freckles_1'),				name = 'moles_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_type'),				name = 'beard_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_size'),				name = 'beard_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_color_1'),			name = 'beard_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_color_2'),			name = 'beard_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},

	-- Add nicoo_charcreator
	{label = _U('mother_heritage'), 		name = 'mom',				value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('father_heritage'), 		name = 'dad',				value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_width'),	 			name = 'nose_1',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_height'), 			name = 'nose_2',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_peak'), 				name = 'nose_3',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_bone'), 				name = 'nose_4',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose_peak_2'), 			name = 'nose_5',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('nose'), 					name = 'nose_6',			value = 0.0,	min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('eyebrows_depth'),			name = 'eyebrows_5',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrows_height'),			name = 'eyebrows_6',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('cheekbones_height'), 		name = 'cheeks_1',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('cheekbones_width'),		name = 'cheeks_2',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('cheek_width'),				name = 'cheeks_3',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('opening_eyes'),			name = 'eye_open',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lips_thick'),				name = 'lips_thick',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('jaw_width'),				name = 'jaw_1',				value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('jaw_length'),				name = 'jaw_2',				value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('chin_height'),				name = 'chin_height',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('chin_lenght'),				name = 'chin_lenght',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('chin_width'),				name = 'chin_width',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('chin_hole'),				name = 'chin_hole',			value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('neck_thick'),				name = 'neck_thick',		value = 0.0,	min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
}
```

2. In the `function ApplySkin` modified the line ```SetPedHeadBlendData			(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)```
by
```
  	SetPedHeadBlendData			(playerPed, Character['mom'], Character['dad'], nil, Character['mom'], Character['dad'], nil, Character['face'], Character['skin'], nil, true)

	local Face = {[0] = 'nose_1', [1] = 'nose_2', [2] = 'nose_3', [3] = 'nose_4', [4] = 'nose_5', [5] = 'nose_6', [6] = 'eyebrows_5', [7] = 'eyebrows_6', [8] = 'cheeks_2', [9] = 'cheeks_1', [10] = 'cheeks_3', [11] = 'eye_open', [12] = 'lips_thick', [13] = 'jaw_1', [14] = 'jaw_2', [15] = 'chin_height', [16] = 'chin_lenght', [17] = 'chin_width', [18] = 'chin_hole', [19] = 'neck_thick'}

	for k,v in pairs(Face) do
		if Character[v] then
			SetPedFaceFeature(GetPlayerPed(-1), k, Character[v])
		end
	end
```
 ## Nicoo
 And now the script is ready! The installation is a bit complex, that's why I let you contact me if you need help.
 
 # My discord: Nicoo#6134
