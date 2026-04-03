Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610E2737EB;
	Fri,  3 Apr 2026 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183693; cv=fail; b=IbJJ3xyAW09vmgRpdCTgnCe90qzCeTV+O5wA8t1MxhRhCDHUGZpkD7zofpqEnzslAwz0J6NjwX1GgiOd7Xu+JJnjHJUUIhzAa9I4lpzUghQKLuz36IvHwnO4yUU0vdsdQu3SfS6jc22P8gEYhMmi2kozIQBZpOmaxDKjX0aNuYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183693; c=relaxed/simple;
	bh=BWx6Ped2a8VQZq+uJX6J6nG4vAZk35llJJRMgb71Ht4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m+akES+62eFWYk8aNr4W7xflqZyjjhu6zVrlaLhY3IDmsaqq0cyUE5X7va7Mau9WtfMuNXPhP5Gcx10vE1ECKq0yKNRAXOeN6dh3xLuIdom/vLQLeSwzKGE3RxqSNoznCSJ9bIKWvJaNXX2coT9WP0LgGPdfnn8JwQCvus/KQJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=qmiOQL7P; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="qmiOQL7P"
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632NriYp2162638;
	Fri, 3 Apr 2026 02:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=mbXny90
	WTNQ6rgZbPAi+xdwJ6xgIzefM3xd/pcraksQ=; b=qmiOQL7Pqvi4LustWOfw2q4
	BKt2y6NObO3tGBqmUvmoIfPMf8k2lggMy4Wi7yWLsnkEnDuS14n1TEunNjaigXD9
	1z+atYtdxmIBpQcIeiM28XbUyUIUeAqY0jz8eIrIX0BsgHT+Qkwj7RcyexsazeK7
	+Z2BH2CxRKyC5CKkY7af91daVDcqg7R3UY0xSDdVq3imL4NcCGiEJfmvMBwfnNOB
	1soWO6MHJOZ2iGiLDaZU6vLCcBq8ITW40n66UMnjF98JNJh2LVkV4fOnAO29u3z+
	LDeFga/fONQOxPjLfPCSatolXWq3yo90Pg5Y3a9ZME3A7XNSKPDsAi1roFU8V3g=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012057.outbound.protection.outlook.com [40.107.75.57])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4d65utyf4s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 03 Apr 2026 02:34:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krx7X1OrenufCPGhGQaqjrEWlNwbpxTYglGNaAhFsfUpaU07nzuMsNXI9ba9qhb5ntl6Dgg300fOMYK8YTCcZ595Q/M5g/Zrvq/APAnfucx55hcdhHvDQyg15LfJX1tX7NlhOsoJS++4gNbG7rtEKqgzARn7UGXzfjV9jZ+BX89n0kvJkKR3/7dxRSy8c2zInN426LNPwrHp6WEwRDECNQhzStkDbOZs4KvPzB/pK63nHYmKd9P5Is7v/Lv/5zb3J0IV1AnxBXWsLZUdp16Sh5zNWDdN2bjpGKyhx1030Tj/csolA97i4SV6qLdipWD0XDP8iUUw5QKa64qZFO0W9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbXny90WTNQ6rgZbPAi+xdwJ6xgIzefM3xd/pcraksQ=;
 b=RbQqloI3gCqrUU+PQcvLICrWPxMpb3B1HGsoqa2QBsBKUaJkvOBx31mqrFj2O0qyr3o1DYQOqCgl8c4Xuqi9ujeIIKT7ELIrLK0TG2cW/TLg8JwWMlwytmpIehUhacWLpq8C8ianmED2xzHgs4kvn0BsacmipLfN48f3gzSX/CuBN3vyoBW5hPF41npSXJNjehGmKTss3i83O+Ix7e05y04PVXut8xlhMw2TKJeiVZ1mmZ00fakR5elweoWZQOOPVxTNMJAxwxL/LMWr6IDHc8bpLKtnsnf7KsR+Qarh0drlH8q/8ZEjtfWsHldI/QP57f5Z+ihbsHss+pNqr5cBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OSQPR04MB8016.apcprd04.prod.outlook.com (2603:1096:604:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 02:34:24 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 02:34:24 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chi Zhiling
	<chizhiling@kylinos.cn>,
        "syzbot@syzkaller.appspotmail.com"
	<syzbot@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2 5/6] exfat: introduce exfat_chain_advance helper
Thread-Topic: [PATCH v2 5/6] exfat: introduce exfat_chain_advance helper
Thread-Index: AQHcwabo2xROJsKGL0yxF2pmXJqQgbXMmnrG
Date: Fri, 3 Apr 2026 02:34:24 +0000
Message-ID:
 <PUZPR04MB6316F93B0D34197D68F302CF815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260401071138.114836-1-chizhiling@163.com>
 <20260401071138.114836-6-chizhiling@163.com>
