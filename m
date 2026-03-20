Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1B28C84A;
	Fri, 20 Mar 2026 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032019; cv=fail; b=h0QeXPEFqfuJFVMuFnzfxKSlm/8MJ/s8nHjd0FzGRdCGp18uKpxU5CpijHvchmo4m4YBwW4JMhpQRv/SaDIN6ANGKUfar+5BmJnbG1xWiRPtg+Fe+zx0oyr7E6cnCpcFKzRT5pnLyb50Tml0AtXy6FfoD9qCTPGoPG9fWom5l3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032019; c=relaxed/simple;
	bh=PQqtGQ+ScM9vm2P6Z56zTRH1eWH4V3eWVxtczMx++3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vu+vuWB0biAVnhfoFa/9poCZO95GEQjKuxSC2MmWmVvP88GPnbNq05li2uYouQ0AUAhYUsxK0ZtD6MnLvop9LxRa+MHS5ipKNTjwyTf7XRhoCkOUXK45I9O+d7R3QY2iby9cMpFnLlueH6ug9qhlh6ZpjhxDM6cHzGijsJ+9I/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L92+sqbO; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L92+sqbO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8e3WP2372658;
	Fri, 20 Mar 2026 18:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=PQqtGQ+ScM9vm2P6Z56zTRH1eWH4V3eWVxtczMx++3E=; b=L92+sqbO
	FPddpq9dESD2CUmA3vnpi9Mmp1auQW6BAXDiWDUanKtx2HixoKqq415qzJziyuLP
	jfm8OVjouOFNO1BWEpCOTp2+QaaDvwQDu7IiiK21PufEyRX7yAuHcTdIpD686q9I
	76S+7wV5bm2PQfDoulBECJrv+T3PYwieYvhL7vMt3cSWPCaePuTLQyXMTS90VzNt
	+Ie4mrOC/lzpL1t2hGprkHXFfwl9+iWWJo/LahRgOjx835twloU1luZS82TRuMz5
	YxxyTNMxlu7ZiF2rSagJOro8g+Wo4K1RqNIHPBHqVuUDSftpbfcqPtO9JjSdfeWa
	RPBsHYpftDa1VQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfy9cf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 18:40:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGKTEQe6nUr0cJUZ2EKelHp1WnCC3lE2qX79rUB7gGLcVpaRQrg0jPVqrQla0tYQ2exXKFeSllfn6kSxzc3KcIKJJObPQNQM8mIyxbGHM+2giGte96SoV/LPexPBt6a7S3DOKVgVsgl4hpmSxDx7dnFzDew58CM+oZZhKiUcjnViQuqpB7TuomohHf45aRPpJVwO04mxn0L6KkJ7JTTx1mFYBeg+Ut7AYXuPNW9ni/RAAI12/O8V1zseytXc202HUg4V827Z5rMSYNz8odELWoYa/odBxu8E8rV97XHRTLVYVT9tLJD9Opc5aeQ4FXh5NhPix4J7ZzrxquchSIYpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQqtGQ+ScM9vm2P6Z56zTRH1eWH4V3eWVxtczMx++3E=;
 b=uhItufqSnd3BTZf3oq+X0lfNFt7rBKJl00nBhnaC5/cQYkB28qofByeHvg7690PAQBJ2+2OO4L5D2YRuhp9sDr5qMOKneKdAUWG8/jdrKlWvojungjut+32BTjL7XJhiKAJ4izTdFbnqFUW9g5yHbFNxyODwIKFnPbl1rN103juPkfzoV5AIT3QIgcGlnezD0d8QiMvm7i3DzrZ2F5M+YJkuf98jNO3yL2N/VpBg4w+oS08PwOvBz29fuXQ1E88+8AVMFOfCSRdH98K8COTFk4vvIn9+JSK3nthLicFRkZJh0TXSpJki+CyVXIGzQCHI5oQUVSw+gS3HdzBpTeMKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS5PR15MB6982.namprd15.prod.outlook.com (2603:10b6:8:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 18:40:02 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 18:40:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "zilin@seu.edu.cn"
	<zilin@seu.edu.cn>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
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
Subject: Re: [PATCH v3 2/2] hfsplus: extract hidden directory search into a
 helper function
Thread-Topic: [PATCH v3 2/2] hfsplus: extract hidden directory search into a
 helper function
Thread-Index: AQHcuJj2oK4qMdUfDEOBXyk9Kyu5IQ==
Date: Fri, 20 Mar 2026 18:40:02 +0000
Message-ID: <381c1a738fbc47d7e6a81d9c2040ca95d8bb3b31.camel@ibm.com>
References: <20260320130438.988629-1-zilin@seu.edu.cn>
	 <20260320130438.988629-3-zilin@seu.edu.cn>
In-Reply-To: <20260320130438.988629-3-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS5PR15MB6982:EE_
x-ms-office365-filtering-correlation-id: a5f20dbc-184c-43b5-3d8a-08de86b018c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 tFFk7xinC4Hl8Z295ZDaD7r9Ij6QT5KBbv8txVbUCtZzDAYW7fRvCRLHsdYgbjihVigvcuFOVybjT6hfRlnmC7C0oHGjlK0wV4Zi5y5raRX454JWVPHxkQEpc1dOn7bZzhqYwhnS7tbRByNFmPDO94DpfmM3FBWtDakqBQofA4+2Cj362aABEqOeKnHcWSiQqwVhr2TTpTH5zYiQK5zd+kCKIfBVl8WkqYG7cKrJCtpxcabhgG+DiMfXEqHas7utlYhiOgHnbxDKxJ9KahQO+ng3kMdJ86cfO3n57h3cEF9YImch9uIHCLmlY4bVHtt6Y7BdWn8BgUrSs//DKZURQDwqvd3lfrBGnQMmMpes9Zhuf4nzz/h0whKgwDOHYq78Nqjd096/3zzVSJpZgj42M7o1nQsXnUlwbCxV1QUeZd0SsnI0GtbkRwwQSoYxVlXTE49Ip7tH69b39PD9M4TBeTlCX9ATbBBw0ZlsMEfHVxdgoe1LZddICs+V84172PReVb8wxnx9ugUaU3yhs3lw3cdpuFukLfWDOXCZ4viw12karQC1GbAaX+3cEsy4mnVaCy70S738td1PcvE/kSX6oJIBL5M3vFg6Og0wlaw4G5A7NpM/jCWOX9R35OOSaE3U4TqGS72c57srit3O9qnWGoU9UyjGORoZWf8ID/Nry1tUUPWb2pmkcpFofwEhc9HReDeB/0Zflk2lbLTK06XHRXEdpQ2aHlbkIU3eVLD3kK7dRcG/hT9u2ParOBKXXhfOIhsxjo5/wv5ZaE8AqDEobbe4MRGeNAzfJo4tRqlSG6c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHJBOHJZa1RrOGNnQ2dNWEdZaDBPTmVwaGR6dHlUMkRaYWs5STdwbjdJcHg2?=
 =?utf-8?B?NFRTaWxDVW5WWTh4dmZjQ016RittN05SOE0xMWRDTXhzbDkyVHcrcFdxTnNL?=
 =?utf-8?B?MDhyNjRiQjdVaDl5NHd1QVpqRStlQWk0THIvd09nZTRJeDBEQjhJSC9QR1J5?=
 =?utf-8?B?ZVVzNXh1YW1UY0lHRHdwTjY5b01RVVJ0dUkxVSt5all2RzZIU2lsdnNIZU1Q?=
 =?utf-8?B?MnhwcGtMOTZTSmgxOUJNVytKeFlCUEsyd0h2bWdwVXJWVGN1ODRqVm9jOU9B?=
 =?utf-8?B?VG1JaXVwWGNuYi9HczlxakIvSXI5ZUYrcmdTUkczRC9MVTh5V1ZYVFRsdVp5?=
 =?utf-8?B?SGNvcGxzaXRLU29Pb1pEaUI5Z1B1M2k3NzI2Y0crdGN2Rk13alRWbWtVZFVp?=
 =?utf-8?B?UUhvSjlpa2RzcmxPalFEMnJGcG9WSU0wWG1LL1hXN2JJallTT01kdStRbGda?=
 =?utf-8?B?Qi8rcFlSeUJjRDM1a0JZTUhCMWxCM3F3VXBKVXFNNFNWVlVvQW9MZjFBenZS?=
 =?utf-8?B?T3NUNzVHSmZ0L2RYK1dRTXBPcmJCUE8rTjRDVTlZcnNJeXZKNFlQTkxBNi9k?=
 =?utf-8?B?d1J2QzdhQ1lKSjBjNDcvYjVPbUVqVVV6U3JSci9GbEFCaFZ0ZVZydFFZUFU1?=
 =?utf-8?B?OW9vc3hXaW9mL01VOTFvTWpXUllxY3hXc1p0WE94cjY1cERmNUNPNkR0dm95?=
 =?utf-8?B?MmNheTFGdThiUG8vcnlPWDgwZEhyblc1YmlXc1Q5cUZ5c3E1Y0UyUzdiUXgr?=
 =?utf-8?B?bUZBK0MzKys0N2xZR1BqMSt3UG9FbnlVUW4vYjNuUEp5YU85K2tUbVdvV1V6?=
 =?utf-8?B?YXVoZ29SWENsT2lmcDFLY2VTazQ0ZkZiY2dLckVEbGVHM09OK2Z2aWxOd0d1?=
 =?utf-8?B?UElWNXlhR3pNNlRBWmY0ZG9vd1RHTDcwM01mNXI1YnJzN1k2SzhxYm9ZcmlG?=
 =?utf-8?B?M3lhcGNLbVFwVS8vVE5nVTBMUDErS2l3L2FoK3AzS1lWcU9mR1Zackh5T1FR?=
 =?utf-8?B?bS9kbklmNS9mNGJwQk9OM3p5cndpQUhBSGlSL09Vb1REanM0Y3lzeDk4dXZY?=
 =?utf-8?B?SytFeDV5L3ZMTE9vNHU0MDQwLzVtL3FhV0V2Vk5DcEh2MEtDNWVhVGtJSzAr?=
 =?utf-8?B?MDRwSXNuK21QcmphMGgzNnBxS3RQZHcwa0RBb05QbEtEek1IVmpwUHJJQ1BK?=
 =?utf-8?B?WjdtbGh2UlVCOWc4UExwTVNqNityQ1ZpaENRQXhTR21jbWwwelRid2FqVjQr?=
 =?utf-8?B?YlVhUDN2Q3lGUGJ6dmhHT2VpU21QT05xZlNTUjR3bUZYWDdUeWJiNEVib3JX?=
 =?utf-8?B?dkJZOGpVMHBMeXEwb0I4Q0RmL1lRTDlKUDFPZUZRRCtnRjdLWHhSWExMamJP?=
 =?utf-8?B?MWpsdnZrc1p6MTBHcTFCQjZYQVlFMHVZNm81QmIwN2dYbnNTc2dFREQwQUQv?=
 =?utf-8?B?RjBIUHRwcnJuWHFHaVE5bk85aEo0QVVVczMzYy8wWk1RUkJJL1ZJeHRFRHFo?=
 =?utf-8?B?WDRHTEFmSUc2bXhmUER3L1MvSkZKVm8xUmJWR2x2dWIvc2Vqa2FUbXg3RjlL?=
 =?utf-8?B?cDNFaE1DWVpaQmZDWkZRcnVON2pkS2JHeEJDT3ZsTzduWGRyVGhwMHVJVTVx?=
 =?utf-8?B?bFhLY2tTejBlV21EY3Vlak5uWUZaVmx1aEpIcTVhaEJDZCtrL1QrN3JoNjJv?=
 =?utf-8?B?L2xVMTYzWTYyZVVuNmo1cThXajJKTzhLbkQxR0s1emVyTThNc0V1WUU4L3k2?=
 =?utf-8?B?WXFGRktPakg4U3lzbjBwSGJwTi80cUtxMVJxM1U4eU1veExMd1lQS0gxN2E2?=
 =?utf-8?B?aDhPR3ozWXVkVklVWVovS0VOT0EvbnJqOU1TL1dwRWJueTYrRXpHeXNNRkhH?=
 =?utf-8?B?SGt4U3kvaDgxTDVJNGp4TXN1WURuOGFud1d0Z0w1ZUtKSkxQSTNTRHNjdGVk?=
 =?utf-8?B?YVhaa05GVStTVmJkOVdvMGtzcjNLM3c4VFR5TFNWNVlFM1U1N2o3UW1Cb3Yr?=
 =?utf-8?B?b1ZoVWx2blFpajBkeFhZazErTVFKTVlDR3ZxRFZMRUMveGYwYVZiSXVzayt0?=
 =?utf-8?B?dTVzY1pQdmlya2ZWQWI1ZC9nYTVZMmFPdExBK3UyRzdXRTA2YjVVdGVmZlRF?=
 =?utf-8?B?MVFsY0RnVnYrMGdIdmY2SVBHQ2JobGlGS2ZVYU9FN051dHpiYmQrZEt6VVhv?=
 =?utf-8?B?U1FXajFZcTg3Zy9ueGVPaE1GdnR0OUdzeW9KMGcydjNSWGMvS2wyK3h2QnZh?=
 =?utf-8?B?a3VNalVJenU1WThJemZTcXppYjYxSXZ0TytKeVhrd2dXV1Q1UFRVRTZwbWVL?=
 =?utf-8?B?UTR1c24yeVNyS0RSN1pWbUxhdUNvVGFHcXlvNEc1cHJMd1ErMm1LL0Z6UkxL?=
 =?utf-8?Q?MTnTO4uSnKq6BOvwPhHeaaENX0IbNun+n4X8Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9E4364424E9C34893DF7856B69E76D4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jEED3NjYetG4u5ljVCYjRZ9VOC22pR/aQrfH1Z/kC0FTVmLOHW4i6yqSsi5h3TC01hqufS8f8jxJrTmGmRGoOqZeM2VTtOLR4+vwGzs3GMImIRsxhTfRptJYW+T/pREqBjaELTLmTiWJrZAV7sqY+M+pKckNhIp9Gllglb28OU0wmJln0ZVKb0/Y9Z4MK4ndyUIXlwm4m6C6yAEuiWhw/dRKJLbMzmekdTZDmBYY9WniRUI54GdzVA03aPFPl8j9n3eFpOWZhtoT6OQBwv3LcsEbdFV1n58OvEYc9qDSkFFGlMN1epjIXNCsjvTOirWOV1+DbjYDXiJQBEsCHfIC+A==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f20dbc-184c-43b5-3d8a-08de86b018c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 18:40:02.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5+LU64pXSR5op/yuPF9KmTa8tqiVIY0pu2WoS+HvoNfI7ZL0G6I8FEIRAGZ+xNut03Ufn6X8sEkxpNeWjoZ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR15MB6982
X-Proofpoint-ORIG-GUID: RsOpOdTLZAhSQpXhOvFTtRFBlrgsMbRW
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bd9484 cx=c_pps
 a=cIeYbKhGSB7Na0nkMajj9Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=PQ6SMGNLiiK4PPM3B2UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0OCBTYWx0ZWRfX4CDS4tgGXDk8
 Rg9PvHjWoulyzk9NKyV9iwDgS8Yr8N2MS55MjWZhTYOHuGUMTp8Nm9tqH+SbXkuav9gVFZM6YDu
 dT+Sb4F3Rs1g7yfwNm+qciVyEotUZAj9k5lNzEsg3KKowH9FlEKd19PrjdmP6JL8ZzsQz58ccxX
 /fC4UP0yTymulz5BuM48jcaddXN7I0gTFhfow5JjUrwAhVmnmvCQ/dHoXBPg12w6Ns4GgzntJq2
 EWOxw0/hXB56HOYCCK8YKCJMg6qhDx+d75GLNstcaMwkOS3k+ZzomUazCMywjZi8SPS8Hr0u+d0
 K88Ar99u6cTqkbfpUAQkmE7HqNMMID7Ij0x+jq8f0VHne+yNhHA/yJG19pMpWGta1VGHXes6R8y
 0liReqtyqVgAQ88kRsPSaCnUt3TkaBKEGjolpkvIFl3s98jbLYHfZ9qw6IZM6TJ2tGP8wTwaNDS
 NoWGW4mlBf7UQ7mNjhg==
X-Proofpoint-GUID: RsOpOdTLZAhSQpXhOvFTtRFBlrgsMbRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200148

T24gRnJpLCAyMDI2LTAzLTIwIGF0IDIxOjA0ICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBJ
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
bHVzL3N1cGVyLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9zdXBlci5jIGIvZnMvaGZzcGx1cy9zdXBl
ci5jDQo+IGluZGV4IGYzOTZmZWUxOWFiOC4uOWEwM2UyMDY2NjBkIDEwMDY0NA0KPiAtLS0gYS9m
cy9oZnNwbHVzL3N1cGVyLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9zdXBlci5jDQo+IEBAIC00MjQs
MTIgKzQyNCwzNSBAQCB2b2lkIGhmc3BsdXNfcHJlcGFyZV92b2x1bWVfaGVhZGVyX2Zvcl9jb21t
aXQoc3RydWN0IGhmc3BsdXNfdmggKnZoZHIpDQo+ICAJdmhkci0+YXR0cmlidXRlcyB8PSBjcHVf
dG9fYmUzMihIRlNQTFVTX1ZPTF9JTkNOU1ROVCk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbmxp
bmUgaW50IGhmc3BsdXNfZ2V0X2hpZGRlbl9kaXJfZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpz
YiwNCj4gKwkJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBxc3RyICpzdHIsDQo+ICsJCQkJCSAgICAg
ICBoZnNwbHVzX2NhdF9lbnRyeSAqZW50cnkpDQo+ICt7DQo+ICsJc3RydWN0IGhmc19maW5kX2Rh
dGEgZmQ7DQo+ICsJaW50IGVycjsNCj4gKw0KPiArCWVyciA9IGhmc19maW5kX2luaXQoSEZTUExV
U19TQihzYiktPmNhdF90cmVlLCAmZmQpOw0KPiArCWlmICh1bmxpa2VseShlcnIpKQ0KPiArCQly
ZXR1cm4gZXJyOw0KPiArDQo+ICsJZXJyID0gaGZzcGx1c19jYXRfYnVpbGRfa2V5KHNiLCBmZC5z
ZWFyY2hfa2V5LCBIRlNQTFVTX1JPT1RfQ05JRCwgc3RyKTsNCj4gKwlpZiAodW5saWtlbHkoZXJy
KSkNCj4gKwkJZ290byBmcmVlX2ZkOw0KPiArDQo+ICsJZXJyID0gaGZzX2JyZWNfcmVhZCgmZmQs
IGVudHJ5LCBzaXplb2YoKmVudHJ5KSk7DQo+ICsJaWYgKGVycikNCj4gKwkJZXJyID0gLUVOT0VO
VDsNCj4gKw0KPiArZnJlZV9mZDoNCj4gKwloZnNfZmluZF9leGl0KCZmZCk7DQo+ICsJcmV0dXJu
IGVycjsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBoZnNwbHVzX2ZpbGxfc3VwZXIoc3RydWN0
IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiAgew0KPiAgCXN0cnVj
dCBoZnNwbHVzX3ZoICp2aGRyOw0KPiAgCXN0cnVjdCBoZnNwbHVzX3NiX2luZm8gKnNiaSA9IEhG
U1BMVVNfU0Ioc2IpOw0KPiAgCWhmc3BsdXNfY2F0X2VudHJ5IGVudHJ5Ow0KPiAtCXN0cnVjdCBo
ZnNfZmluZF9kYXRhIGZkOw0KPiAgCXN0cnVjdCBpbm9kZSAqcm9vdCwgKmlub2RlOw0KPiAgCXN0
cnVjdCBxc3RyIHN0cjsNCj4gIAlzdHJ1Y3QgbmxzX3RhYmxlICpubHM7DQo+IEBAIC01NjUsMTYg
KzU4OCwxMSBAQCBzdGF0aWMgaW50IGhmc3BsdXNfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiLCBzdHJ1Y3QgZnNfY29udGV4dCAqZmMpDQo+ICANCj4gIAlzdHIubGVuID0gc2l6ZW9m
KEhGU1BfSElEREVORElSX05BTUUpIC0gMTsNCj4gIAlzdHIubmFtZSA9IEhGU1BfSElEREVORElS
X05BTUU7DQo+IC0JZXJyID0gaGZzX2ZpbmRfaW5pdChzYmktPmNhdF90cmVlLCAmZmQpOw0KPiAt
CWlmIChlcnIpDQo+IC0JCWdvdG8gb3V0X3B1dF9yb290Ow0KPiAtCWVyciA9IGhmc3BsdXNfY2F0
X2J1aWxkX2tleShzYiwgZmQuc2VhcmNoX2tleSwgSEZTUExVU19ST09UX0NOSUQsICZzdHIpOw0K
PiAtCWlmICh1bmxpa2VseShlcnIgPCAwKSkgew0KPiAtCQloZnNfZmluZF9leGl0KCZmZCk7DQo+
IC0JCWdvdG8gb3V0X3B1dF9yb290Ow0KPiAtCX0NCj4gLQlpZiAoIWhmc19icmVjX3JlYWQoJmZk
LCAmZW50cnksIHNpemVvZihlbnRyeSkpKSB7DQo+IC0JCWhmc19maW5kX2V4aXQoJmZkKTsNCj4g
KwllcnIgPSBoZnNwbHVzX2dldF9oaWRkZW5fZGlyX2VudHJ5KHNiLCAmc3RyLCAmZW50cnkpOw0K
PiArCWlmIChlcnIpIHsNCj4gKwkJaWYgKGVyciAhPSAtRU5PRU5UKQ0KPiArCQkJZ290byBvdXRf
cHV0X3Jvb3Q7DQoNCkkgYW0gc2xpZ2h0bHkgbm90IGhhcHB5IGFib3V0IHRoaXMgcGF0dGVybi4g
OikgQ291bGQgd2UgcmV3b3JrIGl0IGluIGJldHRlcg0Kc2hhcGU/DQoNCkkgYW0gdGhpbmtpbmcg
YWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KaWYgKGVyciA9PSAtRU5PRU5UKSB7DQogICAv
Kg0KICAgICogSGlkZGVuIGRpcmVjdG9yeSBpcyBhYnNlbnQgb3IgaXQgY2Fubm90IGJlIHJlYWQu
DQogICAgKi8NCn0gZWxzZSBpZiAodW5saWtlbHkoZXJyKSkgew0KICAgIGdvdG8gb3V0X3B1dF9y
b290Ow0KfSBlbHNlIHsNCiAgIDxleGVjdXRlIGxvZ2ljPg0KfQ0KDQpXaGF0IGRvIHlvdSB0aGlu
az8gRG8geW91IGFncmVlPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiArCX0gZWxzZSB7DQo+ICAJ
CWlmIChlbnRyeS50eXBlICE9IGNwdV90b19iZTE2KEhGU1BMVVNfRk9MREVSKSkgew0KPiAgCQkJ
ZXJyID0gLUVJTzsNCj4gIAkJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiBAQCAtNTg1LDggKzYwMyw3
IEBAIHN0YXRpYyBpbnQgaGZzcGx1c19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHN0cnVjdCBmc19jb250ZXh0ICpmYykNCj4gIAkJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiAgCQl9
DQo+ICAJCXNiaS0+aGlkZGVuX2RpciA9IGlub2RlOw0KPiAtCX0gZWxzZQ0KPiAtCQloZnNfZmlu
ZF9leGl0KCZmZCk7DQo+ICsJfQ0KPiAgDQo+ICAJaWYgKCFzYl9yZG9ubHkoc2IpKSB7DQo+ICAJ
CS8qDQo=
