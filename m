Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A703CBE9A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155455; cv=fail; b=VvA1nfOmAOYrl0jZqB6NZHqN3ZuzjBNNARogYG9lnC6aSohBttnNF1S2LSmp2JX5gFIKu0513qa+2Bd6wkEOSWSoU4eQF0cEgOmFWmFj+oMssRmqVJYrX8lmdn4C43tgHRiRaR8fWLpz64aQJOg8flrcTpAM+MpGTLh3mrV5YLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155455; c=relaxed/simple;
	bh=sqHrcyppSbotP6PBoCOtb+S/KMlwKf3L5lRJgFxz6ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lm1nRbze5Hw+ejVb9mRKpLvOrFI2IPEw9H96Hi32kzQxXDX9QVVRosmqTJi8UzedcBp7tgaAxDJmfApf9Uz7sqyTFX5vTWSzzxuKyXfwIVrw1relNptZYQZiawokCas80kVoa+orNXuhP7ZUYqJ6sIFDRsaZcOYepxlumg0x75A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=QRsTzKjW; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="QRsTzKjW"
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BZNl21947711;
	Thu, 7 May 2026 12:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=h8T5Jd4
	UV35zNpAv+BWc7ok8pJ2d2u5UZSHAkOIG5cc=; b=QRsTzKjWmlpbWvQ0iVGM/T5
	UzLb66X7x4ieKl8rkqniRjTXNyM3t/5PiSQxESDon4FS4SJ73FXubp7rFgYInl27
	tHkpDQo9biqlgfY2buB+H631WqnWIXA/wCSGVT/2PqU+jvzWT6VOVyeYx8eYDwp7
	o9+W4ZtjLod2H5CYAQzeIP8Xjq0EQrYBrNNvI/DIXbVPLzNe58oWBh1vBPaMtNUW
	Rg+DLJtEy9LzsDHQ851fimSV1fU+3bUbzZ2K613OgstgsxFGSaaOYYGU2GkmM06f
	Y36hDs96Vx9vrL4oaAK0BsqErTNKQKmscO/QqByTnliybuhwU9Zfz4+Ewh/PHNQ=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013001.outbound.protection.outlook.com [40.107.44.1])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4dw9e6mdsu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:03:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX7azwMLpMq6O6xVqQYs3g/WIyfwWx7v4xmLxzY9Df2cm8IXx6gcXQF2jKONn3Ed444QpcFKnfQOJbQ6eAfr/Yw+cVavdvAOLbJy/knlKBRoAYGP7hidH+YSY7tgZN2nf2Dtv9RomJ/I5XtP46MhkuKnkM5eBklCoKoPoqsuSHkYODblWGOU0y75hxYSL5edRmsiZsCDmQwSR88EDnk+WyJouILPIBBK8sROjpb3ojPad5O2GxcK93Zrtn36cJWeyDJzo9Ay2WcpWi6sSQQAUYF4okCi7aqGgfQdByO5V/10VAj/3/uAm9/IbmMHk5p6sr62oyunSsC6cpajE+468Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8T5Jd4UV35zNpAv+BWc7ok8pJ2d2u5UZSHAkOIG5cc=;
 b=TCAGjFiv61ESxzgOj10hT2SeWQM6KfR0GQNbm9q5UKO57nD0KdfDHZO7d+YBT5Sqsq06Xs9trAiN9xiaHKv3X5k5tYWYHzcHMuvp9fMF+qNsTbNw7N/wasvB+8iZ4NPPrsVLwcVIL4wSwUjiSuK5QzXdOgHUATYt2TxLDprsbnam4hfx3ZICh/iU/76JsZ7qhlaCDIrUOp7d50CoHsW2aQr/+TSgiSJ2ApAoLSm63MCUC2SuvPjiQfgCR1F5GLrcHP0xgQAiQXQ6xX/fIeNmjKQVHM3Gv2L77wcqPeLo68fXWdkBBzkFi3ZIjylaeDCBYYZoFSPSSlLOUpvncrDXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SG2PR04MB5663.apcprd04.prod.outlook.com (2603:1096:4:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:03:27 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 12:03:26 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
Thread-Topic: [PATCH v2 1/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
Thread-Index: AQHc3Is9Ctuv9rZTh0aBie7mOook7bYCbEf7
Date: Thu, 7 May 2026 12:03:25 +0000
Message-ID:
 <PUZPR04MB6316AD038BC864209E256243813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
 <20260505123144.730782-2-dxdt@dev.snart.me>
In-Reply-To: <20260505123144.730782-2-dxdt@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SG2PR04MB5663:EE_
x-ms-office365-filtering-correlation-id: 8c9add7c-5ebd-4dec-2017-08deac30a4ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 0O7XtWmV58IBFDr8INELCkYHCDKzwcuaxOr4tuYV4Ew9SK1FyW4HP+xxo9LaIbUK3s6c+yONUzVo1URwdqlRQrHbkIXIaxawQTEUqbnYl/Bn/mF1iB+4aSFxLdotmJZQBRRs4BmHtBJ3ShWxQJVN28ctX9AIisPFgy8eFvtWTYHfLYveAe6Un4SrRP1KFsKjCJuUFJE2/LKrq7BTu84/kRVv1UXkCM25NvpNR8egyesk4vgNshH5ci1IbDX6/PLObBiqyNFPCuYB5J/ZDMLtizTeiDPdoGiEshSA8XlsVj5auFmE05kZNApujp1sNLr8fSMdlT7IDpJGfZ9sy4yJFC8ShCukhmHaVhCRSu5PNEUBYE+KhaWYokcm3g5YkIcQ1cHDt2GWIXQLlCdX/lrijRK3W6dxoz5Ueo4SXawYMJFcO334zctBZ4y7fQeXoedcxGxJVGPawIE/wU6tT2x5xUwaC1SI2V2O27I37f0V6NykbfoGMFa6ZY/8ewzHObyncIMAmJSesdf8zZsJBphRIc6I7U9LndQa3/EtVrsLQbJgcdhT1wEPiOXKVcPJsspdH2FxXzgZGg+IwFbU9KxukNAWnENIFC7qMTl1YFbLFeJ+Ra4u7JS0zgnmiCA/jQEo2KgJtwgz3nKfX8zshjR7exCKe57+bc2voizbbF0s2Tm6s8p6WHjlrLF04IeHCXWFcil3yS4OpczN234EACfVZFJFQeAIwLXXFyZ+THwilOeHFrPBI2c2ac9TyhsVQfQN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?txxGj7mETJtJePppLGoLHJnC0sX6f1RGLNU1NYATH630kc2Q+T9C95mwFd?=
 =?iso-8859-1?Q?E58Z/jeW4GU2g/QpPz7HpF71P76SEruXSE0TeScI1U4Bnr+O1k6AbT91nC?=
 =?iso-8859-1?Q?Nx4k/wF1rAKD6c/e0XnEqMLl4cCISsdXXl103XHR/sYJ9tbOS/BCYQ//9P?=
 =?iso-8859-1?Q?iAiU/jlpOOD0513FV0aYWLhGXIXSbOy9rp9644C3HRAXtVa4ScdN5RImAC?=
 =?iso-8859-1?Q?XBLIxkTne5VQbCy9avDwuVGr0yffIkO01pPOPBJbtzGcsTmtbabo8k8sm3?=
 =?iso-8859-1?Q?1cDBJP5zQrHFldMzICgq8nQC43cQi4wFLtiISxjTe8GmQumDFOgIu4bCMo?=
 =?iso-8859-1?Q?I3Brh2epJJbtM6zqo0yEbXaNFsdnJ+t6CoS64CJBCSBPw1+0CvrRUXnG4B?=
 =?iso-8859-1?Q?esxj86J9lUhNJL6beuaBwfdp6DGrS/oaRZkvG+pYnkctBx19e/7g32Vyhl?=
 =?iso-8859-1?Q?3jSh8rzke+YsWBRr/x2AszcWIFRRhuvJ5DtUx3Gymi7Oy5FCEq2nu1okm0?=
 =?iso-8859-1?Q?46nU+Uy1FfZIUK3jRhi3lfK4zdqXP/n4C5sTojvJdeeBes+TnGbHAxprKH?=
 =?iso-8859-1?Q?40j1R5dJt5GxGvdmI77rz3QGqOYsGhIUF+927dfYJf79cgx/4VQ8Gh9OES?=
 =?iso-8859-1?Q?rsKxOtk0VUXFgn+MbnNQZO9WWS2hbLe676gS41ZR8+Y479Ge8kIjOu6OwJ?=
 =?iso-8859-1?Q?314RsrD7TgIsYTdYQGQpyJJgqbvn+7FRzR8VyRlBe0cD+nJ/kITxAa8Mg6?=
 =?iso-8859-1?Q?yK6/tnc1pbHglDvDOHSgzVK7vtb/E1EjoI7YQDRy2d5+RIgLZiodwAl3sJ?=
 =?iso-8859-1?Q?mJvVIn/nbUjN4tXpeZQxGB5N4OO/9JF4tLH1xVa0xn49XKnGtW3HtqFFrk?=
 =?iso-8859-1?Q?7VJWfh+cIDj5Ss8pCD0fuz/P2Jue/tvqesmlbmv33UY9oAAnE6OJObaQ8V?=
 =?iso-8859-1?Q?kjqkUKulO+UILvdfMdo8sRjJpAxfCp34Awe3rbtlhx67L/LTRUMIah2Zr8?=
 =?iso-8859-1?Q?P5qigvnWGUdFhdXmr03593pNU/G0iSWq1N8b+uoqvj9QBT+FW9tOpcdRk3?=
 =?iso-8859-1?Q?PxMUPnx61JOYB1BwTqJD1PrImBGr4fhwIxE3rGGnWreDrn/5/+vK9FecDQ?=
 =?iso-8859-1?Q?ruLkhFUE5magUvN99WUJN2ddaO+ViRMlRmgDCGWjB12WMvdmWpUWFTjW2w?=
 =?iso-8859-1?Q?p2S6YOa0rBGrWpNf8DDhk+5iWuUGj0g9v0pri7rZmwV+jBjheHoGmsEvoP?=
 =?iso-8859-1?Q?UFwFI/oVMlenVvdicH0cpYVm45bzNS4Suda0lcBcMm5Bkhw6pw5dnygEko?=
 =?iso-8859-1?Q?xDhG2ki+TAdEaCIxAwiac5cY+qBBKsGUDZY++SNVfVI3QQRh7t4aTXSo3+?=
 =?iso-8859-1?Q?cPLFOp80tb2eUrZGbj5kVq77NbvLATnx88YXf28Qgp7oq+sQ3VU+6CTBsy?=
 =?iso-8859-1?Q?6v2JZvaFBtLifx1Zi8WWoRX0GSdeQf1jms191GvlB1UmFmiurrH2UwskSl?=
 =?iso-8859-1?Q?wBwSWyaouHTVwtRxKRRrOFQBlrZTTDcid9Z25TAT/TwuMgAo2oz+aRxGxW?=
 =?iso-8859-1?Q?nbNn/tabQpxlNDwF7yW1IGUfJV+/r1aWDxVQO/Alod46gBD+7GYlS4mo+G?=
 =?iso-8859-1?Q?MXoZ6czKFw3jxXkxIHvpOwodjv0nmdiMGms+Ho6dLR5+pqVZczinS8Hyui?=
 =?iso-8859-1?Q?sNsfR+v7ByLv3KYUW/6blo9KeDZZqfAmc7V4zI2bWlgaz8pmGea1KrPHr2?=
 =?iso-8859-1?Q?K7a6gS+ve6RufFKNJQPRvRmpGKN3NrJijwumH2covUOH1B+6riqBbQ6Mwq?=
 =?iso-8859-1?Q?2KIj8i3POA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GYJSQSI9q02BAzsynqa0GV0tIypmo3yUu2r7wSfANGpPgL6OYNCDKDIkXP1REuEECTjyoP4/mojIen47c5QpPCV3lbJX3RIEFALbs2a+uz3JD34lWJNpPsUSLDW6nQ+gjVqyqincsxu5nZ/uK76SPXALBl/H5xo8Q3zYjhKliBunpB1jOPVt7gJmJPHWyaQSmCIo3wcbeoWd9NkDxyYd+Ex/Wm1xQSdydnrx8Pymr0irdUKd7HFa7pXUshf4A0/zBsp8dGGq6ZTouxXSHLoW6uX0wxionlBhVCQSnY0ai6+vj94h3pCr4q3y1lu0QceFmxUH/S6FM70m+ePK+OTlEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SUiiyOcZa3eV5hxHMoHSowRUgxySzzd8Thp7gaNQwQB8BEMe5HvfBN3LOIqjHM3Orr1iMILp9DW10AXZa3oshbd9HY9spwN8QgudogMnEBpx+Rl1XU6Sb2BdSi/E1YtThx4AcF3BxWJI2MnWW1BHbIQOis6H0DbheZs6Rpxq92IKgmYxBPf+KT1jx9aANF6P8sHPiVGIcCuRJpPXWuyInaEmMwR8JYeRmdlUcy3xOW9qO0mLKS1KSX5Vcn/nRFudLR7/R6sYfC8jZJIi52KgM+vMlIpyUSw1aAizPI+dhHdJ90+43Av6yKR0dKd2KFtLn5bBU4KrgAwqOJCEN7FSZokUNi4gqKrkY8spLvtb9yQ8uxbhowFmUqieUCmM89Uq757NjrpCEVHbgzSSVAi22d7Hq+gCD3UeMdJ8wuq513FD0bRUFF+4W/qDru4OoNPYxMQOUPTtY1eDUIWbHUcptsOlo3Nf528OAG685IcEnjTgcysLDQA0UHAiVnHlbCo8LEGsGoslIAK3mgRgfWxi2sBU57pV8oJwKUt0zebae/UkrVvjnGhb7PrT/jLJdtyNrkyDONFKgLdXMZAMwFTwMczf0gZw0+dSyV5zpH24tY+dCy67UEVuDtE4wH15JpyT
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9add7c-5ebd-4dec-2017-08deac30a4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 12:03:25.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCfIEuQA1bG9W8Tca1HXJTOkZQ2EzBQlz/7MV0cHahtg1K2KbShiHBcemLElLKfMgcSQVm8kZXkFGqec6dKH9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5663
X-Proofpoint-GUID: Dxe_DIs_KQUpnA5FHngtsrIKleD8psXM
X-Authority-Analysis: v=2.4 cv=FLgrAeos c=1 sm=1 tr=0 ts=69fc7f99 cx=c_pps
 a=HTpkYgdmRHmM3zEy0r+iTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=bd-SKr3HlWZVCYFCRTQK:22
 a=TsY-pnac105tANwHzmYA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExOSBTYWx0ZWRfX90I3qdhVi/i8
 bHO4LcduCDq41ktQBV8CidqSLsOyzIoZ/0DW6Mys9Vf5+ghJp6S35enoY1BvJpqwuAKY/SAmJSl
 Buec5CSWaeh/Ci9RoQ63q+tz8GR4hZV+Nvk11Wks5dXfDoiiuq5GHpuRGB9kE2fBe3UWVuGvTkG
 fKpJtjQYo9RnG74mhc6AJcdf61hXEGWf9QlDke6W6XtheSIYEJPTMiqXDPk7ma9/P0ZexBpPc9B
 KxhRZqBkSICsXxqeCKegRq2+Q2vzifKywVBUppV8iwblC4qD1C0yjUwGnyNrmX3xQNgCp6VEdfl
 TjADT/1JG5rUdhe9yLcLSTPtpieao85wgWw0KoTRt3iURFlVVMp+1dubezNrDHygo1FVGd86sZg
 GrfKmkaT8Ea6v7CUZ04a2haI/J6fvLWq9MBaQSjQnqDvQ4fa5fb/jQ8dSK0BjKiE63Bgpi3mjWr
 p5ynbG/6GXuCoEwqAlw==
X-Proofpoint-ORIG-GUID: Dxe_DIs_KQUpnA5FHngtsrIKleD8psXM
X-Sony-Outbound-GUID: Dxe_DIs_KQUpnA5FHngtsrIKleD8psXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01

> + * To maintain interoperability, these errors are not corrected.=0A=
> + */=0A=
> +static const struct exfat_upcase_range_info def_utbl_ri[] __initconst =
=3D {=0A=
> +       /* ASCII */=0A=
> +       {=0A=
> +               /* (index =3D 0, len =3D 26) */=0A=
> +               .start =3D 0x0061,=0A=
> +               .end   =3D 0x007B,=0A=
> +               .value =3D 0x0041,=0A=
> +               .inc   =3D 0x0001,=0A=
> +       },=0A=
=0A=
How about changing to this style? the table looks too long.=0A=
=0A=
/*     start   end     value      inc */=0A=
/* ASCII */=0A=
[0] =3D {0x0061, 0x007B, 0x0041, 0x0001}, /* 26 characters */=0A=
=0A=
And 'len' in the comments is not very meaningful, the comments indicate=0A=
how many characters need to be converted more appropriately.=0A=
=0A=
> @@ -896,6 +898,12 @@ static int __init init_exfat_fs(void)=0A=
>  {=0A=
>         int err;=0A=
> =0A=
> +       err =3D exfat_populate_upcase_ptable(&exfat_def_upcase_ptable);=
=0A=
> +       if (err) {=0A=
> +               WARN_ON(err =3D=3D -EINVAL);=0A=
> +               return err;=0A=
> +       }=0A=
> +=0A=
>         err =3D exfat_cache_init();=0A=
>         if (err)=0A=
>                 return err;=0A=
>=0A=
=0A=
As I said before, we should call exfat_free_upcase_ptable() if=0A=
exfat_cache_init() return an error.=0A=
=0A=
> @@ -691,53 +330,36 @@ static int exfat_load_upcase_table(struct super_blo=
ck *sb,=0A=
>                 brelse(bh);=0A=
>         }=0A=
> =0A=
> -       if (index >=3D 0xFFFF && utbl_checksum =3D=3D chksum)=0A=
> +       if (index >=3D 0xFFFF && utbl_checksum =3D=3D chksum) {=0A=
> +               /*=0A=
> +                * is_default being set does not necessarily mean the con=
tents are exact same as the=0A=
> +                * upcase table loaded from the volume may be missing som=
e entries. The checksum=0A=
> +                * matching should be enough to cover that case.=0A=
> +                */=0A=
> +               if (is_default && utbl_checksum =3D=3D EXFAT_DEF_UTBL_CHK=
SUM) {=0A=
> +                       exfat_free_upcase_ptable(upcase_table);=0A=
> +                       kvfree(upcase_table);=0A=
> =0A=
=0A=
If the default upcase table is used, 874 entries will be set.=0A=
=0A=
We can determine whether the default upcase table is being used, rather=0A=
than checksum, by checking `is_default` and the number of entries.=0A=
