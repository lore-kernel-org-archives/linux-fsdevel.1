Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020223FBEA2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535920; cv=fail; b=g0EfvWXGQlkyUX7k0rTsgeS1ADjoKXWieEhP383lRsckDIJJyqC1OL0eYejISFE/UKCfsHbPb9h7kt5y8jVFuW3Q/bFOqW7kPBQSCcfZpPkIoJG4M+OZJ809rrP2LkpvE/NoiWx06h3XCB1LopCTTQFkNJLrsOrWMDivAl8Zw/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535920; c=relaxed/simple;
	bh=5rRWu7YyAoy7TgVyUNXhzvO6IHUDVamN2yUeW0KbKEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e9WowvO/6MB9SkRxyVH6m30Hl9s5+AGVlHbqWN4DxzO5qYvS8OtJdNCaYYq5SvO/Q+oUpRnSz+cRmvDazPbO0dMByBM2wgHASSRmaa2UCqAacf/3KtXX1jyfktxrsASPDZrgVWqri9St4FsKly1A0BvRVQifGWNqkD8K33GzV5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=pDxqSvmU; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="pDxqSvmU"
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNtBgR2623175;
	Thu, 30 Apr 2026 07:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=U29iWRE
	Gmur+rWYx2ET0C2fBA6Sz7SfK48VuA1B0XOc=; b=pDxqSvmUKqc5kIHRVtmS8On
	zXNYAiHwC3iuvY2iGe8ZSrcKCAF8vJp3MCiCWghUW2S5nzaALUeOc4FBD5JKTU3N
	muCq59/ICYDoH8FgmDZB2DrHYM24harnTyyvZiAl6D1q3lGTXoXXHNfEEBJusYQd
	oijwrAbZiIybmrlJzbGQhgge43NMH9JZ32r1qi2QYRz0XQbv8aWK9Zqkg78wZdU+
	g58/2JWuwsAqLZvpzhgczBiNNA/oJ7M6EEd+kYEm/WLSQSgYHMZmMbVLEBUjBX2c
	k32jgGiMMGx/D8XMQ+phkRDb85/TJkcc06BZG48ZkzpTGQenzu/itu1c1JKN4xA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012002.outbound.protection.outlook.com [40.107.75.2])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4drjs45km9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 07:58:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qf27j1B1G5tXKNNOWU7W85eag5MAmyRDfWUROfYw/CQQ+Oe8O9luaVmHd8rEhxlS0Yv5VAXzS0oK4+Q9Myp2fuGqDQ29LEHo86CdR2BKOXfynkX5Ic7G1o6Kuvkhy2N9uQsxQO88HTeYQlFU9KZD3o4C5ZZ3gefaLmPsmo7HKjvqvb2lHyqRXY9Rp0NtqMkfCBZZxtMUtqry2FYGXY0yQUVZPcCmOiiAfBEwzO/sGPjch56a4PGQf81Nwb8Rn7gq6GJMLBjE7qT56bvUye+cJQH8Gs3kzZamtIMI80E9L3efsAJkNLF+M3vv0cvoV89uE1ExaPZfbDXfEYZWwzwFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U29iWREGmur+rWYx2ET0C2fBA6Sz7SfK48VuA1B0XOc=;
 b=C2eLqmiHfqO5dJyfUHpJi80FJXXieFHm3Z+RMHcZ+QfE6LNAkQG/lfWd4Wzmh0FAAY1LBUH6qXafSLrApseh4wVC2S2MzNZkv5VaxForWo3oE7HX6o3NkGSbzL5wJWbl0a+Q34PNrV3qj7DcC9/q8K7loYgS1wv/PmtgSz9tinWwIcwZo+B0aqNO3qANe7fUAmjrel7WxBHqetzbWmMFwoHTjH+G/YX/7sa2uYYLyYH2ebgGICUyF1ZJ6KLb3k+d2FMUcAGfxUlSmel/V09j5thbidXrpvOx/UNZOlGyW3DQXIq280l7bdqEFyMGnT7GguYiiSi4qkMxcz8hlBbRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB6445.apcprd04.prod.outlook.com (2603:1096:400:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 07:58:20 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 07:58:19 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] exfat: more pedantic upcase table validity check
