Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1203CF02A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680014; cv=none; b=Zs6ZyN9sC2LSXkhwrSAdQ/Zvq7T8M50uUs+DXevG6zQIMsdpQmPhGUkorUooyJzNJQ9fvzqAOCYUy2auu2bTSq8LzN80Z1WzHXw8/fFWZpsyTnywh8eNJCKQarw3p3Hw/Cf980d3bYSVnwg5TQnV7rdR/CeOWI59RoRvFLVMwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680014; c=relaxed/simple;
	bh=oG/y+kfRvXwNHjG3IEEwOpFNn9WVTkTVXBLQQW8c59A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eByXXaYqznWKcMDkwdzZZefoARYZW/E8v8BiIWATw6/btvaeaqSIkO8QRkwJC3/zdpNXU1b5insELZEOOIYddqSjMgTrAjH2sm7cEx+mLbTlKR4H9T0ugSGH3cuvVK3bxfmJiaUZt//RohViGmdu42g2vNIETVHrhzi7JG2z3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4NaIz5/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlAaNxUI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4NaIz5/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlAaNxUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9ZUSVLYsJMDzZ0CiZV1IT9luAY6X5gnMXIC4Ty3skA=;
	b=G4NaIz5//waTZthKUPfmYq7F7V+2MetFGKT0lnVI9OlmkDF5ac09CiIl9+nYMWNRgkvq2M
	X84EtTM9ML7T5szHj9UjZdvlhnl/zkwDLT6uxr4EbePtRL5KzUiOb3UIOfSVUqf62BcsZh
	yvsvlltzvYSVBCMfiutwUvKCQNx1T/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508--Sp8E2I3PHeMRL0pHJfuBA-1; Mon, 16 Mar 2026 12:53:28 -0400
X-MC-Unique: -Sp8E2I3PHeMRL0pHJfuBA-1
X-Mimecast-MFC-AGG-ID: -Sp8E2I3PHeMRL0pHJfuBA_1773680008
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-485397788b3so45538715e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680007; x=1774284807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9ZUSVLYsJMDzZ0CiZV1IT9luAY6X5gnMXIC4Ty3skA=;
        b=JlAaNxUIedtp7B74qoMfl+SS24QRSVc5XME3nmiMRdZZmL8Rete0xKHOkZ3/8dyy3x
         E8yf7pZDPcsk/EfkV2CB3xBk1b3AlcvYpTAxzriAsg5PkK8dvSyZM0W0SlgUFd8OoRoq
         fETm83a9RljEYpqMxkx0zf+pZlhXw24V2guylkAiNnXIjrUWyJYyvt1/uWAlZOC8zRdD
         m6umLkE3CggcsOPX0NyRGRLqZkbHdFTskl+s2uiQUj1jvFFIisrg+SE4vI2TWbyL/2ev
         oaJ2cokoKLyFCiHwKyr4rspF/p+h2QBG1r4jEQ76mcdPvnKE2zqkGs6BmKX2mVkBVEnz
         FMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680007; x=1774284807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N9ZUSVLYsJMDzZ0CiZV1IT9luAY6X5gnMXIC4Ty3skA=;
        b=YwNqjZZgrJ4mUpzxvJ3UINhPZom9XyLRyduJTPZ+Be+igoG9UAQrofDh/Bw0/Z5m7t
         MsNeP57p0cXlDNh1uWke1wAJalRyLTh6RRfEqVgGmdQ2sgY8AarXXKXKuayepMQEWstm
         ikreNLj/qn4Dx7q6EL7hKZmlfu6rLFK8jQ/qapd/Wcfd1gBrtR7kL5+fLfA3rR7Nmcbb
         r00ZM3bS9Oo/S/WFE3CoMbyE6Oa7t6kLYSIgEDRvqmjikOQOjJ146zw/2HqAEibz43Fj
         wsYZyAPaO5GCa8zJrcos9xVBCSdvtfjDvre5OEIQDBs6+SAd0jEkXw9vqIiKgf3c8ESY
         ymvQ==
