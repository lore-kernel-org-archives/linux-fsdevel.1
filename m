Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092273A961B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480090; cv=fail; b=THOq5QLk/hj1MPeBUklPJl7me/WK28vPcL718jYCGlv+AR2f/cnn3bMzO8wZg+P9XExrj1w5NksraFwEjSrBBJHpeuERdGd63dFJ7ZnR7qODjuZYCHIWl1pczp4kN7jJVoGV0isrb8CY8WuwoXgMuttpPVJR2AIHH27vTHeysP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480090; c=relaxed/simple;
	bh=JTILoiNejKlNSIR8A71cDFhA/+gM5ShBgkGDvTjavS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htY9UCywrfGMx6RRuSfWQgan/fo2zqJ8xnEA/uWJ6Ibwop5Zz0xYC3MABC1SYJ24V3lgpXaXqXg40Xv/HKbf7QFPwh9JcASNCy8EMG/oFl0q/gRYPDTb0cUWz7JMYPxTlDx/CXiwWTbhjsSU1su2TfMSGzUxFcH9Q93v/EbfM20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=TEy9ri5p; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="TEy9ri5p"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020110.outbound.protection.outlook.com [52.101.46.110]) by mx-outbound19-121.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Apr 2026 16:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKcGkXeeYFuN/kMHmXXXL/W13WI9JKWklvR+p1AAZEVg9d+C34kOml9XugE8HOe5V1pgWbLrrnCX31IybuUPka5plBhzaCxPyAHfulHt5rRHapB/d5I/T6zv/jHWnIUWWlhFHZvAmjb/lFsYnMIEqQ3zt6U5vdWcjY9u/YdG7CHk7jcMDkAu69cfz/TsExCZIFQYErw3kwQZ0GidWcnWhbByCZ7BlU/5GWqThTzVVTQlW87nJz0rzwHCuZj05J7tmNxH/Uz5HlgKAhqR6qI7y1pQUNfYYh/CqiFCGgT+juYkgKbcx81YHES0ykWgjx0Icx9CV8hoBuuJvusMQOWQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oId918dtHsP7tbXaxv5DbDrHHITjAw7R3I7Jk+WimlM=;
 b=k5mTAKs17P0DSJ1nvkfKxBVvw0zOhfs3lGtX1RT8i25W47nq/Mn9ol0KLxbirU+7wyONPsdIlx5LqVT9y9oWxbMWSqRXTlyucxpWan/VjwDCGnRtnVubaZbyk22dSMDNWFYIFtZ6p/EnY6L1S8zkxD9s9ekH1Yzy3UtvrRFSnN46BW+10mNcQh42xN9ozRFoApPlgGyY+/nMc5/5M2yZNPSliiAXCxsW5dANAYeoWdKOOek1SF8W/alS0ViaZd3moIETxrRmmYs8701VzDruH/Yifc6LgzJETHnsEtqqeHt3taQyi9kJkM1ewTpEOXYy/5YUQK8orpFTXkMh2VFDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oId918dtHsP7tbXaxv5DbDrHHITjAw7R3I7Jk+WimlM=;
 b=TEy9ri5pmUa5rIpmKH1l6edOwBc0dStfgsdXeQBM+MKvNi9RJ++qTD+I08bfxHUXvQ+H3XcwftIWfEG/aeFdn+KToOmsfU1tYNUtVuD132eZNU2UKGqX7krDxuqplSC7d86f2CaGnN9Cz4MIWGpvq63iAcoc284Wd9s3n/p2S3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH8PR19MB6761.namprd19.prod.outlook.com (2603:10b6:510:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 16:11:50 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 16:11:50 +0000
Message-ID: <840a41a9-cbb8-4855-985d-d74ffbf317fd@ddn.com>
Date: Wed, 29 Apr 2026 18:11:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] fuse: {io-uring} Prefer the current core over
 mapping
