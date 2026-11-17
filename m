Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899850;
	b=Hn9mCF1L8h8CQWyB9WD4z8ZrF6Jyni8xqrh6t9D1eLu4ye6D1qAMJldYY6wEvyln58ky
	 ET70BY5dIlEMf4PUR2MkYNRZ5AMk3m5xA7J/M/FOX4Qg7Z5XC61mvXIWZMQl2avoEbOWs
	 JetXVVv2rzDznOxuiRRX8xfG3e+I0796RH1g1NiN4tdXWyLw25b/rnKEGec6fH7mO8HEU
	 71aS91nEBcO/Yl9wzgZoQ1jrbjzbhUIjSiM6KvtfTBmCDhf+jHzV2f5SCC3NLQ7flWI5t
	 xn6SME8RNKNlpOm+EOqXC31iDhaKDerRusgAtjpSthz4MfAr2aak5asbDmIyW8uc+uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899850;
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
	bh=yhRKRDvMYeKRq8t6wR6WauC4ymlRcWzmVHmXqCbJJmc=;
	b=Xnda4OKaQo56/u8zeVDUsWfMbaZiO2oalXH5sj0I2sjSNM+w1q9feG7v7gVB91FGhjb3
	 M/h2T/2T0VQVJEl7FFTJhpwsFlAdVAp5j9vuj0nRgCQz+pG0VrYtWPjQL2+g6YZ7+n+Jn
	 TjanYDHjsfilb5pJyFlBfe43eHbL1Ta9fvXAMqh3e8RRTCi5/WOjBzkA6GsFAhfmX9Glt
	 nxOoWG7ixzU9p9FKY9Tu4P4aKy9RjcF8SR8qBBjEM52pUBillhTms6yr9xCX8b59bWmhB
	 6aZZIWGUTPPuA2mjK0sYLRE7DYeUMce8a3zN1vUX+Vfrbf9Tukx3QlPBBwPkIGJOtGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S16ZteXu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.62
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F0606A32C;
	Tue, 17 Nov 2026 07:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B44F0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S16ZteXu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUrA45kxcrUXCNzFkSjVhlyjp04yOofBabNURNwqzP0HKlX9/CgtIHF3/CSg33ezr856WBYuyS7hMSw+mUHWRxEatGYiREqM3b0hz4M81VtFCXo0yCj75Gg+PjO01czBsjmYmCR2UawMD2er3Lx+0APy81hL5DC/w90fZxlPKMX11CGtRh7+ayHdQLqoDNEJWgSLrrH+Sfdn6oCvCk8hNXg6lm3McUtLbo2ZmTgDi0zjTSMLHHTiE/nfuPY2mu5hWmZ6A3vFc2v4kiCIWJlFyhK0j1zefdMv4TXjn4lAaFQkGtUXQeuV5lY9wjR4XECM6RAfkq5upQsm6/u0brEuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhRKRDvMYeKRq8t6wR6WauC4ymlRcWzmVHmXqCbJJmc=;
 b=V9ORzAcCVM1okEsH4FwY/TdhBrrP0C/EpIX1TFswYUpScdTRnJ/dzbarMAVW7QillLuTP0z/pqn9ZjscvWzZ09ij2EtheZQ5Op+7C27FNLHuVYfBGvcWrxrGRme3kPSg/lMX6iyIVcXAbNNQhPZC0IEkuKsOM89i5K0EqrXl6wSVb5ZlIUNZ5IJPFg5Cmz9UJbFz8ZPwQOAzEcP34SwKdudqH/9CUSXiP+Bz+wmCK2jLEQ4FzCX0pmrgNCHvBJ+M361HpnrST+P322LqJ2ogKMevSzFB+d+TVjbq5gOP7JytZQ20hQWgqDUlREvCJKpNkqVJ+EN348FkpENQgL2n7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhRKRDvMYeKRq8t6wR6WauC4ymlRcWzmVHmXqCbJJmc=;
 b=S16ZteXuiMncW4OX0Ya89BOXGYcaMMnoHD1hhvIdG6O3FPDq46IvvxM4H95OeVXwsJ1a067uqE9OJtMYCn2vso1Gzsdicdw7DlaIHKhKxckKXyiNChYzyf3UoGqp/hf2gABZHYzsh8iP0hIVBX32Mlbak0h//Q1gCWw1qFERQeY=
