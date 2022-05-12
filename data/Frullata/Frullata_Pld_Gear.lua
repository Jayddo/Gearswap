function user_setup()

	include('Common/PLD_UserSetup_Common.lua')

end

function init_gear_sets()

	include('Common/PLD_Common.lua')
	
end

function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','DDTank','Normal')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('SIRD','Normal')
	state.Passive:options('None','AbsorbMP')
    --state.PhysicalDefenseMode:options('PDT_HP','PDT','PDT_Reraise')
    --state.MagicalDefenseMode:options('MDT_HP','MDT','MDT_Reraise')
	--state.ResistDefenseMode:options('MEVA_HP','MEVA')
	state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Tank','Kiting','PDT','Block','MDT','Normal')
	state.Weapons:options('None','SakpataAegis','SakpataOchain','NaeglingBlurred')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Chance of successful block +5'}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
--	send_command('bind ^backspace input /ja "Shield Bash" <t>')
--	send_command('bind @backspace input /ja "Cover" <stpt>')
--	send_command('bind !backspace input /ja "Sentinel" <me>')
--	send_command('bind @= input /ja "Chivalry" <me>')
--	send_command('bind != input /ja "Palisade" <me>')
--	send_command('bind ^delete input /ja "Provoke" <stnpc>')
--	send_command('bind !delete input /ma "Cure IV" <stal>')
--	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind ^q gs c set IdleMode Kiting')
	send_command('bind !q gs c set IdleMode PDT')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {
		--main="Sakpata's Sword",sub="Ochain",ammo="Paeapua",
        --head="Loess Barbuta +1",neck="Moonlight Necklace",ear1="Friomisi Earring",ear2="Trux Earring",
        --body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        --back=gear.enmity_jse_back,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Eschite Greaves"
		ammo="Incantor Stone",
		head="Loess Barbuta +1", -- 19-24
		neck="Moonlight Necklace", -- 10
		ear1="Cryptic Earring", -- 5 
		ear2="Trux Earring", -- 5 
		body="Souv. Cuirass +1", -- 12
		hands="Souv. Handsch. +1", -- 14
		ring1="Petrov Ring",
		ring2="Eihwaz Ring", -- 4
		back=gear.enmity_jse_back, -- 5
		waist="Flume Belt",
		legs="Souveran Diechlings", -- 7
		feet="Yorium Sabatons" -- 15
	}
		
    sets.Enmity.SIRD = {
		main="Sakpata's Sword",
		sub="Sacro Bulwark",
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Odyssean Greaves",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear="Cryptic Earring",
		left_ring="Petrov Ring",
		ring2="Eihwaz Ring",
		back=gear.fastcast_jse_back
	}
		
    sets.Enmity.DT = set_combine(sets.Enmity,{
		main="Sakpata's Sword",
		sub="Sacro Bulwark",
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Odyssean Greaves",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear="Cryptic Earring",
		left_ring="Petrov Ring",
		ring2="Eihwaz Ring",
		back=gear.enmity_jse_back
	})
		
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +1"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +3"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{
		head="Cab. Coronet +1"
	}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +3"})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet="Cab. Leggings +3"})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{
		head="Cab. Coronet +1"
	}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		ammo="Quartz Tathlum +1",
		head="Rev. Coronet +1",
		body="Cab. Surcoat +1",
		hands="Umuthi Gloves",
		ring1="Levia. Ring +1",
		legs="Cab. Breeches +1",
		feet="Whirlpool Greaves"
	}
		
    sets.precast.JA['Chivalry'].DT = {ammo="Paeapua",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Rev. Surcoat +3",hands="Cab. Gauntlets +2",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Luminary Sash",legs="Nyame Flanchard",feet="Carmine Greaves +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +2"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +2"})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Rev. Surcoat +3",hands="Regal Gauntlets",ring1="Asklepian Ring",ring2="Valseur's Ring",
		back="Moonlight Cape",waist="Chaac Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {ammo="Aurgelmir Orb +1",
        head="Carmine Mask +1",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Flamma Korazin +2",hands="Regal Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Flam. Gambieras +2"}
		
	sets.precast.JA['Violent Flourish'] = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Incantor Stone",
		head="Chevalier's Armet +1",
		neck="Unmoving Collar +1",
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body={name="Rev. Surcoat +3", priority=254},
		hands="Leyline Gloves",
		ring1="Defending Ring",
		--ring2="Kishar Ring",
		back=gear.fastcast_jse_back,
		waist="Flume Belt",
		legs="Souveran Diechlings", -- 
		feet="Odyssean Greaves" -- hp68 DT6
	}
		
    sets.precast.FC.DT = {
		ammo="Incantor Stone",
		head="Loess Barbuta +1",
		neck="Unmoving Collar +1",
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body="Rev. Surcoat +3",
		hands="Leyline Gloves",
		ring1="Defending Ring",
		--ring2="Kishar Ring",
		back=gear.fastcast_jse_back,
		waist="Flume Belt",
		legs="Souveran Diechlings", -- 
		feet="Odyssean Greaves" -- hp68 DT6
	}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC.Cure.SIRD = set_combine(sets.precast.FC,{})
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Amar Cluster",
		head="Flamma Zucchetto +2",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Karieyh Ring",
		right_ring="Petrov Ring",
	}
		
    sets.precast.WS.DT = {
		ammo="Amar Cluster",
		head="Ratri Sallet",
		body="Ratri Breastplate",
		hands="Ratri Gadlings",
		legs="Ratri Cuisses",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Karieyh Ring",
		right_ring="Petrov Ring",
	}

    sets.precast.WS.Acc = {ammo="Hasty Pinion +1",
        head="Ynglinga Sallet",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body=gear.valorous_wsd_body,hands="Sakpata's Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Sulev. Leggings +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring"
	})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Mache Earring +1",ear2="Telos Earring"})
	
	sets.precast.WS['Flat Blade'] = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"}

    sets.precast.WS['Sanguine Blade'] = {ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",neck="Fotia Gorget",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Metamor. Ring +1",
        back="Toro Cape",waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.precast.WS['Atonement'] = {ammo="Paeapua",
        head="Loess Barbuta +1",neck="Moonlight Necklace",ear1="Friomisi Earring",ear2="Trux Earring",
        body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back=gear.enmity_jse_back,waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Eschite Greaves"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {
		ammo="Incantor Stone",
		head="Chevalier's Armet +1",
		neck="Unmoving Collar +1",
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body="Rev. Surcoat +3",
		hands="Leyline Gloves",
		ring1="Defending Ring",
		--ring2="Kishar Ring",
		back=gear.fastcast_jse_back,
		waist="Flume Belt",
		legs="Souveran Diechlings", -- 
		feet="Odyssean Greaves" -- hp68 DT6
	}
		
	sets.midcast.FastRecast.DT = {
		ammo="Incantor Stone",
		head="Loess Barbuta +1",
		neck="Unmoving Collar +1",
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body="Rev. Surcoat +3",
		hands="Leyline Gloves",
		ring1="Defending Ring",
		--ring2="Kishar Ring",
		back=gear.fastcast_jse_back,
		waist="Flume Belt",
		legs="Souveran Diechlings", -- 
		feet="Odyssean Greaves" -- hp68 DT6
	}

	sets.midcast.FastRecast.SIRD = {
		main="Sakpata's Sword",
		sub="Sacro Bulwark",
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +3",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Odyssean Greaves",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear="Cryptic Earring",
		left_ring="Defending Ring",
		ring2="Eihwaz Ring",
		back=gear.fastcast_jse_back
	}

    sets.midcast.Flash = set_combine(sets.Enmity, {
		body="Rev. Surcoat +3",
		back=gear.fastcast_jse_back
	})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {
		body="Rev. Surcoat +3",
		back=gear.fastcast_jse_back
	})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {
		ammo="Impatiens",
		head="Loess Barbuta +1",
		neck="Unmoving Collar +1",
		ear1="Nourish. Earring +1",
		ear2="Cryptic Earring",
		body="Souv. Cuirass +1",
		hands="Macabre Gaunt. +1",
		ring1="Defending Ring",
		ring2="Eihwaz Ring",
		back=gear.enmity_jse_back,
		waist="Audumbla Sash",
		legs="Souveran Diechlings",
		feet="Odyssean Greaves"
	}
		
    sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure,{
		ammo="Staunch Tathlum",
		head="Souv. Schaller +1",
		neck="Moonlight Necklace",
		ear1="Knightly Earring",
		ear2="Nourish. Earring +1",
		body="Souv. Cuirass +1",
		hands="Macabre Gaunt. +1",
		ring1="Defending Ring",
		ring2="Eihwaz Ring",
		back=gear.enmity_jse_back,
		waist="Audumbla Sash",
		legs="Carmine Cuisses +1",
		feet="Odyssean Greaves"
	})
		
    sets.midcast.Cure.DT = set_combine(sets.midcast.Cure,{})
		
    sets.midcast.Reprisal = set_combine(sets.FastRecast,{
		body="Shabti Cuirass +1"
	})

	sets.midcast.Reprisal.SIRD = set_combine(sets.Enmity.SIRD,{
		body="Shabti Cuirass +1",
		ring1="Defending Ring"
	})

	--sets.Self_Healing = set_combine(sets.midcast.Cure.SIRD,{})
		
	--sets.Self_Healing.SIRD = set_combine(sets.Self_Healing,{})
		
	--sets.Self_Healing.DT = set_combine(sets.Self_Healing,{})

	sets.Cure_Received = {hands="Souv. Handsch. +1",body="Souv. Cuirass +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,{
		body="Shabti Cuirass"
	})
		
    sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast.FastRecast.SIRD,{
		body="Shabti Cuirass"
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
		main="Sakpata's Sword",
		body="Valorous Mail",
		hands="Souv. Handsch. +1",
		back=gear.fastcast_jse_back,
		legs="Sakpata's Cuisses",
		feet="Souveran Schuhs"})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {
		main="Sakpata's Sword",
		body="Valorous Mail",
		ear2="Cryptic Earring",
		hands="Souv. Handsch. +1",
		back=gear.fastcast_jse_back,
	})
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})	
	sets.Phalanx_Received = {
		main="Sakpata's Sword",
		hands="Souv. Handsch. +1",
		legs="Sakpata's Cuisses",
		feet="Souveran Schuhs"}
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {
		ammo="Homiliary",
		head="Jumalik Helm",
		neck="Coatl Gorget +1",
		ear1="Infused Earring",
		ear2="Ethereal Earring",
		body="Chevalier's Cuirass +1",
		hands="Souveran Handschuhs",
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back="Philidor Mantle",
		waist="Flume Belt",
		legs="Carmine Cuisses +1",
		feet="Amm Greaves"
	}

    -- Idle sets
    sets.idle = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Homiliary", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Sakpata's Breastplate", -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs="Sakpata's Cuisses", -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
    sets.idle.PDT = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Sakpata's Breastplate", -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs="Sakpata's Cuisses", -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
    sets.idle.Block = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Sakpata's Breastplate", -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs="Sakpata's Cuisses", -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
    sets.idle.MDT = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum", -- MDB 4 --
		head="Nyame Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Nyame Mail", -- 9 DT --
		hands="Nyame Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Carrier's Sash",
		legs="Nyame Flanchard", -- MDB 4 --
		feet="Nyame Sollerets"
}

	sets.idle.Tank = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck={name="Unmoving Collar +1", priority=200}, -- 5 DT --
		ear1={name="Tuisto Earring", priority=150}, -- MDT 2 --
		ear2="Cryptic Earring", 
		body={name="Sakpata's Breastplate", priority=136}, -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs={name="Sakpata's Cuisses", priority=114}, -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
	sets.idle.Kiting = {}

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
	sets.passive.AbsorbMP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.SakpataAegis = {main="Sakpata's Sword",sub="Aegis"}
	sets.weapons.NaeglingBlurred = {main="Naegling",sub="Blurred Shield +1"}
	sets.weapons.SakpataOchain = {main="Sakpata's Sword",sub="Ochain"}
	sets.weapons.DualWeapons = {main="Naegling",sub="Demersal Degen +1"}
    
    sets.defense.Block = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Sakpata's Breastplate", -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs="Sakpata's Cuisses", -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
	sets.defense.PDT = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Sakpata's Breastplate", -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs="Sakpata's Cuisses", -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
    sets.defense.PDT_HP = set_combine(sets.defense.PDT,{})
		
	sets.defense.MDT = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Sakpata's Breastplate", -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs="Sakpata's Cuisses", -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
    sets.defense.MDT_HP = set_combine(sets.defense.MDT,{})

	sets.defense.MEVA = set_combine(sets.defense.MDT,{})
		
    sets.defense.MEVA_HP = set_combine(sets.defense.MEVA,{})
		
    sets.defense.PDT_Reraise = set_combine(sets.defense.PDT_HP,{head="Twilight Helm",body="Twilight Mail"})
    sets.defense.MDT_Reraise = set_combine(sets.defense.MDT_HP,{head="Twilight Helm",body="Twilight Mail"})
		
	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {
		ammo="Amar Cluster",
		head="Flam. Zucchetto +2",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Abyssal Beads +1",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Trux Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
	}

    sets.engaged.Acc = set_combine(sets.engaged,{})

    sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

	sets.engaged.Tank = {
		main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum +1", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Sakpata's Breastplate", -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs="Sakpata's Cuisses", -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
	sets.engaged.DDTank = {
		ammo="Staunch Tathlum +1", -- MDB 4 --
		head="Sakpata's Helm", -- MDB 2 / MDT 5 --
		neck="Unmoving Collar +1", -- 5 DT --
		ear1="Tuisto Earring", -- MDT 2 --
		ear2="Cryptic Earring", 
		body="Sakpata's Breastplate", -- 9 DT --
		hands="Sakpata's Gauntlets", -- MDB 1 / MDT 5 --
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=gear.enmity_jse_back, -- 4 MDT --
		waist="Flume Belt",
		legs="Sakpata's Cuisses", -- MDB 4 --
		feet="Sakpata's Leggings"
	}
		
	sets.engaged.Acc.DDTank = set_combine(sets.engaged.DDTank,{})
		
	sets.engaged.NoShellTank = {}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		legs ="Shabti Cuisses"
	})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4) --War/Etc
    end
