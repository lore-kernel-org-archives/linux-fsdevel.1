Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9CAA59
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535566; cv=fail; b=ZUKMRhVTGcNskglj+DPC86fSJOxvidgdwiqgoyzGUyf9GySryWx2r7QAkukfpN5I0lbauotC9m/IKmDyV8+6onquyFz3XQ/pzoIKuVHy4MiaJmbX0SWVH34t8hB49hzeFtZB3RAfd1ZK0Klkia18hqUGLzJJH67wA0JoBVeolQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535566; c=relaxed/simple;
	bh=tqg7oqzWNCvUQWU+OK8KiEPcpRrKAkmqz161+avZl5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cKlOUmVg5HHcMjbCE1dBVP++Zq3IvuQfTSXhgnFBc8lbqfxeTDymL7kF9Y71d6JKMPm9l7pHWjzoIH05yiQBULUbeDEbphYuKZ+y6QxCjvSWfBStId2kYWSTJ+79YmSkIXc6gkVBpyWuIcDkWw+C2cbFakeziOYAvdT/1bo+wFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=d2hylbjo; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="d2hylbjo"
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TMeNsX3171917;
	Thu, 30 Apr 2026 07:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=9z1O4gu
	ON0AznF8ED3hStkO2XrEolxarXNIXQd6mq5Q=; b=d2hylbjoAr2srG7eLaeoTgQ
	FirCABkUppYcYD4vwKp4gwxjB+rvDZNYLh33pc8WmY2RBf7IKZpekdJQ0/SjPUMz
	paUSrpcM3mK3lcZdePDMd5AyySLT9fZXKtRmfFrP80LRBJuwqEaGeV52bu+2ztrB
	dlF0rHKaxoZ8gjHnoeR8imkUDSCpqIF26GDrX24cu5deeUJdJEnZh7hCSlLNcEvb
	qOka1gprSe6jCuFExywaBxI4Y9sV5Is6DTJfG/X1TseAZeyh4QR2dqbzlyUsagUu
	E9VR+hSylhUjNluQ314LtVcbtBX1kSOdIm15wacFCRkWTcII4mHM4pBX6XxmwUQ=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012043.outbound.protection.outlook.com [52.101.126.43])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4drp0pvxkd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 07:52:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlvX6jZTzdzxgK288H7DQVuVeSyXuKJp1uIAzGe18MpgBbi3xLDbHGXsj+mMY9NNbtV11IrOb1QymKUZzv3r++zgkBbkeIzO93Lu0gDL0ZYVWlNSPgyrlgS0pBjxNUu/Cr1iNOgd2M17By8ej/q3knBWkF8VmCgXgYiDMukjF4edwnLFKLed4vj9gKqqZjBEXj10kKDQT1SgNzjGQVyPYtdE1i5AoEI0B9WugTQNLPO/Lxde8CK1xI2eIxVDhkycwjkA2xlxwl9TBX1R/6RaSzthA47YAkyCW3rlt58TvieXwvPOTWcmLnSTPy8U1y2wZAVW1GLfoFLLdieNnta1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z1O4guON0AznF8ED3hStkO2XrEolxarXNIXQd6mq5Q=;
 b=PBg5D/IGvY+uBQeTdBnCtYAY+I7pRhphxWe2ZPqHCfA9YgHFuA9zgJHBrnCksxQenBBKMSkMfzgcm75ORnZbZrPC6hVyLU4YgCKwhAUKdjRznMq5g7d5nAVmh2i0CAVZy+HIz3yC+bBepmtw1RUBC0MEPg91h1ZGHDiQUgpcwtjr/uNKTQrP4A8tkxHOO7UaTsYBCLCORsBh9lZ/Jlr5hw3hl78+Z5OHpPFNo4siL1rkQ0kQ7uFV8j1Vib7I4iua1vADtTIWSrWDXKnwPfHi79JumLy1YtNsx/6XV9zo19Ohm/pgrl3Ht+lBldjqCFBPw5b/OT8QOoXitoyVRxVFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB9278.apcprd04.prod.outlook.com (2603:1096:405:39c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:52:08 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 07:52:08 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v0 1/2] exfat: add volume limit bounds checks
