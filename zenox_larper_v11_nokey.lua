--[[
	ZENOX LARPER v11 (no key)
]]

-- =====================================================================
-- SERVICE & WARNA
-- =====================================================================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local HS = game:GetService("HttpService")
local SG = game:GetService("StarterGui")
local MPS = game:GetService("MarketplaceService")
local IS = game:GetService("InsertService")
local SPRING = TweenInfo.new(0.36, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TS = game:GetService("TweenService")

local me = Players.LocalPlayer
local httpReq = (syn and syn.request) or (http and http.request) or http_request or request

local OR = Color3.fromRGB(255, 255, 255)   -- aksen (putih)
local BLK = Color3.new(0, 0, 0)
local BG = Color3.fromRGB(17, 17, 17)      -- #101010 background utama
local HD = Color3.fromRGB(17, 17, 17)      -- #191919 header & footer
local SIDE = Color3.fromRGB(17, 17, 17)    -- #191919 sidebar
local ROW = Color3.fromRGB(28, 28, 28)     -- #242424 container & input
local BTN = Color3.fromRGB(34, 34, 34)     -- #242424 tombol
local ACT = Color3.fromRGB(38, 38, 38)     -- #303030 elemen aktif
local OFF = Color3.fromRGB(48, 48, 48)     -- #303030 toggle mati
local BRD = Color3.fromRGB(38, 38, 38)     -- #303030 border
local TXT = Color3.fromRGB(255, 255, 255)  -- #FFFFFF teks utama
local MUT = Color3.fromRGB(128, 128, 128)  -- #888888 teks sekunder
local LOGC = Color3.fromRGB(200, 200, 200)
local GOOD = Color3.fromRGB(220, 220, 220)
local BAD = Color3.fromRGB(255, 255, 255)
local FB, FM = Enum.Font.GothamBold, Enum.Font.GothamMedium

-- =====================================================================
-- FUNGSI DASAR
-- =====================================================================
local F = {}
local S = {}

local function trim(s) local r = tostring(s or ""):gsub("^%s+", ""); return (r:gsub("%s+$", "")) end
local function fmt(v) return string.format("%.1f", v) end
local cacheMuat = {}
local function muat(id)
	local k = tostring(id)
	local tpl = cacheMuat[k]
	if not tpl then
		local ok, o = pcall(function() return game:GetObjects("rbxassetid://" .. k)[1] end)
		if not (ok and o) then
			local ok2, o2 = pcall(function() return IS:LoadAsset(tonumber(id)) end)
			o = (ok2 and o2) or nil
		end
		if not o then return nil end
		cacheMuat[k] = o; tpl = o
	end
	local ok3, salin = pcall(function() return tpl:Clone() end)
	if ok3 and salin then return salin end
	return nil
end
local function mk(cls, p, parent)
	local o = Instance.new(cls)
	for k, v in pairs(p) do o[k] = v end
	if parent then o.Parent = parent end
	return o
end
local function rnd(o, r) mk("UICorner", {CornerRadius = UDim.new(0, r or 12)}, o); if not (r and r >= 7) then mk("UIStroke", {Color = BRD, Thickness = 1, Transparency = 0.3}, o) end end
local function httpJson(url)
	local body = nil
	if httpReq then
		local ok, res = pcall(function() return httpReq({Url = url, Method = "GET"}) end)
		if ok and res and res.StatusCode == 200 and res.Body then body = res.Body end
	end
	if not body then
		local ok, txt = pcall(function() return game:HttpGet(url) end)
		if ok then body = txt end
	end
	if not body then return nil end
	local ok, d = pcall(function() return HS:JSONDecode(body) end)
	if ok and type(d) == "table" then return d end
	return nil
end
local function bgSrc(s)
    s = tostring(s or "")
    if s == "" then return "" end
    if s:match("^https?://") then return s end
    if s:match("^rbxassetid://") then return s end
    if tonumber(s) then return "rbxassetid://" .. s end
    return s
end
local function tulis(nama, isi) if not writefile then return false end; return (pcall(writefile, nama, isi)) end
local function baca(nama)
	if not (readfile and isfile) then return nil end
	local okA, ada = pcall(isfile, nama)
	if not okA or not ada then return nil end
	local okB, isi = pcall(readfile, nama)
	if okB then return isi end
	return nil
end

function F.notif(judul, teks, dur)
	pcall(function() SG:SetCore("SendNotification", {Title = judul, Text = string.sub(tostring(teks), 1, 190), Duration = dur or 4}) end)
end

-- =====================================================================
-- KONFIGURASI
-- =====================================================================
local C = {
	NAMA = "ZENOX LARPER", VERSI = "V11",
	CREDIT = {"OWNER: RAXZY", "DEV: yura", "DONATUR: tamagaz", "TIKTOK OWNER: raxzy369"},
	PERINGATAN = "HOLA",
	FILE_SKIN = "zenox_skin.json", SLOT_SKIN = 5,
	EMOTE = { {nama = "Tomato Dance", id = 125871567269726}, {nama = "Michael Jackson", id = 140440735589603}, {nama = "L Dance", id = 114846964045392}, {nama = "FF Push Up", id = 73630423562709}, {nama = "Break your leg", id = 117057554612284} },
	AKSES = {
		{"8 Bit Royal Crown", 10159600649}, {"Verdant Crown", 13241836994},
		{"Extra Domino Top Hat", 17266399676}, {"Frozen Horns", 74891470},
		{"Poisoned Horns", 1744060292}, {"Fiery Horns of the Netherworld", 215718515},
		{"Valkyrie Helm", 1365767}, {"8-Bit HP Bar", 10159610478},
		{"8-Bit Tabby Cat", 10159617728}, {"8-Bit Roblox Coin", 10159622004},
		{"Spring Fairy", 150381051}, {"White Gothic Hair", 139101716417676}, 
            {"Hovering UFO", 8151404994}, {"Sparkling Angel Wings", 192557913}, {"Tragedy", 13702160}, {"Ghostdeeri (head)", 183468963}, {"White Fluffy Zoldyck Hair", 126541017138655}, {"Unkept Spiky Vkei Anime Boy Hair", 131251657230383}, {"HEART SHADES BOBUX CLOUD", 83672858218486}, {"Dominus Empyreus", 21070012}, {"Emberwrath, Lord of the Burning Void", 117367851700030}, {"Fall Fairy", 128217885}, {"St Patrick's Day Fairy", 226189871}, {"Dark Guardian Angel", 76292007466829}, {"Bloodsteel Bathelm", 113655181607111}, {"The Ashen Reaper", 120386566219436}, {"Scorched Riddling Skull", 88641938334989}, {"Jester hair", 98310432834620}, {"FF purple shade", 110450103676376}, {"Classic beatiful hair", 16630147}, {"light blue emo messy", 72774691792757}, {"Sparkle Time Classic Pumpkin", 311450131}, {"Disgruntled Sheet Ghost", 130448026520738}, {"Winter fairy (shoulder)", 141742418}, {"EXTRATERRESTRIAL SHADES", 17682484184}, {"OWL PERCH BACKPACK", 11386252129}, {"MISCHIEVOUS MINI-VAMPIRE HAT", 14847263816}, {"FLAMING HOT CHIP HEAD", 15316834620}, {"DELINQUENT DEMON", 14228725502}, {"BUBBLER HEADPHONES", 15184892213}, {"ROBLOX GNARLY TREE GHOUL (back)", 18148245935}, {"BOBUX BAG (back)", 9243927199}, {"WATERMELON SLICES", 9560398801}, {"INFINITE HUNTER'S WINGS (back)", 16733494880}, {"CROWN OF WINTER'S FROST", 14475019074}, {"EVIL CLOWN MASK", 14228728879}
	},
	GEAR = { {"Pumpkin", 131592085}, {"Bluster Buster", 83704190}, {"Ice Dragon Slayer", 168141301}, {"Korblox Mage Staff", 127506105}, {"The Fiery Sun", 83021250}, {"Darkest Arts Sword", 147143863}, {"Flaming Orb of Divine Pain", 461488745}, {"Skelefriend", 63253701} },
	KOR_R15 = 139607718, KOR_KIRI = 139607673, KOR_R6_MESH = 902942093, KOR_R6_TEX = 902843398,
	AURA_BUNDLE = 4899847411546,
	
	SKEL = {kanan = 118130363235242, kiri = 118084431069710, badan = 95747577407647},
	WA_SALURAN = "https://whatsapp.com/channel/0029Vb9bx5u2f3ERBvI6EY2U",
	CELANA = { {nama = "Y2k", id = 15901064855}, {nama = "White jeans", id = 15464582959}, {nama = "Duck", id = 18412297771} },
	SHIRT = { {nama = "Emo punk shirt", id = 11112380477}, {nama = "White baggy shirt", id = 15630817253}, {nama = "Pink bape", id = 13505652810}, {nama = "Halloween shirt", id = 6074054267}, {nama = "Blue bape", id = 11631057198}, {nama = "Roblox shirt", id = 17493041361} },
	RAMBUT_GANTI = {[98310432834620] = true, [110450103676376] = true, [16630147] = true, [15563758601] = true, [72774691792757] = true, [139101716417676] = true, [126541017138655] = true, [131251657230383] = true, [130933973014024] = true},
	SECRET_ID = 109520550485360,
	WEBHOOK_CLONE = "", -- kosong = pakai WEBHOOK_SARAN
	WEBHOOK_SARAN = "https://discord.com/api/webhooks/1564188976942948413/iRLP4kuY8qljhxO_iW5FTGctWSPqpI4TlJaBh8W-79JPxZCVfGekxpYGwxFVIHF_5lTp",
	DOMINUS_ID = 21070012,
	-- tanpa key: semua item bisa dipakai
	-- item posisi khusus: kepala (melayang di atas) dan punggung (seperti tas)
	POSISI = {
		[8151404994] = {tempat = "kepala", off = CFrame.new(0, 2.4, 0)},
		[192557913] = {tempat = "punggung", off = CFrame.new(0, 0.2, 0.9)},
		[109520550485360] = {tempat = "kepala", off = CFrame.new(0, 0, 0), sembunyiKepala = true},
	},
	ZOMBIE_R15 = {idle = 619535834, walk = 619537468, run = 619536621, jump = 619536283, fall = 619535616, climb = 619535091, swim = 619537096},
	SLOT = {idle = {"idle", {"Animation1", "Animation2"}}, walk = {"walk", {"WalkAnim"}}, run = {"run", {"RunAnim"}}, jump = {"jump", {"JumpAnim"}}, fall = {"fall", {"FallAnim"}}, climb = {"climb", {"ClimbAnim"}}, swim = {"swim", {"Swim"}}},
	ATYPE = {[51] = "idle", [55] = "walk", [53] = "run", [52] = "jump", [50] = "fall", [48] = "climb", [54] = "swim"},
	ACC_TYPE = { [8]=true,[41]=true,[42]=true,[43]=true,[44]=true,[45]=true,[46]=true,[47]=true,[57]=true,[58]=true,[64]=true,[65]=true,[66]=true,[67]=true,[68]=true,[69]=true,[70]=true,[71]=true,[72]=true,[76]=true,[77]=true },
	LARP = {
		{nama = "Larp 1 (boy)", tampil = true, keepBody = true, items = {10159600649, 139101716417676, 141742418, 15184892213, 131592085, 74891470}, headless = true, rambut = false, korKanan = true, shirt = 11112380477, pants = 15901064855},
		{nama = "Larp 2 (boy)", tampil = true, items = {15563758601, 13702160, 15967743}, headless = true, shirt = 101800403864268, pants = 117643174548182, bundle = 34852431243411},
		{nama = "Larp 3 (girl)", tampil = true, skala = {HeightScale = 1.02, WidthScale = 1, DepthScale = 1, HeadScale = 0.95, BodyTypeScale = 0, ProportionScale = 0.5},
			shirt = 12477364736, pants = 127850175870187, tshirt = 18317952413, face = 0,
			part = {Head = 123250617543449, Torso = 114206707267907, LeftArm = 75159926897589, RightArm = 76683091425509, LeftLeg = 80875865622618, RightLeg = 116347950599962},
			kulit = {HeadColor = Color3.fromRGB(252, 235, 219), TorsoColor = Color3.fromRGB(252, 235, 219), LeftArmColor = Color3.fromRGB(252, 235, 219), RightArmColor = Color3.fromRGB(252, 235, 219), LeftLegColor = Color3.fromRGB(252, 235, 219), RightLegColor = Color3.fromRGB(252, 235, 219)},
			acc = {
				{16986103339, "Face", false, 0}, {73433809808976, "Waist", false, 0}, {76486682516618, "Neck", false, 0},
				{86666157208996, "Shirt", true, 3}, {87231958325448, "Waist", false, 0}, {93657994013430, "Jacket", true, 4},
				{98398147667125, "LeftShoe", true, 1}, {102310423223816, "Shorts", true, 2}, {106435130820388, "Waist", false, 0},
				{108959094938055, "Hat", false, 0}, {114997243592366, "RightShoe", true, 0}, {117643155362118, "Shoulder", false, 0},
				{121393834748415, "TShirt", true, 9}, {136829649360498, "Waist", false, 0}, {140497120701064, "Neck", false, 0},
				{94021962797486, "Hair", true, 13},
			}},
		{nama = "Larp 4 (girl)", tampil = true, skala = {HeightScale = 0.94, WidthScale = 0.77, DepthScale = 0.88, HeadScale = 0.95, BodyTypeScale = 0, ProportionScale = 0},
			shirt = 11362664764, pants = 11633042493, face = 0,
			part = {Head = 96891473904291, Torso = 86499666, LeftArm = 86499716, RightArm = 86499698, LeftLeg = 0, RightLeg = 0},
			kulit = {HeadColor = Color3.fromRGB(248, 248, 248), TorsoColor = Color3.fromRGB(248, 248, 248), LeftArmColor = Color3.fromRGB(248, 248, 248), RightArmColor = Color3.fromRGB(248, 248, 248), LeftLegColor = Color3.fromRGB(248, 248, 248), RightLegColor = Color3.fromRGB(248, 248, 248)},
			acc = {
				{123319489118371, "Hair", true, 13},
			}},
		{nama = "Larp 5 (girl)", tampil = true, skala = {HeightScale = 0.93, WidthScale = 0.93, DepthScale = 0.96, HeadScale = 0.95, BodyTypeScale = 0.62, ProportionScale = 0.41},
			shirt = 72932915528070, pants = 16367009807, face = 0,
			part = {Head = 103031319453048, Torso = 114206707267907, LeftArm = 75159926897589, RightArm = 76683091425509, LeftLeg = 14755628952, RightLeg = 14755631027},
			kulit = {HeadColor = Color3.fromRGB(248, 248, 248), TorsoColor = Color3.fromRGB(248, 248, 248), LeftArmColor = Color3.fromRGB(248, 248, 248), RightArmColor = Color3.fromRGB(248, 248, 248), LeftLegColor = Color3.fromRGB(248, 248, 248), RightLegColor = Color3.fromRGB(248, 248, 248)},
			acc = {
				{16709907935, "Hat", false, 0}, {18753881484, "Shirt", true, 4}, {77755885512278, "Shirt", true, 0},
				{80626138551363, "TShirt", true, 3}, {88435463187701, "Neck", false, 0}, {97711457387108, "Shirt", true, 1},
				{107151900164834, "Jacket", true, 5}, {110450606891774, "TShirt", true, 2}, {120378895682860, "Face", false, 0},
				{16998945216, "Hair", true, 2},
			}},
		{nama = "Larp 6 (girl)", tampil = true, skala = {HeightScale = 0.98, WidthScale = 0.9, DepthScale = 0.95, HeadScale = 0.95, BodyTypeScale = 0.17, ProportionScale = 0.97},
			shirt = 73661566234463, pants = 87665895041930, tshirt = 15421235444, face = 0,
			part = {Head = 14755628872, Torso = 114206707267907, LeftArm = 75159926897589, RightArm = 76683091425509, LeftLeg = 119392407702016, RightLeg = 100695610012736},
			kulit = {HeadColor = Color3.fromRGB(249, 249, 249), TorsoColor = Color3.fromRGB(249, 249, 249), LeftArmColor = Color3.fromRGB(249, 249, 249), RightArmColor = Color3.fromRGB(249, 249, 249), LeftLegColor = Color3.fromRGB(249, 249, 249), RightLegColor = Color3.fromRGB(249, 249, 249)},
			acc = {
				{13538877047, "Hair", true, 13},
				{14476554978, "Hat", false, 0}, {15348443679, "Neck", false, 0}, {16933957658, "Waist", false, 0},
				{18753841366, "Shirt", true, 1}, {18839953935, "Hat", false, 0}, {73956060408695, "Jacket", true, 0},
				{75874979129458, "Neck", false, 0}, {87213649184619, "Hat", false, 0}, {107020944632130, "Hat", false, 0},
				{133390277113217, "Face", false, 0},
			}},
		{nama = "Larp 7 (boy)", tampil = true, skala = {HeightScale = 0.9, WidthScale = 0.76, DepthScale = 0.88, HeadScale = 1, BodyTypeScale = 0.21, ProportionScale = 0},
			shirt = 17435420276, pants = 6678547575, face = 0,
			part = {Head = 15093053680, Torso = 0, LeftArm = 0, RightArm = 0, LeftLeg = 134444446333310, RightLeg = 139607718},
			kulit = {HeadColor = Color3.fromRGB(237, 213, 180), TorsoColor = Color3.fromRGB(237, 213, 180), LeftArmColor = Color3.fromRGB(237, 213, 180), RightArmColor = Color3.fromRGB(237, 213, 180), LeftLegColor = Color3.fromRGB(237, 213, 180), RightLegColor = Color3.fromRGB(237, 213, 180)},
			acc = {
				{94901203295166, "Hair", true, 13},
				{17468955006, "Neck", false, 0}, {89541920843310, "Face", false, 0}, {114757506326457, "Pants", true, 6},
				{117349952263277, "Back", false, 0}, {120261379853043, "Waist", false, 0}, {132586558875162, "Hat", false, 0},
			}},
		{nama = "Larp 8 (boy)", tampil = true, skala = {HeightScale = 0.92, WidthScale = 0.7, DepthScale = 0.85, HeadScale = 1, BodyTypeScale = 0.24, ProportionScale = 0.48},
			shirt = 79655977696267, pants = 121130943071383, face = 0,
			part = {Head = 15093053680, Torso = 0, LeftArm = 0, RightArm = 0, LeftLeg = 0, RightLeg = 139607718},
			kulit = {HeadColor = Color3.fromRGB(240, 205, 196), TorsoColor = Color3.fromRGB(240, 205, 196), LeftArmColor = Color3.fromRGB(240, 205, 196), RightArmColor = Color3.fromRGB(240, 205, 196), LeftLegColor = Color3.fromRGB(240, 205, 196), RightLegColor = Color3.fromRGB(240, 205, 196)},
			acc = {
				{128217885, "Shoulder", false, 0}, {187998056, "Neck", false, 0}, {7029045446, "Waist", false, 0},
				{10159600649, "Hat", false, 0}, {10159610478, "Hat", false, 0}, {17756304457, "Hat", false, 0},
				{78528175321289, "Back", false, 0}, {80695286291268, "Pants", true, 6}, {80738608422250, "Hat", false, 0},
				{119206308403996, "Front", false, 0}, {132088415927261, "Hat", false, 0},
			}},
		{nama = "Larp 9 (girl zepeto)", tampil = true, skala = {HeightScale = 1.04, WidthScale = 1, DepthScale = 1, HeadScale = 0.95, BodyTypeScale = 1, ProportionScale = 0},
			shirt = 0, pants = 76626042089750, face = 0,
			part = {Head = 106591500385507, Torso = 134717005197652, LeftArm = 89143502376032, RightArm = 130548515013957, LeftLeg = 72234257632785, RightLeg = 106894876305910},
			kulit = {HeadColor = Color3.fromRGB(240, 205, 196), TorsoColor = Color3.fromRGB(240, 205, 196), LeftArmColor = Color3.fromRGB(240, 205, 196), RightArmColor = Color3.fromRGB(240, 205, 196), LeftLegColor = Color3.fromRGB(240, 205, 196), RightLegColor = Color3.fromRGB(240, 205, 196)},
			acc = {
				{81366453258399, "Hair", true, 13},
				{150381051, "Shoulder", false, 0}, {81550816889926, "Hat", false, 0}, {83120578648455, "Hat", false, 0},
				{88176794011465, "Eyelash", true, 1}, {98321888453897, "DressSkirt", true, 4}, {105589647195735, "Jacket", true, 5},
				{107494881345548, "Neck", false, 0}, {115052821586749, "LeftShoe", true, 1}, {131077643734767, "Hat", false, 0},
				{131189165805302, "Shirt", true, 3}, {133243059747228, "RightShoe", true, 2}, {136394204161305, "DressSkirt", true, 0},
			}},
		{nama = "Larp 10 (clasic boy)", tampil = true, skala = {HeightScale = 1, WidthScale = 1, DepthScale = 1, HeadScale = 1, BodyTypeScale = 0, ProportionScale = 0},
			shirt = 3057887732, pants = 6462753014, face = 0,
			part = {Head = 15093053680, Torso = 376532000, LeftArm = 376530220, RightArm = 376531012, LeftLeg = 376531300, RightLeg = 376531703},
			kulit = {HeadColor = Color3.fromRGB(255, 204, 153), TorsoColor = Color3.fromRGB(255, 204, 153), LeftArmColor = Color3.fromRGB(255, 204, 153), RightArmColor = Color3.fromRGB(255, 204, 153), LeftLegColor = Color3.fromRGB(255, 204, 153), RightLegColor = Color3.fromRGB(255, 204, 153)},
			acc = {
				{16630147, "Hair", true, 13},
				{9255011, "Hat", false, 0}, {5731049064, "Back", false, 0}, {6651264473, "Back", false, 0},
				{8770132654, "Neck", false, 0}, {16477149823, "Hat", false, 0}, {17213230300, "Back", false, 0},
			}},
	},
	WARNA = {
		{"Putih", Color3.fromRGB(255, 255, 255)}, {"Hitam", Color3.fromRGB(25, 25, 25)},
		{"Merah", Color3.fromRGB(0, 229, 255)}, {"Biru", Color3.fromRGB(40, 110, 240)},
		{"Hijau", Color3.fromRGB(60, 200, 90)}, {"Kuning", Color3.fromRGB(250, 220, 60)},
		{"Ungu", Color3.fromRGB(150, 70, 230)}, {"Orange", Color3.fromRGB(255, 122, 0)},
	},
	FP = {
		display = "marzu", handle = "@tamagaz3", bio = "hello",
		friends = 64, followers = 211, following = 0,
		btnAppearance = "Edit appearance", btnProfile = "Edit profile",
		cardBgUrl = "", avatarBgUrl = "", headBgUrl = "",
		show3D = true, badgeText = "3D",
		btnMinWidth = 120, btnPadX = 18, btnGap = 10, btnOffsetRight = 0,
	},
}

S = {
	items = {}, byId = {}, logs = {},
	alive = true, pantau = false, lastTarget = nil,
	headOn = false, headConn = nil,
	kor = {on = false, objs = {}, hid = {}, conn = nil, tinggi = 0},
	kiri = {on = false, objs = {}, hid = {}, conn = nil},
	cam = {on = false, fov = 70, dist = 6, conn = nil},
	anim = {orig = {}, want = nil, custom = {}},
	emote = {track = nil, anim = nil, conn = nil, nama = ""},
	baju = {}, bajuWant = {},
	emOrig = setmetatable({}, {__mode = "k"}),
	pilih = nil, skin = {slots = {}}, skala = 1,
	hideKey = Enum.KeyCode.RightControl, hideNama = "RightControl", hideConn = nil,
	ui = {}, urut = 0, gantiJeda = 0.6, rambutOn = false, rambutOrig = {},
    fp = {
        display = C.FP.display, handle = C.FP.handle, bio = C.FP.bio,
        friends = C.FP.friends, followers = C.FP.followers, following = C.FP.following,
        btnAppearance = C.FP.btnAppearance, btnProfile = C.FP.btnProfile,
    },
    cardW = 320, cardH = 520, avatarH = 250, cardScale = 100,
}
for i = 1, C.SLOT_SKIN do S.skin.slots[i] = {kosong = true} end

-- =====================================================================
-- GESER & SISTEM INTI
-- =====================================================================
local function geser(h, t, onTap)
	local dr, ms, fs, banyak = false, nil, nil, false
	h.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dr, banyak = true, false; ms, fs = i.Position, t.Position
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			if dr and not banyak and onTap then onTap() end; dr = false
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dr and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - ms; if d.Magnitude > 6 then banyak = true end
			t.Position = UDim2.new(fs.X.Scale, fs.X.Offset + d.X, fs.Y.Scale, fs.Y.Offset + d.Y)
		end
	end)
end
F.geser = geser

function F.catat(t)
	local okT, w = pcall(os.date, "%H:%M:%S")
	local s = tostring(t)
	table.insert(S.logs, "[" .. (okT and w or "--") .. "] " .. s)
	while #S.logs > 200 do table.remove(S.logs, 1) end
	print("ZENOX " .. s)
	local ui = S.ui
	if ui.logBox then ui.logBox.Text = table.concat(S.logs, "\n") end
	if ui.statusBox then
		ui.statusBox.Text = s
		local buruk = string.find(s, "gagal") ~= nil or string.find(s, "error") ~= nil or string.find(s, "DIHAPUS") ~= nil
		ui.statusBox.TextColor3 = buruk and BAD or GOOD
	end
	if string.find(s, "error") then F.notif("ZENOX ERROR", s, 6) end
end
function F.aman(fn) local ok, e = pcall(fn); if not ok then F.catat("error: " .. string.sub(tostring(e), 1, 140)) end end

function F.rigModel(p)
	local r = workspace:FindFirstChild("Rigs")
	local m = r and r:FindFirstChild((p or me).Name)
	if m then return m end
	return nil
end
function F.modelOf(p) return F.rigModel(p) or p.Character end
function F.target() return F.modelOf(me) end
function F.isRig(m) return m ~= nil and m == F.rigModel(me) end

local function attCari(m, nama)
	for _, d in ipairs(m:GetDescendants()) do
		if d:IsA("Attachment") and d.Name == nama and d.Parent:IsA("BasePart") and d.Parent.Parent == m then
			return d
		end
	end
	return nil
end


-- cermin pose terhadap badan (sumbu kiri-kanan), hasilnya dalam ruang badan

-- =====================================================================
-- FITUR ITEM
-- =====================================================================
function F.cfgBaru() return {ox = 0, oy = 0, oz = 0, skala = 1, warna = nil, rate = 1, size = 1} end
function F.gaya(part, cfg)
	cfg = cfg or F.cfgBaru()
	if cfg.skala ~= 1 then part.Size = part.Size * cfg.skala end
	if cfg.warna then part.Color = cfg.warna end
end
function F.pasangWeld(m, acc, tag, cfg)
	local h0 = acc:FindFirstChild("Handle")
	local att = h0 and h0:FindFirstChildOfClass("Attachment")
	if not h0 or not att then return nil, "Handle/attachment tidak ada" end
	local tgt = attCari(m, att.Name)
	if not tgt then return nil, "attachment tidak ada" end
	cfg = cfg or F.cfgBaru()
	local c = h0:Clone()
	for _, v in ipairs(c:GetChildren()) do
		if v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("Motor6D") then v:Destroy() end
	end
	c.Name = "Zenox" .. tostring(tag)
	c.Anchored = false; c.CanCollide = false; c.CanQuery = false; c.CanTouch = false; c.Massless = true
	F.gaya(c, cfg)
	c.CFrame = tgt.WorldCFrame * CFrame.new(cfg.ox, cfg.oy, cfg.oz) * att.CFrame:Inverse()
	c.Parent = m
	local w = Instance.new("WeldConstraint")
	w.Part0 = tgt.Parent; w.Part1 = c; w.Parent = c
	return c, "weld"
end
function F.pasangAks(m, obj, it)
	local acc = obj:IsA("Accessory") and obj or obj:FindFirstChildWhichIsA("Accessory", true)
	if not acc then obj:Destroy(); return false, "bukan aksesoris" end
	it.tipe = acc.AccessoryType
	if it.src then pcall(function() it.src:Destroy() end); it.src = nil end
	acc.Parent = nil
	local c, info = F.pasangWeld(m, acc, it.id, it.cfg)
	if not c then
		-- cadangan: pasang lewat fungsi bawaan Roblox di Humanoid karakter
		local hum = me.Character and me.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			local okA, eA = pcall(function() hum:AddAccessory(acc) end)
			if okA and acc.Parent then obj:Destroy(); it.obj = acc; return true, "AddAccessory" end
			info = tostring(info) .. " | AddAccessory: " .. string.sub(tostring(eA), 1, 60)
		end
		obj:Destroy(); acc:Destroy(); return false, info
	end
	obj:Destroy()
	it.src = acc; it.obj = c
	return true, info
end

function F.angkatTangan(m, state)
    if not m then m = F.target() end
    if not m then return end
    local torso = m:FindFirstChild("Torso") or m:FindFirstChild("UpperTorso")
    local shL = torso and (torso:FindFirstChild("Left Shoulder") or torso:FindFirstChild("LeftShoulder"))
    local shR = torso and (torso:FindFirstChild("Right Shoulder") or torso:FindFirstChild("RightShoulder"))
    
    if not shL or not shL:IsA("Motor6D") then return end
    
    if state then
        if not shL:GetAttribute("OrigC0") then
            shL:SetAttribute("OrigC0", shL.C0)
            if shR then shR:SetAttribute("OrigC0", shR.C0) end
        end
        local c0L = shL:GetAttribute("OrigC0")
        shL.C0 = c0L * CFrame.Angles(math.rad(-90), 0, 0)
        
        if shR then
            local c0R = shR:GetAttribute("OrigC0")
            shR.C0 = c0R * CFrame.Angles(math.rad(-90), 0, 0)
        end
    else
        local c0L = shL:GetAttribute("OrigC0")
        if c0L then shL.C0 = c0L; shL:SetAttribute("OrigC0", nil) end
        if shR then
            local c0R = shR:GetAttribute("OrigC0")
            if c0R then shR.C0 = c0R; shR:SetAttribute("OrigC0", nil) end
        end
    end
end

function F.cekAdaGear(m)
    for _, it in ipairs(S.items) do if it.kind == "gear" and it.on then return true end end
    return false
end
function F.tasBackpack(tunggu)
	local bp = me:FindFirstChildOfClass("Backpack")
	if not bp and tunggu then local ok, r = pcall(function() return me:WaitForChild("Backpack", 5) end); if ok then bp = r end end
	return bp
end
function F.tasPasang(it, bp)
	if it.inv then pcall(function() it.inv:Destroy() end) end
	local salin = it.tpl:Clone()
	salin.Parent = bp
	it.inv = salin
end
function F.tasCek(tunggu)
	local bp = F.tasBackpack(tunggu)
	if not bp then return end
	for _, it in ipairs(S.items) do
		if it.kind == "gear" and it.tpl then
			if it.on then
				-- hanya gear yang sedang dipilih (nyala) yang tampil di tas
				local ada = it.inv and it.inv.Parent ~= nil
				if not ada then F.tasPasang(it, bp) end
			elseif it.inv then
				pcall(function() it.inv:Destroy() end)
				it.inv = nil
			end
		end
	end
end
function F.tasSimpan(it, tool, tunggu)
	if not it.tpl then
		local salin = tool:Clone()
		for _, d in ipairs(salin:GetDescendants()) do if d:IsA("Script") or d:IsA("LocalScript") then pcall(function() d:Destroy() end) end end
		it.tpl = salin
	end
    F.tasCek(tunggu)
end
function F.gearMuatTas(it)
	local obj = muat(it.id)
	if not obj then return end
	local tool = obj:IsA("Tool") and obj or obj:FindFirstChildWhichIsA("Tool", true)
	if tool then F.tasSimpan(it, tool, true) end
	obj:Destroy()
end
function F.pasangGear(m, obj, it)
	local tool = obj:IsA("Tool") and obj or obj:FindFirstChildWhichIsA("Tool", true)
	if not tool or not tool:FindFirstChild("Handle") then obj:Destroy(); return false, "bukan gear" end
	local hum = m:FindFirstChildOfClass("Humanoid") or (me.Character and me.Character:FindFirstChildOfClass("Humanoid"))
	local bp = F.tasBackpack(true)
	if not hum or not bp then obj:Destroy(); return false, "karakter/tas belum siap" end
	F.tasSimpan(it, tool, false)
	obj:Destroy()
	local dipegang = it.inv
	if not dipegang then return false, "salinan tool gagal" end
	-- Roblox yang memasang: tool dipindah dari tas ke karakter, pegangannya bawaan pabrik
	local okE, errE = pcall(function() hum:EquipTool(dipegang) end)
	if not okE then F.catat("gear: EquipTool gagal: " .. string.sub(tostring(errE), 1, 80)) end
	if dipegang.Parent == bp then F.catat("gear: masih di tas, belum dipegang") end
	it.obj = dipegang
	local o = it.cfg or F.cfgBaru()
	if o.ox ~= 0 or o.oy ~= 0 or o.oz ~= 0 then
		-- geser kanan/kiri, atas/bawah, depan/belakang: ditambahkan ke sambungan tangan bawaan
		task.delay(0.1, function()
			for _, d in ipairs(m:GetDescendants()) do
				if d:IsA("Weld") and d.Name == "RightGrip" and d.Part1 and d.Part1.Parent == dipegang then
					d.C0 = d.C0 * CFrame.new(o.ox, o.oy, o.oz)
				end
			end
		end)
	end
	return true, "gear dipegang"
