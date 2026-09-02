Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220254A99A8
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364726; cv=none; b=CZuskCwlFpTvu+S0knMi60Hid4xBMzrG7YaoiSrEpbUI93XvTQvP/dMr2SsR3A/0VXvO4uNrvyYctAzrUTDC1jAzWhPl54BcHXAKT0Iqfyp4/pYz4Sg5N5KZ2BfjBJeLuNmHyVMooththnH2WF4qSsp3qeXZSLYl8yCdiJfvzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364726; c=relaxed/simple;
	bh=CF5a4LQk8LryDAEchLHYUqNlMP5ZPULYJgPqZDN3RsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Clph+UC5lZ48G3l6pnNPLlyLlocAMo7htiL0z7ud63g7Ic2ECv+JhjNagxyXKXGALU/t5w3Mm/jev+PwwFIZ84ZCU5QKNZHSsoA4ANC1bFsnDqhMy08WHqfcutGdslAyXbi5LnO9F+UJZE8YriarsyFpjqJ//aeqHjR6HWTfM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Br6vYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Br6vYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806D81F000E9;
	Wed,  2 Sep 2026 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364724;
	bh=B/Vh1KDHDGHALQubSqpR7V++aiEsRq2v/HQK3m84/z8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O4Br6vYMXidSk3mxmZPoEPMA+fh8C0b3t2KjYjwVYPO6GqS9Tx9+L+Qa6nhFfZEOM
	 KnAZWNwhrJ0RyuNs0BKsbYcIpFLUqUT2/JbXMhnSSr1fU3je0LX8Ur4WrXd/JkleGu
	 hRJy74psFlCcqN9YS0/NA37d6MWe6+GeZiera2WzfyjnmcX1+0Yz7L+KTBaeNqNnVw
	 sQXY4M9pKQ/FPB+EBz3RXKfOjYg/ytWr3FwsNZS+ls1rJD0XIvU67rFfUQhHbynMD5
	 +YpwROcmq5RHTWqgbAsgB0afkN9EQQlVY0YOnGwIzBZjBcpjckwEEGC3yS0rlcO7t5
	 R9+6psW8mq99Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:20 +0200
Subject: [PATCH RFC v2 02/16] fs: add fput_close_list() and fput_list()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-2-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3182; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CF5a4LQk8LryDAEchLHYUqNlMP5ZPULYJgPqZDN3RsU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF/OM/esTei+k552AbH7CrSumCYYh32c7fthdo/WV
 Yuaa0/fdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk80NGhnsTt0xvnnatwOyf
 2NcP8/V7NXPXdf5f/rCaqfn6qRfPSj8xMvSznNzLc1ZxrrPFlJYjyiJ9KbfvBsxWvZrV99fgy4e
 J/1gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add helpers for paths that close many files in one go. They collect the
last references during the walk and drain them right after

fput_list() runs the final __fput() for everything on the list.
delayed_fput() shares that loop.

We'll use that in the next patches.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file_table.c | 25 +++++++++++++++++++++----
 fs/internal.h   |  3 +++
 fs/open.c       |  2 +-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index c68b8c0a4097..617912ca4e0a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -528,11 +528,10 @@ static void __fput(struct file *file)
 static LLIST_HEAD(delayed_fput_list);
 static void delayed_fput(struct work_struct *unused)
 {
-	struct llist_node *node = llist_del_all(&delayed_fput_list);
-	struct file *f, *t;
+	/* Detach the shared list once, then drain it like a private one. */
+	struct llist_head list = { .first = llist_del_all(&delayed_fput_list) };
 
-	llist_for_each_entry_safe(f, t, node, f_llist)
-		__fput(f);
+	fput_list(&list);
 }
 
 static void ____fput(struct callback_head *work)
@@ -629,6 +628,24 @@ void fput_close(struct file *file)
 		__fput_deferred(file);
 }
 
+/* Like fput_close(), but the last reference goes on the caller's @list. */
+void fput_close_list(struct file *file, struct llist_head *list)
+{
+	if (file_ref_put_close(&file->f_ref))
+		__llist_add(&file->f_llist, list);
+}
+
+/* Run the final __fput() for everything on the private @list, right here. */
+void fput_list(struct llist_head *list)
+{
+	struct file *f, *t;
+
+	llist_for_each_entry_safe(f, t, __llist_del_all(list), f_llist) {
+		__fput(f);
+		cond_resched();
+	}
+}
+
 void __init files_init(void)
 {
 	struct kmem_cache_args args = {
diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..619eaeb23fd9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -129,6 +129,8 @@ static inline void put_file_access(struct file *file)
 
 void fput_close_sync(struct file *);
 void fput_close(struct file *);
+void fput_close_list(struct file *file, struct llist_head *list);
+void fput_list(struct llist_head *list);
 
 /*
  * super.c
@@ -198,6 +200,7 @@ extern struct file *do_file_open_root(const struct path *,
 extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
+int filp_flush(struct file *filp, fl_owner_t id);
 
 int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
 int chmod_common(const struct path *path, umode_t mode);
diff --git a/fs/open.c b/fs/open.c
index 6b1c14e684a9..7181665c3af5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1506,7 +1506,7 @@ SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
  * "id" is the POSIX thread ID. We use the
  * files pointer for this..
  */
-static int filp_flush(struct file *filp, fl_owner_t id)
+int filp_flush(struct file *filp, fl_owner_t id)
 {
 	int retval = 0;
 

-- 
2.53.0

