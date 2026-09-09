Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07A57982C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969188; cv=none; b=tB1Nd/e8i4gJQumkRiPWOvtcvAmL+qqK1BcLfnMZk/UNBQlLUVULP+e+QqLzL4eYi/TbN672hspttm8KPcXlrEO6OOE7817KZR22qjSaacXJ61Bam3u937ys/x1I5IjO6BpEBQBwCTanSyIuS9pvhGiXbxj8dSc+oz5mxeZc4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969188; c=relaxed/simple;
	bh=seUKL4baZQl80bACe5x3GNBsLFNla2y8zOYnea220GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjJAaLNOv2i2Hv5MQwKkNmrZQkJualPtTl3+yLSwal7mytf1vuE5k/yguebS5VeYP5rbSaVZsEcDRQW7ohApKGyWJwfsEU24ngwyTOJlCdpF7Wjihsyefa9APSlrs+gkhrtImWOHuuiRjuR+LQ44mFTf9NVeGoxUSJgytK9pTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDYLCHsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDYLCHsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C02B1F00A3A;
	Wed,  9 Sep 2026 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969186;
	bh=MqClb4Div+/vJEICsaMQiffcrKS//ucL7IiO/cYr6j8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mDYLCHsMW+6ZD3rUpD8Tz9W/TIEVkwfMjsA+k7m+gCZcog0GuzcM8MWXERAZqYuMx
	 4U9LhxsTU12nyb5KUUYENLKlxIpBUPly6rqeee8fjVy//MVwdxjmaXp3dlvBqsnRDF
	 G6Pp4UUjI9fQ8ksiHrZrgnuOQlFRe/0BUwV42Jru//lHmXhaIOEW8GJ7qXABY/XY3h
	 PPIFOFOMXMQquEDVmBGjmo7CBdpfAnTAbI3EC31CcQrXPwF0i0ZfIyyGi4M9lBPyK2
	 DVyDINP69T+P8DbYYc7LjVCt10X4jUw3E+pkcEkzDlAqwC7eGepwTrVv8l8//StaRE
	 6kJasBH7AnEdg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:46 +0200
Subject: [PATCH RFC v3 03/15] fs: move unshare_fd() to fs/file.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-3-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
In-Reply-To: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386; i=brauner@kernel.org;
 h=from:subject:message-id; bh=seUKL4baZQl80bACe5x3GNBsLFNla2y8zOYnea220GY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLia6p6w7eoVh7dRwjKZiXP2Mf/xmWzSeiHFkSHzo
 Pfvs7u6O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayhZfhN8uK8AuG+/N6b36c
 K5BRoZHvPPFeouEFnp7Zjg9YT7zaZcvIsLn3qbX65os+m8tlHrzlyVm214xjs8B2u+9MHOUMp7R
 usAMA
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
index fbc247bd7896..a527183dc664 100644
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
index 0f2edec45de0..25af1386abbe 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -103,6 +103,7 @@ void put_files_struct(struct files_struct *fs);
 struct files_struct *switch_files_struct(struct task_struct *tsk,
 					 struct files_struct *files);
 int unshare_files(void);
+int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp);
 struct fd_range {
 	unsigned int from, to;
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index b959191edf52..c456958c51f4 100644
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

