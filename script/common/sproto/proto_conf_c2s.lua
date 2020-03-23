local conf = [[
.package {
	type      0 : integer
	session   1 : integer
}

.position {
	x         0 : integer
	y         1 : integer
	z         2 : integer
}

AUTH_HandShake 1 {
	request {
		operator      0 : integer
		channel       1 : integer
		platform      2 : integer
		openId        3 : string
		appId         5 : string
		os            6 : string
		imei          7 : string
		idfa          8 : string
	}
	response {
		code          0 : integer
		msg           1 : string
		sault         2 : string
		patch         3 : string
		serverSec     4 : integer
		serverUsec    5 : integer
		serverTzone   6 : integer
	}
}

AUTH_Auth 2 {
	request {
		data          0 : string
	}
	response {
		code          0 : integer
		msg           1 : string
	}
}
]]
return conf
