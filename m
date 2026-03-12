Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF693502AA;
	Thu, 12 Mar 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323508; cv=none; b=nXp1tD5bLsrqBeEbl6lK/0A+Dcu4X+RmED/Xy+fcvKUwWCbyewNuj5xk7GWoGjd1J3QzJzJDcv4Dp1ObYgl8rro2/zm4GTODTYMzJyieLDcmIBrfCfmS49FkGIO/KSlO4+9MtWbhG8pWMAd1f6Q7OVv5ZuE4NWgcHpw6+zyin/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323508; c=relaxed/simple;
	bh=7JvcBNLvTKILv+2oRSTs3qORaMz002kR/mYNHZMo+bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWfnl74XjXbtPnksznhkdsyEXshVn1arRH9sOVoEnbWZW8qrn3hC79Z9FvQHhLUbIHZ+2r1j2SdkA8uj66XgSQeqR8/QQeyyzvt6NTg6lJ4ZT1tkpgJWOqXEQzkj9jKH062rj1MxGnF+VS02rIHHI7QVx8LA9opTYj3P0u3BHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjzaoxIP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjzaoxIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77081C4CEF7;
	Thu, 12 Mar 2026 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773323507;
	bh=7JvcBNLvTKILv+2oRSTs3qORaMz002kR/mYNHZMo+bc=;
	h=From:To:Cc:Subject:Date:From;
	b=PjzaoxIPK3VwaqE2fUDod5N6JD8PRIt8S6iU5yl3I6iaKHa5ZaL+5IQO9dqrCs/e7
	 mMC7GIBl+WNsjLYVC3mwaTFg5ySgzt1h85VJAUUTuNH1741Pgu0xnvDhs7w0mkwNRM
	 UrGoMj8k+T2dMYxSgrD42Io53BeGvtGwxXXuJs7gteVcg6eMkVeaMk1/qsEc5OaJkM
	 uC74Z9mYOTI0PAQk2CiahjAROGSPp2c3FZrQpSvb2GzrrCuh3ob1IvErrcozeYX+vT
	 cFvlm7hX12oE9H5zjUVSYeihQUVIK+owicrogd/Yv+sut6dbbwLRuwGVgsqq9DhVSj
	 zsghcoyLUULYA==
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
Subject: [PATCH v2] fs: Replace user_access_{begin/end} by scoped user access
Date: Thu, 12 Mar 2026 14:51:34 +0100
Message-ID: <9b8b9c7f7d533c96c0c1abe5b4aecb7dc19e2abf.1773306879.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8524; i=chleroy@kernel.org; h=from:subject:message-id; bh=7JvcBNLvTKILv+2oRSTs3qORaMz002kR/mYNHZMo+bc=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRuOvJMjP1FM1/rJIUM4SfHJ6xbd/TC+0I+Qe9z/6uDt HY7a+o87ShlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATWXuU4X9E46f7z1l1vzZu d1xTVvnPbXZyRa/iofeXP7R/TnyR2vuGkeFIR6vp/ik/zWtWtc/S/aRy1yBoD98tvR/LdqtM16v 64cgCAA==
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
---
 fs/readdir.c | 94 +++++++++++++++++++++-------------------------------
 fs/select.c  | 35 ++++++++-----------
 2 files changed, 51 insertions(+), 78 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 73707b6816e9..bd7bdf4a9840 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -198,18 +198,14 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
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
+	scoped_user_write_access_size(dirent, (unsigned long)(dirent->d_name + namlen + 1) -
+					      (unsigned long)dirent, efault) {
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
@@ -460,18 +448,14 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
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
+	scoped_user_write_access_size(dirent, (unsigned long)(dirent->d_name + namlen + 1) -
+					      (unsigned long)dirent, efault) {
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
+	scoped_user_write_access_size(prev, reclen + prev_reclen, efault);
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

