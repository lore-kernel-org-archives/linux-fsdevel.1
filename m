Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7E1B78F3
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778989495; cv=none; b=aPYVjqNviHQN9JCEb9RTbzHe9tEwyZVOAcDJ/5yaycZNMFjTcAgiT4GXbr8CZf6HgIhZNZzdh0zF76o0rig4OpFU484gMk1hpcPnC7GZ9k9JfXVmQwt84c5kdK7hpIFCLsaPbKjYtKMjUZsiXen7/OBXI/AGAKeHRZyv0RUeKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778989495; c=relaxed/simple;
	bh=OBL0hz2vORnvOvVyBfrgRjiED7HNGC7ZbNcTq/BP/iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE+4eBD5Gos6D85E6nTQnmKa67h1G2RFT1HF6nevr6fL/g3eb8sZOVyc1dnDlv5hbguMvFG6Fzt/bUFKKrqZOuamSs1ObliaHqheI/oj24d1z5+FiQU3kARYao4TWbBptcEj63mSQEXOh7Juxkl4nBAPiSC7ugUcZy2Tkykx9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pybLVCpj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pybLVCpj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b9a18f53afso2424275ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 20:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778989492; x=1779594292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Msd/ZNvVZHJfF3onmjoSuNe5tIT8QpvjGmg4z+SRhH4=;
        b=pybLVCpjezHVuudOQ+xlYDcPVl6QlwePLGzJRkGZj5hNZMz0Vi4dQlkF+IaiLczYsj
         wPhTX1T7HTle5ncHFlQ+A3RuZ0kj81lKEqTiIKmx1r5UFMn5KT9zS4fljBLp0O+stfxH
         P3aVjTwK3AUBeQf/XA3//JFRriXTR/GfTcpNp/8lM4fAEhQugKIwmS7NoRNvxeC3XM7s
         yXLmg/Q/omLsWboZBrv0Ur1ZEw3BU14V3IkgOmgZKudVoM6ydrY4wx9w9+Ejy5ElvrB7
         +FCFffWOAyNiqaZUGhSLkOrJAjTVAGrqC8b8El24a7i31NLKxhBzLQDmJkop1uuNpEKY
         lFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778989492; x=1779594292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Msd/ZNvVZHJfF3onmjoSuNe5tIT8QpvjGmg4z+SRhH4=;
        b=U2gn2aREPF6l6VTZ3CNUThIHB2e4n2YdSRPmx2ozV+ggTke0A5QqumycidSyQcq4cx
         BUjspJjINLK/hWrck2y5bEGW/lw3BVzqzzQj/SviPI4QC7i8+ILa/k81LgNSxL50hD9V
         hs+YkS+0GGT3EjHubspLFGR+Iu5IoxLwYYKAfUl5PhZGXmICG8kC3birgZNwBhuEdAA2
         R/fZLIMK2aEJvPPiNfNlxAzvhso3JWp+1z3QKHM0Q8zf12F745Th0/TcEExMzxqkkGhP
         uJ8bq/6T8aDrbNtDY1s4QzA4igKz3XoTm6u3Oj3RBSVz8uRwzrz2npWzmAh3D0Cvi7vd
         zhjg==
X-Gm-Message-State: AOJu0Yws0prDSqxZ3oruShYOT+TH4nqiCNYrj/IY1YX0Yh6OBgCTYvW4
	ynMzqCNPhFGX/1mY5o4obEKJENdy1pVJ2w+u4ngNzYhqMfL5QJrWON6B
X-Gm-Gg: Acq92OGmo1hyX9McLYwLtWCAG0bDGyuvfay550xwIweQiKu6Fc3zMbfcdAu7Ir3DP7y
	Jh9xs84kGtcfemXOrq6agULdb32WBrjJQ+R/IWucRRQXiIVOxXpWmEVYIom+tFr8cPKpavOf0Qi
	ITiS3N9tnHU9aFHpIpVordwv5q4NZZysnSLT4V/gCotMDr15CHWAEVMiyz+xwVBAcdvlV3VdbuO
	IGduWYJ9GNxaVaziVsWfNHhIepu5d0hEjURIm0wIYtY6jBNazdxA1ZnfSqYAo0xG+6og+UG4atE
	zQyWJqnUT0u6RHyxcds1yaIytI8mfcGH3lNMxpMLEBa6qFfHYlWLx7ipvv0y+K1SaZzi7vByC+/
	n7bRMhVVD9rv7yiM/gXL6DE7jS46DdnT7yh0vyf4r3m9OUIxJuy/xF4u+syntaI47aqTx+0TWYZ
	z7bsGucFA99y33KErl
