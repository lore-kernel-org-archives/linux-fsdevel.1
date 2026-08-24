Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C2370D70
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585320; cv=none; b=ILNwvqsNTFt/wA68J7f3b6vzJvtPQqhbM07ghWMTbRvcW2X8QI1qWYgA7fu1JLuQZwGv5tgLXIz+yftaUXsFHgj/ROi0zBjOSKOWzxZu1yYbz8lnZBBoyiPYbV+eE7RmZzNovhk97m14jn7VICPblk7f557u2qfZDu2GJTCltwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585320; c=relaxed/simple;
	bh=s9NijOcxqU4RauLQnGB8xIzQifKAQKgSTJ2eh0+dWvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRXiKGCLC7U9SB6p9J9kgShT4y4hZJg2wwtp5a1FHPb2s23kFSvZ94evp/MhwMpb4Qhpg+MV2zxT39Auge3rnMxTVnXqt+fvvh8wtq2CweGT11eo0O0e7j1D1iDgzkJe3NCpWCOuCq7BY+XSYlPt5t+xw+coIQ/Alz2wKWRe2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la43msgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la43msgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B5F1F000E9;
	Mon, 24 Aug 2026 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585316;
	bh=d2tYSPvKQqncZnbBRGAtCMXNzOI8Xo+jpXz4CR5d5js=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=la43msgYqckCH3OJjllXuh5U1BQdP9fx81jO5gVq9JsLk4p6GdidBIFTLG/VpEqFt
	 j1ETfZsibXdKFP1fnT5vV/1B3ygFb0kq4OI++lXGnj123GI9Hv3/dLxcBA0K7GTauP
	 SRciDjzoqkhg2ESfQdoFrvQ8jMv2ao+v6cv+eNIp1vyqasdE3HswsETvpXhlm7IEMW
	 CQPnFcHATHAQQK5JJe49tshNpBWoWttk3dhyXB3RAha8P+Eoo9rQAy4+efXVFs56J6
	 X6ofpJceoi144KhsIqIGj4zO3TpUkP5dfDkz5pN0IU16FS4f7Gygju4EDTtuWT5La8
	 MbxmlWZ3LwnbA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 17:28:17 +0200
Subject: [PATCH RFC 3/7] fs: add switch_files_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-work-coredump-unlock-self-v1-3-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s9NijOcxqU4RauLQnGB8xIzQifKAQKgSTJ2eh0+dWvY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1JEtdudH2j83x7fkNC2NC5F/UOD2oXi5hU+TSsuW3a
 8i3xY4aHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpb2RkeFP65DrLxfgdDVdv
 9fJ1XDQ7OaEncHH+jIo2DueLm9UtfjIydHIVZWZY5l6X+qsvqHsppudcJvv2qHnHBaND416+Dst
 hAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add switch_files_struct() so a task can switch to a new file descriptor
table and close the old one. That's very restricted to the exit path and
coredumps.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 63 +++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index e2d4b72c2e26..391b6d4292c4 100644
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
 
@@ -404,6 +398,26 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	new_fdt->full_fds_bits = newf->full_fds_bits_init;
 	new_fdt->fd = &newf->fd_array[0];
 
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
@@ -523,16 +537,29 @@ void put_files_struct(struct files_struct *files)
 	}
 }
 
-void exit_files(struct task_struct *tsk)
+/* Hand @tsk the table @files, or none, and drop the one it had. */
+static void switch_files_struct(struct task_struct *tsk,
+				struct files_struct *files)
 {
-	struct files_struct * files = tsk->files;
+	struct files_struct *old;
 
-	if (files) {
-		task_lock(tsk);
-		tsk->files = NULL;
-		task_unlock(tsk);
-		put_files_struct(files);
+	task_lock(tsk);
+	old = tsk->files;
+	if (old) {
+		if (files)
+			atomic_inc(&files->count);
+		tsk->files = files;
 	}
+	task_unlock(tsk);
+	if (old)
+		put_files_struct(old);
+}
+
+void exit_files(struct task_struct *tsk)
+{
+	if (!tsk->files)
+		return;
+	switch_files_struct(tsk, NULL);
 }
 
 struct files_struct init_files = {

-- 
2.53.0

