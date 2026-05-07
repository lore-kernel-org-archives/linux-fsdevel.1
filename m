Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DF3EC2CA
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155467; cv=fail; b=ERmwAH/sGHuTsVMDGWWNRN/hXPzqAfH1GU+sXS+14moI/tev5mRBpfc2KpMrh09FHgRl9i3yO18RTf3DzN8+dGZGxc7XVqK419CFqCWI/raG05u0puqRL4YOyHLAwMmGwKkq4IFlbQd9UeEDh3OZbvusOblFe03vcymr3SNUi4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155467; c=relaxed/simple;
	bh=Cfd+edJUrcM7bDH810z9V6vE1nZBO+KGY/8vvhUcLX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kOEFY2SqQBvuj6TUpbAxKpqbOYu/ZnodRULF0IwF7RF3RO2mzLdeT6VU4r8zgXbDjt5hjQkSuG3NW6zXxXATaPo3TBhM+mwZfCqhxcqAbzVNfS6rMumbFZ6mrLsaedEkmr7UnIRu6b8iYDoSi2rEqYOv4PEvqS/9ZCWjY79o8iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=K4XeDwir; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="K4XeDwir"
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646MpNxJ3829214;
	Thu, 7 May 2026 12:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=VcONH8v
	7oE1XzBEHd7BhDxvAi4YQNklq2ndtvH6XlGI=; b=K4XeDwirmqy75wsDam9au2/
	GhikZZodLfJgnAMYtjB59yHxbmUYxy8wTmXYIcultvjUgrhyEwFZ+HExPdj7KZVE
	yv3UXoQKP/xVh+KsNRplB10y2/DpdtGOkY+Zzbuuud0gznnrwedZE8LXOyVbANZW
	pEmke/Q568K9+4QFa43e7vKcZDwuQ1SETyScJMvuveug/jGzWZi6vQ+r+zJGTx1f
	OmXYaCblaUex1WwIS6CENVgM/04R6Rz/OcldDEAYcjy2twDY8hg1+3+/534LlMno
	4b1wqtfgnkSuRkcA6/MCTHPxz4JWYZJL3LhqLAKdJfmQQf79S3gcgrbgVRlqjTg=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012014.outbound.protection.outlook.com [52.101.126.14])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4dw9f94vu6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:03:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RogflQ9ggiKeXs1kmmPeYc5e8Vf3oXxFa9Aml7nSRKGQfQjvJ4sEh9Czk9YN9JMsnugQvNjrhnkVVTTragW3DTNdlgOY0xLJbgllJ0XtNDx8nHYts06jMvKtNWYkXKGVF30dbbjAKHBQvBfEdHAgMnlOP+oM8r4AapcHFTINewV0X2x9GedBeyL8BOzxyfOisb0DhFlE40hRK2a5Qgq7EwhR+zy2qHh35fASheW+tJSX/JUP2r9AL12hWnKqRcQkLjid4fDCOwhF9lvNG11UZidJqN4UDfd57l2C2qhkIILOb4h6nPT4P7IwoG0BJATnm4Ewmzn5AloQIs7vhk8LHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcONH8v7oE1XzBEHd7BhDxvAi4YQNklq2ndtvH6XlGI=;
 b=EgcaBmaeD8dyD6AuuPDvO6yG0MYom6B44XgkOFE7ObMMvNMSifx+76X9P9lQSd4ZuXJNS7J/qHlto06xFJu04tlJQSm5ucDyWkVCP4GLMXPDZhAUnxFn28x18qc0YEHuDKEG8PFCBzAbPRvHH1o0BFAuO4+yh5gFBwtfSZ5eDHT0xevpUaDawp0uduwclhQv8rfWAI33trvjxH29VyOrj+6vM0Vm4NbVx4POP4rROk1P17PTf+CM2JwyVRE3mR+YdloPiD/6NiC+hipUFQMmoZ0W29EMS300TdjhwuDZk3IfryHQJUeE339IltzedQeAvJCFRRLlKM5emEeRQJf57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SG2PR04MB5663.apcprd04.prod.outlook.com (2603:1096:4:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:03:47 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 12:03:47 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Timber <dxdt@dev.snart.me>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] exfat: optimise and refactor filename up-case
 conversion
Thread-Topic: [PATCH v2 2/4] exfat: optimise and refactor filename up-case
 conversion
Thread-Index: AQHc3Is7jvUBUKx0B0+9XdwrgDjn/LYCQ8dG
Date: Thu, 7 May 2026 12:03:47 +0000
Message-ID:
 <PUZPR04MB631684B809F703C8D62D3B59813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
 <20260505123144.730782-3-dxdt@dev.snart.me>
