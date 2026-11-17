Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899845;
	b=L3pv0b/7BmyFdLStydeUaBBGaNO/dmIhObkRlMP9JJAH1HJgN3insNr72wWo/oOav79b
	 NHXkgtm+EtgAkezguQVTyvididA9OuvR6AW/6WNIKnETpoA6mLDsGzWRSQKcma/rrPnfN
	 l/bRLN1uwFvZ/na+P0LKSs82N5PsZzvbhyAIXmENXMQPv3CEWGkAK57sZL1pygB5o7Y8F
	 72bduzvmsskdmqiV0i7LaE367INssW+ItXUfk2uQxiZG+ZncD6dBQ8Q1GIr9te428Z+O9
	 PrAPBUrjlYwDF3TTfVa7fq49xV/seklACoT2zNb1ZDpnMgEHZa40e6z5q3fRsCNJ9rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899845;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GONDpkblcOJvLVbypKC+BDQYgzFpZgqqFHYTmmwdxyE=;
	b=nN6BKElRGdEoEuibWmaihmFxNOvTA1P0/DU9Xo5D8oteRyIKgV7g/E8QMX7h0xMSWaHG
	 iHZCTILjLI1i9WzzBSBRmypW25b4zmlZxV7/D7mddyCY5BKPHfuOv0/JE8ojrffBwI1vU
	 J+SwZcuBmfGoQHRpmAdIhZZoC4NohB1ChAQHKMlMWTt5APURVXEn5oZjUOCfLaVKl1duX
	 Dv0y4RlN9Di59815Q4ZX1RmHMfkkgUbc63IN1PgRbazbwAFZUW8BUjOfrDbYhYZbfd86q
	 ocDo4VejDRzeHMjxLP2YceJjzfYDNOIG1OF06zLdWT8Sp/Lx3zZnzYXI41nTAC1HK2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jzP8likt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.57
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5867606A32F;
	Tue, 17 Nov 2026 07:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5867606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jzP8likt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ9w4pOzQnXhVJxsKI+nJfYQsm2qplsrhauzaqUxxHM8VpVgnBrvtxV3cytdlQO+OzzqY+G0qT7vIbILU8h27qR/0ddzN8x/vwaz2TolDoQG9IGAm++2Svtk7cMNeaMNMxImhumeU7y0Ilj876hgnHGpkSOO3kaQra4IKFwUlZhl+DZ8ruvBGOqQu3S5nZSHw6gDuGxTKf78X/xX3cLDcUpKuYvCfIODWyYDWyu59KVP7ci7Lf7f9Hel5VCki5M+79N8IHd4VA2DQRIndKIvARdCc8v089+i81kKYx1V9061nVhR4a8NyAwqjRUDWwvbS1rxdO4yBzFiXEORKjtDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GONDpkblcOJvLVbypKC+BDQYgzFpZgqqFHYTmmwdxyE=;
 b=lBCkbmT04C6kLMW3nGQiVzFTivuLlOxlIydlkDpmljU5md1zTceXy6PFtDSXbWYqZnVXo0LyLVs91LfQ9oI7lQJ7vSRAHmUeAmj3NWMyGHL0cg0Mt24Y0+4XSlI7evsCAEqaIWdoPCEod+LjYajE+tfT+2DJ/faeZ8p0MIon92xB4SwbL6+KuxqXh2YsltKnkeRIemtX1iHLsywMpMgfDTHZ+1UzOZ/5itT/VgcEXlsBlhkYU/hBILherQMK+4KMmgkgASeVONT9ngzvTZU6+mzSJYq9+yOrQeXV8zSjV8vcS9oaIH30OlsjJrhYMETcZpHNdhHiNGXQpgJlRNVa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GONDpkblcOJvLVbypKC+BDQYgzFpZgqqFHYTmmwdxyE=;
 b=jzP8likth+eqRZizIqcboKKQm5Wgt3cR5SDsoFGSnt+mt3iw9ALPrF4JY5EcdM6WRLGJrrIMUWq13Ak1Yk9PplLG+8HYaIPnMX5mGRTObrpVajOZhPl0A2p3dtpyA+IFSnQNmesmSEfRloMlDY6KPbF59SNaeYw+akbZA5gRJsE=
