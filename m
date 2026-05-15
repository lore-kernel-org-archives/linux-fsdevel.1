Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77580487BE;
	Fri, 15 May 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879456; cv=fail; b=XmQu5fpOmtHftnHOXZx3qlpvfeJz4DsrFxAaQmO+KW0g7WWNUjMglqABZD6+ViwgV343sIbwmgcqPfEXT23bHtNm7WoAw0uEQM5W9qMjMHYftN0cjDLkK1wQqIpD8rT+TKT6fNNOAQKIJ6vWHKatvlc1J2oHods728liPiBNjGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879456; c=relaxed/simple;
	bh=RXB9bk1s48cTdqZ3fI2XDXdD87GdpUAMFrvGYJ5TPlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5NcMjubMf9S4PgLKsZ5zdnyoG6GQ9GZB5vrK6gdWekGaaLezZd9ksNaM3LogIL50sLC+cRDsDkncN1Ur0S3xbg8ZLvPVg5fHtExLUvEKNhzQO9tuYQ/FMn6uvONy+FqMZtg5n24T8Entiy87HTLarG7XkFtlPZMvcZQkTWFyuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TWbCp5pS; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TWbCp5pS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAbkLZ574813;
	Fri, 15 May 2026 21:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=RXB9bk1s48cTdqZ3fI2XDXdD87GdpUAMFrvGYJ5TPlo=; b=TWbCp5pS
	IgTsgbkvelgPGksu7W7jCtZHo+GVpYXPCS6Ahqc7Ly3WeNCyjkLwekcrRsB1lBva
	JwyAEEhi3W/tF1J8RO/+pb1kZ56txxk2M6QvSah0ANPy2MnM96yNgofOFBoRGxig
	Utjdij0ZDRuoSQxmn3X716XGuePG9IKIs56a3TikCSJLdiyPES96KXUIhUT3USWh
	GukkeANlasQI+45x4uvreAiRY1id3ZLyEIyL4UDYvPa+MHTUVBUc1uU3c4uYddTb
	OTJiKpTIUppZSVKM0A1A2OSkBCu3tLhctVyEYguTRzE2I8NAZ4eda77utpoTfcEB
	yoIvKTVcU1zDsA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m92n2uf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 21:10:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR/kDH9fCmRvW8nThD0LweFuH9aqkN07u2eANXdg50QA9lxgwhj4DMODs1yt09BVyME6ML/5jCVBGFeG2Z6evMAEmplYy66UphQ33lTD0XAdyiwkhxpojrW7JmSe8a0ORSnvw2s4L+2E9GwO6y28egx4mkYTDrRwx7C6QhpCsfyuxSy2t4rLQ+aOCgziGvxUxE7UKvdDc1L38emN1HeyFoR40E9x0njkU3/cjuJ/jRiiLq3iRMZ9tdNA4XFANh8xUWXdoRdF3r3eLCMBNABPIyN6viomunxSdyv99PtJNQL3Vgv1e47Lt5EAX15Ljq5EyD1OzVIgd0XZWP3OpwvQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXB9bk1s48cTdqZ3fI2XDXdD87GdpUAMFrvGYJ5TPlo=;
 b=heinmJ++fh5iKUN3QS2zsyQTIsTCe4dIIY1v77lv4wiUE9MyzWsHjlQZWABIqc2jbU+mnBDINsRXaqTn+yoyPTbaJlNyVU++VysxpNnga+G5hDhESgXLk7VrM4xzSgKie2+BCL1A91CKasaiK9+5A1SXOegGt3bITmx0S/nsZ5YC7r7H6UomOKzANROH+piqI9A9cGdk9vby9aeUyrSUJEpBDkd/v33k4tXmT1PO+EBKJGr/JsQSh+sG5+jpGXZIDlCa45WZkCo1r7An1N6eFAvcBzhoM3NqeXzUVINq6nY4fla+jFUirvgK4Porac9leqZpESNNZpTl10ob7TLPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB6179.namprd15.prod.outlook.com (2603:10b6:510:24a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 21:10:27 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 21:10:27 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7] hfs: validate record ID against requested CNID in
 hfs_cat_find_brec()
