Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5374448B99;
	Tue, 18 Aug 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060569; cv=fail; b=cR7q1K2Z3lxr1lbwBaHxzxgQjWWBG5VB0VvLKPk2jUWT3F17iWwTpqd4YcIeu3Cg8w0xgGYOUYEYsrzODPiqKZ6PScgzDBs0ruZEm2YQf+dBptHGKU6/Ur2R80eHhJ22AYtlyiOyNW5e4WDVkmQr1OQb7Ci5SMzK6N2+2YcR2r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060569; c=relaxed/simple;
	bh=tYmpY49cYY6hTcW6gcdRK6c8/qqbqdYYdp+CpF08dt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=myoBPtdPt7pva8yC4IQdjwzqfJ8pc+YvkD8ZQicImpvJ+U3XlMz+fDAtkfVeb9L/CuXcBGibkLnx6Q1m3FQzEd4j8fATJh0oGcaVC+KFPAaU8JDE9q4GIfHo6k1ULlErgRfyugoPD6NIE5lUTIiWnb0sW+Qfi0+8Is5xBc5f9tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rT4wQQHI; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rT4wQQHI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwCrLG3hk+cvoLwAUOMuWpfIXlTFO6V5zYXm+EYBQFPqTIuBHnSlAtxSROhRFdGpCXqqKz3e44jtqdsvJgJbs6S/N4OxMAoyCUrdecW8iZsxEEi4sCz4LfVuDcBdRfNEc+yvKRcyTjGyaI46NbfYsv52KWQBI5A+h7rqLNHM4q9P4n4/x0gtyJTFc+AnmmwNiQ4/oM9IE19VGHpvORzYOjtXw7knabOBomw+aHfEePxRg4bUWlbV3hD1V6rJQlUHZOzbN50FVRthay7m0TS9nOBplN7n60XjOv6AijGFlBJoid9h03vNY/guSiCqrx8COLrV89u7oAV+rECkzsWjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPh+5vfhrdzv3A20C4tD+3JFjcBqjY/jRnNS9LMttDQ=;
 b=XoPFDNNhvs1cm4nzXHiJ0CIwIp6Jmimbd4SuLBkF/WsLqqKXT2HxrP/t5naAisXiQzhTrSPfqVDlWQlbralopJkpvq4mfN7tyGEgJyPG0mLa1/sXxKF04siq0WrZmpyqoyOwWfna3tzY2vN8MkEzJ3wwS+GzsTU4MLFpAxniTXW4iOw0xoUkxTtkwmeYM4PjhMbTKHut8ElL50mTrrGs5HxLaPQyYV2VrFRUvx+Y9WSMM4xNSnUBnxpTu6PECYkjzNMfIDrH8ZXfc7hdO4XfFFfobhcFkosHzbeIvLSwAwmumKIEm92QfEcgEY7E+zPGmnUZAnK/tblU95HTw0Uftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPh+5vfhrdzv3A20C4tD+3JFjcBqjY/jRnNS9LMttDQ=;
 b=rT4wQQHIk23Igv2B+HQbm3jDpqn/Rysgx3mUjgtK/IEROr/kUY1UXKqNYCaGjaHarJIpE0eelVYXcF77/EzQ26mizsOcc9vabDjDNxH8H6ljCQ+CcMeauEGWyRHokavbKa7/yWy0inKr5QiT23K3cx1OmtXfkjnpfKwurNDrvRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:42:43 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 13:42:43 +0000
