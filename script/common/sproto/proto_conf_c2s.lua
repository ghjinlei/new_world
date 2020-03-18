conf = [[
.pairValue{
	t_integer 0 : integer
	t_string 1 : string
	t_boolean 2 : boolean
}

.teamApplyList {
	Name 0 : string
	Level 1 : integer
	UserId 2 : string
	TypeId 3 : integer
	Race 4 : integer
	IconPath 5 : string
	CombatPower 6 : integer
}

.keyValuePair{
	key 0 : string
	value 1 : pairValue
}

.simpleHashTable{
	pairs 0 : *keyValuePair
}

.package {
	type 0 : integer
	session 1 : integer
}

.position {
	x 0 : integer
	y 1 : integer
	z 2 : integer
}

.teamData {
	typeId 	0 : integer
	level 	1 : string
	name 	2 : string
	userId  3 : string
	vip	4 : integer
	race	5 : integer
	combatPower 6 : integer
}

.buddyProfile {
	SlotIdx		0 : integer
	TypeId		1 : integer
	Level		2 : integer
	Quality		3 : integer
	Star		4 : integer
	Combat		5 : integer
	SubLevel	6 : integer
}

.GSQueryRankRow {
	key		0 : string
	uniKey		1 : string
	cols		2 : *string
	teamData	3 : *teamData
	LaunchFrom  4 : integer
	QQVipType   5 : integer
	BuddyMap	6 : *buddyProfile
}

.itemTarget {
	UserType	0 : integer
	UserValue	1 : string
}

.title {
	titleId 0 : integer
	param 	1 : string
}

.titleInfo {
	titleId 	0 : integer
	Title		1 : title
	LifeTime	2 : string
}

.buddyInfo {
	Level	0 : integer
	Star 	1 : integer
	TypeId 	2 : integer
}

.rivalData {
	BuddyMap 	0 : *buddyInfo
	Combat 		1 : integer
	Icon 		2 : string
	Level 		3 : integer
	Name 		4 : string
	Rank 		5 : integer
	TypeId 		6 : integer
	UserId 		7 : string
}

.ItemData {
	TypeId		0 : integer
	Amount		1 : integer
	IsBind		2 : boolean
	Star		3 : integer
	Addition	4 : integer
	EffectList	5 : *integer
	GemEmbedKeyList 6 : *integer
	GemEmbedValueList 7 : *integer
	RefAttrKeyList	8 : *string
	RefAttrValueList 9 : *integer
	Status		10 : integer
	Level		11 : integer
	Aptitude	12 : integer
	Standby		13 : boolean
}

.buddyMapItem {
	sid 		0 : string
	position 	1 : integer
}

.tiantiLog {
	Icon 		0 : string
	IsWin 		1 : boolean
	Level 		2 : integer
	Time 		3 : string
	Type 		4 : integer
	UserName 	5 : string
}

.friendInfoItem {
	Level 		0 : integer
	LoginTime 	1 : integer
	LogoutTime 	2 : integer
	Name 		3 : string
	TypeId 		4 : integer
	UserId 		5 : string
	GuildName	6 : string
	CanIntrude	7 : boolean
	CanVisit	8 : boolean
	FamilyId	9 : string
	CombatPower	10 : integer
}

.interactionUserInfo {
	IconPath 	0 : string
	IsOnline 	1 : boolean
	Level 		2 : integer
	Name 		3 : string
	TypeId 		4 : integer
	UserId 		5 : string
	CombatPower 	6 : integer
	GuildName	7 : string
	PartnerName	8 : string
	Sex		9 : integer
	TianzhuId	10 : integer
	Vip		11 : integer
	ForbidPhotoTime 12 : integer
	FamilyName 	13 : string
	HideVip		14 : boolean
}

.actionItem {
	Id 		0 : integer
	Name 	1 : string
}

.buddyDataItem {
	SId 	0 : string
	TypeId 	1 : integer
}

default_call 1 {
	request {
		msgData 0 : string
	}
	response {
		msgData 0 : string
	}
}

default_send 2 {
	request {
		msgData 0 : string
	}
}

SCENE_GS01Move 3 {
	request {
		SceneId  0 : integer
		EntityId 1 : integer
		pos      2 : position
		rot      3 : integer
	}
}

SCENE_GS01DoAction 4 {
	request {
		SceneId  0 : integer
		EntityId 1 : integer
		ActionId 2 : integer
	}
}

GSOCK_GS01Beat 5 {
	request {
	}

	response {
		sec 0 : integer
		usec 1 : integer
	}
}

AOI_Change 6 {
	request {
		AddIds		0 : *integer
		RemoveIds	1 : *integer
	}
}

GS01EnterGame 8 {
	request {
	}
	response {
	}
}

GS01UserLogout 9 {
	request {
		back2selectUser 0 : boolean
	}
}

GSUserInit 12 {
	request {
		initKey 0 : integer
		nickName 1 : string
	}

	response {
		success 0 : boolean
		msgId 1 : integer
	}
}

GSRandomName 13 {
	request {
	}
	response {
		randomX 0 : integer
		randomM 1 : integer
	}
}

GSQueryRank 14 {
	request {
		rankId 0 : integer
		pageIndex 1 : integer
	}
	response {
		rankId 		0 : integer
		startIndex 	1 : integer
		userData 	2 : *string
		rows 		3 : *GSQueryRankRow
	}
}

HandShake 15 {
	request {
		Channel				0 : integer
		Platform			1 : string
		PlatformId			2 : string
		Version				3 : string
		DeviceId			4 : string
		DeviceType			5 : string
		ChannelData			6 : string
		MsgPackDictMD5		7 : string
		isRobot				8 : boolean
		DeviceMode			9 : string
		OpSystem			10 : string
		RAM 				11 : integer
		GraphicDeviceName	12 : string
		ProcessorType		13 : string
		GraphicDeviceMem	14 : integer
		ShaderDev			15 : boolean
		DrawCallDev			16 : boolean
		AppId				17 : string
		ServerStartTime		18 : integer
		pf					19 : string
		OS					20 : string
		NetType				21 : integer
		NetOpType			22 : integer
		GameVersion			23 : string
		InstallChannelId	24 : integer
		LaunchFrom			25 : integer
		ServerId			26 : integer
		IMEI				27 : string
		IDFA				28 : string
		SessionId			29 : string
	}

	response {
		ok					0 : boolean
		msg					1 : string
		rsaPubN				2 : string
		rsaPubE				3 : string
		salt				4 : string
		patch				5 :string
		server_sec			6 : integer
		server_usec			7 : integer
		ServerStartTime		8 : integer
		ServerStartDateTime	9 : integer
	}
}

Auth 16 {
	request {
		isRobot    		0 : boolean
		blob		    1 : *string
	}

	response {
		ok 0 : boolean
		isdev 1 : boolean
		msg 2 : string
	}
}

GetMyCharObj 17 {
	request {
		charTime    	0 : integer
		innerId		    1 : integer
	}
}

GetOtherCharObj 18 {
	request {
		charTime    	0 : integer
		sId		    	1 : string
	}
}

GetMyCharObjByKeyMap 19 {
	request {
		innerId    		0 : integer
		keyLst		    1 : *string
	}

	response {
		packValLst		0 : *string
	}
}

GetOtherCharObjByKeyMap 20 {
	request {
		sId		    	0 : string
		keyLst		    1 : *string
	}

	response {
		packValLst		0 : *string
	}
}

CHAR_GS01GetData 21 {
	request {
		sId				0 : string
		charTime		1 : integer
	}
}

CHAR_GS01GetDataByKeyMap 22 {
	request {
		sId				0 : string
		keys			1 : *string
	}
}

ACHIEVEMENT_GS01GetAchievementData 23 {
	request {
	}
}

ACHIEVEMENT_GS01GetReward 24 {
	request {
        achId 0: integer
	}

	response {
		bVar 0 : boolean
	}
}

ACTIVITY_GS01GetDetailData 25 {
	request {
        activityId 0: string
	}
	response {
		detail 0 : string
	}
}

ACTIVITY_GS01OpenBox 26 {
	request {
        boxId 0: integer
	}
	response {
		bVar 0 : boolean
	}
}

ACTIVITY_GS01GotoActivity 27 {
	request {
        activityId 0: string
	}
}

ACTIVITY_GS01ReceiveReward 28 {
	request {
        activityId 0: string
	}
	response {
		bVar 0 : boolean
	}
}

ARENA_FIELD_GS01Prepare 29 {
	request {
	}
}

ARENA_FIELD_GS01CancelPrepare 30 {
	request {
	}
}

AUTO_FIGHT_CONTROLLER_GS01LockSkillOnce 35 {
	request {
        sceneId 0: integer
        entityId 1: integer
        skillId 2: integer
	}
}

BAGUA_GS90DumpEquipedBagua 36 {
	request {
	}
}

BAGUA_GS01DoEquip 40 {
	request {
		baguaSId 0: string
		slotId 1: integer
	}
	response {
		success 0 : boolean
	}
}

BAGUA_GS01DoSwallow 41 {
	request {
		mainSId 0: string
		subSIdMap 1: *string
	}
	response {
		bVar 0 : boolean
	}
}

BAGUA_GS01UnEquip 42 {
	request {
		baguaSId 0: string
		slotId 1: integer
	}
	response {
		success 0 : boolean
	}
}

BATTLE_ENTITY_BUDDY_GS01SingleFire 46 {
	request {
        sceneId 0: integer
        entityId 1: integer
	}
}

BATTLE_ENTITY_BUDDY_GS01RunTo 47 {
	request {
        sceneId 0: integer
        entityId 1: integer
        position 2: position
	}
}

BATTLE_ENTITY_BUDDY_GS01LockSkillOnce 48 {
	request {
        sceneId 0: integer
        entityId 1: integer
        skillId 2: integer
	}
}

BATTLE_ENTITY_BUDDY_GS01Fire 49 {
	request {
	}
}

BATTLE_ENTITY_HERO_GS01StartJoystick 50 {
	request {
	}
}

BATTLE_ENTITY_HERO_GS01StopJoystick 51 {
	request {
	}
}

BATTLE_ENTITY_HERO_GS01PointMember 52 {
	request {
		entityId 0: integer
	}
}

BATTLE_ENTITY_HERO_GS01AutoFight 53 {
	request {
		autoFightType 0: integer
	}
	response {

	}
}

BATTLE_ENTITY_WARRIOR_GS01CastNormalSkill 54 {
	request {
        sceneId 0: integer
        entityId 1: integer
	}
}

BATTLE_ENTITY_WARRIOR_GS01ActiveSkill 55 {
	request {
        sceneId 0: integer
        entityId 1: integer
        skillTypeId 2: integer
	}
}

BATTLE_ENTITY_WARRIOR_GS01MoveInterrupt 56 {
	request {
        sceneId 0: integer
        entityId 1: integer
        skillTypeId 2: integer
	}
}

BATTLE_ENTITY_WARRIOR_GS01CastRageSkill 57 {
	request {
        sceneId 0: integer
        entityId 1: integer
        skillParams 2: *integer
	}
}

BATTLE_ENTITY_WARRIOR_GS01CastSkill 58 {
	request {
        sceneId 0: integer
        entityId 1: integer
        skillTypeId 2: integer
        level 3: integer
        skillParams 4: *integer
	}
}

BATTLE_ENTITY_WARRIOR_GS01InactiveSkill 59 {
	request {
        sceneId 0: integer
        entityId 1: integer
        skillTypeId 2: integer
	}
}

BATTLE_SKILL_GS90ResetCD 60 {
	request {
	}
}

BUDDY_GS01Summon 67 {
	request {
        typeId 0 : integer
	}
	response {
		SId 0 : string
	}
}

BUDDY_GS01ShowBuddyInfoFinish 68 {
	request {
        buddyTypeId 0: integer
	}
}

BUDDY_GS01Star 70 {
	request {
        sId 0: string
        star 1: integer
	}
}

BUDDY_GS01UnlockLevel 71 {
	request {
		typeId 0: integer
	}
	response {
		level 0 : integer
	}
}

BUDDY_GS01ExpUp 72 {
	request {
        buddySId 0: string
        consumeSIdList 1: *string
	}
	response {
		bVar 0 : boolean
	}
}

BUDDY_GS01Standby 73 {
	request {
        sId 0: string
        flag 1: boolean
        tips 2: boolean
	}
}

BUDDY_GS01ExpStarUp 74 {
	request {
        buddySId 0: string
        consumeSIdList 1: *string
	}
	response {
		bVar 0 : boolean
	}
}

BUDDY_GS01Lock 75 {
	request {
        sId 0: string
        flag 1: boolean
	}
}

BUDDY_GS01UnlockStory 76 {
	request {
        sId 0: string
        idx 1: integer
	}
	response {
		bVar 0 : boolean
	}
}

BUDDY_GS01SkillLevelUp 77 {
	request {
        sId 0: string
        skillTypeId 1: integer
	}
	response {
		bVar 0 : boolean
	}
}

BUDDY_GS90Dump 78 {
	request {
        typeId 0: integer
	}
}

BUDDY_GS01DoAddExp 79 {
	request {
        sId 0: string
        expWay 1: integer
        times 2: integer
	}
}

BUDDY_GS01BuyEquipment 80 {
	request {
	}
}

CHARGE_GS01GainRebate 82 {
	request {
		rebateId 0: integer
	}
}

CHAT_GS01SpeakPrivate 83 {
	request {
		to 0: string
		audioId 1: string
		duration 2: integer
		msg 3: string
	}
}

CHAT_GS01GetUserAutoReplyData 84 {
	request {
	}
}

CHAT_GS01SetAutoReplyAudio 85 {
	request {
		audioId 0: string
		duration 1: integer
	}
}

CHAT_GS01SetAutoReplyMsg 86 {
	request {
		msg 0: string
	}
}

CHAT_GS01SayPrivate 87 {
	request {
		to 0: string
		msg 1: string
		isHref 2: boolean
	}
}

CHAT_GS01Say 88 {
	request {
		channel 0: integer
		msg 1: string
		isHref 2: boolean
	}
}

CHAT_GS01Speak 89 {
	request {
		channel 0: integer
		audioId 1: string
		duration 2: integer
		msg 3: string
	}
}

CHAT_GS01SetUserAutoReplyFlag 90 {
	request {
		flag 0: boolean
	}
}

CHAT_GS01SetUserStrangerTalkFlag 91 {
	request {
		flag 0: boolean
	}
}

CHECKIN_NEW_GetMonthReward 93 {
	request {
	}
	response {
		bVar 0: boolean
	}
}

CHECKIN_NEW_GetBuQian 95 {
	request {
	}
	response {
		bVar 0: boolean
	}
}

CHECKIN_NEW_GetGiftReward 96 {
	request {
		key 0: string
	}
	response {
		bVar 0: boolean
	}
}

DEFENCE_GS01SetBuddyList 97 {
	request {
		key 0: string
		list 1: *string
	}
}

EQUIPMENT_GS01UpgradeStar 110 {
	request {
		equipSId 0: string
		star 1: integer
		matSIdList 2: *string
		matAmtList 3: *integer
		buyTypeIdList 4: *integer
		buyAmtList 5: *integer
		runeTypeId 6: integer
	}
	response {
		success 0: boolean
	}
}

EQUIPMENT_GS01UpgradeAddition 100 {
	request {
		equipSId 0: string
		addition 1: integer
		matSIdList 2: *string
		matAmtList 3: *integer
		buyTypeIdList 4: *integer
		buyAmtList 5: *integer
	}
	response {
		success 0: boolean
	}
}

EQUIPMENT_GS01UpgradeLevel 101 {
	request {
		equipSId 0: string
		matSIdList 1: *string
		inherit 2: integer
	}
	response {
		success 0: boolean
	}
}

EQUIPMENT_GS01UpgradeDegree 102 {
	request {
		equipSId 0: string
		matSIdList 1: *string
		inherit 2: integer
	}
	response {
		success 0: boolean
	}
}

EQUIPMENT_GS01Inherit 111 {
	request {
		oldEquipSId 0: string
		newEquipSId 1: string
		inherit 3: integer
	}
	response {
		success 0: boolean
	}
}

EQUIPMENT_GS01Refine 114 {
	request {
		equipSId 0: string
		refineId 1: integer
		resComp 2: boolean
	}
	response {
		success 0: boolean
	}
}


EQUIPMENT_GS01ReplaceRefineAttr 115 {
	request {
		equipSId 0: string
	}
	response {
		success 0 : boolean
	}
}

EQUIPMENT_GS01Recast 116 {
	request {
		equipSId 0: string
		genEquipTypeId 1: integer
	}
	response {
		success 0 : boolean
	}
}

EQUIPMENT_GS01Smelt 118 {
	request {
		equipSIdList 0: *string
	}
	response {
		success 0: boolean
	}
}

EQUIPMENT_GS01Unbind 119 {
	request {
		equipSId 0: string
	}
	response {
		success 0: boolean
	}
}

SYNTHESIS_GS01Synthesis 120 {
	request {
		typeId 0: integer
		amount 1: integer
		matSIdList 2: *string
		matAmtList 3: *integer
		buyTypeIdList 4: *integer
		buyAmtList 5: *integer
	}
	response {
		success 0: boolean
	}
}

FREE_POINT_GS01ResetFreePoint 123 {
	request {
	}
}

FREE_POINT_GS01GetFreePointData 125 {
	request {
	}
	response {
		InitLevel 0 : integer
	}
}

FREE_POINT_GS01GetMaxFreePoint 126 {
	request {
	}
	response {
		pointLimit 0 : integer
	}
}

FRIEND_CMD_GS01MakeFriendsRequestByList 130 {
	request {
		friendIdList 0: *string
	}
}

FRIEND_CMD_GS01RenameTag 131 {
	request {
		tagName 0: string
		newTagName 1: string
	}
	response {
		bVar 0 : boolean
	}
}

FRIEND_CMD_GS01AddTag 133 {
	request {
		TagName 0 : string
	}
	response {
		bVar 0 : boolean
	}
}

FRIEND_CMD_GS01InteractFriend 134 {
	request {
		friendId 0: string
	}
	response {
		bVar 0 : boolean
	}
}

FRIEND_CMD_GS01RemoveTag 135 {
	request {
		tagName 0: string
	}
	response {
		bVar 0 : boolean
	}
}

FRIEND_CMD_GS01MakeFriendsConfirmResponse 136 {
	request {
		requestUserId 0: string
		isPass 1: boolean
	}
}

FRIEND_CMD_GS01RecommendUser 137 {
	request {
	}
}

FRIEND_CMD_GS01MakeFriendsRequest 141 {
	request {
		friendId 0: string
	}
}

FRIEND_CMD_GS01AddFriendTag 142 {
	request {
		friendId 0: string
		tagName 1: string
	}
	response {
		bVar 0 : boolean
	}
}

FRIEND_CMD_GS01RemoveFriendTag 143 {
	request {
		friendId 0: string
		tagName 1: string
	}
	response {
		bVar 0 : boolean
	}
}

.friendlyInfo {
	Name 0: string
	ReqValue 1: string
}

FRIENDLY_GS01GetFriendlyInfoMap 146 {
	request {

	}
	response {
		friendlyInfoMap 0: *friendlyInfo
	}
}

FRIENDLY_GS01GiveGift 147 {
	request {
		targetUserId 0: string
		giftId 1: integer
		amount 2: integer
		sessionId 3:integer
	}
}

FRIENDLY_GS01GetFriendly 149 {
	request {
		targetUserId 0: string
	}
	response {
		friendly 0 : integer
	}
}

FUBEN_GS01GetMeterDataMap 152 {
	request {
	}
	response {
		User 0 : string
		Buddy 1 : string
	}
}

FUBEN_GS01Pick 153 {
	request {
		typeId 0: integer
		difficulty 1: integer
	}
}

FUBEN_GS01GiveupPrepare 154 {
	request {
		prepareId 0: integer
	}
}

FUBEN_GS01CloseCountResult 155 {
	request {
	}
}

FUBEN_GS90CreateEntity 156 {
	request {
		typeString 0: string
		id 1: integer
	}
}

FUBEN_GS01Prepare 158 {
	request {
		prepareId 0: integer
		flag 1: boolean
	}
}

FUBEN_GS01CloseBox 159 {
	request {
	}
}

FUBEN_GS01Leave 160 {
	request {
	}
}

GEM_GS01Inlay 166 {
	request {
		equipSId 0: string
		gemSId 1: string
		holeId 2: integer
	}
	response {
		success 0 : boolean
	}
}

GEM_GS01Unlay 167 {
	request {
		equipSId 0: string
		holeId 1: integer
	}
	response {
		success 0 : boolean
	}
}

GEM_GS01Smelt 168 {
	request {
		gemSId1 0: string
		gemSId2 1: string
		gemSId3 2: string
	}
	response {
		TypeId 0 : integer
	}
}

GEM_GS01Remould 169 {
	request {
		gemSId 0: string
		resComp 1: boolean
	}
	response {
		TypeId 0 : integer
	}
}

.guildApply {
	UserId 0 : string
	TypeId 1 : integer
	Level 2 : integer
	Name 3 : string
	Power 4 : integer
	Time 5 : integer
}
GUILD_COMMAND_GS01GetApplyList 171 {
	request {
		idValue 0 : integer
	}
	response {
		Map 0 : *guildApply
		Id 1 : integer
	}
}

GUILD_COMMAND_GS01EasyApply 172 {
	request {
	}
	response {
		Map 0 : string
	}
}

GUILD_COMMAND_GS90AutoFire 173 {
	request {
	}
}

GUILD_COMMAND_GS90DailyRefresh 174 {
	request {
	}
}

GUILD_COMMAND_GS90ResetCreateGuildTime 175 {
	request {
	}
}

GUILD_COMMAND_GS01OpenCreed 176 {
	request {
	}
	response {
		result 0: boolean
		needFund 1:integer
	}
}

GUILD_COMMAND_GS01OpenGuild 177 {
	request {
		IdMap 0 : *integer
	}
	response {
	}
}

GUILD_COMMAND_GS01ModifyCreed 178 {
	request {
		content 0: string
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01Apply 180 {
	request {
		guildId 0: integer
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01KickMember 181 {
	request {
		targetUserId 0: string
	}
}

GUILD_COMMAND_GS01Fire 184 {
	request {
		targetUserId 0: string
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01ClearApplyList 185 {
	request {
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01SwitchTitle 186 {
	request {
		targetUserId 0: string
		star 1: integer
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01RemoveApplicant 187 {
	request {
		applicantId 0: string
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01GoTo 188 {
	request {
		key 0: string
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01AcceptApplicant 190 {
	request {
		applicantId 0: string
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01GoToGuildField 192 {
	request {
	}
}

GUILD_COMMAND_GS01RevokeApply 193 {
	request {
		list 0: *integer
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01AcceptAll 194 {
	request {
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01Resign 195 {
	request {
	}
}

GUILD_COMMAND_GS01OpenMessage 199 {
	request {
	}
	response {
		bVar 0 : boolean
		needFund 1:integer
	}
}

GUILD_COMMAND_GS01LeaveGuild 200 {
	request {
	}
	response {
	}
}

GUILD_COMMAND_GS01SendMessage 202 {
	request {
		content 0: string
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01TouchActivity 203 {
	request {
		key 0: string
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01Appoint 204 {
	request {
		targetUserId 0: string
		position 1: integer
	}
	response {
		bVar 0 : boolean
	}
}

GUILD_COMMAND_GS01GetGuildDataInChar 205 {
	request {
	}
	response {
		Name 0 : string
		TitleName 1 : string
	}
}

GUILD_COMMAND_GS01CreateGuild 206 {
	request {
		name 0: string
		creed 1: string
		logo 2: string
	}
	response {
		bVar 0 : boolean
	}
}

MAIL_GS01GetMailDataById 208 {
	request {
		mailId 0 : string
	}
	response {
		bVar 0 : boolean
	}
}

MAIL_GS01GetMailListReward 209 {
	request {
		mailIdList 0 : *string
	}
	response {
		Map 0 : *string
	}
}

HOME_GS01QuickHarvest 238 {
	request {
		factoryType 0 : string
	}
	response {
	}
}

HOME_GS01HomeFight 239 {
	request {
	}
}

HOME_GS01QuickProduce 240 {
	request {
		factoryType 0 : string
	}
}

HOME_GS01FactoryUpgrade 241 {
	request {
		factoryType 0 : string
	}
	response {
	}
}

HOME_GS01Harvest 242 {
	request {
		factoryType 0 : string
	}
}

HOME_GS01IntrudeHome 243 {
	request {
		homeMasterId 0: string
	}
}

HOME_GS01GoHome 244 {
	request {
	}
}

HOME_GS01Produce 245 {
	request {
		factoryType 0 : string
	}
	response {
	}
}

HOME_GS01HomeUpgrade 248 {
	request {
	}
}

HUODONG_GS01ReqActivityList 249 {
	request {
		deviceType 0: integer
	}
}

HUODONG_GS01ReqReward 250 {
	request {
		actKey 0: string
		rewardKey 1: string
		deviceType 2: integer
	}
}

HUODONG_GS01ReqActivityByKey 251 {
	request {
		actKey 0: integer
		deviceType 1: integer
	}
}

HUODONG_GS01ReSingin 252 {
	request {
	}
}

CHAT_CreateNewItemDesc 253 {
	request {
		itemSId 0:string
	}
	response {
		descId 0:string
	}
}

TSS_AntiHackerPkg 254 {
	request {
		PkgData 0:string
	}
}

ITEM_GAIN_WAY_GS01GotoGainWay 259 {
	request {
		gainWayId 0: integer
		itemTypeId 1: integer
	}
}

JINGMAI_GS01GetOpenLevel 262 {
	request {
	}
	response {
		level 0 : integer
	}
}

JINGMAI_GS01Grow 263 {
	request {
		main 0: integer
		branch 1: integer
		idx 2: integer
	}
}

LOADBAR_GS01Interrupt 264 {
	request {
		oid 0: integer
	}
}

LOADBAR_GS01Loadbar 265 {
	request {
		oid 0: integer
	}
}

MAIL_GS01RemoveMail 269 {
	request {
		mailId 0: string
	}
}

MAIL_GS01ReadMarkByType 270 {
	request {
		mailType 0: integer
	}
	response {
		bVar 0 : boolean
	}
}

MAIL_GS01ReadMarkById 271 {
	request {
		mailId 0: string
	}
	response {
		bVar 0 : boolean
	}
}

MAIL_GS01GetMailReward 273 {
	request {
		mailId 0: string
	}
	response {
		bVar 0 : boolean
	}
}

MAIL_GS01RemoveMailList 274 {
	request {
		mailIdList 0: *string
	}
}

NEIGONG_GS01GetAttr 275 {
	request {
	}
}

NEIGONG_GS01Advance 276 {
	request {
	}
	response {
		bVar 0 : boolean
	}
}

NEIGONG_GS01Open 278 {
	request {
	}
}

PACKAGE_GS01UnlockSlot 280 {
	request {
		packageType 0: integer
		slotId 1: integer
		resAmount 2: integer
	}
	response {
		success	0 : boolean
	}
}

PACKAGE_GS01LoadItemMap 281 {
	request {
		packageTypeList 0: *integer
	}
}

.moveOpt {
	SrcSlotId 0: integer
	SrcItemSId 1: string
	DstSlotId 2: integer
	DstItemSId 3: string
}
PACKAGE_GS01MoveItem 282 {
	request {
		srcPackageType 0: integer
		dstPackageType 1: integer
		moveOptList 2 : *moveOpt
	}
}

PACKAGE_GS01SplitItem 283 {
	request {
		srcPackageType 0: integer
		itemSId 1: string
		dstPackageType 2: integer
		dstSlotId 3 : integer
		amount 4: integer
	}
}

PACKAGE_GS01ArrangeItem 284 {
	request {
		packageType 0: integer
	}
}

PACKAGE_CheckItemState 285 {
	request {
		packageType 0: integer
		itemSIdList 1: *string
	}
}

PAY_GS01CheckPay 286 {
	request {
		billId 0: string
		platformName 1: string
		params 2: integer
	}
	response {
	}
}

PAY_GS01CheckBill 288 {
	request {
		billId 0: string
	}
	response {
		bVar	0 : boolean
	}
}

TIANTI_GS01SetDefenceTeam 289 {
	request {
        buddyMap 0: *buddyMapItem
	}
}

TIANTI_GS01GetLogList 290 {
	request {
	}
	response {
		logList	0 : *tiantiLog
	}
}

TIANTI_GS01RequestChallenge 291 {
	request {
        rivalRank 0: integer
        sessionId 1: integer
	}
	response {

	}
}

TIANTI_GS01GetDefenceTeam 292 {
	request {
	}
	response {
		buddyMap	0 : *buddyMapItem
	}
}

TIANTI_GS01GetPersonalRankData 293 {
	request {
	}
	response {
		data	0 : integer
	}
}

TIANTI_GS01GetRivalDataMap 294 {
	request {
	}
	response {
		rivalDataMap	0 : *rivalData
	}
}

TITLE_GS01SetTitle 296 {
	request {
        titleId 0: integer
        isActive 1: boolean
        opField 2:integer
	}
	response {
		result	0 : boolean
		textId 1:integer
	}
}

TITLE_GS01GetTitleMap 297 {
	request {
	}
	response {
		titleInfoMap	0 : *titleInfo
	}
}

UI_MENU_GS01Menu 299 {
	request {
        oid 0: integer
        key 1: integer
        data 2: integer
	}
}

UI_MENU_GS01MenuTimeOut 300 {
	request {
        oid 0: integer
	}
}

UI_MENU_GS01MenuCancel 301 {
	request {
        oid 0: integer
	}
}

USER_GS01UseItem 302 {
	request {
        sIdList 0: *string
	useAmtList 1: *integer
        useKey 2: string
        target 3: itemTarget
	.UseParmas {
		UseType 0: integer
	}
	params 4: UseParmas
	}
}

USER_GS01UpdateAttrMap 303 {
	request {
	}
}

USER_GS01DelItem 304 {
	request {
		itemSId 0: string
	}
}

USER_GS01CheckPackage 306 {
	request {
	}
	response {
	}
}

USER_GS01UpdateAutoFightSkillMap 307 {
	request {
		.SkillSettingData {
			skillId 0 : integer
			open 1: boolean
		}
		SkillSettings 0: *SkillSettingData
	}
}

USER_GS01ResourceFunc 308 {
	request {
		resourceType 0: integer
	}
}

USER_GS01Rename 309 {
	request {
		newName 0: string
		isBoardcast 1: boolean
		useItem		2: boolean
	}
	response {
		is_succeed 0: boolean
	}
}

USER_GS01SetBattleSkillMap 310 {
	request {
		manualcast 0: integer
		data 1: *integer
	}
}

USER_GS01SkillLevelUp 311 {
	request {
		skillTypeId	0 : integer
		isNormal	1 : boolean
	}
	response {
		is_succeed  0: boolean
	}
}

UPVOTE_Upvote 312 {
	request {
		rankId	0: integer
		uniKey	1: string
	}
	response {
		ret 0: boolean
	}
}

TOUGONG_GS01PickBaoXiang 313 {
	request {
		key	0: integer
	}
	response {
		ret 0: boolean
	}
}

FASHION_ChangeFashion 314 {
	request {
		fashionId	0: integer
	}
	response {
		ret 0: boolean
	}
}

DAILY_TEST_GetReward 316 {
	request {
		Question 0 : integer
		Answer 1 : integer
	}
	response {
		bVar 0 : boolean
		Correct 1 : *integer
		status 2 : integer
	}
}

SCENE_Revive 318 {
	request {
		Type 0 : integer
		SessionId 1: integer
	}
}

BATTLE_ENTITY_WARRIOR_JumpInterrupt 319 {
	request {
	sceneId 0: integer
	entityId 1: integer
	skillTypeId 2: integer
	}
}

USER_GS01SkillGradeLevelUp 325 {
	request {
		skillTypeId	0 : integer
		isNormal	1 : boolean
	}
	response {
		is_succeed  0: boolean
	}
}


QINGGONG_GS01GetContentMap 335 {
	request {
	}
	response {
		StarAttrMap 0 : string
		StarExpMap 1 : string
		AttrIdList 2 : string
		UnitMap 3 : string
		QinggongMap 4 : string
		ExpWayMap 5 : string
		Config 6 : string
	}
}

QINGGONG_GS01GetOpenLevel 336 {
	request {
	}
	response {
		level 0: integer
	}
}

QINGGONG_GS01DoAddExp 338 {
	request {
		expWay 0: integer
		times 1: integer
	}
	response {
		CurStarId 0: integer
		CurExp 1: integer
	}
}

QINGGONG_GS01GetCurStarIdAndExp 339 {
	request {
	}
	response {
		CurStarId 0: integer
		CurExp 1: integer
	}
}

SCENE_GS01Prepared 346 {
	request {
		sceneId 0: integer
	}
	response {
		bVar 0: boolean
	}
}

SCENE_GS90CreateEntity 348 {
	request {
		entityTypeId 0: integer
		entityOCI 1: integer
	}
}

SCENE_GS90KillAllMonster 349 {
	request {
	}
}

SCENE_GS01EndCamera 350 {
	request {
	}
}

SCENE_GS01MovePath 352 {
	request {
		sceneId 0: integer
		entityId 1: integer
		movePath 2: *position
	}
	response {
	}
}

SCENE_GS90KillEntity 353 {
	request {
		entityId 0: integer
	}
}

SCENE_GS01Talk 354 {
	request {
		sceneId 0: integer
		entityId 1: integer
	}
	response {
	}
}

SCENE_GS90ReviveAll 355 {
	request {
		percent 0: integer
	}
}

TEAM_COMMAND_GS01OpenInviteMenu 356 {
	request {
	}
}

TEAM_COMMAND_GS01GetTeamInfo 357 {
	request {
		teamId 0: integer
	}
}

TEAM_COMMAND_GS01GetUserTeamInfo 358 {
	request {
	}
}

TEAM_COMMAND_GS01Invite 359 {
	request {
		userId 0: string
		userIdList 1 : *string
		key 2 : integer
	}
}

TEAM_COMMAND_GS01SetGameplayTag 360 {
	request {
		gameplayTagName 0: string
		filterTagNameList 1: *integer
		professionMap 2: *integer
	}
}

TEAM_COMMAND_GS01AutoMatch 361 {
	request {
		gameplayTagName 0: string
		filterTagNameList 1: *integer
		professionMap 2: *integer
	}
}

TEAM_COMMAND_GS01SetBuddyPositionList 363 {
	request {
		list 0: *string
	}
}

TEAM_COMMAND_GS01AcceptUser 365 {
	request {
		applicantId 0: string
	}
}

TEAM_COMMAND_GS01DetachTeam 366 {
	request {
	}
}

TEAM_COMMAND_GS01ApplyTeam 367 {
	request {
		teamId 0: integer
	}
	response {
		retType 0: integer
	}
}

TEAM_COMMAND_GS01GetInviteDataList 368 {
	request {
		key 0: integer
	}
}

TEAM_COMMAND_GS01TeamStandby 369 {
	request {
	}
}

TEAM_COMMAND_GS01CleanApplyMap 370 {
	request {
	}
}

TEAM_COMMAND_GS01Ask 371 {
	request {
	}
	response {
		ret 0: integer
	}
}

TEAM_COMMAND_GS01LeaveTeam 372 {
	request {
	}
}

TEAM_COMMAND_GS01CreateTeam 373 {
	request {
	}
	response {
	}
}

TEAM_COMMAND_GS01BreakAway 374 {
	request {
	}
}

TEAM_COMMAND_GS01SyncPosition 375 {
	request {
		posList 0: integer
	}
}

TEAM_COMMAND_GS01GetApplyUserList 376 {
	request {

	}
	response {
		applyList 0: *teamApplyList
	}
}

TEAM_COMMAND_GS01ComeAfter 377 {
	request {
	}
}

TEAM_COMMAND_GS01IsLeader 378 {
	request {
		sceneId 0: string
		entityId 1: integer
	}
	response {
		bVar 0: boolean
	}
}

TEAM_COMMAND_GS01InviteUser 379 {
	request {
		inviteeId 0: string
	}
	response {
		bVar 0: boolean
	}
}

TASKUTIL_GS01TaskIntro 380 {
	request {
		senderId 0: string
		taskId 1: integer
	}
	response {
		Title 0 : string
		TargetWord 1 : string
		Desc 2 : string
	}
}

TASKUTIL_GS01CancelTask 381 {
	request {
		taskId 0: integer
	}
}

TASKUTIL_GS01SubmitItem 382 {
	request {
		taskId 0: integer
		sid 1: string
		amount 2: integer
	}
}

TASKUTIL_GS01DoWork 383 {
	request {
		mainTaskId 0: integer
		sign 1: string
		doingTaskId 2 : integer
	}
}

TASKUTIL_GS01GetTaskInfo 384 {
	request {
	}
}

TASKUTIL_GS01FinishWork 385 {
	request {
		mainTaskId 0: integer
		sign 1: string
		doingTaskId 2 : integer
	}
}

TASKUTIL_GS01TimeOut 386 {
	request {
		taskId 0: integer
		subDoingTaskId 1: integer
	}
}

SCENE_MANAGER_GS01TeleportToSceneByMap 387 {
	request {
		SceneProtoId 0 : integer
		Position 1 : position
		NpcId 2 : integer
		EntityId 3 : integer
	}
}

SCENE_MANAGER_GS01TeleportToScene 388 {
	request {
		toSceneProtoId 0: integer
	}
}

SCENE_MANAGER_GS01Connect 389 {
	request {
		sceneId 0: integer
	}
	response {
		err	0: integer
	}
}

BUDDY_GS01TransferSkill 393 {
	request {
		oSId 0 : string
		oSkillId 1 : integer
		tSId 2 : string
		tSkillId 3 : integer
	}
	response {
		ret 0: boolean
	}
}

SCENE_MANAGER_GetTrunkLineInfo 394 {
	request {
	}
	response {
		lineInfo 0: *integer
	}
}

SCENE_MANAGER_SwitchTrunkLine 395 {
	request {
		sceneId 0 : integer
		line 1 : integer
	}
}

YAOSHENHUOSHI_GetBossHpPercent 396 {
	request {
	}
	response {
		HpPercent 0: integer(2)
	}
}

PickDrop 397 {
	request {
		EntityIdLst 0: *integer
	}
}

PRACTICE_GS01ExchangePoint 408 {
	request {
		amount 0: integer
	}
	response {
		bVar 0: boolean
	}
}

PRACTICE_GS01ResetPoint 409 {
	request {
	}
	response {
		bVar 0: boolean
	}
}

PRACTICE_GS01DistributePoint 410 {
	request {
		pointMap 0: integer
	}
	response {
		bVar 0: boolean
	}
}

QINGHUA_GS01Prepare 411 {
	request {
	}
}

QINGHUA_GS01CancelPrepare 412 {
	request {
	}
}

QINGHUA_GS01PrepareTimeout 413 {
	request {
	}
}
QINGHUA_GS01SetConfirmed 414 {
	request {
		confirmId 0 : integer
		flag 1 : integer
	}
}

QINGHUA_GS01GiveupConfirm 415 {
	request {
		confirmId 0 : integer
	}
}

SHOP_GS01GetShopInfo 419 {
	request {
		shopName 0 : string
	}
	response {
		info 0 : string
	}
}

SHOP_GS01Buy 420 {
	request {
		shopName 0: string
		itemTypeId 1: integer
		count 2: integer
		coinType 3: integer
	}
	response {
	}
}

SKILL_GS01CostMp 422 {
	request {
		typeId 0: integer
		level 1: integer
	}
	response {
		mp 0: integer
	}
}

SKILL_GS90Level 425 {
	request {
		sId 0: integer
	}
	response {
		level 0: integer
	}
}

SKILL_GS01DetailDesc 426 {
	request {
		typeId 0: integer
		level 1: integer
	}
	response {
		description 0: string
	}
}

STORE_GS01IsPayEnable 428 {
	request {
	}
	response {
		bVar 0: boolean
	}
}

.memberData {
	Name 0: string
	Level 1: integer
	Race 2: integer
	Damage 3: string
	Rank 4: integer
}

GUILD_BOSS_GS01RequestRankData 429 {
	request {
	}

	response {
		rankdata 0: *memberData
		myrank 1: integer
	}
}


GUILD_BOSS_GS01RequestBossData 430 {
	request {

	}
	response {
		sceneId 0: integer
		entityId 1: integer
		hp 3: integer
		maxhp 4: integer
	}
}

JIANGJUNFU_GS01GetRankDataList 462 {
	request {
		gameLevel 0 : integer
	}
	response {
		RankDataList 0 : string
		UserInfoMap 1 : string
		PersonalData 2 : string
	}
}

USER_GS01BuddyNotifyClose 463 {
	request {
		typeId 0 : integer
	}
}

TOUGONG_DetailFunc 500 {
	request {
	}
	response {
		msg 0 : string
	}
}

GAMEPLAY_TEST_GS90StartFuben 504 {
	request {
		typeId 0: string
		difficulty 1: integer
	}
}

CMD_GS01GetServerCmdInfo 505 {
	request {
	}
	response {
		info 0 : string
	}
}

CMD_GS01ProcessWizcmdByClient 506 {
	request {
		cmd 0: string
	}
}

BACKEND_WENJUAN_GS01OpenWenJuan 507 {
	request {
	}
}

JUMP_GS01Prepare 520 {
	request {
	}
}

PK_GS01Challenge 528 {
	request {
	}
}

PK_GS01Search 529 {
	request {
		userNameOrUserId 0: integer
	}
	response {
		bVar 0: boolean
	}
}

GUIDE_GS01FinishGuide 530 {
	request {
		guideId 0: integer
	}
}


LOTTERY_GS01CloseLottery 532 {
	request {
	}
}

SCENE_ENTITY_GS90DumpAttr 536 {
	request {
		sceneId 0: integer
		entityId 1: integer
		attr 2: string
	}
}

SCENE_ENTITY_GS01PointEntity 537 {
	request {
		sceneId 0: integer
		entityId 1: integer
		pointEntityId 2: integer
	}
}

WORKSHOP_GS01OpenWorkshop 544 {
	request {
		workType 0: integer
	}
}

FRIEND_CMD_GS01GetFriendInfo 545 {
	request {
	}
}

FRIEND_CMD_GS01GetUserInfoById 546 {
	request {
		userId 0 : string
	}
}

FRIEND_CMD_GS01GetBlackListUserInfo 547 {
	request {
	}
}

UI_TELL_GS01ModelMsgBoxReq 550 {
	request {
		revObj 0: integer
		oid 1: integer
		key 2: integer
	}
}

ROBOT_GS01Fuben 553 {
	request {
	}
}

ROBOT_GS01RunTo 554 {
	request {
		SceneId  0 : integer
		pos      1 : position
	}
}

STORY_JUQING_GS01FinishPlay 557 {
	request {
		juqingId 0: integer
	}
}

DELAY_GS01Hit 561 {
	request {
		hitIndex 0: integer
	}
	response {
		hitIndex 0: integer
		timeMilli 1: integer
	}
}

GAMEPLAY_MANAGER_GS01StartGame 562 {
	request {
		tag 0: string
		level 1: integer
	}
}

FRIEND_CMD_GS01GetRecentInfo 563 {
	request {
		recentContactsList 	0 : *string
	}
}

GAMEPLAY_MANAGER_GS01OpenTeamTagSys 564 {
	request {
		tag 0: string
		gamelevel 1: integer
	}
}

SKILL_GS01DetailData 566 {
	request {
		typeId 0: integer
	}
}

.TEAM_COMMAND_GS01Search_memberData {
	IconPath 0: string
	Id 1: string
	Level 2: integer
	Name 3: string
	Race 4: integer
	SId 5: string
	Type 6: string
	UserId 7: string
}

.TEAM_COMMAND_GS01Search_teamData {
	IsApplied 0: boolean
	MemberList 1: *TEAM_COMMAND_GS01Search_memberData
	TeamId 2: integer
}

.TEAM_COMMAND_GS01Search_userData {
	BodyId 0: integer
	CombatPower 1: integer
	Dead 2: boolean
	Hp 3: integer
	IconPath 4: integer
	Id 5: string
	IsInvited 6: boolean
	Level 7: integer
	MaxHp 8: integer
	Name 9: string
	Race 10: integer
	SId 11: string
	Type 12: string
	UserId 13: string
}

TEAM_COMMAND_GS01Search 567 {
	request {
		gameplayTagName   0: string
		filterTagNameList 1: *integer
	}

	response {
		TeamList 0: *TEAM_COMMAND_GS01Search_teamData
		UserList 1: *TEAM_COMMAND_GS01Search_userData
	}
}

TEAM_COMMAND_GS01GetApplyUserNumOnLogin 568 {
	request {

	}
	response {
		cnt 0: integer
	}
}

VINELADDER_GS01GetGameCurData 569 {
	request {

	}

	response {
		BossNumber 0: integer
		GuardNumber 1: integer
		CurFloor 2: integer
	}
}

CHECKIN_GS01GetCheckInDataMap 571 {
	request {
	}
	response {
		checkInDataMap 0: string
	}
}

CHECKIN_GS01DoCheckIn 572 {
	request {
	}
	response {
		data 0: string
	}
}

FRIEND_CMD_GS01SearchUser 573 {
	request {
		text			0 : string
	}
	response {
		notPass			0 : boolean
		userData		1 : friendInfoItem
	}
}

.storeTagData {
	GoodsIdList 0 : *integer
	AutoRefreshTime 1 : integer
	RefreshTime 2 : integer
	DailyRefreshCount 3 :integer
}

STORE_GS01GetInitData 578 {
	request {
		storeId 0 : integer
	}
	response {
		TagId 0 : integer
		TagData 1 : storeTagData
		TagInfoMap 2 : string
		LabelInfoMap 3 : string
		GoodsInfoMap 4 : string
		GoodsDataMap 5 : string
	}
}

INTERACTION_GS01GetActionList 579 {
	request {
		targetUserId 	0 : string
		typeId 			1 : integer
		data 			2 : string
	}
	response {
		actionList 		0 : *actionItem
	}
}

STORE_GS01GetGoodsList 580 {
	request {
		tagId 0 : integer
	}
	response {
		TagData 0 : storeTagData
		GoodsInfoMap 1 : string
		GoodsDataMap 2 : string
	}
}

INTERACTION_GS01GetUserInfo 581 {
	request {
		userId 		0 : string
		MayNotOnMyHost	1 : boolean   # userId可能不是本服务器上的
	}
	response {
		userInfo 	1 : interactionUserInfo
	}
}

.storeGoodsData {
	BuyCnt 0 : integer
	StartTime 1 : integer
}

STORE_GS01Buy 583 {
	request {
		tagId 0 : integer
		goodsId 1 : integer
		amount 2 : integer
		sessionId 3: integer
	}
	response {
		GoodsData 0 : storeGoodsData
	}
}

INTERACTION_GS01DoAction 584 {
	request {
		targetUserId 	0 : string
		typeId 			1 : integer
		data 			2 : string
	}
	response {}
}

LOTTERY_GS01Lottery 585 {
	request {
		lotteryId 		0 : integer
	}
	response {
		buddyDataList 	0 : *buddyDataItem
	}
}
HOME_GS01SetDefence 586 {
	request {
		buddySIdList 	0 : *string
	}
}

HOME_GS01UpTrainBuddy 587 {
	request {
		buddySId 		0 : string
		idx				1 : integer
	}
	response {
		succeed			0 : boolean
	}
}

HOME_GS01DownTrainBuddy 588 {
	request {
		buddySId 		0 : string
		idx				1 : integer
	}
	response {
		succeed			0 : boolean
	}
}

.guildFullInfo {
	Id 0 : integer
	Name 1 : string
	Creed 2 : string
	Level 3 : integer
	Liveness 4 : integer
	OnlineCnt 5 : integer
	TotalCnt  6 : integer
	LeaderId  8 : string
	LeaderName 9 : string
	Fund 10 : integer
	DailyDonateFund 11 : integer
	Logo 12 : string
	GroupId 13 : string
}

GUILD_COMMAND_GS01UpdateGuildInfo 589 {
	request {
		idValue 0 : integer
	}
	response {
		info 0 : guildFullInfo
		id 1 : integer
	}
}

.guildList {
	GuildList 0 : *guildFullInfo
	ApplyMap 1 : *integer
}

GUILD_COMMAND_GS01GetGuildMap 590 {
	request {
	}
	response {
		bVar 0 : boolean
		info 1 : guildList
	}
}

GUILD_COMMAND_GS01GetMaxLogPage 591 {
	request {
	}
	response {
		bVar 0 : boolean
		info 1 : string
	}
}

GUILD_COMMAND_GS01GetLogInfo 592 {
	request {
		page 0 : integer
	}
	response {
		bVar 0 : boolean
		info 1 : string
	}
}

.guildMember {
	JoinTime 0 : integer
	Position 1 : integer
	UserId 2 : string
	TypeId 3 : integer
	Name 4 : string
	Level 5 : integer
	CombatPower 6 : integer
	Donate  7 : integer
	TotalDonate  8 : integer
	LogoutTime 9 : integer
	DestinyLevel 10 : integer
	SharedNum  11 : integer
	TaskTimes  12 : integer
	AllCityWarCount 13 : integer
	AttendCityWarCount 14: integer
}

GUILD_COMMAND_GS01GetMemberInfo 593 {
	request {
		idValue 0 : integer
	}
	response {
		Map 0 : *guildMember
		Id 1 : integer
	}
}

OPEN_NOTICE_GainReward 611 {
	request {
		noticeId 0 : integer
	}
	response {
	}
}

BATTLE_ENTITY_HERO_GS01DisabledAI 612 {
	request {

	}
}

TASKUTIL_GS01Arrive 613 {
	request {
		mainTaskId 0: integer
		sign 1: string
		doingTaskId 2: integer
	}
}

TeleportBack 614 {
	request {
	}
}

BATTLE_ENTITY_HERO_GS01EnabledAI 615 {
	request {

	}
}

BATTLE_ENTITY_HERO_GS01UpdateGrounded 616 {
	request {
		isGrounded 0: boolean
	}
}

USER_GetAttrInfoList 617 {
	request {
		updateTime 0 : integer
	}
	response {
		InfoList 0 : string
		updateTime 1 : integer
	}
}


BUDDY_COLLECT_GS01UpgradeYuan 620 {
	request {
		yuanId 0 : integer
	}
	response {
		success 0 : boolean
	}
}

USER_GS01SetQuickItem 630 {
	request {
		slotId 0 : integer
		typeId 1 : integer
	}
	response {
	}
}

BUDDY_GetSupportAttrInfoList 631 {
	request {
		buddySId 0 : string
	}
	response {
		InfoList 0 : *integer
	}
}

USER_GS01ViewUserData 632 {
	request {
		targetUserId 0 : string
		viewIdList 1: *integer
	}
	response {
		userData 0 : string
	}
}

ReqOpenProfileUI 633 {
	request {
		answer 0 : string
	}
	response {
		succeed 0 : boolean
	}
}

TASKUTIL_GS01FinishStep 634 {
	request {
		mainTaskId 0: integer
		sign 1: string
		doingTaskId 2 : integer
		talkType 3 : integer
	}
}

BUDDY_GS01ChangeSkill 635 {
	request {
		buddySId 0 : string
		consumeSId 1: string
		from 2 : integer
		to 3 : integer
		useMoney 4 : boolean
	}
	response {
		ok 0 :boolean
	}
}

MAIL_GS01RequestMailDateByType 636 {
	request {
		mailType 0 : integer
	}
}

MAIL_GS01RequestMailDataById 637 {
	request {
		mailId 0 : string
	}
}

HEROSOUL_GS01UseExpItem 700 {
	request {
		soulSId 0 : string
		sIdList 1 : *string
		useAmtList 2 : *integer
	}
	response {
		success 0 :boolean
	}
}

HEROSOUL_GS01Resolve 701 {
	request {
		sIdList 0 : *string
	}
	response {
		success 0 :boolean
	}
}

HEROSOUL_GS01DoEquip 702 {
	request {
		buddySId 0 : string
		slotId 1 : integer
		itemSId 2 : string
	}
	response {
		success 0 :boolean
	}
}

HEROSOUL_GS01UnEquip 703 {
	request {
		buddySId 0 : string
		slotId 1 : integer
		itemSId 2 : string
	}
	response {
		success 0 :boolean
	}
}

USER_GS01DoEquip 704 {
	request {
		equipSId 0 : string
		slotId 1 : integer
		oldEquipSId 2 : string
		inherit 3 : integer
	}
}


CreateUser 705 {
	request {
		initKey 0 : integer
		nickName 1 : string
	}
}

UserEnterGame 706 {
	request {
		userId 0 : string
	}
}

DeleteUser 707 {
	request {
		userId 0 : string
	}
}

TIANZHU_Switch 708 {
	request {
		tianzhuId 0 : integer
		changeSex 1 : boolean
	}
}

BUDDY_GS01SelectStandby 710 {
	request {
		on 0 : *string
		off 1 : *string
		list 2 : *string
		tips 3 : boolean
	}
}

.fubenData {
	FubenTypeId 0: string
	DifficultFinishTimes 1: *integer
}

USER_GS01GetStoryFubenData 711 {
	request {

	}

	response {
		FubenData 0: *fubenData
	}
}

TASKUTIL_GS01Reward 712 {
	request {
		taskId 0 : integer
		talkType 1 : integer
	}

	response {
		FubenData 0: *fubenData
	}
}

DROP_OUT_PickDropItem 713 {
	request {
		IdList 0: *integer
	}
}

USER_GS01SkillLevelUpOneKey 714 {
	request {
		skillTypeId	0 : integer
		isNormal	1 : boolean
		skillGoalLevel 2 : integer
	}
	response {
		is_succeed  0: boolean
	}
}

FUBEN_UTILS_GS01EnterFuben 715 {
	request {
		Difficulty 0 : integer
		FubenTypeId 1: string
		OnXServer 2: boolean
	}
}

SCENE_CHANGE_PK_MODEL 719 {
	request {
		PkModelId 0 : integer
	}
}

GATHER_Begin 720 {
	request {
		EntityId 0 : integer
	}
	response {
		ret 0 : boolean
	}
}

GATHER_Cancel 721 {
	request {
	}
}

GATHER_End 722 {
	request {
		typeId 0 : integer
	}
}

RESOURCE_TRACEBACK_GetResTraceback 723 {
	request {
		ActivityId	0 : string
		TypeId		1 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

MEDITATION_CancelMeditation 724 {
	request {
	}
}

MEDITATION_TakeReward 725 {
	request {
		Double 0 : integer
	}
	response {
		ItemId 0 : *integer
	}
}

MODAO_DoWork 726 {
	request {
		mainTaskId 0 : integer
	}
}

.RewardInfo {
	TypeId 0: integer
	Amount 1: integer
	ResType 2: integer
}

FUBEN_UTILS_GS01SweepFuben 727 {
	request {
		FubenTypeId 0: string
		Difficulty  1: integer
		SweepType   2: integer
	}
	response {
		rewardMap 0: *RewardInfo
	}
}

CHAT_AddChannelSubscribe 728 {
	request {
		Channel 0 : integer
	}
}

CHAT_RemoveChannelSubscribe 729 {
	request {
		Channel 0 : integer
	}
}

.ExchangeInfo {
	fromResourceType 0: integer
	toResourceType 1: integer
	exchangeTimes 2: integer
}

BAOTU_StartDig 730 {
	request {
		itemSId 0: string
	}
}

LIANJIN_DoExchange 731 {
	request {
		lianjinType 0: integer
	}
	response {
		result 0: boolean
	}
}

TREASURE_LOTTERY_DoLottery 732 {
	request {
		LotteryTypeId	0 : integer
		LotteryIndex	1 : integer
	}
	response {
		ErrorCode		0 : integer
		.rewardInfo {
			ResType		0 : integer
			TypeId		1 : integer
			FullTypeId 	2 : integer
			Amount		3 : integer
			CombatPower	4 : integer
			Aptitude	5 : integer
			DescId      6 : string
		}
		RewardInfoList	1 : *rewardInfo
	}
}

TREASURE_LOTTERY_GetAllNotifications 733 {
	request {}
	response {
		PackedMsgList	0 : string
	}
}

TREASURE_LOTTERY_BuyCoin 734 {
	request {
		Amount		0 : integer
		sessionId   1 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

AIRCRAFT_LevelUp 735 {
	request {
		UseReplacement	0 : boolean
	}
	response {
		ErrorCode		0 : integer
	}
}

TURFWAR_GS01Prepare 736 {
	request {

	}
}

TURFWAR_GS01CancelPrepare 737 {
	request {

	}
}

GSQueryRankIdx 738 {
	request {
		rankId 0 : integer
		userId 1 : string
	}
	response {
		idx 0 : integer
	}
}

LEVEL_RUSH_GetRewardNum 739 {
	request {

	}
	response {
		ret 0 : *integer
	}
}

MEDAL_LevelUp 740 {
	request {}
	response {
		ErrorCode	0 : integer
	}
}

TUTENG_LEVELUP 741 {
	request {
		tianzhuid 0 : integer
		easyUpdate 1 : boolean
	}
	response {
	}
}

GUILD_COMMAND_GS01LevelUp 742 {
	request {
	}
	response {
	}
}
WANMOTA_Sweep 743 {
	request {
	}
	response {
	}
}

WANMOTA_Start 744 {
	request {
	}
	response {
	}
}

GUILD_Donate 745 {
	request {
		typeId 0 : integer
	}
	response {
	}
}

GUILD_Donate_Reward 746 {
	request {
		rewardIndex 0 : integer
	}
	response {
	}
}

RANK_COMBAT_RequestRecord 747 {
	request {
	}
	response {
		rows 		0 : *GSQueryRankRow
		userData 	1 : *string
	}
}

BUDDY_GS01Equip 748 {
	request {
		sId 0 : string
		flag 1 : boolean
		slotId 2 : integer
	}
	response {
	}
}

BUDDY_GS01Levelup 749 {
	request {
		slotId 0 : integer
		swallowSIds 1 : *string
	}
	response {
	}
}

BUDDY_GS01Starup 750 {
	request {
		slotId 0 : integer
		swallowSIds 1 : *string
	}
	response {
	}
}

BUDDY_GS01Collect 751 {
	request {
		buddySIds 0 : *string
	}
	response {
	}
}

FACE2FACE_ExchangeReq 752 {
	request {
		destUserId 0: string
	}
}

FACE2FACE_ExchangeRsp 753  {
	request {
		exchangeId 0: integer
	}
}

FACE2FACE_ExchangeOperateItem 754 {
	request {
		exchangeId 0: integer
		itemSId 1: string
		itemAmount 2: integer
	}
}

FACE2FACE_ExchangeOperateResource 755 {
	request {
		exchangeId 0: integer
		amount 1: integer
	}
}

FACE2FACE_ExchangeLock 756 {
	request {
		exchangeId 0: integer
	}
}

FACE2FACE_ExchangeConfirm 757 {
	request {
		exchangeId 0: integer
	}
}

FACE2FACE_ExchangeCancel 758 {
	request {
		exchangeId 0: integer
	}
}

FUBEN_GS01DoBalance 759 {
	request {
		selectBalance 0: integer
	}
}

DESTINY_Change 760 {
	request {
		IsTicket 0 : boolean
		IsFree 1 : boolean
	}
}

DESTINY_Accept 761 {
	request {
		Id 0 : integer
	}
}

DESTINY_Give 762 {
	request {
		Id 0 : integer
	}
}

DESTINY_Share 763 {
	request {
		UserId 0 : string
	}
}

DESTINY_Request 764 {
	request {
		UserId 0 : string
	}
}

SetAppearance 765 {
	request {
		Type 0 : integer
		AppearanceId 1 : integer
		ForWhat 2 : integer
	}
}

CHARGE_GIFT_GetGift 766 {
	request {
		GiftId		0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

.tradeItemInfo{
	Uuid 0: string
	sellUserId 1: string
	price 2: integer
	totalPrice 3:integer
	endSellTime 4:integer
	itemDesc 5: string
}

TRADECENTER_QueryMyTradeItem 767 {
	request {}
	response {
		itemInfoList 0: *tradeItemInfo
	}
}

.tradeItemIcon{
	typeId 0: integer
	amount 1: integer
	totalPrice 2: integer
}

TRADECENTER_QueryTradeItemByItemType 768 {
	request {
		typeId 0:integer
		quality 1: integer
		level 2: integer
		orderRule 3: string
	}
	response {
		referencePrice 0: integer
		itemIconList 1: *tradeItemIcon
	}
}

TRADECENTER_QueryTradeItemPerPage 769 {
	request {
		category 0: integer
		quality 1: integer
		level 2: integer
		orderRule 3: string
		page 4: integer
	}
	response {
		page 0: integer
		totalPage 1: integer
		itemInfoList 2: *tradeItemInfo
	}
}

.tradeLogInfo{
	isBuy 0: boolean
	itemType 1:integer
	amount 2:integer
	totalPrice 3: integer
	tradeUserName 4: string
	tradeTime 5: integer
}

TRADECENTER_QueryTradeLog 770 {
	request {}
	response {
		tradeEarning 0: integer
		tradeLog 1: *tradeLogInfo
	}
}

TRADECENTER_AddNewTradeItem 771 {
	request {
		itemSId 0 : string
		amount 1: integer
		price 2: integer
	}
	response {
		result 0: boolean
		textId 1: integer
	}
}

TRADECENTER_RevokeTradeItem 772 {
	request {
		Uuid 0 : string
	}
	response {
		result 0: boolean
		textId 1: integer
	}
}

TRADECENTER_BuyTradeItem 773 {
	request {
		Uuid 0 : string
		sellUserId 1: string
	}
}


TRADECENTER_SearchItemByTypeList 774 {
	request {
		quality 0: integer
		level 1: integer
		orderRule 2: string
		page 3: integer
		typeIdList 4: *integer
	}
}

TRADECENTER_ExtractTradeEarning 775 {
	request {}
}

WING_LevelUp 776 {
	request {
		UseReplacement	0 : boolean
	}
	response {
		ErrorCode		0 : integer
	}
}

FEAST_Drink 777 {
	request {
	}
}

FEAST_GetDrinkInfo 778 {
	request {}
	response {
		DrinkLevel 0 : integer
		DrinkCount 1 : integer
	}
}

TASKUTIL_TeleportToPoint 779 {
	request {
		SceneProtoId 0 : integer
		Position 1 : position
		Rotation 2 : integer
		DoingTaskId 3 : integer
	}
}

MAIL_CheckAndRequestMailData 780 {
	request {
		mailCheckList 0 : *string
	}
	response {
	}
}

VIP_GetVipGift 781 {
	request {
		VipLevel	0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

VIP_SetAutoSmelt 782 {
	request {
		State		0 : boolean
	}
	response {
		ErrorCode	0 : integer
	}
}

UnSetAppearance 783 {
	request {
		Type 0 : integer
	}
}

GROWTH_FOUNDATION_Invest 784 {
	request {
		Type		0 : integer
		SessionId	1 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

GUILD_TASK_Share 785 {
	request {}
}

GUILD_TASK_Accept 786 {
	request {
		Id 0 : integer
	}
	response {
		ret 0: boolean
	}
}

CHANGANCITYWAR_GS01RequestBid 787 {
	request {
		LocalValue 0: integer
	}
}

CHANGANCITYWAR_GS01RequestUpdate 788 {
	request {
		Type 0 : integer
	}
}

ENCHONG_ChooseOrReplace 789 {
	request {
		TypeId 0:integer
	}
	response {
		result 0:boolean
		textId 1:integer
	}
}

ENCHONG_TaskTakePhoto 790 {
	request {
		TaskId 0:integer
	}
	response {
		result 0:boolean
		textId 1:integer
	}
}

ENCHONG_ChangeClothes 791 {
	request {
		ClothesType 0:integer
	}
	response {
		result 0:boolean
		textId 1:integer
	}
}

ENCHONG_ChangeCallName 792 {
	request {
		CallName 0:string
	}
	response {
		result 0:boolean
		textId 1:integer
	}
}

ENCHONG_TakeQiyuanTask 793 {
	request {
		TakeTask 0:boolean
	}
	response {
		result 0:boolean
		textId 1:integer
	}
}

.qiyuanPhotoInfo{
	TaskId 0:integer
	PhotoDnsKey 1: string
}

ENCHONG_QueryPhoto 794 {
	request {

	}
	response {
		PhotoInfo 0: *qiyuanPhotoInfo
	}
}

ENCHONG_LookupQiyuanTask 795 {
	request {
		taskId 0 : integer
	}
	response {
		result 0:boolean
		State 1:integer
		textId 2:integer
	}
}

ENCHONG_Talk 796 {
	request {

	}
}

HOME_OpenHome 797 {
	request {
		homeType 0:integer
	}
}

HOME_GoHome 798 {
	request {
		homeOwnerId 0 : string
	}
}

CHANGANCITYWAR_GS01RequestDukeData 799 {
	request {

	}
	response {
		UserId 0 : string
		GuardName 1 : string
		GuildName 2 : string
		TakeReward 3 : integer
		CurrentIncome 4 : integer
		HoldParty 5 : integer
		IsGuildLeader 6 : boolean
		BodyId 7 : integer
		WingId 8 : integer
		Sex 9 : integer
	}
}

CHANGANCITYWAR_GS01TakeReward 800 {
	request {

	}

	response {
		TakeReward 0 : integer
	}
}

CHANGANCITYWAR_GS01HoldParty 801 {
	request {
		ChoiceType 0 : integer
	}

	response {
		Ret 0 : boolean
	}
}

CHANGANCITYWAR_GS01PartakeParty 802 {
	request {

	}
	response {
		Ret 0 : boolean
		LeftCount 1 : integer
		AllPartake 2 : integer
	}
}

WELFARE_MANAGER_NEW_ReqReward 803 {
	request {
		actKey 0 : string
		rewardKey 1 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

CHANGANCITYWAR_GS01RequestFight 804 {
	request {
		Confirm 0 : boolean
	}
	response {
		Ret 0 : boolean
	}
}

SHENGTANG_CARD_LevelUp 805 {
	request {
		typeId 0 : integer
	}
}

SHENGTANG_CARD_CardDecompose 806 {
	request {
		typeId 0 : integer
		amount 1 : integer
		sourceType 2 : integer
	}
}

SHENGTANG_CARD_Zhuling 807 {
	request {
		typeId 0 : integer
		tianzhuId 1 : integer
	}
}


SHENGTANG_CARD_UnlockZhuling 808 {
	request {}
}

VIP_AddVipTrialBuff 809 {
	request {}
	response {
		ErrorCode	0 : integer
	}
}

.queryFuben {
	Name 0 : string
	BossNum 1 : integer
}

FUBEN_UTILS_GS01QueryVipFubenData 810 {
	request {
	}
	response {
		Query 0 : *queryFuben
	}
}

TASKUTIL_GS01FinishTalk 811 {
	request {
		mainTaskId 0: integer
		doingTaskId 1 : integer
		talkType 2 : integer
	}
}

CHANGANCITYWAR_GS01Open 812 {
	request {
	}

	response {
		ChoiceType 0 : integer
		NextTime 1 : integer
		LeftCount 2 : integer
		PersonCount 3 : integer
	}
}

SCENE_TalkMenuRequest 813 {
	request {
		sceneId 0: integer
		entityId 1: integer
		MenuId 2: string
		OptIdx 3: integer
	}

	response {

	}
}

MARRIAGE_RecommendPartner 814 {
	request {

	}

	response {
		userDatas 0 : *string
	}
}

ActivateAppearance 816 {
	request {
		Type 0 : integer
		AppearanceId 1 : integer
	}
	response {
		ActivateRet 0 : boolean
	}
}

NPC_TalkToNpc 818 {
	request {
		EntityId 0:integer
	}
}

MARRIAGE_SendFlower 819 {
	request {
		typeId	0 : integer
		amount  1 : integer
	}
	response {}
}

SHARE_SDK 820 {
	request {
	}
}

LONGXUEXUNBAO_Start 821 {
	request {
	}
}

ZHUBO_GET_ROOM_ID 828 {
	request {
	}
}

ZHUBO_SEARCH_RESULT 829 {
	request {
		zhuboId 0 : string
	}
}

ZHUBO_Attention 830 {
	request {
		zhuboId 0 : string
		enable 1 : boolean
	}
}

ZHUBO_GiveGift 831 {
	request {
		zhuboId 0 : string
		amount 1 : integer
		buyAmount 2 : integer
		msgText 3 :string
	}
	response {
		token 0 : string
		msgText 1: string
	}
}

TREASURE_LOTTERY_GetEventsData 832 {
	request {}
	response {
		ErrorCode		0 : integer
		.event {
			EventKey	0 : string
			BeginTime	1 : integer
			EndTime		2 : integer
			Phase		3 : integer
		}
		Events			1 : *event(EventKey)
	}
}

CHARGE_GS01GetPromotionInfo 835 {
	request {
	}
	response {
		promotionId		0 : integer
		promotionInfo		1 : string
	}
}

LUCKY_CARD_DrewCard 836 {
	request {
		CardIndex	0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

SHENGTANG_CARD_Save 837 {
	request {
		typeId 0 : integer
		amount 1 : integer
	}
}

CONSUME_RANK_GetRankDataList 839 {
	request {
	}
	response {
		.chargeUserData {
			RankIdx	0 : integer
			UserId	1 : string
			Name	2 : string
			Yuanbao 3 : integer
		}
		RankDataList	0 : *chargeUserData
		UserData	1 : chargeUserData
		PreUserData	2 : chargeUserData
	}
}

CHARGE_RANK_GetRankDataList 840 {
	request {
	}
	response {
		.chargeUserData {
			RankIdx	0 : integer
			UserId	1 : string
			Name	2 : string
			Yuanbao 3 : integer
		}
		RankDataList	0 : *chargeUserData
		UserData	1 : chargeUserData
		PreUserData	2 : chargeUserData
	}
}

GUILD_RequestGuildShareInfo 841 {
	request {
		GuildId 0 : integer
	}

	response {
		GuildId 0 : integer
		Name 1 : string
		Num 2 : string
		Creed 3 : string
		LeaderName 4 : string
		LeaderId 5 : string
	}
}

FORTUNATE_TRADER_Buy 842 {
	request {
		SessionId	0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

GUILD_Share 843 {
	request {
		msg 0 : string
	}
}

VIP_GROUPON_GetGainedMap 844 {
	request {
	}
	response {
		keyList		0 : *integer
		valueList	1 : *integer
	}
}

VIP_GROUPON_GetNewVipCount 845 {
	request {
	}
	response {
		newVipCount	0 : integer
	}
}

VIP_GROUPON_GetReward 846 {
	request {
		grouponId	0 : integer
	}
	response {
		success		0 : boolean
	}
}

YCMB_GetReward 847 {
	request {
		ContentId	0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

PUSH_GIFT_Roll 848 {
	request {
		key	0 : string
	}
	response {
	}
}

PUSH_GIFT_Buy 849 {
	request {
		category	0 : integer
		SessionId	1 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

FIREWORKS_Buy 850 {
	request {
		amount	0 : integer
	}
}

FIREWORKS_Light 851 {
	request {
		amount	0 : integer
	}
}

FIREWORKS_GetLog 852 {
	request {
	}
	response {
		globalLogList	0 : string
		selfLogList	1 : string
	}
}

TUPO_Level 853 {
	request {
	}
}

.bossInfo {
	BossType 0:integer
	IsAlive 1:boolean
	BelongTime 2:integer
	MaxBelongTime 3:integer
}

PINGLUAN_QueryPingLuanBossInfo 854 {
	request {
	}
	response {
		BossInfo 0:*bossInfo
	}
}

PINGLUAN_GoToKillBoss 855 {
	request {
		BossTypeId 0:integer
	}
}

UpdateRising 856 {
	request {
		flag 0:boolean
	}
}

GUILD_DAILY_WELFARE 857 {
	request {}
	response {
		ret 0 : boolean
	}
}

RICH_TEXT_OnClickHyperlink 858 {
	request {
		LinkId 0: integer
		Params 1: string
	}
}

TRADECENTER_PutOnSellAgain 859 {
	request {
		Uuid 0 : string
		Price 1: integer
	}
	response {
		result 0: boolean
		textId 1: integer
	}
}

CHAT_QueryItemDesc 860 {
	request {
		DescId 0:string
	}
	response {
		ItemDesc 0:string
	}
}

UpdateBoarding 861 {
	request {
		flag 0 : boolean
	}
}

SHENGTANG_CARD_CardSaveOneKey 862{
	request {
		typeIds 0 : *integer
	}
}

.tradeItemData {
	ItemId 0 : integer
	CurrentBid 1 : integer
	EndTime 2 : integer
	IsMyGuild 3 : integer
	ItemNo 4 : string
	UserId 5 : string
	DstPrice 6 : integer
	BasePrice 7 : integer
}

GUILDAUCTION_GS01QueryGuildTradeData 871 {
	request {
		Page 0 : integer
	}
	response {
		TotalPage 0 : integer
		TradeEarning 1 : integer
		TradeItemData 2 : *tradeItemData
		Page 3 : integer
	}
}

.auctionLog {
	ItemId 0 : integer
	Time   1 : integer
	Name   2 : string
	Price  3 : integer
}

.myauctionLog {
	ItemId 0 : integer
	Time   1 : integer
	MyPrice  2 : integer
	CurrPrice 3 : integer
}

GUILDAUCTION_GS01QueryRecord 872 {
	request {
	}

	response {
		AuctionLog 0 : *auctionLog
		MyAuctionLog 1 : *myauctionLog
	}
}

GUILDAUCTION_GS01TakeEarning 873 {
	request {
	}
	response {
		RetCode 0 : integer
	}
}

GUILDAUCTION_GS01DoBid 874 {
	request {
		ItemNo 0 : string
		CurrentBid 1 : integer
	}
	response {
		CurrentBid 0 : integer
		RetCode 1 : integer
	}
}

GUILDAUCTION_GS01DoBuy 875 {
	request {
		ItemNo 0 : string
	}
	response {
		RetCode 0 : integer
	}
}

TENCENT_QueryCanSendGift 879 {
	request {

	}
	response {
		CanSendGift 0 : boolean
	}
}

ENCHONG_GetQiyuanTaskReward 880 {
	request {}
	response {
		result 0:boolean 
	}
}

ENCHONG_CheckSearchStr 881 {
	request {
		SearchStr	0 : string
	}
	response {
		NotPass		0 : boolean
	}
}

GUILD_COMMAND_GS01CheckGuildSearchStr 882 {
	request {
		SearchStr	0 : string
	}
	response {
		NotPass		0 : boolean
	}
}

GUILD_COMMAND_GS01CheckGuildMemberSearchStr 883 {
	request {
		SearchStr	0 : string
	}
	response {
		NotPass		0 : boolean
	}
}

FRIEND_CMD_GS01CheckMyFriendSearchStr 884 {
	request {
		SearchStr	0 : string
	}
	response {
		NotPass		0 : boolean
	}
}

TENCENT_GiveGiftToFriend 885 {
	request {
		HostId 0:integer
		OpenId 1:string
		UserId 2:string
	}
	response {
		result 0:boolean
		CanSendGift 1: boolean
	}
}

RED_PACKET_CreateNewPacket 886 {
	request {
		channel 0 :integer
		totalMoney 1:integer
		amount 2:integer
		msg 3:string
	}
	response {
		result 0:boolean
	}
}

RED_PACKET_GrabPacket 887 {
	request {
		channel 0:integer
		packetId 1:string
	}
	response {
		result 0:boolean
		money 1: integer
	}
}

.redPacket {
	state 0:integer
	packetId 1: string
	senderName 2:string
	sendTime 3:integer
	msg 4:string
}

RED_PACKET_QueryTotalPacket 888 {
	request {
		channel 0:integer
	}
	response {
		PacketList 0: *redPacket
	}
}

.grabPacketLog {
	money 0:integer
	ownerName 1:string
	grabTime 2:integer
}

RED_PACKET_QueryGrabLog 889 {
	request {
		channel 0:integer
		packetId 1:string
	}
	response {
		TotalCount 0:integer
		TotalMoney 1:integer
		SendTime 2:integer
		MinMoney 3:integer
		MaxMoney 4:integer
		GrabLogList 5:*grabPacketLog
	}
}

PAY_TENCENT_CheckPaySuccess 890 {
	request {
	}
	response {
	}
}

PAY_TENCENT_RequestBuyGoods 891 {
	request {
		GoodsId 0 : integer
		Amount 	1 : integer
	}
}

GIFT_EXCHANGE_NEW_CheckCodeStr 892 {
	request {
		CodeStr		0 : string
	}
	response {
		NotPass		0 : boolean
	}
}

CHAT_TSS_SimpleCheck 893 {
	request {
		RawString		0 : string
		Channel			1 : integer	# 若仅仅是简单检查不需要输出服务端日志,则该字段为空
	}
	response {
		ErrorCode		0 : integer
		NotPass			1 : boolean
		FilteredString	2 : string
	}
}

MATERIAL_CONVERT_SetNoticeList 894 {
	request {
		NoticeList		0 : *boolean
	}
	response {
		ErrorCode		0 : integer
	}
}

YUANBAO_GIFT_MANAGER_Buy 895 {
	request {
		GiftId		0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

YUANBAO_GIFT_MANAGER_SetHideRedDot 896 {
	request {
		GiftId		0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

PAY_TENCENT_IsSandbox 897 {
	request {
	}
	response {
		IsSandbox	0 : boolean
	}
}

.redPacketHistory {
	HeadId 0:integer
	Level 1:integer
	Vip 2:integer
	Name 3:string
	Money 4:integer
	Channel 5:integer
	Msg 6: string
	PacketId 7:string
}

RED_PACKET_QueryHistory 898 {
	request {
		QueryType 0:integer
	}
	response {
		TotalMoney 0:integer
		HistoryList 1: *redPacketHistory
	}
}

TLOG_SecReportFlow 899 {
	request {
		TargetUserId		0 : string
		ReportTypeList		1 : *integer	# 信息类型, 1 违规头像, 2违规昵称, 3政治敏感, 4恶意谩骂, 5色情信息, 6欺诈广告, 7其他, 多个上报eg: 1, 2, 3
		EvilType			2 : integer		# 恶意类型, 1 广告, 2 色情, 3 谩骂, 4 政治, 99为其他
		ReportDesc			3 : string		# 用户填写的举报说明
		ReportChatContents	4 : string		# 用户举报的信息内容
		ReportPicUrlList	5 : *string		# 举报玩家图片的URLlist, 多张图片URL用逗号隔开.
	}
	response {
		ErrorCode			0 : integer
	}
}

.turfwarRankData {
	DamageValue 0 : integer
	Score  1 : integer
	Name   2 : string
	UserId 3 : string
	Red    4 : boolean
	DeadCount 5 : integer
	TypeId 6 : integer
	KillCount 7 : integer
}

CHARGE_REPAY_GetRepay 900 {
	request {}
	response {
		ErrorCode	0 : integer
	}
}

XMAS_HangGift 901 {
	request {
		ItemTypeId	0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

ZHUANSHENG_UserZhuansheng 902 {
	request {
	}
	response {
	}
}

ZHUANSHENG_BuddyZhuansheng 903 {
	request {
		SlotId 0: string
	}
	response {
	}
}

ZHUANSHENG_QueryAllJuqingFinish 904 {
	request {
	}
	response {
		result 0: boolean 
	}
}

YUANXIAO_Answer 905 {
	request {
		IsCorrect	0 : boolean
	}
	response {
		ErrorCode	0 : integer
	}
}

YUANXIAO_PickHedeng 906 {
	request {
		EntityId	0 : integer
	}
	response {
		ErrorCode	0 : integer
	}
}

YUANXIAO_SOS 907 {
	request {}
	response {
		ErrorCode		0 : integer
	}
}

YUANXIAO_WakeUp 908 {
	request {
		TargetUserId	0 : string
		SessionId		1 : integer
	}
	response {
		ErrorCode		0 : integer
	}
}

YUANXIAO_Lottery 909 {
	request {
		Type			0 : integer		# 0是低级抽奖 1高级抽奖 不传默认为0
		Amount			1 : integer		# 不传默认为1
	}
	response {
		ErrorCode		0 : integer
		ItemDataList 	1 : *ItemData
	}
}

YUANXIAO_GetLotteryLog 910 {
	request {
		Type			0 : integer		# 0是低级抽奖 1高级抽奖 不传默认为0
	}
	response {
		ErrorCode		0 : integer
		GlobalLogList	1 : string
		SelfLogList		2 : string
	}
}

VIP_HideVip 911 {
	request {
		HideVip			0 : boolean
	}
	response {
		ErrorCode		0 : integer
	}
}

TURFWAR_GS01RequestData 1000 {
	request {
	}

	response {
		RankData 0 : *turfwarRankData
		RedPoint 1 : integer
		BluePoint 2 : integer
	}
}

.arenaRankData {
	KillCount 0 : integer
	FlagCount 1 : integer
	Point 2 : integer
	Name 3 : string
	UserId 4 : string
	Red    5 : boolean
	DeadCount 6 : integer
	DamageValue 7 : integer
	TypeId 8 : integer
}

ARENA_FIELD_GS01RequestData 1001 {
	request {
	}

	response {
		RankData 0 : *arenaRankData
		RedPoint 1 : integer
		BluePoint 2 : integer
	}
}

JIANIANHUA_ReqReward 1002 {
	request {
		Type 0 : integer
		Day 1 : integer
		RewardKey 2 : integer
	}
}

TENCENT_UpdateToken 1003 {
	request {
		openKey	0 : string
		pf	1 : string
		pfKey	2 : string
	}
}

FRIEND_CMD_GS01MakeFriendsConfirmResponseByList 1004 {
	request {
		requestUserIdList 0 : *string
		isPass 1 : boolean
	}
}

PAY_TENCENT_MakePayBill 1005 {
	request {
		TypeId 0 : integer
		Amount 1 : integer
	}
	response {
		BillId 0 : string
		TypeId 1 : integer
		Yuanbao 2 : integer
		Time 3 : integer
	}
}

GUILD_GetCreateGroupTimes 1006 {
	request {
	}
}

GUILD_DismissGroup 1007 {
	request {
	}
}

XINYUE_QueryUrl 1008 {
	request {
		ava 0: string
		channelId 1:string
	}
	response {
		url 0: string
	}
}

SECURITY_Repay 1009 {
	request {
	}
	response {
	}
}

BUDDY_GS01Refresh 1010 {
	request {
		slotId 0 : integer
		stoneType 1 : string
	}
}

BUDDY_GS01Replace 1011 {
	request {
		slotId 0 : integer
	}
}

USER_GS01QueryServerLevel 1012 {
	request {

	}
	response {
		Level 0 : integer
	}
}

GUILD_CreatedGroup 1013 {
	request {
	}
}

GUILD_AgreeJoinGuild 1014 {
	request {
		InviterId 0: string
		GuildId 1 : integer
	}
}


USER_GetPhotoKey 1015 {
	request {
		userId 0 : string
	}
	response {
		Key 0 : string
	}
}

LAUNCH_FROM_Update 1016 {
	request {
		LaunchFrom 0:integer
	}
}

.BigInt {
	HighValue 0 : integer
	LowValue 1 : integer
}
.rankInfo {
	Name 0 : string
	Race 1 : integer
	Level 2 : integer
	Damage 3 : string
	Heal 4 : integer
	Bear 5 : integer

}
FUBEN_TEAM_RANK_DATA 1017 {
	request {
	}

	response {
		rankData 0 : *rankInfo
	}
}

.buddyPosition {
	formationSlotIdx 	0 : integer
	buddySlotIdx 		1 : integer
}

.opponentData {
	RankKey		0 : integer
	Icon		1 : string
	Level		2 : integer
	Name		3 : string
	TypeId		4 : integer
	Combat		5 : integer
	BuddyMap	6 : *buddyProfile
	BuddyFormation 7 : integer
}

BQP_GS01SetBattleFormation 1018 {
	request {
		Formation 	0 : integer
		BuddyMap 	1 : *buddyPosition
		IsForFight	2 : boolean
	}
}
.bingqipuBuddyLog {
	Icon 		0 : string
	IsWin 		1 : boolean
	Level 		2 : integer
	Time 		3 : string
	Type 		4 : integer
	UserName 	5 : string
	BuddyFormation 6 : integer
	BuddyMap	7 : *buddyProfile
}

BQP_GS01GetLogList 1019 {
	request {
	}
	response {
		logList	0 : *bingqipuBuddyLog
	}
}

BQP_GS01RequestChallenge 1020 {
	request {
        opponentRank 0: integer
        sessionId 1: integer
	}
	response {

	}
}

BQP_GS01GetRankBuddyData 1021 {
	request {
		rank	0 : integer
		slotIdx 1 : integer
	}
	response {
		TypeId 			0 : integer
		SlotIdx 		1 : integer
		Combat			2 : integer
		Level 			3 : integer
		SubLevel		4 : integer
		Quality 		5 : integer
		Star 			6 : integer
		BornGrowthRate 	7 : integer(2)
		AttrMapKey 		8 : *string
		AttrMapValue 	9 : *integer
		ActiveSkillMap	10 : *integer
		PassiveSkillMap	11 : *integer
	}
}

BQP_GS01GetPersonalRankData 1022 {
	request {
	}
	response {
		data	0 : integer
	}
}

BQP_GS01GetOpponentDataMap 1023 {
	request {
	}
	response {
		opponentDataMap	0 : *opponentData
	}
}


.yuandanCharacter {
	index 0:integer
	userId 1:string
}

YUANDAN_CloseCharacterPanel 1025 {
	request {
		entityId 0:integer
	}
}

YUANDAN_SetCharacter 1026 {
	request {
		entityId 0:integer
		index    1:integer
		charItemType 2:integer
	}
	response {
		result 0: boolean
		myCharacter 1: integer
		setIndexList 2: *integer
	}
}

YUANDAN_Lottery 1027 {
	request {}
	response {
		result 0:boolean
	}
}

SHENGTANG_CARD_CardDecomposeOneKey 1028{
	request {
		typeIds 0 : *integer
	}
}

BUDDY_LearnSkill 1029 {
	request {
		slotId 0 : integer
		itemId 1 : integer
	}
}

FAMILY_CreateFamily 1030 {
	request {
		Name 	0 : string
	}
	response {
		ret 	0 : boolean
		msgIdx 	1 : integer
	}
}

FAMILY_RecruitMember 1031 {
	request {
		TargetId 	0 : string
	}
}

FAMILY_LeaveFamily 1032 {
	request {}
}

FAMILY_DismissFamily 1033 {
	request {}
}

FAMILY_SignInDaily 1034 {
	request {}
	response {
		ret 	0 : boolean
	}
}

FAMILY_GetWelfare 1035 {
	request {}
	response {
		ret 	0 : boolean
	}
}

FAMILY_ReqLogData 1036 {
	request {
		Index 		0 : integer
		UpOrDown	1 : integer
	}
	response {
		LogData 	0 : string
	}
}

FAMILY_UpdateNickname 1037 {
	request {
		TargetId 	0 : string
		Nickname 	1 : string
	}
	response {
		ret 	0 : boolean
	}
}

FAMILY_ResponseRecruit 1038 {
	request {
		FamilyId 	0 : string
		IsPass 		1 : boolean
	}
}

FAMILY_ReqRecruitData 1039 {
	request {
	}
}

FAMILY_KickMember 1040 {
	request {
		TargetId 	0 : string
	}
	response {
		ret 	0 : boolean
	}
}

FUBEN_UTILS_GS01CancelPrepare 1041 {
	request {

	}
}

.familyData {
	FamilyId 	0 : string
	FamilyName 	1 : string
	LeaderName 	3 : string
	LeaderId 	4 : string
	RequestFlag	5 : boolean
	MemberNum 	2 : integer
}

FAMILY_RequireFamilyList 1042 {
	request {}
	response {
		FamilyList 	0 : *familyData
	}
}

FAMILY_SendRequestEnterList 1043 {
	request {
		FamilyIdList 	0 : *string
	}
	response {
		ret 		0 : boolean
	}
}

FAMILY_RemoveRequestEnter 1044 {
	request {
		FamilyId 	0 : string
	}
	response {
		ret 		0 : boolean
	}
}

FAMILY_SendResponseForEnter 1045 {
	request {
		TargetId 	0 : string
		IsPass 		1 : boolean
	}
	response {
		ret 		0 : boolean
	}
}

FAMILY_ReqRequestEnterData 1046 {
	request {
	}
}

FAMILY_ClearRequestEnterList 1047 {
	request {}
	response {
		ret 		0 : boolean
	}
}

FAMILY_OneKeyAgreeRequestEnter 1048 {
	request {}
	response {
		ret 		0 : boolean
		SuccessUserList 1 : *string
	}
}

FLOWER_SendFlower 1049 {
	request {
		itemId 0:integer
		amount 1:integer
		targetUserId 2:string
	}
	response {
		ret 0 : boolean
	}
}

FAMILY_CheckFamilyCache 1050 {
	request {}
}

FUBEN_UTILS_GS01EnterXServerFuben 1051 {
	request {
		FubenTypeId 0: *string
	}
	response {
		RetCode 0 : integer 
	}
}

FRIEND_CMD_ReqFriendCache 1052 {
	request {}
}

MATCH_REJECT_GS01EnrollMatch 1053 {
	request {
		EnrollType 0 : integer 
		EnrollName 1 : integer 
		FubenTypeList 2 : *string 
	}
}

GUILD_Rename 1056 {
	request {
		name 0 : string
	}
}

FAMILY_Rename 1057 {
	request {
		name 0 : string
	}
}

FAMILY_GotoFamilyFuben 1058 {
	request {}
}

BAOTA_Explore 1060 {
	request {
		amount 0: integer
	}
}

BAOTA_GetLog 1061 {
	request {
	}
	response {
		globalLogList	0 : string
		selfLogList	1 : string
	}
}

.lotteryRecord {
	itemTypeId 0:integer
	userName 1:string
}

NEW_YEAR_QueryLotteryRecord 1062 {
	request {
		recordType 0: integer
	}
	response {
		recordList 0: *lotteryRecord
	}
}

NEW_YEAR_Lottery 1063 {
	request {
		Amount 0:integer
	}
	response {
		ItemDataList 0 : *ItemData
	}
}
.yiyuanduobaoItem {
	index 0 : integer
	tickets 1 : integer	
}

YIYUANDUOBAO_Open 1064 {
	request {
		sessionId 0 : integer 
	}

	response {
		list 0 : *yiyuanduobaoItem
		userdata 1 : *integer
		sessionId 2 : integer
	}
}

YIYUANDUOBAO_RewardRecord 1065 {
	request {
		sessionId 0 : integer 
		typeId 1 : integer
	}
	response {
		sessionId 0 : integer
		record 1 : *string
	}
}

YIYUANDUOBAO_Join 1066 {
	request {
		typeId 0 : integer
		tickets 1 : integer
		index 2 : integer
	}
	response {
		ok 0 : boolean
		refresh 1 : boolean
	}
}

NEW_YEAR_SendDanMu 1067 {
	request {
		Type 0 : integer
		Msg  1 : string
	}
	response {
		result 0:boolean
	}
}

STORE_GS01Refresh 1071 {
	request {
		tagId 0 : integer
	}
	response {
		TagData 0 : storeTagData
		GoodsInfoMap 1 : string
		GoodsDataMap 2 : string
	}
}

NPC_StopMove 1072 {
	request {
		EntityId 0 : integer
	}
	response {
		ret 0 : boolean
	}
}

DATANGYANWU_GS01XiuBuRequest 1073 {
	request {
	}
}

.dtywRankData {
	KillCount 0 : integer
	Point 1 : integer
	Name 2 : string
	UserId 3 : string
	Red    4 : boolean
	DeadCount 5 : integer
	DamageValue 6 : integer
	TypeId 7 : integer
	XiuBuCount 8 : integer
}

DATANGYANWU_GS01RequestData 1074 {
	request {
	}

	response {
		RankData 0 : *dtywRankData
		RedPoint 1 : integer
		BluePoint 2 : integer
	}
}

MARRIAGE_PARTY_Declare 1075 {
	request {
		Str 0 : string
	}
	response {
		ok 0 : boolean
	}
}

MARRIAGE_PARTY_PointLantern 1076 {
	request {
		Index 0 :integer
	}
}

MARRIAGE_PARTY_Reward 1077 {
	
}

MARRIAGE_PARTY_SendInvitation 1078 {
	request {
		FriendIds 0   : *string
		ChannelMask 1 : integer
	}
}

MARRIAGE_PARTY_UseInvitation 1079 {
	request {
		Key 0   : integer
	}
}

BUDDY_ZhuanSheng 1080 {
	request {
		slotId 0   : integer
	}
}

MARRIAGE_PARTY_CanPointLantern 1081 {
	request {
		Index 0 : integer
	}
	response {
		Ok 0 : boolean
	}
}
]]

