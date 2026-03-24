Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7571A2392;
	Tue, 24 Mar 2026 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311478; cv=fail; b=nOGC9nj+3mir9Qll9t0+cmzdhDKSizdevj+34ToL+uRsyt/VCZ4Cc3+fGrMo6FIji1O/zIJ0cUv1OKofGINOgk4aSmlkD8ClL8Buj3TRBqpdG1oeHsi8j66HX1jyzggqWzRbOD2sFdaceKMqHLxf7H6PHtbVm4HuxlNGw/C82vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311478; c=relaxed/simple;
	bh=BLTHa8q+3ubAfVCCwcg9+SdWNYdfXrTn/cMK/oqPIT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q9hyF5bYTAyP/qlxCyPiurBsIWxD3F0VNsMCGBdZzIlkbbhPY6mvH2JNyvVLgGKKelLgJ7fDtvl7TnodLkghdbkrnyc6+82aBiwc9YX7sIvo/Esl2l87GiUxbGW8mBVRpdDhYLHdp/DMPZFpiOveEdm1SYooPm+EClsYIN3AEUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DToNqpxl; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DToNqpxl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NCt6e1194143;
	Tue, 24 Mar 2026 00:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=BLTHa8q+3ubAfVCCwcg9+SdWNYdfXrTn/cMK/oqPIT8=; b=DToNqpxl
	zVoXHg0DZFc0u1NeNebC+GrwUgBhq7D8OUzVB6wH/6rsRMZymiloBCIJSW32/8jO
	19iNeAKrsszPW2APMCr/2p0SrugDlp6XPKgmmExBslLykBANOvKTADqMsY/XjSvH
	NsA4MIji2IYWsDRlsSJNKjlEpyB0FW2geh3K1/42+gkBsbOPyVJ1Vgno2NzYF0CW
	hYMI4QnAhQ8amraqfWeYtfQHUOHIOTNANt5KvOaZbTRTSJVxrA0MHgXuXw0Ktvcm
	kXs5J0ZSC3hFy627XfQ9j0ik1wOe1dW9dQ1eh9s5Sxub1cCadHpHVraskKiZBFR0
	6HnohNzyRv8DVw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxs5j0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 00:17:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cykgRE5TXWvvS9J7T3O12spTygzMf7apQsc25SPHjQhMrx/z2TlNMWX+iRZl46LpLraIg5qJHvVxVi9i93z7XXCmbwFSOMYCeojAhPv2X7+X45qFyHzkdqhUzE9hFFDT8UGqyizSJr1pMZ/0dqDLmjh5V5LoAvzEx/jj9P+l9/m+9Gke6zhDC0vLpjYTQN3YTuk0A4XzNPM7VPzrCe0JKkV074pSExWDUPfeVwrvq8AW5CP5oWs3ZmueYmUeonk21EskVSRYcasz753S+hBiIUdjDmAj9FWOO7rqgN79JXNl9hxcaWD/1oavtQQrY9GWKLGk7QPJV14EZPffeiW/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLTHa8q+3ubAfVCCwcg9+SdWNYdfXrTn/cMK/oqPIT8=;
 b=pBTwpzCgdPOPaSPvlwogA934h2NMaNgIkiSTiVt7ZQs8JccoPr+K4TCr/pdoPAS9ChXSX8rVQOjl3bGhocq9RyxJkuN4IHrrzbwYFVnuhIg5073arJmH07BZm4QBF1p0tYB6ujFYhRMro2hnBMhcWZB13tSNCPtwYhjvhL4g7AZUWwIb4ntbY9CCB7hgJfhn2G1sHlJQL8Qh9B7TgosBHC0imjDaDHCTFvvED2l2x3FOe8axvcJCwtafzfT0QgGMxmNaVBHLSi78nIO45lUsyx5siLuPTAqRu4w6KsF0xuHkTm8R+q+KBBdlYs2jDv4tz+sWJbYkBOauPCfG/Jcu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW5PR15MB5170.namprd15.prod.outlook.com (2603:10b6:303:198::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 00:17:42 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 00:17:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "zilin@seu.edu.cn" <zilin@seu.edu.cn>
CC: "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "jianhao.xu@seu.edu.cn"
	<jianhao.xu@seu.edu.cn>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v4 2/2] hfsplus: extract hidden directory search into a
 helper function
Thread-Topic: [PATCH v4 2/2] hfsplus: extract hidden directory search into a
 helper function
