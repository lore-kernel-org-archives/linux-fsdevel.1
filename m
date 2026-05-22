Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A838A718
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 05:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427049; cv=fail; b=QaAlInBqgFAjc1QenVU807dwa7P30l95T2ZprIfyqbtNMhD78WUZRkkORCKtomm1+Vv37hiNNZU4MYpHNYPXkXrQW1ouEA8w5tp9KCL+EbJbvWKCT+wvlMo9ADhKYrZZm1F0SQRUh4Fv80J0dF0/EqREMuSk3c45TDKvih3SZKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427049; c=relaxed/simple;
	bh=MfvUcdHzNrEf5tzuooSj1P8O6sz3zB5GrMkOSopaFTA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:CC:Content-Type; b=jLQwlZVUgPn2bJUrt/hAwYgnmLv4oeJRts+bX/peOxQLIGNPesxdpbFwym//GXSTAVLiSs3bmYKiHSQXqsko/CD22cpb93+h82mVj+E0DgWF/vBgYCd3mpMCCj2SSgdhR88Jg9mowf16uSIgG86PC8mFUrKjCGBKYvLePGYmCFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=tOUc3TdL; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="tOUc3TdL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fURKI6Tyd9A5Bv71hgYOABbYgVf0U9Lq2a2aJ/oCt6/9Ky43m+PwiWnrIT5rU3i7KLhayZxFomXJFBIzfe2C0/8naLiphePbl3Oz7VHGnLCZXk/LooNQeuQmYKiM3YbZyqWwtWmAxFHrfruuNg88TEclnlqo7t/OVeqtw33zcLtSDgSIM9VV5VnUMsi+AZJuxlE2mgl3YoJ35xUGdeTImZtu73MblRVP3mHlLp7KH9xnvf3L0HhXMuHXY1DBXYjNQRd1zidGVqqhg4KetVO2KALcugjLeX5VoVrygg8+VXGA0ZTi8J1GnRq66zuiVO+u0EnRBqrVTs8/IResOUTwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F17fYE2PxZ0ugDuwO+sfjtfgrE0d9PJZGHGSyaNlfho=;
 b=VAj2DBMI13Xgjw9wlpYZfrElwh7ZQfPka0UKhoxEEKufV53pgpmP3YTRp4apiSB67G0StTdnBasi7IuM+E0rRQQKORQy7WL86MTos9/8eeU0kr98Xwpxe85k8gQFcER2BYMijkDSET4CFkqce/qN1BDoWhGXEBkwRDNWvrxtQYEF63NGSRD6KnnBIShzTRDIwiaYzjY6a3h0dSRziEwmz1JojVYOnixYX5Qo4jl9KBCYlp3xgQMKviIeS9sptiLjtAt40o81fjUT+1X+6mXhEOOKP54FoJXUjYADJcuc5jOMzYlqDPqAe0So9Fn3ZcDtAPlMDsOfiha4QLxJle4J0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F17fYE2PxZ0ugDuwO+sfjtfgrE0d9PJZGHGSyaNlfho=;
 b=tOUc3TdLk8MvJCa19sCRF0w9RuP82tm4jMSRFX0Hwj2mge5NPZfa9sRkPu3dQpRS1PicqMKDPe4Ec9B4iTgwYDrURIUqwFCXbL13GiFNogcfItA4Y7Bt5sSw7sHRt5wGAMCKOUpQucuGr9JSSCGNpwZP45S1frTG5rEXC3S7B1W3w9X9FZlT+xoZN21dI/kd+eOdy0dy6usHqNltMdpov8wlRzKQjKYcTnI9j4YN9A5+rH1lp63rWdLBd/euPNc3vilSFhZlzuIs+VkabeP1eCsLEgvZuHH6H10F4IVyxld6Uga8oBZ4PApUjD19nfI+2WsiQePmybH09G/TjTPm8A==
