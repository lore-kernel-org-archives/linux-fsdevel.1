Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794915637;
	b=S+5MV6IkX247nuWvzCBvVGIcydA2wan9pR/+5+axIFpBvHp24G6F/zIoxbVNPzgreOr3
	 ZdWiNVMWF9IMA/VBqYYOx1KJb5iIfnhesqy1BHmdYwfShuWIrGzo7H78SiLMkHQWfchNI
	 STOxirYJUEjk07G7q9WJFsO15zq0rvA3iK1SGfmkHPVYpLES7KkD30a/JvcT+W6kWAMCL
	 G1TAn5/93X62JZE4elWVBAFxPP39D/X1m1K4M/7nDQAogPYr22odzC+6uq5I0Gtr5i8hF
	 KFu5p55Wj8K2LyxGaig+egqjsjcIlh6VKYLAbmJPVNwdrEKaIGL62EZMRynkZjhbOLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915637;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1ZrzZO36e3wrnXYfw22Oh1DxbVsnlLFAnN98QzJalzs=;
	b=Qhp28IDIQHei9fcEmlT40/w/yLVcbt3hi4hmVn0kc/ad0M6k5gP8but72viQlFg0TwOL
	 h2aVP7G64RyBYxoFQ/w1b9nsKSEsNeY1DltqLZ9TLJiw9CU5BTj621UycJ1LD39Nm77tV
	 3ZToP/JSuS2z/HA3D60REZGnME6+/sPpgdWLD3m8A1bwoAoaA/I7lSLgbU52ny1gTLAK9
	 Kxr5VtSGEWlsAnx6u5y73UuCB8PKpIsyfRilrdqbqvjM4JwRz9nHj3WvvmWaRv3Gp7B2E
	 6XyXicgSpPA6wtyBFNjgH56OLtML0yBE8z+YJiwCGj96EEI5MOc84V02qaOv1KobyHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=yHE2TUdt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.124
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021124.outbound.protection.outlook.com [52.101.95.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85158606A31C;
	Tue, 17 Nov 2026 11:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85158606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=yHE2TUdt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eubENYlMfr8EZmGRcRrfp+i8/TTUgEBgrYtt255mz8neIR65/JClKMsXCY2mV76LLx5t8KezxLntuMS52ZIrgO6ycKW4NlhnsE3qApWXcguKYPHiLrYAjd56TM+uWCIyW1edGUD/+ug60kN1L0OHaybWbGVxLilZ7HqbzrAstS/VeFqHSLZPuUm2R2K2s1w6MpTSPPPofA2vuXlmOYD7SYG6MNA0HflWYQj2tG8kQ8A/KR8fsKr4iJmkDwks2kBF6H28OCbtOMOCZvZQfbhe7eGWdjk471lUpipXo6iWSNCpu2I9D6r8vSnwpjhht7cejlZ0vSkEAJDRWKC65v+iIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZrzZO36e3wrnXYfw22Oh1DxbVsnlLFAnN98QzJalzs=;
 b=raNum0JPPvildBSOi/eerN9dw50x1c06z2gS0dpVVYh/vlIXIzY7bTlukSoDtcMjXRlYFmBvX9T/6/nMhOOQt+Jidns4DCbLCDxynStWqCz0PT6tRpsv7ARTHANbh3MxRf2qK79CiKZU6Q7qsz1CemhvYPnLSDBcqB8Q+lJAUjvSkX9WxlBvVH3M2g62Dq4JS9i0HmFg27UA6rySUFgkEqWTdIMI4ypIMV+91mAuTWdqNwciJESk0zyjtHiadzTZNCyca+GWrA4FIIwNwF7dfn3Q8Eyw5YUDJ36OcuAsQh1G+lSZ+Ulmkk9XuKO34jhOW2Raq5V4HHAP3kDRmNJL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZrzZO36e3wrnXYfw22Oh1DxbVsnlLFAnN98QzJalzs=;
 b=yHE2TUdttbLXetttgba5B1Tc12azZRchZRYht1+NWuNpf7SmxxEEzX8JWfmC8z7uyrdeSp9cp2iXBOxReRxabdXywbf6C0AZcayGK5JvhRMDbAllZ9YonNYQQJlXVILUIRtyo+hbI7lDEkqbrQ2JOj6dCBczJAfs+gRIoOXznLk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWXP265MB5035.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 11:40:32 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:40:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 11:40:31 +0000
Message-Id: <DMXGHLYADENS.14LHK34JTZTRX@garyguo.net>
Cc: <boqun@kernel.org>, <gary@garyguo.net>, <aliceryhl@google.com>,
 <lyude@redhat.com>, <daniel.almeida@collabora.com>, <work@onurozkan.dev>,
 <ojeda@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
 <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] rust: task: add safe schedule_timeout() wrapper
From: "Gary Guo" <gary@garyguo.net>
To: "FUJITA Tomonori" <tomo@flapping.org>, <dakr@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-2-dakr@kernel.org>
 <20261117.094531.2139684707820199268.tomo@flapping.org>