X-Received: by 2002:a17:90b:2743:b0:368:65d4:486b with SMTP id 98e67ed59e1d1-36951b8707cmr5846532a91.3.1778989492270;
        Sat, 16 May 2026 20:44:52 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369515895d2sm6828185a91.8.2026.05.16.20.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 20:44:51 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ntfs: remove unsupported quota handling
Date: Sun, 17 May 2026 12:44:47 +0900
Message-ID: <20260517034447.1330941-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ntfs driver does not implement quota accounting.  It creates
new inodes with the NTFS 1.2 $STANDARD_INFORMATION layout and does
not maintain the NTFS 3.x owner_id/quota_charged fields or the
$Quota usage records that Windows would need for meaningful quota
accounting.

The only runtime quota path left in the driver is the remount-rw
code that tries to mark $Quota/$Q out of date, plus the mount-time
code that loads $Quota and its $Q index solely to support that
marker.

Since the driver does not maintain the per-file quota metadata,
setting QUOTA_FLAG_OUT_OF_DATE does not make the quota state
meaningful, and failures in this unsupported path can unnecessarily
block remount-rw or force a mount read-only.

Remove the quota marker, the $Quota/$Q loading state, and the
unused quota volume flag.  Keep the on-disk quota layout definitions
in layout.h so the documented NTFS structures remain available.

Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
Link: https://lore.kernel.org/all/CANFS6bYTzioqZjYt=51Kb9RdR3MKXaez_fh_WCLoym093VxFmg@mail.gmail.com/
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
This is the standalone patch agreed in the discussion (see the Link:
above): the earlier "$Quota view-index lookup" fix series is being
dropped because the ntfs driver does not implement quota accounting, so
the unsupported quota loading/marking path is removed instead of fixed.

Tested:
- Applied on 5d6919055dec (Linux 7.1-rc3).
- Built with CONFIG_NTFS_FS=y.
- Booted the patched kernel in QEMU with an mkfs.ntfs-created NTFS 3.1
  image containing $Extend/$Quota.
- Mounted the image read-only, remounted it read-write, created a
  directory and file, read the file back, remounted read-only, unmounted,
  mounted read-only again, and read the file back again.
- Verified no remaining runtime quota references outside layout.h
  definitions.

 fs/ntfs/Makefile |   2 +-
 fs/ntfs/quota.c  |  95 -----------------------------------------
 fs/ntfs/quota.h  |  15 -------
 fs/ntfs/super.c  | 109 +----------------------------------------------
 fs/ntfs/volume.h |   7 ---
 5 files changed, 2 insertions(+), 226 deletions(-)
 delete mode 100644 fs/ntfs/quota.c
 delete mode 100644 fs/ntfs/quota.h

diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
index 0ce4d9a9388a..e120c2e69862 100644
--- a/fs/ntfs/Makefile
+++ b/fs/ntfs/Makefile
@@ -5,6 +5,6 @@ obj-$(CONFIG_NTFS_FS) += ntfs.o
 ntfs-y := aops.o attrib.o collate.o dir.o file.o index.o inode.o \
 	  mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o \
 	  upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
-	  iomap.o debug.o sysctl.o quota.o object_id.o bdev-io.o
+	  iomap.o debug.o sysctl.o object_id.o bdev-io.o
 
 ccflags-$(CONFIG_NTFS_DEBUG) += -DDEBUG
