Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899833;
	b=fUkJbOm997+ETLBd6HkhIgk+hfwvVXN8bnlqZ1J1bdVhoKoSKpd4JmrvdGmiNHtY+Tiq
	 OGME07txYSvs+xIC7t7k+YIqWbsCQQwaTkPv1E76J3SGrSdCAfWgHOzxNpnQQJhttdvTN
	 1sy9HKsKQs+22tjz8vRFPGyIitF/2Jud43bc6HMxee5ArU4DHIwajROE1kDTzYjgiw2Fq
	 820rl9Zcn0V/2+TCxtYVv1NroGAcKpfkEWbCD9P80UQNSbEMcNxbfVooL3iKBxOOKqnZo
	 tETqRJb7c5IBHxIe/shNF8rbSi1aYwwFRPLvBHVRIs5pjAfi3DsHoi5GlQ//u2JwCNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899833;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
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
	bh=+xV+Q/FmcEg+DznkN+seFJKIAO0Dys4NqSGGXgUOSug=;
	b=hTbfEphAZw7wzuK0BcBditVMZKXNx2xlIrHjalmTibKaAJA5BVTZnvUz7rKqsjYtcJlA
	 JiQld0/7JmhZoYUaa1Bvxw2p4qBJl7LAKSHDP38aCq9EqHntL3ZXEKfxhccBHIlU8ojAJ
	 GLNHGbIKYbp2ERhzzdD/VoqPNhx3/wBZ7NtRSjdBAYk/M1lsx3LeU1j530OsrY5QnqwTk
	 Qa1kTcYWMmCsbA43V1igDqtE7/Nzgi2mnC7p/XnwA56BB7ZqJS81gQ3t6ovc1gYX6FrXo
	 dimwSqUTAM65UaYgfFkrMVA+6v5dZ43ld/ldD1KdSu6WbEV5ytxv7/iIv6HT9eUjO3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q1K344jx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.40
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C3606A31C;
	Tue, 17 Nov 2026 07:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 329C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q1K344jx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5s/HWUAXQvjamLaRznlhCiI1Eohpv+X6CoF4kPnHFuc4awZXUB+owgJd+XMJ1HgvYm87j944A0WtMtGRml2qjPNT5mD3XuRLZbdmFlG/cpG30n1m1/9xlacMFuFBcwhABmOCB7GaJt6TOxF9M4H24NTSz0UGHsIv80OlCr4s/oaabTVhSK0oYPQtsLJAOHNWtP/ymoEiP+8gc4MrK+iy9HsXOXuW1tSWEw5S53Bxub6xITy/iXi7U17ZLBuUk8Buv4sprYyMRNoLx/Gk8m15iZHhDPATbzugb7q/TmooyLt1VmLWQlAj+11rE9uPqxux6sDKh81LbfT3iIriVq0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xV+Q/FmcEg+DznkN+seFJKIAO0Dys4NqSGGXgUOSug=;
 b=TQlOz0ut8/G8BxbuaBaEhgcN2Ji90zJi/qkRMXnN7B6NsQAFs8o0Nb/Y2tsHfw/hUaMvoWOfmJqf93UiGNvwgxex+OnlWRMc0g+HgcYawakMI0SJ/zE4Y/A+Z8Tl9F7r8/ed1dN4WCzyMLpkh76eZZG/dpG5COC9gprPwpL6M6rpJNRdPsKbpa1RdKltP+rbIRr+cfLHBhWk9GO2DipWWFLlxRogLSVzwahjAyTSPLVlpfeke1/EbdATVggFiIoLUHnSgXrqYbxgDwsla42YZt21pP7tSAJ8pZzVQ48vlMw0e2lxu5WvdcrClCS1+3hqCxEDdCAukD3owbIfWg+KCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xV+Q/FmcEg+DznkN+seFJKIAO0Dys4NqSGGXgUOSug=;
 b=q1K344jxMC6hBDh96wOmu4oO2p2CiySHm4XgK9dBBVBmpkygIk8YdvQ2HtoxOMirZcOl9rk4XcvWoDp9P9qF0dxe0Z0dl4wibIJDMfQRob3O3kQXi55r9nHw5hsZBaWwdtBn2k1ykeABFoPxkY6dabho5ZUmOI/3z4pkDGAenNA=
Received: from CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::19)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:17:08 +0000
Received: from CH7PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:1e8:cafe::4d) by CH3P220CA0008.outlook.office365.com
 (2603:10b6:610:1e8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 17 Nov 2026 07:17:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000015.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Tue, 17 Nov 2026 07:17:07 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:17:01 -0600
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH mm-new v2 0/5] mm: remove unused functions
Date: Tue, 17 Nov 2026 07:16:47 +0000
Message-ID: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G9CqdfmKeBAbNYdWaXCj+HeLx
 2GYCSDkmQS6JICnk4U3F0GlCUzr6BZCNpFBZUrnedbi4Q4hg/JYtBabeax1qVVVFwSx2T3NfP+
 /HqJ3dMHwvh/93C6dZwAAAA==
