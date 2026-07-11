Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AF2F99B8
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783753916; cv=none; b=P1D2d5LPyZowy+KfGC66mptpwSkv9l+ixgaivyLMHZNDyY+Odl9OhcGzXzmCDU+AEpN4NupmMXufzyqgMJLHqKaw42YC4pqEWrFgtjZWXrLk4zToToDYiVqjhJ2bb8lH8JWQxBlz9EEgjGkSrOmQNqVHJpCV0uRuRcZa82Kk7GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783753916; c=relaxed/simple;
	bh=+E4n/3FyPTXDZvlORbNj4dIGjJze88J8Lwyr5OxxoFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjebtysTXO/of+sUx+wpumixUIrZqbivQ2aiDnmC7rP5EBefDwIFVazMN4dNld93FQHdeRHwnvfCRBcEmVg4cNpYK6040FkEtIHv+5uf6KjhKBvrBg0lk8DAaJ8EYdVR90HnP751ZMc11fGU5ZPCz0q0YXk7J7IUM92Rn0rM73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDgRXzl0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDgRXzl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783753913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OvublaibrtOMvG0eHQdKg2ge5aW5fO+X8CredtBGML4=;
	b=LDgRXzl0qjoLG2A3BLUXCd+8+GBR5/yQ029qCJZo5R5rnUaYvwAGH+eFVj/ynAMGlmMQdP
	beqiLFUKkWnlCbYzTObpvgVFtcLSvnTyYEetgtzXKzuuTkqFxeEoBcX8rqaXBw6iGivv9k
	jUo8vGYzNA3UaEE+/95YWT4qbCjgogM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-qV8DHBUrMriZQRMkDxywZw-1; Sat,
 11 Jul 2026 03:11:52 -0400
X-MC-Unique: qV8DHBUrMriZQRMkDxywZw-1
X-Mimecast-MFC-AGG-ID: qV8DHBUrMriZQRMkDxywZw_1783753911
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 207A1195605F;
	Sat, 11 Jul 2026 07:11:51 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.32.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D322F1800594;
	Sat, 11 Jul 2026 07:11:49 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org,
	gscrivan@redhat.com
Subject: [PATCH v2] erofs: accept source file descriptor via fsconfig
Date: Sat, 11 Jul 2026 09:10:54 +0200
Message-ID: <20260711071137.4130824-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add fsparam_fd("source") so that userspace can pass an already-opened
file descriptor instead of a path string.  When the fd is provided via
fsconfig(FSCONFIG_SET_FD, "source", NULL, fd), it is stored directly
in sbi->dif0.file and erofs_fc_get_tree() skips the filp_open() call.

This is useful for mount namespaces where the backing file may not be
reachable by path, and for tools that already hold an fd to the image
(e.g. composefs reusing an erofs mount's backing file).

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
I've moved this out of the previous series, as the second patch is on
hold for a design discussion.  Since the two patches were independent,
they do not need to be held together.

v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/#r

 fs/erofs/super.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..3040d4cf9b85 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
+	Opt_source_fd,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag_no("directio",	Opt_directio),
 	fsparam_u64("fsoffset",		Opt_fsoffset),
 	fsparam_flag("inode_share",	Opt_inode_share),
+	fsparam_fd("source",		Opt_source_fd),
 	{}
 };
 
@@ -524,6 +526,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_source_fd:
+		if (sbi->dif0.file)
+			return -EINVAL;
+		sbi->dif0.file = get_file(param->file);
+		break;
 	}
 	return 0;
 }
@@ -752,14 +759,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
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
@@ -767,12 +778,13 @@ static int erofs_fc_get_tree(struct fs_context *fc)
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

