Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795006234;
	b=BGADoyTywBO7VDVVlil+V7t3lVCtbimI2q8PkU3gEBdCXZOrCtpZN7k4+kIAD28jJrg9
	 l/hjTi9cPcGk9lPZx4nh5/fCYYyM1DtNVB0MqBz0aSIP0ypBizr1MPRyccWVJdaQcPgmp
	 MJxDrZkCEuxTeCvrGoXgfh+oEtswZCAu6L6HGSozBNwwtG9x32anm3d6QPdWuT/rj7bXK
	 O4dygz8DcLLR/PQ3AXBr9TIIyvn23ueuTEziivY7x0awelUAaYAPw4S3UH2tm7dgmA1YP
	 /ZpWI2s0hYMW65wz+gUaVHC3gKnqYdriV8DgtnhOIfju2Sb86q6BoNf6UY+v1L4CUCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006234;
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
	bh=7hJkk5R5/YPPm1FlE6CXJJaYJKsdWU1Io/q8UKX8Bgc=;
	b=iq1AyDxDOt5eDNPOrbKh5cW7GHNqYAVUKq82sOpyDlFrlApvKbITnA6qsFGCmhfbnUGR
	 6mOh5Fexj7rydz3qcotu74vogCpdT0nNDGCVa7pX2K8G2Zdf83dhLOBM8ojhbGCmTvhN7
	 v8kguKeTaoCNbbmWirQjrC7Bg63qZpfXPFguMto30VtrfRtpghGqi48jiTFsdflTofd9h
	 Dr0glbgG13lGw4r+Ix3OsEbCDRk/i02Bp0CCoFJbs0Q4RO+XK7l1CeHeUvBDSa0qdGTU5
	 eZbINwNyC2OWHf3p0RRNQSsMBs843autW/rMluXNb3xmCh/KNL6D6X7DCW3FsSwUTLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b="Gnt9R/lv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.102
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022102.outbound.protection.outlook.com [52.101.96.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B71606A320;
	Wed, 18 Nov 2026 12:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B71606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=Gnt9R/lv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKeAqRbtbU2dxxCN1CZbguU0BiRWtR9IBfUiBHET2WNzncHMKLIZ9QYPGBnZ8NGtDMCf40xsInoeXZDpPK2G15D7r0RYx1uftnrJ9bwW63X4O4YaaylspLMSMlLQikP24+ThxSkc0Kz0/PPsloeXkgLh4ldBa8hBGtTFtHtsYD8koPmBgAve/kB1VCUcAHeJlFxTaHCCiLRYpnGNTYkYXdJrUWgkcyo6BqCxoulQMAJUSG21E0YiFJ9sLQUpVi/XKYj3YgU2fvJQTi70GeCQPTyl3UBpnIxzSerwsk3Blvki+AXtGRkyOlTnsDFfHErr5z630XnoPZVGwBqDkfUw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hJkk5R5/YPPm1FlE6CXJJaYJKsdWU1Io/q8UKX8Bgc=;
 b=u6rLmOjmFQMFSjAJDD/bst0dKM7dEIPqnDu7b/rKrMidaqNdkWttS5bpjb7hIyWT4nFfg9Nz4lPQpaRa/04ThRWtOLAh7KHRoQPBYSIc5LRmPKck697Vx6t0daDYS/20Lu59b6g3IA6pch8Njy4Jwf7Sx8vVlz/wSG4U7WQ9s95hq5cW88gdYLbd3f4hpVCXjfpXJESmZjRmwikcgXP86LQEnrxSmSsEcOgIhovJUL7w6EIvXz3MkZMNEhkAk5fFAvn84MeUBlDxixRsu5daJ8TkZb7PpQ5k73MiWk574xjQYrsKLThEDVrucR5208nOtdIzzhuZbHUReiRucOPVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hJkk5R5/YPPm1FlE6CXJJaYJKsdWU1Io/q8UKX8Bgc=;
 b=Gnt9R/lvxITfAo/5RzY7oWFdypr0B9+VcGmGsv3mop2xCCabQiZmQX8v/Gm+xC8gI3NxnNnK3zuZYJ/2sgCJXQ3oLsi1T2IRupcyprqq7lAqSzM5g5N6tyTrfsqL+H4kXQ0O64zYIQEqLZzZY/yR8E9A69dpgy9o7YtH/bpLV+o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB6438.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:50:29 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:50:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 12:50:27 +0000
Message-Id: <DMYCLP56JQ92.1F1KMOFMU5IHA@garyguo.net>
Cc: <boqun@kernel.org>, <aliceryhl@google.com>, <lyude@redhat.com>,
 <daniel.almeida@collabora.com>, <work@onurozkan.dev>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] rust: sync: add WaitQueue infrastructure
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-3-dakr@kernel.org>
 <DMXGWCITETPM.1OCWS0ISXH5RP@garyguo.net>
 <DMYC07XW5HN0.2N8G5STNNZ8GR@kernel.org>
