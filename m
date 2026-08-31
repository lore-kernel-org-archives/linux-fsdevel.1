Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69242367B61;
	Mon, 31 Aug 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204371; cv=fail; b=D2zbcITe8Z31U8HNnaHjdzPgffCnhm5POkTdP0R9Rkgl8kebr0pWZ5idHIImPNLozMYg79ln1n2hZN/Z+ShXHdTZVJ16pWR4hbUXZ8wQpvezJZJTCCxrqNo70XweDpco7UD7w8IS1Gzr2wh0iQEyqQGpBwcUGsUKDQtZxMIT9jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204371; c=relaxed/simple;
	bh=AoOFwRHcUPe7Ul2xB8c1C6qcKxmtuahH5GmysL6Jprk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HjLOCHk9sWGMTsjBYKpPM4SiCaLqj62ZgOdT6fVgY8cDwV3t1Jw9NwHN9VIP4h4uqXWWu9MiEWFts6780mP9bEMISKQ1++gErJ09buG7dEEv7VMVdVWMhoXUCGNyiiL4HwEwnectzvOIlUBJjtm4A9i/pI2JD4K24GMBkGfXR/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DqDalye/; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DqDalye/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmN/ODJ6Gr/3rzrPcdVrNkC+Ysd5YcWG4n8M1oe0JHRPlc3s7gIEueV0pEoMcTVoKlvtFZ+7Ys2oFNIdWb31ehWEfX9D4bEuKfq/QrOjkns0bKVuz7soIJzV5qtO5YVlBODsG6PqOrD3WZx7MGxQHgKAiFePCEVYko8wDgLmUB37YTebwfeTNG+4vFmOY1FdcFpt+H3yh0a4uGXpWBCzO4zy/shhcYXbp5q5pdMuBhHvFSrkx/w0PKpteMxSxmtag7JKv9YEB4xIH5Cna/7HilO7eGPvm5qXGNtx9pnh9qTy/w9nsJhSQmhYWRpc4kbpGneg4dJRDQxLqkUbUBeQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmiS3zJ8+gLvEmPROyGfTdnP+5xIWzIJ8ixlUsSG0UM=;
 b=bK304ak/K2LzplCOYLPuiRDAuzfC9AOgI3nSicbkh/vVt/uUna8fMgR7zKHuIlhwgxNots7K1kiUMTIDZHFnAyDiejW2ibT1nAcG0xfWWyUNZQakJh/SMyM661EnFKCSn4kUYPRtrqp7S07CgdIrZ9fGVzx8OYZVNm7ZQ1Qa6KQaxXVLU3D0mGvl/1HWzpY+J61sPZ4XoMrD2nQ58545MBDtoWP1lM71yP54Yh9ijcRpPn16Ga6vDHlwK4u/E0wEgY+EKEu8ncpjyQ/p67v0A0Uixb94Yz0YHXwY6SPpUg2swd5UkyQv/q0XsPtO1YI3rf1QUIDhS8duHCKlGn3bCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmiS3zJ8+gLvEmPROyGfTdnP+5xIWzIJ8ixlUsSG0UM=;
 b=DqDalye//TN5IWfzMahUNHKVU4a77sPchgBTBFxsgfbmtrX2PnGGFwmouGjzpOEI6wLf3wgTK5SUgavvJVbe6isbIpojwISla8cxB3ht+POiQB8V+BEW/ByCgQefkNdPEriZxC7YQoQIqOMhNwtao/YA7eZG+cENAJczqQGCnCTRQM9vLP7yG/fMW6yqwJm6BbLoV/0qIRdbRntt2+NaiTAWogJNCmYEE3FzYQzSzhUkYMCb3EN/I25Y8OZt31a3Em6uF5ZKG5z22eVqxb/WpGTdVrIxYlCVT5zsxR9Ptrey0dSQhPqzGnXwTVhUarAXklTZCKG30i+6xK9+RtKhEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Mon, 31 Aug
 2026 19:25:54 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 19:25:54 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 31 Aug 2026 15:25:30 -0400