Thread-Topic: [PATCH v1 4/4] exfat: more pedantic upcase table validity check
Thread-Index: AQHc12nqK7S6w+4sFEaIG01h5XC297X3O/ly
Date: Thu, 30 Apr 2026 07:58:19 +0000
Message-ID:
 <PUZPR04MB631687B9E5BF6066086C7F5E81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-5-dxdt@dev.snart.me>
In-Reply-To: <20260428235038.93816-5-dxdt@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB6445:EE_
x-ms-office365-filtering-correlation-id: c773c470-3775-4bf8-651f-08dea68e3e96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 UrrITd4rjuoplMU7MI9c8ZJOJGcEa03Qmy8/MtR0eCiPvekSZ5uoqYMr619hl3smYU9m/bUpJx73zy9hWxMq36cRqu0XjbD9enX8/gGDK0+q5zjVqQmWLuPxc4io8nmcp26KyuQIOnn9l8UOL24ijIsi6nQdIDtW/vss3WgLKnPFTr7G8rHf8qGsZ8/pGXFsOwCMuE4eOM3wfIrUoG69Xxdantx7jK03m9ArIkS9S9+OMwD38+nrYSFV7ICnG8sMKM/EqUaIqd5PrN0VxNQoVfMRR5etci/i4SF77XjEONxQLs4SL7JPG0TcWOj9PbKGN/kSaZpNAs9soCyIkWwQFxd8QqfTl0xVylc+bWe07d125+kQCa+cBPbWrdf4TdBng8EHOmxdvLBAPMM7pBodfsye2iol5tAWSme8Rr3FR/g5fqcvA+LV/NZAEWhflG4uUWtPzbXETjv4K9IApXBS7L1KANhYCzO704mJuySjMRbo6WjB89bG9PkVctIud26gWDDdU4PjpIaEgW4VUpbgRlW9GU6TtZz1/WUyY6CC0ioj+fHGfOHp0APm/2iKH8P/maR0ba9lcrYRr9oK+x2n78SDsBKbLYEJWA7Hmpr8GKhnfMSh0TG/fXy4Qo884ToerkMf6uhU25Tq0As7XrURZ6TTlR/vJnvSuJLQhT0nFAO8zdJu5ORgvSK+WrmM6sE9SRAs+j0jIxQ1c3yu+cf9EN65/Lm7Ytu+IDDjx0DGn0H0WapvngV6oBvratxuKCA7U1czdh2Ate7McAJAFY9+m0lAH3VCbW5JLo1A/sRXsI8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EyWA1KY8dBPATwlVBoHQuDlgcOR6sXhgvJQJpUlv50HrPqz3DAtLCZSBsI?=
 =?iso-8859-1?Q?dfLQTYnc2Dr00U4CzKIyWUWkErfwkSb5y6in3mlxtWganPQpjhpdUFvGEr?=
 =?iso-8859-1?Q?f1gNFEKUfH+FfUIpkojJpQF2IxOgZmY8r1V1KWlYyRJfcwI5nLhjKUAvqb?=
 =?iso-8859-1?Q?sEujPjKqjCh+7V43Hbti/89yU1ABNadNxEb6lnCP5nj9elx7FDmmUUFIWc?=
 =?iso-8859-1?Q?TvsMwPZOlXQgZvhepiBDSzCGa3DLDU+wY6ammNLNOMVjHVt5ll7dfB+g/w?=
 =?iso-8859-1?Q?iZRrKykFgOCb4LkJ9EtitDZJPFToRT5dHOmh+6ntEjQivuv8qZni0/PHj9?=
 =?iso-8859-1?Q?ysqkEoxMEyjTIM8IlK2HeecbW4DtDiZiFgJTFwO58lrmuMwhXVtsJFclWd?=
 =?iso-8859-1?Q?sUPJKWBE6sRKHBZdHccsngk5xLgCTCN0EyMyIlhcLlh21+KO4BnJRyevPW?=
 =?iso-8859-1?Q?OqSnXA973e7L83y1/sSceZPIc1i9Vb+TWAW2FlTVrkldrUs7QAb1oPGbmN?=
 =?iso-8859-1?Q?3+wxrSfQci3IghnLI/cktQRZ1cUfo38v2C2GgziaLY6/VcB1xIbVdUBEJ+?=
 =?iso-8859-1?Q?znwKgoJhCWRsCcF6qTt1f9SrfDaYihcfYIBT+zLNFVPc5g/5x/rAF6NrdY?=
 =?iso-8859-1?Q?4q/3hIaYpo2LNlDKVRPxTMNuG3mxpQqKLpyhab5pAUJBGb7klQWTkDp048?=
 =?iso-8859-1?Q?Zekk7NRODjRVCsrW7IJs32LaxSfGXRqxldx49jVFbhS3vRq3ee0cmiHodP?=
 =?iso-8859-1?Q?yUbM6Nc9viSAjq8yc6f360OiW4NPz2YEydrjb58OQjTDSUocp640ee3qJR?=
 =?iso-8859-1?Q?PIBQnStuyfIYYDIPZUZmfEUqKUOtjRkAkmJEcTLhas82Yj5XaBPgCaaIFE?=
 =?iso-8859-1?Q?JAQbh+ZgCMWIR8AjKvMjsg0H8GCNo08zR94vx6E1K0dD1wwSnK035yZn+g?=
 =?iso-8859-1?Q?ZDgLWwKzytyj781DL8xtG3PUF+CUJlXj9msLKtNgMFpcF+oqjobIFQtZfF?=
 =?iso-8859-1?Q?gfyH2C2ZRWkrfyHLarxUjUdV8rD/RtigDfzjbErlpgyouwQjhdyymngEZm?=
 =?iso-8859-1?Q?+taO5cAT9BdlqdZ2wwfClH4GyjoCc6uHRug/zmiQ081ZPjOIxVaf53S+Gp?=
 =?iso-8859-1?Q?gY2xqcurASk3xexGG4gmPLcVybaRAaPbfrQ5rNjHZzY+H0T/RSK0IAeBvE?=
 =?iso-8859-1?Q?sszV2v5sb1dBCTEYZBGsfY/VZP2epKGkNqqfJz0Cy9w9UN04Q5Ootw/If9?=
 =?iso-8859-1?Q?gvkiMh4erllt2b6KSrHjYNsSxsu1pzULD5CV5ynyuEErFxLOVnrv0Oj4ii?=
 =?iso-8859-1?Q?uZSaW5BzS+HLPOP4abWeKONEwaIq4oYbSsB02tDZefBWQp1yfJdELQ6ymI?=
 =?iso-8859-1?Q?mQJdvG/A/mme+OdOa4vtON/NzQFly/bT6mWirI8Qj7LqcyAFmLuYRLOYw6?=
 =?iso-8859-1?Q?2hK+1NkIu8ZlczTfGBi55KFR0kXHPf3vmAjHwStZtpdURIcHlyVeRrUW63?=
 =?iso-8859-1?Q?l6Z747OnAHP3yzGTeRhDDmM1sl0xdoSr63+OeD9JNbHMJM0kXwPNAN2BlD?=
 =?iso-8859-1?Q?SvbbauuFOG5G42Fy6D5tX4f6KYevOnARJHYd6WH0opIgjWjNdTrBmf6Jq5?=
 =?iso-8859-1?Q?R8txHyuELnbJCL/RcAGoVh3KuG2xCWWYjVRvRmuom0iuc3n5HiIPfUeBK4?=
 =?iso-8859-1?Q?z4Scpi2rsQ+EByFMD0HsKQTgqiwKoEFs03ypGFbw/B4cs8Ru9s4Kqve33G?=
 =?iso-8859-1?Q?7K+7rQ+TRhPF7A37nIIdW+TNcQbbJnaKfafMAyRqUZJ93FBlDapEe9DEAy?=
 =?iso-8859-1?Q?jo9yPgTSm6HE+jT23xC+b7KMLvu/jl0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YYiPXiSlFespZMlZWq4LW+l25PP6P9B4+KbZcyJY1ByXRWexWPqVvm+g+hVbr7Z/DA9OtQCs5ANrXFJaZ4hxl31DeWt7DufcFxrZHJ24EHhMiAFYYwiooxG8UgSLofhEqfJVN4bEjMKyVjBZDE2x80SyHFZYjfHye6a1QdZgPvwpGHBu0F4LPw3eJYbAo8QJEv/I+65GdOj0Xj9cKEFf5injqsBWayr4H9GGqKYMPT+yhn1QlyKLYb1qja8CQTlo/p6OMu9fLOpiP+gjv6kFFHyRe//KmcOxQvEfo1ADhpSNcXyO7HtS3q4T1aN6ihZXSbb/o+iC7Xfdfo9/dWPyeA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D5xvhKISlYz2gyqtofoB5cden/J8foQTzheI8kulTu2T2wSXIheF9vhIfwFojsRQUAfeaRpT53iq5UoHVWxZ3VFiNIJSTHRKTdZTJGVcgOdUoQjci3MQQwjzUwmiS18+9X0GYTrfru86l3UXHOlc+GBTWyoi5KpIIFQWYyt81+hVnSSTbflo1IE6OgRkqkxOIonCzPOPa8Q3V95TeAuKfY/WtZMDhRSI+xY6tcXaRtm4d7o0+2nMm8kwQXClbIM9x6ekytVS5bC/ppd9H3jL+aUG8efcFD2PmEpGvflei7iZ9CkCopV4c9QMIXWLFEpGcdp6/P5ehOYRSjqi2JbfM+N1xgFloI7/VqPZfnvYnWimi7TElBn6qoeL0l77MEVnVh1wPephxK2nwx8RcLSO7/BsotPRst0v6CjEnl9xrPt/smuUSJjiC753xw7Y/z5hz9koJiRDlXWhl9dJDLQRSwH4VB88S4gr2f9JpEeKTuopX3XQnuUknZaW6yAeezsgNyVr6qRp+ZJey56W0ORKCfrtPC+JtblAzjviBqAm4UVP4dpEOBeWz8lzeKht0DGYKZx89jyr7j8aFY06OiH8Ol+Pz1EZlvepOj/VEljt+rFA936pQMmw7+WkXdSdtO96
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c773c470-3775-4bf8-651f-08dea68e3e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 07:58:19.8409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KAx4cp7DCQbWJ7vOFJ+9/DhDHoTGGU0piS/SL88vNenb8z1lYXJKRTC0Ghg15rzlW+x2QjGPL0qvLyCLrOHQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6445
X-Authority-Analysis: v=2.4 cv=R8Ez39RX c=1 sm=1 tr=0 ts=69f30ba1 cx=c_pps
 a=uxO36MsyforZG/P9Ztohsw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=I_Y4LlEPCAdqsIK1J1Zo:22
 a=zXxTFxg3KmBQXHV-y2MA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: IcnHRen3erOXL_5HyH9YIoKhxcGtcQeX
