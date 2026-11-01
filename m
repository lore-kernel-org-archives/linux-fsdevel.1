Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530661;
	b=BdV13bNccDbnBrldFgUDfjM0JoCSukcCEvnEI7lJXm388zrxa2PCcV49wyxuh9MqW7Tz
	 TFfMBvUSxebeQ22S7UxNVMVr+ETfuNKWItOxNu1pq7SULvhA6H7C0Qwd1J/kuNGrk94hF
	 LoJmT0IIRCAwOXbLSW7zKeh5N701z7YQjsOZcgk0vB9fhKEdyxz9wGH3W0Ytnl2gHjYEx
	 CnnyBM4apL4GVrkf99wuMPQiOuDaY3ZQM8XT5FDIXfH9Ep0DMnoEgZQt9gLQt30/OVj68
	 b20z9Ic8dUC267Tk1zR9xTbY5p/VdiKgoDMg+Xu7LSUgNhO5YKyJh68OWHvGGJ+jPmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530661;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tz6DRKKAaKFijdEYnHdeWMUpIb4bgRi13fdp15y1y44=;
	b=WCliAGswHRm6juufLJFMcs4V6gRAZf8HlYhMO1DIE5QeOURRqYV+lOd8PwyzLaAhiflE
	 tFDbnNiy1KLq2fvga4+C1IotpFALyxdkq9c95qtEELSAPVEiUBW4veE/tB0QZ6X0YneAQ
	 HFmbDYPJaMEH3TQN5XMNEczyZLaDJ/DyucC5A1iG5tbFHK3FOr9A1xLx2VQLtSUYwnacM
	 O4HYw7ilPEkZOCXLcL5oonIaxmW58xmKIakU5o3m9SXmv8t8BSEi5kvjTe3cpkmufoUVP
	 HaO85LjYM/d0GFEhGVvRtxvdTI0kTJiTVlxZ6py8aPcjGjR6DZWTxYPF2E87tMWs9Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTpX3CbZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99471606A32C
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTpX3CbZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08D61F000C1;
	Sun,  1 Nov 2026 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793530661;
	bh=tz6DRKKAaKFijdEYnHdeWMUpIb4bgRi13fdp15y1y44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iTpX3CbZohTFrbjX+kAOyQcsHErziqHi5PwFDT2JIDVv26VGmKEEapEj6llPRclJD
	 JWP0giymizW+ZZ9L4qSvev3QvwCY8ZA6GdZMz+1hec+d2KG0zpmXabieLT5s2KqVes
	 8v2QFYznEo/Bl6pPU3lK5Xb0SXdiev4kZiV9KJTNFdiaO/EkaZvRPI324tPRi8uWsr
	 /hKuLrVGTmJFy/C0Pauc3A/XD1v3mVWQfnuJlbhoM7xUrQFFVMcxmH5jzagS9FPn6k
	 v0Bq7hxB6j7fAQsLVFqlKRKKrDwEzN2b5QgJ1bQB10fkaJ1wnav/yBU621I3YsE7f4
	 jzp73Jo1whAUw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 01 Nov 2026 11:57:21 +0100
Subject: [PATCH v2 2/3] libfs: walk offset directories in offset order
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-work-libfs-offset_readdir-v2-2-c621125b56d1@kernel.org>
References: <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
In-Reply-To: <20261101-work-libfs-offset_readdir-v2-0-c621125b56d1@kernel.org>
To: Chuck Lever <cel@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Nickolai Zeldovich <nickolai@csail.mit.edu>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7783; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5QmdA37cru1IKJhJt5/fO61nl29Y5ZsxvtK3VciVNb4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9l5Z92Km5y+LT2f7CLdMFNtyb/HriK5YDRV3/zWbe/
 pq+ymKhYkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzgQx/E8IXtUYLfxnkktk
 uX6wpga/bfWvYlmbknXrHn3uyuGensHwVyxnS/kxsU7vFKm3N5oDJT4stWdb63m1vU6NUfwP5/M
 wPgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

offset_iterate_dir() walks d_children from the head and only uses the
maple tree to map ctx->pos back to a dentry when a getdents64() call
resumes. offset_dir_lookup() finds the entry at ctx->pos, or the one
with the next lower offset if it is gone, and the list walk continues
from there.

That only works if list order and offset order agree and quite often
they don't. A rename over an existing name gives the moved dentry the
offset of the name it replaced but __d_move() puts it at the head of
d_children. RENAME_EXCHANGE does the same to both dentries. And once
the cyclic offset allocator wraps new entries get low offsets at the
head of the list.

So if the entry at ctx->pos is unlinked between two getdents64() calls
we resume at the entry with the next lower offset and that one can sit
anywhere in the list:

(1) If it sits further down the list everything in between is skipped.
    Create y, t, a, b and rename b over t. The list is now t(4) a(5)
    y(3). Stop the listing at t and unlink t. The next call resumes at
    y and a is never returned although nobody touched it.

(2) If there is no lower entry we restart at the head and return the
    whole directory again. Nickolai reported this for the simple case
    of unlinking the oldest entry while a listing is about to reach it.
    Ending the walk there instead turns this into (1): create a, b, c,
    rename c over a, stop the listing at the renamed entry, unlink it,
    and b is lost.

Instead of the list let's walk the maple tree itself in descending
offset order. Then ctx->pos really means that everything above it has
been emitted and resuming at the highest offset at or below it is right
no matter where the dentry sits in d_children. Entries created or
renamed to a new name after the listing started get an offset above
ctx->pos and aren't returned, same as with the list walk which never
went back to the head. So a readdir loop that renames or creates an
entry for each one it reads still terminates.