In-Reply-To: <DMYC07XW5HN0.2N8G5STNNZ8GR@kernel.org>
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4b6245-3821-4338-c087-08df457285eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|7416014|10067099003|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/nvh1LwMRYWCWWYjlyeX4C55Eo25vkd9BOUR+BU5hFbVB8YG7Cp7Dczy748LlpkD5yPDRh53fUu8cIvngjeQiqvV6v3Fy/J9XpP7ysAMEK4ANGZHsLR5eK4OvjRq83kV6jrqlL7zX/sb6r7aeaOazq6JKHDAZe7KvTQpFcmC2UooO9FPtZt3LqbDbI15Ryljl4TXbtjRwuyjzuvCsGkYjcZA8I3maLwCB/zhrQqNnXibCcj06HHVbhotuZdFhxxKZy8k4pcL4z5pgSAYcIM/xQtng10SMzqsUu7X9T7okXEyUBFjaxsS3eEtlq/oRkfifKh5tlV6ulhv7SuHy+f9RBG1PEQUHOFh+nQGxY6gqbTyY4bIgLsxyabSa6NZNLZMQrkGfJJcSiEV61LWi++QXD3Gp0T9WCawb/9zVIolBFGmoAAkDOeyYBawmaJY/l5iqnQlud2t474UKgW2qgWfrBytYrK80NdCotF0RP8aTCSRy+MZ9oJcHGiD8xC38Bcev4C+yFGMaT56lp+/kg7BVX4SXSnMjdh6w3JQEZhJz+A0GdeYQcaLq/PerIvByx+svyXHBlY+U3QIKFWeAv99cApzZSvYDGfs6f9HWpKHrbZbPOqdxitOfsy+GFYN9UfzHBWqyt/fzqLihFiuk1Y/1ys4a/U1c4iJ7/2/rdddjaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWhQa1l5ck84TTJkR0xCanMzSXZZQ21zVEZmdGNJWHg4NXZpZmNIUzJ4MzdC?=
 =?utf-8?B?M09ob3hMM2NwRXpuWms1Q1F5b3ZWYUZmM0hHeEFaOXlybGM5Sm9UNy9ITDY3?=
 =?utf-8?B?Ynh0V2R6Ukl1dWRiTzVoelFwVWJFTUhuK3R4WWlnQWpmVVlCZnQvazJTQUNB?=
 =?utf-8?B?Q2FDQkk3V29vZThJUzM2K0RwVlB0b05ja1Y1Q21mMnE4Z2hGYnF4dXV5TDBS?=
 =?utf-8?B?Z3pueVloWDVmaUk3VFQzV3d2cTg1UXdDMGt1YmNDcmJ6L0F1N3VHN3Z3MlJa?=
 =?utf-8?B?V3lFc2xhT3AyQ202b1NMc2xGN1FaMFN1aWJNMzlacmYvNWk3TC95V1JnMzBS?=
 =?utf-8?B?eHRpMEVPVlp5eXc3bExUY1g1YXdSVFZ0WFdENEVjWm02TWE1NnFHei9LVzlj?=
 =?utf-8?B?Wkhla1N6c1ZMQzdqR2FSRWlER29RR3FRZG4wczBmS0svTHNrSWw0OGMvaEh5?=
 =?utf-8?B?aVNKMU5YOW05OHBqL0lJZVFsT2xuT2piRHRCaHFVMXJmRzk1S1dCcFFxZm9W?=
 =?utf-8?B?aGhBeGdjdlRsOTBKalN2VE4vN1BaU3YyMW5tMjZodkdXQmFRU1BsZTFuWktx?=
 =?utf-8?B?WXlCQVZMWjJZK3duRmdXTVFtOU1KVUFyZTBlcHJCZlRtT2FCU2h2R0M0K1JV?=
 =?utf-8?B?bjNDRzZrZi9KVlBKbFh1Nzl6SDFrNmRkbitWOFRHZ1puRDZjeXhxQ0VGak52?=
 =?utf-8?B?b2orUmpBcjlYZXdUNkpqbFJLaEN1SnlNNHdBV2JzTlUxVXl4SE9VVDFhUEN6?=
 =?utf-8?B?WFRnbDF4SUxERkVaVGhYcEZNamJCOTZ5VW1qR25XamNsSWdnNFpSUmtJK21r?=
 =?utf-8?B?OHFqbjdVZVo3ZzEwVTBRT2RBeFhVUjAxbnhGdzRNWHA0R0wxaHFJazFOWWJm?=
 =?utf-8?B?Z2ljNnR2ejdJQXRSRStyVU5FYXR0eVlsNUlrbVoyalBmaEdjdDVwakNnbE0r?=
 =?utf-8?B?U3NmTTlmcHFzVVBUeFpkSTRCdjJUdWdZaW9ZTXVRY1NBMkQ4N1YvQ21rVkVv?=
 =?utf-8?B?cnF5NjhKc2F5TnJQcmpVY0NaYVdlRG9ZWTI2bTYzQVNwcC8vYXBLS1BTSWFZ?=
 =?utf-8?B?YXdXSEIvZStRWE5wQVlGRnArcXRQcENFWXBsZEljbHUyTGxkSHlTMk1ITElQ?=
 =?utf-8?B?MWdFN3UwU090N2FpOWMxS29VQUQvUGhBZUhNUndFR0hSd09NRVJzbFhUQXNu?=
 =?utf-8?B?b2laemFuTU91SGlkUjg3RXlWUEhoaW5YTGRMUm5DT05GSnNMTENtSENXckZL?=
 =?utf-8?B?QUhrUWpndHp4bU94bUU4SGx3MW1PTmlOUEJPa3lGWS83MG42UUZwdzJVNXM1?=
 =?utf-8?B?OWVWaHJnSGdzY2F3T0I1OHRmNDBEdTF6blRkQ25FeVh5T2xyV3Irc2lUc0hW?=
 =?utf-8?B?UnpDUDFzQ3g1djVSODNueVhJYkl6QVF5cEhHY3ZjS0ViU2N6YnMxRjZ2ZmYw?=
 =?utf-8?B?REtRYy9wU1dhN2pFZXlEUTdLM2QvWkVYUk8vaUhrV1VLOVBRWEs0M242UDNy?=
 =?utf-8?B?NVBDOWQ1QmZIWmpzNzJDUDllMXlUUzYwbzhhdGR5RmF0aWp1ZTl2SnRzZWE1?=
 =?utf-8?B?RGpmakpwaUl5aTcvMlp0eWRVRXdmZ3hDUC9FclBMN1E2M3N1S3hUdWl4RENq?=
 =?utf-8?B?L1ROV1NZTVlwYWxzb2hwaGpiQVlEeTVMbWVkcjRSREZkUjBKZnArZ1NHRzgv?=
 =?utf-8?B?d3Zlb2Q4SVE5TWpEckdyVW56RGg4NFdMOVIwZjN6Z0lTUENkaUxGb2lkRXZY?=
 =?utf-8?B?ODZPRytqbEJ0ditPR1Mxa2lZajV4REV0ZGdsbGFtVmErek9LcGJFdlBpcUsv?=
 =?utf-8?B?eUNFd2tWY2NNMzlVK3lobmplTnRiSlQyOUdDSXI2QkFFTXZzZ0tPQ0w5K3BN?=
 =?utf-8?B?VXlwSmhGazJsTVllNXNxZFFSQ0JQUTdaSDJ4Q001eFVBOHRzS083TzBhRmVw?=
 =?utf-8?B?MjMzclJPRWo2RlArWUFiOUk3OGJJSjZXblMzVklUYUkzM0JHc2pEb3JjV0RN?=
 =?utf-8?B?NHl4T2dsbnRQS1hmZlNWRktxT2dualM0OFNscmx0YVNiTFoyMitBcjFPNkhw?=
 =?utf-8?B?SVo5OWE4OE9aSDRRZ1EwdFpJS0d5bStrd0NGMmJ1UEY0eDFkL0pMdUUxM0p6?=
 =?utf-8?B?cytnUDlZMnBMNlIyMENEeUxwd20xSVFraVVkQ3RobWVtY3AxNFpJSUFmTzNL?=
 =?utf-8?B?Zzlua2pCRE5RVlFlaTJTK05aQVlsNnBHb2IvWlV5WVFjRnp5dzZnM01CWGNM?=
 =?utf-8?B?TkpuUjJTWXNVN3paQTJGaWw3T0xkNTRXNUgwbmZHNHEwSVVrQmhUamVlVG1E?=
 =?utf-8?B?YWVZN3VUVGsyNHNFUzZUenBHQ0ZaTzNPcUIraWxKTWdqL1kxUHREdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4b6245-3821-4338-c087-08df457285eb
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:50:28.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4hE6Oz0coqCNIG2VbmMkw6ADWXQxBHubZm2mqI0Nxj48eaySTcuMkEjuUU4qXv2qzn929toUShBSCk2hDMEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6438

On Wed Nov 18, 2026 at 12:22 PM GMT, Danilo Krummrich wrote:
> On Tue Nov 17, 2026 at 12:59 PM CET, Gary Guo wrote:
>> The first paragraph is rendered as rustdoc short item description so ple=
ase
>> have something more descriptive and leave the C equivalence to other pra=
graphs.
>
> diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
> --- a/rust/kernel/sync/wait.rs
> +++ b/rust/kernel/sync/wait.rs
> @@ -35,6 +35,8 @@
>  pub use new_waitqueue;
>
> +/// A wait queue for sleeping until a condition becomes true.
> +///
>  /// Exposes the kernel's [`struct wait_queue_head`] as a Rust wait queue=
.
>  ///
>  /// A `WaitQueue` allows a thread to sleep until a caller-supplied condi=
tion becomes true,

Reviewed-by: Gary Guo <gary@garyguo.net>
