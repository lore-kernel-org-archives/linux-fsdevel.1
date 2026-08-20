Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952353D6485;
	Thu, 20 Aug 2026 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214119; cv=fail; b=GmtORQt31r8xueSN20/i6OVPup1VnAA70fuSgHBZ4JsqatNJXyOhLrwJwjKh8PRey9SlgyCsI/qtP4HuEJ7MNI8FKNc9e6lwep/GcIS+dp26r+luedXI8JchPExZ1U04bgfcGSOXKocvghJeD5q2iWYX9QNVINfS2+EnhvRTaJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214119; c=relaxed/simple;
	bh=8/XBT0NhK5I9Sbggd0lgpnF+nze9HenHdXv1bUFUeTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BuGj/6dhpPhkqXyzzvGmD/zk8EwTa5Y+U144bxuCyrODcXoulpTZTxJLgkLseIRyBGCWZvvyfptCyjVCujjnZkAkHvU21vy8w0msxzCoYnyAHh1IAY+p1JkEsdUd8ddj8V6P6jiSxoxFDjgC7dhOOKHRW8rxaFkCVejuSd2t00U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f22Cu9ck; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f22Cu9ck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEDq2Kmb5UG0ed17KVSCrarTE8rjCfgIfS1CKbsHX6Z8i9h1LauKvbigYDV/37VGLlsl/EvCa+obEQyvDasohdoZgdRR2/kmOdfrPbvAy6dKfJCH3UXNiKQlnTqoivOwk7XT1e6mqlTLNNNonZy3M/I0l6Qc2jBTZfn7QVToJYdHkCrShO1b+K/NRhfJ2gLAhgMM/EGeBE+F6TY7p/N40m1N1lV68FHh6DW9mecfsKAhj6tpmpLV/mfLGQr415IOFKTZkBTKLALdlq0iljjOGXkJQueOyCLNs6tvw3kkwh7fBwL2/b904PSOt8S0+v6I/wTn3+RfYrEbnl2CEgSp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntUkWNCByRUIjEx8YllhL/PlcbCDcz+t7kkCfU4Bo6c=;
 b=iwM/vdXPs91DMtUesabntnCPI/sLMNjVP33gjAiL5Yc9Q4X6Y+DSgTAvAeAL2BzG8L3k2JZC9pCRzF3J2RfXFtoBPGehK29lIhoDR4xIAVsFoOyCF6vVA4uwlTepQgnld+41IVz/CjJ+uK9zQ4rSepxL5znV9ynb6VeMJ12VjCXNYdi5h6O4rTklpx8ROBB8n1F1RMAlPqoasHCacStOGna+BkZO01NaQpbmf2bljyKg0lRXMgUQAKueo+LQ0/zv/4G6O7j2VF5+oNKU1+4E4NSWXWjZZUlIOmcJ/iIHkfzRcQc/fh7E/iDEquA2C/FoM5gnzuQoCwW5AX8erOQtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntUkWNCByRUIjEx8YllhL/PlcbCDcz+t7kkCfU4Bo6c=;
 b=f22Cu9ck8HC/77POPQHO+/c9jNxFNIG5jLw/hRM+waqlkoMIRpYWHxazMHgOqS8Ajr+nAJj+ImWh7Ua9BY1AoUJ35aO43vW4QaP8ENE4uL/QrGw2nB/oNJvXNuKURmC/9mqM2VjHhocL9w3s8rcTUBMO8R9uuLgQgNGJA46960I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) by
 BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 08:21:53 +0000
