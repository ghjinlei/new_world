conf =  [[
.package {
	type 0 : integer
	session 1 : integer
}

.position {
	x 0 : integer
	y 1 : integer
	z 2 : integer
}

.positionX {
	x 0 : integer(2)
	y 1 : integer(2)
	z 2 : integer(2)
}

.userData {
	Level 		0 : integer
	LoginTime 	1 : integer
	Name 		2 : string
	TypeId 		3 : integer
	UserId 		4 : string
	RequestFlag	5 : boolean
}

.memberInfo {
	UserId		0 : string
	PlayerName	1 : string
	PlayerIcon	2 : string
	IsLeader	3 : boolean
	IsReady		4 : boolean
}

.buddyInfo {
	Idx		0 : integer
	Level	1 : integer
	Star	2 : integer
	TypeId	3 : integer
}

.rivalData {
	RankKey		0 : integer
	BuddyMap	1 : *buddyInfo(Idx)
	Combat		2 : integer
	Icon		3 : string
	Level		4 : integer
	Name		5 : string
	TypeId		6 : integer
}

.mkFriendUserInfo {
	Level		0 : integer
	LoginTime	1 : integer
	LogoutTime	2 : integer
	Name		3 : string
	TypeId		4 : integer
	UserId		5 : string
	Vip		6 : integer
	ForbidPhotoTime 7 : integer
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
	Vip		9 : integer
	OpenId 		10 : string
	ForbidPhotoTime 11 : integer
	FamilyId	12 : string
	CombatPower	13 : integer
}

.objPack {
	idxLst 			0 : *integer
	packedValLst	1 : string
}

.buffObj {
	BuffId			0 : integer
	BuffObjPack		1 : objPack
}

.packedItemData {
	SId		0 : string
	ItemObjPack	1 : objPack
	ClassType	2 : integer
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
	RefAttrKeyList	8 : *integer
	RefAttrValueList 9 : *integer(4)
	Status		10 : integer
	Level		11 : integer
	Aptitude	12 : integer
	Standby		13 : boolean
}

default 1 {
	request {
		msgData 0 : string
		compressed 1: boolean
	}
}

SCENE_ENTITY_POSITION 2 {
	request {
		EntityId 0 : integer
		pos      1 : position
	}
}

SCENE_ENTITY_ROTATION 3 {
	request {
		EntityId 0 : integer
		rot      1 : integer
	}
}

SCENE_ENTITY_DOACTION 4 {
	request {
		EntityId 0 : integer
		ActionId 1 : integer
		Params   2 : string
	}
}

.S_AOI_Enter_Entity {
	entityId		0	:	integer
	entityTypeId 	1	:	integer
	x 				2	:	integer
	z 				3	:	integer
}

AOI_Enter 5 {
	request {
		entity		0	:	S_AOI_Enter_Entity
	}
}
AOI_EnterArray 6 {
	request {
		entities	0	:	*S_AOI_Enter_Entity
	}
}

.S_AOI_Mov_Entity {
	entityId		0	:	integer
	x 				1	:	integer
	z 				2	:	integer
}

AOI_Mov 7 {
	request {
		entities		0	:	*S_AOI_Mov_Entity
	}
}

AOI_Leave 8 {
	request {
		entityId		0	:	integer
	}
}

AOI_LeaveArray 9 {
	request {
		entityIds		0	:	*integer
	}
}

AOI_Clear 10 {
	request {
	}
}

MESSAGE_QUEUE_GDoCallback 11 {
	request {
		msgId	0 :	integer
		data	1 :	string
	}
}

MESSAGE_QUEUE_GDoCallbackError 12 {
	request {
		msgId	0 :	integer
		code	1 :	integer
		msg		2 : string
	}
}

CreateUser 13 {
	request {
	}
}

InternalError 14 {
	request {
		msg		0 : string
	}
}

OnLogin 15 {
	request {
		UserId		0 : string
		sceneId		1 : integer
		areaId      2 : integer
		dirUrl      3 : string
	}
}

OnKicked 16 {
	request {
		msgID		0 : integer
		msg		1 : string
	}
}

SyncUser2Client 17 {
	request {
		userId	0 	: string
		data 1	: string
		index	2 : integer
	}
}

OnCharAttrChange 19 {
	request {
		InnerId 	0 : integer
		keyDataIdx	1 : string
	}
}

SetMyCharObj 20 {
	request {
		innerId		    0 : integer
		charTime    	1 : integer
		packData		2 : string
	}
}

SetOtherCharObj 21 {
	request {
		sId		    	0 : string
		charTime    	1 : integer
		packData		2 : string
	}
}

SCENE_ENTITY_RUNTO 22 {
	request {
		EntityId     0 : integer
		NetworkPoint 1 : position
		Time         2 : integer
	}
}

SCENE_MODEL_UpdateEntity 23 {
	request {
		EntityId		0 : integer
		keyDataIdx		1 : string
		SceneId			2 : integer
	}
}

HintClient 24 {
	request {
		dictId		0 : integer
		strParamList	1 : *string
		switch		2 : integer
	}
}

ShowItemList 25 {
	request {
		dictId		0:  integer
		itemList	1:  *ItemData
		switch		2:  integer
	}
}

FIGHT_PANEL_UpdateSkillPanel 26 {
	request {
	}
}

.BaguaDesc {
	typeId	0:  integer
	amount	1:  integer
	level	2:  integer
	userId	3:  string
	baguaId	4:  integer
}

ShowBaguaList 27 {
	request {
		dictId		0:  integer
		baguaList	1:  *BaguaDesc
		switch		2:  integer
	}
}

.ResDesc {
	resType	0: integer
	resAmt	1: integer
	resRate	2: integer
}

ShowResList 28 {
	request {
		dictId		0:  integer
		resList		1:  *ResDesc
		switch		2:  integer
	}
}

.TellFrom {
	SubChannel	0: integer
	Name		1: string
	EntityId	2: integer
	UserId		3: string
	IconId		4: string
	Level		5: integer
	Vip		    6: integer
	SceneId 	7: integer
	QQVip       8: integer
	RedPacketId 9: string
	ForbidPhotoTime 10:integer
}

CHAT_Tell 29 {
	request {
		channel		0:  integer
		msg		1:  string
		from		2:  TellFrom
		config		3:  string
	}
}

CHAT_PrivateTell 30 {
	request {
		msg		0:  string
		from		1:  TellFrom
		config		2:  string
		toUserId	3:  string
	}
}
SCENE_ENTITY_RunToStraight 31 {
	request {
		EntityId     0: integer
		NetworkPoint 1: position
		Time         2: integer
		pos      	 3: position
		rot		 	 4: integer
	}
}

TASK_SetObstable 32 {
	request {
		IsOn 0: integer
		List 1: *integer
	}
}


HintClientX 33 {
	request {
		data		0 : string
		switch		1 : integer
	}
}

REDDOT_SetActive 34 {
	request {
		reddotKey	0 : string
		isActivate	1 : boolean
	}
}

FRIEND_PushRecommendData 35 {
	request {
		recommendInfoList 	0 : *userData
	}
}


SCENE_MODEL_UpdateEntity_HpMp 36 {
	request {
		EntityId		0 : integer
		SceneId			1 : integer
		Hp				2 : integer(1)
		Mp				3 : integer(1)
	}
}

.danmuMsg {
	Type   0: integer
	UserId 1: string
	Msg    2: string
}

CHAT_BroadCastDanMu 37 {
	request {
		DanMuList 0: *danmuMsg
	}
}

SCENE_ENTITY_SPEAK 48 {
	request {
		SceneId	 0 : integer
		EntityId 1 : integer
		TypeId	 2 : string
		Msg	 3 : string
		Time	 4 : integer
	}
}

ShowAddExp 50 {
	request {
		dictId	0 : integer
		exp	1 : integer
		switch	2 : integer
		expRate 3 : integer
	}
}

ShowAddBuddyExp 51 {
	request {
		dictId	0 : integer
		exp	1 : integer
		switch	2 : integer
	}
}

UI_MAIN_MONEY_ADD_OpenByServer 52 {
	request {
		resType 0 : integer
		resAmt 1 : integer
	}
}

UI_COMMON_ROUND_OpenByRound 53 {
	request {
		ChapterIndex	0 : integer
	}
}

UI_COMMON_QINGHUA_CONFIRM_OpenByServer 54 {
	request {
		ConfirmId		0 : integer
		CountDown		1 : integer
		MemberInfoList	2 : *memberInfo
	}
}

UI_COMMON_QINGHUA_CONFIRM_CloseByServer 55 {
	request {
	}
}

UI_COMMON_QINGHUA_CONFIRM_RefreshQinghuaConfirm 56 {
	request {
		ConfirmId	0 : integer
		UserId		1 : string
		Flag		2 : integer
	}
}

UI_CHALLENGE_CLOSE 57 {
	request {

	}
}

UI_MAIN_ITEM_GET_OpenByServer 58 {
	request {
		itemTypeId 0 : integer
		amount 1 : integer
		quality 2 : integer
	}
}


FRIEND_DelRecentUser 59 {
	request {
		UserId 0 : string
	}
}

SCENE_ENTITY_RunByPath 60 {
	request {
		EntityId 		0: integer
		NetworkPointList 	1: *position
	}
}

BATTLE_ENTITY_WARRIOR_WarriorShowAction 61 {
	request {
		entityId 0 : integer
		actionName 1 : string
	}
}

BATTLE_ENTITY_WARRIOR_AddSkill 62 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		skillObjPack	2: objPack
	}
}