Thread-Topic: [PATCH v7] hfs: validate record ID against requested CNID in
 hfs_cat_find_brec()
Thread-Index: AQHc5K9AOkKw6k+WEkaNqrLCblW2gg==
Date: Fri, 15 May 2026 21:10:27 +0000
Message-ID: <5ff5f107e5a8588367b3af77748369c166f16cc7.camel@ibm.com>
References: <20260311211309.27856-1-contact@gvernon.com>
	 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
	 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
	 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
	 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
	 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
	 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
	 <abnzsVk9JNN3alKq@Bertha>
	 <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
	 <absr9g7LaMEHfw47@Bertha>
	 <f84ae595-a084-4ded-9f99-964752a69f7d@I-love.SAKURA.ne.jp>
	 <070d92639460b672a174d6a11b1e7d0b099b18cb@gvernon.com>
	 <9f66743b-70e0-4886-884e-5203f5c02ed8@I-love.SAKURA.ne.jp>
	 <c80f3c36-4c66-4e51-ab3e-e83d37b60131@I-love.SAKURA.ne.jp>
In-Reply-To: <c80f3c36-4c66-4e51-ab3e-e83d37b60131@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB6179:EE_
x-ms-office365-filtering-correlation-id: 0b74f025-6b24-434c-ad2f-08deb2c6634e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|56012099003|22082099003|18002099003|38070700021|11063799003|4143699003;
x-microsoft-antispam-message-info:
 ittM0b+2z3SQRNrDAJoGohZzbaB2zcnytNu02nsygqa23/+O+ZeROaebZVaH0aqHDLyNJlgMGkgIzH19gLhhsSboy1vF64gKvF92X7ynxlGf5tei1gqKzC4nFZvH7+M/9RiiEOIuWP4ZCiDlQS7enInz/3lCfOOtVDHOoVKmLQUrrZelHfuvNYWH+W608TeK/MSprvg9tuTNhRZjvfigeRoMuCHr+nIK47LoFVPfXHNEstIrLPSRGf//YZRFpRZ6y2uRJMrxWsRnqt/E6FTEbAFDG5naOztA5tIHZydWSzNFGZPuf4be5ZPAfQU0/Uy8J1tutKW1QNlUKvJm66mSc4p0VnW9dIFP2hT14IGLTR047NRvnp3VsWDxej6gw7Myi7Yru3qyNN5mjHOUz6zlYNRM3iGjo2nIcBpzxhVmHpgqCDtRmIpVY9e9BzhHk65WHlfFV807HGYNrMtI289ltpb/aCs3WXoi08GNdsqEl1mfPKe7W/RVUSe5eXl9VKL47V21i4QK2Ct2jeoBDShJA5w8mMpSzou6BJbY44eWuVWf+YifkPvhJB5LnFqWMieomLp+F0n2oVryI7e2Sm4sFllPh3GbVafM++nBAmiPHP0bDIUwQAZim+mLaSpTG6zk9eyIPTiYVFOa+QlZSZ+Q3coE1M6wdvETSPjcB+/yuimpXiCMSQwPpNt08D5rQ39MrNk5NBnLF9kYwvNpQqCM0w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(22082099003)(18002099003)(38070700021)(11063799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVRGblFQQ2ZMS3NTcTc1UldKbkN3Y1UxNmd4SHk4WlNKZGt1TGd1S1BaYnl1?=
 =?utf-8?B?OFRYdlduYUdiNTJySGV0L1gvUDhWTmV5eW9iOGpBUXN5NDNoSHl2eE0vbk1G?=
 =?utf-8?B?Z09GVithY2lyTkQvd0VJakhyQVFmSDZ3VU1GY1lPM01aK3llOE83OUpieVQr?=
 =?utf-8?B?VFZrWE9RTUhnSU52Z0pPK3N2dC9kZCtWNGhackw4dG9LeFh3NUxBMTJRRi8y?=
 =?utf-8?B?WGxWL2E3UjBhTkV0M3JLNit2V1d2RGwzUnRTWlVpQjVOZjhBVlRMSHZVM2Jy?=
 =?utf-8?B?QUlMck9YTDE3YkxJZFR1NXA1dlh1bFBaWGxIc1hwcmRPWGljSFF0dEU4dVFX?=
 =?utf-8?B?K0xnQm9MU3lucDZKcjlKVnVtdGRvSGhtZlJYb0cwYWpDZTRCdFFadHMvSkRP?=
 =?utf-8?B?Q1NPTE01SDZVeGNEUUN6Y3poT2gxQ2UxUGtNQ2trUFB3b1dLQStJc3NLUXVQ?=
 =?utf-8?B?c1IvWXVtS20weDEzVGxmOFpMR05Ma2paVC9vUExYdmlZa3pUVkE0bkNCQ0kx?=
 =?utf-8?B?TWJ1aHZIY0pmaVRvZ3pOZnNIQ2p6TjRVcElYVlBkLzBoWVB1UHp5ZXk1eEFt?=
 =?utf-8?B?dFJVQWl1WlFYdDV3Q00yWGNzWS9MOUZqcndkVkRiNDlaVDU0T1FSWmZOV1Vr?=
 =?utf-8?B?Z0gvTEVMbm1oVVVkQm05Qy9BYm1aQzNEWXpMT0NJenkyWUYyRTE4QVkxQUtt?=
 =?utf-8?B?ZFU5MW5IK2Z2dkVzWTdGRlhhZ2gza1RTN1VHYUcwRkNaMTNLRzlXL1F4WEha?=
 =?utf-8?B?MXV4dGZoM1EybkV1bkFaWXRBcURGd0pkRityeU4yTU0wbllGKzVLQkhKWmxG?=
 =?utf-8?B?SUFvbkgyL2tSenpkdUs1QmxaTXV4TXdtYlJXUzFNNVBMdGJBVDhvazdvdVll?=
 =?utf-8?B?L1BTYXk5Sjk5VDUwSjFFVlRRZi9ObThzd1VhenlMaVRHR2F0cW83cGducCtH?=
 =?utf-8?B?RDJiSXhIenVzWW1jdkFGVHphUE5qS2licEN3b2FRbVFqRmpBMEJ3MHVOMERM?=
 =?utf-8?B?djM1dTcvVWZyVUhMcTRMeS9HSlhMdzRRYWF1aWd2QVhLMnpNN1kwL21PV0Nj?=
 =?utf-8?B?QmhYZC9OMURsL1RlbmNuaThYYnBOaVNHd1U2YU5HaGZteWNCOGJQNmx2ejg3?=
 =?utf-8?B?eTkrTXA5NEw4TVM1NmRlZ3pkZWdaNUZQN0d0NVFwL0F3eVhRSkVhbVNmbnJS?=
 =?utf-8?B?dDVJQjZsVEQ1N08yTCtCTXdsejN5TUVjeFEvenZzYWVONlJkaVhnNnVRR2tM?=
 =?utf-8?B?QXBhTUJIQVNHNmRQMURFNmErWURaK1ZndERhelg2YWFJekh1UHd2QW1hYnZy?=
 =?utf-8?B?NW5YNkg3eFRVVlQzZko4cFNrT3JIWkpuYUJReHB3RElTZWRranFnMkxqdXZE?=
 =?utf-8?B?eldnQ0ZMSk5iS0xhMG55MjkvNDVjK3FKOG83SlkralBacWJ2dUtqQnNyNEZr?=
 =?utf-8?B?ZWZGQitDRjF2bmN1eGsrRWhmRTdVbkFQM3lQMEt6UXRhcmRNZ1Rrb1VOQVFn?=
 =?utf-8?B?SzN4cCtTak5WenlwRFFnQmptMk8wdlZkTDc3aEw3TElYdlAwSHNNNWZuRklT?=
 =?utf-8?B?N0tyQkRHTUQ0eE9TZWxPUHo3eGswcUxOaXE4bkJCTUI2aDF5bDQxdDBXVEhW?=
 =?utf-8?B?eHBnOEE2NGlWdVpWeHdld1pLNTZ3Z1FTcGNKc0dmenN6L3hCN29UUCttNWth?=
 =?utf-8?B?L09KUW5NellUNElsZFpxMCtRd1BVWFl6d3E3dHdDQ04veXovWFFxK05nK0xp?=
 =?utf-8?B?NzhvSFBQRU5zYy9Ndm9GQUtCTUtsRlRpLzlYa2FRNXBzbk1qbEhSMmNhdXpZ?=
 =?utf-8?B?MU95WnFES25KWDZpZHNsM3VOVFY3STQ4ZVNoWFFXOWI4ZmlnOTlZUFNCMUha?=
 =?utf-8?B?T1c1ME4rT2ZwVEZ6NGcxM0pSakxWb2NQMmVmYThLQ2JpNEdtK21iQ3FIa3Bp?=
 =?utf-8?B?U0d2TklDVmluZDhQNWI1K01SbzBiRGgrbVdzOVdHN0RvaGNIaWhtRHNzQkJ2?=
 =?utf-8?B?TUcrZmN2MUdnakkyUng2dHRDSmtybURFNTNraWg3MFJqK1A1RHkwTGIvVDlP?=
 =?utf-8?B?dDBtYkVoclA1U21yR2FHVjdZRmJXb0xTNGc4WVdYbG5GWHNQK1BiTW1FcHdh?=
 =?utf-8?B?WGk5THRwNHB5OFFYUk5TRWJrUkZlUjhFRkphTlV4SVB4Y1d0bGFhWlhHOUx3?=
 =?utf-8?B?aVc5Y2U2dzB1ZzdPRytHT1dJM1d6MUEwSm5kSk5NTHhRL0cyZVFwNjFLRWk4?=
 =?utf-8?B?dVZDVGM1NkpnYzd1V0tYeGp4czBrSUNneklVWTJQMDMwWDloekNQczZVcUU0?=
 =?utf-8?B?R25DaERyRGU0cG1iUTFrSmpUTXB2VXphaVNqVDV2WlV3cnV5MUJ3Yzk1NjBa?=
 =?utf-8?Q?psDErwtkHe08qPmtqYkSfr5SyFB+Eg0KFgNLi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D10852A8FD7B594D887D6CB790374E98@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	d1Fc2eF+kgM/7S/rSenbPQrW593w+mWGUlxblenvgI3y7ga2XjJfuQR2kY1IZb++AySFL+1drPY2ovGagUPzUbNYBb4h88AWQzghJl0bMxLrAX9lrMyZwg2Jk2WPgobxBFxLjvIMVI91Da0iobyxpYd69c/XFk1E6hrJkzvR4yd61BohJsdJdHqFtMayhLJ0ecbz7EH50Ifh7qE/8qO5EeEyFAwKdZckKu/XDo8eYai1hXf4IHG8FC2qN+JtWdIL0CzPRq1HWTgeXmHUiYgKr8w7XEvlgQaQCftVoiwB1+V0JqMKs3lUMnpbe7NcFjdJMeILNXsS87XWb9r0Dju9kQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b74f025-6b24-434c-ad2f-08deb2c6634e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 21:10:27.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghkapyKQfknSTczyInLmzUj4wFPPdtDDH9E8u1yfCRhOVosif3rNNEAzB2Gg21T6rB9fZgz1cNegvVHF8fkPxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIxMiBTYWx0ZWRfX58qLqPCX4h/7
 aQQE3Mou+tqsq8/Sj3GQx3E7480GKE4Zf0qRl9l2ttSMIamMx6OGGNnNb6SBSqsqlrSckHEdFdk
 vpOyAS0HyRV0kElG2ns3SiL38JJiNAHBqZTjkSUvYc0sbnYmwnwFSIZyvj8k6t/nwu8Sn4BzHm9
 ZCYoMkj+RT4BL3mmN/Tqrd8rJtqaJIwOSqAPYHCkX/wHEKEZZvAxiPUPhfNGPHEd3JAYt1f3tXJ
 1NpXGBRCzg7XftVOzpA2dMYTXWfo3XPDCI76PjFT4YVigS6kpwCs8PymqDRQ8v+TpPKeeFQkALF
 aFgMyndHE0Z6q0dNMZfW54Au/frupfW/tLYFj+9lVUK4znALDBd7mbEft83EBy3Px96Cszz1FhE
 bYX+ku7sMRq6K1h9L+faHk8y92bS2p8Ri4f3jlWLkKAa4KaCe3nmwSeij4FqAMtCsNyur1BiQWw
 g4AEnoqRnuXduPXsiXA==
