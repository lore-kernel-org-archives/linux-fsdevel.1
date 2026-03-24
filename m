Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3943EF66F;
	Tue, 24 Mar 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352551; cv=none; b=SpTWAUxyCqgoKPItGAv0EHKpaGiMp5tbZw15vuj0SHPVdwwjK010Pfh6cpB2u5E9sQIfqJe5SpnlYoRctMLpkhfb7RfGR4LP34DanCsZ6cNwZ+ZhOFP6ndtLBmouk7+gDusn/OFq4i70bfnh1zq2nyWZegZDOgw3Kya411Vz8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352551; c=relaxed/simple;
	bh=4PomMYzDixS1M/cpXZRiI8sfPTeQWI+OQgRyCHJzP8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brr9+VZ8NT+JpiLTvLBfnpr6GRTzkC9229tVjecC3QgABtpeslSakg4e/DP2BtxcjB+MlXoNSKZZXgL4uPb3KVf7xkxQC9dGZBsVaXtsjAIvpRNAR0VsNfSDybRP++OI8rA1qkrNKe16eYUSzuGwo70gpmGtd0fGSzTYEsYVtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVTQpPm3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVTQpPm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3437FC2BCB3;
	Tue, 24 Mar 2026 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774352551;
	bh=4PomMYzDixS1M/cpXZRiI8sfPTeQWI+OQgRyCHJzP8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVTQpPm3F58cE3VDg8q3SQE1k0p3aCTdkAJGoLD8xilQvtbouUc41vVhmy2BiGXsh
	 h5XNCMkdhC3ZUyKeMK1+EEqZcGeG1qR9Y9XV4L1ZYxqh7g0KiueYwefOtrMh/QIpOJ
	 /PC7407Tu8e/utoVf2N1JP5AEZQKJ9jhiKbKhHTrn2y8KlcvnWX3s7iYmmaQEX0oEU
	 luU+EP6bE4X/sCOP6usEZMEIWVDKr+MiXFXY4RlGStPYBOfrIsOIn9OVY7fVRlzUZX
	 FsfkTip+p2wkyiu4X+G/cve3Fc6CO7dAn3llbfGcpW9GYu6GtnwzJuKSAL+TpmCW6W
	 cGAW4ZwzXheTA==
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
Subject: [PATCH v5 2/2] fs: Replace user_access_{begin/end} by scoped user access
Date: Tue, 24 Mar 2026 12:41:16 +0100
Message-ID: <16daf33a8190a771a93e294d050bd8153521ffca.1774350128.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
References: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8633; i=chleroy@kernel.org; h=from:subject:message-id; bh=4PomMYzDixS1M/cpXZRiI8sfPTeQWI+OQgRyCHJzP8o=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQeqki+vTpr05qVbZsXqW97vNct91VOqXdmyXaZbwFnH misexre2lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAmwv6d4Z/9rQonntkMoZpV NxeHGP/OqEoIrj22dX5m5GlPhmufPNkY/sf1zVJU7frTW/snesGHkxWnHaMzBQIThArPbGRU9d7 VyQkA
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

v5:
- Just rely on the macro added in previous patch.
---
 fs/readdir.c | 88 +++++++++++++++++++++-------------------------------
 fs/select.c  | 35 +++++++++------------
 2 files changed, 49 insertions(+), 74 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index fb910dc2f52b..76bb1ae3a450 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -200,16 +200,13 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!user_write_access_begin(dirent, dirent_size(dirent, namlen + 1)))
-		goto efault;
-	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(offset, &dirent->d_offset, efault_end);
-	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+	scoped_user_write_access_size(dirent, dirent_size(dirent, namlen + 1), efault) {
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
@@ -286,23 +283,19 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
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
@@ -369,24 +362,20 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
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
@@ -458,16 +447,13 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!user_write_access_begin(dirent, dirent_size(dirent, namlen + 1)))
-		goto efault;
-	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
-	unsafe_put_user(offset, &dirent->d_offset, efault_end);
-	unsafe_put_user(namlen, &dirent->d_namlen, efault_end);
-	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
-	user_write_access_end();
+	scoped_user_write_access_size(dirent, dirent_size(dirent, namlen + 1), efault) {
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
@@ -538,22 +524,18 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
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

