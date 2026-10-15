Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4714BEE58
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062098; cv=none; b=i+P7w4sxHyieAFOc0W9cbrjX/VHYXHCJibbmlobWDIKPR41Clq31P1PkqJBS2Z9dH1/dDpymGBU6K2zBwUi10Y+VB2xneezT2zLq8sySN5jXoHE8k9sH6410EK9w4UQpjcvJt0GdgC/mYcza9wPdR72fz+fUNgXAusu1H3PDec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062098; c=relaxed/simple;
	bh=seHe7MX+AB+3THcLxHQRuciiU9R6sdELYrwShqGoACE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IorX0hCwPP6MZTI1cP5kxRsX7FJn7bdx9z92I2L/8IFY7rBY8gDkkPBntn84XSLEohMv42jFpweJ3VG5XGdHIE3mW5GKUASIO7qmKqPI1vRWmwwspn8D0En4QUTvEElOO5saN9knMVaeB3/g4pKLkwo8w81lL8We68A3zNXEq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=OojDj9Wq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="OojDj9Wq"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93cb1c0e851so400033985a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792062093; x=1792666893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZMRtmyXIeDsgzi8BAit0mLc2X2OR2gmmR6POyT9a9M=;
        b=OojDj9WqBffFt0nO+J5//OFsJKVcomfHq1SjG8a8v2+0KXbSRkzolymOkuL/iUkGsQ
         AhQrJESOM615WI+OkdjnmkHjE5faSiWXR/qE2uqkvBaKWG0bjpMtMwSe+F7Bz/iIqZwx
         JIG/8LWx4v1Y9hYJ+/FMb8mWFCbafX++W4ETD74S3jCyxeOHOxDitZJlbywZ/77NhZLa
         WCQeh9TvjUVDG78fDuW+DzfOpco3an8RgMD9AuyL0Qf0L4RN745I64KT/5jMNe4B1dxy
         kGOQ3kYNLgkLAi7FqNWKYE0ED8gBa4HSUtZQM7eNhgf/LWfrjE3HqGuZNwZPpg+H87c3
         DYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062093; x=1792666893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZMRtmyXIeDsgzi8BAit0mLc2X2OR2gmmR6POyT9a9M=;
        b=j8KLuDEXnmpNJQwuco8tToty1qHECbsjCr8UUDZjqz/6AlIC/DUEjNFZTL08U8A4py
         vH/DwI+eUOB4ee91KDTPjUnzrtxv+qWdPJP2UyPxcJFoDH6kCvdPPr+xRlfj7Xeafh+R
         LsM9ra0Du2YHJcgbV8gL4mx4qgzvn/Onk5qWRPJNrfK6GIf3r/80qswZmrfpPJXAo/bL
         yy2mLhaHiYBEGQaoVeV71e6K1eZgULs1cHCxxK+Y2SCsvTNgoXY2tHxK+qLfIbeON8w0
         DTRt6OLZD2D3xNBqkULWEYKcaFO3Aa2xGFv1rGkhmA0OKGV0X6smT1iu1kdDI0kSWouA
         x2kQ==
X-Forwarded-Encrypted: i=1; AKwUvByZlo0SPRbHXY3wZwDPnS3DCpn7Om+uEJDWJe4VcP8dksKhMibSDo+tEsR03Svq5syTRyjkvLZe7j7uRE9i@vger.kernel.org
X-Gm-Message-State: AFq9FYIrJMa5h/uYnzhbD3PoZh0cQ3PO4FLS+QM7dV1ied6TOMhCUrV9
	zMKrIODQGr+OUBeLf4UWbWQ9eaJMKu9JmiT6KJDCmrf72Em1vyj1tRx9EGOGalPLumDDC40lc6s
	CVkGFFA==
