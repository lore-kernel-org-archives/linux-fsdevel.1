Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D93199D8
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776640748; cv=fail; b=ti5B8XDt6Z2VJr4qXcXvbbF0Z5f7NR4PGkGpLdvYoVqittoPXfmWLuINGpwxJvtWBE/sMniky44I9OlEvELmhUHgfR4GH9TraJWv7cy+oq5xS/yTXRRw46awuvbsmLYRGW5lMstG6wUGY+tkvY/XlGwE1pK8isM2kGdSoHTp2gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776640748; c=relaxed/simple;
	bh=5DLsJsjmRtE4Y2PSUgcjbjYw30UYjHGdMiwcUdkRnTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ei03VxUwzVPcacVRX0I5XFCjKsacwrKDSXBCljwQ88XQJtFryqzor5ea+cZn9PWsd9CNSArS6prPAb941PG3E80rQc+QKKyRwNAkrRkJlZFw5ESW9Yxy3ZTvsilG6aDVoIaE9teUAz96X7MAl83SEsnsUVM6KLbZladR7j6DotQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=ebwRYN9P; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="ebwRYN9P"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021097.outbound.protection.outlook.com [52.101.62.97]) by mx-outbound17-79.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 19 Apr 2026 23:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJSpZ0p8gIfQnfWfkOwVHd3Ds221uLzwvdji/cm0RC9lcv5udna42W+PvhA8bZQcmFYm4SIlP9yUc7J1Ktjmh2N/0cTdFVfmysoezcn/9UQQ4V0rVJL+VHKPjKk6yoa8XrsJkJ7Ya03rEDIhvZOHbzn/gDzpR4HbyZfBB8G0VwVQf0P+gq4fwpJnq/VjTlDtp1GEYARICdBGIR2ugXy3sBI7nQYXKW/XpxL0dh9mfZKyT3hob2utQTcHX/cSM+3fbc7cBlWk/yoLQCWwbbxFh+6byxcNqlZCVcnwQ+vz0jsbYIO9J46nhcMZAo4DecmMoR31YYQaOziMxQxBHkT8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2+YRZIK/l4x3j4Hxby2i/XUGfiuvosppGmvrTRM1uA=;
 b=FA/Qt5ra5X2TpIpiTEAC1xW4/7D1Qo2x50x3iqxcl443KWPH9OnBBSunZuImPFEKcBJMF3BSQDci6suV+VCUSktAzNJcdKY+K51PwRy71CQ+adlNrZkvSxv5yNbcJAJw5+QwFSe02NZ2YkK0Glx8IzvtrTfZVPi5hy2tBLaC0pmYXDMXq0b1h3/TLewEeeGXOTBGlHNky63HKEF7jh4QZcV1rYkGQumRv2Gyh15iTfr7qyAD1rxhDgFZfDd9GqtmHCQ9c6Eu8/wiizPktoS6BKj3kLFsz3KUcpqvW38XmbMnpqnq8IVVtzXli4neygNBm4bVG6wxHyc846RlQtqd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2+YRZIK/l4x3j4Hxby2i/XUGfiuvosppGmvrTRM1uA=;
 b=ebwRYN9PWE84mpjQ+uaujY5p2FFZNPK6AMY/bGLQQMpNvmVDscnm+18452uCUDFS9SEBRTLMsnItFtQlKCQnFWtBDiJr6Q3gACpSUQfOsXZtzuKHFHUZBBA+9KnTIabsPcEqYjkdVhXTW6ktWUvYszP/kkqOfCm8gIoR59bKZi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from MN2PR19MB3872.namprd19.prod.outlook.com (2603:10b6:208:1e8::8)
 by CH8PR19MB9072.namprd19.prod.outlook.com (2603:10b6:610:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sun, 19 Apr
 2026 23:18:45 +0000
Received: from MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b]) by MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b%6]) with mapi id 15.20.9769.046; Sun, 19 Apr 2026
 23:18:45 +0000
Message-ID: <12fd5db1-c1c8-4fe8-b037-6ff0db122633@ddn.com>
Date: Mon, 20 Apr 2026 01:18:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/25] Make fusermount work bidirectional for sync init
To: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-20-b1ca8fcbf60f@bsbernd.com>
 <20260330190315.GA6202@frogsfrogsfrogs>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: fr
