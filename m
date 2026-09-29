Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023126.outbound.protection.outlook.com [52.101.83.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA923DA5DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790657003; cv=fail; b=qiSeE8atmFrjMocvAxkdWNfHM69Fs0giosuRZDhCfjwUuxrSrPYzfDQMx/JxeCzQqWHj1U51qBY6Xkv/liDrV2Orb30+fKhI/uV0z267khT8yX0JqMgPdeIzTc4On8B7qNwFtcw3K941+9eG4A07objPGrlU909Hxx8Ybls9TZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790657003; c=relaxed/simple;
	bh=nHGs+6mD/hnnVUX0wV8cbF2/36PTiCVnh1OaK2MGOuY=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=tqpO64NsqlWTGfqpzzqC1VMkPQpSu7b2p+0XxJInpO6mDE+V2j9VwNNoszwbw6rZUwsEm29s6LW4Z0/9xOZY940MH+SqZsci5tMULGY1qMCNnjNwrl+v3yzqBwltnEG2HHJa5oU4sw/pDIYTp+kLgXue5lRpxwh4JYZHxNWG2cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=fq5Ui5GW; arc=fail smtp.client-ip=52.101.83.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="fq5Ui5GW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4D9UHz639sEMDaqhcjsbYFgKZLqRcE9EPu86dhnFYVd+M/sXQDtL8poU+zR5ZQt41LJnU8LSHmNbKiSAuj+2pxw2Ul5CMXqkHvegq2QjbkOGxL0S/L/vneTecRQmX8QNVR+mNmyE1BAibGEuOhnw/kGSZMcbDtjEWfCIxU6wOH0Xpk/ezFcMaTEPk0iV0d1SXlOSSytASyP8Y0kaY1+cgyvPd2LhpLWVsq+FUvMKrb4P60EwS6HiT1vlUtpyq9gXNWZJIvVWYflYGcXO5n8SrAXgcTfh5Aly1kFOCZFn+L0dpytZR6kk93CVpkZPip/Y4I8/rmiEXNJK+um+E7+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHFiUVpc7nwBvhD/WzCu+ehJiMcJlyX9bvLs1QxVddM=;
 b=LXophB/rrP6mmVpIRlMGOz20wmRBKkJyc1AGoZCiYUBh80s3jZJf55eI4iX5ZaHgxVrw4g8cGH9EnU7pIkEM4QLHMb95rbOyOolFevOuH3FiodOyeauQKJaO5ehzFKXo8zmwVptlvm3GBfnne95C7GEQZQe4ogQqzE9Rh5buRbknIKnlyMfJB0BBbd1znD/UriOtpJgkuGI39ojLPDf/BQYWWQP5v9FrvRgQ3L9Hj8phwgDImrNYUC66CjCOO2RlN8auZSTZmnHXUjPApor0H6AA29PRB51wBbt1rWaSeRftwmFPbn9nhew3l9LVdOPGY29AfebT0bdcvdzv8FW6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHFiUVpc7nwBvhD/WzCu+ehJiMcJlyX9bvLs1QxVddM=;
 b=fq5Ui5GWezuzUq3VXUEBgnsA6sVJFAQD4d72haPq22nacKm+d/F3Lt/dHpfoXlhMsym8lFm3m6xIdQI4nsEOeT7xNIHlXKeMjZuGhFdcW3jIMajWwiszKDq6TlU0IAYEozXe0g0JqpvFL7+47xUDaoZDBNkSR2Qp6ml2iy2LvUt5ZSzmkqtrtxGwHR3vcan7T/qZ0vD8v1s8dyD9yVkSpzeIC5GKRXk2bruCoiLpqUi5r3hP5yodwvx4fsqPBShsGkpCI+T9ZLJN+aVhZbl2VZ6lJmJwwcflxc3I1IK2UYcgSpuIVrZQ06kfhw8XQQrC3364JC+dOl+e4oJuezTZCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from MI7PR06MB643805.eurprd06.prod.outlook.com
 (2603:10a6:290:103::6) by GVXPR06MB500966.eurprd06.prod.outlook.com
 (2603:10a6:150:3a9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 04:43:17 +0000
Received: from MI7PR06MB643805.eurprd06.prod.outlook.com
 ([fe80::c71b:903f:aa3:f0b4]) by MI7PR06MB643805.eurprd06.prod.outlook.com
 ([fe80::c71b:903f:aa3:f0b4%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 04:43:16 +0000
Message-ID: <205bba77-a19a-4463-a1e2-fd60bb2abbc0@tuxera.com>
Date: Tue, 29 Sep 2026 07:43:15 +0300
User-Agent: Mozilla Thunderbird
From: Erik Larsson <erik@tuxera.com>
Subject: Stable version NTFS-3G + NTFSPROGS 2026.9.28 Released
To: linux-fsdevel@vger.kernel.org, ntfs-3g-devel@lists.sourceforge.net,
 ntfs-3g-news@lists.sourceforge.net
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::11) To MI7PR06MB643805.eurprd06.prod.outlook.com
 (2603:10a6:290:103::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI7PR06MB643805:EE_|GVXPR06MB500966:EE_
X-MS-Office365-Filtering-Correlation-Id: 58006d77-b67b-4940-559a-08df1de42dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+6ULbWDyqbCXzge4fHMC9rP7FrnILMhfimll+WYvb1vSPSWrDcDT4tB4qem05CuwMOSkRqnsaFAzUCckMoNAlK5hqBj3qIT/twO8i3gx8ePzz7TwZYbrY1RnTGcN3G2FZAvikdMAOu1guxYYxeSP07MJCSjqO1MM01IAKkL+qjUuztH2dQu9wSY9iRihuCBKD0ICc3+/BFay9eZwNOwf+pAmbfeYQv60gP8WSksDl3xwB2hz5FEEfLnGeadjhr+HsQBx32L7xIqbiyEwsO1WKeLz0E/8BWeB6qX77+AzS8gTBv7wH2DRkaKUXp2kXd5tl0XiVlXdFqo6ZNTX3jar/sUD/gok2mIBsVehKrujooDM8JWiUCdD3raFIbaVX6lOmr6+bcFzXkaavjkcKc4sONaJIYVGXikHj3Mg203gkdgsE0jisgmvkrtcPiphmUK3soKFJLZKc303y54CFYFXC6grmTdNmB8kR/PIqD2iu2D3pQ0pDsjPl67Mcw85wFAd92yxsxCMbz6lWnFnZyQZc4Aeztks91GZHjVFr62Uv1JAqnqKIWKx/TdLjjEEWTB8QMUgP+pOzpmY23UJm7O1cWkRmGGD22zkQ8m2zp3nJgmqUP6KlugmbHUsJfOgZ8A3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI7PR06MB643805.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eSt2M002M2pXcDZScFNHODQ1VHNUY1dkeHlGTUs3cjZzK3dMK3VPM3MvOG12?=
 =?utf-8?B?MURzSWg1NWljT2ViZEZRZnZSdEtXdGpsZXFPdDVnY0s1SGk4amFjUDNZTWpm?=
 =?utf-8?B?Q1A0bnF4UFdJcFJESkYvTS9BN0VPc1E5SmJ3Qng4MUpWalJEUHZzZ2ZvVXRE?=
 =?utf-8?B?Mnh0SXdCalBOUURQeXdxQkVHUXpVQVVVNm0zdTY4TmFOOW5BSFZNR21iRkV6?=
 =?utf-8?B?R0FCNU01aEozakdGZ0l5cGZZTDFleStaUk43R3RvUzEwZjBKM2luRisrTkt5?=
 =?utf-8?B?VlVIZlRoNHpUMnVia3VHRUZKdGZQZTlORHdHeGg3K3RQd2ZkcUJtdERVK29P?=
 =?utf-8?B?aWRjcHpJMW1MWTg0UlFzeHpBSEhSWFdVdzRiNmx1V0RYb0JQVEg3c1phV09E?=
 =?utf-8?B?UUw4K1hyYS9tbFpDb2tKaE5VVU5FdEJkcDNzRGFkaFhQRVRqM0dzdHY3SnM3?=
 =?utf-8?B?MERBMnR5d0dnbmVKditYSzREdE9BczhRNzZHM2l4U1l6SzNtcTZ3VktMbCtB?=
 =?utf-8?B?OE1EakhzQ2dEZGFxWlRlVEoxQ1lZQ3NXR0daZWFxcHdaVlp2S3JjNWRneU1P?=
 =?utf-8?B?eU44RW5BY0JjOVJCMm1OdnVQUVJ1ZWVveGw5WlpWckR3SExaS1dnKzc2aGUy?=
 =?utf-8?B?aDB0UXFyemNEbVUxZjBEMUY2V2x6YWFRMWJYRmVJV0JzTXk3NFBBMEpyM2Rs?=
 =?utf-8?B?eXJidU1NZ3FjSmx6S3ZkMHdNdzd0OXVVYTByWEdQZlJsYUZ5bG5FdlNmejJW?=
 =?utf-8?B?V1R6M0o2L0hDNksxZUZ2Q1NORmtJMlAyMXRMbUE5VHM4UUdDb0pybGxIMDgx?=
 =?utf-8?B?dHRTZThQUXBzMEJqWGJpbElyYTFWdHp1S0lJazliNGcrWEJPRnJobEtab2Js?=
 =?utf-8?B?NWswdHpoTWVGRVdVWVFFWWQwYkcyV3cxejRIT2w4Z3RJYWdiYkZGaGVCcWlo?=
 =?utf-8?B?K2Q5Q3YycjRLZjEwZEUrbFhib2J5bkc4bnNwM3kxRDVSNzd2WjhGT2lLVTFt?=
 =?utf-8?B?eUFRL092a2ljVVl0UzQwTWJtVGtFSkdkcXRLTU5GMVpCWTkwNlRLeEQ3MXVv?=
 =?utf-8?B?N0ZJeUVVZlhnajYvTTEvNXA3d3g5cDFQVTlTc1AxcWJlK0MwNlhsSlhDSWhP?=
 =?utf-8?B?U3Y1RjB1OHRDL2lVakxYdGNDZXJ2ZUxpenpva2Y2ak1oUVRTWUYrQksxcHA3?=
 =?utf-8?B?NWJmQnFLMy9Bd2JNNi9CWUUwd3lLL3ppcTlkVGVVUW92b0xibDM0anJmYkNO?=
 =?utf-8?B?cWUyczNQOHF0QUNMbUMzdEZvVWFiT0FNVVVxL21GOXJlNk5TL1ZEcHBQQXN3?=
 =?utf-8?B?WTV5aWVES1hnWWRMZXk2QnljWmlUQTdWK3owMXdxWTk5TEFkWEErNDgyZjdp?=
 =?utf-8?B?Q0xKb0tTL1FLeHl6RUNvY3dFTjg2YjhLOHB1STl6ekVSSFd5NDVSUCtLd1dh?=
 =?utf-8?B?ck1EUll5NmNJdDFjME9GY0pyTmlSU3BIVWorU0RZalUvR2U4NndqK2JmWjYz?=
 =?utf-8?B?QkpNblNYMWVpSWNobHY4eHJVcWdkMUtQSXo4NlpBMlpFMFlpTnFIc2RXSmdC?=
 =?utf-8?B?NmFWQnVjQmF1dWdUL2xSUDlkMUJEend1YzBwaEk1UVFYZ3FhbjhHaUJNNnFR?=
 =?utf-8?B?UHlLck10WWEzRkg4dkhZejUyQ0RlY1gvU0RBSk5PWFc5MFkwZW1aaWhyQ0Vl?=
 =?utf-8?B?SXhsTHZIc2VKZFc5UDRua0lpeURUeUQ3Z1diRmNLbWp6QndwRVZDN3dwamp4?=
 =?utf-8?B?SWJHVUhSenhRSlZMdUVlbWtZVHRHdDBUdzJxTGsxZUY0UnlCK28wQ0Urdk9I?=
 =?utf-8?B?cnlpTmREaExpbHZydWVYZTdhQk1hL0lqY1lIMDNlM0ZHY01aMFA0b25va3Mv?=
 =?utf-8?B?MVlyaWhCUEt6ZkkxUldrY1hnaGx1SEZSVCtYdzdpQjhEdmlQeWQrM1FULzNW?=
 =?utf-8?B?cFdJZkxBYlM2MURVaE1tbnhQeEtZSWZlTzU1L2k2a0Q2Z0NFRTdtY2hFYW02?=
 =?utf-8?B?ZURRcFJqK3ZTVDNtcXpQQi9aZzh4U2k5a0NyV21JOHM2a0twRHgrSlNVMVp2?=
 =?utf-8?B?TUJuYUlCeDJaaVh5WS8wcUo0QVIxRU9OYnJwb0ZUbEhLaXRqRmZNQVU1VFZa?=
 =?utf-8?B?bVRMSjZ1UXh3OUZhbHNoRE1zVUdDRU1aRlpiMmZKU2liVE14WW14T3VNNWZG?=
 =?utf-8?B?WjRERjdsZG05SjV5T2dlVHRQSjFGaDRId20xVmhkNitMVzVkb3ZoenM3aVc5?=
 =?utf-8?B?SUpsaFN6QnJ1YVp4SVZSSmVlRXAzQTc2d05iazhmdkErMFh1ajExaEpGb2Iw?=
 =?utf-8?Q?7Zm2EjGUYDI+B6ApfA?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58006d77-b67b-4940-559a-08df1de42dce
X-MS-Exchange-CrossTenant-AuthSource: MI7PR06MB643805.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 04:43:16.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +USVqJLY8WZM2FhBAjS/u9oiNv2BVwB7PRjM5yUveXFHlswJSot3b6QrEY74EFMy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB500966

Tuxera's NTFS-3G team are happy to announce that a new NTFS-3G stable 
release is out, version 2026.9.28.

The new release of NTFS-3G includes important bug fixes. A list of the 
fixed issues is available on the GitHub release page:

https://github.com/tuxera/ntfs-3g/releases/tag/2026.9.28

The full changelog is available at:

     https://github.com/tuxera/ntfs-3g/wiki/NTFS-3G-Release-History

The new release can be downloaded from:

     https://tuxera.com/opensource/ntfs-3g_ntfsprogs-2026.9.28.tgz
     SHA-256: 
350d9415c59f7c3fa74e23985ad2d56423c6a168337368f672e2e362d8f295c8
     SHA-512: 
9300d38e3dc790506f7d5a14c0c5fb4ff567d6acaaaca7f4a3c3a24beb01c54145135be61363302590d9c65cf26c338d57cf7eb1757c785f5d3586335bc3480f

The source code is also available on GitHub:

     https://github.com/tuxera/ntfs-3g/tree/2026.9.28

Many thanks to Jean-Pierre André, Rakesh Pandit, Emil Thorsoe, Rostislav 
Skudnov, Eva Rio, Ashok Galla, Szabolcs Szakacsits and many Tuxerians 
for their contributions to this release.

With best regards,

Erik & Tuxera's Open Source Team
