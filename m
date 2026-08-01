Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756153BFAD4;
	Sat,  1 Aug 2026 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624998; cv=pass; b=X+4v7yo6PYV23JcqTRZM7fdk3wKdYPOcyQQoadeC1NcfhfLdBtK8AQO6hsvGjApMeKKDuUQySuGcU3lEJJK3jF8/CJ0RvgVCZ21pvcNx9NaJTajDCivRZdREGKWbBd4ICEHeOKdj+G7KXouSH/ZsJ3P1B+GMZ+wNjy84pmDtFRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624998; c=relaxed/simple;
	bh=6aYR/PtG6cnzRncR674UokAGDmIUKc2o1lWR65Jt/n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbR4KQegfZ+cHfv/7ZXHE9mFqGgo9A2DVyWzcoDvaUZuZp74Z+wGIP2rB65Te0JUP/LcJKfeBJAm7tZ1Sm1OM2+f0ASMs8T4EF7e4APpwftI/dn5QszR/WFFWj0CG7AR9FBzOEHUyZR9E4gYfeMzTcKSncYqqSlQvQec+LV4LQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=Bt7pLdlX; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="Bt7pLdlX"
ARC-Seal: i=1; a=rsa-sha256; t=1785624974; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=P1owJqSvQkJZlkz/Vl58ScdbEHvcCxLNEeZl+3XLuGyPm7CLefW5rjKHazt/hSNAxtUa/ee6onzvtv+7nZBLxRMuBHY0/vvs402OvvFYdBOq3eyFN2hSD6HsBHfCOSLrpoi2z2/iKEXRMhyj7K+Lj/obcuZvAFPZtbYuYMVEZlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624974; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wrd1BPWzTmr3/PZ0rIQk/dUqDEZiWESRgrvFaPrkgXQ=; 
	b=RPmb7c4AnUA5OQHrBfbb7xNpNGEKKFkppF59e20gU4z+4bqpUd5dMFEw0NLy5/FT29rEgp95DAQUH/ZIoq0LH5OiLc8iE7m8x5pz9JSNrsEmHgwkb9dBrEOUAxrDSvB0++L1TR+QELliaBDC9b2umY5hsDNCd7p0CxYSGgyv4QU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624974;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wrd1BPWzTmr3/PZ0rIQk/dUqDEZiWESRgrvFaPrkgXQ=;
	b=Bt7pLdlXw/GSR3WHYyyFovWDe5ij6tA/153mw/N2fV/cce2iv9h/7HsW48lcLpuU
	9A1xhBzTGbW2RA8MZ9tXBeCKUTh/Q84amV5IbsVSpSUYdHOI6CRLccEY3AlalIWlPRR
	g1tPHPTRQ3FPT3omgpAGJsA39MbtVmNCzvs4gsU4=
Received: by mx.zoho.eu with SMTPS id 1785624971437922.1356418553123;
	Sun, 2 Aug 2026 00:56:11 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] ufs: refuse read-write mount when fsck or journal replay is needed
Date: Sat,  1 Aug 2026 22:55:28 +0000
Message-ID: <20260801225530.148386-9-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801225530.148386-1-ali@iusegentoo.com>
References: <20260801225530.148386-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

FS_NEEDSFSCK, FS_SUJ and FS_GJOURNAL live in the 32 bit fs_flags of the
modern superblock, which Linux has never read. A UFS2 filesystem that
FreeBSD marked as needing a foreground fsck, or that carries soft
updates journalling or a GEOM journal, therefore mounts read-write here
and is written to with the pending recovery work still outstanding.

FreeBSD itself will not do this. ffs_mountfs() only accepts an unclean
filesystem when neither flag is set:

	(fs->fs_flags & (FS_SUJ | FS_NEEDSFSCK)) == 0 &&
	    (fs->fs_flags & FS_DOSOFTDEP)

and otherwise refuses with "Filesystem is not clean - run fsck".

Linux has no journal replay for either journal and no way to run the
recovery, so the only safe thing it can do is stay read-only. Check the
flags on mount and on remount read-write.

Only UFS2 is examined. On older layouts the same offset is scratch space
that may hold anything, and misreading it would wrongly refuse
filesystems that are perfectly fine.

Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/super.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 4b0e9196fa41..df95502e039e 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -767,6 +767,34 @@ static bool ufs_state_allows_write(struct super_block *sb)
 	}
 }
 
+/*
+ * Refuse to write to a filesystem using features we do not implement.
+ * Only UFS2 is examined: the 32 bit fs_flags lives in the modern part of
+ * the superblock, which older layouts leave as scratch space.
+ */
+static bool ufs_features_allow_write(struct super_block *sb)
+{
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+	struct ufs_super_block_third *usb3 = ubh_get_usb_third(uspi);
+	u32 fsflags;
+
+	if (uspi->fs_magic != UFS2_MAGIC)
+		return true;
+
+	fsflags = fs32_to_cpu(sb, usb3->fs_un2.fs_44.fs_flags);
+
+	if (fsflags & UFS_FS_NEEDSFSCK) {
+		pr_err("%s(): fs is marked as needing fsck\n", __func__);
+		return false;
+	}
+	if (fsflags & (UFS_FS_SUJ | UFS_FS_GJOURNAL)) {
+		pr_err("%s(): journalled fs, journal replay is not supported\n",
+		       __func__);
+		return false;
+	}
+	return true;
+}
+
 static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ufs_fs_context *ctx = fc->fs_private;
@@ -1103,7 +1131,7 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * Check, if file system was correctly unmounted.
 	 * If not, make it read only.
 	 */
-	if (!ufs_state_allows_write(sb))
+	if (!ufs_state_allows_write(sb) || !ufs_features_allow_write(sb))
 		sb->s_flags |= SB_RDONLY;
 
 	/*
@@ -1310,7 +1338,8 @@ static int ufs_reconfigure(struct fs_context *fc)
 			mutex_unlock(&UFS_SB(sb)->s_lock);
 			return -EINVAL;
 		}
-		if (!ufs_state_allows_write(sb)) {
+		if (!ufs_state_allows_write(sb) ||
+		    !ufs_features_allow_write(sb)) {
 			mutex_unlock(&UFS_SB(sb)->s_lock);
 			return -EROFS;
 		}
-- 
2.55.0

