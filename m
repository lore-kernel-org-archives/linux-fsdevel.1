Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776B3FE65A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344430; cv=none; b=UMPLNpKedc0WxWpdk5/VbPe9XyG8L/YRtCkXt2tJgfByBQoKrbU3BqSn4Y3nM2yC7ukfAv4RPM76R5JhtlbFtoCTit2t/R+1T3XDgRAieHB/ylnOeckKaLmCJawSGJkk7V2Vc+Ixo0OYv5S1OPElzzlGP9bVZ1rB7pNqbsaH7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344430; c=relaxed/simple;
	bh=MZavd0jSQlziu+keekTorMUZeMxpzzWZ9f/1W50joFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5ZqY9IBqOJFIeBzwBagv3ASOBxjCfilr7/RnZSYPuuBQQDNepz/ZhzToRZR7L1Enf/6ImJ0BWtCVkgbgBKQqXNo/cic+LMsz0Vi1Mnt8TBojBpHvU8VZS4g5ofwxZ7G9jROkasLhrSzTrZBS3CpS5gDU8BXPDVbOBb0U9uOLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdn9TFU8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOWF06HP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdn9TFU8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOWF06HP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773344428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eI0jqRElybdBmM2uJMV+/w5888Pk7vjLOuX+knpayM=;
	b=Mdn9TFU8N4Op3bmWGjB5EF2mrwkHGGR+kMkho7y8yxblfFhabKPIca0Aq+UbZ9xvt2HtVV
	/woIlWgBd1OTWREdYPKi2+ZTj8PBDw3aR4vhbF/GIFxFa0SGep3CHysyDvT6iyYYTAq1JY
	OGEus2Xi2zkdC+PBQCSHsM16BFm+dBQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-xodJkChvM5qgUL62NnEjVA-1; Thu, 12 Mar 2026 15:40:27 -0400
X-MC-Unique: xodJkChvM5qgUL62NnEjVA-1
X-Mimecast-MFC-AGG-ID: xodJkChvM5qgUL62NnEjVA_1773344426
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439da07c5bfso1004367f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 12:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773344425; x=1773949225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eI0jqRElybdBmM2uJMV+/w5888Pk7vjLOuX+knpayM=;
        b=EOWF06HPQMzLcYj4Pf0bWbqn+HYuG1EASIIaXAAEuwQubIIz+gz5pfYXaqXck+pqFM
         2tB3z95CtVnqapH8cd6jXEO2ZTTtUcnco5mMgPCdtOQhq9Q+e5v3BF/JnOw2BHTMmjcw
         lAmMcG/kO6iY68KKBSGm10l96dPCnfBALVet/jLowADs0RLKgiKE0cceJrWKcHkKUDLv
         MKE2WWnt7V1ankffNXzWhsFB4DALBTxH9xptyH1mx0/fip2UMJ+wuTu4gNJrUigjtSkc
         kyClZYFm0hVCsOpBbuq6QluPsdMgvetamHKuMZXGC6BDZ5M+jdlsx/djhf/KmBgk+ZJF
         q+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344425; x=1773949225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9eI0jqRElybdBmM2uJMV+/w5888Pk7vjLOuX+knpayM=;
        b=wp6sl/sYkcyCioMkl2hA27xj3mAE/YF18A4rns/LCyyefg8/wV8LUrJkjhaJQMryzd
         F+x1E3zaUq/+9t+1gKOZWik9ci6Df4b0TG7qgyBhfYzftiZd5ZohYqVpNGptHPPZ99F+
         E4CXtPn/ZiWN20rLZQrJ00Td2xwTcGoFyCdPb78nh9B0R8KfqLefP6ionxSeJcxljjgJ
         mRnOEoqPVPeeln419lSjZ8bckw6OnnHzTKMAOpdCE2cT/1meNdlffAtrNFfyCGqegZgP
         zMvGWyz62yYnz55Hc0RH638Eg9ty584fWFrgLuYiLjWHROXK6ayx5YrAR7+YYHw4mrBO
         XkoQ==
