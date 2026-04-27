Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C2836C597
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293809; cv=fail; b=OwP4NMRG6AdDZNv+2oI3h+LQpZTGDgd95AKN9FGUR9Otb1TbwYXxh8YYnVSlvEFih7VodE0HFUodA2Iu34A+QNuRHdDMrJc8D4u/9/PRf/V35XLt81ASWPSGSrJ2FFLZsgf4szwYoh9cMqhcTws9kcQcmXgkR5lFvHkY67+QiG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293809; c=relaxed/simple;
	bh=Pbs+jDjPATEwuxBckzvPM9PN0XZXo6d5N+YMPyabWOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q6CdPcnCXtUn66fFacGHOwy/Y7lbc5M4EIkUh4LaF3BetcpfdI15/ocqNgQLMPPS7uM6UMLJ8GAphKIlebMQC8SgYZrY8QOXtrVE83ttQu/A5LUP3qUziwTH0cbe3Vr9bmY4c6WsHd6T9X5TUtIyinH321pn8a6Qo9BOzS4MUy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=nptlYOda; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="nptlYOda"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022139.outbound.protection.outlook.com [40.107.209.139]) by mx-outbound45-213.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 27 Apr 2026 12:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c707wsiuSkO3WHdZjk2IU00kRAYXN2NCf9Aoo6GTELXlz5nVKnOPhp8jt4M9P8l21VBtAzyvNCfcxycduq9v2FCC41uGFrY/Jm94EfAmIjXlz2nK/+N+aNSnEuRUNJEkr3TKpjYTpgeWNz2/v72t+jbYM6qegnbMzco79bKm1p45b9aJPzYmgYvnta1sCJzWD5Yt4Eo0B/IwK5M6lNaq63KhK1pom1wu6GwDLjgzkxO2U/WBa8iU2RLpPwz7dye5YQc0UC8Bdo8TcI2a8kXK5XSQI8niESXmanO6xePWIhe6gEvzmUwRqlm4Y15XxPqCa2uyRGz96eLuTBqnqg5+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pbs+jDjPATEwuxBckzvPM9PN0XZXo6d5N+YMPyabWOg=;
 b=sJq2maIHrU4mGJVcVXCK1jilTy3QzIVq7VO6TUj2jDkOAhP/SVUiecaLx7cK3/Stmr7R1zL/k1o1XL4Hm7ofIl2ku9KXF/Z9E7CCucK8nOiVtqCTQi5XLmxOIcHt4DTlWAtGnN5IwJe/xzBjpvZ5S4sz7xx1iENrqxNw3d7hA7/NUL2kZRgd3kZpqOPID4zcNYf84gAykF1+JMXTBp5P4E0q55aL3EKS6KZQT885piNzR3zuKTdQ8TEviG72HBh3VaLPr5yOvOVELbWlSmX1QrOh9CcpT12XhvV5eATPS6kueNe3LyK8tt3A8nrhTaq+mAmvnpBXuvb7QbTfLMD3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbs+jDjPATEwuxBckzvPM9PN0XZXo6d5N+YMPyabWOg=;
 b=nptlYOdax/Fx4r+NaGE2Z9Kk+K9mTyTj9qkuubA4JviCA0Yxjy5VzTvtddwOhxPEt0B6LbUu40vhyYz67UiOEQd377cSDp7mOUE2w+BokUlFn3gZB1gzZF9uclAI2/Mj6hg7pUayBUsCK01tXAcNm5Qd/RbQ+nL/v7oAwv9WUQQ=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BLAPR19MB4594.namprd19.prod.outlook.com (2603:10b6:208:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:08:56 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:08:55 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>, Bernd Schubert via B4 Relay
	<devnull+bernd.bsbernd.com@kernel.org>
CC: Miklos Szeredi <miklos@szeredi.hu>, "bernd@bsbernd.com"
	<bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Gang He
	<dchg2000@gmail.com>
Subject: Re: [PATCH v4 6/8] fuse: {io-uring} Queue background requests on a
 different core
Thread-Topic: [PATCH v4 6/8] fuse: {io-uring} Queue background requests on a
 different core
Thread-Index: AQHcyym3da7S0TuuSkKjU3cY43t6oLXuZzrGgAR/r4A=
Date: Mon, 27 Apr 2026 12:08:55 +0000
Message-ID: <ed5488cf-9f73-4337-9b06-57e3beddbaba@ddn.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
 <87v7dgmlb5.fsf@igalia.com>
In-Reply-To: <87v7dgmlb5.fsf@igalia.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|BLAPR19MB4594:EE_
x-ms-office365-filtering-correlation-id: 93b176dd-3462-4352-80bb-08dea455c17b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|19092799006|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 yeVcR2VOIW+/rptPezGmW4B0U2PPtzHPxhqtXccK0UnmCgenm10hFcWuHflwpYdsDvJZIFSf2BKM2PZlEvcfS327x4nwHoFNvD4rnIL4EJYLg3XH8WYOvelSFog1R1K7FXvhAuGMcU61Xaj+SQrIuNx+OOSqHzQpX2RXdVR0ARrzFx3ceOnsR951lyP6d9OF20usEy/rfcN0wUFW7avmFRmuCy/MVYjyhQuZsy/iifl1DhM4wuPwscPSEBECHBy4H+6AWDKYkksDemf2zlaObEMZqSm7PeebwoOjVdXnhoTBm5/zJ+QR9Fq89BT6CEQZu5MiI1bxDoRhFXVTx/C5QZd4taHS6Tyz9FTqoVgePGXo9wtvYhRPk4YP4BRXYwWDIbNOzw9AjVDB4hjUE3gT2mbw9JM97Z5d2Ye6vag4XgpVNeA5aqBu/QuFIK/JyPfD57OaLIPjoD9ZpQZuOBRSx4kjlTlSPQyARY8PKiROnVaMHasitDl4RRvBp3MynqLuk/vlntvN49E9ogoE6q/QPG9L9eNbjs5WlD7ysyjvKDPAszY25a4qylnWc/l46COeRNtw3drwW5cCJkmMHKwkQaGDHCQvtSoXtCFWHxySxcJ2FGAxHKnZ5+4u1xWzlcLj36Yp7CIzB1TTuIYu+H56Oxdku7J4gX6WnAPBgpMxjxwSgqc+QiUBac3MKbqjq6JsWj3Ou8WrODJ+PqXcChXzkNOrHwUxTSqUw7Qzgjp2nForA9fAYL9IiZdJGJc4zZVZ9njZrNpKCM86GG0sBF1GEjP6QleIWHtaQnIrJyLlrFA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(19092799006)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzhoTUdZbUNjeEFCQ1M4cisrdHAxQ2NwTi9ZVHUzL0U3bEFRajA2aVN0YnVS?=
 =?utf-8?B?a09zUnpsOVFtUG50Qm4wVXhYTEFLcENEL3JDelplSnUvYS9MVUc4V3ZuVjhB?=
 =?utf-8?B?QisxS3pIdWhMdFh3VkZ5bHhHb205anFnZnN0cE5PTS82dVVXS1c3WVljdVE2?=
 =?utf-8?B?cG5GRzhuSUQrcWF4RDBES0tLcXhDMDQ5dTE5alN3bDlDcno0cSt1VXpPNDE2?=
 =?utf-8?B?ZjRpV2R3U2VoL2s2QWUyZnJnQ2FFR01QSFFIZ200TG1WbWFwWDcwRDNoM0FM?=
 =?utf-8?B?bWRVbnRaT2VTYjhPUFNEMFJBWS9mdUQrcnNGbGNhSnJhUkdBWkJhVVp2UDY2?=
 =?utf-8?B?aDJDem1QbUltbTljdkZNR0JHMURiaU5BZ1g5TjJTSmJtVUc4YTNKN1E2MnM2?=
 =?utf-8?B?VE5XUi9LcEdndXFFYjNDZDkzWitBRWVQNGczS2M3WmhzQ01oNDNRTW84bkov?=
 =?utf-8?B?WnJsWUpMRGRkd1BuNDZnZEd0OHp6b3RYa2Y3UEVRYmpxTVFCRlhrN1VQY2ZM?=
 =?utf-8?B?MWg3Sm5FR1BnUHBadTR4Q0owYUpUbWRCTk1NQWFXZkVtOVQzOGpmMVpydHBk?=
 =?utf-8?B?ZVc4Y1BqY094UEZ6VFRhUEpCeVUxN3BUVDZPeWFuZHRwMkMweHQ2aXp5T1JT?=
 =?utf-8?B?OGh2M2hTWDQxSEI4RXdBRzNOQU1OZFY2SmcvSEZ5ZEthZXkxdC9XbW5xY2VD?=
 =?utf-8?B?L0RYZ3dQaXE0UEdvUWV5ZHFQY1RZcUVxWDBFNW1xSmZPWDBxNmtKdzhnbDNO?=
 =?utf-8?B?bkFhUVZsU0ZORXIyZEo4Sm5kZ0pRZXhYMEtKNWdYQ2xzUmM0UGVKNFB3NzBK?=
 =?utf-8?B?MGhWcFVadnFWT2xRUHhrSnExaHp5SEd0VHVWMFROOFUwY3B4dElWVWZxOUFv?=
 =?utf-8?B?d1UzRkRETGMyMXVuK2Jpb3EwNHdGZ0NSb3dlRWYzK3IxNTUrK0g0dDZJVEZa?=
 =?utf-8?B?SEZFdlpNKysySEdadkF0ci93c0dxWmozT3hGYmVQQnBzTnNHVWtMNHhjZFdv?=
 =?utf-8?B?bE9xbzYxWmpxUXlIMktlU254UEpHMlg4RW5uOCt0cGVRMVh4MHM0bVVneFZB?=
 =?utf-8?B?YkNYclI3aDFuMDlFdHVoYUFkQmc3UzNMQWJONkEydUtYS292SzNndm1lK3o0?=
 =?utf-8?B?eDE0dHJPRjhickR6bG8xSUlHbE1FWHN5c0MyaURtK1lQbE13WDRXWFczR2p0?=
 =?utf-8?B?REplaTQ0Mlc1RERvaEF6dWF3RG94WTlDTVN4UEVsM2dvSEEzZitSVGlGclkx?=
 =?utf-8?B?US96elJFZzA4cWVJbzRGYkl4aFJTU2h5OE5uajBXdDE3Z2lNb2FRNnZWc3Iv?=
 =?utf-8?B?a2ZFeVVaNFJVVlhqdm1jc0NEK0dtOStJVUp3a2hqNVFCdnoveGlweHc4OGhB?=
 =?utf-8?B?VTRRaEovc2pTRXQ2MEJWc0dhMVlHVmdacVJVV25nQXNzZXo1ZmtMSExXVzJj?=
 =?utf-8?B?QlVScVg2ZXYzb2o4Zk5JMUNhTkVqOGc5KzdrbytBNUN6MnpFSitIVFdWYjQx?=
 =?utf-8?B?ZkxOWFI0dUF2NCtNWUxMN2ZIVDE5bmZrbkpGdVJ3USt1SmQ5KzdYUG9uY1Yv?=
 =?utf-8?B?cW1KdnNkVUVXNzJSWkJvRzdLL2htYVAzRVZMQkV5SEczTjJzT3pXbWRCMzV4?=
 =?utf-8?B?SXorSWxXVE1TQm5KNUpVSTBwZUNYRktiTFNtRDI5czNxMVp2UkNBeDkyb21W?=
 =?utf-8?B?ZnJiR1RPMVM1bG1XZUxBdlJEYlZGRFBnRnVXVi8yT1VDd0MrdCtXczFBY3dD?=
 =?utf-8?B?YzZnSnhQM3EzaTNSZ3I0SGVhajlKankvaHNYNjcvSXBrQlBiNEg0UDBRT3pL?=
 =?utf-8?B?L0dEM1cvaWtQeWljZEE4d2hadmZmbVNobGpYUEdNQWlZcWxURThKMloyNDFy?=
 =?utf-8?B?WU5wK2tFWnJSZ2xQdmhCWUVyNnFPa3JaUUp3OG9FdGVyd1NPYlJVcTVZUW1v?=
 =?utf-8?B?UTVjd0J0OHZFNnJnSWNmakJ4ZXp4NWh3NHp1N09CQlFEK2ZiTm5OU0dlSDVa?=
 =?utf-8?B?WUNBK3l6QS9qSW5PV2JZWS9vaWdtU3VpUm9mM2ZsMG52Vm9lK2NOR1dyRGc1?=
 =?utf-8?B?LzlFd2M0cFV0YTRhVXcrT2VoRWxXWENLWGZOM3NwOUJZRzVrUVJNQWNTa2Nk?=
 =?utf-8?B?citvZ1JyckhHU2VnZnMxZFBjaUhReHppRFdrWnBIcHpBS2ZuMTZxdWllQUwr?=
 =?utf-8?B?RkxldnMxeDVsd3FFNWNPa0tqeGZIM3JCTWZjeEQyU3kyQ0xic1VyT0N1QzNP?=
 =?utf-8?B?NkNVb0VZWm8wK2trVFlTb3BTWHlVMnFVbzA1MFVVdkRIcDBFRnVYWnNjNjR0?=
 =?utf-8?B?cC9CTDliWXVyb3ZEUG8vTE5ybXZsNWpnMUlYc1RlSTNhVEY2Mm1OZHBWL1RX?=
 =?utf-8?Q?ef+zLxLvy+ggL0QMvzpVLVJ8DdEVmLBUACBAU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEEC3F187FE012458DEE22917043DB60@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pSxsmbMxfXtm7ClrdErb3xYBQNY/L8XNTMxTRwcg2bYqJJzGW7ActtpUQJUxGlFnb5dP8hEoeb5wkVSmkdQu19R1Ls9C6aS0I6S4NhT6jRUBhV49b2YQTCmsr5OK2slt9tXPjCYYeq1DZTW1c0wLIa/sNrsf9d/RYOsvpanT2DMkjpLki/RYY1gGqSRSDcoMwyuOUeqDkWM8/Ua1LQI1qN7WtG2R+LZilqq6gpZP4uy90PzvXTJ+O2RcNRdU3avZ7KG1OZjHdmLYM/TCpF/bCNKhVjyf8Mto3hyvHnhSafDXlkSCEl6Aj0vgzVhFYa2XwlPdOjV/8RFYo3j1Lauqxg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oOSTbK8R1thO6C1/WRnuu3LWF/g3BekBQzgz0peKQXnLavhQhxy/T8FaEt7Ippjs+VTxUFEtyAUx7IJDUWPXeVtmeb4UnR/lwRtwQKVwNTaxmT3H7vaL7srqP1Rlmxfngotnb4bV32hGtT1lVHHO/f6di71W5oPiwnTbLIYoZDUBUWudsA0o8aYXAN+C0FVZZVaUz+tbBgS6zY18mtUAxdB0gGU1szsdkrmFH8KoT9yy0CycuQ4i8CjSdU8uQrhfpnjafQj0jy8QZBlH/7GjwimfYTNXUUKu+ACqwl96kPekv/FxItSEltkHcJt/5CRjs/QX5H/VJS7c6rPTbzofZTgVfJ0GDr0bagZ8dXtTPBY+prPc8HO33VIuksIRq5y8Ns1BHyaBzWN+c5lerZquJ5e/02mM6a/v1SDORsFUb/c40w64I1CJRL4SMQakI9njm5yw8usRY1M61WCDy0J9P44LPjQvxxxO325hM6blhbpe4Tf2wfDwURE0VjBFn0KKytBl9ZeX7aqPa8OgaZn2DS/5qHW+xp+DPPBB9BypcW3C8DnHE3NWs4Ac1Ayxyn4bR6dR9JyctL/z870tITfm6m6PCV19vu+GkVQ8FilZm+PnrldfMvsyPRQ8aEb9KAj0yTTFnwqFRwbhhVkp/qhIJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b176dd-3462-4352-80bb-08dea455c17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 12:08:55.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjNkmYkjchjbJhgjxzIXOrKozlaZnmmzti1QYbbUEosIZNrVT5XbIu1mdskEv/tvFrGFeREHaDDch5P9gJhzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4594
X-OriginatorOrg: ddn.com
X-BESS-ID: 1777293804-111733-9403-2743-1
X-BESS-VER: 2019.1_20260409.1619
X-BESS-Apparent-Source-IP: 40.107.209.139
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbmlsZAVgZQ0CIxLTHFLMnUNM
	nMKMUwJTUl2cAszcLMwNDUyMTIyDRRqTYWAAh7JFlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272851 [from 
	cloudscan20-119.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNC8yNC8yNiAxNzoyNiwgTHVpcyBIZW5yaXF1ZXMgd3JvdGU6DQo+IE9uIE1vbiwgQXByIDEz
IDIwMjYsIEJlcm5kIFNjaHViZXJ0IHZpYSBCNCBSZWxheSB3cm90ZToNCj4gDQo+PiBGcm9tOiBC
ZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+DQo+Pg0KPj4gUnVubmluZyBiYWNrZ3Jv
dW5kIElPIG9uIGEgZGlmZmVyZW50IGNvcmUgbWFrZXMgcXVpdGUgYSBkaWZmZXJlbmNlLg0KPj4N
Cj4+IGZpbyAtLWRpcmVjdG9yeT0vdG1wL2Rlc3QgLS1uYW1lPWlvcHMuXCRqb2JudW0gLS1ydz1y
YW5kcmVhZCBcDQo+PiAtLWJzPTRrIC0tc2l6ZT0xRyAtLW51bWpvYnM9MSAtLWlvZGVwdGg9NCAt
LXRpbWVfYmFzZWRcDQo+PiAtLXJ1bnRpbWU9MzBzIC0tZ3JvdXBfcmVwb3J0aW5nIC0taW9lbmdp
bmU9aW9fdXJpbmdcDQo+PiAgLS1kaXJlY3Q9MQ0KPj4NCj4+IHVucGF0Y2hlZA0KPj4gICAgUkVB
RDogYnc9MjcyTWlCL3MgKDI4NU1CL3MpIC4uLg0KPj4gcGF0Y2hlZA0KPj4gICAgUkVBRDogYnc9
NjUwTWlCL3MgKDY4Mk1CL3MpDQo+Pg0KPj4gUmVhc29uIGlzIGVhc2lseSB2aXNpYmxlLCB0aGUg
ZmlvIHByb2Nlc3MgaXMgbWlncmF0aW5nIGJldHdlZW4gQ1BVcw0KPj4gd2hlbiByZXF1ZXN0cyBh
cmUgc3VibWl0dGVkIG9uIHRoZSBxdWV1ZSBmb3IgdGhlIHNhbWUgY29yZS4NCj4+DQo+PiBXaXRo
IC0taW9kZXB0aD04DQo+Pg0KPj4gdW5wYXRjaGVkDQo+PiAgICBSRUFEOiBidz00NjZNaUIvcyAo
NDg5TUIvcykNCj4+IHBhdGNoZWQNCj4+ICAgIFJFQUQ6IGJ3PTY0MU1pQi9zICg2NzJNQi9zKQ0K
Pj4NCj4+IFdpdGhvdXQgaW8tdXJpbmcgKC0taW9kZXB0aD04KQ0KPj4gICAgUkVBRDogYnc9NzI5
TWlCL3MgKDc2NE1CL3MpDQo+Pg0KPj4gV2l0aG91dCBmdXNlICgtLWlvZGVwdGg9OCkNCj4+ICAg
IFJFQUQ6IGJ3PTIxOTlNaUIvcyAoMjMwNk1CL3MpDQo+Pg0KPj4gKFRlc3Qgd2VyZSBkb25lIHdp
dGgNCj4+IDxsaWJmdXNlPi9leGFtcGxlL3Bhc3N0aHJvdWdoX2hwIC1vIGFsbG93X290aGVyIC0t
bm9wYXNzdGhyb3VnaCAgXA0KPj4gWy1vIGlvX3VyaW5nXSAvdG1wL3NvdXJjZSAvdG1wL2Rlc3QN
Cj4+ICkNCj4+DQo+PiBBZGRpdGlvbmFsIG5vdGVzOg0KPj4NCj4+IFdpdGggRlVSSU5HX05FWFRf
UVVFVUVfUkVUUklFUz0wICgtLWlvZGVwdGg9OCkNCj4+ICAgIFJFQUQ6IGJ3PTkwM01pQi9zICg5
NDZNQi9zKQ0KPj4NCj4+IFdpdGgganVzdCBhIHJhbmRvbSBxaWQgKC0taW9kZXB0aD04KQ0KPj4g
ICAgUkVBRDogYnc9NDI5TWlCL3MgKDQ1ME1CL3MpDQo+Pg0KPj4gV2l0aCAtLWlvZGVwdGg9MQ0K
Pj4gdW5wYXRjaGVkDQo+PiAgICBSRUFEOiBidz0xOTVNaUIvcyAoMjA0TUIvcykNCj4+IHBhdGNo
ZWQNCj4+ICAgIFJFQUQ6IGJ3PTIzMk1pQi9zICgyNDNNQi9zKQ0KPj4NCj4+IFdpdGggLS1pb2Rl
cHRoPTEgLS1udW1qb2JzPTINCj4+IHVucGF0Y2hlZA0KPj4gICAgUkVBRDogYnc9MzY2TWlCL3Mg
KDM4NE1CL3MpDQo+PiBwYXRjaGVkDQo+PiAgICBSRUFEOiBidz00NzJNaUIvcyAoNDk1TUIvcykN
Cj4+DQo+PiBXaXRoIC0taW9kZXB0aD0xIC0tbnVtam9icz04DQo+PiB1bnBhdGNoZWQNCj4+ICAg
IFJFQUQ6IGJ3PTE0MzdNaUIvcyAoMTUwN01CL3MpDQo+PiBwYXRjaGVkDQo+PiAgICBSRUFEOiBi
dz0xNTI5TWlCL3MgKDE2MDNNQi9zKQ0KPj4gZnVzZSB3aXRob3V0IGlvLXVyaW5nDQo+PiAgICBS
RUFEOiBidz0xMzE0TWlCL3MgKDEzNzhNQi9zKSwgMTMxNE1pQi9zLTEzMTRNaUIvcyAuLi4NCj4+
IG5vLWZ1c2UNCj4+ICAgIFJFQUQ6IGJ3PTI1NjZNaUIvcyAoMjY5ME1CL3MpLCAyNTY2TWlCL3Mt
MjU2Nk1pQi9zIC4uLg0KPj4NCj4+IEluIHN1bW1hcnksIGZvciBhc3luYyByZXF1ZXN0cyB0aGUg
Y29yZSBkb2luZyBhcHBsaWNhdGlvbiBJTyBpcyBidXN5DQo+PiBzZW5kaW5nIHJlcXVlc3RzIGFu
ZCBwcm9jZXNzaW5nIElPcyBzaG91bGQgYmUgZG9uZSBvbiBhIGRpZmZlcmVudCBjb3JlLg0KPj4g
U3ByZWFkaW5nIHRoZSBsb2FkIG9uIHJhbmRvbSBjb3JlcyBpcyBhbHNvIG5vdCBkZXNpcmFibGUs
IGFzIHRoZSBjb3JlDQo+PiBtaWdodCBiZSBmcmVxdWVuY3kgc2NhbGVkIGRvd24gYW5kL29yIGlu
IEMxIHNsZWVwIHN0YXRlcy4gTm90IHNob3duIGhlcmUsDQo+PiBidXQgZGlmZmVybmNlcyBhcmUg
bXVjaCBzbWFsbGVyIHdoZW4gdGhlIHN5c3RlbSB1c2VzIHBlcmZvcm1hbmNlIGdvdmVub3INCj4+
IGluc3RlYWQgb2Ygc2NoZWR1dGlsICh1YnVudHUgZGVmYXVsdCkuIE9idmlvdXNseSBhdCB0aGUg
Y29zdCBvZiBoaWdoZXINCj4+IHN5c3RlbSBwb3dlciBjb25zdW1wdGlvbiBmb3IgcGVyZm9ybWFu
Y2UgZ292ZW5vciAtIG5vdCBkZXNpcmFibGUgZWl0aGVyLg0KPj4NCj4+IFJlc3VsdHMgd2l0aG91
dCBpby11cmluZyAod2hpY2ggdXNlcyBmaXhlZCBsaWJmdXNlIHRocmVhZHMgcGVyIHF1ZXVlKQ0K
Pj4gaGVhdmlseSBkZXBlbmQgb24gdGhlIGN1cnJlbnQgbnVtYmVyIG9mIGFjdGl2ZSB0aHJlYWRz
LiBMaWJmdXNlIHVzZXMNCj4+IGRlZmF1bHQgb2YgbWF4IDEwIHRocmVhZHMsIGJ1dCBhY3R1YWwg
bnIgbWF4IHRocmVhZHMgaXMgYSBwYXJhbWV0ZXIuDQo+PiBBbHNvLCBuby1mdXNlLWlvLXVyaW5n
IHJlc3VsdHMgaGVhdmlseSBkZXBlbmQgb24sIGlmIHRoZXJlIHdhcyBhbHJlYWR5DQo+PiBydW5u
aW5nIGFub3RoZXIgd29ya2xvYWQgYmVmb3JlLCBhcyBsaWJmdXNlIHN0YXJ0cyB0aGVzZSB0aHJl
YWRzDQo+PiBkeW5hbWljYWxseSAtIGkuZS4gdGhlIG1vcmUgdGhyZWFkcyBhcmUgYWN0aXZlLCB0
aGUgd29yc2UgdGhlDQo+PiBwZXJmb3JtYW5jZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZXJu
ZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+DQo+PiAtLS0NCj4+ICBmcy9mdXNlL2Rldl91
cmluZy5jIHwgMTQgKysrKysrKysrKystLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kZXZf
dXJpbmcuYyBiL2ZzL2Z1c2UvZGV2X3VyaW5nLmMNCj4+IGluZGV4IGU2ODA4OWJhYmFmODlmYjgx
NzQxZTRhNWU2MDVjNmUzNmExMzdmOWUuLmVkMDYxZTIzOWI4ZWQ3MGZmMzZkZWI1MWRkNjk1N2Zl
MTcwNGVjODcgMTAwNjQ0DQo+PiAtLS0gYS9mcy9mdXNlL2Rldl91cmluZy5jDQo+PiArKysgYi9m
cy9mdXNlL2Rldl91cmluZy5jDQo+PiBAQCAtMTMwNiwxMyArMTMwNiwyMSBAQCBzdGF0aWMgdm9p
ZCBmdXNlX3VyaW5nX3NlbmRfaW5fdGFzayhzdHJ1Y3QgaW9fdHdfcmVxIHR3X3JlcSwgaW9fdHdf
dG9rZW5fdCB0dykNCj4+ICAJZnVzZV91cmluZ19zZW5kKGVudCwgY21kLCBlcnIsIGlzc3VlX2Zs
YWdzKTsNCj4+ICB9DQo+PiAgDQo+PiAtc3RhdGljIHN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKmZ1
c2VfdXJpbmdfc2VsZWN0X3F1ZXVlKHN0cnVjdCBmdXNlX3JpbmcgKnJpbmcpDQo+PiArc3RhdGlj
IHN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKmZ1c2VfdXJpbmdfc2VsZWN0X3F1ZXVlKHN0cnVjdCBm
dXNlX3JpbmcgKnJpbmcsDQo+PiArCQkJCQkJICAgICAgIGJvb2wgYmFja2dyb3VuZCkNCj4+ICB7
DQo+PiAgCXVuc2lnbmVkIGludCBxaWQ7DQo+PiAgCWludCBub2RlOw0KPj4gIAl1bnNpZ25lZCBp
bnQgbnJfcXVldWVzOw0KPj4gIAl1bnNpZ25lZCBpbnQgY3B1ID0gdGFza19jcHUoY3VycmVudCk7
DQo+PiAgDQo+PiArCS8qDQo+PiArCSAqICBCYWNrZ3JvdW5kIHJlcXVlc3RzIHJlc3VsdCBpbiBi
ZXR0ZXIgcGVyZm9ybWFuY2Ugb24gYSBkaWZmZXJlbnQNCj4+ICsJICogIENQVSwgdW5sZXNzIENQ
VXMgYXJlIGFscmVhZHkgYnVzeS4NCj4+ICsJICovDQo+PiArCWlmIChiYWNrZ3JvdW5kKQ0KPj4g
KwkJY3B1Kys7DQo+PiArDQo+IA0KPiBUaGUgcGVyZm9ybWFuY2UgbnVtYmVyIGxvb2sgZ3JlYXQs
IGJ1dCBJIHdhcyB3b25kZXJpbmcgaWYgeW91IGdldCBzaW1pbGFyDQo+IGltcHJvdmVtZW50cyBm
b3Igd3JpdGUgb3BlcmF0aW9ucy4NCg0KSSBkaWRuJ3QgdGVzdCB5ZXQsIGJ1dCB0aGlzIGlzIHN0
aWxsIGRpcmVjdC1pbyAtIHdoYXQgd291bGQgYmUgdGhlDQpkaWZmZXJlbmNlIGZvciB3cml0ZXMg
aGVyZT8NCg0KPiANCj4gQWxzbywgaXNuJ3QgJ2NwdSsrJyB0b28gYXJiaXRyYXJ5PyAgSSBtZWFu
LCBpc24ndCB0aGVyZSBzb21lIGhldXJpc3RpY3MNCj4gdGhhdCBjb3VsZCBiZSB1c2VkPyAgSSB1
bmRlcnN0YW5kIHRoZSBnb2FsIGlzIGp1c3QgdG8gcHVzaCB0aGUgcmVxdWVzdA0KPiBzb21ld2hl
cmUgZWxzZSwgYnV0IGRvZXMgaXQgbWFrZSBzZW5zZSB0byBwdXNoIGl0IHRvIHRoZSBuZXh0IGNw
dSBvbiB0aGUNCj4gc2FtZSBub2RlPyAgT3IgdG8gdGhlIG5leHQgY3B1IGluIGEgZGlmZmVyZW50
IGNvcmU/ICBJJ20ganVzdCB0aGlua2luZyBvdXQNCj4gbG91ZCwgYW5kIG1heWJlIHRoaXMgaXMg
bm9uLXNlbnNlIDstKQ0KDQpNeSB0aGlua2luZyBpcyB0aGF0IHRoZSBzY2hlZHVsZXIgd2lsbCB0
YWtlIGNhcmUgb2YgaXQgYW5kIG1vdmUgdGhlIHRhc2sNCnRoYXQgaXMgcnVubmluZyBvbiBjcHUx
LCBpZiB0aGVyZSBpcyBhbnkuIEluIHByaW5jaXBsZSB3ZSB3b3VsZCBuZWVkIHRvDQpoYXZlIGhl
bHAgZnJvbSB0aGUgdGFzayBzY2hlZHVsZXIgaGVyZSB0byBwcm92aWRlIGFub3RoZXIgY3B1Lg0K
DQo+IA0KPiBGaW5hbGx5LCBzaG91bGRuJ3QgdGhpcyBiZWhhdmlvdXIgYmUgYmVoaW5kIHNvbWUg
a25vYj8gIE1heWJlIGl0J3MNCj4gb3Zlci1jb21wbGljYXRpbmcgZm9yIG5vIGdvb2QgcmVhc29u
LCBidXQgYmVpbmcgYWJsZSB0bzogMSkgZW5hYmxlL2Rpc2FibGUNCj4gaXQsIDIpIGVuYWJsZSBi
eSBwdXNoaW5nIGl0IHRvIHRoZSBuZXh0IGNwdSAodGhpcyBiZWhhdmlvdXIpLCAzKSBlbmFibGUg
YnkNCj4gcHVzaGluZyB0byB0aGUgbmV4dCBjcHUgb24gdGhlIHNhbWUvZGlmZmVyZW50IG5vZGUs
IGV0Yy4NCg0KDQpJIHRoaW5rIGFueSBmdXJ0aGVyIGNvbXBsZXggbG9naWMgc2hvdWxkIGdvIGlu
dG8gdXNlcnNwYWNlLiBXZSBuZWVkIHRvDQp0cnkgb3V0IHRvIG92ZXJyaWRlIHRoZSBmdW5jdGlv
biB3aXRoIGVCRlMgZnJvbSBsaWJmdXNlLiBJIGRvbid0IHRoaW5rDQppdCBtYWtlcyB0b28gbXVj
aCBzZW5zZSB0byBhZGQgdmVyeSBjb21wbGV4IGxvZ2ljIGFuZCBzZXR0aW5ncyBpbnRvDQprZXJu
ZWwgY29kZSAtIHdlIGNhbiBzZWUgdGhhdCB0aGUgcGF0Y2hlcyBoYXZlIGFkdmFudGFnZXMgLSB3
aGF0IHNwZWFrcw0KdG8gdGFrZSBpdCBhcyBpdCBpcz8gV2l0aCB0aGUgZXhjZXB0aW9uIHRoYXQg
ZnVzZV91cmluZ19zZWxlY3RfcXVldWUoKQ0KbmVlZHMgdG8gcmV0dXJuIGFuIGludGVnZXIgKHFp
ZCkgdG8gbWFrZSBpdCBlQlBGIG92ZXJyaWRhYmxlLg0KDQpNeSBwZXJzb25hbCBpc3N1ZSBoZXJl
IGlzIHJhdGhlciBzaW1wbGUsIEkgd2FzIGJhc2ljYWxseSB3b3JraW5nIGFsbA0Kd2Vla2VuZCB0
aHJvdWdoIHdpdGggZGlmZmVyZW50IHRoaW5ncyAoYXMgdGhlIHBhc3Qgd2Vla2VuZHMpIGFuZCBu
byBlbmQNCmluIHNpZ2h0ICgxIGRheSBwZXIgd2VlayBpcyBjb250cmFjdG9yIHdvcmsgZm9yIERE
TikuIFNldmVyYWwgcmVwb3J0cw0KYW5kIHJlcG9ydGVkIGlzc3VlcyBpbiBsaWJmdXNlIGFyZSB3
YWl0aW5nLg0KQWZ0ZXIgd29ya2luZyB0aGUgcmF0aGVyIGxhcmdlIHN5bmMgRlVTRV9JTklUIGZv
ciBzZWxpbnV4IG5leHQgY29tZXMgdG8NCmFkZCBhIGdlbmVyaWMgaW50ZXJmYWNlIHRvIGxpYmZ1
c2UgaW8taW9yaW5nIGZvciBjb3JvdXRpbmVzIC0gSSBkb24ndA0KaGF2ZSB0aGUgdGltZSB0byBz
ZXZlcmVseSBjaGFuZ2UgdGhlIGxvZ2ljIG9mIHJlZHVjZWQgcXVldWVzIGFuZCBhZGRpbmcNCmtu
b2JzLiBCZXNpZGVzIHRoYXQgRlVTRV9JTklUIGFsbW9zdCBydW5uaW5nIG91dCBvZiBzcGFjZS4N
Cg0KVGhhbmtzLA0KQmVybmQNCg0KDQo=
