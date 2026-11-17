Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794916792;
	b=wmQnVjWMrpGYtbq8W4H4a7rXa3kn6Fzgwl39B3KtLPPwLaB2Bb0BcibTJGaNgl23+aNB
	 6jzinNzR0nH9akYLhrq03MNC4xpUGJil9Xe+yLN4ULNXs9GoSYjq32w1RqkrsKPiBQyIF
	 hf7EayUAzHzOF2Z2D8Qv8DfhFjIpLkZgPdFYFk0dw+OpwgCHinXYxE36hkA+6ANGG4PHH
	 vR1F2UB22UzqweV+/j/WAFRDYDHDMyWcHVc68Pp10dm0M7FnplKjtwI2ody4g3V4/M4kv
	 cNUdyzKI2592wXoWhHxuLQE8XJLkDZUn5wJSwVXeCljp0cTUTQw4SJ3pDyYPtqwy0jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916792;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=EaF45K7XiF7yG0xrsqtzQAR2SkVQdlNs7x0SrbW6VR0=;
	b=mx7aptPuW/5RxIOYmEoszXHG0qaMaYc6N4er2MAwEXnxqzLGKFiZndDoij5bO65aasj+
	 Vdenah4w4iIG7G0aBe0ZND8QVVtfMCkHj6YjDrbUuuPRFeSe3ueQRVS71cahGOJbFGqwO
	 ykFt1wU8BkQGdQN+DTMhs0cjqg6Lb8RZWaH94leQRRmWmecNpfADSwCoOiS5U2nQ7OusI
	 BN2ehPHYUB9bBkaza9yMEBWemDff6AKgsmuS3w4EfM/Aa4CLNWpmBZttAmm4U7oYkkfDV
	 kFmYBdAR5XtHOYKycBLO+FwQuA05vTMcMaBUbJenj3VnId8ssaUtb779i4mkHf7kJrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=HsPT6eam;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.101
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022101.outbound.protection.outlook.com [52.101.101.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F5606A31C;
	Tue, 17 Nov 2026 11:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 782F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=HsPT6eam
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gopdEXczPXgBephfefcU3bABRY2/bdWIQniy6cQUyrzhHRScOSaByRJkCMvFdKKf3cUZYuXxgREd90AD/bGQ33B1l2mhWT6IvbM5YL/hPltqKu1OR/aReWSznOavAaMWjL9ilCIsKjcteAYeb6gCF05GROM89I9pLJ0kqYQL+WwO4hshvwkZ1ynFu0mXC3RXaFLgXY9GFgTfBxvLplDdMVf0EpU4+jadHXUc/I1/7iHHu483OTLBlQ1zi9gBdgneFjDRnQ2C2rd3CPodDE6gjqMXyIEEi6gCvbsdoZhT055LSkf7unnU4/aJ0iYzi2zflGJd+bDmHLvE8nq3UYGKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaF45K7XiF7yG0xrsqtzQAR2SkVQdlNs7x0SrbW6VR0=;
 b=JksViAJC39uHgeG4C+/gZMcgglyEn5E9EWAHLIfCKWHlZ++RxrM30ehfEaxVQAWypLitiMjIVqF+WwD0Jow1p4mHOCU8vuSX/ZbQ8f/YPjbrkg19BgFKsgWYVtxi9DcBcFycf7PPkvDV0KKIpW9m7n7onv40SI3iXRp8wCpaxC77QMsZbPP3zn/Nc5gAxW7EoIaZONOJ9N2frw5WrzmzfU9yYfUEzGP45FQRpno4w686HZrEJbJi8KSxSgxIg0YlHQhkJBBdpocWi8Aen8BGbdzUQB9QxYnGC1mQtwiJn8CVJ99ONEls1Rlx+M5v12SZ6O7CvxzXv5Hlsow9OJIJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaF45K7XiF7yG0xrsqtzQAR2SkVQdlNs7x0SrbW6VR0=;
 b=HsPT6eam2LECKe7QD6z0qOWWyn2QLbB0hW+7LbDnBJk4GCe7ceSc28kScrrdK6k0VwS0uwpBc96B/FO2SS4/sWdvyMQ+uIdluktvXR70Chr/cGMVoxIGFOqcgUs/8083nQwcrUuQj+YzF/G++k0sLWGNHvnO3OsOqQjLa/KFY8M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO2P265MB3248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 11:59:47 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:59:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 11:59:46 +0000
Message-Id: <DMXGWCITETPM.1OCWS0ISXH5RP@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <aliceryhl@google.com>, <lyude@redhat.com>,
 <daniel.almeida@collabora.com>, <work@onurozkan.dev>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] rust: sync: add WaitQueue infrastructure
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-3-dakr@kernel.org>
In-Reply-To: <20261117001507.1611984-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0660.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::13) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO2P265MB3248:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a246db-02bd-4d01-50a3-08df44a246e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|1800799024|7416014|18002099003|6133799003|22082099003|261009223027099003|921020|4143699003|56012099006|261102130727099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261022113327099003|261021121427099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	VBRsK1j1G/Vf95Jr9yzERicJZTBnizX2t1rWUz2k715OcIFW8SSVDtulwYBRvp3tVdyUz9pbV+wNLn/8bmdkDi+rXLQvxCNarusonUT4CZBRHFxqnbog2Nmh14YccNgqSrrFRkJgAkbS0DgjV6jvwwnN4ES+qxgJ/C2uG0WmCofpd4rhPzJHpbL+VBLDHsLUI0DcJkeaoNLbjsl5iPTwTo02fKnVW+Dy7G/dXL7KRVwnrxWRmDdzxiWtlEL/UE6PhyeNsa0MoZbjaJfyHFU0oZEfj272KcSkUrKGe363LwKgQzrz43EeUCubCfyvFH64Rb7RY2m14IN9JwKsL7qYuYtO4/mUdwUrvIHscJAm+HX1hCuMMGVg2XUANOM7U4XQsSbTAFoIApKPcPxuYXLaZUqIfIi+LvvICgd83vX5R1QZolgFK9omC3jCYK3XUQw0GLUY4hRtZsIFlQq21sPxdhvftqZzvJMY8Ohtko9i9g++N6cOosDiJgS8KIyL0TYTAYDR0NBYpIIAHrOSJF1wBBNoE+7tEp7Lgtkmio3dVcSajJNAX5CqCmxVWHos217yUATF3811L5b52oigkgMQrbrjIuVGM5oi0tHFeyjDXEd3a9X6HYhZjJGI1L8rOdJEgVbEuHp+DeqWHE0bRZhk6i2LFaSKwRxvhUmA+Zw+jUNqhpzLkGzR66tvjyAf3MGz6+M1ZvlTz69qAvxNap39zQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(261009223027099003)(921020)(4143699003)(56012099006)(261102130727099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022113327099003)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3duL0xqMHQ4MFE0bnF5cU1aYUVIdVdUMUwxNnovcW5zMGtFdmNmRHY4b0sr?=
 =?utf-8?B?azVaWUtudGk1VjV6MzlLQWJoOG5YVFlUenRXMEcvbU4wdjlxNUV3OXAzVVl6?=
 =?utf-8?B?WU5FbEdRSlE4WHM1b3h4Q1NiSzJXOUxCRTRFQUhXcDQ0WDlQRkNuS3FNQytD?=
 =?utf-8?B?aUd4Y1g1dFJLeFRybThzdmx3MXBocWR6V1ZoZFJXaDNVR2oyMlJ2cnZrOFhG?=
 =?utf-8?B?U1FzLzNBcFNHOWEwKzVBeDI0WmFHUm1oaU5iRVRmTG9maHRqRFUxdG1Ga1Zj?=
 =?utf-8?B?NHRmc2NUejVFTHVNOFB0SzkrRHVZb1RBTlFlSHZJZmZNQnV3Zm9CQldRMmRI?=
 =?utf-8?B?cDMvcnBSREtSMTNsRVA3QWlKdDNCNlRBN0l0M0hNYUVIYnRNTE9Jc2pCaGZq?=
 =?utf-8?B?VlYzN2owZ3piYUJRYmNkUDNCTXE2SFNIekhHNEprT2xhQkhqdHRzdXpsMGdC?=
 =?utf-8?B?SkY1TnNjRnBCTml1L0dXOFMxREE4ZXBTRmNCaUZRNE9LaTRzcXdpdS83bkQx?=
 =?utf-8?B?aTVGTmNEN3V5U09yZnNacUVocG0vZFNoNU5SakFVV0NCdktORnc1dWh1TnJK?=
 =?utf-8?B?aDJPRmQxU25mc0taNDVacDIrYWNoZk5hVzZOYzRZaXRmUUM0dFRtZFE4c2Ju?=
 =?utf-8?B?L0Q4Qm9pYjZQa29iRmJQd3ljdmtxYU4xc1dydnZjdFZjT21JeHpGaFF3TUhZ?=
 =?utf-8?B?UmZYMjkvMVRDMDJ4VTlpR1NzR3h4Ykh0Y0VEaldlYWw4TFdZdDRWcDRZM0M2?=
 =?utf-8?B?SjdSSGxGRzZ5WGNpQW1HckZjQU5aN3U4Y28yditJSVIxWlVKajBZMk14akE3?=
 =?utf-8?B?TGgySFVXRkF2czl0dk9ma2RnZzV6clFEbU9XOWhKcm0xaEVoUVdkSVdLUm5S?=
 =?utf-8?B?d0hkbHdTWmxycFhGbytuUSs5ak84MVAwaU0rVkhHL1RoSEMxdWdLNko2MFVo?=
 =?utf-8?B?d0VvR01FcmxFZGw5YVprMThZQnpQbkVVUXBmNmVoR2dCRFViWVlFMVpGbDJ2?=
 =?utf-8?B?K2lheWZzM3l5K2V3S2tuWGh3TVFqaXEzb2RhbE9uc3U1RmFub202dGtONGpP?=
 =?utf-8?B?cWJYRDdaRVE3RmVhYXdwZjFEb2d2TStvVzRnMm5WY2VzQk5DL1FreDdxaExx?=
 =?utf-8?B?VnNoMk5nVXBhTytWRy9FOEkwN2tCS1ZtQ2RoVUJ1M25Hd3VRcm9xbEtNSHA5?=
 =?utf-8?B?NWpkQUQwVXdzUlA4clVOTWp2dzJPSktnd0o4T1duUWNmcVJ6YzRvNE5jb1Fi?=
 =?utf-8?B?OTQ5Yms4aGhEZkFWS0FxNzBUOTV0Y00zNzhpazEvSzg3OS9pQ0dBSUxBMk9t?=
 =?utf-8?B?UE13SlppWGJYMzZud1ZJdjdiZ0hNMExlQ25EWFR1dWlVaTI5akFsNUgrVmdq?=
 =?utf-8?B?SCsvSjRMbzFCcWhoV3BZbloweFRLQVdrb0RQdEQwaSsvM2JzaXM4aGQzTmFR?=
 =?utf-8?B?d25ETUtUUHY5b2V3dEhaRGJ4bTBMUDJkOU5EdXRmMlNnT0NmdllnaFRRWnBz?=
 =?utf-8?B?M3lrRjljTFl1T0FaTjJHcVVYREsxYmgzazlOdXlUSXRnK2dtQWd5MGpSTDZN?=
 =?utf-8?B?dS82ekpjMnNqOHpqQ25reStnbVZjL3JlMlBmc0NUdUZqZUdVdUtkWUhvSzRh?=
 =?utf-8?B?SWFkNlJ5Ynd4dUFnUDRZUEdvK2tjVW5Ka3JvTHQzamFDNFA2dlFvR1lIYW55?=
 =?utf-8?B?U1A5dEpUanE4bWl2OWRuSzNSY1hsaU94Nk5qOFFBK2xXRzM3QUhPN3RndDJ2?=
 =?utf-8?B?d1JZSkRlcjJVemg5SDFCQURXOEl0K2dwUTNtYWJrS3B6NlBrbDNoYW9CaEZZ?=
 =?utf-8?B?Mlg0NVdsaTBrM1B0eVQvLzI1YmFMbW5aSVQ5UkpIWmtYOUZaenQ3TnRBdzhX?=
 =?utf-8?B?QTI0SGFjb0REVHVpQWhJbDZ6UkVWNU15dXJTNFhiaWJQNXhtZXNHUWFjK0tj?=
 =?utf-8?B?cTd6a1lwcUZsMVduOHhvRmFVY2c2eCt3Zm81RWRHQzNYZUl1WG1HUWhBaUFT?=
 =?utf-8?B?OEVvVVVPS3I1bWpQeHRTQ1AzOXF5NlV3bVZnVDRIdUR5MnRTY3JuS2xXTHlU?=
 =?utf-8?B?VHN5ak5KcldqdFI1QnhBWnZUOVRVS0ZSM2xyMlRncmhCWmNNQ3lueHBDeGNE?=
 =?utf-8?B?azFBdlNFQllTdm9LUFVHZkdoK05oRTZKcFNjSFFxQzgwTTl0djBDU2laWXZC?=
 =?utf-8?B?d2YrcjZRMjV2SDBrUWVyeHZ5QWJaNERhRUlJcFpVY0R5cXlKeHoyUTkzMG1q?=
 =?utf-8?B?YXFla3Y0eDNRK01BQ21NR0VKcUpmSWVqd3Y1VTdlMk1WaU9LWU5BR2E0ajN3?=
 =?utf-8?B?RVU0bTVUUkdBQzNjaXdGaTBzMEtscnhhZzFPZ0NnYU9PTzI3aVNyQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a246db-02bd-4d01-50a3-08df44a246e3
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:59:47.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6lC3mZkQpBxpLepiDHpqnzZJeBDXmqSkhovp4zrsStSa4zHHmQWAxS6VcyksHvM1qAO+cA/Ug2a5rNs0Bd+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3248