To: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-8-982b6414b723@bsbernd.com>
 <CAJnrk1bE7ALGtWdV2Jm8_36gZv1o3AhF9Pdehwr+tTij_b1JYw@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJnrk1bE7ALGtWdV2Jm8_36gZv1o3AhF9Pdehwr+tTij_b1JYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0078.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::23) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|PH8PR19MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e27315-610d-4987-aeb4-08dea60a0512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|376014|19092799006|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 sB7PRBb34pWW3CW+pREiVDKwRBvx98NrHhwIZwUorEDgR7e5gsxdAfMZ/apV9C/tZO2yB14PmQ/8qZtw9axuD+S3vutuodNtOFtURss7JqU5XZglRrYJA5mRd8R8KwxgCPePau3AgLCKGJdcsFYx5YZwXSXRkBXqvf3brtJSFCqHCIdGOdANMsDLNFpwDMDZMIVhWUcCd6JRluiPj2l9AfAjimiPSfqeoc6uWcsQuloelpomLjPArM/G6+NsQVtyazzxw56xKGjitUkPqQ0Nl2Lp9rp0PcjnZalrENsiDrSUje0D4JctGdqqk1L+6ZkStXz9nsIMPrNviBgpDDftu73djo/JB/tGAHFU+soD1HsrIq7FF9/tlZt9UfoN4kzSY6OAcbceinSfNGrp3ZHClOLjGnZvIdW9VFOuqDZcHXrUqFzuz+7e91VgH9H+aBYxGi9P/4lNndXKBq1ur5nRGiy/1wDSfLTUbY1BFm9xov5gl5qMPtJBKyealmkPrG0qA8IYIsjgfzDTV2d07oaj6mAyIvmcdofgsaVnnYa5xRSOAJfMmRl1MAf6WBpWAa9YcjIltE/pzmYAzcowcA4BdJ4kIZrgfdzQlFt5j4fA+taaOLQQl9Q50T/1siq2Rjy9maxIb4Z6VZKgDd68EF8ueSULLFZt8iDPW6aH+3i169Y2BHM81Wy6bqJMn0cS9MD3/A61m44kPya5537YqJQgvM94dvmYu6jyDew1s9kvU1U=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c1l3cy95V2FmZ1hHRngyK0YvRkd0bVJCaXB2U2lkK0Zub2Zlckg1WGlReHAv?=
 =?utf-8?B?VW9nOWFWeTVUZElQQ2g4VUhTY2RvdjllTmJhRlFKSGZ2OVh4QVc3T1B4SVlJ?=
 =?utf-8?B?dEdENG1mbWFKcnZXN0M1TnZ2WkNrblpielJ0RTlvSHZnc2V6cC8zVUw5RHlI?=
 =?utf-8?B?SSs2OXZBTDEwWExBYnlNU1IvMUxaRUg0R1VtL01jMUI3M2FsTk83UkZkbXhW?=
 =?utf-8?B?cFI4Sm92ZFhscGZONzQ0REdrcVBZWWhVWUVvN1h2bCtOS1BoRkd2am9MVm8x?=
 =?utf-8?B?YTByakppOVRwMUExekFObWRzVy96WUZqTXdHNlo4a1RBampJQ05mWDZzM3NY?=
 =?utf-8?B?RG9iSGc0NFp6aHFjUjdGQXZnRjRQTTVQK1BlSk9YUUZYbnRxUm9weUx3NXR5?=
 =?utf-8?B?bzVrVkhRZUUzQm1QYWlMSWlldnN3S0FUSWl2eUh3ckFJR3J4c2dyUmNHNlhH?=
 =?utf-8?B?SEtZYVVhQW5NWGxRV2I2MjQzSXRWWjFVM3F6Tm1jRDhZU3dTOUtLbk0wcEZO?=
 =?utf-8?B?RkpNLzlIZDQ0SVdOZVY1RlEyeS8xbkhidzBtMXVFMk1zRjQwYUtkczJLaGt2?=
 =?utf-8?B?TUJ6WVRuM2tuNTVPL0l3K0RzRE1aK1BZQ2lsTDFhMExOekJ3bHdYaWxTVEhK?=
 =?utf-8?B?RFRvMUFzNFJOeUtSdEQzTXNmc21vTTYxNW1IM1pJWGpHa2dROFZsNWtHamFE?=
 =?utf-8?B?SFVrbitMdUxxZ3lRTEsxRmhuNWU5ZkU2d0daanUvU1M0eEZOZ2Z1REVNaEFB?=
 =?utf-8?B?bFZ0ejhEbmszS21WS1ZtVmUzNUtRQTRza3NPTnpQRkU1OXlSMmZGWEI2cVk2?=
 =?utf-8?B?V0lNaVZNWE0yV2RJeTRkSThmWlpMN0kyRG5JK2tCQ2IrREVOUkJyQ3BaNFdY?=
 =?utf-8?B?UnRlMEczaUNBRUFQWkZMTERORnBDdTlOVkxZSXJRQ3ArRHVjWWZnb2I4bDlj?=
 =?utf-8?B?Tkl2VXV2U0x2emNKbjRNT1pvRElWWGpuY2VqeUQ3RzdWYVVqc1NPR3JDZnF4?=
 =?utf-8?B?UEtkdEFtdXJGL0k4bnl4UDJ2VVIyNlArcTE5NzR1clVoWlBUUDI2bkFyc2Va?=
 =?utf-8?B?Y1BQYnRET2FNTnBidE53QThRNVh6VjM2bVRQSEk3UnEzbGtaVUNmSmVyUVFQ?=
 =?utf-8?B?dndwVFI4emJuL0krZE5sSmw3SnIzSThkL2poMG1LQVZoeERFNjc2UXVGMVkw?=
 =?utf-8?B?Tm4vckkvVTJsTnB0em41b1FVY3o1REp6MkwvZzFWc0REa3NuRnoxVnpPaUl1?=
 =?utf-8?B?Q3JMc0djWFlPMXFrSlJHT013dndkTW5mNHY0cWtiN1lwZG5FTVhXQlQxdWRH?=
 =?utf-8?B?OGZrcFpkTjBCMXBza1g0WWxCZFlSMTkzME5KOHJSMVRCTS9NNWU0bTBpVjEr?=
 =?utf-8?B?Y0ovQVpaWmgxNUhJN3NOM0JaSlFJNU1hME5WQ3loUUt0VFNTTGcveVUyd1N2?=
 =?utf-8?B?OGxqdlN1QkV6ODFHTXJHYlg2ZnhpaGJQVnBjcnIvWHlLclJjbXBMSXdscFFS?=
 =?utf-8?B?ZlgwR0cyTW9DNjVvSVFOOE5aUXhyalhYa3lqQkZ6R3cwS2UyRVNJUlNGc01E?=
 =?utf-8?B?TVNaNFNzZzlmKzBrUEZNMnJCWlN0NDdhQ3MxeSs3NjVpRDJEL2FidXo3Q3Z0?=
 =?utf-8?B?MWRBaFlrdUcyaXVGdmYxRmRBbEZNOERmU25OYW9kakpETWhUQkZxeks1WGd5?=
 =?utf-8?B?cVhuR3JrVWlCMUpaOUErVTVmM2NQZy9iUzhmZXVqS3UyZlpjRmlwNG9pWHNt?=
 =?utf-8?B?NEFRRnhUK0RjTmliMk15WVJ6M2pGKzFObDFhUjRFc01WVWxIUnM3Z1RJQVRC?=
 =?utf-8?B?eitsQkdocVhVaHdIc25TVHNkWWlxZUs0M25DV1o1SE0vMzY4ODdCREdLNlA4?=
 =?utf-8?B?c0YxMWtqTlNuUE5iWlNGcklSQnlXYkJSZThsb29veEFzRVdqSC9uUGREMnpC?=
 =?utf-8?B?YWtlM01TMytnd2xxVXpjV3JLV2FaYnE1Z2hJd3FhdmR3cXJrRzhTT0dBeGJr?=
 =?utf-8?B?OTY3Vm13VFZVWXhXMnhlLzFOMW5SangyNVdvZjRoby9pVk1IVU01SHFteFdn?=
 =?utf-8?B?ejhUa0FiOXNIOVFGdnRoc21wY2ZIemZHemtvSG9jMjVqOXY3UWlXWGtFT3Yy?=
 =?utf-8?B?SWJWVDBFeWp4aXZrUElJL0NHYkFKVjVVY2FUZXhrNlRIWHJrMWg0WTg5VitB?=
 =?utf-8?B?c2tKT3I2bEtObllicHo4ZXhuY0xQbjBha2p3MWVHbmtKOXJlUGN3dlRtNnJm?=
 =?utf-8?B?cWorb2lndjRTT25ob1VuRlNwWWxaWXlVelJweUkyMVEyaExWS3hoWmpqMWdT?=
 =?utf-8?B?OUI5OElSUG55TDd1OEJ1Y29RZG9OOVVHZ1RkYUQyS3R3U0ZIL3VXenJyWUwz?=
 =?utf-8?Q?HC8iT8XO8x0VqHav+ePA8lV2HLD29CzYGa7qkWFkOt9X3?=