Message-ID: <909ab2ef-b931-4a64-acfc-13096f232a07@amd.com>
Date: Tue, 18 Aug 2026 08:42:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
To: Miklos Szeredi <miklos@szeredi.hu>, Punit Salian <psalian@google.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 linux-coco@lists.linux.dev, x86@kernel.org
References: <20260727210718.125872-1-psalian@google.com>
 <CAJfpegvtp3L3FuYd8v1Ox0nZ-fb632jy+_M_+YyBWpMQGJAXug@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <CAJfpegvtp3L3FuYd8v1Ox0nZ-fb632jy+_M_+YyBWpMQGJAXug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25c::11) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 2073fab3-cbe1-43d3-10b4-08defd2e9436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wzoxiU6Jsxs/EEh2j1cuBQhOzlBZbag7weUMXCUiInvqJgjOif9QnFfVKRyIiTOJ9gsgxNkg0wb0iJ37jazPIh8iBIkN5ghc/iARDFmXva0TqaTlun+K7P11gcY0rB4CUv/E7fkq6AukHk1ezFHckozopuLl8f+zsDWaS44bnmjrD8CXUmB+UXR8Wb9JVzeFvhE/+fxKf72NQ/67GncMXdvNskM52BeTfmD6uFcZxfiTmEKLQ/g4p7eAeLJyXnNVQcxaH6msTEcK6qAm63wl4EN1q4EPdSux0+1WYuG8eDuTtC+pNapk4IxVjViu3qTDr1mESIptz0F+qiDAIDz/Eq+LnEKQZ4LmJKtiy70jTRCvubTsqURX/HCCBYuvpBYx0Gy4X9DFFfsGCLtLyp2dOxDH5TB2wDcDN8lMXlwJFJFbBkYFIC+i4NwhiRQVS9DBd7AGTf0ATvulzWmFN/3PCE50mgwFT1sT+XVwSkplOHyFRlloWuu3P0RdApDPzXP9pI28YH4jm65PAGkJBsnLVXLJmgqBijle7mIhcUjETPxuAJUDN/QpDBXo+J/a7z1sw0v3ABLx9i638ykFMG+hj2yNiL39TXgN+UAMalMqmE9bmRGbWDAufDWxtvfiEzJdJKO/WwnDIQBPpIezjRs7BW1yaStSGgiPR4/xv9EBrcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWtENkg0blNRSm5VMTZtTGJxN2UyU242NmlydWxEL2dOcmd1bVoyZ0JZT3Bj?=
 =?utf-8?B?U0JudkRHVVVwU0hSc2RjWmYrbG0vQmlDR2pWUzgzK3A3VFA5czNCbDdJZFhU?=
 =?utf-8?B?VXczTXl1eDRkNG1lRTV1MkJEd3lwbk4xSWtZTnphZFR3VHNEdWdxeW9PeVRE?=
 =?utf-8?B?UXFzV29NdE9SVWl4RWIxcW5SMjY4WUpjOEp4THFMOVNzUGE4b0ZqYm9lemh6?=
 =?utf-8?B?OFBLWmFhSjQzc1dFZnpwcUdNWnE0cHV1WWE5NEhKcGUzZHdINFVhVlBwb3hn?=
 =?utf-8?B?cWhCZ0xVV21ZbmxrL3N1VDBSWXBuYnlZb2FPV3RMR2NhSTRNaDFKZ2taWGFm?=
 =?utf-8?B?WlYrUk45V3c3MUVVT2RBbXNGd0QvR1pNUnM3RW5VQmZvaXBXbUhoOFFaZER6?=
 =?utf-8?B?WDVNQ1BzNTBpOUVVSzNVNnJteUJXNTZzY3RFWTg1NGg3VHpHbkZvZllxUjk4?=
 =?utf-8?B?Y2gvUG54SnRaaE55NnZ2UXpBZ09MTVg0ZVg3aWRvWThpLzlRbWJ6UTNsdjgr?=
 =?utf-8?B?ODFoRzR0cTRPamMxOXRoVnhlTzE0SVhwaFduTjJ0K2d4NkdmUmtneG5jNzNs?=
 =?utf-8?B?R2ZOTW4vUkVEWTNGWmUzTURReWh6WS9MZ0s0Y3lKS2hrNFIxM0Q0YUEveGR6?=
 =?utf-8?B?alVndjBPMTBvbVZad0hudTNHakpmK1VhdHBZa2FzL1FQdGUyYmdvdlhiMWdR?=
 =?utf-8?B?aFBWN0FBWi93R2tlQmNlTm1CRWFDYld3VmU5Y1NJdE1idDVTZEt3cFVKTUFB?=
 =?utf-8?B?OVRXTnZkdGs5eHVOOXhnQS9YY0pKTzczYm1vUmNHUTBmcmxDVHhBQ1ZHdGs2?=
 =?utf-8?B?enllSjI3OEtsWjEwNUxGSzZtbkhBZ2duSGRBQVFZZFpwclAvTkFvWlh5OHJy?=
 =?utf-8?B?U2ZBeFp5bGZHbHNIWWJ1aGJ5bTcwVUlTWjV1TXk5bHhpb3RwUXRxQ1VpMWVG?=
 =?utf-8?B?RXhOVFV4eldMbSt5T2hhWnVxcit2QytkS0ZpODI4OHpnL0l5QUJPQ3V3MUhJ?=
 =?utf-8?B?UXQvTkd3a1lCNU0xMzYrY3pHanV2cGxJNkdKMkRLa2dpcndha1d5STdJNVR2?=
 =?utf-8?B?anFoWVdPbzk0MmtmcG5ROGI3Y2ZWOEo3bW9jSVdkMlVkd2ExSVpRZWpPWTJJ?=
 =?utf-8?B?UHdJUGh2STZoc1dmZHMySUhXYTdYa2lDVjExVGE2MTJNWCtIcWhGbVlqWDNS?=
 =?utf-8?B?aXI2bWZ0dEludW00eFlUeUNOVmVGbTQ0QjlJTXpkemtQY1EydnlNeDNhcXBi?=
 =?utf-8?B?SHcrbTgrQS80Wk9zZ2U2NGJGR1BVUHk0ZHZITmphSVBWUmZTUFAwYUllby9J?=
 =?utf-8?B?SHlLZU0wQWRXclhuUGxkZzIzdDhWYXlVYVkxSS9KNEZZQ0d2a00zeG8zZWs2?=
 =?utf-8?B?L014WCtIQmNIZCtTZG9KZFpBSG92cVZ5QjRIbTlDdjh1UFpGOEFSVXNhcStW?=
 =?utf-8?B?dUZHcTArRW9KcTl1dHNFS0lxVld3SnB2djd0TGtCN0JPVGJDbUltOEduUURa?=
 =?utf-8?B?QXpBdE9rUTlVSVVMNUFsVFlmck05aVlyTFhsb1hlZHNxcVU0MnlPNFFvVk92?=
 =?utf-8?B?dHEwZ2JReFZFT3pIOWtpZ2pQbjZnQ0FpWmFGRjhiK01xWkFwb0l4aDZ2QzNL?=
 =?utf-8?B?THJzbkErV3R5WUJvNGNnZi9DL045QXdKU3pINm5iUHE5TlRJaTkvUmx0V0Zi?=
 =?utf-8?B?eWFsUk03dGxIL0VmYm5WaUdMNmNkN21VZ0wra29VNEliTG5aYnVianVCL3N4?=
 =?utf-8?B?QUt2a0Zib2ZEVnQ5Sk8rRjJ5L0xzNm1CTlBpaUxnZVhjK0dKVTlYcmh1RjdY?=
 =?utf-8?B?VWRrQzQrYkFWL3RSV3JET3dYRzhlbzJsZjV0MzJLbWZGaWZQMmxKM0I4bWJm?=
 =?utf-8?B?RzlDcXhmUHA0ejdSbTZUWnlmb2M2cFBPZ2NmNXFod2Y4enpHblBINGFETThI?=
 =?utf-8?B?T2YybThIa0pUdlRRcWhaSjYxV2tHd2tMSXoxMlVMb0orSCt1UG9QUDZJbW16?=
 =?utf-8?B?RGtucCt2ODVUbzhkM241aVQxOUpWOFp6bzd5Ym1MbGpKK0RtZU9XS0JQbEtV?=
 =?utf-8?B?bjhqM3lIOG9NZUJFTXhkcmsyWGY5ZUt2N2VwaUNPaUZ2V3Zpa0tQRXhwR1Fh?=
 =?utf-8?B?cVRYTVQwemdUVjE2MFJmMnplVHRQZnpldlhMU3FGQ1ZOSDBzLzRBQnk0RExZ?=
 =?utf-8?B?UlZpVVZWRVVqQU5HSjJEclZQRHVHcWRyZWhrcHlXSjJoNEMrUlZaSmw0dFQr?=
 =?utf-8?B?TVRZYk1xSEpVZVpCU1RmcnIzNVhNRDBEeXpSTEgwQWhlRFNkT3FYNmNPa1N3?=
 =?utf-8?Q?H4oHxiLO05TvBBdI4k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2073fab3-cbe1-43d3-10b4-08defd2e9436
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:42:43.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qT9nNhx6HuHKDimUMPt9rAvAQHwmsw/am2uFKqgh2zj0TJq45k/gSNQ9MtuCU4DoyX2f8rB4rm3O4xI+yP69ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626

