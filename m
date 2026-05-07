Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B23BA22C
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155493; cv=fail; b=Wo+lZhPLxuLuKKQXIxojU/h0Jalfopti5nH5Ih2QFPK0pOM58ZD2ncOKUSXGnlJxXuMA3sAR3aeNt6nV+IdJM2WG6ux3siDVbsHv4tWu4PIio9G16H887V22js2evn/7lBK4hYqxE7Jy97hmvbqQnHcI6fbY4lSYDRIs3xQkXo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155493; c=relaxed/simple;
	bh=NscolBrVCRSszQZ+lzgSziAeX1Glt0OYTD8TM+dgkuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9a8FauzMgnMOEpgaV4kk1kH2U4UT1DslYaOr2EZpPN/s9HMnpE8aT3CzhT7eRMe04U9iRNwnotQL6CYzS9wEq2FPcTw1ln05d5pS1rxVFTbCQQzcrRhyDS6/XEzeQofHoby8PQnOTyKPxEQ5n1y31eDM2WIog4YOxO96Cv4E/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Z7KgJ4PL; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Z7KgJ4PL"
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647C05gw2065861;
	Thu, 7 May 2026 12:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=03WmgTl
	EdhtuSjUomnG9I/7e9efq3Zu9LctlghFuKf8=; b=Z7KgJ4PLtG8isaTWNN4LcY3
	Rh1Md0EwhfC3H41Ou9WQn2YwO2DhbrTOR+w15GnC3RpddsoVa4L1DpUey/kHnUBg
	CeuTEhpH0NtnXmq6eTGEQ0wr0GoV5Nsjnuo08nzgxrt7onmcIN8PpYOyMJJ67Cnx
	Uf1hRno22lF21QtCOU7lgqnscmHdJF+yds2DgKt2rwDwZXWnbVVTrVvbhSkkP+NX
	pOl5gUoPnGXRb/8IQIZ10EFTRf3q8v/jatUedUGh0tuluj3vjO2/WFOlcJqNNe5o
	pg7eWlXLqt3Tidq6QQLJtg3iZDax8s5u1OW13Slbcd3q1nlE3s+J1YnrBCZ8NKg=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012070.outbound.protection.outlook.com [40.107.75.70])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4dw9g6mdwu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:04:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ewx2u7p9HjcjJqEhd/6fWHa234GeRpLtV4Y98dAS5hFefa+2iM9NJar0M4k0GmOdtGGFK8+N7cdnf4pnNDKa3MrDQXcOSKXxRnnTu1jWy6r/G6bmptyl0mlNcgWC9JAyGg25nDfnzKFEYlfkZicC7I6n9PYrUhST1YAv79kH790KLl1E5KHIqYy8isw1boYIwm1vvbUI4NnNRVHjJR+WtV4ATFIrO17QiBZgmMgStD94U2jbmBGhgMlWe1t3WGrx7cML25+HxPTh03X2ainGPcAt0oGkdB2AMGn8rSVk4SZ6fKZUIDfTa/GejLcVQ1+v61WvVUVK+NVGmiisXxpwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03WmgTlEdhtuSjUomnG9I/7e9efq3Zu9LctlghFuKf8=;
 b=LeKLULI6Akf5ZcAP5WipVVKg9RHENQvNgS2ZwJ/hHd7GXd5KwTeMjslfEHZGRQZR7wpk7Kor9qUiAdmAWByo1tZ693bkySZbtMHwlpzjcKzRTpAWQp3KXLXlS5h+vNIa0zwCRWmBeQ0s9S3DXIrCGNwMbQC6J2RnxLAMRg6gEVhuF/x7J7qalSkLXZg114QP4KxiVYUAwHLq5TPw+OrJEmqHFmiycpOxcaAha0jmG+gYJXvoxlN+ELfFvOodZhYqQyafE+Z3f6bFHhdbbkU/D4mP10OXcWDJyGG5jLlxESPzHZjWZd3NxlwGwNu/6QSmHIqueWTefDMvvPRLOkszrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SG2PR04MB5663.apcprd04.prod.outlook.com (2603:1096:4:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:04:27 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 12:04:27 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] exfat: add volume limit bounds checks
Thread-Topic: [PATCH v1 1/3] exfat: add volume limit bounds checks
Thread-Index: AQHc3Iq8aahMAAX4PUKTh0YI0s/syLYCRAr/
Date: Thu, 7 May 2026 12:04:26 +0000
Message-ID:
 <PUZPR04MB63168F494EE6F2061377420D813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260505122808.728020-1-dxdt@dev.snart.me>