Received: from CH2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:610:51::37)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:17:24 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::46) by CH2PR15CA0027.outlook.office365.com
 (2603:10b6:610:51::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 07:17:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF0000001A.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 17 Nov 2026 07:17:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:17:18 -0600
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 17 Nov 2026 07:16:50 +0000
Subject: [PATCH mm-new v2 3/5] mm/swap: remove unused folio_to_swp_tb()
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
Message-ID: <20261117-unused-sym-mm-v2-3-2f845e94dd50@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794899821; l=812;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=4PyAIKcMg5mDnqU/Ax5f8TRMcaitQtbJu5JCfPDiymQ=;
 b=utq/lbiEeTxoXTcOMh5yHlgUCrh2Rj+wZGLz+HLp0oU51cNX7LWSp9PB81vU6h1kRCltQypAQ
 ASpcz0vX+W+B7w+Y0sXTxF/x8oFKvZ3dqN6I7IoRyVbONIsnnjjmA4F
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c64ca5-3c84-4727-ca05-08df447ad41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|921020|10067099003|11063799006|56012099006|261026121527099003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eG4bXr38PPnTw21cXmlGjYsS/dYKm1bjcUmcElNoS6oEY07FzDcgJg+JOWEGSQnUpHtdOPke/eDbUUpMTM056fKIkcjOIkL64V4x9ON26CLWYUHC040WCq50lB/ZCwHK6K7MIxPk0kqRrlBAYLLP463tMI1HZnLB+ajiPGuwQzToHoLdqnFHXd982B0MG3ohMozCM+uUvKsk0jv2yLawkerZSKjnSvvlMmj2qlZbYuvxlOltDBPoltCX2fRPPgtdPLqZFjT72iFm6+uzNvXSMMw9tpYGDIAGGtk4yyL5oW5oMcbnLY7JamRcpglli32aBdnkYX1O4pBokPgGT6utCh8rSGitRfoambDdUHS+kxtcqqruRYmocdOO4a24/ndxVf8aZJ9QR8JmBUH4I/BKkWQxQOD1IKylXyoGsfabAv9B43H3dL5XuVBK6kwVn9aRDzb6q0j+KuNqv2mVlIF7SndenTSQxV71S9hA3VlnaKltfastu554qPY2m0Nw3jul7amP9TDHK/QnsH7MFe9+RfFDiJngKGhU3k6Ryq15+AavnlzYX3S4VS92ckOBjxm9ETLNcmsVTttlKF3+yWwEq+T2dTLIld/BMxSaa1AnJ+E1kxJJusWJYMvm7+uN3qt6o7N/u5zRxr91wC3L7anOYkSadNSSQrjAOGb1kbcC5p27HHEDMg8di77yD/MDy5sHk7MaMivA1RrvqnEP5hIQeL8xbibdRwyed3R+O3I09Yby+r9/bQLJ1Yr6pjMYZzh7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yZp/ZdwVPNcwFabsMpBg/2z078H1GRdIbV3VgzqBzQILzF1nhgg8yrtw1zPO6eYkNo/sJilIabnhEs4Xxj323mRA+kD9UO9YVUxqS7JZA+QzkCYV7D8sGjK2VJHDx5TFfNG7nDITC8qBnp+ngTWmXdXQ26Ji8ny6RznVwGkdyzrxlcu70ZIk6bx4XjXfCqDhThC/yOgRBkMsxRWjHWMzjFO4vl9lq/p0gHsRjJiIk4tMiRVe7v11fwNbU7r5v4YcHwhP5/jtlhkI2khIP6Y3GnAMSiYYtpQMsWV2phPdPUnfD4OmIWHdMyHnJ8V2DYUc7Pb8dytmpaZpjKjjYkyAVp3JFQnxuiyEOPMMsU9KVg2fXrfjeFdNG2l6NKFctwV0erCZ1/kG1sDewBkAtjMAJXackG83nZ73hDtWusJ0eUL+kV3ZbKcjQLoJfUoSB9Ql
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:17:24.4573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c64ca5-3c84-4727-ca05-08df447ad41a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636

Its last users were removed in commit 0d6af9bcf383 ("mm, swap: use the
swap table to track the swap count").

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/swap_table.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/swap_table.h b/mm/swap_table.h
index 072625d60d54..022d2251884e 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -135,11 +135,6 @@ static inline unsigned long pfn_to_swp_tb(unsigned long pfn, unsigned char flags
 	return swp_tb | __flags_to_swp_tb(flags);
 }
 
-static inline unsigned long folio_to_swp_tb(struct folio *folio, unsigned char flags)
-{
-	return pfn_to_swp_tb(folio_pfn(folio), flags);
-}
-
 static inline unsigned long shadow_to_swp_tb(void *shadow, unsigned char flags)
 {
 	BUILD_BUG_ON((BITS_PER_XA_VALUE + 1) !=

-- 
2.53.0

