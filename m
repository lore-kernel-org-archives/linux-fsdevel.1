Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795871001;
	b=BUo/JQeRYjxVgwtpyDlK1DbA3BNIXLIORPsU1nwXQDV4DAnCFQZvEZNM8LI5Hv2Y9yFn
	 0MCbiEZ4roTmSlK49xJ74cnMAOygfIn74HVbvXdY/8QCGjzxZPztxMwGFQ5rrjYUjGze4
	 2v07LB6YPscNrVtUmKq/88C/8a8oQaGzLHbbzvOG/hZ7WdweWwc42BTa+jIFluNZtBjKA
	 MH3a9Obj0cICv5pQ+7i06dgqXLtDQ1g7HHegfVW1F1IhWOxkTAyBy0v4bRneebZ10M0Lr
	 XvGobngqI5d0oTXUjM10fYhTy/+WZpbyO2+UbIBXYXDYkbcNeId02IIVCDnxZOWr6Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795871001;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=+oVLPe9ZN9J01nn+pU3kY0Zcgk6F9gECkd7bjEZ7suU=;
	b=0gsbow2PhVLErn7g+ZpbhIcpFhuoLFzv5XRWEgOx3IzUQsKOlq0gJIynmeeEaxhxU059
	 hPbZY4zGdXt8tSMW/JPBGdIt0BXufC1utmOHfI3pdP0DP1m53/duOb7KQYE2wDLX94G4i
	 sEJ/5lLCbRg+eZ/yWK2ThhtxxzshwNA+yBtqGdjh7Rinr+wZrEGnyCAn8iKC4nJJHZbqe
	 3u6Kkk1Ehu1qaJZxUGw+4R0i/imCuEdwj9/5CQzJr2lko/1blzD02qiKCzUARXo3yJnG4
	 /kfeodfNkSNXuDIGJpptr8Zd6V1B6hzUi9zmF2bGRfrdSRWQZ1f4NQJay86zCsH/E9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tuxera.com;
	spf=pass smtp.mailfrom=tuxera.com;
	dkim=pass header.d=tuxera.com header.i=@tuxera.com header.a=rsa-sha256 header.s=selector2 header.b=hRx8vDws;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.73
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021073.outbound.protection.outlook.com [52.101.70.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA2606A31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 13:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08DA2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tuxera.com header.i=@tuxera.com header.a=rsa-sha256 header.s=selector2 header.b=hRx8vDws
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHTT8mGCjjKNErwwGY0FA9Ky7l2E1idNNFxbpSP27aXlgKWj5GArPOOnqyLVOAPShwU5+otbhUaOa/UE1enhLVndtjUE6DDIcajx5hpNZrETR8TGZfTafeKl2kfywfSHR2hVniOGoS2ab6iErj95tHeIKpy1KiRYOKc2CwaEFIEFw46ZEu7JvnBUiegvN8Rpdy1BNAbTRJh9ezUNLi1GvFgu1eRzo0Rurd29xJhXYT/oUy8Vd/BNj7fUyqawGwkvqmSelSTIjV1uaeC4nP9IXq/q6A5trGLQg4cI6ITBj7XV6WF1s0pN7gmHfuGlYzTPjxL48Y/XmwVpGjAtBZ0nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oVLPe9ZN9J01nn+pU3kY0Zcgk6F9gECkd7bjEZ7suU=;
 b=xd1wn6iMjxZelbVgIMfHxq+tJ76dFqmxgdSVmNLCvD7TcNn1Nr4XFAoYqXcseMfBtLLKLhI7awu3usQAveBr4+2s/HErq4786i/+kDPgFAZ0lA8QBhHrusgV2sUTVOHXxKv3oHwxu6WV9UWkPJ/9rHX9dQq5IvgsmSB4z39EYhjvVN5343k0VMqI8sLxMt/AqCB+OQvSL0z1GWvMda8DbHC2fDpSOheJL+3X7HyOkJml0FFgYK3Fx3Fwz43PHvRTa3Vn2bg4vT/a7qpZii83ksxWCKaJu5BuEVVtWZhcroAadNtaRd9TDP0v+atg0Uz90+NiMKb/Y5LVJP4VFQpD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oVLPe9ZN9J01nn+pU3kY0Zcgk6F9gECkd7bjEZ7suU=;
 b=hRx8vDws4xji95uB1XJowTCA9TYiMv1pskPN/RvegdQCiyE/y31byWo+KTSNPUZ1o2pYJXh4zITCgv3nRo4hxQtSTYiO9ckKFBoWc2wIhCihvtGcQdHtTGVCx/dQZvzlNXPJYHxutpzoXacfveEfjThyNG5GXQUeZ7z1ogwwaUvkEwe42Qtgq5gBQjxJp8FgadbEz+H1SCi4uRsaKPay7s5IMFi/+8odYwWHomZksZMK+wu8qbnBNom1bOF7V81JbqPwIEVoiIL0OSaftIDZO5zn2Aqq+imM8nS+y8WlO3lu/bpY/tcstb+UD2dUF5Qed1gkRPrpIz8t5FELrKlG5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from MI7PR06MB643805.eurprd06.prod.outlook.com
 (2603:10a6:290:103::6) by PAXPR06MB8304.eurprd06.prod.outlook.com
 (2603:10a6:102:217::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 13:03:17 +0000
Received: from MI7PR06MB643805.eurprd06.prod.outlook.com
 ([fe80::c71b:903f:aa3:f0b4]) by MI7PR06MB643805.eurprd06.prod.outlook.com
 ([fe80::c71b:903f:aa3:f0b4%3]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 13:03:17 +0000
Message-ID: <89f4e427-f31b-41d3-a057-eb85deb6a216@tuxera.com>
Date: Sat, 28 Nov 2026 15:03:15 +0200
User-Agent: Mozilla Thunderbird
From: Erik Larsson <erik@tuxera.com>
Subject: Stable version NTFS-3G + NTFSPROGS 2026.11.23 Released
To: linux-fsdevel@vger.kernel.org, ntfs-3g-devel@lists.sourceforge.net,
 ntfs-3g-news@lists.sourceforge.net
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0003BF37.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::625) To MI7PR06MB643805.eurprd06.prod.outlook.com
 (2603:10a6:290:103::6)
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
X-MS-TrafficTypeDiagnostic: MI7PR06MB643805:EE_|PAXPR06MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4580ef-89aa-41d2-42df-08df4d4ff803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nn+qRDfdAYuOGV2dBQa7Nntvv37dfjUv+uBYj4K/W4mEBxRWQ5Gs11Hm2NhwzpkuuXELcwK7OpTy2hMqdf4sv9r+Ztmz0/4SqZvsBw36esPgfcmoYBPndeKDtgpcLUYigJ0qrv+KyabBgOg+Fc6rPhBSF65TSSqkzazB7ryoVLMJnVfcITsBgHaLCzFeHRt4yH+bwdeoyjjbCrz/08ii5zQp+3xvdmJQP3JhyQUHN9gv0GINxctrpUZ3Omh5hsDOSbDs2hblBh+wJKTlAhPkSXs8CSMVMrRHfGIsc9kPTHa2XqD7q9NTkyOCc7hCG3zltdrFT2UvP0Vw1TITLbw+j/XXjzIYH9PR0TVA3YhUhN+UPLSw6Gi/QPqArDT0fko3MgzaeF0b4yN/+D7bOqd+HvI+ESRVr5+2n47IYkYeXVVXrpmW6SYALWhevsfQgs1UD6RzT6jsF8Smcy4uOoCexN6En0FwMH1D1ZhZlBT4HuPzwqXkNqgsLSSBfo94ptA9/MJCt54R5159+eLax7lwYWPq0lP15DAVRNdn3+JljSb66o+Qx8FZPBxtaE7bBcIyqyhaTF5igYX4HNSDDmfGMaPpl5Wsw5MmWmnaKqlHKcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI7PR06MB643805.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0Ixa2dWOG12bWIxRGljQ2dWaGlLMnRHVUVkeG9HYUx2cUoxY3lNbWhIc2xZ?=
 =?utf-8?B?RDFIK1pnTVpDMHc2MVcxbWVHdmlHSzUzWTJ2S0FBZjk1T0huWGtmTjBKd1BT?=
 =?utf-8?B?bkcxU1Vld0ZoTkkxLyt3a0U1K1o5MFRNc2NwSU5xZk1VelpFRmo0MFhWYUIx?=
 =?utf-8?B?dU01N2JTTW9neXB2c00raFZWM0J6aDlvNkwvWnRKb3YvMldSb094UFdKYVE0?=
 =?utf-8?B?VDhscmxtc3VzOWRzcjNGVW9lS0dGV0lTS0ZFNitYd2xsTWdOVDI1VW83d0Vn?=
 =?utf-8?B?NHoveER1ei9sNGNUdTJhN2swWkczSEdBaDdDYlRIZloyRzNuNXVGSUdncjAv?=
 =?utf-8?B?K1J1dzgvYUkrYWxWWE5Md2NVc0xVYWxJdmxJMmh4ZjgzWit4NExjd1dDOTIr?=
 =?utf-8?B?c0lQUVIrczBENzZlVitQb0RMMGs3RXpkdThJbU5WNkxoUENxdlZKR3l0NWov?=
 =?utf-8?B?MHJWWlNHWVNpZ0dSZzNjNVVRRUE1enB3M3J1b3c5NitsVlJWMDBuYnJDZmZs?=
 =?utf-8?B?Z1JGRUM4cU45N0FpamNNY2dVbzZ4Qy8xaVlIR00vZWxBTWZLb1RaeUFRS0hK?=
 =?utf-8?B?VWlJSlNGcEdabzFuUk9yM2NrZFhjLzdZM1dtK09ha1RMSG43aHE3ZUxrWm5r?=
 =?utf-8?B?NmU0cG85eloxbzNXQkFHejFvOS9hZW1mb0tUYnU4WktGUE4zYzQ5Z01xK2xi?=
 =?utf-8?B?di9yWU05cUJ2eFAxWjhUOC9aY2c1NkJhaGd1cWZ2ZXRFUmJHaTliWTNIck1C?=
 =?utf-8?B?K1o2K285MmUzYkgwSVk3c3lUa01tb0Q1SlQvTnBOU1JxL1o0TUdwdVFkLzkz?=
 =?utf-8?B?MGZUVVBNeHV2K3ZnbE1JaGRMNDd1VzVNSnB2WDdOdSttU0x3alFUYmhVL0dS?=
 =?utf-8?B?N1prN3JOVkR5OGhmQjZ3U1J2Wis0dnlUTFdwVXo2KzBoUGZiTUhpTUdTSkl0?=
 =?utf-8?B?TEk3ZVlQaE5wTVhGd2pCekdweWM2U3NpdnJNV3pYMEcyREU4a3RJYk15bWVW?=
 =?utf-8?B?bm9VR1I3ampUR0NSVndXZ1d6TjIwSmJhVit3RmJlVEZycW04RFgzalhzcC8y?=
 =?utf-8?B?RzJtK2tVY3JDSEhPNitYTmtMOWc2eFJSamQ5TjBWY3dMbG54eGc0dE5WVnk0?=
 =?utf-8?B?Q1FhSmYzZUhCZFBwQU1yMmh3Y3JiYUZoSjlOU2lJdHlQaW9sa3FyMGNmdXRW?=
 =?utf-8?B?S0cwZXJmNVJqbzNtZG1TY2FOdmpmL0JkVFhtdXZjdmhlWmR2S2NvSXVYZm93?=
 =?utf-8?B?NE1rVjZuaVovUXZObGZtZzdoSzc2UkJjT2VodDdqSVRQZmRVbXNmZ3FQV1o5?=
 =?utf-8?B?Tzg5dlpCbTN5a3ZDd0paUHhvSEJzRWNTZ0Y0Yk13dzNaUmdIMm9CTE1tNWRG?=
 =?utf-8?B?WHlhMU9ZdlI3NDJIczBTMG9rRzJ0OTNYRnNlSksxUXRGeWxqMklmNTl3bVA5?=
 =?utf-8?B?VDlwaHh0dXhVbXdZNFJFUWNNWmRiTVFad3oreWZoZ1IySGx1eU5ESDFOWHBq?=
 =?utf-8?B?SVJnaU1UeGY3ak15VFM5LzJGUURTTUZycnZVTXJIMjhrTWkvTWQ5My82eWRz?=
 =?utf-8?B?WjRGd0UzTmQySk1lZVVzRW5PZ3VBMUhhWFhtYUN2OWVrS2ZtYitzNVFSUzR2?=
 =?utf-8?B?N0FUZUVod2N6bjllZTQwKzRaQkk2V0x2NktLWUp4d0o2U28yUzBaUWJaODVa?=
 =?utf-8?B?WHl2ZEpHc0tMVDFrbUU2S1BOVW1Wb0NDM3owWGlaandGTDB1UEgrUEtHbFlW?=
 =?utf-8?B?L1F2bzlxaHZIb01RUTFHNDVaQU1iTWNEb2hHUTlwdzVtb0t3R0MwS2hQVXJh?=
 =?utf-8?B?UGJrRW9WN2o0SUJueTVZUXRpWEUvMnBwTE84QW90UU1CMmsrWndFSE9rRjFL?=
 =?utf-8?B?akFTNW1BVHVKa3BnRXVXSGVKYWZ0dFBoL0FtRHRzNjhIbVRYeGRxcCtCbHN3?=
 =?utf-8?B?Sk1wMnhOUDhHOFVYd0JLdE13b05OMnVHY0IxSHZ3cmhJa2dKR0JqaHo4SUEy?=
 =?utf-8?B?eWJhSFZ3T0F6TkYxNzJ4VTRTSGNCRlh5MG1NL083MURTUjUvdlVOZ005SVFi?=
 =?utf-8?B?dUlINEpXTDE5bXRIV2JNOFFrRytHU2ltOFMzUGtsaCtTZUlpN0RtQWtOZzA4?=
 =?utf-8?B?TS9PQStZRFZBb0syTWZLeURpUTNDaEZoc0tXSENPQWh5czV3NWJGc2RYZFNi?=
 =?utf-8?B?aDhiVldnaDdHd2NzaExxbmJkSG5MT2FncTRpczdzWnZDaklMdDE2aC9iS3dY?=
 =?utf-8?B?d0V1QTdqSnpNQkNmRmJ1SGNFY2NZQ2xNU09YTUdxN1Z1S1Ayc21rWi9sMzgv?=
 =?utf-8?Q?EQfoHxZWyuCdABo/S4?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4580ef-89aa-41d2-42df-08df4d4ff803
X-MS-Exchange-CrossTenant-AuthSource: MI7PR06MB643805.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 13:03:16.9491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClefgRXAR4VWhR6xf0Fx+/UeqMqOesCAK2jpGSCNc1yxSxCGh9AJfo4NkzzdQN7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8304

Tuxera's NTFS-3G team are happy to announce that a new NTFS-3G stable 
release is out, version 2026.11.23.

The new release of NTFS-3G includes important bug and security fixes and 
includes support for more recent versions of libfuse.
A list of the fixed issues is available on the GitHub release page:

https://github.com/tuxera/ntfs-3g/releases/tag/2026.11.23

The full changelog is available at:

https://github.com/tuxera/ntfs-3g/wiki/NTFS-3G-Release-History

The new release can be downloaded from:

https://tuxera.com/opensource/ntfs-3g_ntfsprogs-2026.11.23.tgz
     SHA-256: 
827f909955c4c2ae549f431617ded00e753adcda7e2feb5a33d70904e5a197c9
     SHA-512: 
dff57ca33edbfac9f77decee79bc763602244f84ba5a5f2b17003c8436bb1b9f8530bc549e82df031721b9cc05bd0ee048d57af3ce3688f9ee1c3c215ad5dddd

The source code is also available on GitHub:

https://github.com/tuxera/ntfs-3g/tree/2026.11.23

Many thanks to Jean-Pierre André, Rakesh Pandit, Emil Thorsoe, Rostislav 
Skudnov, Eva Rio, Ashok Galla, Szabolcs Szakacsits and many Tuxerians 
for their contributions to this release.

With best regards,

Erik & Tuxera's Open Source Team
