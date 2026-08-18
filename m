Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63443FCC;
	Tue, 18 Aug 2026 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068844; cv=fail; b=fOY5JFFQPZUfKhigPdMXfbPn17OPOkwdnTlRu3dhAQGPYGCADYjaRCrQEzfXGROZHsS1fzBLf5yPeQ5cSi1xMc6+WCbsqfAx1eyPeG1/RgMNlOaMvgNQOaQall618bIVOofX5cAReVDlQF0rfPBwSQDHv4BifutDIwIagvVWDYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068844; c=relaxed/simple;
	bh=QRGJinUNk2pl3v8/q9DZaBcV+EACBLVm2QSIn+tN04g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XueInK7CtqWiseSmXtSzPBnTTgPex1wu0Si9m2h2EspNEL0WXqR14QTojr7cV2r8ynsMdLnOfKso1BbBMidXrAZtsMz7eyFMkKQlxq6xh3KeDkZj5A9yCogiZs2qYkhqW4hinPRcgcg495Li7cvgh6rJgBSqkRbdo/kiZSGpIT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=umKuJfNd; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="umKuJfNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDCFtRytX07b3la46JjWRIUQdm6pmg7oCQSN77EQ4nBsfyMFt7uKtGKVaslrnWe0Saf7X7spWZolWUlkkbuAiuOYu6QAfWDqJXYE++Phh5CFOsdw7GLCTIp84XYf3HzwbTZ6f2OsyqviiVWxhyeTYqcWGtizy4Nl8yqB9C1vuwmfaSBI8VHVmG7ydTurfA6eKWo6InbdE00n9ZyuE8LjCXKu/PKsEB8xj7wQ5LaZqMHh3rr5pHtwIe98sQhjYqeFmSCJJsc7XsQkmQN6Uo4q/UmJrsOtRSIoIUnOoFaL4UJfWZrqn9MpCZ9ALFIZtReaMqJyvbKD4XR8NBs2Ozb8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R86c2Lr/Tbvbq2AohIlj5jtIYuFYC+gnD+6XRSovubo=;
 b=yAS62qTzhMiY6kIEPuXY7W5EW0Vjjv5JUO5qRL0HbapwhoILX3Qj1z6dYSvlpmR1xoUI+P2AWES5pNpfZsFnnUzxIAWynMKB/dR3KFi9Xl4oJaDqEwFrQriPNFx3ULh8agVms6pWFH8iny4e21LF6BMIGDkrX4OMuSA7Yxx1tV4FChXs3AEy5cmC8Dq14AZgRUTug8Ex4e848v8ey6RRj2aX+4XQP43n5Q9+9a/G2bAI6W/SsCiTLlW0rNRPLkUOzuDTogsjEnhjyqAAhYiVtY5vwdSWpHho6adhNJhwMms1sEUwVfwq86PrHPs8thgCU0OCJWZwol+2Ok8LLTFcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R86c2Lr/Tbvbq2AohIlj5jtIYuFYC+gnD+6XRSovubo=;
 b=umKuJfNdDUrxK4CdV6ra2qzDavxhDotfwx3XXKkYupUFPzmg2480pyziCMHMqBaKM3GG4ZYbFsfdNX5KZ7/QmFOkTfNz4pNBgA4DzXueoVjH960TwpAGkmD/GD17iEmzvXmEMWe7geIJPTz9wGXpty/4zcf+Mnuz2srdN6ai41E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:00:35 +0000
