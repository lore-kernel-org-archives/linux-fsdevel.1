Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA5248F62;
	Fri,  3 Apr 2026 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187260; cv=fail; b=dYx6gsuFi1HKaQqtBtt3zf9jQ9DWNnQsmMiYYP5rG71bbsd1s+++qNxuOa/1cS31IwcxWxIpg8S5iS3hgJbBAh89cRjdxLFlhrfADGdAE91bhCbss8vIe1/EJhsrxw9Nm/lUMLlIlEa1vqR/qv8DRH4ddZn80XoefoU0DdUndLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187260; c=relaxed/simple;
	bh=sOScdVwfEL668xek38cTjnLlJftVLPbQceRtasuRHnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmcK9jquheGwi1uhbdqA17g3I89tRoJJCYGFg6MHTAleTxhs340VwCQ/rxdYe33C6IqqxZ7B54fEfuCw/4cffI8cawck/wC5nR5I2IWoDmlw9PI6FLSEpBaISmG1acpcSnLv5+MuKulT70vnHkxevCteXpMydc22l9H9XweFmeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=IeKRXBl7; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="IeKRXBl7"
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6331fXso2356118;
	Fri, 3 Apr 2026 03:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=uw4KqEv
	LDdXbomw4pC/gJoBNYpp3XpaioDOGFuUxbyw=; b=IeKRXBl7xHw8F85ClI8guEU
	3t7kPEE9xdrvFBEPAtW5ttWjTznCOadXQZW+dRaek4TkluWEjH0QhccqeBt1bwxr
	C+PoMaPkBvyaOy5WUvDI9Xd72LeXYKtmmApxju/sxUn3uKg6p6eQooZQFl3lqAR0
	yhpQJLA2mSquzWqD3y3EL5DPj996rs/XICvDVsq7YIZjsxpM/QauAXb06U/AfGhH
	/nkkkzzdQVPwB4F20HTBtIiVKJBm+anjvICXZWBpst30hmk3M4iEOJEjXqS6R6M9
	SMq6y0x2XW7Ma7NQd/nEtH6xTluIK9FlpsirIi9TokSfF8m+Hw0E0PFbSOIeuZA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012001.outbound.protection.outlook.com [40.107.75.1])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4d65utyhfu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 03:33:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiKvSYHpddVzQtXbGx2r7yj/MjjrAm5zhfrUuazFhGF836TTdzi8y/QF3bsq6dqhtScEj2SjaAqBw3Jf6MnLOjQAEtBtNJkVCkIOrnhXcIEYqrUxpXPiwmsPp4ykhzKmkyEoOgKtlsXbJ2RpOhQApjHY4xd53/mb75Olj+hLcw2tsv5UxWlZBUmNFIoq8YTl0afYoXPSiaQpzz71aeigH5GhoQELaim2eCBa9zEs3j8M46UqSUZ4mwqy+urT5oh5qfkzB8lNzRV6IqKc6k7ZEURXHFCWnJ/WAtgBEi8ycu83SaQicSUFOunNqZMOCfoi6iftNeN/2LpKI+eTo53zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw4KqEvLDdXbomw4pC/gJoBNYpp3XpaioDOGFuUxbyw=;
 b=G/1Zm3uzM4iu/T7MRfrq/Y81fs3YfoT8szFrukCh7uQNoDmNTiM928yQrSjVU9rGZbqgirUFAZ3k4ZWPGZbvSST3Gnaq8LrOs6tvlwgSQEgfVvHU/hSQKheHoNzZ3roeUNCSEvB4Y6P+NbQe2HWszuTWrJVYvVyMq786U7zw2jzP2XePD47P4lrNl50VLEJFfFNDLBoB7UD1XyPqc33mRgmwulTedggtVD/66TsyfQgZ2Ycs0kta6lwmJi/yUCuuzj7al/yNtrPYOSKQKaPhmbO0YWT2YHpFJuWdS5oJ+Sfv84kYiiexkUiGtxwT/NRzw3Vkeqem4AIBAMQf0BLxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KUZPR04MB9170.apcprd04.prod.outlook.com (2603:1096:d10:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 3 Apr
 2026 03:33:51 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 03:33:51 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chi Zhiling
	<chizhiling@kylinos.cn>,
        "syzbot@syzkaller.appspotmail.com"
	<syzbot@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2 5/6] exfat: introduce exfat_chain_advance helper