Subject: [PATCH v2 07/14] erofs: mm/pagemap: add readahead_folio_last() to
 avoid folio->private
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-remove-pg_private-v2-7-3668159cd9e8@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
In-Reply-To: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Jan Kara <jack@suse.cz>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <hongbohbli@tencent.com>, 
 Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: YQBPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::20) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e162e5-4022-48ac-4630-08df0795a9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	jNhDQFLuMGZ0W/PW+ti5tfP1ZOViw+BHkuYtLtFMYS9XUeSkYPJTX4sLMVVTj33r20AJMrmnTGSlhjLNrkL0yuhhLT0hVjLL5e5MY9ivjWKqpGTu1NghDXIc9Dol3F5FlxY/lgPFsvcbvmS5cOThDQ/Nb/hbLLhWYRkGodQqrzv7uVLU3PMXYNPDv90ktUgzVl/IwQeVyySOLC1pzOkLlr2KZUfenc06mXI+ftND+1LOuepZ6VfvX5941GRdODG8YyDCTFmPPq2cNlIsQMqlBKFz3E21DMMunYlQWXGhJ11tVkpu+vXEookTy/qSPvdJgnXfGozJ16x6xXto/JQiGkyGKYl1ZkvjWnVr7gf7kCUr77EpP7zt/Z/haovK954I7ld/cBeMOewZfhCHXPxeW8SwG8G/FsNeYBEapIeotDM9fB1C2PQEE5sPVGyJ2O60DSScqY84AwRNxC0bKGvguLL2ZTtMmCULNqVVfDhKQAm/h2vvBAo/W3aJjYO83/pvjjexGVE6OitIZlGGeLMGRA4CJnSG/d8G/4NqE/x+It/aSpyJMMlvlf5IVajkGtdKxxk0WbSWxwZ8OBOvxu1JSifnpDW+ghK4Jx8UUoA7mih79gVTmuu5iZVyu7cpAnCyg9I9BaMLOE9PH2Jqx/Ed/h0UHFGyKwvckFo6wJrYqAkN5SuNY0d4Q0sNmkhMrs/68u4UtoE9TKgGOo7rHei9+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkhuNk9WWkQzc0laRG9HUUFoanRYNGRoMkNLd2I0MDNaZENwMWdEL0lDR2dD?=
 =?utf-8?B?RHdPOWZEQW8rVEFGN1RwU2NZcHNrS054WFhzVGN0cjRUZ3Bic2dTaGNyOTVi?=
 =?utf-8?B?QmM0dUcrZENSMDhYa0hVQWZYbEwvbUU0RkpsRVE2cWJvTElBL1BIUk40c0ZS?=
 =?utf-8?B?blUzYkFheUFKRTRnaHlPcytPbjAzZW56c0NxRFR4TWNjSUR4eStLUzh2RnBB?=
 =?utf-8?B?c0ZhVCtHWXk0dWk2NHdCOW5CdWQzVXBINnJiUERxazJoMmRoVG9jK1VJRTA1?=
 =?utf-8?B?VTQ1N3JZWjJWd0pnNGZhZXBiY2F2SmRmdVJvWjFDNFc1bE9BZlhXSmVSZHh1?=
 =?utf-8?B?S1hDSGtnWTJoSGZzOGlJQTJMeVlFcWtkalFOSGZFcWNwQUdvS215cjZFNTcr?=
 =?utf-8?B?dFc1RHlMRVRxYzZjUWRmV2xidGpzb3Q3ZzU1RzZERmN0cVRXYm5Hc1F3aGJW?=
 =?utf-8?B?SUVTclByWXFXZ2Q3VW1HdkwwbnVpZ0VIbUZxV1k0YTgzbGtBdEJWYUJvSW9Y?=
 =?utf-8?B?cDlmemlYaENQbW9UVm0zcE1aeW0zaTZETW5PdFVidEZQc1hPYUs3amNsU2Iw?=
 =?utf-8?B?bFgzeE5RMk9FNm1ya3hSV290UUZrRnlBV1lOMVhhQXprYmZMYmJKZm04eVJI?=
 =?utf-8?B?SE1xVlQ2ZE1ycjZwd2cvWG1iUmRTUkJPNjBhbSthNnJKbkpqS281RXlQSzRW?=
 =?utf-8?B?TFdjR0l0TzJzbE1OcjJCWC95N2MyS3h1aVdsYVNMcE4zMUkwYlhLcmw4U2hY?=
 =?utf-8?B?K0dzQ0tLZ3lNcE5XY29UQ0NidkdiSEN1SlMvTnZiTTQ5RmxIR01yTTFQNDQw?=
 =?utf-8?B?Nit0OUQvQzNoRHB4dFVvdllmVmNpUk9KaC9DUDVDblJJOHRUY0NLa2lsM0Uv?=
 =?utf-8?B?WVNzVFJUSDB6S0NhbCtQRnpidTUvRm9ZdHFwTEZnQWI3OWFVUVhkYy9veWpv?=
 =?utf-8?B?VXMzY3EvTUlqTGVpTjBCR0plVUgxdTVZcFJnK2tVbVZtYzM5cEFDc3dlZXdV?=
 =?utf-8?B?b2ZTT1ZtbU5GSTJSa0xvS2hJdkhJSSt5dmRvU0t6aHRTRm9WVjRDLzh0eEJS?=
 =?utf-8?B?cnJxMEdTSERkUThUaDM2NkFERG1EaVlycnBYMVpJUTFmR0RJN3J6NE5HWHFS?=
 =?utf-8?B?NmFvWEdVRzN6SDNuWGs1UlpJc0wwYU93bmtOQ0QzRUV5UktzbnBrTTFaNkM1?=
 =?utf-8?B?UU5jK3hQVXlKbzd2OXEzbURjNjd2aFJidUdUbTlyWUU4TERQTysrM0lmRmhZ?=
 =?utf-8?B?U0l5eG51S1h5bjNkZTczLzFrYkdZeGljUWhWT0w0SkY4VWY1a0w1VisxS1N0?=
 =?utf-8?B?NVA1QW1SRGV0NzF6R2tYbmRrSmg0Q2x0RDBnUEJoK2pYRkVrdHRxT0NsWFNQ?=
 =?utf-8?B?eUhJbzNJdWcxcVRjUzdId2FHRVlmcFZqeVlVR3BXNFVEZ3dDVXFRaWZnNldq?=
 =?utf-8?B?MW1wL0ZwUzR3ay9xQmFvTjlNcHVHNGVnaFpUNVNqVmhyNzhBT290T0RwTVYw?=
 =?utf-8?B?NjdMa2J4b2g5Yjc0QW1zdXpOaEUrc1BvQVVXbVU3YjRkNG1mU2pSS240emFh?=
 =?utf-8?B?R1orY3VDNDVDRzVHa1VCOVp2dDhqOURXbmh5OVgxb2lyLzFtR3pRc2daK0FY?=
 =?utf-8?B?Tk82NU5ZdUY5UisxdFFNeWo4V3UzTnpRRlpIR3J0djJZQnplMWN4N1YrNDBp?=
 =?utf-8?B?MUtaV2JTVUJKeUpBTi9WMW1EcVFHQnBURVZQOFhxNDM4cnNrKy8weEg2OW1P?=
 =?utf-8?B?WUk1WjhMSHZxL1dIQWRPQy9ja0NLTU45VDI0VUhxRjdpSEJTN0FkM1RhUVVw?=
 =?utf-8?B?SkJFbnU3ZUVHeGlEUTh3bkdQYzYwSTRkOEhJT0NWa0E2WFFOVVJ4WVhoVE04?=
 =?utf-8?B?cWVhK0N0eTBYUURYWVhjaXVWdHdlVzd5WTZLWWZlMjhFM2kyN2dwUG03WlhP?=
 =?utf-8?B?cTNiWnhpdVlzUUNDQjZyRlN5UGtDOXFSanVPMVZLejF6ejNzYjgrVnE1Z3Zs?=
 =?utf-8?B?QURZcUZmb05yVGJVRDFpdzRYUUxYVW9JT0F2YWRxV0NQMjZvQ04ycHpMREF5?=
 =?utf-8?B?S2VLdFlzUUhjSytMZHptcG1XM0xZNFhyMVZaeEZYa00rcm9lSHhsRHV5QndO?=
 =?utf-8?B?TTZ0T2VoR0tQc3FUbHlmdHhWV1VVa1VSVXdlMnZTbnR6NmxyL3BISWVjRGM4?=
 =?utf-8?B?YXZkbDI2Y0E5VHFGb1VRZVZUaFNBdGE4WHJxYk0zNTFCNFdDaE9lSFdUVXk1?=
 =?utf-8?B?bytKVGk1WWVRUzdNVkEvUjVCRm9GUk13Y3dvZHBSL25ZS0t6UWI0enhldEYw?=
 =?utf-8?Q?10zWh80V2EKn2UN60w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e162e5-4022-48ac-4630-08df0795a9e3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:25:49.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ITzvUpcuLqw4Z4h17eUYHhm72+ssdjwcJUyiMPazmzrjAHRZRCzilERskSKvkZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742