Thread-Index: AQHcuyOh1tz6sW9t/kCQ8yerJKiaTw==
Date: Tue, 24 Mar 2026 00:17:41 +0000
Message-ID: <da6150e9de2574a88190935faa10b0d19fdb4db7.camel@ibm.com>
References: <20260321080130.1292216-1-zilin@seu.edu.cn>
	 <20260321080130.1292216-3-zilin@seu.edu.cn>
In-Reply-To: <20260321080130.1292216-3-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW5PR15MB5170:EE_
x-ms-office365-filtering-correlation-id: aebf9674-e994-44cf-b171-08de893ac3c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 lsnVeUlhORPVawQeps5Q6EaqGXPLey1iNdgia2B3eEyPVrDy9QsDhXSo8tqbWPZ/ac2Ck+cP5Wvww0cipdD11Wk0ujxKJsnAsbjjBDu1/dxBCoZBs5TSjDt3AxlSIFTjlYqI2Z15S8h9ALu7POim8WGE1BMSE404G2Kcr1OotvM+5uCLdIBD8pkkdGRImbMKrccUgrDJrSrRmj/xPc9g/fVGq9CzEhiqhCWDHZjXzq4J56E15+aeBMbcbG5ElRVn/JlTLqtNKAB6D5ImsIGP2KMZBHl0SbTTreh1aIHKn3N9JM96MlL5nspgSKzkaQzuq8GB8+3qjOD2+xyrXcHm+aCNMv6U5SiODstiWuuZpkT0XdBi+pk728rjyC2dirjAm/FoIpK6T0NAqC5hIoSFGvzVLeyuZeiK+52LqJmKzaZCTyUJUUwI5R8aewLkFdFw0llzSR5tH7u04Sxe6zwZumxFUG7mUAlbFWsIMnYnK32c8zNZp6jgfCnj2nadmfc0ibwEhhDogC45EMH1kcFo8p0HEexUGlb6u8oTZPnwKbxLTdnCiI1XMPwwL8XdbQHEe46E2ERbHXVF/+61dHu5SUtWmAZAZyixY4yIn4uOjhixdXOL/utC2ULqztyenjCT9rjuDjhaKZhQmtm/0zuq8FUbJFgv4W4/vBSdQSUJq76k3jg4vTJt3gJL6nuWdg15bkoJfPoVZyzXt5UrCdeLjIJ62jqLM45KR+ag2S76q3i8XpkqzFC017OAdLx8CaEIibRf54IQDav3qGyIi89Bwj7VDxv1xA+1IFSPdZpIs5M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGZuS2pUaHM3djk0SGxGQngxaFc0bnkvSTRiQmVyWlhydmFjUTR5eGZBL2ty?=
 =?utf-8?B?bVova0dyMkVYVzJjMGFndG5ic3hzeXNNazNlTnN1d0lINCtkOE9RQ1B6aUg5?=
 =?utf-8?B?QWEzZ0ZMRlVCK2NDNmt1ZzJQNVREaU1DYU95bk02SjdVd3UzR1BqdHJza2c0?=
 =?utf-8?B?ODZSS1lhNE55aWx5ZzBYTDc4TTRrTGRSYmhDdlljRUVMSmtkSk9TbXhyckZD?=
 =?utf-8?B?L1laZGhOOEVGakorb09NUk1oTi9Ka3pBWWlKeDhXZGFVNTRUZTNWTzNpd09a?=
 =?utf-8?B?S0VmTmJ2OHR1RktKTHhGdXErVVJJNlNmQWZSWnRjb0x3b1BRZlhWN3lBUFRN?=
 =?utf-8?B?aFBkcW5hWmpGTUkyZ1duMFNEaDJEOWJSUjU2NFNyNzlVU0d5ZEppaGxhcllQ?=
 =?utf-8?B?eEtZbWFwYUYwczZiWTV1MC93WFRXMEZsWHkzZjlTZmRUNSs0R0EyQ0dGeHZJ?=
 =?utf-8?B?UUFXTGtYWXhpcytqVWdWMHFIZVZSZW5oT0l4dGtkMUQ0UmEyRlBiWnFyWGdD?=
 =?utf-8?B?SS92ZnZUZ0l2Z1QyM0xDcFRFaDF5WWNVSStqSGJRSG00VXIvOGVSQ215eU1J?=
 =?utf-8?B?OTA0QmlhN3F5bGRnaHlsN3N5ZUlxS0RZQktrU0YwTzhHRHVSc29aQlVnZEVF?=
 =?utf-8?B?YXNyUDNzbDV5S1BUTGplWVcrYVJ5RG5TZ3VHWmU2UCt5MGd0TFJmbmhGTGRs?=
 =?utf-8?B?VFZNVFVnSkMwdTVCbS92YXZJRmJ0VG5sTVhsOGlKV0tOSDB1aG5DTTNnTkhv?=
 =?utf-8?B?TzMrNTRHRWloYTFqSlJaaU5mSldlUFVIL2VVODgrNm1lT1ZtckMxQ3Uxa1hC?=
 =?utf-8?B?MmhFQTEzWldzaE90KzlmRjYrMmxGS1l0Q3JZRUltekFOQU9LWVF6TURITXBT?=
 =?utf-8?B?N1VFMVVSTEpVYWg5UXgzdmswK3JCblBlbm1MOFpnYUdCbmllZG1NOFg4N2lK?=
 =?utf-8?B?Z1pLWTFST3laMjQ4cXlZRW9vbElha2c2bWRXeUMzOGFmKzAyMHlwVSttL1FD?=
 =?utf-8?B?bFczdk80T2EydE16cDQvUmRoeWxtZkZCSDlObU5DV2Jid1NIYlVITm5XTXJY?=
 =?utf-8?B?WWNSVnBkTm55cXJ3TFZtb3M3ck0waEEvYXNIN3JFbURTQWx1blJ4eXU0MmZu?=
 =?utf-8?B?S0EwaThDd3NtQ2k5b3BSZ2RKT3pNRERhN1JFSUJhNEFIUVR5ZjlYWkR0ZXVt?=
 =?utf-8?B?UitISzFZcy8yM3NIV0xJQ2VZVWhiQURzdEhMYjBIOFlOOXBqQkQza2JYVDhm?=
 =?utf-8?B?U0ZZVHVsK1ZSUXZaa3dGQTNtdzNobXhIVVUwSzJmTFlCRVdNempGalZqK2FU?=
 =?utf-8?B?OGJSZkxMVDNvMjB3aVdzeVloS0srOGUzUmVYdUhsZjZVMzhwUW1EQ0tFMTht?=
 =?utf-8?B?SmhtaEZEbGk1Q2h5ZDdqc0pxcjc4cDlQYzFRSG9rVFJxTnN2RkQzUWlqSUVJ?=
 =?utf-8?B?TFFuM2JMVEdsRVVDM2VtOGYvOUtFSjhSVHBiTzFJZ2ZrU2t3VUl0QmE0bmJG?=
 =?utf-8?B?b0Zlb29jcWovYkwvZUNucnd4VW9JSVJCdHNwSDNTRCtZWThZN1RSTkN3NEpC?=
 =?utf-8?B?VG5SbHR3enVYOVdCMmdPWno1SzhkWUFnZE1uOTBMMGZNTDI1QVJIZmpYdlEx?=
 =?utf-8?B?amNvelJVazdMODN6VHkvRXFrbTlvWmtZcDd5M1ZuZDUzNVEvbkNYV1FZdFgr?=
 =?utf-8?B?R0JaZ2NYaGlFRDRJd3c1eUlJeW05TmhBdk83cU5yRTlwcWNkTFNtaWdQeVNS?=
 =?utf-8?B?NDRTNTFhUU9uWFlHMFZDRnpEOEpNNHJYK3ROdnRFL2w5a1hNeFpRUmlaT1g0?=
 =?utf-8?B?TE5kWXZydDk5ZHQxZXpWYTBZd0lIZEMwOG9BTjQ1Y1l1WEtJaU8raGV5R2Zx?=
 =?utf-8?B?UGtVQkU1eUI3TjkweVZYd3lVUUJCRXBZNTlwci9JMVlpUGk2YzgxdUdyV0Nx?=
 =?utf-8?B?T281RHpaL3IzeGhicllyRlVNTkJPbXBPNFFyQVY0RjY2Z0kzUjZ4Zkg0NENH?=
 =?utf-8?B?SGJqOWZsTDFLR1Fib1A3bVBPRU9KaTJKajMvRzJnaHp3eVd2aElBNWx2S0N4?=
 =?utf-8?B?ZTk4UnF1OFY3dmVaZlluaVgxUkNvTGVsa3FNZzkxNnJnZ0hydlNWUzdTbnFs?=
 =?utf-8?B?aXpRMzYrRzMzcVNhcWR4aldVaVVLVm5hUW44aEF5YjM2Ukc3Z1ZubXhDeHV6?=
 =?utf-8?B?bjVYWkVCSnpvV05uMnNQYUoreC9sQXNjREJhNVVMVVNZejVmQnRKL1NHUGV0?=
 =?utf-8?B?SXNmOVBJMFM0aFYwYjREMStQSWpBODU0OVRNUEZvZVpKclIwaVNvMk12eWZ3?=
 =?utf-8?B?bzdaUW1WVFUrZHhaL0hsbERzQ3NKRWdlVXNvWHRPQ1ZkVlZEL1g3cDZRMGE0?=
 =?utf-8?Q?VprLAQSuXBsPbaemtxDDeh64R4ZVxXFFO5SuI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DE934CB7FECC14B9EEBBDB8A9705489@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GQd5KTsK/k//oihbT/xOEGsOiFCjsz/tn1YYLZ8cQgRUymnWHudtAMOLPZTx5BnSuMfbBj3uqGkzLt7HaIPsNRLS/c4uLD6f8cMZGlehFtT6lF8WUU6a64k9AWS/ozIPyjp/Or8H5IyvQLhlN5GDxHu1Mpfxl2aP0HHjkgPm/4RWxhb4IPFU7Jx69hcDB/VOA8jZQVD7MKO0IuivDpl8N3KjntJAiC4b6LxpFVkKLiPukFFgMyTp+E0D2zgZ/x7Td5r/ZmffUFzswyY8HoAjE9tZR3sSI92B3SMsm7w/4RNjuxoEYW8ZJXP8MEx+BPva1HBX0lQDC+Wr/zoXO12nSA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebf9674-e994-44cf-b171-08de893ac3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 00:17:41.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaYzaWM+61COxXRECJB1d1g4Bzn7OEYkzglK2qw3umGBtvS4tRXRqLjogMOCP8bPrmVDlmtnIH9aCPaYFIm28Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5170
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c1d828 cx=c_pps
 a=AKd2An130fSphkJyqL6rzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=wCmvBT1CAAAA:8 a=PQ6SMGNLiiK4PPM3B2UA:9
 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAwMSBTYWx0ZWRfX8k4sbIVapfSm
 RQi7jJPkd9knk47fxCUnFF4RsOIBR2NL4HonL0Ev+ACKDSMZHyVVfxTvecbUjJmpcWFb1P8sVU6
 W2O+JSsYvclrOcXTcx1qWQDiqzppB9lyJZEgJnJuTZaH7jdiFOlmAhcQ7Etk/yT5le59gCkXIG6
 EU5pDBp0VXRISvmh5TR3pLuPpvMZCC1+ZtXyqLqQXJtQNDjh88fPEm9iVUgbdhtsPuAAWECFe/z
 yWjhj74JwnwPAL69tes44bweTRghrvne/eeoNsOp6+C3yPBlpLDVGKD8yrXf2w87vducbr1DFOh
 2vI8hmug4EvEtGW+9hZst7RQoJ1Z7rMU1mV/X2MxFwEdrIJ4iR5+zhzU4zFBBIJHToAaFlY7y+j
 8S2fnhQreiYml2rhOEGQ2Lhs+xU80w4o9i5Ftiz0PnT6qlq/7b8jao6ctHXHHHdZh4nDhpKifKQ
 9+ngUwipbpNt/zUMO/w==