Thread-Topic: [PATCH v2 5/6] exfat: introduce exfat_chain_advance helper
Thread-Index: AQHcwabo2xROJsKGL0yxF2pmXJqQgbXMmnrGgAAKgQCAAAWk9Q==
Date: Fri, 3 Apr 2026 03:33:51 +0000
Message-ID:
 <PUZPR04MB6316FA116436AAB12EA72F18815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260401071138.114836-1-chizhiling@163.com>
 <20260401071138.114836-6-chizhiling@163.com>
 <PUZPR04MB6316F93B0D34197D68F302CF815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <0f46e0c6-82de-4aee-9d01-e417eb619bff@163.com>
In-Reply-To: <0f46e0c6-82de-4aee-9d01-e417eb619bff@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KUZPR04MB9170:EE_
x-ms-office365-filtering-correlation-id: a968e027-f6a6-45f1-77e2-08de9131d2e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 H81fPdjFxIBCNcu2Qsb7Tqw3aMKOm4Xb17g5xKWrV+Ub3g9rXvQ6jJReJ6gTG9iQKdRYDqo6e3sKAO8pSTAzF0jegEUxhCgZyQ6W+RnaakASNUoE4mLL0YhSJfiKPTD5+el7f475pTMNAutgmmHZE7ehTca4S7MkXDXnScwzYLWhYfdQib9t7jrSnCpIV9mfsqaoECKI2cv3YnBCzhQmt3rbJy/ImHE9aJ3mlzPiVbbdgrflO4C5ZjeD4pj6RSKfwly9HvtHjXbUSDocE1pNlQCx/JPFCOlXDQEH1U5sPN60UojgY2064Y6+SH7xPVsCyXjHUR/cc8gZ9QeJnRzsXKkSXpAl+x3m4ncGlIYhLs6eHuM7RZBFe4QZ1ufAaZnuqINTiRUZb4D6NQ74vndLGqEk8MYIygNG0GgeFLP98P7nxuWiZL5PfokeCeHKV//xTH1eT38SCJROkp78hGHWmH7BDpqTkKLiBEQ2Aft1sup3ELg0eBo3Q+bu8pPsQkuSdPnOWPmrZGr1sbiiscR7rQhkJLeMb2Kh+geAt7J/UhfAY6SiH0i1fxNm/aPHO9Z0yu+Ld3sjRMliPSKk5hPFAHGPoQErjy+0ef6RMSajYzBIV0u9JqUfBWB6mtoYiCIzcXkOka4ZSPTbWoi2bRuem2F+XNwa4HlgmqzjjevgjD9Bp9C06HhXmlARWM3bKSstRrOOXJ6SYrfudbrFX/0t27+Y+n118jpGn/OwhizMRv+wMybn5haptILZ3OI3wJjTC5DcGdwC12hvnEI+3/rm0sqN1HQjL1XZQHFyL120RhU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1yndkiSKyPt5KqxPZ6jS16uyRNoa9Ra2tJKHizd3Y8UWozgxpGWo/PEkqU?=
 =?iso-8859-1?Q?IRB/S8t74H4hNnVJUfRpYv1wKKiJkVHSVAYIfHBazPdFK60kp96fZx1WKc?=
 =?iso-8859-1?Q?yLM0S8F/+RbSaHV09mmErKRUCRjm28uTOcvYv6/kBdqBlFFPuZyrgSh+js?=
 =?iso-8859-1?Q?Ym9Pc4hXPt2eXVAqT1fewkRD56aWvLl0XgMNQAh6QjQ69NZZt0MsrJcgw9?=
 =?iso-8859-1?Q?JPiF/sCAK4v4zHyztwYCOu42PGxs5XOYacI+5Xpp4TD4pdtGFTuM9WvBBc?=
 =?iso-8859-1?Q?vjIZUdAQfqX1Zgsa31G3v7LWzvek1YR8BANhYZRFoyrFoz7tBQkciyE8Jk?=
 =?iso-8859-1?Q?F/1lQiy5q6SSU8zCeuETzOb4wZdN6KgW3Z6ZEWREw+CTVBV6ykoMASUcOF?=
 =?iso-8859-1?Q?MeBrJ9Tbpcc/KxhQGsVLuDDmkAn/69o0Uzxkcl4XhYBDbo+OdLGtSRhowC?=
 =?iso-8859-1?Q?FSoZdt1XvpGSR+c4HH7CSOEb8jf9zKsv8XbqFZCrE+KNvGqjDx/ienIU+0?=
 =?iso-8859-1?Q?BKl6BLEA17vlOY+kRGvW+LbsthezpPj3edS7U0SDvgS1EOgQlW2j93HYu4?=
 =?iso-8859-1?Q?n14li/mEBkWBOWCMIMfO7gTa4bG3nsNGD+cOn+ABBx+b+Udv9plk5s2pkw?=
 =?iso-8859-1?Q?c3dB8E5Zaxo/xkIf/SaPfRBp1+IBNgj1Y6hGviOg3gHPaVQHF2BTiE84Om?=
 =?iso-8859-1?Q?J4s9ILKw8MlOZfT+5Sd/Gx/5ONavJwVCFjRWVsyv927Yk8WXB6oKF02JFG?=
 =?iso-8859-1?Q?XrnbHoWYyNlPWv+Obzf/Dh8Kck3QqV6l6LMSdq7qpTVPrTVz+15w+fxddK?=
 =?iso-8859-1?Q?uOdC3uJ8Fi/PHvloOlOb5JHw21owXx52WgET51TqbXsMSle2YQgA6ZH/1y?=
 =?iso-8859-1?Q?AXYItfDg6QoDuBaxAAs8VHIbDQHfNjxScte4Q9JRRrApU6HxzNFxXxdqMA?=
 =?iso-8859-1?Q?7jqyFB3rNQPFuOcg8QO1FtP6wdYPmAF/JNB51wNwhKHCnLu6ZVNkIJhkuL?=
 =?iso-8859-1?Q?8dGIzOdHLqCbc4sthsez//h0ZcCnJB1szXBSQLIYcSTkyCqCVDMWqJpCYl?=
 =?iso-8859-1?Q?vXkswyH3x8yRJXm70d8ywbm+jW4DMl2tP8eRg3UGcYyVOe2CD4L5NaB5HK?=
 =?iso-8859-1?Q?+ol3p1+BrehdufYrtcVbi8kB8tczAmi7Lb2OJig2fZtgNkLDrrUvUdykB6?=
 =?iso-8859-1?Q?D5qqdN/t7/RFz9M2rEg42Wecvu++AVr2PU9pS3CeRvEUzLqi9BdFMg/ZGU?=
 =?iso-8859-1?Q?mKXH0oNnMZhRvglHWM7YDY5LjNkETXBjKf4K210gg1g7+i4YO8rQdKLjnd?=
 =?iso-8859-1?Q?g3OCV3/zMI9XvCbhcIrnTW2lAID1sRn8V6HOJKz8JyMa04gBqG1ZFfFD6m?=
 =?iso-8859-1?Q?x3T+3VW1XgzLH6XY1abFqdrNEnoLdY65k7V9BT50l19h/V/vDgE8Dd7hTG?=
 =?iso-8859-1?Q?23btvsTK4/EamojzhUpoEra5bkyKpatTsrUWXJ1H2ywEK8HOiPacmrml/G?=
 =?iso-8859-1?Q?QuXrOod6PEQZjaX2igjr03c/JqNTH/jYbQOUWYnVKwDXthEDKVqa5FySAt?=
 =?iso-8859-1?Q?eI/W9Q/cOjPKOSolFhii37NQcfDUcUGrK25WGNcIW/dUAsgWRN3RsUcxHk?=
 =?iso-8859-1?Q?zjlu4pwQ53Cy+BQxEreLy29z210JVW6kneZOslq4+T21WZWdRCP/rrNf9V?=
 =?iso-8859-1?Q?7xNC6/zHvh2Dn+zjY/Qh+5npR3sel/yNrK0+YZsyWAYOQ9i+J/MGQ19PAw?=
 =?iso-8859-1?Q?iWn7MsDsrESwK0y44piNmDYWL6weCyptQjTBik20KoQ/PM5SoRLHtFUiyU?=
 =?iso-8859-1?Q?ExFsK/7A2HCeFDm6TAeeHkG7hx8TXtE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XrPZhTmtr886UnHs85b5vrA5WZB+HuDoamojzDI1gT3W6koLS8kAwES1tgYFuftF7/1Vgj69g27vzYN8vpGV/Xd4Y23pBcTpa/dO42v4sm1xZOGpfoTPg15KT1+n3P1jMhq9N0xWASY4xJ4yZBHKMpZWTuDeBnXmGe06TttvClFmTWySg9p6AqiNPqYv9AcxinpKZg3MkIjUfoc+L2RnREkL3GSzSYAv450OzDQCQVT+TqJxpVmdljHi8S68/mAYIEqY8XgduU65TlpFxmNBgeel5+KMxEd6dxEyNU3Ihr7ihY3l3tksVX8g13LbhcCu8j/GBHL+iX/lvHBwgZBY3g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	47dDccPDer/rtmNWdbTwaX7o7Bjn8y6aK4DOCG2o0E0XtjX3v9L6nPLjdhdn5hKW5Tbw9svnytXzHszg+7kopQ82Svn2HQ0IDi9YxT+jWZzRvCX4BqCNiUyGB9lk092kKqqQnkIKZ1YEdRmiymiW4RQfeRbxX5tSV3O3ff/qODwszahqXeOfJ0A1Gn/M4GAcBSCZsRQXJtiuihRJddi7M7M+9oMMoen9rvxtOM9YMft5AID1YDkE9Z1UOxvABNJm5XY5ldwmg7L1g7Oc+ADrS3wkidFs9Kp4My9KVOVFcd4fuBousVo8wtStMMZ7i7zYKLj8pqE9be2gVu+2dHRWgdB0Xo20nNkgBIb7LkNDjC+ek8wNwkdCTGqdR/CzrX7WzcPziIaLeUxSlpVzgCulo+bqTI6n6YP2gE0F2zJ+1IuyCC9Makydu0qmYbMtMQCJGdCPZU+lAQMQ7R5pk95ctPQlxQr6Pa06Mv27blACqhr6IWrhskPohrrwGlbaBX0sGTVF2B/Dp2ArVpdRcertVtDCBP0uyn6r1qGsybPpJmOEkVdxVzpg5L+D0UyJafEzt0c4KVXteteMGkqRi5gzLpC593rCEChEEqZBf97xUUS3XbAceGScFBmjOM2PVJv0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a968e027-f6a6-45f1-77e2-08de9131d2e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 03:33:51.0262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ligsgAE9Iq/SGmK6h0KYmA+2ljwgSVSygimhFeglAJNGGCPwPXrjNPzIIzCMjFPrEriC/wibpSXvlEtRYKl/UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB9170
