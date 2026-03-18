Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE6285CA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773829417; cv=fail; b=dH6222Yq5k7yeDcZnk7EmPmLKC2GM8GqIDfLmYSVtx4EzwSZ+/YNz/GvC3CMwtthDR22K9quN3GthBaU3xys1yZfF2xUGO1ST/8lhgCOm3d0DLHcBR9W1aUyMMM74TpLoLzngf0oo1MKh4I20PlXnHy2elniQ3vj5SPyqYiQ74g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773829417; c=relaxed/simple;
	bh=pH+2pw/5G9mrrNkLAiYtsFP7kJBq8IGPRNb6LmOB4SA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nnJFv/gIWIWCIs3kzEAS24bmIPcIN8IYs6GAA3LcUlFBdYSz2SXZD+PE9umQ5V302cI2w6qfK4PvQiT/iPklb4Jz3INFr2MTcbANnmK42UTi/1ETlDF2VgFnHTVbtcLSgX3zbmifYUsMbgiPLSFIRZWgwvsdSGmyUK+ovjIWHQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=NhA7fZW9; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="NhA7fZW9"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023136.outbound.protection.outlook.com [40.107.201.136]) by mx-outbound11-254.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 18 Mar 2026 10:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=It1+vK6TQFSnhFbl1BNY9LeifZYa7TPBYYELjQYo8t7uP9BRyLmcTCsEbFR7/WGOwWz6ZkJKjnzFy2Oe4EiA52iKuDhW7WrMmDCokTwC8UDvKj5h4QzAh5M2cKYyYYjzenJecmBoJvTnGJQol0HekH2Dw3/yiAna08rZCJO6TA+usTh/VHFIr64fvlPy62p10n1HnxM8sf0XHqpfSuWTT+U8rGSjq/oayRW76LHqehC9yiWy4K0RPBCWPZPqzyoLGoIh/oVN8NJ6T3EsndvVRnoKRe/X6YvIPhJJjl9glALJgycFh640y467Z0SG0zPyaGrChxAVCvnoAfE8ZXqJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5loTCXlkkGDbjSmqXNLoC6H+Ui3w3YkwarZb8uS2yq8=;
 b=MQ86/Emcdqd9bvKV8x/+vHMfuilRgDS/6ZEEQZ3giFAe3hWJeHKlEi/IuiwYfR+1SY6t/7rbv21A7fN+JtJuYm75C1HKCq3mvuvJzZVnP/aKGtx+2YvaWsZE5ssoA9dsZ76jBDCPkYobu4IOBjS26kmGEOyROCCBW9DZtWc9ZRbp0c7r34itfCE1TfDfbB6XodtWWXPXO0TAZkm0HGCQIB+43+zzDTT/Gv7HC3LlQcTDfSkyEQZKceMRRCgiqs1TJlw1P6iXDTyYRP3MXc2IldxGNPFz0T5ZP0BOuAA3smeUUXgXTmT8ykX6aU1Z0PqSpMtRmkwMmAhChy9o2EhaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5loTCXlkkGDbjSmqXNLoC6H+Ui3w3YkwarZb8uS2yq8=;
 b=NhA7fZW92j1XAU+BSorpt5aAsaHEe31lw5ukSyh93y2ne1f9XDjpsfgYT56TLp7Wcn1z1vpG7c9I3VyvQ9d1iU6ffidrkOZzOgvp5GfDPMszgvIfSARxMqwx7qa3IaTRA3jCLp3ni9SLPuyK0WgvDKI9IqYja3mXooPR4mY9ER4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from MN2PR19MB3872.namprd19.prod.outlook.com (2603:10b6:208:1e8::8)
 by PH7PR19MB6634.namprd19.prod.outlook.com (2603:10b6:510:1a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:48:16 +0000
Received: from MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b]) by MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:48:15 +0000
Message-ID: <a2275132-58a8-45be-9e6f-0a521af2ef63@ddn.com>
Date: Wed, 18 Mar 2026 09:48:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL v2] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
 neal@gompa.dev