In-Reply-To: <20261117.094531.2139684707820199268.tomo@flapping.org>
X-ClientProxiedBy: LO4P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::19) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWXP265MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 647bad3b-fc13-4248-6e55-08df449f9684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261026121527099003|261022075727099003|261021123027099003|4143699003|56012099006|10067099003|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oWX0mgV8HKlJ4mreuqIDIXrX6E9cEYWkxJDKnLzBmQ4/dfjyRF7t4oGHTym0J+b743nnqXTnp+pCp3p4Pu1pp+DxLsYe+7gfGxooxddc6DUCbHVSPKAkMcTbCihdy3p/s6xvmKRsMD9NBpyc/bbBg6ETDUbHlMJ1YZK2+rW1LbE4HPTRJWfdq7KquDAOHPp5O3Vv6Bbdl5NIK091IFD5AchWB7bimTwy5Zafrry214Gl6vQLbRkMRBEnMyRsuZKPSxOv0n0TVEyded0J4MHqMpjNG5xEJJbsOLGHM4ggp8/YjsjbDriemRbCnIFTX9m01p5aSr4oRrQjeBvClFGN1lDhBBbYrjWZALSRSqdbgeS30dNY53suzjvLSN93bc/T1NO3OauyHlPNzkO/83K2RbI6MtBawLh7BV/XAy4LyvDK0WbJIklVskqwwLnEwSbQMrPweY1yCTGlRumeb4hcpc3hpStT2dtIUtjXhBQWNjXOe0noQgOFLRIGlmK19BXWDC13ylEfH4ST7Emc6b5fEHQL/vjTqZB9U+eG1NWmM5GbsWb8aCI8IZJ6SBNXzxHc8WIITpfjf2ShjRNUsNwM45i+uNnJbJPJ/+ott5+7rBWFyLzbitXxU0NrXKuOy4E1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261026121527099003)(261022075727099003)(261021123027099003)(4143699003)(56012099006)(10067099003)(18002099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHp1azNlZ2lDdVBpK1VuWDg1M200TTJpWm52eHpUbTdyWWorbmtZckk2OE1Y?=
 =?utf-8?B?NTJkeFJNTnR6cHhYSlczWnhlaW5GNEVQNGpsbndNSkFwNzZnOGtwaTVzbWh6?=
 =?utf-8?B?RDVNTFdrVkNlWHdoRUV5QnRWUjNTek5EWDhXT05VWFNiU3k1OVRWS3d1MEZT?=
 =?utf-8?B?UkpERlllblBGNzJ0Mk9WZWMwTmtkODZxRnNyTlY3UURLNkx4eitFRzVwT3VC?=
 =?utf-8?B?dHRXUVhKR3V2UDE0d281UStPOVlydEtDVVBkd05SdXZWV0tLbWd1bWpRSm5R?=
 =?utf-8?B?YWliUHNzY0cyYjczTTRxQjloTEhqMkFzVzlVWlI0UlZkVENnZFlLd3FteWE4?=
 =?utf-8?B?WDZORlVvNlNtRHlZN0NxV3ZkSlI1VlAwWU1WZGtObHRKajhHbTdaSjI0Ny9D?=
 =?utf-8?B?eGwzMzZ5T25QajRNcCtoUkd3UWRMT1NCTUZ0eG85OFIxZUk2UnUvalgyQ0xD?=
 =?utf-8?B?NVBSL0xuemtqZHVvNkhJS0thUkJkWGNBOElFNlBzZ2Y5NmdONzVlcGJyS2tt?=
 =?utf-8?B?ckQxcVdzRHlZeTdvVWRnRTMxak5mRG16bW9XakRNeitaZUZzbnB4Y2NRemNW?=
 =?utf-8?B?UWtaN0g3RVF6N3N4MCt6TmtJMTl0ZUx5WnVEQ2lDdW5LbDV6RThSTklKYXJV?=
 =?utf-8?B?c203Y094TW92U0tkV0ZPbVZyVHZKWDVrdlNocm84QTFGblNwQlByRW9Tbnla?=
 =?utf-8?B?bU1Qc2M4OGZuWWRLbVdpdit5UjZDTTc2RlFnT2txVklJUWxOL2h2aTBNaGRJ?=
 =?utf-8?B?b0JEeVBUeGozZlYxNHZObmxWbUkwVkhtekwvSURJY1AzT05scE5iNER6NGZW?=
 =?utf-8?B?cThITXZxNk9tZ1Zlc1BLVkJ3UjdrMXlidVVXWEdWZm1ndGlxNUxBaUNHWXA5?=
 =?utf-8?B?S0ZQTVNqV2NSdUk3bEMxd2M3a0svck5MOFdBQTkrS3Npek9DRnNOVER1Z3d4?=
 =?utf-8?B?YmpsQnZzOTVMN21mOCt5WmM0bUlDOHhnNGhRUVk4ZnQ0dVJwMWdqOFN3VnlZ?=
 =?utf-8?B?MEVJOTh0bmFrQTd0Q09VRXJzN3NkWTV4REZYejlVVUIwT2NXaDkwQnYxRFB3?=
 =?utf-8?B?b05JaHIweDhPMGVOVWdzdmVVTFZkdm1tbFpHM3loTkZhOHJwTWFneGJqYWNR?=
 =?utf-8?B?UmkxbXBXaTRXdHdINEExT0JnbU4rWW1jWkVoYTcvMVozOSt1VDRQYkYwcHJG?=
 =?utf-8?B?Z0g1L3ErVkFoYW1lc0ZKUUttK1BZMnJMNXhtcjhpWHphcjNiYWI1VFIra1pE?=
 =?utf-8?B?SUdJVVZXbm9WT1JWcmlMZWw0aU5FMm5kNENyNERDQXNjNGZOS1JMM3g1R2J1?=
 =?utf-8?B?MG95dXhtN0FLdGdFUUpSc21jSUoyUXd2YVRZYUU5bHkzQitoNkFRVHRiVXAv?=
 =?utf-8?B?cGN3QllRcE85czN2VTArS0F6SWtlQ2tyZ2k2anRFaUl2S0w3WWdNYjRsWm5m?=
 =?utf-8?B?d0NtOGxRTEpkLzVoZzRvWGg1cW5qa1F5TytaUG1NRElXQkg4U0pRMXZ2NGMx?=
 =?utf-8?B?eitCeFYrK3VPeEhlRVo3K2d4RitSeVhWeVdyN0srYW9UYXFJMHJkdjRsaXRv?=
 =?utf-8?B?RmhQakxhMFBLbHF4YlkvK212TjgremNHZTJ4a0xGYjJ6ZlgrM3NDc3ozd3hk?=
 =?utf-8?B?N25UeGErMEh2K2crSHBwaXdkS3QvRjBzU0g5SXkzdjNnSEZsOGNhcVRQOFpD?=
 =?utf-8?B?bDBqeDFXT1JFVW84THVmNktCZGFZZGxMbUllZVNydmltVzRxdVhpd3B5clFF?=
 =?utf-8?B?Zk5YNFpLNnY0ZisveDI0SW9TaHhuQzlsckdqK3l1emdTYzVwTFZRWDBSTnY0?=
 =?utf-8?B?VFBrYWlZY0kyRDluZUNZOVVTZ1dzZTVjZHpDaE5rL2Jva3NRMGcyYjJJcG1l?=
 =?utf-8?B?eURuSVhET0g0WERNbWRMRXoxTURhamt4c0Vxc2lOZVZPY1ZFU2JwamtoZEpy?=
 =?utf-8?B?R3FQZUE5N3BoWUZTSFQ0ODQ4MjA3NjVicHRlSWZoQStSSGFTYWZ0bk9pekdq?=
 =?utf-8?B?eGFIU2FWdjFvcUVVamwyM1N5bjkwN1JRRkh1YWNoV0FGc09lRmFMK3lweENX?=
 =?utf-8?B?US9leGxwd1dFTkFlUzRqOFdaRTdzazBLZUsvYkdFQll0NWhHQ0x6bUtYU0NR?=
 =?utf-8?B?aG1TQjJ3R2JDT0VmcytFMlB2anhhZkxYZDNYMk5meTlkVFpJMmJFL2xOT0Vj?=
 =?utf-8?B?ckJzbzYxSktlRjh2TFNYbHRzc3R2eHhFVFVVNDE4S0NSSUxIemJnYzJUc0RO?=
 =?utf-8?B?Q1FuS2R5UTNCcUVJcXNSUmdRZlE4R3lXOEQ1M3ZIQWwxWXhYbTVsY2w4T2Vi?=
 =?utf-8?B?SDJyWkszTllXUjhaWVczNTRxZXdtVlhHaHgxQTVjbFZySXNLL2dEZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 647bad3b-fc13-4248-6e55-08df449f9684
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:40:32.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jihuCptm7P2lDXoU4E+U6WTrgbC9Olxw/w5loI/whJiaMp3h2FqBwrKT+MViqiHMNIQazYzxx1rAWj8EcQ5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5035

On Tue Nov 17, 2026 at 12:45 AM GMT, FUJITA Tomonori wrote:
> On Tue, 17 Nov 2026 01:14:42 +0100
> Danilo Krummrich <dakr@kernel.org> wrote:
>
>> +pub fn schedule_timeout(timeout: Delta<Jiffy>) -> Delta<Jiffy> {
>> +    let timeout =3D timeout.as_jiffies().max(0);
>
> In earlier reviews of my patches, Gary asked me to use the function
> syntax or clamp() for this instead of the method syntax [1][2]:
>
>     let timeout =3D isize::max(timeout.as_jiffies(), 0);

Yes, please do. I'm okay with either `isize::max` or `cmp::max`.

Best,
Gary

>
> [1] https://lore.kernel.org/rust-for-linux/DLMME4OBH3P8.3Q6UK95T2WGI@gary=
guo.net/
> [2] https://lore.kernel.org/rust-for-linux/DLUDG2TH77RI.ZQ0T5MH7Q573@gary=
guo.net/