X-Proofpoint-GUID: ByYxEx7KYxwzLwzgPlYq91nEoCO93dmx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAyOCBTYWx0ZWRfX8wh7P7FYR+sn
 ZuFjmSIDFyTeFTpgNs3X4nYERHQMMbARsFQi4U1vA/vh5WdqMiAhckIGnJbA3c08/mbcaN+9Iyt
 YjjbuZy0uYiMQJHu0HxMfT9fsBt047i2RQL49ZWpzn/tAMpmucPBJJEhDamKZSISQcSs9aV9x+/
 +aOfmsvSCOUHaNx0ozV8Dnwox+FuvvOm53ko6S6ULhzcLAiMfutk7JErYBcYSTRFPv/uszi5Sv2
 0VrEIxh8gq5qYrnNP6WTJ70As76Ox/Fo/IbOZf/9ui35FcjGZyZEAIeVp7ykPO3YKwDT2gD4cGc
 8VlUJEySyjjBTLch/0d5gOa0MD1xMhiYhvZSO7UFjSgMhAXih5dfFI4RCJ0/Be1bRdyFmcnnP21
 hEI6pk0Q/cdIRxnc26Kdn6LZEqROILyjdQEzfvWnel+U4M2DDcEXlvmZWUSvPzFSYfbdzJWRBb0
 jnO/YeX0JrL4xzp3lYQ==