end
function F.tasGear(yang)
	for _, o in ipairs(S.items) do
		if o ~= yang and o.kind == "gear" and o.on then
			F.setOn(o, false)
			F.catat(o.nama .. " masuk tas")
		end
	end
end

function F.muatItem(it)
	if not it.cache then it.cache = muat(it.id) end
	if not it.cache then return nil end
	local ok, salin = pcall(function() return it.cache:Clone() end)
	if ok and salin then return salin end
	return muat(it.id)
end

local function adaKelas(o, k) return o:IsA(k) or o:FindFirstChildWhichIsA(k, true) ~= nil end
-- item posisi khusus: ditempel ke bagian tubuh dengan offset dari C.POSISI
function F.pasangTempel(m, obj, it)
	local info = C.POSISI[it.id]
	local host
	if info.tempat == "kepala" then host = m:FindFirstChild("Head")
	else host = m:FindFirstChild("UpperTorso") or m:FindFirstChild("Torso") end
	if not host then obj:Destroy(); return false, "bagian tubuh tidak ada" end
	local cfg = it.cfg or F.cfgBaru()
	local parts = {}
	for _, d in ipairs(obj:GetDescendants()) do if d:IsA("BasePart") then table.insert(parts, d) end end
	if #parts == 0 then obj:Destroy(); return false, "tidak ada bagian" end
	-- weld yang menunjuk ke luar objek (sambungan aksesoris bawaan) dibuang, weld di dalam objek dipertahankan
	for _, d in ipairs(obj:GetDescendants()) do
		if d:IsA("Weld") or d:IsA("WeldConstraint") then
			local p0, p1 = d.Part0, d.Part1
			if not (p0 and p1 and p0:IsDescendantOf(obj) and p1:IsDescendantOf(obj)) then d:Destroy() end
		end
	end
	if it.obj then pcall(function() it.obj:Destroy() end); it.obj = nil end
	local root = parts[1]
	local rel = {}
	for i, p in ipairs(parts) do rel[i] = root.CFrame:ToObjectSpace(p.CFrame) end
	local baseCF = host.CFrame * info.off * CFrame.new(cfg.ox or 0, cfg.oy or 0, cfg.oz or 0)
	local holder = Instance.new("Model"); holder.Name = "Zenox" .. tostring(it.id)
	for i, p in ipairs(parts) do
		if cfg.skala ~= 1 then F.gaya(p, cfg) end
		p.Anchored = false; p.CanCollide = false; p.CanQuery = false; p.CanTouch = false; p.Massless = true
		p.Parent = holder
		p.CFrame = baseCF * rel[i]
	end
	holder.Parent = m
	for _, p in ipairs(parts) do
		local w = Instance.new("WeldConstraint"); w.Part0 = host; w.Part1 = p; w.Parent = p
	end
	obj:Destroy()
	it.obj = holder; it.src = nil
	if info.sembunyiKepala then S.secretHid = true; local hd = m:FindFirstChild("Head"); if hd then local asli = hd.Transparency; hd.Transparency = 1; local prev = it.restore; it.restore = function() if prev then pcall(prev) end; if hd.Parent then hd.Transparency = asli end end end end
	return true, info.tempat
end
-- item wajah (Face/Decal): ganti tekstur muka di kepala, dikembalikan saat item dilepas
function F.pasangWajah(m, obj, it)
	local decal = obj:IsA("Decal") and obj or obj:FindFirstChildWhichIsA("Decal", true)
	if not decal and it.id then decal = Instance.new("Decal"); decal.Texture = "rbxassetid://" .. tostring(it.id) end
	local head = m:FindFirstChild("Head")
	local muka = head and (head:FindFirstChild("face") or head:FindFirstChildWhichIsA("Decal"))
	if not decal or not muka then obj:Destroy(); return false, "wajah tidak bisa dipasang" end
	if it.restore then pcall(it.restore) end
	local asli, tex = muka.Texture, decal.Texture
	obj:Destroy()
	muka.Texture = tex
	-- saat headless kepala transparan dan decal muka ikut hilang: muka ditampilkan lewat BillboardGui
	local bb = mk("BillboardGui", {Name = "ZenoxWajah", Adornee = head, Size = UDim2.new(0, 72, 0, 72), AlwaysOnTop = true, Enabled = false}, head)
	mk("ImageLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Image = tex}, bb)
	it.restore = function() if muka.Parent then muka.Texture = asli end; if bb.Parent then bb:Destroy() end end
	return true, "wajah diganti"
end
function F.wajahSync()
	local m = F.target(); local hd = m and m:FindFirstChild("Head"); if not hd then return end
	for _, c in ipairs(hd:GetChildren()) do if c.Name == "ZenoxWajah" and c:IsA("BillboardGui") then c.Enabled = false end end
end
-- bersihkan sisa model item yang sudah dimatikan (mis. crown yang masih nempel)
function F.bersihYatim()
	local m = F.target(); if not m then return end
	for _, it in ipairs(S.items) do
		if not it.on then
			local nama = "Zenox" .. tostring(it.id)
			for _, c in ipairs(m:GetChildren()) do
				if c.Name == nama then pcall(function() c:Destroy() end); F.catat(it.nama .. " sisa dihapus") end
			end
		end
	end
end
function F.pasangItem(it)
	local m = F.target()
	if not m then return false, "karakter belum ada" end
	local obj = F.muatItem(it)
	if not obj and it.kind == "wajah" then obj = Instance.new("Decal"); obj.Texture = "rbxassetid://" .. tostring(it.id) end
	if not obj then return false, "asset gagal dimuat" end
	local baju = (adaKelas(obj, "Shirt") and "shirt") or (adaKelas(obj, "Pants") and "pants") or (adaKelas(obj, "ShirtGraphic") and "tshirt")
	if baju then
		obj:Destroy()
		return F.bajuSet(baju, it.id), "baju " .. baju
	end
	if C.POSISI[it.id] then return F.pasangTempel(m, obj, it) end
	local tool = obj:IsA("Tool") or obj:FindFirstChildWhichIsA("Tool", true)
	if tool or it.kind == "gear" then
		it.kind = "gear"
		F.tasGear(it)
		return F.pasangGear(m, obj, it)
	end
	if it.kind == "wajah" and (obj:IsA("Decal") or obj:FindFirstChildWhichIsA("Decal", true)) then return F.pasangWajah(m, obj, it) end
	if obj:IsA("Decal") or (not obj:FindFirstChildWhichIsA("Accessory", true) and obj:FindFirstChildWhichIsA("Decal", true)) then return F.pasangWajah(m, obj, it) end
	return F.pasangAks(m, obj, it)
end


function F.jalan(it, ket, n)
	n = n or 1
	if not it.on then return end
	if it.busy then it.ulang = true; return end
	it.busy = true
	local okP, ok, info = pcall(F.pasangItem, it)
	it.busy = false
	if it.ulang then
		it.ulang = false
		F.lepasObj(it)
		if it.on then task.spawn(F.jalan, it, "terapkan ulang", 1) end
		return
	end
	if not okP then F.catat(it.nama .. " ERROR: " .. string.sub(tostring(ok), 1, 100)); it.on = false; if it.set then it.set(false) end; return end
	if ok and not it.on then F.lepasObj(it); return end
	if ok then it.hapus = 0; if it.id == C.SECRET_ID then pcall(F.secretSync) end; if it.id == C.SECRET_ID or it.id == C.DOMINUS_ID then pcall(F.bersihKepala, it.id) end; F.efekTerapkan(it.obj, it.cfg); pcall(F.sembunyiTerapkan, it); F.catat(it.nama .. " " .. ket .. ": " .. tostring(info)); if it.set then it.set(true) end; return end
	F.catat(it.nama .. " gagal (" .. n .. "/5): " .. tostring(info))
	if it.on and n < 5 then task.delay(1, function() if it.on and not it.obj then F.jalan(it, ket, n + 1) end end)
	else it.on = false; if it.set then it.set(false) end; F.catat(it.nama .. " GAGAL TOTAL") end
end

function F.lepasObj(it)
	local rs = it.restore; it.restore = nil; if rs then pcall(rs) end
	local o = it.obj; it.obj = nil
	if o then pcall(function() o:Destroy() end) end
	local s = it.src; it.src = nil
	if s then pcall(function() s:Destroy() end) end
end
function F.setOn(it, v)
	if v and it.on and it.obj then if it.set then it.set(true) end; return end
	it.on = v
	if v then task.spawn(F.jalan, it, "pasang", 1)
	else
		F.lepasObj(it)
        if it.kind == "gear" then
            F.tasCek(false)
        end
		F.catat(it.nama .. " dilepas")
	end
	pcall(F.hairSync); pcall(F.bersihYatim)
	if it.id == C.SECRET_ID then pcall(F.secretSync) end
	if it.set then it.set(it.on) end
end
-- Dominus & Secret Head: saat dinyalakan, aksesoris topi (Hat) lain dilepas
function F.bersihKepala(sumber)
	local n = 0
	for _, it in ipairs(S.items) do
		if it.on and it.id ~= sumber and it.kind == "akses" and it.tipe == Enum.AccessoryType.Hat then F.setOn(it, false); n = n + 1 end
	end
	if n > 0 then F.catat("aksesoris kepala dilepas: " .. n) end
end
-- Secret Head: ON -> kamera menghadap depan, kepala & rambut disembunyikan.
-- OFF -> kamera kembali seperti semula, kepala & rambut kembali normal (lewat restore item).
function F.secretSync()
	local it = S.byId[C.SECRET_ID]
	local nyala = it ~= nil and it.on == true
	if nyala and not S.secretCam then
		S.secretCam = true
		S.secretCamPrev = S.cam.on
		if not S.cam.on then F.camSet(true) end
		F.catat("Secret Head ON: kamera depan")
	elseif not nyala and S.secretCam then
		S.secretCam = false
		if not S.secretCamPrev and S.cam.on then F.camSet(false) end
		S.secretCamPrev = nil
		F.catat("Secret Head OFF: kamera & kepala normal")
	end
	pcall(F.hairSync)
end
function F.addItem(nama, id, kind)
	if S.byId[id] then return S.byId[id] end
	local it = { nama = nama, id = id, kind = kind or "auto", on = false, obj = nil, src = nil, hapus = 0, busy = false, builtin = false, cfg = F.cfgBaru(), premium = false }
	table.insert(S.items, it); S.byId[id] = it
	if S.ui.itemAdd then S.ui.itemAdd(it) end
	F.pilihRender()
	return it
end

function F.terapkanUlang(it)
	if not it.on then return end
	if it.busy then it.ulang = true; return end
	F.lepasObj(it)
	task.spawn(F.jalan, it, "terapkan ulang", 1)
end


-- =====================================================================
-- PILIH ITEM, EFEK & SETTING (FIX ERROR NIL)
-- =====================================================================
function F.pilihWajib() if S.pilih then return true end; F.catat("pilih item dulu"); return false end
function F.pilihTeks()
	local it = S.pilih
	if not it then
		if #S.items == 0 then return "belum ada item." end
		return "belum pilih item."
	end
	return "dipilih: " .. it.nama .. (it.on and "" or "  (belum nyala)")
end
function F.pilihKe(it) S.pilih = it; F.pilihRender(); F.segarkanUI(); F.catat("dipilih: " .. it.nama) end
function F.pilihRender()
	for _, w in ipairs(S.ui.pilihWadah or {}) do
		if w.Parent then
			for _, c in ipairs(w:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
			for i, it in ipairs(F.itemTampil()) do
				local dipilih = S.pilih == it
				local b = mk("TextButton", {
					Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = dipilih and OR or ROW,
					Text = it.nama, TextColor3 = dipilih and BLK or TXT, Font = FM, TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
					AutoButtonColor = false, LayoutOrder = i,
				}, w)
				rnd(b)
				b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() F.pilihKe(it) end) end)
			end
		end
	end
end
function F.daftarSegar(fn) S.ui.segar = S.ui.segar or {}; table.insert(S.ui.segar, fn) end
function F.segarkanUI()
	for _, fn in ipairs(S.ui.segar or {}) do pcall(fn) end
end
function F.nilaiPilih(kunci, fmtFn) local it = S.pilih; if not it then return "-" end; local val = it.cfg[kunci]; if type(val) ~= "number" then val = 1 end; return fmtFn(val) end

function F.efekTerapkan(root, cfg)
	if not root or not root.Parent then return end
	cfg = cfg or F.cfgBaru()
	for _, d in ipairs(root:GetDescendants()) do
		if d:IsA("ParticleEmitter") then
			local o = S.emOrig[d]
			if not o then o = {rate = d.Rate, size = d.Size}; S.emOrig[d] = o end
			d.Rate = math.min(o.rate * cfg.rate, 500)
			local keys = {}
			for k, kp in ipairs(o.size.Keypoints) do keys[k] = NumberSequenceKeypoint.new(kp.Time, math.min(kp.Value * cfg.size, 100), kp.Envelope) end
			d.Size = NumberSequence.new(keys)
		end
	end
end

function F.efekSet(kind, v)
	if not F.pilihWajib() then return end
	local it = S.pilih; it.cfg[kind] = v
	if it.obj then F.efekTerapkan(it.obj, it.cfg) end
	if not it.on then F.setOn(it, true) end
	F.catat(string.format("%s %s: %.1fx", it.nama, kind, v)); F.segarkanUI()
end

function F.efekGeser(kind, d)
	if not F.pilihWajib() then return end
	local current = S.pilih.cfg[kind] or 1
	local nv = math.floor(math.clamp(current + d, 0.5, 8) * 10 + 0.5) / 10
	F.efekSet(kind, nv)
end
function F.efekReset()
	if not F.pilihWajib() then return end
	local it = S.pilih; it.cfg.rate, it.cfg.size = 1, 1
	if it.obj then F.efekTerapkan(it.obj, it.cfg) end
	F.catat(it.nama .. " efek direset"); F.segarkanUI()
end

function F.aplikasiItem(it)
	if it.on then F.terapkanUlang(it) else F.setOn(it, true) end
end

-- nilai posisi/besar item terpilih (kotak ketik & tombol - +)
function F.itemSet(kunci, v)
	if not F.pilihWajib() then return end
	local it = S.pilih
	local lo, hi = -5, 5
	if kunci == "skala" then lo, hi = 0.5, 2 end
	it.cfg[kunci] = math.floor(math.clamp(v, lo, hi) * 10 + 0.5) / 10
	F.aplikasiItem(it)
end

function F.itemGeser(sumbu, d)
	if not F.pilihWajib() then return end
	F.itemSet(sumbu, (S.pilih.cfg[sumbu] or 0) + d)
end


function F.itemSkala(d)
	if not F.pilihWajib() then return end
	F.itemSet("skala", (S.pilih.cfg.skala or 1) + d)
end


function F.itemWarna(col, nama)
	if not F.pilihWajib() then return end
	local it = S.pilih; it.cfg.warna = col; F.aplikasiItem(it); F.catat(it.nama .. " warna: " .. (nama or "asli"))
end


function F.itemReset()
	if not F.pilihWajib() then return end
	local it = S.pilih; it.cfg = F.cfgBaru(); F.terapkanUlang(it); F.catat(it.nama .. " reset")
end

function F.cfgResetSemua() for _, it in ipairs(S.items) do it.cfg = F.cfgBaru(); F.terapkanUlang(it) end end

-- =====================================================================
-- KARAKTER & KAMERA
-- =====================================================================
function F.bajuPada(m, kelas, id)
	local cls, prop
	if kelas == "shirt" then cls, prop = "Shirt", "ShirtTemplate"
	elseif kelas == "pants" then cls, prop = "Pants", "PantsTemplate"
	elseif kelas == "tshirt" then cls, prop = "ShirtGraphic", "Graphic"
	else return nil end
	
	local o = m:FindFirstChildOfClass(cls)
	local buat = false; local asli = nil
	if o then asli = o[prop]
	else o = Instance.new(cls); o.Parent = m; buat = true end
	o[prop] = tostring(id)
	return {obj = o, prop = prop, asli = asli, buat = buat}
end

function F.bajuTemplate(kelas, id)
	local cls, prop = "Shirt", "ShirtTemplate"
	if kelas == "pants" then cls, prop = "Pants", "PantsTemplate"
	elseif kelas == "tshirt" then cls, prop = "ShirtGraphic", "Graphic" end
	local obj = muat(id)
	if obj then
		local src = obj:IsA(cls) and obj or obj:FindFirstChildWhichIsA(cls, true)
		if src then
			local ok, v = pcall(function() return src[prop] end)
			if ok and type(v) == "string" and v ~= "" then return v end
		end
	end
	return "rbxassetid://" .. tostring(id)
end

function F.bajuSet(kelas, id)
	local m = F.target()
	if not m then return false end
	local tpl = F.bajuTemplate(kelas, id)
	local rec = S.baju[kelas]
	if rec and rec.obj and rec.obj.Parent == m then rec.obj[rec.prop] = tpl
	else S.baju[kelas] = F.bajuPada(m, kelas, tpl) end
	S.bajuWant[kelas] = id; F.catat(kelas .. " " .. tostring(id))
	return true
end

function F.bajuReset()
	for _, rec in pairs(S.baju) do
		if rec.obj then
			pcall(function() if rec.buat then rec.obj:Destroy() else rec.obj[rec.prop] = rec.asli or "" end end)
		end
	end
	S.baju = {}; S.bajuWant = {}
end
-- baju: hapus baju asli (dicadangkan dulu), pasang baju baru, atau kembalikan baju asli
function F.bajuHapus()
	local m = F.target(); if not m then return end
	if not S.bajuBackup then
		local cad = {}
		for _, c in ipairs(m:GetChildren()) do if c:IsA("Shirt") or c:IsA("ShirtGraphic") then table.insert(cad, c:Clone()) end end
		S.bajuBackup = cad
	end
	for _, c in ipairs(m:GetChildren()) do if c:IsA("Shirt") or c:IsA("ShirtGraphic") then c:Destroy() end end
	S.baju = {}; S.bajuWant.shirt = nil; S.bajuWant.tshirt = nil
	F.catat("baju dihapus")
end
function F.bajuGanti(id)
	local kelas = "shirt"
	local ok, inf = pcall(function() return MPS:GetProductInfo(id) end)
	if ok and inf and inf.AssetTypeId == 2 then kelas = "tshirt" end
	F.bajuHapus()
	F.bajuSet(kelas, id)
end
function F.bajuKembali()
	local m = F.target(); if not m then return end
	for _, c in ipairs(m:GetChildren()) do if c:IsA("Shirt") or c:IsA("ShirtGraphic") then c:Destroy() end end
	for _, c in ipairs(S.bajuBackup or {}) do pcall(function() c.Parent = m end) end
	S.bajuBackup = nil; S.baju = {}; S.bajuWant.shirt = nil; S.bajuWant.tshirt = nil
	F.catat("baju asli dikembalikan")
end
-- celana: ganti celana asli (dicadangkan dulu). kalau ID ternyata baju, diperlakukan sebagai baju
function F.celanaGanti(id)
	local m = F.target(); if not m then return end
	local kelas = "pants"
	local ok, inf = pcall(function() return MPS:GetProductInfo(id) end)
	if ok and inf then local t = inf.AssetTypeId; if t == 11 or t == 2 then kelas = "shirt" end end
	if kelas ~= "pants" then return F.bajuGanti(id) end
	if not S.celanaBackup then
		local cad = {}
		for _, c in ipairs(m:GetChildren()) do if c:IsA("Pants") then table.insert(cad, c:Clone()) end end
		S.celanaBackup = cad
	end
	for _, c in ipairs(m:GetChildren()) do if c:IsA("Pants") then c:Destroy() end end
	S.baju.pants = nil
	F.bajuSet("pants", id)
end
function F.celanaKembali()
	local m = F.target(); if not m then return end
	for _, c in ipairs(m:GetChildren()) do if c:IsA("Pants") then c:Destroy() end end
	for _, c in ipairs(S.celanaBackup or {}) do pcall(function() c.Parent = m end) end
	S.celanaBackup = nil; S.baju.pants = nil; S.bajuWant.pants = nil
	F.catat("celana asli dikembalikan")
end
-- kecerahan panel utama (1 = penuh, 0 = tidak kelihatan tapi masih ada).
function F.uiTerapkan()
	local gui = S.ui.gui; if not gui then return end
	S.uiOrig = S.uiOrig or {}
	local a = S.uiAlpha or 1
	local mini = S.ui.mini
	for _, d in ipairs(gui:GetDescendants()) do
		local lewat = d == mini
		if not lewat then
			local o = S.uiOrig[d]
			if not o then o = {}; S.uiOrig[d] = o end
			if d:IsA("GuiObject") then
				if o.bg == nil then o.bg = d.BackgroundTransparency end
				d.BackgroundTransparency = 1 - (1 - o.bg) * a
			end
			if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
				if o.txt == nil then o.txt = d.TextTransparency end
				d.TextTransparency = 1 - (1 - o.txt) * a
			elseif d:IsA("ImageLabel") or d:IsA("ImageButton") then
				if o.img == nil then o.img = d.ImageTransparency end
				d.ImageTransparency = 1 - (1 - o.img) * a
			elseif d:IsA("UIStroke") then
				if o.st == nil then o.st = d.Transparency end
				d.Transparency = 1 - (1 - o.st) * a
			end
		end
	end
end
function F.uiAlphaSet(v)
	S.uiAlpha = math.floor(math.clamp(v, 0, 1) * 10 + 0.5) / 10
	F.uiTerapkan()
end
function F.uiAlphaGeser(d) F.uiAlphaSet((S.uiAlpha or 1) + d) end
function F.skalaSet(v)
	S.skala = math.floor(math.clamp(v, 0.6, 1.4) * 10 + 0.5) / 10
	if S.ui.skalaUI then S.ui.skalaUI.Scale = S.skala end
	F.catat("besar UI: " .. tostring(math.floor(S.skala * 100 + 0.5)) .. "%")
end
function F.headSet(v)
	S.headOn = v
	if S.headConn then S.headConn:Disconnect(); S.headConn = nil end
	if v then
		S.headConn = RS.Heartbeat:Connect(function()
			local m = F.target(); local hd = m and m:FindFirstChild("Head")
			if hd and hd.Transparency ~= 1 then hd.Transparency = 1 end
		end)
	else
		local m = F.target(); local hd = m and m:FindFirstChild("Head"); if hd then hd.Transparency = 0 end
	end
	pcall(F.wajahSync)
end
-- Headless v2: kepala diganti Hollow Horseman Dynamic Head lewat jalur body (R6 & R15)
function F.korClearS(st)
	if st.conn then st.conn:Disconnect(); st.conn = nil end
	for _, o in ipairs(st.objs) do pcall(function() o:Destroy() end) end
	st.objs = {}; st.sync = {}
	for p, t in pairs(st.hid) do if p.Parent then p.Transparency = t end end
	st.hid = {}
end
-- Korblox: mesh di-WELD ke bagian kaki rig, jadi ikut gerak bareng kaki (tanpa sinkron CFrame per frame).
-- Posisi awal diambil dari pasangan attachment yang paling dekat dengan kaki asli.
function F.korLas(tg, c)
	local w = Instance.new("WeldConstraint"); w.Part0 = tg; w.Part1 = c; w.Parent = c
end
-- sisi = "Right" atau "Left"; st = state kaki itu (S.kor atau S.kiri). Tinggi & geser dipakai bersama.
function F.korR15(m, sisi, st)
	local obj = muat(sisi == "Left" and C.KOR_KIRI or C.KOR_R15)
	if not obj then return false, "asset gagal" end
	local n = 0
	local off = CFrame.new(S.kor.geserX or 0, S.kor.tinggi, S.kor.geserZ or 0)
	for _, nm in ipairs({sisi .. "UpperLeg", sisi .. "LowerLeg", sisi .. "Foot"}) do
		local tg = m:FindFirstChild(nm); local src = obj:FindFirstChild(nm, true)
		if tg and tg:IsA("MeshPart") and src and src:IsA("MeshPart") then
			local terbaik, jarakMin = nil, math.huge
			for _, a in ipairs(src:GetChildren()) do
				if a:IsA("Attachment") then
					local ta = tg:FindFirstChild(a.Name)
					if ta and ta:IsA("Attachment") then
						local cf = ta.WorldCFrame * off * a.CFrame:Inverse()
						local jarak = (cf.Position - tg.Position).Magnitude
						if jarak < jarakMin then jarakMin = jarak; terbaik = {a = a, ta = ta} end
					end
				end
			end
			-- pengaman: kalau mesh meleset jauh dari kaki, jangan sembunyikan kaki asli
			if terbaik and jarakMin <= 8 then
				local c = src:Clone()
				c.Name = "ZenoxKor" .. nm; c.Anchored = false; c.CanCollide = false; c.CanQuery = false; c.CanTouch = false; c.Massless = true
				c.CFrame = terbaik.ta.WorldCFrame * off * terbaik.a.CFrame:Inverse()
				c.Parent = m
				F.korLas(tg, c)
				if st.hid[tg] == nil then st.hid[tg] = tg.Transparency end
				table.insert(st.objs, c)
				n = n + 1
			end
		end
	end
	obj:Destroy(); if n == 0 then return false, "gagal" end; return true, sisi .. " R15 " .. n
end
function F.korR6(m, sisi, st)
	local tg = m:FindFirstChild(sisi .. " Leg"); if not tg then return false, "gagal" end
	local off = CFrame.new(S.kor.geserX or 0, S.kor.tinggi, S.kor.geserZ or 0)
	local obj = muat(sisi == "Left" and C.KOR_KIRI or C.KOR_R15); if not obj then return false, "asset gagal" end
	-- kaki R15 (paha, betis, telapak) dari asset Korblox Deathspeaker disusun jadi satu kaki R6
	local bagian = {}
	for _, nm in ipairs({sisi .. "UpperLeg", sisi .. "LowerLeg", sisi .. "Foot"}) do
		local p = obj:FindFirstChild(nm, true)
		if p and p:IsA("MeshPart") then table.insert(bagian, p) end
	end
	if #bagian == 0 then obj:Destroy(); return false, "mesh kaki tidak ada" end
	local acuan = bagian[1].CFrame
	local lokal, minV, maxV = {}, Vector3.new(math.huge, math.huge, math.huge), Vector3.new(-math.huge, -math.huge, -math.huge)
	for i, p in ipairs(bagian) do
		local lc = acuan:ToObjectSpace(p.CFrame)
		lokal[i] = lc
		local h = p.Size / 2
		minV = minV:Min(lc.Position - h); maxV = maxV:Max(lc.Position + h)
	end
	local pusatA = (minV + maxV) / 2
	local s = tg.Size.Y / math.max((maxV - minV).Y, 0.01) -- skala seragam, mengikuti tinggi kaki R6
	local n = 0
	for i, p in ipairs(bagian) do
		local c = p:Clone()
		c.Name = "ZenoxKor" .. p.Name
		c.Anchored = true; c.CanCollide = false; c.CanQuery = false; c.CanTouch = false; c.Massless = true
		c.Parent = m
		pcall(function() game:GetService("ContentProvider"):PreloadAsync({c}) end)
		c.Size = p.Size * s
		c.CFrame = tg.CFrame * off * CFrame.new((lokal[i].Position - pusatA) * s) * lokal[i].Rotation
		c.Anchored = false
		F.korLas(tg, c)
		table.insert(st.objs, c)
		n = n + 1
	end
	obj:Destroy()
	if st.hid[tg] == nil then st.hid[tg] = tg.Transparency end
	return true, sisi .. " R6 " .. n .. " bagian"
end
function F.korSetS(st, sisi, v)
	local nama = sisi == "Left" and "kiri" or "kanan"
	F.korClearS(st); st.on = v
	if not v then F.catat("korblox " .. nama .. " OFF"); return true end
	local m = F.target(); if not m then st.on = false; return false end
	local ok, info
	if m:FindFirstChild(sisi .. "UpperLeg") then ok, info = F.korR15(m, sisi, st) else ok, info = F.korR6(m, sisi, st) end
	if not ok then st.on = false; F.catat("korblox " .. nama .. " gagal: " .. tostring(info)); return false end
	-- kaki asli cuma disembunyikan; mesh korblox sudah ter-weld ke kaki
	st.conn = RS.Heartbeat:Connect(function()
		for p in pairs(st.hid) do if p.Parent and p.Transparency ~= 1 then p.Transparency = 1 end end
	end)
	F.catat("korblox " .. nama .. " ON (" .. tostring(info) .. ")")
	return true
end
function F.korSet(v) return F.korSetS(S.kor, "Right", v) end
function F.kiriSet(v) return F.korSetS(S.kiri, "Left", v) end
function F.korApplyAll()
	if S.kor.on then F.korSetS(S.kor, "Right", true) end
	if S.kiri.on then F.korSetS(S.kiri, "Left", true) end
end
function F.korTinggi(d) S.kor.tinggi = math.floor(math.clamp(S.kor.tinggi + d, -3, 3) * 10 + 0.5) / 10; F.korApplyAll() end
function F.korGeser(sumbu, d)
	local kunci = sumbu == "x" and "geserX" or "geserZ"
	S.kor[kunci] = math.floor(math.clamp((S.kor[kunci] or 0) + d, -3, 3) * 10 + 0.5) / 10
	F.korApplyAll()
end
function F.korReset()
	S.kor.tinggi = 0; S.kor.geserX = 0; S.kor.geserZ = 0
	F.korApplyAll()
end
function F.camSet(v)
	S.cam.on = v
	if S.cam.conn then S.cam.conn:Disconnect(); S.cam.conn = nil end
	local kam = workspace.CurrentCamera; if not kam then return end
	if v then
		kam.CameraType = Enum.CameraType.Scriptable
		S.cam.conn = RS.RenderStepped:Connect(function()
			local m = F.target(); local hd = m and (m:FindFirstChild("Head") or m:FindFirstChild("Torso"))
			if not hd then return end
			local pos = hd.Position + hd.CFrame.LookVector * S.cam.dist + Vector3.new(0, 0.5, 0)
			kam.CFrame = CFrame.lookAt(pos, hd.Position); kam.FieldOfView = S.cam.fov
		end)
	else
		kam.CameraType = Enum.CameraType.Custom; kam.FieldOfView = 70
		local hum = me.Character and me.Character:FindFirstChildOfClass("Humanoid"); if hum then kam.CameraSubject = hum end
	end
end

-- =====================================================================
-- ANIMASI, EMOTE, & KATALOG
-- =====================================================================
function F.animCari(m) return m:FindFirstChild("Animate") or (me.Character and me.Character:FindFirstChild("Animate")) end
F.animCache = {}
function F.animId(id)
	if F.animCache[id] then return F.animCache[id] end
	local hasil = "rbxassetid://" .. tostring(id)
	local o = muat(id)
	if o then
		local a = o:IsA("Animation") and o or o:FindFirstChildWhichIsA("Animation", true)
		local aid = a and a.AnimationId or ""; o:Destroy(); if aid ~= "" then hasil = aid end
	end
	F.animCache[id] = hasil
	return hasil
end
function F.animSet(m, slot, id)
	local an = F.animCari(m); local inf = C.SLOT[slot]
	if not an or not inf then return false end
	local fd = an:FindFirstChild(inf[1]); if not fd then return false end
	local aid = F.animId(id); local n = 0
	for _, nm in ipairs(inf[2]) do
		local nd = fd:FindFirstChild(nm)
		if nd and nd:IsA("Animation") then
			local k = slot .. "/" .. nm
			if S.anim.orig[k] == nil then S.anim.orig[k] = nd.AnimationId end
			nd.AnimationId = aid; n = n + 1
		end
	end
	return n > 0
end
function F.animMuat(m)
	local hum = m:FindFirstChildOfClass("Humanoid") or (me.Character and me.Character:FindFirstChildOfClass("Humanoid"))
	if hum then pcall(function() for _, t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop(0) end end) end
	local an = F.animCari(m); if not an or not an:IsA("LocalScript") then return end
	local induk = an.Parent; local b = an:Clone(); an:Destroy(); task.wait(); b.Parent = induk
end
function F.animTerapkan(m, peta)
	local n = 0
	for slot, id in pairs(peta) do if F.animSet(m, slot, id) then n = n + 1 end end
	if n > 0 then F.animMuat(m) end; return n
end
function F.animZombie() local m = F.target(); if not m then return end; S.anim.want = {kind = "zombie"}; F.animTerapkan(m, C.ZOMBIE_R15) end
function F.animBundle(id, label)
	local m = F.target(); if not m then return end
	local data = httpJson("https://catalog.roblox.com/v1/bundles/" .. tostring(id) .. "/details"); if not data then return end
	local peta = {}
	for _, it in ipairs(data.items or {}) do
		local t = tonumber(it.assetType); if it.type == "Asset" and t and C.ATYPE[t] then peta[C.ATYPE[t]] = it.id end
	end
	S.anim.want = {bundle = id, label = label}; F.animTerapkan(m, peta)
end
function F.animCustom(slot, id) local m = F.target(); if not m or not C.SLOT[slot] then return end; S.anim.custom[slot] = id; F.animTerapkan(m, {[slot] = id}) end
function F.animUlang(m)
	local w = S.anim.want
	if w then
		if w.kind == "zombie" then F.animZombie() elseif w.bundle then F.animBundle(w.bundle, w.label) end
	end
	if next(S.anim.custom) ~= nil and m then F.animTerapkan(m, S.anim.custom) end
