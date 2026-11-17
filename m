Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899854;
	b=x6o1Oz9c9gP0OrGzYF38tL7QwFYP8EIYnY+KWU4vCGqHk6fjSdlTGIRO7J2+22iHBg0L
	 FlJ20Z7mfn31azMujYMHQ/ASAJmoIyTsOhTbtZpm5TO9xpIe31ftMDz7+cTTgx67Qr/kP
	 Gc5JSPbJtQxP0BgGT7n80PozZjqdbAnz6yFfCGa+hLBLpV/sm1lOGwx7Dt3i0AWJ179Y0
	 hpVu8ZIkNKPwKTtM0bP/tnYvJjjcJ75LTFX9/WjIVmIftrCDjJ8rCkKeX4KXblm4zJz7Z
	 PwUfRBXOrjF4bUd3oRlHYDniPs6mm0ObBU1XHo4lX/vFx/1ECC0lhgK6LprUmMWUKwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899854;
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
	bh=C69q8YVfbq6Wnj5phIjJy8NVq8cn1ZrzPW8sluVzesI=;
	b=SIsFFLyB9m39RUXxTMFI30vGwhIIzqNKNqYApe5wvak2BObtPDsLYtxWWa3HUOqRXsZ5
	 eSrqcKr0rPR5SW43j4ede09cTF88m0ppihEXQk+AR7dZ2Czic1U8I7H2BjvHfFJ+EVSTE
	 qkv1x4grn8aTsf5ND9EGbmoIw1MlNZ4XXZz+VmpRVb0LUajqn5jca1QmzFXCYrJ1lDShZ
	 kXkAovwctp5jc9j052GY8FiPd7N2Wfb8FG0QhbDMTBcMDh5yoCryhq740+wGeG8pUMQOj
	 jwAwKHmHP81NobfoNgdVomVsQ3KsWkiumVXbxdFbHwKMk4k97GP3BA13jwUpvlvQiyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="NEKQ/k0H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C6606A32C;
	Tue, 17 Nov 2026 07:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 294C6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NEKQ/k0H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfAsnDC5hFo6TqEdYyQVTHKVpyuOih9GqZ4vhJ8OWw6UvF/OgKARe9AFJFbTQ7LQ/OTj0E0zgQg5mCeD0ci+Ra6+S3GXdLSOqtyzLN2b3Q7gatXWs499E6zqlvZuJee8wZ5mVg/b0qAOjBUdcIgZ/El3lJ5hjNLgazhuNQSw5h6fERtlEwPSV39EdEbBQ45tUL6/q+Phk1Gdb4Ppb6et5rB3FKE3amMP/SmlcLqQABAFpaOMrjQhOS0Evd4qW6n/YHhusTbQIvs3ec7c+DpIj3pWdgniGhW/pXyVTMzndYCX/vqEHh9UgA03Ler/fdTFvzaVTahsFi7rWr1OT3q+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C69q8YVfbq6Wnj5phIjJy8NVq8cn1ZrzPW8sluVzesI=;
 b=XSYbO9RfG7omq3kxRGzHw7q4ixqOWm6ihfURT4YYrkUqR+9gZ1dAKFitsmmJ/HrDPTitDxykvO6c3gO7uWJj8Zn8S0Lgj953NTVtpGMM7kF3+xlb6X0tfph+gPR6x3uxeajLwQn+L/ZOkd/G33CdiORLuAiH2YqTz2WYj68MCpP4E1i5CgXApgsBfiyjso70iJR4zeeL3SgJQkL6zJXAyGB9JbjkvsDc65jezGd7wLC0jTc6NQAUzrzAxU+rw47fpwIqiBFf81tr5M8C6VMpPfOvHbcnjnCDZ5qBS4DUZvde61MJ7qA2ZHe8jCbEe/CXUkkBsgAn4Em9nMj2aTQqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C69q8YVfbq6Wnj5phIjJy8NVq8cn1ZrzPW8sluVzesI=;
 b=NEKQ/k0Hhz/HC4tyEP+oMZQuPx0LGUMPfYLix7PUAx/yeE3TCB68HvdJVGuFZqyHpBiPFbcoIG4QVJVCCEQsXGoJYeNqOPQa7scE+3JsmrgdE/O7xWKnxHp3Uf/8S7s6dsyJP0EkSt6/fy4JsAHExcOukaLxXO1gg3NpsNbR0mU=
