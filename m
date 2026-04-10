Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3681F936
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865973; cv=none; b=ZLSR/UwpTyTb78OjU3ioc5/E2eBFnofsESXHceFOYpwxKCBf2AfMjVHBNynX+7eAL1D/8+EKYjGxgZQZ/h61AzW+Pq+D43S3hLhzBQqbGw6jvzNWA+eFw7Cw6rmhh3ijoJDSZLm0HyfdbMTF/zz1lU8vHQUpDfn9lCJ8WEIO0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865973; c=relaxed/simple;
	bh=a+ZSb4mfTAgnfpS7FUxHtveS1lSCEkabIHIfQ4bLM6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEAAIX6ZczyKN0hfM1w5A6TTrljT9VACSEtFgdfEvh5sw8Smq5a0odU3thV7H/XvghDGuQ3NHQ8TifOUrg3cNt0GxEHJ0rLQyGQqwPUCy2Sw/mtdzOJ7SNAfK2YJjqYu49/1cUMpW6qazjUbgqnug06YIAisc/nNGOfInxh57Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.51 with ESMTP; 11 Apr 2026 08:36:07 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO hyunchul-PC02.lge.net) (10.177.111.62)
	by 156.147.1.126 with ESMTP; 11 Apr 2026 08:36:07 +0900
X-Original-SENDERIP: 10.177.111.62
X-Original-MAILFROM: hyc.lee@gmail.com
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cheol.lee@lge.com
Subject: [PATCH] ntfs: fix uninitialized symbol warnings
Date: Sat, 11 Apr 2026 08:35:53 +0900
Message-ID: <20260410233553.2542229-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detected by Smatch:

fs/ntfs/ea.c:444
  ntfs_ea_set_wsl_inode() error: uninitialized symbol 'err'.
fs/ntfs/namei.c:651
  __ntfs_create() error: uninitialized symbol 'ea_size.
fs/ntfs/iomap.c:517
  ntfs_write_simple_iomap_begin_non_resident()
  error: uninitialized symbol 'err'.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/ea.c    | 5 ++++-
 fs/ntfs/iomap.c | 2 +-
 fs/ntfs/namei.c | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index ee99baf9c7d2..c4a4a3e3e599 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -406,7 +406,10 @@ int ntfs_ea_set_wsl_inode(struct inode *inode, dev_t rdev, __le16 *ea_size,
 		unsigned int flags)
 {
 	__le32 v;
-	int err;
+	int err = 0;
+
+	if (ea_size)
+		*ea_size = 0;
 
 	if (flags & NTFS_EA_UID) {
 		/* Store uid to lxuid EA */
diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 621645fbbf2e..3d1458dea90f 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -384,7 +384,7 @@ static int ntfs_write_simple_iomap_begin_non_resident(struct inode *inode, loff_
 	loff_t vcn_ofs, rl_length;
 	struct runlist_element *rl, *rlc;
 	bool is_retry = false;
-	int err;
+	int err = 0;
 	s64 vcn, lcn;
 	s64 max_clu_count =
 		ntfs_bytes_to_cluster(vol, round_up(length, vol->cluster_size));
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 10894de519c3..d5cd2a790678 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -408,7 +408,7 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
 	struct super_block *sb = dir_ni->vol->sb;
 	__le64 parent_mft_ref;
 	u64 child_mft_ref;
-	__le16 ea_size;
+	__le16 ea_size = 0;
 
 	vi = new_inode(vol->sb);
 	if (!vi)
-- 
2.43.0