end
function F.animReset()
	local m = F.target(); local an = m and F.animCari(m)
	if an then
		for k, aid in pairs(S.anim.orig) do
			local slot, nm = string.match(k, "^(%w+)/(%w+)$"); local inf = slot and C.SLOT[slot]
			local fd = inf and an:FindFirstChild(inf[1]); local nd = fd and fd:FindFirstChild(nm)
			if nd and nd:IsA("Animation") then nd.AnimationId = aid end
		end
	end
	S.anim.orig = {}; S.anim.want = nil; S.anim.custom = {}; if m then F.animMuat(m) end
end
function F.emoteStop(alasan)
	if S.emote.conn then S.emote.conn:Disconnect(); S.emote.conn = nil end
	local tr, an, nama = S.emote.track, S.emote.anim, S.emote.nama
	S.emote.track, S.emote.anim, S.emote.nama = nil, nil, ""; S.emote.id = nil
	if tr then pcall(function() tr:Stop(0.2) end) end
end
function F.emotePlay(nama, id)
	F.emoteStop()
	local m = F.target(); local hum = m and m:FindFirstChildOfClass("Humanoid")
	if not hum and me.Character then hum = me.Character:FindFirstChildOfClass("Humanoid") end
	if not hum then return end
	local animator = hum:FindFirstChildOfClass("Animator") or mk("Animator", {}, hum)
	S.animCache = S.animCache or {}
	local anim = S.animCache[tostring(id)]
	if not anim then anim = Instance.new("Animation"); anim.AnimationId = F.animId(id); S.animCache[tostring(id)] = anim end
	local okL, track = pcall(function() return animator:LoadAnimation(anim) end)
	if not okL or not track then return end
	track.Priority = Enum.AnimationPriority.Action; track.Looped = true; track:Play()
	S.emote.track = track; S.emote.anim = anim; S.emote.nama = nama; S.emote.id = id
	S.emote.conn = RS.Heartbeat:Connect(function() if hum.Parent == nil or hum.MoveDirection.Magnitude > 0.1 then F.emoteStop() end end)
end
function F.emoteCari(teks)
	local q = trim(teks); if #q < 2 then F.catat("emote: isi nama emote dulu"); return end
	local d = F.cari(q)
	if not d or not d.data or #d.data == 0 then F.catat("emote: tidak ketemu di katalog: " .. q); return end
	local pilih, lq = d.data[1], string.lower(q)
	for _, it in ipairs(d.data) do if string.find(string.lower(tostring(it.name or "")), lq, 1, true) then pilih = it; break end end
	F.catat("emote: pasang " .. tostring(pilih.name) .. " (" .. tostring(pilih.id) .. ")")
	F.emotePlay(tostring(pilih.name), tonumber(pilih.id))
end
function F.cari(teks)
	local q = trim(teks); if #q < 2 then return nil end
	return httpJson("https://catalog.roblox.com/v1/search/items?keyword=" .. HS:UrlEncode(q) .. "&limit=10")
end
function F.cariTampil(teks, wadah)
	for _, c in ipairs(wadah:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
	local d = F.cari(teks); if not d or not d.data then return end
	for i, it in ipairs(d.data) do
		local b = mk("TextButton", {
			Size = UDim2.new(1, -4, 0, 28), BackgroundColor3 = ROW, TextColor3 = TXT, Font = FM, TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left, AutoButtonColor = false,
			Text = "  " .. tostring(it.name or "?") .. " [" .. tostring(it.itemType) .. "]", LayoutOrder = i,
		}, wadah)
		rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() F.pasangId(it.id) end) end)
	end
end
-- BODY PARTS (bundle full body / template Larp): tiap bagian diganti asset-nya, di-weld ke bagian R6 asli, bagian asli disembunyikan
S.body = S.body or {objs = {}, hid = {}, conn = nil}
F.BODY_PART = {[17] = "Head", [27] = "Torso", [28] = "Right Arm", [29] = "Left Arm", [30] = "Left Leg", [31] = "Right Leg"}
function F.bodyClear()
	local b = S.body or {objs = {}, hid = {}}
	if b.conn then b.conn:Disconnect(); b.conn = nil end
	for _, o in ipairs(b.objs) do pcall(function() o:Destroy() end) end
	for p, t in pairs(b.hid) do
		if p.Parent and not (S.kor.hid[p] ~= nil or S.kiri.hid[p] ~= nil) then p.Transparency = t end
	end
	for p, c in pairs(b.col or {}) do if p.Parent then pcall(function() p.Color = c end) end end
	S.body = {objs = {}, hid = {}, conn = nil}
end
-- ambil bagian mesh dari asset: MeshPart langsung, atau Part + SpecialMesh
function F.bagianAsset(obj)
	local mp = obj:FindFirstChildWhichIsA("MeshPart", true)
	if mp then return mp:Clone() end
	local bp = obj:FindFirstChildWhichIsA("BasePart", true)
	if not bp then return nil end
	local p = Instance.new("Part"); p.Size = bp.Size; p.Color = bp.Color
	local sm = bp:FindFirstChildWhichIsA("SpecialMesh", true)
	if sm then sm:Clone().Parent = p end
	return p
end
-- bagian R6 -> grup part R15 yang ditutupi (mesh R6 dibungkus di atas grup itu)
F.PETA_R15 = {
	["Head"] = {"Head"},
	["Torso"] = {"UpperTorso", "LowerTorso"},
	["Right Arm"] = {"RightUpperArm", "RightLowerArm", "RightHand"},
	["Left Arm"] = {"LeftUpperArm", "LeftLowerArm", "LeftHand"},
	["Right Leg"] = {"RightUpperLeg", "RightLowerLeg", "RightFoot"},
	["Left Leg"] = {"LeftUpperLeg", "LeftLowerLeg", "LeftFoot"},
}
-- tipe rig karakter: "R6", "R15", atau nil kalau tidak dikenali
function F.rigTipe(m)
	if not m then return nil end
	if m:FindFirstChild("Torso") and m:FindFirstChild("Right Leg") then return "R6" end
	if m:FindFirstChild("UpperTorso") and m:FindFirstChild("RightUpperLeg") then return "R15" end
	return nil
end
-- daftar part (BasePart) yang dipakai untuk satu bagian bundle di rig ini
function F.bodyGrup(m, tipe, nama)
	if tipe == "R6" then
		local tg = m:FindFirstChild(nama)
		return (tg and tg:IsA("BasePart")) and {tg} or nil
	end
	local daftarNama = F.PETA_R15[nama]; if not daftarNama then return nil end
	local grup = {}
	for _, nm in ipairs(daftarNama) do
		local p = m:FindFirstChild(nm)
		if not (p and p:IsA("BasePart")) then return nil end
		table.insert(grup, p)
	end
	return grup
end
-- kotak pembungkus satu grup, dihitung di ruang bagian pertama (CFrame pusat + ukuran)
function F.bungkus(grup)
	local u = grup[1].CFrame
	local minV, maxV = nil, nil
	for _, p in ipairs(grup) do
		local hs = p.Size / 2
		for _, sx in ipairs({-1, 1}) do for _, sy in ipairs({-1, 1}) do for _, sz in ipairs({-1, 1}) do
			local titik = u:PointToObjectSpace(p.CFrame * Vector3.new(sx * hs.X, sy * hs.Y, sz * hs.Z))
			if minV then minV = minV:Min(titik); maxV = maxV:Max(titik) else minV = titik; maxV = titik end
		end end end
	end
	return u * CFrame.new(0, (minV.Y + maxV.Y) / 2, 0), maxV - minV
end
-- muat aset bagian body: harus ada BasePart di dalamnya, kalau tidak coba jalur LoadAsset
-- lebar x tebal standar R6 per bagian (dipakai untuk grup R15 supaya kiri & kanan sama)
local UKURAN_R6 = {["Torso"] = {2, 1}, ["Right Arm"] = {1, 1}, ["Left Arm"] = {1, 1}, ["Right Leg"] = {1, 1}, ["Left Leg"] = {1, 1}}
local cacheBagian = {}
local function muatBagian(id)
	local k = tostring(id)
	if cacheBagian[k] then
		local ok, salin = pcall(function() return cacheBagian[k]:Clone() end)
		if ok and salin then return salin end
	end
	local ok, lst = pcall(function() return game:GetObjects("rbxassetid://" .. k) end)
	local hasil = nil
	if ok and lst then
		for _, o in ipairs(lst) do
			if o:IsA("BasePart") or o:FindFirstChildWhichIsA("BasePart", true) then hasil = o; break end
		end
		for _, o in ipairs(lst) do if o ~= hasil then pcall(function() o:Destroy() end) end end
	end
	if not hasil then
		local ok2, o2 = pcall(function() return IS:LoadAsset(tonumber(id)) end)
		if ok2 and o2 then
			if o2:IsA("BasePart") or o2:FindFirstChildWhichIsA("BasePart", true) then hasil = o2
			else pcall(function() o2:Destroy() end) end
		end
	end
	if not hasil then return nil end
	cacheBagian[k] = hasil
	local ok3, salin = pcall(function() return hasil:Clone() end)
	return (ok3 and salin) or nil
end
-- daftar = { {id = asset, nama = "Torso"}, ... } ; warna = Color3 atau nil
function F.bodyApply(daftar, warna)
	F.bodyClear()
	local m = F.target()
	local tipe = F.rigTipe(m)
	if not tipe then
		S.bodyOn = false; F.catat("body: rig tidak dikenali (bukan R6/R15)"); return false
	end
	local n = 0
	for _, bp in ipairs(daftar) do
		local grup = F.bodyGrup(m, tipe, bp.nama)
		local obj = muatBagian(bp.id)
		local c = obj and F.bagianAsset(obj)
		if obj then pcall(function() obj:Destroy() end) end
		if grup and c then
			local utama = grup[1]
			local asli = c.Size -- ukuran mesh asli dari asset (proporsi R6)
			local cf, sz = utama.CFrame, utama.Size
			if #grup > 1 then
				local span
				cf, span = F.bungkus(grup)
				-- lebar & tebal pakai ukuran R6 standar, cuma panjangnya yang ditarik ke panjang grup
				local std = UKURAN_R6[bp.nama] or {asli.X, asli.Z}
				sz = (tipe == "R15") and span or Vector3.new(std[1], span.Y, std[2])
			end
			-- kepala dynamic: pasang lewat FaceCenterAttachment supaya posisi wajah benar, ukuran asli
			local attA, attT = c:FindFirstChild("FaceCenterAttachment"), utama:FindFirstChild("FaceCenterAttachment")
			if bp.nama == "Head" and attA and attT then
				cf = attT.WorldCFrame * attA.CFrame:Inverse()
				sz = asli
			end
			c.Name = "ZenoxBody" .. bp.nama
			c.Anchored = true; c.CanCollide = false; c.CanQuery = false; c.CanTouch = false; c.Massless = true
			c.CFrame = cf; c.Parent = m
			pcall(function() game:GetService("ContentProvider"):PreloadAsync({c}) end)
			c.Size = sz; c.CFrame = cf
			if warna then pcall(function() c.TextureID = "" end); c.Color = warna end
			c.Anchored = false
			F.korLas(utama, c)
			for _, tg in ipairs(grup) do
				if S.body.hid[tg] == nil then S.body.hid[tg] = tg.Transparency end
				tg.Transparency = 1
			end
			table.insert(S.body.objs, c)
			F.catat(string.format("body: %s mesh %.2f x %.2f x %.2f", bp.nama, asli.X, asli.Y, asli.Z))
			n = n + 1
		else
			if not grup then F.catat("body: " .. bp.nama .. " tidak ada padanan di rig " .. tipe)
			elseif not obj and bp.nama == "Head" then F.catat("body: kepala dynamic ID " .. tostring(bp.id) .. " tidak bisa dimuat di executor ini, kepala asli dipertahankan")
			elseif not obj then F.catat("body: " .. bp.nama .. " gagal dimuat (ID " .. tostring(bp.id) .. ")")
			else F.catat("body: " .. bp.nama .. " tidak ada mesh di asset") end
		end
	end
	if warna then
		for _, nm in ipairs({"Head", "Torso", "UpperTorso", "LowerTorso", "Left Arm", "Right Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "Left Leg", "Right Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
			local p = m:FindFirstChild(nm)
			if p and p:IsA("BasePart") and not S.body.hid[p] then
				S.body.col = S.body.col or {}
				if S.body.col[p] == nil then S.body.col[p] = p.Color end
				pcall(function() p.Color = warna end)
			end
		end
	end
	if n == 0 then S.bodyOn = false; F.bodyClear(); F.catat("body: tidak ada bagian terpasang"); return false end
	S.bodyDaftar = daftar; S.bodyWarna = warna; S.bodyOn = true
	S.body.conn = RS.Heartbeat:Connect(function()
		for p in pairs(S.body.hid) do if p.Parent and p.Transparency ~= 1 then p.Transparency = 1 end end
	end)
	F.catat("body ON (" .. tipe .. "): " .. n .. " bagian")
	return true
end
-- ambil daftar bagian body dari katalog bundle
function F.bodyBundle(id)
	local data = httpJson("https://catalog.roblox.com/v1/bundles/" .. tostring(id) .. "/details")
	if not data or type(data.items) ~= "table" then return nil end
	local daftar = {}
	for _, it in ipairs(data.items) do
		local nama = it.type == "Asset" and F.BODY_PART[tonumber(it.assetType)]
		if nama then table.insert(daftar, {id = it.id, nama = nama}) end
	end
	return daftar
end
function F.bodyTambah(id, nama)
	local daftar = {}
	for _, bp in ipairs(S.bodyDaftar or {}) do if bp.nama ~= nama then table.insert(daftar, bp) end end
	table.insert(daftar, {id = id, nama = nama})
	return F.bodyApply(daftar, S.bodyWarna)
end
function F.bodySet(v, bundleId)
	if not v then F.bodyClear(); S.bodyOn = false; F.catat("body OFF"); return true end
	local daftar = F.bodyBundle(bundleId)
	if not daftar then S.bodyOn = false; F.catat("body: katalog bundle tidak bisa dibaca"); return false end
	local warna = (tonumber(bundleId) ~= 261702574320055) and Color3.fromRGB(163, 162, 165) or nil -- Burger tetap pakai warna asli
	return F.bodyApply(daftar, warna)
end
function F.bundleApply(id, data)
	local n = 0; local peta = {}
	for _, it in ipairs(data.items or {}) do
		if it.type == "Asset" then
			local t = tonumber(it.assetType)
			if t and C.ATYPE[t] then peta[C.ATYPE[t]] = it.id
			elseif t == 11 then F.bajuSet("shirt", it.id); n = n + 1
			elseif t == 12 then F.bajuSet("pants", it.id); n = n + 1
			elseif t == 2 then F.bajuSet("tshirt", it.id); n = n + 1
			elseif t and F.BODY_PART[t] then F.bodyTambah(it.id, F.BODY_PART[t]); n = n + 1
				elseif t == 19 then F.setOn(F.addItem(tostring(it.name), it.id, "gear"), true); n = n + 1
			elseif t == 18 then F.setOn(F.addItem(tostring(it.name), it.id, "auto"), true); n = n + 1
				elseif t and C.ACC_TYPE[t] then F.setOn(F.addItem(tostring(it.name), it.id, "akses"), true); n = n + 1 end
		end
	end
	F.catat("bundle " .. tostring(id) .. " dibaca: " .. n .. " item"); local na = 0; local m = F.target(); if m and next(peta) ~= nil then na = F.animTerapkan(m, peta) end
end
function F.pasangId(id)
	local ok, inf = pcall(function() return MPS:GetProductInfo(id) end)
	if not ok or not inf then F.catat("ID " .. tostring(id) .. ": info tidak bisa dibaca"); return end
	local t = inf.AssetTypeId
	if t == 18 or (t and C.ACC_TYPE[t]) then
		local it = S.byId[id] or F.addItem(inf.Name, id, t == 18 and "wajah" or "akses")
		if t == 18 then it.kind = "wajah" end
		F.setOn(it, true); return
	end
	F.catat("ID " .. tostring(id) .. " (" .. tostring(inf.Name) .. "): bukan aksesoris, tidak didukung")
end
function F.cariUser(teks)
	local nama = trim(teks); if #nama < 3 then return nil, "minimal 3 huruf" end
	local s = httpJson("https://users.roblox.com/v1/users/search?keyword=" .. HS:UrlEncode(nama) .. "&limit=10")
	if not s then return nil, "gagal" end
	for _, u in ipairs(s.data or {}) do if string.lower(tostring(u.name or "")) == string.lower(nama) then return u end end
	return nil, "tidak ketemu"
end
function F.avaDaftar(userId)
	local av = httpJson("https://avatar.roblox.com/v1/users/" .. tostring(userId) .. "/avatar")
	if not av or type(av.assets) ~= "table" then return nil end
	local out, shirt, pants = {}, nil, nil
	for _, a in ipairs(av.assets) do
		local t = a.assetType; if type(t) == "table" then t = t.id end; t = tonumber(t)
		local id = tonumber(a.id)
		if id and t then
			if t == 11 then shirt = id elseif t == 12 then pants = id elseif C.ACC_TYPE[t] then table.insert(out, {id = id, nama = tostring(a.name or id), kind = "akses"}) end
		end
	end
	return out, shirt, pants
end
function F.pakaiSet(daftar, label)
	for _, it in ipairs(S.items) do if it.on then F.setOn(it, false) end end
	task.wait(S.gantiJeda); local n = 0
	for _, d in ipairs(daftar) do
		local it = S.byId[d.id] or F.addItem(d.nama, d.id, d.kind or "akses")
		F.setOn(it, true); n = n + 1; task.wait(S.gantiJeda)
	end
end
function F.avaDariDesc(userId)
	local out, shirt, pants = {}, nil, nil
	local ok, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(userId) end)
	if not ok or not desc then return out, nil, nil end
	local okA, acc = pcall(function() return desc:GetAccessories(true) end)
	if okA and type(acc) == "table" then
		for _, a in ipairs(acc) do
			local id = tonumber(a.AssetId)
			if id and id > 0 then table.insert(out, {id = id, nama = "ID " .. tostring(id), kind = "akses"}) end
		end
	end
	if (desc.Shirt or 0) > 0 then shirt = desc.Shirt end
	if (desc.Pants or 0) > 0 then pants = desc.Pants end
	if (desc.Face or 0) > 0 then table.insert(out, {id = desc.Face, nama = "Face " .. tostring(desc.Face), kind = "auto"}) end
	return out, shirt, pants
end

function F.custApply(teks)
	local daftar = {}
	for angka in string.gmatch(tostring(teks or ""), "%d+") do local n = tonumber(angka); if n and n > 0 then table.insert(daftar, n) end end
	if #daftar == 0 then F.catat("isi ID dulu (angka)"); return end
	for _, id in ipairs(daftar) do F.pasangId(id); task.wait(0.3) end
end

function F.bajuUser()
	local c = me.Character
	local hum = c and c:FindFirstChildOfClass("Humanoid")
	local ok, desc = false, nil
	if hum then ok, desc = pcall(function() return hum:GetAppliedDescription() end) end
	if not ok or not desc then ok, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(me.UserId) end) end
	if not ok or not desc then return nil, nil end
	local sh = ((desc.Shirt or 0) > 0) and desc.Shirt or nil
	local pt = ((desc.Pants or 0) > 0) and desc.Pants or nil
	return sh, pt
