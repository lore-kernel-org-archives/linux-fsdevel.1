Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899983;
	b=ORNdzvKA4n73LMHOQIlUky/xbRgC92v7JATMbLWBoqLxk36UMoEOjs9vOXRkmJ9I2/1i
	 nbKxFrD8wzRi/NqBAdyhDKKGDd+l6m4tM0iUerWpZxDY+jcoSiqH0sI3hvcCod7KJm890
	 wjBWFhAGDFj1KisMay85RHegY2lsbUiSifChDnNo0tF0BsOeo7pMx350ggB+v7G9JVvzM
	 jkmS7cy8r3G8mx00p07Q71uQiajVQ3nAeYh8fZ9tx8H8wHHpY7CFoSo0+kk4RTtn8Go8I
	 toxJxz/BgWMz/SIdArGD0A11O/BB0OIX8tp9YUkJGvSjbLhBrcvtn5dmrfBcQRI8zww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899983;
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
	bh=09U7UvY+B3okNAT7LE1wuAp6ZjyC3vPbdWsq64758qY=;
	b=h5SgFhstUDCOzLEb3tcmCYyqcmOYdhT9eMWwzMBciIk/Zx+R3fLs+b+ghzWA/Er5qjcW
	 glWU/6HXsVIPCxJxdtzQBco23ovohM9pRGleCjyO/oURD9mTD5WDLs5CZZua4BRl+ZAZe
	 TkY7finhde2vZDvyQgUM9587uojjImSksIUZ9eMJKZoH1CQNo2fXUTJ6T0Abhky7w8VN3
	 bCAdeu3HPMnrZ1S6JY2dICRCDBsgRSdkO41OJ4QFgfwySE2h1fAKQiSpRo1SxqpmIM57q
	 BJm6HCC7ditHynZYQjR39mC2e68R+uTMyOYzcN+JfYDkKbyNej9eQZ7LZYZH/XXyNCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hNGdQPcw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.67
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D8606A323;
	Tue, 17 Nov 2026 07:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3D8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hNGdQPcw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8TCJEseh2ncOCgJj4Q9U4VykaxC/UuGN3p0F0OnXu90DVr9yFHTCNFWb8RGdgYcf4j/J51a2tAiDlV/RKimQaBLmtNRiNkE/Uz3SoTWWaegZ66lRkGvxJiPoOFp66u3xaw98QkR5stLj0NXld67g8c/4qpJTMFV5a6/OyYreg6O7SOuCw2WtSBXJF96dt0Mxe7GbjKgKZoyxV5+kIBpYNKovoYPuJ5vOeYP5OhKTFdxf1j/nCsQZ7+yKrtlfb3rpln0fqyY5q69bBj2vUfLQV4ZLX6kILdnOMj4SAkFc67Ld7uKEzIm3Nsi+8snK07x+a+FsErva7eWIdxDSDUH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09U7UvY+B3okNAT7LE1wuAp6ZjyC3vPbdWsq64758qY=;
 b=iQQ5wmVbtZMTOkG2LViHxMxDKKMDN1VjSDl4Obnz90TjFtps75z9PTkTsmftItKhxvgZgVH3sslLIvjsZeC0Zsxl8fYZBNdUze+fMIEjGz3k8vG50kPcRdbgwSYibCTi2VXU0Dgvxd2eNZdlWEVh6mwxeNmc61eQ566a6J9i24++ymgv8hVQ7YwiXY3ivTcLHC21FlBvGWfOzdXM7b90AhKy5fq1SI7E9sUqhIkpdsdnYpQw1T0B7PxugfSQC7swFLRylHAMnYmzcpR7k5srGKMMwnmsD3z3IN3hMnPBcwK/FQBE9Fv/ixxppa0XPwuO6ilF4zfHrHkOmWOqq7Sayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09U7UvY+B3okNAT7LE1wuAp6ZjyC3vPbdWsq64758qY=;
 b=hNGdQPcwsCl0F5b4rRHa0i3cLu3mSEDxHB88vNUQFp5teRiWmXi/zRUdKTGc8H6yuuI8r0pVs7LUnzGGjCTZBXGEcp9kxISZTY8xRwHwSZV7QmCaC/I0R2WhaGkZWIp7aKEEdLjKFE7XRJoMIDNMwz08TeHTUKGLkMxOV6DZ1GU=
