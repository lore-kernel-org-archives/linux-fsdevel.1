Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5C366562;
	Mon, 16 Mar 2026 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700523; cv=fail; b=vAhvoq3eiGsDov+Id9GVHBrXFcSzNO+csy6NJEFHSytJK6k41N6eTc/HMSbZ5sjTeOYJFBDXtGaKleiwAK3RkMH8J+Rl8NL7Ql3ggNZAwwX1galQXCP4PiZvfN9y4qxdufZigIzWN8PjD5TsNy3YnzFk4u+M5+843iRH5Yc2kLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700523; c=relaxed/simple;
	bh=3mIbo0PK1roXvmC9tWqxZTU2rgnTS3qx02L6a3kcOMQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Mx9l4TEnCIPs/swkrf8VgErJAE3bP12HXPt6gs0pfNCQ76YrKfFCYro2lssg6E/J+HL4NjE9tTaRDEHOHRxEjdRh6+N2Wiqjk2a8Yh+wHvcI/vrYUMwoa0Jbjh312NlqAphHV6zfE4EDVEPZA5zFYz3K0o75ock//y+eBX8pM4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MIDX0fyB; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MIDX0fyB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GH88qS1189655;
	Mon, 16 Mar 2026 22:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=3mIbo0PK1roXvmC9tWqxZTU2rgnTS3qx02L6a3kcOMQ=; b=MIDX0fyB
	lK3UTeTvBPOK4ZEXczaWx/QV2SLYCbw4hzIwmGv32DOF8l6c769koEPIAIdQXUbw
	8nUdXrHxukcbdZM2WQE4BsTck1R0sE1fNfUJ6EUW7nQDOgRS3aPM6yFwEfarKQax
	hqaombRCIe3yz2sq36cJzm/dJP1YvQx2OFm6E1Anj6YTiCUUTyNy7iIDmRR1RZ5T
	JbCPnyYRbasJrZbth2TOQg3rA3BjZ4GeX4N+YAjlfa7DtfocaMANwJLyFTkcjIAR
	zVqO/Ku4kYlMZPt6UsqLgEfrMK2o2kYXqOm8T7wiaxWnO+Ytz4/R9wlTochGLRo9
	prOSpI4tS7NnZw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfc8pq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 22:35:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnVojP59nMHSb1RMxtlkhX2uuWC4HtAxeoQZ22qPz9ATSe9lSBkTHj23Mdk2UTdsyhHEYC6gdSyp+W+sjQiWFaOwUBYVbD83vzoCePoss0AJs9orZ623hziTdUl+w/YkKq0SsRhvCjDh5v8soTuvheMwLnRm8Q7lSfdD9Eaa2O52p8YQSykjpEIMNKOX8OoVeBdfvk3GZiGCJYTQDYVTqSnb/zAue3ux9AiWyt9MTQzwHD2hEn+qilZ1BHkVUx7e1JgNz3tcRXIv76+3dmp9Kozkn9gsbFi+UZv0pYRbN1MIlnGp84E3RTjWovqp7lngUtK4ZN4fmiIu+wlVVI+w4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mIbo0PK1roXvmC9tWqxZTU2rgnTS3qx02L6a3kcOMQ=;
 b=Z9w/LtSv0i7EAga6Tu20PgGjpGEYTuXwmZff065B41omWqiShTtitRDsf4k+Uj2BX0GY7Kxfh/PXQZlImCHXG3QJvYsb9SkCHChUHj18ZeeIxYvodZ11qxD1979lqAjLO2pPbwO5oeZCWmJrxrfjI3V4Y5gsDt4aFNvczWljG5sl/fvjUezc0j9SP7Ap6vct1ebF5f4Of+r7utD5oSweJahE6GenVJEYiCehG7yGVrtNGVwJI45L2ZEJtiwMty27tXU4sal9jgWAg/JTYs4a1j20+c7E6UmauKOQ6SKwweq5k4cWOG/8ZwaTf/wXuqt3drc1ZE1bqbbNAyenhZCufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB6163.namprd15.prod.outlook.com (2603:10b6:510:236::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 22:35:00 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 22:35:00 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "janak@mpiric.us" <janak@mpiric.us>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v6 2/2] hfsplus: validate b-tree node 0 bitmap
 at mount time
