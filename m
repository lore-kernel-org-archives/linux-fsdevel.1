Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F86405C21
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888983; cv=none; b=E0XHwj/jvkeYepU35BE73BgRg6IZVYuDhH/XMZ5hELh2tGW5GYEl3W1lzTb1psk1h/MxHNMXMectCvqPysC9z4Ty7D2Xu+J7gvhPMMSzCJd0o51GVXkMvEk0OplhECcOXsBJRAkLmTPgf9ta2NvC3BMisVLUNMNpkMYJwmSXCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888983; c=relaxed/simple;
	bh=5IqH3rtxy34dNHAACvs5lP8NKiJT6VKmEanaZWVybaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWch/dN4DLSTmkYzVn3lUSLyMgiuIoS7nOvU93XW8xEBbAWzOkFZ7QAbxikf1fcG398mxUdHF6PMeDnkRwyPqy1z/ljWLzhm0iISuAKs8kzRdDD7PR1ZTjB6KhGDEwn8HNCy5NRAw3D80KN7e3lQprRAo+ZQ8wLUG/BUbBvE6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lihdd.net; spf=pass smtp.mailfrom=lihdd.net; dkim=pass (2048-bit key) header.d=lihdd.net header.i=@lihdd.net header.b=jqmyCbEd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lihdd.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lihdd.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lihdd.net header.i=@lihdd.net header.b="jqmyCbEd"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cbc593a67aso52296785a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lihdd.net; s=google; t=1778888981; x=1779493781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQzTKnRgvG1KzI5oOnwgsBb/NWXP2/hzb5cjXiyHb24=;
        b=jqmyCbEddk9PcbWAmZs3GoXYXtqeBaFyFQ0l6FD87XnVuD7XJSgIqRYgMiLhJoBZg5
         Bfr3wnuPLHtBgzKGasH8dkXeb6h+npLuEIf+r4+kh69lu66LdmIBwzS+R2WVAvjx6pc2
         Z2Cj7tms5wwzH/JbxXZ0hXuCaqvLE5WOWlwlR4I51Bod5sSIOAc2dZlc/ktwOJ85OGeE
         Q1bfl/0KYE+cQMy357gfF+APm4X3rBx+zKiFbyMg/Zz/gxCc7TSJTFmsHheqhlCqP5x4
         Me0EYsP7TI8ZxDcfKtv7ivHa/HI7GLDn5rJpliV9G5vnWoT1wp24Ze1FpMrAsV+zfI1L
         TFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888981; x=1779493781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQzTKnRgvG1KzI5oOnwgsBb/NWXP2/hzb5cjXiyHb24=;
        b=I0Ggqr6gMHTZFlfV+IwGmhnvgzvamYn3s5LTCFrpvNEwUQJaEjFnGc4EWvLodGXSwm
         /rqt4Y4fZUX8b8aimOyX0moyp9nQvOL92pSeS/neFLeYPLjV4geHw41EgGymJ+iSPPM9
         qmcvYvTb065QuBAcrTSfVRnN2m6K95ARmzpGmceN/cb92piCSh3N3Tftwg+/U/PD239F
         VxlzsiSNOSlF9g3bsTyNm/rtyOe4lG+rpqw7g/dN3E7EBwFaYVF63cPxdouwOmn8RiHR
         FgsBs3U7pMh/yJ6GpDq7pMVv3QxVg0iaTsfIBCH1P3nDHT3moFSdnWPCLkPbtbLTbjsO
         a3sg==
X-Forwarded-Encrypted: i=1; AFNElJ+az1BC2XSKieKlan0SvhGdCEKEUnjmqMuJRmZF9ObPqVJyKa5+cgeS3VrO/FnMQ7H3oDEHVKWbJrkzdPER@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGaNgL89TNbhGZGkshX+5eJddyxDk0MymRZxiuI40svOb5bK7
	xAXlmiJQwB56xxujhmdHF7E8v1i/2tYILm1UOYgwohgrRSa159r8vFhZHa0tXRcHhQ5AUcjRUoY
	ZXtAM