On Tue Nov 17, 2026 at 12:14 AM GMT, Danilo Krummrich wrote:
> Implement a wait queue wrapping the kernel's struct wait_queue_head,
> with wait_event()-style methods that take a condition closure directly.
>
> The API mirrors the C wait_event() family:
>
>   - wait_event()
>   - wait_event_interruptible()
>   - wait_event_timeout()
>   - wait_event_interruptible_timeout()
>   - wake_up() / wake_up_all() / wake_up_sync()
>
> The interruptible variant returns Result<(), Interrupted>, the timeout
> variant Result<(), TimedOut>, and the combined variant Result<(),
> WaitError>. These errors map to ERESTARTSYS (signal) or ETIMEDOUT
> (timeout).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/Kconfig.test |  10 +
>  rust/kernel/sync.rs      |   8 +
>  rust/kernel/sync/wait.rs | 549 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 567 insertions(+)
>  create mode 100644 rust/kernel/sync/wait.rs
>
> diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
> index 3bf4194f28c7..7a1a464b6b29 100644
> --- a/rust/kernel/Kconfig.test
> +++ b/rust/kernel/Kconfig.test
> @@ -104,4 +104,14 @@ config RUST_TIME_KUNIT_TEST
> =20
>  	  If unsure, say N.
> =20
> +config RUST_WAITQUEUE_KUNIT_TEST
> +	bool "KUnit tests for the Rust wait queue API" if !KUNIT_ALL_TESTS
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This option enables KUnit tests for the Rust wait queue API.
> +	  These are only for development and testing, not for regular
> +	  kernel use cases.
> +
> +	  If unsure, say N.
> +
>  endif
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index ee372c048a8a..5f7ffd828259 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -19,6 +19,7 @@
>  mod refcount;
>  mod set_once;
>  pub mod srcu;
> +mod wait;
> =20
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use completion::Completion;
> @@ -41,3 +42,10 @@
>  pub use refcount::Refcount;
>  pub use set_once::SetOnce;
>  pub use srcu::Srcu;
> +pub use wait::{
> +    new_waitqueue,
> +    Interrupted,
> +    TimedOut,
> +    WaitError,
> +    WaitQueue, //
> +};
> diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
> new file mode 100644
> index 000000000000..abbd5466ff44
> --- /dev/null
> +++ b/rust/kernel/sync/wait.rs
> @@ -0,0 +1,549 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFIL=
IATES. All rights reserved.
> +
> +//! Wait queue.
> +//!
> +//! C header: [`include/linux/wait.h`](srctree/include/linux/wait.h)
> +
> +use super::LockClassKey;
> +use crate::{
> +    prelude::*,
> +    str::CStr,
> +    task,
> +    time::{
> +        Delta,
> +        Jiffy, //
> +    },
> +    types::Opaque, //
> +};
> +
> +use core::{
> +    pin::Pin,
> +    ptr, //
> +};
> +
> +/// Creates a [`WaitQueue`] initialiser with the given name and a newly-=
created lock class.
> +#[macro_export]
> +macro_rules! new_waitqueue {
> +    ($($name:literal)?) =3D> {
> +        $crate::sync::WaitQueue::new(
> +            $crate::optional_name!($($name)?),
> +            $crate::static_lock_class!(),
> +        )
> +    };
> +}
> +pub use new_waitqueue;
> +
> +/// Exposes the kernel's [`struct wait_queue_head`] as a Rust wait queue=
.