In-Reply-To: <20260401071138.114836-6-chizhiling@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OSQPR04MB8016:EE_
x-ms-office365-filtering-correlation-id: 290a2389-e8e9-4646-6c29-08de91298532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 AhC9TaR9xmK+vSO3ofwwwc5Y4rqex9gRpXGmGiMn4uzL+00I5JObPVpkoclQgGtLvBNY6qEov4vn8oZd/7DLFzvZsIA0we/BA7nE0HAuW3+cKfLiXt0jAoChl7lRSa8LZix82meUGLiGaUcJmTdNWTcxkdSNk935OxUExRGAct2IjjKT11ICZE7v1ijUKIsCkuu73Y+2mqI8AXmugL19R2yahJqrtmwHval70aQ4Z1FO80YgGYopYHpVqwUosI8FYjo8eJdVx5PrMjUnQzJ/ggJEiXZ5s8H7Fpee7XlBR1uu4Go7FQL4Ba4UunqITVgqnRJnCWKEmSZPSNAeWhaZnqPCSCNl0A9ZbtbuijvzvKjiTpoFmpd8alp3180pmsGDVobqdMK+QaYZcmAcSLDWesBltw6qhHvAJMzyiIQAwV+IBA8mb5CWi/gHRe50jp9DktAb2my/rqCrH8rJxFO7MZwbLG+98xMtn/jKPe5D/77Z+sqJLM8H13OsRyRLPGcsYVC+a9BtLQSH9Mw8iwWfxCF69tAVAgirrOMKbyfvCLFqNh/ovd/8iaY9tzk4Vgi1YEURyhgvTzhEmXwgChy+t9vRz7koddrTLT4p1al69Ljn/yO3T37Yip1jPeDfSmZvJA9g+3dmC6WbBYKwKakys28AnB7YGsyHLSV3MtCu0LSHSWTv2KSY1NCpySHFL/XbD20cqcVOu1YOWICnduoDvrHhtBHCz1+5B9l7+5M5zlRK+4FIdjObnQOLcnLXpZYEnlt/wkwBP9ZuZCQGImSLM+8Cdbs5RpphE4D4VpZcM5k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jTxVIDOS1dJOCpVv7D0CFWR6l6QMcmA09ySLInRNyU+mArMjNxoH9OoDeF?=
 =?iso-8859-1?Q?rvX/rwzdPGVgsUDQXlDT/CLS+g39ARcNsZJqNCE9aLlAbZ1c0WeS2qporw?=
 =?iso-8859-1?Q?TmyWYxhlko/yrCjDFLNcHj39U0rD6KCLx3NM1/Wrl8Oh6HtGPumqMUGysk?=
 =?iso-8859-1?Q?lFP/GaIYwKKhEhSuYxpbPHngtgeoilK535x/BlA9F5OQekHLVL+2eyRx66?=
 =?iso-8859-1?Q?uj/mQhxryVkPFY6A3zkGadGgst6DZQHT86OM1ubm6J9FPP/Om+rWMI3wVj?=
 =?iso-8859-1?Q?P/9H3thWuBj+jNI7UzXF4TzPFg0GfD8/Ov1kBCU5/qBJCnRlWGNebDQjXJ?=
 =?iso-8859-1?Q?uV3BDgAz/RhX6FYy9CiP4DVEgytKCi+nlJlBdHawDzpElMPM5m/DYVDkt4?=
 =?iso-8859-1?Q?WDv61V/uIAlilv/Vfhjy8FbwnJUy59Ekt4+Yx/LgzA2pvREZBa0ip26f9t?=
 =?iso-8859-1?Q?v68dlt5i3nzcuxZtcGrscTdPgZk/tCGKyf1i7T3kAIrpdzKLaWsa5ReKQA?=
 =?iso-8859-1?Q?jZqhAqvNTOeOdoxniZsN1j8JOtPQFLnfgV1Q6EkVgWVLDUteTAq6F7OzG1?=
 =?iso-8859-1?Q?bjZvVuj3NBtUpzxI1J5gCD3yqiQSZZqKFDRlEn4Tlt+nW5Gi4FslrIVzdq?=
 =?iso-8859-1?Q?e7TEo55ztY3++ppQgghg83ck79uuon8lHhoFSUZuL8rAMLIgrW+fB03+ha?=
 =?iso-8859-1?Q?dUv+wykde3y7R0FCiG9XloBDKJOUB9bgkMJY4jrF53M5g1xeiAGE8BO8f+?=
 =?iso-8859-1?Q?k6Ci3JsOeIj25DAHcJF4nH7pWgRhYfzTwhDGfjJUsRohuLTJV258/NdqYA?=
 =?iso-8859-1?Q?tz5Gn2JwAXkyltKmmeHGomWV8whe7vieC6kCzpy4DaYpWpyRh9Y4LalU+G?=
 =?iso-8859-1?Q?lDPTPJjIYOaQ+cFSvabftuil4DJL9L101C/IH1qwcAu0JXLISCTuqVmAp6?=
 =?iso-8859-1?Q?3t3AKfrf3BITqjvc9x6mjGgtbIO0OIcps8S+SHsQlU+5UUwhgK5wjGNTV4?=
 =?iso-8859-1?Q?4JkLy5GBoUSKAo3HiWH3qDKKL0v87jyolGM4kJWjphPDo69i2eomtXUsXf?=
 =?iso-8859-1?Q?PVkE8uSBWLswNI4cl6gQxZvBa4+hdFYyF41+a1xmZT0/z2bmg67hJL3UfO?=
 =?iso-8859-1?Q?xHazC7eGAHtnsyFlz/mNBHSe5/DNNQb5kjA3KqGjuhlbkKB3y/rRSjpqK+?=
 =?iso-8859-1?Q?/6Q+6sLWigUI+xXNvxVAOJoKRTQmnOroLas1ShXsLA08UMq1GUXboFcqfK?=
 =?iso-8859-1?Q?4BObKXs+U000bNn2dIGcM2iDpdUEpAUQxf5vIrmXATfPz08ixoD8f77qVa?=
 =?iso-8859-1?Q?yXKBwRDygJv9mnz9VmX1nDS+aWScYVeF50EAP7qB9/YXhJqXQLukI+Hui3?=
 =?iso-8859-1?Q?0E8NKamG+Qpcm3HSObzQc9gytCfXr+xlhIJLZGDC7byVoCRadiFw3NPAAK?=
 =?iso-8859-1?Q?zhZu9sdYzrZS/T7192Ov6MoeAS9Wfncm8N5AuCGl5Ty92b10h7EmJHlJa/?=
 =?iso-8859-1?Q?XasZXVO3blQDTpjOLIcplnx3hBZbB2oj2/gmBfsxhGZ5EUhPV9woDo2oGq?=
 =?iso-8859-1?Q?M9VRFbyVuYhYkZdkePsxpH1qI9hRS2YR/SylNRiwHfIa2OWnTiDPKBNtoY?=
 =?iso-8859-1?Q?VApI6eeasY0K+JehwRlnyCkoZVGaIf/XVWda5dfRuoo/ZsBJi7w+CE/Tv7?=
 =?iso-8859-1?Q?pUFnRmN/PGytxNvHldaEJ83V/YAiD6RDB/REGxz1xZyKr71c4fBoW7sObx?=
 =?iso-8859-1?Q?bE8z98+stuwzeelNiPecOO8CB497dwr4x0FW6L2ODEzSlPIsqAYbvNc6iZ?=
 =?iso-8859-1?Q?8dyGUzXz1Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CuNMmYOUFC5JyCYITRcMfhthHebVBrrjaL2OKHUEpOgztGWDVceXwiTp7XGLLmBse213pF6h8q4lGkF3J1OETtsHJK6JGh5KAo0fQSThtKG37pdAz96EpU9Vfkpvdv49rXmZ18qpYdu1B785fBYKxz2+V9ulbJNbv4rMXDaI9wuWzumawMK+jpSWRVNrtNHkFxAbYc1ZwqOeFlDkNLsXVL5gF1CISZCoaw0aiIyLfuZMeVF8hktit6IomolqocYc79PxCM0pwOLM5DbjQCJ/+UihuflY6VkJTeLKdSNxUhbdvpF+fSEgyMZCa7vDZFhEUZxPBzRcCyzTSu6tgpK0fg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tkz0xw5Hi65BaufgeJIhJY7UKTHEZ2S6LPBoqkE12bDRA6wvehkkX1dz9zfDfzxie7kvX1jn/CW+gWJask36NESsXN4vvgeXwy7BqXjVu0W9Tc1GtGfpcpKhpL2Rp09Zr6sytd7l0JWzWv1hvFwWl9j2isIh99VVMGYKZLr4f3SSGITYbrzBQW6tfwelWaOI8fYSU37U+qsPM044N9prHyiHb3/cUZ7qj/AwWQ/GUMwvK4U+/KxqwjqtKdwmfzcT8Ye59R1UOqbcpr1DqKuPGvyZBokCNenD8EJiNs6Ibz54ZnSiWEzu8oWbcDUsEYu6c5m4ohjfHsp5SxK9L0hOmqtJ6dgpCFoD7zvGpBBhk6RX70TDUyA8Ck9dpqjDb8GmdDT+XkQNmSucsAB5fS+1aqhJydAYs58K2gcGeE+yeJ3SCSUUR0LNLSRTc/SqJzLbLFRo60EKXRCOuV0Fqi+GfFoi2lhhdiImT6dud4bSAgxQPlRjzJTcluu4q2BWb4k5NI5ealqE+CBKFkmxS4QoGBkgYPviEecAscNERgKAyuLg8W1ueejoY3E2RATlxJrWm9ys8yB7flv096fVIxXHMmcv7OHE6KZqth90sosLwPbo9zqg3CcPqin4DgsvITwf
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290a2389-e8e9-4646-6c29-08de91298532
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 02:34:24.7114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: No4a3AqvNKeYyd0258JyDIF/1fqtbR3pa2YiKouT/Y7Pm6IkUVHCbbWNVGaOhUB2A806egsqM+hVrPQIA2Ti9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8016
X-Proofpoint-GUID: P7X8RGL5DUwWlerbZ02si1jGkdm3W3wG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAyMCBTYWx0ZWRfXx4J5p3TMELA8
 a5J/+kO/2rKOnsrVKbNDFiXY/BF40ZHlTQnHq5x2mlXFk93l/H1AcgXv0pzPZlcCc2r5B6X5Z1+
 jneb93qL2Qu25i7J19rqCCl5YbKVcShi4TxmckC50FTnsFbR6rsxZyoYBb321w1lhpjJXELCLVW
 snTLEBWCDEAPXQXd9sFrp1t01Ks0rPdd9obrBDIVknAfzUk4dxOkmYQvvfSmfJBSIqNonjGkoa0
 MhU4uledt5JHQxrrYDxAlWbG9Tkpxd43mYPZUx1x/dQv1YD3h2IC2dgq8SPn8pzvn/+PaXnkwzz
 Ut43D2GzGphMsN+2LF7q6y1oso5HDxjlbZS0h5vIkUl2T+j8mxFYxd7LZcHm/FyobR3s26sq2BR
 jxisTp1xu+6KZwLGs6RIkETl9ALKVLHhblBBXPEsGjW+ZxFWfvGCEi5iBU8iboWofIcR64V22gE
 Ea5okrsxEMfK2mslOGw==