end
function F.gantiSet(v) S.gantiJeda = math.floor(math.clamp(v, 0.1, 3) * 10 + 0.5) / 10 end
-- outfit Roblox (outfitId): aksesoris, baju & celana outfit dipasang
function F.outfitApply(outfitId, label)
	label = label or "outfit"
	if not outfitId or outfitId == 0 then F.catat(label .. ": outfitId belum diisi di kode"); return false end
	local ok, desc = pcall(function() return Players:GetHumanoidDescriptionFromOutfitId(outfitId) end)
	if not ok or not desc then F.catat(label .. ": outfit tidak bisa dibaca"); return false end
	local daftar = {}
	local okA, acc = pcall(function() return desc:GetAccessories(true) end)
	if okA and type(acc) == "table" then
		for _, a in ipairs(acc) do
			local id = tonumber(a.AssetId)
			if id and id > 0 then table.insert(daftar, {id = id, nama = "ID " .. tostring(id), kind = "akses"}) end
		end
	end
	if (desc.Shirt or 0) > 0 then F.bajuSet("shirt", desc.Shirt) end
	if (desc.Pants or 0) > 0 then F.bajuSet("pants", desc.Pants) end
	F.pakaiSet(daftar, label)
	F.catat(label .. " dipasang: " .. #daftar .. " item")
	return true
end
-- LARP: pasang preset lewat jalur Copy Avatar (HumanoidDescription)
local LARP_ACC = {[8]="Hat",[41]="Hair",[42]="Face",[43]="Neck",[44]="Shoulder",[45]="Front",[46]="Back",[47]="Waist",[57]="TShirt",[58]="Shirt",[59]="Pants",[64]="Jacket",[65]="Sweater",[66]="Shorts",[67]="LeftShoe",[68]="RightShoe",[69]="DressSkirt"}
local LARP_LAYER = {TShirt=true, Shirt=true, Pants=true, Jacket=true, Sweater=true, Shorts=true, LeftShoe=true, RightShoe=true, DressSkirt=true}
local LARP_SLOT = {Hat="HatAccessory", Hair="HairAccessory", Face="FaceAccessory", Neck="NeckAccessory", Shoulder="ShouldersAccessory", Front="FrontAccessory", Back="BackAccessory", Waist="WaistAccessory"}
local LARP_BP = {[17]="Head", [27]="Torso", [28]="RightArm", [29]="LeftArm", [30]="LeftLeg", [31]="RightLeg"}
local LARP_BP_NAMA = {["Head"]="Head", ["Torso"]="Torso", ["Right Arm"]="RightArm", ["Left Arm"]="LeftArm", ["Left Leg"]="LeftLeg", ["Right Leg"]="RightLeg"}

-- isi aksesoris ke deskripsi:
-- berlapis (baju, rambut berlapis) lewat SetAccessories; tidak berlapis (topi, wajah, leher, pinggang/ekor, dll)
-- diisi ke slot aksesoris biasa, karena SetAccessories tidak memasukkan yang tidak berlapis
local function larpSetAcc(d, acc, accNama)
	local berlapis = {}
	for _, a in ipairs(acc) do if a.IsLayered then table.insert(berlapis, a) end end
	local okSet = pcall(function() d:SetAccessories(berlapis, true) end)
	if not okSet then okSet = pcall(function() d:SetAccessories(berlapis) end) end
	local isiSlot = {}
	for _, slot in pairs(LARP_SLOT) do isiSlot[slot] = {} end
	for i, a in ipairs(acc) do
		if not a.IsLayered then
			local slot = LARP_SLOT[accNama[i]]
			if slot then table.insert(isiSlot[slot], tostring(a.AssetId)) end
		end
	end
	-- slot yang kosong TIDAK dikosongkan kalau preset punya aksesoris berlapis dengan tipe yang sama:
	-- mengisi HairAccessory = "" ikut menghapus rambut berlapis (Anime Straight Hair) yang baru dipasang
	local berlapisTipe = {}
	for _, a in ipairs(acc) do if a.IsLayered and a.AccessoryType then berlapisTipe[a.AccessoryType.Name] = true end end
	for tipe, slot in pairs(LARP_SLOT) do
		if #isiSlot[slot] > 0 or not berlapisTipe[tipe] then
			pcall(function() d[slot] = table.concat(isiSlot[slot], ",") end)
		end
	end
	-- cek: setiap aksesoris berlapis yang diminta harus ada di deskripsi, kalau tidak dicatat di log
	local okG, ada = pcall(function() return d:GetAccessories(true) end)
	if okG and type(ada) == "table" then
		local dapat, kurang = {}, 0
		for _, x in ipairs(ada) do dapat[x.AssetId] = true end
		for _, a in ipairs(berlapis) do if not dapat[a.AssetId] then kurang = kurang + 1 end end
		if kurang > 0 then F.catat("larp: " .. kurang .. " aksesoris berlapis tidak masuk deskripsi") end
	end
	return okSet
end

-- dasar = avatar yang sedang terpasang (warna kulit, skala, bagian badan tetap)
local function larpDasar()
	local m = F.target()
	local hum = m and m:FindFirstChildOfClass("Humanoid")
	local okB, base = false, nil
	if hum then okB, base = pcall(function() return hum:GetAppliedDescription() end) end
	return (okB and base) or Instance.new("HumanoidDescription")
end

-- preset dengan data lengkap (tipe, layer, urutan, warna, bagian badan sudah ditentukan)
function F.larpExact(lp)
	local d = larpDasar()
	d.Shirt = lp.shirt or 0; d.Pants = lp.pants or 0; d.GraphicTShirt = lp.tshirt or 0
	if lp.face ~= nil then d.Face = lp.face end
	for k, v in pairs(lp.part or {}) do d[k] = v end
	for k, v in pairs(lp.kulit or {}) do d[k] = v end
	for k, v in pairs(lp.skala or {}) do d[k] = v end
	local acc, accNama = {}, {}
	for _, a in ipairs(lp.acc or {}) do
		local okT, tipe = pcall(function() return Enum.AccessoryType[a[2]] end)
		if okT and tipe then
			table.insert(acc, {AssetId = a[1], AccessoryType = tipe, IsLayered = a[3] == true, Order = a[4] or 0, Puffiness = 1})
			table.insert(accNama, a[2])
		end
	end
	local okSet = larpSetAcc(d, acc, accNama)
	return d, {}, okSet
end

-- preset dengan daftar ID: tipe tiap ID dibaca dari katalog Roblox
function F.larpDesc(entri)
	local d = larpDasar()
	d.Shirt = 0; d.Pants = 0; d.GraphicTShirt = 0
	local acc, accNama, gagal = {}, {}, {}
	for _, e in ipairs(entri) do
		local id = tonumber(e.id)
		if id and id > 0 then
			local okI, inf = pcall(function() return MPS:GetProductInfo(id) end)
			local t = (okI and inf) and tonumber(inf.AssetTypeId) or nil
			local bagian = e.bagian and LARP_BP_NAMA[e.bagian] or nil
			if t == 11 then d.Shirt = id
			elseif t == 12 then d.Pants = id
			elseif t == 2 then d.GraphicTShirt = id
			elseif t == 18 then d.Face = id
			elseif t and LARP_BP[t] then d[LARP_BP[t]] = id
			elseif t == nil and bagian then d[bagian] = id
			elseif t and LARP_ACC[t] then
				local nm = LARP_ACC[t]
				table.insert(acc, {AssetId = id, AccessoryType = Enum.AccessoryType[nm], IsLayered = LARP_LAYER[nm] == true, Order = #acc + 1, Puffiness = 1})
				table.insert(accNama, nm)
			else
				table.insert(gagal, tostring(id))
			end
		end
	end
	local okSet = larpSetAcc(d, acc, accNama)
	return d, gagal, okSet
end

function F.larpPasang(lp)
	if lp.maint then F.catat(lp.nama .. " lagi maintenance"); return end
	if lp.outfit then F.outfitApply(lp.outfit, lp.nama); return end
	if not F.target() then F.catat(lp.nama .. ": karakter belum siap"); return end
	-- matikan efek lama dulu (sama seperti Copy Avatar)
	if S.headOn then F.headSet(false) end
	if S.kor.on then F.korSet(false) end
	if S.kiri.on then F.kiriSet(false) end
	for _, it in ipairs(S.items) do if it.on then F.setOn(it, false) end end
	if S.bodyOn then pcall(F.bodySet, false); S.bodyId = nil end

	local d, gagal, okSet
	if lp.acc then
		d, gagal, okSet = F.larpExact(lp)
	else
		local entri = {}
		for _, id in ipairs(lp.items or {}) do table.insert(entri, {id = id}) end
		if lp.shirt then table.insert(entri, {id = lp.shirt}) end
		if lp.pants then table.insert(entri, {id = lp.pants}) end
		if lp.tshirt then table.insert(entri, {id = lp.tshirt}) end
		if lp.body and not lp.keepBody then
			for _, bp in ipairs(lp.body) do table.insert(entri, {id = bp.id, bagian = bp.nama}) end
		end
		if lp.bundle and not lp.keepBody then
			for _, bp in ipairs(F.bodyBundle(lp.bundle) or {}) do table.insert(entri, {id = bp.id, bagian = bp.nama}) end
		end
		d, gagal, okSet = F.larpDesc(entri)
	end

	local ok, info = F.cloneApply(d)
	if not ok then F.catat(lp.nama .. " gagal: " .. tostring(info)); return end
	-- cek: aksesoris yang benar-benar ada di karakter setelah preset dipasang
	local mm = F.target(); local nAcc, namaAcc = 0, {}
	if mm then for _, c in ipairs(mm:GetChildren()) do if c:IsA("Accessory") then nAcc = nAcc + 1; table.insert(namaAcc, c.Name) end end end
	F.catat(lp.nama .. ": aksesoris di karakter " .. nAcc .. (nAcc > 0 and (" -> " .. table.concat(namaAcc, ", ")) or ""))
	for _, g in ipairs(gagal or {}) do F.catat(lp.nama .. ": ID " .. g .. " dilewati (bukan aksesoris/bagian)") end
	if not okSet then F.catat(lp.nama .. ": SetAccessories tidak tersedia, pakai cadangan") end
	F.catat(lp.nama .. " dipasang")
	if lp.headless then F.headSet(true) end
	if lp.korKanan then F.korSet(true) end
	F.rambutSet(lp.rambut == true)
	if lp.anim then local mm = F.target(); if mm then F.animTerapkan(mm, lp.anim) end end
end

function F.adaHairItem()
	for _, it in ipairs(S.items) do if it.on and (C.RAMBUT_GANTI[it.id] or (it.id == C.SECRET_ID and it.obj ~= nil)) then return true end end
	return false
end
function F.hairSync()
	if S.rambutOn or F.adaHairItem() then pcall(F.rambutTerapkan)
	elseif next(S.rambutOrig) ~= nil then
		for p, t in pairs(S.rambutOrig) do if p.Parent then p.Transparency = t end end
		S.rambutOrig = {}
	end
end
function F.rambutTerapkan()
	local m = F.target(); if not m then return end
	for _, acc in ipairs(m:GetChildren()) do
		if acc:IsA("Accessory") and acc.AccessoryType == Enum.AccessoryType.Hair then
			for _, d in ipairs(acc:GetDescendants()) do
				if d:IsA("BasePart") then
					if S.rambutOrig[d] == nil then S.rambutOrig[d] = d.Transparency end
					d.Transparency = 1
				end
			end
		end
	end
end
-- "girl hair": rambut Larp 3 (Anime Straight Hair) saja, satu tombol ON/OFF di tab SHIRT/HAIR
C.GIRL_HAIR = {118056103257844}
function F.girlHairOn()
	local it = S.byId[C.GIRL_HAIR[1]]
	return it ~= nil and it.on == true
end
function F.girlHairSet(v)
	for i, id in ipairs(C.GIRL_HAIR) do
		local it = S.byId[id]
		if not it then
			it = {nama = i == 1 and "girl hair: rambut" or ("girl hair: layer " .. tostring(i - 1)), id = id, kind = "akses", on = false, obj = nil, src = nil, hapus = 0, busy = false, builtin = false, cfg = F.cfgBaru(), premium = false, senyap = true}
			table.insert(S.items, it); S.byId[id] = it
		end
		if (it.on == true) ~= (v == true) then F.setOn(it, v == true) end
	end
	F.catat("girl hair " .. (v and "ON" or "OFF"))
end
-- daftar pilih (efek) tidak menampilkan item rahasia "girl hair"
function F.itemTampil()
	local daftar = {}
	for _, it in ipairs(S.items) do if not it.senyap then table.insert(daftar, it) end end
	return daftar
end
function F.rambutSet(v)
	S.rambutOn = v and true or false
	F.hairSync()
	F.catat("hapus rambut " .. (S.rambutOn and "ON" or "OFF"))
end
S.tiru = S.tiru or {on = false, asli = {}, snap = {}, lastCh = {}, sigOf = {}}
-- FAKER: tiru outfit kita ke pemain lain (visual lokal, cuma R15)
F.tiruBagian = {Head = true, UpperTorso = true, LowerTorso = true, LeftUpperArm = true, LeftLowerArm = true, LeftHand = true, RightUpperArm = true, RightLowerArm = true, RightHand = true, LeftUpperLeg = true, LeftLowerLeg = true, LeftFoot = true, RightUpperLeg = true, RightLowerLeg = true, RightFoot = true}
function F.tiruSig()
	local ku = me.Character; if not ku then return "" end
	local parts = {}
	for _, a in ipairs(ku:GetChildren()) do
		if a:IsA("Accessory") then
			local h = a:FindFirstChild("Handle")
			local mid = (h and h:IsA("MeshPart")) and h.MeshId or ""
			table.insert(parts, a.Name .. "|" .. tostring(a.AccessoryType) .. "|" .. tostring(mid))
		end
	end
	for _, cls in ipairs({"Shirt", "Pants"}) do
		local x = ku:FindFirstChildOfClass(cls)
		if x then table.insert(parts, cls .. "|" .. tostring((cls == "Shirt") and x.ShirtTemplate or x.PantsTemplate)) end
	end
	for _, d in ipairs(ku:GetDescendants()) do
		if d:IsA("BasePart") and not F.tiruBagian[d.Name] and d.Transparency < 1 then
			table.insert(parts, d.Name .. "|" .. tostring(d:IsA("MeshPart") and d.MeshId or ""))
		end
	end
	local kh = ku:FindFirstChild("Head"); local kf = kh and kh:FindFirstChildOfClass("Decal")
	if kf then table.insert(parts, "face|" .. tostring(kf.Texture)) end
	return table.concat(parts, ";")
end
function F.tiruSalin(karakter, sumber)
	local ku = sumber or me.Character
	if not (ku and karakter) then return false end
	if not (ku:FindFirstChild("UpperTorso") and karakter:FindFirstChild("UpperTorso")) then return "rig" end
	S.tiru.asli[karakter] = S.tiru.asli[karakter] or {}
	local simpan = S.tiru.asli[karakter]
	local bA = ku:FindFirstChildOfClass("BodyColors")
	local bB = karakter:FindFirstChildOfClass("BodyColors")
	if bA and bB then
		simpan.warna = simpan.warna or {}
		for _, p in ipairs({"HeadColor3", "TorsoColor3", "LeftArmColor3", "RightArmColor3", "LeftLegColor3", "RightLegColor3"}) do
			if simpan.warna[p] == nil then simpan.warna[p] = bB[p] end
			pcall(function() bB[p] = bA[p] end)
		end
	end
	for _, a in ipairs(karakter:GetChildren()) do
		if a:GetAttribute("ZenoxTiru") then
			a:Destroy()
		elseif a:IsA("Accessory") or a:IsA("Shirt") or a:IsA("Pants") or a:IsA("ShirtGraphic") then
			table.insert(simpan, a:Clone())
			a:Destroy()
		end
	end
	for _, cls in ipairs({"Shirt", "Pants"}) do
		local x = ku:FindFirstChildOfClass(cls)
		if x then local c = x:Clone(); c:SetAttribute("ZenoxTiru", true); c.Parent = karakter end
	end
	local bagian = F.tiruBagian
	simpan.trans = simpan.trans or {}
	for nama in pairs(bagian) do
		local kp = ku:FindFirstChild(nama); local tp = karakter:FindFirstChild(nama)
		if kp and tp and tp:IsA("BasePart") then
			if simpan.trans[nama] == nil then simpan.trans[nama] = tp.Transparency end
			tp.Transparency = kp.Transparency
		end
	end
	for _, d in ipairs(ku:GetDescendants()) do
		if d:IsA("BasePart") and not bagian[d.Name] and d.Transparency < 1 then
			local w = d:FindFirstChildWhichIsA("WeldConstraint") or d:FindFirstChildWhichIsA("Weld")
			local induk = w and w.Part0
			if induk and bagian[induk.Name] and induk:IsDescendantOf(ku) then
				local tp = karakter:FindFirstChild(induk.Name)
				if tp and tp:IsA("BasePart") then
					local offset = induk.CFrame:ToObjectSpace(d.CFrame)
					local c = d:Clone()
					for _, x in ipairs(c:GetChildren()) do
						if x:IsA("Weld") or x:IsA("WeldConstraint") or x:IsA("Motor6D") then x:Destroy() end
					end
					c.Anchored = false; c.CanCollide = false; c.Massless = true
					c.CFrame = tp.CFrame * offset
					local wc = Instance.new("WeldConstraint"); wc.Part0 = tp; wc.Part1 = c; wc.Parent = c
					c:SetAttribute("ZenoxTiru", true)
					c.Parent = karakter
				end
			end
		end
	end
	local kh = ku:FindFirstChild("Head"); local th = karakter:FindFirstChild("Head")
	local kf = kh and kh:FindFirstChildOfClass("Decal"); local tf = th and th:FindFirstChildOfClass("Decal")
	if kf and tf then
		if simpan.wajah == nil then simpan.wajah = tf.Texture end
		tf.Texture = kf.Texture
	end
	return true
end
function F.tiruKembalikan(karakter)
	if not karakter then return end
	for _, a in ipairs(karakter:GetChildren()) do
		if a:GetAttribute("ZenoxTiru") then a:Destroy() end
	end
	local simpan = S.tiru.asli and S.tiru.asli[karakter]
	if simpan then
		for _, a in ipairs(simpan) do
			if a.Parent == nil then a.Parent = karakter end
		end
		local bB = karakter:FindFirstChildOfClass("BodyColors")
		if bB and simpan.warna then
			for p, col in pairs(simpan.warna) do pcall(function() bB[p] = col end) end
		end
		local th = karakter:FindFirstChild("Head"); local tf = th and th:FindFirstChildOfClass("Decal")
		if tf and simpan.wajah then tf.Texture = simpan.wajah end
		if simpan.trans then
			for nama, t in pairs(simpan.trans) do
				local bp = karakter:FindFirstChild(nama)
				if bp and bp:IsA("BasePart") then bp.Transparency = t end
			end
		end
	end
	if S.tiru.asli then S.tiru.asli[karakter] = nil end
end
function F.tiruRestore(nama)
	local p = nama and Players:FindFirstChild(nama)
	if p and p.Character then pcall(F.tiruKembalikan, p.Character) end
end
-- foto outfit kita saat ini (klon karakter), dipakai untuk Save outfit
function F.tiruFoto()
	local ku = me.Character; if not ku then return nil end
	local ok, m = pcall(function() ku.Archivable = true; return ku:Clone() end)
	if not ok or not m then return nil end
	for _, c in ipairs(m:GetDescendants()) do
		if c:IsA("Script") or c:IsA("LocalScript") or c:IsA("Humanoid") or c:IsA("Animator") then pcall(function() c:Destroy() end) end
	end
	m.Parent = nil
	return m
end
-- semua = true: kembalikan juga outfit yang sudah di-Save
function F.tiruStop(semua)
	if not (S.tiru.on or S.tiru.target or next(S.tiru.snap) ~= nil) then return end
	local nama = S.tiru.target
	S.tiru.on = false
	if nama and not S.tiru.snap[nama] then F.tiruRestore(nama); S.tiru.target = nil end
	if semua then
		for n in pairs(S.tiru.snap) do F.tiruRestore(n) end
		S.tiru.snap = {}
		S.tiru.target = nil
		S.tiru.asli = {}
	end
	S.tiru.lastCh = {}; S.tiru.sigOf = {}
	F.catat(semua and "tiru: semua outfit pemain dikembalikan" or "tiru: berhenti")
end
function F.tiruJalan()
	if S.tiruJalan then return end
	S.tiruJalan = true
	task.spawn(function()
		while S.tiru.on or next(S.tiru.snap) ~= nil do
			local daftar = {}
			for nama in pairs(S.tiru.snap) do daftar[nama] = "snap" end
			if S.tiru.on and S.tiru.target and not S.tiru.snap[S.tiru.target] then daftar[S.tiru.target] = "live" end
			for nama, mode in pairs(daftar) do
				local p = Players:FindFirstChild(nama)
				local ch = p and p.Character
				if ch and ch.Parent and ch:FindFirstChildOfClass("Humanoid") and (mode == "live" or S.tiru.snap[nama]) then
					local sg = nil
					local perlu = S.tiru.lastCh[nama] ~= ch
					if mode == "live" then
						sg = F.tiruSig()
						if sg ~= S.tiru.sigOf[nama] then perlu = true end
					end
					if perlu then
						local sumber = (mode == "snap") and S.tiru.snap[nama] or nil
						local ok, hasil = pcall(F.tiruSalin, ch, sumber)
						if not ok or hasil ~= true then
							F.catat("tiru gagal (" .. nama .. "): " .. (ok and "karakter pemain bukan R15" or string.sub(tostring(hasil), 1, 80)))
							if mode == "live" then S.tiru.on = false; S.tiru.target = nil; F.tiruRestore(nama)
							else S.tiru.snap[nama] = nil end
						else
							S.tiru.lastCh[nama] = ch; S.tiru.sigOf[nama] = sg
						end
					end
				end
			end
			task.wait(1)
		end
		S.tiruJalan = false
	end)
end
function F.tiruPilih(nama)
	if not nama or nama == me.Name then return end
	if S.tiru.target and S.tiru.target ~= nama and not S.tiru.snap[S.tiru.target] then F.tiruRestore(S.tiru.target) end
	S.tiru.target = nama; S.tiru.on = true
	S.tiru.lastCh[nama] = nil; S.tiru.sigOf[nama] = nil
	F.tiruJalan()
	F.catat("tiru outfit kita ke " .. nama)
end
-- centang Save: foto outfit kita sekarang dan tempel ke pemain terpilih, tetap walau STOP
function F.tiruSimpanToggle()
	local nama = S.tiru.target
	if not nama then F.catat("pilih pemain dulu sebelum save outfit"); return end
	if S.tiru.snap[nama] then
		S.tiru.snap[nama] = nil
		S.tiru.lastCh[nama] = nil
		F.tiruRestore(nama)
		if not S.tiru.on then S.tiru.target = nil end
		F.catat("save outfit ke " .. nama .. " dilepas")
	else
		local foto = F.tiruFoto()
		if not foto then F.catat("gagal ambil foto outfit"); return end
		S.tiru.snap[nama] = foto
		S.tiru.lastCh[nama] = nil
		F.tiruJalan()
		F.catat("outfit disimpan ke " .. nama)
	end
end
function F.resetSemua()
	pcall(F.tiruStop, true)
	for _, it in ipairs(S.items) do if it.on then F.setOn(it, false) end end
	if S.rambutOn then F.rambutSet(false) end; if S.headOn then F.headSet(false) end; if S.kor.on then F.korSet(false) end; if S.kiri.on then F.kiriSet(false) end; if S.cam.on then F.camSet(false) end; if S.bodyOn then F.bodySet(false) end
	F.emoteStop(); F.bajuReset(); F.animReset(); F.cfgResetSemua()
	if F.cloneKembalikan then pcall(F.cloneKembalikan) end
	F.catat("reset: avatar dikembalikan")
end
function F.resetAll()
	local TS = game:GetService("TweenService")
	local pg = me:FindFirstChildOfClass("PlayerGui") or me:WaitForChild("PlayerGui")
	local g = mk("ScreenGui", {Name = "ZenoxFlash", ResetOnSpawn = false, DisplayOrder = 10000, IgnoreGuiInset = true}, pg)
	local layar = mk("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, BorderSizePixel = 0}, g)
	TS:Create(layar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
	task.delay(1, function()
		F.aman(function()
			F.resetSemua()
			if S.namaCustom then F.namaSet(nil) end
			S.skel = {}
			if S.bodyOn then F.bodyClear(); S.bodyOn = false end
			S.bodyDaftar = nil
			F.segarkanUI()
		end)
		local keluar = TS:Create(layar, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
		keluar:Play(); keluar.Completed:Wait(); g:Destroy()
	end)
end
function F.skinMuat() local isi = baca(C.FILE_SKIN); if not isi then return end; local ok, d = pcall(function() return HS:JSONDecode(isi) end); if ok and type(d) == "table" and type(d.slots) == "table" then for i = 1, C.SLOT_SKIN do local s = d.slots[i]; if type(s) == "table" then S.skin.slots[i] = s end end end end
function F.skinTulis() return tulis(C.FILE_SKIN, HS:JSONEncode(S.skin)) end
function F.skinAmbil() local akses, gear = {}, {}; for _, it in ipairs(S.items) do if it.on then if it.kind == "gear" then table.insert(gear, it.id) else table.insert(akses, it.id) end end end; return {kosong = false, akses = akses, gear = gear, shirt = S.bajuWant.shirt, pants = S.bajuWant.pants, waktu = os.time()} end
function F.skinSimpan(i, nama) local d = F.skinAmbil(); local t = trim(nama); d.nama = (t ~= "") and t or ("skin " .. i); S.skin.slots[i] = d; if F.skinTulis() then F.catat("skin slot " .. i .. " disimpan") else F.catat("skin slot " .. i .. " di memori") end; F.skinSegarkan() end
function F.skinHapus(i) S.skin.slots[i] = {kosong = true}; F.skinTulis(); F.catat("skin slot " .. i .. " dihapus"); F.skinSegarkan() end
function F.skinPakai(i) local d = S.skin.slots[i]; if not d or d.kosong then F.catat("skin kosong"); return end; local daftar = {}; for _, id in ipairs(d.akses or {}) do local known = S.byId[id]; table.insert(daftar, {id = id, nama = known and known.nama or ("ID " .. tostring(id)), kind = "akses"}) end; for _, id in ipairs(d.gear or {}) do local known = S.byId[id]; table.insert(daftar, {id = id, nama = known and known.nama or ("ID " .. tostring(id)), kind = "gear"}) end; if d.shirt then F.bajuSet("shirt", d.shirt) end; if d.pants then F.bajuSet("pants", d.pants) end; F.pakaiSet(daftar, "skin " .. tostring(d.nama or i)) end
function F.skinSegarkan() local ui = S.ui; if not ui.skinBox then return end; local baris = {}; for i = 1, C.SLOT_SKIN do local d = S.skin.slots[i]; if d and not d.kosong then local jml = #(d.akses or {}) + #(d.gear or {}); table.insert(baris, i .. ". " .. tostring(d.nama) .. " (" .. jml .. " item)") else table.insert(baris, i .. ". kosong") end end; ui.skinBox.Text = table.concat(baris, "\n") end
function F.welRusak(o)
	local w = o:FindFirstChildWhichIsA("WeldConstraint", true)
	return w ~= nil and (w.Part0 == nil or w.Part1 == nil or w.Part0.Parent == nil)
end
function F.watchStep()
	-- kepala asli hanya disembunyikan saat Secret Head dipakai; kalau sudah mati, kembalikan
	local sec0 = S.byId[C.SECRET_ID]
	if S.secretHid and not (sec0 and sec0.on) then
		S.secretHid = false
		if not S.headOn then local m0 = F.target(); local hd0 = m0 and m0:FindFirstChild("Head"); if hd0 then hd0.Transparency = 0 end end
	end
	local m = F.target()
	if m ~= S.lastTarget then
		S.lastTarget = m; S.baju = {}; S.rambutOrig = {}; S.bajuBackup = nil; S.celanaBackup = nil
		for _, it in ipairs(S.items) do pcall(F.lepasObj, it) end
		if m then
			F.catat("target baru: karakter")
			for _, it in ipairs(S.items) do if it.on then task.spawn(F.jalan, it, "ulang", 1) end end
			for kelas, id in pairs(S.bajuWant) do F.bajuSet(kelas, id) end
			if S.headOn then F.headSet(true) end
			if S.kor.on or S.kiri.on then task.spawn(F.korApplyAll) end; if S.centang then task.spawn(F.centangSync) end; if S.bodyOn and S.bodyDaftar then task.spawn(F.aman, function() F.bodyApply(S.bodyDaftar, S.bodyWarna) end) end
			task.spawn(F.animUlang, m)
		end
	else
		local sekarang = os.clock()
		for _, it in ipairs(S.items) do
			if it.on and it.obj and (not it.obj.Parent or F.welRusak(it.obj)) then
				pcall(F.lepasObj, it)
				-- catat kapan item dihapus game; terlalu sering = berhenti, supaya tidak berkedip terus
				local baru = {}
				for _, t in ipairs(it.riwayat or {}) do if sekarang - t < 10 then table.insert(baru, t) end end
				table.insert(baru, sekarang); it.riwayat = baru
				if #baru > 5 then
					it.on = false; it.riwayat = {}; it.jedaSampai = 0
					if it.set then it.set(false) end
					F.catat(it.nama .. " DIHENTIKAN: dihapus game 5x dalam 10 detik")
					F.notif("ZENOX", it.nama .. " dihentikan, sering dihapus game", 5)
				else
					-- pasang ulang dijadwalkan, jeda minimal 2 detik antar pemasangan
					local tunggu = math.max(0, (it.jedaSampai or 0) - sekarang)
					it.jedaSampai = sekarang + tunggu + 0.5
					if not it.jadwal then
						it.jadwal = true
						task.delay(tunggu, function()
							it.jadwal = false
							if it.on then F.catat(it.nama .. " dipasang ulang"); task.spawn(F.jalan, it, "ulang", 1) end
						end)
					end
				end
			end
		end
	end
	F.tasCek(false)
	local ui = S.ui
	pcall(F.hairSync)
		pcall(F.bersihYatim)
		if ui.rigBox then
		local hd = m and m:FindFirstChild("Head"); local n = 0
		for _, it in ipairs(S.items) do if it.obj then n = n + 1 end end
		ui.rigBox.Text = "target: " .. (m and "karakter" or "-") .. " | Head: " .. (hd and "ada" or "-") .. " | terpasang: " .. n
	end
end
function F.jalanPantau()
	if S.pantau then return end; S.pantau = true
	task.spawn(function()
		while S.alive do task.wait(0.5); local ok, e = pcall(F.watchStep); if not ok then F.catat("error pantau: " .. string.sub(tostring(e), 1, 100)) end; pcall(F.tasCek, false); pcall(F.kameraJaga); pcall(F.nametagSync); if (S.uiAlpha or 1) ~= 1 then pcall(F.uiTerapkan) end; if S.ui.gui and S.ui.gui.Enabled then pcall(F.segarkanUI) end end
	end)
end
function F.tutup()
	S.alive = false
	for _, it in ipairs(S.items) do it.on = false; F.lepasObj(it) end
	F.headSet(false); F.korSet(false); F.kiriSet(false); F.camSet(false); F.bajuReset(); F.emoteStop()
	if S.hideConn then S.hideConn:Disconnect(); S.hideConn = nil end
	if S.ui.gui then S.ui.gui:Destroy() end
end

-- =====================================================================
-- UI KOMPONEN & HALAMAN
-- =====================================================================
local U = {order = 0}
function U.nx() U.order += 1; return U.order end
function U.sec(pg, t) local l = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, Text = t, TextColor3 = OR, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = U.nx()}, pg) end
function U.row(pg, h, nama, kanan)
    local r = mk("Frame", {Size = UDim2.new(1, 0, 0, h or 32), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = U.nx()}, pg); rnd(r)
    if nama then mk("TextLabel", {Size = UDim2.new(1, -((kanan or 50) + 18), 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1, Text = nama, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, r) end
    return r
end
function U.toggle(pg, nama, cb, awal)
    local r = U.row(pg, 32, nama, 50); local tr = mk("TextButton", {Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9), BackgroundColor3 = OFF, Text = "", AutoButtonColor = false}, r); rnd(tr, 10)
    local kn = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = BG, BorderSizePixel = 0}, tr); rnd(kn, 7)
    local st = false
    local function set(s, inst) st = s; local ti = TweenInfo.new(inst and 0 or 0.12, Enum.EasingStyle.Quad); TS:Create(tr, ti, {BackgroundColor3 = s and OR or OFF}):Play(); TS:Create(kn, ti, {Position = s and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play() end
    tr.MouseButton1Click:Connect(function() local ok, res = pcall(cb, not st); if not ok then F.catat("error: " .. tostring(res):sub(1, 90)); return end; if res ~= false then set(not st) end end)
    if awal then set(true, true) end
    return set, r
end
function U.stepper(pg, nama, get, dec, inc)
    local r = U.row(pg, 32, nama, 112); local v = mk("TextLabel", {Size = UDim2.new(0, 50, 1, 0), Position = UDim2.new(1, -88, 0, 0), BackgroundTransparency = 1, TextColor3 = OR, Font = Enum.Font.GothamBold, TextSize = 14}, r)
    local function mkBtn(txt, x) local b = mk("TextButton", {Size = UDim2.new(0, 26, 0, 22), Position = UDim2.new(1, x, 0.5, -11), BackgroundColor3 = OFF, Text = txt, TextColor3 = TXT, Font = Enum.Font.GothamBold, TextSize = 16}, r); rnd(b, 5); return b end
    local function seg() v.Text = get() end; seg(); mkBtn("-", -116).MouseButton1Click:Connect(function() dec(); seg() end); mkBtn("+", -36).MouseButton1Click:Connect(function() inc(); seg() end)
    return seg
end
function U.full(pg, txt, col, cb, solid)
    local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = solid and col or ROW, Text = txt, TextColor3 = solid and BLK or col, Font = Enum.Font.GothamBold, TextSize = 14, LayoutOrder = U.nx()}, pg); rnd(b)
    if not solid then mk("UIStroke", {Color = col, Thickness = 1}, b) end
    b.MouseButton1Click:Connect(function() cb(b) end); return b
end
function U.input(pg, ph, val)
    local r = U.row(pg, 36); local b = mk("TextBox", {Size = UDim2.new(1, -24, 1, -10), Position = UDim2.new(0, 12, 0, 5), BackgroundTransparency = 1, Text = val or "", PlaceholderText = ph, PlaceholderColor3 = MUT, TextColor3 = OR, Font = Enum.Font.GothamMedium, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false}, r); return b
end
function F.barisItem(it, parent)
	S.urut = S.urut + 1
	local b = mk("TextButton", { Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", AutoButtonColor = false, LayoutOrder = S.urut }, parent); rnd(b)
	mk("TextLabel", { Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = it.nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd }, b)
	local sw = mk("Frame", {Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9), BackgroundColor3 = OFF, BorderSizePixel = 0}, b); rnd(sw, 10)
	local kn = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = BG}, sw); rnd(kn, 7)
	it.set = function(v) TS:Create(sw, SPRING, {BackgroundColor3 = v and OR or OFF}):Play(); TS:Create(kn, SPRING, {Position = v and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play() end
	it.set(it.on); b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() F.setOn(it, not it.on) end) end)
end

-- FITUR
local function pgFitur(page)
	local B = {page = page}; local n = 0
	local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local function btn(txt, solid, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = solid and ACT or BTN, Text = txt, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end); return b end
	local function input(ph) local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = nx()}, page); rnd(r); return mk("TextBox", {Size = UDim2.new(1, -16, 1, -8), Position = UDim2.new(0, 8, 0, 4), BackgroundTransparency = 1, Text = "", PlaceholderText = ph, PlaceholderColor3 = MUT, TextColor3 = OR, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, r) end
	local function wadah() local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = nx()}, page); mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, f); return f end
	local function box(w) local l = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ROW, TextColor3 = w, Font = Enum.Font.Code, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page); rnd(l); mk("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, l); return l end
	local function toggle(nama, get, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); mk("TextLabel", {Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, b); local sw = mk("Frame", {Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9), BackgroundColor3 = OFF}, b); rnd(sw, 10); local kn = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = BG}, sw); rnd(kn, 7); local function p() local s = get(); TS:Create(sw, SPRING, {BackgroundColor3 = s and OR or OFF}):Play(); TS:Create(kn, SPRING, {Position = s and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play() end; p(); S.ui.segar = S.ui.segar or {}; table.insert(S.ui.segar, p); b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() fn(not (get() and true or false)); p() end) end) end
	
    sec("Cari fitur (nama)"); local boxCari = input("ketik nama fitur, contoh: headless"); btn("CARI FITUR", true, function() F.cariFitur(boxCari.Text) end); boxCari:GetPropertyChangedSignal("Text"):Connect(function() F.cariFitur(boxCari.Text) end)
	sec("Aksesoris & Gear"); local wAkses = wadah(); local wGear = wadah(); box(MUT).Text = "Gear dipegang satu per satu. Hanya muncul di tas kalau toggle-nya nyala."
	
    for _, it in ipairs(S.items) do if not C.RAMBUT_GANTI[it.id] then F.barisItem(it, it.kind == "gear" and wGear or wAkses) end end; S.ui.itemAdd = function(it) if C.RAMBUT_GANTI[it.id] then if S.ui.hairAdd then S.ui.hairAdd(it) end; return end; F.barisItem(it, it.kind == "gear" and wGear or wAkses) end
	
    
	sec("Custom ID aksesoris"); local boxId = input("ID aksesoris"); btn("PASANG ID AKSESORIS", true, function() local id = tonumber(trim(boxId.Text)); if id and id > 0 then F.pasangId(id) end end); btn("NYALAKAN SEMUA", false, function() for _, it in ipairs(S.items) do if not it.on then F.setOn(it, true) end end end); btn("MATIKAN SEMUA", false, function() for _, it in ipairs(S.items) do if it.on then F.setOn(it, false) end end end)
end

-- hide item: visual (mesh, decal, part) disembunyikan, efek (particle, beam, light) tetap jalan
function F.sembunyiTerapkan(it)
	local o = it.obj; if not o then return end
	it.transAsli = it.transAsli or {}
	local daftar = {}
	if o:IsA("BasePart") or o:IsA("Decal") or o:IsA("Texture") then table.insert(daftar, o) end
	for _, d in ipairs(o:GetDescendants()) do if d:IsA("BasePart") or d:IsA("Decal") or d:IsA("Texture") then table.insert(daftar, d) end end
	for _, d in ipairs(daftar) do
		if it.sembunyi then
			if it.transAsli[d] == nil then it.transAsli[d] = d.Transparency end
			d.Transparency = 1
		elseif it.transAsli[d] ~= nil then
			if d.Parent then d.Transparency = it.transAsli[d] end
		end
	end
	if not it.sembunyi then it.transAsli = {} end
end
function F.sembunyiSet(it, v)
	it.sembunyi = v and true or false
	F.sembunyiTerapkan(it)
	F.catat(it.nama .. (it.sembunyi and " disembunyikan (efek tetap)" or " ditampilkan lagi"))
end
function F.sembunyiSemua(v)
	for _, it in ipairs(S.items) do
		it.sembunyi = v and true or false
		pcall(F.sembunyiTerapkan, it)
	end
	F.catat("semua item " .. (v and "disembunyikan (efek tetap)" or "ditampilkan lagi"))
	F.segarkanUI()
end
-- baris hasil cari di menu HIDE ITEM (muncul hanya setelah diketik)
function F.barisHide(it, parent)
	local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", AutoButtonColor = false}, parent); rnd(b)
	mk("TextLabel", {Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = it.nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, b)
	local sw = mk("Frame", {Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9), BackgroundColor3 = OFF, BorderSizePixel = 0}, b); rnd(sw, 10)
	local kn = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = BG}, sw); rnd(kn, 7)
	local function segar() TS:Create(sw, SPRING, {BackgroundColor3 = it.sembunyi and OR or OFF}):Play(); TS:Create(kn, SPRING, {Position = it.sembunyi and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play() end
	segar(); F.daftarSegar(segar)
	b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() F.sembunyiSet(it, not it.sembunyi); segar() end) end)
end
function F.hideCari(teks, parent)
	for _, c in ipairs(parent:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
	local q = string.lower(trim(teks)); if q == "" then return end
	local n = 0
	for _, it in ipairs(S.items) do
		if string.find(string.lower(it.nama), q, 1, true) then
			n = n + 1; if n > 15 then break end
			F.barisHide(it, parent)
		end
	end
end

-- cari fitur yang ada di menu: baris yang namanya cocok ditampilkan, tab-nya otomatis dibuka
function F.cariFitur(teks)
	local q = string.lower(trim(teks))
	local pertama = nil
	for _, pg in pairs(S.ui.halamanList or {}) do
		for _, d in ipairs(pg:GetDescendants()) do
			if d:IsA("TextButton") and d.Text == "" then
				local lb = d:FindFirstChildWhichIsA("TextLabel")
				if lb then
					local cocok = (q == "") or (string.find(string.lower(lb.Text), q, 1, true) ~= nil)
					d.Visible = cocok
					if cocok and q ~= "" and not pertama then pertama = pg end
				end
			end
		end
	end
	if pertama and S.ui.tampil then S.ui.tampil(pertama:GetAttribute("zxKey")) end
end

-- SHIRT & HAIR
function F.pasangCustom(teks)
	local id = tonumber(trim(teks or ""))
	if not id or id <= 0 then F.catat("custom ID: isi angka ID dulu"); return end
	task.spawn(F.aman, function()
		local ok, inf = pcall(function() return MPS:GetProductInfo(id) end)
		if not ok or not inf then F.catat("ID " .. id .. ": info tidak bisa dibaca"); return end
		local t = inf.AssetTypeId
		if t == 2 or t == 11 then F.bajuGanti(id); F.catat("shirt " .. tostring(inf.Name) .. " dipasang")
		elseif t == 12 then F.celanaGanti(id); F.catat("celana " .. tostring(inf.Name) .. " dipasang")
		else F.pasangId(id) end
	end)
end
local function pgShirt(page)
	local B = {page = page}; local n = 0
	local function nx() n = n + 1; return n end
	local induk = page
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local function btn(txt, solid, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = solid and ACT or BTN, Text = txt, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, induk); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end); return b end
	local function wadah() local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = nx()}, induk); mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, f); return f end
	local function toggle(nama, get, fn)
		local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", AutoButtonColor = false, LayoutOrder = nx()}, induk); rnd(b)
		mk("TextLabel", {Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, b)
		local sw = mk("Frame", {Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9), BackgroundColor3 = OFF, BorderSizePixel = 0}, b); rnd(sw, 10)
		local kn = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = BG}, sw); rnd(kn, 7)
		local function segar() local v = get(); TS:Create(sw, SPRING, {BackgroundColor3 = v and OR or OFF}):Play(); TS:Create(kn, SPRING, {Position = v and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play() end
		segar(); b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() fn(not get()); segar() end) end); F.daftarSegar(segar)
	end
	local function grup(judul, buka)
		local kepala = mk("TextButton", {Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = nx()}, induk)
		local teks = mk("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, TextColor3 = OR, Font = FB, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, kepala)
		local isi = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Visible = buka, LayoutOrder = nx()}, page)
		mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, isi)
		local function segar() teks.Text = judul .. (isi.Visible and "  -" or "  +") end
		segar()
		kepala.MouseButton1Click:Connect(function() isi.Visible = not isi.Visible; segar() end)
		return isi
	end
	induk = grup("Custom ID (shirt / celana / hair)", false)
	local boxCustom = mk("TextBox", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", PlaceholderText = "tempel ID shirt, celana, atau hair", PlaceholderColor3 = MUT, TextColor3 = TXT, Font = FM, TextSize = 12, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, induk)
	rnd(boxCustom); mk("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, boxCustom)
	btn("PASANG ID CUSTOM", true, function() F.pasangCustom(boxCustom.Text) end)
	induk = grup("Baju (shirt)", false)
	btn("HAPUS BAJU", false, function() F.bajuHapus() end)
	btn("KEMBALIKAN BAJU ASLI", false, function() F.bajuKembali() end)
	for i, s in ipairs(C.SHIRT) do btn(i .. ". " .. s.nama, true, function() F.bajuGanti(s.id) end) end
	induk = grup("Celana (pants)", false)
	btn("KEMBALIKAN CELANA ASLI", false, function() F.celanaKembali() end)
	for _, s in ipairs(C.CELANA) do btn(s.nama, true, function() F.celanaGanti(s.id) end) end
	induk = grup("Rambut", false)
	toggle("Hapus rambut", function() return S.rambutOn == true end, function(v) F.rambutSet(v) end)
	toggle("girl hair", F.girlHairOn, function(v) F.girlHairSet(v) end)
	local wHair = wadah()
	S.ui.hairAdd = function(it) F.barisItem(it, wHair) end
	for _, it in ipairs(S.items) do if C.RAMBUT_GANTI[it.id] then F.barisItem(it, wHair) end end
end

local function pgHide(page)
	local B = {page = page}; local n = 0
	local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local rowAll = mk("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, LayoutOrder = nx()}, page)
	local function tombol(txt, x, fn) local b = mk("TextButton", {Size = UDim2.new(0.5, -4, 1, 0), Position = UDim2.new(x, x > 0 and 4 or 0, 0, 0), BackgroundColor3 = ROW, Text = txt, TextColor3 = OR, Font = FB, TextSize = 13, AutoButtonColor = false}, rowAll); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end) end
	tombol("SEMBUNYIKAN SEMUA", 0, function() F.sembunyiSemua(true) end)
	tombol("TAMPILKAN SEMUA", 0.5, function() F.sembunyiSemua(false) end)
	-- sembunyikan username (nama di atas kepala) untuk karakter kita dan karakter hasil Larp / Clone
	local bNama = mk("TextButton", {Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = ROW, Text = "", TextColor3 = TXT, Font = FM, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(bNama)
	local function segarNama() bNama.Text = (S.nametagHide == true) and "Username: DISEMBUNYIKAN (klik untuk tampilkan)" or "Username: TAMPIL (klik untuk sembunyikan)" end
	bNama.MouseButton1Click:Connect(function() task.spawn(F.aman, function() F.nametagSet(S.nametagHide ~= true); segarNama() end) end)
	segarNama()
	sec("Hide item (cari dulu)")
	local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = nx()}, page); rnd(r)
	local boxHide = mk("TextBox", {Size = UDim2.new(1, -16, 1, -8), Position = UDim2.new(0, 8, 0, 4), BackgroundTransparency = 1, Text = "", PlaceholderText = "ketik nama item yang mau di hide", PlaceholderColor3 = MUT, TextColor3 = OR, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false}, r)
	local wHide = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = nx()}, page)
	mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, wHide)
	boxHide:GetPropertyChangedSignal("Text"):Connect(function() F.hideCari(boxHide.Text, wHide) end)
	local catatan = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ROW, TextColor3 = MUT, Font = Enum.Font.Code, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Text = "Item muncul setelah diketik. Hide hanya menyembunyikan badan item, efek partikelnya tetap jalan.", LayoutOrder = nx()}, page); rnd(catatan)
	mk("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, catatan)
end

-- CLASSIC RETRO SKELETON: kaki kanan, kaki kiri, badan bisa dinyalakan sendiri-sendiri
function F.skelSet(k, v)
	S.skel = S.skel or {}
	S.skel[k] = v and true or false
	F.skelSync()
end
function F.skelSync()
	local urut = {{"kanan", "Right Leg"}, {"kiri", "Left Leg"}, {"badan", "Torso"}}
	local daftar = {}
	for _, u in ipairs(urut) do
		if S.skel and S.skel[u[1]] then table.insert(daftar, {id = C.SKEL[u[1]], nama = u[2]}) end
	end
	if #daftar == 0 then
		if S.bodyOn then F.bodyClear(); S.bodyOn = false end
		S.bodyDaftar = nil
		F.catat("Classic skeleton OFF")
	else
		F.bodyApply(daftar, nil)
	end
	F.segarkanUI()
end
-- tab BODY: Korblox, Headless, Classic Retro Skeleton
local function pgBody(page)
	local B = {page = page}; local n = 0
	local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local function toggle(nama, get, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); mk("TextLabel", {Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, b); local sw = mk("Frame", {Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9), BackgroundColor3 = OFF}, b); rnd(sw, 10); local kn = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = BG}, sw); rnd(kn, 7); local function p() local s = get(); TS:Create(sw, SPRING, {BackgroundColor3 = s and OR or OFF}):Play(); TS:Create(kn, SPRING, {Position = s and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play() end; p(); S.ui.segar = S.ui.segar or {}; table.insert(S.ui.segar, p); b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() fn(not (get() and true or false)); p() end) end) end
	sec("Korblox")
	toggle("Korblox kaki kanan", function() return S.kor.on end, function(v) F.korSet(v) end)
	toggle("Korblox kaki kiri", function() return S.kiri.on end, function(v) F.kiriSet(v) end)
	sec("Headless")
	toggle("Headless", function() return S.headOn end, function(v) F.headSet(v) end)
	sec("Body bundle")
	local boxBundle = mk("TextBox", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", PlaceholderText = "ID bundle lain (angka)", PlaceholderColor3 = MUT, TextColor3 = TXT, Font = FM, TextSize = 13, ClearTextOnFocus = false, LayoutOrder = nx()}, page)
	rnd(boxBundle)
	local tombolPasang = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ACT, Text = "PASANG BUNDLE", TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page)
	rnd(tombolPasang)
	tombolPasang.MouseButton1Click:Connect(function()
		task.spawn(F.aman, function()
			local id = tonumber(trim(boxBundle.Text))
			if not id then F.catat("body: isi ID bundle (angka)"); return end
			F.bodySet(false)
			local ok = F.bodySet(true, id)
			S.bodyId = ok and id or nil
			F.catat("body bundle " .. tostring(id) .. (ok and " dipasang" or " gagal"))
		end)
	end)
	local tombolLepas = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "LEPAS BODY", TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page)
	rnd(tombolLepas)
	tombolLepas.MouseButton1Click:Connect(function()
		task.spawn(F.aman, function() S.bodyId = nil; F.bodySet(false) end)
	end)
	mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ROW, TextColor3 = MUT, Font = Enum.Font.Code, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx(), Text = "Body bundle R6 di-weld ke rig R15 kamu. Kepala bundle tidak bisa dimuat dari client, jadi kepala tetap seperti semula. Rig tetap R15."}, page)