BATTLE_ENTITY_WARRIOR_UpdateSkill 63 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		skillTypeId		2: integer
		skillObjPack	3: objPack
	}
}

BATTLE_ENTITY_WARRIOR_UpdateAllSkill 64 {
	request {
		sceneId				0: integer
		entityId 			1: integer
		skillTypeId			2: integer
		skillObjPackArray	3: *objPack
	}
}

BATTLE_ENTITY_WARRIOR_RemoveSkill 65 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		skillTypeId		2: integer
	}
}

BATTLE_ENTITY_WARRIOR_CastSkill 66 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		packParamStr	2: string
		TypeId			3: integer
		Normal			4: boolean
		CDEndTime_1		5: integer
		CDEndTime_2		6: integer(3)
		Level			7: integer
		Grade			8: integer
		paramPointEntityId	9: integer
	}
}

BATTLE_ENTITY_WARRIOR_CastSkillFail 67 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		skillTypeId		2: integer
	}
}

BATTLE_ENTITY_WARRIOR_StopSkill 68 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		skillTypeId		2: integer
	}
}

.RunBehaviorReocil{
	CastTime		0: integer(3)
	Haste			1: integer(3)
	NormalSkill		2: boolean
	Phase			3: integer
	TotalTime		4: integer(3)
	TurnTo			5: boolean
	Moveable		6: boolean
	MovingCast		7: boolean

}

BATTLE_ENTITY_WARRIOR_RunBehavior 69 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		skillTypeId		2: integer
		behaviorTypeId	3: integer
		recoil			4: RunBehaviorReocil
		recoil_now_1	5: integer
		recoil_now_2	6: integer(3)
	}
}

BATTLE_ENTITY_WARRIOR_RunCurve 70 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		curveId			2: integer
		pos             3: positionX
		behaviorId      4: integer
		distance        5: integer(1)
		time            6: integer(1)
	}
}

BATTLE_ENTITY_WARRIOR_RemoveCurve 71 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		curveId			2: integer
	}
}

BATTLE_ENTITY_WARRIOR_AttachBuff 72 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		buffId			2: integer
		buffObjPack		3: objPack
	}
}

BATTLE_ENTITY_WARRIOR_UpdateBuff 73 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		buffId			2: integer
		keyDataIdx		3: string
	}
}

BATTLE_ENTITY_WARRIOR_RemoveBuff 74 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		buffId			2: integer
	}
}

BATTLE_ENTITY_WARRIOR_ShowDamage 75 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		CasterEntityId	2: integer
		Value			3: integer
		AttackTypeId	4: integer
		Crit			5: boolean
		NoHit			6: boolean
		LeftHp			7: integer(1)
	}
}

BATTLE_ENTITY_WARRIOR_ShowHeal 76 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		CasterEntityId	2: integer
		Value			3: integer
		Crit			4: boolean
		LeftHp			5: integer(1)
	}
}

BATTLE_ENTITY_WARRIOR_FireBullet 77 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		targetId		2: integer
		typeId			3: integer
		duration		4: integer
	}
}

BATTLE_ENTITY_WARRIOR_ShowLine 78 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		otherEntityId	2: integer
		lineId			3: integer
		duration		4: integer
	}
}

BATTLE_ENTITY_WARRIOR_DoEffect 79 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		behaviorId		2: integer
		typeId			3: integer
		casterEntityId	4: integer
	}
}

BATTLE_ENTITY_WARRIOR_DoDodge 80 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		behaviorTypeId	2: integer
		casterEntityId	3: integer
	}
}

BATTLE_ENTITY_WARRIOR_DoWin 81 {
	request {
		sceneId			0: integer
		entityId 		1: integer
	}
}

BATTLE_ENTITY_WARRIOR_UpdateRotation 82 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		degree			2: integer
	}
}

BATTLE_ENTITY_WARRIOR_DoFadeOut 83 {
	request {
		sceneId			0: integer
		entityId 		1: integer
	}
}

BATTLE_ENTITY_WARRIOR_RotateTo 84 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		degree			2: integer
	}
}

SCENE_ENTITY_RunByDrag 85 {
	request {
		EntityId 		0: integer
		NetworkPoint 		1: position
	}
}

SCENE_ENTITY_RunToWithRange 86 {
	request {
		EntityId 		0: integer
		NetworkPoint 		1: position
		Time                    2 : integer
		Range                   3 : integer
	}
}

USER_SetTable 87 {
	request {
		key 0 : string
		value 1 : string
	}
}

USER_SetIntoTable 88 {
	request {
		tbl 0 : string
		key 1 : string
		value 2 : string
	}
}
.userInfo{
	UserId 0 : string
	Name	1: string
	LoginTime 2 : integer
	Sex 3 : integer
	TianzhuId 4 : integer
	WeaponId 5 : integer
	Level 6 : integer
	BodyId 7 : integer
	WingId 8 : integer
	WeaponStage 9 : integer
	RelationMask 10 : integer
	Vip 11 :integer
}
UserInfoList 90 {
	request {
		lst  0: *userInfo(UserId)
	}
}

OnCreateUser 91 {
	request {
		errMsgId 0 : integer
		userId 1 : string
		nickName 2 : string
	}
}