Thread-Topic: [PATCH v0 1/2] exfat: add volume limit bounds checks
Thread-Index: AQHc1/J7/RiBmdQXuEGYJ/2VItWXBrX3DlRc
Date: Thu, 30 Apr 2026 07:52:08 +0000
Message-ID:
 <PUZPR04MB6316951E45F7BC9A02E490FE81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260429160824.409881-1-dxdt@dev.snart.me>
In-Reply-To: <20260429160824.409881-1-dxdt@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB9278:EE_
x-ms-office365-filtering-correlation-id: 51954f2d-c574-4ab7-6078-08dea68d610d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 yhEAEsOuR1B5kRkylKslnhTcpdVfN5Bl9LBAAkhU8TCDP2kXFUCNTmBpMZPWYz5OJJTJRvIsgAGk0exGjHFCoh5Szz9syb/7itZ4Hp1unNAoV3Jw4IOtc9e1A3T0sUDgJq+oA/vQFsLVBagIMvwlwprj4tXXnYl9EDsZycxZeYjVD1XNfzMSIzghkogvlozQNohBG99WzoFuYjye4e4w7cSaohdf7gFAkt3g+2VKxeL2QOfc8qZwQ/JKqco/P8D0DfLKb8m5gmg9OJeP0iov5dHtMHrgvF4vfDuAmqNprlEhb8oqLg7ZAspN4cENw5RildXy7eLlAiNNNstQluT8Tna+fbk/sQAWL+8t+7I7pmOy8HI016A3wOoGMOzf+Nh3+Guv/lc/pthnss+BNF+eRnvmrFIf/58Xfy6XNwIVHE8Jr9Vh35YlWhRLA3J61x43RSNZzsNoG/gSf3De5ze78A1FrF75b6OEUMh94iHw1wcOmajiiDsJrDRipsyvPutEO6EbrUX7j0aujOrBVS/eMjI17duWVwv/uX7O8vrGZQiKwRx++fu4GxdnJf7+8QAdEcDG2/xztKSJAU/p2y0HEf62kNVuIaSaPDqTIMKGsKa3eRceSy0oxbHxKQwdHjHb8agNpq4iP1ZDl22EhxRW1nLGy+Z4FuDTTOZqP94DCsb42oOwPcerF9gty1Z9iC3HSWYF/LKzKN9Zx8QjiTXAlF4lA5YZt+hOvvZMHSnC3egDjVj0vcH4Tz0JA6elDGnxvetqOhdUq9yuO4rfZONC7INarTGoLRogzR0qVV54/KQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mD3YY1RbpnnDFT6u5mW7dFx/Wt2o0afjkLpPozwOsGZo2UXU8JQ99+7a4c?=
 =?iso-8859-1?Q?drbQ/uFukk/vMpCru2DKMGUpz/QKdn9U/MIRN3MiRNmeP1PSAJy6w1b/T/?=
 =?iso-8859-1?Q?V5tXtF6qhrkqkzCcBMr4NQWOdboynvmOavNo2iK2Afq4HqPh5hDQB+vEPZ?=
 =?iso-8859-1?Q?G76F3543zlVo9paQ6OS6LyKgN4crZWnOMVqw7cn9isCU+d65mNGWR//6u8?=
 =?iso-8859-1?Q?PyqjrKebfi5gSp8S13ufAzlKoKgBgFJot7EJredZF9PJYLB4Z8YWg1mnFQ?=
 =?iso-8859-1?Q?7pLvAwvO5Ev1O8HPbOSvLtAbp27uKjvnbYPA+goxcQbtESLtapY/lMLG7b?=
 =?iso-8859-1?Q?oLIw8TljUo8y8Oq6mLGcotkyA/QvJTK8kTU3YicYVAI3WuuoqPvA2ehYE6?=
 =?iso-8859-1?Q?SchidzFJ0G81Ue0J+YDI8ZFNg/FZ6NmxdDagCSuzIMloaKltEBoE1vJIFV?=
 =?iso-8859-1?Q?gzuYbIMqnymhw6Lut7oJHRRc29Dkq67CzQiBxx3nFfxhtt5OlLIKXYNOyG?=
 =?iso-8859-1?Q?Qx2114j+8oSJJi+pKQUKzVd2Tutge1ZHiW6VcEd28DiYwFjvKeU6QhK5QT?=
 =?iso-8859-1?Q?3VPDFcmK9k5prMat70AmbJlg9FyHB3xjDlF53pdbravkB9mesLi2lkxqXh?=
 =?iso-8859-1?Q?PhRjQncMwbmsI0gqertUs6/1NbyTC6fl1I/nxT5lLIerM9T1IYa+t1w8US?=
 =?iso-8859-1?Q?yxuRgDzNi8I9BxxtVUpZ3/QlgGLp+IMtWiLc9e525RjVLmSc47UJnrHhOg?=
 =?iso-8859-1?Q?4ITaIqw0dkJtFksDf0Njzr/jZiGfD979Mr6ByrKLU/lL5WmWw895FxWJgZ?=
 =?iso-8859-1?Q?jlBrpRKU0wYLahhC0Nz84WauKyO0T/pYOS1PtGqmFL3eh3N/P/qMufN5s2?=
 =?iso-8859-1?Q?Eh+UrzJZDOTHCHi2Njw8JrJ7Khv3+PgWipiHb7P7EkfyATjH1rTGPD86Hp?=
 =?iso-8859-1?Q?KSdyyTmYTElvAj2UZzw11qejdhqOrZPc3ymfr353nDriR8TAamvrcMPFT7?=
 =?iso-8859-1?Q?jEe8NeWcii82zyjbJC/MBl0lB4x0SAZDFaEQfqkjDk+LqTwtlMe3QgmGRA?=
 =?iso-8859-1?Q?ekRpCfFTh94vY7BD2RBO54Xt1X1sGEJIE13IRLzpgNPtRdEzuzknfYW/Ap?=
 =?iso-8859-1?Q?d4SFYl/ROchKyTLV48kkbS0LWnr+Yetqev8unBSACK4y1yCH6tzNPwjnYP?=
 =?iso-8859-1?Q?IbX6EcrU5i426/LM56zWv6VoBCkve0icWOMynbJ/DsxEh+9zpw2S6GrdA2?=
 =?iso-8859-1?Q?Ba2f3GcvEkCtgoMfMPq6r2V+CcVN4kDaaiRr+d2FaeXabl74Z9sMEUXxcl?=
 =?iso-8859-1?Q?z+HVLAKirXq6vMJBeD1WZ8VuEf6gKXOhtXLgPqOPlXYfT4FXYxZxFTf2Lt?=
 =?iso-8859-1?Q?69w1Iq6YMdBdreVxQd9yJLLXDvSNhkBqiXK/8lMcQkV2jXhEm+hIDwUdV3?=
 =?iso-8859-1?Q?hsnoXtVkkNiwPWQ6iLNCRgj8to5QgzMS4hmtN/KOuy9KcD3LXDcuXrgK2e?=
 =?iso-8859-1?Q?xqNCcYBjQcHUuK+UDskAeVFKnBOu4/AcasE6oCslurTVMkMerEI6Acb9hD?=
 =?iso-8859-1?Q?5BFiurRi8/HoPhy2FqzH0vOSc/Qm2GIXwJbEWOImfaicV02568Nz9m/qmK?=
 =?iso-8859-1?Q?LL9UviU5SbGfk/KBf3Agi41Fu50s7D1I4fPNqd2oy4/hFkl+WK+9OO7m5l?=
 =?iso-8859-1?Q?CYsASan/KBnl/NUlkR+iofqN0jnOkD44iCrqg0w9LwkwRdoCyITijLo09Q?=
 =?iso-8859-1?Q?qNSP/Gd7xhNDqjvv97gN2Fal/MQrKa4jaqTjODGT+FoA1ArEetoX6TZjJl?=
 =?iso-8859-1?Q?lrmTn39niA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BCV0V+8kZOgkVcdK6Lm/uokpXKUQx4TfDlXbdI3gjpikjj77cd9YxZfuuVpxLg/uj+nfzD/ZGENygGlNqbkxMcRvEdSb70nC55j6O363E/en9MV/cqq9nPonkLhSAJ9fX22lI8z9cwphk/nxXdvKzk6bScx9+HcBnlP65kRq1EVOL8uDgiZ1QNZWdmfhpyYvm5jihB2mTljguNPrXOhGNiBZpsV1oJkREN0oJxkjYC7EReYRz7M6lxW7wDvw9+aN/CiLD3oGMP3RZAuDiG1LpOf298tgZvI54vaoeyf2Vq2x2mWaUWXiyRELPa3XKiNB7morr3UxqQjSETwvSlIPTQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ztt6uRLZuZ1ufNgP+wqkWsOFgZSMq1Pr9JpHu6GWsoRfJZIqEa3rJo52mM7aE43K8+ZDYfp1vQ/ntTnom+6Jk8h3/2tEbQwCt+gShLK9Ia5tfYambA/zkNyrWECiLizI1pLgwVo4+EN03GraCHEMEOQ/7miZjid51ueEQ6W6ZjC4ojlm1nNACJpvPOCRg4cXDyGaG7oWTYqAa8D+g609HB9THxgONG0L5kF7Oquml5AX8pivUcD7Y0S0vpL8OBli09pLwg/omkCG2eor4cDzozT7CtM2az1A9KRtOrTYz0G4sduTuB3xG02uZuqX63B8VT8iJbRjLg3kT2TqL259lwsLC8qQCLYdlyhtOPdzpnSpQyUaI61++8ipK5aaekMJ90rHAz1+F/f7wtxFz0ZmLQaxPmTuGE5FtAZgU9xjxksdC5RWLugTCt/AB+xkfaRPnMEPX5STKOFpYKLL5/ZnVQ3JFPfsSx2yFobC3deCMASuM0R4/y7X4L0HH6/i+LgRmkQqbTN25OMNKA6M34iP9qKzjAtKeOXXHNbYGzksWtGkeWXzpsY7OFvHnbS43nvk6yVKPpCg9gbMhC5UBWPrQCsJeEMFfoP6MsTmChD61KJMrvsV2Afn8EBgNQHVH/yP
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51954f2d-c574-4ab7-6078-08dea68d610d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 07:52:08.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nahtpGFArPCNtRuIPm98+yyBBcIHlQK+qn0bb6oarGT9YbuUYfzBro7m89DrKBrQHpwnU3FEgMOD6cQ5dzP1KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB9278
X-Proofpoint-GUID: WjQ9TZgSDS35DqiP645-cdHYg61EMGNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3NiBTYWx0ZWRfXyZhRHXO1UL0o
 DdVjQ98m84+0A2fdXiO0i9UCQM2uMihkcKncoE+2tZaAhHAztMIhRcQ8hAGpHSp/Jcn4DABJ62T
 S+f3mrPVJfndt64HoHi5V1JbsZJOipOREdKOoBFqFfuzPz6ERp36y+esT8vXb6g8PnVyO3TILMZ
 r+eand2XTTNP/ikJ8hvY/4WkGw5SKGH2p/yuzszbDnQvyd2m3MxcKK6FwG2eIKgtqL4nv+QerRe
 QUhHnPd5afk//uHxpJOTeiT/SROMhX5Ihp5GqUf01j5H8bxSUYKPgGbC8NTUGHJUIV35wpYfQhR
 ZCA72/gS90LgWoCXarcY6+OCTXiFVkuj8zqYTMqXX1LRs15jSTp3KmeTnA3DRf6gHXV+l5AtHA7
 T4bKHxj74MwiPjffnIJyMTzhviu5HMVw8ziQT4onNfxAS8kRactzR91Mgvdy5QKoM0YlkXh4IFm
 5PeVdAuTG3b9htWmvGA==
X-Authority-Analysis: v=2.4 cv=csmrVV4i c=1 sm=1 tr=0 ts=69f30a2d cx=c_pps
 a=hHKKfTtuLqLmwMmoH29UBw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=6Vn1QVPt8UGdu3r8PAnt:22
 a=dBjtWzw9WxGK7x5jawgA:9 a=wPNLvfGTeEIA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: WjQ9TZgSDS35DqiP645-cdHYg61EMGNr
X-Sony-Outbound-GUID: WjQ9TZgSDS35DqiP645-cdHYg61EMGNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01

> +	/* Actually try reading the last sector to see if it's within the block=
dev bounds */=0A=
> +	bh =3D sb_bread(sb, last_sector);=0A=
> +	if (bh =3D=3D NULL) {=0A=
> +		exfat_err(sb, "last sector read failed : %lld", last_sector);=0A=
> +		return -EIO;=0A=
> +	}=0A=
> +	brelse(bh);=0A=
=0A=
Instead of checking by reading the last sector, we can use bdev_nr_sectors(=
) to =0A=
get the actual size of the volume.=