end

-- OUTFIT CODE: urutan fitur tetap (1 = item pertama di config, lalu fitur tetap, emote terakhir, custom paling akhir)
function F.fiturUrut()
	local daftar, dipakai = {}, {}
	local function tambah(nama, on, cat) table.insert(daftar, {nama = nama, on = on == true, cat = cat}) end
	for _, grup in ipairs({C.AKSES, C.GEAR}) do
		for _, a in ipairs(grup) do
			local it = S.byId[a[2]]
			tambah(a[1], it and it.on, a[2]); dipakai[a[2]] = true
		end
	end
	local wb, sk, em = S.bajuWant or {}, S.skel or {}, S.emote or {}
	tambah("Headless", S.headOn)
	tambah("Korblox kaki kanan", S.kor and S.kor.on)
	tambah("Korblox kaki kiri", S.kiri and S.kiri.on)
	tambah("Classic skeleton kaki kanan", sk.kanan, C.SKEL.kanan)
	tambah("Classic skeleton kaki kiri", sk.kiri, C.SKEL.kiri)
	tambah("Classic skeleton badan", sk.badan, C.SKEL.badan)
	tambah("Hapus rambut", S.rambutOn)
	local sid = wb.shirt or wb.tshirt
	tambah("Shirt", sid ~= nil, sid)
	tambah("Celana", wb.pants ~= nil, wb.pants)
	tambah("Emote", (em.nama or "") ~= "")
	for _, it in ipairs(S.items) do if not dipakai[it.id] then tambah(it.nama, it.on, it.id) end end
	return daftar
end
function F.outfitKode()
	local p = {}
	for i, e in ipairs(F.fiturUrut()) do if e.on then table.insert(p, tostring(i)) end end
	if #p == 0 then return "ZX-kosong" end
	return "ZX-" .. table.concat(p, "-")
end
function F.avatarKode()
	local c = {}
	for _, e in ipairs(F.fiturUrut()) do if e.on and e.cat then table.insert(c, tostring(e.cat)) end end
	if #c == 0 then return "(kosong)" end
	return table.concat(c, ",")
end
function F.urutanTeks()
	local b = {}
	for i, e in ipairs(F.fiturUrut()) do table.insert(b, i .. ". " .. e.nama .. (e.on and "  [ON]" or "")) end
	return table.concat(b, "\n")
end
function F.salin(teks, pesan)
	if setclipboard then setclipboard(teks); F.notif("ZENOX", pesan, 3)
	else F.notif("ZENOX", "executor ini tidak punya fungsi salin", 4) end
end
function F.pasangAvatarKode(teks)
	local daftar, sudah = {}, {}
	for angka in string.gmatch(teks or "", "%d+") do
		local id = tonumber(angka)
		if id and not sudah[id] then sudah[id] = true; table.insert(daftar, id) end
	end
	if #daftar == 0 then F.catat("avatar code kosong / tidak valid"); return end
	task.spawn(F.aman, function()
		local adaSkel = false
		for _, id in ipairs(daftar) do
			if id == C.SKEL.kanan or id == C.SKEL.kiri or id == C.SKEL.badan then
				local nama = (id == C.SKEL.kanan and "kanan") or (id == C.SKEL.kiri and "kiri") or "badan"
				S.skel = S.skel or {}; S.skel[nama] = true; adaSkel = true
			elseif S.byId[id] then
				if not S.byId[id].on then F.setOn(S.byId[id], true) end
			else
				local ok, inf = pcall(function() return MPS:GetProductInfo(id) end)
				local t = ok and inf and inf.AssetTypeId
				if t == 2 or t == 11 then F.bajuGanti(id)
				elseif t == 12 then F.celanaGanti(id)
				else F.pasangId(id) end
			end
		end
		if adaSkel then F.skelSync() end
		F.catat("avatar code dipasang: " .. #daftar .. " ID")
	end)
end
-- tab OUTFIT: kode outfit yang sedang dipakai + avatar code (share avatar), bisa disalin dan dipasang

-- FAKER: centang biru lokal (cuma tampil di layar sendiri)
-- centang biru hanya di baris nama pemain (leaderboard/daftar pemain) di layar sendiri
function F.centangBadge(lbl)
	local b = mk("Frame", {Name = "ZenoxCentang", Size = UDim2.new(0, 14, 0, 14), Rotation = 20, BackgroundColor3 = Color3.fromRGB(40, 140, 255), BorderSizePixel = 0, ZIndex = lbl.ZIndex + 1}, lbl)
	local function garis(x1, y1, x2, y2)
		local dx, dy = x2 - x1, y2 - y1
		mk("Frame", {Name = "Garis", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new((x1 + x2) / 2, 0, (y1 + y2) / 2, 0), Size = UDim2.new(math.sqrt(dx * dx + dy * dy) + 0.12, 0, 0.12, 0), Rotation = math.deg(math.atan2(dy, dx)), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = lbl.ZIndex + 2}, b)
	end
	garis(0.25, 0.52, 0.43, 0.70)
	garis(0.43, 0.70, 0.76, 0.34)
	return b
end
function F.centangTempel()
	local nama = string.lower(me.Name)
	local tampil = string.lower(me.DisplayName or "")
	local jumlah = 0
	local akar = {}
	local pg = me:FindFirstChildOfClass("PlayerGui"); if pg then table.insert(akar, pg) end
	local okC, cg = pcall(function() return game:GetService("CoreGui") end)
	if okC and cg then table.insert(akar, cg) end
	for _, root in ipairs(akar) do
		for _, d in ipairs(root:GetDescendants()) do
			if (d:IsA("TextLabel") or d:IsA("TextButton")) and not (S.ui.gui and d:IsDescendantOf(S.ui.gui)) then
				local asliTxt = d.Text or ""; if d:GetAttribute("ZenoxNamaTampil") ~= nil and d.Text == d:GetAttribute("ZenoxNamaTampil") then asliTxt = d:GetAttribute("ZenoxNamaAsli") or asliTxt end; local teks = string.gsub(asliTxt, "<[^>]->", "")
				local t = string.lower(trim(teks))
				t = string.gsub(t, "^@", "")
				t = string.gsub(t, ":$", "")
				if t ~= "" and (t == nama or (tampil ~= "" and t == tampil)) then
					jumlah = jumlah + 1
					local b = d:FindFirstChild("ZenoxCentang") or F.centangBadge(d)
					local sz = math.max(7, math.floor((d.TextSize or 14) * (S.centangUk or 0.62)))
					b.Size = UDim2.new(0, sz, 0, sz)
					if d.TextXAlignment == Enum.TextXAlignment.Center then
						b.Position = UDim2.new(0.5, math.floor(d.TextBounds.X / 2) + 4, 0.5, -math.floor(sz / 2) - 2 + (S.centangGeser or 0))
					else
						b.Position = UDim2.new(0, math.floor(d.TextBounds.X) + 4, 0.5, -math.floor(sz / 2) - 2 + (S.centangGeser or 0))
					end
				end
			end
		end
	end
	return jumlah
end
function F.centangSync()
	-- bersihkan centang versi lama yang ada di atas kepala
	local m = F.target(); local hd = m and m:FindFirstChild("Head")
	if hd then local lama = hd:FindFirstChild("ZenoxCentang"); if lama then lama:Destroy() end end
	if not S.centang then
		F.bersihBadge()
		return
	end
	if S.centangJalan then return end
	S.centangJalan = true
	task.spawn(function()
		local laporan = false
		while S.centang do
			local ok, n = pcall(F.centangTempel)
			if not ok then F.catat("centang error: " .. string.sub(tostring(n), 1, 90))
			elseif n > 0 and not laporan then laporan = true; F.catat("centang: " .. n .. " baris nama ketemu")
			elseif n == 0 and not laporan then F.catat("centang: nama belum ketemu di layar, buka leaderboard dulu") end
			task.wait(1)
		end
		S.centangJalan = false
	end)
end
function F.bersihBadge()
	local akar = {}
	local pg = me:FindFirstChildOfClass("PlayerGui"); if pg then table.insert(akar, pg) end
	local okC, cg = pcall(function() return game:GetService("CoreGui") end)
	if okC and cg then table.insert(akar, cg) end
	for _, r in ipairs(akar) do
		for _, d in ipairs(r:GetDescendants()) do
			if d.Name == "ZenoxCentang" then pcall(function() d:Destroy() end) end
		end
	end
end
-- CUSTOM NAME (lokal): ganti teks nama di leaderboard dan nametag karakter, cuma kelihatan di layar sendiri
function F.namaAkar()
	local akar = {}
	local pg = me:FindFirstChildOfClass("PlayerGui"); if pg then table.insert(akar, pg) end
	local okC, cg = pcall(function() return game:GetService("CoreGui") end)
	if okC and cg then table.insert(akar, cg) end
	local m = F.target()
	if m then table.insert(akar, m) end
	if me.Character and me.Character ~= m then table.insert(akar, me.Character) end
	return akar
end
function F.namaSapu(custom)
	local jumlah = 0
	for _, root in ipairs(F.namaAkar()) do
		for _, d in ipairs(root:GetDescendants()) do
			if (d:IsA("TextLabel") or d:IsA("TextButton")) and not (S.ui.gui and d:IsDescendantOf(S.ui.gui)) then
				local tampil = d:GetAttribute("ZenoxNamaTampil")
				if tampil ~= nil and d.Text ~= tampil then
					-- leaderboard sudah menulis ulang teks label ini, anggap label baru
					d:SetAttribute("ZenoxNamaAsli", nil); d:SetAttribute("ZenoxNamaTampil", nil)
					tampil = nil
				end
				if tampil ~= nil then
					if custom then
						if tampil ~= custom then d:SetAttribute("ZenoxNamaTampil", custom); d.Text = custom end
						jumlah = jumlah + 1
					else
						d.Text = d:GetAttribute("ZenoxNamaAsli") or d.Text
						d:SetAttribute("ZenoxNamaAsli", nil); d:SetAttribute("ZenoxNamaTampil", nil)
					end
				elseif custom then
					local t = string.lower(trim((string.gsub(d.Text or "", "<[^>]->", ""))))
					t = string.gsub(t, "^@", "")
					t = string.gsub(t, ":$", "")
					if t ~= "" and (t == string.lower(me.Name) or t == string.lower(me.DisplayName or "")) then
						d:SetAttribute("ZenoxNamaAsli", d.Text)
						d:SetAttribute("ZenoxNamaTampil", custom)
						d.Text = custom
						jumlah = jumlah + 1
					end
				end
			end
		end
	end
	return jumlah
end
function F.namaSet(v)
	local t = trim((string.gsub(tostring(v or ""), "[<>]", "")))
	S.namaCustom = (t ~= "" and string.sub(t, 1, 24)) or nil
	if not S.namaCustom then
		pcall(F.namaSapu, nil)
		F.catat("custom name: kembali ke nama asli")
		return
	end
	pcall(F.namaSapu, S.namaCustom)
	F.catat("custom name: " .. S.namaCustom)
	if S.namaJalan then return end
	S.namaJalan = true
	task.spawn(function()
		while S.namaCustom do
			local ok, e = pcall(F.namaSapu, S.namaCustom)
			if not ok then F.catat("custom name error: " .. string.sub(tostring(e), 1, 90)) end
			task.wait(1)
		end
		S.namaJalan = false
	end)
end
function F.centangSet(v)
	S.centang = v and true or false
	F.centangSync()
	F.catat("centang biru lokal " .. (S.centang and "ON" or "OFF"))
	F.segarkanUI()
end
-- ===== CLONE AVATAR: port dari KingAgoy (model swap + copy di tempat R6/R15), tidak diubah =====
local CLONE = (function()
	local inPlaceBackup = {}
	local inPlaceUserId = nil
	local buildR15Model = nil
	local function log(...)
		local t = {}
		for i = 1, select("#", ...) do t[i] = tostring((select(i, ...))) end
		F.catat(table.concat(t, " "))
	end
	local function restoreToggleEffects(character) end
	-- ----- state & shim dari KingAgoy -----
	local player = me
	local running = true
	local autoApply = true
	local AutoApplyToggle = nil
	local Window = nil
	local targetInput = ""
	local fake, real = nil, nil
	local lastUserId, lastBuilder = nil, nil
	local ours = {}
	local copying = false
	local savedLeg = nil
	local stopEmoteSupport = nil
	local reapplyBusy = false
	local reapplyTimes = {}
	local MAX_REAPPLY = 3
	local REAPPLY_WINDOW = 60
	local pendingRestore = {}
	local RunService = RS
	local ContentProvider = game:GetService("ContentProvider")
	local trackedGuis = {}
	local customName, prevCustomName = nil, nil -- display name palsu (tidak dipakai di v10)
	local ownEmoteData = nil
	local lastEmotes = {}
	local setupEmoteSupport = nil
	local function notify(title, text)
		F.catat(tostring(title) .. ": " .. string.sub(tostring(text), 1, 140))
	end
	-- nametag di atas kepala: sembunyikan nama default + BillboardGui (bisa dinyalakan lagi)
	local function nametagApply(char, on)
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			if on then
				if hum:GetAttribute("zxDDT") == nil then hum:SetAttribute("zxDDT", hum.DisplayDistanceType.Name) end
				pcall(function() hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end)
			else
				local asal = hum:GetAttribute("zxDDT")
				if asal then
					pcall(function() hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType[asal] end)
					hum:SetAttribute("zxDDT", nil)
				end
			end
		end
		for _, d in ipairs(char:GetDescendants()) do
			if d:IsA("BillboardGui") then
				if on then
					if d:GetAttribute("zxEn") == nil then d:SetAttribute("zxEn", d.Enabled) end
					d.Enabled = false
				else
					local asal = d:GetAttribute("zxEn")
					if asal ~= nil then d.Enabled = asal; d:SetAttribute("zxEn", nil) end
				end
			end
		end
	end
	local function nametagPlayer(on) nametagApply(me.Character, on); local mT = F.target(); if mT and mT ~= me.Character then nametagApply(mT, on) end end
	-- matikan efek body script selama copy (dipasang ulang setelah copy selesai)
	local function turnOffToggles()
		pendingRestore = {kor = S.kor.on == true, kiri = S.kiri.on == true, head = S.headOn == true}
		if S.bodyOn then pcall(F.bodySet, false); S.bodyId = nil end
		if pendingRestore.kor then pcall(F.korSet, false) end
		if pendingRestore.kiri then pcall(F.kiriSet, false) end
		if pendingRestore.head then pcall(F.headSet, false) end
	end
local function getDescription(userId)
    local lastErr = "unknown"
    for attempt = 1, 3 do
        local ok, res = pcall(function()
            return Players:GetHumanoidDescriptionFromUserId(userId)
        end)
        if ok and res then
            return res, nil
        end
        lastErr = tostring(res)
        log("Ambil deskripsi gagal (percobaan " .. attempt .. "): " .. lastErr)
        task.wait(1)
    end
    return nil, lastErr
end
-- ===== COPY AVATAR R6 "DI TEMPAT" (karakter & isi map TIDAK diganti) =====
-- Karakter asli tetap dipakai, jadi Tool (mis. alat pancing), script Animate, animasi map,
-- dan semua yang tersambung ke karakter tetap utuh. Yang diubah hanya TAMPILAN:
-- Accessory, Shirt/Pants/ShirtGraphic, CharacterMesh, BodyColors, wajah, bentuk kepala, warna part.
-- Tampilan asli dicadangkan dulu supaya bisa dikembalikan lewat Reset.
local R6_PART_NAMES = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}

local function isAppearanceItem(c)
    return c:IsA("Accessory") or c:IsA("Shirt") or c:IsA("Pants") or c:IsA("ShirtGraphic")
        or c:IsA("CharacterMesh") or c:IsA("BodyColors")
end

local function restoreInPlace(model)
    local rec = inPlaceBackup[model]
    if not rec then
        return
    end
    inPlaceBackup[model] = nil

    if model.Parent == nil then
        return -- karakter sudah hilang, tidak ada yang perlu dikembalikan
    end

    local hum = model:FindFirstChildOfClass("Humanoid") or model:FindFirstChildWhichIsA("Humanoid", true)

    -- buang hasil copy
    for _, c in ipairs(model:GetChildren()) do
        if c:GetAttribute("KA_Copy") then
            c:Destroy()
        end
    end
    local head = model:FindFirstChild("Head")
    -- buang titik sambung (Attachment) / mesh / decal hasil copy di semua part badan
    for _, p in ipairs(model:GetChildren()) do
        if p:IsA("BasePart") then
            for _, c in ipairs(p:GetChildren()) do
                if c:GetAttribute("KA_Copy") then
                    c:Destroy()
                end
            end
        end
    end

    -- kembalikan badan R15 (mesh, ukuran, warna, sambungan)
    if rec.r15 then
        local r = rec.r15
        for cur, j in pairs(r.joints) do
            if cur.Parent then
                cur.C0 = j.c0
                cur.C1 = j.c1
            end
        end
        for a, cf in pairs(r.atts) do
            if a.Parent then
                a.CFrame = cf
            end
        end
        for part, d in pairs(r.parts) do
            if part.Parent then
                if d.mesh then
                    pcall(function()
                        part.MeshId = d.mesh
                    end)
                    pcall(function()
                        part.TextureID = d.tex
                    end)
                end
                pcall(function()
                    part.Size = d.size
                end)
                part.Color = d.color
                if d.sa then
                    d.sa.Parent = part
                end
            end
        end
        if hum then
            pcall(function()
                hum.HipHeight = r.hip
            end)
        end
    end

    -- kembalikan tampilan asli
    for _, item in ipairs(rec.items) do
        if item:IsA("Accessory") and hum then
            local okAdd = pcall(function()
                hum:AddAccessory(item)
            end)
            if not okAdd or item.Parent ~= model then
                item.Parent = model
            end
        else
            item.Parent = model
        end
    end

    if head then
        if rec.headMesh then
            rec.headMesh.Parent = head
        end
        if rec.face and rec.face.decal and rec.face.decal.Parent then
            rec.face.decal.Texture = rec.face.tex
        end
    end

    for name, color in pairs(rec.colors) do
        local part = model:FindFirstChild(name)
        if part and part:IsA("BasePart") then
            part.Color = color
        end
    end
end

local function resetInPlace()
    local any = false
    for model in pairs(inPlaceBackup) do
        local okR, eR = pcall(restoreInPlace, model)
        if not okR then log("reset error: " .. tostring(eR)) end
        any = true
    end
    inPlaceBackup = {}
    inPlaceUserId = nil
    -- bersihkan sisa hasil copy yang masih menempel di karakter sekarang
    if player.Character then
        for _, c in ipairs(player.Character:GetChildren()) do
            if c:GetAttribute("KA_Copy") then pcall(function() c:Destroy() end); any = true end
        end
    end
    return any
end

-- Pasang 1 aksesoris ke karakter: cari pasangan Attachment (HairAttachment, HatAttachment, dll)
-- lalu pastikan ada Weld yang benar ke part karakter kita (bukan ke model referensi).
local function attachAccessoryInPlace(model, acc)
    local handle = acc:FindFirstChild("Handle")
    if not handle or not handle:IsA("BasePart") then
        acc.Parent = model
        return
    end

    -- weld lama menunjuk ke model referensi: buang
    for _, d in ipairs(acc:GetDescendants()) do
        if d:IsA("JointInstance") and d.Name == "AccessoryWeld" then
            d:Destroy()
        end
    end
    for _, d in ipairs(acc:GetDescendants()) do
        if d:IsA("BasePart") then
            d.CanCollide = false
            d.CanTouch = false
            d.CanQuery = false
            d.Massless = true
            d.Anchored = false
        end
    end

    -- cari pasangan attachment: attachment di Handle + attachment bernama sama di part karakter
    local att0, att1 = nil, nil
    local hatAtt = handle:FindFirstChild("HatAttachment")
    local order = {}
    if hatAtt and hatAtt:IsA("Attachment") then
        table.insert(order, hatAtt)
    end
    for _, a in ipairs(handle:GetChildren()) do
        if a:IsA("Attachment") and a ~= hatAtt then
            table.insert(order, a)
        end
    end
    for _, a in ipairs(order) do
        if not att1 then
            for _, p in ipairs(model:GetChildren()) do
                if p:IsA("BasePart") then
                    local x = p:FindFirstChild(a.Name)
                    if x and x:IsA("Attachment") then
                        att0, att1 = x, a
                        break
                    end
                end
            end
        end
    end

    acc.Parent = model
    task.wait() -- beri kesempatan engine membuat weld sendiri

    -- sudah ada weld yang benar (ke part karakter kita)?
    local good = false
    for _, d in ipairs(handle:GetChildren()) do
        if d:IsA("JointInstance") and d.Part1 == handle and d.Part0 and d.Part0:IsDescendantOf(model) then
            good = true
            break
        end
    end
    if good then
        return
    end

    local w = Instance.new("Weld")
    w.Name = "AccessoryWeld"
    if att0 and att1 then
        w.Part0 = att0.Parent
        w.Part1 = handle
        w.C0 = att0.CFrame
        w.C1 = att1.CFrame
    else
        -- cadangan: puncak kepala
        local head = model:FindFirstChild("Head")
        if not head then
            return
        end
        w.Part0 = head
        w.Part1 = handle
        w.C0 = CFrame.new(0, head.Size.Y / 2, 0)
        w.C1 = CFrame.new()
    end
    w.Parent = handle
end

-- R15 di tempat: salin mesh/texture/warna/ukuran tiap part badan, Motor6D (proporsi) dan
-- Attachment dari model referensi ke model yang ada. Nilai asli dicadangkan di rec.r15.
local function applyR15Body(model, ref, hum, rec)
    local data = {parts = {}, joints = {}, atts = {}, hip = hum.HipHeight}
    rec.r15 = data
    local refHum = ref:FindFirstChildOfClass("Humanoid")

    for _, refPart in ipairs(ref:GetChildren()) do
        if refPart:IsA("BasePart") and refPart.Name ~= "HumanoidRootPart" then
            local part = model:FindFirstChild(refPart.Name)
            if part and part:IsA("BasePart") then
                local d = {size = part.Size, color = part.Color}
                data.parts[part] = d

                if part:IsA("MeshPart") and refPart:IsA("MeshPart") then
                    d.mesh = part.MeshId
                    d.tex = part.TextureID
                    pcall(function()
                        part.MeshId = refPart.MeshId
                    end)
                    pcall(function()
                        part.TextureID = refPart.TextureID
                    end)

                    local curSA = part:FindFirstChildOfClass("SurfaceAppearance")
                    if curSA then
                        d.sa = curSA
                        curSA.Parent = nil
                    end
                    local refSA = refPart:FindFirstChildOfClass("SurfaceAppearance")
                    if refSA then
                        local c = refSA:Clone()
                        c:SetAttribute("KA_Copy", true)
                        c.Parent = part
                    end
                end

                pcall(function()
                    part.Size = refPart.Size
                end)
                part.Color = refPart.Color

                for _, a in ipairs(refPart:GetChildren()) do
                    if a:IsA("Attachment") then
                        local ca = part:FindFirstChild(a.Name)
                        if ca and ca:IsA("Attachment") then
                            data.atts[ca] = ca.CFrame
                            ca.CFrame = a.CFrame
                        end
                    end
                end
            end
        end
    end

    for _, j in ipairs(ref:GetDescendants()) do
        if j:IsA("Motor6D") and j.Part1 then
            local p1 = model:FindFirstChild(j.Part1.Name)
            local cur = p1 and p1:FindFirstChild(j.Name)
            if cur and cur:IsA("Motor6D") then
                data.joints[cur] = {c0 = cur.C0, c1 = cur.C1}
                cur.C0 = j.C0
                cur.C1 = j.C1
            end
        end
    end

    if refHum then
        pcall(function()
            hum.HipHeight = refHum.HipHeight
        end)
    end
end

local function applyAppearanceInPlace(model, userId, descOverride)
    local hum = model:FindFirstChildOfClass("Humanoid") or model:FindFirstChildWhichIsA("Humanoid", true)
    if not hum then
        return false, "Humanoid tidak ditemukan"
    end
    local isR15 = hum.RigType == Enum.HumanoidRigType.R15
    if hum.RigType ~= Enum.HumanoidRigType.R6 and not isR15 then
        return false, "Tipe rig tidak didukung"
    end
    if hum.Health <= 0 then
        return false, "Karakter sedang mati, tunggu respawn"
    end

    local desc, descErr
    if descOverride then desc = descOverride else desc, descErr = getDescription(userId) end
    if not desc then
        return false, "Gagal ambil data avatar: " .. tostring(descErr)
    end

    -- model referensi (tidak ditaruh di workspace, hanya dibaca lalu dibuang)
    local okM, ref = pcall(function()
        if isR15 and buildR15Model then
            return buildR15Model(desc, Enum.HumanoidRigType.R15)
        end
        return Players:CreateHumanoidModelFromDescription(
            desc, isR15 and Enum.HumanoidRigType.R15 or Enum.HumanoidRigType.R6)
    end)
    if not okM or not ref then
        return false, "Gagal buat model referensi: " .. tostring(ref)
    end

    -- bersihkan copy sebelumnya + efek Headless/Korblox supaya cadangan bersih
    pcall(restoreInPlace, model)
    pcall(restoreToggleEffects, model)

    local rec = {items = {}, colors = {}, headMesh = nil, face = nil}
    inPlaceBackup[model] = rec

    -- 1) pindahkan tampilan lama ke cadangan (Tool & script TIDAK disentuh)
    for _, c in ipairs(model:GetChildren()) do
        if isAppearanceItem(c) and not c:GetAttribute("KA_Copy") then
            table.insert(rec.items, c)
            c.Parent = nil
        end
    end

    -- 1b) titik sambung aksesoris (HairAttachment, HatAttachment, dll) yang belum ada di karakter map
    for _, refPart in ipairs(ref:GetChildren()) do
        if refPart:IsA("BasePart") then
            local part = model:FindFirstChild(refPart.Name)
            if part and part:IsA("BasePart") then
                for _, a in ipairs(refPart:GetChildren()) do
                    if a:IsA("Attachment") and not part:FindFirstChild(a.Name) then
                        local na = a:Clone()
                        na:SetAttribute("KA_Copy", true)
                        na.Parent = part
                    end
                end
            end
        end
    end

    -- 2) salin pakaian, warna kulit, CharacterMesh, dan aksesoris dari target
    for _, c in ipairs(ref:GetChildren()) do
        if isAppearanceItem(c) then
            local cl = c:Clone()
            for _, d in ipairs(cl:GetDescendants()) do
                if d:IsA("LuaSourceContainer") then
                    d:Destroy()
                end
            end
            cl:SetAttribute("KA_Copy", true)

            if cl:IsA("Accessory") then
                attachAccessoryInPlace(model, cl)
            else
                cl.Parent = model
            end
        end
    end

    if isR15 then
        pcall(applyR15Body, model, ref, hum, rec)
    end

    -- 3) kepala: bentuk + wajah
    local head = model:FindFirstChild("Head")
    local refHead = ref:FindFirstChild("Head")
    if head and refHead then
        local refMesh = refHead:FindFirstChildOfClass("SpecialMesh")
        local curMesh = head:FindFirstChildOfClass("SpecialMesh")
        if refMesh then
            if curMesh then
                rec.headMesh = curMesh:Clone()
                curMesh:Destroy()
            end
            local cm = refMesh:Clone()
            cm:SetAttribute("KA_Copy", true)
            cm.Parent = head
        end

        local refFace = refHead:FindFirstChildWhichIsA("Decal")
        local curFace = head:FindFirstChildWhichIsA("Decal")
        if refFace then
            if curFace then
                rec.face = {decal = curFace, tex = curFace.Texture}
                curFace.Texture = refFace.Texture
            else
                local nf = refFace:Clone()
                nf:SetAttribute("KA_Copy", true)
                nf.Parent = head
            end
        end
    end

    -- 4) warna tiap part badan
    for _, name in ipairs(R6_PART_NAMES) do
        local part = model:FindFirstChild(name)
        local refPart = ref:FindFirstChild(name)
        if part and refPart and part:IsA("BasePart") and refPart:IsA("BasePart") then
            rec.colors[name] = part.Color
            part.Color = refPart.Color
        end
    end

    pcall(function()
        ref:Destroy()
    end)

    inPlaceUserId = userId
    log("Copy R6 di tempat selesai: " .. model:GetFullName() .. " | item lama dicadangkan: " .. tostring(#rec.items))
    return true, "tampilan berhasil disalin (karakter & isi map tidak diubah)"
end
local R15_BODY_SLOTS = {
    {prop = "Head", parts = {"Head"}},
    {prop = "Torso", parts = {"UpperTorso", "LowerTorso"}},
    {prop = "LeftArm", parts = {"LeftUpperArm", "LeftLowerArm", "LeftHand"}},
    {prop = "RightArm", parts = {"RightUpperArm", "RightLowerArm", "RightHand"}},
    {prop = "LeftLeg", parts = {"LeftUpperLeg", "LeftLowerLeg", "LeftFoot"}},
    {prop = "RightLeg", parts = {"RightUpperLeg", "RightLowerLeg", "RightFoot"}},
}

local R15_COLORS = {
    {prop = "HeadColor", parts = {"Head"}},
    {prop = "TorsoColor", parts = {"UpperTorso", "LowerTorso"}},
    {prop = "LeftArmColor", parts = {"LeftUpperArm", "LeftLowerArm", "LeftHand"}},
    {prop = "RightArmColor", parts = {"RightUpperArm", "RightLowerArm", "RightHand"}},
    {prop = "LeftLegColor", parts = {"LeftUpperLeg", "LeftLowerLeg", "LeftFoot"}},
    {prop = "RightLegColor", parts = {"RightUpperLeg", "RightLowerLeg", "RightFoot"}},
}

local R15_SCALE_PROPS = {"HeightScale", "WidthScale", "DepthScale", "HeadScale", "BodyTypeScale", "ProportionScale"}

buildR15Model = function(desc, rigType)
    -- rig bukan R15: pakai method biasa
    if rigType ~= Enum.HumanoidRigType.R15 then
        return Players:CreateHumanoidModelFromDescription(desc, rigType)
    end

    -- 1) model utama
    local model = nil
    local okA, resA = pcall(function()
        return Players:CreateHumanoidModelFromDescription(
            desc, Enum.HumanoidRigType.R15, Enum.AssetTypeVerification.Always)
    end)
    if okA and resA then
        model = resA
    else
        model = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15)
    end

    -- 2) cek ulang tiap slot body lewat model mini
    local fixed = 0
    for _, slot in ipairs(R15_BODY_SLOTS) do
        local id = 0
        pcall(function()
            id = desc[slot.prop]
        end)

        if type(id) == "number" and id > 0 then
            local okS, ref = pcall(function()
                local d = Instance.new("HumanoidDescription")
                d[slot.prop] = id
                return Players:CreateHumanoidModelFromDescription(d, Enum.HumanoidRigType.R15)
            end)

            if okS and ref then
                for _, name in ipairs(slot.parts) do
                    local part = model:FindFirstChild(name)
                    local refPart = ref:FindFirstChild(name)
                    if part and refPart and part:IsA("MeshPart") and refPart:IsA("MeshPart") then
                        if part.MeshId ~= refPart.MeshId then
                            pcall(function()
                                part.MeshId = refPart.MeshId
                            end)
                            fixed = fixed + 1
                            log("R15 body diperbaiki: " .. name .. " -> " .. tostring(refPart.MeshId))
                        end
                        if part.TextureID ~= refPart.TextureID then
                            pcall(function()
                                part.TextureID = refPart.TextureID
                            end)
                        end

                        -- SurfaceAppearance (tekstur body bundle Rthro/dll)
                        local refSA = refPart:FindFirstChildOfClass("SurfaceAppearance")
                        local curSA = part:FindFirstChildOfClass("SurfaceAppearance")
                        if refSA and (not curSA or curSA.ColorMap ~= refSA.ColorMap) then
                            if curSA then
                                curSA:Destroy()
                            end
                            refSA:Clone().Parent = part
                        end
                    end
                end
                pcall(function()
                    ref:Destroy()
                end)
            else
                warn("[clone] R15 slot " .. slot.prop .. " gagal dicek: " .. tostring(ref))
            end
        end
    end

    -- 3) paksa warna kulit
    for _, c in ipairs(R15_COLORS) do
        local color = nil
        pcall(function()
            color = desc[c.prop]
        end)
        if typeof(color) == "Color3" then
            for _, name in ipairs(c.parts) do
                local part = model:FindFirstChild(name)
                if part and part:IsA("BasePart") then
                    part.Color = color
                end
            end
        end
    end

    -- 4) bandingkan dengan GetAppliedDescription (hanya laporan ke console)
    local hum = model:FindFirstChildOfClass("Humanoid")
    if hum then
        local okG, applied = pcall(function()
            return hum:GetAppliedDescription()
        end)
        if okG and applied then
            for _, slot in ipairs(R15_BODY_SLOTS) do
                local a, b = nil, nil
                pcall(function()
                    a, b = applied[slot.prop], desc[slot.prop]
                end)
                if a ~= b then
                    log("R15 beda slot " .. slot.prop .. ": applied=" .. tostring(a) .. " target=" .. tostring(b))
                end
            end
            for _, p in ipairs(R15_SCALE_PROPS) do
                local a, b = nil, nil
                pcall(function()
                    a, b = applied[p], desc[p]
                end)
                if type(a) == "number" and type(b) == "number" and math.abs(a - b) > 0.01 then
                    log("R15 beda skala " .. p .. ": applied=" .. tostring(a) .. " target=" .. tostring(b))
                end
            end
        end
    end

    log("buildR15Model selesai | slot diperbaiki: " .. tostring(fixed))
    return model
