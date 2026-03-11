Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F222741B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265890; cv=none; b=k1JPVBPxrR4irOjWeUosi4MRXHouJ7FkKoWcYJXaY3hq5Wn/buPcFqVFZLmzXpVG9DLPeLu+LUHZXyrAIzPFuONA11BBA1hldvac0G7wy2BeZszYMkWjQIhAG3qmFq3hElseAGbpVUMXiZQdC4nxJH2NAIIKU6gKtWGdsNK6UVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265890; c=relaxed/simple;
	bh=VVLgurSl1faSLYzUmoqeqCTnlN4BzWpjPvnP5c0RPQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psq17jkc+uP7Tm1181fnxwr2e4uhX+8y0cyVWD7PLwV774KkJaxUeFLeZcoX4db573f5bViG6nTXrgnXkMGn24YCAuWTpSbqovwFf03/WU31rshnlo8XkiYhET3DN49gmgQ/p9Gk/cwkXwDP/T91q9YnTgZGifNFTv5rZKjobWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZZRLy4K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oty7/nt/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZZRLy4K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oty7/nt/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773265888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQRKDTk24FttIJZ56zllOanlD1X2mxkyFejgMFcxH1A=;
	b=dZZRLy4K0p4CrTKMvxyDFf/3zOtkCE8w0U2gWJKbEFHDgpUSfhH3pMCyii95XbBgrHBf/7
	6sQnsiMX5xd6QDVOwHW596nAy49CTFbZV0rrikACOcTXwjc3QdpRFpwYIJwfQD1eowqoBI
	HvZ1qAPiGoRukKNOUWBYUMXnPtR92mg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-1oUZFhz5OHGF0kZ_o0XMow-1; Wed, 11 Mar 2026 17:51:26 -0400
X-MC-Unique: 1oUZFhz5OHGF0kZ_o0XMow-1
X-Mimecast-MFC-AGG-ID: 1oUZFhz5OHGF0kZ_o0XMow_1773265886
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b0af42aso3830835e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773265885; x=1773870685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQRKDTk24FttIJZ56zllOanlD1X2mxkyFejgMFcxH1A=;
        b=Oty7/nt/kDXbvxLlSJh+KXrp8u02wtktJxiovQTbYZAlajTnmy4SSkOPjD5mmHL00L
         AYJMpAOA59F0fEhJcpF/CMlHrdI4WiugeLVoQl0PM9iR9Fv0g8W9vs3GeK6+Z3PHZeBJ
         Bdxrcb9Mso2avuu0dj7GM9sXEgbOPC2nTgbOq9kasEu9htJGPDVtpH9H5OddxCWCVYz3
         IssHTSsVBHiKzuJ9Gr/B91M5VLiNyGoUhBsjrxUg4EIAFUTIm24Dar59S//Z77Ow1mQI
         Z3Hie9bdgalGjJiGyIYbm/a5yznPC9SvA9GVY/usFdQLJbDJdUI1Dt+LATRpBi6OsP0W
         wLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773265885; x=1773870685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQRKDTk24FttIJZ56zllOanlD1X2mxkyFejgMFcxH1A=;
        b=C3W7zjEDOObJWtyzRQSHcqfbfit2pGbzl9bjn217EmGi60hGh1FjQfKV5sHezPvprf
         jm8zb2TCye4ULMLAheEVrpgyXWOiuFeX8y0awf3w0J2mL/FWvneB3jYcfK/vONdmhi+k
         gsZINu43J4/UjsVemgnofs2sm67WkU3L8V1FtNBypih5o9S5vzl/VkmvOj2FGmzFXJIQ
         tti3ONPaDmQxIb950m8zTVW7T0yK3qsE9PN+IzSMUzRrRU+avP4lFpYbuVx6KS9r5OXU
         w8cpotuPQC928hWtGkkAr4kV7WzVqnKSQ+be6hSGA76EMTkdbPj+qYkHo9veQMWvPBzV
         C+SQ==