OnDeleteUser 92 {
	request {
		errMsgId 0 : integer
		userId 1 : string
	}
}

UI_COMMON_MATCH_Open 93 {
	request {
		CancelMethod	0 :	string
	}
}

UI_COMMON_MATCH_Close 94 {
	request {}
}

UI_COMMON_MATCH_ARENA_OpenByServer 95 {
	request {
		TimeEnd			0 : integer
		CancelMethod	1 : string
		DictId 2 : integer
	}
}

UI_COMMON_MATCH_ARENA_CloseByServer 96 {
	request {}
}

FUBEN_COUNTDOWN_OpenByServerDataByID 97 {
	request {
		TimeEnd	0 : string
		DictId	1 : integer
		Params	2 : *string
	}
}

.teamMemInfo {
	UserId	0 : string
	Name	1 : string
	Icon	2 : string
	Race	3 : integer
	Level	4 : integer
}

.teamData {
	TeamMemInfoList	0 : *teamMemInfo
}

UI_ARENA_TEAM_CONFIRM_Open 98 {
	request {
		CountDown		0 : integer
		TeamDataList	1 : *teamData
	}
}

UI_ARENA_TEAM_CONFIRM_Close 99 {
	request {}
}

ACTIVITY_NOTICE_MAIN_AddRobborBtn 100 {
	request {
		Duration	0 : integer
		.info {
			Icon	0 : string
			Name	1 : string
		}
		.pushData {
			Info	0 : info
		}
		PushData	1 : pushData
	}
}

ACTIVITY_NOTICE_MAIN_RemoveRobborBtn 101 {
	request {}
}

.mailData {
	MailId			0	: string
	Type			1	: integer
	Title			2	: string
	Sender			3	: string
	Time			4	: integer
	Msg				5	: string
	.item {
		ItemId		0	: integer
		Num			1	: integer
	}
	ItemList		6	: *item
	.cash {
		ResType		0	: integer
		Num			1	: integer
	}
	CashList		7	: *cash
	ItemDataList		8	: *ItemData
	Icon			9	: string
	ReadIcon		10	: string
	RewardId		11	: string
	Start			12	: integer
	OP				13	: integer
}

MAIL_ReceiveMail 102 {
	request {
		MailData	0 : mailData
	}
}

MAIL_PushMailDataList 103 {
	request {
		MailDataList	0 : *mailData
	}
}

MAIL_PushMailData 104 {
	request {
		MailData	0 : mailData
	}
}

SCENE_MODEL_RemoveEntity 105 {
	request {
		SceneId		0 : integer
		EntityId	1 : integer
	}
}

SCENE_ENTITY_GoTo 106 {
	request {
		SceneId			0 : integer
		SenderEntityId	1 : integer
		NetworkPoint	2 : position
	}
}

SCENE_ENTITY_ChangeModel 107 {
	request {
		BodyId	0: integer
	}
}

CHAT_SetAudioChannelInfo 108 {
	request {
		.info {
			Channel		0 : integer
			OpenLevel	1 : integer
		}
		InfoList	0 : *info
	}
}

ACTIVITY_MAIN_WINDOW_OpenByServerData 114 {
	request {
		ActivityIdList	0 : *string
	}
}

UI_GM_WEB_Open 115 {
	request {
		URL	0 : string
	}
}

UI_GROWUP_Open 116 {
	request {}
}

.baguaData {
	BaguaId			0 : integer
	TypeId			1 : integer
	Level			2 : integer
	Exp				3 : integer
	RawPriAttr		4 : string
	RawSecAttr		5 : string
	RawAddSecAttr	6 : string
	Switch			7 : integer
}

BAGUA_UpdateData 117 {
	request {
		BaguaId			0 : integer
		BaguaDataMap	1 : baguaData
	}
}

BAGUA_SetIntoBaguaMap 118 {
	request {
		BaguaId			0 : integer
		BaguaDataMap	1 : baguaData
	}
}

BAGUA_LoadBaguaMap 119 {
	request {
		SubBaguaMap	0 : *baguaData(BaguaId)
	}
}

SCENE_ENTITY_TalkToEntity 120 {
	request {
		ToSceneId		0 : integer
		EntityId		1 : integer
		NetworkPoint	2 : position
	}
}

BUDDY_WINDOW_Open 125 {
	request {}
}

SHORTCUT_USE_Push 126 {
	request {
		TypeId	0 : integer
		UseKey	1 : string
		Amount	2 : integer
	}
}

UI_SKILL_UPGRADE_OpenByServer 127 {
	request {
		SkillTypeId	0 : integer
		SkillLevel	1 : integer
	}
}

MSG_BOX_Show 128 {
	request {
		Msg		0 : string
		MsgId 	1 : integer
	}
}

UI_SKILL_OBTAIN_OpenByServer 129 {
	request {
		SkillTypeId	0 : integer
		SkillLevel	1 : integer
		ExistTime	2 : integer
	}
}

AUTH_OnLogout 130 {
	request {
		MsgId	0 : integer
	}
}

CMD_TellMe 131 {
	request {
		Msg	0 : string
	}
}

CHAT_SetAudioSendUrl 132 {
	request {
		Host	0 : string
	}
}

FRIEND_CloseMakeFriendConfirm 133 {
	request {
		UserId	0 : string
		UserName 1 : string
	}
}

FRIEND_PushRecentContacts 134 {
	request {
		UserId	0 : string
	}
}

FRIEND_WINDOW_Open 135 {
	request {}
}

FRIEND_WINDOW_ReOpen 136 {
	request {
		OpenTag 0 : integer
	}
}

FRIEND_WINDOW_OpenWithAllFriendsTag 137 {
	request {}
}

FRIEND_WINDOW_PrivateTalk 138 {
	request {
		UserId	0 : string
	}
}

FRIEND_PushMakeFriendConfirm 139 {
	request {
		MkFriendUserInfoMap	0 : *mkFriendUserInfo(UserId)
	}
}

FUBEN_LOGIC_Open 140 {
	request {
		TargetName		0 : string
		PrepareId		1 : integer
		CountDown		2 : integer
		MemberInfoList	3 : *memberInfo
	}
}

FUBEN_LOGIC_Close 141 {
	request {
		PrepareId	0 : integer
	}
}

FUBEN_LOGIC_ChangeReadyState 142 {
	request {
		PrepareId	0 : integer
		UserId		1 : string
		Flag		2 : boolean
	}
}

# FUBEN_READYGO_WINDOW_Open 143 {
# 	request {
# 		Title				0	: string
# 		Desc				1	: string
# 		Progress			2	: integer
# 		Limit				3	: integer
# 		TipsList			4	: *string
# 		.gameLevelInfo {
# 			RewardList		0	: *integer
# 			Lock			1	: boolean
# 			Level			2	: integer
# 			Name			3 	: string
# 		}
# 		GameLevelMap		5	: *gameLevelInfo
# 		EntityId			6	: string
# 		GamePlayTag			7	: string
# 		HideSearchTeam		8	: boolean
# 		RightTag			9	: string
# 		Difficulty1Disabled	10	: boolean
# 		Difficulty2Disabled	11	: boolean
# 		Difficulty3Disabled	12	: boolean
# 		.textData {
# 		}
# 		TimesTxt			13	: *textData
# 	}
# }

