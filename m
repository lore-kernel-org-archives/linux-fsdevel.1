Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7802475E3;
	Tue, 19 May 2026 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168181; cv=fail; b=XZQcsMi31LOQT5SbvMIGwxVQRzXFEYiyIt3EPENFRzfU61W+0ooJXLbef6nca6x4+1uZ2A9Ydo1NsWqIn0CNbstMN1BTzemgxQIhO71qOx+chteQuSTum70KYCrJlcL2eA6fUIsV47FG1Sx4XtSmENu8cyvLNs1Rb9kkEesYp/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168181; c=relaxed/simple;
	bh=db01/Zyca4+556E5Qh1RFR4iNzf2rOuEX3h9/eUaszs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qNik7O37ACBf4DCpWwTO56lsyp0knkc1RQRjwGx2cJOizbk7NqjDkFr5hfJCp/eR+/2i5EHTsU3ATIFb6XADZqR+bTTrOCcLsWyLISIGtvb6Xs3tI13w4eIHgx37y5YAPdXQWdiBndhNK1hCb5OiucSuegzeAMzNxPxy8cdsUDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=j7mCNMum; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="j7mCNMum"
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IMmjuh3718154;
	Tue, 19 May 2026 05:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=+R8roY8
	5EAvQi2RC6R/cEBweHdvyaJbA7Qnasvdvt78=; b=j7mCNMuml/TvkgcBPrnG+uq
	n3OEY32TVZbnVItDnXpDs1UkpRIwrhZNvwlI2dwNfUfUwchRsqrwJiMVzTWLnlLG
	u4dUN3yb5gO93kxjjk0naJ5hivFMhwfPjgrOi1pG7J9SmKax7tZHUG5OxwVvX3Eq
	wALu9kzO8TOVIQiUViS1q7hqMzUuDB65u4ErgBdzJihIHvfdevl+TwfkJ8RfYc4I
	35MZnoqkW4WBalaOfrb5KqHgoKb9fsHN5jNkCGBYn1LvD/l1e8Vhr8NXHPUSpges
	oP9vq4wvuI4BLhtb0ZvjK6TEmAGrHv1CoGJlD17rtnqH8fsVg9cWMUDUFeAwEcA=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012053.outbound.protection.outlook.com [52.101.126.53])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4e6h362mv1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 05:21:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOiYYXNvUgjgScpYho5RbJcHNyac93JX7cnXzj4zSDJXj3PLRQ8Xf+bfH/1NCS58dhve5ExLFslJbAAySlY9C5QqceO1WKN+tAE7+Yz6vdxhts4qHHp1J9UGZO5E1MSGbft3U52VB88POSvas1K90JvEDoo+i6CIA+xgEivFVV+xfAFgqxaO+Wx7cC7gt+p4iKMoKYN7u/RCcPNT7G5rwW34V317ivD2qQddA94E2fFkK52jqsVH6wbtKBHi0rOflnhpS0OH3rUcUCbluniJ7vZkyeNYQtKVXfd+P94ARR9vYLVzQnFSepFbfefdmfkQklMXquyPHM1CqRTQa3cSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R8roY85EAvQi2RC6R/cEBweHdvyaJbA7Qnasvdvt78=;
 b=EPdZRBfO8O+mpTIpS1oIyVJBcY7lDnLn/F0dc5qbrNKLM1q++CJ4qUA0S/jCqbJZmvDZZBNsfWjU1n/0NOeQRgGqYhdhtwwWi6YUHrMzu639b/vkYtDqoI4rwwcflCrLLtmF8jrPRHkx8fsN0d4yPBDhJqmyPItCxT1IogfqhppXJXN1l8YFRzbgA6TK69hY+1JGcvriIp4YE6jSoGeIFdHnrCRt++3C952ERpysn8V49BaTvYkfu1vl/sE+I/Hb2Abj4Y9Ej/ED/rgMlL8mVKRlLvU0qeDDpTabmn8j8rEN9CEwOci60Y69KkXwsu0bMQXuh/DxGMq1tglYotKBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB6375.apcprd04.prod.outlook.com (2603:1096:400:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 05:21:05 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 05:21:04 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "anmuxixixi@gmail.com" <anmuxixixi@gmail.com>,
        "dxdt@dev.snart.me"
	<dxdt@dev.snart.me>,
        "chizhiling@kylinos.cn" <chizhiling@kylinos.cn>,
        "chizhiling@163.com" <chizhiling@163.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "charsyam@gmail.com" <charsyam@gmail.com>
Subject: Re: [PATCH v4 08/11] exfat: add iomap buffered I/O support
Thread-Topic: [PATCH v4 08/11] exfat: add iomap buffered I/O support
Thread-Index: AQHc5rxcnX5CIklRYkqRI0sbJA1s/LYUzw38
Date: Tue, 19 May 2026 05:21:04 +0000
Message-ID:
 <PUZPR04MB63168E8C2FB92B80F9F6476581002@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
 <20260518114705.9601-9-linkinjeon@kernel.org>
In-Reply-To: <20260518114705.9601-9-linkinjeon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB6375:EE_
x-ms-office365-filtering-correlation-id: e8beee1f-1986-4dd9-9523-08deb5666c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|38070700021|56012099003|22082099003|18002099003|4143699003|11063799003;
x-microsoft-antispam-message-info:
 Anqi01X3Zed/khMwdB0Oev1C5Lgryh0twgiI1Nbh7wjfVj7cGMxqpDkj/2q69wOKNhHIACqSYv51tPBDnXp2thUzXGcgI7WEDkVpY7je3Iyafxi2n71p8d5jX3QIHxTsrcJd7bDz5nr1StejV0TudzjhYEL4vmfAcfUv6lioPQkjBdZ0MGPImIZ7Q29QArDGz3ou/aNDhUGxwunMFUucrSVjItKLoig3zlcbV6C4am76mb3o2pcPeHmTMXaOp3d64eUasE7kz28YW3CQT2pPGQ99JMjWbNrUHLHZqFPZPz76Yhw/ff3xAclaPdgPpOPE1VKx8hYQ5iyXaa6uEHP8uHjjrgNBU5mlJiShOv2REQ7VmHvy8E/NnjiKyCS8zGt9RlQFp3QA3C4uHowc4ufA9zZ/+6Vp3t8JmCdKSxR546R4/Eplgvgto+cUxgzjBTPVMQG3CvncmcxxG1HcYtiZmS3qXo24dnOEd8nRlzDPhEsibx+k/eqjsEhPQeC0RnyhIwnaNOWcLAMB+DRt4mR9XaCyVT3NJ8v/oL5SmLfLqVBL9kO5pjQnVTV4gZKKlTPZPyVxq65UAtz4cTjBihUrhOI5VFh0MCiF+cecQiBTcXUoESagAwSK5mEnXRfqHVsLTLWoN349gJNhGO9HZWrUNxyxmjLnwKjVJHpPnykp/hbN7WcS/6kMIKhA/AcnSlemh7GjYR/Fc19CJj99AirfaByaeeY29+hMg0qHQpAFAbdwOsns75+vQlpEykYoQXns
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TkIH1EcG91fSPLEa56+nxB+/kJ9m35rsyxymxapGYLYOnKBHg+n4PbW+TT?=
 =?iso-8859-1?Q?iX0vHRUAZew8hXUJM0jPvftlDtjoAekzSP+3p35ZCyMTB+VKZGvU/WkJBt?=
 =?iso-8859-1?Q?gGJKnCBoC1BfwwzKNB7TbwHEPT+C24/c+jJIIntrPWxcVfWLPmUNAg45B6?=
 =?iso-8859-1?Q?vHDRRpVmu1ETAK8Wzi3lp/0O2EdVWcw62zOEedJHuEfRj5Z2VI+mwY8jQ+?=
 =?iso-8859-1?Q?/1am3CuEmAI9/N5q7r2fLoXywRB1/9YJnOHGZ5qN2hK1fy4Jiax0916ScF?=
 =?iso-8859-1?Q?ZKciYq8n0ZgM0lX8Hs3NR6KhQd/tjc6N35wPSnXLi3TErzWexsrFDxVrP/?=
 =?iso-8859-1?Q?ZRT7G1Q5opn8cfvceTGMXlw5FpLs7pRNTOb9XLZCwHv6THYtD0tbWtz1CU?=
 =?iso-8859-1?Q?Koda8BytV9Yj1qEic2cQtKkMSMZkZVSLO/EZ3HFv/aiSVlm5GoXQ78bYrt?=
 =?iso-8859-1?Q?pHSBspLSu6wqHo5jtMmYK/y3sCsFLq3LjPqhIXWB6RKTMae2mqOIVyuyCs?=
 =?iso-8859-1?Q?wAacoUEAHec2hU4ldkiOGHoMd8En/qRfRvIBLzi3ZJV8VWm/kNrxOuFURN?=
 =?iso-8859-1?Q?PMGjXWcy5X65GeHocbHTT1KwHfPJGIxm5hGYGMMxoh6GYh4o+7pqkQMQmp?=
 =?iso-8859-1?Q?tN9+8edlL5FHgysjPXMFWpQTBQwPTVPyDpSYt/0HyydPJA7OlgAysBzDfn?=
 =?iso-8859-1?Q?OsaHT67ZEZXKe9LAHh02ZL5HxqbBdHrPLlcYpgVKa6CIjpecr6yc2tmzbY?=
 =?iso-8859-1?Q?ZJ2vA0m5O6MzcHT5bhZn1/yeYBvaGi7jUB6P0fovI/aofY7tF+4EgMQGEW?=
 =?iso-8859-1?Q?KFmCzShVhzWDTZjEJ7EBHC899b5qxJXXBswOXFF56MlCeNbWd6/hVgF/g6?=
 =?iso-8859-1?Q?yfFsWuyFyBhJR5TG3MQadZWMBC37zsnI25DGDHOQp3Zg4xad8f6eVMJCoQ?=
 =?iso-8859-1?Q?7Wpa/rYFt3+jAhnQDz+LRjwYv5u8sh8WJI/gmUANM9eBN+mK5RskydkXuv?=
 =?iso-8859-1?Q?j8pxY+Tmz6bmIfY1M9gXXSvDLuX25tksgtLp8M7nVQ15ckBWxuj5HcIW98?=
 =?iso-8859-1?Q?dtSVo4YWkeYPg8KtZmjC5GyldGea9R3l1iv0SBmSpnT4VfiEdsk/PYMp3j?=
 =?iso-8859-1?Q?N2/rMrNNCVxSJaWbkQEh3iMljE5J/BGzLF8K7XISb/HDhxQxjOWjMv92/u?=
 =?iso-8859-1?Q?ciDlE0htQ2CPGFCBNeZgARVNzuyKiVMH+1GlxCCo1JZrn3k7Sz+licjZFV?=
 =?iso-8859-1?Q?QWOoIaAo8pBtR0GziO0CJvauHKCXgpqIxk6Rvzhr4bsuyLPt7LXTxjGaDP?=
 =?iso-8859-1?Q?Zsmgul3pS2jZiEN1r9mC5ljl9Ul339hZ0rzrkf00piCs5hgaSsz5zlGEPj?=
 =?iso-8859-1?Q?ZuyUkhOGiZYBUz6NX+q4gSi9JCJJqOkLpi9OYRbMY6F38/94wyACmytT+W?=
 =?iso-8859-1?Q?Y4lnx/hHhqx2J094CRvafgPWS1lC/CQ029sohnME2WNnxIAkkIppqlAZPO?=
 =?iso-8859-1?Q?nJB4ay2wfW890R4De063uhNRpT2uEymn/Z1cSfWao0Su5/vS18me6E+Z2N?=
 =?iso-8859-1?Q?XfSfv1c5Vf1I2Rio2JKGxakbRPIZL1PWC9xntx4zfn9/Xkg1kwZBuoT3LM?=
 =?iso-8859-1?Q?USQpNkPsyMBfQe5IYlQmS5gJeCrXuhz47AFYht9J0aqgXMHQukvRgaknv0?=
 =?iso-8859-1?Q?H3Sv7y6DIjP+MVOlTXOLeUqVMp9fBevSAedPaSr8sqCpXVp4t1dmk356C1?=
 =?iso-8859-1?Q?pol/npEqXjCt2DyWffqrIsZo4ONqhM1QYNoycq9eW3w7mev5R7RMwVvW43?=
 =?iso-8859-1?Q?vg4hcn8skw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lu5Avlvk8yK+uUto1OMtr+xmpmFgk78+Hol0Z3AFc46JRnwVAUQJ57wVzwLnUp7txQBmr4y2yhNRXNZw2clZt7Yf4vCm9W6gmH3orBcAxYp1IuNu3yxurCfpEiOO07u7ZTAlabmqP1vbWvObd8FHUUbgKToVqE9zt89BRGc05+oYE8VhSl51CkWjoHRLzZRPcNfMjk2oNUimuZFIlMlMGlTsQ2N+KNvPlyRwcIJ+UNvv5Dp3yGaMS7sWCHqoqWKXXSOdddjPOxrCmk26RvwnG+0nKqdsozrrABOG0R47siutbveEC6uUjUXJ0yD1F9FdMelYgCfvnMSJW4CJYA0hCw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t2oE0JRkdrkDKR8SZnTNXl4jaFi7EnvpjOb0UN3Bcgwa8QFR8vsucjTXjGq2ewsaxMQPZMOf4KpdRJ3FEj2LBIKFsD/WAFeUwgYI6oqgeSNkXszGjLbDoeTRwdRFqdewWpSnI1xB9cjJCO25YwReA/APaIiq759zHOADxJTdnxT91Y4U8lLECN4JHffOZT0flzlfkcvu69BMa7PSSRUd+vKN9dbI2HnjzD1RpxW8Thz1Is/Q4TNGeF19xI5PRE6CgfN7g7z4o2b+ymTkA+IkCgYqNpPxRrd0weGtnFDW6Dny+sKAb8+i2lctAD31tLjrNBUC2QKTtH/eKN9ZhkqgOmUC0S34LiLq9jTeH/7jLL43JgzqrbzwWbDw5YPPcK6r7hjqMiFtcbLNEJBW6RVHyHoEMJCW93+i7W6iqixn3hn+Ec3k5UxEJDnc+vGJOy8zElr3Z7ix1N3uVMdh10OaWLYXq78509l5u8YVN+bp3wXgfeOfX3L1hW+ljYBqCGxqJ8hNKtBs1RTt2wN2dGhfQpD73Ku6vtlH0xGNt++d6b+o+5YJTfLo7sHfM2m8YpSI7pP75JSHwP1GYdWCGTwz7RAp1PNs8shNK9EuUvsibZwaw30xuew+r44/FCGaZAof
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8beee1f-1986-4dd9-9523-08deb5666c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 05:21:04.5402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DOlVavNqYANwoddEP56Qd72EfeA3fuj3wdnJ5i4RYqvonC3a/rRgBqpXBr39J3Nqq+0+qbIPIhMu5AMWCZfZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6375
X-Authority-Analysis: v=2.4 cv=QaBWeMbv c=1 sm=1 tr=0 ts=6a0bf346 cx=c_pps
 a=lvP0nPgiJ1xWSC4R46nbEw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=6Vn1QVPt8UGdu3r8PAnt:22
 a=uJefQaUuXTt4M4BVPmAA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: ln2yR8iwjv9PyT914REaS9uW4b5rJs3I
X-Proofpoint-GUID: ln2yR8iwjv9PyT914REaS9uW4b5rJs3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA0OSBTYWx0ZWRfX6Oh/QiBAcH6D
 ON+QeN26i19YFgBvM/pm+HmGahtL6e3FDowNBav9JvSPqTsU8hN1u8VtyXZL2UIFP7UWslxfwQz
 jGhrjNpXtGPG62MLo9Y8sRUiNw6imyHG18goSXEmxBYiEW3c7GjOZa3TjOlDGAgBoZ3GW+aclba
 iyzZokRjHXsRWvWS9Ax1p5oHiAveTxtm3t4W8gg1nxIXGyMaHpaCbXTvZMttdOm5IhJ2Cfrx8Fp
 ScxzFzMTnyb6RNIWU0K6FQYIKr4Ua+q3RWU1XfkqusnH0PE5KFWob5F6+G+H68X4m94UEuhuUjO
 SItVHMLVx+TVqx5f8jFSJ7xP3qDkUCCDtsWf2wweHAvu3fP/ygx19POaUD5XlJ1PPwqAMux4sn8
 5IkrPRMi9ivycrfkztCZHXqhYQFMXesFr0icrOlVeKtQ3daIUCtH8bM8cB/Z46X+QaMKZgeKhAT
 P4V1iQNxkWBrHRWKPvw==
X-Sony-Outbound-GUID: ln2yR8iwjv9PyT914REaS9uW4b5rJs3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01

> @@ -749,28 +750,56 @@ static ssize_t exfat_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *iter)=0A=
> =0A=
>  static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)=0A=
>  {=0A=
> -       int err;=0A=
>         struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
>         struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
> -       loff_t new_valid_size;=0A=
> +       vm_fault_t ret;=0A=
> +       loff_t new_valid_size, mmap_valid_size;=0A=
> =0A=
>         if (!inode_trylock(inode))=0A=
>                 return VM_FAULT_RETRY;=0A=
> =0A=
> -       new_valid_size =3D ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;=0A=
> -       new_valid_size =3D min(new_valid_size, i_size_read(inode));=0A=
> +       mmap_valid_size =3D ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;=0A=
> +       new_valid_size =3D min(mmap_valid_size, i_size_read(inode));=0A=
> =0A=
>         if (ei->valid_size < new_valid_size) {=0A=
> -               err =3D exfat_extend_valid_size(inode, new_valid_size);=
=0A=
> -               if (err < 0) {=0A=
> -                       inode_unlock(inode);=0A=
> -                       return vmf_fs_error(err);=0A=
> +               if (ei->zeroed_size < mmap_valid_size) {=0A=
> +                       int err;=0A=
> +=0A=
> +                       /*=0A=
> +                        * Only zero the range that hasn't been zeroed ye=
t for=0A=
> +                        * this mmap write path. zeroed_size tracks the l=
argest=0A=
> +                        * page-aligned offset that has already been zero=
ed.=0A=
> +                        *=0A=
> +                        * This prevents unnecessarily zeroing out the en=
tire=0A=
> +                        * tail page on every page fault when userspace w=
rites=0A=
> +                        * data byte-by-byte through mmap (after a small=
=0A=
> +                        * fallocate). It fixes data corruption in the ta=
il page=0A=
> +                        * while preserving the existing valid_size seman=
tics.=0A=
> +                        */=0A=
> +                       err =3D iomap_zero_range(inode, ei->zeroed_size,=
=0A=
> +                                       mmap_valid_size - ei->zeroed_size=
, NULL,=0A=
> +                                       &exfat_iomap_ops, NULL, NULL);=0A=
=0A=
For volumes with clusters smaller than 4K, mmap_valid_size may be greater=
=0A=
than exfat_on_disksize(), causing iomap_zero_range() to allocate new cluste=
rs=0A=
for the file. We need to ensure that mmap_valid_size is not greater than=0A=
exfat_on_disksize() to avoid this situation.=0A=
=0A=
> +                       if (err < 0) {=0A=
> +                               inode_unlock(inode);=0A=
> +                               return vmf_fs_error(err);=0A=
> +                       }=0A=
> +                       ei->zeroed_size =3D mmap_valid_size;=0A=