X-MS-Exchange-AntiSpam-MessageData-1: X3Tuj7c7w18s3g==
X-Exchange-RoutingPolicyChecked:
 mZgH/w6vHS1tY4E2m/euiJSGnbpfrOTrAi1qn5qVNOh0/ZX+cuZu3jSzE0tLj6Lv/shgbQ+JZRm4AyRHo0n55ZvW3jIQba7Js7lfu7u/cX9TmUMrbsaHMjQiO2/70fS2XARUpnErCilMdX+Y92nUTd3ykMeJcNMO0P0OGcqDM4FN1Tto+4n0K/SxY0jMh6KMhRVwqFerBzY2fmVmeb27IqikLCe4aGvMjtRc/xO21QmsTIi6/qNNorI3Uokj+kviY6p/ZZvrj4JkQ4PfgbOcCuKGudAuxfG8jDf1OP/ExHUaZ+s7OqmzoE97UIwkkH7VDXH+XGaLrhYo7mXc/wyeOg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 qSk2n80tT3L99iFGegFtf1MraxaWvrT1exajnIKIn1jsXDNHYggpHuG8GVmpnbNObx1yH3yzAa2M8spaRy7epYZ9FfhMRKA/JVMPB0MzTdmq5dHWHCDBNvT61KEuc9frqZvqWhZcHtIeCcR1Da3xmNHbPGO0gitbE62vZIN9VWV1GJBk8gU80k5FhmmBvhUvx3DRipPXL5xXVbev/irjZMx7SxCYL1lBcAvJUuJgjAWvqh4NUbfP6X5LydYTh6pP3NWqTQPXk6J+87gxHVZhsUyCuGEK0RRflDWvZ/U/oALLdEgOZ9T4Lc2KUFup4cFzPZFhP1SgdYgOe63krfSrNwQUmUQsnhbQZh3E23+VIheq3Fj1ezNOrqq/7uKd5WlSo1fahZHofjO6Cyj/y/KrZqbMulC1aAXqsT2geacWZrnhYCUwcO8FdrYDoInpmmhvtqlgTVIwXqXHjYI1r/Hldw0z8dSd0uhquimyOGVeZkidr+sJ2XWYgjeJwREpJExpFhxJ+EMIrgGQ0XydgVRsW50FaCDZwUyO7lFlMak1pG7D0lgOt90qQGfpjc8Ld4TCWtbUyYeZZczHuoKyd3Slp1tOW4l6F0XjLH6AfrUCVLD0anBmpu9eb6axbjHaEvaTYtR68+3OnNiWh3pXCAOxxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e27315-610d-4987-aeb4-08dea60a0512
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 16:11:50.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjqdOn8vJz9j4RzhyudpmLVYHvtFKV7sN5W0RxDnjC7SRSPMR/xEddTKmOk5k/ZtNyGLYzV9QjKyzFv0xVfQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6761
X-OriginatorOrg: ddn.com
X-BESS-ID: 1777480085-104985-7736-23115-1
X-BESS-VER: 2019.1_20260409.1619
X-BESS-Apparent-Source-IP: 52.101.46.110
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaW5gZAVgZQMM3YItHANMXQ2N
	gyzdTU3DjVItHMyNjQxMDSwtjEIilZqTYWAPKUIdhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272903 [from 
	cloudscan19-22.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/29/26 17:40, Joanne Koong wrote:
> On Mon, Apr 13, 2026 at 10:41 AM Bernd Schubert via B4 Relay
> <devnull+bernd.bsbernd.com@kernel.org> wrote:
>>
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Mapping might point to a totally different core due to
>> random assignment. For performance using the current
>> core might be beneficial
>>
>> Example (with core binding)
>>
>> unpatched WRITE: bw=841MiB/s
>> patched   WRITE: bw=1363MiB/s
>>
>> With
>> fio --name=test --ioengine=psync --direct=1 \
>>     --rw=write --bs=1M --iodepth=1 --numjobs=1 \
>>     --filename_format=/redfs/testfile.\$jobnum --size=100G \
>>     --thread --create_on_open=1 --runtime=30s --cpus_allowed=1
>>
>> In order to get the good number `--cpus_allowed=1` is needed.
>> This could be improved by a future change that avoids
>> cpu migration in fuse_request_end() on wake_up() call.
>>
>> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
>> ---
>>  fs/fuse/dev_uring.c | 41 ++++++++++++++++++++++++++++-------------
>>  1 file changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index e06d45b161d5000e24431314b2222b66bdea58aa..5c00fd047c8bd359ec34fb6a41abba44f6794517 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -19,8 +19,12 @@ MODULE_PARM_DESC(enable_uring,
>>
>>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
>>
>> +/* Threshold that determines if a better queue should be searched for */
>>  #define FUSE_URING_Q_THRESHOLD 2
>>
>> +/* Number of (re)tries to find a better queue */
>> +#define FUSE_URING_Q_TRIES 3
>> +
>>  bool fuse_uring_enabled(void)
>>  {
>>         return enable_uring;
>> @@ -1311,7 +1315,7 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>                                                        bool background)
>>  {
>>         unsigned int qid;
>> -       int node, retries = 0;
>> +       int node, tries = 0;
>>         unsigned int nr_queues;
>>         unsigned int cpu = task_cpu(current);
>>         struct fuse_ring_queue *queue, *primary_queue = NULL;
>> @@ -1336,26 +1340,36 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>
>>         nr_queues = READ_ONCE(ring->numa_q_map[node].nr_queues);
>>         if (nr_queues) {
>> +               /* prefer the queue that corresponds to the current cpu */
>> +               queue = READ_ONCE(ring->queues[cpu]);
>> +               if (queue) {
>> +                       if (queue->nr_reqs <= FUSE_URING_Q_THRESHOLD)
>> +                               return queue;
>> +                       primary_queue = queue;
>> +               }
>> +
>>                 qid = ring->numa_q_map[node].cpu_to_qid[cpu];
>>                 if (WARN_ON_ONCE(qid >= ring->max_nr_queues))
>>                         return NULL;
>> -               queue = READ_ONCE(ring->queues[qid]);
>> +               if (qid != cpu) {
>> +                       queue = READ_ONCE(ring->queues[qid]);
>>
>> -               /* Might happen on teardown */
>> -               if (unlikely(!queue))
>> -                       return NULL;
>> +                       /* Might happen on teardown */
>> +                       if (unlikely(!queue))
>> +                               return NULL;
>>
>> -               if (queue->nr_reqs < FUSE_URING_Q_THRESHOLD)
>> -                       return queue;
>> +                       if (queue->nr_reqs <= FUSE_URING_Q_THRESHOLD)
>> +                               return queue;
>> +               }
>>
>>                 /* Retries help for load balancing */
>> -               if (retries < FUSE_URING_Q_THRESHOLD) {
>> -                       if (!retries)
>> +               if (tries < FUSE_URING_Q_TRIES && tries + 1 < nr_queues) {
>> +                       if (!primary_queue)
>>                                 primary_queue = queue;
>>
>> -                       /* Increase cpu, assuming it will map to a differet qid*/
>> +                       /* Increase cpu, assuming it will map to a different qid*/
>>                         cpu++;
>> -                       retries++;
>> +                       tries++;
>>                         goto retry;
>>                 }
>>         }
>> @@ -1366,9 +1380,10 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>
>>         /* global registered queue bitmap */
>>         qid = ring->q_map.cpu_to_qid[cpu];
>> -       if (WARN_ON_ONCE(qid >= ring->max_nr_queues))
>> -       /* Might happen on teardown */
>> +       if (WARN_ON_ONCE(qid >= ring->max_nr_queues)) {
>> +               /* Might happen on teardown */
>>                 return NULL;
>> +       }
>>         return READ_ONCE(ring->queues[qid]);
>>  }
>>
> 
> This kind of seems like a runtime workaround for the mapping algorithm
> we used in patch 5 for the round-robin distribution.
> 
> In patch 5, the mapping logic is:
> 
>> +static void fuse_uring_cpu_qid_mapping(struct fuse_ring *ring, int qid,
>> +                                      struct fuse_queue_map *q_map,
>> +                                      int node)
>> +{
>> +       int cpu, qid_idx, mapping_count = 0;
>> +       size_t nr_queues;
>> +
>> +       cpumask_set_cpu(qid, q_map->registered_q_mask);
>> +       nr_queues = cpumask_weight(q_map->registered_q_mask);
>> +       for (cpu = 0; cpu < ring->max_nr_queues; cpu++) {
>> +               if (node != -1 && cpu_to_node(cpu) != node)
>> +                       continue;
>> +
>> +               qid_idx = mapping_count % nr_queues;
>> +               q_map->cpu_to_qid[cpu] = cpumask_nth(qid_idx,
>> +                                                    q_map->registered_q_mask);
>> +               mapping_count++;
>> +               pr_debug("%s node=%d qid=%d qid_idx=%d nr_queues=%zu %d->%d\n",
>> +                        __func__, node, qid, qid_idx, nr_queues, cpu,
>> +                        q_map->cpu_to_qid[cpu]);
>> +       }
>> +}
> 
> I think if we tweaked the mapping initialization to
> 
>       if (cpumask_test_cpu(cpu, q_map->registered_q_mask)) {
>           q_map->cpu_to_qid[cpu] = cpu;
>       } else {
>           qid_idx = mapping_count % nr_queues;
>           q_map->cpu_to_qid[cpu] = cpumask_nth(qid_idx,
>                                        q_map->registered_q_mask);
>           mapping_count++;
>       }
>       ...
> 
> then it's guaranteed that a CPU with its own registered queue would
> always map to its own queue, and this patch could be dropped.

I had actually considered that. My idea was that libfuse can override
fuse_uring_select_queue() with eBPF and could then enable/disable
this preferred self-queue with a userspace config. Which is not so easy,
if it is encoded into the mapping.
This override is something I wanted try out, but never came to it so
far. I'm perfectly fine to the simple way for now and then go the more
complicated way once libfuse has the eBPF overide.

Thanks,
Bernd
