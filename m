Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A63033DE;
	Wed, 19 Aug 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151800; cv=fail; b=bMNvp87A1rHJo5ewgreG9NXbUqlMf0YD980r3cH716+PnzEbfUzVwDg/h1q3ItR0hYoGcZEKPVmyqT4gloMyfvS/5rvBcqqCI5H59/o27s5yq9wc7HyStwA1H+joSGgCt++4Srlfu441K8nJ5dObsti/KUXl5aXDlzv1IBMmPgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151800; c=relaxed/simple;
	bh=mMv1mgKIBiX0EdZMI2DHkwoXDhLwXMUMfVEr7HynD1A=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HwANK11+iBsL1spbzihf91L3MxSZtFoygUIwnhwvExU40z9GZ2cpJuVZQXZ2HXTsdmFfWZWm+rC5tPPzdTGcsEjyzlprDdQM7SmgEXVIdAJQ+E99vDQks+8y79DlfKVHk5sb9L66U6hswyavmSPwme4Q7JGz4va0Q7cMN4CjONE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pvv9RXcV; arc=fail smtp.client-ip=52.101.57.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pvv9RXcV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1eD8QIEvW0HMiDiKTDH3H4Q/rN49XhpCudxBSuyH4toYXGkjhpHF0zICFuZt1A7qT20pG0pXMfFB5jHU5yEdu894awtFOeDzOYrXBl8Q7IYu5FgFNPNwgmXlmyFq+WdWvnL3xEZJmMHjxUiUqmjq5SBAN5Knx8CU0ZAcM+b5zETHgxI/N7T5rsMGuYKiMogVw5nch8nqNGMAXBZNaIrh2aV6tXw3HnlXwv9bzNCjSIHrA60YTrnHk7vOlEje2dEPdYUxI/Y2lrGmwESPqkBxxcDLRXwY4fKFkqCg+kKJ7kFFQdo9xnoNkgPOMUnukug0G3xvUyU4YenJwt8dfaAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypv8ChOXl3FK9YjDQ+oHQwuk2XNXpVnJ+ekEUW9YkpU=;
 b=qNFrEKLawVhts+rnWebRUziEFVTAjwkDoqJr8+i1l+CZCx0OjzhHix4oJ8LzE6PxXZgRoAjnzmXxBkdq8AYoUOfSYEAAquTy9D7aXB7mFoMV6F3cMHJmLr3FlYzhItpUDArS1L6MQNb+zqwi8/WTRGyQPeLUZh527PzvjvAV2FIpRytT5/0qG0fc+ItOXJAtzCTDlYHZ5fY+bg6Aq50iAHvvvxSLZOkUJF1VmShv4vdBmG+LRweYzjAbwYNerssIhtJH6lxq5Sao6N8L1Ky5ZnSp721FDW3w0VCZbt/H+WzMdha05bDe2H0UF6EmKUT4TbH4LcgLdFIxWdkxxMMZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypv8ChOXl3FK9YjDQ+oHQwuk2XNXpVnJ+ekEUW9YkpU=;
 b=Pvv9RXcVygt5OXaceyVotGCO+31P7AuaRM4qZKWpXowGKrycHFvo4aieioXLJFChvNCtXcQf7VRTa29Sjdr1fhBZ6ztwu6fOwdeV0g0ykoPLsJmiItNe4xgGYAhtv4HwyBOKOf7IWvuxrXiWiTnrIou1vijjTSyNftvDE9Ve3yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) by
 MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:03:14 +0000
Received: from DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c]) by DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:03:14 +0000
Message-ID: <b965c127-08d2-4e57-9396-a2c3f5cf253a@amd.com>
Date: Wed, 19 Aug 2026 17:03:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Punit Salian <psalian@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 linux-coco@lists.linux.dev, x86@kernel.org
References: <20260727210718.125872-1-psalian@google.com>
 <CAJfpegvtp3L3FuYd8v1Ox0nZ-fb632jy+_M_+YyBWpMQGJAXug@mail.gmail.com>
 <909ab2ef-b931-4a64-acfc-13096f232a07@amd.com>
 <004afd12-762d-45d6-ab75-037d58e7a359@amd.com>
