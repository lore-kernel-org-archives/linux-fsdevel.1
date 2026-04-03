Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFCE3451B2;
	Fri,  3 Apr 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210925; cv=fail; b=DtB8VckPuBmvEnWdemNtx9CDroRo1sIRTYzqW03jrhLMZ20tIx3hn3fuNNyKMuJbFpm7XptkaBj5moXqyliHHUXRfdiorrcLNKnKuYorA2GlCo0sBV4Gx/R2UMaqSEWaZRlIe1qkOj+VQuuZu3EtsMBzbUkw1SKMBrAjvt3eQUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210925; c=relaxed/simple;
	bh=z8kLbH1cZrdnZHPnAmEc8mZDJDoh62192MBl9rrxOqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDZKYtWZysme7zmfjgT1Ep6S87wFqgBD9TjNosgYIY78oqw1sbb0NU6Cou8MXZ/F/fL0BiL119Dsz7xQHI1s9aZTNn+PGVXwFIrV2OZ0HHOxvx972iegxWtWTwqftVNeSZUAS7eQJiOq8hKp2WMFlaov97pqBVoPqmKSbGUXZVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=TdJo7Wko; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="TdJo7Wko"
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633A0N20069768;
	Fri, 3 Apr 2026 10:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=z8kLbH1
	cZrdnZHPnAmEc8mZDJDoh62192MBl9rrxOqs=; b=TdJo7WkoMVOJwnQW1xaAw07
	6XCpulSEtpEcONYMW3YXZtC70Aw25X/U403FzJdAeqKHC0LMFz1ajyIKtO4fev5H
	q11KEgM6KxSrf0ooThK9klPk0SWlt3UJhHh8BYEJRXNGZKKrGDIJIi26kwfm5a+w
	16iygzjNyn1X9+wQoRBMxumBRq+ha5JzUIs0R8fvYPbTKswZU4L94lplCh/c0+Uc
	PIjys1jpED4qdgVQTW5PIHbeI3y6p/F/G/1Zkt9hAiC0tq4DY68mjTbKt0Ifn5YT
	xPMjYa/FnDBZaA4PBsHw7g2+Nmx22TBqvJxZdSc0SozR5L7Z0fDWF8V85drrRVg=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012046.outbound.protection.outlook.com [52.101.126.46])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4d65j1ff1t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 10:08:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzIokU4Tf+98ZqlHeVZl/JIkRG+2P/TMmDmWhHJrxrtKQVyeswA4I5qh6/TxJL+ixzikSsUtJrMPXU4fHTw/SYJ84S9GrHH2fLpfeh0ftUfrs5wtohEBsXpEDkuBJ7CaFCxz9KlRf+EUf/3iyCNTa4MKhA75ciNq3aug4d0B3XIxdnq8/vkHu/Q7VXqDaDS1tr4BzTdux5CxV9iA0I9T2T5NO4R6/4vgsJjus4xPiRSKuCgaKbOjanS+4CT7xebOk+TOEHLpdcNGjQbt8kQIKvJWl1oPRO/3xOeMza4GNd49cj2nRydcT78t2CvfDSTVqFrKfQxxwMeSTcK17o6p/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8kLbH1cZrdnZHPnAmEc8mZDJDoh62192MBl9rrxOqs=;
 b=QaSeBqHDgCMhbsKk6IxyHdKBNWJUcP2OqCZcu6OeW53V6JxhGauj4rtRNj7qRZfjWTIpwBxBzniuU34o1PLxFJO4o2Iq7fWsBI+muobZ+7wZFi4pyQ+5Tguyvcf/CubtMp13z8zNCTUg5BYSiPwVc4R3jF8PhBiDBg2dqaBRaXh+6u1HH00Yw7WckrcuqmBw3VgbF/oMXfeWsZVpuSVf35O4wUJFp3nHOXJNzPNH/qj9oPwsljphae3asaNjPpP/RA3G9wE2o2NZ78fuW03OmttcFq6/1o8TiWgoFTptb7DsFvyelJAeyTwTyfqtil1JmaZAXGc9Othc2RYe2fEsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7205.apcprd04.prod.outlook.com (2603:1096:400:45a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 10:08:00 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 10:07:59 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chi Zhiling
	<chizhiling@kylinos.cn>
Subject: Re: [PATCH v3 0/6] exfat: unify FAT chain walking helpers
Thread-Topic: [PATCH v3 0/6] exfat: unify FAT chain walking helpers
Thread-Index: AQHcw0DUgj3/mUiWoESoEexAFYm/t7XNGtG2
Date: Fri, 3 Apr 2026 10:07:59 +0000
Message-ID:
 <PUZPR04MB6316CB848747D5E1520D3FFD815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260403080538.361663-1-chizhiling@163.com>
In-Reply-To: <20260403080538.361663-1-chizhiling@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7205:EE_
x-ms-office365-filtering-correlation-id: fd7695c5-d530-4232-a62d-08de9168e29f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 7x34r3gT/ejSE+SH1ugEO5/B+v0wE5oSKmwDwBcT2fbBoV4bmFBYWJNarCNBW+nT0+PKjciroRZ128PpH1G0oY/PFP12+tFFo3+60U6dgnaaSiCv336xpiKvA//19Ql4UcogyarZQ/xY7XoFRWaXVpFNMw4fBFaZZG4Z3CaJiFkQZ8trmdR94QMvoovp0Hkc76exhwFWqbkEKDCCjKnLbrvnRDRYOMBST2IEIw/23p93wwzoxQMC4cc7h5W7xxzad+yxchb5HZvbGTsy+RYcFoPlQbHED7cdbssM1k2oxSONxpfSZT9+q86IakCnM4cPTl35TvHy+b6qfi4GlFDVK6mcrO333HtLz53B90bTiDqShfzABCOGM43kNB8Fd02kFhw01SFNoTkxJP9TKxZ2KjgDNyaWqFCneU2OpWMJYgnXi7QoQM/k/FWu5gIYPJ2shU+wS19eIx2cXQT8RVn6Y9xHhS2RAHWc6Ge/5dEYIx+Fr4xp8I67aPSmM4yKKxx8L9S+JJbDP6BrEXpFrq9NMNvCt+gyUvkpHFntCesGQwjDHkWowKQwRTB02qLYic30iBk75vp338SVDHqHqH8b8rsptqeftzyqprOZfW9Er2/MgXn0PmaM0QY/cR3VCiVCONCxiKBK78FAT8s3kXuNN1QVkYGs3CmY74RraEHHnPpqnxbQnLpheO+3HEtEekxrxbnkmkGFVZ+cJJsunRSAwjLwCGRbBEIgdOEBfFVx5A0/zBCYtIARMqZFG1oPuxqNZz1DerEObDsFSizI7MVDcnPfrCqKd30TvColyXChEig=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Vd10sKoUTvZELo3H2BDo9/hHdzIpnSWXYqAG3FOGM6b+aIuFIx1lRXxtes?=
 =?iso-8859-1?Q?nXRDtmfUD+BPTEL5wuZKeyhE9AXpm/jvGbIDsz6xyvadjU6XTl3i5qzOn5?=
 =?iso-8859-1?Q?mPhjQsAf1tCZ5d6lTVhPrUPchMld6jrB3UPqS5pa2KQhI8b0WpnssxB0P5?=
 =?iso-8859-1?Q?wIu2Nsi/EVa2STw1lWgq+ZH9pTMosgDITH3IY6OcG26h5eQECHXxQarbWe?=
 =?iso-8859-1?Q?Sw3n172jNlMWKHNSK2JyZwniv9687i3u8otf5T11cYaFW7P20TDx3WJ6ve?=
 =?iso-8859-1?Q?W1U+ogH4ToDF1eeQI/DjGiyNT3XbKcDvuxZAyhArNlBeGoJr14X92m4vD5?=
 =?iso-8859-1?Q?d2QNrqs1SV7GGTmpc7hvWVzSpj7VIPdNvlOzaC0R30RL6FwP9FdYtaMW6P?=
 =?iso-8859-1?Q?RxdJvvFAmxRFaHhlW4Bx/9IeJPvMthwcvcvoE3EXyuMJppl0qUeQoxrNPF?=
 =?iso-8859-1?Q?WvZm3+KLnGpTyIaKweznocLmz9SuHA0mm3RX6GPaITdFU9l5wI+BA4rPmk?=
 =?iso-8859-1?Q?4zgmE5uhC9okDEkEq4uaWacAfoeT2z6UK/wFSdeddAptlUvbXiizrEv4Pm?=
 =?iso-8859-1?Q?Tw0IG3bGnJqd8/eI6HuKpjep7V96QCXnvSHLbUzCQ0aQXRt+WpnY1KoWOn?=
 =?iso-8859-1?Q?dUzTjyi7GzOFTXMhJAkWJl97deFKxWVYRv4FFmUgNs0/e/8km8BFZTc0Wk?=
 =?iso-8859-1?Q?xzLvJn/rek5gKnDt6FWVxus+EOU4f/FllVbAj15DAgWheGJjXx+U5OxexT?=
 =?iso-8859-1?Q?Tq8LBtvsYUJsOKDOI8rAaKl+iThd8KwqA2mV15fdFBTui9D+gzUqiksJuJ?=
 =?iso-8859-1?Q?Acm84RwEBGc7fKCiURWUzMpNWdKBFsRUbjC84R7mrOW1ku11RWdlScaIaI?=
 =?iso-8859-1?Q?FMdVniQ02DLNyDOCDSTwOCayurlfeh9Dxf7XmSfT/uP6RgubYqnDUjnTLG?=
 =?iso-8859-1?Q?soQ6snIf3RAgpdPHYc2HuTGB6k3oyKSXmX+IFNRmz+f7l65E8ZEN5fyB3S?=
 =?iso-8859-1?Q?7PXdEjPdUp51z5FhxaH6fdMDHavD28oxwsAiwjDIPsoCKmxCN5vc83d3+V?=
 =?iso-8859-1?Q?eRu2Tpb7VOf95v3yOx9rfqY++KCU6RAa2ix/wQmIQQE362uLdcEvRKeHD9?=
 =?iso-8859-1?Q?K3Tlhsxp98nNsiF4w2COwE3Tm5Oyal3cYRaoe6DtGmEgV0QetvpZeTm0uU?=
 =?iso-8859-1?Q?y98uMjaY0ZNcp8q6lYgwcP6TwccloDTddmvNbR3EbudrLrEVg6zY/7fr9M?=
 =?iso-8859-1?Q?8JrF6cYz5POOAHf0Bl/W/28pXew8osE/qzhfhrrWqDpVBMsZXJsklZsB+Y?=
 =?iso-8859-1?Q?//MFLuo2wJXWLe8Fx7k63+5RVOwvDYq/Cf3yCrHmEq8rZkjp8az1iDHxZx?=
 =?iso-8859-1?Q?dfnJZ0I2Udb7NXx6wHZkLJTMV3UrWc6PFvniKN5zbOMre6l/eF4nXmWKAX?=
 =?iso-8859-1?Q?RruaoPH6GBm3KjOTqr+JsnSqtKhvu3cGDweMvGksH8gSFGYcnk459zdQCZ?=
 =?iso-8859-1?Q?p8MdQW8k4wPs5XvbxbIvS+ozuo5UKifJvhcQEJXdTpqtg8+XBqUsN2RC+l?=
 =?iso-8859-1?Q?+Xi4pO6/y7UV5BJLyLEzGleUXmZeu5gCkCw6yk+jeX0nEqOMe3XqKzvd4Y?=
 =?iso-8859-1?Q?aCm5spT23krhcfJdwXAvl3FSk8wbbzadkv61JC4/xNsbNtCmpc35pW1tho?=
 =?iso-8859-1?Q?5N+ugW2RuICIE0yE0DBYw2tQKlBSFQeLWkpoBhQsOrWNkPFnmu5hrfaIgQ?=
 =?iso-8859-1?Q?aGULvYHqjDwXqSYaSW+WvVh7o1hs9HjDjKnL2w6otkbVGSxIZaO885VXiY?=
 =?iso-8859-1?Q?uAC79ikzyDJt+tH6lNXJddvYi8sLt2A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	t7Fg0SVG6kXOlmdaY4nIvab6WQl6+FKD0dtxqzsGwXmK93DKwxfxTKJvbWZ6J9miAqKX53611QzeHCtULBO71cYgv4u/SQnT/M2Wdf7stKGHXpP7mrdPnSkt1M8rgs60yr7Syx1skih32Jbwlir94OjWkFX3eF6QnIdQpXUMQ1AIRFLhMQFFdtlzfNhrzZxxdyJdj5/MNqYqz74aa83fJL503lW4eMwu1tF0JV7ShwtefQId/HOJ6VWvl5a2cnCwDEzPBrLDIQj7HKMkrP5OkwnsHEE3xnhmZPviA5RTC4eiRyC66O1Et2mv25UWzMymElD2yot4m7690CTxvJVY+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p7J0KouJfMDOZMlB/986tiRP0d5xixeF5a1S/CN9JC+SjiE0QkqBOMQ8NVp4hZ5Wn6xZyY7lSqI8PDsJqQpUHDynnG408MkdQpBF4kuO9HLpqqKHwMqLQn3rFH4G+EVfnjGU9+Jqr/pC2i8rvM1K8wFgD83zvGnDbjhRAS6nOxGikeiv0M7haqkSkwK1/2Yw3OH9L7FxMCBK/eQeZbhYIDZ0MFgD2rS3hY2HN3h32YnrfJuJW0T5VGC3K44KoWBnnsuh2zwG1if3M2JHZMSr/3LJf+J6787aqoJGcoHQNu7vvdie4vRs0IjIRw9h4Nc2akDHYHAfRXKvQwzWpsWQJ1/Na2jyBAxInmPnB1JAxNQyPXPba85DCb2jp73sUEfy0UhkodMiZi7nO5qCta0DW9mvqy2AU/lkzh90GT5v/xyOicHM/Rvjb3axAnaOTUZHDTBA0KZY/LlEuqnmUDSDXEPLiUfdqCvRX5oXuk1fRkhdAGBoj545As1W1cxmzwZyXS33G+1F2sGpK8NKAOmyJBbfT0Xo6Dm8u5Q5Uv6bOZ+HEuc6NxnT5TOmgGq9v9FArSaIRrDwnLQjgA4KQc9ulSW9HFvotEl1P5PAgSAU/lORH393edQsKkbYm9C43ryq
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7695c5-d530-4232-a62d-08de9168e29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 10:07:59.7816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzIpLgGmF1F6isj9ymTjUiFW8rs6W7tBJPZO5Auc+PA5aP/3XyMJl1iCGrSShFhKlFxhihbi28KPQM5UZeSwRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7205
X-Proofpoint-ORIG-GUID: tDC6EC2Gkb05MoFIEJhWfxLDa1GYDMpS
X-Authority-Analysis: v=2.4 cv=eLEeTXp1 c=1 sm=1 tr=0 ts=69cf9187 cx=c_pps
 a=pIYr9hYmT/mvZOnNJbaFUg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=XGr2FpfLDd2dUKU_94WB:22
 a=z6gsHLkEAAAA:8 a=azEX5703NOKUl-qZ2UIA:9 a=wPNLvfGTeEIA:10 a=hjbc2OpvlusA:10
X-Proofpoint-GUID: tDC6EC2Gkb05MoFIEJhWfxLDa1GYDMpS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA4OSBTYWx0ZWRfX8A3BitN19tIA
 3OvTXln7VWNXipi0AE8Q57kTYbCqYtR1/6mcnXSlkK01wuKBcmwjaIELY3MtJ05ZZjkrJMJHjYu
 /1WGZyrUMmnPcjzG563R3NpdH+S6zPPx8p4vxb1ydNKmSWvnJQqK0El7xa9GFLrJZyC2IjVrUgD
 DYR4n+sB0mUmK8snLU1qowX4Ih6n/pNU/LFHEkexDtLm/5TvlizPh+SsbRyUHmk+XAo9JNmZSpG
 3zfa19w4X7PsA7nwFZFofYRJwxkh6XzbRRCtlIn62pT+lt4MoEVf1Ya6NoqDyxRC720UbPo00p3
 jpuv9yaazAhLW3I71sQnH842fHOi0zirkBaJy9TAzDSrCC8n3pqqZBH089gZfkMqazrMm060bg+
 pLeeuhf0IM15B1xyiNtc+bJEE6tyi580gJSlE/UbXQgw10xShwUpWIRwyzK9F7pcZgafXKJUAgp
 nlt02wmHni89NU42WxA==
X-Sony-Outbound-GUID: tDC6EC2Gkb05MoFIEJhWfxLDa1GYDMpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01

> Changes in v3:=0A=
> - rework exfat_chain_advance=0A=
> - add error handling in exfat_find_location=0A=
> - misc tweaks=0A=
=0A=
Looks good to me.=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