TASK_PANEL_UpdateTaskPanel 144 {
	request {}
}

TASK_PANEL_UpdateTeamPanel 145 {
	request {}
}

FUBEN_END_ANIMATION_Open 146 {
	request {
		IsWin	0 : boolean
	}
}

UI_MAIN_FIGHT_STATIC_Close 147 {
	request {}
}

FMOD_MODULE_PlayFightSoundByResult 148 {
	request {
		IsWin	0 : boolean
	}
}

FIVE_LOADING_BAR_Open 149 {
	request {
		.info {
			Index	0 : integer
			Id		1 : integer
			Prog	2 : integer
			Dir		3 : string
		}
		InfoList	0 : *info
	}
}

UI_FIVE_ARENA_RECORD_Create 150 {
	request {
		RS		0 : integer
		BS		1 : integer
		RF		2 : integer
		BF		3 : integer
		AT		4 : string
		IsRed	5 : boolean
	}
}

UI_NEW_RANKING_WINDOW_Open 151 {
	request {
		RankId	0 : integer
	}
}

ROLE_WINDOW_OpenSpecial 152 {
	request {
		SpecialTypeIdList	0 : *integer
	}
}

UI_MARKET_MAIN_OpenX 153 {
	request {
		FuncName	0 : string
		TagId		1 : integer
		GoodsIdList	2 : *integer
	}
}

DAILY_QUESTION_Open 156 {
	request {
		Questions	0 : *integer
		TimeLeft	1 : integer
		Correct		2 : *integer
	}
}

DAILY_QUESTION_Close 157 {
	request {}
}

SWEET_WALL_SELECT_Open 158 {
	request {
		Sign	0 : integer
	}
}

UI_PROFESSIONAL_CHALLENGE_MAIN_SetStartCountDown 159 {
	request {
		Duration	0 : integer
		MsgKey		1 : integer
	}
}

UI_PROFESSIONAL_CHALLENGE_MAIN_UpdateNextTime 160 {
	request {
		Time	0 : integer
		Wave	1 : integer
		Max		2 : integer
	}
}

COMMON_MODULE_TIPS_ShowFinishTaskEffect 161 {
	request {}
}

COMMON_EXPLAIN_Open 162 {
	request {
		Title	0 : string
		Content	1 : string
	}
}

.shopItemInfo {
	ItemType	0 : integer
	Name		1 : string
	CoinType	2 : integer
	Price		3 : integer
	Desc		4 : string
}

.sellInfo {
	Name			0 : string
	Desc			1 : string
	Info			2 : *shopItemInfo
	TaskItemsList	3 : *shopItemInfo
	EntityId		4 : integer
}

UI_SELL_MAIN_Open 163 {
	request {
		SellInfo	0 : sellInfo
	}
}

UI_SELL_MAIN_Close 164 {
	request {}
}

UI_SELL_MAIN_Update 165 {
	request {
		SellInfo	0 : sellInfo
	}
}

UI_POETRY_OpenByTaskId 166 {
	request {
		TaskId		0 : integer
		MainTaskId	1 : integer
	}
}

UI_TIANTI_MAIN_Open 167 {
	request {
		BestRank		0 : integer
		CurCount		1 : integer
		FreeCount		2 : integer
		MaxCount		3 : integer
		FinishTime		4 : integer
		CurRank			5 : integer
		RivalDataMap	6 : *rivalData(RankKey)
		TicketTypeId	7 : integer
	}
}

LINGNAN_SetLingNanMap 168 {
	request {
		CurFloor	0 : integer
		TotalFloor	1 : integer
		BossId		2 : integer
		GuardId		3 : *integer
		StartTime	4 : integer
		BossNumber	5 : integer
		GuardNumber	6 : integer
	}
}

GUIDE_StartServerGuideEx 169 {
	request {
		GuideId	0 : integer
	}
}

GUIDE_FinishGuideByServer 170 {
	request {
		GuideId	0 : integer
	}
}

GUIDE_SetBtnWorldCanClick 171 {
	request {
		Flag	0 : boolean
	}
}

UI_MAIN_SetQinggongBtnHideMask 172 {
	request {
		Mask	0 : string
		Flag	1 : boolean
	}
}

UI_MAIN_SetTaskPanelActive 173 {
	request {
		Flag	0 : boolean
	}
}

UI_MAIN_TwinkleHelp 174 {
	request {}
}

GUILDBOSS_OpenUIByServer 175 {
	request {}
}

UI_COMMON_ACTIVITY_INFO_OpenByServer 176 {
	request {
		Key				0	: string
		Name			1	: integer
		Icon			2	: string
		MaxTimes		3	: integer
		Intro			4	: integer
		Desc			5	: integer
		Reward			6	: *integer
		GoTo			7	: boolean
		GoToMsg			8	: integer
		.level {
			Min			0	: integer
			Max			1	: integer
		}
		Level			9	: level
		GuildLevel		10	: integer
		.time {
			Idx			0	: integer
			TimeList	1	: *string
		}
		Time			11	: *time(Idx)
		NeedReddot		12	: boolean
		Times			13	: integer
	}
}

TEAM_OpenTeamIfNoTarget 177 {
	request {}
}

TEAM_OpenApplyList 178 {
	request {}
}

COMMON_BUDDY_STANDBY_WINDOW_Open 179 {
	request {}
}

UI_EQUIP_GEM_WINDOW_OpenGemWindow 180 {
	request {}
}

UI_EQUIP_GEM_WINDOW_OpenMeltWindow 181 {
	request {}
}

UI_EQUIP_GEM_WINDOW_Open 182 {
	request {
		ToggleName	0 : string
	}
}

CHAT_LABA_WINDOW_Open 183 {
	request {}
}

UI_COMMON_CHANGE_NAME_Open 184 {
	request {}
}

UI_ITEM_PK_WINDOW_Open 185 {
	request {
		TypeId	0 : integer
	}
}

LOTTERY_Open 186 {
	request {}
}

ROLE_WINDOW_OpenByToggleName 187 {
	request {
		ToggleName	0 : string
	}
}

STORAGE_WINDOW_Open 188 {
	request {}
}

.moveOpt {
	SrcSlotId	0 : integer
	SrcItemSId	1 : string
	DstSlotId	2 : integer
	DstItemSId	3 : string
}
PACKAGE_OnBatchMoveItem 189 {
	request {
		SrcPackageType	0 : integer
		DstPackageType	3 : integer
		MoveOptList 1: *moveOpt
	}
}

PAY_OnPaySuccess 190 {
	request {
		BillId	0 : string
	}
}

PAY_OnPayFailed 191 {
	request {
		BillId	0 : string
	}
}

.bill {
	Id			0 : string
	UserId			1 : string
	TypeId			2 : integer
	Price			3 : integer(2)
	Time			4 : integer
	Yuanbao			5 : integer
	FirstYuanbao		6 : integer
	GiftGold		7 : integer
	GiftSilver		8 : integer
	Channel			9 : integer
	CchId			10 : integer
	MId			11 : integer
	Payed			12 : integer
}

PAY_Restore 192 {
	request {
		BillMap	0 : *bill(Id)
	}
}

SCENE_ENTITY_AvatarGoToScene 193 {
	request {
		ProtoId			0 : integer
		NetworkPoint	1 : position
	}
}

