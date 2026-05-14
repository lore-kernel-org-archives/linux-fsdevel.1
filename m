Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25D38A73A
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753086; cv=fail; b=huqOBT71ICdEKZSCRIOM9xRxjh9VEtuM04WKcXNOU1WKHLk9HW5prGv6pEedZwump08aPA1cj0ss9m1GhJo3pwQ/D9QHBAQjucCZVW39Op4Y79cPh+/v3fkWyaNTVyhW9j6XBEK30XcfTQ0No7DIR9Qneulfm3eiEc6gsCfolqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753086; c=relaxed/simple;
	bh=rp9Rs9+mWg9S+FP+7LeEGgYjrTebIL2XzKbbnGQhH+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVQ94jiXmjDBiHXn4fnTeN7h9JQks3F+T9amunhhdC67Y8Se+jzmpV+mfgHtFHtBhm5vGPNODXUVaxgxgAjYkLI28KLd1VsGNtnOLO0FN77zlLmZEPTZS7fN7QCDAPEVKP8j/Mffa8WcKS0QxUPEcQynHzKAqO1+6qscpbTWyWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=rEcDfBKS; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="rEcDfBKS"
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DNlm0l238357;
	Thu, 14 May 2026 10:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=u3edQp4
	BgiF7rk2D8HKyXZet3hOOWWf00KTgDQVU36Q=; b=rEcDfBKSnpCsE3NAD1uZ+ku
	88dYJPainuulpIH8fic7tAkNXm/L/UMsmNSwSBbKWDW6lGSEW3+9VklCqYW9lrMw
	vI/B7nF3CS0yAoZHn8AXUkph1kWNLZXFxsbmnnVaISFmdOwXBmbLIq03uiCpbYpH
	QT1isbdVqHYtAACfRf2mHfW/Bqw+8B87NsHqiwqffciTE+DV1azTkhocz3WozPIa
	k7miMfDIldePo7ak506m51NneIu4S7bbbWnBA6+0+Dxo5larkfoLAUYr7MiGX1ZB
	ha9qdyO55rIDZ5RfujCkP/TOSiyYIZSIAGA61aUHXnJD/++h3M6chR+i8qxSybw=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013022.outbound.protection.outlook.com [40.107.44.22])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4e3nuxbd85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 10:04:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thwp+9UF4eoU4Lyb+oS6rS2quu/8FErm2/gCaRUq6f9strMDMIdsqiCllHe1aqsO+ZOKtVQI252F3IQQIMjICg9hlHKSCf3K3j1K9T1782ufD4s+G+rmfn1y9vjzvE5erAR9fMXcVjE+HniBls0bwWluqH1KosjYpicTfruc5cTfgIZ9u+JJ/zXN7RrDiyZYVsS4GlOIv2mRptvL3OdUFmQxOJO1ElKgLK1I6mMm/UUbQ5DUqwtEcN+4/70jC3J64fsuVaGPXDa5sVDnSYhAT1hl/x8iKUC4vt7a+IELd9EKWL08t4oBzmSHYoFm8lhARYxscisHKgeHBOO5opELHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3edQp4BgiF7rk2D8HKyXZet3hOOWWf00KTgDQVU36Q=;
 b=F/awJjMa48FwuuJ3Pc02ub6/1BT0JYR73eN8r5Mdupa47CtmMIOPo3i+Y1UGBAYu6TPzP12nrtyAeji+QjOJPGZk4bWKhuQ8n3F3jk0vxnjbt0dsoq7IiC4p9W4d5CEF0xN9TtbTKe0QC6a5DAY1ez1xt1Y/Kvqcn/ji4MH53aLP0JYcDVqwcseCuS9q9HJiFzwqa9L62tOCsWasyBRLE52uK66L4zKNpWbMXGfkkEQLKPbYjBMtCCucEVrvJ+OXDKCrtkMtBt2XX+yQGoBHzDfPs68t1Aie74uzcqurRKSaUVO9qyoczv3BHVdI2UipH7vAwqiRSYom8k6zOWZCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6347.apcprd04.prod.outlook.com (2603:1096:820:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 10:04:06 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 10:04:05 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dan
 Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
Thread-Topic: [PATCH v2 1/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
Thread-Index: AQHc3Is9Ctuv9rZTh0aBie7mOook7bYCbEf7gAVxiICAA9JL0g==
Date: Thu, 14 May 2026 10:04:05 +0000
Message-ID:
 <PUZPR04MB6316CE26A44D001F933B14B581062@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
 <20260505123144.730782-2-dxdt@dev.snart.me>
 <PUZPR04MB6316AD038BC864209E256243813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <258feba8-a4fd-4c31-9553-691ab375858b@dev.snart.me>
In-Reply-To: <258feba8-a4fd-4c31-9553-691ab375858b@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6347:EE_
x-ms-office365-filtering-correlation-id: 93e705ee-99ad-41e6-5130-08deb1a02200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|18002099003|4143699003|11063799003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 3C+GWWXCRNW3OyCJTK5U8VhdwvD1MvPuoZpF1EP4iL1kX3nFp3nqkF8vOwoo9BxJN2BwXCXV0Ss3yYUXcpZh+5pSEg4BnBpKys8MEl07Nlhvkjhwgk/ttQp2G497Tr3FPywwefS/tUZB7LoBrP71F9s66IHWgCH76uzTWIGyc/imRWkS0IDIXT4Pi8vBze/lx19QO4f43RFjJ9B+++YUvgdasVyCkv2eM9rX3obs/39SSGg/TaksZVNd64c01p9XiJo9vqc5ykEMOFb98qQ24odvmUcbQCsjgRCc80uNeUwIfFqAN+iygngP9N3JI86fCky2ze1lPCVwz8XLS8LjQVHeymUHsM78gsOQYSUtSuQ38oYvbdVyFuoLw07VxFRr5TgtIqUHSSoAlCax4AFjyMPjOMq8Tr9Qkmtsq32bDXs6keFWuRNrLI//yXAI6M97bp0+obId2DZoz8FeERFjMgV8n8HHg+uTI0Nb/U+Z2vdIGpfNnXBGJs+gDVq0dfbWjZDi4IiQY/ddOiSuY2lTT8zhBXUfRdqJ1f/lFFYqlaP3c2BrCdlpyHSisvKnqLpAKaL+V8khhoEmw99e7JnFeiRjZiQ6hTuJ/7+8+NguZJHQgToH/+RcY7bO4W/l1gdEd8Jg6sgSMXBXNFMGFAy4OEPDvWBKbNTfVGAE17xFILHlGd6HP910MwEpp+oyKGLowJu849v8e9c9zi5s5kXSySBdzyvPogEgvxUvfiLqHiSFAJZIg6QmsnTWjZz0/hb2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(18002099003)(4143699003)(11063799003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2nmMX9tSChFP19hpIBFznA7R/M0awW1dfhlkz5PlvFNXLi1kpsDteTaGNC?=
 =?iso-8859-1?Q?OO2YO5LWGDQ7nA/P42FzpcRu1TAg+eT6nZCMq37RKN3nJUhanESqQOKKpQ?=
 =?iso-8859-1?Q?6oezwoSF5XmaKjhUnBFhXTKA4IFDrAnBwBJrvF/hk/nCTDLljyl/hA5fcA?=
 =?iso-8859-1?Q?72Lhmqq/18NrXflxYPlO7D/21b1vrl4S7iRO9e67v/FkJPaP9qN1azxpMP?=
 =?iso-8859-1?Q?YP/Xgs4xfXeaDdCwE+9uYumqX5COu00Iu261Nq1yG450T4pJNdd+F0CtGf?=
 =?iso-8859-1?Q?sGVPefXtW6RUSN9kek1ocT7T73m1vhroYnT69cS+pWZqvCK9YipJpkQjGS?=
 =?iso-8859-1?Q?eXjV+NgXbcMJL+AvZ2tGkRGfunjBCmDzkUX4rIb/A4e9OKlVdjS2SoEhW+?=
 =?iso-8859-1?Q?h+cgiUVrE8MP5V3b+VhryPSOg8nCoXtyoD3Tcn0S6ilBBRHLKPgU0RPQPR?=
 =?iso-8859-1?Q?aTkoW7mYr5yueb0+NdGRUf8C+a9X/DgN60KK7YGKrw5EGqTYYEAyj06KP/?=
 =?iso-8859-1?Q?TCrZ/uOrV4d9DOGjxDbSoFxmsKy6c4a9EjFX5MW4Akc+dl+nfaYTygpba1?=
 =?iso-8859-1?Q?4Tbts/0zLUWsS1JCIdbQ7vVDX4WT41U7k342Ijn52M0Or/m+g+sRYivH8G?=
 =?iso-8859-1?Q?5SxAY4l78OXQdC4J1Uyyd6yQlPapdiOfKPA2FYBAe49PvwSx0RPy0RjE8q?=
 =?iso-8859-1?Q?UiDqIMQsoT+u7lX8D1j4E6lls9HOmWoGB+Wll61VJ4VyjXK5yIdSq5qZIr?=
 =?iso-8859-1?Q?OvPrpJCkTo78Tb9UoNSeeYK7KnHtnnjivWzj3gtiRs4IvoQ4gR/t6jHEc3?=
 =?iso-8859-1?Q?pBumoeTlYSOtaepYgWX4COlPRrFfPsBcgDSCQxi4+GJUn6doaVnJD0kIiz?=
 =?iso-8859-1?Q?ykW+AG6pDiDXR3lDsLDsDyLpZKAeYEKBDIPzULz4knD8cjxkg291hgljtF?=
 =?iso-8859-1?Q?7kDxw+BgZECkHCwSf/MhAONpMJxzlQOYmWrs//GCNm5dxZj9gr2zlYcnLf?=
 =?iso-8859-1?Q?cpUotFrNPjN5ex4geBlrVpFw/yj4VK/GmanBWkUL55OQdsYfMGeGoegJlq?=
 =?iso-8859-1?Q?I5PLp/4CBfkaQtcT8D3froqkAT5f+m6FgDTNVCObxYg0RTv6ru05Pl6iO+?=
 =?iso-8859-1?Q?dsJoQW+JIw7Yf/T/pLlsboMqqPwtcfWLYGpI/nDJqpsk7G5N9Gjbjn6j28?=
 =?iso-8859-1?Q?CGiwt3HsGivRBNIc1P0NpwsspkwfYrf5aXIFMVhCghxE8IHVu32BI69LEh?=
 =?iso-8859-1?Q?Tp8mab48VugYcIyl8JpGcOXRkvfHp/SoWgngp3a6sDYMzWnOwSUX2lL3Ag?=
 =?iso-8859-1?Q?VSaEN+2hLBEszKHos4BUO+JVvAnK7q/hmZJ/VAIuy74+0VydgeaddP0h1n?=
 =?iso-8859-1?Q?2rzVN4eG2IfgeUOXS7cbEGF0YGhmhONIxAyQK+8DPY6xT9vHYMXW3DIsZ7?=
 =?iso-8859-1?Q?sY2MktOga2FNRA3EQDjZXgXOsGQdvXR3D5pP5rWfWQLftmLsZe87Y9l3EV?=
 =?iso-8859-1?Q?GjGn4ce+Es+jSYzM7Vg+Q2d2lYPVaZXiLdabdv6iCOWaUSrEfyqQPS4a+h?=
 =?iso-8859-1?Q?ckYWdUxWeTZeGD8XZjiiw0x5S1WznmOaRxiz1LmTluZPH18qabtYVD8xw4?=
 =?iso-8859-1?Q?xgw4huldwNwXPolXVqcMk9r0QMtms8f+izk7kgDhEvgTK7oM/eVYcNyfv8?=
 =?iso-8859-1?Q?kvC1ouMOOdZ3AKCfhfBGhkgSrOcBH8/Ucn7yUOPWwKFlnjsx9VcISNOe39?=
 =?iso-8859-1?Q?l/20Rjb1gp16I/wyK06Cv0H+3vzytmNmprhV5pX0YU8Ly7Mge/cqSC/pXd?=
 =?iso-8859-1?Q?L/qXgITdvw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MFuzoQAp01R7II3ue8obAVza9eTZU+IBF6GkvZn2G759MphaQzMeLfjBTwqvZ3EJ7VBxy2NG/l//dsUf6MfjDTWPRGEXU0nvcfe8hkKHOBVHthkspDHH6Jy7QrVdXHlruu9l30YSqddgw/ki5B4vnE3goB3b8AMBxyHKNMEV/2ZYdlXTAyLCIbli9QOv3oKXqwBS5PeFVpS2hGE9NSL2Mqr0vhOgR7tVrfmXF2B4RdveJTQ1977oEiuB20pfJLYkdlOmgVdOaaGuX0ifTOxEIRbCBA3tDRX2Z3EosAdB3xsWCpKWnpCtwLYKFXo2259o5+Tqjflcj6/v0vdAVp5Mew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YnFBGYqZa23kxK5K4Aapw4qOUiJUMiX23MXV4OK6Fmr1Yqe2HzNnpJj5HesPOeEvbrSaZ+u+uFa2C8QJsRarxdanwtSX10Zd8bUYJ602zgmegH++LZmKEFRNQjVAcklNI2c6Srfra6RPNFw4s9vfRoIVBv3P7AaCeeXnU0/3eC5Yktr3buMFEJGU1sTPzOifewIwDVSkEWNSAkSyVravyXeUZ/iK4xnoqelRi8Jpd2mCYjLlpeuyjVDYW6cH8ILoBlcw0mhEbetnaegynwnz7inE7m2IrcxwwhnXvcv55ycX/FbbuGh+VTTSccUqfmL+zd8Ci2u1sPg75OkTd5wZkLCvLcWjZWmUSXPxrqvoUMmSjA27mDZxOZd/IHf0stSnqUOZH7TdK4Qfl2SpvxNiWaOyOiHQQzVaA1w5ZUioEhEh8a25SwJ175ogOOuQ0J7rboDKxf6AISk2OILrp2tydy2w8dstRfFBm2bmA9Wh+Y+pG+sUEEPEY9AuW3hBZMIPaPFjjUNEsIsrjoMQsMoiBmVS/dcTE6wew9Sh+FMtO2tgelvivHoyXvttn8f9GAbO6H3m7kbhxdgp7A2XNossKvWxBssK7dlcNM5/R97v5EylP1nFQLZqtkpjokYvJfrI
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e705ee-99ad-41e6-5130-08deb1a02200
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 10:04:05.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +N0bcClHFlbTrermle4Px8LhiM4g2AEEDEloDiIlIrQwqjB51OsNB/SuhP60LdyjLHCtZqyA9Kqa5HsoiRcsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6347
X-Proofpoint-GUID: eqDht78wPmovDO1-eUD6_TsMwDvo7R7h
X-Proofpoint-ORIG-GUID: eqDht78wPmovDO1-eUD6_TsMwDvo7R7h
X-Authority-Analysis: v=2.4 cv=DYsnbPtW c=1 sm=1 tr=0 ts=6a059e1c cx=c_pps
 a=mSFsxCVuS8LUzYwKI3zE3g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=jHItnBwsj8f3cr25iGAb:22
 a=z6gsHLkEAAAA:8 a=FKv24BYVvETt751XiiQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5OSBTYWx0ZWRfXwocx59YlN58J
 FedzJ9r3AauXQWEokjm7Oxur4WqwuO3d3oJIKYkZGo2I+7SjnBb21vfO/uEUwK2EIWl1Lk2pl6D
 dciQ98LXqxm2uKG8DSgbhr3D97LuUENzlP78s5QI8mbxRD5yL1bZdli5jvE6mOt8TdjJ6HlM/hJ
 BfjA93Y7+jGTAaz9SmGaIRKG4BSFv5VDCipiqlhfv2lgpJrX4vDau0zKAu7YoXKIQLq3F+GqQXs
 D7PIBohtThHpxlL5Hq1DZsYd6JLDzhgQdeNkHro2Fz/hQmXFvr+nr/9Ogbe1MmRACunsIVr9KOh
 /rJW018ulfjal2DRMeptAHgDRdw9c5+5pqSqZxNHI9EzlpkiK27MaEduxKdANbwlI0sbsAulB6B
 glR0Irnu8PzDKAPrm3kMdHu8F+lZOzsJWgtYRk+b8sdgfFECquy+EWY0lHF7951MnSZh4lLQ5EP
 NceAs1IEoVOyz3x2plg==
X-Sony-Outbound-GUID: eqDht78wPmovDO1-eUD6_TsMwDvo7R7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01

> On 5/7/26 21:03, Yuezhang.Mo@sony.com wrote:=0A=
> >> + * To maintain interoperability, these errors are not corrected.=0A=
> >> + */=0A=
> >> +static const struct exfat_upcase_range_info def_utbl_ri[] __initconst=
 =3D {=0A=
> >> +       /* ASCII */=0A=
> >> +       {=0A=
> >> +               /* (index =3D 0, len =3D 26) */=0A=
> >> +               .start =3D 0x0061,=0A=
> >> +               .end   =3D 0x007B,=0A=
> >> +               .value =3D 0x0041,=0A=
> >> +               .inc   =3D 0x0001,=0A=
> >> +       },=0A=
> > How about changing to this style? the table looks too long.=0A=
> >=0A=
> > /*     start   end     value      inc */=0A=
> > /* ASCII */=0A=
> > [0] =3D {0x0061, 0x007B, 0x0041, 0x0001}, /* 26 characters */=0A=
> >=0A=
> > And 'len' in the comments is not very meaningful, the comments indicate=
=0A=
> > how many characters need to be converted more appropriately.=0A=
> Agreed. Will change the procuder program.=0A=
> =0A=
> >> @@ -896,6 +898,12 @@ static int __init init_exfat_fs(void)=0A=
> >>  {=0A=
> >>         int err;=0A=
> >>=0A=
> >> +       err =3D exfat_populate_upcase_ptable(&exfat_def_upcase_ptable)=
;=0A=
> >> +       if (err) {=0A=
> >> +               WARN_ON(err =3D=3D -EINVAL);=0A=
> >> +               return err;=0A=
> >> +       }=0A=
> >> +=0A=
> >>         err =3D exfat_cache_init();=0A=
> >>         if (err)=0A=
> >>                 return err;=0A=
> >>=0A=
> > As I said before, we should call exfat_free_upcase_ptable() if=0A=
> > exfat_cache_init() return an error.=0A=
> This is frustrating. Yes, this is skill issues on my end, but it makes=0A=
> me wonder why we can't just have only two return points(success and bail)=
.=0A=
> =0A=
> Whilst trying to hunt down the kernel memory corruption error in f2fs,=0A=
> I've witness the horrors in the fill_super() as well. Why complicate=0A=
> things by having too many goto labels?=0A=
> =0A=
=0A=
A single bail label might seem simpler, but it obscures the pairing of=0A=
resource allocation and release. Using multiple goto labels (e.g.,=0A=
`err_free_upcase`, `err_shutdown_cache`), each cleanup operation perfectly=
=0A=
matches an allocation step, and the reverse order is explicit.=0A=
=0A=
A unified bail approach enforces that each cleanup function can be safely=
=0A=
called even if the resource was never allocated; while this is currently=0A=
true, future additions of new cleanup functions might overlook this.=0A=
=0A=
> =0A=
> =0A=
> I think this generally comes from the coding guidelines that mixes up=0A=
> goto and return statements for clean ups. Sure, it makes sense if this=0A=
> is the function that gets called millions of times in like skb a=0A=
> handling callback, where avoiding a couple of no-op calls actually=0A=
> matters. In this case, I fail to see if doing something like this can=0A=
> hurt anything as long as we're careful with the order of resources being=
=0A=
> freed:=0A=
> =0A=
>     static int __init init_exfat_fs(void)=0A=
>     {=0A=
>         int err;=0A=
> =0A=
>         err =3D exfat_populate_upcase_ptable(&exfat_def_upcase_ptable);=
=0A=
>         if (err) {=0A=
>                 WARN_ON(err =3D=3D -EINVAL);=0A=
>                 goto bail;=0A=
>         }=0A=
> =0A=
>         err =3D exfat_cache_init();=0A=
>         if (err)=0A=
>                 goto bail;=0A=
> =0A=
>         exfat_inode_cachep =3D kmem_cache_create("exfat_inode_cache",=0A=
>                         sizeof(struct exfat_inode_info),=0A=
>                         0, SLAB_RECLAIM_ACCOUNT,=0A=
>                         exfat_inode_init_once);=0A=
>         if (!exfat_inode_cachep) {=0A=
>                 err =3D -ENOMEM;=0A=
>                 goto bail;=0A=
>         }=0A=
> =0A=
>         err =3D register_filesystem(&exfat_fs_type);=0A=
>         if (err)=0A=
>                 goto bail;=0A=
> =0A=
>         return 0;=0A=
> =0A=
>     bail:=0A=
>         kmem_cache_destroy(exfat_inode_cachep);=0A=
>         exfat_cache_shutdown();=0A=
>         exfat_free_upcase_ptable(&exfat_def_upcase_ptable);=0A=
> =0A=
>         return err;=0A=
>     }=0A=
> =0A=
> >> @@ -691,53 +330,36 @@ static int exfat_load_upcase_table(struct super_=
block *sb,=0A=
> >>                 brelse(bh);=0A=
> >>         }=0A=
> >>=0A=
> >> -       if (index >=3D 0xFFFF && utbl_checksum =3D=3D chksum)=0A=
> >> +       if (index >=3D 0xFFFF && utbl_checksum =3D=3D chksum) {=0A=
> >> +               /*=0A=
> >> +                * is_default being set does not necessarily mean the =
contents are exact same as the=0A=
> >> +                * upcase table loaded from the volume may be missing =
some entries. The checksum=0A=
> >> +                * matching should be enough to cover that case.=0A=
> >> +                */=0A=
> >> +               if (is_default && utbl_checksum =3D=3D EXFAT_DEF_UTBL_=
CHKSUM) {=0A=
> >> +                       exfat_free_upcase_ptable(upcase_table);=0A=
> >> +                       kvfree(upcase_table);=0A=
> >>=0A=
> > If the default upcase table is used, 874 entries will be set.=0A=
> >=0A=
> > We can determine whether the default upcase table is being used, rather=
=0A=
> > than checksum, by checking `is_default` and the number of entries.=0A=
> >=0A=
> Hmmm.. I can read between the lines. I get what you're saying.=0A=
> =0A=
> I have to admit, I realise now that the idea of `is_default` was rather=
=0A=
> stupid. Even with the algorithm you suggested, I've found that there are=
=0A=
> some corner cases that would have been missed.=0A=
> =0A=
> The look up op will definitely add a few milliseconds to the mounting=0A=
> process. Let's not do that.=0A=
> =0A=
> The thing is, we're probably giving too much love to the codepath that=0A=
> will (probably) never be executed in production. No sane formatter will=
=0A=
> ever use non-default table. We can even assume that volumes with=0A=
> non-default upcase tables are probably with malicious intent. I have no=
=0A=
> real-world data, though. If anyone can prove that there is indeed an=0A=
> exfat formatting util that uses non-default upcase table, I'd like to be=
=0A=
> enlightened, please.=0A=
> =0A=
> Anyway, we're stuck with the specs and so we have to do our best to find=
=0A=
> the common ground. How about removing `is_default` and just checking=0A=
> `utbl_checksum =3D=3D EXFAT_DEF_UTBL_CHKSUM` for non-default fallback? Th=
at=0A=
> should be more than enough. I don't think other implementations actually=
=0A=
> bother to use the upcase table in the first place.=0A=
=0A=
I understand your point that currently known formatters all use default=0A=
tables, and I agree that in practice, the probability of a non-default=0A=
table unexpectedly matching the default checksum is extremely low, and=0A=
such conflicts are extremely rare. However, theoretically, simply checking =
=0A=
`utbl_checksum =3D=3D EXFAT_DEF_UTBL_CHKSUM`, even with checking=0A=
`tbl_size =3D=3D EXFAT_NUM_UPCASE * 2`, is not rigorous.=0A=
