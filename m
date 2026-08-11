Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B12C21F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433061; cv=none; b=BJKxpXd8dyKqc3Ck8XsPefqp6sWJ5d2VSS0m4x3HI0YE5N6wNxha1c8+uoxOptg2XfK/GzNz4TyV+K6jSBjvYKJebpIOkMyV30NxNKek8b6JAYSPrxfcvAu+369DhYC0Tz7E7CKgN9VI1gt88cyy6My4KWKs7DIlAWyu+nfYXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433061; c=relaxed/simple;
	bh=FjKuxZkjfKwY9z/ySopDFVDEslAChh+5o85rpW590a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpBbcVk+EJZRRUqT1UPzPsVxhyrpg4tixl/LmZhCqfi0vKzVZjMT7jJvTmab6gf02+qSSCjetVpcivx7FdCJrWpERIJgdflHFDm5rBjVT+NYFtEVnEt4zi6XG/r4T2E+oY6WGqkFMhyGK1CSsya97i4GLifQL/6bPET5UaBETF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zsoaf7qv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zsoaf7qv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786433059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioen7yg45t3UifenWmxJJ7HmiN0IGdexHBH13NMVZ6c=;
	b=Zsoaf7qv4J0DgIBeVPUbdz+/5so2sUqwBbkQIgsuU2GB/RSa+XQ9CCr4Wxzdy31hH6wm0I
	RpEA461gcO41zereaKNcSQZHcobwKS7H4af5vPPxqf/+dPaeY+RrzyN32NUwBsApzRdolz
	HBpXYQwO8n49vWxottVWxUt/LrbyrUk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-Tt9JptKWMSCd_bZzu_dGAw-1; Tue,
 11 Aug 2026 03:23:59 -0400
X-MC-Unique: Tt9JptKWMSCd_bZzu_dGAw-1
X-Mimecast-MFC-AGG-ID: Tt9JptKWMSCd_bZzu_dGAw_1786433038
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C1881800578;
	Tue, 11 Aug 2026 07:23:58 +0000 (UTC)
Received: from oxygen.station (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 676AA18005BD;
	Tue, 11 Aug 2026 07:23:56 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	gscrivan@redhat.com,
	brauner@kernel.org
Subject: [PATCH v5 1/2] fs: rename vfs_get_super() to get_tree_super() and export it
Date: Tue, 11 Aug 2026 09:10:50 +0200
Message-ID: <20260811071241.389589-2-gscrivan@redhat.com>
In-Reply-To: <20260811071241.389589-1-gscrivan@redhat.com>
References: <20260811071241.389589-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

vfs_get_super() already implements the common get_tree pattern of
looking up an existing superblock via a test callback and initialising
a new one with fill_super otherwise, but it is private to fs/super.c
and only reachable through the get_tree_nodev()/get_tree_single()/
get_tree_keyed() wrappers, none of which let a filesystem supply its
own test callback.

Rename it to get_tree_super() and export it so filesystems that need a
custom superblock matching policy can reuse it directly instead of
open-coding sget_fc() + fill_super().  No functional change.

This is a preparatory fix for the next patch.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/super.c                 | 19 +++++++++++++++----
 include/linux/fs_context.h |  4 ++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index a8fd61136aaf..84b878317364 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1251,7 +1251,17 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
 	return 1;
 }
 
-static int vfs_get_super(struct fs_context *fc,
+/**
+ * get_tree_super - Get a superblock, optionally sharing an existing one
+ * @fc: The filesystem context holding the parameters
+ * @test: Comparison function to find a matching existing superblock, or NULL
+ * @fill_super: Helper to initialise a new superblock
+ *
+ * If @test is non-NULL and matches an existing superblock, that superblock is
+ * reused; otherwise a new anonymous superblock is created and initialised with
+ * @fill_super.  Passing NULL for @test always creates a new superblock.
+ */
+int get_tree_super(struct fs_context *fc,
 		int (*test)(struct super_block *, struct fs_context *),
 		int (*fill_super)(struct super_block *sb,
 				  struct fs_context *fc))
@@ -1278,12 +1288,13 @@ static int vfs_get_super(struct fs_context *fc,
 	deactivate_locked_super(sb);
 	return err;
 }
+EXPORT_SYMBOL(get_tree_super);
 
 int get_tree_nodev(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, NULL, fill_super);
+	return get_tree_super(fc, NULL, fill_super);
 }
 EXPORT_SYMBOL(get_tree_nodev);
 
@@ -1291,7 +1302,7 @@ int get_tree_single(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
 {
-	return vfs_get_super(fc, test_single_super, fill_super);
+	return get_tree_super(fc, test_single_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_single);
 
@@ -1301,7 +1312,7 @@ int get_tree_keyed(struct fs_context *fc,
 		void *key)
 {
 	fc->s_fs_info = key;
-	return vfs_get_super(fc, test_keyed_super, fill_super);
+	return get_tree_super(fc, test_keyed_super, fill_super);
 }
 EXPORT_SYMBOL(get_tree_keyed);
 
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 0d6c8a6d7be2..c920aba5177c 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -150,6 +150,10 @@ extern int vfs_parse_fs_param_source(struct fs_context *fc,
 				     struct fs_parameter *param);
 extern void fc_drop_locked(struct fs_context *fc);
 
+extern int get_tree_super(struct fs_context *fc,
+			 int (*test)(struct super_block *, struct fs_context *),
+			 int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc));
 extern int get_tree_nodev(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc));
-- 
2.55.0