X-Authority-Analysis: v=2.4 cv=X6Vf6WTe c=1 sm=1 tr=0 ts=69cf3524 cx=c_pps
 a=HxIMnyElsDSQbyWpFcpfrw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=b20fedWF67CaGdYoUt4Y:22
 a=z6gsHLkEAAAA:8 a=hSkVLCK3AAAA:8 a=a8kb0EB0RjMOpiRCxIYA:9 a=wPNLvfGTeEIA:10
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: ByYxEx7KYxwzLwzgPlYq91nEoCO93dmx
X-Sony-Outbound-GUID: ByYxEx7KYxwzLwzgPlYq91nEoCO93dmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01

> On 4/3/26 10:34 AM, Yuezhang.Mo@sony.com wrote:=0A=
> >> From: Chi Zhiling <chizhiling@kylinos.cn>=0A=
> >>=0A=
> >> Introduce exfat_chain_advance() to walk a exfat_chain structure by a=
=0A=
> >> given step, updating both ->dir and ->size fields atomically. This=0A=
> >> helper handles both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes with=
=0A=
> >> proper boundary checking.=0A=
> >>=0A=
> >> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>=0A=
> >> Tested-by: syzbot@syzkaller.appspotmail.com=0A=
> >>=0A=
> >> ---=0A=
> >> fs/exfat/exfat_fs.h | 17 +++++++++++++++++=0A=
> >>   1 file changed, 17 insertions(+)=0A=
> >>=0A=
> >> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
> >> index 530459ab9acc..1035d20ba563 100644=0A=
> >> --- a/fs/exfat/exfat_fs.h=0A=
> >> +++ b/fs/exfat/exfat_fs.h=0A=
> >> @@ -552,6 +552,23 @@ int exfat_read_volume_label(struct super_block *s=
b,=0A=
> >> int exfat_write_volume_label(struct super_block *sb,=0A=
> >>                               struct exfat_uni_name *label);=0A=
> >>=0A=
> >> +static inline int exfat_chain_advance(struct super_block *sb,=0A=
> >> +               struct exfat_chain *chain, unsigned int step)=0A=
> >> +{=0A=
> >> +       if (chain->size >=3D step)=0A=
> >> +               chain->size -=3D step;=0A=
> >=0A=
> > It would be better to not change *chain if return an error.=0A=
> =0A=
> Okay,=0A=
> =0A=
> v3:=0A=
> =0A=
> static inline int exfat_chain_advance(struct super_block *sb,=0A=
>                  struct exfat_chain *chain, unsigned int step)=0A=
> {=0A=
>          if (chain->size < step)=0A=
>                  return -EIO;=0A=
> =0A=
>          chain->size -=3D step;=0A=
> =0A=
>          if (exfat_fat_walk(sb, &chain->dir, step, chain->flags))=0A=
>                  return -EIO;=0A=
> =0A=
>          if (chain->size =3D=3D 0 && chain->flags =3D=3D ALLOC_NO_FAT_CHA=
IN)=0A=
>                  chain->dir =3D EXFAT_EOF_CLUSTER;=0A=
> =0A=
>          return 0;=0A=
> }=0A=
> =0A=
=0A=
chain->dir should also not be changed.=0A=
=0A=
static inline int exfat_chain_advance(struct super_block *sb,=0A=
                 struct exfat_chain *chain, unsigned int step)=0A=
{=0A=
         unsigned int clu =3D chain->dir;=0A=
=0A=
         if (chain->size < step)=0A=
                 return -EIO;=0A=
=0A=
         if (exfat_fat_walk(sb, &clu, step, chain->flags))=0A=
                 return -EIO;=0A=
=0A=
         chain->size -=3D step;=0A=
=0A=
         if (chain->size =3D=3D 0 && chain->flags =3D=3D ALLOC_NO_FAT_CHAIN=
)=0A=
                 chain->dir =3D EXFAT_EOF_CLUSTER;=0A=
         else=0A=
                 chain->dir =3D clu;=0A=
=0A=
         return 0;=0A=
}=0A=
=0A=
> =0A=
> Thanks,=0A=
> >=0A=
> >> +       else=0A=
> >> +               return -EIO;=0A=
> >> +=0A=
> >> +       if (exfat_fat_walk(sb, &chain->dir, step, chain->flags))=0A=
> >> +               return -EIO;=0A=
> >> +=0A=
> >> +       if (chain->size =3D=3D 0 && chain->flags =3D=3D ALLOC_NO_FAT_C=
HAIN)=0A=
> >> +               chain->dir =3D EXFAT_EOF_CLUSTER;=0A=
> >> +=0A=
> >> +       return 0;=0A=
> >> +}=0A=
> >> +=0A=
> >>   /* inode.c */=0A=
> >>   extern const struct inode_operations exfat_file_inode_operations;=0A=
> >>   void exfat_sync_inode(struct inode *inode);=0A=
> >> --=0A=
> >> 2.43.0=0A=
> >=0A=
> >=0A=
