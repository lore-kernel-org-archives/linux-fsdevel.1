Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC83CAE73;
	Tue, 25 Aug 2026 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787685951; cv=fail; b=C/ADzzBoOIuSUFsBFyFl3nwvSTSXKVLgTqIdHJnZ1PZ/I2LwEXj7RLzIlD2rVOooSCoXz5T1gAYEBSXM/txXVH14nsY5ns8oeeE8iNAcupb26aw3Tu9hVz424oUq+0Wqn4lFXEuVwRRnqJGFtR7gpYxKwyfBSfKSmpbJQZ103Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787685951; c=relaxed/simple;
	bh=T21wiDCn80h2mM8W5gUNwLl+CNZNsmajVMvlLOvGwDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OtbdjNL7W6LTcYpq4wnMddWO+nxCKZ7CwLDwMdVWIsdBWrv22HwSb8ABeHLsJGl7LW2Aom8fTe54yoINXjUosRj7kVF6JRJweYC2hToDfvWZGGLfe6YKwCSFaL9wxKeI9Gaz+qmkiKGXNeRlyha0jw9ANWzpZMi5jf4grn1p7bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ke9JxNbT; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ke9JxNbT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tefjC+8pEi8sc5DJH461iZjpLPJY89+tWCn9yxlsWnMpGS+W+wV++e2dzHhGm3TQNnAMy1QsMCV4OfmB7/8W8CvzLogi2RJMe+GX9AIvaKSLadrO1iYynvvESCiFKeVKuwv6jbOnRxm291nKrYmcc2ItI+LI3SQ9cnUMKrZTcOkxfFrdKZUXVliTHmZ7h4R+vH7y9n/UldhYuJFK3xZebdqeV70ax6KjDv0PKHQcTw/ItR25FY5GDqZsCiINmDpEwN4X0VIrj3tvyOR97piTjaDtOjwG0U8fPLsnSiYr5YX0hgn65blEjILi3Bx0TS6e9JQ6i9oq9u0O6/XZxxwRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5CS8y+e+DlKSGNeytOLevEntZk4Lx89uhKp0Qr/LAQ=;
 b=IQYz8h4cI13nge3MmzV5DEdu96AFT1xwRoCV9iHkbLDRzpP1jbcOFXiLfRBnNSeJUTCwTdVvRzr5fDP7c8cPZHAg/BxvTfHrbk3KK2bHp2DL1IhT5uWZvpa1IMZh0B88V30B66tff9HnjWDT/7nupfRn4bpXFOX87UobdL0PtVfUaaEoy0WKRZB9o44gUbK7NACJOhgx5D+P/Z9SpgxcHSF0lltcCEhnhpP1QN+DMMiwDCW97w+JFXJPh4Xh/1d0LxK0VhMclQlv0QrS8v7C5BmfauBDatD2Rk5YhPNP8wmTJXPjKSk9ziFqXLW8bR1EjJsdRxI3cchrtgn9XFgvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5CS8y+e+DlKSGNeytOLevEntZk4Lx89uhKp0Qr/LAQ=;
 b=ke9JxNbTtxOmTqFR4HPh6s2hTfx/JVnyA+G94Q+zDobrbbCPq87b+jiWCfAmN4rbyvkG+zQr+wdwPAjc8mt++YeWJtSMj6HrFDR106VspoqL0JtwrY1FzoQHEJxj4mdi/3YN/bBvkHH/JaKlFxDDtj9+rmDO53wjXZHFlZ3t5ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) by
 PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 25 Aug
 2026 19:25:46 +0000
Received: from DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c]) by DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c%5]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 19:25:46 +0000
Message-ID: <a877fa95-4cb4-44b9-b123-5d9084fa4e65@amd.com>
Date: Tue, 25 Aug 2026 21:25:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
To: Punit Salian <psalian@google.com>
Cc: michael.roth@amd.com, thomas.lendacky@amd.com, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stefanha@redhat.com, vgoyal@redhat.com, linux-coco@lists.linux.dev,
 x86@kernel.org