X-Gm-Message-State: AOJu0YzOJAz0xNfx7/+wXiqUsfBc+Zk/6+cYMvYgCDmEKHZhxTiYy26D
	2Z8MhblGShoWDsFnlA210o7IffGdW8+rUD+wjwPKq6ksjnGwuMadDcBWhFVl1k541iEz6lVQqD0
	ns/Kxe+19JqtF8yWvwGOk7uKAiK2XH30b8D2OucOpU5XHkOqYthUCiSONbMKpwxg0GY4eV9fQ3G
	/qbH5AopZrTKpNwgy6nRRpv5qvxUhF88rd6NOIcPWAZ1/AiVc/mq8=
X-Gm-Gg: ATEYQzymS+BXc1E7lezX5dh2VME3aG/5fzwLJMNjOtnn8XixvyF2AlAFOPHkD6BtFGq
	JGO4l82i4fh9Z7nCE7d9BMTglbYtYh+MWcZv4TKqWE0VKSav76YKLnKZYlzHrZ+DknmJvl+AvML
	LG5nfAvWGNPL/qI4GsSqdvO2CPBwoiK5OpvZHbuRp6J+sjKZBTT7uuzIgx0hOdJxBhDeHjZCTie
	BQsjk3VnUMprXezYV9XAOm3rimsu8gYibd/5K6Hd/hCYWSopshrUWi/88AWr6TaZPRBODBSdC/v
	H1i1EjnVWja7LZ0kp5gnvPn36VmT3JnGbyx+87q1lu2hTmzI6QMouPLDZcjRNWltuQkeoah7ZRk
	IcCXRaYq0hJieKEDyJb2axxcEQbpFH0lhiETqVtwbZb9ADJ5xwLFXcq058bXLDsVnM21vhnNEng
	==
X-Received: by 2002:a05:600c:4583:b0:485:3f17:410 with SMTP id 5b1f17b1804b1-485566fd031mr239234815e9.16.1773680007171;
        Mon, 16 Mar 2026 09:53:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4583:b0:485:3f17:410 with SMTP id 5b1f17b1804b1-485566fd031mr239233915e9.16.1773680006562;
        Mon, 16 Mar 2026 09:53:26 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:26 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v3 4/7] fuse: don't require /dev/fuse fd to be kept open during mount
Date: Mon, 16 Mar 2026 17:53:15 +0100
Message-ID: <20260316165320.3245526-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316165320.3245526-1-mszeredi@redhat.com>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
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
uses it in during FSCONFIG_CMD_CREATE, which is inelegant.

Instead grab a reference to the underlying fuse_dev, and use that during
the filesystem creation.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h |  4 +---
 fs/fuse/inode.c  | 54 +++++++++++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 230201dc3f90..4a591a436324 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -606,13 +606,11 @@ static inline bool fuse_is_inode_dax_mode(enum fuse_dax_mode mode)
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
index 0e848e3a13c2..314fb37f272f 100644
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
@@ -1849,7 +1869,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
-	struct fuse_dev *fud = ctx->file ? fuse_file_to_fud(ctx->file) : NULL;
+	struct fuse_dev *fud = ctx->fud;
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct fuse_conn *fc = fm->fc;
 	struct inode *root;
@@ -1952,18 +1972,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
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
@@ -1991,8 +2003,7 @@ static int fuse_test_super(struct super_block *sb, struct fs_context *fsc)
 static int fuse_get_tree(struct fs_context *fsc)
 {
 	struct fuse_fs_context *ctx = fsc->fs_private;
-	struct fuse_dev *fud;
-	struct fuse_conn *fc;
+	struct fuse_conn *fc, *key;
 	struct fuse_mount *fm;
 	struct super_block *sb;
 	int err;
@@ -2012,9 +2023,6 @@ static int fuse_get_tree(struct fs_context *fsc)
 
 	fsc->s_fs_info = fm;
 
-	if (ctx->fd_present)
-		ctx->file = fget(ctx->fd);
-
 	if (IS_ENABLED(CONFIG_BLOCK) && ctx->is_bdev) {
 		err = get_tree_bdev(fsc, fuse_fill_super);
 		goto out;
@@ -2024,16 +2032,16 @@ static int fuse_get_tree(struct fs_context *fsc)
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
@@ -2044,8 +2052,6 @@ static int fuse_get_tree(struct fs_context *fsc)
 out:
 	if (fsc->s_fs_info)
 		fuse_mount_destroy(fm);
-	if (ctx->file)
-		fput(ctx->file);
 	return err;
 }
 
-- 
2.53.0

