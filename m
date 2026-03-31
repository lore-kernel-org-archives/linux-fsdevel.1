Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D90451071
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996771; cv=none; b=lnMTdhWSVyc+WWYm9odIWgESGT2ckefDoC68Q6TtoPE+KQXUpECtDepfXGe4dUEUXk2bZeSCLb2P+Wm2joglVVeDyt3SBSOZjuv+OvX0ubzajiwcuC9VWKw83hNv2Nb55dIBvw9+Wj/c4gVovCeIvIC0lUn1039ZVZmCl/Q0JKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996771; c=relaxed/simple;
	bh=S9RuAMB2fZuld8BvpfYfbzo39zLvD3jBOcZ0dMrisbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3MrgR1iQPpontuEtvEhnxqc0pe1NtD7nGoKzypjr1zzZxa+HuZah1U45ZcAfD1jsnuN7btckfn/CXRxXuB1FWGtT3+wyPS6fjEh5Rfwycd0FuyseTa2bOc7a2+5lHieQz08HDLTS//BKPCfaEhREDUjk1D9jrw0WPpqf934pqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lihdd.net; spf=pass smtp.mailfrom=lihdd.net; dkim=pass (2048-bit key) header.d=lihdd-net.20230601.gappssmtp.com header.i=@lihdd-net.20230601.gappssmtp.com header.b=lUovtSJ3; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lihdd.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lihdd.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lihdd-net.20230601.gappssmtp.com header.i=@lihdd-net.20230601.gappssmtp.com header.b="lUovtSJ3"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128e4d0cc48so7487528c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lihdd-net.20230601.gappssmtp.com; s=20230601; t=1774996769; x=1775601569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm+FlVMYZHdB9Hh8UvEQceL98qYrwUTTEvWIs+d+wiU=;
        b=lUovtSJ3sBXcbqlrw89z2Dgc99oxOL92EZOmP33RnTjrT9c/Wiv9G5zhJGkEfWObnh
         NKE5HDDPoUCMMv3aAuMlyIM33sIu4cKnl/SX5lKb/nlgJvjW3bkrdH5UtB9Lsxa6sUoH
         wKXKurmJeUVA5yd/he3y8/0lJq2oUeBCUxehOc7tuLCTCUKyPsRWvbloq5laQS3otaHL
         3eu6zFftwuqMJyMPiV0YeIyDprfd7pdjoG9kqDjnAYXNuqaYzqJzueFrcYzisgZrCsR6
         EdQYkjNqS2tqKPw9milcRTepqumWlMrcphpLMp0h1L1AtVeFXMCxsXo1K97ZG0Q/FBYY
         2V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774996769; x=1775601569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm+FlVMYZHdB9Hh8UvEQceL98qYrwUTTEvWIs+d+wiU=;
        b=IV4o0rumc6nQ6jGAUlvGk9G0trIMOHa45DtUupYTSYh1a2AmOUv2rAUX4AKF02MHkW
         yh7O3nsOaIF7nK4KMtrKCz8oMeChrlY2R6dS951y/dDk+6aS+rRS++NgovZ4GACaxQW6
         Qy2+FIqzaVqdd3Fx/YK5xxyVhoiN+ilnvoL2bpHD6OlVfIOv5iML5gViy7ECJPLXxSIl
         d2pGy8CnMxbAfyGN5e0cOq1EM4GdQUz3SqNnjFdy3YQlGLFFWaoWOTGnon9FHE2lOLvL
         AEtqq8zlEmMRACykakETu2GP1B1aMPp1F3/LNGSzl28lTsLoG0EXoUw6QaqRCP+ZA4Sm
         F+bw==
X-Gm-Message-State: AOJu0YwmgUn1mRXxijk3LkKNbfIfwdFg6MLaR987LjyuN3j1qTgkLR4o
	hsvkX+n1WjivrVcgimaZy7JZpDBGr8IYdO+kRSwcyqe4Yt7q7xUTTLUupvN097K11p8=
X-Gm-Gg: ATEYQzwdZPDWnezYnt3CcKFCbCtMs/J9zRr6d/JaRd9aQIokAwPEOjRh6+Sbr6J+PbX
	KQOgiPOxSS/E27zt3OAMeLz3D3Dl5XnQV/nmNBh9VchozQjpGcXsPx9BOso6o5yrVXydWg9srKr
	Hmo6mBV7gMYWx/Mh5I1/eAWcLuLEylWGjZjRPbFMC48M9ceEl8O2lNW1fWGb/6KKZHXkKRJHXa6
	ndJYWdbxwAby9C6HHdlDUiSkPU7eLkXZ+lxMPP1T08YJ8d3d6CZbgO57QlR+Kemnc8U6+RgG9UV
	6ouTm5qDhlqwhmgb1bj5IXhv4ADvDuva8a6kwFIVd+fUeGdQAfw/TSMkgmlTZVsQ8jLkRz3X3Sd
	py3usdBIyAAZt4DMOvP6cv3zi4E8B/+kA/215TTemYnsbiQW5iNFic0kjNaEP0ZiIuvsLOz5Ps8
	W5uOLaPW6lEJaShxlACfwq6KbfgHPv5esR5EdWmw==