end
-- ===== PENJAGA DATA GAME DI HumanoidRootPart (mis. "headpos" milik Evade) =====
-- Script map Evade membaca HumanoidRootPart.headpos tiap frame. Model avatar hasil copy
-- tidak punya itu, jadi error terus-menerus. Penjaga ini jalan tiap frame:
--   * karakter asli: ingat Attachment/Value/Folder yang ada di HumanoidRootPart-nya
--   * model hasil copy: kalau ada yang hilang, pasang lagi (dan "headpos" selalu dijamin ada)
local GameRoot = {template = {}, conn = nil, made = 0}

function GameRoot.snapshot(char)
    if not char or ours[char] or char == fake then
        return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return
    end
    for _, ch in ipairs(hrp:GetChildren()) do
        if GameRoot.template[ch.Name] == nil
        and (ch:IsA("Attachment") or ch:IsA("ValueBase") or ch:IsA("Folder") or ch:IsA("Configuration")) then
            local ok, cl = pcall(function()
                return ch:Clone()
            end)
            if ok and cl then
                GameRoot.template[ch.Name] = cl
            end
        end
    end
end

function GameRoot.ensure(char)
    if not char then
        return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp or not hrp:IsA("BasePart") then
        return
    end

    for name, tpl in pairs(GameRoot.template) do
        if not hrp:FindFirstChild(name) then
            local ok, cl = pcall(function()
                return tpl:Clone()
            end)
            if ok and cl then
                cl.Parent = hrp
            end
        end
    end

    if not hrp:FindFirstChild("headpos") then
        local a = Instance.new("Attachment")
        a.Name = "headpos"
        local head = char:FindFirstChild("Head")
        if head and head:IsA("BasePart") then
            a.Position = hrp.CFrame:PointToObjectSpace(head.Position)
        else
            a.Position = Vector3.new(0, 1.5, 0)
        end
        a.Parent = hrp
        GameRoot.made = GameRoot.made + 1
        if GameRoot.made <= 3 then
            log("headpos dibuat otomatis di " .. char:GetFullName())
        end
    end
end

pcall(GameRoot.snapshot, player.Character)
GameRoot.conn = RunService.Heartbeat:Connect(function()
    if not running then
        return
    end
    local c = player.Character
    if not c then
        return
    end
    if ours[c] or c == fake then
        pcall(GameRoot.ensure, c)
    else
        pcall(GameRoot.snapshot, c)
    end
end)
local function getUserId(target)
    -- link profil: https://www.roblox.com/users/123456/profile
    local fromLink = string.match(tostring(target), "users/(%d+)")
    if fromLink then
        return tonumber(fromLink)
    end

    if tonumber(target) then
        return tonumber(target)
    end

    local name = tostring(target):lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #name) == name
        or p.DisplayName:lower():sub(1, #name) == name then
            return p.UserId
        end
    end

    local ok, id = pcall(function()
        return Players:GetUserIdFromNameAsync(target)
    end)
    if ok then
        return id
    end
    return nil
end
local function setCamera(model)
    local cam = workspace.CurrentCamera
    local hum = model and model:FindFirstChildOfClass("Humanoid")
    if cam and hum then
        cam.CameraType = Enum.CameraType.Custom
        cam.CameraSubject = hum
    end
end

local function plainReplace(text, from, to)
    if from == nil or from == "" then
        return text
    end

    local out = ""
    local pos = 1
    while true do
        local a, b = string.find(text, from, pos, true)
        if not a then
            break
        end
        out = out .. string.sub(text, pos, a - 1) .. to
        pos = b + 1
    end
    return out .. string.sub(text, pos)
end

local function forEachLabel(gui, fn)
    for _, d in ipairs(gui:GetDescendants()) do
        if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
            fn(d)
        end
    end
end

-- Semua BillboardGui di sebuah karakter + yang sudah kita pantau
local function collectGuis(character)
    local guis = {}
    if character then
        for _, d in ipairs(character:GetDescendants()) do
            if d:IsA("BillboardGui") then
                guis[d] = true
            end
        end
    end
    for g in pairs(trackedGuis) do
        if g.Parent ~= nil then
            guis[g] = true
        else
            trackedGuis[g] = nil
        end
    end
    return guis
end

-- Ganti nama aslimu di teks nametag dengan display name palsu
local function applyBillboardNames(character)
    if not customName then
        return
    end

    local names = {}
    local seen = {}
    local function add(n)
        if n and n ~= "" and not seen[n] and n ~= customName then
            seen[n] = true
            table.insert(names, n)
        end
    end
    add(player.DisplayName)
    add(player.Name)
    table.sort(names, function(a, b)
        return #a > #b
    end)

    local guis = collectGuis(character)
    for gui in pairs(guis) do
        forEachLabel(gui, function(label)
            local text = label.Text
            local newText = text

            if prevCustomName and prevCustomName ~= customName
            and string.find(text, prevCustomName, 1, true) then
                newText = plainReplace(text, prevCustomName, customName)
            elseif not string.find(text, customName, 1, true) then
                for _, n in ipairs(names) do
                    newText = plainReplace(newText, n, customName)
                end
            end

            if newText ~= text then
                label.Text = newText
            end
        end)
    end
end

-- Kembalikan teks nametag dari display name palsu ke display name asli
local function restoreBillboardNames(character, oldName)
    if not oldName then
        return
    end

    local guis = collectGuis(character)
    for gui in pairs(guis) do
        forEachLabel(gui, function(label)
            local newText = plainReplace(label.Text, oldName, player.DisplayName)
            if newText ~= label.Text then
                label.Text = newText
            end
        end)
    end
end

-- Nametag buatan game menempel di karakter asli (yang kita sembunyikan).
-- Salin ke model avatar baru supaya nametag tetap muncul di atas kepala.
local function transferNametags(fromChar, toChar)
    local count = 0
    if not fromChar or not toChar then
        return count
    end

    for _, d in ipairs(fromChar:GetDescendants()) do
        if d:IsA("BillboardGui") then
            local parent = d.Parent
            local target = nil

            if parent == fromChar then
                target = toChar
            elseif parent and parent:IsA("BasePart") then
                target = toChar:FindFirstChild(parent.Name, true)
            end

            if target and not target:FindFirstChild(d.Name) then
                local c = d:Clone()
                if d.Adornee then
                    c.Adornee = toChar:FindFirstChild(d.Adornee.Name, true)
                elseif target == toChar then
                    c.Adornee = toChar:FindFirstChild("Head", true)
                end
                c.Parent = target
                trackedGuis[c] = true
                count = count + 1
            end
        end
    end

    return count
end

-- Nametag yang disimpan di tempat lain (workspace/PlayerGui) tapi menempel
-- ke karakter asli lewat Adornee: arahkan ke model avatar baru.
local function retargetExternalNametags(fromChar, toChar)
    local count = 0
    if not fromChar or not toChar then
        return count
    end

    local roots = {workspace, player:FindFirstChildOfClass("PlayerGui")}
    local checked = 0

    for _, root in ipairs(roots) do
        for _, d in ipairs(root:GetDescendants()) do
            checked = checked + 1
            if checked % 3000 == 0 then
                task.wait()
            end

            if d:IsA("BillboardGui") and not d:IsDescendantOf(toChar) then
                local adornee = d.Adornee
                if adornee and adornee:IsDescendantOf(fromChar) then
                    local counterpart = toChar:FindFirstChild(adornee.Name, true)
                    if counterpart then
                        d.Adornee = counterpart
                        trackedGuis[d] = true
                        count = count + 1
                    end
                end
            end
        end
    end

    return count
end

local function copyHumanoidProps(from, to)
    pcall(function()
        to.WalkSpeed = from.WalkSpeed
        to.UseJumpPower = from.UseJumpPower
        to.JumpPower = from.JumpPower
        to.JumpHeight = from.JumpHeight
        to.MaxHealth = from.MaxHealth
        to.Health = from.Health
        to.DisplayName = from.DisplayName
        to.AutoRotate = from.AutoRotate
    end)

    -- cara nama/darah ditampilkan (game yang pakai nametag sendiri biasanya mematikan bawaan Roblox)
    pcall(function()
        to.DisplayDistanceType = from.DisplayDistanceType
        to.NameDisplayDistance = from.NameDisplayDistance
        to.HealthDisplayType = from.HealthDisplayType
        to.HealthDisplayDistance = from.HealthDisplayDistance
    end)
end

-- ===== TARGET TAMPILAN KARAKTER =====
-- Beberapa game (mis. Evade) menaruh karakter di folder khusus (workspace.Game.Players)
-- atau memakai model tampilan terpisah dari player.Character. Supaya Headless, Korblox,
-- aksesoris, dan Copy Avatar tetap kena, efeknya dipasang ke SEMUA model milik kita:
--   1) player.Character
--   2) model yang sedang diikuti kamera (kalau dekat dengan karakter kita)
--   3) model bernama sama dengan username/display name kita di workspace (sampai 3 tingkat folder)
local extraTargets = {}
local lastTargetScan = -10
local pinnedTarget = nil -- model tampilan yang ditemukan lewat fallback Humanoid (copy avatar)

local function rootPos(model)
    local r = model and model:FindFirstChild("HumanoidRootPart")
    if r and r:IsA("BasePart") then
        return r.Position
    end
    return nil
end

local function scanExtraTargets()
    local list = {}
    local seen = {}
    local mine = player.Character

    local function consider(m)
        if m and m:IsA("Model") and m ~= mine and not seen[m] and m.Parent ~= nil then
            seen[m] = true
            table.insert(list, m)
        end
    end

    if pinnedTarget then
        if pinnedTarget.Parent ~= nil then
            consider(pinnedTarget)
        else
            pinnedTarget = nil
        end
    end

    -- model yang diikuti kamera, hanya kalau posisinya dekat karakter kita
    -- (supaya tidak ikut mengubah pemain lain saat spectate)
    local cam = workspace.CurrentCamera
    local subject = cam and cam.CameraSubject
    if subject then
        local m = nil
        if subject:IsA("Humanoid") then
            m = subject.Parent
        elseif subject:IsA("BasePart") then
            m = subject:FindFirstAncestorOfClass("Model")
        end
        if m then
            if mine then
                local a, b = rootPos(m), rootPos(mine)
                if a and b and (a - b).Magnitude < 25 then
                    consider(m)
                end
            else
                -- player.Character kosong (game yang menaruh karakter di tempat lain):
                -- percaya model kamera selama bukan milik pemain lain
                local owner = Players:GetPlayerFromCharacter(m)
                if owner == nil or owner == player then
                    consider(m)
                end
            end
        end
    end

    -- model bernama sama dengan kita (cari di workspace & folder-foldernya)
    local function scan(parent, depth)
        for _, c in ipairs(parent:GetChildren()) do
            if c:IsA("Model") and (c.Name == player.Name or c.Name == player.DisplayName)
            and c:FindFirstChild("Head") then
                consider(c)
            end
            if depth < 3 and (c:IsA("Folder") or c:IsA("Model")) then
                scan(c, depth + 1)
            end
        end
    end
    scan(workspace, 1)

    extraTargets = list
end

local function visualTargets()
    local out = {}
    local mine = player.Character
    if mine then
        table.insert(out, mine)
    end
    for _, m in ipairs(extraTargets) do
        if m.Parent ~= nil and m ~= mine then
            table.insert(out, m)
        end
    end
    return out
end

-- ===== ANIMASI (dikontrol script sendiri, tanpa script Animate) =====
-- ID bawaan Roblox (dipakai kalau animasi target/game tidak bisa dimuat)
local DEFAULT_ANIMS_R15 = {
    idle = "rbxassetid://507766666",
    walk = "rbxassetid://507777826",
    run = "rbxassetid://507767714",
    jump = "rbxassetid://507765000",
    fall = "rbxassetid://507767968",
    climb = "rbxassetid://507765644",
    swim = "rbxassetid://507784897",
    swimidle = "rbxassetid://507785072",
    sit = "rbxassetid://2506281703",
}
local DEFAULT_ANIMS_R6 = {
    idle = "rbxassetid://180435571",
    walk = "rbxassetid://180426354",
    run = "rbxassetid://180426354",
    jump = "rbxassetid://125750702",
    fall = "rbxassetid://180436148",
    climb = "rbxassetid://180436334",
    sit = "rbxassetid://178130996",
}

-- name: nama internal | field: properti di HumanoidDescription (hanya R15)
-- folder/anim: lokasi Animation di script Animate milik game (cadangan)
local ANIM_SOURCES = {
    {name = "idle", field = "IdleAnimation", folder = "idle", anim = "Animation1", loop = true},
    {name = "walk", field = "WalkAnimation", folder = "walk", anim = "WalkAnim", loop = true},
    {name = "run", field = "RunAnimation", folder = "run", anim = "RunAnim", loop = true},
    {name = "jump", field = "JumpAnimation", folder = "jump", anim = "JumpAnim", loop = false},
    {name = "fall", field = "FallAnimation", folder = "fall", anim = "FallAnim", loop = true},
    {name = "climb", field = "ClimbAnimation", folder = "climb", anim = "ClimbAnim", loop = true},
    {name = "swim", field = "SwimAnimation", folder = "swim", anim = "Swim", loop = true},
    {name = "swimidle", field = "SwimAnimation", folder = "swimidle", anim = "SwimIdle", loop = true, strict = true},
    {name = "sit", field = nil, folder = "sit", anim = "SitAnim", loop = true},
}

-- Asset animasi di avatar bukan animasi langsung, tapi paket berisi objek Animation
-- (seperti struktur script Animate). ID animasi aslinya ada di dalam paket itu.
local assetCache = {}

local function readAnimationAsset(assetId)
    if assetCache[assetId] ~= nil then
        return assetCache[assetId]
    end

    local list = {}
    local roots = nil

    local ok, objs = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(assetId))
    end)
    if ok and type(objs) == "table" then
        roots = objs
    else
        local ok2, model = pcall(function()
            return game:GetService("InsertService"):LoadAsset(assetId)
        end)
        if ok2 and model then
            roots = {model}
        end
    end

    if roots then
        for _, obj in ipairs(roots) do
            if obj:IsA("Animation") and obj.AnimationId ~= "" then
                table.insert(list, {name = obj.Name, id = obj.AnimationId})
            end
            for _, d in ipairs(obj:GetDescendants()) do
                if d:IsA("Animation") and d.AnimationId ~= "" then
                    table.insert(list, {name = d.Name, id = d.AnimationId})
                end
            end
            pcall(function()
                obj:Destroy()
            end)
        end
    else
        warn("[clone] Gagal membaca asset animasi " .. tostring(assetId) .. " (GetObjects/LoadAsset tidak tersedia di executor ini)")
    end

    assetCache[assetId] = list
    return list
end

local function pickFromAsset(list, animName, strict)
    for _, a in ipairs(list) do
        if a.name == animName then
            return a.id
        end
    end
    if not strict and #list == 1 then
        return list[1].id
    end
    return nil
end

-- false = animasi target TIDAK dipakai (clone pakai animasi game / bawaan Roblox)
local ANIM_PAKAI_TARGET = false
local function getCandidates(info, desc, srcAnimate, defaults, isR15)
    local list = {}

    local function add(id, label)
        if not id or id == "" or id == "rbxassetid://0" then
            return
        end
        for _, v in ipairs(list) do
            if v.id == id then
                return
            end
        end
        table.insert(list, {id = id, label = label})
    end

    -- 1) animasi milik avatar target
    if ANIM_PAKAI_TARGET and isR15 and info.field then
        local ok, value = pcall(function()
            return desc[info.field]
        end)
        if ok and type(value) == "number" and value > 0 then
            local assetList = readAnimationAsset(value)
            local fromAsset = pickFromAsset(assetList, info.anim, info.strict)
            if fromAsset then
                add(fromAsset, "target (isi asset " .. tostring(value) .. ")")
            end
            add("rbxassetid://" .. tostring(value), "target (langsung " .. tostring(value) .. ")")
        else
            log("Avatar target tidak punya animasi khusus untuk: " .. info.name)
        end
    end

    -- 2) animasi dari script Animate karakter asli (animasi game)
    if srcAnimate then
        local folder = srcAnimate:FindFirstChild(info.folder)
        local anim = folder and folder:FindFirstChild(info.anim)
        if anim and anim:IsA("Animation") then
            add(anim.AnimationId, "animasi game")
        end
    end

    -- 3) animasi bawaan Roblox
    add(defaults[info.name], "bawaan Roblox")

    return list
end

-- Coba tiap kandidat sampai ada yang benar-benar termuat (Length > 0)
local function loadTrack(animator, candidates)
    for _, cand in ipairs(candidates) do
        local anim = Instance.new("Animation")
        anim.AnimationId = cand.id

        local okLoad, track = pcall(function()
            return animator:LoadAnimation(anim)
        end)

        if okLoad and track then
            pcall(function()
                ContentProvider:PreloadAsync({anim})
            end)

            local waited = 0
            while track.Length == 0 and waited < 1.5 do
                task.wait(0.1)
                waited = waited + 0.1
            end

            if track.Length > 0 then
                return track, cand.id, cand.label
            end

            pcall(function()
                track:Destroy()
            end)
        end

        anim:Destroy()
    end
    return nil, nil, nil
end

-- Ambang kecepatan (studs/detik) untuk animasi lari.
-- Jalan biasa Roblox = 16. Lari dipakai kalau kecepatan di atas RUN_SPEED_ENTER
-- dan kembali ke jalan kalau turun di bawah RUN_SPEED_EXIT.
-- Kalau di game-mu lari terlalu cepat/lambat berubah, ubah dua angka ini.
local RUN_SPEED_ENTER = 20
local RUN_SPEED_EXIT = 17
local WALK_ANIM_BASE = 16 -- kecepatan di mana animasi jalan diputar normal (1x)
local RUN_ANIM_BASE = 24  -- kecepatan di mana animasi lari diputar normal (1x)

-- Pemutar animasi: meniru logika script Animate bawaan Roblox
-- (kecepatan dari event Humanoid.Running, jeda sebelum animasi jatuh,
-- hysteresis idle/walk, dan kecepatan animasi dihaluskan supaya tidak patah-patah)
local function startAnimDriver(model, hum, root, tracks)
    local current = nil
    local conn = nil
    local runConn = nil
    local jumpConn = nil

    local groundSpeed = 0
    local freefallTime = 0
    local jumpTimer = 0
    local useRun = false
    local lastMode = nil
    local warnedRun = false
    local smooth = 1

    local function stopAll()
        for _, t in pairs(tracks) do
            if t.IsPlaying then
                t:Stop(0.1)
            end
        end
        current = nil
    end

    local function cleanup()
        if conn then
            conn:Disconnect()
        end
        if runConn then
            runConn:Disconnect()
        end
        if jumpConn then
            jumpConn:Disconnect()
        end
        stopAll()
    end

    local function play(name, speed)
        local t = tracks[name]
        if not t then
            return
        end
        if current ~= name then
            local prev = current and tracks[current]
            if prev and prev.IsPlaying then
                prev:Stop(0.2)
            end
            t:Play(0.2)
            current = name
        end
        local spd = speed or 1
        if math.abs(t.Speed - spd) > 0.02 then
            t:AdjustSpeed(spd)
        end
    end

    runConn = hum.Running:Connect(function(speed)
        groundSpeed = speed
    end)

    jumpConn = hum.Jumping:Connect(function(active)
        if active then
            jumpTimer = 0.31
        end
    end)

    conn = RunService.Heartbeat:Connect(function(dt)
        if not running or model.Parent == nil or hum.Parent ~= model then
            cleanup()
            return
        end

        if hum.Health <= 0 then
            stopAll()
            return
        end

        local state = hum:GetState()
        local vel = root.AssemblyLinearVelocity
        local hspeed = Vector3.new(vel.X, 0, vel.Z).Magnitude

        if state == Enum.HumanoidStateType.Freefall then
            freefallTime = freefallTime + dt
        else
            freefallTime = 0
        end
        if jumpTimer > 0 then
            jumpTimer = jumpTimer - dt
        end

        if hum.Sit or state == Enum.HumanoidStateType.Seated then
            if tracks.sit then
                play("sit", 1)
            else
                play("idle", 1)
            end
        elseif state == Enum.HumanoidStateType.Climbing then
            play("climb", math.abs(vel.Y) / 5)
        elseif state == Enum.HumanoidStateType.Swimming then
            if hspeed > 1 then
                play("swim", hspeed / 10)
            elseif tracks.swimidle then
                play("swimidle", 1)
            else
                play("swim", 0)
            end
        elseif jumpTimer > 0 then
            play("jump", 1)
        elseif state == Enum.HumanoidStateType.Freefall and freefallTime > 0.2 then
            -- animasi jatuh baru dimulai setelah 0.2 detik (hindari kedip di tanah tidak rata)
            play("fall", 1)
        else
            -- di tanah, atau melayang sebentar (< 0.2 detik)
            local speed = groundSpeed
            if speed < 0.1 and hum.MoveDirection.Magnitude > 0.1 and hspeed > 1 then
                speed = hspeed
            end

            local threshold = 0.75
            if current == "walk" or current == "run" then
                threshold = 0.4
            end

            if speed > threshold then
                if useRun then
                    if speed < RUN_SPEED_EXIT then
                        useRun = false
                    end
                else
                    if speed > RUN_SPEED_ENTER then
                        useRun = true
                    end
                end

                if useRun and not tracks.run and not warnedRun then
                    warnedRun = true
                    warn("[clone] Animasi run tidak termuat, memakai animasi walk")
                end

                local mode = "walk"
                local target = speed / WALK_ANIM_BASE
                if useRun and tracks.run then
                    mode = "run"
                    target = speed / RUN_ANIM_BASE
                end

                -- ganti walk <-> run: langsung ke kecepatan baru, lalu haluskan
                if mode ~= lastMode then
                    smooth = target
                    lastMode = mode
                end

                local alpha = math.clamp(dt * 12, 0, 1)
                smooth = smooth + (target - smooth) * alpha
                play(mode, smooth)
            else
                smooth = 1
                lastMode = nil
                play("idle", 1)
            end
        end
    end)
end

local function setupAnimations(model, hum, root, desc, source, isR15)
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = hum
    end

    local srcAnimate = source and source:FindFirstChild("Animate")
    local defaults = DEFAULT_ANIMS_R6
    if isR15 then
        defaults = DEFAULT_ANIMS_R15
    end

    local tracks = {}
    startAnimDriver(model, hum, root, tracks)

    pcall(function()
        log("Animasi target (tidak dipakai) -> idle=" .. tostring(desc.IdleAnimation)
            .. " walk=" .. tostring(desc.WalkAnimation)
            .. " run=" .. tostring(desc.RunAnimation)
            .. " jump=" .. tostring(desc.JumpAnimation)
            .. " fall=" .. tostring(desc.FallAnimation)
            .. " climb=" .. tostring(desc.ClimbAnimation)
            .. " swim=" .. tostring(desc.SwimAnimation))
    end)

    for _, info in ipairs(ANIM_SOURCES) do
        if model.Parent == nil then
            return
        end

        local candidates = getCandidates(info, desc, srcAnimate, defaults, isR15)
        local track, usedId, label = loadTrack(animator, candidates)
        if track then
            track.Looped = info.loop
            tracks[info.name] = track
            log("Animasi " .. info.name .. " dimuat [" .. tostring(label) .. "]: " .. tostring(usedId))
        else
            warn("[clone] Animasi " .. info.name .. " gagal dimuat")
        end
    end

    log("Semua animasi selesai diproses")
end

-- ===== COPY AVATAR (tukar karakter dengan model avatar target) =====
-- Tipe rig (R6/R15) dibaca dari bentuk badan kalau Humanoid tidak ditemukan
local function detectRig(model)
    local hum = model:FindFirstChildOfClass("Humanoid") or model:FindFirstChildWhichIsA("Humanoid", true)
    if hum then
        return hum.RigType, hum
    end
    if model:FindFirstChild("UpperTorso") or model:FindFirstChild("RightUpperLeg") then
        return Enum.HumanoidRigType.R15, nil
    end
    if model:FindFirstChild("Torso") then
        return Enum.HumanoidRigType.R6, nil
    end
    return nil, nil
end

-- Cari karakter sumber + Humanoid-nya. Urutan: player.Character, Humanoid yang diikuti kamera,
-- model bernama sama dengan kita (mis. di workspace.Game.Players milik Evade), lalu model
-- tanpa Humanoid yang tipe rig-nya dibaca dari bentuk badan.
-- Return: model, humanoid (boleh nil), rigType
local function findSourceCharacter()
    local mine = player.Character

    -- 1) player.Character (Humanoid langsung atau lebih dalam)
    if mine then
        local hum = mine:FindFirstChildOfClass("Humanoid") or mine:FindFirstChildWhichIsA("Humanoid", true)
        if hum then
            return mine, hum, hum.RigType
        end
    end

    -- 2) Humanoid yang diikuti kamera (bukan milik pemain lain)
    local cam = workspace.CurrentCamera
    local subject = cam and cam.CameraSubject
    if subject and subject:IsA("Humanoid") and subject.Parent then
        local owner = Players:GetPlayerFromCharacter(subject.Parent)
        if owner == nil or owner == player then
            return subject.Parent, subject, subject.RigType
        end
    end

    -- 3) model bernama sama dengan kita
    pcall(scanExtraTargets)
    for _, t in ipairs(extraTargets) do
        local hum = t:FindFirstChildOfClass("Humanoid") or t:FindFirstChildWhichIsA("Humanoid", true)
        if hum then
            return t, hum, hum.RigType
        end
    end

    -- 4) tanpa Humanoid: tipe rig dari bentuk badan
    local candidates = {}
    if mine then
        table.insert(candidates, mine)
    end
    for _, t in ipairs(extraTargets) do
        table.insert(candidates, t)
    end
    for _, t in ipairs(candidates) do
        local r = detectRig(t)
        if r then
            return t, nil, r
        end
    end

    return nil, nil, nil
end

-- Emote akun sendiri (diambil sekali lalu disimpan)
local function loadOwnEmotes()
    if ownEmoteData then
        return ownEmoteData
    end

    local data = {emotes = {}, equipped = {}}
    local d = getDescription(player.UserId)
    if d then
        pcall(function()
            data.emotes = d:GetEmotes()
        end)
        pcall(function()
            data.equipped = d:GetEquippedEmotes()
        end)
    end
    ownEmoteData = data
    return data
end

-- Game seperti Evade menaruh data buatan sendiri di karakter asli (mis. Attachment/Value
-- "headpos" di HumanoidRootPart yang dibaca script map untuk cek air & soundscape).
-- Model avatar baru tidak punya itu, jadi script map error. Di sini semua Attachment,
-- Value, Folder, Configuration, dan Attribute milik game disalin ke model baru.
local function transferGameParts(fromChar, toChar)
    local copied = {}
    if not fromChar or not toChar then
        return copied
    end

    local function allowed(c)
        if c:IsA("JointInstance") or c:IsA("DataModelMesh") or c:IsA("Decal") or c:IsA("Texture")
        or c:IsA("SurfaceAppearance") or c:IsA("LuaSourceContainer") or c:IsA("BillboardGui")
        or c:IsA("Constraint") or c:IsA("BodyMover") or c:IsA("Tool") or c:IsA("Accessory")
        or c:IsA("Clothing") or c:IsA("ShirtGraphic") or c:IsA("CharacterMesh") or c:IsA("BodyColors")
        or c:IsA("Humanoid") or c:IsA("Animator") or c:IsA("ForceField") then
            return false
        end
        return true
    end

    local function copyAttrs(a, b)
        for k, v in pairs(a:GetAttributes()) do
            if string.sub(k, 1, 3) ~= "KA_" and b:GetAttribute(k) == nil then
                pcall(function()
                    b:SetAttribute(k, v)
                end)
            end
        end
    end

    local function cloneInto(child, parent, label, origRef, twinRef)
        local ok, cl = pcall(function()
            return child:Clone()
        end)
        if not ok or not cl then
            return
        end

        for _, d in ipairs(cl:GetDescendants()) do
            if d:IsA("LuaSourceContainer") then
                d:Destroy()
            end
        end

        local weldIt = false
        if cl:IsA("BasePart") and child:IsA("BasePart") and origRef and twinRef then
            cl.Anchored = false
            cl.CanCollide = false
            cl.CanTouch = false
            cl.CanQuery = false
            cl.Massless = true
            cl.CFrame = twinRef.CFrame * origRef.CFrame:ToObjectSpace(child.CFrame)
            weldIt = true
        end

        cl.Parent = parent
        if weldIt then
            local w = Instance.new("WeldConstraint")
            w.Part0 = twinRef
            w.Part1 = cl
            w.Parent = cl
        end
        table.insert(copied, label .. " (" .. cl.ClassName .. ")")
    end

    copyAttrs(fromChar, toChar)

    -- laporan: isi karakter asli (supaya kelihatan apa saja yang dicari script map)
    do
        local rootNames = {}
        for _, ch in ipairs(fromChar:GetChildren()) do
            table.insert(rootNames, ch.Name .. "<" .. ch.ClassName .. ">")
        end
        log("Isi karakter asli (" .. fromChar:GetFullName() .. "): " .. table.concat(rootNames, ", "))

        local fromHrp0 = fromChar:FindFirstChild("HumanoidRootPart")
        if fromHrp0 then
            local hn = {}
            for _, ch in ipairs(fromHrp0:GetChildren()) do
                table.insert(hn, ch.Name .. "<" .. ch.ClassName .. ">")
            end
            log("Isi HumanoidRootPart asli: " .. table.concat(hn, ", "))
        end
    end

    local fromRoot = fromChar:FindFirstChild("HumanoidRootPart")
    local toRoot = toChar:FindFirstChild("HumanoidRootPart")

    for _, c in ipairs(fromChar:GetChildren()) do
        if c:IsA("BasePart") then
            local twin = toChar:FindFirstChild(c.Name)
            if twin and twin:IsA("BasePart") then
                copyAttrs(c, twin)
                for _, child in ipairs(c:GetChildren()) do
                    if allowed(child) and not twin:FindFirstChild(child.Name) then
                        cloneInto(child, twin, c.Name .. "." .. child.Name, c, twin)
                    end
                end
            end
        elseif c:IsA("Humanoid") then
            local th = toChar:FindFirstChildOfClass("Humanoid")
            if th then
                copyAttrs(c, th)
            end
        elseif allowed(c) and not toChar:FindFirstChild(c.Name) then
            cloneInto(c, toChar, c.Name, fromRoot, toRoot)
        end
    end

    -- cadangan: Evade membaca "headpos" di HumanoidRootPart (cek air / soundscape).
    -- Kalau setelah semua disalin masih belum ada, buat Attachment di posisi kepala.
    if toRoot and not toRoot:FindFirstChild("headpos") then
        local a = Instance.new("Attachment")
        a.Name = "headpos"
        local head = toChar:FindFirstChild("Head")
        if head and head:IsA("BasePart") then
            a.Position = toRoot.CFrame:PointToObjectSpace(head.Position)
        else
            a.Position = Vector3.new(0, 1.5, 0)
        end
        a.Parent = toRoot
        table.insert(copied, "HumanoidRootPart.headpos (dibuat otomatis)")
    end

    return copied
