Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6E35F5E8;
	Wed, 18 Mar 2026 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836582; cv=none; b=il3rn+9E2NJMFfbOCDSsTslJaQG0OrsiiSWz4e2arDO74gUxuQiHj/K9aGMuxXp+aoH0facCMuKnY7iroKAIaHwILD9Ojr3rxco5rK9AhEsIKkEtfNW4WRWGCaK46TGcH9llUWjODJPNdP5Ej0FwtKwdlpbYevRM5LkW2cVL0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836582; c=relaxed/simple;
	bh=LFBV3FKqCHGIGpa8UF0TaoOEPIzW8XXWMiAR47mpB/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJV7UEY/lPkUUqJjT1+Se4XaOHVFih019mSWky6PJE1ghnFC8FKcdJUIyYHtlVm8xYNQxxb7wKwZ4G4dAU0q7N72VDMuQ4lhADmhDxPBkzJvmW4iI5uQ2BblGpunFQWP90WoxFsxRVTaoXKwircdZ0GVbwTIzmfuKGXe6BNNe/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3TkXw+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3TkXw+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37B6C19421;
	Wed, 18 Mar 2026 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773836582;
	bh=LFBV3FKqCHGIGpa8UF0TaoOEPIzW8XXWMiAR47mpB/A=;
	h=From:To:Cc:Subject:Date:From;
	b=A3TkXw+1EgSEbhmx6lN+R5iOmhHDs6ohTu6YOlThw5nUnRPwXAZ6oSSOEG7jHp7S7
	 r1vBedqXc8M/uK/JGTZOSob9dIOmEObKWhVDGPZliXSh+KGLC5gqbCRpnwM7I3C8M0
	 cnPgrg7yOR08S3TrAPWbzxvKZ0rtka7WPAHSJe/ZZ5izveL742Qv+8keODrnpSEoh+
	 DUEw4T5F1caTowy9RgY0UVVOonjrlKj8dw8ufVMscrOfvPEKpGEkH7rBk/ZlXCvhVk
	 3raODPm7FvyMWBSBkGSk3OovGV5fRXO/opGF99v8oXtlHs5guo0Wi9zwN8Kb9obL/u
	 UqB3gdqS7DEPA==
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
Subject: [PATCH v4] fs: Replace user_access_{begin/end} by scoped user access
Date: Wed, 18 Mar 2026 13:22:43 +0100
Message-ID: <f46941437f681cc72fc5a84fa768f65b952f43c6.1773830446.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9338; i=chleroy@kernel.org; h=from:subject:message-id; bh=LFBV3FKqCHGIGpa8UF0TaoOEPIzW8XXWMiAR47mpB/A=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTumik6b9/SeUJJWf80VvxMiozYc0dZp+F6T4RhSU+Zv ayg+6mkjlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjCRxSsZGVa7VMnoMfwp+ux6 87fCJ8abdVt95dUKFpsdeXaIKdnK8DLDP9XZert1up/PzzN58mWpUb5grHjth8mX9PRqTbPnXVN 7wQcA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Scoped user access reduces code complexity and seamlessly bring
masked user access on architectures that support it.

Replace user_access_begin/user_access_end blocks by
scoped user access.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
v2:
- Fix build failure with CONFIG_COMPAT
- Handled checkpatch.pl output

v3:
- Fix again build failure with CONFIG_COMPAT. I was obviously too tired when I sent out v2.

v4:
- Introduced local size var based on Linus comment on readability. Not a dirent_size() helper as suggested as both sites are different.
---
 fs/readdir.c | 94 +++++++++++++++++++++-------------------------------
 fs/select.c  | 35 ++++++++-----------
 2 files changed, 51 insertions(+), 78 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 73707b6816e9..8fa615b7e950 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -184,6 +184,7 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
 	struct readdir_callback *buf =
 		container_of(ctx, struct readdir_callback, ctx);
 	struct old_linux_dirent __user * dirent;
+	size_t size = offsetof(struct old_linux_dirent, d_name) + namlen + 1;
 	unsigned long d_ino;
 
 	if (buf->result)
@@ -198,18 +199,13 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!user_write_access_begin(dirent,
-			(unsigned long)(dirent->d_name + namlen + 1) -
-				(unsigned long)dirent))
-		goto efault;
-	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(offset, &dirent->d_offset, efault_end);
-	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+	scoped_user_write_access_size(dirent, size, efault) {
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
@@ -287,23 +283,19 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
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
+		unsafe_put_user(d_type, (char __user *)dirent + reclen - 1, efault);
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
@@ -371,24 +363,20 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
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
@@ -446,6 +434,7 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
 	struct compat_readdir_callback *buf =
 		container_of(ctx, struct compat_readdir_callback, ctx);
 	struct compat_old_linux_dirent __user *dirent;
+	size_t size = offsetof(struct compat_old_linux_dirent, d_name) + namlen + 1;
 	compat_ulong_t d_ino;
 
 	if (buf->result)
@@ -460,18 +449,13 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!user_write_access_begin(dirent,
-			(unsigned long)(dirent->d_name + namlen + 1) -
-				(unsigned long)dirent))
-		goto efault;
-	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(offset, &dirent->d_offset, efault_end);
-	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+	scoped_user_write_access_size(dirent, size, efault) {
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
@@ -543,22 +527,18 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
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
+	scoped_user_write_access_size(prev, reclen + prev_reclen, efault) {
+		unsafe_put_user(offset, &prev->d_off, efault);
+		unsafe_put_user(d_ino, &dirent->d_ino, efault);
+		unsafe_put_user(reclen, &dirent->d_reclen, efault);
+		unsafe_put_user(d_type, (char __user *)dirent + reclen - 1, efault);
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
index e0244dbe4429..75978b18f48f 100644
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
+		scoped_user_read_access(from, efault) {
+			unsafe_get_user(to->p, &from->p, efault);
+			unsafe_get_user(to->size, &from->size, efault);
+		}
 	}
 	return 0;
-Efault:
-	user_read_access_end();
+efault:
 	return -EFAULT;
 }
 
-- 
2.49.0