diff --git a/fs/ntfs/quota.c b/fs/ntfs/quota.c
deleted file mode 100644
index b443243b58fb..000000000000
--- a/fs/ntfs/quota.c
+++ /dev/null
@@ -1,95 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * NTFS kernel quota ($Quota) handling.
- *
- * Copyright (c) 2004 Anton Altaparmakov
- */
-
-#include "index.h"
-#include "quota.h"
-#include "debug.h"
-#include "ntfs.h"
-
-/*
- * ntfs_mark_quotas_out_of_date - mark the quotas out of date on an ntfs volume
- * @vol:	ntfs volume on which to mark the quotas out of date
- *
- * Mark the quotas out of date on the ntfs volume @vol and return 'true' on
- * success and 'false' on error.
- */
-bool ntfs_mark_quotas_out_of_date(struct ntfs_volume *vol)
-{
-	struct ntfs_index_context *ictx;
-	struct quota_control_entry *qce;
-	const __le32 qid = QUOTA_DEFAULTS_ID;
-	int err;
-
-	ntfs_debug("Entering.");
-	if (NVolQuotaOutOfDate(vol))
-		goto done;
-	if (!vol->quota_ino || !vol->quota_q_ino) {
-		ntfs_error(vol->sb, "Quota inodes are not open.");
-		return false;
-	}
-	inode_lock(vol->quota_q_ino);
-	ictx = ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino), I30, 4);
-	if (!ictx) {
-		ntfs_error(vol->sb, "Failed to get index context.");
-		goto err_out;
-	}
-	err = ntfs_index_lookup(&qid, sizeof(qid), ictx);
-	if (err) {
-		if (err == -ENOENT)
-			ntfs_error(vol->sb, "Quota defaults entry is not present.");
-		else
-			ntfs_error(vol->sb, "Lookup of quota defaults entry failed.");
-		goto err_out;
-	}
-	if (ictx->data_len < offsetof(struct quota_control_entry, sid)) {
-		ntfs_error(vol->sb, "Quota defaults entry size is invalid.  Run chkdsk.");
-		goto err_out;
-	}
-	qce = (struct quota_control_entry *)ictx->data;
-	if (le32_to_cpu(qce->version) != QUOTA_VERSION) {
-		ntfs_error(vol->sb,
-			"Quota defaults entry version 0x%x is not supported.",
-			le32_to_cpu(qce->version));
-		goto err_out;
-	}
-	ntfs_debug("Quota defaults flags = 0x%x.", le32_to_cpu(qce->flags));
-	/* If quotas are already marked out of date, no need to do anything. */
-	if (qce->flags & QUOTA_FLAG_OUT_OF_DATE)
-		goto set_done;
-	/*
-	 * If quota tracking is neither requested, nor enabled and there are no
-	 * pending deletes, no need to mark the quotas out of date.
-	 */
-	if (!(qce->flags & (QUOTA_FLAG_TRACKING_ENABLED |
-			QUOTA_FLAG_TRACKING_REQUESTED |
-			QUOTA_FLAG_PENDING_DELETES)))
-		goto set_done;
-	/*
-	 * Set the QUOTA_FLAG_OUT_OF_DATE bit thus marking quotas out of date.
-	 * This is verified on WinXP to be sufficient to cause windows to
-	 * rescan the volume on boot and update all quota entries.
-	 */
-	qce->flags |= QUOTA_FLAG_OUT_OF_DATE;
-	/* Ensure the modified flags are written to disk. */
-	ntfs_index_entry_mark_dirty(ictx);
-set_done:
-	ntfs_index_ctx_put(ictx);
-	inode_unlock(vol->quota_q_ino);
-	/*
-	 * We set the flag so we do not try to mark the quotas out of date
-	 * again on remount.
-	 */
-	NVolSetQuotaOutOfDate(vol);
-done:
-	ntfs_debug("Done.");
-	return true;
-err_out:
-	if (ictx)
-		ntfs_index_ctx_put(ictx);
-	inode_unlock(vol->quota_q_ino);
-	return false;
-}
diff --git a/fs/ntfs/quota.h b/fs/ntfs/quota.h
deleted file mode 100644
index 4b7322661a32..000000000000
--- a/fs/ntfs/quota.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Defines for NTFS kernel quota ($Quota) handling.
- *
- * Copyright (c) 2004 Anton Altaparmakov
- */
-
-#ifndef _LINUX_NTFS_QUOTA_H
-#define _LINUX_NTFS_QUOTA_H
-
-#include "volume.h"
-
-bool ntfs_mark_quotas_out_of_date(struct ntfs_volume *vol);
-
-#endif /* _LINUX_NTFS_QUOTA_H */
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 22dc7865eca7..a518dd1802f3 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -17,7 +17,6 @@
 
 #include "sysctl.h"
 #include "logfile.h"
-#include "quota.h"
 #include "index.h"
 #include "ntfs.h"
 #include "ea.h"
@@ -240,8 +239,7 @@ static int ntfs_reconfigure(struct fs_context *fc)
 	 * flags are set.  Also, empty the logfile journal as it would become
 	 * stale as soon as something is written to the volume and mark the
 	 * volume dirty so that chkdsk is run if the volume is not umounted