end

local function copyAvatarInner(userId, builder, descOverride)
    -- Di lobby game (mis. Evade) player.Character = nil dan game memakai rig terpisah.
    -- Mengisi player.Character di sini membuat script map error terus & UI game ter-reset.
    if not player.Character then
        return false, "Belum ada karakter game (lobby). Masuk ke round dulu, atau pakai rig lobby (R6/R15 di tempat)"
    end
    local found, srcHum, rigType
    if real then
        -- sudah pernah di-copy: karakter asli yang disimpan jadi acuan
        local h = real:FindFirstChildOfClass("Humanoid") or real:FindFirstChildWhichIsA("Humanoid", true)
        if h then
            found, srcHum, rigType = real, h, h.RigType
        end
    end
    if not found then
        found, srcHum, rigType = findSourceCharacter()
    end

    local current = found
    if real and player.Character then
        current = player.Character -- model yang sedang dipakai (posisi terbarunya jadi acuan)
    end
    local source = real or current
    if not current or not rigType then
        return false, "Karakter/Humanoid tidak ditemukan"
    end
    if srcHum and srcHum.Health <= 0 then
        return false, "Karakter sedang mati, tunggu respawn"
    end

    local desc, descErr
    if descOverride then desc = descOverride else desc, descErr = getDescription(userId) end
    if not desc then
        return false, "Gagal ambil data avatar: " .. tostring(descErr)
    end

    local isR15 = rigType == Enum.HumanoidRigType.R15

    -- R15: model baru dibuat dengan EMOTE MILIKMU (bukan emote target), supaya menu emote
    -- Roblox / emote yang kamu punya tetap bisa dipakai setelah copy
    local buildDesc = desc
    if isR15 then
        local data = loadOwnEmotes()
        lastEmotes = data.emotes
        local okC, cloned = pcall(function()
            local x = desc:Clone()
            x:SetEmotes(data.emotes)
            x:SetEquippedEmotes(data.equipped)
            return x
        end)
        if okC and cloned then
            buildDesc = cloned
        end
    end

    -- Roblox membuat model avatar lengkap (body, rambut, aksesori, pakaian, skala)
    local okM, model = pcall(function()
        if builder then
            return builder(buildDesc, rigType)
        end
        return Players:CreateHumanoidModelFromDescription(buildDesc, rigType)
    end)
    if not okM or not model then
        return false, "Gagal buat model avatar: " .. tostring(model)
    end

    local newHum = model:FindFirstChildOfClass("Humanoid")
    local newRoot = model:FindFirstChild("HumanoidRootPart")
    if not newHum or not newRoot then
        model:Destroy()
        return false, "Model avatar tidak lengkap (tanpa Humanoid/RootPart)"
    end

    ours[model] = true
    model.PrimaryPart = newRoot
    model.Name = player.Name
    if srcHum then
        copyHumanoidProps(srcHum, newHum)
    end
    do
        local okT, listT = pcall(transferGameParts, source, model)
        if okT then
            log("Data game disalin ke model baru: " .. (#listT > 0 and table.concat(listT, ", ") or "tidak ada"))
        else
            warn("[clone] Gagal menyalin data game: " .. tostring(listT))
        end
    end
    pcall(function()
        model:PivotTo(current:GetPivot() * CFrame.new(0, 2, 0))
    end)

    -- bersihkan efek toggle di karakter asli sebelum disembunyikan
    if real == nil then
        pcall(restoreToggleEffects, current)
    end

    local oldFake = fake
    fake = model
    if real == nil then
        real = current
    end

    pcall(GameRoot.ensure, model)
    model.Parent = workspace
    player.Character = model
    lastUserId = userId
    lastBuilder = builder

    -- sembunyikan karakter asli (hanya di sisi kita, server tidak berubah)
    if real and real.Parent ~= nil then
        real.Parent = nil
    end
    if oldFake then
        oldFake:Destroy()
    end

    -- animasi: dikontrol script ini sendiri (tidak memakai script Animate)
    task.spawn(function()
        setupAnimations(model, newHum, newRoot, desc, source, isR15)
    end)

    -- emote (R15): menu emote Roblox + emote milik map ikut jalan di model baru
    if isR15 and setupEmoteSupport then
        pcall(setupEmoteSupport, model, newHum, source)
    end

    -- nametag buatan game (BillboardGui): salin/arahkan ke model baru
    task.spawn(function()
        task.wait(0.5)
        local moved = 0
        local retargeted = 0
        pcall(function()
            moved = transferNametags(source, model)
        end)
        pcall(function()
            retargeted = retargetExternalNametags(source, model)
        end)
        log("Nametag game: disalin=" .. tostring(moved) .. ", diarahkan=" .. tostring(retargeted))
    end)

    task.wait()
    setCamera(model)
    task.delay(0.5, function()
        setCamera(model)
    end)

    return true, "avatar berhasil ditukar"
end

local function copyAvatar(userId, builder, descOverride)
    if copying then
        return false, "Copy sedang berjalan, tunggu sebentar"
    end

    copying = true
    local ok, a, b = pcall(copyAvatarInner, userId, builder, descOverride)
    copying = false

    if not ok then
        return false, "Error: " .. tostring(a)
    end
    return a, b
end
local function handleCopy(targetRaw)
    local target = string.match(tostring(targetRaw or ""), "^%s*(.-)%s*$")

    if target == nil or target == "" then
        return false, "isi username dulu"
    end

    local userId = getUserId(target)
    if not userId then
        return false, "player tidak ditemukan (pakai link profil, UserId, atau username persis)"
    end

    turnOffToggles()
    notify("Copy Avatar", "Mengambil avatar " .. tostring(userId) .. "...")

    -- R6: ubah tampilan di tempat (karakter, Tool, dan animasi map tetap utuh)
    -- R15 / karakter yang sudah ditukar: pakai method tukar model seperti sebelumnya
    local srcModel, srcHumFound, srcRig = findSourceCharacter()
    local ok, info
    -- R6: selalu di tempat. R15: di tempat kalau modelnya BUKAN player.Character
    -- (mis. rig lobby Evade di Workspace.Rigs). Tukar model hanya untuk karakter R15 game asli.
    local inPlaceOk = srcModel ~= nil and srcHumFound ~= nil and not fake and not real
        and (srcRig == Enum.HumanoidRigType.R6
            or (srcRig == Enum.HumanoidRigType.R15 and srcModel ~= player.Character))
    if inPlaceOk then
        if copying then
            ok, info = false, "Copy sedang berjalan, tunggu sebentar"
        else
            copying = true
            local okP, a, b = pcall(applyAppearanceInPlace, srcModel, userId)
            copying = false
            if okP then
                ok, info = a, b
            else
                ok, info = false, "Error: " .. tostring(a)
            end
        end
    else
        -- R15: pakai method khusus R15 (bangun body per slot + paksa warna)
        local builder = nil
        if srcRig == Enum.HumanoidRigType.R15 then
            builder = buildR15Model
        end
        ok, info = copyAvatar(userId, builder)
    end

    if ok then
        notify("Berhasil", "Avatar " .. tostring(userId) .. ": " .. info)
    else
        notify("Gagal", info)
        warn("[clone] Copy gagal: " .. tostring(info))
    end
    return ok, info
end

local function resetAvatar()
    turnOffToggles()
    local restoredInPlace = resetInPlace()
    if stopEmoteSupport then
        pcall(stopEmoteSupport)
    end

    if fake and real then
        local oldFake = fake
        local oldReal = real
        local cf = oldFake:GetPivot()

        fake = nil
        real = nil
        lastUserId = nil

        pcall(function()
            oldReal:PivotTo(cf * CFrame.new(0, 2, 0))
        end)
        oldReal.Parent = workspace
        player.Character = oldReal
        setCamera(oldReal)
        oldFake:Destroy()
        return true, "karakter asli dikembalikan"
    end

    restoreToggleEffects(player.Character)
    if restoredInPlace then
        return true, "tampilan asli dikembalikan"
    end
    return true, "efek Headless/Korblox dibersihkan"
end

-- Respawn dari server: bersihkan hasil copy lama, lalu terapkan ulang otomatis
-- (dengan penjaga supaya tidak pernah looping)
local charConn = player.CharacterAdded:Connect(function(char)
    if not running then
        return
    end

    -- karakter buatan kita sendiri / karakter asli yang kita simpan: abaikan
    if ours[char] or char == fake or char == real then
        return
    end

    log("Karakter baru dari server: " .. tostring(char.Name))
    task.spawn(function()
        char:WaitForChild("Humanoid", 10)
        task.wait(0.5)
        nametagApply(char, S.nametagHide == true)
    end)

    -- mode copy R6 di tempat: karakter baru dari server -> terapkan ulang tampilan di karakter itu
    if inPlaceUserId and not fake then
        inPlaceBackup = {} -- karakter lama sudah hilang, cadangannya tidak berlaku lagi

        if not autoApply then
            inPlaceUserId = nil
            log("Auto Apply mati, tampilan target tidak diterapkan ulang")
            return
        end

        if reapplyBusy or copying then
            log("Auto-apply sedang berjalan, event respawn ini diabaikan")
            return
        end

        local uid = inPlaceUserId
        reapplyBusy = true
        task.spawn(function()
            pcall(function()
                char:WaitForChild("Humanoid", 10)
                char:WaitForChild("HumanoidRootPart", 10)
            end)
            task.wait(1.5)

            if running and player.Character == char then
                local ok, info = applyAppearanceInPlace(char, uid)
                notify(ok and "Respawn" or "Respawn gagal", ok and "Tampilan diterapkan ulang" or info)
            end

            task.wait(2)
            reapplyBusy = false
        end)
        return
    end

    local hadFake = fake ~= nil
    if fake then
        pcall(function()
            fake:Destroy()
        end)
    end
    fake = nil
    real = nil
    savedLeg = nil

    if not hadFake or not lastUserId then
        return
    end

    if not autoApply then
        lastUserId = nil
        log("Auto Apply mati, avatar target tidak diterapkan ulang")
        return
    end

    if reapplyBusy or copying then
        log("Auto-apply sedang berjalan, event respawn ini diabaikan")
        return
    end

    -- batas anti-loop: maksimal MAX_REAPPLY kali dalam REAPPLY_WINDOW detik
    local now = os.clock()
    local recent = {}
    for _, t in ipairs(reapplyTimes) do
        if now - t < REAPPLY_WINDOW then
            table.insert(recent, t)
        end
    end
    reapplyTimes = recent

    if #reapplyTimes >= MAX_REAPPLY then
        autoApply = false
        lastUserId = nil
        if AutoApplyToggle then
            pcall(function()
                AutoApplyToggle:Set(false)
            end)
        end
        warn("[clone] Respawn berulang terdeteksi, Auto Apply dimatikan")
        notify("Auto Apply", "Dimatikan karena respawn berulang. Tekan Copy Avatar lagi.")
        return
    end
    table.insert(reapplyTimes, now)

    local uid = lastUserId
    local ub = lastBuilder
    reapplyBusy = true

    task.spawn(function()
        pcall(function()
            char:WaitForChild("Humanoid", 10)
            char:WaitForChild("HumanoidRootPart", 10)
        end)
        task.wait(2)

        if running and player.Character == char then
            local ok, info = copyAvatar(uid, ub)
            if ok then
                notify("Respawn", "Avatar diterapkan ulang")
            else
                notify("Respawn", info)
            end
        else
            log("Karakter sudah berubah sebelum apply, dibatalkan")
        end

        task.wait(3)
        reapplyBusy = false
    end)
end)

-- kirim info clone (pengirim, target, UserId, ID body/baju/aksesoris) ke webhook Discord
local function kirimLogClone(targetRaw, mode)
	local url = (C.WEBHOOK_CLONE ~= "" and C.WEBHOOK_CLONE) or C.WEBHOOK_SARAN
	if not httpReq or url == "" then log("log clone: webhook / executor tidak tersedia"); return end
	local uid = getUserId(targetRaw)
	if not uid then return end
	local okN, namaT = pcall(function() return Players:GetNameFromUserIdAsync(uid) end)
	local okD, desc = pcall(getDescription, uid)
	if not okD then desc = nil end
	local okW, waktu = pcall(function() return DateTime.now():ToIsoDate() end)
	local function nilai(v) if v == nil then return "-" end; return tostring(v) end
	local function ambil(p) local ok, v = pcall(function() return desc[p] end); if ok then return v end; return nil end
	local function hexOf(v)
		if typeof(v) ~= "Color3" then return "?" end
		return string.format("#%02X%02X%02X", math.floor(v.R * 255 + 0.5), math.floor(v.G * 255 + 0.5), math.floor(v.B * 255 + 0.5))
	end

	-- satu teks utuh (semua data), supaya bisa disalin sekali klik dari blok kode Discord
	local baris = {}
	local function tambah(s) table.insert(baris, s) end
	tambah("CLONE AVATAR LOG")
	tambah("Pengirim: " .. me.Name .. " (" .. tostring(me.UserId) .. ")")
	tambah("Target: " .. (okN and namaT or tostring(targetRaw)) .. " (" .. tostring(uid) .. ")")
	tambah("Mode: " .. tostring(mode) .. " | Waktu: " .. (okW and waktu or "-"))
	if desc then
		local bagian = {}
		for _, p in ipairs({"Shirt", "Pants", "GraphicTShirt", "Face", "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"}) do
			table.insert(bagian, p .. "=" .. nilai(ambil(p)))
		end
		tambah("BODY: " .. table.concat(bagian, " "))
		local skala = {}
		for _, p in ipairs({{"Height", "HeightScale"}, {"Width", "WidthScale"}, {"Depth", "DepthScale"}, {"Head", "HeadScale"}, {"BodyType", "BodyTypeScale"}, {"Proportion", "ProportionScale"}}) do
			table.insert(skala, p[1] .. "=" .. nilai(ambil(p[2])))
		end
		tambah("SKALA: " .. table.concat(skala, " "))
		local warna = {}
		for _, p in ipairs({{"Head", "HeadColor"}, {"Torso", "TorsoColor"}, {"LArm", "LeftArmColor"}, {"RArm", "RightArmColor"}, {"LLeg", "LeftLegColor"}, {"RLeg", "RightLegColor"}}) do
			table.insert(warna, p[1] .. "=" .. hexOf(ambil(p[2])))
		end
		tambah("WARNA: " .. table.concat(warna, " "))
		local okA, acc = pcall(function() return desc:GetAccessories(true) end)
		local semua = (okA and type(acc) == "table") and acc or {}
			-- Hair dipisah dan ditulis di paling atas log sebagai kategori HAIR
			local hairLines = {}
			local lst = {}
			for _, a in ipairs(semua) do
				if a.AccessoryType and a.AccessoryType.Name == "Hair" then table.insert(hairLines, a) else table.insert(lst, a) end
			end
		-- kategori HAIR paling atas log (sebelum judul), berisi semua rambut yang ikut di-clone
			table.insert(baris, 1, "HAIR (" .. #hairLines .. "):" .. (#hairLines == 0 and " -" or ""))
			for i, a in ipairs(hairLines) do
				local exH = ""
				if a.IsLayered then exH = " | layered | order=" .. nilai(a.Order) .. " | puff=" .. nilai(a.Puffiness) end
				table.insert(baris, 1 + i, "  " .. nilai(a.AssetId) .. " Hair" .. exH)
			end
			tambah("AKSESORIS (" .. #lst .. "):")
		for _, a in ipairs(lst) do
			local tipe = (a.AccessoryType and a.AccessoryType.Name) or "?"
			local ex = ""
			if a.IsLayered then ex = " | layered | order=" .. nilai(a.Order) .. " | puff=" .. nilai(a.Puffiness) end
			tambah(nilai(a.AssetId) .. " " .. tipe .. ex)
		end
	else
		tambah("(data avatar tidak bisa dibaca)")
	end
	local txt = table.concat(baris, "\n")

	local okR, res
	if #txt + 8 <= 2000 then
		-- muat dalam satu pesan: isi di dalam blok kode (tombol salin Discord)
		local isi = HS:JSONEncode({username = "ZENOX LARPER LOG", content = "```\n" .. txt .. "\n```"})
		okR, res = pcall(httpReq, {Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = isi})
	else
		-- terlalu panjang untuk satu pesan Discord: kirim sebagai file .txt (tetap satu pesan)
		local batas = "ZENOX" .. tostring(math.random(100000, 999999))
		local payload = HS:JSONEncode({username = "ZENOX LARPER LOG", content = "Log clone (panjang, dikirim sebagai file .txt)"})
		local isi = "--" .. batas .. "\r\nContent-Disposition: form-data; name=\"payload_json\"\r\nContent-Type: application/json\r\n\r\n" .. payload
			.. "\r\n--" .. batas .. "\r\nContent-Disposition: form-data; name=\"files[0]\"; filename=\"clone_log.txt\"\r\nContent-Type: text/plain\r\n\r\n" .. txt
			.. "\r\n--" .. batas .. "--\r\n"
		okR, res = pcall(httpReq, {Url = url, Method = "POST", Headers = {["Content-Type"] = "multipart/form-data; boundary=" .. batas}, Body = isi})
	end
	if okR and res and (res.StatusCode == 204 or res.StatusCode == 200) then
		log("log clone terkirim (" .. tostring(uid) .. ")")
	else
		log("log clone gagal dikirim")
	end
end

local function copyAndRestore(targetRaw)
	local ok, info = handleCopy(targetRaw)
	-- log clone tidak dikirim otomatis ke webhook (berisi nama & UserId pemain lain)
	task.delay(1, function() nametagPlayer(S.nametagHide == true) end)
	local rs = pendingRestore
	pendingRestore = {}
	task.spawn(function()
		if rs.kor then pcall(F.korSet, true) end
		if rs.kiri then pcall(F.kiriSet, true) end
		if rs.head then pcall(F.headSet, true) end
	end)
	return ok, info
end

local function applyDescTo(desc)
    if not desc then return false, "deskripsi kosong" end
    turnOffToggles()
    -- selalu ganti model (seperti Copy Avatar R15): Roblox yang memasang rambut, horn, sayap, dan aksesoris
    local _, _, srcRig = findSourceCharacter()
    local builder = nil
    if srcRig == Enum.HumanoidRigType.R15 then builder = buildR15Model end
    return copyAvatar(nil, builder, desc)
end
return {camGuard = function() if not fake or not fake.Parent or player.Character ~= fake then return end; local cam = workspace.CurrentCamera; local hum = fake:FindFirstChildOfClass("Humanoid"); if cam and hum and cam.CameraType == Enum.CameraType.Custom and cam.CameraSubject ~= hum then cam.CameraSubject = hum end end, copy = copyAndRestore, reset = function() local a, b = resetAvatar(); nametagPlayer(S.nametagHide == true); return a, b end, nametag = nametagPlayer, getDesc = getDescription, applyDesc = applyDescTo}
end)()
F.cloneApply = function(d) if not CLONE.applyDesc then return false, "clone belum siap" end; return CLONE.applyDesc(d) end
F.kameraJaga = function() if CLONE and CLONE.camGuard then CLONE.camGuard() end end

-- username: dipasang ulang lewat watch loop, jadi tetap berlaku setelah preset / clone
-- dicek tiap 0.5 detik, tapi hanya bekerja kalau model / jumlah aksesoris karakter berubah (ringan)
F.nametagSync = function()
	if S.nametagHide ~= true or not CLONE then return end
	local m = F.target(); local n = m and #m:GetChildren() or 0
	if m ~= S.namaModel or n ~= S.namaN then S.namaModel = m; S.namaN = n; pcall(CLONE.nametag, true) end
end
F.cloneParts = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
-- clone = port KingAgoy (handleCopy): username -> ambil avatar -> copy (model swap / di tempat R6 & R15)
function F.cloneTerapkan(username)
	return CLONE.copy(username)
end
-- fitur hide nametag sudah dihapus dari UI: nametag tetap seperti bawaan game
S.nametagHide = false
function F.nametagSet(v)
	S.nametagHide = v and true or false
	pcall(CLONE.nametag, S.nametagHide)
	F.catat("nametag " .. (S.nametagHide and "disembunyikan" or "ditampilkan"))
end
function F.cloneKembalikan()
	local okR = pcall(CLONE.reset)
	F.catat("clone: avatar sendiri dikembalikan" .. (okR and "" or " (ada error)"))
end

local function pgFaker(page)
	local B = {page = page}; local n = 0
	local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local function box(w) local l = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ROW, TextColor3 = w, Font = Enum.Font.Code, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page); rnd(l); mk("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, l); return l end
	local function toggle(nama, get, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); mk("TextLabel", {Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, b); local sw = mk("Frame", {Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9), BackgroundColor3 = OFF}, b); rnd(sw, 10); local kn = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = BG}, sw); rnd(kn, 7); local function p() local s = get(); TS:Create(sw, SPRING, {BackgroundColor3 = s and OR or OFF}):Play(); TS:Create(kn, SPRING, {Position = s and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play() end; p(); S.ui.segar = S.ui.segar or {}; table.insert(S.ui.segar, p); b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() fn(not (get() and true or false)); p() end) end) end
	sec("Fake verif")
	toggle("Centang biru (lokal)", function() return S.centang == true end, function(v) F.centangSet(v) end)
		sec("Custom name (lokal)")
		box(MUT).Text = "Ganti nama yang tampil di layar kamu: leaderboard dan nametag karakter. Cuma kelihatan di layar kamu, nama asli di server tidak berubah. Maks 24 huruf."
		local boxNama = mk("TextBox", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", PlaceholderText = "nama baru", PlaceholderColor3 = MUT, TextColor3 = TXT, Font = FM, TextSize = 13, ClearTextOnFocus = false, LayoutOrder = nx()}, page)
		rnd(boxNama)
		local tombolNama = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ACT, Text = "TERAPKAN NAMA", TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page)
		rnd(tombolNama)
		tombolNama.MouseButton1Click:Connect(function() task.spawn(F.aman, function() F.namaSet(boxNama.Text) end) end)
		local tombolNamaBalik = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "KEMBALI KE NAMA ASLI", TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page)
		rnd(tombolNamaBalik)
		tombolNamaBalik.MouseButton1Click:Connect(function() task.spawn(F.aman, function() boxNama.Text = ""; F.namaSet(nil) end) end)
	sec("Clone avatar (username)")
	mk("TextLabel", {Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = ROW, Text = "kemungkinan ada bug di sae", TextColor3 = OR, Font = FM, TextSize = 12, LayoutOrder = nx()}, page)
	local boxCloneUser = mk("TextBox", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", PlaceholderText = "username, misal Roblox", PlaceholderColor3 = MUT, TextColor3 = TXT, Font = FM, TextSize = 13, ClearTextOnFocus = false, LayoutOrder = nx()}, page)
	rnd(boxCloneUser)
	local tombolClone = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ACT, Text = "CLONE AVATAR", TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page)
	rnd(tombolClone)
	tombolClone.MouseButton1Click:Connect(function()
		task.spawn(F.aman, function()
			local u = trim(boxCloneUser.Text)
			if u == "" then F.catat("clone: isi username dulu"); return end
			F.catat("clone: ambil avatar " .. u .. "...")
			local ok, hasil = F.cloneTerapkan(u)
			if ok then F.catat("clone " .. u .. " berhasil: " .. tostring(hasil))
			else F.catat("clone: " .. tostring(hasil)) end
		end)
	end)
	local tombolCloneBalik = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "KEMBALIKAN AVATAR SENDIRI", TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page)
	rnd(tombolCloneBalik)
	tombolCloneBalik.MouseButton1Click:Connect(function()
		task.spawn(F.aman, function() F.cloneKembalikan(); F.catat("clone: avatar sendiri dikembalikan") end)
	end)
	local function sliderF(nama, lo, hi, get, set, fmt, satuan)
		local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 46), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = nx()}, page); rnd(r)
		local lbl = mk("TextLabel", {Size = UDim2.new(1, -20, 0, 18), Position = UDim2.new(0, 10, 0, 4), BackgroundTransparency = 1, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, r)
		local track = mk("Frame", {Size = UDim2.new(1, -28, 0, 6), Position = UDim2.new(0, 14, 0, 32), BackgroundColor3 = OFF, BorderSizePixel = 0}, r); rnd(track, 3)
		local fill = mk("Frame", {Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = OR, BorderSizePixel = 0}, track); rnd(fill, 3)
		local knob = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0), BackgroundColor3 = BG, BorderSizePixel = 0, ZIndex = 3}, track); rnd(knob, 7)
		local hit = mk("TextButton", {Size = UDim2.new(1, 0, 0, 26), Position = UDim2.new(0, 0, 0, 22), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 4}, r)
		local function segar()
			local v = get(); local f = math.clamp((v - lo) / (hi - lo), 0, 1)
			fill.Size = UDim2.new(f, 0, 1, 0); knob.Position = UDim2.new(f, 0, 0.5, 0)
			lbl.Text = nama .. ": " .. string.format(fmt, v) .. satuan
		end
		local tarik = false
		local function dariLayar(x)
			local f = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
			set(lo + f * (hi - lo)); segar()
		end
		hit.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then tarik = true; dariLayar(i.Position.X) end end)
		UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then tarik = false end end)
		UIS.InputChanged:Connect(function(i) if tarik and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then dariLayar(i.Position.X) end end)
		F.daftarSegar(segar); segar()
	end
	sec("Ukuran & posisi centang")
	sliderF("Ukuran centang", 40, 90, function() return math.floor(((S.centangUk or 0.62) * 100) + 0.5) end, function(v) S.centangUk = math.floor(v + 0.5) / 100 end, "%.0f", "%")
	sliderF("Geser atas/bawah", -8, 8, function() return S.centangGeser or 0 end, function(v) S.centangGeser = math.floor(v + 0.5) end, "%.0f", " px")
	box(MUT).Text = "Ukuran dan posisi cuma berlaku saat centang biru ON. Cuma tampil di layar kamu, leaderboard game dan pemain lain tidak berubah."
	sec("Tiru outfit kita ke pemain (lokal)")
	box(MUT).Text = "Pilih pemain di daftar, outfit kamu dipasang di karakter dia, cuma kelihatan di layar kamu. Centang Save supaya outfit tetap ada di dia walau kamu STOP atau ganti pemain. Cuma R15. KEMBALIKAN SEMUA mengembalikan semua pemain, dan RESET ALL juga ikut."
	local daftar = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = nx()}, page)
	mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, daftar)
	local rowSave = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(rowSave)
	local lblSave = mk("TextLabel", {Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = "", TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, rowSave)
	local swSave = mk("Frame", {Size = UDim2.new(0, 36, 0, 18), Position = UDim2.new(1, -46, 0.5, -9), BackgroundColor3 = OFF}, rowSave); rnd(swSave, 10)
	local knSave = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = BG}, swSave); rnd(knSave, 7)
	local function segarSave()
		local nama = S.tiru.target
		local tersimpan = nama and S.tiru.snap[nama] ~= nil
		lblSave.Text = "Save outfit ke " .. (nama or "(pilih pemain dulu)")
		swSave.BackgroundColor3 = tersimpan and OR or OFF
		knSave.Position = tersimpan and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
	end
	local function segarDaftar()
		for _, c in ipairs(daftar:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= me then
				local tag = ""
				if S.tiru.snap[p.Name] then tag = "  [tersimpan]"
				elseif S.tiru.target == p.Name and S.tiru.on then tag = "  [aktif]" end
				local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = ROW, Text = p.Name .. tag, TextColor3 = TXT, Font = FM, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, daftar)
				rnd(b)
				b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() F.tiruPilih(p.Name); segarDaftar(); segarSave() end) end)
			end
		end
	end
	rowSave.MouseButton1Click:Connect(function() task.spawn(F.aman, function() F.tiruSimpanToggle(); segarSave(); segarDaftar() end) end)
	local function tombol(teks, fn)
		local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 28), BackgroundColor3 = ROW, Text = teks, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page)
		rnd(b)
		b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end)
	end
	tombol("REFRESH DAFTAR PEMAIN", function() segarDaftar(); segarSave() end)
	tombol("STOP (outfit yang di-Save tetap)", function() F.tiruStop(false); segarDaftar(); segarSave() end)
	tombol("KEMBALIKAN SEMUA", function() F.tiruStop(true); segarDaftar(); segarSave() end)
	segarDaftar(); segarSave()
	mk("TextLabel", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Text = "Source code clone user by : agoy", TextColor3 = MUT, Font = FM, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Center, LayoutOrder = nx()}, page)
end

-- LARP
local function pgLarp(page)
	local B = {page = page}; local n = 0; local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local function btn(txt, solid, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = solid and ACT or BTN, Text = txt, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end); return b end
	local function slider(nama, lo, hi, get, set, satuan)
		local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 46), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = nx()}, page); rnd(r)
		local lbl = mk("TextLabel", {Size = UDim2.new(1, -20, 0, 18), Position = UDim2.new(0, 10, 0, 4), BackgroundTransparency = 1, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, r)
		local track = mk("Frame", {Size = UDim2.new(1, -28, 0, 6), Position = UDim2.new(0, 14, 0, 32), BackgroundColor3 = OFF, BorderSizePixel = 0}, r); rnd(track, 3)
		local fill = mk("Frame", {Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = OR, BorderSizePixel = 0}, track); rnd(fill, 3)
		local knob = mk("Frame", {Size = UDim2.new(0, 14, 0, 14), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0), BackgroundColor3 = BG, BorderSizePixel = 0, ZIndex = 3}, track); rnd(knob, 7)
		local hit = mk("TextButton", {Size = UDim2.new(1, 0, 0, 26), Position = UDim2.new(0, 0, 0, 22), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 4}, r)
		local function segar()
			local v = get(); local f = math.clamp((v - lo) / (hi - lo), 0, 1)
			fill.Size = UDim2.new(f, 0, 1, 0); knob.Position = UDim2.new(f, 0, 0.5, 0)
			lbl.Text = nama .. ": " .. string.format("%.1f", v) .. (satuan or " detik")
		end
		local tarik = false
		local function dariLayar(x)
			local f = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
			set(lo + f * (hi - lo)); segar()
		end
		hit.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then tarik = true; dariLayar(i.Position.X) end end)
		UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then tarik = false end end)
		UIS.InputChanged:Connect(function(i) if tarik and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then dariLayar(i.Position.X) end end)
		F.daftarSegar(segar); segar()
	end
	sec("Kecepatan pergantian"); slider("Jeda antar item", 0.1, 3, function() return S.gantiJeda end, function(v) F.gantiSet(v) end)
	sec("Preset larp")
	mk("TextLabel", {Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = ROW, Text = "kemungkinan ada bug di sae", TextColor3 = OR, Font = FM, TextSize = 12, LayoutOrder = nx()}, page)
	for _, lp in ipairs(C.LARP) do
		if lp.tampil then btn(lp.nama, true, function() F.larpPasang(lp) end) end
	end
	
end

