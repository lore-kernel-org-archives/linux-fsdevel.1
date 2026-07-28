Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8633D503
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254804; cv=none; b=nnPsodPL5z9KRyaKTH5Z3LciXpQ5uSG9VQIyGVPuwiHIhr9lGS5I3+g8ONIkIMUp5qxK99r5wqGsWIHBHSeshH9F+EceIUDBPOUhPW0Ja1i6+RTExs6xfLuER/C5bV6bor0ra6ZWR7bFUEOTQO1RqlXoULLSpKz8bl5a4tahq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254804; c=relaxed/simple;
	bh=yr24I03G/dtvb9I4TCQ7Tdb6l6Q+skcOosUj4TP/F1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZ63J83gNq3LBEKEVnTrAS/4lZIXMdamGGe2dMFo1pCV0CHc6vtFoCIuu/94vHSA3Nuzoe2nKL7i7IPXyO8gw/msoOlRpglG/WG0IoEBUNWUfqUyHFT4LrHSMMi/kPxuqHNwK+m7v8uXNtKd9zUOn0vyJTjNFfmjpsvmGnPkRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3xN29s2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3xN29s2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785254800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qkNH3H26FdTRk7zvARBF2+lnCXz8gfu0NSh+cQUr6xU=;
	b=d3xN29s2XCpDgya8ehKeXSATK7Iwjz/JeG+9kpaRXuK5byZV6P9RZ561U5rgGxqe5tSbwu
	ywUVTrTnEWQgpbCC3AcMFOY7jPKuyWt1NgVCiwc3ofvy/s6FiM56yWRzv+1I7EoLsU7wkw
	XcPm1BZ8evi94RNE1jvEVjCgmmaVkVw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-j9FHKHKvN0OgWfaG32jwRg-1; Tue,
 28 Jul 2026 12:06:38 -0400
X-MC-Unique: j9FHKHKvN0OgWfaG32jwRg-1
X-Mimecast-MFC-AGG-ID: j9FHKHKvN0OgWfaG32jwRg_1785254797
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C54DB1956080;
	Tue, 28 Jul 2026 16:06:36 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.48.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEC411956044;
	Tue, 28 Jul 2026 16:06:34 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: cyphar@cyphar.com,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	gscrivan@redhat.com
Subject: [PATCH v5] erofs: accept source file descriptor via fsconfig
Date: Tue, 28 Jul 2026 18:05:32 +0200
Message-ID: <20260728160619.853924-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allow userspace to pass an already-opened file descriptor as the mount
source instead of a path string.  This is useful for tools that already
hold an fd to the image, such as composefs reusing an existing erofs
backing file.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
v4: https://lore.kernel.org/linux-fsdevel/20260717134147.1602735-1-gscrivan@redhat.com/
v3: https://lore.kernel.org/linux-fsdevel/20260714154917.489993-1-gscrivan@redhat.com/
v2: https://lore.kernel.org/linux-fsdevel/20260711071137.4130824-1-gscrivan@redhat.com/
v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/

 Documentation/filesystems/erofs.rst | 15 ++++++
 fs/erofs/super.c                    | 73 ++++++++++++++++++++++++-----
 2 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 4230884fb359..774e8b236d09 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -139,6 +139,21 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
                        page cache.
 ===================    =========================================================
 
+File-backed mounts
+==================
+
+When CONFIG_EROFS_FS_BACKED_BY_FILE is enabled, EROFS file-backed images
+can be mounted directly without a loopback block device.  The backing file
+can be given either as a path, or as an already-opened file descriptor.
+
+When a file descriptor is used, the kernel resolves its path and records it
+so that /proc/mounts and similar interfaces can still report the mount
+source.
+
+Only regular files are accepted as backing files; to mount an image that
+resides on a block device, use the traditional block device mount path
+instead.
+
 Sysfs Entries
 =============
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..558041011398 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
+	Opt_source,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -402,17 +403,18 @@ static const struct constant_table erofs_dax_param_enums[] = {
 };
 
 static const struct fs_parameter_spec erofs_fs_parameters[] = {
-	fsparam_flag_no("user_xattr",	Opt_user_xattr),
-	fsparam_flag_no("acl",		Opt_acl),
-	fsparam_enum("cache_strategy",	Opt_cache_strategy,
+	fsparam_flag_no("user_xattr",		Opt_user_xattr),
+	fsparam_flag_no("acl",			Opt_acl),
+	fsparam_enum("cache_strategy",		Opt_cache_strategy,
 		     erofs_param_cache_strategy),
-	fsparam_flag("dax",             Opt_dax),
-	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
-	fsparam_string("device",	Opt_device),
-	fsparam_string("domain_id",	Opt_domain_id),
-	fsparam_flag_no("directio",	Opt_directio),
-	fsparam_u64("fsoffset",		Opt_fsoffset),
-	fsparam_flag("inode_share",	Opt_inode_share),
+	fsparam_flag("dax",			Opt_dax),
+	fsparam_enum("dax",			Opt_dax_enum, erofs_dax_param_enums),
+	fsparam_string("device",		Opt_device),
+	fsparam_string("domain_id",		Opt_domain_id),
+	fsparam_flag_no("directio",		Opt_directio),
+	fsparam_u64("fsoffset",			Opt_fsoffset),
+	fsparam_flag("inode_share",		Opt_inode_share),
+	fsparam_file_or_string("source",	Opt_source),
 	{}
 };
 
@@ -437,6 +439,40 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 	return false;
 }
 
+static int erofs_fc_parse_source(struct fs_context *fc,
+				 struct fs_parameter *param)
+{
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	if (fc->source || sbi->dif0.file)
+		return invalf(fc, "Multiple sources");
+
+	switch (param->type) {
+	case fs_value_is_string:
+		fc->source = param->string;
+		param->string = NULL;
+		return 0;
+	case fs_value_is_file: {
+		char *buf __free(kfree) = kmalloc(PATH_MAX, GFP_KERNEL);
+		char *p;
+
+		if (!buf)
+			return -ENOMEM;
+		p = file_path(param->file, buf, PATH_MAX);
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+		fc->source = kstrdup(p, GFP_KERNEL);
+		if (!fc->source)
+			return -ENOMEM;
+		sbi->dif0.file = no_free_ptr(param->file);
+		return 0;
+	}
+	default:
+		WARN_ON_ONCE(true);
+		return -EINVAL;
+	}
+}
+
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
@@ -524,6 +560,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_source:
+		return erofs_fc_parse_source(fc, param);
 	}
 	return 0;
 }
@@ -752,13 +790,26 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 	int ret;
 
+	if (sbi->dif0.file) {
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE)) {
+			errorfc(fc, "source fd option not supported");
+			return -EINVAL;
+		}
+		if (!S_ISREG(file_inode(sbi->dif0.file)->i_mode) ||
+		    !sbi->dif0.file->f_mapping->a_ops->read_folio) {
+			errorfc(fc, "source is unsupported");
+			return -EINVAL;
+		}
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+	}
+
 	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
 		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
 			GET_TREE_BDEV_QUIET_LOOKUP : 0);
 	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
-		struct erofs_sb_info *sbi = fc->s_fs_info;
 		struct file *file;
 
 		if (!fc->source)
-- 
2.55.0