Received: from CY8PR12MB7755.namprd12.prod.outlook.com
 ([fe80::369d:b573:2989:5b6]) by CY8PR12MB7755.namprd12.prod.outlook.com
 ([fe80::369d:b573:2989:5b6%3]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:00:35 +0000
Message-ID: <004afd12-762d-45d6-ab75-037d58e7a359@amd.com>
Date: Tue, 18 Aug 2026 18:00:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
To: Tom Lendacky <thomas.lendacky@amd.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Punit Salian <psalian@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 linux-coco@lists.linux.dev, x86@kernel.org
References: <20260727210718.125872-1-psalian@google.com>
 <CAJfpegvtp3L3FuYd8v1Ox0nZ-fb632jy+_M_+YyBWpMQGJAXug@mail.gmail.com>
 <909ab2ef-b931-4a64-acfc-13096f232a07@amd.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <909ab2ef-b931-4a64-acfc-13096f232a07@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To CY8PR12MB7755.namprd12.prod.outlook.com
 (2603:10b6:930:87::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7755:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: c2771382-b177-45bc-62f7-08defd41d6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	iaD/NnY1khD+lGv+MFex5H/Sf169/O0LCKTid3BOP5osIf7dGryq87YtRqQFGOatoWx0yLJKnlZQ8VpNswF1M59D9fiSy0YkoENdKUTm9q6oHgZTSu7HGPwMkCiDXR3IVkRyTXw8fGeMaXKUDvuR49atvSNi3/EK6hgGnZ9x2jAM5Wuynpet8GM0m1yYZIEx7mhvcmIhAN0CZRNpL9uWmqky7w0sBpy5PxqZAv0WFZ7B/We+CeJZlpqaBebtGYXjWk1/cwtg0jumPafrBmPnE9G7UxJ0qLpqD+hDxVCUeJ1WOF9rP2o0A93kLipzMASoI1T/fVcUvwT2mmiQ8NTD8WVKkSxaBl5KfLvNCUrbKJa4fqbaTNHowjWMUw384a4GPaNG6T5j2dbO17OOrTDN64nrlDIGiw/j6wbQgSA3x/DxL3Iow5tWI2ozedlAqrAOw1IEiXPydijiObyptJYURxvW3LGq/xpukaCWpANFYpOXJ+dFp2fIAOOz3CYYgwbmRhCD7PZMYJ+I9fM55jxCzoW435OEqZFGEF3wg6JgwoP5fSZxTOXjEZJTwStuRHHU0dc+nDdx4vrObdmLuPpFid0pVFtmcAqAj4PppzH2q4o76pwIrhvvVjJFwCFGu4aNskXclM2Zks4ILaJI+HDqiwymWi4/dYHWJ2BP/XNsAkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7755.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3JCOWwzR2lkbUo1bWZKWkM2S2Yyd0ZBY3BtaURDTnZXNmhNRjFsMXc3VTQ5?=
 =?utf-8?B?T203UXhjVzhhekNwREhzTms5aXBjQjQvWENKVmRlRVh3Z0pFLzljVEZOaTFL?=
 =?utf-8?B?RytwZWlwNHRhZzdBVFEyNThEVkZlMVYxWlVWTUswYk5QWU5MSFB6TldVdWtM?=
 =?utf-8?B?cURSYU9XZ1dtVGNvbU9CVC9EdUdHbHR1SWZJQTI2REtVdzJPall5OTFuejBo?=
 =?utf-8?B?TEMyVk9xbnJhdkhJOVArU2prWlFrWHBlWVhrdXo5cVFHVkZTNTd0K1V3TEQv?=
 =?utf-8?B?V3gyNTJTOVVTVW5lK0ZPT0paSWhmai9oWk8wV2pTVmpnQmNBK1RBTCsvTE1U?=
 =?utf-8?B?Vi9uWTlsKzQzTDZrQStQaVdTSklLM1BoejFZUDRsNmdyRDQzMytVaFlnNk02?=
 =?utf-8?B?dmFySEVZK0c4a3VnazYyQVlQOTQ2QVNTdVJld3Jrb3FuSkExTzdKSmprQm9K?=
 =?utf-8?B?dVR4R2g2WTdpczNNZ242NGt4cXBZTDMyMld1M3FBNVFRSHQ5bFoxeTF2cTNS?=
 =?utf-8?B?bXR6VFh4dWZVVGNZZlRYRDc3KzRrRFNpWS94NzhFYWFRY3hSRjFzTHRMZkhx?=
 =?utf-8?B?eGgzMkVmaUV0MnI5YWU3NmJIVjdqTjA0UnpHdkFIVGE5NWVXcGVUQmUrOVRo?=
 =?utf-8?B?eWxzb0RSeHB5dXE5Z1UrNXZDODFqTFFVOU9Hc2dCa2xrUm5tTlM3OTZ2dnYv?=
 =?utf-8?B?U3JZSVc5VFpOSlFrY3l4cXVVQ1FZZjdTVkJzMXh5OVZxcE5LWUJDZGJtR0FY?=
 =?utf-8?B?SGhnUjN4OENvdzBmdnVrZW12VEFSNG50Ry95L1I0WXBXTXZ2YjNCamZwRmlO?=
 =?utf-8?B?dXo4UWJGWEVvMW84SEd1dEdGQ1RjdEZGR01GdGZHZWpiWlY3WXFQOXd6ZlpP?=
 =?utf-8?B?allVaFRXajFqVExUSXRWbDlCL2ppUEdqcXhkMGRYN09oT1R0MmE5K2U4Q0pJ?=
 =?utf-8?B?ZnBtNFdEWHlPNXNaREhHMmJKMjlFMUZyM0IrVHBTWi9nWE5zVkJYY0lod0xC?=
 =?utf-8?B?aGV4eWJrUlZkMCs3MUpETnhWdXpreEszWkU4bHNzbW1YTEZqcS9wd2htV1cv?=
 =?utf-8?B?TzROMW5GZ00vUndGR0ZlWm5uc2t5UVRDT3YrViszeVlhL2tyVXdsR3dEUDhh?=
 =?utf-8?B?UXJuVWQ0S29tVDRXeUNRSTh6am0rN1hUcVVCaHRTdVdZQXZDZjhua2xRd0Z0?=
 =?utf-8?B?aXd5ZWZzdkpXZS9kYmpiREFXMjhrK29LZkNqUVlZVTdJMUtEdWhOYnhVNW0z?=
 =?utf-8?B?ZjFRUVlTM0NZR0l4R2ZnY2cwYzVuNVFRNVgwRzFWN2tSR3RXalFsZ08walVa?=
 =?utf-8?B?aEJBYkJBVWZETEFnRUMydGR5MEEyUWxYYVVxS2RtNzhvVVBPV0lRTnpBNG02?=
 =?utf-8?B?aE5xOHpzRURWbE5XY2FRSm5sM01IMDNCVnlqZE1DU0pzRHVMeDZLV2hlSFhS?=
 =?utf-8?B?c3lSSGZMRTZsTFRnL0N4dXdtZUowa08vYnlGWm9aayt3OUQ5VXZOMDFOc2Nk?=
 =?utf-8?B?dFdNdlZvK25uVjJqOTU2amp0MmNHQk8wc0puYTMxY2tvd2s0Y21lOXlER2hk?=
 =?utf-8?B?eW5mbkxobUdML1hmbDFkUExaWVJuNVQ2RlFITi9QOFdpY1liRTd3eHdqMEYw?=
 =?utf-8?B?THNOdVBLU0M4RzBLT1ByWTRQalJIKzlMK2c5VUNaMEFPalhDcjlPOHhDWC9t?=
 =?utf-8?B?T0NrZUZ5cnpRUnJuVll3R0U2K0JMaGVqd0tGWFlncmVYUmtnL0JSbFBkNlly?=
 =?utf-8?B?WVAyTmZhMEIvNzFLckk4Rk1hYXZ0aEtHWU5PdlNUVDlNZXY1ZmlWbjY2dTdk?=
 =?utf-8?B?Rm5MWGFpMjAxOG9LVndFdVArYnlhNEtPYWo3R1ZSUFVHcHF1UTIzSVRHNCtw?=
 =?utf-8?B?aEtJNHIyK29IaFBZZ1YxZ3V3cmRQem5CQzZ0L2JWTkVIbTAzZWhZSjVaaDNt?=
 =?utf-8?B?Q2hIRTJwWDM5cnFXWlRpekpMblQ2K0prOWxmZUU2MUtJMllIV0I3VlpDZXZW?=
 =?utf-8?B?OXF5Y3k2b1BHOThUMkY3ZnZ6U2pZbEVHVFBDUEtoNHF5RVFieVFKdnRxbXZB?=
 =?utf-8?B?OWFRS0xYeE9lM09NT2F4UUN1a28yOUltZmJnN25pRUVKVjlXemsxZkRHRTZp?=
 =?utf-8?B?UFgwejRFakNIbVZkWGpZbmpLTjdXYjdTdWtrdHhLbGhSN3I4MXErNTN3Mnpr?=
 =?utf-8?B?MUpSeFFlWVYvall0R3l6aUhzUUFWQlprbXJYR2t1U2M4aDJKMFlncUhoNjdl?=
 =?utf-8?B?OGtDdHV2cmdrOXJPY0R5MFVuell3dlNDVDExWTNJK1ZVcEV6U2NWbjV0MkJC?=
 =?utf-8?Q?9G+bEzXsKjibtFlbcP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2771382-b177-45bc-62f7-08defd41d6f4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7755.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:00:35.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Qk4pWKWssGDl7AV6SuPuyxeXerJOzOpOYFRTnxLs/fQEPXrwPcbRfwZaNDbw0L/8fteSIQGSsY3hDt1yw98bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742

>>> In confidential computing guest environments (such as AMD SEV-SNP or
>>> Intel TDX), direct memory access (DAX) mappings between the guest kernel
>>> and host-backed FUSE/virtiofs shared memory regions must be accessed
>>> using shared (decrypted) page protections.
>>>
>>> Modify fuse_dax_mmap() to apply pgprot_decrypted() to vma->vm_page_prot
>>> when establishing FUSE DAX memory mappings. This ensures guest page
>>> table entries for shared DAX buffers are explicitly marked as decrypted,
>>> preventing memory encryption faults when accessing host-shared DAX memory.
>>>
>>> Signed-off-by: Punit Salian <psalian@google.com>
>>> ---
>>>   fs/fuse/dax.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>>> index a15c464c8d19..00e316a7f805 100644
>>> --- a/fs/fuse/dax.c
>>> +++ b/fs/fuse/dax.c
>>> @@ -826,6 +826,7 @@ int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
>>>          file_accessed(file);
>>>          vma->vm_ops = &fuse_dax_vm_ops;
>>>          vm_flags_set(vma, VM_MIXEDMAP | VM_HUGEPAGE);
>>> +       vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);

For virtio-pmem on host with SEV support we addressed similar issue by 
marking FS DAX device memory decrypted in memremap_pages()

(commit 867400af90f1, "mm/memremap.c: map FS_DAX device memory as 
decrypted"), since the device memory

is mapped though the kernel address space there. For virtio-fs DAX we 
don't seem to have such a central location so

VMA level handling seems reasonable fix to me.

That said, I'm not entirely certain about all of the security 
implications in a CoCo environment, given that the host is generally 
considered untrusted

and virtio-fs involves sharing host-backed memory with the guest. Till 
we get some mechanism to access this memory as encrypted, we can have 
this support

with existing security practices for virtio-fs:

Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>