X-Authority-Analysis: v=2.4 cv=X6Vf6WTe c=1 sm=1 tr=0 ts=69cf2736 cx=c_pps
 a=yzFcANwbdDXkjV0LA80XPQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=b20fedWF67CaGdYoUt4Y:22
 a=hSkVLCK3AAAA:8 a=dQbab-0cgPcHtsIc56oA:9 a=wPNLvfGTeEIA:10
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: P7X8RGL5DUwWlerbZ02si1jGkdm3W3wG
X-Sony-Outbound-GUID: P7X8RGL5DUwWlerbZ02si1jGkdm3W3wG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01

> From: Chi Zhiling <chizhiling@kylinos.cn>=0A=
> =0A=
> Introduce exfat_chain_advance() to walk a exfat_chain structure by a=0A=
> given step, updating both ->dir and ->size fields atomically. This=0A=
> helper handles both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes with=0A=
> proper boundary checking.=0A=
> =0A=
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>=0A=
> Tested-by: syzbot@syzkaller.appspotmail.com=0A=
> =0A=
> ---=0A=
> fs/exfat/exfat_fs.h | 17 +++++++++++++++++=0A=
>  1 file changed, 17 insertions(+)=0A=
> =0A=
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
> index 530459ab9acc..1035d20ba563 100644=0A=
> --- a/fs/exfat/exfat_fs.h=0A=
> +++ b/fs/exfat/exfat_fs.h=0A=
> @@ -552,6 +552,23 @@ int exfat_read_volume_label(struct super_block *sb,=
=0A=
> int exfat_write_volume_label(struct super_block *sb,=0A=
>                              struct exfat_uni_name *label);=0A=
> =0A=
> +static inline int exfat_chain_advance(struct super_block *sb,=0A=
> +               struct exfat_chain *chain, unsigned int step)=0A=
> +{=0A=
> +       if (chain->size >=3D step)=0A=
> +               chain->size -=3D step;=0A=
=0A=
It would be better to not change *chain if return an error.=0A=
=0A=
> +       else=0A=
> +               return -EIO;=0A=
> +=0A=
> +       if (exfat_fat_walk(sb, &chain->dir, step, chain->flags))=0A=
> +               return -EIO;=0A=
> +=0A=
> +       if (chain->size =3D=3D 0 && chain->flags =3D=3D ALLOC_NO_FAT_CHAI=
N)=0A=
> +               chain->dir =3D EXFAT_EOF_CLUSTER;=0A=
> +=0A=
> +       return 0;=0A=
> +}=0A=
> +=0A=
>  /* inode.c */=0A=
>  extern const struct inode_operations exfat_file_inode_operations;=0A=
>  void exfat_sync_inode(struct inode *inode);=0A=
> --=0A=
> 2.43.0=0A=
=0A=
=0A=
