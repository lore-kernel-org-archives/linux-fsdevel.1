Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11E2EBBB7;
	Tue, 10 Mar 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153639; cv=none; b=IFS5R4E/Y+MuFyREx6dwPxUJjM90gwPI7ExYBmBw/a1Fv5WTJcQaTY6CHiG2u/4+YiqMI9BP5Q3IGI5XXPyrtsFo/FK+YqwoJRetOhYILejiIQXvlJZd+I9/4+5Y36VxjR3p5rrcz5rJoh+jNQPrXpYPY48D+63LYPsAgzjykJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153639; c=relaxed/simple;
	bh=Z8Nr1QvwMGZovkr0ftgEALk+HzXNA2h8VoVMn52LLrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=en+9PHFPq4zyJOIAORm7jP5MNf+qw4X/UQQSyBMRDkqqflRW27+vhyjGVhPM9L4qBD7j5FiPM/PHryXhDIbx0tftu8sXsQqt7dD6VMqfS8HbNdQmZXXZtRJNVEknIFwT3Ki9hSv3XYApTwUSmkyYCrqiwGvHlkKS3Zp4dDGyMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIFsxyJz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIFsxyJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FD4C2BC86;
	Tue, 10 Mar 2026 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773153639;
	bh=Z8Nr1QvwMGZovkr0ftgEALk+HzXNA2h8VoVMn52LLrQ=;
	h=From:To:Cc:Subject:Date:From;
	b=IIFsxyJzZNgb8vuPt4nqXC3ZeBA2n8EWvymkZZ8hsMTEKpqxNqUKkAmAR2XYQuT3U
	 4v/tpkrMl3PLErwHNsjF62eOFi6SmPNgjn7s87LaGQRh2iTyWsO3x8GQNCuCLzNYTh
	 c5RzFcIqRKFV2Li63m4PB9tEnNydLr45tkjO5uGzCl7b25JEklqixm3SgikDP4v29B
	 ff8vg/aNTvxo2v7BgG6P/ADVHMBtlV7/LYv6sGzhDV5zrobeUCMW49yNpNT2e9F1G9
	 UltXPEqJzL+mwL3VDbLvoQDDBfYWW9JZWCzqDyla5am9enbx7Aitq9ngY7PhoylJlw
	 OiH7xbRUXmgKw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Replace user_access_{begin/end} by scoped user access
Date: Tue, 10 Mar 2026 15:40:25 +0100
Message-ID: <5021aa325554b3d2437341514ab0a2977e158274.1773153431.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8333; i=chleroy@kernel.org; h=from:subject:message-id; bh=Z8Nr1QvwMGZovkr0ftgEALk+HzXNA2h8VoVMn52LLrQ=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRu0I10iOWVK5ft8jw48Wh19D6XquUrVFMnht9KYRCVc xO1bJvQUcrCIMbFICumyHL8P/euGV1fUvOn7tKHmcPKBDKEgYtTACai94mRYdpPXYHUG85PSn9f XOhwjufhBr+lm3olXPol39nP+FLvMI2R4b+6sJFU5/65tTL6qsdUZlpkLj/6PdRYMvAqLz+Hp9F qdgA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Scoped user access reduces code complexity and seamlessly bring
masked user access on architectures that support it.

Replace user_access_begin/user_access_end blocks in fs by
scoped user access.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 fs/readdir.c | 92 +++++++++++++++++++++-------------------------------
 fs/select.c  | 33 ++++++++-----------
 2 files changed, 50 insertions(+), 75 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 73707b6816e9..3ebe4adbe36c 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -198,18 +198,15 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!user_write_access_begin(dirent,
+	scoped_user_write_access_size(dirent,
 			(unsigned long)(dirent->d_name + namlen + 1) -
-				(unsigned long)dirent))
-		goto efault;
-	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(offset, &dirent->d_offset, efault_end);
-	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+				(unsigned long)dirent, efault) {
+		unsafe_put_user(d_ino, &dirent->d_ino, efault);
+		unsafe_put_user(offset, &dirent->d_offset, efault);
+		unsafe_put_user(namlen, &dirent->d_namlen, efault);
+		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
+	}
 	return true;
-efault_end:
-	user_write_access_end();
 efault:
 	buf->result = -EFAULT;
 	return false;
@@ -287,23 +284,19 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
-	if (!user_write_access_begin(prev, reclen + prev_reclen))
-		goto efault;
-
-	/* This might be 'dirent->d_off', but if so it will get overwritten */
-	unsafe_put_user(offset, &prev->d_off, efault_end);
-	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
-	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
+		/* This might be 'dirent->d_off', but if so it will get overwritten */
+		unsafe_put_user(offset, &prev->d_off, efault);
+		unsafe_put_user(d_ino, &dirent->d_ino, efault);
+		unsafe_put_user(reclen, &dirent->d_reclen, efault);
+		unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault);
+		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
+	}
 
 	buf->current_dir = (void __user *)dirent + reclen;
 	buf->prev_reclen = reclen;
 	ctx->count -= reclen;
 	return true;