SCENE_ENTITY_AvatarRunToSceneByTeleport 194 {
	request {
		ProtoId			0 : integer
		NetworkPoint	1 : position
	}
}

SCENE_ENTITY_TalkToEntityByTeleport 195 {
	request {
		ProtoId			0 : integer
		EntityId		1 : integer
		NetworkPoint	2 : position
	}
}

SCENE_ENTITY_AvatarRunToScene 196 {
	request {
		SceneId			0 : integer
		NetworkPoint	1 : position
	}
}

SCENE_MODEL_Switch 197 {
	request {
		FromSceneId	0 : integer
		ToSceneId	1 : integer
	}
}

UI_STORY_CHAPTER_WINDOW_Open 199 {
	request {
		ImgPath		0 : string
		MaxShowTime	1 : integer
	}
}

STORY_LOGIC_JuqingShow 200 {
	request {
		Id		0 : integer
		Name	1 : string
		TaskId 2 : integer
		DoingTaskId 3 : integer
	}
}

FUBEN_CAMERA_ANIMATION_OpenByTask 201 {
	request {
		.cameraData {
			StartPos		0 : *integer
			StartRotation	1 : *integer
			EndPos			2 : *integer
			EndRotation		3 : *integer
			Time			4 : integer
		}
		CameraData			0 : cameraData
		Sign				1 : string
		TaskId				2 : integer
	}
}

SCENE_ENTITY_ShowEffect 202 {
	request {
		SceneId			0 : integer
		EntityId		1 : integer
		ShowEffectId	2 : integer
	}
}

SCENE_ENTITY_RemoveEffect 203 {
	request {
		SceneId			0 : integer
		EntityId		1 : integer
		RmEffectId		2 : integer
	}
}

TASK_ITEM_SUBMIT_Open 204 {
	request {
		TaskId		0 : integer
		Num			1 : integer
		.itemInfo {
			SId		0 : string
			Amount	1 : integer
		}
		Map		2	 : *itemInfo(SId)
	}
}

TEAM_UpdateMember 205 {
	request {}
}

.member {
	BodyId			0	: integer
	CombatPower		1	: integer
	Dead			2	: boolean
	EntityId		3	: integer
	IconPath		4	: string
	Level			5	: integer
	Name			6	: string
	Race			7	: integer
	SId			8	: string
	SceneId			9	: integer
	State			10	: integer
	Type			11	: string
	UserId			12	: string
	Sex			13	: integer
	WingId			14	: integer
	WeaponStage		15	: integer
	ForbidPhotoTime		16	: integer
}

TEAM_UpdateTeam 206 {
	request {
		.data {
			MemberMap		0	: *member(SId)
			PositionList	1	: *string
			GamePlayId		2	: string
			FilterIdList	3	: *integer
			IsAutoMatch		4	: boolean
			FakeFlag		5	: boolean
		}
		TeamId				0	: integer
		DataMap				1	: data
	}
}

TEAM_UpdateMemberInfo 207 {
	request {
		MemberId	0 : string
		Data		1 : member
	}
}

TEAM_SetAutoMatch 208 {
	request {
		Flag	0 : boolean
	}
}

TEAM_OpenTeamWithGamePlayTag 209 {
	request {
		GamePlayId		0 : string
		FilterIdList	1 : *integer
	}
}

TEAM_OpenWithFb 210 {
	request {
		GamePlayId		0 : string
		FilterIdList	1 : *integer
		protoName		2 : string
		.data {
			level		0 : integer
		}
		Data			3 : data
	}
}

TEAM_SubApplyCount 211 {
	request {}
}

TEAM_AddApplyCount 212 {
	request {}
}

UI_ARENA_INVITE_SetData 213 {
	request {
		Key				0 : integer
		.data {
			CombatPower	0 : integer
			IconPath	1 : string
			IsInvited	2 : boolean
			Level		3 : integer
			Name		4 : string
			Race		5 : integer
			UserId		6 : string
		}
		Data			1 : *data
	}
}

LOADING_BAR_Interrupt 214 {
	request {
		Oid		0 : integer
		UiType	1 : integer
	}
}

LOADING_BAR_Loading 215 {
	request {
		Oid						0	: integer
		.optMap {
			CanMove				0	: boolean
			MoveInterrupt		1	: boolean
			CanTransfer			2	: boolean
			FightPanelVisible	3	: boolean
			Msg					4	: string
			UIType				5	: integer
			StartByTouch		6	: boolean
			EffectId			7	: integer
			EffectScale			8	: string
			LoadingSecond		9	: integer
			NotUI				10	: boolean
			IconName			11	: string
			Timeout				12	: integer
			HintMsg				13	: string
			ActionName			14	: string
			Type				15	: integer
		}
		OptMap					1	: optMap
	}
}

FIVE_SHOW_MSG_Show 216 {
	request {
		MsgStr	0 : string
		Icon1	1 : string
		Icon2	2 : string
		Color	3 : string
	}
}

FIVE_LOADING_BAR_UpdateFloorColor 217 {
	request {
		Index		0 : integer
		Direction	1 : integer
	}
}

FIVE_LOADING_BAR_UpdataBarValue 218 {
	request {
		.info {
			Index		0 : integer
			Progress	1 : integer
		}
		InfoList		0 : *info
	}
}

BATTLE_ENTITY_HERO_UpdatePkRevengeMap 219 {
	request {
		.revenge {
			EntityId	0 : integer
			Flag		1 : integer
		}
		PKRevengeList	0 : *revenge
	}
}

FUBEN_CAMERA_ANIMATION_OpenWithPoint 220 {
	request {
		x	0 : string
		y	1 : string
		z	2 : string
	}
}

LINGNAN_UpdateLingNanMap 221 {
	request {
		LeftBossNumber	0 : integer
 		LeftGuardNumber	1 : integer
	}
}

FRIEND_MakeFriendConfirm 222 {
	request {
		FromUserInfo	0 : mkFriendUserInfo
	}
}

CHAT_PushPrivateMsg 223 {
	request {
		.msgInfo {
			.config {
				Type		0 : integer
				URL			1 : string
				AudioId		2 : string
				Duration	3 : integer
			}
			configData		0 : config
			from			1 : TellFrom
			msg				2 : string
		}
		MsgInfoList			0 : *msgInfo
	}
}

SCENE_MODEL_SyncScene 224 {
	request {
		sceneId			0 : integer
		avatarEntityId	1 : integer
		sceneObjPack	2 : objPack
		avatarObjPack	3 : objPack
		avatarBuffLst	4 : *buffObj
	}
}

BUDDY_SetIntoBuddyMap 225 {
	request {
		SId					0 : string
		BuddyObjPack		1 : objPack
		New					2 : boolean
		.skillData {
			SId				0 : integer
			SkillObjPack	1 : objPack
		}
		SkillDataList		3 : *skillData
	}
}

SCENE_MODEL_NewEntity 226 {
	request {
		SceneId				0 : integer
		EntityId			1 : integer
		EntityObjPack		2 : objPack
		ClassType			3 : integer
		BuffLst				4 : *buffObj
	}
}

PACKAGE_LoadItemMap 227 {
	request {
		ItemList	0 : *packedItemData
	}
}

PACKAGE_SetIntoItemMap 228 {
	request {
		PackedItemData	0 : packedItemData
	}
}

CHAR_Set 229 {
	request {
		SId		0 : string
		CharObjPack	1 : objPack
		ClassType	2 : integer
		CharTime	3 : integer
	}
}

