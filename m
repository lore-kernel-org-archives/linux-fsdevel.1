Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F604A9D45
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364737; cv=none; b=aw1IigC4m3jx4oPxVRpAZr9iKwq2jwnOD5YclYRmxht88iKUXULs3by1WumeBcySDXaThm3L+FSXPlMFn76LnpcrqukqYlNPOlLf4vNvgPglBTTELV1UFFpHiahVYLX5zFL4bEgJHO1KCi4UxBmTLByiAakRrnyf1XuEUKzlsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364737; c=relaxed/simple;
	bh=1tiMBiD28ukwax9AezsINPBMCjl/2B+T1JR2eDp2WrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DV3Aim8HIoIxIGzgGxlgCrUF/eAVOdvZ7NnmMRURBPejYjKsVa9f8T84ykZMqRRrECp2/mUGfKRsiDYOZIQtgyN6vQZyM8iOCQj/xNJ5DhZaVZ2hYcMSMh72jgU3gvhRCYRa3WqO77c/1CkWA6xa6gz7Dz1y9Dv4aqbiOvR2sdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvemvbKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvemvbKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04AB1F000E9;
	Wed,  2 Sep 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364735;
	bh=mWYDhUMH59K4T5UEnxQDhyXuXlQpLfdqUBbzm11qX4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mvemvbKL/vxKdx0pVUc+vyyhnm+L0yUWnUIehA4wnHqR9O4xD40VkZTVeAeKlCOAH
	 GzRVq2RKIEcGPDlzzzju/9nT9yOBnT8mmZ7qSibFDcvMgsJVOL4AYRLiu0k71Bzcze
	 s4gKPX2trbDQ+JWT8KXTAJXfmK7L0i3Gy07CvhudwWUJ1i0Z+ag7cuOSCxJaWsmoSU
	 U5QifU0F+lucjHTAsvfwEarn0GrIrXtCjrnkWGgw4q+xdMV0xPw+xFyiEfc0JoA7qL
	 tKGdr38wV+jR4PArRZByjiVyF1g9WoLtv6Oyvf7nKYccFGRer81sq6FjFVx3JWY3/X
	 /4rtGjbnUsrmQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:24 +0200
Subject: [PATCH RFC v2 06/16] fs: move unshare_fd() to fs/file.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-6-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1tiMBiD28ukwax9AezsINPBMCjl/2B+T1JR2eDp2WrI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF/RPNd6r7LOaTknp6uuxg0Prlt9fsC6+an6JFn3B
 v24v/a/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby/Rkjw2N5jmVb2ZY6Ldqh
 xn1I7/F5jxuJWpPiTxUH3bwkdDWgyoGRYVnGCqu9l2ZMcHBdGC3qtzLqR7ZU1rPkruWJfYGK2Uc
 dWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move dup_fd() and switch_files_struct() where the rest of the
descriptor table lifecycle helpers live.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 18 ++++++++++++++++++
 include/linux/fdtable.h |  1 +
 kernel/fork.c           | 18 ------------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index aec2adf59031..185de8deb39d 100644
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
index 80f192412a5a..102fe4c20b7d 100644
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

