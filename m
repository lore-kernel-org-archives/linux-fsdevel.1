Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB048EC88
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055308; cv=none; b=BXYoPsSWmKYgdYjVvmJW89YpyWenvqyMcm1pYGhKHmNgaZrtmIsgy4biOTPXCK050VDnt5j2APHDY3g8PgEMPl+yNhLDjc+Jt4b4dU+KUGjwuZJMit7RlxMSdczkclITrhXk70job5O66N+BWwIY1/wwOc4dxc9E0aMwcUEdxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055308; c=relaxed/simple;
	bh=UruTJtRYw3bjA12dthvKdQsZJ8sUIE5HN7+PE2R2buo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2VP1qmfMi22MkSQl3YeLW6bkLTBgVXtjxoFsVrBmmq4PCseZwGQgEkpzzQ0GRPs7T2TU2LqVN4OUVll6p9fyN/mnX8v9HPd+uT5zvwBzQk305Al3CargbcuCXBmv6EHtyP5cXvL1fT/X0BpWdbnRPI5c7H+cj50hVDq0sgi4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfMKOAm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfMKOAm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015511F00893;
	Thu, 10 Sep 2026 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055307;
	bh=DluK9+pgAyV4IlAfefBa9uV0LjFpGavS3hW7dAHn7sI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XfMKOAm183eI6JOYuehrAONtnNlIzyOLHFETEsvl1U6NaJh+2CdSvM2zUBOODjx78
	 w12wy3Rg30NelFD+XSnoKhw4bAGT3OkmvNL1X6jamz8t35pw+oHC8tW6jfTmQKQtac
	 j4Sh4RsNzR67w9KXw5PTExuJd2qGTMkKXHXnPT5AfNoBBnYMLmB+z9xGwEGDFEKzzr
	 BHsJhM+y94JWJjgqYjtgBDzF8Ax7tNGg0xvi1zW8G41PsY03jwrnwE/F4u2dUyu1SV
	 5egaWLe8lamMHiVfUz3NIToK4VOV/ylKFqG+MR2K16rVe+cxOcE+OT5k/gfQu59TUc
	 WFaFrM+knaOuw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:01 +0200
Subject: [PATCH RFC v4 03/18] fs: move unshare_fd() to fs/file.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-3-a5c1800dc930@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UruTJtRYw3bjA12dthvKdQsZJ8sUIE5HN7+PE2R2buo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumjblqcuKqnQHyboGcV3rFzomOi15t9nX87uShHRm
 WBU/3F6RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERMkxn+2Xden2wjLfpIcSJ3
 oHVG4ozfrnzS+10c1gbdtDZMqTnrxchw3b2g+Xpes0nAuqmfnqccCf+xx23BxePZS066tj4yPnS
 FEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move unshare_fd() where the rest of the descriptor table lifecycle
helpers live.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 18 ++++++++++++++++++
 include/linux/fdtable.h |  1 +
 kernel/fork.c           | 18 ------------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 345011dad472..636a87e527b3 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -471,6 +471,24 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	return newf;
 }
 
+/*
+ * Unshare file descriptor table if it is being shared
+ */
+int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
+{
+	struct files_struct *fd = current->files;
+
+	if ((unshare_flags & CLONE_FILES) &&
+	    (fd && atomic_read(&fd->count) > 1)) {
+		fd = dup_fd(fd, NULL);
+		if (IS_ERR(fd))
+			return PTR_ERR(fd);
+		*new_fdp = fd;
+	}
+
+	return 0;
+}
+
 static struct fdtable *close_files(struct files_struct * files)
 {
 	/*
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 9614c6ecd477..4ee1598848bb 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -102,6 +102,7 @@ struct task_struct;
 void put_files_struct(struct files_struct *fs);
 void switch_files_struct(struct task_struct *tsk, struct files_struct *files);
 int unshare_files(void);
+int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp);
 struct fd_range {
 	unsigned int from, to;
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index 7c6fe82dbb9f..fddba55bbc14 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3207,24 +3207,6 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 	return 0;
 }
 
-/*
- * Unshare file descriptor table if it is being shared
- */
-static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
-{
-	struct files_struct *fd = current->files;
-
-	if ((unshare_flags & CLONE_FILES) &&
-	    (fd && atomic_read(&fd->count) > 1)) {
-		fd = dup_fd(fd, NULL);
-		if (IS_ERR(fd))
-			return PTR_ERR(fd);
-		*new_fdp = fd;
-	}
-
-	return 0;
-}
-
 /*
  * unshare allows a process to 'unshare' part of the process
  * context which was originally shared using clone.  copy_*

-- 
2.53.0