Received: from CH0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:610:b2::15)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 07:17:19 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::63) by CH0PR13CA0040.outlook.office365.com
 (2603:10b6:610:b2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Tue, 17
 Nov 2026 07:17:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 17 Nov 2026 07:17:18 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:17:12 -0600
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 17 Nov 2026 07:16:49 +0000
Subject: [PATCH mm-new v2 2/5] mm/swapops: remove unused
 make_guard_swp_entry()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-unused-sym-mm-v2-2-2f845e94dd50@amd.com>
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
In-Reply-To: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song
	<baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, Minchan Kim
	<minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Liam R.
 Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
	<pfalcato@suse.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794899821; l=678;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=cbqqr7piF4YSkr6W1BfNjAnWbO0ioXEHfqpBufV9mOE=;
 b=HEWEpPe4f4Ay2ZJA82gZ/ns5a7GyQKSGOiU73CeFbHUnPdGid9v56zYN0ouXC8if+/LUzl48G
 r7hZAsH4DkPAV7h/rWq87+2hRuTVuTW8i9r+EsG4Is3bPe3TqiKQqSi
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 6069f1e5-ed64-424c-3e74-08df447ad09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|921020|10067099003|11063799006|56012099006|261021123027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VgicG9X/go0iyHTqhYMno9rSVZRUFhfGgLfXapYWsvf+aj+/FewaogQ4CNsXFyzO7FKVb5HmvVuj7ilqzxY2m3bOWqgIAPkCzYwJ+u5HniQ/E2S1Klp2MV7egUPnUKb0Hz+7zsrdmBBBMvH9qAnCmJj00y/NkkLIH8opQyOrvT0rGnOSh0A+egTMH9W5Mixs0N4YN7qwZzIexXzcD0s777qZEE5CJ+9o5zKk6H8rtLN3gNNzGmC8gmIOcBNE19Nv93aBgjtKNFaE5T7e0xyr3985/GI/G9wjeoFLdV7HBvTlBgGYJbj4Ms9fRu7NB/6hBXA6EKPvasEfx9AjqhUZcaNTh1BNI7neefj++tOCGma1+h7vu+7mrMF+rAaAlcHy3Fg2c8dVsO3EhCteEYjhVsZbEOzepPhMf5fCAQvrDZpKYzNTER+8EORpnVCGqwBXjuuylL1UiHcqEFRfe5uRIy2sZvpO552sW2CdHDL15YF+O+PVFyjKO/T9jqlaEAq3nuZ/9r6iafHrrXQ55p435HaKga2Hs4I6NH+g4gSBDb7nn/iQw/nscUNGuZxceNC2uoyEfsA9oCP1Z8IMPgMNMU+wGclej8zbJRPBVkTWdMPXgru3jE7/dVdAtw0s/cL/2Q1zKkDNKQAlSsogd+ZwRtprvC9AybW33VCGMZBmTQeD55iGMU8Z7Uamf9T19X+fS1H3JKJW2030RrQxBvFP5//wSjfDZc5w+AOR2koBqeIGlOHpITLnwXbOLpQRDtv6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZUi74z8kcsv3LE28EzhPDKta2SUOT6QMWx88Dl8TBn+z+a2Gq5Vnr0vR7pp6UTA6Jr2QqrOAj7LrJopZNfMBIGcDfVO/04MNUCrSB3aVxd8SyO2aUAdbPBdYD3YX/JqZgQOdtbmpVeWPPIYtrv+QBGxt4N3NnB4+n6Gli5cnC3XZX77pygjtMaizlptPHsWKeApJ47d3Ak+eP1Z/DN8KezS+tHH5QOfoMYHsN48Q4RHxKI9aOmuC51QQ+6jXkeky/z5NGr1dOHnx2HL+IdKJmQLhZ18/FJB1zcVRu2n2hzKCBiBc9kLo6fZ7k4mP3eUgIYCJI37xnrWGNQHj73HSb2y2PY8SygdvpBVvUOORE1lcaEkMCQKPs7xWN5r+MI7RhaG2sYI5tZXjQFpaLfp6Nc8LgFIhOhvi5X4aMtq7HDTFFzoKejZEnoqOrJWOLNPt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:17:18.5924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6069f1e5-ed64-424c-3e74-08df447ad09d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190

make_guard_swp_entry() has no callers.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/swapops.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 603f9e3f909c..6f62fc3c8cfa 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -306,11 +306,6 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
 	return make_pte_marker_entry(PTE_MARKER_POISONED);
 }
 
-static inline swp_entry_t make_guard_swp_entry(void)
-{
-	return make_pte_marker_entry(PTE_MARKER_GUARD);
-}
-
 struct page_vma_mapped_walk;
 
 #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES

-- 
2.53.0

