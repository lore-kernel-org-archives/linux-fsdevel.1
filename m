Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23744065E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289357; cv=none; b=JkLP66fmcS9Q5hmB9QTCbMlEEUGWnP9IveW0BFly9mnT8t2eWOllM98VCR1VkP55pPbO2hMxUGnS+5OoJUsSCZoThYLSBwFJx8/FUppHdSZrx4/Ulntj27eiEh1ZNaG+eJs2hKen4ugyj1Ma1WhaqYqeNBd7msKGLURFaQv6Mt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289357; c=relaxed/simple;
	bh=cOB4QzfwSZe7pLLndzedllByWC9zyzZ7ASz5yf3/ucA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpzqMaETyu99Z+NUHihv45PrYxheo4AIGnLOB8heGln8dIaVcNr5osHCcMCa/hVv6qDlfE6J7l+rBOplX+5DH25QXH8IJG/Bh2F9fMWWOCQytmW3hop4x+bgJUwJ0U1T5v1dDpVWQpOfL5jQ6I2Dysk5VCyRHT6ZUs0PWWNHeKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyeNtMvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyeNtMvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EBA1F00893;
	Thu, 24 Sep 2026 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289356;
	bh=y6sxcTrxihYzcRE1Dz6fLCgST/r9uqPniwYuRH5nD+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KyeNtMvm0SsRDCOrPeuLq6jM5abimdZwY4hf2lKCg7olcqkQORBaoFsN78QahAe6K
	 7Kd9FGJJbvV/xeEN7UJrzUAp7WsnOIbDFwDOWXEmUvs3u5xFOgZKBymtYXyStKdzbZ
	 IfpRiT+vfAyD7yu9tLCPw7hYkOXBUDmzoGMUVf/TGhfNwf/HpKol1WFjM4M02D26va
	 TZSzdvGqHZ1BkmnPGEDPLYIW+rsttSC/WnePiP6H42EwGUhgLb5k0J5bGPb1yhDygg
	 SXGAT80BnLlCBI02wIJtjHmCCa1OyBJi7Pgl8htb87B2RFAHNC9wrvu9bmqHDARQO2
	 XYqz3k69wtT/w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Sep 2026 00:35:44 +0200
Subject: [PATCH RFC v2 4/8] namespace: drop the file's reference first in
 dissolve_on_fput()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-work-mount-knullfs-v2-4-c4aebaa186e9@kernel.org>
References: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
In-Reply-To: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cOB4QzfwSZe7pLLndzedllByWC9zyzZ7ASz5yf3/ucA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtXXog9FFg8c0dEumve/UqPboXbg0XXxYtrPdkzptVO
 v5Jn1OZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayQI2R4QXT2eOFS56avd9j
 vj2jdJ7r/vzYGW/Evu4J7J2TPcf1hzYjw8d2O+PAhPM/dpskGTr3PU1x175s4lKmlFeYMWmDw5N
 mRgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A detached mount tree is held alive by a file. dissolve_on_fput()
unmounts the detached tree attached to that file.

Currently dissolve_on_fput() leaves the file's reference to the root of
the tree to the caller. So either __fput(), open_detached_copy(), or
fsmount() drop the mount.

That's backwards. The reference keeps the tree around and is dropped
when the tree is already gone. Instead, let dissolve_on_fput() the mount
and drop it after umount_tree() with namespace_sem still held. After
umount_tree() the mntput() is never the last reference and so the root
gets unmounted before its children.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file_table.c | 3 ++-
 fs/namespace.c  | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index c68b8c0a4097..e2665eaa6f8c 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -520,7 +520,8 @@ static void __fput(struct file *file)
 	dput(dentry);
 	if (unlikely(mode & FMODE_NEED_UNMOUNT))
 		dissolve_on_fput(mnt);
-	mntput(mnt);
+	else
+		mntput(mnt);
 out:
 	file_free(file);
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index 580877e46b1a..4ff3cebe6c31 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2294,9 +2294,11 @@ void drop_collected_paths(const struct path *paths, const struct path *prealloc)
 
 static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
 
+/* Consumes the caller's reference to @mnt. */
 void dissolve_on_fput(struct vfsmount *mnt)
 {
-	struct mount *m = real_mount(mnt);
+	struct vfsmount *p __free(mntput) = mnt;
+	struct mount *m = real_mount(p);
 
 	/*
 	 * m used to be the root of anon namespace; if it still is one,
@@ -2321,6 +2323,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 		lock_mount_hash();
 		umount_tree(m, UMOUNT_CONNECTED);
 		unlock_mount_hash();
+		mntput(no_free_ptr(p));
 	}
 }
 
@@ -3088,7 +3091,7 @@ static struct file *open_detached_copy(struct path *path, unsigned int flags)
 	path->mnt = mntget(&ns->root->mnt);
 	file = dentry_open(path, O_PATH, current_cred());
 	if (IS_ERR(file))
-		dissolve_on_fput(path->mnt);
+		dissolve_on_fput(no_free_ptr(path->mnt));
 	else
 		file->f_mode |= FMODE_NEED_UNMOUNT;
 	return file;
@@ -4545,7 +4548,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	FD_PREPARE(fdf, (flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
 		   dentry_open(&new_path, O_PATH, fc->cred));
 	if (fdf.err) {
-		dissolve_on_fput(new_path.mnt);
+		dissolve_on_fput(no_free_ptr(new_path.mnt));
 		return fdf.err;
 	}
 

-- 
2.53.0

