Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387B125B2;
	Wed, 18 Mar 2026 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773799349; cv=fail; b=V/7WfkcFdvc3pcJaR0TZdD6b86t1LNTekCSk4ysg9fgCU3Ai6MnQw6CrKbMN5yyG2wk5hGZH7V4qFi70ItaLyqTuVkvl906urncWcLKTpC3sEtH067Zg3wrYLuHU5QA8HXGvrHEgaynC53K7IC6M98V9kcBu+KUDDpiu3KXvIv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773799349; c=relaxed/simple;
	bh=SSgUCM/WnO23z2Wc6cFr/Iq5HfdXx58U2Qef1sGbKdg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ldyiY0amfWuX5LRnSV2hxWwIUPx6xCut4yiMBXOjkrPluzWlmBD7qFTGE9DpS5bQCJ9YidRQz/n+Z1jugaVHaUtPYEFz8rLoR3c1snI6hnERejCwdHdHDZ1HfS003hLnVFRtpE4ndZ1xPlBJd+X4Awzsb5uQICAPxLlLQtk/UuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CScGeuGH; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CScGeuGH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HKA8tY976992;
	Wed, 18 Mar 2026 02:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=SSgUCM/WnO23z2Wc6cFr/Iq5HfdXx58U2Qef1sGbKdg=; b=CScGeuGH
	2OpK1r3l+zk1t2e6H1SJ44pRCLwWaKBlq+vdQUOYdzkrsAJkzVKQN7U4ulDItuhY
	X3DrnJBF5Qar2cxnCfbVC5e5QitSyW0ec71+3S7WwNSoRS5w51Gse+CYV2xrFn5p
	sjHDDuUB0n+WnGPWW6ganb+AE0yBJbVvL6SqSCiaMC3wfqwzvTcZPFd/uxILMlLM
	/isG4bN7HZCRSCM+xO3KlptDCirdxIbqrwUFtSBLyFdJcD8geSMA9IoNNM4nZB40
	vi5t/DWH5/MGmvk5a/q1oadgtnThOEeqk3R/hvtD9OUyYLy4wDmEtbaU2c/PSAPd
	HQhOYiJMHaQc3A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cy43k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 02:02:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw09S4q+rMSw7duC2gPOY7HwTBP+QUbfPSonzPuNkZKYOdihUw7xHt3D1b/1yGog70MYl7tQTDT1GCVrD1ukvo2ZcRtwFMJ/1EYt+J63O66YZTYPxcVhCl1Gfl/2jpyTrU0A/a/iIAm8LnnFujfO2l2PkvjBMq7bvPwzJXBfVAM7CeDekb7gqIUu9Ds1oYkSdKomojag7XYOmEBHAXT49SdxlXdJWhaLs6/snWIH95H5iW8wqHgzdD+7VSWmnRZS6/TuKD4pwufnhumrEHJ5j1oklj+NDP61d5jRmrGVgMey9b63MmJZMUA7pr8TRFOzTD2D+T3QQxbW+jbmjFLyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSgUCM/WnO23z2Wc6cFr/Iq5HfdXx58U2Qef1sGbKdg=;
 b=wmrckAyEQTD85kRFEK8PWiV89vR3VAnV22lLhOg61rns71KYKV44NrfzHs4Jle8/qTiU8GWTKZWExiJ9zcM5uSewIdoITI2pXpC2f04UJZ4NnYGxcZaFa0mo+tBevi8C6t/hBA5HcLbZUbxnLgaOWMYdbMezziyU5nJhQnlnQlhakdfKLq84ZbFfZlfPfE6QBzBXwx0qnubmibkTFMztxDXx4NAG5U5AzL1IfQm5uNlt05O4e7fCUqJFwnOhLYIlXjmZ/jz5tzKyg/Hz3Ij/PG+4yFj3ymXENIQ7z84n6DZOMATbozWTFj/EQ+ypFxSZiBBkFAQrmuntwJiyPhd9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH8PR15MB7067.namprd15.prod.outlook.com (2603:10b6:510:3aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 02:02:11 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 02:02:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>
CC: "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@i-love.sakura.ne.jp"
	<penguin-kernel@i-love.sakura.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
Thread-Index:
 AQHcsg/APN5tsWR8/06I9Ew1VYcR+rWrh4IAgADGZ4CAAH/BAIAAx6WAgAQkTYCAAcD0gIAAF8WA
Date: Wed, 18 Mar 2026 02:02:10 +0000
Message-ID: <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
References: <20260311211309.27856-1-contact@gvernon.com>
	 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
	 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
	 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
	 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
	 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
	 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
	 <abnzsVk9JNN3alKq@Bertha>
In-Reply-To: <abnzsVk9JNN3alKq@Bertha>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH8PR15MB7067:EE_
x-ms-office365-filtering-correlation-id: a64bf559-b51d-4e91-3591-08de84925df0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 s74jDLLuO1AGqKsRhiPZmrwncmPQ/cJ+AlUzWe07cQB23g+C/sSel0raDl9Nx8VNRfMJETh+7uBnllD01PoVOBDnQ8nwGOJqhQUA0S+PeVO6jqJc0Za2ZMshGixIC8xVrs8G1dLv6ubFSsQcjJr862lWuovffQyv6tVy8PWaQwNh6I+2GkAxxuIDQ1Dd3b/x4nZPe+cOQirnhHt62Gi67+PBjADDLtSt2+Lsm+uAhRWsu34CwZF3own8qE+52m1eyCsWbFZoQOvcZgtkowH/I1AmAq+JSFrDlzQd82vBFozGaCvEoS+MXxTG8LnF7iqF8MBRteY0S5hBhj9TEQIghy7lezh/5yowuVM3hFZvbrWWpICNVN7X4VZy0nhVIfZq/oxknS/61O6QDyil5egP5Ibh/1NfGE2DhASQFb5mzCTv5nW/Gqi1LK4EF9UCPfLUXX8a/vTcxkRMT8aUuGfjCV+zkt9gS5wrcJsR9kZk31K6fsaxIGuocKFuC99XU2+eAuPaZkboNRI/9B9rNHhJhiVqa3OzlSngBVNzqPPAOCBhW+lv0rJ3pMgoP/Jt/r1QtIIkQWTU3CgQ+1yUwtBNOt1FkZFbB/YM0qMnhiiuih2oHBWb7/ARgSe46qCuWGoudLYJj/hir2Kcl948STz1+kUU7Jk8cQnNRQ/2Zbmew+bhGOFSUQ4NLPRAB7SrIhdeudmi+rYkt0kNbs2NeelVk7SyFSdTEEvfY2HobwV1OtvVnu6Eo6VkyTr/1IYSz6alvEki5AhL4GSgthwmSPJmrU0Zcu/sXfy9kvpjv1fQb8s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2hNNGswcHZlR3RpSFV0ZkRCeXNWdHBwV2tkZCtTNW9XbHBNUC9BQkYzb0tI?=
 =?utf-8?B?SW5ZRXl3M3RKODNyY1RGSGI5U0Rhd09uRHhHNWZRWi85SWp2eDU5SmJyQ25a?=
 =?utf-8?B?RjgycXNlUDdGRjVDbVJoNjB4bnFFMDNqeHpTOVVnRjNZOENZWkF2cmo0TWlO?=
 =?utf-8?B?TlA5bDhtcFc5ajIyaUwxVjlYV0tVbnJTcFJyc3hEejdpRWIxQS9LQ1BOTDBs?=
 =?utf-8?B?WjhQM2I5Z1dISytTT2xrU1VFNC9pclNhMGdjdFk5dGxSV24wNVhtNEptOTJs?=
 =?utf-8?B?SkR2SFdaOThPMzhRbWRub0pUdmd0eHhJczk5WGYyRzhRazh0Nnl5QllmNEI4?=
 =?utf-8?B?UEI5akNxdE0vanVQdldJZ3dMaEZqam1DdUtRbHZVZi9aeU03bm1CZHdzZGRi?=
 =?utf-8?B?RXoxSzZsY3c2QmlORXlreUE5c1IwSEpSWTBDVUxyS2hIemd2WVhxR3U0alVx?=
 =?utf-8?B?Tks0MnNoeTlZeU41OGYxV3QxZjNwRmZIU01QSk1TbG9PbWdINWlqQ21zZy9T?=
 =?utf-8?B?d3F1Ni8rTDRJVDcyT1FwS2s2S1JZTVpDVDZ6TE03UjhGc1BRSDlUbFFFV2Vv?=
 =?utf-8?B?TVJxVXVZM0Q4TjVKckxYU0k0Z2hKOUxoaVNQYUFIaG15RjREUGpvM05WTzBT?=
 =?utf-8?B?TjRUTk9LY29sMm1xR0N1aUtoRWs3WVBicXh3Mk1Xa3ozUHRLYTk4a3MxRzNa?=
 =?utf-8?B?eldVdG0zN3Y3YVBNelJ5a0pNZkxlS1gxZ0FDWTExVnNMSHc0YUM1WTZLcmVE?=
 =?utf-8?B?Y3BmWUFKNjR0Z0dZRXZJazlpQUpSVmNyNzFzUkF3WGRXd1ZVbHMyS0djYUJY?=
 =?utf-8?B?MFZja0ozVXZrL3dBMk1vdVc1a1JJTDJ6WGV2MDRJZnJ3eGNMTzhORW1NUm54?=
 =?utf-8?B?aE1vMHBaMlhITWRpUzhWU084OEoxRm44Q3FydGJmUmtmRzFwKzFyYThmblAw?=
 =?utf-8?B?K2NHN0J0azlOVW9lTzFCRlc4N0FpSytrK1NVdkx5ZU14V1hnL0F1aktwaFFZ?=
 =?utf-8?B?bnFlWXlxdVFOcmZlcXdvQXRLSCs0OHAyODNoVC9mRkNIMVBlS1RvVmdOUFpm?=
 =?utf-8?B?Q2Y5eEZnMlJGQnF0d1IzOFFUMFV5RjBZKzU3NXhyMUk2RHpPWDlqVDVuUnZV?=
 =?utf-8?B?SVZRbnZWNGFJcU5WTU9yYjl3QmNqcWk2WllCVWZKSHJZRzdOU2ZNb3JxelVS?=
 =?utf-8?B?UXZta1VacFJOUnUyMTR1RFdsSzFubWJZVjdqay8vTk1JRUlEdTZ2NGhoWVl6?=
 =?utf-8?B?NmJuQ3FkbGRTS3Nvc1RvcTB6TXNoTndXSWNSaVMySXN2Q3FiQjF3ZG05TXFU?=
 =?utf-8?B?NjZneEdmRmJ5bEJWdmcyYzZ4L0J1Vjc2M3ZsTW5uOTc4MFNYN01lZjJVcWFj?=
 =?utf-8?B?Q3hnKytab1Bod0JRaUlDZU14a1VKZml0dVd6Zk5ucHJNOElKZ2h3bWoyNWs3?=
 =?utf-8?B?RUpNR3BaMWQvdGt1VXBVMFNYRC9oTVNSZ3hWU3AycnVGRmRueDBRVWhWZXBu?=
 =?utf-8?B?c3dDZzYyMUpqekRvRTAxNUZFbGRsTE5sbEoxRGdjRWN2OWdZcVlqS3ZuN1ov?=
 =?utf-8?B?TDkzV2ZXcWpnM2NKT1JadCszT29yS0x3ZzhkNjlwWFZVNnFNeG5LYjNSYlcv?=
 =?utf-8?B?dGVQeFU2WWFvNWYzdDlHWkJKQVl3a2pUTG11WUJ2K3pLKytXMHF0alBlZUZr?=
 =?utf-8?B?ckF6ay9zaEhiU05HTVN0MU1JNEZZWFQ3aFpvdG9YSVdoR2I0R3ErenB4ZG8v?=
 =?utf-8?B?dFNnck9BR1E2M29lUUxJTVcrK3VnWnZyS08xSFBpaGY5bUhXVThYRTJFc2ta?=
 =?utf-8?B?RTViWFU0Mk9WcXk3SXRTYlBrc2lGSHdQNXVpc1J1M2k2WnM5TExjSTVoZjBD?=
 =?utf-8?B?S3BKSlozekU3QTFLZjlqNEJPL2VsR2loNzBwMmtMbHl1ams2WTF6cGtOWWoy?=
 =?utf-8?B?cDdsWXhKZ3RSTHBETjJyc3RZK2VOU0pOUkd1RmtsNWFCQ1lJV2dFcUNWVjMw?=
 =?utf-8?B?MUprWjdRc2lvQjFRR2pLK3F2N0Z0VWRTcStWR3NUeEd3c2J5TklrVjdOd2FI?=
 =?utf-8?B?MGZCQ3htNzB0WmVYMG1BZXFXZGljT2U5RmdUUHdIeEtRNTZRc29LMWNtWFlB?=
 =?utf-8?B?djVxOFhTVlVxbnhwb2RsRW9KVWVmYzd1TW1jZUJiaE0zL2VGMTBUOEZCVVVt?=
 =?utf-8?B?cVVtYnQzVG03S3Z4anBycHloSnRwMFFWZHJML3NjSTMxaWxWTFFuUWtjeThl?=
 =?utf-8?B?MjZaVXBVWllia3FRbDV2RmY1S3JjMk9NbEEvcTBiclc2bWgyNXNHdlloVFkz?=
 =?utf-8?B?U3BTWEV4NWRzRDZERTNPOGs2Q3B1cWFiMXpIRklXbC9vYWJHQXh5S0ZTS21Z?=
 =?utf-8?Q?GeI1IqubXtDUlKANHTCB4PqOayyHAACjx0AyD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A62F3E0302312048B9F63B8582C44698@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	InTKHZqmOrDGHd0/SZhIaVku/iZPgxj7+V1sLAha9yU4xY1iIb/EQdLapp3ySSTktuglaD9idH8ETy3CcQRJYWxzPPSPAL3jm0gC5lagRtteE6p9z1Y4QQE2e69N25ePgFFsIuY7RT3G+ZQChQroIgci0liB90TQUvVH0mf2gqTulK5GPmk5YeapNd51lLPSVDaxQZTAH9O6fIP12YzaVBcrRk2TKZxd6MEv+Q3GN6t2QXnXcsWS58dul3agCqfDEEaU1N3IBzy5RPGnkhIOoV3n4oEbJ6UhQCulANFAh91JmJ2FbwykGc++IzZEf2ySw8MXg1datcJD39JZTh7CSQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64bf559-b51d-4e91-3591-08de84925df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 02:02:10.9069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNs8FbLP8DZbIceJt/dnlIyIoSsBCbMyJEocjOtnDxRdtObHOEpgTdCmDg/BQmefcYH9+qy/DfWuJr/tKD5rkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR15MB7067
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69ba07a5 cx=c_pps
 a=MBvOscNZ4ImqL1nQClNoCg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=LMw0XaIsVMKyNYn9RTkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAxMiBTYWx0ZWRfXzpyA80yLMvaU
 7IzWu1F4gqtQhygtWAFlsLJIexl4bZwI+bTUFrzFi9yExTIfLy3PwyQiizCAC0xWvhCvrtVWW2B
 S+9Kn4wmOU+v88xJGBwcuTbZ1mOdVJc7djtqFLDefWqACIsMIdnrZQg9kQ33FfDxjjTn/EDHJVD
 cBSs1/sm488gji010ctGpIUho0CcWuSzGfjjfS2fUvLFR7mXFsx5TkRc9mYVPo/vRCenIR2cE9j
 nhQ8EvzDzBBFbhYxg6A4+Jt0HPbi3genufdL9S/rdU0S1j8lEYDiAhev8XdVMMsvtvQWFJSpH7w
 7eyOCVJNy8qcI/7oTQeRrHHcEQmPYGbrv+eAhpNY9aVUosqCCpadQ3nF1JtmEGvt3kOLWsgCwiX
 ch1GjFg2KhMyemPPZDEHAqBWw5RDkG5ol6/PZLRxAjU/siVvqf9i51mH1TzRKS8cBOWpZ1Erugj
 eCZW3Ar5T0UCRpdrnwg==
X-Proofpoint-GUID: TFt8x42H2uS0ihXW_V80I_WqhFrrHyRd
X-Proofpoint-ORIG-GUID: TFt8x42H2uS0ihXW_V80I_WqhFrrHyRd
Subject: RE: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180012

T24gV2VkLCAyMDI2LTAzLTE4IGF0IDAwOjM3ICswMDAwLCBHZW9yZ2UgQW50aG9ueSBWZXJub24g
d3JvdGU6DQo+IFNvcnJ5IEkgc3RydWdnbGVkIHRvIHVuZGVyc3RhbmQgeW91IGhlcmUgU2xhdmEs
IHRoZXJlJ3MgYSBsaXR0bGUgYml0IGxvc3QgaW4NCj4gdHJhbnNsYXRpb24gSSB0aGluay4NCj4g
DQo+IE9uIE1vbiwgTWFyIDE2LCAyMDI2IGF0IDA5OjUwOjE0UE0gKzAwMDAsIFZpYWNoZXNsYXYg
RHViZXlrbyB3cm90ZToNCj4gPiBieSBoZnNfY2F0X2ZpbmRfYnJlYygpLiBCdXQgSSBjYW5ub3Qg
aW1hZ2luZSB0aGF0IHRoaXMgbG9naWMgY2FuIGV4dHJhY3QgdGhlDQo+ID4gcmVjb3JkICB3aXRo
IGluY29ycmVjdCBDTklELiBCZWNhdXNlLCBpdCBpcyB0aGUgbWFpbiBnb2FsIG9mIGhmc19jYXRf
ZmluZF9icmVjKCkNCj4gPiBsb2dpYyB0byBleHRyYWN0IHRoZSByZWNvcmQgdGhhdCBjb250YWlu
cyByZXF1ZXN0ZWQgQ05JRC4gQW5kIGlmIHdlIHJlcXVlc3RlZA0KPiANCj4gRG8geW91IG1lYW4g
dGhhdCB5b3UgZG8gbm90IHRoaW5rIGhmc19jYXRfZmluZF9icmVjICpjYW4qIHJldHVybiBhDQo+
IHJlY29yZCB3aXRoIGluY29ycmVjdCBDTklELCBvciB0aGF0IHlvdSBkbyBub3QgdGhpbmsgaXQg
KnNob3VsZCo/DQo+IA0KPiBJIHRoaW5rIFRldHN1byBpcyByaWdodCB0aGF0IGhmc19jYXRfZmlu
ZF9icmVjKCkgd2lsbCByZXR1cm4gYSBjYXRhbG9nDQo+IHJlY29yZCB3aXRoIGRpZmZlcmVudCBD
TklEIGluIGNhc2Ugb2YgYSBtYWxmb3JtZWQgdGhyZWFkIHJlY29yZC4NCj4gDQo+IE9uIE1vbiwg
TWFyIDE2LCAyMDI2IGF0IDA5OjUwOjE0UE0gKzAwMDAsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90
ZToNCj4gPiBsb2dpYyB0byBleHRyYWN0IHRoZSByZWNvcmQgdGhhdCBjb250YWlucyByZXF1ZXN0
ZWQgQ05JRC4gQW5kIGlmIHdlIHJlcXVlc3RlZA0KPiA+IHRoZSBIRlNfUk9PVF9DTklELCB0aGVu
IHRoaXMgbG9naWMgc2hvdWxkIHJldHVybiB0aGUgcmVjb3JkIHdpdGggZXhhY3RseQ0KPiA+IHJl
cXVlc3RlZCBDTklEIG9yIHJldHVybiB0aGUgZXJyb3IgY29kZSBpZiBzdWNoIHJlY29yZCBoYXMg
bm90IGJlZW4gZm91bmQuDQo+IA0KPiBEbyB5b3UgbWVhbiB0aGF0IGhmc19jYXRfZmluZF9icmVj
KCkgc2hvdWxkIHZhbGlkYXRlIHRoZSBDTklEIG9mIHRoZQ0KPiBjYXRhbG9nIHJlY29yZCBmb3Vu
ZCBieSBoZnNfYnJlY19maW5kKCk/IEknbSB3b3JyaWVkIHRoYXQgdmFsaWRhdGluZw0KPiBldmVy
eSBCLXRyZWUgbG9va3VwIGlzIGdvaW5nIHRvIGJlIGV4cGVuc2l2ZS4gV2UgY291bGQgZG8gaXQs
IGhvd2V2ZXIuDQo+IA0KPiANCg0KSWYgeW91IG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGUgaW5vZGUs
IHRoZW4geW91IG5lZWQgdG8gZmluZCBhIGZpbGUgb3IgYSBmb2xkZXINCnJlY29yZCBpbiBDYXRh
bG9nIEZpbGUgKGItdHJlZSkuIEl0IG1lYW5zIHRoYXQgdGhlcmUgYXJlIHR3byBwb3NzaWJsZSB3
YXlzOiAoMSkNCmZpbmQgaXQgYnkgbmFtZSwgKDIpIGZpbmQgaXQgYnkgQ05JRC4NCg0KSWYgeW91
IGtub3cgdGhlIG5hbWUgb25seSwgdGhlbiB5b3UgbmVlZCB0byBmaW5kIGEgdGhyZWFkIHJlY29y
ZCBieSBuYW1lLiBUaGUNCnRocmVhZCByZWNvcmQgY29udGFpbnMgYXNzb2NpYXRlZCBDTklEIHRo
YXQgY2FuIGJlIHVzZWQgdG8gZmluZCB0aGUgZmluYWwNCmZpbGUvZm9sZGVyIHJlY29yZC4gSXQg
bWVhbnMgdGhhdCB0aGUgc2Vjb25kIHN0ZXAgaXMgdGhlIHNlYXJjaGluZyB0aGUgcmVjb3JkIGJ5
DQp1c2luZyB0aGUgQ05JRC4gSWYgQ05JRCBpcyBPSywgdGhlbiB3ZSBjYW4gZmluZCB0aGUgcmVj
b3JkLiBJZiBpdCBpcyBub3QgT0ssDQp0aGVuIHdlIGNhbiBmaW5kIG5vdGhpbmcgb3Igd3Jvbmcg
cmVjb3JkLg0KDQpJZiB3ZSBrbm93IENOSUQsIHRoZW4gd2UgY2FuIHRyeSB0byBmaW5kIHRoZSBy
ZWNvcmQgYnkgQ05JRCBkaXJlY3RseS4gV2Ugd2lsbA0KZmFpbCB0byBmaW5kIHRoZSByZWNvcmQg
aWYgdGhlcmUgaXMgbm8gcmVjb3JkIHdpdGggc3VjaCBDTklELiBCdXQgeW91IGRvbid0IG5lZWQN
CmluIHRocmVhZCByZWNvcmQgaW4gdGhlIGNhc2Ugb2YgaGF2aW5nIENOSUQgZm9yIHRoZSBzZWFy
Y2guDQoNClRoYW5rcywNClNsYXZhLg0K