Content-Language: en-US
In-Reply-To: <004afd12-762d-45d6-ab75-037d58e7a359@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To DS0PR12MB7771.namprd12.prod.outlook.com
 (2603:10b6:8:138::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7771:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad46ca0-aa91-43b9-8c3c-08defe02fe67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|6133799003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	nunkb45NPPIHr9yXxMSMDRRiW95Yeht2qe6JRo6PdNwSqD9kg/y56R36fRqmdkWH/nA+O/bidAqbPzGb2QnCnV1Nr/+rblAr3wcXXnk5OpAqDpF9pWErZJOlCQHFpd/fVhPdlhN7rmLKDWzq2Lkxng7S0TXrwo22iCBou2ZdaXtPd5yD3zUif1AfDWu3XdFMtLWTU0l38nceHDhy1bx88/0Bfgg8W+tI2MGTpbLZJ6IFn2FoKR2vaQJEULsFdoPfo54/VFBmuPoBl9VVX1cORLLcJ9U4H1kIIP2sHdtSNnWqttCzwhMrrvv78YC49vtTqRMhkdWNXQbpqhgnokt6pStcOw97uYS1lCCOkcblZLvjiVDvDgtVpOpbcHGJHDLaElgW2C5/8j9lAj4ZXwpU7sK1DicRPVVYQEvtDvB9kPszTxsIokJx8NVePMe+sPcV05vFN40A+39nmWbywdwlkNiaWcYSx+4r1KLwhqajqvMr2yjeujVSR+JtmKRbsx7PdHnnjPEaW98saN3J3T6WgoMR+vtXG2U3I/mL+/EyHkXEmKMTwiaAWZqZRblmMnOkfBnvwL8U7V6Sr3YsALNfPOPKEkgsFAdXAmRh+CmZpo6QoJInk7QzAlEFISCDQzWTDyOc49aHfaaSb4kBWFF/fNleXe+MS8mIKFM4SekVoKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7771.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGJtVFRkd2xZeTRtRjNvVWFkTWplQWxPK0hZS1FOdkluVlVCT0VKU0JET05R?=
 =?utf-8?B?WGlrc05HY3BiZkhFa2RkWVprTlJ5UTUzdEtWenhkUDlRTWlJMTVLT1E2MFBy?=
 =?utf-8?B?TFcxYTNOZEdjd3NiRUhyVnRTWHBDbGN1b1hTMTJKVzRSbVN0VWtHUnNSYUdQ?=
 =?utf-8?B?eDlZVktISTZNRTdFdGJmUms4dVVkU3c2SFp1QW4wek92ZmlZTWJ6YnZpa05t?=
 =?utf-8?B?YzBtS2RRTFBraDQ5U2V0NjhLWVRQSXlSOTdLMGJtWGNBQnpmNWNoUGVnQm5N?=
 =?utf-8?B?NWdMeUFsSDhmN0tvNkFjc2l0bFFPL005YnZQdW5GQXdaMTYxN204Zjc4VG13?=
 =?utf-8?B?TmJ3VmM2V0hTSnNHYTBGZjdmUG5GSVhDMzBrRWxnQjAzaEtHZmJMWTdjc2VZ?=
 =?utf-8?B?d1pQWnZSdnpIenRndWV0ZEhzcFpOc3dRdFQyeTJYUVdCOVNEZGlrMFVxZGtN?=
 =?utf-8?B?V2NOeVBPNG0zZEQwaUsyVUtYQmZ3SlZVVFJHZTlGYnhBSStJZW1VS3V0WXlG?=
 =?utf-8?B?MkgvUkR2S09oMHJVNUh6MGoxSkFyYjBwSjVnWi9QQk9EeHlZWHVZU0xJTlBm?=
 =?utf-8?B?WURoZkxRcUc1SVFndWRZcENISEozUk5VaHNVMlF5QmtJckhCZ3lhL3BLMWxu?=
 =?utf-8?B?alp0VkpBVHlXSnZqVzBPdXdyQ0E3aU9nWWdjWnFLZm5XMXZLZHdkS0Fwa0NT?=
 =?utf-8?B?VElxWWxGYUw1OWpKa3VIZWR0OUZ1dUhXWkg5WkJKeEZEQ09adlFaK3B5Z3hz?=
 =?utf-8?B?TndmZW5zVGRSeW1MNmxsUG9UTFMvMnZnQnZJSlhzbmZHSHlydEVpNUVEeWdq?=
 =?utf-8?B?a3UzSlhtVTdaRXNUUHM5WlFjSGF6SStTL2pTbVNWQjFoNlZ2NXZDZStKM01N?=
 =?utf-8?B?V3RIYmRiK0RQd3F6dmY5NzBybmZUSUlPYmlxQ0Nmd1ZBQkFSNjNpdkFYUk1L?=
 =?utf-8?B?OW1pOUVReTNYMjA4TFBPclVmQXJ0aFJnQWJBMEo1NzBvaFl0WnYwS3psU3Z6?=
 =?utf-8?B?alcrRTFoNHB5S2ZoY3pESmRjVXFOeGsxNUJUSFdxZXBhclN6SEJRV1hpQit0?=
 =?utf-8?B?NXpiNzhkbi91ZTBEOHllSlB4TzJRbU12RnhxN1p1WHh6RTlQajJHU1c4eU9p?=
 =?utf-8?B?VHB6T3I2ZDRSYkNPNU9Zc0V3Y1p5R2hmZ0ZBL1lwQVBpNFppV1BJNzduQjVq?=
 =?utf-8?B?K1RScHkrUXR0eTFJaERNTEZRWFZwWWNRbFNZQzJPbTN5d2Uvak93L0NRUzZR?=
 =?utf-8?B?WWR1MVBFM25DTyt6eDB0SkVlY2picHpIYUZPSGg4M0EwNENtY0JjeVNkRWoy?=
 =?utf-8?B?eVY4THNXWEZPWHNnYUN4WlJUS1V2K2RIcmdFSW5NTDJOcWpRSjBpaEZ0VVUv?=
 =?utf-8?B?S21SOUVOR0lMTDhOcFliQkg5ckc0OHRtRzUzS1ZqV2NWb2gvY2hNb3RJcXd3?=
 =?utf-8?B?WExOaEM3L1labE5mMlRlZFRnZ1dCb1pBVXg3NVFIRDRCdSt3bmo1VEw4YjEr?=
 =?utf-8?B?TWNYMExDcDRmNnhpV0FEeFVZeWV2eHYySUI5L29oNTlveFJkRWtSRVI5VDhE?=
 =?utf-8?B?Nm0wV2xIQmp6aXB3cVc4YSt1WUVUOTBIaExzN085NGJXZzBKWHlTYm5XYUJ5?=
 =?utf-8?B?TEZXL0tsL2xBRk52LzNxejJJaWljc1d5RFhtcURiOW1TWEpyQ0ZZVDBWSElF?=
 =?utf-8?B?ZFltQzUxdE5QTkY1c0dFbkVwekNIbkprUldOem5hRCtObFpLeWdtNkRQRCts?=
 =?utf-8?B?Sk1BdnlQSnZQSlp4MG1ldGNWZHFEelNERzhKMUpvNXVTZzhkdkZHV3VJMjBK?=
 =?utf-8?B?Uk1YZXVmOFp1blpEVzdDcnU1NDhXNUlEZ3hmNm0rbUx5a0ovQUFzUkdQajZZ?=
 =?utf-8?B?b1ExM2c0MmhJcHl6a3dybEV4Q1hQNld0TElKWE45dlBnMFVqMkdwT3g1SGk1?=
 =?utf-8?B?V2NiYVY5RTZyQndmOU5hbUxFSmdRcWgwWjZreXk3Z3QzckQ0QWdHQlJYeWV3?=
 =?utf-8?B?dWNLVkhMbG9FQmFBZS9vMG5idEdUaUYyLzAwTjZZeHpHNlp6MndlajNqWjFL?=
 =?utf-8?B?TFdYRm5iUGZadUczQTQ4bUNzbFZXTThQdm9kZnFzTW1lMkhmbWZHQ3RRMUsx?=
 =?utf-8?B?MWk5THpkN3FQTGF5bzM0RDNEZytJdGJFZWI2KzRxTjJFRWlzMXBIZVRKekZ5?=
 =?utf-8?B?R2pPZTJPZjR2djNEWDNvNDc2aFNxZ1VRWXhBREx1MkxCaGUrbG9YcDRMSW83?=
 =?utf-8?B?WTF1WWZ3SU8vb2RqUkU0bjA3V3Nsam1Hc1p5cHdOTm5mcXJmMmFmdGhTbGt0?=
 =?utf-8?Q?E0rTpGkPURLzYnSyw0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad46ca0-aa91-43b9-8c3c-08defe02fe67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:03:14.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a36jqExWBNJwiXD+fi8VEvaPSnzEVu2vY/0gQC1eMj+20TDdL6IJh+na7BudCkHQKpQbH6JiVTEYYtQ4U5TJiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173

Hi Punit,
>>>> In confidential computing guest environments (such as AMD SEV-SNP or
>>>> Intel TDX), direct memory access (DAX) mappings between the guest 
>>>> kernel
>>>> and host-backed FUSE/virtiofs shared memory regions must be accessed
>>>> using shared (decrypted) page protections.
>>>>
>>>> Modify fuse_dax_mmap() to apply pgprot_decrypted() to 
>>>> vma->vm_page_prot
>>>> when establishing FUSE DAX memory mappings. This ensures guest page
>>>> table entries for shared DAX buffers are explicitly marked as 
>>>> decrypted,
>>>> preventing memory encryption faults when accessing host-shared DAX 
>>>> memory.


I started testing this on my AMD system with QEMU and am still working 
through the configuration details.

Did you happen to test this with QEMU under SEV or SEV-SNP as well? If 
so, would you mind sharing your setup steps or

the QEMU/virtio-fs configuration you used?


The error I am facing is: device 'vhost-user-fs-pci' does not support 
ACCESS_PLATFORM when it is enabled.

But under SEV-SNP ACCESS_PLATFORM(iommu_platform) is globally enabled 
and when I manually disable it, guest says:

[    8.788217] virtiofs virtio0: device must provide 
VIRTIO_F_ACCESS_PLATFORM

Did you observe something similar or there are additional virtiofsd 
settings i need to use?

Thanks,
Pankaj