References: <20260316235017.GK1742010@frogsfrogsfrogs>
 <70550759-eae2-482d-a598-164d10930220@bsbernd.com>
 <20260318001512.GT6069@frogsfrogsfrogs>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260318001512.GT6069@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::21) To MN2PR19MB3872.namprd19.prod.outlook.com
 (2603:10b6:208:1e8::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR19MB3872:EE_|PH7PR19MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adbb47c-4c92-483c-dd65-08de84cb1845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Lup/F3pg2lkUjX3/SvLNWPGHxZ+uksMV7F4498kzBtkxAzm9HLMojr1JizHs9pjTR+I67BhWOUTYza9XXciDJoYTwzqhDJ5SdnSWZXCzhRJsn4UcIE7Cn0xdAeV/K+7m8Z4GuKRRaF8ZdYgm53gzFVQpV97cvmN5Xc2uIidJu4XdTi7vC3G+QgHU4Wikhf8o8CP3av1/iYcpCh0xPUX+eFxVxhcj8sRaDVTnayJWOCsP7T0aH6YR3r+5myurQXmopADgkq1YlWv1DWbrOrezMPz/P9Jqigfmz3k65LkzQZ6Kp6xQrWvmkgjqWgjBgLqpNKFApzXtrCEf6mgJojBci2fcXf9z8vu1qzBtWsBKNJnkE6H+e28nVA3HOKXaSdZ+5u25ru47/BZmpLVIrXJhVSgqeHfg8o9mf060cuocS2GjohDwo4ycggFht3EzLNEpvZ+epDFrUY2vzHBNGdHTjSijQHVvIIzG0zB7MshTVm6jJ/DogW6/6ve66R3kgUqGd4pqiTYxKiKtJc8n0c0Ha3mOl+qM+F+TkdO539VM5E79dJ2uAnGW0pQ7MEreUIoR5zz2X51NIilzC4++6wXNdwMdIuzqkANPBuizceNfVb0YQy4JCj5AF/O8IVlTQt/rYPryZb+8TraFndfbWtmZQDjnaEYf74/KmHDUYBB58y37fj/vC8ncb1YCSRFWOiBP+dr1/V4H9Z0w51MX526sWqys32pWmi7xPu+HfT6EdeQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3872.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVhiWWhJSmkyd2FUYnlzampYWkN1K3RwTnBFSFRjUUY2MGt3aFZGVkdzWVRl?=
 =?utf-8?B?cUowVDhQdUlqSGI1a2R6ZmtBWlg0SlVtbnNmZVZMV0NEcnlqL2F4VjJTTVBT?=
 =?utf-8?B?MFJSckY0cjBaZ2ZyNHkyYjd3ekRjZ09aZU00bUpTZ2M0V2c1Tk85K1VrZkJF?=
 =?utf-8?B?MGVCOTVicDBiRGpJYnhQMTRZdk45dkc2YWx5VzZSTXBXejNkc1MwdmEyUm1F?=
 =?utf-8?B?S3BRVnViSENtbEpkOTJMNUtXOUdUN1RsbnBGLzhzWjcrSzh4OHNwYndZa2hh?=
 =?utf-8?B?cWI2aUlka2VwNEV4SFZZWHZtRWV1SmtZRHBXUXJzOFVCT3Z5UTVldGVsV3h3?=
 =?utf-8?B?TkRmQ1EwZUMwS0NMOFMyTUdZckp1OXVOUEEyQXRpY1NHU0w3OEpxR1ZzRjVh?=
 =?utf-8?B?QTNrUkIxdm5zNlZibDRGL2c5djVpdVZYQWVyS1FqVG5DN2VZVCtqblQ5Rzkz?=
 =?utf-8?B?SGVwMkFHbTFVTm5CVU1paFRjaGh2VGVUR1ZERndOWVd3S2VDQUM3c21oeVdo?=
 =?utf-8?B?K09sYkxxdmtVcnBES3BnZ0NrNUhPRElUS01pMGtSVU13WUtQL1FXbWlkRzhB?=
 =?utf-8?B?RG10Q2lKM3VXTGNsMEoxNXVXdUc3N1p1SU8zOTVWV0dsekJBT3h0UVZtdVhH?=
 =?utf-8?B?WFI1ZUlYSHlNRnF1ZDEyTFBIWWlIQ2MzT3pERjhwRSt1dDZGSFU3ZVp2Qm9p?=
 =?utf-8?B?cmZGdU9Rb0tETmozOW41RS9JaTdqZWZVOGEwVXQ5ZFpXK3N1bk9Eb0VYVDIw?=
 =?utf-8?B?U3M2eGcrUGpsWUNNUUlIUjJSK0x4UXhtOHF0SVFXTmNnL0NwZm00OFFTNUkv?=
 =?utf-8?B?dmtrTVY2WDU0Z1YxRkhNb1RLd0MyQlhHTGUxMFlSQmt6QXFBSTVEWGsxSjB4?=
 =?utf-8?B?NjhjeCtheWk3aWNNeVltQm1ua2s1VXlZZ3RySFY4Zm1ITzJ3ZlYrNUVMQnM3?=
 =?utf-8?B?SVRtM3RLZzRvSG94YTdHRTFZNmhJQzRWWjBGSnhxczMrTEVBaFNEcXVXcVBi?=
 =?utf-8?B?R0tZamw3UHFMV2xVYU1iNm1tSkZ3WDMxY3NmeE1RMGVIelNVWVZGQmp4Sng3?=
 =?utf-8?B?aVJkaFhqNDQ4cHpaTGdUWVhqVEE0aTdPM2xUOUFhUFpXVk82ZzByMG1NQ2Q3?=
 =?utf-8?B?MWg2QThVT0dXQzEyZ0MrN2JVTFE3UENoQVhxMFNnLzdUQXhjeGF2RHRLMmVR?=
 =?utf-8?B?VHMyS2twem96Q2FqY2lSRGJpbkpWaHNROGhaKzdzWG5hT1VxbjRYV2dBK3E4?=
 =?utf-8?B?ckxvYy9ZVzBDc3psY1hZK2JCS0xRWWZlVW1PSGJ6UXdxclBsU3padVhVSE53?=
 =?utf-8?B?Y1BBL0R3bC9kdkl1UmZuZS9jVGJiRTRLM01LbEQ4UWRzY0k4QXpUWTZPOXN2?=
 =?utf-8?B?bXNrdnQ4K0FKWjZrNUx4OTdsME5FMnhJYkl3QWplSElWcDRSVzhCTHhFRmFB?=
 =?utf-8?B?TGxqdUcrcE1kR2xYeUpEWi9URUtYS3Vsc1dhczZaV1dvaDFjbzczbjBBdXlj?=
 =?utf-8?B?V3A4cHYrUU9FbDBTVmdad3BUU2d5WU03d1krZzZqcXJWU21YRm1VY2hXdU8z?=
 =?utf-8?B?MEticG5ubWVkbG5XYjRNYnh6UFlVbXZQMmJtOVdJYnRTNjFIOXBNN1lZYUpK?=
 =?utf-8?B?Q1BiNEgxU3lBeW5oZGVhb0ZNYjRpYjhzdkU0czF5YjdJL1IwdUVwc3lUeTNQ?=
 =?utf-8?B?R3VIWjdBMGRoREZuc0Y2RU51QjJML3NZU2Z1UDJVOUFLbndIaE1CdXRIMXJO?=
 =?utf-8?B?eDZoMHVIbkZRUFVmc0dTSHYzcXpLZlRmQzE1Tk9CQU1SQzhtbFIxOEFZYzZz?=
 =?utf-8?B?eWRXTmRISm9OMDNoMkNjcHBuMVFRRW1UemcwY3VBOFVuS0kvK0NjVFN5TFdq?=
 =?utf-8?B?b1FTV1FlQklQcERvaXZMSlNwUnZ1L2RudHU5aWNRWG14UUtPK01nTXQ0emV3?=
 =?utf-8?B?dnBmNmsrRlo0NHdyWDcybnV4S3A3YkNIR2o0V2xTQkJSdklscDhGUGdiRzFr?=
 =?utf-8?B?d21iSmZ2a2xXMDVLaVVEZ2EzWWtBVjJlYnlOc2R5TjBYMm5TUzBVWkdLZWdX?=
 =?utf-8?B?NExleTh5WlUxbTdaOTVoUU9XSFRwZEczSXVNMndtQ1ZIK1MzVnM4NUhUV292?=
 =?utf-8?B?M1pDQXY4QVFQdDkwdnlES2htQ01ac1FRa0VETGJ3K3ZDeDBjcWJsL3VDVkVG?=
 =?utf-8?B?TDBmeVBUdUgzZHZWNnFsdURpSCtQRjV1L2dMWEc5TGtDSmNJMUFyZW16RXN5?=
 =?utf-8?B?Sy92NXkrL0RPZ1lONnBGb1ZkSzBnQ0dMTjd5a1ZVeW5FWGxYOUtCeWpHVElT?=
 =?utf-8?B?MUVpei9YZGVhYm12SjZjY1RTRFI3N2pNTm54S3h6cmhVQW1OT29kV3ZMWVNv?=
 =?utf-8?Q?ADdqqAGQl3P8Z/sgUmU1H5H3K3CId0UB1R+zLNF9ckeBL?=
X-MS-Exchange-AntiSpam-MessageData-1: N7b2oXl0W2ovFg==
X-Exchange-RoutingPolicyChecked:
	eveH6KF3NPvLheBpUmjTZLwYaBp+uD1BPm1QHFl1ZAjW108MwKYrj96QospnpV6pS8l1SZVjkWvncjA8pSDgeZdqpGl6fHwZf9uHWPsqqv0nRzBLB54O+eTuaD3n3de20wwUve7FUGRlA89ye6Ybh4sESuJugt4ud9BOrv3qYxOmYhQa7YBb1ufOu0d/r9e3IKAF3UzGJtbzMyZhATmIfbafRHHV9JW2bDKzidITqRQPk//WDtZI9yBzt+F+/4V0Y1H4eh/Quh/FQVGQJ3A56hCbe7C/FF6NlKwzw4Shs7dGffTXnx2r+yHKyDVOiWVoCj8ltSDoU+tQp/0FWa+cXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IfDGMaZKYxIwU5NB/bGF85Ogl0vrEjsdKpJObJU5TOBNaftTpJONRFOkn5K8FJ9Vyhs+FiNVKeiDCuVqvao94jtVWcEL+prZycUl5Z9OG3JNd2r5STyhNJ3TADwOXsi5sxxmlXRx4s9L5M/Iq0OWyf9/c5ExLSzQOtctvFkJYqNtSAGn/060tYsLlDTj0gwLq9l0HIsqmdx1xZ6mLYUEt2QiK2UlcH9FDdBZxS8u1VwvTsqDeo3AK2C0qICYNzqlQS5yBVne463BD6mDEh+US7r18jWKDUtn9V+C+EFkYCylVOIc5/daUGcMULqAvxU8qWygWCMv3Qn4mKFYpg6rnPoPlR96OfMsY+u+4s/tZbVYLU96p8+xbsrh8ij5kFqRhJTbDvtNGIE3NaY0BEz3Ja5lD+ZXFToAUqdr3s8k1szvPhqr4obXhRkkKiHrJpgs9XWboDqDO5hvEA9KXtYHDFjzs6MSTuPLljvCuTpZ+hbopQXoMW1ESInAKGzyDCnK2b19Xp0naaBw4sF1zCXsXz0chzeejDKxDRKPnLQMgjlGdVtnD8X3VrRpHtpuwxJKZDhI7jN59ySOUO19thHxqw0dFRi5VkIDbbhZYZwQ71a6uFNhKeWWxjtHGDEdGroeTWAY3tvNdhgbtz8k9YOhvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adbb47c-4c92-483c-dd65-08de84cb1845
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3872.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:48:15.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fvtxia9R31MeEW2TjmUmWIiE3xSs02c+jn4ZGPdKbnu7w3jbfqC+sittXurqZc4XF3h+gUyiR6OYiImkmB82uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6634
X-OriginatorOrg: ddn.com
X-BESS-ID: 1773829413-103070-8859-156387-1
X-BESS-VER: 2019.1_20260316.2223
X-BESS-Apparent-Source-IP: 40.107.201.136
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhamhqZAVgZQ0NLQ0DLF2NTc1D
	gxzTQtNS01Jc0wNdEwLcnUOC3V3NxQqTYWAK5cNG1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.271893 [from 
	cloudscan12-190.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 3/18/26 01:15, Darrick J. Wong wrote:
> On Wed, Mar 18, 2026 at 12:08:37AM +0100, Bernd Schubert wrote:
>>
>>
>> On 3/17/26 00:50, Darrick J. Wong wrote:
>>> Hi Bernd,
>>>
>>> I hope you're feeling better!
>>
>> Thank you much better!
>>
>>>
>>> Please have a look at this branch with changes for libfuse.  This second
>>> PR contains a bunch of new things:
>>>
>>>  * Cleaned up error code handling and logging
>>>  * Examples of systemd-enabled high and low-level fuse servers
>>>  * Most of the checkpatch complaints addressed
>>>  * fuservicemount3 can now be a setuid program to allow unprivileged
>>>    userspace to fire up a contained filesystem driver.  This could be
>>>    opening Pandora's box...
>>>
>>> As usual, I did a test-merge with the main upstream branch as of a few
>>> minutes ago, and didn't see any conflicts.  Please let me know if you
>>> encounter any problems.
>>
>> I only found a minute to pull and push to my github repo to update the PR. 
>> BSD still fails
>>
>> 2026-03-17T23:01:17.9810147Z FAILED: [code=1] example/hello_ll.p/single_file.c.o 
>> 2026-03-17T23:01:17.9813484Z cc -Iexample/hello_ll.p -Iexample -I../example -Iinclude -I../include -Ilib -I../lib -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -pthread -MD -MQ example/hello_ll.p/single_file.c.o -MF example/hello_ll.p/single_file.c.o.d -o example/hello_ll.p/single_file.c.o -c ../example/single_file.c
>> 2026-03-17T23:01:17.9817014Z ../example/single_file.c:46:10: error: use of undeclared identifier 'PTHREAD_MUTEX_INITIALIZER'
>> 2026-03-17T23:01:17.9817870Z    46 |         .lock = PTHREAD_MUTEX_INITIALIZER,
>> 2026-03-17T23:01:17.9818369Z       |                 ^
>> 2026-03-17T23:01:17.9819309Z ../example/single_file.c:198:51: warning: unused parameter 'ino' [-Wunused-parameter]
>> 2026-03-17T23:01:17.9820276Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
>> 2026-03-17T23:01:17.9821012Z       |                                                   ^
>> 2026-03-17T23:01:17.9821785Z ../example/single_file.c:198:60: warning: unused parameter 'flags' [-Wunused-parameter]
>> 2026-03-17T23:01:17.9823239Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
>> 2026-03-17T23:01:17.9824029Z       |                                                            ^
>> 2026-03-17T23:01:17.9824978Z ../example/single_file.c:198:71: warning: unused parameter 'mask' [-Wunused-parameter]
>> 2026-03-17T23:01:17.9829337Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
>> 2026-03-17T23:01:17.9830366Z       |                                                                       ^
>> 2026-03-17T23:01:17.9832001Z ../example/single_file.c:199:33: warning: unused parameter 'fi' [-Wunused-parameter]
>> 2026-03-17T23:01:17.9833062Z   199 |                        struct fuse_file_info *fi)
>> 2026-03-17T23:01:17.9833562Z       |                                               ^
>> 2026-03-17T23:01:17.9834825Z ../example/single_file.c:211:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>> 2026-03-17T23:01:17.9836166Z   211 |         pthread_mutex_lock(&single_file.lock);
>> 2026-03-17T23:01:17.9836592Z       |         ^
>> 2026-03-17T23:01:17.9837750Z ../example/single_file.c:226:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>> 2026-03-17T23:01:17.9869585Z   226 |         pthread_mutex_unlock(&single_file.lock);
>> 2026-03-17T23:01:17.9870081Z       |         ^
>> 2026-03-17T23:01:17.9871240Z ../example/single_file.c:239:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>> 2026-03-17T23:01:17.9872595Z   239 |         pthread_mutex_lock(&single_file.lock);
>> 2026-03-17T23:01:17.9873056Z       |         ^
>> 2026-03-17T23:01:17.9874265Z ../example/single_file.c:241:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>> 2026-03-17T23:01:17.9876020Z   241 |         pthread_mutex_unlock(&single_file.lock);
>> 2026-03-17T23:01:17.9876497Z       |         ^
>> 2026-03-17T23:01:17.9877854Z ../example/single_file.c:252:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>> 2026-03-17T23:01:17.9879416Z   252 |         pthread_mutex_lock(&single_file.lock);
>> 2026-03-17T23:01:17.9879896Z       |         ^
>> 2026-03-17T23:01:17.9881050Z ../example/single_file.c:259:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>> 2026-03-17T23:01:17.9882409Z   259 |         pthread_mutex_unlock(&single_file.lock);
>> 2026-03-17T23:01:17.9882862Z       |         ^
>> 2026-03-17T23:01:17.9884018Z ../example/single_file.c:273:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>> 2026-03-17T23:01:17.9885354Z   273 |         pthread_mutex_lock(&single_file.lock);
>> 2026-03-17T23:01:18.0387503Z       |         ^
>> 2026-03-17T23:01:18.0402115Z ../example/single_file.c:275:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>> 2026-03-17T23:01:18.0403861Z   275 |         pthread_mutex_unlock(&single_file.lock);
>> 2026-03-17T23:01:18.0404573Z       |         ^
>> 2026-03-17T23:01:18.0404979Z 12 warnings and 1 error generated.
> 
> Aha, I bet that came as a result of me boneheadedly copying this from
> lib/util.c:
> 
> #ifdef HAVE_PTHREAD_SETNAME_NP
> #define _GNU_SOURCE
> #include <pthread.h>
> #endif
> 
> Will fix that right up.
> 
>> And actually, the Ubuntu build also fails
>>
>> [12/109] Compiling C object lib/libfuse3.so.3.19.0.p/fuse_service.c.o
>> FAILED: [code=1] lib/libfuse3.so.3.19.0.p/fuse_service.c.o 
>> clang -Ilib/libfuse3.so.3.19.0.p -Ilib -I../../../home/runner/work/libfuse/libfuse/lib -Iinclude -I../../../home/runner/work/libfuse/libfuse/include -I. -I../../../home/runner/work/libfuse/libfuse -fdiagnostics-color=always -fsanitize=address,undefined -fno-omit-frame-pointer -Wall -Winvalid-pch -Wextra -Werror -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -fPIC -pthread -DFUSE_USE_VERSION=317 '-DFUSERMOUNT_DIR="/tmp/libfuse-install-wwy0ckA/bin"' -MD -MQ lib/libfuse3.so.3.19.0.p/fuse_service.c.o -MF lib/libfuse3.so.3.19.0.p/fuse_service.c.o.d -o lib/libfuse3.so.3.19.0.p/fuse_service.c.o -c ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c
>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:400:19: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>>   400 |                 sf->allow_other = 1;
>>       |                                 ^ ~
>> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:473:21: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>>   473 |         sf->owns_fusedevfd = 1;
> 
> Er... ok.  Debian 13 gcc (14.2) doesn't complain about this, but fmeh,
> I'll just turn that into a fullblown int. :)

That is exactly the reason why I always insist on running test with
clang, it finds a lot more things. Next step I need to set up in tests
ist clang static CTU analysis - it likely would have found the CVEs we
are going to get today (non public security ticket in github, sadly in
my own code.).

> 
> Thanks for dipping your toes in!

No problem, maybe I can convince you at some point to create a github
account ;)

Please let me know when I should pull from your branch again.


Cheers,
Bernd
