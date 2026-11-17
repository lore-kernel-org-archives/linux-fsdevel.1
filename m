Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794916945;
	b=sBp7Epr9vPEDaGfr8+3cJQHTEvqL90G/5KLZ8IB4CtegSLUl0jipgt5l3E2gmf3890T7
	 TpA1J2cUQjVhVZL/iyDIQBj6V1kw7TinP02JRlmfv0g757iRDP/7lQc5J4+2tF5kamA2m
	 rhDJj5McJogydclUE3G7dQO0AEdoqYmU4i+NpMZc+6iZ3aBENgW4kWypRVAp/CJFx166i
	 xyWisRu8pQ5BzyuJkSAOx2JVM1JkY5sjMmM844ch3Pfm04wnUwqXqWp6HwLliDyf/ZctU
	 W+MqtFDP3NCGHRsNmIFs3I26elvrJIPV2tiy1muO4qGIKUfELUB9kNiVaS0OqQ4MyMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916945;
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
	bh=X5xvD4wSMdmutJCrZqduXROYua+2ILV7TwrETXo49cQ=;
	b=tIXVxtrjfSyPnKLJBXoTYkgFSjuvq2zzHcyW5NoS1cXgRODuq9Op6bYC0tjXNvSmyooE
	 WAi2q1iADHh2M6b8kEyblG258CDberXNjLyC8Ak7b/FMfH2qHg7XPqehgN2ye2Q5ZkFHy
	 LiYU+JqCswYIIVCbM6I4bzSMSAjKLVOAqSITrX2nfakLX8QquG165nT/pywsFTPMfjy+L
	 NoQ2FR8JWo2n2xs31ppd4jc2mDUmj7E0iS5kOgAWH0vuKSBbgHmmU4abYznurheS3KNgy
	 YsdhxDc+ODtUMOturFvB/h+q+s0o+NyY0wejy2R4INZsRTVitl89K4/84nlXlaeia7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=evx2UEIh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.106
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020106.outbound.protection.outlook.com [52.101.195.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189B0606A32A;
	Tue, 17 Nov 2026 12:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 189B0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=evx2UEIh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/JHIJtmSkWpkE5Ct3mXAXRh+OQIpccG40GxVn3i80QpmbcpN64dsOSyQnnon3GT/pMXxERRNHuUbypW+iqJGM42mjPdJ3o9n2ZfH3PtRsUUune+GyeebMX4+fLfBZsRPM2G/EL5vVV5YfqpXSdd3hbNbHplhaueUf7DvtgyvMtE41FtyGefR1ZSSzrOe8Q16JUzGFtsy10n0sSpuxJiCk6E9feXIbCiEHubgmkHKCtYgDrrK462A7BpbheK6s5opT9lfBepMcXzDn+u56+VebEEjl8MNGiXCqNYtgMwMR6rvGHPTY6QK3KIu8MFRlnff0+/flCQhqkddOIvtdwUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5xvD4wSMdmutJCrZqduXROYua+2ILV7TwrETXo49cQ=;
 b=JcrHGf+15qDqFB1GMI//0fwv8xqRqBRyDeuRzDAbXT3FHyyyfthfHxjZO+IPZokpvXiN9Yg7XQrJcdTnmHqMQs0wQmmlopXT/bcaQ2x2dchtf95kEARPK0XdFxdqMZDWcDe8x9bM4HSrd7WWpg+kriV7c1Qr4TZKlCrmkraklpFXvAqd0VWfhCjygHhm8GJZaFeSpJNWWCxFVm3lIPdrzTOIczZ7L4X2JAQHDwo7ViGvfkrSWHTyxE3KHkB2ZnouBzfYT8fCXDKEPMUlo3LW75vJhtWo2tcXskzUPpHPeTwYaJgcpSpLw2IcTIUvQZwNM+QuglJQesGchqLCCBW1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5xvD4wSMdmutJCrZqduXROYua+2ILV7TwrETXo49cQ=;
 b=evx2UEIhZdO8g2s+yjx7B6HqHJQuIfiH/o5xXN6i+aaVS9fB0M6rdMhTS90lcTvrxFEkWBnxv03eF3SJhXP3csKtptFWHE6isA5x0cxnT3tQ4T+uB9CanggR/GIr2Fz4Y+ihIO1PK8KxqyVT2/BmUTYV0q6HbT2z7casgXSw3tY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWXP265MB3080.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 12:02:20 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 12:02:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 12:02:19 +0000
Message-Id: <DMXGYAQZB33R.4BWEI96XQXL6@garyguo.net>
Cc: "FUJITA Tomonori" <tomo@flapping.org>, <boqun@kernel.org>,
 <aliceryhl@google.com>, <lyude@redhat.com>, <daniel.almeida@collabora.com>,
 <work@onurozkan.dev>, <ojeda@kernel.org>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <acourbot@nvidia.com>, <viro@zeniv.linux.org.uk>,
 <brauner@kernel.org>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] rust: task: add safe schedule_timeout() wrapper
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-2-dakr@kernel.org>
 <20261117.094531.2139684707820199268.tomo@flapping.org>
 <DMXGHLYADENS.14LHK34JTZTRX@garyguo.net>
 <DMXGTVTETSCB.2AG2E0Z05QT03@kernel.org>