Received: from DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c]) by DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 08:21:53 +0000
Message-ID: <51a316c1-4654-4f6f-92ff-84c310cd604d@amd.com>
Date: Thu, 20 Aug 2026 10:21:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
To: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Punit Salian <psalian@google.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 linux-coco@lists.linux.dev, x86@kernel.org
References: <20260727210718.125872-1-psalian@google.com>
 <CAJfpegvtp3L3FuYd8v1Ox0nZ-fb632jy+_M_+YyBWpMQGJAXug@mail.gmail.com>
 <909ab2ef-b931-4a64-acfc-13096f232a07@amd.com>
 <004afd12-762d-45d6-ab75-037d58e7a359@amd.com>
 <b965c127-08d2-4e57-9396-a2c3f5cf253a@amd.com>
 <ijwjd4gc5hrowrxntq7dknbuhvotkvpuhrk3gdoorxab4kez2w@ym6mti6jmcmz>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <ijwjd4gc5hrowrxntq7dknbuhvotkvpuhrk3gdoorxab4kez2w@ym6mti6jmcmz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To DS0PR12MB7771.namprd12.prod.outlook.com
 (2603:10b6:8:138::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7771:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 469db31c-b23e-48cc-c4be-08defe941729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZG0o5bR6Rs6rKjoRSpEowg6uZgwvRelHOrlVD8QNrMr5yIWDytu0cC02BpEh4j+17Iqc1xTV08Qbau2HrZn11HqpglHQRzWJtt3Bdctyug8QJRMS6O7hwQTHatbJIQqwYGtSLEW5iNuJH/qyuAY+NXnIEp7NyRSKCMlWDFcCZ06qTkmi2fECi0GAMeusPCFzf9jCguSTQ7Ko8ZUNt746GgZM5o6st+hJz8/YUpMAIor1va88HQPUzeXU5c0OOxsaaSSrTbE00oZqU/HC4Lks7lFgmpvUiDB4hOBpewMWWEnJaSj8CRmMBQXYjsUSfTlLz9s77vzKpoOkopu3doDwzNVIEfw7or7tLpoj7YpI8ELane1S+C8JPVuUNmjTQtFcFsjKHxMEldG5jB/YLIRMEiNqXBlosm0W2IPPvRukAfgOoDletFj+V1f+Cdyx6YcSCmOz1nxaqR1qoFdKCCeMcO6BGB3QqAJNY88gUQ9dvMVyqGd0PH1muoID0HdgX8TvQxA9PUIH1V1NMgNPW8vGUDuIfae5Z04XMG6g0ul9rmcNcdT3M1E4QRgAvcbbum+Z8wBgdNgHVCh2Wnlftu4+36U5i81hSHfQkzJg1nqx+mfY6ItIM+yTRJjQt0Rtvssj+Dtpxr8gBI82FxKMjArdLL61K48WWBRtv3K9LgzpB+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7771.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW1zV0t2SFczZ1doUVNoRFRBMjA5bE5zY1UrM1Rod1BMc0ZXbWhJNHBYdW5l?=
 =?utf-8?B?MlkybWtrc3RJTnQvbGwxMFN0ZWh6TkFNaFZXUnU0OWR4QWowVFlRa3FQUWhs?=
 =?utf-8?B?cTFaa2NnV3RldjJVQW5IbW9mbU9RUjd2WVJGd01ra21zTVFGTzFNWmFoeVM5?=
 =?utf-8?B?WTNYSnFLNEdMQjY2cG1HVG1wY0gyS2tZQk0zekJYSTUrMCtkb3Q4TlFnTFU1?=
 =?utf-8?B?cFVXNUNPNTRIYXRUZ3NhaHdLRUlRZ3Y4Znl4SEEyZUEvenpEcVFQcEZkTDE2?=
 =?utf-8?B?RWU2ZEdJOVJXbG5OMVFvNWxVb3g1dGhUQkRMQ0tTZ2hWTU5hOHJjR3pwRUtJ?=
 =?utf-8?B?L2ZnbkZKQXZxQWJ2VTJydDlld2t1TmR2WTFsQUJqRm5OM3pMeHo5Wkg1S0tj?=
 =?utf-8?B?VmxHbHJMK1FFOFRPM1lEMklMZG92MUFET0JzODl6Qm1SaGw0VEt6ZDYxMHFy?=
 =?utf-8?B?Nys2VCtCcUZ0WVAyK2ZrRWFkR0tYV1FITCtjRFhWUGlZQ2RyL3NMZEsyMFBw?=
 =?utf-8?B?UzJ4aU1yVWplRmVLRFZ3WXczQUxJdytEcG90UUpCVjFpMjI2dWk1RXV5T0li?=
 =?utf-8?B?MTNMQTZSZFRObDRMOGJJSGV3RnZiYUI3N0RucmdvTGtUVzZSYW4xMGZGamxs?=
 =?utf-8?B?c2xmdXVLUHg3MGZkK3REQjBMZGV3YWhLU0E1TjR4ZVVMbEpDRWoyZU9QdTg2?=
 =?utf-8?B?L0RoeWd1bllkTXMxTU5JL2Z1a0J2THZHT2tQQTRLalpFWmRPZUZ6UFpCdlNk?=
 =?utf-8?B?YmFFWHBwOFRYbVhVNklqY2hDUzlHT2xvR296OHpZcDNNSGRnMnk4VnVCVUxs?=
 =?utf-8?B?bEhRTnFnWDdpUjFvaTRYeDNqZENXL2krclRyalVkcUtrS1JKWit2YnBqVXlR?=
 =?utf-8?B?MFk5amxEa1Vob01lald1R0JrbEhGSzNEOG1uVUtaNVgvMGNhcnVKcXVlVEFq?=
 =?utf-8?B?aVhPOXZFeTRKNWc4cTkxdVhBR2V4bVJCYzh1U2cwM212UXIvSWlHVDB5YlZZ?=
 =?utf-8?B?OVd4SU5ybHBtOGNtODIya2g5R2JWY25PV1hPU0M0d2toU3ZpYXdzd2tsUWNt?=
 =?utf-8?B?VFcyT2wvTWNuUUdnZUx1UkxMNzkvY3pJcHU5Yks1ZTBoWlhUV0pEVTFyaDBC?=
 =?utf-8?B?eXRZUDdRam5KWkNYdmZGRnJ2QVB2UGNyZmh0ajErY3JJVjMzTTJIc3BIcFlD?=
 =?utf-8?B?aHU1bC9YS0Q3aTBJcmJkQmVpYmVEQ2NkTlExdk1HQTl2QW84SnkzdmRZKzhU?=
 =?utf-8?B?QTFhSy9Kc0pIUWJNdXFIOXB5ZTZTT3NaQys0USt6ZmdqNWwwdEtKdHdESlJt?=
 =?utf-8?B?MmJUMjF1MUJGNVRVMEdGS0JSYlV6OVZteFphYzQ1NVVmUEFMOFBHSzlldHd6?=
 =?utf-8?B?bGFZZWYvd2ZSc3dqSmFBcnU4cmhEb244RXgzWlg5ZjNrK2hUaCtIb1JudVhQ?=
 =?utf-8?B?TDUrRmFMWVkwQnpQZVEzM2paWGtPTVE2L3BQV1dDVDUwUURyNDRyc00wWDRX?=
 =?utf-8?B?aDFNMGswRkRETFpWYXZEWm1iK3hIdEgrOFBIbUdMdHoxczluRzlEdEdYdlI3?=
 =?utf-8?B?WFI1d2c4NnM3VUJGQmFpdkF4ZkF3amNiR0RkNEp3ZlVqeXI1UitxV1BlYm51?=
 =?utf-8?B?Q3hWVnlUTTFjT04wOEV1RVNVYm5XY1ZsaUpVSkFSZkl1aDA2M3UyZldabVht?=
 =?utf-8?B?NWpSZ3RrK0xaYzlzL0ZuRFhvTGxRTThVMHgvNlU2Y2xsZEowMDZOQ2R4eWxK?=
 =?utf-8?B?Q2Mrdk5HTC9ablQ0djBCWHlWVzd1UUl2U0RHc0o5VnpwQ01PWjg2NzVEcUFw?=
 =?utf-8?B?QWhZT0dVQWE2NXdUU2ZBbXNPUVd6TFN3aXh6bkF2eG04K0dTQWRuV2FnQnhn?=
 =?utf-8?B?L1dPeStCOHBlNU9lZU5hTS9ycVpjSnRNMjJUcmxuTG00aDFMVE5XRzNnL2d4?=
 =?utf-8?B?NUh6RzZsR3dONmtkckxBMTZucExHN1E4N2xIVUtPb2h0c25RdEJ2YlhoYzcy?=
 =?utf-8?B?Z3pFWWdRSzJtR1hEdlhqRnVTbGE3RzlWOXFIZDB3T05kaDBDbmwydWpTNFdj?=
 =?utf-8?B?djFUSVNtYmlFc29IZFRmQmRITlBSSzFadGRDOTZRQ1F3QUNYNUFCVDl5UC9y?=
 =?utf-8?B?Z29XRm9xNFpqbTZuR0VyZ0FhRnBZR29Ib0VJc1NWUzNJQlhpbS9oV0I3SGdC?=
 =?utf-8?B?TW03MXNLUWU4VlJrbTNqNmFwMnhCUEU3VXFhbWpPSkdaZE1pa0U2MmVQc3Bk?=
 =?utf-8?B?TisxWk9TQTBLcFdqNVpOYTd0VVhGaHJpQVF1c1pYa3dIem1zaS84ZFhyYSs5?=
 =?utf-8?Q?/p4gbTFRd/ZAW/0AwM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469db31c-b23e-48cc-c4be-08defe941729
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 08:21:53.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS2SUCXpyyjZTUVv1ltUAeWuxiBtPSMSjzHzjCi5bbHVTCzbTjko8WgztH1NrSFdz7k0wRqkytROv8DLVnzExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732


>>
>> I started testing this on my AMD system with QEMU and am still working
>> through the configuration details.
>>
>> Did you happen to test this with QEMU under SEV or SEV-SNP as well? If so,
>> would you mind sharing your setup steps or
>>
>> the QEMU/virtio-fs configuration you used?
>>
>>
>> The error I am facing is: device 'vhost-user-fs-pci' does not support
>> ACCESS_PLATFORM when it is enabled.
>>
>> But under SEV-SNP ACCESS_PLATFORM(iommu_platform) is globally enabled and
>> when I manually disable it, guest says:
>>
>> [    8.788217] virtiofs virtio0: device must provide
>> VIRTIO_F_ACCESS_PLATFORM
> I'm not sure what the real solution should be for this, but does this
> hack for QEMU avoid the error?
>
>    https://github.com/AMDESE/qemu/commit/63f103e35f5f3735d10f7618584bd8bb208e2c28

Mike,

Yes, this hack avoids the error, and I was able to get virtio-fs working 
with it.

Thanks for sharing the patch!

Best regards,

Pankaj

