Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B584A8FE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000155; cv=none; b=jemXVtnqZbwgCkwiUzoo2Ij8zmB5jAWo66OmRPkVmU06UGsklus+h2slLM8YNd/y4ZpLq6Xrgyla46zwWmeFInz1+st/VdyWYAAl89VwA7n22v2zQeZGNjE4F1wVQNUL0fvREQ0PPnj/9Z0aGWtEJbgvVpJycmQ8XSVc0jtjgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000155; c=relaxed/simple;
	bh=Nw67yKNI70Qxkj4QJny4OSToB5R95eV2fvOoVEhrFVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IF3vk4OWxsxsv122zW0Az7ZwcQufqCwXdeBpwTwF844/eQ7Em7SDu85QiZrG4cmNJ7CkTA5wHA/9x/Wt4yT/dCXHtpxaZe9DAfiTF5Fq9aljs8yTYs/ICgmHM3GGKJ5JaNsfwi8bjX3C9TbfIg6RnUx6TAps9PRVJ5ptkxrgkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTIPBoRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTIPBoRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D6C1F00893;
	Mon, 21 Sep 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000153;
	bh=fvAEe6rDaBywQpGM46YJ5jbiDGvo2f2wZYWCQnhZAps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mTIPBoRQbTYQk+P/OwSKu4VO//TYJR3jkTaYlvTJ9wkQGIq8byaMkzHX3BaL8008+
	 mWZC8gP7QNOXpV1Aorm/wz53itXPoKZSiKUVCnNJNTyE/U10fY6kNwZVwI4EK/UDgI
	 4Ed048yPLz5pOpY8r/0j9fn/96K/oD3wFXsOzhMyroLDaY4J0G7ii+OR1OhrruxLgC
	 bJwUpMND1lyWT9WwLHxhit5NaBcOIF0Tq+77UjiyrKEo5319XKmDClCSdPSwCQIRJc
	 QOnEiSeWK0uK7GS0MSq0cCD1DsubfmaBE/xFvsZM5wzgGR9Vy5+DN0aHWZHi3A5KJN
	 XHo2ioZnTbJjQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:31 +0200
Subject: [PATCH 03/10] file: rename dup_fd()'s punch_hole to range
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-3-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4578; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Nw67yKNI70Qxkj4QJny4OSToB5R95eV2fvOoVEhrFVc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOFZIdm9LFD5v/bnFZsiN/H8Wa5bdONhl2SQjf+SN
 ZOWG9xX6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI+1qGv4Kado6l3MfsZjvP
 yl5whTugpe3HVz6+/46VzRdNmqrPvmD4H+lw6emlmp/zaiqXit9k+uSy2il/tnK73fuZn31e7GS
 o5wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

dup_fd() will be taught what to do with the range that was passed to it.
It won't always be dropped. Rename it to a plain "range" from
"punch_hole". close_range() keeps a pointer named drop for the one case
it has today.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 95dbdfee555a..6234548be88b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -365,23 +365,23 @@ static unsigned long fd_range_word(struct fd_range *range, unsigned int i)
 }
 
 /* Bits of word @i that dup_fd() leaves behind. */
-static unsigned long dup_fd_dropped_word(unsigned int i, struct fd_range *punch_hole)
+static unsigned long dup_fd_dropped_word(unsigned int i, struct fd_range *range)
 {
-	if (!punch_hole)
+	if (!range)
 		return 0;
-	return fd_range_word(punch_hole, i);
+	return fd_range_word(range, i);
 }
 
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
  *
- * punch_hole is optional - when close_range() is asked to unshare
+ * range is optional - when close_range() is asked to unshare
  * and close, dup_fd() leaves the descriptors in that range behind,
  * so the cloned table only has to reach the last open descriptor
  * outside of it.
  */
-static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *punch_hole)
+static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *range)
 {
 	unsigned int last = find_last_bit(fdt->open_fds, fdt->max_fds);
 	unsigned int i;
@@ -391,7 +391,7 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *punc
 	/* Only words up to the last open descriptor can hold a kept one. */
 	i = last / BITS_PER_LONG + 1;
 	while (i--) {
-		unsigned long dropped = dup_fd_dropped_word(i, punch_hole);
+		unsigned long dropped = dup_fd_dropped_word(i, range);
 
 		if (fdt->open_fds[i] & ~dropped)
 			return (i + 1) * BITS_PER_LONG;
@@ -402,9 +402,9 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *punc
 /*
  * Allocate a new descriptor table and copy contents from the passed in
  * instance.  Returns a pointer to cloned table on success, ERR_PTR()
- * on failure.  For 'punch_hole' see sane_fdtable_size().
+ * on failure.  For 'range' see sane_fdtable_size().
  */
-struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_hole)
+struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *range)
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
@@ -431,7 +431,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = sane_fdtable_size(old_fdt, punch_hole);
+	open_files = sane_fdtable_size(old_fdt, range);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -455,7 +455,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = sane_fdtable_size(old_fdt, punch_hole);
+		open_files = sane_fdtable_size(old_fdt, range);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
@@ -482,7 +482,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 		struct file *f = rcu_dereference_raw(*old_fds++);
 
 		if (!(fd % BITS_PER_LONG))
-			dropped = dup_fd_dropped_word(fd / BITS_PER_LONG, punch_hole);
+			dropped = dup_fd_dropped_word(fd / BITS_PER_LONG, range);
 		if (f && !(dropped & BIT_MASK(fd))) {
 			get_file(f);
 		} else {
@@ -858,7 +858,7 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		return -EINVAL;
 
 	if ((flags & CLOSE_RANGE_UNSHARE) && atomic_read(&cur_fds->count) > 1) {
-		struct fd_range range = {fd, max_fd}, *punch_hole = &range;
+		struct fd_range range = {fd, max_fd}, *drop = &range;
 
 		/*
 		 * If the caller requested all fds to be made cloexec we always
@@ -866,9 +866,9 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		 * use them.
 		 */
 		if (flags & CLOSE_RANGE_CLOEXEC)
-			punch_hole = NULL;
+			drop = NULL;
 
-		fds = dup_fd(cur_fds, punch_hole);
+		fds = dup_fd(cur_fds, drop);
 		if (IS_ERR(fds))
 			return PTR_ERR(fds);
 		/*

-- 
2.53.0

