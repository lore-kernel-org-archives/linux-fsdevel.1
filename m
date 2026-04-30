Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA53FB7C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535918; cv=fail; b=kNTAMOYiGtEt0h8GZMWb/wEiMC+sqkT7Dv/aHqTpwh4+BMAqxYnoQDTPmDf7Z2nzT/aN578GCwfFglvDmSdsjhDaOXfOjgXrOYUeE6ByulRQ6aZvs45eI3LhhO09ra391E1YWGdLRt3mp+BWuI14KrZqcF2W8qMFBaV1JZAuTyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535918; c=relaxed/simple;
	bh=roApw7eAj/vljvWwV7BU1HULGNHodWINAT9VDQpXDio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m76MtSok5k+/Sxp0YeTLIL4EKChtumOJDhCXNwmBYeWKll9s4DMZm3Y5IhEX72P7i+BXvKsRsjzxHpeMGAyzdRy0rmnAsTh175OJZf38Blf+vrwQXJ7CIhTlhCFUj/ZhwyRwBr6YVnS9do9ITf3/bVJ8251EqolFWocbs1r390g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=K3/ExgvZ; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="K3/ExgvZ"
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNqHEe146282;
	Thu, 30 Apr 2026 07:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=sOoQysk
	Z7adg8WhEuNopGVti6zlpLyJO9d6XABDOzGA=; b=K3/ExgvZG1oVVWvFYyB0rri
	dcskVTrJ0jN1BcaJTGWjjC20MinM74DsgxMBpc09o77xFDzs9j3w1ih++KKeCFI+
	kQxAFn9eBMEmZ2VaQID/Lu6nJQzABlK215drQ1oHrfNA+/mFqV4QwXZ+3OBEqyKG
	/Qr5N9FDkNRTmx3DGh9iJa3Cr97bUOPLsRMG4EVvjMXqMmy0sGjERHEXIR7GMxS6
	yTxP55b+Ztghknq65LA/PpC0szvTkRXVuP+wYyiNtFgUFvVxu1mJw93bUl0Prm9h
	B2AFoTadKwgh4BdRpiQlmh56uJ78rVF5F07BsrcADCMLKWfWPcg6OuHdguGSVkA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012055.outbound.protection.outlook.com [40.107.75.55])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4drjuwwkj9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 07:58:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/PIrXTCzUqV0PyWVlaqiT9rEREcP6xxOPI8kUR/h9xwsJmtzXQNR9n1G7Caiz56C33fPPEQdH3x52KoUhmkMOt+CgB9/ZlhCwML0aadzFZU3t5sa30jk3o+QV0n04ZLFFL8SdlZbcrE82CGXClxYlMLeqkvA2wEJO6xqW+mFD97U2q0QglPNwot0LltNjOfkC25g+bVgrR13UsitPQwD0nDg058vUW+eyD+gJtUwX1sfyC1SpaXt9kvqewyARKsZKF9fm5pNHN18Zvew5B6j+gLZeJGG4bDVoH3jhwybNDKOz20c0+20Enny8ZwH2mPQD2qjNFQBklIC6h9DQuXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOoQyskZ7adg8WhEuNopGVti6zlpLyJO9d6XABDOzGA=;
 b=hwW5RRd3hM4ktAqwMnlaNRhqt+286sKQtCvkO7tiYe1QGTaAJV2trnvLLlWwlr0SRWmlx92wCXGTFQTnKEV7LjU8MbjsA5iR8xhyM0obC9Qy50iGL5ZxYWJzwyB9965zHSwz6YuSuc3ddVWbkvouKK0+OFMekLzWTikEkOxtjjk+7eB+nlcemanYEhMldt8uS83fg40qEA1mhQTmr/z4lNrurZ3XpFDjZGThmpHRwArbin9c5rPPeDYlJxC0zLTq3UHL4SfceZgtzoBbtX5hU/YK823XC2G8vKQ/0h7C4xT4Fz+OwXBQo7zDhHGAy0rLzQQKskOY/g4Xy8fWfoWGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB6445.apcprd04.prod.outlook.com (2603:1096:400:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 07:58:04 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 07:58:04 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
Thread-Topic: [PATCH v1 2/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
Thread-Index: AQHc12np1ZnUrgkEIUykrJx6T+bQ5LX3OoFU
Date: Thu, 30 Apr 2026 07:58:04 +0000
Message-ID:
 <PUZPR04MB6316657C9EB764F8A3A119AB81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-3-dxdt@dev.snart.me>
In-Reply-To: <20260428235038.93816-3-dxdt@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB6445:EE_
x-ms-office365-filtering-correlation-id: 6770b7b3-5f09-4a09-39d4-08dea68e353e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 KSA5tjayj75xBHhDZ0U01zo/CNd83wGtL2A3mhytF/PJvUi7t2utk6Wx6/RRpGGSfVYa9vCA5wJVOxmGK2QzQ0SyVWuoQdU9IQ02IcR/1Den4NXhtGjUGxFSN7jbQbpCgGdCUCZ468OxkjtSziOFnjN4dkZaJgL4MuDoL54jz837A5wz5XYDEMRdrHxeBrVHubKiOWe9Nr2ujr0WZ4DV0CyYdcVmqF/zcNFK15E7tb3r5OsgP1lD5tJ0MBmRbcP6VlZ5hHs+YMArQAAnwlT+WFznf9bIxir3/DOpy4exAteQqplHVE6RMIDOk4NXMHlJTOHvsmGpBPC8uWG6wJWxQ+1HQ5GjPfOxB7PT+6DmQchukSRhA/z41QPqMlxgsC1tq3OTuw/qaZ9KlxnRBdV0xjsjX25tkATZTAWlndnOYx4axF1BIqtX7kNh0sfHTC5UXruoPcoZWG4nGXvT5L3zsLeiPqxKlg7Csdd5Wo2lRQf8TqmCPYc7BmPYITTDKaY79wxEFWWwbo0WUGzPdfFr6iY1vF6ZqJjwEoMfyr9/Cj9QkqZNMZNRcCzHLl+NqXjLVPsAlFsmLn+8NhBGjYPdjeac7ApzvojAe9+QRljwdZpjbmTe/yb0lSHlipTGLWrj3CfrT6kocU10TVTqieB03iMQAnoCNaxrc1mQwUEdJpRT2ENeBMVXdXT+3XmvanGbaxTimMLiVpI60ifKkdmmsAzRgnJVYNnuhDxQ5bjyc8u0UIpjJQwoQG1p2aDOB18Dv4+66E3dW0RS9af4/u2HfJ+vBd3Ys7PTmoJ+OckCyF8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yK3S0exYmfYe7tF50uaCkWwXZynN3zmpl1wnoAOiSu1pL1VMnP+Ch/Bhaj?=
 =?iso-8859-1?Q?Tzi1yLQMxczvqw/CXokhkF/5BMmo/W+SSKJMTroxLjBEpzyqG1jtpt/M+8?=
 =?iso-8859-1?Q?SKA7+NXm8te1NirXqoyZLyjNuHDBFCNKx0fOAyRZvBWby/CR/y+isJDEI9?=
 =?iso-8859-1?Q?4mZsnFLEgrMyyiamD+8Y6DN31pL8l6aOSKaeewiH8JWIYqj103TYAIDkoi?=
 =?iso-8859-1?Q?Ywhgnugnkd+B6xlD3eHNauHLGARKEBDUI+6680i3lU/dkM+sqoQTHohvRl?=
 =?iso-8859-1?Q?5NC5I3g6EN0erTZxYjgEW4KAZZ3vJcdd6H3x9oVwglufxOxk8V4+Rlnbaf?=
 =?iso-8859-1?Q?dIUYt1YqqWukDkVasJBa/f4YtXgQPvzT3ZQfZma1t89IOPPxtmZKWq3esL?=
 =?iso-8859-1?Q?9sVpvI/GArVbTjujCtzgbugot8gV8K+TsZy2LntRDYId4U4ysc6BmZXHpi?=
 =?iso-8859-1?Q?gLIf6gl+M9t9YND/0FRy9fciM7yUEGgBVTQ1CLQTWmhtZ/zVhJBMyulVAg?=
 =?iso-8859-1?Q?BPJ2PTD51ZsjUknPl2r0UxRzz74GlhSGf0Hv3+UKSgnff4V7tXDCCROmq3?=
 =?iso-8859-1?Q?DsuM6jrMIfto1QJcjMdK0hfUzzMubyWnksYpvtvQJXw/6j8eL0sPq2jwfy?=
 =?iso-8859-1?Q?9uXqjGo4IUEoQtmTU9IEdtdBXx/UcaX0Uu3JwpwWTD+3M1QoC6fydkeGdd?=
 =?iso-8859-1?Q?NEG7d+Ejb1S2AYoL2KO83Cam2RmgN/n0nAXfpD8YDMGjfK6GnNLGq03/Jz?=
 =?iso-8859-1?Q?Zfa4/HSXzg98B7LdiurADdf2hajpaqzqxkTc8dC+w77q4bsfmyNQFwDHJV?=
 =?iso-8859-1?Q?WBikDKVPc8vdIiJRqU6CqAtjTzNPJVjx+Of23cMGBDnS/Bx/zFhcf6nuu+?=
 =?iso-8859-1?Q?ODnC2fG1v1ddIXas2ZH8pAgwkY/Vxe1gAk2ZfkBGHD8i9nxjG1WRZ49qm5?=
 =?iso-8859-1?Q?uoo9yWundFRJ65nLNgIETjY9w3jmvrDM0yNevAvh96OtVG5WgCVH1tn8qz?=
 =?iso-8859-1?Q?6x1H9Pvti5L4Bs2h9MDSG3VIzW605QTdMQSLuIokFYt3inVAZQuJnqdo1T?=
 =?iso-8859-1?Q?Aukqky0/AfjNmJaXQb2Nf66iUqcMu2pshuSdpRIMPvlT925lqCQW1+591R?=
 =?iso-8859-1?Q?a26y7brOoYxhn52ggJsnHZAXPkm0ZvcpyOUSN14Tah1zYG1+uN1Q3+1ZPJ?=
 =?iso-8859-1?Q?GyLDxYwVYoo8/rJuh+FRrsT3NWQgwrowXdS0UOTQsMBJdx+n57B6j8m+u+?=
 =?iso-8859-1?Q?MIlXWkKCORcuxyWvzGQdR3icPnJ2AxEJpM7y56qt9+2ZESOBrPHOINQukW?=
 =?iso-8859-1?Q?7i1e7XpIKQXj1zFylBvdxHZDHOvgZWsos2Swd08Y9u8mQMXYVLR5bFFA2D?=
 =?iso-8859-1?Q?xl1gdgRnQJKd4thnqjHtBUzQVtsVtVg4faagGNCIiwvyI43cCV7TuZcR3M?=
 =?iso-8859-1?Q?ykr1v4NCMaT0yb4q/Xdfw5sYTl5BXJZ8GVNT+J6jtjKjzaGJ0/MihvGLq7?=
 =?iso-8859-1?Q?U07MR+UKRgke8GIlqWMfxZB7KE1GKmwnK6qr+8UUmCAxZOaWo03Be1y1Jf?=
 =?iso-8859-1?Q?cCrg1B3yS5nmED50/NbA4dSnx8J+bNgzYIbpu3OddWgLX0tE7Kyop/cLd0?=
 =?iso-8859-1?Q?+CHvii7niQ+B2yIEDEzGVT3AOqyV/QtrU8pXoKnMTZrJCZjIa76lcHvaZx?=
 =?iso-8859-1?Q?raIHM+jysO5x4HAMz9dP4xEWsIqv9duoZetmUMC3q9auo9RGxFJLwtTrGo?=
 =?iso-8859-1?Q?wnu3UXl7mMfZ1dpzdp4lPGLpwXZGa80iHCP7Ax88xC3iqKeLcDTFtHpwGW?=
 =?iso-8859-1?Q?GgXskWoM74Qjvo9VK+4pB4mtDOkci5A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QpGukqSF6eN4ee7J3Xw+gTfYneCGWPzxsKsM+edv8QHf2bmD8zEpbUDxqIdFFsQ6OBUHW/30JJRdy01rxW3KLh9qEN9D+9jWPs3m1VA5ZSei9OBpWiKP6KvzS0p/EFAyc8UJllOpSbPIsW/snsj1ewkfTm0TEKuvTo2LsvpDFoYu1Z152PxtqYQN6/1D+fQ9Tz4C2OpnA9fasGAF05XZyJUL/gPdBW0JL3+APWArcuqP9CRNSyUh212dUcgNwsQuG3pdTSyZ7ey2lHec2NHE6e1PxntjiAcfu4QMf7q9tdJ6mEz8LH5E1Jiq2hXdS2aYvGWsxdzpkfXOxQ188+MIEw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C58p0zmOVcDyEMU1LSZ8pWsADK4Zqjtatgey7SwQgdAJIKXoz4/7bo8FIGJY/98f2ZYCWLK/7Je+XzR1hFouTJDXnGGczsIOReUb6LBXaeqWppIkPvdW/2GKPZ+QDI045rGg1RqM7Jeq+4LqNn5UuzI7awvloSop+pY7Le29de8S0ACOiywSRqFjGbfnUtx6v3NM+yVSWFSYViKSz8iPClFIRfw9bwEgDa6G7MdiyPxmY/xjnG9ZF1AftR+BipQj7Rkja3TI3kfTr/btk5Htxm/E1/AkLbUDCCPnUW2gD6fpMPpA6a2G7/WykeeIPECLpdlXLXjB+Y6yh5MsLTvFIJbp21MUdiDL+doUYdbGW/WC28fawTbQPYYoosAdikJ+adGm1OKQcms04q5cSIDvB2jOGQf6wHBE5IkR7xgCngsCS+CG4I1LxlGnyoPokEBx9n2ibpMIttZgRPVA7NEbb2BzyPyIK1BD6swZuGoUYZJBpNJqZ+VFvMCqTkyRTxVu0d2Jnmnbang8immz+gsrQxUJVmPyYYeqvm1ySz+np7XQZwROXnG0QEb3BTwR9pLOuRvN6yZ/bP5TPrA+IrCt7tJUPgtzahUi/q6xkc/QUcgIqcZDzTDH5XSg5UoEEgZS
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6770b7b3-5f09-4a09-39d4-08dea68e353e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 07:58:04.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYenld4075k/9tiMg538SSeUd/941lk/4kXiRAmtRx1nlqRNV8s8kFJjVUxSq1jyf5dnQE0I818orJf5qPRv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6445
X-Proofpoint-ORIG-GUID: 8Nuo_N2c08yJA7zh4xOZ7BgBoJ9AxRty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3NyBTYWx0ZWRfX6Fj0bjuo6dvp
 8JOmp+r9opWhCBKyIoLaYNxY9vprC7DXcOdj2i2Om/rvanFsUsMCzYw/Q6b4ObLbfQMJd/TQ6Ow
 2TUvtFmxOTQG3sKLVYENroDd1Ia5yj6FWmp3It0GifUh7wtqBQ1ZL9zS51OGo33J+ODf/jsbLuM
 lpjAOkonadvY9fdd5r+0OaBz+etvXU519//VbfrxYZixcrL+6tqXd9jYeyqLaDmsc68PFWflP8c
 EUzfuiS6o5QDbltvzqT4rk3ebffUe22Og0UCp52Ilc0DN1F7Xaf+8udkrvtVqlsvc5Vlf/fApMf
 57eyD6HyoqhknDNLrUyzqaveyz6+coVzeKzLQgB4YxMked+AnBYh9gjoMNpAbbWK4AztTcTBs+Y
 VJrmPcjjd9Vg8B/jM5Ns2fctyC4xlxi4Ik3FX0psdwErdtFwpiK7lH2jfKJhBPtTV29LSZcPczm
 UNIaa5XhcbTvB9vf/3A==
X-Authority-Analysis: v=2.4 cv=PZDPQChd c=1 sm=1 tr=0 ts=69f30b9b cx=c_pps
 a=Rs3nkYQqYq11W3uOqABXuw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=FGjXJT7Bex8XaPnzAX5M:22
 a=kzz7OiJGBeZKKemmW20A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 8Nuo_N2c08yJA7zh4xOZ7BgBoJ9AxRty
X-Sony-Outbound-GUID: 8Nuo_N2c08yJA7zh4xOZ7BgBoJ9AxRty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01

> +static inline __u16 exfat_lookup_upcase_ptable(const struct exfat_upcase=
_ptable *ptbl,=0A=
> +             const __u16 index)=0A=
> +{=0A=
> +     const size_t page_idx =3D index / EXFAT_UPTBL_PAGESIZE;=0A=
> +     const size_t idx_in_page =3D index % EXFAT_UPTBL_PAGESIZE;=0A=
> +=0A=
> +     return ptbl->pages[page_idx] =3D=3D NULL ? 0 : ptbl->pages[page_idx=
][idx_in_page];=0A=
 =0A=
How about this? Then we won't need to check it again in exfat_toupper().=0A=
 =0A=
return ptbl->pages[page_idx] =3D=3D NULL ? index : ptbl->pages[page_idx][id=
x_in_page];=0A=
 =0A=
> +}=0A=
> +=0A=
> +void exfat_free_upcase_ptable(struct exfat_upcase_ptable *ptbl);=0A=
> +int exfat_populate_upcase_ptable(struct exfat_upcase_ptable *ptbl,=0A=
> +             const struct exfat_upcase_range_info *ri,=0A=
> +             const size_t cnt);=0A=
> +=0A=
>  /* exfat/tables.c */=0A=
>  /* Upcase table macro */=0A=
> -#define EXFAT_NUM_UPCASE     (2918)=0A=
> -#define EXFAT_UTBL_COUNT     (0x10000)=0A=
> +#define EXFAT_DEF_UTBL_RI_COUNT      (112)=0A=
> +#define EXFAT_DEF_UTBL_CHKSUM        (0xE619D30D)=0A=
>  =0A=
> -extern const unsigned short exfat_uni_def_upcase[EXFAT_NUM_UPCASE];=0A=
> +extern const struct exfat_upcase_range_info exfat_def_utbl_ri[EXFAT_DEF_=
UTBL_RI_COUNT];=0A=
 =0A=
Is there a way to reduce the size of `exfat_def_utbl_ri` so that we=0A=
can put it on the stack of `exfat_init_default_upcase_ptable()`?=0A=
 =0A=
If not, add `__initconst` for `exfat_def_utbl_ri`.=0A=
 =0A=
> +int exfat_init_default_upcase_ptable(void)=0A=
 =0A=
Add __init.=0A=
 =0A=
> +void exfat_free_default_upcase_ptable(void)=0A=
 =0A=
Add __exit.=0A=
=0A=
> @@ -896,6 +896,12 @@ static int __init init_exfat_fs(void)=0A=
>  {=0A=
>       int err;=0A=
>  =0A=
> +     err =3D exfat_init_default_upcase_ptable();=0A=
> +     if (err) {=0A=
> +             WARN_ON(err =3D=3D -EINVAL);=0A=
> +             return err;=0A=
> +     }=0A=
> +=0A=
>       err =3D exfat_cache_init();=0A=
>       if (err)=0A=
>               return err;=0A=
 =0A=
Please add error handling to release default_upcase_ptable.=0A=
 =0A=
> +=0A=
> +int exfat_populate_upcase_ptable(struct exfat_upcase_ptable *ptbl,=0A=
> +             const struct exfat_upcase_range_info *ri,=0A=
> +             const size_t cnt)=0A=
                                                                           =
                                                                           =
                                  =0A=
This function is only called by exfat_init_default_upcase_ptable(),=0A=
how about merge this function to it?=0A=
 =0A=