SCENE_MODEL_SyncAttr 230 {
	request {
		SceneId			0 : integer
		SceneObjPack	1 : objPack
	}
}

CHAPTER_ANIMATION_Open 231 {
	request {
		mTask 0 : integer
		dTask 1 : integer
	}
}

SYNC_SCENE_ExpireTime 232 {
	request {
		SceneId 0 :integer
		ExpireTime 1 : integer
	}
}

TASK_UPDATE_STATE 233 {
	request {
		mTask 0 :integer
		State 1 : integer
	}
}

SHARPEN_REWARD_PANEL_OpenByRewardId 234 {
	request {
		rewardId 0 : string
		typeId 1 : integer
		msgId 2 : integer
		delay 3 : integer
	}
}

GATHER_AutoGatherHandle 235 {
	request {
		TypeId 0 : integer
	}
}

GATHER_End 236 {
	request {
	}
}

GATHER_Gone 238 {
	request {
		typeId 0 : integer
	}
}

FUBEN_TIANTI_SWEEP_OPEN 239{
	request {
	}
}


TASK_RunToTarget 241 {
	request {
		entityId 0 : integer
		protoId 1 : integer
		taskId 2 : integer
		sign 3: string
		point 4 : position
		taskType 5 : integer
	}
}

YAOSHENHUOSHI_ShowReward 242 {
	request {
		.extraRecord {
			UserName 0: string
			Damage 1 : integer
			DamagePercent 2 : string
			Reward  3 : integer
			ExtraReward1 4 : integer
			ExtraReward2 5 : integer
		}
		ExtraRecord 0 : *extraRecord

		.specialRecord {
			UserName 0 : string
			ExtraReward1 1 : integer
			ExtraReward2 2 : integer
		}
		SpecialRewardList 1: *specialRecord
	}
}

SCENE_MODEL_UpdateFubenExtraData 243 {
	request {
		SceneId 0: integer
		keyDataIdx 1: string
	}
}

SCENE_MODEL_UpdateSceneExtraData 244 {
	request {
		SceneId 0: integer
		keyDataIdx 1: string
	}
}

YUANXIAO_WakeUpAnime 245 {
	request {
		WakerEntityId		0 : integer
		SleeperEntityId		1 : integer
		WakerPackPos		2 : position	# 需要用MATH.PointUnpack变换
		SleeperPackPos		3 : position	# 需要用MATH.PointUnpack变换
	}
}

.welfareStatus{
	Name 0 : string
	IsActive 1 : boolean
	IsRemaining 2 : boolean
	BeginTime 3 : integer
	EndTime 4 : integer
	DestroyTime 5 : integer
	EventId 6 : string
}

WELFARE_MANAGER_OpenWelfares 800 {
	request {
		Welfares	0 : *welfareStatus
		OpenServer	1 : *welfareStatus
		Qianduange	2 : *welfareStatus
		Other		3 : *welfareStatus
	}
}

CMD_SHOWSERVERINFO 999 {
	request {
		Name 0	: string
		Info 1	: string
	}
}

CANPICK_ITEM_MANAGER 1000 {
	request {
		IdList 0: *integer
	}
}

FUBEN_MANAGER_Open 1002 {
	request {
		FubenClass 0: integer
		FubenTypeId 1: string
	}
}

MEDITATION_Cancel 1003 {
	request {
	}
}

TURFWAR_UpdateLeftUiRecord 1004 {
	request {
		Score 0: integer
		KillCount 1: integer
		DeadCount 2: integer
	}
}

TURFWAR_DoubleKill 1005 {
	request {
		Icon 0: string
		Name 1: string
		TitleID 2: integer
	}
}

TURFWAR_BeKilled 1006 {
	request {
		KillerName 0: string
	}
}

TURFWAR_UpdateTopUiRecord 1007 {
	request {
		CurrentScore 0: *integer
		EndTime 1: integer
		CampIndex 2: integer
		monsterID 3: integer
	}
}

TURFWAR_Kill 1008 {
	request {
		KillCount 0: integer
	}
}

AutoGatherHandle 1009 {
	request {
		TypeId 0 : integer
	}
}



BAOTU_TryDig 1011 {
	request {
		itemSId 0: string
		targetSceneProtoId 1: integer
		NetworkPoint 2: position
	}
}

BAOTU_TryNextDig 1012 {
	request {
		itemSId 0: string
	}
}

FACE2FACE_ExchangeReqNotify 1013 {
	request {
		exchangeId 0: integer
		userName 1: string
	}
}

FACE2FACE_ExchangeStartOperateItems 1014 {
	request {
		exchangeId 0: integer
		userName 1: string
	}
}

FACE2FACE_ExchangeOperateItemNotify 1015 {
	request {
		opUserId 0: string
		exchangeId 1: integer
		itemSId 2: string
		itemDesc 3: string
		itemAmount 4: integer
	}
}

FACE2FACE_ExchangeOperateResourceNotify 1016 {
	request {
		opUserId 0: string
		exchangeId 1: integer
		resourceType 2: integer
		amount 3: integer
	}
}

FACE2FACE_ExchangeLockNotify 1017 {
	request {
		opUserId 0: string
		exchangeId 1: integer
	}
}

FACE2FACE_ExchangeConfirmNotify 1018 {
	request {
		opUserId 0: string
		exchangeId 1: integer
	}
}

FACE2FACE_ExchangeSuccess 1019 {
	request {
		exchangeId 0: integer
	}
}

FACE2FACE_ExchangeCancelNotify 1020 {
	request {
		exchangeId 0: integer
		textId 1: integer
	}
}

SYNC_SCENE_AfterCall 1023 {
	request {
		ModuleName 0: string
		ActionName 1: string
		args 2: string
	}
}

MODIFY_DESTINY 1024 {
	request {
		Level 0 : integer
		Name 1 : string
	}
}

DESTINY_SHARE 1025 {
	request {
		Id 0 : integer
		TypeId 1 : integer
		Name 2 : string
		Level 3 : integer
		UserId 4 : string
	}
}

BATTLE_ENTITY_WARRIOR_DoFloorEffect 1026 {
	request {
		sceneId			0: integer
		entityId 		1: integer
		behaviorId		2: integer
		casterEntityId		3: integer
		networkPoint 		4: position
	}
}

TRADECENTER_ExtractTradeEarningNotify 1027 {
	request {
		result 0: boolean
	}
}

.taskData {
	State 0 : integer
	TargetWord 1 : string
	ChatData 2 : string
	TargetData 3 : string
	CurrentTimes 4 : integer
	TotalTimes 5 : integer
	IsRmTimeOut 6 : boolean
	TaskId 7 : integer
	DoingTaskId 8 : integer
	SceneId 9 : integer
	SceneProtoId 10 : integer
	NpcId 11 : integer
	Position 12 : position
	EntityId 13 : integer
	EndTime 14 : integer
	ParentTaskId 15 : integer
	Sign 16 : string
}

TASK_Update 1028 {
	request {
		taskList 0 : *taskData
	}
}

