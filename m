Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375886;
	b=Vo/U1bnrBmp+xhslUtoMn7YI2rQcptiqvK8AsREqEltun5hFSG2zNO7Nko8GqZPetsmR
	 f4ZmPiwBTr2C20GnEPKYYHmXgqA7NIX/qfwNqCURvIiCPh8qCOeFCE2oEXQKb+rwOcBz+
	 SArRnSNwGoojcSfQsQ/I9qcIEZUGnBBj8/0ioOtaRrt5FsOOXhpMAHRaUZSGpUU/NDckU
	 sYU12Sh/0ws6BJc26QLVs2iPVVudgd8NXxzl7l+smjV0oIZ+FnIAyqAUYW2UjRb2CuYW5
	 yWVdvZK0YK53ZBra/tFCDHvApPNJ3QVAcR4HZFZKylsXuhZHLmxUmX8H7kClg2MeVKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375886;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mHmsV++4fT8TY6BSD763DBrchduEf2WvvITz9T/2Gmg=;
	b=Z1+0n0Cazflc8dP6++mBJHNx7iWL7lQBNWx56ovDj8N6uh0KhITa5lXDAbJ+P0MhfVFh
	 eQa6YjZzkLh7gFUddWluYInymRe0SEIUEfEgonZVx9y1R3+mxvWWEOajFuj/pf5rObGmR
	 TJAHBjlkHHr+gh94BIPy8dWD+hkrq6p4xAjdtbKH++M7R3IgReNJqdV0j4DIHzn0rjRAX
	 1bNB1+k6OnRDrWeBEHbsVUH8wctCsBQ/R/7QECq6twjco/TpMH73OiEEkmRuMKNTf3Quu
	 AA4YfFCc6HazrjKwaXX7T1xPrb6SlHGQ7ZR25XgLBfca6husQ4oJ/rjteV/VISykD5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BaW/8FT1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC64606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BaW/8FT1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDA11F000C1;
	Fri, 30 Oct 2026 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793375885;
	bh=mHmsV++4fT8TY6BSD763DBrchduEf2WvvITz9T/2Gmg=;
	h=From:Date:Subject:To:Cc;
	b=BaW/8FT1G+Ljzi0OSDrvlZp0g5iCvuBTAlQp3nxqY7nluBgrBJ7OgGNIP9bD7+Wt9
	 grMKSE2RYZmux+yOdnntkZSjZ2U4Z+Qv2vCzOTKK9z+uvv/sdYCr72Q3lpe/2rfhqT
	 HY9kJ7dQijlPr+ECxI2kQCHQOYOGuoHmcq8/eEx01WgHeWhbSWkewpyQs5iYOh6r+D
	 UiM10X4aDRvnoVPrSGPbC1jVxE2IzSk/mrTZYSfs8ZX5we9w/wLjweRO5Pe8fA77Ct
	 gExTk3twQ58j3+Tsfidy4j/Stm0wjVwaiTudLrH2VRHSPAMPGuiR5goT8J7HOwT10H
	 pA+SLug3fKa0w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 16:58:00 +0100
Subject: [PATCH] libfs: walk offset directories in offset order
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
Message-Id: <20261030-work-libfs-offset_readdir-v1-1-ed733c14229e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2wrCMBAFf6Xk2ZU0lUb8FRHJZWNXJZXdWoXSf
 zexj3M4M4sSZEJRp2ZRjDMJjblAu2tUGFy+IVAsrIw2fas7DZ+RH/AknwTGlASnK6OLkRiO2sb
 OW3swvVbFfzEm+v7b58vG8vZ3DFMN1od3guDZ5TDUaU6y34x1/QFE/aNMmQAAAA==
X-Change-ID: 20261030-work-libfs-offset_readdir-807d3b774260
To: Chuck Lever <cel@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Yongjian Sun <sunyongjian1@huawei.com>, 
 Nickolai Zeldovich <nickolai@csail.mit.edu>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5448; i=brauner@kernel.org;
 h=from:subject:message-id; bh=J3ecgdUicEiUB3fvdaKNniJb5Mv9bymuS96hbDVfUGw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ92dfZGTNxbyOrWD3TW2mvaQxO8iERIVPlFbn3f7t5v
 rTZR3NxRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES0LjIytIplu127HXPlYMbB
 uTsl6ziW1RY5qfDwCX6cP/H00R+2VxkZ3jcZ9cc6f1s20+XecZ7vWdVd+j9PHEhTEP/voLNxks5
 qNgA=
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
shared.

Fixes: b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset directories")
Fixes: f70681e9e606 ("libfs: Fix duplicate directory entry in offset_dir_lookup")
Reported-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
Link: https://patch.msgid.link/20261018024549.798968-1-nickolai@csail.mit.edu
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/libfs.c | 56 ++++++++++++++++++++++----------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 96a6e9b1535f..8d5de5f61ffd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -446,31 +446,11 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
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
+/*
+ * Find the entry with the highest offset at or below @offset. Entries are
+ * emitted in descending offset order, so this is the next entry to emit
+ * when resuming at @offset.
+ */
 static noinline_for_stack struct dentry *
 offset_dir_lookup(struct dentry *parent, loff_t offset)
 {
@@ -480,14 +460,19 @@ offset_dir_lookup(struct dentry *parent, loff_t offset)
 
 	MA_STATE(mas, &octx->mt, offset, offset);
 
-	if (offset == DIR_OFFSET_FIRST)
-		found = find_positive_dentry(parent, NULL, false);
-	else {
-		rcu_read_lock();
-		child = mas_find_rev(&mas, DIR_OFFSET_MIN);
-		found = find_positive_dentry(parent, child, false);
-		rcu_read_unlock();
+	if (offset < DIR_OFFSET_MIN)
+		return NULL;
+
+	rcu_read_lock();
+	while ((child = mas_find_rev(&mas, DIR_OFFSET_MIN))) {
+		spin_lock(&child->d_lock);
+		if (simple_positive(child))
+			found = dget_dlock(child);
+		spin_unlock(&child->d_lock);
+		if (found)
+			break;
 	}
+	rcu_read_unlock();
 	return found;
 }
 
@@ -504,7 +489,10 @@ static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
 	struct dentry *dir = file->f_path.dentry;
 	struct dentry *dentry;
 
-	dentry = offset_dir_lookup(dir, ctx->pos);
+	if (ctx->pos == DIR_OFFSET_FIRST)
+		dentry = offset_dir_lookup(dir, DIR_OFFSET_MAX);
+	else
+		dentry = offset_dir_lookup(dir, ctx->pos);
 	if (!dentry)
 		goto out_eod;
 	while (true) {
@@ -514,7 +502,7 @@ static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
 		if (!offset_dir_emit(ctx, dentry))
 			break;
 
-		next = find_positive_dentry(dir, dentry, true);
+		next = offset_dir_lookup(dir, ctx->pos - 1);
 		dput(dentry);
 
 		if (!next)

---
base-commit: b44341e39d856e4cc6ad8ed94ebffd440f39846c
change-id: 20261030-work-libfs-offset_readdir-807d3b774260