In-Reply-To: <20260330190315.GA6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0031.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::13) To MN2PR19MB3872.namprd19.prod.outlook.com
 (2603:10b6:208:1e8::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR19MB3872:EE_|CH8PR19MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: fa92642a-aed5-4c06-99d2-08de9e6a00a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	i+E82P1G6N0NlAZXM6tbU9Gm04PZRoQKEnW7EFP1QXUCxPBaMz7PIxB1t5uhDqBEqQg8HvTKQkyiO65xgPWR1el+kOX6zVSck5rr6vY3yqM11lPIB4l2NpKLnMQnmTfxgY0cVWlR8NvAhtAwDR9uuwjAYoUCuhxJeMzHXDjxyFlBgGKe4XvADEAPTvTAtC+k0DKj/6bAubNLjXzK/tknUEnvekhrXpMI3OdA4pZEjMOpEj7DnM8bV/3Fp1W2TgkzNjdOkCXD4rtY2mwUIwOIGt7vs24qPMwm0LFLhGgCwmA4AQDs4S/muajjRPckZ0iPFqA6HRbQ9Q3wMV6vv9U8+3mJp4pJ+SZi6HtSdwgJbyPC89FbFjK1CwREsKmwwPMnVZfV7O2VSgDr2ZdeVP9B5sepf5Da3rzKZiOUfZotdoFv+uN5MhgQAi7PzJQ3D0BY03gL+MoI7uLKsddq4BXCidUQ7iwv9tXWMTp0AgM/31IYmpzq05fINUiBTEJC5lTmsQTKWNyylI2w0m6YPwgm1gMPnN8b0B0w4LH3BgVl4X2Q7bsmvSUEYv96VN67/wCryAQP5blO2WODZDRNocwNoUEEHSdE71wis1LKOzCNoAm2e/mkVwSGvHc/mbltzNJKFiYb43yE2ZT0heVlUB6BWdjmnbb53g8wtuB9wX/tE6Xh0w3Io8Ev5sUWt7SoV3Bouo/WAPkH+OE5dczwNSa1dyZr1ZAlLJ4a4seEQ5QA+Aw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3872.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anN0Q0VOWW44T2ZUcmZPcDRIczRFYmt2WVMyOGF4RXVXcGo2UlBJV3A3Y0gz?=
 =?utf-8?B?SXZCQmhZQm1sR3V1a1N5ZDlSckV5SWRvWVVHWVlkUVlGTWlnRUpWVUZibzd6?=
 =?utf-8?B?amthQnI4UFI3RUVnc3BMTmEyV05Icm1DNFF4MEpzV1l2Y2xGRWszdmUrM2Rs?=
 =?utf-8?B?N2I0eUlMcXNwUWx4TTRhVloveE5ZdnUvN0EyY1dLcE1IenVzd3JmQmxySG5Z?=
 =?utf-8?B?SmR2UUpaRXJEY2lod3FVRm1leU5FeG9uN01rbzEwSWUyakNPbmZHNDM4ZjZa?=
 =?utf-8?B?cjd2STZGMWgrZm5sN1FJc2Zsdk9Qb2h3dm5oN1dpS0o4aExpNElPTU5lV3lL?=
 =?utf-8?B?R2kzRjh1M1h1U3k5VC9CU09XWEVZUTdHbkZnSFE4SnJ1bjgvMjd3c0xBQmFx?=
 =?utf-8?B?QXlSQWhhYTRybEU0aEFoakYrQ1BKVTBOQnFEMUYzSDhqOFNXL1BEZ2RveUp0?=
 =?utf-8?B?Q3JjcWJJL0pBZDg4N0NXWUxINWJRbTJCaTBHRnNta0thdDY3NU5XZTI3WVZ6?=
 =?utf-8?B?R3h2cHY4d0J0cHA5UllJUGppSGgwd0k5UURuR3JpSzRneDVtNlNDMks1Tmhm?=
 =?utf-8?B?Wm5jN2VWckZiY1lIN1lVVDBVM3A4Y0I3TzBTY25FVHZXSjE5aEdjU3FHYVpa?=
 =?utf-8?B?M3p5M2NYQ2VkWEdVZkZ6dXViWXpYMTFjSlhKdFZTKzl5T3NDRnIxUUs5ZTg4?=
 =?utf-8?B?eWpyUFIzaUlYNTRpajd2Qy84THV3dHc2S2o1aVhoNWl0K3BvbHprTzlqbGtT?=
 =?utf-8?B?eEFyVU0rc2NTZjNrellQcjRBNzhoaGFQdTZKb3lYSlNxamhtWFZIaGg1UTdx?=
 =?utf-8?B?RnU5YjUyb2ozTjhPZjUxYnhSN3BJem5taWZmcXNTc2wxYjNKNEM2cUJvZFdq?=
 =?utf-8?B?TzRwZ1VuRmlnc0U1dWo1cC9kOXFUOFdYaTRIUFF3U3EwdnZ3M0pJOWhpZGxI?=
 =?utf-8?B?aHpPUXJPbFd4TmVxeXdsajNnSnVFSmFCeFlwZzhOeDVSNGVhYVY3dzFZSkVR?=
 =?utf-8?B?SkVYUHVnSGFwS1NhZFoxSitBYVF0TGVHak5kd280aXllWVJ2VVMzcFJFS2dr?=
 =?utf-8?B?dDdIdzBsSC9MazQxWkdFQlo1K2llTWUyRXBtYW9kVnoyNzM4N09hT2NsbEs4?=
 =?utf-8?B?VXIyZWtpOWlsdUVyVktkbHRwWVBaQ3NVSzBhdnJudDZVeWRndCswd1QzRjVI?=
 =?utf-8?B?MjgvbFlHM2s2SXNvVlM2QjhWU2FjK3Nnb1pCdWRTUWtMTG9jaGw0QnkwZk5R?=
 =?utf-8?B?M0dnUGlJV3cvblRoWHlFdzFBdVV6dDRzZTg5VzdUMVdLQXp3MGdlbkwvWkFI?=
 =?utf-8?B?Z1pQK1V6RmdpOWNnV0tacVMwSk81em9IeWV0OUFLLzVQaW9VVHpEc2ZGd3Zz?=
 =?utf-8?B?aFNXNnUzaERIbHpVU1dMdGtOMEdGZUpKNm9DeGhBQ2dlcVFjUHlEai84MDlP?=
 =?utf-8?B?TjNpNXo2L2ZQOEJKbzZGTzZ6N2pzN0luOHpIMTYzOTA4Y1NJVEJGYjduY0la?=
 =?utf-8?B?MC9pZG5kWHpIUngrb1pyRUFPVUJTaCsrS3hyaThUdlVJQ1YrNnRWU01VOXls?=
 =?utf-8?B?VXFBZkVZZklKS3NGblNBMG5KQzE1ZTBnNjU4RVdoc0tNV1JyYWkvTVFYVFdq?=
 =?utf-8?B?ejlINFZFVDFHd2IxbVV4Z1Q2alNQTW5GRExTc3p2U09PSW5lQ3BuQTJNdEM3?=
 =?utf-8?B?VTUyN09GWEhqcjYzQXRBU1JsMHVLQ2hFOUNqc0JXdG10bWVEQWtYMkNQZWw1?=
 =?utf-8?B?RGovVXM2U0NUbktiRXpzb3Judk8vTXh2RTFGdWkxdW93QmxsdSsxSlRUemU2?=
 =?utf-8?B?d0lDV0c5aUVJNnNwQ0lsYVNkRnVQd1krdjlVbDdMNE5EZDQvVDlXUFYxdWdF?=
 =?utf-8?B?WTVtL08wYmJMRXR2Ri9ueUdWby9yVjNReWF2N0FkV1YvMm14SUpWTzhaVVZB?=
 =?utf-8?B?M3FQZExIVFphVjk1bnNTRU85WHlBRCsrK2RNKy8vc3N5SXFzcHBNVm5pM2tl?=
 =?utf-8?B?dDUxT1pjNjJzMDd2Rjh3MlBRYmkzUXU5aDBsclN3dXdvaThGOUpKMTlXbTY1?=
 =?utf-8?B?UWZtaU5HSXB1WWw0YUYyU2w2Q0Z5c2xTZWFpUXRwYk15MDhBSDVpSmVWVk1u?=
 =?utf-8?B?d05PM09EUW9MbUhLT09FZVRsMFhqMkFXdHlpMUZqUDNvM1YyUENTcmNzRHN5?=
 =?utf-8?B?YWdiZFpmNC8rK0Y1Z1c5RmtTMFNpM2NCbVhKUXc5eXhBS045aXpWVnhDRmJQ?=
 =?utf-8?B?ZTV4Y3hYcVNHS3VwVVZjUWp0azUxN2lxZDlmVjNBT2doei9PbXE1dmV2ZW04?=
 =?utf-8?B?c3RJeE0xYU0yWTlBS2pSL0QvYlRSMisrd1RCRnU1VjlsREQyaElxcWdidXcw?=
 =?utf-8?Q?f2XRBGF+Z4b6dr+QE6TrtxkcAdh4O0Sa+KuFg94rz/s8Z?=
X-MS-Exchange-AntiSpam-MessageData-1: H/KATv7cyyetQg==
X-Exchange-RoutingPolicyChecked:
	Y4kK5iJjv7aMRbooN9kyA/53cj26JZPsjx2zC4aDxgZHGZpmdzj5tIkI277PHapSUdbz+N2Qeia4PGcYaabCOCWm2R4O3VA5W98dyVYN2b2CStu+tLUJV1pNfxWAZ1VsdIv54+XjMztp0oaSqvEFPMaHlSv+L56QtFcRzbZiIs3eqJCvMnA2G4MWk47SN+fTQSvmbxrWpsjg+Qs0FAu8vzfHjRQi3MPpUJ8ovqS7W2qi4qY8LkAXlq3VMD34UIehw5a/wX6cjAMsa0D/daGmm/IErpRxFuM40IL+kP8aAvH2PuSbtF16wxOL9gJ1NpcZa6JkdrTweFKMVyOWLwMCEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0sfRha4rqb1tXMf34zC+i5VczYu8GqkvgPlLeGROVsVn5duBmjyvLpK0bxH4uiFyxzgWbpa4iaoMZm65xzD7ZrKKxoE2caRkVQuTdgQKutUrb725PzgfQuB0+IF2C9zuHIzcYfwQMZkKNZQqc3b1O6EbIiBhdHW0SFRU5j9JAsreaBwQ7lgLY/SAx+5pLoYGEwLNf4znWxIKN3SrddtXL9RPeyNOK4A2uQ7XndVzjaz2YHpCogseB3Ve0t82r67MRpsLisSYIFwOo6IFVG3oNCOoyZPF2vLC3unW8Irib7+r2XiLxB1kEIaZq6Z9b1UDH/Bz8dA7TyJxdhDNolXaZM9rN6OceOn/g46REmyLhSV5n2Xm5A9dw2IcGygtr5YmJMt9xKU8YtlAzHNNcdh5lUYpigJAGRd8ClggujcaQV9ERI3Zqy3ROa5n4Jksn6rI/xzWHZObtZcQCmN6QQeMIBC6PuCo+bc9EwsVI3NHWqAHEAecPMDXOT6eOFI7UvSbCt+VwjG74ydGVmX1pcbkvKt72R2VZft8VcOQFlKUeUvETaglrlDe7tWB2nyzCeTv0/VloDNZ5iuXUDnTDeHsNkDw0dQZP1n3epTqfwJrl1uTmpKfJ6HnV1xL70mKWOJAaR6gZdShAHVJG5YMMstH8g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa92642a-aed5-4c06-99d2-08de9e6a00a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3872.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 23:18:44.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oBz5Gw3rDvfLN8AaZZwdJP75tgNK6GEMCXli3PwfCSFMOtjkBUQgwLL9YfsaGkco61AHJDyPqULit4grxrIYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR19MB9072
X-BESS-ID: 1776640727-104431-7694-11380-1
X-BESS-VER: 2019.1_20260409.1619
X-BESS-Apparent-Source-IP: 52.101.62.97
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYmFmZAVgZQ0CI52cQ40TLJIs
	3MICXZMsXMIM3UIMXSJDHVwDTRwsRSqTYWAPlCTNVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272671 [from 
	cloudscan20-218.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 3/30/26 21:03, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:34:53PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  util/fusermount.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  util/meson.build  |   2 +-
>>  2 files changed, 291 insertions(+), 13 deletions(-)
>>
>> diff --git a/util/fusermount.c b/util/fusermount.c
>> index d42e16955f6d26f81e6d2a5acb040b1448e20b51..31bf959024ae0cd2a4e50974589bfab30a100b0a 100644
>> --- a/util/fusermount.c
>> +++ b/util/fusermount.c
>> @@ -11,6 +11,9 @@
>>  #include "fuse_config.h"
>>  #include "mount_util.h"
>>  #include "util.h"
>> +#if __linux__
>> +#include "mount_i_linux.h"
>> +#endif
>>  
>>  #include <stdio.h>
>>  #include <stdlib.h>
>> @@ -923,6 +926,7 @@ static void free_mount_params(struct mount_params *mp)
>>  	free(mp->source);
>>  	free(mp->type);
>>  	free(mp->mnt_opts);
>> +	memset(mp, 0, sizeof(*mp));
>>  }
>>  
>>  /*
>> @@ -1309,6 +1313,171 @@ static int open_fuse_device(const char *dev)
>>  	return fd;
>>  }
>>  
>> +/*
>> + * Context for split mount operation (sync-init mode)
>> + */
>> +struct mount_context {
>> +	int fd;
>> +	const char *dev;
>> +	struct stat stbuf;
>> +	char *source;
>> +	char *mnt_opts;
>> +	char *x_opts;
>> +	const char *type;
>> +};
>> +
>> +/*
>> + * Phase 1: Open device and prepare for mount (sync-init mode)
>> + * Returns fd on success, -1 on failure
>> + */
>> +static int mount_fuse_prepare(const char *mnt, const char *opts,
>> +			      struct mount_context *ctx)
>> +{
>> +	int res;
>> +	int mountpoint_fd = -1;
>> +	char *do_mount_opts = NULL;
>> +	const char *real_mnt = mnt;
>> +
>> +	memset(ctx, 0, sizeof(*ctx));
>> +	ctx->dev = getenv(FUSE_KERN_DEVICE_ENV) ?: FUSE_DEV;
> 
> Should this use the helper to figure out the fuse device path?

I somehow already had that in my branch, must have changed after sent
the series, don't remember anymore.

> 
>> +
>> +	ctx->fd = open_fuse_device(ctx->dev);
>> +	if (ctx->fd == -1)
>> +		return -1;
>> +
>> +	drop_privs();
>> +	read_conf();
>> +
>> +	if (getuid() != 0 && mount_max != -1) {
>> +		int mount_count = count_fuse_fs();
>> +
>> +		if (mount_count >= mount_max) {
>> +			fprintf(stderr,
>> +				"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
>> +				progname, FUSE_CONF);
>> +			goto fail_close_fd;
>> +		}
>> +	}
>> +
>> +	res = extract_x_options(opts, &do_mount_opts, &ctx->x_opts);
>> +	if (res)
>> +		goto fail_close_fd;
>> +
>> +	res = check_perm(&real_mnt, &ctx->stbuf, &mountpoint_fd);
>> +	restore_privs();
>> +
>> +	if (mountpoint_fd != -1)
>> +		close(mountpoint_fd);
>> +
>> +	if (res == -1)
>> +		goto fail_close_fd;
>> +
>> +	free(do_mount_opts);
>> +	return ctx->fd;
>> +
>> +fail_close_fd:
>> +	close(ctx->fd);
>> +	free(do_mount_opts);
>> +	free(ctx->x_opts);
>> +	ctx->fd = -1;
>> +	return -1;
>> +}
>> +
>> +#ifdef HAVE_NEW_MOUNT_API
>> +/*
>> + * Phase 2: Perform the actual mount using new mount API (sync-init mode)
>> + * Returns 0 on success, -1 on failure
>> + */
>> +static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
>> +				     struct mount_context *ctx,
>> +				     const char **type)
>> +{
>> +	int res;
>> +	char *do_mount_opts = NULL;
>> +	char *x_prefixed_opts = NULL;
>> +	struct mount_params mp = {
>> +		.fd = ctx->fd,
>> +		.rootmode = ctx->stbuf.st_mode & S_IFMT,
>> +		.dev = ctx->dev,
>> +	};
>> +	char *final_mnt_opts = NULL;
>> +
>> +	/* Extract x-options */
>> +	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
> 
> Didn't we already extract_x_options() in phase 1?  Can we save
> do_mount_opts in ctx instead of calling this twice?

Fixed.

> 
>> +	if (res)
>> +		goto fail;
>> +
>> +	res = prepare_mount(do_mount_opts, &mp);
>> +	if (res == -1)
>> +		goto fail;
>> +
>> +	/* Merge x-options if running as root */
>> +	final_mnt_opts = mp.mnt_opts;
>> +	if (geteuid() == 0 && ctx->x_opts && strlen(ctx->x_opts) > 0) {
>> +		size_t mnt_opts_len = strlen(mp.mnt_opts);
>> +		size_t x_mnt_opts_len = mnt_opts_len + strlen(ctx->x_opts) + 2;
>> +		char *x_mnt_opts = calloc(1, x_mnt_opts_len);
>> +
>> +		if (!x_mnt_opts)
>> +			goto fail_free_params;
>> +
>> +		if (mnt_opts_len) {
>> +			strcpy(x_mnt_opts, mp.mnt_opts);
>> +			strncat(x_mnt_opts, ",", 2);
>> +		}
>> +		strncat(x_mnt_opts, ctx->x_opts,
>> +			x_mnt_opts_len - mnt_opts_len - 2);
> 
> asprintf?

Fixed as well.


Thanks,
Bernd