X-Proofpoint-GUID: IcnHRen3erOXL_5HyH9YIoKhxcGtcQeX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3NyBTYWx0ZWRfX0FyX32UmfmJG
 WwwX6yFo8aoy8U+1lR+SM/it1LU3UEJIjKltobFisefxLPojuTfRtBAlwp6ofsmoob8buyxMxY2
 HvilRSoz/fmgvt34t7fKxFWuBXOvkFsXe3sDHfpReIgeaCsGAFF3qWna3z4gtF0bBIU11012bbR
 xTTXDlx/LOyWTPNNwtVU1KF42tOE4AtgYSgylZLTY7+BMkF/owEMTPAHYXh+pzt3TyBSAcTrZpO
 K6wBPDt9R2b1BnRX4ZznUI06WnJofHTgH2oiqOwtoYFBP1lNiCDd8AxwOaOmof1wsxZZBKzIaIP
 qA5YpqaUURKD8A98KhBkxLuACWSjTMmqbLGuROmWxz+azWx5Uamg5MLEr4hdjL7Xat6xE2SgrS4
 itdA5il+HZuJsYNU1SIBVRWNIG3jRERLCsd7rcF6xh0vTD5bce4hNBKj3BsNZ8LWxzru4bqonbF
 LpjY3sSJZUSeTQtlsYQ==
X-Sony-Outbound-GUID: IcnHRen3erOXL_5HyH9YIoKhxcGtcQeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01

>  static int exfat_load_upcase_table(struct super_block *sb,=0A=
> -             sector_t sector, unsigned long long num_sectors,=0A=
> -             unsigned int utbl_checksum)=0A=
> +             unsigned long long tbl_size, sector_t sector,=0A=
> +             unsigned long long num_sectors, unsigned int utbl_checksum)=
=0A=
=0A=
After adding the parameter tbl_size, the parameter num_sectors is no=0A=
longer needed.=0A=
=0A=