In-Reply-To: <20260505122808.728020-1-dxdt@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SG2PR04MB5663:EE_
x-ms-office365-filtering-correlation-id: 15967037-1c09-4072-1e60-08deac30c965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 Y/Ie7nhaCb+4ZFlXN/zcbq9nBE4UvYzvqdn5D3qu+guNzxhCBdbpXqIm8/M2unYnRESGIdvuc0+R6MrCAXduJhPRI2RNFq2O1eKs+rcGOD0y1YtJrxSPg/msiVDfNJj1hxSyWQoTiYUvktFeOZOgPVavRJMXO2JdgCKIgXg/vn0Slm4GK2y8d40IPQIFFlxxNhtfkm8IUA1ECPtUL2NiOAlC7MjFfQsI+w79+C+JaJ85qsR0rx/R8ZBI0ZoQwGOCEG07idV5YR25K7fBV36nQ/tFJh0orAqvpE7YeFVyxrpZf954GGj/lU+Gdow/0A8+weKOPyQZckh+SMMCTqnKF58HQRaRwyC8ohZvD6VWS/QMRAkaWllr5UpwCKiAK/zua6YuFapEmEIh4ySPAWBshjcyehR6Glzrx3PwVRIE6CvsjGNiMoZVQOyxzqdCbu/S6ZaSXtoOfbmJPpbYGfkcLCRDeMKdipRND1yQwk73hgyVhrNTg9YOnE3FwhFb1y3O5TQnjObg440KEX2TYkcz0Ok4E/JPfu19aXMER8hE4i03XF4QSzhR1mbYentz2mHcUFn5jpQ/0kr1LwyU/8yL2HUVCrWKIPXRedHtMkSAxUp50LLxKXPMMT9z1ds/qZxM9XyDJ+yi3leA219cELptzCT+F0i9h5ECikHY82+3RRWoL6nNonZkeWfF3SHR7WwlQxVSEj5odQQSJRWrQ6k22wPFYQwto6qy5oOmor/xFDEfS9JwNfdeRQw+Z9c60E2/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wXszLkLxZFg42hyjluB//QQY6n2W/lLL6kSFG7aj40JtP5pBLNiunB/vza?=
 =?iso-8859-1?Q?G/SNlHDaLKHsjOORUTJIukAyzTSWW6miiEaSqaObxTO/L9HEGavsYulUu7?=
 =?iso-8859-1?Q?ouHiY6sp6eoRTSyWo8oe12YLQW/USV5uxC1owQsuOLtzc6XO/H56+3EOOm?=
 =?iso-8859-1?Q?2vOuF4mybosB43Va4u3pylQj0hpc3aWYyETDRtkEaWhnlarnsuVlI4+ZBe?=
 =?iso-8859-1?Q?i1W8n4ar/Jn7YkBtktDzmH1u2W1/cBD9Zkf+GxpuUcfdLj5bbQYgyt/jQx?=
 =?iso-8859-1?Q?Tgu4/6BrUDSBJxuge9vuT/tdbJOodyOeAy5OXlRytM/kxrOWicfofIT1cb?=
 =?iso-8859-1?Q?Qh55fs7vlnCRgdzJuwzIap7J/xaLQdrujO91fY8lvnrCwpXXyBOqjtQ/bF?=
 =?iso-8859-1?Q?yvEyYA/jvXx3NXzAXLcIunXPYDmV9tH25HIZMc4t31tdmb4H/kO6W+A62a?=
 =?iso-8859-1?Q?XJFuezLcDyKO0X/TVCZRzXNEtwenI80KXCuYy5wilCO0nvl1k14Pr1i5on?=
 =?iso-8859-1?Q?pjD6cOnVkRMjBvq47B4dWwN7h8+osHzu6hq3fd5u8w9d2QirktbuAM7xK7?=
 =?iso-8859-1?Q?BhHIjma+2Ud42+lt2LYd6mGLzdZQAanzB6mt71r6APdOM4pLsZefmTNjSp?=
 =?iso-8859-1?Q?ok0b+ROnh4zJ1X+EjO3Ij+V3nR8R01XAYY1qLvMFdMWNok4k9EeHfkU4dB?=
 =?iso-8859-1?Q?6yXJbJAomW2r33Zx1whV0XB18qDgyISarpMaQ8cdZ/kWTV18Hi6e1Pw0NY?=
 =?iso-8859-1?Q?LvoYJeBpwXMOe946g9EEZaRpD9cf8mef+eE4cMmbBLCp5OToqV+3JCmaI9?=
 =?iso-8859-1?Q?+ePUZV8LhTHirgga4ANn92olGwdgLe6/K3a0EwViVBn2HdFktXNCnid23z?=
 =?iso-8859-1?Q?MrVr5MByP/JE65ZnPpVj+qIyWaQkM0P/G+rrxJWPIE0yAdd9zC7ZDxjab7?=
 =?iso-8859-1?Q?rNhJ9GFpIx5UdxPpHCk5TERI/tn+cF9Zpa18VEAUQlM+7kgRLl1TL/efUU?=
 =?iso-8859-1?Q?NQR9whSNl12mcuOXmB1Qr794+xALWp/Ey5dlaGYtZQ0f9+JiwLw8M1EsB1?=
 =?iso-8859-1?Q?dYlfTC7xyTZJB3ThcpWrCtyD/7roT6YX2DUAqOEJBPIXqxxGOf45TV/Fsl?=
 =?iso-8859-1?Q?wFTbz3LqCeqqc6kWsE6NvP6l3poDt1NhQMKRjcC2v+GJo3cGsbehkAAWaW?=
 =?iso-8859-1?Q?Ek07muJiM0V1JYuryAcEqbv7vc7c/CDHa3jDvnMgZcOLaNn37KRGCceBp7?=
 =?iso-8859-1?Q?oTFkcvTTwbaflqVTGxqkbOnQPHmjCD5DKiSY4A6EAahlF77L5qcY4shtcC?=
 =?iso-8859-1?Q?8hAhmgHd3y8sxdbgD1N6r8W/wG46DclDZERJD9v0AmO+MQZMXaMxjQHPDS?=
 =?iso-8859-1?Q?7nly/4D+T8TBrwxzF8xUxguLW5jH64TjFhCycES7B3xXo0wLrYj1UAdkrN?=
 =?iso-8859-1?Q?3LNaxojo1pzOLjuEqgT00xPU32K0aDHuuwffV2XMXkV+N68X4Cht9qekRa?=
 =?iso-8859-1?Q?/SdAchKXeGdSAODWvN4J7wGsroo8BDI73AXgZiDNmluujI9YEybcjX/fUp?=
 =?iso-8859-1?Q?7GeRFvNFGPSZ93HnouaeDVePbg7OTuT0dnHb7PiKLWG80NxmQoxQXo3Yzf?=
 =?iso-8859-1?Q?IWzZiiGsqcOfe+z9m1AQNI4aJWQ9m0vjTNi/UK2Dv+FCnyCJY/FxBGDYrN?=
 =?iso-8859-1?Q?4v5Zv1VJ9OX5au8COR7laIK+/1fusXf+tJfQyYSx0Gtzvp/0ZkXN1kiRt9?=
 =?iso-8859-1?Q?lpWu/qkaudz4zVraIfCyv65SK9EwF67VbUvc8bgvMnL1khaKZBqDgBLSJf?=
 =?iso-8859-1?Q?rt/2XLK2vw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bxJotNU/4nDfCJ1UZlOk9xNZUhaMJWUMYbzhYb/g/KiRfMI35gypEE/3TEvQT09tuGqMi+dLVT7hKNhdJ5PXV9O4X3JyOAjE9U+VVylEtpKXZ1+VHlgd/m1RIdHWPABB0blMJ/mdUrN92BVoG6ATtkjjxeZe/UqJtoZoLczohXC6HLgqfgyk4pSRlaiaPRun7QcHnU1tq/qI30nHfsZPZ5HZan3pqp/FnhJdnTLmkWp/0rMMMw8cd4JKhk6iycUEfGz5OXHzA9GsdgYrFbr7+KY90Bs+J/IG1hgZEV2GqfQ2fC8T08FUxs8KmRNQkUal7dLOI/Kn+r0uyEgxXF5Wew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UG5VS+V+mt9aCgYODrtvJnW7Trl9pCfr6u7TVKFzoxS6X/+Y9sCrOBA5c+A58TjSwiAWWk/VZJxNw2yqLBRmE0MEbOV1pQ7FKM1r3HVZ8wHMg5dbtsaEkO8UiLUndGOxH0Ehl1Y+xecVuMxfdUWMcDgNUORkdBUuqQtDZriQq/JJdSfq7SuK6jjG430jN869c/meWB+m43QoqOs+GUx87lEEdZsmCwwsj1iKxDVSN81G3tOX9xW35q1ZAWNRQ/8Nm0PSF758gcTwAH99jT9xCl6xptEsz9iN01SZd6zT8Jwmu/Z7XcjfYCzgwkjqmWQoHs9dFOLkS2oszoQvx9Eg3H0e/2OqLffHAecOAvTaF7N/GjyoGZj9JEcqfIjJ9uiR8atf+pAZTTupqJhPvUk1xlOgtqSs5YCRehDoubEjxx4ZlZhMVMu1FKpXMmfB/qyOb5Ox/PCaqYsJJGrlZtKbnuA5zAXAakTKu4aHiWoIlERYxL9hXgVXKmajSu7ABWTmlY/H8T74PGGeMKOYQ/0xA05SljGO6ak6SjTABG9ekNevTkyiA1VYR6hfn2zjqidZhHw1bgC3DSF6KVLWUqw0iR1qV067C50reY2+QiLVCp/NhA9k379T/sVM0KGEVqt2
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15967037-1c09-4072-1e60-08deac30c965
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 12:04:27.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET8WntHynLjNc46fa2XrmuFx/i0n5fCrq5T5eqsl/ak5BK4uR6+/tWlD7Qe/iHxz/XIn3gNow0MkApcTwAnnJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5663
X-Proofpoint-ORIG-GUID: BcECkk_mb-KHBRgXElGlgU4NIT8KK4hF
X-Authority-Analysis: v=2.4 cv=RP6D2Yi+ c=1 sm=1 tr=0 ts=69fc7fd0 cx=c_pps
 a=WMo9HYg8Dr992rWvOlhhqA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=cIyGuqrkuvkXWOl_fzuj:22
 a=NEAV23lmAAAA:8 a=VhN4NTNiaV3Y445IOP4A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExOSBTYWx0ZWRfX+vDAB9JBXIAX
 6jOcbzeCmlgYSAhdzE3m/tiZnmzgz3VPbf/8j7qLwNavCaNSVsg3Ctrv7MjFnpKK2V3SPuACPJK
 RHAHgtHf65f+O31HDCk/Hy10PaeFDh+qoqKH2WECqy6ykfUU2tG1l2x7PjdnAshudrmKCAY5tGs
 nTUgFNsPKOMy2BaYr7acng7bu9Hbv0ewpIrJwzezU/r9FoX+shEiilVa0iR/HTmZ0UpfygCWA7c
 lFX0fUjCiTjHEuWA6SNUE52ezMoKgUsaBZNAnvZCKp6PhDUi9YMZALMHVetlKFmM9LufK7S2aZk
 1xi7Xz+CsOg3mq0CCA/R8eqAFn+n7vIgPyBPvUHYiV8Xr2ZJyEkTwuvosEj3GAFhExGIVbbZS0a
 ZBZ5RWLWDfPx9l0izE3hvyB3gVh7K5jnlk88YOjR7Yr9HO/yKlcW7HDTxpFOH9Yla71gvic3/8O
 DOI4u1fwRnaCL/qJcAw==