X-Change-ID: 20261109-unused-sym-mm-8fa76462573e
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794899821; l=1262;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=9cQhrJlly/ClG37s4BEv1CH0T39zF1bHVJy1LWjiDOA=;
 b=th6hHOvFrEmqdr7Z4/7jLH2lvS2jUjI2hI1jhBhntNeSKVC+1vgstOoRc9zCHNMyJGlBqC58N
 02u3v1K2OtvAYFmkRAo0/2mgYz6kwPwQ+bHYn/Fjz44B+iAtxTsMtIc
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000015:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: c53d4ffc-9ee7-43e1-638d-08df447aca14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|921020|11063799006|56012099006|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	dAByAkezUlZesjhhzopVkRn7jxXkDm2Yr6qxPX5XVjp3nh7iu06evsLj/bSuvyrwfnYQT+vOZnfnuE2bi/AjlIC/fqmVD/pLsg6KrnlETUSOOAfIUKkAmxGgRVMhIvKvQDoknmH4aCut4yCIylgh94wyhdDCUvOexDSiHpcrMKO97XiYnJmBoKOw5oBC5qoUuUkGpnJvGh5afPP1bbKbITs5cUWytAzeMg9bZkKJB47sCjcznTYn1kqt0TAnbDFm3a0RmFogJZLiY9bUDTm8kUHgU6vzWf7h2t143cGDeqnoIz2EVzfvnkSwtpFmcg5+A5C5G/3j9H2dl9dcyp470fiQ5Eizkn89RqpovH6BrSOnfTSptROb6ASoSL5Sm37ur2KcOcSAkTHi0dJEl6lxFDudWJ8wA8Lu0kb6BnoFy35EscGag59mHjQCUqP+V79nGUF962KBCyX6kslw11MJ79VXun39PP5UX3pOx8H8zVi4julyHaVEADsrqhSEhuUfwVVVu0vvRVVP/uVRAwaTN7cCrASBVsrX7CNctRSBy/PYhMkeqM9P6V4OdULTQCnxQku7UwztJ2aqNJ6l+99DBj9gqqR7fuKhwBfxVAse3jALPsz5SqUE+Dd+GoBuC85nd5VIJynY+F/GRiW5OsSo8QHPVfe5044HiQODPTkmzgG8h3Z95oiAVw3C/4myN8b2CbrUth/Fj0GdYVwjXe4Mqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R9tMzjEudz1Q/wQ+CNRd1ZqgEP2avBUzCXtbhsD/z4IGzdmu0bxSzYqPFKL8qKctD10eQvbltTA/WCp35/gS5xJp2QMt/PpP8SIlqjA6xOvd/IWsVU9crsmj4fQyaY+XZCjPySZ/jo1AKjtjmQZKB+CpXXxO9UP2nSsD+XxvX7slEMmnNu5qBRa6jp9SRb7BsS5hMxnKaPuDWa25+1huaAIYOCRqSilINyl1jV/vcg0MUhEhutidQoVygfJeTB8Unk+n5k3psEtrTHW6PqqYcG1rH2abxoEiCEhhaKCAp3kWrrpVrhZrxum2a/vfRn7rffNHgVV2UULojIfr82RzPJT+zDWjA4Gw3Slm3ivQX3zHnxNKGcqUUw0fGhm1NZxq2yB91qNxlClCbSQViPRyEeMN1EuGRXKFkHmgbJAykUvKoy+9lQldg/9xVWViR7fL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:17:07.6381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d4ffc-9ee7-43e1-638d-08df447aca14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422

This series removes five functions and one variable in mm that have no
users left anywhere in the tree. I found them with the kunused scripts
[1], which I wrote with LLM's help. The v1 cover letter [2] has more
details on the scripts and how LLM was used.

Changes in v2:
- Split v1 [2] up by MM tree, as David suggested. These five patches
  are based on mm-new. 
- No changes to the patches themselves.

[1] https://github.com/AMDESE/linux-mm/tree/shivank/kunused
[2] https://lore.kernel.org/r/20261026-unused-sym-v1-0-82ca2dceabe1@amd.com

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Shivank Garg (5):
      mm: remove unused helpers from pagemap.h
      mm/swapops: remove unused make_guard_swp_entry()
      mm/swap: remove unused folio_to_swp_tb()
      mm/zsmalloc: remove unused zpdesc_lock()
      mm: nommu: remove unused heap_stack_gap

 include/linux/pagemap.h | 11 -----------
 include/linux/swapops.h |  5 -----
 mm/nommu.c              |  1 -
 mm/swap_table.h         |  5 -----
 mm/zpdesc.h             |  5 -----
 5 files changed, 27 deletions(-)
---
base-commit: 67f3b04b277373438f17300e056306adbd9edf7b
change-id: 20261109-unused-sym-mm-8fa76462573e

Best regards,
-- 
Shivank Garg <shivankg@amd.com>

