Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F684AF9EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055339; cv=none; b=j2XWZ3sWioKegfJR1c51sGvns1zbOzrnBzk6cuPYjfMlGnkg7zPDT54XnTuDZX0Nw3uWPlLGaoZcSLVx3/yWZFVdPGXIzunfIHoYMP+YQe5BpEbifkC4YQqSh7jjc7NvtLDde/U9tX0uPyGQ9zrKtMCUpA50h1JdEz+qFrr8q3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055339; c=relaxed/simple;
	bh=E+SPaXFzCBApgYFAM5KXiAb9PzQTdE0PNGGmCbrkFMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfXce11v0oIvuyoKrkGByGch/6MMaE+5KGBolJdDLG0aZgiB/jy6XRAX0MNkL6iUgxUasTHx0MrckopYrK5McgyRnzs1oqVUtPbZDMaumkncUJ/ZfnoEckUSnttRF/KYJ4m2Ny15TQ4PvvMUYQL74K8K4qY//fkIaJdIaeNghsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0GQ0hCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0GQ0hCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3192B1F000FF;
	Thu, 10 Sep 2026 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055337;
	bh=SndLR4tow0YvFnaF+IHSGNzfQ8itg2LrhCTAMsR46hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=H0GQ0hCYfdWr2dUV9N360XeiuSEYEPhSo4dljNffiIw59xbSrMWf5ATi8gYxaqTpF
	 Z6Vpu4gI1N5P3iiYR2ggp/oTh60sqdPj3fZ5DaDC6PKsYjObbj01RQYV8Lwtnj0+8N
	 vgTI8TxC4BlhFwW08pcPlPouQdG5Y3INEIPYT3G0gxFMqdHG1hEjFqEv6e9OOYJ/DV
	 yl2/F37go9S9b5kdwnVGqiI8f8JdCt914q3HcFz/X+jruEW0dxGVzJeX6+w10nqbh5
	 cfpytSdxzkMHD8eqGB2gTsEeMqFIV6aV4s3BFTMuAR4LUk5wiw2cpv9A3NWm6QBfCg
	 P23aq34/PsNCg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:12 +0200
Subject: [PATCH RFC v4 14/18] fs: add alloc_files_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-14-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258; i=brauner@kernel.org;
 h=from:subject:message-id; bh=E+SPaXFzCBApgYFAM5KXiAb9PzQTdE0PNGGmCbrkFMI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumhX9JRB9T5XlNeqCSKVG/55Xv1T8f/YerGX3yYuO
 PH/CJdfe0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBExCcy/LMMlU5p61s4u97S
 w+jWtynWeYk8F6+XnrKdJfxg+aJVrzwYGe7tYcyOPr2/7ZgkF7ste1Wh56RNgc73HL/McZb8vN1
 TjhcA
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
index 76e328edf630..8fa58500b6d1 100644
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
index 2965acd120bc..155ad783f2ce 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -100,6 +100,7 @@ static inline bool close_on_exec(unsigned int fd, const struct files_struct *fil
 struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
+struct files_struct *alloc_files_struct(void);
 void switch_files_struct(struct task_struct *tsk, struct files_struct *files);
 int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp);
 struct fd_range {

-- 
2.53.0

