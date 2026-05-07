Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC03A16AC
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155505; cv=fail; b=R2hcofo3mz+KuQVNrHcqOMuqw6N+DLTmDuSK9K/9yKHhYeq6Vh2i0JMiFWZxr0Y6/X5DyKh+jHxwgZ3TXYyGOsnxajZAsRtEUeNuZnMUn7ucd8EA7oDXT5ZgYqUwolnX45eDt+NVijg327H4W+FoWqR/+d1J4zk790WVjocGFlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155505; c=relaxed/simple;
	bh=EosE6zR/Tx6Xnmm8nNaGfL1+porFhJ0C+VSh77GsZg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pALznsyclDbbPG8VOyp9VYpYr6WCyzotHCALod/NKAK7u5TYLe0O6fQMI3TsDSMg1wJnZCTjbKTo6jAQL19FrvM60pJZ0pS5NtxziMHmw3xfcNM1jrZn8Ixi5bAcukduL4+yzz23153qv2FLZApalhXnSvlMys/Kr5fgeVSE9Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=lQJmuqO/; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="lQJmuqO/"
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Bo2Os1898979;
	Thu, 7 May 2026 12:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=XrcQCvv
	02pJd8BLoku2161zaFuVpo+m+F+ynUZPR7Bk=; b=lQJmuqO/WR32txYZUaLTPBu
	kq2CLH2H+65YSjYGY05VkOtYFIR9Dk85IzcM/YhiytDW/is9/O7S3EHTpU4D6UEU
	BfFHIQ1MEpIoaJZacA9o3tUniy5Z5CClpemKUXk7flAcRJyJPHu9nfNpA/PGbqme
	0M0agDMcTXv25S4B9kgv9eQbIlI76CwV3NV/KPzPgC4JdYPPg5BwGOYhFo86QrA+
	j+K5HTLv0vrQzemiU1zZ7Gn1KeTd8mKMHU36MuDsXOjRzJwmeiYNpKct8/h8CN1X
	03uH34MeNnfe6myTxRXvPOrneVj6fB39u+tZz+yWhNHOuelJnbSUscXfBXy+Fbg=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012044.outbound.protection.outlook.com [52.101.126.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4dw9k9ve0v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:04:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTz9dLxd+vbBdty1PKIZi39XTYwL0sgDzuFZW3FxXD+zvi3YkVb0bnkMotTxOqQef7R+sELlnmuQ3G4TFTt7zDddu1Dnv/a+Xd1LdySqQ0fS46g4KnH9PzUt6kIyiwIWnFEG6RjIWpC863EFWKy+t6+5KM0l9UcrONywz+2KFZA0SJVga1pY6mFl0ZqURqBrUj6J8fKtfI8y2UEnwuiuCz//1OthCXUaDGDyOmo/Iz+4RZGNJH8tgsNLfhBLjo9n1EGzVoGYT7gGb6ORzBK4PRJMb9ct+GRKUC4IuJjAJetn+979R69/any8sQfqftr0RvmRP1gx7eH9qCHn+D9mUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrcQCvv02pJd8BLoku2161zaFuVpo+m+F+ynUZPR7Bk=;
 b=uPnJL8vFtXQ/PyVcUZgivP1rsLwQ+3UG5df1vtYymSm355zdtUkRHundqWQW3tx7NIOUrpl8APCsW4lsG1f+rZo467AEL5IWouULVi5EU8l3adqjHAAsDSoQNHMGWHBoHJTx8aG6ju8rxuECQLoYSiGAT1hc7+0QHRf5bLlGaWPAyPkiMWXtd6uluorq7qTZXmGGIuzsoLsjSf3EupPNuMzJO4t6HqhWu6W7jcEMmPiucHx8vNmckTo6Dg09nkPHd6yY7WFZOgZZxwcO7mdJg1nV2lrSX388Ee3cDseJwJ9bkCKf4F0OcpwiQv3/+Mn/EiMbYoDLaNUN7HI0bwHfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SG2PR04MB5663.apcprd04.prod.outlook.com (2603:1096:4:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:04:41 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 12:04:41 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] exfat: fix memory leak (upcase table)
Thread-Topic: [PATCH v1 3/3] exfat: fix memory leak (upcase table)
Thread-Index: AQHc3Iq+j8woM6M4l02jM5OZRg3Dp7YCYGaJ
Date: Thu, 7 May 2026 12:04:41 +0000
Message-ID:
 <PUZPR04MB6316EA20F9C7618B53803AD3813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260505122808.728020-1-dxdt@dev.snart.me>
 <20260505122808.728020-3-dxdt@dev.snart.me>
In-Reply-To: <20260505122808.728020-3-dxdt@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SG2PR04MB5663:EE_
x-ms-office365-filtering-correlation-id: f2bfae96-7225-4ac8-f584-08deac30d1cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 j8PsJRhareybfFbfC2XR4oMHGvIXY8COV5T21eJ+myLHdKpzFNmUGosw9ss7dBXvQi5/T6otUdb4XB/ip/9fe/MmF/gksC7CbaOOdqXG1rwb3KKUoi/Z8ZwelF0nUyJOo/BzBzRr8DQgdIqJHM/o43NiA86YBPLtfFNPLCJl516h+vjfP8BvDPZLDyJmy80L2GzoCQB191o4vPAqFLA7/vge0L8ZuYFJU4jqOtCnCPYcMjNd9D3Lp29gpkNgFgG8KSIXLe0pcon8F95AA2DtKRRVW4pT8u7MRv/hnqxL0i2ZoC/S2Dw9jTV3+a1gRkphSJ4U5QjK1h7MjZYl6xhFp67rsrHQqlXRvYd2mcUF22YlOAJq5b9w7K1qrSGNPvL9Hmq5DgX/1v50cj+PiKCQjorkd3sHDuXRjHkH+SvBURUqkb7hBifahWsUqSQlXoacP/GtTn5EQECw69FKWaim5pdIcrtPFzvUiTNbSROKbghzs18apfqBMh9e82Evay9fpYPGogHUHfBXuZhASoLXWcqAdBQMs/HL9w1PdoehbKkyekbyJG9kWpZlQTm+QfAd+Xnp8h5EOY+r9MPpZcIpXCIkM5TW/WIPQEFDdJEVjyVuqL4CTwEjACEUg5RMwxkzgNVRZlpq1Cpu7bJerooxyf+YeEtG0aBhL7KDV2iUBQUCNdW5UwZzNRYNgmNfRNqAGQUx3ALYMJkbw+/sNM4sASX1DTFlyoLqLcoNFW8xZMo742VxYu/0qCnHVjc/DNs9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KT4Bnu+Njvqz5dNzXXGRke2c7Vgl0HfCOZShuIVeQd6gizfNn+zbM6hVM5?=
 =?iso-8859-1?Q?gIDowzgtCXTJYZlm/B/i35EmlKhZC9uTHQOaXcECg+BC6QggxrVYu6z+8r?=
 =?iso-8859-1?Q?zzpNKqAGJcKxRk89/VAHaS91PABxvFUx2YPyt/GCWInsZ4q0OBd8RO+kfT?=
 =?iso-8859-1?Q?hRA9OWuujbyzDFD1+Lqv8th0Z1iseIY2QCSEpcpfAFGDv8zKqFJUd2rDtL?=
 =?iso-8859-1?Q?E3R1tAb+1/KAt0pPEQwdOD9NJHDwIxD3id+niDB05zu4tn9AX2fo67iVPL?=
 =?iso-8859-1?Q?+oHLsj3nY0BQaaFh0w8gOBbDAaRFljLg0czlYXhKEm88zCiOW04KdXa4S6?=
 =?iso-8859-1?Q?a3DwHDY5HzFps4n3rAlFowH4zw/mgJzdgqVMT0k+w0gwiAV4KbUKvQ8ldw?=
 =?iso-8859-1?Q?DYznas61jaay491Xc3jq6JNNuvSAILsMgrTA+fFziOJtBHUse/9gAw81g5?=
 =?iso-8859-1?Q?omuZpkNozCBRVxpUi9CFsEG0YgCSbtfRGAdIxaYOhh0VYX5zESUneU7XKK?=
 =?iso-8859-1?Q?t/Df6x6H9QYWxsG7RETXWrF6Emtehftx5N66qaWZW90boGwIu7LnozmFxk?=
 =?iso-8859-1?Q?LhBf3GYV3Nxlg1hds+qbVxdZX2yLmUMmYKiMnxg57O5XozD9SXu7bsTcx4?=
 =?iso-8859-1?Q?TGStDdEFM0SQdibkem1gLucOmZNsC3J/X2VH6GwsCt9cXh80Qjxn1QmkpP?=
 =?iso-8859-1?Q?DPOGnJaoNhnIYJgmXJZqwuEiDneAWOSGsc/zjuYQkVbHza+K+w9Kf2f1qt?=
 =?iso-8859-1?Q?brXvFehva1ROVS93M34Yo7CtjTJIMBpwJvWFEnN2DdQE0maTBHKGoOA4mu?=
 =?iso-8859-1?Q?8FIEEWqloWoyC3+ww0Odc01SDbeUbSFXdJ2XGKAm3cQgoXpOke+Nf5vSJp?=
 =?iso-8859-1?Q?FB9NSkJMkblV4b0KDjltCxPy/YkEQpPz0t08PuImjiCeQvOYbb1zxqMsr4?=
 =?iso-8859-1?Q?7fapGz0ienau/x7yExkZQHmqTGV8+WSEQFprZrZvoMarssbBma5rGHMK0p?=
 =?iso-8859-1?Q?5pPGjEIxUWuNOY6VkYsRDjxq3vVQqEzbM5/A6tNoWzsKFANtDaVuifoNpx?=
 =?iso-8859-1?Q?juzFeh8iqK+I3rvqwaACo+nEsRPpvJ4FL0MLLQfkad8+nG3FUeHVR3ffe+?=
 =?iso-8859-1?Q?2dmqNCQFsZeE630i1in2GYwADN9F/MGutMl2uGRqpjTPS51yUtw7E8fch9?=
 =?iso-8859-1?Q?8IdZjFv8JTWOMVceZ/KSTbtCOJEoK2TFK75SU9VZ4c3d72G5wU2VIbz56V?=
 =?iso-8859-1?Q?lrBXBzMW+BkPp0W/74vu7T4RdhJZPJF8N/shmqkuZp5hKrV3QkkEHwAyEp?=
 =?iso-8859-1?Q?at8vz1yKtUHZqfWElQTFanEEpivPB3++vIce2OS3qmQaRz9Bi0oMhxuZxi?=
 =?iso-8859-1?Q?HxiwU2MOrKQI3gCf0vv7XOrwIzYayLR/TzQVbRbFNXKKSaMkIhE4izbKjp?=
 =?iso-8859-1?Q?5psbo4EWIwUcp+z3JGN8XG1Q/lxkDM44aMxY3QqxjMdCHfAdpvZp2XGjD8?=
 =?iso-8859-1?Q?UZfIeE+53wL9qsSzks0HE3aHRWdAx1+J/JIhbJBbjo6Au8O3K777M0+cjd?=
 =?iso-8859-1?Q?VssmflwKot2izpJSpxd6SZb5KglSsj9uEGyM9d3NfqO1rlZ3HkXfsLz2/n?=
 =?iso-8859-1?Q?g4sVJgYOAhTzttpsd95Fq1N6PcFbZgfHBEG5aTNGWuFNOhtJntiCzVo4F/?=
 =?iso-8859-1?Q?cJidxSzVft3SgcswXxHYtzYELuauTC6VyjTX9Xw+7EZk/kyG9DUzbP/3m+?=
 =?iso-8859-1?Q?Znt286+cKyo14Ru+iX4MGcn/smgKLyUcVV3zYIfkD9mcfBqFcQp5w/8ANC?=
 =?iso-8859-1?Q?inyeK+mDAg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QaDU9rWyAYT6H9BVdFGEZwspmOU9vV08RDFFMW26PRr2ZpNl0o2vMaaOO0otTa/M5In4AR2c8UndjGkYV3vencPGVIuEXxzwST6O2A62ie4o0VExztUB6/8yWc/cEp4UGeThauXMMfNOsnq2L6YIqrLQVC859eB+AaqWcy+sVzwN7sRgSRRzyjgA2bqIsPfXVB4jCcXfIgO13iSlW95eiX8xFNKYTvVBKn/3+auC6XDtpYPAjjZ6wcTwamAotG33dgGFL97SJwdlHp3oaBC2NU9RPqaNPMicrKKwRyuq42kr08FzIym6CDUBHUmglQq0koCGwT/NANgFKLn/E3erUg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L7xFVkNXrIi1JrR0zla2rwmEVM5EL4OCa8G58/RtfmAdIgMKVYjaYqcuMDJ4A74UES/sHnhYdP0HXToc8dMD4Dm9uRWiDiflPOliwHQgYa1U35ir5xfrG3MM7GEO7S7Hb0qA793nNbvvZrwaPL/bTiCfJNPG9UomwSw+dsPsWFE5PNHAoQmZeKaSrGd5m4oTx9DcbWuWgXbvbLUCEDMorAykhMVb3ZhRVywEzZrAlR1jOEyNEw5GCnyVcqV/xZEX50Q3q9yLCKTqNENamwc8f8I1CYccvu6We3S9zPtCoKFI8L8zsc5uyMXTdKwZJ3wA0pmZ9Gyby6B5cEA6rYI7CfU51XSBxif+ElGBUfg7EqBa5Msvnx7wsQsgsudUjVtm9HLn/5Hmnj9wQSNz0HoQ8pl/3BDRiPYPBGxl1DhwLwdMj0qyjyxQuaBMqvuB4bJ4lE6ep5UR8zWTycwA4M+nUQUTBorwe+50j9CRouXxWggqX3zCdNXg6D8kV95eAvr31QL2JfPGb2g0+iKHguZhcKd1Zdm9i5m+Z1a07QrVXUItlxLXxeNGVA2ET4ZbSB/Tt9Btpbv3OgZdGEBMShpK/3JNyDPfXBPBgfWZDozZaPn9AcAFDMFqTRovvfyAcEmJ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bfae96-7225-4ac8-f584-08deac30d1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 12:04:41.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVvtZWiz3IqXm/V6HocM21osTyByy4qTG4xQqLO1DY1LjncuZLhwbZk0fFo3vtUa/Gcby7alibppspew8oEHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5663
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExOSBTYWx0ZWRfXywNG4cYpBzrL
 sul4Nipi6MYTcFHGpYWZlgQcibGOiPZrOn0VG3zrI0h0+Iu+seNR5aDKBCCblCRLhLPncEztvxc
 M29K3OdaHQH9ggWPekJsthflA6MIcwK8hxrRk5Tso/d5l3iWeOOwd6F+5cPhBezOh1+7ApHYQtX
 eEV2nw6P5lMNcwUx1NJiIUAIQWjR8VOpvgd7xnVSeU6GuA251U4PWV+WXS5XhGbyboCcPtVCra4
 LnCK/5okyLufsSx1s7Vv48hzoAYxEqCd6zrneJE6t+BFlYi/p5943P5PoUgWIazNgYUei75N11Y
 ZwdxofIX1/DfuRlfaED3JbcGQudXXdCOTKhfbPlOV+zV0obGJYJC/HKREKgneqfg3iaZPIBK3/j
 mony2dNrlDCgUiULBhyMMh/SYLNt0MXr0OEtI3mNFbyTbP+Xxlp72Ue8KTq4DpGDO9umwKwZh6i
 4Whh4sbHcm8S/ALzqAg==
X-Authority-Analysis: v=2.4 cv=etzvCIpX c=1 sm=1 tr=0 ts=69fc7fde cx=c_pps
 a=MHq0tdBkReDSW4qRyocOiQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=dNm3KQjjYUbhztXjLiFs:22
 a=6wanpYfC6ybyGBPjnzcA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: Zt3ontaKGdYwpKilXVh0EJYA3ts4AAyL
X-Proofpoint-GUID: Zt3ontaKGdYwpKilXVh0EJYA3ts4AAyL
X-Sony-Outbound-GUID: Zt3ontaKGdYwpKilXVh0EJYA3ts4AAyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01

> Fix memory leak conditions due to exfat_free_upcase_table() not being=0A=
> called.=0A=
> =0A=
> Signed-off-by: David Timber <dxdt@dev.snart.me>=0A=
> ---=0A=
>  fs/exfat/super.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
> =0A=
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
> index e0a80d8f5f80..e9dc1e616fac 100644=0A=
> --- a/fs/exfat/super.c=0A=
> +++ b/fs/exfat/super.c=0A=
> @@ -707,6 +707,7 @@ static int __exfat_fill_super(struct super_block *sb,=
=0A=
>         exfat_free_bitmap(sbi);=0A=
>  free_bh:=0A=
>         brelse(sbi->boot_bh);=0A=
> +       exfat_free_upcase_table(sbi);=0A=
=0A=
Although kvfree() checks for NULL, adding a new goto label would be better.=
=0A=
=0A=
>         return ret;=0A=
>  }=0A=
> =0A=
> @@ -802,6 +803,7 @@ static int exfat_get_tree(struct fs_context *fc)=0A=
> =0A=
>  static void exfat_free_sbi(struct exfat_sb_info *sbi)=0A=
>  {=0A=
> +       exfat_free_upcase_table(sbi);=0A=
=0A=
exfat_free_upcase_table() has already been called in delayed_free(), so it =
is=0A=
not needed here.=0A=
=0A=
>         exfat_free_iocharset(sbi);=0A=
>         kfree(sbi);=0A=
>  }=0A=
> --=0A=
> 2.53.0.1.ga224b40d3f.dirty=0A=
> =0A=
=0A=
=0A=