The maple tree can't change under us as all modifications happen with
the directory's i_rwsem held exclusive and offset_readdir() holds it
shared. That also covers the dentries in the tree. They are all
persistent and only unlink, rmdir and rename remove or rename them. And
since the previous patch i_rwsem is the lock of the tree. So keep a
single ma_state across the walk and emit directly from the dentry
without taking rcu_read_lock(), a reference or d_lock.

This also makes the walk cheaper than the list walk was. With a million
entries on tmpfs a getdents64() listing goes from 146ms to 114ms. With
four processes listing the directory at the same time it goes from
470ms to 113ms per listing as they don't bounce the parent's d_lock and
the dentries' lockrefs between them anymore.

                                                base     v2       this
      1M entries, getdents64 32k buffer (ms)    146      127      114
      1M entries, getdents64 1k buffer (ms)     184      156      141
      1M entries, getdents64 128b buffer (ms)   429      364      335
      1M entries, ls -f (s)                     0.259    0.239    0.228
      1M entries, LC_ALL=C ls (s)               0.482    0.467    0.455
      1M entries, 4 parallel listers (ms)       470      125      113
      18 entries, rewind and list (ns)          4107     3594     3323
      250k of 1M left, getdents64 32k (ms)      58.8     57.8     53.8
      250k of 1M left, getdents64 128b (ms)     128      114      108

Fixes: b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset directories")
Fixes: f70681e9e606 ("libfs: Fix duplicate directory entry in offset_dir_lookup")
Reported-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
Link: https://patch.msgid.link/20261018024549.798968-1-nickolai@csail.mit.edu
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/libfs.c | 85 ++++++++++++++++----------------------------------------------
 1 file changed, 22 insertions(+), 63 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 653ee8461a8f..654f487b05c0 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -283,6 +283,12 @@ void simple_offset_init(struct offset_ctx *octx, struct inode *dir)
  * @octx: directory offset ctx to be updated
  * @dentry: new dentry being added
  *
+ * The offset map holds no reference to @dentry. Once positive, @dentry
+ * must be pinned with d_make_persistent() for as long as it is in the
+ * map, and entries may only be added, removed or renamed with the
+ * directory's i_rwsem held exclusive: offset_readdir() emits straight
+ * from the map under the shared lock.
+ *
  * Returns zero on success. @octx and the dentry's offset are updated.
  * Otherwise, a negative errno value is returned.
  */
@@ -458,51 +464,6 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
-static struct dentry *find_positive_dentry(struct dentry *parent,
-					   struct dentry *dentry,
-					   bool next)
-{
-	struct dentry *found = NULL;
-
-	spin_lock(&parent->d_lock);
-	if (next)
-		dentry = d_next_sibling(dentry);
-	else if (!dentry)
-		dentry = d_first_child(parent);
-	hlist_for_each_entry_from(dentry, d_sib) {
-		if (!simple_positive(dentry))
-			continue;
-		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-		if (simple_positive(dentry))
-			found = dget_dlock(dentry);
-		spin_unlock(&dentry->d_lock);
-		if (likely(found))
-			break;
-	}
-	spin_unlock(&parent->d_lock);
-	return found;
-}
-
-static noinline_for_stack struct dentry *
-offset_dir_lookup(struct dentry *parent, loff_t offset)
-{
-	struct inode *inode = d_inode(parent);
-	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
-	struct dentry *child, *found = NULL;
-
-	MA_STATE(mas, &octx->mt, offset, offset);
-
-	if (offset == DIR_OFFSET_FIRST)
-		found = find_positive_dentry(parent, NULL, false);
-	else {
-		rcu_read_lock();
-		child = mas_find_rev(&mas, DIR_OFFSET_MIN);
-		found = find_positive_dentry(parent, child, false);
-		rcu_read_unlock();
-	}
-	return found;
-}
-
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
@@ -511,32 +472,30 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
+/*
+ * Emit entries in descending offset order. The directory's i_rwsem is the
+ * lock of the offset tree and the persistent dentries in it only change
+ * with it held exclusive. We hold it shared, so @mas stays valid across
+ * dir_emit() and the dentries need no references.
+ */
 static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
 {
-	struct dentry *dir = file->f_path.dentry;
+	struct inode *inode = file_inode(file);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
+	loff_t start = ctx->pos == DIR_OFFSET_FIRST ? DIR_OFFSET_MAX : ctx->pos;
 	struct dentry *dentry;
 
-	dentry = offset_dir_lookup(dir, ctx->pos);
-	if (!dentry)
-		goto out_eod;
-	while (true) {
-		struct dentry *next;
+	MA_STATE(mas, &octx->mt, start, start);
 
+	for (;;) {
+		dentry = mas_find_rev(&mas, DIR_OFFSET_MIN);
+		if (!dentry)
+			break;
+		VFS_WARN_ON_ONCE(!(dentry->d_flags & DCACHE_PERSISTENT));
 		ctx->pos = dentry2offset(dentry);
 		if (!offset_dir_emit(ctx, dentry))
-			break;
-
-		next = find_positive_dentry(dir, dentry, true);
-		dput(dentry);
-
-		if (!next)
-			goto out_eod;
-		dentry = next;
+			return;
 	}
-	dput(dentry);
-	return;
-
-out_eod:
 	ctx->pos = DIR_OFFSET_EOD;
 }
 

-- 
2.53.0

