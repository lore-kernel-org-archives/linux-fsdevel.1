Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FDA4AA026
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364755; cv=none; b=pS+7gDTVPhbsagqq9cSaHgOP10CYg+EgOJtep1DCXlSqVDSvtCoxytoRIfM0xLLfWCDFdA5QyI4Zi6fkOeWc9dulcYUz9/ojwxCprZeuYZRhWHBVgNWorQECnYuVmDIr8OftuNsawtv0TaVIi60+Di4muQNXjsF7llAxFOrtI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364755; c=relaxed/simple;
	bh=m6FjGuXAb6otenpkNMK1VdGUuOWJXbAEx+bmwFUFs+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hr6Ckpr5bg5sEqYw3tn87HBbqpljp75PA+tNmnhX8fH++tYBbUUcPamV028cNxd4tJ1/3G2jEKRdFt08ZdxuQL7CZl73mB7tNWwdFa6k+J9tWZfJTyJcQBqipdbgwgitltQhkMSSD+t4Ef8sq1pqqaeRnoVJBPKpE/UlwC1LpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAClj0az; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAClj0az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5C91F00A3A;
	Wed,  2 Sep 2026 15:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364753;
	bh=oxLT3UOsldPmIJeVFHPaIvQ51uEj02ZPTX1haXGqiFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dAClj0azb1yTJT/IrGBphI1bIYW4dS4PxuQQqo+ByxRPxIyDOpQuvlUle9pV9QlvH
	 JhfpprSiGrwLVImnO2VhkWS1pY6UM0yruhovHMZK8O3gnb+YCH5YDBaOJzPN+eaM+s
	 l0+ktzNtZqCDAEREqJjuy6bd0HZ78RINagajUMvDZhLkJNvpjWmAc/a1b20BK5NrEM
	 WjtbirndXTDyoPCGmESg3seeTRfO37OH9y32xCkYCpFyqYWCL8wmsZOy8m0Pbr5jD9
	 ckYkxkRO0N/WUSMs1aDsg4WesuqRZoNlFMCCU4twNX18bYr9Nb6qdMG2X46x5jI8ex
	 hD0RgoHtNb80w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:31 +0200
Subject: [PATCH RFC v2 13/16] fs: add alloc_files_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-13-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3257; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m6FjGuXAb6otenpkNMK1VdGUuOWJXbAEx+bmwFUFs+Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF9hUOv079xlm3OTrnluudF2zVbE+Bv3ydtbo7PuK
 Dbb/Fp4uqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiW/cxMqx8/+39jcanyQoc
 i5N+euukJm96vt3JznffqXlXUh1mKbUy/M+aoVv46pIj0ypOS+5N3tsnRyyKnLbc6uLdw7Om5su
 VWrMBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a way to get an empty descriptor table with one reference. Let
dup_fd() use that helper. The coredump code will use it too in a bit.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 49 ++++++++++++++++++++++++++++++++++++++-----------
 include/linux/fdtable.h |  1 +
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 608e6a1fa69b..ccbaa71dfbe4 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -375,21 +375,15 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *punc
 	return ALIGN(last + 1, BITS_PER_LONG);
 }
 
-/*
- * Allocate a new descriptor table and copy contents from the passed in
- * instance.  Returns a pointer to cloned table on success, ERR_PTR()
- * on failure.  For 'punch_hole' see sane_fdtable_size().
- */
-struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_hole)
+/* A table with one reference and the embedded fdtable, nothing copied yet. */
+static struct files_struct *alloc_files(gfp_t gfp)
 {
 	struct files_struct *newf;
-	struct file **old_fds, **new_fds;
-	unsigned int open_files, i;
-	struct fdtable *old_fdt, *new_fdt;
+	struct fdtable *new_fdt;
 
-	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
+	newf = kmem_cache_alloc(files_cachep, gfp);
 	if (!newf)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	atomic_set(&newf->count, 1);
 
@@ -404,6 +398,39 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	new_fdt->full_fds_bits = newf->full_fds_bits_init;
 	new_fdt->fd = &newf->fd_array[0];
 
+	return newf;
+}
+
+/* An empty descriptor table with one reference. */
+struct files_struct *alloc_files_struct(void)
+{
+	struct files_struct *newf;
+
+	newf = alloc_files(GFP_KERNEL | __GFP_ZERO);
+	if (!newf)
+		return NULL;
+
+	rcu_assign_pointer(newf->fdt, &newf->fdtab);
+	return newf;
+}
+
+/*
+ * Allocate a new descriptor table and copy contents from the passed in
+ * instance.  Returns a pointer to cloned table on success, ERR_PTR()
+ * on failure.  For 'punch_hole' see sane_fdtable_size().
+ */
+struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_hole)
+{
+	struct files_struct *newf;
+	struct file **old_fds, **new_fds;
+	unsigned int open_files, i;
+	struct fdtable *old_fdt, *new_fdt;
+
+	newf = alloc_files(GFP_KERNEL);
+	if (!newf)
+		return ERR_PTR(-ENOMEM);
+	new_fdt = &newf->fdtab;
+
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
 	open_files = sane_fdtable_size(old_fdt, punch_hole);
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 15ee6292e0e3..811994b16bed 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -100,6 +100,7 @@ static inline bool close_on_exec(unsigned int fd, const struct files_struct *fil
 struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
+struct files_struct *alloc_files_struct(void);
 struct files_struct *switch_files_struct(struct task_struct *tsk,
 					 struct files_struct *files);
 int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp);

-- 
2.53.0