Received: from DS1PR02CA0028.namprd02.prod.outlook.com (2603:10b6:8:44a::9) by
 CHBPR12MB780315.namprd12.prod.outlook.com (2603:10b6:610:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:17:30 +0000
Received: from CH7PEPF00000019.namprd21.prod.outlook.com
 (2603:10b6:8:44a:cafe::a2) by DS1PR02CA0028.outlook.office365.com
 (2603:10b6:8:44a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 07:17:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000019.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 17 Nov 2026 07:17:30 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:17:24 -0600
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 17 Nov 2026 07:16:51 +0000
Subject: [PATCH mm-new v2 4/5] mm/zsmalloc: remove unused zpdesc_lock()
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
Message-ID: <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794899821; l=774;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=pV2CJt/tj69awn4Duh9GB/gFNsS3CYaXfVzki/FvS/w=;
 b=Gk2gq5M0QxfvARTMU7dns2zud9iawP3p+8ErGLADgmWplO6E5/AgvsXMCGv5eO66vd9Me0n4a
 t4I0boVzQaZDOduPMXov9Xyxhn59U0JzRbY8JkNtbTFR9rIHncZW8hH
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000019:EE_|CHBPR12MB780315:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d60d2f1-340a-4dc6-424f-08df447ad792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|7416014|921020|10067099003|11063799006|56012099006|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Wbq7r+a0QEwQR7OOz+P/df6kZkPLuOyAjhbpeCbDqegIvcy1ZEw8/DbRrOfsLhLfg84uqaXul7/Inju1DZBgOwFw53pOp8Yh0fBD6WpIjurA2MoVkMAnlGeFUvfp+gj0rOv5UmaVbDuvEc7F3nI02QcftckKgkkj9+GXqfCRVjTLMFK2q4SLxXeB5k44wjDUVApoeLJqLVLP7JvfI0gfKzBDriu1oChvw6lPgp9CT4px2ynsBYCZuQrKt1wHvgtP5MojR9d/W9+BnwkChvZDLvGpL/KrXgLRhPU2tb5lrWM0n5P06cJOl/jGdMbnGiHFYtfCAHQzymehA54ZfFJPol/fw7PPvDXyUYHN/GJPCx/Nk5mcP1KF/2ulxrLvC3PzFQVAACG+EP0L1wTijxIyV6LQgpLTfMhcK16qL6DkEhQCwe3lpfby4GbTor7fVWPq2rVSZbADpkPbM+eWV4doU844qzcpD2eVNU2m/zlw+ey7musfa5SMzDIvN6ya0/AL7K+gJBM6kRLb9fu84bWQs3smgB4GeEdmcyHj33u09YlZexAjwquPx44VeONLynYXY0Yp75J0aBSalOEDlTKA18mYtl0edcW2LLrkHOVBYV/rv616bluVjbr6oYSgp08gttk2RNRmbdEK3uFMu+Nu0yqyPirEg+ym09kzkWr3Vwmvr8MOmciXGGSH/K3YHwAc5CRPPOUTimRZs4qDwX+9fFJxiU1gka6tu7W7CaLsVF+zssBpOniCMlvedRWLWWiH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(7416014)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Ax+9L1EheMleS/ax/nEvPYs+odXNUcw+FpItXvDH10jBWwJum0hUZGEGeDSOqZ2VwzeJ4Sfd1S679XA79IGsKa2R4ywqFTi10c459/MxH8aO82n/J2Yhd6qGjZEwGB/Sz7GFnVE/iEGNzG7sPi77Y0s6eqHlHCdq2ZQU/XxeV+BZ7dLja4BLd8kf/9oghNrR7WD8By0tPEVcL0UWq8vdqISSnwGESiaGvnmFf0Gf8wy525Atnau8X+Iob+y/RV+JntkuMb6vj35S3cuwCTCqO5YDDH61cU+ieNhAOKyIiGn2+4UWO1hLSaEvtJkWZz+zLim/2D8/n9Yu4ZbRka9INBv35lTuENReMjIOMvfM3imqaiBvRAcOIIoHAhRNWpeJBUbIYRPITek7Qg7bV5AQcFouBSR5LI+Hb06ln4eqJ8rPOfrw23A+xlBsvvmy/lC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:17:30.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d60d2f1-340a-4dc6-424f-08df447ad792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF00000019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB780315

It was added in commit c1b3bb73d55e ("mm/zsmalloc: use zpdesc in
trylock_zspage()/lock_zspage()") but has never had a caller.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/zpdesc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 4fd81c2e8076..aaab5f1bfb52 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -107,11 +107,6 @@ static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
 	const struct page *:		(const struct zpdesc *)(p),	\
 	struct page *:			(struct zpdesc *)(p)))
 
-static inline void zpdesc_lock(struct zpdesc *zpdesc)
-{
-	folio_lock(zpdesc_folio(zpdesc));
-}
-
 static inline bool zpdesc_trylock(struct zpdesc *zpdesc)
 {
 	return folio_trylock(zpdesc_folio(zpdesc));

-- 
2.53.0