Thread-Index: AQHctKAn6K3yvzlro0qr92DwOc3cwbWxwP2A
Date: Mon, 16 Mar 2026 22:35:00 +0000
Message-ID: <c4df4e9ea51ac7cf02ece60e258b19cdcd628b7e.camel@ibm.com>
References: <20260315172005.2066677-1-shardul.b@mpiricsoftware.com>
	 <20260315172005.2066677-3-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260315172005.2066677-3-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB6163:EE_
x-ms-office365-filtering-correlation-id: fce03049-b73a-400e-cd6c-08de83ac4253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 jajKAxxG9h1dRRXj6yGIJxaxYp+YtMDBeG4QH8lgpqxEITn1ZsF2O7l+7u4GSgbktSzdZNe1uAhZYbi0nrYprPb7GP0eAylbubYam77AGXtLgO4n4vL9HuAv07zk3gwlFli5y04KNUlYiZhePjupRGDywjbjisW1CYyVaxbCMeO6gFr2metIkUizLbL3ZyBzaBwDm9bWyQO/cZdWg+GyBJz70oFwuOklPv2ZuicvKGUETFakzq8lZZT4sdfovCduSAy+K4U0uRvc/TSBASeQfZec0Nb+iuCYSHoXR5dgXhyaaPi7Fzjv36LcDZfd8Xx3H8oZi2BLYceNO0isIM3R/6xmE3srChjf+xWtBxh7azlFl+C5thHRKCyS7sIXeSA9KcXxKyM7qa1hojSEhxMt0/hQyrYE3pvTUTEEb2znCY4YtUTWz6J46IKEoFFQpO5evgcav3Adi8nrOJMpfXjChvWDHFExU/ywaYyrz1/gZVR/JvaLpqqdSlkNlw//rXyiQawyapZ/Kw8KfZhBw//NEDFsBZjR0sKmX63iwLalsk6ZcrFlJV1g8S4Q9vGaaKrsuytEDXtlTxc5xKl9HXC8Ej3tKKp6LsDSV3GoIl8NFlvRwK76k8mD8cIK7JppfbySBH4gk+up4gumGBRGa44+gwfAslnEQjtX1DNuDRwJqaWeMqVar9lFa1t2Iast1oUgQ6SIIqzdw3oiRsGjeSLIlRvab/L+sDFX+pu9hPpoJFXEe2LGOp62vbdZa67xVRfT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzEza2w5Ylp4akQwdHMzVlN3cHZ0TkZXR0xOM1d2QUtkeU1BZGtUL05xZUZN?=
 =?utf-8?B?UWZ6amlwbGxSQjJRbDVFU1ZMTW54RWFUdVRhYWZtK3BmZ2R2Y3kxQ2FCOW1S?=
 =?utf-8?B?L2Q5T3BvVzUvdGNYZHdFNmY4RDNOMTFNVGtlWTdrb1JJSGZDSWhsY0F1RjZo?=
 =?utf-8?B?RlVyd2tlZWl6bi9aZWRlWldkZ1RkTG5nU01kMTJjQWlkbHoxckhhSHVLdmU0?=
 =?utf-8?B?YXpjUnkzMi9rZzJYU3N2M2tSWldqNUdqc0VEL29lb216VlNJL01sdWNoSjFW?=
 =?utf-8?B?ZW92MUZzdC8ydzJWVmhrMHk1OVRCZVg1eWVWeU5FT3lPYjQxcEZhWjlnM0gv?=
 =?utf-8?B?akM0OGNHYVJxa3FkUjVUWDFLSHhQMlEvb0lpa3p1MFBWVW9ES1kyVXYydHpT?=
 =?utf-8?B?ZG5RSmFLNlBSRXMyaFdTRFBRV3Y5SnFPeUJFVkJwZC80S1h2UjZuOUZTY21h?=
 =?utf-8?B?WnQraEFyVEM0djdBc2NrbVpTYmd1NGpjdjMyWmJKSzFhV29KdExlYzZKR1V6?=
 =?utf-8?B?bXUvZWlGS2NkRHdFdXBlZlIrUUwybjJqVkZTZUlMdDVzLzRqM2FTL3AxblQr?=
 =?utf-8?B?ajY3SUh3ZGIzU1c2L2dYZEFFNkRVWklnaDFJK0doMVBSQUpHR1ZZMlV1K2FV?=
 =?utf-8?B?QTRaS1Y2ZnN0UmJXZTUybTR1WlpUTGNycldzMlExY0JMZVNOUkQvSUYveGpP?=
 =?utf-8?B?SldBWjNiU21RTzI1c1BYRXp3T1JFbnkvVEMwTmZlRDVBQTgzemdPQkZSWjhv?=
 =?utf-8?B?aHJxUjhVR3U1dWxMa3oyOS9ma1NMYXY4SzhZOEE2dHF0UnB6MlB0NnM0ME9r?=
 =?utf-8?B?M0pqNld6aGVhWmRITEdUVTZrdk00SXIzUFB4RmpuMkI3SFo4UlhPYzVXS05o?=
 =?utf-8?B?bVNHU0JHREwvRXlZaGZ3a0xDcEtPczJWb1NpYTh3dEtRTnAwTk5iUFJKZkZB?=
 =?utf-8?B?cVh6TUZRNTh3UStzWWtmN3VoOFJiU1Nuc0R3VTRoK3gvSTQ5YVJHeG9pbWww?=
 =?utf-8?B?amttZlpHdFJmMEpLNXdXbFRDMkNTVTJ1aHZlR1RXN0x0TDFTa2xVUTE3TjJG?=
 =?utf-8?B?K2doVXREN2kvdWxvMFBkbVJ0aHJMSWZzNi9vS1krQXlZejZ2RzVtTmEyVW5p?=
 =?utf-8?B?UzFFeGVCK3kzRDlYV0lHQnFBYjZVQW5Oa3ZSOU4xdy8xVW5UYVZTSUx2cDN3?=
 =?utf-8?B?UEJpNERPT2NWbFpnclVwUlljcG1pR1dQSGg2WDNHZ3JGaFJCUlF1ampWamtx?=
 =?utf-8?B?MUd5WlBZOHRjM2VHVkhjZm52Q1BhekMyb0pvVU9Bc3FqTE1mUkdNSjcvY3F5?=
 =?utf-8?B?UXdJTzYyTUp2algxTUdoejMrZUtqbFV0N2d5Z3MrdVYwU2pwZWhtYnVpZkI1?=
 =?utf-8?B?bGNwd1U3UEM3NlZGenA0THY2aTZQWGtyY0VaVnAzTllsbDhyY1FiT2dTQXhT?=
 =?utf-8?B?bDJkcWhUOHNuRlE4aWJCa2VRTThNWm10akRFRGRieEFyU3d3WXpxcEpjdnp2?=
 =?utf-8?B?MlAvZ3RLcUhyUndOcnd2TkVkeHZWSVJRdzhYdEdwMEFyenhGQmFBNW5XMFBP?=
 =?utf-8?B?cUlHNW0zc2IzN1FZSG8xQ1RwOVRyVXpMdkMxa0RxT2pTWWRUTkxQRjJJMXVH?=
 =?utf-8?B?QklXdXFHVnN6aEhndnhKdzJjVzNseVNWZnlSbGhvWklxa21LSkt3SkplbXFD?=
 =?utf-8?B?RUVWVUYwWkpZRjhnUy9DWjEwM0VQRDMzR05oRWtZUXFjYUtXZkhERExsWmNT?=
 =?utf-8?B?VHpLbVMwM1FzR0lHWlRZS0dJSzJRdHQ1dURMLzJBNUFTOHpobkZlMzN2Tito?=
 =?utf-8?B?WlZQbWxCK1VZT1lTdTVYeEhhMnl5dklFNnFFdEFId1RtcXUzc2Z5ZFFGNWth?=
 =?utf-8?B?VEhndC81MjdrRVFNSDVyaFZKVDFHQXRyeUp6SUZHTHNDbnRKalZaU0oyaWxV?=
 =?utf-8?B?Qk9WMExXWWxRc0NiSjVLM0E2d3o0KzNiK2c0bU55SXQ0S0FGRnZtNkZQOGFt?=
 =?utf-8?B?UHdMdmFGaHo0VDdZQ0tIcUt1aXVCaEtxU0hXNnRqcU1kUUtMdWZIajN0YnQ3?=
 =?utf-8?B?QjBHUzN4bXBaU2ZVZGM5VkM5SmY3TVJieFpNTkQ1ZFQ4dmJjc2tid3AwdDUv?=
 =?utf-8?B?amZyT1JLWGxpZ3R4a25ZV2QwU2ZiVWFlSVJ0SDBkc0NILzAwZE03QlA1byt3?=
 =?utf-8?B?Q3ZVL2hZNE01SERYdkgxTU45dTZlY3ZySGZrMUJhaHpVenJ6YkM5QXFsTlVC?=
 =?utf-8?B?L3FXd1h2M0o5ZldrZElRUEJVNFN3ZFVyMFBqbk12Q2tyVEM3bXh1QUJaQWh6?=
 =?utf-8?B?ZXR0cDdtT1o1Z2RqZzVsbmxmY1ozbUZLMmhYRHRkZjRtZDhSTUR3bGNQNWw0?=
 =?utf-8?Q?1NGIESKaHtpTrVCs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23E9300BAF26EE478F267AAC51DB4D27@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	n75A+g8m2SHf/9v7XsbowiFuZGdb5HblLjfyKr2+td7wmMvGUmH95/vJkrw88qAqFngEtdtARxT4f7sPtUpyUE7oYpem8GauhFiLZxi6BrGE8Hu8TosNxMdFabjMkqbtCC8aLrkuqKXehW4fmiYe/1U6lPuxSJLwG/80gp10WVs85ZXXCorilzHXhekZDDYgV/nupYoJVfdBvGBVg3AEA54iqnuBL0ejMhgJ1b/bkY3OBs7fayjQ5NkWn/XL00R3MmxU6wQZKzdVznCPIt99W9in8fndysZ7yng8ADKQV/QiffJk1ukNWWUfuMDATDcRIsVXuMMt8P1r/XPL7ZGVvg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce03049-b73a-400e-cd6c-08de83ac4253
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 22:35:00.2701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBTSbCl86r2/FaqHpbJR1M9/jwWiAob0rlTMWGz70OU2kg9biZMPRMs5v0pddjxg4Lqi2FGQeJLMpu+3y3cN1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6163
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aF9IpTWoBxMh023SWTCF-tl2W-dpFQvS
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b88599 cx=c_pps
 a=G0fLBfPV4gnnEhzimi2a/Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=szKgq9aCAAAA:8
 a=hSkVLCK3AAAA:8 a=X4SKyhY1npt6HT5od_8A:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=R_ZFHMB_yizOUweVQPrY:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE4MyBTYWx0ZWRfX3wTelfvhSg5+
 kv0W4kO/eoBJuaBXN+7zSGi+ud3Uml7OfXBaEsHReAHB05d4LlG38yN7TfRKMv1tGVuaIHaQkOH
 2F8F0pf2CgsvImKEz9zcpSj+5armwrtSKPPgU+ExFGgUOpkqnhGzHz2XOVz5Kx6rI5PTVqyvGgd
 qRi4Zc++UCHsfkkiPnJA/cq8fhS2WJY8psh22AvNlPhL53EG0w362HKaoEAOiFtKZMYrfhS3Qnc
 whr18j5iMFpFKQuuNyNNnbmC+5UpR4sTRhr6b0c6W908l/mIp/pjMOQjqbvg4udp/IsA/CZ+lJk
 Fo0DC7iqzUfaPQj+PTOBY4a2MqCtCuvQRWknmDD9e+uC9aIcIlwGNJF+aAsV6AAbJ7/OexHIcsZ
 Kf7H/xm3z41QBO675WbKDG5o7NAeW59KLui8Fvf2J0OU6j/K69PzP3oPpaFU23EL+9LoOKzcgdi
 W7Ylf0W0G79JfZSzqMQ==
