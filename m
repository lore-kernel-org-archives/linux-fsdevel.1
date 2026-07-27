Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF0374A1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182290; cv=fail; b=qb/KsrHsJjr/qh8ltoAuzoOGS89XTAXcWRyf7LIP1wrLg1+zznx1lPn/3cGzCIV9JaKclgPhRD99WdIafTmAYPzkaQmJkS+ZwjB6wSJv1wq5NdRKrliKDEx8OZTYEA9Oqy3Ky8kBmVv/bZJf2WPINtPkXv017wfnwbS7rHgyMP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182290; c=relaxed/simple;
	bh=EB1LzVRsI29oSBOsnpw2x2SDY6CWjWkeRvm0inWG6W8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VbvurrkBJTgpzfJhO2HLJA24L7Kv10jIXVTetaWYcRVRkI4jt+nQFa/2jsRaZzKqXLr7i4NfJhmx0SiZ5SrUyPWQe0VNNhondDaodXRJB2GhyPgG8OIrF+DpITxEv76RW+kC5i2kB3dhVqaL7wEh3kZhdM0ocewwAbTE8xIFdRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OydcMlu4; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OydcMlu4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1Xt2Ak8wmxc25VnamiRQYILzmJjkj2SSGxcYOuCnIw8jqV6u0GlyJSu+HJBAWJ8qiKRfKMK/AEJws4EGe0NWtXIeF81pzpaid3wfEOO/4bl0E06CvY+soNm6ZSfuok/EIi1InBsDu1Wvnjlq4HE7UyRVXxUHF/Wj7i2wDbQu8PLoquimPeJ6DsCj2deYc7nlrscSMhh6glVVYVXEdLe8JI9u08VL5lcMFtX43HYCbSurVY/jry8bsnDb/oJlc97qyeQqmMOjSsSDUjdk4AqqkUAu5XqkcoMzBbjPjZzveAPrmOR+npo7V2iogsukxhtO+aKeHH12FOFJDkOIeJ3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63LXXDhkb2veBSl74AwDHLX28w4u1P+ia0HJtyOh7Qw=;
 b=kNm7LtR4FGXNRNfzH0/rILpd49b5QhsiMq04yK3PkmGwcNRARFpMyK7CLrKJUGRzCp6FIT63RusDAXRN6we2r9ZOf+LsAy8TbgCt0lUsN84LYWSs02qPoWRsWRIc60QtCpcPUWBZfP813F5XpDxZBWduxurNRHddr9wlAB+pUluI14K1i52gZYUC3Evhj4ceeayRUVU0w5eud7n+vvdTFhf3jDvHK45z01ChX7CRRlFuZVzUgTUFJWBsCA9mhsAUHKET30GKe741l3UhyqYbQ0YYUWAMkJMRLuSEBiVNzhNDjf3WhmAoZhk1ooIxENsj3rYpj1PMIERj0JerMZqkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zeniv.linux.org.uk smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63LXXDhkb2veBSl74AwDHLX28w4u1P+ia0HJtyOh7Qw=;
 b=OydcMlu4924+reM4dzNAXk0Nrm4CuUOWsP2DxoBbMxHPsp52CYVFwvw4xtyUXjnGrNx7Le/qCVxz/8xRId2o3m/YzP+9rlhIqfY0F0FTHZl+VRwc5K2ciwHIif4FLCSVqfGKp3uadSeV00MatE4kWqC9vU587vXhp/c0LliqgMk=
Received: from SJ2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:a03:505::22)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:58:02 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::79) by SJ2PR07CA0018.outlook.office365.com
 (2603:10b6:a03:505::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 19:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 19:58:01 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 14:57:59 -0500
From: Alex Hung <alex.hung@amd.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <alex.hung@amd.com>,
	<arnd@arndb.de>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] seq_file: rename mangle_path to seq_mangle_path