X-Proofpoint-ORIG-GUID: rrAGRWWBfL1s32ne893tdsyabqTj7ayJ
X-Authority-Analysis: v=2.4 cv=aNnAb79m c=1 sm=1 tr=0 ts=6a078bcd cx=c_pps
 a=uwUl5xS/OuIXHPkYzYKLCw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=P-IC7800AAAA:8 a=6fMgnlLFsNLh-IYJOZcA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: rrAGRWWBfL1s32ne893tdsyabqTj7ayJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150212

T24gVGh1LCAyMDI2LTA1LTE0IGF0IDE2OjM0ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IHN5emJvdCBpcyByZXBvcnRpbmcgdGhhdCBCVUcoKSBpbiBoZnNfd3JpdGVfaW5vZGUoKSBmaXJl
cyB1cG9uIHVubW91bnQNCj4gb3BlcmF0aW9uIHdoZW4gdGhlIGlub2RlIG51bWJlciBvZiB0aGUg
cmVjb3JkIHJldHJpZXZlZCBhcyBhIHJlc3VsdCBvZg0KPiBoZnNfY2F0X2ZpbmRfYnJlYyhIRlNf
Uk9PVF9DTklEKSBpcyBub3QgSEZTX1JPT1RfQ05JRCwgZm9yDQo+IGNvbW1pdCBiOTA1YmFmZGVh
MjEgKCJoZnM6IFNhbml0eSBjaGVjayB0aGUgcm9vdCByZWNvcmQiKSBjaGVja2VkDQo+IHRoZSBy
ZWNvcmQgc2l6ZSBhbmQgdGhlIHJlY29yZCB0eXBlIGJ1dCBkaWQgbm90IGNoZWNrIHRoZSBpbm9k
ZSBudW1iZXIuDQo+IA0KPiBJbml0aWFsbHksIFZpYWNoZXNsYXYgRHViZXlrbyB3YXMgYXNzdW1p
bmcgdGhhdCB3ZSBjYW4gZml4IHRoaXMgcHJvYmxlbQ0KPiBieSBhZGRpbmcgdmFsaWRhdGlvbiB0
byBoZnNfcmVhZF9pbm9kZSgpLCBhbmQgR2VvcmdlIEFudGhvbnkgVmVybm9uIGlzDQo+IHByb3Bv
c2luZyBhIHBhdGNoIHRoYXQgYWRkcyB2YWxpZGF0aW9uIHRvIGhmc19yZWFkX2lub2RlKCkuDQo+
IA0KDQpXZSBjYW4gZml4IHRoZSBwcm9ibGVtIGluIGJ5IGFkZGluZyB2YWxpZGF0aW9uIHRvIGhm
c19yZWFkX2lub2RlKCkuDQoNCj4gV2hpbGUgSSBhbSBub3QgYWdhaW5zdCBhZGRpbmcgdmFsaWRh
dGlvbiB0byBoZnNfcmVhZF9pbm9kZSgpLCB0cmVhdGluZw0KPiBhbiBpbm9kZSB3aGljaCBpcyBu
b3QgdGhlIHJvb3QgaW5vZGUgYXMgaWYgdGhlIHJvb3QgaW5vZGUgaXMgYSBsb2dpY2FsDQo+IGVy
cm9yIHdoaWNoIHNob3VsZCBiZSByZWplY3RlZCByZWdhcmRsZXNzIG9mIHdoZXRoZXIgd2UgaGl0
IEJVRygpIG9yIG5vdC4NCj4gQW5kIHdlIGNvbmZpcm1lZCB0aGF0IHdlIGNhbid0IGZpeCB0aGlz
IGxvZ2ljYWwgZXJyb3IgYnkgYWRkaW5nIHZhbGlkYXRpb24NCj4gdG8gaGZzX3JlYWRfaW5vZGUo
KS4NCj4gDQoNCldlIGhhdmVuJ3QgY29uZmlybWVkIGl0LiBUaGUgaXNzdWUgY2FuIGJlIGZpeGVk
IGJ5IGFkZGluZyB2YWxpZGF0aW9uIHRvDQpoZnNfcmVhZF9pbm9kZSgpLg0KDQo+IFNpbmNlIGhm
c19icmVjX3JlYWQoKSBkb2Vzbid0IHJlY2VpdmUgd2hpY2ggdHlwZSBvZiBzdHJ1Y3QgKG9uZSBv
ZiAic3RydWN0DQo+IGhmc19jYXRfZmlsZSIsICJzdHJ1Y3QgaGZzX2NhdF9kaXIiIG9yICJzdHJ1
Y3QgaGZzX2NhdF90aHJlYWQiKSBkb2VzIHRoZQ0KPiBjYWxsZXIgb2YgaGZzX2JyZWNfcmVhZCgp
IHdhbnQgdG8gcmVhZCBhcyBmdW5jdGlvbiBhcmd1bWVudCwgY3VycmVudGx5DQo+IGl0IGlzIGlt
cG9zc2libGUgZm9yIGhmc19icmVjX3JlYWQoKSB0byByZXR1cm4gMCBvbmx5IHdoZW4gdGhlIHJl
dHJpZXZlZA0KPiByZWNvcmQgaXMgd2hhdCB0aGUgY2FsbGVyIHdhbnRzLCBkZXNwaXRlIHRoZSBI
RlMncyBvbi1kaXNrIGxheW91dCBpbmNsdWRlcw0KPiB0eXBlIG9mIHN0cnVjdCB3aXRoaW4gdGhl
IHJldHJpZXZlZCByZWNvcmQuDQoNClRoZSBoZnNfYnJlY19yZWFkKCkgaXMgY2FsbGVkIHdpdGgg
YXJndW1lbnRzIFsxXToNCg0KaW50IGhmc19icmVjX3JlYWQoc3RydWN0IGhmc19maW5kX2RhdGEg
KmZkLCB2b2lkICpyZWMsIHUzMiByZWNfbGVuKTsNCg0KU28sIHdlIGhhdmUgdm9pZCAqcmVjIGFz
IGEgYnVmZmVyIGZvciByZWFkLiBUaGUgaGZzX2JyZWNfcmVhZCgpIGlzIGNhbGxlZCB0bw0KZXh0
cmFjdCB0aGUgYi10cmVlIHJlY29yZCwgZm9yIGV4YW1wbGUgWzItNF06DQoNCmludCBoZnNfY2F0
X2ZpbmRfYnJlYyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1MzIgY25pZCwNCgkJICAgICAgc3Ry
dWN0IGhmc19maW5kX2RhdGEgKmZkKQ0Kew0KCWhmc19jYXRfcmVjIHJlYzsNCg0KPHNraXBwZWQ+
DQoNCglyZXMgPSBoZnNfYnJlY19yZWFkKGZkLCAmcmVjLCBzaXplb2YocmVjKSk7DQoJaWYgKHJl
cykNCgkJcmV0dXJuIHJlczsNCg0KPHNraXBwZWQ+DQp9DQoNClNvLCB0aGUgZ29hbCBvZiB0aGlz
IGZ1bmN0aW9uIGlzIHRvIGV4dHJhY3QgdGhlIGhmc19jYXRfcmVjIFs1XToNCg0KLyogQSBjYXRh
bG9nIHRyZWUgcmVjb3JkICovDQp0eXBlZGVmIHVuaW9uIGhmc19jYXRfcmVjIHsNCglzOCB0eXBl
OwkJCS8qIFRoZSB0eXBlIG9mIGVudHJ5ICovDQoJc3RydWN0IGhmc19jYXRfZmlsZSBmaWxlOw0K
CXN0cnVjdCBoZnNfY2F0X2RpciBkaXI7DQoJc3RydWN0IGhmc19jYXRfdGhyZWFkIHRocmVhZDsN
Cn0gaGZzX2NhdF9yZWM7DQoNCkl0IGlzIHBvc3NpYmxlIHRvIHNlZSB0aGF0IGhmc19jYXRfcmVj
IHN0YXJ0cyBmcm9tIHR5cGUgZmllbGQgWzZdLiBUaGlzIHR5cGUNCmZpZWxkIGNhbiBiZSBjaGVj
a2VkIHRvIG1ha2UgYSBjb25jbHVzaW9uIHdoaWNoIHR5cGUgb2YgcmVjb3JkIHdhcyByZWFkIGJ5
DQpoZnNfYnJlY19yZWFkKCkuIFRlY2huaWNhbGx5IHNwZWFraW5nLCB3ZSBjYW4gY2hhbmdlIHZv
aWQgKnJlYyBvbiBoZnNfY2F0X3JlYw0KKnJlYzoNCg0KaW50IGhmc19icmVjX3JlYWQoc3RydWN0
IGhmc19maW5kX2RhdGEgKmZkLCBoZnNfY2F0X3JlYyAqcmVjLCB1MzIgcmVjX2xlbik7DQoNCm9y
IHdlIGNhbiBjYXN0IHZvaWQgKnJlYyBpbnRvIGhmc19jYXRfcmVjICpyZWMuIEFsc28sIHdlIGNh
biBpbnRyb2R1Y2UNCnNwZWNpYWxpemVkIGhmc19icmVjX3JlYWQoKSBmb3IgQ2F0YWxvZyBGaWxl
LiBTbywgSSBkb24ndCBzZWUgYW55IHByb2JsZW0gdG8NCmNoZWNrIHRoZSB0eXBlIG9mIHRoZSBy
ZWNvcmQgaW4gdGhlIGhmc19icmVjX3JlYWQoKS4NCg0KQWxzbywgd2UgaGF2ZSBzdHJ1Y3QgaGZz
X2ZpbmRfZGF0YSBhcyBhbiBpbnB1dCBhcmd1bWVudDoNCg0Kc3RydWN0IGhmc19maW5kX2RhdGEg
ew0KCWJ0cmVlX2tleSAqa2V5Ow0KCWJ0cmVlX2tleSAqc2VhcmNoX2tleTsNCglzdHJ1Y3QgaGZz
X2J0cmVlICp0cmVlOw0KCXN0cnVjdCBoZnNfYm5vZGUgKmJub2RlOw0KCWludCByZWNvcmQ7DQoJ
aW50IGtleW9mZnNldCwga2V5bGVuZ3RoOw0KCWludCBlbnRyeW9mZnNldCwgZW50cnlsZW5ndGg7
DQp9Ow0KDQpXZSBidWlsZCB0aGUga2V5IGJlZm9yZSB0aGUgc2VhcmNoOg0KDQppbnQgaGZzX2Nh
dF9maW5kX2JyZWMoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdTMyIGNuaWQsDQoJCSAgICAgIHN0
cnVjdCBoZnNfZmluZF9kYXRhICpmZCkNCnsNCgloZnNfY2F0X3JlYyByZWM7DQoJaW50IHJlcywg
bGVuLCB0eXBlOw0KDQoJaGZzX2NhdF9idWlsZF9rZXkoc2IsIGZkLT5zZWFyY2hfa2V5LCBjbmlk
LCBOVUxMKTsNCglyZXMgPSBoZnNfYnJlY19yZWFkKGZkLCAmcmVjLCBzaXplb2YocmVjKSk7DQoJ
aWYgKHJlcykNCgkJcmV0dXJuIHJlczsNCg0KCXR5cGUgPSByZWMudHlwZTsNCglpZiAodHlwZSAh
PSBIRlNfQ0RSX1RIRCAmJiB0eXBlICE9IEhGU19DRFJfRlRIKSB7DQoJCXByX2VycigiZm91bmQg
YmFkIHRocmVhZCByZWNvcmQgaW4gY2F0YWxvZ1xuIik7DQoJCXJldHVybiAtRUlPOw0KCX0NCg0K
CWZkc2VhcmNoX2tleS0+Y2F0LlBhcklEID0gcmVjLnRocmVhZC5QYXJJRDsNCglsZW4gPSBmZC0+
c2VhcmNoX2tleS0+Y2F0LkNOYW1lLmxlbiA9IHJlYy50aHJlYWQuQ05hbWUubGVuOw0KCWlmIChs
ZW4gPiBIRlNfTkFNRUxFTikgew0KCQlwcl9lcnIoImJhZCBjYXRhbG9nIG5hbWVsZW5ndGhcbiIp
Ow0KCQlyZXR1cm4gLUVJTzsNCgl9DQoJbWVtY3B5KGZkLT5zZWFyY2hfa2V5LT5jYXQuQ05hbWUu
bmFtZSwgcmVjLnRocmVhZC5DTmFtZS5uYW1lLCBsZW4pOw0KCXJldHVybiBoZnNfYnJlY19maW5k
KGZkKTsNCn0NCg0Kdm9pZCBoZnNfY2F0X2J1aWxkX2tleShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LCBidHJlZV9rZXkgKmtleSwgdTMyIHBhcmVudCwgY29uc3QNCnN0cnVjdCBxc3RyICpuYW1lKQ0K
ew0KCWtleS0+Y2F0LnJlc2VydmVkID0gMDsNCglrZXktPmNhdC5QYXJJRCA9IGNwdV90b19iZTMy
KHBhcmVudCk7DQoJaWYgKG5hbWUpIHsNCgkJaGZzX2FzYzJtYWMoc2IsICZrZXktPmNhdC5DTmFt
ZSwgbmFtZSk7DQoJCWtleS0+a2V5X2xlbiA9IDYgKyBrZXktPmNhdC5DTmFtZS5sZW47DQoJfSBl
bHNlIHsNCgkJbWVtc2V0KCZrZXktPmNhdC5DTmFtZSwgMCwgc2l6ZW9mKHN0cnVjdCBoZnNfbmFt
ZSkpOw0KCQlrZXktPmtleV9sZW4gPSA2Ow0KCX0NCn0NCg0KU28sIHdlIGtlZXAgQ05JRCBpbiB0
aGUga2V5LT5jYXQuUGFySUQuIEFzIGZhciBhcyBJIGNhbiBzZWUsIHdlIGhhdmUgZXZlcnl0aGlu
Zw0KZm9yIGNoZWNrLiBXZSBoYXZlIHRoZSBwb2ludGVyIG9uIHRyZWUgaW4gc3RydWN0IGhmc19m
aW5kX2RhdGEgYW5kIHdlIGNhbiBtYWtlDQpjb25jbHVzaW9uIHdoaWNoIGtleSBuZWVkIHRvIGJl
IHVzZWQgYmFzZWQgb24gdHJlZSB0eXBlLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KWzFdIGh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y3LjEtcmMzL3NvdXJjZS9mcy9oZnMvYmZpbmQu
YyNMMTcwDQpbMl0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjcuMS1yYzMvc291
cmNlL2ZzL2hmcy9jYXRhbG9nLmMjTDE4Nw0KWzNdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y3LjEtcmMzL3NvdXJjZS9mcy9oZnMvZGlyLmMjTDIwDQpbNF0gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjcuMS1yYzMvc291cmNlL2ZzL2hmcy9pbm9kZS5jI0w1NDQN
Cls1XQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjcuMS1yYzMvc291cmNlL2lu
Y2x1ZGUvbGludXgvaGZzX2NvbW1vbi5oI0w0NDcNCls2XQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjcuMS1yYzMvc291cmNlL2luY2x1ZGUvbGludXgvaGZzX2NvbW1vbi5oI0w4
OQ0KDQo=