X-Gm-Message-State: AOJu0Yy5arSoiO4QzAdtLpY23Kh7oD4+yJK4XalArb5fz7KKTE6uFXy6
	dqEOeAebs4gE0teu5O7rVUwCn7rzHJblqJvwXd4zwEWrUV4KUj0nwYRYYeY7Omq74Z1mv1bZwrS
	LrnoqRS9P44xSZKfeTk+URYu3DS4bX546DXux1I1VP/8XjKbSbZJQEL2O4A4T6Y7kZBv5UszhDG
	XUBruOy8/VzZP1gZYGRGGJjH0kAB5IQ1AIJFVKZWxC0R7LpQKfBvE=
X-Gm-Gg: ATEYQzwfMYLihAHlB8s3qw+FeoZpbhAxyfoPmQgCV93G+J5wKhiXRRuXcd1DpboJ3x0
	zyCr0beolOT9b3jFT+BdK17li/PlU314Me65dEIHf0hnZv73bGZdN7fVe4tjHh/4EuqbeEuXz/y
	vaqa/NuO5P/nOQS8Ocp58Hu2lVX2qOefShxNLcYTFOCbnXkGCqJGRCwAqlqfML70JGV9pgCwhfx
	bTQoZDNo8ClwlgSP+GOSvme1EYwDAXylAve4Byk7SlqzY2zlvSF/G4OjcbuIQ8R312OCEteOPqS
	4Yos1uXj4wF+p9SSYEGEDUZP9tacvNFE9wJFa4SljJOeIeb3+HhzhapbSWDG6rV2hKvRm4AHPTM
	WR6deSjFxnyXNSkWAjrOQ3L1CLpcOV/Qz70Lst80qss1C1IgUU6r9U2LMvCbUqGWla50YMclnfm
	kNq6M=
X-Received: by 2002:a05:600c:1f14:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4854b100afamr74076565e9.20.1773265885313;
        Wed, 11 Mar 2026 14:51:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1f14:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4854b100afamr74076175e9.20.1773265884791;
        Wed, 11 Mar 2026 14:51:24 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm79881205e9.3.2026.03.11.14.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:51:23 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [RFC PATCH 3/3] fuse: don't require /dev/fuse fd to be kept open during mount
Date: Wed, 11 Mar 2026 22:51:17 +0100
Message-ID: <20260311215118.2891117-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311215118.2891117-1-mszeredi@redhat.com>
References: <20260311215118.2891117-1-mszeredi@redhat.com>
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
index 0817fbe3ba43..356cb4bafb01 100644
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
index 5a823b574634..17f4e1d30222 100644
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
@@ -1827,7 +1847,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
-	struct fuse_dev *fud = ctx->file ? ctx->file->private_data : NULL;
+	struct fuse_dev *fud = ctx->fud;
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct fuse_conn *fc = fm->fc;
 	struct inode *root;
@@ -1930,18 +1950,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
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
@@ -1969,8 +1981,7 @@ static int fuse_test_super(struct super_block *sb, struct fs_context *fsc)
 static int fuse_get_tree(struct fs_context *fsc)
 {
 	struct fuse_fs_context *ctx = fsc->fs_private;
-	struct fuse_dev *fud;
-	struct fuse_conn *fc;
+	struct fuse_conn *fc, *key;
 	struct fuse_mount *fm;
 	struct super_block *sb;
 	int err;
@@ -1990,9 +2001,6 @@ static int fuse_get_tree(struct fs_context *fsc)
 
 	fsc->s_fs_info = fm;
 
-	if (ctx->fd_present)
-		ctx->file = fget(ctx->fd);
-
 	if (IS_ENABLED(CONFIG_BLOCK) && ctx->is_bdev) {
 		err = get_tree_bdev(fsc, fuse_fill_super);
 		goto out;
@@ -2002,16 +2010,16 @@ static int fuse_get_tree(struct fs_context *fsc)
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
+	key = smp_load_acquire(&ctx->fud->fc);
+	if (key) {
+		fsc->sget_key = key;
 		sb = sget_fc(fsc, fuse_test_super, fuse_set_no_super);
 		err = PTR_ERR_OR_ZERO(sb);
 		if (!IS_ERR(sb))
@@ -2022,8 +2030,6 @@ static int fuse_get_tree(struct fs_context *fsc)
 out:
 	if (fsc->s_fs_info)
 		fuse_mount_destroy(fm);
-	if (ctx->file)
-		fput(ctx->file);
 	return err;
 }
 
-- 
2.53.0

