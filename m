Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5641A92A;
	Mon, 27 Jul 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164124; cv=fail; b=fIq41QyeFm8nGH0wPkNFkSCtAjLwlAFp8wCkg5OmjEIi4+ZZHDx/5L9ud3gJC2c5itEAFu71sbJWlTxs3IVty5XDNIhynl7GPy7AFg/P/yGDuwsH7Xp4MdEhXyTuZ2fz0PyRLj136UkibC244bitS0EFHwyJbMttf7h83FTcRK8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164124; c=relaxed/simple;
	bh=Z7Vi+BBkP9XLQOafl/3Ge3TEKkW4n0dmRjJ7GgZyEO8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bgywOsy8NPeYAKNgNntZbaglbxy/BVTSf526gC/P1hwmnzkuxJ51rQWB3/9cQkRc5aLUwAJpFdiq2k1KZj7ew/DzPa5bKIunQ3rtsYGZlU68B2nOO+4ubGjYllp+JuN4VSr6I48tkmUJ2q+Co868bawmAv4cVjzPGn6g2tF6Kwk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d6E1cTD5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d6E1cTD5; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d6E1cTD5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d6E1cTD5"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DMPO7HSURS7tsOfAkyisH6t+wCRQlBCWyyurKkYgaal3Gy8wFYAq2WKdlD4AlaxyEMR3NsVTmmOSNl4O2vBqmiHR/2Atc5goWmt5IYGFuY1Gy2jkOghlAwjJRnXtIDIttIEtiUtEcR8JMAQGsEJY3WFGiH6i/B/fwAqXxz6t/o2rxwYLLXpczNBgI3hjvxL3Fcn5MYsSXqU7zGWUsegPJOji0bt+kYhrfbmgvJlo3IW+P9QJ+Js+ntAN6nunIXiw/L9u4aDTuVVatF5trF3yJDC1AVxxhi7yEYNKH+b7vUaCiUlLSudj2Bd9I9g4QzVx6WysbWLXfYAXFAsQH9lcgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5VaDQI0fPijhYKAmd5mamSfQ6ueLhwNLiPBB8eC6p4=;
 b=y6xhp3vyCMxlsSHpuAnnvsg/lgfCpJcrW/sJnd3n6eqBkWC0KthLGFfvo5mvjhfWlJyO2KA8vRwX6Xl21utIE/LtfRK0rSpJ/VDOSCj6TJf7pKlVNpvIAhU5GN+epWSzGgaT154mkLRuMSsMQn9yAqg4j79MCDQocs2x/oy1t9dP6XfFosY0GbMDWIPOJQek11hssXB3OME9acd6CeV7Sdou2Ku2nGOef9q7pDxK4Z2LAeTvmAE8icKzRsE9zqEfhkPMHntXeOl8dKn4By+Rf3Kb0QPv6LAFJTFCn8eFEP5VtEtNDxCERYUW4fRgKQUfgmhBi1us3CCQ+RZ7XLTIrw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5VaDQI0fPijhYKAmd5mamSfQ6ueLhwNLiPBB8eC6p4=;
 b=d6E1cTD5pW3ta7NpkozqrAe6xpgxImRqPHEtzeAbPBc3hGmKCRD6OohrnplkCJNBA6O/Dho/ZapoBjs0tgN5EDM+RE0MUTT9lEd1Ze/zW8y77WJ2XAwuugbLqOe0JbIPys6jrmKdjDE+XxaPMkJMyzZ+TXcoOVHmyd6KnU7hPys=