On 8/18/26 06:38, Miklos Szeredi wrote:
> [Cc:  Tom Lendacky + lists]

Adding @Pankaj Gupta to take a look.

Thanks,
Tom

> 
> On Mon, 27 Jul 2026 at 23:07, Punit Salian <psalian@google.com> wrote:
>>
>> In confidential computing guest environments (such as AMD SEV-SNP or
>> Intel TDX), direct memory access (DAX) mappings between the guest kernel
>> and host-backed FUSE/virtiofs shared memory regions must be accessed
>> using shared (decrypted) page protections.
>>
>> Modify fuse_dax_mmap() to apply pgprot_decrypted() to vma->vm_page_prot
>> when establishing FUSE DAX memory mappings. This ensures guest page
>> table entries for shared DAX buffers are explicitly marked as decrypted,
>> preventing memory encryption faults when accessing host-shared DAX memory.
>>
>> Signed-off-by: Punit Salian <psalian@google.com>
>> ---
>>  fs/fuse/dax.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>> index a15c464c8d19..00e316a7f805 100644
>> --- a/fs/fuse/dax.c
>> +++ b/fs/fuse/dax.c
>> @@ -826,6 +826,7 @@ int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
>>         file_accessed(file);
>>         vma->vm_ops = &fuse_dax_vm_ops;
>>         vm_flags_set(vma, VM_MIXEDMAP | VM_HUGEPAGE);
>> +       vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>>
>>         return 0;
>>  }
>> --
> 
> Needs review from someone understanding this technology.
> 
> Thanks,
> Miklos

