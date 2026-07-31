Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD832EEE6E;
	Fri, 31 Jul 2026 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464304; cv=fail; b=i+GqKnVI300UkDMjPqg+vzX2ZV8LXwLqD84Z7wmqAiQ1iXT2GSXd1thI8c2I9+ax5KFTm1LhfXiqpUXllwyjdfgDz4dit6YCaVzVw/QneL0F4X0jgjlUpMJOlCO0BO7X2HiLkpID08YtnVWi7oMD3XJNBW+FaFuedEr/4wpsN2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464304; c=relaxed/simple;
	bh=Z8lnlc+4pGNvqiMseKnSvzjO211k1d/PJ8UDq0q7Yzg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kvJg2n/CZH8M4g/L1tAPd5qOnFyhPCBlnW9SAZDmLYVj9jCDmErEeITU/BPjbWN60yLc54Y8cXvoIytfRZZXemmxJTAXZkqQighnhQX1bQgkfXw+1IjBe+pU/0xQPrpRQjox55G7hr3/UT8dUzRmPo3hzlxav99OUSJa1ubBbLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WAnh5Bnl; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WAnh5Bnl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA7msslbx1TiE8RxFfRdAq5HV0QCTTo0BhBQDihkVOR/0jbE2xfHTU7YGsgpg4Qkq91FNi/xfAmNxLnSAQhF3psIvBYy8BNsjjYTxHa+LYBpB+jNpVCLUgK9kGJkcAI+qDCE1PuoOBxjgClfJ5AhHwPKCM9mMlB5attpfccjwsmuqd1anY5g6Hx0A8HTIBYrDlTOfTQd9gBov/TELy8tWkvrTUezaCC0IDfkPU9SsnJQXCpjjme5aQHSrg+gAmEU6px+WyM2SFZE18zg6B8G8J1QeFB3LYaXQprHhQrC/SpFZ3/OEjhGy+wf9/LpwH+vNSOWgZAADm77YhV/LaS6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY5bwpAnESOqNmfmI1rLpTXinTPe7cQ87HqGs9331QQ=;
 b=RVmppAXMM3FNSphJYqo0c1/ECmubgw3PivaLQUZhSQwINH0qJnUv9ZPk2wdgzaKcsqwpyRQORo1Nnzne61R8MQkijSIdXIOgTcSU2lyFDB0gn9gbNkZWmILBIcs0TSZBcAyKFdL+kfrarrTsdWsWgB9wV7ftFR4bNm+vCWmy5HYGn9JBudL+B3lhu3i/sejb1ldFIJ28I+C33f/6atLv9k1cubnL8xdOOiOPHuWnd8yptt+8GlAskd0sYDS5abWh/8pAR1izEBiC5e++nTsofp0Qij89c6FnEgsbQ6EP5Nf75TZZmVplERXLJZRrEFwsIpLGGu9kjy7wBN/ukJpO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY5bwpAnESOqNmfmI1rLpTXinTPe7cQ87HqGs9331QQ=;
 b=WAnh5BnlpIvUHti0K/lHT428Phd0vzqZogyl4RsMlPjZ3EvbVz14C63FEuZ8GHMttLSLAG+w5hCK5NeINMB5Gl18A3oGdiBSyFycnxEaiIPjB1MYq30RP65mWOKtWrRYb5Cj+W41TkKIavhoVDUgxmPdvdXl96bUcpt55gwebVP9lqYYK5sQEcfpLpxuBdW3zHU0NtGjLy1RdfwnbO3lkZYDluuA2cpX44meVXvLRWJVfxRN7rDmuLwhNIwSieR7niEmQj1cIPvhgameXc5SEA3mGBAhB78YP3Y3EOiv38TOL62NfuvvSZNx8YK3fwb+55kRximtGN1T4tjefVoGKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 02:18:16 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 02:18:16 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 30 Jul 2026 22:18:00 -0400