-efault_end:
-	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
 	return false;
@@ -371,24 +364,20 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *)dirent - prev_reclen;
-	if (!user_write_access_begin(prev, reclen + prev_reclen))
-		goto efault;
-
-	/* This might be 'dirent->d_off', but if so it will get overwritten */
-	unsafe_put_user(offset, &prev->d_off, efault_end);
-	unsafe_put_user(ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
-	unsafe_put_user(d_type, &dirent->d_type, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
+		/* This might be 'dirent->d_off', but if so it will get overwritten */
+		unsafe_put_user(offset, &prev->d_off, efault);
+		unsafe_put_user(ino, &dirent->d_ino, efault);
+		unsafe_put_user(reclen, &dirent->d_reclen, efault);
+		unsafe_put_user(d_type, &dirent->d_type, efault);
+		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
+	}
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
 	ctx->count -= reclen;
 	return true;
 
-efault_end:
-	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
 	return false;
@@ -460,18 +449,15 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!user_write_access_begin(dirent,
+	scoped_user_write_access_size(dirent,
 			(unsigned long)(dirent->d_name + namlen + 1) -
-				(unsigned long)dirent))
-		goto efault;
-	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(offset, &dirent->d_offset, efault_end);
-	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+				(unsigned long)dirent), efault) {
+		unsafe_put_user(d_ino, &dirent->d_ino, efault);
+		unsafe_put_user(offset, &dirent->d_offset, efault);
+		unsafe_put_user(namlen, &dirent->d_namlen, efault);
+		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
+	}
 	return true;
-efault_end:
-	user_write_access_end();
 efault:
 	buf->result = -EFAULT;
 	return false;
@@ -543,22 +529,18 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
-	if (!user_write_access_begin(prev, reclen + prev_reclen))
-		goto efault;
-
-	unsafe_put_user(offset, &prev->d_off, efault_end);
-	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
-	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+	scoped_user_write_access_size(prev, reclen + prev_reclen, efault);
+		unsafe_put_user(offset, &prev->d_off, efault);
+		unsafe_put_user(d_ino, &dirent->d_ino, efault);
+		unsafe_put_user(reclen, &dirent->d_reclen, efault);
+		unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault);
+		unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault);
+	}
 
 	buf->prev_reclen = reclen;
 	buf->current_dir = (void __user *)dirent + reclen;
 	ctx->count -= reclen;
 	return true;
-efault_end:
-	user_write_access_end();
 efault:
 	buf->error = -EFAULT;
 	return false;
diff --git a/fs/select.c b/fs/select.c
index e0244dbe4429..7cf80568ff78 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1004,17 +1004,17 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 	fdcount = do_poll(head, &table, end_time);
 	poll_freewait(&table);
 
-	if (!user_write_access_begin(ufds, nfds * sizeof(*ufds)))
-		goto out_fds;
+	scoped_user_write_access_size(ufds, nfds * sizeof(*ufds), out_fds) {
+		struct pollfd __user *_ufds = ufds;
 
-	for (walk = head; walk; walk = walk->next) {
-		struct pollfd *fds = walk->entries;
-		unsigned int j;
+		for (walk = head; walk; walk = walk->next) {
+			struct pollfd *fds = walk->entries;
+			unsigned int j;
 
-		for (j = walk->len; j; fds++, ufds++, j--)
-			unsafe_put_user(fds->revents, &ufds->revents, Efault);
-  	}
-	user_write_access_end();
+			for (j = walk->len; j; fds++, _ufds++, j--)
+				unsafe_put_user(fds->revents, &_ufds->revents, out_fds);
+		}
+	}
 
 	err = fdcount;
 out_fds:
@@ -1026,11 +1026,6 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 	}
 
 	return err;
-
-Efault:
-	user_write_access_end();
-	err = -EFAULT;
-	goto out_fds;
 }
 
 static long do_restart_poll(struct restart_block *restart_block)
@@ -1338,15 +1333,13 @@ static inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
 					    struct compat_sigset_argpack __user *from)
 {
 	if (from) {
-		if (!user_read_access_begin(from, sizeof(*from)))
-			return -EFAULT;
-		unsafe_get_user(to->p, &from->p, Efault);
-		unsafe_get_user(to->size, &from->size, Efault);
-		user_read_access_end();
+		scoped_user_read_access(from, Efault) {
+			unsafe_get_user(to->p, &from->p, Efault);
+			unsafe_get_user(to->size, &from->size, Efault);
+		}
 	}
 	return 0;
 Efault:
-	user_read_access_end();
 	return -EFAULT;
 }
 
-- 
2.49.0