Received: from AS4P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::19)
 by DU5PR08MB10579.eurprd08.prod.outlook.com (2603:10a6:10:517::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:55:18 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::37) by AS4P191CA0023.outlook.office365.com
 (2603:10a6:20b:5d9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 14:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 14:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvRJbql9ocBfWWKcCZJU3bCfPnfKGhgR2Ud29h6n5I+LZGjz/O1ztXbzZSgpoZoEM0KywrJy38zmnguR75H9PfHCNE/A4AYejpVtBSs/OvJPmPVVGJhpPV7BoFtJ7R744qN5Z3X+JiyvT28psyZt+IJO5aouMOHs5U/YUAXtCEnoM+BxUg34cFeuMyeEAtnkHUAaFYEQeaHiQwaMImIzhiIYnxPDxrf1Cb5gc6bN9NzMQEFdmz1unjQMRE1cuRvq2kqbYcYocv+iomPe/QVGDiJ2HA6PoqnukTDhKEyjBcR9rL0Pt7fOlnKv8AHN/+CC6sI5Y2waFkSmZnBrFvcU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5VaDQI0fPijhYKAmd5mamSfQ6ueLhwNLiPBB8eC6p4=;
 b=mvObWNic6FBcVKGwmaPXpd2pRGn9mODpMF9ffXvzrH99TJSihyv78sHdOJfv0A4L3iNWdJx8pRpF+PHO7YBvGe0P3TiMZjeLHCk8SQ6BkbNh39lBvJu9LPY3/YH/kZSOnv/Ak0jMjgiNTNZ52ZpgHs/oHkAmzhnzqnQFvO5qKC4KQNslwVBQikGNzcGyvihiBKLsmQ85Z8zIDTaBpXTYStjs1AAZ1TzV2mycwGmbgn+jPwDVj0If9KJrVIg/ucDsS1njDTOoTqMVskcNU+GfU9fCGMe5l4lpYEtx0sGCVfZHn79zKJMX7J5aL45E84wqOBBRUlDFsrS9d2p0r+luGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5VaDQI0fPijhYKAmd5mamSfQ6ueLhwNLiPBB8eC6p4=;
 b=d6E1cTD5pW3ta7NpkozqrAe6xpgxImRqPHEtzeAbPBc3hGmKCRD6OohrnplkCJNBA6O/Dho/ZapoBjs0tgN5EDM+RE0MUTT9lEd1Ze/zW8y77WJ2XAwuugbLqOe0JbIPys6jrmKdjDE+XxaPMkJMyzZ+TXcoOVHmyd6KnU7hPys=
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com (2603:10a6:10:3d1::9)
 by GVXPR08MB11542.eurprd08.prod.outlook.com (2603:10a6:150:2e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:54:11 +0000
Received: from DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90]) by DB9PR08MB8651.eurprd08.prod.outlook.com
 ([fe80::8fb8:7cf9:49c4:6f90%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:54:10 +0000
From: Fayssal Benmlih <Fayssal.Benmlih@arm.com>
To: "sudeep.holla@kernel.org" <sudeep.holla@kernel.org>
CC: Cristian Marussi <Cristian.Marussi@arm.com>, Elif Topuz
	<Elif.Topuz@arm.com>, Fayssal Benmlih <Fayssal.Benmlih@arm.com>, Lukasz Luba
	<Lukasz.Luba@arm.com>, Philip Radford <Philip.Radford@arm.com>, Souvik
 Chakravarty <Souvik.Chakravarty@arm.com>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"d-gole@ti.com" <d-gole@ti.com>, "david@kernel.org" <david@kernel.org>,
	"etienne.carriere@st.com" <etienne.carriere@st.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "james.quinlan@broadcom.com"
	<james.quinlan@broadcom.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "leitao@kernel.org" <leitao@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "michal.simek@amd.com"
	<michal.simek@amd.com>, "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
	"puranjay@kernel.org" <puranjay@kernel.org>,
	"subrahmanya.lingappa@oss.qualcomm.com"
	<subrahmanya.lingappa@oss.qualcomm.com>, "usama.arif@linux.dev"
	<usama.arif@linux.dev>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 00/22] Introduce SCMI Telemetry support
Thread-Topic: [PATCH v6 00/22] Introduce SCMI Telemetry support
Thread-Index: AQHdHdd8o6QI3Ch3u0igVr+IkJZcog==
Date: Mon, 27 Jul 2026 14:54:10 +0000
Message-ID:
 <DB9PR08MB86511F5DAD811D400FAAEFE8FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DB9PR08MB8651:EE_|GVXPR08MB11542:EE_|AM4PEPF00027A68:EE_|DU5PR08MB10579:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e163f9e-3d7c-4602-756f-08deebef12ad
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 EF+76A3Xq2yTfYhUbE0n9bpnmgjTEu+0MJ2926Q1iJlm9801Mngycd1CP3+jsdeT1yjsjTkma+Zi81VEyesYPwvcI22PsIjtO1KkUFkMqgVdo668kpp3ap+l53NoE3mfeSxsHnP4Za5KeIIqgVwjKYjJnZQEBbN7tvnDZ5sr2JaanYWnoQ/hbLE8U1AMakj5vnPSLxbA/EjWMC08gfrERR5t7/CGhxevz3zzgXU2MmdZ1gC2XYB000KhSetpp4drcCJi1uUY8Tjmi4a8FepD2Jj8+3+UsRztxb4Rup8x5ADMqNerSkhpLsZjODGbx9jtGVfA31HJuHzxxQJ3zXgMihn5n6gpEhwsLQRX89ggX/CUDzf3fHDDXR+Ptk+OyHvrYkDopG+TAiGmpOEqCqVvzTHWZePk6nEM4VObFz35EtGbp1P8iiNm31Zdci7raxTTJzxt+Ogd1JvdgRxOkLiUBIw9zq/aOMp0Y6pJnS7ux3YKu16/EfpS4sPG4lFb4QdEp/9UQvRea1GyLfjzy9YncbI0WN1s6s5vNJCZTvHVgFowU4KcQuoGoQHHU1jJBggwg+XwY5LxeN3oOnor6fdqh/E186mp3I/P44AnuaJTXV2Esoolmfm2dsWL5hlCVgqpgGCT/3zg54JLjIb/oPvMp11uiq59DNJorAZ8SbK1/4MavmZoK+fWxYizb9tycvvgLH5Jla7L8hSzx0HclJhmEF6Yq4xy3nABcQWJdcPuq90=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB8651.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 GssVmCPD6GfhdZ3bNLyYpY/yLqcJ+zbJMMUxKDk6bqmXbRv2Fu6+k21NK4P+GH7Doid0lsy6l6RQoWtp7YfaepANzuf01BtjDLjOQ+GrPdeU4vqMDLGoHgawItpQdU3GT/Ld3AYwfQu3W+C75WRAnuK7ifKlNdEadoMAWh9E15Bz1F699pxn9ICDQHsCnnhha2ltlqsK4XxdvKDI8Nuaf+gDAOU9qCPWIFUVq0W7Ga0HA9rDDjnoGzuN7oSZ0tnDzDuhZFFIh3hzRmJFikTyNzr2UmLiJB2s04b5CapPpB09ARrLennJ+2CZz1AroaNH0AvWMD+qbaBZf5UMjtuznw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11542
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	596dc050-319b-4002-7fde-08deebeeeae4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|23010399003|376014|1800799024|7416014|82310400026|36860700016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QDR/FkHY2PtE6pfavQGAg3323OCXNrfPHCF//vpU1BMvo4lDhexEMSb49Ht/0O9Na+igOI6tN8mtL7X7Oyqn1pnwDfaTrsB+DH+JiwIqHJy/q8lyc9wp6/HLjq5bcXFWjHQNgWgyTLRsCY91wpBPC0mdUdjhVuOGQPZ1dq3bbOeHLWmvhV/3vKeR+WY0w32GdGubGLQOfyJ83bEYN8A6fSRUaZwneApFaZIAC1un30rN7dvMQjRUbklMYpBPUY8HewBKSnstEoNb4T2DD9mhWQSt+iRSRYnYPbJq3vy+QaIARCh829SUetOM6iBzi2bm1RY1m3nNCIBuLj7Mkmm2lYNxhxXst9U8zUQ5Nwh5alF2YAhWIry4wXvSktBuV+DOHYbt47bLP1jC89xD76/XJMioeK08vbCjueqU+eecpyFTgVGXWA2ZOtzjbJVidWsSLwYLASnwxX24ybZlSO8+nOhreUuSyBtmhflj9i6XmykWi+VYC+4BQdC8Pw3q4hHUCrbcEbjP46++o168fUCgT9Egdf5P05m/kfuZNBzvPn3WHcNZC41aJD5HC+wzQ3fJP0ZxkmtV3ai77cbcJeqG+b2J1WV/LW+m64i64EecY9tnDW/8beOktUREEYF36F6RkdOyvxlyVQd1K3WETA2dRkQhX8n4j7CwE/MCV3eogm2NJ3+2CDmRYDDD1SCIkXiA2fXK9oDqaV0+AR91uTehmw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(23010399003)(376014)(1800799024)(7416014)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kVlnpN9dTQbYopoZ2NsW6Ms0AKzkx5aKs0jLw2AjEtjrQouEKptv1JEEEPMIFn1Y+rB+IxX/sfNo3HAIBVMgG15lGZyUhWcBCbmafzItVCrAG19xj3RwAMbRgkgYuyOAHboYIzFMzUJSJbNIUvPyk3+/3Di90nMaK/O4bGVJqzffFER3sHUfAX5dZ1MSAmahDRvpybiKhlDOZmHPLJsf17VsTv3sbnzZAoZTQZcxZuDDFaYcjKjq80Rai+xiI1SBetWKj2rFORPXtxOF8dJterzakmZGEY2TSZvofA1rt7FgZTney5CZUBAvCrucMYpkPSQsBV2h/PEznm+o+R6X39yTFlaUgxtnaRHMiFQ/7QiFYdPix1neUYHS/4jfTpuOgwlk5qD+qX9w4Vk+M6O9+tCU5GcK5VxULrrM2LClE0d+j4P56YpH98Ju6YH846qD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:55:17.5327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e163f9e-3d7c-4602-756f-08deebef12ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10579

Hi Sudeep,=0A=
=0A=
Thanks for the guidance. Understood=97I=92ll move the code-specific comment=
s to inline replies on the corresponding patches and keep cover-letter feed=
back limited to series-level concerns.=0A=
=0A=
Regards,  =0A=
Fay=E7al=0A=