In-Reply-To: <20260505123144.730782-3-dxdt@dev.snart.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SG2PR04MB5663:EE_
x-ms-office365-filtering-correlation-id: 33c7aa0b-0ff1-46ad-34c5-08deac30b19a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|3023799003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 IB/WpgRQJn4R+HereBny09liKmMZ3E8njrWcxbZZc5lxny0bJuPU8hDxV/ZPoi7RuzoQLKpc7Hv5csI006lutpcZ17MdSMv6T+X0XqnKL1LisE4ZiddVeq+xLhQO82xFmTLSBrRN/Bev7dRCQUfzZ44x9XLRiU8y8vwGPQMtxvOgFXSW84fL6ojLq4PwfQnmULdQxl+JbBDE/ZUW5qqq0IXpKVmauj0wVX7+cHGtqvS/vq+sL6p17Cx2qxDnG+zyP2nypQN0tTMYWI17NDX1klfwLWJWt36ppSAm2f3wxeRSK9M+bucT8pvJV2k6ULNHQ3amj+zV3ihC9BiCw9Jw3C8JqL7+2/ezyO1h0GSztO2v2GWQfzAxx2m83QumWFX5AE49DVINsV22vHRHqp1qW4TBRUKv8Uq119Nwbm6xptCqDi9sUPJLMABon6z4A5LSkc7g5aUyi9HcjAZvIvm8lIc2BLr927zmkrQl8oJjkNhmOqHZOHKWmB0+TxEeUHEHreYJrhW9lPh4stdW0Ri+1tNRfAc508RFAx/kOf/zYYRlNS/1niPhjpHIk5j1S3AKpQSaPi6AyQqzvNmTsjdErCRWCfBRQkpyjWThDjSa45L0zqLBtvrygGGwWQJcPJJo7p420/avajZ8dMt3EH/lNlQD0JoV49sm/u2IcwybRBGe6Ykf12cBo6KU9VA5FU5FxkDP3cHpWfF+kUy9yF7/VefUDBv+sTl/z44NfP2i4hLKpn3s9Su/aWEm3B8MTbVh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XfGYLGs7Yhc3QAXN2zqZ9ynKcRTD59O+dbyh2e1F4RqSBsSiMh796ywadU?=
 =?iso-8859-1?Q?7AC+ps5HCYKw+r3pYE8LdxUfnihsEXKcA9p6XVBsCaqWXRjfHO3vwtFBKW?=
 =?iso-8859-1?Q?CPSUKiM9+Zx8hn7AW4b35hD92Y1281OJeY2aP2RXkO/Y6do/cFb9kraNXv?=
 =?iso-8859-1?Q?u2+ktQ2AxX7nCWoM7GlZ8WoT8wv4gJmnjMIa96P1WRqJVobQxN5RDEq8hu?=
 =?iso-8859-1?Q?X06yX6ciWJVafmRG8AwUA9uwvCdP/xnDFVd9qmFW0aOraI0UDaPQ1G08gT?=
 =?iso-8859-1?Q?yl8YI7FeVfWKm+V8mpUtBWHcxlydCE+W4pSCTT5R3WO0AvWcmKOoDNWEja?=
 =?iso-8859-1?Q?tFnBkwgPEUq7iS/PIRuZ2DVjhpULaw7l8/FaeXAtsbeMNpHvpiiJpKI+h5?=
 =?iso-8859-1?Q?xMnfxpd73BtXjw2HqDIZlZYSNpwJ76usgGE9H8jN34GWvkL1GisgROAhgd?=
 =?iso-8859-1?Q?ZeS6THj2RT1FNZrr40TN/06gWPFXahK1W1xhlt8gUU3KaanLDBvBuzB4ul?=
 =?iso-8859-1?Q?2KdWZ8JK/JpMhQjDyGQ1EAwGQ7WMV3qP0GOM7I25mtBEBywNPAHTdnqh/w?=
 =?iso-8859-1?Q?QRcqsebrvmUfHpl991asmSVu/Jj4Cy2YY+0y9c4XqUpCaTBP0bnqlIReQf?=
 =?iso-8859-1?Q?wPiwVnZm5/WQ3GCebygJj+/LNxsO6+xseIAcDUIeqxyKB5jI5mufSmEAbl?=
 =?iso-8859-1?Q?JcMO0atblJ7CcqEc8wMVj1NDTOT8mKlYUZAIPaLUc+OdsmbRRst+/aCdnF?=
 =?iso-8859-1?Q?rVOjn8+UusyWADGizwsfiPseQe6+gfwyq1HKAEJZJkUFqIGil2Vhiq5NDQ?=
 =?iso-8859-1?Q?xKPC9XdBwVG37HtyOdnmta/I9nvlKjMnctQlUNXNQu/jq1brvDY43iTuLN?=
 =?iso-8859-1?Q?4paczfXK/very4Hs/jYW8tW9Rvnj6xSALaRWdstEFRKYSjRbKXSj6VDSaB?=
 =?iso-8859-1?Q?Jwvfiiq/goXaYKNqJCxn/iy3f02Z9WIFY0U+sf1Km054+4eJgo9iz121mQ?=
 =?iso-8859-1?Q?znvnQiKkYeSJk9kIHp014dKfqUek4CBISgVK4iwcHXwD3ZOm1Q8S8n7eYE?=
 =?iso-8859-1?Q?3VRLFt9+v+RPVp1CTkaqF2DihfWrBxs5XZFl34p2deEiEQKg1j/CsEg2lQ?=
 =?iso-8859-1?Q?vBA+mDb8OVjFJciUiwJOnZEn6f63NTXKX/UE2B89qwt8th3dYEsRKScmy4?=
 =?iso-8859-1?Q?zcdDMrL6mcZFc17Gzjk5xV464rwAi7nemJEEE1zYmIoRlj5xC/2L2hOWQB?=
 =?iso-8859-1?Q?Yt2JUGvVvVjc8RQ6XmheWBcAwNYqQozvUaVFApwurEEDxwISD6Rgh+KlnK?=
 =?iso-8859-1?Q?7EGaiA4lkISLhOnY5WEIJuUNUwlqoUfwlQxZBaeiPlVWQsPdjUr9tykDZW?=
 =?iso-8859-1?Q?KGFf1NSbG4mLU2iPj9ZH1P/ztZr0D7dXaJ0IXwVvPFaR0ocfOU9zOVGkH+?=
 =?iso-8859-1?Q?A89IB3x+6G7bNSEx8WUtgrOwUgcS3IeUg3YJ35axTe0bsbBp7GTBu9ZnEu?=
 =?iso-8859-1?Q?VNPd1gJRqA+hc+leGkpFB/qOA24Ii4Gday+dhnosL2opIgw75cTP9QmnUN?=
 =?iso-8859-1?Q?BaipPNn7jrd7pe1kJiqnxackV+OsaKkjt8EQWQz2clTO+SlZTYLxYAjEZ2?=
 =?iso-8859-1?Q?iApDY/UEsLPBhdtzMS3JSTZVQ8kszjYEgGgCjbCQxC2g7rfsdjtRzFPDgW?=
 =?iso-8859-1?Q?qkDRYE3HhXWBLWV8YZlJMUfD7G2SWzBFgjR90r1SkK5Ty782r1K7UsAJl8?=
 =?iso-8859-1?Q?xY3uUnY6mTNp0H6aulNUbwX2++7+sT5K5aSw9CMYnpr4pT6jBveg2z5/ze?=
 =?iso-8859-1?Q?l4A4X6PpPQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fA0lSYi3EaqNEhenrYGKab7pHBELOG6tDaYhn5Caz/IqU/O9CkmqX+FHTbWTbi/IgU1wndRXBF0tju6FQAuJVDHiz0wnNoPOw3uI5cnM5AqsNACsqJlbCH5vdl69GqbIsuno6aZ+vpnP/c0JtB0FzPr5QBoQq3222GF+pqsQo3h4yWZhY3fvO7n76U0V7pFBdx/9lkU200yY+bNHCpg9/hk8GSGDY8uH79dtgrCbzAPPD0MTjnsdr2zbz3gX6frv+1aafWolaDry0iyxfxdJN1XkgAbn8Jp+b3Eh1QQ6emqZhJXE40ENzYRoVMPITdh7LA/idbZuMXKwI+gXC4VihA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rtp8UHDYJC/8UysbRxcs3RNDcup1CiD0PRNMCatKZxGaQyHsDAlzxSkIKkSMqwidglmEXX2yFCaYR12O9dOPt1Ghr4WBLHLPIuip8nm3EE41KcRiqTZ0EL387ktJp4dJG/QW9aWwwe6wJT9ZdKYCeviqYOQa4l8x4Uz96dQF3rsU/jNJ8gCPGwTFHJOZX3/s8XhG7uNkNbCabjhHTQ1OPxHnnm8pHpyLJigrGN/CAvldiOyPyI/pV6Xa2R/rl0hW3238z3TFIYhCQHrLvhZiXxajbraNl5THmrdeANqjZGnHpyYr+WkHY9kMyPILaBHQvre1sdrpqF02cF5+8OIdaie1vRD/jnU8U1SjqaYKExIkBHr1LB9+xYUf9fVYCxy/1DEtIpwbVDLv1c/O2xXZY5KZzMZpdIhqMukfSRLnJymiUL9CVog+BAj2/s0eL7NctvgxPEdV3a8UR04xVJWZJgc+/zvJOCS2pyhxuT7qU3WmFTgnijgz/NnbCP4k3I0GCeb4kvnubsj8ZRjhq4Y4pMh0oDCS7Ln4DpVp/0LkK35j9a7Q9cTQuqeuMgzswO3W4Mb8byMjRIAeOc1Gbat9pYGRXPeTDbLnQYF/MvnLx78IdT3b6++Xzk/8iptksFjc
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c7aa0b-0ff1-46ad-34c5-08deac30b19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 12:03:47.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkaHcJjgrQ9GLOT9R4+YLft/1Rry0wo9PRbxypJIfHBUunx26yluVAAhK0HtKtlC2QS+QGlGXQf2GgUcEr2tjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5663
X-Proofpoint-ORIG-GUID: HO6a0fJFhKRigXS_IrSWVw3dVpOQ3h32
X-Authority-Analysis: v=2.4 cv=Xc25Co55 c=1 sm=1 tr=0 ts=69fc7fa8 cx=c_pps
 a=mMqXi9Dvh+da6KVTmFGiYA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=I_Y4LlEPCAdqsIK1J1Zo:22
 a=8bLzx-9FNwqRn0T42RQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExOSBTYWx0ZWRfXwUsxXBnRKeQ/
 Lgwm9ucuptuNuGEs+3ZtM9KxlQaLyh0kzHnFPbeEyOIABiLcYrZMdLIwKs2jXLXDXnNunKgvrY0
 kVn9ZGGMelAKLaLaW44ZwwcEnG7eAIe0NYjiw+A/Pgu/0bc5mOQhnRKBbGNumFM1U4lG0q7iEk9
 02sgo2h53Tn2YbjztSEItFxjNbcGRKG5m5zbeIJOSGzMFIEkilon0hUvviu90Wyq6WNJciyH0Re
 m/i2d1XEm0X+h9HKKpU4w8Ha0hqsDx9R1srZSRVTIm2Vqthn9ed5OlA44/f/Qlr3MkxEakzPXHC
 P8P+cf3WLxpua91uVZPjkpLhEbHkZWWWN+giC6/HwLzaTN5irGGyeYt2cNymJLc/A7iIEuUXKB/
 P2+YGSXxRSmBiqxZmDbSFxaTpvFFpfWJvOJoAJ0zM6/CX8M1uBQ6FHNw6x9/54Kzc+DIO8gEOGO
 1wTyPhK0s691dAXLIeA==