end

buff_spell_lists = {
	Auto = {	
		{Name='Crusade',Buff='Enmity Boost',SpellID=476,When='Always'},
		{Name='Reprisal',Buff='Reprisal',SpellID=97,When='Always'},
		{Name='Phalanx',Buff='Phalanx',SpellID=106,When='Always'},
		{Name='Cocoon',Buff='Defense Boost',SpellID=547,When='Always'}
	},
	
	Default = {
		{Name='Crusade',Buff='Enmity Boost',SpellID=476,Reapply=false},
		{Name='Reprisal',Buff='Reprisal',SpellID=97,Reapply=false},
		{Name='Haste',Buff='Haste',SpellID=57,Reapply=false},
		{Name='Refresh',Buff='Refresh',SpellID=109,Reapply=false},
		{Name='Aquaveil',Buff='Aquaveil',SpellID=55,Reapply=false},
		{Name='Stoneskin',Buff='Stoneskin',SpellID=54,Reapply=false},
		{Name='Blink',Buff='Blink',SpellID=53,Reapply=false},
		{Name='Regen',Buff='Regen',SpellID=108,Reapply=false},
		{Name='Phalanx',Buff='Phalanx',SpellID=106,Reapply=false},
	},
}

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 05')
end

    -- Allow jobs to override this code
	function job_self_command(commandArgs, eventArgs)

		if commandArgs[1] == 'RuneElement' then
			send_command('input /ja "'..state.RuneElement.value..'" <me>')
	
		elseif commandArgs[1] == 'SubJobEnmity' then
	
			if player.target.type ~= "MONSTER" then
				add_to_chat(123,'Abort: You are not targeting a monster.')
				return
	
			elseif player.sub_job == 'RUN' then
				local abil_recasts = windower.ffxi.get_ability_recasts()
				
				if abil_recasts[24] < latency then
					send_command('input /ja "Swordplay" <me>')
				end
				
			elseif player.sub_job == 'BLU' and not moving then
				local spell_recasts = windower.ffxi.get_spell_recasts()
						
				if spell_recasts[584] < spell_latency then
					windower.chat.input('/ma "Sheep Song" <t>')
				elseif spell_recasts[575] < spell_latency then
					windower.chat.input('/ma "Jettatura" <t>')
				elseif spell_recasts[592] < spell_latency then
					windower.chat.input('/ma "Blank Gaze" <t>')
				elseif not check_auto_tank_ws() then
					if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Blue Magic on cooldown.') end
				end
	
			elseif player.sub_job == 'DRK' then
				local abil_recasts = windower.ffxi.get_ability_recasts()
				local spell_recasts = windower.ffxi.get_spell_recasts()
				
				if (state.HybridMode.value ~= 'Normal' or state.DefenseMode.value ~= 'None')  and buffactive['Souleater'] then
					send_command('cancel souleater')
				end
				
				if (state.HybridMode.value ~= 'Normal' or state.DefenseMode.value ~= 'None')  and buffactive['Last Resort'] then
					send_command('cancel last resort')
				end
				
				if spell_recasts[252] < spell_latency and not silent_check_silence() then
					windower.chat.input('/ma "Stun" <t>')
				elseif abil_recasts[85] < latency then
					windower.chat.input('/ja "Souleater" <me>')
				elseif abil_recasts[87] < latency then
					windower.chat.input('/ja "Last Resort" <me>')
				elseif abil_recasts[86] < latency then
					windower.chat.input('/ja "Arcane Circle" <me>')
				elseif not check_auto_tank_ws() then
					if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Dark Knight abillities on cooldown.') end
				end
	
			elseif player.sub_job == 'WAR' then
				local abil_recasts = windower.ffxi.get_ability_recasts()
				
				if state.HybridMode.value:contains('DD') then
					if buffactive['Defender'] then send_command('cancel defender') end
				elseif state.HybridMode.value ~= 'Normal' and not state.HybridMode.value:contains('DD') then
					if buffactive['Berserk'] then send_command('cancel berserk') end
				end
				
				if abil_recasts[5] < latency then
					send_command('input /ja "Provoke" <t>')
				elseif abil_recasts[2] < latency then
					send_command('input /ja "Warcry" <me>')
				elseif abil_recasts[3] < latency then
					send_command('input /ja "Defender" <me>')
				elseif abil_recasts[4] < latency then
					send_command('input /ja "Aggressor" <me>')
				elseif abil_recasts[1] < latency then
					send_command('input /ja "Berserk" <me>')
				elseif not check_auto_tank_ws() then
					if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Warrior Job Abilities on cooldown.') end
				end
				
			elseif player.sub_job == 'DNC' then
				local abil_recasts = windower.ffxi.get_ability_recasts()
				local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
			
				if under3FMs then
					if abil_recasts[220] < latency then
					send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
					return
					end
				elseif abil_recasts[221] < latency then
					send_command('input /ja "Animated Flourish" <t>')
					return
				elseif abil_recasts[220] < latency and not buffactive['Finishing Move 5'] then
					send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
					return
				elseif not check_auto_tank_ws() then
					if not state.AutoTankMode.value then add_to_chat(123,'Dancer job abilities not needed.') end
				end
			else
				check_auto_tank_ws()
			end
	
		end
	
	end