The first paragraph is rendered as rustdoc short item description so please
have something more descriptive and leave the C equivalence to other pragra=
phs.

Best,
Gary

> +///
> +/// A `WaitQueue` allows a thread to sleep until a caller-supplied condi=
tion becomes true,
> +/// re-checking the condition on each wake-up. This matches the C `wait_=
event()` family of macros.
> +///
> +/// For waiting with a lock guard (the condition variable pattern), use =
[`CondVar`](super::CondVar)
> +/// instead.
> +///
> +/// Instances of `WaitQueue` need a lock class and to be pinned. The rec=
ommended way to create such
> +/// instances is with the [`pin_init!`] and [`new_waitqueue!`] macros.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::{
> +///     atomic::{
> +///         Atomic,
> +///         Relaxed,
> +///     },
> +///     new_waitqueue,
> +///     WaitQueue,
> +/// };
> +///
> +/// #[pin_data]
> +/// pub struct Example {
> +///     value: Atomic<i32>,
> +///     #[pin]
> +///     queue: WaitQueue,
> +/// }
> +///
> +/// fn wait_for_value(e: &Example, v: i32) {
> +///     e.queue.wait_event(|| e.value.load(Relaxed) =3D=3D v);
> +/// }
> +///
> +/// fn set_value(e: &Example, v: i32) {
> +///     e.value.store(v, Relaxed);
> +///     e.queue.wake_up();
> +/// }
> +/// ```
> +///
> +/// [`struct wait_queue_head`]: srctree/include/linux/wait.h
> +#[pin_data]
> +pub struct WaitQueue {
> +    #[pin]
> +    wait_queue_head: Opaque<bindings::wait_queue_head>,
> +}