X-Proofpoint-GUID: HO6a0fJFhKRigXS_IrSWVw3dVpOQ3h32
X-Sony-Outbound-GUID: HO6a0fJFhKRigXS_IrSWVw3dVpOQ3h32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01

> +static inline bool exfat_illegal_chr(const unsigned short wchar)=0A=
>  {=0A=
> -	while (*str) {=0A=
> -		if (*(str++) =3D=3D wchar)=0A=
> -			return str;=0A=
> +	switch (wchar) {=0A=
> +	/*=0A=
> +	 * Control characters=0A=
> +	 *=0A=
> +	 * This saves some cmp instructions if the compiler does its job correc=
tly=0A=
> +	 */=0A=
> +	case 0x0000: case 0x0001: case 0x0002: case 0x0003:=0A=
> +	case 0x0004: case 0x0005: case 0x0006: case 0x0007:=0A=
> +	case 0x0008: case 0x0009: case 0x000A: case 0x000B:=0A=
> +	case 0x000C: case 0x000D: case 0x000E: case 0x000F:=0A=
> +	case 0x0010: case 0x0011: case 0x0012: case 0x0013:=0A=
> +	case 0x0014: case 0x0015: case 0x0016: case 0x0017:=0A=
> +	case 0x0018: case 0x0019: case 0x001A: case 0x001B:=0A=
> +	case 0x001C: case 0x001D: case 0x001E: case 0x001F:=0A=
> +=0A=
> +	case 0x0022: /* QUOTATION MARK:    (") */=0A=
> +	case 0x002A: /* ASTERISK:          (*) */=0A=
> +	case 0x002F: /* FORWARD SLASH:     (/) */=0A=
> +	case 0x003A: /* COLON:             (:) */=0A=
> +	case 0x003C: /* LESS-THAN SIGN:    (<) */=0A=
> +	case 0x003E: /* GREATER-THAN SIGN: (>) */=0A=
> +	case 0x003F: /* QUESTION MARK:     (?) */=0A=
> +	case 0x005C: /* BACKSLASH:         (\) */=0A=
> +	case 0x007C: /* PIPE:              (|) */=0A=
> +		return true;=0A=
=0A=
For the continuous range 0x0000 to 0x001F, I think it's better to=0A=
handle it like below, which avoids the large jump table, and may be=0A=
just as fast(or even faster).=0A=
=0A=
	default:=0A=
		return wchar < 0x0020;=0A=
=0A=
