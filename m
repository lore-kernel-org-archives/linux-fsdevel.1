Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795008629;
	b=sUs4UkXbQl7A4oFddEhqzyPRZmgRYqJ9LjaC2Onw+VGP/Iy3ZJLyQH+BJrBfds8SFyDt
	 hFTEt3y7dmjTSuEpW4ct+ySOPyG+0kficH3oI9zLo6RBOPJphHd5qd9WLFx/xJQUHXQiY
	 QKpGCoXOItH+b3WJdN+L/KX+8vuc3M1BhX8eXCHKGG6zuIeg61s4D35xUKqhP2YNRDk81
	 FS+kJ5jL7QG1zRfWAah1CS0RpBbtbj9ToW7yDx7vNNcwVjtn+J1Wdgg8DnyxDClBw5JOp
	 FdRBDFwZbRxJ8M3EnkS+fRJdva+zW2tMOoXrjBwfCkNKeNbRSMoYPcXjCLS3b7ADcvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008629;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=abyS9x/up3+YpAHrsG57RgHS6oJWoy45kV6srWvhVt4=;
	b=MwhJI6tnsFtJSl5fpPM8MEpJTIHJw8opzEqvJkgPwkfzi52Lj1ToXE7DeHZClNjVCUd2
	 1h1nvLYo/X6uk7APh7S/hm++1SwKsEgGx4YSZst+mlrp039+upsnR5x3Y2BvwgkvltkZr
	 ZKFDw5dXLsK10tdGan4mHUSbXd4QaimGarmVFx4cnH9GwUfu4mD1UVN0WQBkIMH6VGabk
	 bKBDnoK5Yoir6Vr8xJayn5cLWULdReyIjYOvE70iRZbez24K98uaA0NDgWdoRMvUg1z0d
	 kIg03YgszV4iQ0B5BptbiylZB3QGuzAEwvW9EZXB/H0/jU8zbhPNgCNJdzyA68VZq8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BgksJ7zR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.7
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010007.outbound.protection.outlook.com [52.103.66.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D0606A331;
	Wed, 18 Nov 2026 13:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 758D0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BgksJ7zR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXDaq/HKHyVk9IwhONktFbH+I462xvB0dfbZga91vGwEZsiyJlC1aVCwg3S5oEQRANiZ8ZxO7rc0uI3s74f7XIAXASh6bcv/Wb9mXGkesF0V04RHSTYkzyDWOQIJgqRNXINFA85emTngMsYhM9J8mc482oOlWcd5i9MvbwxAre1xIRDhoVAzXO0oXmA8CDRfUjUdCnp9gTMD9v51FSc+BXVhQ2p2qPmlRFKrMlXItf062RgwqHb1QcGG8XkT1fNwDQrdpgqWH258gKPX/CDEIdnP5tPdW9UibC9djPzSSF1vPPDwVksIc8OajOazlG2FyKH7pZJdR7DJN+kWXCxbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abyS9x/up3+YpAHrsG57RgHS6oJWoy45kV6srWvhVt4=;
 b=D79k9wHS0JbnA8KoKI5Ey42koYj2ChRzNBJS42llF6SADwxSVsCeVS65t6YVO1NGK6NpLfjRt7biZDtRwrbR46EsUg8Faw8pbXekgvTaNB9y5r5AzCkwzspJFQoNEd+PWbXXIqFYW1loQRgcjFMXTWSTgsgHVGds7E2mJOy2g492YdmOlPF6vJ09wUmdgIun9EqiTd20FcTL3mtrWTX7b6K9J26/UpB3i/sMxnG7OCXoUwTPp7XmEiTnoF7RWfMFnmr0AbWyUNBXAgj2Doy3rYqxUOerDNq8UUyEHC+hN92OsdFnTd2CmoUXP7NZjojGa9LEz3+R+yiCgB+wV3QItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abyS9x/up3+YpAHrsG57RgHS6oJWoy45kV6srWvhVt4=;
 b=BgksJ7zRwdYspdNNgH+l28zORN/VjFxZE+yIOqRHOyCmlnjSOfkG8veEPVJeaMzAkeW4g92Ibrle/NGGrbB5jGJE9CLwDFBD4T8EUEtHt9rrXtjFnBdiStkoHp9ioqzwJbmhKAEONXLTfBilFu2lOKjPooeiUxmA/k/97xx0c6fJUA6GwRMOpq2/gBlwI0qglMyXHBnxEHt7oA3/QyHeNUysgqNkpQMov8+2nNFLJ9e06Qw/dMmd4xtRL0IcCKH3RpXjD1uT+ZyBFbwsLi4pmptfF/4/Zf6bG6DC4UzCZEuJxaa7InF23fjmbHx+CJkXMOmkl9+G0YFmAF/w8H97QQ==
Received: from TY4PR01MB14006.jpnprd01.prod.outlook.com (2603:1096:405:207::7)
 by OSCPR01MB13679.jpnprd01.prod.outlook.com (2603:1096:604:380::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:30:25 +0000
Received: from TY4PR01MB14006.jpnprd01.prod.outlook.com
 ([fe80::dc34:4880:849e:e4bd]) by TY4PR01MB14006.jpnprd01.prod.outlook.com
 ([fe80::dc34:4880:849e:e4bd%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:30:25 +0000
Message-ID:
 <TY4PR01MB14006C85EBAAA186836A6E05CA67A2@TY4PR01MB14006.jpnprd01.prod.outlook.com>
Date: Thu, 19 Nov 2026 00:30:21 +1100
User-Agent: Mozilla Thunderbird
From: Akisaira <akisaira@outlook.com>
Subject: [REGRESSION] fs: validate_fs_switch() rewrites fs_struct under PID 1
 threads
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0062.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::12) To TY4PR01MB14006.jpnprd01.prod.outlook.com
 (2603:1096:405:207::7)
X-Microsoft-Original-Message-ID:
 <e21db9f3-9c0d-41bb-8541-ae8d7f17b1c9@outlook.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14006:EE_|OSCPR01MB13679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8256eba9-5c6e-428a-5d5d-08df45781a14
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRMPeYK5sby1jCChGSM5LpvcCS6tUiK/ulbl7JfIIbZrT+Nfo/RRvLdFMvn2jOgfNouqx4w7oMFXdgmEIEz7Tmez2MO/1NsRvTModA0IHhscsEGcAQvhctAymDJQlLvkjnwpNOoHR15dbiifl3hY5cVQuSPpsZnMPbZxlNQs/fSOtWcw6360icNQZxKibYjnBwpoBEpIow6lwflghtsMkp/bGaZJYtpU0biNkg1dtAQ9opsEiSaHdNT+2mJkmhd4jDRw2UrsE3e3H286N7cdLNcacM70MLVScCmfWRv8dMMwlwvzeiKKKm5WBgK9NLfuHb69Mx17hEqrAphey5+2qy4hEH1DF1fjpnk7nERwgBbvgprFgpUBrJ3bGlGTIYhSJuqefFGl7vROGafkVawvIwJtqxOSNg7w3D1R8Z1GQwgGeY0ADn3EmegzbjMez2XJoCgkU+8cOA011EP9I/9HL2VeCnUEPEAR0n80hepcgL8lirbiai3h11Q5XXA8dSSbgENzWUFZNXRGNt+RVuqyOicMlWZbhT9xkjik2zPj5rQdzuhnYb1NM1SHvmd058Gx2o2TToRrvwCRVDho5JKhT1JynOGn6H0CFHN9LW2pHjT1mnOHUWjNqElRRqoIe6t4wKGVJQXWfbuJquQaZCX7Bpf/y+5tJY6E3eyIJ1rkCAvFLms3vT/3/Ii2MIpT1TLQgwWQy0CJoQirfhGuqeEnqllol6n4tuloTW1NPQZw9Vbxo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|8060799015|6090799003|19110799012|39105399006|15080799012|5072599009|23021999003|22091999003|24121999003|25031999004|25010399006|24021099003|22141099003|4140399003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTRrK0xtUzhKbE5rd0FUSlBVbVBiTWU2MjJOenVkK1Jxd3VPN3kzZmVtLzJV?=
 =?utf-8?B?RnV3eXFQR2hFWVNtTUhYNURQUjMvV0dhR0gyY2N1OFI0L3dTSmFmVGJaZTZM?=
 =?utf-8?B?RVYrODBKQkxINU5JbC9BYlpNZE85a1Y3Y3BDRkpSdy9ScWVVMEZxL0tvN0s5?=
 =?utf-8?B?VVVIRnMybDlpdk1zYjVyMlZKZGt0Qmw2MEc3OTJUbk1RNEVYWkhsdU05RWRZ?=
 =?utf-8?B?cUlub0hVMit1WUJMRndGd2Z1ZEovdm5XVXdTcElvQTlxZHlJVCtGRGlDMlJC?=
 =?utf-8?B?TzZFY3FXYzc5cWl0d3o4enRybDM4cEZOSW9HZGczbU51N2VzSmQrcjZ5NCt4?=
 =?utf-8?B?L3Z6UmF5dFVxcGIzUnd1M1ZibHEzZjY4eTM5UStzTjZnUVN1UUdBSE5LVEVu?=
 =?utf-8?B?ZFlManJCM3hYZmxDaWlQOVYyZEpSd3hiQjk1NlhIM3RJZzdQc25UNUlrOWY4?=
 =?utf-8?B?b1ZhS3laMjdGdHVWbEo3RU51ZW53TWEwczc1UmZZcGw5bXF6eTB6SFVSMUEy?=
 =?utf-8?B?ZFlIcXlhbzRDdFRod2lxSVRnU0hYY0l4eTlYNmJaZ00vTklSYlRoMDhsR29p?=
 =?utf-8?B?RkcxUGJFQnROWVpLak93TEo1WWNVTDN6VTZpN216QndHQjlTTDF6L1ZtZFJF?=
 =?utf-8?B?RXlPLzROckxTdVBIelNMdW4rMzZhcnZoeFJLemljL3BqU1JQZ1l4MEt5dXVS?=
 =?utf-8?B?elFoMFNmV0I1UlFJancwT1kySUVOYm1UWktDRG1wNXFsNDM3MVlwQ1hONEZt?=
 =?utf-8?B?UWJWSkVtTzZPVlhubVdBZ1RtelpRZUhnWWxtdjBLR0tuSmpNZEtnY3N2Njdh?=
 =?utf-8?B?cFpvcGVZVThsYndPNXI2cHBOWVl4eXNoLzJsVTgwRzNKTGdqS1JBNml2OFZW?=
 =?utf-8?B?YU5oZU9kVG1nZitlMGROcWgwNHl0TlEzdERjQUYyZ1Z5WWhWelBTUTRoUkhL?=
 =?utf-8?B?NFBHYTFCaHoxbGpZbUtDZ3JLWTU4Tk1icCt1UFhiK21CUThuR09YcWQvRkxP?=
 =?utf-8?B?Y1RFeHlVaHc3bHZaV3l6R1d2cDY1di85aUVYUkM0d2NXQUpCV0N3MkR3VEJY?=
 =?utf-8?B?cEZEZnBhYW14KzhuQzFuQmpWQy9RajlrRE83N3dqUHAzeGhuTDVEZmUvNDZJ?=
 =?utf-8?B?WEEycXdQYmF2MnhyU1FXLzRlN1N4MnZ0dlJlZU1xMXpXdStRU3JHbTB1M1Fu?=
 =?utf-8?B?RnN0VHVLSVVVVXhHeUpMRllycFRRQ1ppZzRYUm5DWHdpSk53RmpldWVGeEFX?=
 =?utf-8?B?YiticEs5WVJEUnFkSXpOZzc3QXlhcjE1TDYyaloyZVpCN211dlVscm1Gd2g4?=
 =?utf-8?B?a2RUZ2F0MEdnN3JvSTQzYVFXZmt4UWU2VTRrakM0Z1I4K2g5TDg2and3WDdT?=
 =?utf-8?B?YTM2M2FsRlFwa1dBaVlncjlRKzhFN2VBWUhSb05ObmJBVUFvUFkvd1VTZ0Zk?=
 =?utf-8?B?eHV4SzYyRjc4eU1MYkNJTzdRc2dRcXRtZFYwV3Y5UzlGMmVUeHdqQndjV3cx?=
 =?utf-8?Q?l4ANPuhnkVuCtDIOzdgbtjsPOLv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2k0RENwN1dCbzFDODhDN1RPRTlvNFowT2hFaEIvTHhkUmZDSmdXNjlWYTl4?=
 =?utf-8?B?OHpqdE4rTUE4SzdYdkJHSGJKZ1ZjdjhLQUhvQ2MvajNlT3JTQmU2c1QyMU5t?=
 =?utf-8?B?UTJkbHNmNVV5NFN5YkxDK1NxQzZqUVZjam9neThvZFd3QWczcDE3OStCbUhj?=
 =?utf-8?B?eWtVSGpUcEtmb0Y4dkRnV3dYZ0I1K1QydVE4SHVOZ01GOWViS3hGWURRRXRS?=
 =?utf-8?B?VjNXZi9nMHR4eFVZaldNdFFJRHR0cVJ1VHkvUlZkVE1iVFVCUi9DZ3ZCUDAr?=
 =?utf-8?B?ZC9rZTRQQ2sxS1dOaTU1K0Nrc0tiblVnY21zRUxqWXVDKzRCZkxiZklZUE5u?=
 =?utf-8?B?dmQwTnVZeStLRlVNUElIZDE4b2Zib1BnVnpFUU5rMW8vOU9rN1NxWEkrVG4r?=
 =?utf-8?B?dDYxZTc5Z3N0Sy8ra0lYUDI3b21rYTA2OGlRZDJrb0dvbDllMENFcE1uaDZz?=
 =?utf-8?B?UHlqckcxb1VOOXBiZGt6cmp1amo4SHJ3ZEdjbFp6SGRnV1RTZVFxOHNsR0pM?=
 =?utf-8?B?d0tLdHRGMW1uY0YwS2NQa1pYT2ZJV1ZvUVUvZ3hhWWJPWUtiWEZiOVd5RzlV?=
 =?utf-8?B?MHFoSEp1MHZkTHNyMWlSem05S3FZdDRmaHdGeEE3cVF2VWxuQTh4SzdJS0JW?=
 =?utf-8?B?VWV4eVg0Z3IxWXE2bXZUbytTQlhJVW5Fa0VmUWkwaWtXZmxzUGxQdlZ5VHBw?=
 =?utf-8?B?d3BrZHdYTmE1aDFQZ3FtbWZqdmx6UmlNdk1MUThsakRvRHp1QzdOSjZZVEMw?=
 =?utf-8?B?UlN5bURXMjJ3cGdNY0NTcGVWWFIycG9iWUwzRDh2QTQ1VFY3Q3NXa0pzbFZH?=
 =?utf-8?B?SEtGRWZVY2lFSHZIbDBnbTJJUWwrV3RhZkFHTFF1NFIzSktXYjBtcndRbVlt?=
 =?utf-8?B?QWVxYmVVbWF5OFVxa1B6Tzh0UW9EbXBYSFkzWUdwNTdOK3R0UnBCOGkyMmlY?=
 =?utf-8?B?Yk1mZEVGcTcvUU5sbnlpdGlQN094THhRWGY2VnNvSEFoZ09SdEpPb3YwR3A1?=
 =?utf-8?B?dm83eTltVTJwR1R1aWd2bkdJM3V2blFEUUF1ZzgwOXRQY0g0ckJZTm0yWTMy?=
 =?utf-8?B?SUhocUpvZWJtQXJkbGlZMmFibXRKSXZJL0dvY2FEcUJ2ZmVSdmZPOUxwSjcv?=
 =?utf-8?B?andTWjJYMTd2QzVDaHdLYWtyNlBOeVhTNlA2ekZMOGIzNzFTSnJ4SE5MVjJn?=
 =?utf-8?B?ZWNkRU1aVHhsbkY1a3h5VXQwSEFQbWhCbFNLNWFZS3BManJxQ1BnbmN1WXQw?=
 =?utf-8?B?Q2RHVEcxWElUNGhITXpEbjZPbEFiUnNVRkI1UEtNeEd2K2l5NDdvWUNIZmtE?=
 =?utf-8?B?YzhMcWo1Z05xVU0remtwZnFXZ0g4NXY3L3FsVEJaSXZYSFRxOFVMcEFIa1Za?=
 =?utf-8?B?eDBSQTgxTW1Yc3djZWRDVTV2Yzl1NU9MTDFQY2cxY0h6clc1a0h4bXptZllY?=
 =?utf-8?B?YUhMdUtpR2JiNGpISitVMFFtYkp0K0crdlVqdFFIY1Bja2hrNkxLeHR4L2JZ?=
 =?utf-8?B?TFVwMTJtSUZ0MGZyT0dDMXBGVlVQdXFoeTlMRzBQSEZVQWxQUGlPb2N0Qjdn?=
 =?utf-8?B?c1RGT2Y1ZTlkTHk5bUhiaDBjdnBqbURJMHJwRUJ4dFFzaEZCMU4wQ1lwQU5C?=
 =?utf-8?B?Z2VHZFIyRWpoYUl1b2tHU1d6Z2lvYTdDVjBOZCtTcjRlbVRsQ3AvOHowMkVr?=
 =?utf-8?B?YTA1aHAyQjdtK1h0OStuR2RGV1pVVStNVnNsTW5udDFoRlJ5dWJJcTdjSFhz?=
 =?utf-8?B?N0huYjZxKzI3WWJqdEJOYksranJoNzhQK3MxYzRxdmVWVzBER1FpbnJoU2Fn?=
 =?utf-8?B?cnhSK0liVFRLREg1bHBDMm5XYkxyNHFDaTNaV3lnckVwVzRWczVaY0xRcWtn?=
 =?utf-8?Q?/elXM/TTUpBNB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8256eba9-5c6e-428a-5d5d-08df45781a14
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14006.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:30:25.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13679

Hi Christian,

Booting Android (AOSP system/core/init, android-17.0.0_r1) fails since
v7.3 and still fails on v7.4-rc3. Right after dmesg logs:

   VFS: Pid 1 stopped sharing filesystem state

second-stage init stalls because every property write is rejected:

   init: Unable to set property 'init.svc.<name>' from uid:0 gid:0 pid:1:
   SELinux permission check failed (...)

v7.2 gets past this point with the same userspace. Bisecting mainline
between v7.2 and v7.3 landed on:

   14adbd5341aa ("fs: stop sharing fs_struct between init_task and pid 1")

During second-stage startup, StartPropertyService() in Android's init
spawns two helper threads via std::thread, which clone with CLONE_FS and
share PID 1's fs_struct (userspace_init_fs). Later in the same startup
sequence, SetupMountNamespaces() calls unshare(CLONE_NEWNS) on the main
thread, implicitly unsharing CLONE_FS for PID 1 while both property
threads remain on userspace_init_fs.

As noted in the comment above validate_fs_switch(), resetting
userspace_init_fs to init_fs.root is meant to stop kworkers and
usermodehelpers from operating on stale filesystem state after PID 1
unshares. However, mutating userspace_init_fs in place via
set_fs_root()/set_fs_pwd() also rewrites root and pwd underneath any
CLONE_FS threads that PID 1 already created, moving live userspace
threads into nullfs (or empty rootfs at 14adbd5341aa). Once that
happens, libselinux in the property threads can no longer open
/sys/fs/selinux/access and treats every permission check as a denial.

Prior to 14adbd5341aa, PID 1 still shared init_fs with init_task, so
first-stage init's chroot had already updated init_fs.root to the real
root and set_fs_root(userspace_init_fs, &init_fs.root) was a no-op.

Skipping the set_fs_root()/set_fs_pwd() reset when old_fs->users > 1
(one reference is held by userspace_init_fs itself) clears the denials
and lets init proceed on v7.4-rc3 (tested on arm64, Qualcomm SC8280XP),
though that leaves kthreads using the old fs_struct via
scoped_with_init_fs() rather than switching them to nullfs. Happy to
test a proper fix.

#regzbot introduced: 14adbd5341aae18e7e14bc3786b49007c26b2503

Thanks,
Akisaira