X-Proofpoint-GUID: t-HYczYWDur-KAF-lwJr8Ot0swpjSBl4
X-Proofpoint-ORIG-GUID: t-HYczYWDur-KAF-lwJr8Ot0swpjSBl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240001

T24gU2F0LCAyMDI2LTAzLTIxIGF0IDE2OjAxICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBJ
biBoZnNwbHVzX2ZpbGxfc3VwZXIoKSwgdGhlIHByb2Nlc3Mgb2YgbG9va2luZyB1cCB0aGUgaGlk
ZGVuIGRpcmVjdG9yeQ0KPiBpbnZvbHZlcyBpbml0aWFsaXppbmcgYSBjYXRhbG9nIHNlYXJjaCwg
YnVpbGRpbmcgYSBzZWFyY2gga2V5LCByZWFkaW5nDQo+IHRoZSBiLXRyZWUgcmVjb3JkLCBhbmQg
cmVsZWFzaW5nIHRoZSBzZWFyY2ggZGF0YS4NCj4gDQo+IEN1cnJlbnRseSwgdGhpcyBsb2dpYyBp
cyBvcGVuLWNvZGVkIGRpcmVjdGx5IHdpdGhpbiB0aGUgbWFpbiBzdXBlcmJsb2NrDQo+IGluaXRp
YWxpemF0aW9uIHJvdXRpbmUuIFRoaXMgbWFrZXMgaGZzcGx1c19maWxsX3N1cGVyKCkgcXVpdGUg
bGVuZ3RoeQ0KPiBhbmQgaXRzIGVycm9yIGhhbmRsaW5nIHBhdGhzIGxlc3Mgc3RyYWlnaHRmb3J3
YXJkLg0KPiANCj4gRXh0cmFjdCB0aGUgaGlkZGVuIGRpcmVjdG9yeSBzZWFyY2ggc2VxdWVuY2Ug
aW50byBhIG5ldyBoZWxwZXIgZnVuY3Rpb24sDQo+IGhmc3BsdXNfZ2V0X2hpZGRlbl9kaXJfZW50
cnkoKS4gVGhpcyBpbXByb3ZlcyBvdmVyYWxsIGNvZGUgcmVhZGFiaWxpdHksDQo+IGNsZWFubHkg
ZW5jYXBzdWxhdGVzIHRoZSBoZnNfZmluZF9kYXRhIGxpZmVjeWNsZSwgYW5kIHNpbXBsaWZpZXMg
dGhlDQo+IGVycm9yIGV4aXRzIGluIGhmc3BsdXNfZmlsbF9zdXBlcigpLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogWmlsaW4gR3VhbiA8emlsaW5Ac2V1LmVkdS5jbj4NCj4gLS0tDQo+ICBmcy9oZnNw
bHVzL3N1cGVyLmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvc3VwZXIuYyBiL2ZzL2hmc3BsdXMvc3Vw
ZXIuYw0KPiBpbmRleCBmMzk2ZmVlMTlhYjguLjVlYTJkMTg1MjU5MSAxMDA2NDQNCj4gLS0tIGEv
ZnMvaGZzcGx1cy9zdXBlci5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiBAQCAtNDI0
LDEyICs0MjQsMzUgQEAgdm9pZCBoZnNwbHVzX3ByZXBhcmVfdm9sdW1lX2hlYWRlcl9mb3JfY29t
bWl0KHN0cnVjdCBoZnNwbHVzX3ZoICp2aGRyKQ0KPiAgCXZoZHItPmF0dHJpYnV0ZXMgfD0gY3B1
X3RvX2JlMzIoSEZTUExVU19WT0xfSU5DTlNUTlQpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW5s
aW5lIGludCBoZnNwbHVzX2dldF9oaWRkZW5fZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsDQo+ICsJCQkJCSAgICAgICBjb25zdCBzdHJ1Y3QgcXN0ciAqc3RyLA0KPiArCQkJCQkgICAg
ICAgaGZzcGx1c19jYXRfZW50cnkgKmVudHJ5KQ0KPiArew0KPiArCXN0cnVjdCBoZnNfZmluZF9k
YXRhIGZkOw0KPiArCWludCBlcnI7DQo+ICsNCj4gKwllcnIgPSBoZnNfZmluZF9pbml0KEhGU1BM
VVNfU0Ioc2IpLT5jYXRfdHJlZSwgJmZkKTsNCj4gKwlpZiAodW5saWtlbHkoZXJyKSkNCj4gKwkJ
cmV0dXJuIGVycjsNCj4gKw0KPiArCWVyciA9IGhmc3BsdXNfY2F0X2J1aWxkX2tleShzYiwgZmQu
c2VhcmNoX2tleSwgSEZTUExVU19ST09UX0NOSUQsIHN0cik7DQo+ICsJaWYgKHVubGlrZWx5KGVy
cikpDQo+ICsJCWdvdG8gZnJlZV9mZDsNCj4gKw0KPiArCWVyciA9IGhmc19icmVjX3JlYWQoJmZk
LCBlbnRyeSwgc2l6ZW9mKCplbnRyeSkpOw0KPiArCWlmIChlcnIpDQo+ICsJCWVyciA9IC1FTk9F
TlQ7DQo+ICsNCj4gK2ZyZWVfZmQ6DQo+ICsJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiArCXJldHVy
biBlcnI7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgaGZzcGx1c19maWxsX3N1cGVyKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250ZXh0ICpmYykNCj4gIHsNCj4gIAlzdHJ1
Y3QgaGZzcGx1c192aCAqdmhkcjsNCj4gIAlzdHJ1Y3QgaGZzcGx1c19zYl9pbmZvICpzYmkgPSBI
RlNQTFVTX1NCKHNiKTsNCj4gIAloZnNwbHVzX2NhdF9lbnRyeSBlbnRyeTsNCj4gLQlzdHJ1Y3Qg
aGZzX2ZpbmRfZGF0YSBmZDsNCj4gIAlzdHJ1Y3QgaW5vZGUgKnJvb3QsICppbm9kZTsNCj4gIAlz
dHJ1Y3QgcXN0ciBzdHI7DQo+ICAJc3RydWN0IG5sc190YWJsZSAqbmxzOw0KPiBAQCAtNTY1LDE2
ICs1ODgsMTQgQEAgc3RhdGljIGludCBoZnNwbHVzX2ZpbGxfc3VwZXIoc3RydWN0IHN1cGVyX2Js
b2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiAgDQo+ICAJc3RyLmxlbiA9IHNpemVv
ZihIRlNQX0hJRERFTkRJUl9OQU1FKSAtIDE7DQo+ICAJc3RyLm5hbWUgPSBIRlNQX0hJRERFTkRJ
Ul9OQU1FOw0KPiAtCWVyciA9IGhmc19maW5kX2luaXQoc2JpLT5jYXRfdHJlZSwgJmZkKTsNCj4g
LQlpZiAoZXJyKQ0KPiAtCQlnb3RvIG91dF9wdXRfcm9vdDsNCj4gLQllcnIgPSBoZnNwbHVzX2Nh
dF9idWlsZF9rZXkoc2IsIGZkLnNlYXJjaF9rZXksIEhGU1BMVVNfUk9PVF9DTklELCAmc3RyKTsN
Cj4gLQlpZiAodW5saWtlbHkoZXJyIDwgMCkpIHsNCj4gLQkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0K
PiArCWVyciA9IGhmc3BsdXNfZ2V0X2hpZGRlbl9kaXJfZW50cnkoc2IsICZzdHIsICZlbnRyeSk7
DQo+ICsJaWYgKGVyciA9PSAtRU5PRU5UKSB7DQo+ICsJCS8qDQo+ICsJCSAqIEhpZGRlbiBkaXJl
Y3RvcnkgaXMgYWJzZW50IG9yIGl0IGNhbm5vdCBiZSByZWFkLg0KPiArCQkgKi8NCj4gKwl9IGVs
c2UgaWYgKHVubGlrZWx5KGVycikpIHsNCj4gIAkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+IC0JfQ0K
PiAtCWlmICghaGZzX2JyZWNfcmVhZCgmZmQsICZlbnRyeSwgc2l6ZW9mKGVudHJ5KSkpIHsNCj4g
LQkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiArCX0gZWxzZSB7DQo+ICAJCWlmIChlbnRyeS50eXBl
ICE9IGNwdV90b19iZTE2KEhGU1BMVVNfRk9MREVSKSkgew0KPiAgCQkJZXJyID0gLUVJTzsNCj4g
IAkJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiBAQCAtNTg1LDggKzYwNiw3IEBAIHN0YXRpYyBpbnQg
aGZzcGx1c19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250
ZXh0ICpmYykNCj4gIAkJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiAgCQl9DQo+ICAJCXNiaS0+aGlk
ZGVuX2RpciA9IGlub2RlOw0KPiAtCX0gZWxzZQ0KPiAtCQloZnNfZmluZF9leGl0KCZmZCk7DQo+
ICsJfQ0KPiAgDQo+ICAJaWYgKCFzYl9yZG9ubHkoc2IpKSB7DQo+ICAJCS8qDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29t
Pg0KDQpUaGUgeGZzdGVzdHMgZGlkbid0IHJldmVhbGVkIGFueSBuZXcgaXNzdWVzLg0KDQpUZXN0
ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQoNClRoYW5rcywN
ClNsYXZhLg0K