Received: from CH2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:610:51::28)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:17:36 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::9c) by CH2PR15CA0018.outlook.office365.com
 (2603:10b6:610:51::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 07:17:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF0000001A.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 17 Nov 2026 07:17:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:17:30 -0600
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 17 Nov 2026 07:16:52 +0000
Subject: [PATCH mm-new v2 5/5] mm: nommu: remove unused heap_stack_gap
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
Message-ID: <20261117-unused-sym-mm-v2-5-2f845e94dd50@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794899821; l=584;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=xutkpMVDsubOUvN4qaxfBq/hpdvEFD2ITbH891JolTM=;
 b=680/aZQMqYQI1ovcbYrJ2fCjmGwoXYkXsCjlBmyUv81oM8JlvmGg1TSZ3wr5Ebod0YvGeaNUf
 HroUr+8ucKQBT+eayrMqbHh+PEmV55ItHWRNjoGVgX0Cox4Yz9sad5G
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5a415a-1894-420c-6c90-08df447adb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|921020|11063799006|56012099006|10067099003|261021123027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	USa2tqs12Qjsc8anIERjTafGFPXjga6zPgoacVByG9WAnBSCDILjyv/5XcwIbY2t+nWAJlf1nEfD9ss4oAWgxMHZcgL/+PNRi2hDXMBU7bR8glf/pup4b05SR7IrGU4c2KSgD3bVxoDxAqFTnx65HSXr9JIua/gzOQImity3/RxVAzNeozQ+wcgpHwv4TFPq1ZRdQclWThG/AyjBYd7OmqP1XgoSC2nYa9LbOirwg3O+8WLgqPLVmh8/w5QAYNrYmrqXH1JKrEbRcWCJX1zXe3EsY2y/f4jxyViDRJdqxNrRWvpMNR/6vbZcgWF06QXNQF4Hc/rDzIhgHamcB4g0WeaULgo+V33j4Q6sNi7lj529SqnhfGysugt5aBTQprJRizjFqqqOXuLW7pJedWoGMXr1lU6OCnKcjEkVum1d1ESdCS50lpx6VhjtSntCIiPa04MmdnxaoVM+3jstUxOnfHSfUM0RumHeSVx5sqJROyurFcp4YpQwOIW+xFVUrJuy6C2hlBm6fbpdU5NBJtSw7NBN3El//YaxoYkICkJu6HkuLYkhA0c53wNiz4TVs3gX3/NuCS36m8Kq9GoiLdW8yIxF//2RHjEqD2IrEvqWwQd/lGmZqcKxB/kT1rB1WtC4vz0RRnriHjvDNRcQAFwHyUHM5TsUwc8CWI5ouBwbik5/jq80orLALTE6nzI17V3Rx02+LlZzKeIHGorxuJsANA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(10067099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EvRImdHtkAklAQXYJcBijJPQ9M1xWXsVpu6NcQ/YwvMp6sXPNDQJMkUm0zpu2NQriQmnZIOAzx+6MUHhIV+H9DJXy1RNBzuKJFXCO1Fbt+NENbVDd739ek2iChD3uInDni06yuAhYgFacOyOaVXs5mXDp8vvHVoK7IgQEuP5VA/jKpTIGNI7f4MUrHUvT58w056954MjW4XEs+o0dYRS3AatENg4Q/NcPzfe9VaZ11b6tLecMGvgqnykcW28LyjtpgD5JmKpkhV+gbTNKqJL1C5JMS+cLGczgFlM6kES4fjjvnFGMpeoCWNWI/rb+Ke3YHzBlPKaLxWMlqTTLzsUR/9+MTVqaI67D9AqdtMPTPDRMVmk+Z39PuvZzvMSj3NMIc9HV0Oig2R4YxrT+qWhi4YXEbG514B0Sdc15GGW488T4MqY6Kqnx0feBeQQTaSo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:17:36.0688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5a415a-1894-420c-6c90-08df447adb06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

heap_stack_gap has been unused since at least the start of git history,
commit 1da177e4c3f4 ("Linux-2.6.12-rc2").

Link: https://lore.kernel.org/linux-mm/20140430083620.GA4711@dhcp22.suse.cz/
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/nommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index df99495c8902..a971c12f2732 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -43,7 +43,6 @@
 #include "internal.h"
 
 unsigned long highest_memmap_pfn;
-int heap_stack_gap = 0;
 
 atomic_long_t mmap_pages_allocated;
 

-- 
2.53.0

