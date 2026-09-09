Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493B57D22B
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969213; cv=none; b=PfoxgigD5Ol1sPXSFEmRl4gHlJZ6mz3HNYmlgjaQMfGfSkhbvRo3EMFUoisyv4s8NPpN3kVI0E8FUvuTdkZhOSQEzhm7KCwgOxYZJyzrsevXUh2eQ8vsYcY8/r+ClgUTqKfjvkYYk73leFd7Qq3uu7Pvp9L2HZ6e2/mqPA7NzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969213; c=relaxed/simple;
	bh=eZiEFGLP4KG5oRBYSyKpJuV9hkFlchwSzSGNTunBHKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFBRo8avMSDuwTzOVSAhQxVt2WGlwzLrUfR0Xv2ZCpCafs/vYNo7ZjIGXSqnoD+jWD6BEs2gr7mZO/nTsESpsqiEO1mTkMKWiSYI1YQEeaUISTrc0ChMDZUSx5fFJUBMvkSxBibQ0TKRIp4dgbFdiRiYCFV+YJDF8bcYkJw8xZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5GYJyOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5GYJyOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EC71F00A3D;
	Wed,  9 Sep 2026 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969211;
	bh=r+sVlGaJlj4bk8gOc4PzzroZCp6t8RAq6Ktg4uqW450=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y5GYJyOEmyhi0fHecK1P7mRT7Yd3vSuzD4JSNodn3YHtLjRYKxwK8CPZDN8kuGnXX
	 e2CMQGCL4/aUAIzDhzGEZZTHkCiq5vDSyvGsGjXvHiNBIa21GUpc/drY4VptZo7EG2
	 y+MdpLC+BXxFou8wMV/+FBTfAjpNFHaQBAUCsL6Qrf0J83amJy25t5V9inDRGZsmEF
	 GelFLoxbGLyH6IV/SjN5b19GmnUapwJzJDgn8mjkBa47iDjZTJYCw/BthxLidNCRqe
	 4N/YG9erjdr77Pxe1mAi54MgqfV06mJ+Q/SF3cYjrR3fiYMupwF3zJo2sm9OIJ3ekB
	 8GLYbv3AiGc4g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:55 +0200
Subject: [PATCH RFC v3 12/15] fs: add alloc_files_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-12-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
In-Reply-To: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3262; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eZiEFGLP4KG5oRBYSyKpJuV9hkFlchwSzSGNTunBHKQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLh6No9njz6LfHHmsmMTjxVe6n/huNBzuW7wko98l
 jdmuxXUdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkYBcjw8JXQRHGQfybmLce
 4ts18ZdagtfmyfqiJk/4t7V3eu99v4aR4Vza+lyDK63fRb2t4vom6Wx9tVrfmSP3SFLUt9UPSq/
 UcAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a way to get an empty descriptor table with one reference. Let
dup_fd() share the allocation. The coredump code will use it too in a bit.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 49 ++++++++++++++++++++++++++++++++++++++-----------
 include/linux/fdtable.h |  1 +
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 2de638d99107..2a0b94974817 100644
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
index fe033bb35e35..447807d4c00b 100644
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