X-Received: by 2002:a05:7300:d50c:b0:2c5:704f:714a with SMTP id 5a478bee46e88-2c930c77e37mr708323eec.8.1774996769531;
        Tue, 31 Mar 2026 15:39:29 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ.thefacebook.com ([2620:10d:c090:500::1:40f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2ff2sm11412790eec.18.2026.03.31.15.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 15:39:29 -0700 (PDT)
From: Jun Wu <quark@lihdd.net>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	Jun Wu <quark@meta.com>
Subject: [PATCH] fuse: invalidate readdir cache on epoch bump
Date: Tue, 31 Mar 2026 15:39:27 -0700
Message-ID: <20260331223927.763741-1-quark@lihdd.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Wu <quark@meta.com>

FUSE_NOTIFY_INC_EPOCH invalidates dentries, but does not invalidate cached
readdir results. A process with cwd inside a FUSE mount can therefore
observe stale readdir(".") output after an epoch bump.

Fix this by recording epoch in the readdir cache and checking it on reuse.

Add FUSE_EPOCH_READDIR init flag so userspace can detect this change.

Minimal reproducer:

- mount a tiny FUSE fs with an empty root directory
- on opendir, enable fi->cache_readdir and fi->keep_cache
- chdir into the mount and call readdir(".") to populate readdir cache
- make the FUSE server report one file in the root directory
- send only FUSE_NOTIFY_INC_EPOCH
- call readdir(".") again; before this change it stays stale, after this
  change it sees the new file

Signed-off-by: Jun Wu <quark@meta.com>
---
 fs/fuse/dev.c             | 6 +++---
 fs/fuse/fuse_i.h          | 3 +++
 fs/fuse/inode.c           | 2 +-
 fs/fuse/readdir.c         | 5 ++++-
 include/uapi/linux/fuse.h | 3 +++
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170..595f90f44772 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2039,9 +2039,9 @@ static int fuse_notify_resend(struct fuse_conn *fc)
 }
 
 /*
- * Increments the fuse connection epoch.  This will result of dentries from
- * previous epochs to be invalidated.  Additionally, if inval_wq is set, a work
- * queue is scheduled to trigger the invalidation.
+ * Increments the fuse connection epoch.  This will cause dentries and
+ * readdir caches from previous epochs to be invalidated.  Additionally,
+ * if inval_wq is set, a work queue is scheduled to trigger the invalidation.
  */
 static int fuse_notify_inc_epoch(struct fuse_conn *fc)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..9b479f597938 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -191,6 +191,9 @@ struct fuse_inode {
 			/* iversion of directory when cache was started */
 			u64 iversion;
 
+			/* epoch of fc when cache was started */
+			int epoch;
+
 			/* protects above fields */
 			spinlock_t lock;
 		} rdc;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c795abe47a4f..5685e696ee2f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1506,7 +1506,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
 		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_REQUEST_TIMEOUT | FUSE_EPOCH_READDIR;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..240b0e993780 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -438,6 +438,7 @@ static void fuse_rdc_reset(struct inode *inode)
 	fi->rdc.version++;
 	fi->rdc.size = 0;
 	fi->rdc.pos = 0;
+	fi->rdc.epoch = 0;
 }
 
 #define UNCACHED 1
@@ -479,6 +480,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		if (!ctx->pos && !fi->rdc.size) {
 			fi->rdc.mtime = inode_get_mtime(inode);
 			fi->rdc.iversion = inode_query_iversion(inode);
+			fi->rdc.epoch = atomic_read(&fc->epoch);
 		}
 		spin_unlock(&fi->rdc.lock);
 		return UNCACHED;
@@ -492,7 +494,8 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		struct timespec64 mtime = inode_get_mtime(inode);
 
 		if (inode_peek_iversion(inode) != fi->rdc.iversion ||
-		    !timespec64_equal(&fi->rdc.mtime, &mtime)) {
+		    !timespec64_equal(&fi->rdc.mtime, &mtime) ||
+		    fi->rdc.epoch != atomic_read(&fc->epoch)) {
 			fuse_rdc_reset(inode);
 			goto retry_locked;
 		}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..b0bd96ac1e84 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -240,6 +240,7 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *  - add FUSE_EPOCH_READDIR
  */
 
 #ifndef _LINUX_FUSE_H
@@ -448,6 +449,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_EPOCH_READDIR: epoch bump also invalidates readdir caches
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -495,6 +497,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_EPOCH_READDIR	(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.53.0