Received: from AM0P309CA0030.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::32)
 by VE1PR10MB3792.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:14b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 05:17:21 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::43) by AM0P309CA0030.outlook.office365.com
 (2603:10a6:20b:28f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.6 via Frontend Transport; Fri, 22
 May 2026 05:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 05:17:21 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 07:17:20 +0200
Received: from [10.34.218.123] (10.34.218.123) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 07:17:21 +0200
Message-ID: <cbe8fa73-ea64-4567-a9be-4447ace44599@de.bosch.com>
Date: Fri, 22 May 2026 07:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: <linux-fsdevel@vger.kernel.org>
From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: ntfs3: Use after free race condition in ntfs_read_folio()?
CC: <Antony.Ambrose@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|VE1PR10MB3792:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a9ca70-608c-4b9d-6b9e-08deb7c16699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|5023799004|3023799007|11063799006|6133799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	adgpixFMlLJ3kFM/ZB8lEV2pPxxUN4qi61flWUwzix0hEugSdTXs6y73ca0CnL3akpu8PIsOYKla/JrMODC7+elja/lsEdv/TABOA+DmYGTe2YiJIxUtd5F4fK0vg/dZpjCQcyhyFbZ3FbsK7vQelStTI+T8bMebiS/p4j8f0P2PGh/IxUlEs7Cgrc5oJH7v+kGSaLk5XqkvKSxPD0vybPxi5YqAy8u47BJI6w9pUDa7TUjLXSNrIDUJbd18XHyMgssr13lpgFFpfMxiUSwnsy39H7lPzAXD5JmGUT3qq6BFfcL4RwHfzhO0LMHDPJYcowHG31a6UyRoy8Q9rxVpu1ltKAFBVYfiqeN3tT4+NASBvYWnK2Gak1WgzRUx4jZb2/JAl7jx5Tct5mXBlPPnF1ZpO70c9w2xQV/ECL60K+JdMX35ev+w8n3zycf41AN7+/ewkEmVq8UYpKNZVzjq4kZ3BBxe/EqFrq7bvwGINJ7VxRRGRfq4W850XpdzAXWuqb0tDY1Y2wWXdrBlDwmlBwnXo+E3DsAUkqwx74aBMROtiCFSYDQ2VGpTe6Gw7stDCUMtCx0wTANdLf4segFQbrzsrYEjzrkDfT6PoON1P1hXQ0XBP6PNTgQ6w0SxqNe5LXXVRB6468tUkz9NTUVdKIOGZ4MvBO3Mxl93Oj1VUVkdnIv2GUUlJ97whWbBqO7/Zfi4FekeNqnLzkiPE545vqHssTE/QV0M4c/Vu9X3dgc=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(5023799004)(3023799007)(11063799006)(6133799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hAG0BngT/DF0XuOJPukV55wntQJ+teed6GzQs78KnpEjk8m3bU4ybEgLHwEWijnrx3uSQWqUwqVLbXRYzGp9g9ZhKFpsB3TxLr5UA7ucwyYAmDoddEvt2FK5/l1x2hs5J8y86iZkANuU/UHproaX4jgZHlBow8fld0kWnA+2RpykkFWN7aUZZxP3I5BV9KEhrUc4FakE8WBeTe3rWet1IRtOYVbyctNwHjNq2+pfyB5CxmhktzX6k08CD9QvvOQV8BfM29Gt7yXL7kGMTyQkBvDpJwpjLzqjtg8EMz4RxwWGDi5lizc9cASwGjlJTUwzcRDzjDqUdNuLjEXcLPqFg8rEznjUDFSHolh3mWwRAuw1u0BjX7Wh19tRdgapjp3c77bWD5HYS/gnQl6puNRfcrLjsGbKJGI5odv4DVm+os+AxT6pZl9zLoDCc8iwZw/3
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:17:21.0345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a9ca70-608c-4b9d-6b9e-08deb7c16699
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3792

Hi,

on a custom ARM64 board with kernel 6.1.157 we got a report about a data 
abort Oops [1] in ntfs_read_folio() [2]. The disassembly is [3].

Analysing this the failing instruction is

385f82e8 	ldurb	w8, [x23, #-8]

with x23: ffff8d623ef35800 - 8 matching the fault address ffff8d623ef357f8.

Matching this to the C code we think the compiler summarises

struct ntfs_inode *ni = ntfs_i(inode);
if (is_resident(ni)) {

to one assembly instruction to access the ni_flags in struct ntfs_inode 
via the inode [4].

Getting a data abort trying to access the ni_flags, we assume that the 
whole struct ntfs_inode has been freed, already. While missing to reset 
/ clear some reference to it. What in sum looks like a use after free 
race condition accessing struct ntfs_inode in ntfs_read_folio().

We have searched for something obvious in more recent commits but 
couldn't find anything what looks related. Have we missed anything?

What do you think? Any idea?

Thanks

Dirk

[1]

Unable to handle kernel paging request at virtual address ffff8d623ef357f8
Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
[ffff8d623ef357f8] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in: ... ntfs3 ...
CPU: 3 PID: 9611 Comm: binder:529_A Tainted: G           O       6.1.157 #1
Hardware name: ARM64 custom board
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ntfs_read_folio+0x24/0xe0 [ntfs3]
lr : filemap_read_folio+0x6c/0x15c
sp : ffffffc01c05bad0
x29: ffffffc01c05bad0 x28: 00000000fffffa00 x27: 0000000000080001
x26: 00000000ffffffff x25: ff00000000000000 x24: ffffff8d623ef4e8
x23: ffff8d623ef35800 x22: 0000000000000000 x21: ffffffc001591414
x20: fffffffe378c42c0 x19: fffffffe378c42c0 x18: ffffffc0109a0080
x17: 000000001b98ee9a x16: 000000001b98ee9a x15: ffffffc00158ed90
x14: 0000000000000007 x13: 000000000001d3a2 x12: ffffffce57fbe000
x11: 0000000000000001 x10: 0000000000000001 x9 : 0000000000000100
x8 : ffffff8d623ef4e7 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffffff8ca937808c x4 : ffffffc01c05bb50 x3 : 0000000006100cca
x2 : fffffffe378c42c0 x1 : fffffffe378c42c0 x0 : 0000000000000000
Call trace:
  ntfs_read_folio+0x24/0xe0 [ntfs3]
  filemap_read_folio+0x6c/0x15c
  do_read_cache_folio+0x144/0x338
  read_cache_page+0x1c/0x58
  ntfs_fill_super+0xde8/0xf20 [ntfs3]
  get_tree_bdev+0x1c4/0x258
  ntfs_fs_get_tree+0x18/0x28 [ntfs3]
  vfs_get_tree+0x48/0xfc
  do_new_mount+0x154/0x36c
  path_mount+0x270/0x4e4
  __arm64_sys_mount+0x1b4/0x3dc
  invoke_syscall+0x58/0x118
  el0_svc_common+0xb4/0xf4
  do_el0_svc+0x24/0x80
  el0_svc+0x2c/0x90
  el0t_64_sync_handler+0x68/0xb4
  el0t_64_sync+0x1a4/0x1a8
Code: 910003fd f9400c28 aa0103f3 f9400117 (385f82e8)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs

[2]

static int ntfs_read_folio(struct file *file, struct folio *folio)
{
	struct page *page = &folio->page;
	int err;
	struct address_space *mapping = page->mapping;
	struct inode *inode = mapping->host;
	struct ntfs_inode *ni = ntfs_i(inode);

	if (is_resident(ni)) {
		ni_lock(ni);
		err = attr_data_read_resident(ni, page);
		ni_unlock(ni);
		if (err != E_NTFS_NONRESIDENT) {
			unlock_page(page);
			return err;
		}
	}

	if (is_compressed(ni)) {
		ni_lock(ni);
		err = ni_readpage_cmpr(ni, page);
		ni_unlock(ni);
		return err;
	}

	/* Normal + sparse files. */
	return mpage_read_folio(folio, ntfs_get_block);
}

[3]

000000000001e934 <ntfs_read_folio>:
    1e934:	d503233f 	paciasp
    1e938:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    1e93c:	f9000bf7 	str	x23, [sp, #16]
    1e940:	a90257f6 	stp	x22, x21, [sp, #32]
    1e944:	a9034ff4 	stp	x20, x19, [sp, #48]
    1e948:	910003fd 	mov	x29, sp
    1e94c:	f9400c28 	ldr	x8, [x1, #24]
    1e950:	aa0103f3 	mov	x19, x1
    1e954:	f9400117 	ldr	x23, [x8]
    1e958:	385f82e8 	ldurb	w8, [x23, #-8]

[4]

struct ntfs_inode {
	....

	size_t ni_flags; // NI_FLAG_XXX

	struct inode vfs_inode;
};