References: <51a316c1-4654-4f6f-92ff-84c310cd604d@amd.com>
 <20260824175817.483800-1-psalian@google.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20260824175817.483800-1-psalian@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To DS0PR12MB7771.namprd12.prod.outlook.com
 (2603:10b6:8:138::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7771:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: fa94e69d-ad86-41e4-1a01-08df02dea938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p1oeG0tihceg/TJY1cT9h39zdy4hxYzdDP2USLrGPtFLXYhwoiHGNvTyOXXLbpBqtFnMz/k+RNcaQZElZe84ZqKGi5J82OsT0jm89yXHKME+xaGB53ENmD6nZJDdD8vxgaT0qoI8NIW98sj20SkFNsnuay62IduoBaqtNfpF0m6ADWggJAURk9qgyq8EUPcrGJvVb3jlq7EdB/EGNfzGRXMU4AFbODeWg+oD8ispX6oYtKM4PMHSTJpBfaXRCv1HtSIjTmTjMTIMLTwRfpyGAiywidhl79B3lsb3Dvr7otZTCcsUKKQUPw+GSZ9qAi4rkX1UGlq4RKsLOO/9HvldHOhXCl/dw3rZYrElRGXhg/anTvlrm331mIFgxwMoaRYT9YwL8bz/7Z6n2cgVvM2fESTD8qdTHwjBux71/+aUzTzfAU+gDo0VyjDrpyhZNDUZRQi76YKkzihhF8ZRPdxcq7p/yyW09DQtNJvXOO33ba3nEidepra8F3GepR/+ZdWgIgKxfvdBhTa5YbcA3ra025AOVhlpeRgM+KwD+Kwhqz6RD8s7SjsjRJoa0Env0MjV6gAbvYNiTsPljUAEipMel+FGzFRGpsTFwvixpDv17T3PuMGBunKgWCSblDF0qlM4TkLggze0KbTjOCWNwP7UDg02imua1t534Qlkj1SuC6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7771.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzUxVDU2aHo3NWE1ZHBhVjdiTFFHUUFNOGhTS2RVNmRHWGRQOUZrUStTeGdH?=
 =?utf-8?B?dXQrOTdGQVUrdlcrbG1qS1Zjdi9aWldBQXE3MjVTZUpzRGNNd1IwZFJlbHhn?=
 =?utf-8?B?V3oxMUNtZUZXcGszZTBSUEVZaDVLU3pqaHJNM1FTVnhSMzB1ZWhiSE9scHhE?=
 =?utf-8?B?Q0N1ZHlyTkkvRTVVNlRHVXBwSWJMUnNORGMyMnRYNUVEWkFBTmJlSnlydDNW?=
 =?utf-8?B?U3NiOUNCMDE1YW03a0VkMERIMG4rNTJteG1yNk03YnUwRjhUdEpMTnZyanpG?=
 =?utf-8?B?dGZtTGdrQUpaM0NaU2FCL0lEZHJicXVWdHBqS1I3SnN1SzZkQUZzK3dhOUFH?=
 =?utf-8?B?dmVQbFRPMmY5eDdic2ZVRlJSYlN3YnYvOUIwZWdlLzA4ZUIvYmhFZDlCYkFZ?=
 =?utf-8?B?b1dTRjB1MXpudjZhVXM4b3FpQU94bXZ1OER1RnBpdmRzY2ZpaTNYMGE5QnF3?=
 =?utf-8?B?WDR2U2dqbndoSEl6aFhtZFNoOStlTy93NE5YcW4xZXEzSnN2QnZwTjRscVBR?=
 =?utf-8?B?V2JhMklNaExsKzdjUUROYlBPTmZkT0w4ZXhtOVhXaDZjL1VkWjZQMHBVclFJ?=
 =?utf-8?B?bjdydU1Ccm5rRld0Tis5MlhIZTk1b2NhVkUzSzV0WlRhcXRtdnRjL0JYMUdB?=
 =?utf-8?B?TVQxUUsvaWZEa1UyS2twZGhZZlZOZGNHLzBFOVBXdmh0MWtkSXVKR0hBS2lx?=
 =?utf-8?B?T29adVhQcWhvRGZRR0NDdW5tUVZMWUYwS1doWFZsRHFLYXVKbUVzeGZxSHJO?=
 =?utf-8?B?REh3WlZZK09CeWJpaTQzSWQ3c2dZeGtZOHFYYklWWk9qbXJpbU52cmg3ZjJE?=
 =?utf-8?B?RzBtOXNCMC90NlMyTWVad3hMWGltcEdSelM1eTVTS2p0WTNZM2FQQk5FQ0Uv?=
 =?utf-8?B?THBoUlR5R3ArV0dzblg3djdaZCs1OU1WeGVqNkoxMnZFbUN0MUY0SXlneDZF?=
 =?utf-8?B?ZWpSbEl4eldROWloM3lHZExxMXRhZm0zVTd0WUhpc3d5UWcrcHc3TFRSd3VD?=
 =?utf-8?B?SmptZ3lxeXJKU3pwUUhGVDNzQkgwZzNDb3BaRWNiTDdGU3k2eFNkWGJCNnd5?=
 =?utf-8?B?bXAyNlhROW9zbFVOYk1QdTY5VjJQQ0NxcHBRV3NWZ1RkUzFtcm8ySjBIL0lC?=
 =?utf-8?B?bm5wNG4zRkZ4Mzd2NzBjdkY3UWJkdHNTclYxeEJ1NWQ3bTM1V0U2WnVnQTN1?=
 =?utf-8?B?b1RMck9zNjR0Y0c3UUhSTm1uZlFVWjNjWjU1ZkIyb0p5N25nd204OFJrREo3?=
 =?utf-8?B?cW11QklUMnM4UER6U1ZhUFRiM1F1QVQwekVCa2lCV0Nsa05SbjJpL1hIa1hI?=
 =?utf-8?B?T0hyaGcyT3RFY3NBcXovUkQvTXluZUN1VzB2S3M0ZzYzYlJCQWdvaUVpbGZx?=
 =?utf-8?B?bDA4UHBhYTU2eW1hNjNjM1JKSERhajJ6eXZYSnQ3YXhBeUlWTWNGSTBsOVNM?=
 =?utf-8?B?VDNSQ21Ga1RrTFVGamxhOVNqNHVlRHU1R3A2Wm9DWmdpQzFybW1nVXZRWWF5?=
 =?utf-8?B?alU1eWRUY1RGUkNCSi9jaUhwL0kvRHhpRUxkWXVHNWJYWEM4bnM1WjlIdFU2?=
 =?utf-8?B?eDF5Vk9MdnNxZU0zdlo4NDBISWFEQmJwOWhuTlFWbExNNm0vMmVaaUZaQnI1?=
 =?utf-8?B?aGhjeGpORzUrRWR0M3RLZVR3SC8wMmovbHd6UVZvVXRFd0VDaGdaQU15MExD?=
 =?utf-8?B?NlUzWTU0bkd1MnlSeGlIazlhR1huRmlQQXpGTjVpYjhTSk5DM1A2em5PaFlz?=
 =?utf-8?B?M1A4SldaanR2cGIrNEpZOUJLQVhzVDdXQWJRaHlNNU9kRG5JOEtnZ1NDVEp5?=
 =?utf-8?B?aGxoYXZsWWJ5aEs0Q1NOMm5WVnZHWmJTSVJYVS84ZURrdFBwbHFERFpqdmlL?=
 =?utf-8?B?Q2xFSHVDN1A0a0xHRTdMRjBjUkhCL1M4N2F6cG11OXYyT1ZUc0w4MFY0MHFN?=
 =?utf-8?B?ZlhhUlhTV0I0QWFaTm1iSU1PZFUxOGdFUVJmN0d1Ync5Qk5xQXlMSHJxM1A1?=
 =?utf-8?B?OHlVQzVSVVIzRU1SWUk2YVA2VHFLcnJwZTViRFRCOVNrSkY4N2RHekd4NUtI?=
 =?utf-8?B?dWhZNDRJUTNkcmhpYzB4YWhndy9FMHVMTm5FL2VaV0gzUENpVHdHZTUwSjQz?=
 =?utf-8?B?OXZsVnM3RkNPT0wwZzNuNGxyT2ZuOVIrYytQWWRvaVlvOTNRaWhyR2JRMzlh?=
 =?utf-8?B?Y0o1ZmhjeHlOR01zRTUyOU1oSUhkUlZaSEQ2YVFhck9GTlhhWkwvUDk2VnJC?=
 =?utf-8?B?Z2hiOEJoWlM5Vmx6YjRNQUlRa3VtVEVDSWhlcTBZbHN1WW15bWFFVUd4ZHdZ?=
 =?utf-8?B?YmZnZ0RzelIzdEVYSnRmbmp0RXh1bXp0T0J5MWhtbm5XcWwrSEl6UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa94e69d-ad86-41e4-1a01-08df02dea938
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 19:25:45.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rcsUhnSb9/18/w+g9jDlu7XIvoFSn+vt1uCk3Vx6CV/db++cITUNxv3U+76eTFkLMBdpiUl0CYwVPrSJYWBmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

Hi Punit,

> Hi Pankaj,
>
> Just following up to see if you had a chance to test this patch on your working SEV-SNP setup. If everything looks good on your end, could you please share your Tested-by tag so we can get this queued up with Miklos?

I tried to test virtio-fs with DAX on Qemu, but could not test it. After 
a brief investigation it appears virtio-fs DAX support is not present in 
Upstream Qemu?

Thanks,

Pankaj