Subject: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
In-Reply-To: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: YQBPR0101CA0236.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::33) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: e0160c53-3e9c-4e89-bf9b-08deeea9fae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|6133799003|10067099003|5023799004|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	tKPw1+po71FhGSUCIdRH4UunC79TEkbStKohyrogOTPWzTWG4cRTI/9CnVxRgHllSzz0qmneM+e5/dfJyXR3ZpFMAEg2dW3nyx3vHYDrcCs8FH/dkyjOLMmRH3lZsU5+4q08YFwYH6s9gtRBGr6Lnny4zpwMxQLtKVdEl2dKt/GyN3gKJqMM4tmB5hSDD2OM7Lp59kQ0grTRKlTXybj4x3E7+s+TjN7CbfY9qYvWvJ/nGxKLvIdLtetYn6uFAKYnZU4a8V5p1X6qeb+6Np5lYASq8p8kLAjlEO+HSNk8EFUvI2IduStolvMmWn7veh/eBp7Fqnyt3OQF3VOU7Oq00AYksWQo1Xi7UcPp2LZsS88XZvyKJU7UEvSgQnKdDbz31O/OVlBPxIFAA6w/Z8Z8WjzvbSCoKEQdC08bkfuRS7OMJxXn0zijjnH8GpOC5YMy3pjpNff51ZLI5xEkiptSIfiIbTtpAS7g0PcU3CLwDRc5B2mMg8M9zDBJ70hqRlejY0YBahHIAec995p3KNC3BMm5P+vEhv3ISDwwILxc/MruXhiExwj76Yr2+JPUv4fq2xPtkYWfD2FV4au9QAkZiAqyQ7s5bXGcNbiT1z12V4G1mEcMt7qhgW6+/3QZU9Hmwjnxbqh/XZdrW/rLaetvJDWwiF3UpInwc2mkx18c/CMrRlqxFoxFuSFBxbLDQPxjmmv7fQfgQsTIdcHtMPosGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUhqM0xNdTZ4SWZsVm1MNld0TXJ2K01wUjB5TXVTdWxqdmhCd0Q2bjJZNmpu?=
 =?utf-8?B?czBLZ1N0MXppaW5sSnc5VW9sOENwNUp3dGY0RGg0L1RwR25zNWVJekN2Yk53?=
 =?utf-8?B?ZWN6cW8xTVFIaFpRY041RFdZeDAxQ3lxdjMvREk5MnR3dXZCQWEvLy9LM201?=
 =?utf-8?B?V3ZaeTZVQ2ZLa1N0MVFleFh4Rytzby9XMlVTSk5PajBiRTBiYnVHT2F4aFZK?=
 =?utf-8?B?U1hHZjRHWEEyMEl5R2xJQUFKRGIwYW5iUGUrY2RuQ3lFL21EeWNoYkdtV0lD?=
 =?utf-8?B?V2h3WFJjZWF0cStCcHVtMXRLSFRnbGdub1dmdWVYUSs1QlpCZjl4cXE5Ymdh?=
 =?utf-8?B?Y1YvVG1PYnYwNDh6MUhTK1RzYWNSOEtSVUFraUl5R0IxQXRhWFlRTDlMUmRI?=
 =?utf-8?B?S2RYUGpPeXFUeU9wUlNlUjY4ZFp4aEZiV1RaeHVJUDl3eUdUMUNMOEVLZHJo?=
 =?utf-8?B?YytGME1BT2t0L01ubkN0VmpQSVJ6Vkg1RTdUUHJBRG8xSlQ1U3owV3NtbDhz?=
 =?utf-8?B?Zm1pWjlyYTRGU0dLUnFHclkvb2M5MGVBdGxzV0JLanRGUXJZRkJSdmlnNzN2?=
 =?utf-8?B?NjV1b2gwY1lEVnFjRmo1Y0hVc3JJem1sUXlKWC9MTDBmMjRVZUp3RXJwVm9h?=
 =?utf-8?B?NlliWWFlLzNWMzF2WHpkOUJZQ2MrOUZ4dThCdFA2bXVzMTAyN1VXQzI3UUFX?=
 =?utf-8?B?ZHp0T0dTL1pOVmxOMldXbEdFQVF0Z0tocllLNGZaT2FUWkVhM2tLay9GMjgv?=
 =?utf-8?B?VVVnQXpDRmhTTVhWNzlqTllMTENiVXJTc1JNK0VYKzdCeW5QeVdHOGFYNGZG?=
 =?utf-8?B?ZElNQ2FKREk3RXhHS1hBTEt0OTdlUURlelMxS3U1S0JXSTZkMURaVkFlV3Ni?=
 =?utf-8?B?VDN3cjY1YnVZaGcwVys3VUEydTE3clM1NlZqbHlucW93NVBkU0N3NmNDU3Qy?=
 =?utf-8?B?ZkQwSSt5anRvSWdBM1JLY2dvaE4zWTVwdnplQ2NqS21pOWJER3VPVjBLNGpt?=
 =?utf-8?B?blZ1OUtObHErL1FJQmNrRGtlV25rZm9qaFc3dSsrSlUrVDRvVUxYVkl3NG51?=
 =?utf-8?B?TGQ1NERIb3U2MDkzYytNNFJzTUtkM0FNb2JtcnhMMmVZVUkzeTVFdmxyajlp?=
 =?utf-8?B?eTFMNlliZjVqQTk0TXY5aG5maDVGanExd0dWZkJSaUZUSjhqYm5aVXA5eXlS?=
 =?utf-8?B?RXp1NXlZZXpDQ05Ua1B3SnlSSFpZUkJUczFyaU1nZ0syRlo3c3M0NG9SUkVJ?=
 =?utf-8?B?M3JGV1lPTVErTlBzZUZtWXNhNUZOdm1mOGlmcythVnNlZ212SFplTmtqNTVO?=
 =?utf-8?B?NDEvdzVoTkdMWVQ1QzNmN2VENGV6Ui9hd0VVSi9FK3VjbE9MbWdIcGtCd2Fp?=
 =?utf-8?B?cVk4RmVOa2dleS9wbW5LTEVwTUk1eTR2bFhLTGcvVnNFWndxWXkvYU5rcFZ5?=
 =?utf-8?B?WVdZTXZkL1RrcmJnU2l1ajhUb3F3K3B0OGZVNXNVSWRtaTQyenpILzlEM1Q5?=
 =?utf-8?B?Rno5VGpKZ3pMclI2cC9lbzVrSk9YeUk4aEZJSWNPTnRoTkQ3QUp0aGhCUTV3?=
 =?utf-8?B?UjR3L05SSmd3Z1FqNmlmS0hkbEpocXh5VE5NZ2xOUTBvaWZqQk5mdzNSenZC?=
 =?utf-8?B?VXpSNVpQVlBqLzZMWkF5dzcvNzhMcTRzcnlCY3ladWFBaE8zeGpoM0x4SVU5?=
 =?utf-8?B?MVp6aHJWSVM2YTJXNmkrbWFqemgxbTZrVDQrRzlTSDd2T1ltb1dXeXpyU0ho?=
 =?utf-8?B?YWxGSzl3dDZ1QWZ0djlzWEh4SmdPT25VdmFSU2FVbWVpNjU3aTRVWFd2Q0ZH?=
 =?utf-8?B?ZmgvTDUxelZZR0dKamE1MzlOL2hjTk5ScTdMV3lOakJtS05WMlVLZXM4MzZJ?=
 =?utf-8?B?aGlRdDZGamRPYWUrTnkxVWIyZjBZNEtVRUoxK0hvMWZGamV2b0xUOE03Y01G?=
 =?utf-8?B?Mm5MWUtYY3JGcUdZZlBBMVBkcUVpWHpldGZjdW1tOENHOXN6b2hKMXRUSzAy?=
 =?utf-8?B?SFRpSGhVYXhRaVN6TU1Va0M5VlRPcUNtT0VVcCtjMnVpRytpUmxPSFJ1dFJv?=
 =?utf-8?B?a1lrUWZEY0hZenVtdk91U3liRnB3MUdKUml4RzlhVUkvRzNpdjVJb2dRS29m?=
 =?utf-8?B?K25TaDJuMHpHc29QQUZqeTI5RUhkWlZydDk2dXAyMGo4MmJmYlFWZ3ZzWUNl?=
 =?utf-8?B?V3REWjBKbjN3d01tTkU4QzVMQjVCbERTUm12QkozSVB4elk2ZUM5Wk45TThF?=
 =?utf-8?B?Rld4MElFcXVlalVDOEhlTHZhSk93dnRYMXF1ck8vZG4wZVBJK3ZnazRtbUM0?=
 =?utf-8?Q?/Q4v95cIjCZTM6wCKX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0160c53-3e9c-4e89-bf9b-08deeea9fae5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 02:18:16.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMD+AG4H61VqQYPMWghJLuhT9gXxZQ18W+GpRKOZ6DSeJ3D8NQQUTJ+fCgJAL15q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