X-Gm-Gg: AYBFou0LJhFu2z/9H8Tbk/gNKjCXl3Qxgm6LgvCPtE6WEd/DQSLhJeUbfGzSCPJo7/u
	jrFQiI3HwKAJVDdO2TkUsgd2cA7C2CVgMCxHaK+1qZ2GGaMa5fduT1QOPWmbIRp82oqHamWN3yU
	jpj5FgdYHnGjIIaMCoxpczgIarOa9+REAOYveLWqgrVXUApjiEBvxjqAOvsZD7Nut9oiX0FvfHM
	naOdl1ww0hknacoY+CTybawJhJ5H2EH2i78JjrmtGI3uLdip4+YuDGLCqFSeblg8llZwleJdb87
	whRjnDx/D+RmXNGF8CvCVHaQfmP/2mp3SGkVsKw996S3hw8moARbUIYAWcJzhr1iYL37f4SPjOT
	4oOWvjMSU+YAbGlQek0HrN6uOkV9zXeGVe67J4BR7ZVWYjeroyLsqeMJmFeydra8wxvBPvRFaZn
	LB/Nq2fIHkhfAp1bUUiYGuPJw84DWsXMgGgKpc3M/s09suKBBJ3j1GApE8DHNBJX8gNQrxq/FAC
	DqEC/FpwE2mbNP3MPZ7gg==
X-Received: by 2002:a05:620a:2988:b0:93c:5f3c:f485 with SMTP id af79cd13be357-93ebd294dafmr2975208685a.53.1792062092573;
        Thu, 15 Oct 2026 04:01:32 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5054416sm729547385a.30.2026.10.15.04.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:01:31 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Thu, 15 Oct 2026 07:01:14 -0400
Message-ID: <20261015110114.1649059-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a06ec283e125 ("hfs: add logic of correcting a next unused CNID")
made hfs_correct_next_unused_CNID() use the CNID of the last file or
directory record in catalog key order to lower next_id after deletion.