-	 * cleanly.  Finally, mark the quotas out of date so Windows rescans
-	 * the volume on boot and updates them.
+	 * cleanly.
 	 *
 	 * When remounting read-only, mark the volume clean if no volume errors
 	 * have occurred.
@@ -274,12 +272,6 @@ static int ntfs_reconfigure(struct fs_context *fc)
 			NVolSetErrors(vol);
 			return -EROFS;
 		}
-		if (!ntfs_mark_quotas_out_of_date(vol)) {
-			ntfs_error(sb, "Failed to mark quotas out of date%s",
-					es);
-			NVolSetErrors(vol);
-			return -EROFS;
-		}
 	} else if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY)) {
 		/* Remounting read-only. */
 		if (!NVolErrors(vol)) {
@@ -1154,73 +1146,6 @@ static int check_windows_hibernation_status(struct ntfs_volume *vol)
 	return ret;
 }
 
-/*
- * load_and_init_quota - load and setup the quota file for a volume if present
- * @vol:	ntfs super block describing device whose quota file to load
- *
- * Return 'true' on success or 'false' on error.  If $Quota is not present, we
- * leave vol->quota_ino as NULL and return success.
- */
-static bool load_and_init_quota(struct ntfs_volume *vol)
-{
-	static const __le16 Quota[7] = { cpu_to_le16('$'),
-			cpu_to_le16('Q'), cpu_to_le16('u'),
-			cpu_to_le16('o'), cpu_to_le16('t'),
-			cpu_to_le16('a'), 0 };
-	static __le16 Q[3] = { cpu_to_le16('$'),
-			cpu_to_le16('Q'), 0 };
-	struct ntfs_name *name = NULL;
-	u64 mref;
-	struct inode *tmp_ino;
-
-	ntfs_debug("Entering.");
-	/*
-	 * Find the inode number for the quota file by looking up the filename
-	 * $Quota in the extended system files directory $Extend.
-	 */
-	inode_lock(vol->extend_ino);
-	mref = ntfs_lookup_inode_by_name(NTFS_I(vol->extend_ino), Quota, 6,
-			&name);
-	inode_unlock(vol->extend_ino);
-	kfree(name);
-	if (IS_ERR_MREF(mref)) {
-		/*
-		 * If the file does not exist, quotas are disabled and have
-		 * never been enabled on this volume, just return success.
-		 */
-		if (MREF_ERR(mref) == -ENOENT) {
-			ntfs_debug("$Quota not present.  Volume does not have quotas enabled.");
-			/*
-			 * No need to try to set quotas out of date if they are
-			 * not enabled.
-			 */
-			NVolSetQuotaOutOfDate(vol);
-			return true;
-		}
-		/* A real error occurred. */
-		ntfs_error(vol->sb, "Failed to find inode number for $Quota.");
-		return false;
-	}
-	/* Get the inode. */
-	tmp_ino = ntfs_iget(vol->sb, MREF(mref));
-	if (IS_ERR(tmp_ino)) {
-		if (!IS_ERR(tmp_ino))
-			iput(tmp_ino);
-		ntfs_error(vol->sb, "Failed to load $Quota.");
-		return false;
-	}
-	vol->quota_ino = tmp_ino;
-	/* Get the $Q index allocation attribute. */
-	tmp_ino = ntfs_index_iget(vol->quota_ino, Q, 2);
-	if (IS_ERR(tmp_ino)) {
-		ntfs_error(vol->sb, "Failed to load $Quota/$Q index.");
-		return false;
-	}
-	vol->quota_q_ino = tmp_ino;
-	ntfs_debug("Done.");
-	return true;
-}
-
 /*
  * load_and_init_attrdef - load the attribute definitions table for a volume
  * @vol:	ntfs super block describing device whose attrdef to load
@@ -1638,18 +1563,6 @@ static bool load_system_files(struct ntfs_volume *vol)
 		ntfs_error(sb, "Failed to load $Extend.");
 		goto iput_sec_err_out;
 	}
-	/* Find the quota file, load it if present, and set it up. */
-	if (!load_and_init_quota(vol) &&
-	    vol->on_errors == ON_ERRORS_REMOUNT_RO) {
-		static const char *es1 = "Failed to load $Quota";
-		static const char *es2 = ".  Run chkdsk.";
-
-		sb->s_flags |= SB_RDONLY;
-		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		/* This will prevent a read-write remount. */
-		NVolSetErrors(vol);
-	}
-
 	return true;
 
 iput_sec_err_out:
@@ -1747,10 +1660,6 @@ static void ntfs_put_super(struct super_block *sb)
 
 	/* NTFS 3.0+ specific. */
 	if (vol->major_ver >= 3) {
-		if (vol->quota_q_ino)
-			ntfs_commit_inode(vol->quota_q_ino);
-		if (vol->quota_ino)
-			ntfs_commit_inode(vol->quota_ino);
 		if (vol->extend_ino)
 			ntfs_commit_inode(vol->extend_ino);
 		if (vol->secure_ino)
@@ -1799,14 +1708,6 @@ static void ntfs_put_super(struct super_block *sb)
 
 	/* NTFS 3.0+ specific clean up. */
 	if (vol->major_ver >= 3) {
-		if (vol->quota_q_ino) {
-			iput(vol->quota_q_ino);
-			vol->quota_q_ino = NULL;
-		}
-		if (vol->quota_ino) {
-			iput(vol->quota_ino);
-			vol->quota_ino = NULL;
-		}
 		if (vol->extend_ino) {
 			iput(vol->extend_ino);
 			vol->extend_ino = NULL;
@@ -2455,14 +2356,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	vol->vol_ino = NULL;
 	/* NTFS 3.0+ specific clean up. */
 	if (vol->major_ver >= 3) {
-		if (vol->quota_q_ino) {
-			iput(vol->quota_q_ino);
-			vol->quota_q_ino = NULL;
-		}
-		if (vol->quota_ino) {
-			iput(vol->quota_ino);
-			vol->quota_ino = NULL;
-		}
 		if (vol->extend_ino) {
 			iput(vol->extend_ino);
 			vol->extend_ino = NULL;
diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
index af41427ec622..e13e1423b2a9 100644
--- a/fs/ntfs/volume.h
+++ b/fs/ntfs/volume.h
@@ -76,8 +76,6 @@
  * @root_ino: The VFS inode of the root directory.
  * @secure_ino: The VFS inode of $Secure (NTFS3.0+ only, otherwise NULL).
  * @extend_ino: The VFS inode of $Extend (NTFS3.0+ only, otherwise NULL).
- * @quota_ino: The VFS inode of $Quota.
- * @quota_q_ino: Attribute inode for $Quota/$Q.
  * @nls_map: NLS (National Language Support) table.
  * @nls_utf8: NLS table for UTF-8.
  * @free_waitq: Wait queue for threads waiting for free clusters or MFT records.
@@ -141,8 +139,6 @@ struct ntfs_volume {
 	struct inode *root_ino;
 	struct inode *secure_ino;
 	struct inode *extend_ino;
-	struct inode *quota_ino;
-	struct inode *quota_q_ino;
 	struct nls_table *nls_map;
 	bool nls_utf8;
 	wait_queue_head_t free_waitq;
@@ -165,7 +161,6 @@ struct ntfs_volume {
  *				Otherwise be case insensitive but still
  *				create file names in POSIX namespace.
  * NV_LogFileEmpty		LogFile journal is empty.
- * NV_QuotaOutOfDate		Quota is out of date.
  * NV_UsnJrnlStamped		UsnJrnl has been stamped.
  * NV_ReadOnly			Volume is mounted read-only.
  * NV_Compression		Volume supports compression.
@@ -186,7 +181,6 @@ enum {
 	NV_ShowSystemFiles,
 	NV_CaseSensitive,
 	NV_LogFileEmpty,
-	NV_QuotaOutOfDate,
 	NV_UsnJrnlStamped,
 	NV_ReadOnly,
 	NV_Compression,
@@ -223,7 +217,6 @@ DEFINE_NVOL_BIT_OPS(Errors)
 DEFINE_NVOL_BIT_OPS(ShowSystemFiles)
 DEFINE_NVOL_BIT_OPS(CaseSensitive)
 DEFINE_NVOL_BIT_OPS(LogFileEmpty)
-DEFINE_NVOL_BIT_OPS(QuotaOutOfDate)
 DEFINE_NVOL_BIT_OPS(UsnJrnlStamped)
 DEFINE_NVOL_BIT_OPS(ReadOnly)
 DEFINE_NVOL_BIT_OPS(Compression)

base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.43.0