During a pagecache folio split, an xarray node allocation can happen and
needs to charge at folio's memcg instead of folio split invoker's memcg,
because for example folio split can happen during reclaim and reclaim's
active memcg might not be folio's memcg. Switch to folio's memcg at the
beginning and switch back afterwards.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 04e8a6b553435..b9c2d8908e564 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4063,34 +4063,42 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
 	int old_order = folio_order(folio);
 	struct folio *new_folio, *next;
 	int nr_shmem_dropped = 0;
 	enum ttu_flags ttu_flags = 0;
-	int ret;
 	pgoff_t end = 0;
+	int ret;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
 
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at)) {
 		ret = -EINVAL;
-		goto out;
+		goto out_no_memcg;
 	}
 
 	if (new_order >= old_order) {
 		ret = -EINVAL;
-		goto out;
+		goto out_no_memcg;
 	}
 
 	ret = folio_check_splittable(folio, new_order, split_type);
 	if (ret) {
 		VM_WARN_ONCE(ret == -EINVAL, "Tried to split an unsplittable folio");
-		goto out;
+		goto out_no_memcg;
 	}
 
+	/*
+	 * switch to folio's memcg as xarray node allocation can happen and
+	 * needs to charge to it.
+	 */
+	memcg = get_mem_cgroup_from_folio(folio);
+	old_memcg = set_active_memcg(memcg);
+
 	if (is_anon) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
@@ -4231,6 +4239,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (mapping)
 		i_mmap_unlock_read(mapping);
 out:
+	/* restore to caller's old_memcg */
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+out_no_memcg:
 	xas_destroy(&xas);
 	if (is_pmd_order(old_order))
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);

-- 
2.53.0

