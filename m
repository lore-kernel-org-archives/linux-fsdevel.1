Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219E57982C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969185; cv=none; b=qDsbz6gq5GzTKPprTo/SR6xivAoh3PnkHjHP0mf5fbM3wnFQbIZ8igJscmTOEIFSeWlAreSckeO5DNdOH1+gS3tdDggpq7Nl0PnZwP92P+SBuQ6WmxUnm200fa8hB/Js4GtfcNW7ox3ZokevjRobmk5ZseLaZsdVkbMTJd4jrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969185; c=relaxed/simple;
	bh=Sg4l5niiNn7WFqPgMNaD9aBR6VyhLIlC/5pTsno4dWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFXPLXyvU1tY2o1/KJGDCh6jZ4VemJELy5/9slX5eFTU+6VneO8CJAhe84tQP5B8wqZmD9b2UAyfsED7sYUjKQKSSIXFyZbWvZgvI+SmUB7KQJeTgz7Pl93o4Ax2T1PAxV3/dLeZPuXsDXVvDjmOwvmyfLo1h6oq2Ar6IYTTuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHBRa2VX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHBRa2VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3B91F00A3D;
	Wed,  9 Sep 2026 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969184;
	bh=x4IgTQRQTDWCZPVJqf7rI88csj9gaRQymiw+YMJssNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bHBRa2VXskcZ69XsFCJpcDopHxU0tz/Rt/X5SJZN3tkrDQdg8+Gp9KxHWWaOaPTkN
	 dkM/RlCkCX3204u1osjWCn1wUN0nM1J77SR9CBiC/ctXXN2twvArbTclLpOKOI8vnu
	 mB4PGhrRipddgz5ZwyGMyCZYpZ1ototQLyc7FCh5N+Ruf/QR0TJpxNnTyUmSk0k554
	 yF+XO+1hm8q1RKDIo5b0yh3kp4qnYLv608P3U53/TEN7gnULWP6+uAQycsEgzMtE2d
	 p0JPu1pLOEExsIvrr3mk8nL8wLA62l79OvHgc8M1y4UQ3lAJtBHLyani7Pwa/rFymA
	 6V9/cJUzXcW3w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:45 +0200
Subject: [PATCH RFC v3 02/15] fs: add switch_files_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-2-04f907687563@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2828; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Sg4l5niiNn7WFqPgMNaD9aBR6VyhLIlC/5pTsno4dWA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLiqHOd/0Uz/4bu+nH8L+myPrOHgn7DjBN9L4dVZH
 YrBfP4fO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZidoPhn0YtyzKV3MPnQzx3
 z7eSu71ZR7XW9EF7ZvL//zm+nf8WFTAyPO9pKQouarCqzp+nqbfswfJvXoanjpy5FPe65gbHtYe
 S3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add switch_files_struct() to install another table on a task. It
consumes the reference to the new table and hands the old one back for
the caller to put. Convert every place that switches a descriptor table
except unshare_files().

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 28 ++++++++++++++++------------
 include/linux/fdtable.h |  2 ++
 kernel/fork.c           |  6 ++----
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 59673547de90..fbc247bd7896 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -515,16 +515,23 @@ void put_files_struct(struct files_struct *files)
 	}
 }
 
-void exit_files(struct task_struct *tsk)
+/* Install @files on @tsk, consuming the reference; returns the old table. */
+struct files_struct *switch_files_struct(struct task_struct *tsk,
+					 struct files_struct *files)
 {
-	struct files_struct * files = tsk->files;
+	struct files_struct *old;
 
-	if (files) {
-		task_lock(tsk);
-		tsk->files = NULL;
-		task_unlock(tsk);
-		put_files_struct(files);
-	}
+	task_lock(tsk);
+	old = tsk->files;
+	tsk->files = files;
+	task_unlock(tsk);
+	return old;
+}
+
+void exit_files(struct task_struct *tsk)
+{
+	if (tsk->files)
+		put_files_struct(switch_files_struct(tsk, NULL));
 }
 
 struct files_struct init_files = {
@@ -855,10 +862,7 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		 * We're done closing the files we were supposed to. Time to install
 		 * the new file descriptor table and drop the old one.
 		 */
-		task_lock(me);
-		me->files = cur_fds;
-		task_unlock(me);
-		put_files_struct(fds);
+		put_files_struct(switch_files_struct(me, cur_fds));
 	}
 
 	return 0;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..0f2edec45de0 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -100,6 +100,8 @@ static inline bool close_on_exec(unsigned int fd, const struct files_struct *fil
 struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
+struct files_struct *switch_files_struct(struct task_struct *tsk,
+					 struct files_struct *files);
 int unshare_files(void);
 struct fd_range {
 	unsigned int from, to;
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..b959191edf52 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3320,10 +3320,8 @@ int ksys_unshare(unsigned long unshare_flags)
 		if (new_fs)
 			new_fs = switch_fs_struct(new_fs);
 
-		if (new_fd) {
-			guard(task_lock)(current);
-			swap(current->files, new_fd);
-		}
+		if (new_fd)
+			new_fd = switch_files_struct(current, new_fd);
 
 		if (new_cred) {
 			/* Install the new user namespace */

-- 
2.53.0

