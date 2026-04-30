Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD673FA5F5
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535623; cv=fail; b=H0HS4lrN08iblFB7uehniKnOE/BzBWgrjs5ehd+TOP8ZQ7ZScyoH0fMYtz4c4m61dISuz5t8cYkgt9cH6YPozuxFghjL2N9HeLCPGAyHqZ9g990+LC22BpkwH7PaHU5021duBCB4rhd9VJTTnM4qPEyNGGwWvBaN+briTosfbes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535623; c=relaxed/simple;
	bh=mvXjVhthdZnjD+ljyL1AVQpP1Lf42Gk6rhZQV0akglE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sG+/S3IDpb9r1PjX2DJqjh2HpvhpPZi+mvJlvjC79rg3FyqvsMKdT+SdSGinPMWvTO4z7A2qbrelmlPmxm0yoUcOj2LbQEaIQ+pCMftzeIppNq+6z1Fytt4qQcKs6rRtDVTvOU3k+XmMxTgjLYm0IsWGZUza1CT+ACK8iXURPSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Yl02zX0O; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Yl02zX0O"
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TMmaTC2475253;
	Thu, 30 Apr 2026 07:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=ny5dXoq
	cGgEvCBnWK0++tTv8TPMob4Y8BJSBslUy3hg=; b=Yl02zX0O4gteWedyu94JeA1
	XmEg+sFOoKbbRk4utCFFG48/Ul4d5bxJ9F2qJ4VzqLD24x2CIBrqGPJsmcfuzv8V
	nfMY4EeNL3GngpIfT4Sbxfs3xO86P1kGcdnFWpKEI3zNCItg1Bkz/EPPwAy7bdf0
	Xd+Xbouvp6e0igSuLRKGRLL0XEspTx9Q3CHpetlb8Uqbkuw+RxjooYKvTBXJhqJn
	mXpV96+3jWf8xJiiYuLAu0m7lW2VD9lBuNfy6wxIlWh5BIpyBM+rgt1VNXj9/QBF
	m90l8SOvS0dQ/Wf4zm+cH8joH5M4PE7f3GklNo8fibmBUwqXcrRjcEGq7KEVboA=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013069.outbound.protection.outlook.com [52.101.127.69])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4drktdnh3f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 07:53:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CntELndvev/cuj4xrZmzs14LIch1yGirkBL/slmUj8Q/v4k272qs5otjthaAnY6WbfILBjayRLyZLN1Sb38ccMlbXSGaNaDJJhN5p1VUc22GCkUo+XMdSxaiwb8KHevRloHmXwEG+XR5AsLoJWOQM4gquUZIY1tjt16t/MMndl3s5TgdbW5xPuITOT0lcp4sZOm5oyrv3WANYf1+zwsZYMlomK5jCFP3+xY5speoWMo2o71yi2PzNqYQuAThB8LVFo5wQ78rRJERkGfG858C9BbGciZNYrMk/8YM7/8a51PoDGsuuo+4o+BM5xa0GdQQxEZ3u9KT+X9+Ru7EJRR7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny5dXoqcGgEvCBnWK0++tTv8TPMob4Y8BJSBslUy3hg=;
 b=MTqUyWZZaoqU4LBwZVL9t+i6duc6pUpb93uaUDZd5wqzbRq4v/EyDurmoFkqKlZVjx1o/8hflbg7gBtP8x0wzP8jEUKdjuVXtmDKWao6+vjOwT+TD8rbbvYTjKTp8OeH7cebzQikXVxwmBDBBY3sbJ+hNMtVpPOCsxGNsHt8ZLXUoqWNUMYPWEqspaKsPuevZOsv4Q1xSawl3P0qrbfnO1YdYxf/RI5NFzypZ02ZbMNEXlcRiQsBnS+uDsk+7/K1OVI9apRoo+9QDnmM02hZuFHX37e9iw91Fx38OSiCxZwwT7iXUf8WkIMqNiOr1GOm4q5l4kY4YNEbe1mnIBq+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7264.apcprd04.prod.outlook.com (2603:1096:101:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 07:53:01 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 07:53:01 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] exfat: refactor nls.c (tables)
Thread-Topic: [PATCH v1 1/4] exfat: refactor nls.c (tables)
Thread-Index: AQHc12no0XTt6eobUU6R16APiGBCf7X3FgVB
Date: Thu, 30 Apr 2026 07:53:01 +0000
Message-ID:
 <PUZPR04MB631683CFF8B30FE0C5EC106181352@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-2-dxdt@dev.snart.me>