X-Gm-Gg: Acq92OHhz6rhGcsFG9UMTXo4spktGBjAQ63IdrHrJc+0FN5Smb9QIQX2Bo+MtGkjYr5
	nvHiw3sT8Yru/2vFzmBfPkjUZORIaw15cZjnxnzqqQIyWxid1usA7zLXaefcrDqf57XQL0qm4QV
	KlVU3E3PwhMDNHgqfqaQjG/cfO/N3xckieTvu3b8d1OMGy26KHLaH0oC/1rN1HOacTae0NMqd+4
	B//NW4U8bQmUGGYYOz3rT520RQsAprd+IAOQtwgHp6nb12SJM5QVH5M8VT3e5rWk4rVjnWtleJR
	yoRXunhUAwCIWb0FYIi/lxXT/8nj2fuGDrZ/YnALsTzKmgndtTY+9ERHuw7PU4vFhPX6Si96eFM
	o3ZNLE1gjV4aiS0Y63na43tInuSfaEnpkoNLCoGF9lPsHD6G23uJDdNOvenlKmvSUQYsa/WFfEd
	lF5C2emNbcKTtdMeEox9nvFvUqc0fN/uSk3cLfFg==
X-Received: by 2002:a05:693c:2c8d:b0:2d9:6373:ad0a with SMTP id 5a478bee46e88-3039818738dmr790404eec.11.1778800158757;
        Thu, 14 May 2026 16:09:18 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ.thefacebook.com ([2620:10d:c090:500::1:695d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc464sm5159778eec.14.2026.05.14.16.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:09:17 -0700 (PDT)
From: Jun Wu <quark@lihdd.net>
To: miklos@szeredi.hu
Cc: luis@igalia.com,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Jun Wu <quark@meta.com>
Subject: [PATCH v2] fuse: invalidate readdir cache on epoch bump
Date: Thu, 14 May 2026 16:09:15 -0700
Message-ID: <20260514230915.1208130-1-quark@lihdd.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260331223927.763741-1-quark@lihdd.net>
References: <20260331223927.763741-1-quark@lihdd.net>
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

Minimal reproducer:

- mount a tiny FUSE fs with an empty root directory
- on opendir, enable fi->cache_readdir and fi->keep_cache
- chdir into the mount and call readdir(".") to populate readdir cache
- make the FUSE server report one file in the root directory
- send only FUSE_NOTIFY_INC_EPOCH
- call readdir(".") again; before this change it stays stale, after this
  change it sees the new file

Fixes: 2396356a945b ("fuse: add more control over cache invalidation behaviour")
Signed-off-by: Jun Wu <quark@meta.com>
---
Changes in v2:
- Addresses Joanne Koong's suggestions:
  - Drop the FUSE_EPOCH_READDIR init flag.
  - Add Fixes tag.
- Rebase onto current mainline.
---
 fs/fuse/dev.c     | 6 +++---
 fs/fuse/fuse_i.h  | 3 +++
 fs/fuse/readdir.c | 5 ++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..35e04b064f37 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2038,9 +2038,9 @@ static int fuse_notify_resend(struct fuse_conn *fc)
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
index 17423d4e3cfa..aa8d6dfbbcc7 100644
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
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index db5ae8ec1030..b18d971e2bb4 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -442,6 +442,7 @@ static void fuse_rdc_reset(struct inode *inode)
 	fi->rdc.version++;
 	fi->rdc.size = 0;
 	fi->rdc.pos = 0;
+	fi->rdc.epoch = 0;
 }
 
 #define UNCACHED 1
@@ -483,6 +484,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		if (!ctx->pos && !fi->rdc.size) {
 			fi->rdc.mtime = inode_get_mtime(inode);
 			fi->rdc.iversion = inode_query_iversion(inode);
+			fi->rdc.epoch = atomic_read(&fc->epoch);
 		}
 		spin_unlock(&fi->rdc.lock);
 		return UNCACHED;
@@ -496,7 +498,8 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 		struct timespec64 mtime = inode_get_mtime(inode);
 
 		if (inode_peek_iversion(inode) != fi->rdc.iversion ||
-		    !timespec64_equal(&fi->rdc.mtime, &mtime)) {
+		    !timespec64_equal(&fi->rdc.mtime, &mtime) ||
+		    fi->rdc.epoch != atomic_read(&fc->epoch)) {
 			fuse_rdc_reset(inode);
 			goto retry_locked;
 		}
-- 
2.54.0

