Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28B2FC00D
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276897; cv=none; b=NEuekWD4mwTXqpN5dgc/QSMySE2kVGMbQdQ+U2kYDV1r592WRxKl/kL5ScQsgj27O4yGqyoL1tH0GU7MvMe5UD8MmasnayMiaa0iE7riODuCcjU1cvYnFrgKBk+JK9fE6kKlfNBCFknlMe16HPAmykwv+HUqdydgCxB93Zc2xTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276897; c=relaxed/simple;
	bh=zi3qiZ7y3/2ztTYzU+DDyrR+tiXJgvGfoOwnDaIm0WA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLVl7dcpEGzlTugcbLYx9Chszie8sJRymgLQlfopM9INtycWsz0wwPRJyjs+0oRk8jEHFKJ9x1bmEBTmkPVbtRILogrpcTOH8hV6TSFevqkeF74uGXXYg1nosRCWBKNV1+X6NEXDUDIKLLrV+jrmo4Gw307RvY+4x2cSCCHuzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXnOHVZ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXnOHVZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784276894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gg2p8ch1DMmROYcsLY+IZC3iNc6EQCfFEq5F4T0NAfI=;
	b=aXnOHVZ4V+tjHB/taObkPaEi49WAVnwCciAujbxHq8AnbyzLYeKPm2+dXUx6c8vsTGECVZ
	rkeORTYCHvgXBdahPa9tpYZbrEYhQcUlChmQKU3HO6Z/mHphTTqiwkxWsv834RFnrjobCM
	YiAk7Ze7xQ6EcSLeTMwLDt98EJx859E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-g3m0lyqOMLm-sTvtvFWwiA-1; Fri,
 17 Jul 2026 04:28:08 -0400
X-MC-Unique: g3m0lyqOMLm-sTvtvFWwiA-1
X-Mimecast-MFC-AGG-ID: g3m0lyqOMLm-sTvtvFWwiA_1784276887
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2FB018009EA;
	Fri, 17 Jul 2026 08:28:06 +0000 (UTC)
Received: from localhost (unknown [10.44.33.219])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFE6E180056E;
	Fri, 17 Jul 2026 08:28:05 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,  cyphar@cyphar.com,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] erofs: accept source file descriptor via fsconfig
In-Reply-To: <a3ee4538-6273-4d25-90d0-8dbaac092a38@linux.alibaba.com> (Gao
	Xiang's message of "Fri, 17 Jul 2026 11:42:39 +0800")
References: <20260714154917.489993-1-gscrivan@redhat.com>
	<a3ee4538-6273-4d25-90d0-8dbaac092a38@linux.alibaba.com>
Date: Fri, 17 Jul 2026 10:28:04 +0200
Message-ID: <87cxwm2f6z.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> Hi Giuseppe,
>
> On 2026/7/14 23:48, Giuseppe Scrivano wrote:
>> Allow userspace to pass an already-opened file descriptor as the mount
>> source instead of a path string.  This is useful for tools that already
>> hold an fd to the image, such as composefs reusing an existing erofs
>> backing file.
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>
> Use the current erofs-utils testsuite, the following tests seems skipped incorrectly.
>
> [Error 22] Invalid argument
> SKIP: erofs/008
> [Error 22] Invalid argument
> SKIP: erofs/009
> [Error 22] Invalid argument
> SKIP: erofs/010
> [Error 22] Invalid argument
> SKIP: erofs/011
>
> [Error 22] Invalid argument
> SKIP: erofs/017
> [Error 22] Invalid argument
> SKIP: erofs/018
>
> And the kernel message shows:
> [  116.477816] erofs: source is unsupported
> ...
>
> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-tests
> $ sudo make check
>
> Thanks,
> Gao Xiang

it seems to be caused by the different error returned by erofs_fc_get_tree.

Would you be fine if I amend this on top of v3?

Thanks,
Giuseppe



diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d7baf9f34dc0..829ae530d7ca 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -791,17 +791,22 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
-	struct file *file = sbi->dif0.file;
+	int ret;
 
-	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !file) {
-		int ret;
+	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file) {
+		if (!S_ISREG(file_inode(sbi->dif0.file)->i_mode) ||
+		    !sbi->dif0.file->f_mapping->a_ops->read_folio) {
+			errorfc(fc, "source is unsupported");
+			return -EINVAL;
+		}
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+	}
 
-		ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
-			IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
-				GET_TREE_BDEV_QUIET_LOOKUP : 0);
-		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ||
-		    ret != -ENOTBLK)
-			return ret;
+	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
+		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
+			GET_TREE_BDEV_QUIET_LOOKUP : 0);
+	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
+		struct file *file;
 
 		if (!fc->source)
 			return invalf(fc, "No source specified");
@@ -809,13 +814,12 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
+
+		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
+		    sbi->dif0.file->f_mapping->a_ops->read_folio)
+			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
-	if (!S_ISREG(file_inode(file)->i_mode) ||
-	    !file->f_mapping->a_ops->read_folio) {
-		errorfc(fc, "source is unsupported");
-		return -EINVAL;
-	}
-	return get_tree_nodev(fc, erofs_fc_fill_super);
+	return ret;
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)

