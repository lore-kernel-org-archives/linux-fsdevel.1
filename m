Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E237757B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963668; cv=none; b=ikpRhx+snlWnCJoazJxoRSQ2oRBsu7IZQhnUe42Ne/Yw5V5HsYDK3xS/jpOLwvc8QQCzYCoxygewzNVooweM/e8KYvt723oNfbrYRyU1UUtEzSDdMv/54sFil/4VmcvxdHM/nul3Cuo8ZCLgiGTC1EzAq7h3hW6ga405i1Ek2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963668; c=relaxed/simple;
	bh=TEJoBkOF1za3Xn01vDGH5YZEbnz7ADl2FfcXwlEHQlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyxKi9Qvnz9K2TzG4Wysddwg2ouJpTpBss70AKzQm8LRqii0agtbOkj2sK1h9NFtbecDFc5cXh8Fg/ofp08jUBED7MA1nCucawVRLspwUaWA4Y2O6j2iF7TbaZOlF8P45Bbg2nL5tED1f/+oPy8Ht2VaG1b7rfF79/EfZuJX5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=PIyat76c; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="PIyat76c"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id DD9A41CBC0;
	Thu, 19 Mar 2026 23:41:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me DD9A41CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773963666; bh=TEJoBkOF1za3Xn01vDGH5YZEbnz7ADl2FfcXwlEHQlw=;
	h=From:To:Cc:Subject:Date:From;
	b=PIyat76cmgnsAhe8tUwv/7cUIJmVE+mq7OHLG9KT63trmLaFlM6t+vwkINNuOXKWQ
	 fKune4mdI/+x5inSbJZNMKg10EL4QO1bo4pxPuHZsGsQvvo9wahSowcfo3YUMLimtz
	 xjuEAcPyDrzQoMKCSZatEt26U/73s8C33BcbE36A=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id /7wEIpCJvGk70wcA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 19 Mar 2026 23:41:04 +0000
From: David Timber <dxdt@dev.snart.me>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com,
	almaz.alexandrovich@paragon-software.com
Cc: linux-fsdevel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH] ntfs(3): export super block magic
Date: Fri, 20 Mar 2026 08:40:47 +0900
Message-ID: <20260319234047.43253-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export NTFS_SUPER_MAGIC and NTFS3_SUPER_MAGIC so that the NTFS
implementation could be differentiated from userspace through
fstatfs() and the coreutils comamnd `stat -f`.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/ntfs/ntfs.h             | 1 -
 fs/ntfs/super.c            | 4 ++--
 fs/ntfs3/super.c           | 4 ++--
 include/uapi/linux/magic.h | 2 ++
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index 45064dbcc2e4..c41be5fbff17 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -76,7 +76,6 @@
 enum {
 	NTFS_BLOCK_SIZE		= 512,
 	NTFS_BLOCK_SIZE_BITS	= 9,
-	NTFS_SB_MAGIC		= 0x5346544e,	/* 'NTFS' */
 	NTFS_MAX_NAME_LEN	= 255,
 	NTFS_MAX_LABEL_LEN	= 128,
 };
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 39a5c3b81001..e595a34619fa 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2149,7 +2149,7 @@ static int ntfs_statfs(struct dentry *dentry, struct kstatfs *sfs)
 
 	ntfs_debug("Entering.");
 	/* Type of filesystem. */
-	sfs->f_type   = NTFS_SB_MAGIC;
+	sfs->f_type   = NTFS_SUPER_MAGIC;
 	/* Optimal transfer block size. */
 	sfs->f_bsize = vol->cluster_size;
 	/* Fundamental file system block size, used as the unit. */
@@ -2352,7 +2352,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* Initialize the cluster and mft allocators. */
 	ntfs_setup_allocators(vol);
 	/* Setup remaining fields in the super block. */
-	sb->s_magic = NTFS_SB_MAGIC;
+	sb->s_magic = NTFS_SUPER_MAGIC;
 	/*
 	 * Ntfs allows 63 bits for the file size, i.e. correct would be:
 	 *	sb->s_maxbytes = ~0ULL >> 1;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 47c11547c972..388d4c51f24b 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -731,7 +731,7 @@ static int ntfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct wnd_bitmap *wnd = &sbi->used.bitmap;
 	CLST da_clusters = ntfs_get_da(sbi);
 
-	buf->f_type = sb->s_magic;
+	buf->f_type = NTFS3_SUPER_MAGIC;
 	buf->f_bsize = buf->f_frsize = sbi->cluster_size;
 	buf->f_blocks = wnd->nbits;
 
@@ -1279,7 +1279,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sbi->options = options;
 	sb->s_flags |= SB_NODIRATIME;
-	sb->s_magic = 0x7366746e; // "ntfs"
+	sb->s_magic = NTFS3_SUPER_MAGIC;
 	sb->s_op = &ntfs_sops;
 	sb->s_export_op = &ntfs_export_ops;
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76c..7bc8058c7108 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -54,6 +54,8 @@
 #define QNX4_SUPER_MAGIC	0x002f		/* qnx4 fs detection */
 #define QNX6_SUPER_MAGIC	0x68191122	/* qnx6 fs detection */
 #define AFS_FS_MAGIC		0x6B414653
+#define NTFS_SUPER_MAGIC	0x5346544e	/* "NTFS" */
+#define NTFS3_SUPER_MAGIC	0x7366746e	/* "ntfs" */
 
 
 #define REISERFS_SUPER_MAGIC	0x52654973	/* used by gcc */
-- 
2.53.0.1.ga224b40d3f.dirty

