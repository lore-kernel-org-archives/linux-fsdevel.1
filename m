Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3ED4AA006
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364734; cv=none; b=hcfDElvDl/KvP12Az3+jM4MhrdVKZtaqOae4xBWUScwuYhrNNlFPMWRb+Y/tlvn2PlJS6hvAI3Q2FTw2yTunLPXSJ53LWoX0wRw2XwkAlThFziKX7ONroLnU8J/oA7vAduU44itrRcEIZGYn6Uecyd8D1uMbip+ZG3UkYzi4Rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364734; c=relaxed/simple;
	bh=4d91SfmeI4y09Xpisb6TQwG0iWJY+Dn0H1Z07o8e5RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdXlmdCyZUzbB9RzBk3lim5SrE5IhCtJj98DT4jhAr6RvjpF0PEIStK74P84+WgLcme/Z4q9dKllxqnxhi/umURUjhOI7IYd47xYSCs6f1uZeo83YC+OyOGq2FaFhF1287eBZNc2sZdX3beGefpVLYrxpNsIwx4GC8SNToA7Z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JumB1KBA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JumB1KBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B34F1F00A3A;
	Wed,  2 Sep 2026 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364732;
	bh=A7Nj1zCd/AB7+KBhfoL4GR8/IK/BFgx6d+8RvLyXWGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JumB1KBA2gdnzvMudWx2Yee/RqejjiGjZ/29tH4bDo/Pjx4fWyc6bgj+mjc352euy
	 hjnm5S12fK45x2yrFJG7/EWu4/2bxkE33RPoWT7d/KjypZRF26AYYy/TECjV6LrYQk
	 7WhtKcsUlqxrvIu4B36iE2+pmg/UCT7PnWOfvsYCdTon2v73VUxpsIdlMjgd5gHYtq
	 iXM8enPGQNil7Ss/sJPs8WUHMjBEpS7qftfB6oU3tq8YWgw9ErXNchZxj8MVWN7txa
	 6aZMEOJfffH6+vwhlyCQgFcJYGeC1aMWoU2QhxDEwgtRNQjLQfaxPWWyAjUQSXXqUJ
	 AodabtMilW2Cg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:23 +0200
Subject: [PATCH RFC v2 05/16] fs: add switch_files_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-5-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4d91SfmeI4y09Xpisb6TQwG0iWJY+Dn0H1Z07o8e5RY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF/xOsXQ1bw8gfHT37rDZmeXVXf9ZVObU6HAn/tIj
 itxMXNqRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET6ExkZnmju4zysrSHvFWKT
 6uCV37rkS9TxPwZcc77srvzb++XYC0aG49KPPNf+ncuTlKtuwncx+Mt9xlSLNTLTIjScTqYy77z
 PCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add switch_files_struct() to install another table on a task. It
consumes the reference to the new table and hands the old one back for
the caller to put. Convert every place that switches a descriptor table.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 28 ++++++++++++++++------------
 include/linux/fdtable.h |  2 ++
 kernel/fork.c           |  6 ++----
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 88ede1262b3e..aec2adf59031 100644
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
index 050f4a04157e..80f192412a5a 100644
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