However, catalog keys are sorted by parent directory ID and name,
not by the record's own CNID. The resulting next_id can still be in
use, so hfs_cat_create() finds an existing thread and returns EEXIST.
Commit 6592287869bf ("hfs: fix incorrect inode ID assignment in
hfs_new_inode()") exposed this issue by correcting the inode ID.

On a freshly formatted and mounted HFS volume, run:

    mkdir z
    : > a
    : > b
    rm b
    : > c

Without this fix, creating c fails with EEXIST, although c does not
exist. With the fix, it succeeds on the first attempt.

First look up the preceding CNID: if it exists, it must be the largest
remaining ID. Otherwise, scan all file and directory records for the
maximum, including files without optional thread records. Follow the
leaf links regardless of node numbers, bound the walk by the total
node count, and acquire a reference on every visit so malformed cycles
cannot loop indefinitely or reuse a released node.

Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused CNID")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
The fallback follows leaf sibling links independently of node numbers.
Bound its iterations by the tree's total node count and acquire a fresh
node reference on every visit, including when a cycle returns to the tail.
The budget check runs before acquisition; exhaustion returns EIO without
using the partial maximum to update next_id.

Tested on v7.3-rc6 with GCC 10.5 and the unchanged KASAN configuration:
14 normal-volume cases passed, including predecessor lookup, ID holes,
missing file threads, concurrency and reordered leaf node numbers.
Three malformed prev chains (tail self-loop, a loop returning to the tail,
and a loop excluding the tail) each returned EIO after exactly node_count
visits. The on-disk next CNID was unchanged; no KASAN or BUG was observed.

 fs/hfs/catalog.c | 80 +++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 490c5e130da3..2d90f1857781 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -269,48 +269,54 @@ void hfs_set_next_unused_CNID(struct super_block *sb,
  * Correct the next unused CNID of Catalog Tree.
  */
 static
-int hfs_correct_next_unused_CNID(struct super_block *sb, u32 cnid)
+int hfs_correct_next_unused_CNID(struct super_block *sb,
+				 struct hfs_find_data *fd, u32 cnid)
 {
 	struct hfs_btree *cat_tree;
 	struct hfs_bnode *node;
+	u32 max_cnid = 0;
+	u32 remaining;
 	s64 leaf_head;
 	s64 leaf_tail;
 	s64 node_id;
+	int res;
 
 	hfs_dbg("cnid %u, next_id %lld\n",
 		cnid, atomic64_read(&HFS_SB(sb)->next_id));
 
-	if ((cnid + 1) < atomic64_read(&HFS_SB(sb)->next_id)) {
+	if ((cnid + 1) != atomic64_read(&HFS_SB(sb)->next_id)) {
 		/* next ID should be unchanged */
 		return 0;
 	}
 
+	/* If the previous CNID is still in use, it must be the maximum. */
+	res = hfs_cat_find_brec(sb, cnid - 1, fd);
+	if (!res) {
+		hfs_set_next_unused_CNID(sb, cnid, cnid - 1);
+		return 0;
+	}
+	if (res != -ENOENT)
+		return res;
+
 	cat_tree = HFS_SB(sb)->cat_tree;
 	leaf_head = cat_tree->leaf_head;
 	leaf_tail = cat_tree->leaf_tail;
-
-	if (leaf_head > leaf_tail) {
-		pr_err("node is corrupted: leaf_head %lld, leaf_tail %lld\n",
-			leaf_head, leaf_tail);
-		return -ERANGE;
-	}
-
-	node = hfs_bnode_find(cat_tree, leaf_tail);
-	if (IS_ERR(node)) {
-		pr_err("fail to find leaf node: node ID %lld\n",
-			leaf_tail);
-		return -ENOENT;
-	}
-
+	remaining = cat_tree->node_count;
 	node_id = leaf_tail;
 
 	do {
 		int i;
 
-		if (node_id != leaf_tail) {
-			node = hfs_bnode_find(cat_tree, node_id);
-			if (IS_ERR(node))
-				return -ENOENT;
+		/* A valid leaf chain cannot visit more nodes than the tree. */
+		if (!remaining)
+			return -EIO;
+		remaining--;
+
+		node = hfs_bnode_find(cat_tree, node_id);
+		if (IS_ERR(node)) {
+			pr_err("fail to find leaf node: node ID %lld\n",
+			       node_id);
+			return PTR_ERR(node);
 		}
 
 		hfs_dbg("node %lld, leaf_tail %lld, leaf_head %lld\n",
@@ -331,42 +337,52 @@ int hfs_correct_next_unused_CNID(struct super_block *sb, u32 cnid)
 				pr_err("fail to get the keylen: "
 					"node_id %lld, record index %d\n",
 					node_id, i);
-				return -EINVAL;
+				res = -EINVAL;
+				goto out;
 			}
 
 			entryoffset = off + keylen;
 			entrylength = len - keylen;
 
-			if (entrylength > sizeof(rec)) {
+			if (entrylength <= 0 || entrylength > sizeof(rec)) {
 				pr_err("unexpected record length: "
 					"entrylength %d\n",
 					entrylength);
-				return -EINVAL;
+				res = -EINVAL;
+				goto out;
 			}
 
 			hfs_bnode_read(node, &rec, entryoffset, entrylength);
 
 			if (rec.type == HFS_CDR_DIR) {
+				if (entrylength != sizeof(struct hfs_cat_dir)) {
+					res = -EIO;
+					goto out;
+				}
 				found_cnid = be32_to_cpu(rec.dir.DirID);
 				hfs_dbg("found_cnid %u\n", found_cnid);
-				hfs_set_next_unused_CNID(sb, cnid, found_cnid);
-				hfs_bnode_put(node);
-				return 0;
+				max_cnid = max(max_cnid, found_cnid);
 			} else if (rec.type == HFS_CDR_FIL) {
+				if (entrylength != sizeof(struct hfs_cat_file)) {
+					res = -EIO;
+					goto out;
+				}
 				found_cnid = be32_to_cpu(rec.file.FlNum);
 				hfs_dbg("found_cnid %u\n", found_cnid);
-				hfs_set_next_unused_CNID(sb, cnid, found_cnid);
-				hfs_bnode_put(node);
-				return 0;
+				max_cnid = max(max_cnid, found_cnid);
 			}
 		}
 
 		node_id = node->prev;
 		hfs_bnode_put(node);
 
-	} while (node_id >= leaf_head);
+	} while (node_id);
 
-	return -ENOENT;
+	hfs_set_next_unused_CNID(sb, cnid, max_cnid);
+	return 0;
+out:
+	hfs_bnode_put(node);
+	return res;
 }
 
 /*
@@ -420,7 +436,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 
-	res = hfs_correct_next_unused_CNID(sb, cnid);
+	res = hfs_correct_next_unused_CNID(sb, &fd, cnid);
 	if (res)
 		goto out;
 
-- 
2.53.0