In-Reply-To: <20260428235038.93816-2-dxdt@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7264:EE_
x-ms-office365-filtering-correlation-id: 600990d8-c757-455c-32c9-08dea68d80d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 b2BD+C4U4LFheiMpD4XfmUFD4N/Y2mauTe7am05O7JX2DfAjzV3kRGanVHGmAMg+2a8eu8wHTXMK5p2wEjlC29bX5BdwtqO+GLbhWij9R3ZnrawQsol3CBrJmQ//danxlvaXAtJdRhdTKfSVJQXCuinGzXG5JoTAWxiHV347h52ZSNwh53jMWPFDjsZjRjzjnpKb603vxNZTruzvkv53YACaQspsCvcI4KlJmW0eaqly9M0S6DkI6OTLk13aMXsPXO+mwETpy4jwPoe2ngpNqBmqb4F9LlRlvx8bxSxoK+xPeJOfXYQkLTJCmJ6EKYx2rHrWJHV3/+DExa9HVad/kVS2TUY8eg/Arv0qKvJrNKupBP0j8OwoEs+9iR3FRQTbmg6eqZDHkrqdEE0BHqsX52KXyzJLiAdGqAxmMQeyFmE0Jb0Ceiiy3pRFJdR1ZG6K2m0bfosbccWC50IjCVrownXj2hX+cABXH2nRW+CDwLR+kcavfuJvI0kRAj9WKIDzQh79fr3o9npSyYvKf+qF5XBNPOmbCHPkNvx/BroKUYOWrJZZK8VvkOVwfWBrJm5z5qbbW+SP5mFqL4cBN0UveBZlU/vUYBoz6fjTVZmmTwneWCahZIekhpUuo00cy2RMYCyAcRKdAyeWJ5l9UEC1RUb5708Igw8FzFhciczjHO7QtGpboenyEattCAXwA12kMe4DGqlw0ic5I8YEvoOG9iWS9fXfjuknx/NTXKIS2cj+hH3nGjRiEu/HHP3kfn8+19Fn1/6Ix0tD/VVHA/TJ0o7/CvgeidXHflzdWtMl2kQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?r5FAfjDbdY6B1ECkVPpu9P2c1zsWVZHTACHGt9fWzGIW2dofNTwPgEcLko?=
 =?iso-8859-1?Q?m3Sz1U/wuacuvQmrJ39qAig4y5Vc7yfLcej1Nbv9GLWoYpc623kBfXv81e?=
 =?iso-8859-1?Q?lfkN2RVQzHrlYNEIE58/hyEB7Sxkz3shWWSSTeKqAtHjIYGAaMOjOZyS4X?=
 =?iso-8859-1?Q?W17eSulrVPrZrDtAW57q87TTq1bgqQO1dV2MVB1BolI4Q9SgFOz/KsN1VR?=
 =?iso-8859-1?Q?AI2zDkESv8maRLei2fZHkOqheNHkU6PtRIWR6kJ7iz6uwaH2iyHIuyj3JG?=
 =?iso-8859-1?Q?FWB2Dsh8L8u/rgS/D0XrRed3LBI3qz6uAy4K7EXe95h+3ki1NRdBZU2RGf?=
 =?iso-8859-1?Q?JoCEfpqL268SfM6WOuno8WVQ7JtU5Xgz5UZnXCDGmxsDFpk2EED4dGeCEy?=
 =?iso-8859-1?Q?f74pGn1++hZcp4u6u+BQF8Nd3x7qACpB5WlaWeS0PrLUrXId8seEuT2JLn?=
 =?iso-8859-1?Q?n1EdzdJ/lQ2KGlXa6KAlYMtWu6yT8oNXiUeKT20QQbuPl2rnhJAQpRzZKf?=
 =?iso-8859-1?Q?8NlmLPycozehO9cKdEU2uzzBk3njAHKe+gpwuQF18VijtYFFPnYpHJM7FG?=
 =?iso-8859-1?Q?wXNXSE5457IxY0Gk7yPvWmGFUqJ7gmqZ4CJsFWRnneCSvVQm6dVcrKZ3zb?=
 =?iso-8859-1?Q?ENGe1bk73sUSfhFCQiOiSADcKxg4aZLaZeRI7SQMWMkCF5ho49p+CBMoAp?=
 =?iso-8859-1?Q?KBvaHWxDqK3sliQcHpe7UEM6PX5JTEUHHJ6NfpzaSmhGf4to9MheDZzJ11?=
 =?iso-8859-1?Q?4uNKbEYHx8h1FtJbzYOOmAjhZGEvmulpgIw4cXDjlxza5/DcSaqFaUFGVB?=
 =?iso-8859-1?Q?ATzCbb4f/ZnCY4O42QAmdT8nnyBvqH+LYW7Cmsn8v8JRqyI8vW8QvsjenL?=
 =?iso-8859-1?Q?Rddx0NkUrw401B85VJzPxWDh2sgXmXBSujyORFy9SumOsNroyD5hsI6TaD?=
 =?iso-8859-1?Q?WYP/etvDlIqjrlEQoQnXciQiweFKQtjwalOlwmQTFLm2+lD0pEprSK8Q6L?=
 =?iso-8859-1?Q?t2TMVR6fIQEN3d8HVwouezRLDs1rWFGtm+cTZ5X7lJ4nOaxwpqVkKSsfYE?=
 =?iso-8859-1?Q?BcXDUH6rKO3rAomZXuP0hXzAnlcXhCOYrKwe3hdl5KZJvZ/8vR4rQOXWOy?=
 =?iso-8859-1?Q?JKBXuUO5PEJUeLUAdxWwxvt8z95DyqnvJWxZDWlG+RUcIKKPOsNUddCJKS?=
 =?iso-8859-1?Q?huYsHztvtZFjQTTmDb/NFgrdpziRy0SRz5SK1sPnHdvTzImH5KMlWBlvQb?=
 =?iso-8859-1?Q?rjxP2Kf9PCK1nkpko6wyTRiTERAZOURRXh0vGVELoD+u4p9daCjm9O6cGA?=
 =?iso-8859-1?Q?BftK+rxeGHMqJzvTT+apM2GPYKcvVICfY/+GmyCT7AsS1j/YCpp9qCWGSZ?=
 =?iso-8859-1?Q?AGR4LFnDSRmSexiVsJ5TxV88F+HAcFEEx85eMI7MrqMvZ0gLCuVKJ9A30H?=
 =?iso-8859-1?Q?6gted+3EAJyCJBaDyuaiFO6Wc6RcleB/+e7kPIZZ8QQOgM6oI19m9cQK43?=
 =?iso-8859-1?Q?ev4CRYzLDHjGWSwEdr1DT/JkxbGWMZJO7ukT0Tf1zS4Pq7TpuiQa2+JbT7?=
 =?iso-8859-1?Q?lLnfw8etA0K8Mocm2jhj0TC/grdjLPhlwdu3r2M2gz9AacVOug7/+vpNPu?=
 =?iso-8859-1?Q?iXgkQHteUA0Wcf6VASvDZ7Osg/ZDkD7b4sZAuMsApKcTjSqrsPtZfYrj+c?=
 =?iso-8859-1?Q?yTSBifFb0ZZif8ie93uNb5sziyWZ/5ck/dwkUVr71SuXDamYPjvk/0lnop?=
 =?iso-8859-1?Q?3GpYzchak6vPWn4YIJ+IVkCMRruW0GfxvlbxCxXDLdEmIiQmX5Qnj/s89+?=
 =?iso-8859-1?Q?ofs3ZIM0FSAFMYktw4CclwXwNvavKvg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	uD2HKMJzrOqlabCh6KzWkD21PLR8j+MXzRHP39WL4Gj5ZuethHmtaH9VgGZexeMtWHy1YZyt6u1moywz1OoW4txqcen55AgbqO2fCo2a201/B+4XeZBno9Pw268Cv7dOLrhC0N37kRU4bHKI9XBY/YZ3WbPXbJRxYqfAyI7gbIBKG6XaFH/dx6z0XueczhyxDb7X1dmDWdA4Kls0Evt0aNyPA+LXMW1kmDZPjWEOQTSGeMe7m5S5PeBH9j0U1LpMD/k8ZaBa9Y3emTneZtXKuruntP3VL5FVSfS+CG0lXc15L3O0DI0gJyr0VUjVuh/D9VgT90iDqWZrzojj1+tDGA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4VlWu0htNKPaA3bivaIBWd2Y9pJjp7uVKtDqP435VPrybOBfdEznuvQag2v7kWSGgDwKdJzO/OgbVgB6bQdiae6NkoykRIlgPHxVLyknHFmAIE58fjNsJr10oOSLA2F0PHzUvT7DN9r8/HHrOQ6InmP1LjG9OIJlP2EKdymSddfx62cFV3LkVFL+PMM5jWKbcRv0VDSASLR3GBy5kUr+4zy19RXheEdLBzGeTrCRLNNN4r8o7WtKoTMGJFfH3s6trkT5AKH4aeWYQt8/MRxlMFlMhLXtF21W7MOeWD0/BW4SuYf+55noX5u6OPiCiRkiDeT2HGOvCeAOOaGP23UKSvvno+9NRTXix1p6GrbIl6qzz07lyvxVB7aGPw4zulaKkzuwowjt1/ntxrN+ExwGoDNjheNbJjqdHyqDnrNlSZD/uJKRsdvjmrZ/M/qbi9kGJxQJYwcFOJteUVQxDmweT8QSB0JC+nswII48JsbPCw+JdqW9bkqg/V83ONeQkxwFh377KGuJhh2sBAeqGNzzeVC04VlNd7kq0QpeRJkQ+UZdzeFL17xigw/i+Ux908AwFh9a1UYcNEleAi7+wY04sGMMMUlbTOt/W6Uy76zUVhO1E0dHLeMVDtgwL/5GVkCY
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600990d8-c757-455c-32c9-08dea68d80d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 07:53:01.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Im9WM4ok/6rSsyfX51yU2SJF8TzTvTsOakxMejN8dsd/sNIeXJcVPQwnqEoSOq0Tr7TVYHNiSXEqUX7ScwNp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7264
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3NiBTYWx0ZWRfX0Ur1Svb+Gi4F
 vxOUaIWpq9nuI16F/ucPCu1q2zQci3dm5ir3ZhsFbYOjPuIy21lXydF46wXKElJsBmD9lrYEka9
 tdpMBPCrpyKots9qxFk/rAcqkCH+o6ot0rnhZzwpULyn9W9T+2nP2Ix6yegu9KVUFKdj3QuILzC
 A4UatphPE1pTZhuoVm3hjG+sINbMBs/PIpUmhche1J9DeAJ3tW/Q1Ekwiz0ex3u8aQqDgxS59gw
 G9Pbg+kCQraiZPnEGo2LdClGMkIJENhQQnwYbfUhpE0c7s9BuISt9tCjG6eugy4WaDrOUFgsE73
 ZpWFkysWosdFio2FRKjeLK/wxk7u8BnipEILpao+PKXnFtVd+KM7kIMI86Gn76wzFdiOnucFzTr
 m5Xb5kGIam/hpG+xjJajo8Ybgsvne0nBZROmqQqjbvvQPVr7kCQ9M2ZP8DdaYSrmEa2Nax5Osgy
 q6K9lVsxnJ4xn46lAgw==