erofs needs to traverse readahead folios in reverse order to achieve
maximum performance by
1. reading all folios from readahead_folio();
2. storing the prior folio pointer in folio->private;
3. traverse from the last folio to the first one.

Add readahead_folio_last() to achieve the same function without using
folio->private. __readahead_advance() helper shares readahead_control
adjustment code among __readahead_folio(), readahead_folio_last(), and
__readahead_batch() by checking new private member, _forward, of
readahead_control.

It prepares for a future commit that replaces PG_private checks with
!folio->private checks. After switching the checks, erofs's use of
folio->private without bumping folio refcount can cause unexpected
outcomes, e.g., in filemap_release_folio(), try_to_free_buffers() becomes
reachable.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Gao Xiang <xiang@kernel.org>
To: Chao Yu <chao@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Yue Hu <zbestahu@gmail.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Hongbo Li <hongbohbli@tencent.com>
Cc: Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/erofs/zdata.c        | 13 +++---------
 include/linux/pagemap.h | 56 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e1e25ca0d1904..78fd7d980e957 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1898,21 +1898,14 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
 	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, readahead_pos(rac));
 	unsigned int nrpages = readahead_count(rac);
-	struct folio *head = NULL, *folio;
+	struct folio *folio;
 	int err;
 
 	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
 	z_erofs_pcluster_readmore(&f, rac, true);
