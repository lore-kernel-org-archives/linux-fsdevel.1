Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E5446856
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044173; cv=none; b=sqCco5SRPkeMp3lj1RbHEP2mPH/tE23AEU+kvyDX8uXJWNmsjByqjcgivOrtESu/FIRBHzR/wtwB64/hoF9my0/24l7jA6iG1zcksUXBDUMpRj5Oo23WthK4v/YEMzkAMEpU/unpaw0f4hUnyYZxTJ/YjNSHX4fH1WbRsyO3oLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044173; c=relaxed/simple;
	bh=5Y93/hK1r/jsBMxpgqE6X+PWTItdNYdRMqTAAbV8LNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kqeij92ox8TQfWBEjbQ4AWRe0LNhADXl8xifuS2ZcmwFzRRZG37F5UIxSWprnfeYCm3Ls4Y9tGCeZYiNBoLINAJA2/XNq9wxsCXG0ZHt/RDkfHQ1bzfBjBV/ta/y/I9pdxokpvOk4y40YNhQc6NWl15GlbwR1RxCIVpngAeTMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHOQa3Jl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHOQa3Jl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784044170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9TVNAefQIHlIju9nW2K1pjBGhSVRpHAkFR/Z5h4ZMBo=;
	b=eHOQa3JlHdNg6oCFYHb8Til+iW3KKGA8NRkunX+KoqOXmxkpnXN8sYDv47D6rot1SxkZfK
	p9ZchsQFC7Znh4zL1tLu2C+QP/jZkxaLSL3ZPLToOi2eB9hwgmyNSuPzJHWlP95IzqBvSh
	mOPNp/3YFLcXZBQJny/0nyV9sPUL7BI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-guchUtRkMS2J_SbIUgNtjg-1; Tue,
 14 Jul 2026 11:49:27 -0400
X-MC-Unique: guchUtRkMS2J_SbIUgNtjg-1
X-Mimecast-MFC-AGG-ID: guchUtRkMS2J_SbIUgNtjg_1784044166
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E07631800350;
	Tue, 14 Jul 2026 15:49:25 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.32.17])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3048414;
	Tue, 14 Jul 2026 15:49:23 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: cyphar@cyphar.com,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	gscrivan@redhat.com
Subject: [PATCH v3] erofs: accept source file descriptor via fsconfig
Date: Tue, 14 Jul 2026 17:48:27 +0200
Message-ID: <20260714154917.489993-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Allow userspace to pass an already-opened file descriptor as the mount
source instead of a path string.  This is useful for tools that already
hold an fd to the image, such as composefs reusing an existing erofs
backing file.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---

v2: https://lore.kernel.org/linux-fsdevel/20260711071137.4130824-1-gscrivan@redhat.com/
v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/

 fs/erofs/super.c | 87 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 22 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..d7baf9f34dc0 100644
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
@@ -752,14 +790,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	int ret;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+	struct file *file = sbi->dif0.file;
 
-	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
-		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
-			GET_TREE_BDEV_QUIET_LOOKUP : 0);
-	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
-		struct erofs_sb_info *sbi = fc->s_fs_info;
-		struct file *file;
+	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !file) {
+		int ret;
+
+		ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
+			IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
+				GET_TREE_BDEV_QUIET_LOOKUP : 0);
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ||
+		    ret != -ENOTBLK)
+			return ret;
 
 		if (!fc->source)
 			return invalf(fc, "No source specified");
@@ -767,12 +809,13 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
-
-		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
-		    sbi->dif0.file->f_mapping->a_ops->read_folio)
-			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
-	return ret;
+	if (!S_ISREG(file_inode(file)->i_mode) ||
+	    !file->f_mapping->a_ops->read_folio) {
+		errorfc(fc, "source is unsupported");
+		return -EINVAL;
+	}
+	return get_tree_nodev(fc, erofs_fc_fill_super);
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)
-- 
2.55.0