X-Proofpoint-ORIG-GUID: nILFJTLtHbuFI7uEjx6xDLNhvKge8M83
X-Proofpoint-GUID: nILFJTLtHbuFI7uEjx6xDLNhvKge8M83
X-Authority-Analysis: v=2.4 cv=Q5TiJY2a c=1 sm=1 tr=0 ts=69f30a6b cx=c_pps
 a=D4TVgLWKYpTCXR8XIqRWmQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=lmptg-Pxpg44AF-n8Qp9:22
 a=nLPHyEK2c_IyvdSuQFAA:9 a=wPNLvfGTeEIA:10
X-Sony-Outbound-GUID: nILFJTLtHbuFI7uEjx6xDLNhvKge8M83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01

> +/* exfat/tables.c */=0A=
> +/* Upcase table macro */=0A=
> +#define EXFAT_NUM_UPCASE     (2918)=0A=
> +#define EXFAT_UTBL_COUNT     (0x10000)=0A=
> +=0A=
> +extern const unsigned short exfat_uni_def_upcase[EXFAT_NUM_UPCASE];=0A=
> +extern const unsigned short exfat_bad_uni_chars[];=0A=
=0A=
The global variable exfat_bad_uni_chars[] is unnecessary, as is the =0A=
generic function exfat_wstrchr().=0A=
=0A=
We can implement a dedicated function `exfat_is_bad_uni_char()`, in=0A=
which we can define static `exfat_bad_uni_chars`, or we can use a=0A=
switch...case... statement.=0A=
=0A=
=0A=