X-Proofpoint-GUID: LxN1z1FYtDuUTc-8h_epjdRM56pQ3V4k
Subject: Re:  [PATCH v6 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160183

T24gU3VuLCAyMDI2LTAzLTE1IGF0IDIyOjUwICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gU3l6a2FsbGVyIHJlcG9ydGVkIGFuIGlzc3VlIHdpdGggY29ycnVwdGVkIEhGUysgaW1hZ2Vz
IHdoZXJlIHRoZSBiLXRyZWUNCj4gYWxsb2NhdGlvbiBiaXRtYXAgaW5kaWNhdGVzIHRoYXQgdGhl
IGhlYWRlciBub2RlIChOb2RlIDApIGlzIGZyZWUuIE5vZGUgMA0KPiBtdXN0IGFsd2F5cyBiZSBh
bGxvY2F0ZWQgYXMgaXQgY29udGFpbnMgdGhlIGItdHJlZSBoZWFkZXIgcmVjb3JkIGFuZCB0aGUN
Cj4gYWxsb2NhdGlvbiBiaXRtYXAgaXRzZWxmLiBWaW9sYXRpbmcgdGhpcyBpbnZhcmlhbnQgbGVh
ZHMgdG8gYWxsb2NhdG9yDQo+IGNvcnJ1cHRpb24sIHdoaWNoIGNhc2NhZGVzIGludG8ga2VybmVs
IHBhbmljcyBvciB1bmRlZmluZWQgYmVoYXZpb3Igd2hlbg0KPiB0aGUgZmlsZXN5c3RlbSBhdHRl
bXB0cyB0byBhbGxvY2F0ZSBibG9ja3MuDQo+IA0KPiBQcmV2ZW50IHRydXN0aW5nIGEgY29ycnVw
dGVkIGFsbG9jYXRvciBzdGF0ZSBieSBhZGRpbmcgYSB2YWxpZGF0aW9uIGNoZWNrDQo+IGR1cmlu
ZyBoZnNfYnRyZWVfb3BlbigpLiBJbnRyb2R1Y2UgdGhlIGhmc19ibWFwX3Rlc3RfYml0KCkgaGVs
cGVyDQo+ICh1dGlsaXppbmcgdGhlIG5ld2x5IGFkZGVkIG1hcC1hY2Nlc3MgQVBJKSB0byBzYWZl
bHkgdmVyaWZ5IHRoYXQgdGhlIE1TQg0KPiBvZiB0aGUgZmlyc3QgYml0bWFwIGJ5dGUgKHJlcHJl
c2VudGluZyBOb2RlIDApIGlzIG1hcmtlZCBhcyBhbGxvY2F0ZWQuDQo+IA0KPiBJZiBjb3JydXB0
aW9uIGlzIGRldGVjdGVkIChlaXRoZXIgc3RydWN0dXJhbGx5IGludmFsaWQgbWFwIHJlY29yZHMg
b3IgYW4NCj4gaWxsZWdhbGx5IGNsZWFyZWQgYml0KSwgcHJpbnQgYSB3YXJuaW5nIGlkZW50aWZ5
aW5nIHRoZSBzcGVjaWZpYw0KPiBjb3JydXB0ZWQgdHJlZSBhbmQgZm9yY2UgdGhlIGZpbGVzeXN0
ZW0gdG8gbW91bnQgcmVhZC1vbmx5IChTQl9SRE9OTFkpLg0KPiBUaGlzIHByZXZlbnRzIGtlcm5l
bCBwYW5pY3MgZnJvbSBjb3JydXB0ZWQgaW1hZ2VzIHdoaWxlIGVuYWJsaW5nIGRhdGENCj4gcmVj
b3ZlcnkuDQo+IA0KPiBSZXBvcnRlZC1ieTogc3l6Ym90KzFjOGZmNzJkMGNkOGE1MGRmZWFhQHN5
emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29m
cG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19zeXprYWxsZXIuYXBwc3BvdC5jb21fYnVnLTNG
ZXh0aWQtM0QxYzhmZjcyZDBjZDhhNTBkZmVhYSZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtW
eVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09N2Rs
SXhqYVdGaG9NQW9TN3luV0pRVFkxX3ZpZlNGdk9VV0YzYXJYRVdQMjRZeXR4dlV1cHV2N19nV0tX
VVV1MSZzPXlTTUd6YmcxMEJyMk9WZ0NZSy1DUkNkR2xlZXVRbGZ3NFBlbnpHZ2Jmc1kmZT0gDQo+
IExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0z
QV9fbG9yZS5rZXJuZWwub3JnX2FsbF8yMDI2MDIyODEyMjMwNS4xNDA2MzA4LTJEMS0yRHNoYXJk
dWwuYi00MG1waXJpY3NvZnR3YXJlLmNvbV8mZD1Ed0lEQWcmYz1CU0RpY3FCUUJEakRJOVJrVnlU
Y0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPTdkbEl4
amFXRmhvTUFvUzd5bldKUVRZMV92aWZTRnZPVVdGM2FyWEVXUDI0WXl0eHZVdXB1djdfZ1dLV1VV
dTEmcz1KejJURnhZTGUtR0ZUNmRsS2h6VXM0NERvYWNrVE53YjB5R0Z0clVFVTBRJmU9IA0KPiBT
aWduZWQtb2ZmLWJ5OiBTaGFyZHVsIEJhbmthciA8c2hhcmR1bC5iQG1waXJpY3NvZnR3YXJlLmNv
bT4NCj4gLS0tDQo+ICBmcy9oZnNwbHVzL2J0cmVlLmMgfCA2NyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvYnRyZWUuYyBiL2ZzL2hmc3Bs
dXMvYnRyZWUuYw0KPiBpbmRleCAxYzZhMjdlMzk3ZmIuLjdjOThiNTg1OGY5OSAxMDA2NDQNCj4g
LS0tIGEvZnMvaGZzcGx1cy9idHJlZS5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvYnRyZWUuYw0KPiBA
QCAtMTg1LDYgKzE4NSwzMiBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKmhmc19ibWFwX2dldF9tYXBf
cGFnZShzdHJ1Y3QgaGZzX2Jub2RlICpub2RlLCBzdHJ1Y3QgaGZzX2JtYQ0KPiAgCXJldHVybiBu
b2RlLT5wYWdlW2N0eC0+cGFnZV9pZHhdOw0KPiAgfQ0KPiAgDQo+ICsvKioNCj4gKyAqIGhmc19i
bWFwX3Rlc3RfYml0IC0gdGVzdCBhIGJpdCBpbiB0aGUgYi10cmVlIG1hcA0KPiArICogQG5vZGU6
IHRoZSBiLXRyZWUgbm9kZSBjb250YWluaW5nIHRoZSBtYXAgcmVjb3JkDQo+ICsgKiBAbm9kZV9i
aXRfaWR4OiB0aGUgcmVsYXRpdmUgYml0IGluZGV4IHdpdGhpbiB0aGUgbm9kZSdzIG1hcCByZWNv
cmQNCj4gKyAqDQo+ICsgKiBSZXR1cm5zIDEgaWYgc2V0LCAwIGlmIGNsZWFyLCBvciBhIG5lZ2F0
aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4NCj4gKyAqLw0KPiArc3RhdGljIGludCBoZnNfYm1h
cF90ZXN0X2JpdChzdHJ1Y3QgaGZzX2Jub2RlICpub2RlLCB1MzIgbm9kZV9iaXRfaWR4KQ0KDQpX
aHkgbm90IHJldHVybiBib29sIGRhdGEgdHlwZT8NCg0KPiArew0KPiArCXN0cnVjdCBoZnNfYm1h
cF9jdHggY3R4Ow0KPiArCXN0cnVjdCBwYWdlICpwYWdlOw0KPiArCXU4ICpibWFwLCBieXRlLCBt
YXNrOw0KPiArDQo+ICsJcGFnZSA9IGhmc19ibWFwX2dldF9tYXBfcGFnZShub2RlLCAmY3R4LCBu
b2RlX2JpdF9pZHggLyBCSVRTX1BFUl9CWVRFKTsNCj4gKwlpZiAoSVNfRVJSKHBhZ2UpKQ0KPiAr
CQlyZXR1cm4gUFRSX0VSUihwYWdlKTsNCg0KV2UgY2FuIHJldHVybiBmYWxzZSBmb3IgdGhlIGNh
c2Ugb2YgZXJyb3IuDQoNCj4gKw0KPiArCWJtYXAgPSBrbWFwX2xvY2FsX3BhZ2UocGFnZSk7DQo+
ICsJYnl0ZSA9IGJtYXBbY3R4Lm9mZl07DQo+ICsJa3VubWFwX2xvY2FsKGJtYXApOw0KPiArDQo+
ICsJbWFzayA9IDEgPDwgKDcgLSAobm9kZV9iaXRfaWR4ICUgQklUU19QRVJfQllURSkpOw0KPiAr
CXJldHVybiAoYnl0ZSAmIG1hc2spID8gMSA6IDA7DQoNClRoaXMgaXMgd2h5IEkgd291bGQgbGlr
ZSB0byBzZWUgYm9vbCBkYXRhIHR5cGUuIDopDQoNCj4gK30NCj4gKw0KPiArDQo+ICAvKioNCj4g
ICAqIGhmc19ibWFwX2NsZWFyX2JpdCAtIGNsZWFyIGEgYml0IGluIHRoZSBiLXRyZWUgbWFwDQo+
ICAgKiBAbm9kZTogdGhlIGItdHJlZSBub2RlIGNvbnRhaW5pbmcgdGhlIG1hcCByZWNvcmQNCj4g
QEAgLTIxOCwxNSArMjQ0LDM2IEBAIHN0YXRpYyBpbnQgaGZzX2JtYXBfY2xlYXJfYml0KHN0cnVj
dCBoZnNfYm5vZGUgKm5vZGUsIHUzMiBub2RlX2JpdF9pZHgpDQo+ICAJcmV0dXJuIDA7DQo+ICB9
DQo+ICANCj4gKyNkZWZpbmUgSEZTX0VYVEVOVF9UUkVFX05BTUUgICJFeHRlbnRzIg0KDQpNYXli
ZSB3ZSBuZWVkIHRvIGhhdmUgRXh0ZW50cyBPdmVyZmxvdyBGaWxlIChvciBCLXRyZWUpLCBDYXRh
bG9nIGZpbGUsDQpBdHRyaWJ1dGVzIGZpbGU/DQoNCj4gKyNkZWZpbmUgSEZTX0NBVEFMT0dfVFJF
RV9OQU1FICJDYXRhbG9nIg0KPiArI2RlZmluZSBIRlNfQVRUUl9UUkVFX05BTUUgICAgIkF0dHJp
YnV0ZXMiDQo+ICsjZGVmaW5lIEhGU19VTktOT1dOX1RSRUVfTkFNRSAiVW5rbm93biINCj4gKw0K
PiArc3RhdGljIGNvbnN0IGNoYXIgKmhmc19idHJlZV9uYW1lKHUzMiBjbmlkKQ0KPiArew0KPiAr
CXN3aXRjaCAoY25pZCkgew0KPiArCWNhc2UgSEZTUExVU19FWFRfQ05JRDoNCj4gKwkJcmV0dXJu
IEhGU19FWFRFTlRfVFJFRV9OQU1FOw0KPiArCWNhc2UgSEZTUExVU19DQVRfQ05JRDoNCj4gKwkJ
cmV0dXJuIEhGU19DQVRBTE9HX1RSRUVfTkFNRTsNCj4gKwljYXNlIEhGU1BMVVNfQVRUUl9DTklE
Og0KPiArCQlyZXR1cm4gSEZTX0FUVFJfVFJFRV9OQU1FOw0KPiArCWRlZmF1bHQ6DQo+ICsJCXJl
dHVybiBIRlNfVU5LTk9XTl9UUkVFX05BTUU7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICAvKiBHZXQg
YSByZWZlcmVuY2UgdG8gYSBCKlRyZWUgYW5kIGRvIHNvbWUgaW5pdGlhbCBjaGVja3MgKi8NCj4g
IHN0cnVjdCBoZnNfYnRyZWUgKmhmc19idHJlZV9vcGVuKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHUzMiBpZCkNCj4gIHsNCj4gIAlzdHJ1Y3QgaGZzX2J0cmVlICp0cmVlOw0KPiAgCXN0cnVjdCBo
ZnNfYnRyZWVfaGVhZGVyX3JlYyAqaGVhZDsNCj4gIAlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFw
cGluZzsNCj4gKwlzdHJ1Y3QgaGZzX2Jub2RlICpub2RlOw0KPiAgCXN0cnVjdCBpbm9kZSAqaW5v
ZGU7DQo+ICAJc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ICAJdW5zaWduZWQgaW50IHNpemU7DQo+ICsJ
aW50IHJlczsNCj4gIA0KPiAgCXRyZWUgPSBremFsbG9jX29iaigqdHJlZSk7DQo+ICAJaWYgKCF0
cmVlKQ0KPiBAQCAtMzMxLDYgKzM3OCwyNiBAQCBzdHJ1Y3QgaGZzX2J0cmVlICpoZnNfYnRyZWVf
b3BlbihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1MzIgaWQpDQo+ICANCj4gIAlrdW5tYXBfbG9j
YWwoaGVhZCk7DQo+ICAJcHV0X3BhZ2UocGFnZSk7DQo+ICsNCj4gKwlub2RlID0gaGZzX2Jub2Rl
X2ZpbmQodHJlZSwgSEZTUExVU19UUkVFX0hFQUQpOw0KPiArCWlmIChJU19FUlIobm9kZSkpDQo+
ICsJCWdvdG8gZnJlZV9pbm9kZTsNCj4gKw0KPiArCXJlcyA9IGhmc19ibWFwX3Rlc3RfYml0KG5v
ZGUsIDApOw0KDQpXZSBkZWZpbml0ZWx5IGNhbiByZXR1cm4gZmFsc2UgZm9yIGJvdGggY2FzZXMu
DQoNClRoYW5rcywNClNsYXZhLg0KDQo+ICsJaWYgKHJlcyA8IDApIHsNCj4gKwkJcHJfd2Fybigi
KCVzKTogJXMgQnRyZWUgKGNuaWQgMHgleCkgbWFwIHJlY29yZCBpbnZhbGlkL2NvcnJ1cHRlZCwg
Zm9yY2luZyByZWFkLW9ubHkuXG4iLA0KPiArCQkJCXNiLT5zX2lkLCBoZnNfYnRyZWVfbmFtZShp
ZCksIGlkKTsNCj4gKwkJcHJfd2FybigiUnVuIGZzY2suaGZzcGx1cyB0byByZXBhaXIuXG4iKTsN
Cj4gKwkJc2ItPnNfZmxhZ3MgfD0gU0JfUkRPTkxZOw0KPiArCX0gZWxzZSBpZiAocmVzID09IDAp
IHsNCj4gKwkJcHJfd2FybigiKCVzKTogJXMgQnRyZWUgKGNuaWQgMHgleCkgYml0bWFwIGNvcnJ1
cHRpb24gZGV0ZWN0ZWQsIGZvcmNpbmcgcmVhZC1vbmx5LlxuIiwNCj4gKwkJCQlzYi0+c19pZCwg
aGZzX2J0cmVlX25hbWUoaWQpLCBpZCk7DQo+ICsJCXByX3dhcm4oIlJ1biBmc2NrLmhmc3BsdXMg
dG8gcmVwYWlyLlxuIik7DQo+ICsJCXNiLT5zX2ZsYWdzIHw9IFNCX1JET05MWTsNCj4gKwl9DQo+
ICsNCj4gKwloZnNfYm5vZGVfcHV0KG5vZGUpOw0KPiArDQo+ICAJcmV0dXJuIHRyZWU7DQo+ICAN
Cj4gICBmYWlsX3BhZ2U6DQo=