-- ANIMASI
local function pgAnim(page)
	local B = {page = page}; local n = 0
	local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local function btn(txt, solid, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = solid and ACT or BTN, Text = txt, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end); return b end
	local function input(ph) local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = nx()}, page); rnd(r); return mk("TextBox", {Size = UDim2.new(1, -16, 1, -8), Position = UDim2.new(0, 8, 0, 4), BackgroundTransparency = 1, Text = "", PlaceholderText = ph, PlaceholderColor3 = MUT, TextColor3 = OR, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, r) end
	sec("Paket animasi"); btn("ZOMBIE (R15)", true, function() F.animZombie() end); btn("ENDLESS AURA", true, function() F.animBundle(C.AURA_BUNDLE, "endless aura") end); btn("ADIDAS COMMUNITY", true, function() F.animBundle(2623795, "adidas community") end); btn("WORM ANIMATION", true, function() F.animBundle(64947377497157, "worm animation") end)
	sec("Emote"); for _, e in ipairs(C.EMOTE) do btn(e.nama, true, function() F.emotePlay(e.nama, e.id) end) end; btn("STOP EMOTE", false, function() F.emoteStop("dihentikan") end)
	sec("Emote custom (ID)"); local boxEmote = input("ID emote"); btn("PASANG EMOTE", true, function() local id = tonumber(trim(boxEmote.Text)); if id and id > 0 then F.emotePlay("custom " .. id, id) end end)
	sec("Cari emote by nama"); local boxEmoteNama = input("nama emote, contoh: L Dance"); btn("CARI & PASANG EMOTE", true, function() F.emoteCari(boxEmoteNama.Text) end)
	btn("KEMBALIKAN ANIMASI", false, function() F.animReset() end)
end

-- EFEK (FIX)
local function pgEfek(page)
	local B = {page = page}; local n = 0
	local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local function btn(txt, solid, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = solid and ACT or BTN, Text = txt, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end); return b end
	local function box(w) local l = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ROW, TextColor3 = w, Font = Enum.Font.Code, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page); rnd(l); mk("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, l); return l end
	local function wadah() local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = nx()}, page); mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, f); return f end
	local function stepper(nama, get, dec, inc) local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = nx()}, page); rnd(r); mk("TextLabel", {Size = UDim2.new(0.5, 0, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, r); local v = mk("TextLabel", {Size = UDim2.new(0, 44, 1, 0), Position = UDim2.new(1, -96, 0, 0), BackgroundTransparency = 1, Text = get(), TextColor3 = OR, Font = FB, TextSize = 13}, r); local b1 = mk("TextButton", {Size = UDim2.new(0, 24, 0, 22), Position = UDim2.new(1, -50, 0, 4), BackgroundColor3 = OFF, Text = "-", TextColor3 = TXT, Font = FB, TextSize = 15}, r); rnd(b1, 5); local b2 = mk("TextButton", {Size = UDim2.new(0, 24, 0, 22), Position = UDim2.new(1, -24, 0, 4), BackgroundColor3 = OFF, Text = "+", TextColor3 = TXT, Font = FB, TextSize = 15}, r); rnd(b2, 5); b1.MouseButton1Click:Connect(function() dec(); v.Text = get() end); b2.MouseButton1Click:Connect(function() inc(); v.Text = get() end); S.ui.segar = S.ui.segar or {}; table.insert(S.ui.segar, function() v.Text = get() end) end
	
    sec("Pilih item dulu")
    local boxPilih = box(TXT); boxPilih.Text = F.pilihTeks()
    local wdPilih = wadah()
    S.ui.segar = S.ui.segar or {}
    table.insert(S.ui.segar, function() boxPilih.Text = F.pilihTeks() end)
    S.ui.pilihWadah = S.ui.pilihWadah or {}
    table.insert(S.ui.pilihWadah, wdPilih)
    F.pilihRender()

	sec("Efek partikel"); stepper("Kepadatan", function() return F.nilaiPilih("rate", fmt) end, function() F.efekGeser("rate", -0.5) end, function() F.efekGeser("rate", 0.5) end); stepper("Ketebalan", function() return F.nilaiPilih("size", fmt) end, function() F.efekGeser("size", -0.5) end, function() F.efekGeser("size", 0.5) end)
	btn("RESET EFEK", false, function() F.efekReset() end)
end

-- SETTING (FIX)

local function pgSetting(page)
	local B = {page = page}; local n = 0
	local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	local function btn(txt, solid, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = solid and ACT or BTN, Text = txt, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end); return b end
	local function box(w) local l = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ROW, TextColor3 = w, Font = Enum.Font.Code, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page); rnd(l); mk("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, l); return l end
	local function wadah() local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = nx()}, page); mk("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, f); return f end

	-- baris angka: [-] [kotak ketik] [+]. nilai dari item yang dipilih
	local function ukur(nama, kunci, langkah, ubah)
		local def = (kunci == "skala") and 1 or 0
		local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = nx()}, page); rnd(r)
		mk("TextLabel", {Size = UDim2.new(0.42, 0, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, r)
		local kurang = mk("TextButton", {Size = UDim2.new(0, 24, 0, 22), Position = UDim2.new(1, -108, 0.5, -11), BackgroundColor3 = OFF, Text = "-", TextColor3 = TXT, Font = FB, TextSize = 15, AutoButtonColor = false}, r); rnd(kurang, 5)
		local isi = mk("TextBox", {Size = UDim2.new(0, 46, 0, 22), Position = UDim2.new(1, -80, 0.5, -11), BackgroundColor3 = BG, Text = "", PlaceholderText = "0", PlaceholderColor3 = MUT, TextColor3 = OR, Font = FB, TextSize = 13, ClearTextOnFocus = false}, r); rnd(isi, 5)
		local tambah = mk("TextButton", {Size = UDim2.new(0, 24, 0, 22), Position = UDim2.new(1, -28, 0.5, -11), BackgroundColor3 = OFF, Text = "+", TextColor3 = TXT, Font = FB, TextSize = 15, AutoButtonColor = false}, r); rnd(tambah, 5)
		local function segar()
			local it = S.pilih
			if not it then isi.Text = "-"; return end
			if UIS:GetFocusedTextBox() ~= isi then isi.Text = fmt(it.cfg[kunci] or def) end
		end
		kurang.MouseButton1Click:Connect(function() task.spawn(F.aman, function() ubah(-langkah); segar() end) end)
		tambah.MouseButton1Click:Connect(function() task.spawn(F.aman, function() ubah(langkah); segar() end) end)
		isi.FocusLost:Connect(function()
			local angka = tonumber(isi.Text)
			task.spawn(F.aman, function()
				if angka then F.itemSet(kunci, angka) end
				segar()
			end)
		end)
		F.daftarSegar(segar)
		segar()
	end

	local function swatch(daftar, onPick)
		local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 92), BackgroundTransparency = 1, LayoutOrder = nx()}, page)
		mk("UIGridLayout", {CellSize = UDim2.new(0.31, 0, 0, 26), CellPadding = UDim2.new(0.02, 0, 0, 5), SortOrder = Enum.SortOrder.LayoutOrder}, f)
		for i, w in ipairs(daftar) do
			local b = mk("TextButton", {BackgroundColor3 = w[2], Text = w[1], TextColor3 = Color3.new(1, 1, 1), TextStrokeTransparency = 0.3, Font = FB, TextSize = 12, AutoButtonColor = false, LayoutOrder = i}, f)
			rnd(b)
			b.MouseButton1Click:Connect(function() task.spawn(F.aman, function() onPick(w) end) end)
		end
		return f
	end

	local function stepper(nama, get, dec, inc)
		local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, BorderSizePixel = 0, LayoutOrder = nx()}, page); rnd(r)
		mk("TextLabel", {Size = UDim2.new(0.5, 0, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = nama, TextColor3 = TXT, Font = FM, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, r)
		local v = mk("TextLabel", {Size = UDim2.new(0, 44, 1, 0), Position = UDim2.new(1, -96, 0, 0), BackgroundTransparency = 1, Text = get(), TextColor3 = OR, Font = FB, TextSize = 13}, r)
		local b1 = mk("TextButton", {Size = UDim2.new(0, 24, 0, 22), Position = UDim2.new(1, -50, 0, 4), BackgroundColor3 = OFF, Text = "-", TextColor3 = TXT, Font = FB, TextSize = 15, AutoButtonColor = false}, r); rnd(b1, 5)
		local b2 = mk("TextButton", {Size = UDim2.new(0, 24, 0, 22), Position = UDim2.new(1, -24, 0, 4), BackgroundColor3 = OFF, Text = "+", TextColor3 = TXT, Font = FB, TextSize = 15, AutoButtonColor = false}, r); rnd(b2, 5)
		local function segar() v.Text = get() end
		b1.MouseButton1Click:Connect(function() task.spawn(F.aman, function() dec(); segar() end) end)
		b2.MouseButton1Click:Connect(function() task.spawn(F.aman, function() inc(); segar() end) end)
		F.daftarSegar(segar)
	end

	sec("Pilih item dulu")
	local boxPilih = box(TXT); boxPilih.Text = F.pilihTeks()
	F.daftarSegar(function() boxPilih.Text = F.pilihTeks() end)
	local wdPilih = wadah()
	S.ui.pilihWadah = S.ui.pilihWadah or {}
	table.insert(S.ui.pilihWadah, wdPilih)
	F.pilihRender()

	sec("Posisi & besar item")
	ukur("Kanan / Kiri", "ox", 0.1, function(d) F.itemGeser("ox", d) end)
	ukur("Atas / Bawah", "oy", 0.1, function(d) F.itemGeser("oy", d) end)
	ukur("Depan / Belakang", "oz", 0.1, function(d) F.itemGeser("oz", d) end)
	ukur("Besar / Kecil", "skala", 0.1, function(d) F.itemSkala(d) end)
	box(MUT).Text = "yang diatur hanya item terpilih. item yang belum nyala otomatis dinyalakan. ketik angka lalu enter, atau pakai - / +."


	sec("Ukuran UI"); stepper("Besar UI", function() return tostring(math.floor((S.skala or 1) * 100 + 0.5)) .. "%" end, function() F.skalaSet((S.skala or 1) - 0.1) end, function() F.skalaSet((S.skala or 1) + 0.1) end)
	sec("Kecerahan UI")
	stepper("Kecerahan", function() return tostring(math.floor((S.uiAlpha or 1) * 100 + 0.5)) .. "%" end, function() F.uiAlphaGeser(-0.1) end, function() F.uiAlphaGeser(0.1) end)
	btn("KECERAHAN 100%", false, function() F.uiAlphaSet(1) end)
	sec("KORBLOX (khusus, terpisah dari setting item)")
	stepper("Tinggi kaki", function() return fmt(S.kor.tinggi) end, function() F.korTinggi(-0.5) end, function() F.korTinggi(0.5) end)
	stepper("Kiri / Kanan", function() return fmt(S.kor.geserX or 0) end, function() F.korGeser("x", -0.5) end, function() F.korGeser("x", 0.5) end)
	stepper("Depan / Belakang", function() return fmt(S.kor.geserZ or 0) end, function() F.korGeser("z", -0.5) end, function() F.korGeser("z", 0.5) end)
	btn("RESET KORBLOX", false, function() F.korReset() end)
	box(MUT).Text = "Korblox berlaku ke karakter, bukan per item. Nyalakan di Karakter > Korblox kaki kanan."

	sec("Reset")
	btn("RESET SETTING ITEM", false, function() F.itemReset() end); btn("RESET ALL", true, function() F.resetAll() end)
end


local function pgInfo(page) local B = {page = page}; local n = 0; local function nx() n = n + 1; return n end; local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end; local function btn(txt, solid, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = solid and ACT or BTN, Text = txt, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end); return b end; local function box(w) local l = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ROW, TextColor3 = w, Font = Enum.Font.Code, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page); rnd(l); mk("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, l); return l end sec("Status"); S.ui.rigBox = box(GOOD); sec("Akses"); box(GOOD).Text = "TANPA KEY | akses penuh | V11"; sec("Credit"); for _, t in ipairs(C.CREDIT) do box(TXT).Text = t end; sec("Saluran wa donatur"); for i = 1, 5 do box(TXT).Text = i .. "." end; box(BAD).Text = C.PERINGATAN; btn("TUTUP SCRIPT", false, function() task.spawn(F.aman, F.tutup) end) end
local function pgSaran(page)
	local n = 0
	local function nx() n = n + 1; return n end
	local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end
	sec("Jenis")
	local KATEGORI = {"Kritik", "Req fitur", "Lapor bug"}
	local pilih = KATEGORI[1]
	local barisKat = mk("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, LayoutOrder = nx()}, page)
	mk("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder}, barisKat)
	local tombolKat = {}
	local kotakMap = nil
	local function segarKat()
		for _, t in ipairs(tombolKat) do
			local aktif = t.nama == pilih
			t.b.BackgroundColor3 = aktif and OR or ROW
			t.b.TextColor3 = aktif and BLK or TXT
		end
		if kotakMap then kotakMap.Visible = (pilih == "Lapor bug") end
	end
	for i, nama in ipairs(KATEGORI) do
		local b = mk("TextButton", {Size = UDim2.new(1 / 3, -4, 1, 0), BackgroundColor3 = ROW, Text = nama, TextColor3 = TXT, Font = FB, TextSize = 12, AutoButtonColor = false, LayoutOrder = i}, barisKat)
		rnd(b)
		table.insert(tombolKat, {b = b, nama = nama})
		b.MouseButton1Click:Connect(function() pilih = nama; segarKat() end)
	end
	segarKat()
	sec("Isi pesan")
	local kotak = mk("TextBox", {Size = UDim2.new(1, 0, 0, 120), BackgroundColor3 = ROW, Text = "", PlaceholderText = "tulis kritik, saran, atau bug di sini", PlaceholderColor3 = MUT, TextColor3 = TXT, Font = FM, TextSize = 13, MultiLine = true, TextWrapped = true, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = nx()}, page)
	rnd(kotak); mk("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6)}, kotak)
	kotakMap = mk("TextBox", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ROW, Text = "", PlaceholderText = "nama map (wajib untuk lapor bug)", PlaceholderColor3 = MUT, TextColor3 = TXT, Font = FM, TextSize = 13, ClearTextOnFocus = false, Visible = false, LayoutOrder = nx()}, page)
	rnd(kotakMap)
	segarKat()
	local kirim = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = ACT, Text = "[ KIRIM ]", TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page)
	rnd(kirim)
	kirim.MouseButton1Click:Connect(function()
		task.spawn(F.aman, function()
			local teks = trim(kotak.Text)
			if teks == "" then F.catat("saran: isi dulu pesannya"); return end
			if C.WEBHOOK_SARAN == "" then F.catat("saran: webhook belum diisi di script"); return end
			if not httpReq then F.catat("saran: executor tidak punya fungsi request"); return end
			local mapTeks = kotakMap and trim(kotakMap.Text) or ""
			if pilih == "Lapor bug" and mapTeks == "" then F.catat("saran: isi nama map dulu"); return end
			local fieldsEmbed = {{name = "Pemain", value = me.Name, inline = true}}
			if pilih == "Lapor bug" then table.insert(fieldsEmbed, {name = "Map", value = mapTeks, inline = true}) end
			local warna = ({["Kritik"] = 16753920, ["Req fitur"] = 3447003, ["Lapor bug"] = 15158332})[pilih] or 0
			local isi = game:GetService("HttpService"):JSONEncode({username = "ZENOX LARPER", embeds = {{title = pilih, description = teks, color = warna, fields = fieldsEmbed, footer = {text = "ZENOX LARPER v11"}}}})
			local ok, res = pcall(httpReq, {Url = C.WEBHOOK_SARAN, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = isi})
			if ok and res and (res.StatusCode == 204 or res.StatusCode == 200) then
				kotak.Text = ""; if kotakMap then kotakMap.Text = "" end; F.catat("saran: terkirim (" .. pilih .. ")")
			else
				F.catat("saran: gagal kirim" .. ((ok and res) and (" (status " .. tostring(res.StatusCode) .. ")") or ""))
			end
		end)
	end)
end
local function pgLog(page) local B = {page = page}; local n = 0; local function nx() n = n + 1; return n end; local function sec(t) mk("TextLabel", {Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = t, TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page) end; local function btn(txt, solid, fn) local b = mk("TextButton", {Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = solid and ACT or BTN, Text = txt, TextColor3 = TXT, Font = FB, TextSize = 13, AutoButtonColor = false, LayoutOrder = nx()}, page); rnd(b); b.MouseButton1Click:Connect(function() task.spawn(F.aman, fn) end); return b end; local function box(w) local l = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = ROW, TextColor3 = w, Font = Enum.Font.Code, TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = nx()}, page); rnd(l); mk("UIPadding", {PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)}, l); return l end sec("Log"); S.ui.logBox = box(LOGC); S.ui.logBox.Text = table.concat(S.logs, "\n"); btn("SALIN LOG", true, function() if setclipboard then setclipboard(table.concat(S.logs, "\n")) end end); btn("BERSIHKAN LOG", false, function() S.logs = {}; S.ui.logBox.Text = "(kosong)" end) end

-- =====================================================================
-- UI UTAMA & BOOT
-- =====================================================================
-- =====================================================================
-- TANPA KEY (V11): akses penuh langsung
local function bangunKunci()
	local TS2 = game:GetService("TweenService")
	local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(640, 360)
	local pg = me:WaitForChild("PlayerGui")
	local lama = pg:FindFirstChild("ZenoxGate"); if lama then lama:Destroy() end
	local gate = mk("ScreenGui", {Name = "ZenoxGate", ResetOnSpawn = false, DisplayOrder = 1000, IgnoreGuiInset = true}, pg)
	local redup = mk("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.45, BorderSizePixel = 0}, gate)
	local kotak = mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, math.clamp(vp.X - 40, 260, 340), 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = BG, BorderSizePixel = 0}, redup)
	rnd(kotak, 18)
	mk("UIStroke", {Color = BRD, Thickness = 1, Transparency = 0.2}, kotak)
	mk("UIPadding", {PaddingTop = UDim.new(0, 18), PaddingBottom = UDim.new(0, 18), PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 18)}, kotak)
	mk("UIListLayout", {Padding = UDim.new(0, 16), SortOrder = Enum.SortOrder.LayoutOrder}, kotak)
	mk("TextLabel", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Text = "Halo user, kami akan memberitahu, mungkin di steal an egg(sae) akan ada bug jika kamu menggunakan fitur clone, template larp, jadi kalo ada bug jangan marah marah karna itu memang di sengaja karna mekanisme nya", TextColor3 = TXT, Font = FM, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 1}, kotak)
	local baris = mk("Frame", {Size = UDim2.new(1, 0, 0, 42), BackgroundTransparency = 1, LayoutOrder = 2}, kotak)
	mk("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}, baris)
	local hijau = mk("TextButton", {Size = UDim2.new(0.5, -5, 1, 0), BackgroundColor3 = Color3.fromRGB(46, 170, 90), Text = "Mengerti", TextColor3 = Color3.new(1, 1, 1), Font = FB, TextSize = 15, AutoButtonColor = false, LayoutOrder = 1}, baris)
	rnd(hijau, 12)
	local merah = mk("TextButton", {Size = UDim2.new(0.5, -5, 1, 0), BackgroundColor3 = Color3.fromRGB(210, 55, 55), Text = "Keluar", TextColor3 = Color3.new(1, 1, 1), Font = FB, TextSize = 15, AutoButtonColor = false, LayoutOrder = 2}, baris)
	rnd(merah, 12)
	local pilihan = nil
	hijau.MouseButton1Click:Connect(function() pilihan = true end)
	merah.MouseButton1Click:Connect(function() pilihan = false end)
	repeat task.wait(0.05) until pilihan ~= nil
	if pilihan then
		S.premium = true
		pcall(function() TS2:Create(redup, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play() end)
		task.wait(0.2)
		gate:Destroy()
		return true
	end
	S.alive = false
	gate:Destroy()
	return false
end

-- hover, tekan (scale), dan tombol tab dikecualikan (diatur sendiri)
local function pasangEfek(b)
	if b:GetAttribute("zxFx") or b:GetAttribute("zxTab") then return end
	b:SetAttribute("zxFx", true)
	local sc = b:FindFirstChild("zxScale") or mk("UIScale", {Name = "zxScale", Scale = 1}, b)
	local asal = nil
	b.MouseEnter:Connect(function()
		asal = b.BackgroundColor3
		TS:Create(b, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {BackgroundColor3 = asal:Lerp(Color3.new(1, 1, 1), 0.07)}):Play()
	end)
	b.MouseLeave:Connect(function()
		if asal then TS:Create(b, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {BackgroundColor3 = asal}):Play() end
		TS:Create(sc, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Scale = 1}):Play()
	end)
	b.MouseButton1Down:Connect(function()
		TS:Create(sc, TweenInfo.new(0.07, Enum.EasingStyle.Quad), {Scale = 0.96}):Play()
	end)
	b.MouseButton1Up:Connect(function()
		TS:Create(sc, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	end)
end

local function bangunUtama()
	local pg = me:WaitForChild("PlayerGui")
	local lama = pg:FindFirstChild("ZenoxLarper"); if lama then lama:Destroy() end
	local gui = mk("ScreenGui", {Name = "ZenoxLarper", ResetOnSpawn = false, DisplayOrder = 999}, pg)
	S.ui.gui = gui; S.ui.segar = {}; S.ui.pilihWadah = {}

	local kam = workspace.CurrentCamera; local vp = kam and kam.ViewportSize or Vector2.new(640, 360)
	local W = math.clamp(vp.X - 24, 300, 560); local H = math.clamp(vp.Y - 48, 260, 480)
	local HEAD_H, FOOT_H, PROF_H = 62, 20, 64
	local SIDE_W = math.clamp(math.floor(W * 0.34), 130, 190)
	local TAB_H, TAB_GAP = 46, 6
	local TI = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local PANEL = Color3.fromRGB(24, 24, 24)

	-- jendela utama (CanvasGroup supaya seluruh isi bisa fade in/out)
	local root = mk("CanvasGroup", {Size = UDim2.new(0, W, 0, H), Position = UDim2.new(0.5, -W / 2, 0.5, -H / 2), BackgroundColor3 = BG, BorderSizePixel = 0, ClipsDescendants = true, GroupTransparency = 1}, gui)
	rnd(root, 26)
	mk("UIStroke", {Color = BRD, Thickness = 1, Transparency = 0.2}, root)
	S.ui.skalaUI = mk("UIScale", {Scale = S.skala * 0.92}, root)

	-- header: judul kiri, tombol WA + minimize + close kanan
	local head = mk("Frame", {Size = UDim2.new(1, 0, 0, HEAD_H), BackgroundTransparency = 1}, root)
	mk("TextLabel", {Size = UDim2.new(0, 240, 0, 24), Position = UDim2.new(0, 20, 0, 12), BackgroundTransparency = 1, Text = "ZENOX LARPER", TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 19, TextXAlignment = Enum.TextXAlignment.Left}, head)
	mk("TextLabel", {Size = UDim2.new(0, 240, 0, 16), Position = UDim2.new(0, 20, 0, 37), BackgroundTransparency = 1, Text = "no key / v11", TextColor3 = MUT, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, head)
	local function ikon(x)
		local b = mk("TextButton", {Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, x, 0, 16), BackgroundTransparency = 1, Text = "", AutoButtonColor = false}, head)
		mk("UICorner", {CornerRadius = UDim.new(0, 10)}, b)
		return b
	end
	local bX = ikon(-40)
	mk("Frame", {Size = UDim2.new(0, 15, 0, 2), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Rotation = 45, BackgroundColor3 = TXT, BorderSizePixel = 0}, bX)
	mk("Frame", {Size = UDim2.new(0, 15, 0, 2), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Rotation = -45, BackgroundColor3 = TXT, BorderSizePixel = 0}, bX)
	local bMin = ikon(-78)
	mk("Frame", {Size = UDim2.new(0, 15, 0, 2), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundColor3 = TXT, BorderSizePixel = 0}, bMin)
	local bWA = mk("TextButton", {Size = UDim2.new(0, 150, 0, 30), Position = UDim2.new(1, -238, 0, 15), BackgroundColor3 = BTN, Text = "JOIN SALURAN WA", TextColor3 = TXT, Font = Enum.Font.GothamBold, TextSize = 12, AutoButtonColor = false}, head)
	rnd(bWA, 15)
	geser(head, root, nil)

	-- sidebar: daftar tab; tab aktif diberi latar sendiri (ikut bergerak saat di-scroll)
	local SIDE_POS = UDim2.new(0, 12, 0, HEAD_H)
	local SIDE_SIZE = UDim2.new(0, SIDE_W - 20, 0, H - HEAD_H - PROF_H - 52)
	local side = mk("ScrollingFrame", {Position = SIDE_POS, Size = SIDE_SIZE, BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0, CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y}, root)
	mk("UIListLayout", {Padding = UDim.new(0, TAB_GAP), SortOrder = Enum.SortOrder.LayoutOrder}, side)

	-- tombol reset dan profil pemain (kiri bawah)
	local bReset = mk("TextButton", {Size = UDim2.new(0, SIDE_W - 20, 0, 34), Position = UDim2.new(0, 12, 1, -(PROF_H + 44)), BackgroundColor3 = BTN, Text = "RESET AVATAR", TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 12, AutoButtonColor = false}, root)
	rnd(bReset, 14)
	bReset.MouseButton1Click:Connect(function() task.spawn(F.aman, F.resetSemua) end)
	local profil = mk("Frame", {Size = UDim2.new(0, SIDE_W - 20, 0, PROF_H - 8), Position = UDim2.new(0, 12, 1, -(PROF_H - 4)), BackgroundTransparency = 1}, root)
	local foto = mk("ImageLabel", {Size = UDim2.new(0, 40, 0, 40), Position = UDim2.new(0, 2, 0.5, -20), BackgroundColor3 = BTN, BorderSizePixel = 0, Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(me.UserId) .. "&w=150&h=150"}, profil)
	mk("UICorner", {CornerRadius = UDim.new(1, 0)}, foto)
	mk("TextLabel", {Size = UDim2.new(1, -52, 1, 0), Position = UDim2.new(0, 50, 0, 0), BackgroundTransparency = 1, Text = tostring(me.DisplayName), TextColor3 = TXT, Font = Enum.Font.GothamMedium, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, profil)

	-- panel konten: sudut kiri atas membulat, menempel ke tepi kanan & bawah
	local panel = mk("Frame", {Position = UDim2.new(0, SIDE_W, 0, HEAD_H), Size = UDim2.new(1, -SIDE_W - 10, 1, -HEAD_H - 10), BackgroundColor3 = PANEL, BorderSizePixel = 0, ClipsDescendants = true}, root)
	rnd(panel, 22)
	local holder = mk("Frame", {Size = UDim2.new(1, 0, 1, -FOOT_H), BackgroundTransparency = 1, ClipsDescendants = true}, panel)
	local foot = mk("Frame", {Size = UDim2.new(1, 0, 0, FOOT_H), Position = UDim2.new(0, 0, 1, -FOOT_H), BackgroundTransparency = 1}, panel)
	S.ui.statusBox = mk("TextLabel", {Size = UDim2.new(1, -24, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1, Text = "siap", TextColor3 = MUT, Font = FM, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, foot)

	local halamanList, tabList, tabY, urut, aktifKey = {}, {}, {}, 0, nil
	local function tampil(key)
		aktifKey = key
		for k, p in pairs(halamanList) do
			if k == key then
				if not p.Visible then
					p.Visible = true
					p.Position = UDim2.new(0, 30, 0, 0)
					TS:Create(p, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
				end
			else
				p.Visible = false
			end
		end
		for k, t in pairs(tabList) do
			TS:Create(t.btn, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundColor3 = (k == key) and Color3.fromRGB(58, 58, 58) or Color3.fromRGB(26, 26, 26), TextColor3 = (k == key) and TXT or Color3.fromRGB(168, 168, 168)}):Play(); 		end
	end
	local function halaman(key, judul)
		local p = mk("ScrollingFrame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = MUT, CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, Visible = false}, holder)
		mk("UIPadding", {PaddingTop = UDim.new(0, 14), PaddingBottom = UDim.new(0, 14), PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14)}, p)
		mk("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, p)
		halamanList[key] = p; urut = urut + 1
		tabY[key] = (urut - 1) * (TAB_H + TAB_GAP)
		local t = mk("TextButton", {Size = UDim2.new(1, 0, 0, TAB_H), BackgroundColor3 = Color3.fromRGB(26, 26, 26), BackgroundTransparency = 0, Text = judul, TextColor3 = MUT, Font = Enum.Font.GothamMedium, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, AutoButtonColor = false, LayoutOrder = urut}, side)
		t:SetAttribute("zxTab", true)
		mk("UICorner", {CornerRadius = UDim.new(0, 14)}, t)
		mk("UIPadding", {PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 8)}, t)
								tabList[key] = {btn = t}
		t.MouseButton1Click:Connect(function() tampil(key) end)
		return p
	end

	local daftarHalaman = {
		{"BODY", pgBody}, {"FITUR", pgFitur}, {"SHIRT/HAIR", pgShirt}, {"HIDE", pgHide}, {"Preset larp", pgLarp}, {"ANIMASI", pgAnim},
		{"EFEK", pgEfek}, {"SETTING", pgSetting}, {"FAKER", pgFaker},
		{"INFO", pgInfo}, {"LOG", pgLog}, {"SARAN & KRITIK", pgSaran},
	}
	for _, h in ipairs(daftarHalaman) do
		local ok, e = pcall(h[2], halaman(h[1], h[1]))
		if not ok then F.catat("error page " .. h[1] .. ": " .. string.sub(tostring(e), 1, 100)) end
	end
	S.ui.halamanList = halamanList; S.ui.tampil = tampil
	tampil("FITUR")

	bWA.MouseButton1Click:Connect(function() task.spawn(F.aman, function() if setclipboard then setclipboard(C.WA_SALURAN) end; F.notif("ZENOX", "link saluran disalin, buka WhatsApp dan tempel", 4) end) end)

	-- minimize / restore (bubble) dan close, semuanya dengan animasi
	local mini = mk("ImageButton", {Size = UDim2.new(0, 42, 0, 42), Position = UDim2.new(0, 10, 0, 40), BackgroundColor3 = BG, Image = "rbxassetid://128967992287891", ScaleType = Enum.ScaleType.Fit, AutoButtonColor = false, Visible = false}, gui)
	rnd(mini, 14); mk("UIStroke", {Color = BRD, Thickness = 1}, mini)
	S.ui.mini = mini
	local function minimkan()
		mini.Position = root.Position
		TS:Create(root, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {GroupTransparency = 1}):Play()
		TS:Create(S.ui.skalaUI, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Scale = S.skala * 0.92}):Play()
		task.delay(0.19, function()
			root.Visible = false
			mini.ImageTransparency = 1
			mini.Visible = true
			TS:Create(mini, TI, {ImageTransparency = 0}):Play()
		end)
	end
	local function pulihkan()
		mini.Visible = false
		root.Visible = true
		root.GroupTransparency = 1
		S.ui.skalaUI.Scale = S.skala * 0.92
		gui.Enabled = true; root.Visible = true; TS:Create(root, TI, {GroupTransparency = 0}):Play()
		TS:Create(S.ui.skalaUI, SPRING, {Scale = S.skala}):Play()
	end
	bMin.MouseButton1Click:Connect(function() task.spawn(F.aman, minimkan) end)
	geser(mini, mini, function() task.spawn(F.aman, pulihkan) end)
	bX.MouseButton1Click:Connect(function()
		task.spawn(F.aman, function()
			TS:Create(root, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {GroupTransparency = 1}):Play()
			TS:Create(S.ui.skalaUI, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {Scale = S.skala * 0.92}):Play()
			task.wait(0.17)
			F.tutup()
		end)
	end)

	if S.hideConn then S.hideConn:Disconnect() end
	S.hideConn = UIS.InputBegan:Connect(function(i, gp) if not gp and i.KeyCode == S.hideKey then gui.Enabled = not gui.Enabled end end)

	-- muncul dengan pegas (membal sedikit) saat dibuka
	local PEGAS = TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	gui.Enabled = true; root.Visible = true
	TS:Create(root, PEGAS, {GroupTransparency = 0}):Play()
	TS:Create(S.ui.skalaUI, SPRING, {Scale = S.skala}):Play()
	-- pengaman: kalau animasi buka gagal jalan, panel tetap dipaksa terlihat (kecuali sedang diminimize)
	task.delay(0.6, function()
		if root.Parent and not S.ui.mini.Visible then root.Visible = true; root.GroupTransparency = 0 end
	end)

	-- hover & tekan untuk semua tombol (termasuk yang dibuat belakangan)
	for _, d in ipairs(gui:GetDescendants()) do
		if d:IsA("TextButton") then pasangEfek(d) end
	end
	gui.DescendantAdded:Connect(function(d)
		if d:IsA("TextButton") then task.defer(pasangEfek, d) end
	end)
	F.catat("siap. ZENOX LARPER v11 jalan")
end

-- =====================================================================
-- BOOT / EXECUTION
-- =====================================================================
local ok, err = xpcall(function()
    task.wait(0.3)
    if not bangunKunci() then return end
    for _, a in ipairs(C.AKSES) do F.addItem(a[1], a[2], "akses").builtin = true end
    for _, g in ipairs(C.GEAR) do F.addItem(g[1], g[2], "gear").builtin = true end
    bangunUtama()
    F.jalanPantau()
    F.skinMuat()
    for _, it in ipairs(S.items) do if it.kind == "gear" and not it.tpl then task.spawn(F.gearMuatTas, it) end end
end, function(e)
    return tostring(e) .. "\n" .. debug.traceback()
end)

if not ok then
    warn("[ZENOX] UI ERROR: " .. tostring(err))
    -- kalau build UI sempat gagal di tengah jalan, tetap paksa panel yang sudah jadi terlihat
    pcall(function()
        local g = S.ui and S.ui.gui
        if g then
            g.Enabled = true
            for _, c in ipairs(g:GetChildren()) do
                if c:IsA("CanvasGroup") then c.Visible = true; c.GroupTransparency = 0 end
            end
        end
    end)
    F.notif("ZENOX ERROR", tostring(err):sub(1, 190), 15)
    local p = me:WaitForChild("PlayerGui")
    local g = Instance.new("ScreenGui", p); g.Name = "ZenoxError"
    local t = Instance.new("TextButton", g); t.Size = UDim2.new(0.85, 0, 0, 200); t.Position = UDim2.new(0.075, 0, 0.5, -100); t.BackgroundColor3 = BLK; t.TextColor3 = BAD; t.Font = Enum.Font.Code; t.TextSize = 12; t.TextWrapped = true; t.Text = "ZENOX ERROR:\n" .. tostring(err); t.Parent = g
end