X-Gm-Message-State: AOJu0YyakOnA6jikjP/xhXRURzFucNR8vjwcldCqbVcN9fwigsV2Nwxn
	TKtajj3j13FSJgi9qZAhjk4MTyMnADK1xJFiSPQT7ibgZEP2JPrMEUgW9m/lQ8zVHxuHOC4ASHN
	VoWFJzf+lX/j6/ENtlPww/YE3CMztbrA5X47a2Au0DPYgyL6U5A9O6eLdi3OPBGAvMjboo8prBI
	7cRt2FKXiEaDEkYaCUp+0LLEAYPYY4I9/uMchz2X6goIvXRs9jZBw=
X-Gm-Gg: ATEYQzwqHoUc6XrAZhxjJwWA9V7mMAX5pD1Hv6llIFpG98DLjvnHzUsc4WZO2yaEqEK
	0lUlP9eUuYVad1irebRnkL5f877hOYAWfkt2Y/FsR/r3P5C/KJL/XKr6oTR5Hj6SAlNJC50nYAf
	tQbKFV0HMnvbk2RkN9Tp/xW72Kj0AwUwy95tFABo1fj3OEmcN54uK2nEYC5HnjxgnPtKBKaODei
	3PmW4HdYGwI6tllrNVh9pQWHla9ldgJDX+nWspLdeHdaJLlP1iRBY8ClvIVqlKksKeWBo+PyohC
	OxRzUTtUzU7ZUbSHlI3pZ9vrBfvP6Is7yWoM0TRbOkxYQQvDhGLquZclAfBPgwS8Gw9Cbv1nLcQ
	25IH7OOAsPNP+M/S+HajVbkRQL3pj/afVGl6dz+gKwOcZRTM2c83Myeh5GvJUAkZI/peX+vJ0hG
	4O4jU=
X-Received: by 2002:a05:600c:8b70:b0:485:39d1:b500 with SMTP id 5b1f17b1804b1-485566f9445mr10126455e9.16.1773344425219;
        Thu, 12 Mar 2026 12:40:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8b70:b0:485:39d1:b500 with SMTP id 5b1f17b1804b1-485566f9445mr10125805e9.16.1773344424589;
        Thu, 12 Mar 2026 12:40:24 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm396705955e9.2.2026.03.12.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:40:24 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2 3/6] fuse: don't require /dev/fuse fd to be kept open during mount
Date: Thu, 12 Mar 2026 20:40:01 +0100
Message-ID: <20260312194019.3077902-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312194019.3077902-1-mszeredi@redhat.com>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new mount API the sequence of syscalls would be:

        fs_fd = fsopen("fuse", 0);
	snprintf(opt, sizeof(opt), "%i", devfd);
	fsconfig(fs_fd, FSCONFIG_SET_STRING, "fd", opt, 0);
	/* ... */
	fsconfig(fs_fd, FSCONFIG_CMD_CREATE, 0, 0, 0);

Current mount code just stores the value of devfd in the fs_context and
uses it in during FSCONFIG_CMD_CREATE.

This is not very elegant, but there's a bigger problem: when sync init is
used and the server exits for some reason (error, crash) while processing
FUSE_INIT, the filesystem creation will hang.  The reason is that while all
other threads will exit, the mounting thread (or process) will keep the
device fd open, which will prevent an abort from happening.

This is a regression from the async mount case, where the mount was done
first, and the FUSE_INIT processing afterwards, in which case there's no
such recursive syscall keeping the fd open.

The solution is twofold:

 a) use unshare(CLONE_FILES) in the mounting thread and close the device fd
    after fsconfig(fs_fd, FSCONFIG_SET_STRING, "fd", ...)

 b) only reference the fuse_dev from fs_context not the device file itself

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h |  4 +---
 fs/fuse/inode.c  | 54 +++++++++++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 66ec92f06497..b77b384b0385 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -603,13 +603,11 @@ static inline bool fuse_is_inode_dax_mode(enum fuse_dax_mode mode)
 }
 
 struct fuse_fs_context {
-	int fd;
-	struct file *file;
+	struct fuse_dev *fud;
 	unsigned int rootmode;
 	kuid_t user_id;
 	kgid_t group_id;
 	bool is_bdev:1;
-	bool fd_present:1;
 	bool rootmode_present:1;
 	bool user_id_present:1;
 	bool group_id_present:1;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ba845092e7f2..45abcfec03a4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -800,6 +800,26 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	{}
 };
 