Date: Mon, 27 Jul 2026 13:57:30 -0600
Message-ID: <20260727195730.2306887-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 274dbaaf-6d09-4bd3-4e7a-08deec195d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|56012099006|11063799006|10067099003|18002099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	1U00i7upEgB/0mOuNkYOP9nJTHtEMZu+eWt1vHdY/rwaw84pFl7bzCqYnuVHwt7GunqnsD4jX7+nJcIHt1dj9b8fSDBILrKctxUpHmt4iJw8w/5RD+2364CFz+AorC6obrbbItnroFhdjwTv/ZEvGbNdHqNqXBby0LkZA/l9e0k8hvBbmXg+BbfP3kuUgVR0nhqBcQ7R11VyXPro0raEPl49hKOTOi/iW/p16SfRHPijjEP4kbUdbnnnrP4rvJ/ZmDWvaqgdr+Hz5KDvS8oH/Vz5NdraP2Mnqxzumfzj7ifg4ZF4YemfyQLQxC8uZJDq5OHMpmHuBdHsasaRsc/hJr+1tFKWSmpfU+Yc1S124WcprX1RzZBo0+ErzbuOaAMB62uwjlVQW7uDXooFKathZcqLkurBxgQUdHnCv8RSnIF+RtpHM5f0NWEeB1Up0zZhti1KJtB4GBXZ5YB+sxyEEwkOQXlHkwtQlLDVR9J7dHr0yui9qOS+VbNCEiCNDCi0hquV0suUAdC9tW6k9ccUzFOsSkNun/znbmf6Zp77qR0Y20GCyqYA7X9ZYuWjjwSxpbR+TKA0MLUbeUuHyRlQXi5yWu19pBrqsloc9tHr2AgHjg+0vrHLZtlFDdhJgGX4S0Axk0ZaVPXyQn2ucAYLSseNXxnxcr7dIG2LvH9f6f9zYlAlzh0DsJjcWnfNiZhNQaCw0QiByHqFrnSY0IyN8AEJTsZLFOGciWw1rAJdQoc6wdd7p/RjaQjRE7m7Vv8s
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	49tZes0/T8Buq47epnhllwASR/d4tAR6z9zWeHcVAIFcZ6tpWDJ8z8AAbVuWaey7UM4QUjrXQDG/5gckukyJPouGyw2KlquKrLZ5U/q8Pg5LxkXaCKWNje+JxXo69t7+CoI/WbSV9BQHllS8Oavv6yiM6U9A9zwq0VBjH6G6KR+5gfApkFHnoE4I/16SDTHa6S/t1t5DWem+K/4HVUKqb36PafClceuxJmNTK3QptqZhfJRCCGqXuDDQC7TbYqru3cJjwZjSXfj1h1lZlYGDduQWcpq8E9HUwHJey6gBeO4/7ehc3KZeU9hthk+MbeGuVmBEo9RF0MWkoYmZnt4yQTc+YHhQ1Lq0b0tqjpK5pfiBHt+QE0y7pBstSmiSIsDUTSvtu74NSP2MM7BKqezAP/3IMKXVYLybRkg4tWKEYBsqEbkC8VG/3Nbbe533DFef
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:58:01.6652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274dbaaf-6d09-4bd3-4e7a-08deec195d5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266

From: Johannes Berg <johannes@sipsolutions.net>

The symbol mangle_path conflicts with a gcov symbol which
can break the build of ARCH=um with gcov, and it's also
not very specific and descriptive.

Rename mangle_path() to seq_mangle_path(), and also remove
the export since it's not needed or used by any modules.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---

This is a revived patch. The original can be found at
https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06604.html

 fs/seq_file.c            | 11 +++++------
 include/linux/seq_file.h |  2 +-
 lib/seq_buf.c            |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 4745db2a34d1..456c78719fd0 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -428,7 +428,7 @@ EXPORT_SYMBOL(seq_bprintf);
 #endif /* CONFIG_BINARY_PRINTF */

 /**
- *	mangle_path -	mangle and copy path to buffer beginning
+ *	seq_mangle_path -	mangle and copy path to buffer beginning
  *	@s: buffer start
  *	@p: beginning of path in above buffer
  *	@esc: set of characters that need escaping
@@ -438,7 +438,7 @@ EXPORT_SYMBOL(seq_bprintf);
  *      Returns pointer past last written character in @s, or NULL in case of
  *      failure.
  */
-char *mangle_path(char *s, const char *p, const char *esc)
+char *seq_mangle_path(char *s, const char *p, const char *esc)
 {
 	while (s <= p) {
 		char c = *p++;
@@ -457,7 +457,6 @@ char *mangle_path(char *s, const char *p, const char *esc)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(mangle_path);

 /**
  * seq_path - seq_file interface to print a pathname
@@ -477,7 +476,7 @@ int seq_path(struct seq_file *m, const struct path *path, const char *esc)
 	if (size) {
 		char *p = d_path(path, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
@@ -520,7 +519,7 @@ int seq_path_root(struct seq_file *m, const struct path *path,
 			return SEQ_SKIP;
 		res = PTR_ERR(p);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 			else
@@ -544,7 +543,7 @@ int seq_dentry(struct seq_file *m, struct dentry *dentry, const char *esc)
 	if (size) {
 		char *p = dentry_path(dentry, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 2fb266ea69fa..dc0e8c62d9e0 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -104,7 +104,7 @@ static inline void seq_setwidth(struct seq_file *m, size_t size)
 }
 void seq_pad(struct seq_file *m, char c);

-char *mangle_path(char *s, const char *p, const char *esc);
+char *seq_mangle_path(char *s, const char *p, const char *esc);
 int seq_open(struct file *, const struct seq_operations *);
 ssize_t seq_read(struct file *, char __user *, size_t, loff_t *);
 ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter);
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index f3f3436d60a9..91b2d0e12158 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -320,7 +320,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
 	if (size) {
 		char *p = d_path(path, buf, size);
 		if (!IS_ERR(p)) {
-			char *end = mangle_path(buf, p, esc);
+			char *end = seq_mangle_path(buf, p, esc);
 			if (end)
 				res = end - buf;
 		}
--
2.43.0