-	while ((folio = readahead_folio(rac))) {
-		folio->private = head;
-		head = folio;
-	}
-
-	/* traverse in reverse order for best metadata I/O performance */
-	while (head) {
-		folio = head;
-		head = folio_get_private(folio);
 
+	/* traverse from last to first for best metadata I/O performance */
+	while ((folio = readahead_folio_last(rac))) {
 		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
 			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0adfa6605653d..546e987d5cda7 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1416,6 +1416,7 @@ struct readahead_control {
 	bool dropbehind;
 	bool _workingset;
 	unsigned long _pflags;
+	bool _forward;
 };
 
 #define DEFINE_READAHEAD(ractl, f, r, m, i)				\
@@ -1480,18 +1481,25 @@ void page_cache_async_readahead(struct address_space *mapping,
 	page_cache_async_ra(&ractl, folio, req_count);
 }
 
+static inline void __readahead_advance(struct readahead_control *rac)
+{
+	if (rac->_forward)
+		rac->_index += rac->_batch_count;
+
+	rac->_nr_pages -= rac->_batch_count;
+	rac->_batch_count = 0;
+}
+
 static inline struct folio *__readahead_folio(struct readahead_control *ractl)
 {
 	struct folio *folio;
 
 	BUG_ON(ractl->_batch_count > ractl->_nr_pages);
-	ractl->_nr_pages -= ractl->_batch_count;
-	ractl->_index += ractl->_batch_count;
+	__readahead_advance(ractl);
+	ractl->_forward = true;
 
-	if (!ractl->_nr_pages) {
-		ractl->_batch_count = 0;
+	if (!ractl->_nr_pages)
 		return NULL;
-	}
 
 	folio = xa_load(&ractl->mapping->i_pages, ractl->_index);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -1517,6 +1525,39 @@ static inline struct folio *readahead_folio(struct readahead_control *ractl)
 	return folio;
 }
 
+/**
+ * readahead_folio_last - Get the next folio to read, from the tail.
+ * @ractl: The current readahead request.
+ *
+ * Like readahead_folio(), but walks the range back-to-front. The folio is
+ * returned locked with its refcount dropped; the caller unlocks it once I/O
+ * completes. Compound folios are returned once, at their head index.
+ *
+ * Context: The folio is locked.
+ * Return: A pointer to the next folio, or %NULL when done.
+ */
+static inline struct folio *readahead_folio_last(struct readahead_control *ractl)
+{
+	struct folio *folio;
+
+	/* Drop the previously returned batch from the remaining range. */
+	__readahead_advance(ractl);
+	ractl->_forward = false;
+
+	if (!ractl->_nr_pages)
+		return NULL;
+
+	/* xa_load() follows sibling entries, so a tail index returns the head */
+	folio = xa_load(&ractl->mapping->i_pages,
+			ractl->_index + ractl->_nr_pages - 1);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+
+	ractl->_batch_count = folio_nr_pages(folio);
+
+	folio_put(folio);
+	return folio;
+}
+
 static inline unsigned int __readahead_batch(struct readahead_control *rac,
 		struct page **array, unsigned int array_sz)
 {
@@ -1525,9 +1566,8 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 	struct folio *folio;
 
 	BUG_ON(rac->_batch_count > rac->_nr_pages);
-	rac->_nr_pages -= rac->_batch_count;
-	rac->_index += rac->_batch_count;
-	rac->_batch_count = 0;
+	__readahead_advance(rac);
+	rac->_forward = true;
 
 	xas_set(&xas, rac->_index);
 	rcu_read_lock();

-- 
2.53.0

