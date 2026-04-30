Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4343793C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549746; cv=fail; b=ZD7GLFgl3S85Zi847yg2K+VH0CwWUyNIoyzY3QodLmx//5HtBxbLotf+DBlw29WeAvd6MXrjQR62weHbpIvyuyj19NvrfZxqTrwgs3eJRgrinn9DiUoW3nKTfMqg3NnKA3+2PQ9vh7u2a6H1IqdHSQHzMAhjtLY5lI5MVUnCYsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549746; c=relaxed/simple;
	bh=Kwf2ty0g4VesizK+3cju2b4skDeI3DH/vCl2FktxGCY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gV9JKAmhpAlieSLLTrBORxHxWHzI/Quol/2Rdj1Ajs17V5g433GPT/iIHCiKtZqPxVer1yETDqrpXmHkt/54NXE7bHlg22CF4aJdMreRu9wBRBg53S+OhmPHrGNxPZW4a5/6yBobJWaVr0iWfPXaYXXNDQxQcxdd60X9OVIvDbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=FBehzFhK; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="FBehzFhK"
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UBLcmA3828113;
	Thu, 30 Apr 2026 11:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=NLyTHDq
	HY7t3IyoT42W4fZKMdwEradQjgUdFRFcJ4Sg=; b=FBehzFhKSh849Zk06NSgZ2d
	5H+fYDfMolNIU0QL7ZeWcf3UII3BB7VduiEn2TvTT0WwtnQJr6q2RlMC8VE4iFi3
	LPbFkcz7vDmpwIRVBClLd39N3AyTheR8Mp7eUqBcByq+T9rGLsb/J4mm7JLVedw/
	P17oUl2vYWns1DYDU+/nicaEnVShys3d6UjW4F2MZECISBnoBGkigRAnby8gXpGN
	9i0QRl+EGTqW+NeXMdgl0nzs2lhwaMiFB6TrmjWC4IjQxgxdYHlHLTDIaDQ8BK2d
	U+5OBG4O2j2NX6hEOA+0Y0GgAmGuSDu43fcEbBJeb1QlWhwRfku9A2C/8OQikNA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012029.outbound.protection.outlook.com [40.107.75.29])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4drktdnshv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 11:48:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnVUNJJBgAKu5fbBJGkvEoSf6Gi7cgnuqY5MmqF6T9gFsBeblGAES3jq+QQNPMWcE/XR9mNLXX4vBF6e2GR64XI4GV/LdVdZ3NKv0QMWUuieo5ZqPZZMgRc/nBwEzIL9UAqJOL5jjoe+k64cf6P1wlJwnmRyUMQuxgbfL2O0Hj4qez+tCNHmJkHJuPWDknJ4rTcohEaOLfju8vtvYtDzS8ht+hEVi1NEtB+HVjePNIX3u5IPXFEIyHbFiln2PdjmNxYgCRPsZwRwoQhZ5MhOBMaKeaBNb07PanterkLY69HF1V3pIQ2g4JgrTSfDB9qRbk/mzrCSTfk7LmxABeElwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLyTHDqHY7t3IyoT42W4fZKMdwEradQjgUdFRFcJ4Sg=;
 b=h6HfzLG1xRO2aYsETyFV0ukEzOdeumoUAwnQ7eDBwFuGKaXyNPkAT/hb0YG8AbYtvi3KI0q5SZ9Fej28HI6SEwHQwqhdcb6Mam8AlYp7q1ix1Piw4/Dsq99ets4JfCvs4tUPI/BOxlHdZFlqOG68DMD7ug1+X8ED+b6yWsZCBB9mC7SRmLZrmArwZDG5G/Pj8xyakj6jirZ9UxzymVqq1y3cyA9DoDoGk4Ej4WzlXQo2TSnQPPPNgGLrTvTugIjidXzelw7xc3avdIG8PglP61mozMCcgtUltoK+PLulBfoOFtgkhtlAY5rfD9rmU+ex0lH0MxYRWFeANG97Fz0iDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB6343.apcprd04.prod.outlook.com (2603:1096:400:328::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:48:38 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 11:48:38 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
Thread-Topic: [PATCH v1 2/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
Thread-Index: AQHc12np1ZnUrgkEIUykrJx6T+bQ5LX3OoFUgAAi6gCAACFDRA==
Date: Thu, 30 Apr 2026 11:48:38 +0000
Message-ID:
 <PUZPR04MB63163EE1D4CAB693180948A581352@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-3-dxdt@dev.snart.me>
 <PUZPR04MB6316657C9EB764F8A3A119AB81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <79b70927-e766-4487-bbda-2481288a0f31@dev.snart.me>
In-Reply-To: <79b70927-e766-4487-bbda-2481288a0f31@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB6343:EE_
x-ms-office365-filtering-correlation-id: 5fef197f-fc89-4a49-6d3e-08dea6ae6b07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 jX1BfMqqdbiCXTZJ05lvOclY5JsY5QOSs+0pEggHtMYche1b7aEnH1TqY0aYC2vqfIjShcjCs1qFY3bAp3Ka3IS8tTp1hLiLiqK3InLkJsSkizBa5dJIw5wZHqt/DqfhSS8Qv6qB75m2ksBoxrFshah8CXioAL8vm/IjB5Uq3jAXvEe8SMmiWegVNFio5Ue3dqYjXPbfkI3SiYGTQeo8AM9+FGu3uytnzX3aCx+FfGRg9YhFu/xram9rrIb3X7oALRCmUJHWWzSVIPfJ057P2RAd9J0PQrxC1RThS0kYp1LyiX5VAQvXOENcI+Arg7T6ZGByx/xLU3nMvm7dBS0VzuJHPgGov6xaNIDMPbrYMS7nlNR8hWTp7Io9QHPqWJFsYUVWCsDM9Ow4WUCpHZQsEkdDRQ+oqsiwlgwCSuwrczCWa5u3nGEYJBsrVKwKCpz8Iu9d8n1QDSm4uHMSxX5gjYAzA44DaEY2TTymYqIspILZ9kFCqR45D1l8wI6ZauNTmOQd2wD3SYJaWLP0C06G0WC4Am5/4USB3bCAdoApooNqvDnOimJo7yiR4do+8jBFxX76sltJw4ZE0Pn6DLRkVx3gta7KM6OfIR1WXe7MsjGwmM1OZ6gCoi61ngoOEuBr3I/PTpGmdA+jWMYsUgF0gZaHWiA2Gc449QhXQaVtSnw+z51bujFbjqHydayYxi8bkrSR4V0onZAiCDwFzAG/NgAdcg5mrH5W7YYmQMTHEigp+vr/hxwLhRybZOW4hYMupr+rV00ScqYk5B/XdMjnEX2fuFns3nEBeYJb1rUuDVQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WO+T2qkc+Jb6wQnVjcztmLo2cTeskv2zzhvxyM51H9VM+KEypE5urxJsLW?=
 =?iso-8859-1?Q?PlcHe/u8PbA7FUl+Fs9lQ1TjdyUAuWTsq+tKl1X+fKhOFXBx3Ojzxr1gXZ?=
 =?iso-8859-1?Q?q4RaC4fXsY1WyJfEebjfe3ZdOywGtVyLUlVfug5A7jD4w3REpURpQmL0dx?=
 =?iso-8859-1?Q?zRSZ9KH6sCU+AmIJaTgwcLmB1pu+RNBJIHb4JqxXzZVimH93MpuR2CCadK?=
 =?iso-8859-1?Q?js8lOdLw96JaGd6mfIWG2xkV4YbCfKMSlkrjMMQYt/Ia2NDc8wJI7rTQIC?=
 =?iso-8859-1?Q?5hbJuhYyONcNxsXu3Fm277jqwWeKtt1NUdyyyZm/ms9S+dYn4itpTm1PGF?=
 =?iso-8859-1?Q?sGH3/U5mh+1zAl3C22Un87kH0eBLlQ0UqGUOmdJV8K+qcYYCDTKNzwlCwS?=
 =?iso-8859-1?Q?xpIRAQjmBBTznJAXPC5wPJZSzFq+FjInn7Wb/yc/gE9+kr2ClGne2qt306?=
 =?iso-8859-1?Q?jA2bl/ce8n/AyP8H9VAEEFfrikYLyE9pTaQML+LXl/iggOHsOHO6B3Vp4Q?=
 =?iso-8859-1?Q?yFS6ChLpZaqCTp75He4NLUHcYt0dDs6jxHqpVofm9472FhPtsAfDAU35gN?=
 =?iso-8859-1?Q?tPa8ub/tjk59FZFKKY60nOSB57KjW1hGe9EdjtzwxjoFURWqk6i9GqceNV?=
 =?iso-8859-1?Q?GiGOnVlJOn8/X4p8kO1dBvaEDKSRfzjKZpY5477AZRyByXHjtWzcdxnyKR?=
 =?iso-8859-1?Q?GSnUuRry6meWZkJdq2CdkVZOQUhirEUtrXkyBHtn5dFua6Wa3wq7CKL4PT?=
 =?iso-8859-1?Q?qSIsfUUtVGtDFPczXKskbqlJZkf2NQRpg1vtaEqS+ve2AqfYuz8bwPm8JE?=
 =?iso-8859-1?Q?uZUqNMQrv3n9FDUsGyEfdXUQfZcXwuNpQmdq+Egs0OcjXNRXgKA9R2yeAg?=
 =?iso-8859-1?Q?P6drmjGXA0uX4ii930PFteLz8v2u0b2yRdzISwTNeI2phfnxVDaoWC8TXD?=
 =?iso-8859-1?Q?ajWUd1h9QROXgmKTBUXgveQ0M0khRVfgAeAWu0SJ07pLX9Jci5PAIeMC5t?=
 =?iso-8859-1?Q?xHvtCG6ucEIa5W+Y7sCa4U5D0Hzb/kq5Mbrx9k66yRw52oWAenNvGtWEFW?=
 =?iso-8859-1?Q?g4RLB5ebRcACnslZZR8Owiz5Y4gYDY7hk261n75D4i4lTB8J8Qehk8L2T3?=
 =?iso-8859-1?Q?HtTRNAg3ZsMpL9Soa0pMWCSVBb12X8w6Trootn47+GqnxP2X6qL7AWgnO+?=
 =?iso-8859-1?Q?bc5tLyU0L+SshgtMZCWwUGhjZcxyXjvYmsqIs7TH9+ecSYwpINAfpPP8x3?=
 =?iso-8859-1?Q?hjep2bASYtCKYbdGec84bS8Sk1iVzMy2bf47Cd+3qrl7U78xMU8ycceryG?=
 =?iso-8859-1?Q?3Jx7XsUrWZlyoOVapNdTN+SDHlsjKs0oiMjm6q5tECmAURPrExu1YaM9Wq?=
 =?iso-8859-1?Q?jcRMM1H9CR/S5QXhJPd2y5cUtnM+dQxAuhVy2X3mXlDsl7cumPWSatHs8E?=
 =?iso-8859-1?Q?hQ0BDoWU19QBVRIxep2Kp+zeR/gHmgfkeCPJ5I1v+2/akvPGdwv7lTbU5j?=
 =?iso-8859-1?Q?52K7M6QZAmc5vrGGlTtsmE1Mo6WBCK/fITOokR6+I4tJ8HuIvVoz4XvlCv?=
 =?iso-8859-1?Q?wEbHNV36HTYG65UDgKbI6IVmWYwZ2k0ERqAKxlK1nV+xtqbHqhXH9QKjVy?=
 =?iso-8859-1?Q?qRXpTc3KYKwgkzCahWhQNnAF6YxQ5SVlbaaGhDGlxiHkR3SZ3jWgT8vQCi?=
 =?iso-8859-1?Q?T/R+i3iH5iJKX3yHGKUKZvMfUrAJPxFLOJeGONcW1s/ojEOg7V9COD6GJZ?=
 =?iso-8859-1?Q?8SiME/ChK6U0vihTjZQkf2L4ZS81ju+aIIb4uDAv9DCw3kvZkR+NWfXMlV?=
 =?iso-8859-1?Q?tRJQ77ogegqOLPFUqvqhkoPGxHF/zL4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jNJzuS8thG0+S4RlefhDV4PHKxlc8T5r2FDtelS8XoFDYOISTzbWtT2bHshGvrhxtRg6a4Qsomtb9HXKQfYKHAe1YpiUpnlxlH+L9+DvVKA6F0J/PlUKhzerthbPS9er6qFh5917F2tHoe4RAozFHJPEp0iUAoQ/3Y0Jwz4WzNQhkqTE+PMJ9WhaC5M4rRuDf+uyAXq4pky1dNqa22A+bPhFy94KslIigMSdWZunx/VpTjgWi5fEBSl+Xao6gpBohI/Bi8tvkVadsII8OmIjby74TxqyvDSrGmdeeG+kg+2p21/43R1TS5xI3aQ3qfFweDHE9Up7Oo2hKdJ/YhYeNw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x9JqzadIN4p7Jx2CzBmEvwPSDl3rXT+TGSDMp0O4OFkylAK2Krowegk4u9yepPPExP4izvNYlrCsxDSpn3ata+htGQVV1a8lnoQKKKwATST2vau5/GWJz0OJ1Z08jo5d3S/zy6K2jHM17QqX1cOTtIrb0nSMJ7eoDgSQNV5INjUCB0BdGtvmZ2rW3e51CbevcsOepI+BfmdjcR3GyLyvOkf29SQiyXm4+drHJIRRsMfhT6L3nZGLIJcSrQGgpDiR42C55QE9+6vyxkryICOFwXAxInRzPqmvJu8eIwLM11Oid8ieUCxhexSyxU7IhqpxhcwhDfIhJscsYUMrzPJO/0GWE3+rpnhBsNgi7AA3aTySTJwT1UvClBEePywEZcqmDqKd0jICnZa0Lp0hb8IawmsXM1kOpZP/zi2HjQf7tfypQQBnVPPakr5yG0rpyXxFxX9WGjhTr7gVeTJxS+FRERgN9RIUMPlS4gV1XVNrFk0alQFRlP99cH9i1f1soIlDngDz0KaXcam8TC2UoPseLgtmM3d0zKeefyeIl/DWV5D5yU4M2wOX1Cmm2XhNrnfVcuuIyOeL80CGgW8ZY5L+45MC3nTr8eg6+mmppygxcKEG2PYhLDQ/yBt4sua3jorh
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fef197f-fc89-4a49-6d3e-08dea6ae6b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 11:48:38.2650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uh7nxYC+ADkgQCB27o4OGo//O/TIXOU1i4QAT5TmfioJH3TNoaJGHTp/zy1bmilMozl8MSepm1oBwOkFjsJSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6343
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEyMCBTYWx0ZWRfX4EGa4WrA7DR1
 WgUt49O1j3JpVKjtoVO0kGjLHT8OXmApQ77BV/RpfvXMrl0Uy23bp1wWuPTj3VmdqKKRUcJ5/PL
 3kNkLkRwgCMhfx/o3ayFqmrP++5nvg3eBB3IWu5Y671h/QZgcyjyzVFMbtV88ZuyTQbtQUcxTMC
 BFFtRhtxvj+WBy3Pr/ZUNeLzkraOOjk/K8qgcimquxLA4edYCDdR98t2Mg/FpE7ExwJGgNbOPvt
 dykqwCwA0HHMxdLOyUueKF4EIaYVNoV5IHQ/l+2FpVIVC+BNozZr/XeXPgIMLa0i7vWn0ugPVuh
 6vxt8eIynLHZ7pVVmfQ83X/v5Ndatjrwem+GBQdp5DMM9lAaxX7L94ziILAMYzi7q2e9+yQJoFo
 OsFyuDpfTj6i2+napjzmSru9nJk1+gcD+c5uy10YdRsk5Oysu0zoBXj9YVxFI35RoJgQ1mjgPn2
 o/atEazm8bpiFbOv9sw==
X-Proofpoint-ORIG-GUID: URcuffKvzglYOZxmHa-g_u7aiK3q8wos
X-Proofpoint-GUID: URcuffKvzglYOZxmHa-g_u7aiK3q8wos
X-Authority-Analysis: v=2.4 cv=Q5TiJY2a c=1 sm=1 tr=0 ts=69f3419c cx=c_pps
 a=HoTJ84mEtfQ0dpb6y/f3IQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=lmptg-Pxpg44AF-n8Qp9:22
 a=z6gsHLkEAAAA:8 a=6U3a1BeVi4rxWXsw2u8A:9 a=wPNLvfGTeEIA:10
X-Sony-Outbound-GUID: URcuffKvzglYOZxmHa-g_u7aiK3q8wos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01

> On 4/30/26 16:58, Yuezhang.Mo@sony.com wrote:=0A=
> >> +static inline __u16 exfat_lookup_upcase_ptable(const struct exfat_upc=
ase_ptable *ptbl,=0A=
> >> +      a       const __u16 index)=0A=
> >> +{=0A=
> >> +     const size_t page_idx =3D index / EXFAT_UPTBL_PAGESIZE;=0A=
> >> +     const size_t idx_in_page =3D index % EXFAT_UPTBL_PAGESIZE;=0A=
> >> +=0A=
> >> +     return ptbl->pages[page_idx] =3D=3D NULL ? 0 : ptbl->pages[page_=
idx][idx_in_page];=0A=
> >=0A=
> > How about this? Then we won't need to check it again in exfat_toupper()=
.=0A=
> >=0A=
> > return ptbl->pages[page_idx] =3D=3D NULL ? index : ptbl->pages[page_idx=
][idx_in_page];=0A=
> =0A=
> Zero(invalid character in exFAT spec) is used as identity within the=0A=
> kernel. We'll have to be a bit careful. I'd have to change this logic in=
=0A=
> exfat_load_upcase_table()=0A=
> =0A=
>                 ret =3D exfat_set_upcase_ptable(upcase_table, index, uni)=
;=0A=
>                 if (ret) {=0A=
>                     brelse(bh);=0A=
>                     goto err;=0A=
>                 }=0A=
> =0A=
>                 def_upcase =3D=0A=
> exfat_lookup_upcase_ptable(&default_upcase_table,=0A=
>                                     index);=0A=
>                 is_default &=3D def_upcase =3D=3D uni;=0A=
> =0A=
> Some OOB data check will be ignored:=0A=
> =0A=
>  - the character is "skipped": zero=0A=
>  - the character is not skipped or specified as identity: non-zero=0A=
> =0A=
> Subtle difference. If we change exfat_lookup_upcase_ptable() to return=0A=
> identity on non-existent mapping, that information is lost, I think. But=
=0A=
> again, the resulting contents would be the same regardless so I think=0A=
> there isn't really a side effect.=0A=
> =0A=
> >> +}=0A=
> >> +=0A=
> >> +void exfat_free_upcase_ptable(struct exfat_upcase_ptable *ptbl);=0A=
> >> +int exfat_populate_upcase_ptable(struct exfat_upcase_ptable *ptbl,=0A=
> >> +             const struct exfat_upcase_range_info *ri,=0A=
> >> +             const size_t cnt);=0A=
> >> +=0A=
> >>  /* exfat/tables.c */=0A=
> >>  /* Upcase table macro */=0A=
> >> -#define EXFAT_NUM_UPCASE     (2918)=0A=
> >> -#define EXFAT_UTBL_COUNT     (0x10000)=0A=
> >> +#define EXFAT_DEF_UTBL_RI_COUNT      (112)=0A=
> >> +#define EXFAT_DEF_UTBL_CHKSUM        (0xE619D30D)=0A=
> >>=0A=
> >> -extern const unsigned short exfat_uni_def_upcase[EXFAT_NUM_UPCASE];=
=0A=
> >> +extern const struct exfat_upcase_range_info exfat_def_utbl_ri[EXFAT_D=
EF_UTBL_RI_COUNT];=0A=
> >=0A=
> > Is there a way to reduce the size of `exfat_def_utbl_ri` so that we=0A=
> > can put it on the stack of `exfat_init_default_upcase_ptable()`?=0A=
> >=0A=
> > If not, add `__initconst` for `exfat_def_utbl_ri`.=0A=
> >=0A=
> Nah. It's as packed as it could get without breaking the alignment. We=0A=
> could pack it down to 784 bytes, but that's still a lot of stack usage IM=
O.=0A=
> =0A=
> >> +int exfat_init_default_upcase_ptable(void)=0A=
> >=0A=
> > Add __init.=0A=
> >=0A=
> >> +void exfat_free_default_upcase_ptable(void)=0A=
> >=0A=
> > Add __exit.=0A=
> Thanks.=0A=
> =0A=
> >> @@ -896,6 +896,12 @@ static int __init init_exfat_fs(void)=0A=
> >>  {=0A=
> >>       int err;=0A=
> >>=0A=
> >> +     err =3D exfat_init_default_upcase_ptable();=0A=
> >> +     if (err) {=0A=
> >> +             WARN_ON(err =3D=3D -EINVAL);=0A=
> >> +             return err;=0A=
> >> +     }=0A=
> >> +=0A=
> >>       err =3D exfat_cache_init();=0A=
> >>       if (err)=0A=
> >>               return err;=0A=
> >=0A=
> > Please add error handling to release default_upcase_ptable.=0A=
> >=0A=
> >> +=0A=
> >> +int exfat_populate_upcase_ptable(struct exfat_upcase_ptable *ptbl,=0A=
> >> +             const struct exfat_upcase_range_info *ri,=0A=
> >> +             const size_t cnt)=0A=
> >=0A=
> > This function is only called by exfat_init_default_upcase_ptable(),=0A=
> > how about merge this function to it?=0A=
> >=0A=
> default_upcase_ptable is already freed up before returning from=0A=
> exfat_init_default_upcase_ptable() upon error. I made=0A=
=0A=
What I mean is that if the subsequent operations fail, such as=0A=
exfat_cache_init() returning an error, exfat_free_default_upcase_ptable()=
=0A=
needs to be called to release default_upcase_ptable.=0A=
=0A=
> exfat_populate_upcase_ptable() as a separate function to use it on my=0A=
> test cases. The compiler inlines the function anyway(although=0A=
> appropriate attributes are missing in the original patch, my bad) so=0A=
> there's no ELF overhead either. I'd like to leave it as it is, if that's=
=0A=
> okay.=0A=
=0A=
Your test cases are only for the current development phase and will not=0A=
be needed later, right?=0A=
=0A=
If not, keeping it is fine. Otherwise, we should try to keep the code as=0A=
concise as possible.=0A=