In-Reply-To: <DMXGTVTETSCB.2AG2E0Z05QT03@kernel.org>
X-ClientProxiedBy: LO4P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::18) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWXP265MB3080:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e11abbb-47c1-4008-5c38-08df44a2a225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|18002099003|22082099003|56012099006|4143699003|10067099003|261026121527099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	Zt4f9aLL0rUc7l4qvy3TM1XwSyUqJA/p00LN9VpNJbYJpWWHS/CWMhPOXsFvPGSGRuHlRUPGH7CJxVCjye9NnbnrHaEXc0YzPi/boM7B68k4UHdI/FTa6q259Ron1Eiv6kymY09Bxue3zyuEk3a19cnS9Qtj05un+z94BkBymFX6WF2yuEYg89pGyOabjMrYzSkPS4ny5BnhM9oxialWXnVFw0Sq17uPcpWj341hmhlefSZosgKYyn/uiXsH5+kdLbqrQtr/RLCYDjx6RZ1eFc2i4/XYZMrik9xdKi03x/ps/yjpHM8wYBYtuCndrACZQDaatUM8npDmsf5rSIg5ZIPyEhnWtdQ4hD/xpZqvI67U1C5P3Qdkm8l/mv9+zKSKygLIXFWF41csbu3DFlLqTNqGOtT/44BXl1vxD8kTjRoHx9BW9IhRwmvMBoBaopD98kxsXfcFr18IS3pK2jCvfeRKZ61FdizE/aSbcnQKujls5719ZEj+9fzcfiWy55E4GI+yBR/5eb7xuiteJeHicYnzS/FHekWXv5pqa4KN+LpDRfon7VoKIHRcsrmOuLAc5LPZYc5m7goTbLE+Xlhv3jbOFud9pBlNG1aAqhh047NoSBimzOtSZ4T40SycDcC07xHINvHs29aDsXY55SeaVeBd9XKGUDQpRpHBrvcK4iI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(261026121527099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3lRVzMxcDFBdlpJRGZ5bG5BTHJxazZnQlVoeFJjY3pNR2ZxcGphNC80WTZB?=
 =?utf-8?B?cXExMmttSDJiUHZzZHZFVldBTHdEVUd4MXJBbzNJUUlGTTQrblJia0pGaUl0?=
 =?utf-8?B?dm9ZNEhJT05ncE9aNERIcTlMdm5Nc1pTb3R3N3FncnhDaXBjUVowb3l3TmJB?=
 =?utf-8?B?QkRvTGFJcmlrak9NNFFjMW94ZGkrNTNBTC90WXVaa1lTV3AvbFZ6MFcyRkRG?=
 =?utf-8?B?S001aUswNzFleTQyYk1CaVN4dyt0WWVnQTY5MlZFSkZEZjNpWWhJeDZ5UlEr?=
 =?utf-8?B?Z1lqMDB2ZzdyMnFIamhEUnRxdWNzT09jWlBCWnd4d3NmQTN0bzNOTXhYaW5o?=
 =?utf-8?B?OU1HeFEyNlJmRG1hckZMU2FBUkJ4WUtZRy9zYXU1SUV4QkhQV1pqdEZzTVkw?=
 =?utf-8?B?S0ZlQ0FySUZpbHdaZjFMNDk4YWJlNHZ2T3JtSWJtNXlodnY0Q0d1L3FKSEZS?=
 =?utf-8?B?Y25rbGRobmV6UUt6cDY5VVdxNkJmcXQwRzMySmZnWEp1aXlMWTBvNE5iZmtC?=
 =?utf-8?B?WGZ6ODZwYmZCZEdUZlBseUxFdElFQUUzSVp2MmR5c05Wb3pzd0QyZVhtQTNG?=
 =?utf-8?B?RUJvWUoyUnlueXYxOWdES0trMnNVM01oZXBMN3NqQ05KNnFuQndzZ0t2MkFw?=
 =?utf-8?B?M2xoMHdRLzFyNnF5eWE0cDVlcWFFREcwa1NvSHRWRjhFY1d3TUVrNSszSkNk?=
 =?utf-8?B?WE0wanBsSjl6dlBUN01rcm1MbVRGVld3bzllMU42cHE2dTMzby9MNzJBQUN3?=
 =?utf-8?B?aFJGZTJzcEF5dlB2QUZwUEhOeStnb0w5elZWQ2NmdEVTZUZnMDkrY0JCbVVj?=
 =?utf-8?B?MCtwT3dPOVBLeXRXekM4WmJ3N0ovTHgwOUcranZDT3V0OUNpejZuRis2cmx6?=
 =?utf-8?B?eFZjbHN2ZWViUEhmU3A5QjlxUUFMcVN2a3BUKzV5RjNxaHFZdkNYSklUbFpG?=
 =?utf-8?B?bVJRcUZlbFY4bDlOVEM2TDdodkU0M0tqNEVzRWZzZHU3N0hMVzRHR1gzLzhD?=
 =?utf-8?B?MzJSK1VHOGxLWVN3VS9kVmg1REplM21vRGFLTzJKN2UyNUxtYzBWc3QxTW9j?=
 =?utf-8?B?NVRlN2c4VDVxT3piVTc1bUFkYjgybWQzakV6cUNvT0pBT3BKZmpTcTVIcnpt?=
 =?utf-8?B?V29ValdXeEZHNzBIbkZJOUt6dmtKRjgwQmt5T1hxRDlPZm9ZWUJ4UHM4dm8y?=
 =?utf-8?B?SXVmYW8vd2poSGdqSzlrUWQ3QkdTZnh0TjhqMzBNTE9UVksrQ1dkMW9mNUI5?=
 =?utf-8?B?MTJML2N6Z3NwN0xCeEZYYjdwNmM4LzhyemJqc015MUFrcUZCRXRldDI3cFB0?=
 =?utf-8?B?NHRDeDZ5UWJVUDUrMEZocEFNTjJTSWtPYno5VzJnRm9XSmhRNWpmV2FqOWhv?=
 =?utf-8?B?dTZwSGEzRlFlVW9ySDdoRWJRMEFONmZNOS9kOGRnaXUyM3JNY0xvSHhIVC85?=
 =?utf-8?B?cDBYdmhqQVpXb09qSldDdm82ZWxmTjB3NDR3WXFTNlVYYkt6YW1NbDVuWDNN?=
 =?utf-8?B?cDcrMytTMVJpZkhBejZyb1ZMdStwTjFIcFR6WXdSaFpEQVloQzNoRE5BQkdw?=
 =?utf-8?B?NzNCd01Uell6UG8rY1lOVmh5NFNNN2VKT3dtYjZnSi9TeDZSMlRCZkI0RDRG?=
 =?utf-8?B?OFN3STBLNldKeEEveEZvbUhxOTdJZFJ1WjFnR0NPTjVVLzU4RUZEc3dzY29Y?=
 =?utf-8?B?bDBmMjFId0V3RWt5NUlOeThMRVIyZnVrWnBpTWw2cVUvR1ZGTjR3OFBMWi9x?=
 =?utf-8?B?M0ljbzZvdWVjN1hoTXI1MU9lZGlWeUVFYUIzcyt5UnM0djBXV0kvUlpRM3Jr?=
 =?utf-8?B?bU1iR0tOd0h6dm1CVUNRSUNyM2ZmRG5RWE5iUGZKcmJoMDQ5aW1jWXpmQ3Za?=
 =?utf-8?B?SDFhNTR1SkhXV2xDVjhzeFg2RTdEazZMcUtodlh4KzBHSHU0Q05tazlaVUZJ?=
 =?utf-8?B?OUMzcXQ1ckhUemFxaWNSRmZUT1FCTW8zV0lwbWZwL3Jnbkd3Z1dTNlg4S0xh?=
 =?utf-8?B?Z201UVdyVWFuU2JYK0crcDk1ejV0Ym12NzJsZnFUMW1JanlxSUYvOW5wMjky?=
 =?utf-8?B?VmtkOE1aMkF4blBaMmZjU2JSL2NRU0xpMnhHSHFYSDAzS2dzekdDVmJnYUtV?=
 =?utf-8?B?cHdIYVVwNStRZ3RObjlvNUtlQ2pJZ0JpYVdnazc3c3RvTE1NL0N2eHkycjJ4?=
 =?utf-8?B?VkFxYjQ2dmI5a2FIdjBWNjEzemNsQnZHY0lyRzdmRG51a1l4Z0l0c2Vhcm5Z?=
 =?utf-8?B?aE5Qa1VhM2tUWEJ0LzNpcUphMEY2SnEvbStPc1R5NUwwU1k2ZDFNTnNjSVk0?=
 =?utf-8?B?ZVpvS2w4VE9DdEg3NXRuRWt6TkZqaitCVnZ6a0l0b2p1dlk2RE91QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e11abbb-47c1-4008-5c38-08df44a2a225
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 12:02:20.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spreeZ0uqwnxMTWiR1oLq4H4vy2paM8Hngcbx/sVUUFhpVrFA7v9PFOfIGpmKm6UIHss3vbXbXHYuFNySW3QGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3080

On Tue Nov 17, 2026 at 11:56 AM GMT, Danilo Krummrich wrote:
> On Tue Nov 17, 2026 at 12:40 PM CET, Gary Guo wrote:
>> On Tue Nov 17, 2026 at 12:45 AM GMT, FUJITA Tomonori wrote:
>>> On Tue, 17 Nov 2026 01:14:42 +0100
>>> Danilo Krummrich <dakr@kernel.org> wrote:
>>>
>>>> +pub fn schedule_timeout(timeout: Delta<Jiffy>) -> Delta<Jiffy> {
>>>> +    let timeout =3D timeout.as_jiffies().max(0);
>>>
>>> In earlier reviews of my patches, Gary asked me to use the function
>>> syntax or clamp() for this instead of the method syntax [1][2]:
>>>
>>>     let timeout =3D isize::max(timeout.as_jiffies(), 0);
>>
>> Yes, please do. I'm okay with either `isize::max` or `cmp::max`.
>
> The examples in [1][2] both seemed to be able to avoid a cast with this, =
which
> isn't the case for this patch. There also doesn't seem to be any ambiguit=
y in
> the extression used in this patch. So I don't see why changing it would b=
e
> better.

The ambiguity is "the maximum value returned will be 0" and "the minimum va=
lue
returned will be 0". The answer is always the latter but I'd avoid the ment=
al
gymnastics.

Best,
Gary