TASK_TinyUpdate 1029 {
	request {
		State 0 : integer
		TargetWord 1 : string
		ChatData 2 : string
		TargetData 3 : string
		CurrentTimes 4 : integer
		TotalTimes 5 : integer
		IsRmTimeOut 6 : boolean
		TaskId 7 : integer
		DoingTaskId 8 : integer
		SceneId 9 : integer
		SceneProtoId 10 : integer
		NpcId 11 : integer
		Position 12 : position
		EntityId 13 : integer
		EndTime 14 : integer
		ParentTaskId 15 : integer
		Sign 16 : string
		ShareFlag 17 : boolean
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
	OpenId	15 : string
}

.guildApply {
	UserId 0 : string
	TypeId 1 : integer
	Level 2 : integer
	Name 3 : string
	Power 4 : integer
	Time 5 : integer
}

.guildDataMap {
	GuildInfo 0 : guildFullInfo
	MemberList 1 : *guildMember
	ApplyList 2 : *guildApply
	IdMap 3 : *integer
}

GUILD_AfterCreateGuild 1030 {
	request {
		GuildDataMap 0 : guildDataMap
	}
}

GUILD_UI_GUILD_MAIN_Update 1031 {
	request {
		Open 0 : boolean
		GuildDataMap 1 : guildDataMap
	}
}

.guildList {
	GuildList 0 : *guildFullInfo
	ApplyMap 1 : *integer
}

GUILD_UI_GUILD_LIST_Update 1032 {
	request {
		Open 0 : boolean
		List 1 : guildList
	}
}

GUILD_UI_GUILD_MAIN_RefreshSingleInfo 1033 {
	request {
		UserId 0 : string
		Data 1 : guildMember
	}
}

TRADECENTER_BuyTradeItemNotify 1034 {
	request {
		result 0: boolean
		textId 1:integer
	}
}

ACTIVITY_MAIN_WINDOW_ShowActivityUseList 1035 {
	request {
		ActivityId	0 : string
		TypeId		1 : integer
	}
}

.title {
	titleId 0 : integer
	param 	1 : string
}

TITLE_GainNewTitle 1036 {
	request {
		TitleId 0:integer
		Title 1: title
	}
}

.ChangAnCityWarData {
	LocalValue  0: integer
	OwnerBidAdd 1: integer
	Name 2: string
	IsOwerGuild 3: boolean
	Logo 4 : string
}

CHANGANCITYWAR_UpdateData 1037{
	request {
		Data 0: *ChangAnCityWarData
		AllBidValue 1: integer
		GuardName 2: string
		GuildFund 3: integer
	}
}

GUILDTASK_SHARE 1038 {
	request {
		Id 0 : integer
		TypeId 1 : integer
		Name 2 : string
		Level 3 : integer
		UserId 4 : string
		TaskId 5 : integer
		mTaskId 6: integer
	}
}

HOME_OpenHomeChooseWindow 1039 {
	request {}
}

TASK_Begin 1040 {
	request {
		TaskId 0 : integer
	}
}

ShowTitleKill 1041 {
	request {
		KillerIcon 0 : string
		killerName 1 : string
		ShowId 2 : integer
	}
}

ShowIonAndIcon 1042 {
	request {
		KillerIcon 0 : string
		KillerName 1 : string
		DeaderIcon 2 : string
		DeaderName 3 : string
	}
}

ShowWhoKillMe 1043 {
	request {
		Name 0: string
	}
}

ShowWoGettingFlg 1044 {
	request {
		FlagId 0 : integer
		Value  1 : integer
		IsLock 2 : boolean
	}
}

MAIL_DeleteMailList 1045 {
	request {
		MailDelList 0 : *string
	}
}

TOUGONG_Update 1046 {
	request {
	}
}

COMMON_MultiKill_Counter 1047 {
	request {
		KillCount 0: integer
	}
}

COMMON_MultiKill_Notice 1048 {
	request {
		IconId 0: string
		DictId 1: integer
		DictParamList 2: *string
	}
}

MARRIAGE_FLOWER_EFFECT 1049 {
	request {
		FromUserId 0 : string
		ToUserId 1: string
		FlowerTypeId 2 : integer
		FromUserName 3 : string
		ToUserName 4 : string
		Amount 5 : integer
	}
}

TASK_FinishSubTask 1050 {
	request {
		TaskId 0 : integer
	}
}

TASK_OpenTaskTips 1051 {
	request {
		TaskId 0 : integer
		Name 1 : string
	}
}

FRIEND_PushUserInfo 1052 {
	request {
		userInfo 0 : friendInfoItem
	}
}

FRIEND_PushUserInfoList 1053 {
	request {
		userInfoList 0 : *friendInfoItem
	}
}

UI_GUILD_BONFIRE_INFO_Open 1054 {
	request {}
}

TREASURE_LOTTERY_RefreshEventsData 1055 {
	request {
		.event {
			EventKey	0 : string
			BeginTime	1 : integer
			EndTime		2 : integer
		}
		Events			0 : *event(EventKey)
	}
}

UI_GUILD_DONATE 1056 {
	request {}
}

CHANGANCITYWAR_OpenUI 1057 {
	request {
		OpenId 0 : integer
	}
	response {
	}
}

CHAT_GUILD_SHARE 1058 {
	request {
		msg 0 : string
		userId 1 : string
		iconId 2 : integer
		name 3 : string
		level 4 : integer
		guildName 5 : string
		guildId 6 : integer
		vip 7 : integer
		qqvip 8 : integer
	}
}

SCENE_ENTITY_RotateTo 1059 {
	request {
		EntityId 		0: integer
		Rotation		1: integer
	}
}

GUILD_OpenGuildWindow 1060 {
	request {}
}

UI_CloseByServer 1061 {
	request {
		UIType 0:string
	}
}

GUILD_UI_StartDefenseWindows 1062 {
	request {}
}

YCMB_RefreshEventsData 1063 {
	request {
		.sub {
			Tag			0 : integer
			BeginTime	1 : integer
			EndTime		2 : integer
		}
		ActiveSubItems	0 : *sub(Tag)
		MainBeginTime	1 : integer
		MainEndTime		2 : integer
		MainIsActive	3 : boolean
		EventId			4 : string
		Phase			5 : integer
	}
}

ITEM_UI_OpenWindows 1064 {
	request {
		UIType 0:string
		ToggleType 1:integer
		ToggleName 2:string
	}
}

USER_INTO_UI_ShowByUserId 1065 {
	request {
		targetUserId 0: string
	}
}

UI_MAIN_ShowMinggePanel 1066 {
	request {
	}
}

GUILD_COMMAND_GS01ChangePostion 1068 {
	request {
		TargetUserId 0:string
		PositionList 1:*integer
	}
}

LUCKY_CARD_RefreshEventData 1069 {
	request {
		IsActive	0 : boolean
		BeginTime	1 : integer
		EndTime		2 : integer
		Phase		3 : integer
		EventId		4 : string
	}
}

SCENE_ENTITY_POS_ROT 1070 {
	request {
		EntityId 0 : integer
		pos      1 : position
		rot		 2 : integer
	}
}

FIREWORKS_LOGIC_FIREWORKS_START 1080 {
	request {
		BeginTime	1 : integer
		EndTime		2 : integer
		DestroyTime	3 : integer
	}
}

PINGLUAN_UI_OpenByServer 1081 {
	request {}
}

LOGIN_QUEUE_NotifyUserIndex 1082 {
	request {
		queIndex 0:integer
	}
}

UI_REPORT_MAIN_WINDOW_Open 1083 {
	request {
		TargetUserId	0: string
	}
}

TSS_AntiSendHackerPkg 1084 {
	request {
		PkgData 0:string
	}
}

TENCENT_BuyGoods 1090 {
	request {
		GoodsId		0: integer
		ProductId	1: string
		Price		2: integer
		Amount		3: integer
		UrlParams 	4: string
	}
}

MSG_BOX_Show_ForceOpen 1091 {
	request {
		Msg		0 : string
	}
}

TENCENT_PaySuccess 1092 {
	request {
		TypeId		0:integer
		Yuanbao		1:integer
		Price		2:integer
		BillId		3:string
		Time		4:integer
	}
}

TENCENT_BuyGoodsSuccess 1093 {
	request {
		GoodsId		0:integer
		Amount		1:integer
		Price		2:integer
		BillId		3:string
		Time		4:integer
	}
}

JIANIANHUA_PushData 1094 {
	request {
		Task 0 : *string
		TotalDayNum 1 : integer
	}
}

TENCENT_RefreshToken 1095 {
	request {
	}
}

GUILD_Leave 1096 {
	request {
	}
}

JIANIANHUA_UpdateGameplayData 1097 {
	request {
		TaskKey 0 : integer
		Record 1 : string
	}
}

JIANIANHUA_UpdateRewardData 1098 {
	request {
		Type 0 : integer
		Day 1 : integer
		RewardKey 2 : integer
	}
}

MSG_BOX_MultiFuben_Confirm 1099 {
	request {
		FubenTypeId 0 : string
		SelectLevel 1 : integer
		NeedCreateTeam 2 : boolean
	}
}

APPEARANCE_AddNew 1100 {
	request {
		Type 0 : integer
		AppearanceId 1 : integer
	}
}

Marriage_YuanbaoInsufficient 1101 {
	request {
		
	}
}

GUILD_SetCreateGroupTimes 1102 {
	request {
		times 0 : integer
		isLeader 1 : boolean
	}
}


GUILDAUCTION_ResetCanBid 1103 {
	request {

	}
}

CHANGANCITYWAR_NotifyUI 1104 {
	request {
		TypeId 0 : integer
	}
}

CHAT_CleanHistory 1105 {
	request {
		UserId 0 : string
		ChannelList 1 : *integer
	}
}

CHANGANCITYWAR_OpenParty 1106 {
	request {
		TypeId 0 : integer
	}
}

SCENE_ENTITY_RunToAndAutoFight 1107 {
	request {
		protoId 0 : integer
		position 1 : position
	}
}

UI_OPEN_NOTICE_SetData 1110 {
	request {
		NoticeId 0 : integer
		Active 1 : boolean
	}
}

ZHUBO_ConfirmGiveGift 1114 {
	request {
		zhuboId 0 : string
		giftTypeId 1 : integer
		amount 2 : integer
		token 3 : string
		msgText 4: string
	}
}

ZHUBO_SEARCH_ZHUBO 1115 {
	request {
		ip 0 : string
		port 1 : integer
	}
}

ZHUBO_UPDATE_ROOM 1116 {
	request {
		IM_RoomId 0 : string
		Talk_RoomId 1 : string
	}
}

ZHUBO_SET_ZHUBO 1117 {
	request {
		zhuboId 0 : string
	}
}

UI_TEQUAN_BIG_WINDOW_OpenByServer 1118 {
	request {}
}

FIREWORKS_GET_REWARDS 1120 {
	request {
		ItemDataList 0 : *ItemData
	}
}

GUILD_OpenInviteTips 1121 {
	request {
		InviterId 0 : string
		InviterName 1 : string
		GuildName 2 : string
		GuildId 3 : integer
	}
}

YUANDAN_OpenCharacterPanel 1122 {
	request {
		entityId 0:integer
		myCharacter 1:integer
		finish 2:boolean
		setIndexList 3: *integer
	}
}

.buddyProfile {
	SlotIdx		0 : integer
	TypeId		1 : integer
	Level		2 : integer
	Quality		3 : integer
	Star		4 : integer
	Combat		5 : integer
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

UI_BINGQIPU_MAIN_Open 1123 {
	request {
		CurCount		0 : integer
		FreeCount		1 : integer
		MaxCount		2 : integer
		CurRank			3 : integer
		CurCombat		4 : integer
		OpponentDataMap	5 : *opponentData(RankKey)
		TicketTypeId	6 : integer
	}
}

.recruitData {
	FamilyId 	0 : string
	FamilyName 	1 : string
	LeaderName 	2 : string
}

Family_Receive_Recruit 1124 {
	request {
		RecruitData 	0 : *recruitData
	}
}

UI_FAMILY_CHANGE_NAME 1125 {
	request {
		TargetId 	0 : string
	}
}

UI_FAMILY_KICK_FAMILY 1126 {
	request {
		TargetId 	0 : string
	}
}


TASK_ClickTask 1127 {
	request {
		mainTaskId	0 : integer
		doingTaskId	1 : integer
	}
}

UI_COMMON_MATCH_ARENA_CloseUI 1128 {
	request {

	}
}

.requestEnterData {
	UserId 		0 : string
	Name 		1 : string
	Level 		2 : integer
	CombatPower 	3 : integer
	TypeId		4 : integer
	LastRequestTime 5 : integer
}

Family_Receive_RequestEnter 1129 {
	request {
		RequestEnterData 	0 : *requestEnterData
		IsCover			1 : boolean
	}
}

FLOWER_AddLog 1130 {
	request {
		Time 0 : integer
        FromUserId 1 : string
        TargetUserId 2 : string
        ItemId 3 : integer
		Amount 4 : integer
		FromName 5 : string
		TargetName 6 : string
	}
}

FLOWER_OpenSendFlowerUI 1131 {
	request {
		targetUserId 0 : string
	}
}

FLOWER_ScreenEffect 1132 {
	request {
		itemId 0 : integer
	}
}

NEW_YEAR_StartPlayEffect 1133 {
	request {
		EndTime 0:integer
	}
}

BAOTA_GET_REWARDS 1135 {
	request {
		ItemDataList 0 : *ItemData
	}
}

UI_FAMILY_WINDOW_OPEN 1136 {
	request {}
}

FAMILY_FUBEN_MONSTER_COUNT 1137 {
	request {
		TotalNum 0 : integer
		KillNum  1 : integer
	}
}

UI_KUAFU_MAIN_WINDOW_Open 1138 {
	request {
	}
}

SONGQIN_TryCountdown 1139 {
	request {
		SetoutTime 0 : integer
	}
}

UI_JITAN_MAIN_SET_BOSSINFO 1140 {
	request {
		IsEnterBattle 0:boolean
		BossType 1: integer
	}
}

WEDDING_OPEN_OATH_PANEL 1141 {
	request {
		EndTime 0 : integer
	}
}

WEDDING_ADD_GLOBAL_EFFECT 1142 {
	request {
	}
}

WEDDING_OPEN_FIREWORD 1143 {
	request {
	}
}

WEDDING_CREATE_LANTERNS 1144 {
	request {
	}
}

WEDDING_REMOVE_LANTERNS 1145 {
	request {
	}
}

WEDDING_OPEN_INVITE_PANEL 1146 {
	request {
		FriendIds 0 : *string
	}
}

MARRIAGE_PARTY_SyncRewardCount 1147 {
	request {
		Candy 0 : integer
		Lantern 1 : integer
	}
}
]]