+static int fuse_opt_fd(struct fs_context *fsc, int fd)
+{
+	struct file *file __free(fput) = fget(fd);
+	struct fuse_fs_context *ctx = fsc->fs_private;
+
+	if (file->f_op != &fuse_dev_operations)
+		return invalfc(fsc, "fd is not a fuse device");
+	/*
+	 * Require mount to happen from the same user namespace which
+	 * opened /dev/fuse to prevent potential attacks.
+	 */
+	if (file->f_cred->user_ns != fsc->user_ns)
+		return invalfc(fsc, "wrong user namespace for fuse device");
+
+	ctx->fud = file->private_data;
+	refcount_inc(&ctx->fud->ref);
+
+	return 0;
+}
+
 static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 {
 	struct fs_parse_result result;
@@ -839,9 +859,7 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		return 0;
 
 	case OPT_FD:
-		ctx->fd = result.uint_32;
-		ctx->fd_present = true;
-		break;
+		return fuse_opt_fd(fsc, result.uint_32);
 
 	case OPT_ROOTMODE:
 		if (!fuse_valid_type(result.uint_32))
@@ -904,6 +922,8 @@ static void fuse_free_fsc(struct fs_context *fsc)
 	struct fuse_fs_context *ctx = fsc->fs_private;
 
 	if (ctx) {
+		if (ctx->fud)
+			fuse_dev_put(ctx->fud);
 		kfree(ctx->subtype);
 		kfree(ctx);
 	}
@@ -1847,7 +1867,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
-	struct fuse_dev *fud = ctx->file ? fuse_file_to_fud(ctx->file) : NULL;
+	struct fuse_dev *fud = ctx->fud;
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct fuse_conn *fc = fm->fc;
 	struct inode *root;
@@ -1950,18 +1970,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	struct fuse_mount *fm;
 	int err;
 
-	if (!ctx->file || !ctx->rootmode_present ||
+	if (!ctx->fud || !ctx->rootmode_present ||
 	    !ctx->user_id_present || !ctx->group_id_present)
 		return -EINVAL;
 
-	/*
-	 * Require mount to happen from the same user namespace which
-	 * opened /dev/fuse to prevent potential attacks.
-	 */
-	if ((ctx->file->f_op != &fuse_dev_operations) ||
-	    (ctx->file->f_cred->user_ns != sb->s_user_ns))
-		return -EINVAL;
-
 	err = fuse_fill_super_common(sb, ctx);
 	if (err)
 		return err;
@@ -1989,8 +2001,7 @@ static int fuse_test_super(struct super_block *sb, struct fs_context *fsc)
 static int fuse_get_tree(struct fs_context *fsc)
 {
 	struct fuse_fs_context *ctx = fsc->fs_private;
-	struct fuse_dev *fud;
-	struct fuse_conn *fc;
+	struct fuse_conn *fc, *key;
 	struct fuse_mount *fm;
 	struct super_block *sb;
 	int err;
@@ -2010,9 +2021,6 @@ static int fuse_get_tree(struct fs_context *fsc)
 
 	fsc->s_fs_info = fm;
 
-	if (ctx->fd_present)
-		ctx->file = fget(ctx->fd);
-
 	if (IS_ENABLED(CONFIG_BLOCK) && ctx->is_bdev) {
 		err = get_tree_bdev(fsc, fuse_fill_super);
 		goto out;
@@ -2022,16 +2030,16 @@ static int fuse_get_tree(struct fs_context *fsc)
 	 * (found by device name), normal fuse mounts can't
 	 */
 	err = -EINVAL;
-	if (!ctx->file)
+	if (!ctx->fud)
 		goto out;
 
 	/*
 	 * Allow creating a fuse mount with an already initialized fuse
 	 * connection
 	 */
-	fud = __fuse_get_dev(ctx->file);
-	if (ctx->file->f_op == &fuse_dev_operations && fud) {
-		fsc->sget_key = fud->fc;
+	key = fuse_dev_fc_get(ctx->fud);
+	if (key) {
+		fsc->sget_key = key;
 		sb = sget_fc(fsc, fuse_test_super, fuse_set_no_super);
 		err = PTR_ERR_OR_ZERO(sb);
 		if (!IS_ERR(sb))
@@ -2042,8 +2050,6 @@ static int fuse_get_tree(struct fs_context *fsc)
 out:
 	if (fsc->s_fs_info)
 		fuse_mount_destroy(fm);
-	if (ctx->file)
-		fput(ctx->file);
 	return err;
 }
 
-- 
2.53.0