X-Proofpoint-GUID: BcECkk_mb-KHBRgXElGlgU4NIT8KK4hF
X-Sony-Outbound-GUID: BcECkk_mb-KHBRgXElGlgU4NIT8KK4hF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01

> If the user inadvertenly truncates an exFAT volume(mistakenly shrinks=0A=
> the partition or simply dd'ing from a larger removable device to a=0A=
> smaller one. eg: device marketed as having 8GB capatity < 8GiB), the=0A=
> kernel exFAT obliviously mounts the volume and operates on it. No error=
=0A=
> is reported to userspace unless the filesystem is accessed with O_SYNC=0A=
> or O_DIRECT.=0A=
> =0A=
> Off by one sector test:=0A=
> =0A=
>         # truncate -s 1073741824 img=0A=
>         # mkfs.exfat img=0A=
>         # truncate -s 1073741312 img=0A=
>         # mount -t exfat img ...=0A=
> =0A=
> The existing filesystem implementations, prime examples being XFS and=0A=
> ext*, refuse to mount the volume with such condition. Introduce the=0A=
> checks similar checks in-place to exFAT.=0A=
> =0A=
> Also, to prevent UB, add checks against exFAT volumes with maliciously=0A=
> a crafted main boot sectors with the ClusterCount field equal to or=0A=
> larger than (2^32 - 11) as per format spec.=0A=
> =0A=
> Link: https://github.com/exfatprogs/exfatprogs/issues/353=0A=
> Signed-off-by: David Timber <dxdt@dev.snart.me>=0A=
> ---=0A=
>  fs/exfat/super.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--=
=0A=
>  1 file changed, 46 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
> index 95d87e2d7717..15e99766cb8c 100644=0A=
> --- a/fs/exfat/super.c=0A=
> +++ b/fs/exfat/super.c=0A=
> @@ -431,6 +431,7 @@ static int exfat_read_boot_sector(struct super_block =
*sb)=0A=
>  {=0A=
>         struct boot_sector *p_boot;=0A=
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +       unsigned int nb_clusters;=0A=
> =0A=
>         /* set block size to read super block */=0A=
>         if (!sb_min_blocksize(sb, 512)) {=0A=
> @@ -501,8 +502,17 @@ static int exfat_read_boot_sector(struct super_block=
 *sb)=0A=
>         sbi->data_start_sector =3D le32_to_cpu(p_boot->clu_offset);=0A=
>         sbi->num_sectors =3D le64_to_cpu(p_boot->vol_length);=0A=
>         /* because the cluster index starts with 2 */=0A=
> -       sbi->num_clusters =3D le32_to_cpu(p_boot->clu_count) +=0A=
> -               EXFAT_RESERVED_CLUSTERS;=0A=
> +       nb_clusters =3D le32_to_cpu(p_boot->clu_count);=0A=
> +       /*=0A=
> +        * The inclusive comparison in the following check seems a bit of=
f(quite=0A=
> +        * literally), but the exFAT format section 3.1.9 says=0A=
> +        * "lesser of the following". Aye, aye, captain.=0A=
> +        */=0A=
> +       if (nb_clusters >=3D EXFAT_MAX_NUM_CLUSTER) {=0A=
> +               exfat_err(sb, "bogus number of clusters : %u", nb_cluster=
s);=0A=
> +               return -EINVAL;=0A=
> +       }=0A=
> +       sbi->num_clusters =3D nb_clusters + EXFAT_RESERVED_CLUSTERS;=0A=
> =0A=
>         sbi->root_dir =3D le32_to_cpu(p_boot->root_cluster);=0A=
>         sbi->dentries_per_clu =3D 1 <<=0A=
> @@ -591,6 +601,34 @@ static int exfat_verify_boot_region(struct super_blo=
ck *sb)=0A=
>         return 0;=0A=
>  }=0A=
> =0A=
> +static inline int exfat_check_volume_sizes(struct super_block *sb)=0A=
> +{=0A=
> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +       /* last sector of exFAT volume =3D=3D end of last cluster */=0A=
> +       const sector_t lc_end =3D exfat_cluster_to_sector(sbi, sbi->num_c=
lusters);=0A=
> +       /*=0A=
> +        * Do the calculations in bytes because the blocksize may have be=
en=0A=
> +        * calibrated in exfat_calibrate_blocksize(), and bdev_nr_sectors=
()=0A=
> +        * always reports in 512-byte units.=0A=
> +        */=0A=
> +       const unsigned long long vol_size =3D EXFAT_BLK_TO_B(sbi->num_sec=
tors, sb);=0A=
> +       const unsigned long long bdev_size =3D (unsigned long long)bdev_n=
r_bytes(sb->s_bdev);=0A=
> +=0A=
> +       if (sbi->num_sectors < (unsigned long long)lc_end) {=0A=
> +               exfat_err(sb, "number of clusters out of volume length bo=
unds : num_sectors=3D%llu, last_cluster_sector=3D%lld",=0A=
> +                         sbi->num_sectors, lc_end);=0A=
> +               return -EINVAL;=0A=
> +       }=0A=
> +=0A=
> +       if (bdev_size < vol_size) {=0A=
> +               exfat_err(sb, "volume length out of bounds : dev=3D%llu, =
vol=3D%lld",=0A=
> +                         bdev_size, vol_size);=0A=
> +               return -EINVAL;=0A=
> +       }=0A=
=0A=
I checked the code further and found that exfat_zeroed_cluster()=0A=
already has a similar check, but it is only for directories and=0A=
does not check the size of the block device.=0A=
=0A=
I think we should also add a check here, similar to the check=0A=
in exfat_zeroed_cluster(), to check if the last cluster exceeds=0A=
the device size. This way, the check will apply to both files and=0A=
directories, and the check in exfat_zeroed_cluster() will no=0A=
longer be needed.=0A=
=0A=
