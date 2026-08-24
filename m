Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2543E9FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585317; cv=none; b=IPuK2suQ5yk8w0Dz9CAkiZ86VdWgeKMNef9uubqpHlgOwxeVzlQaWh/BstDAUk/YwodFeHQMYjjS+Qq7bOTpuOV11ErgPf6t+k9l9sAJYhgEx6iSESO2oFtVKSwImfcq5VtsQldP3ydRAQAlaYFavmpU6LGn7Kv/m5oQMOAjFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585317; c=relaxed/simple;
	bh=wwqaQr9DV5pvtNqEjTVs5p5IqN6V55aiRcnvzvbl7ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a30G1O3ADvRwKWjZ9Skf3rltN5lnypK5zhoK7dfi2wnCP724sc3Fw6rPRWW19U2E8tOH3knLuZvm4vTgCPcnScQKzJSL/TPz/PwVJSDVMakkj8/A0Vc6L40By1vqq9NhJDe3klpKSwPlgn7PCQr1D0Y8DmO2DFNGrneZe0kQHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfh9tsXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfh9tsXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506171F00A3A;
	Mon, 24 Aug 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585311;
	bh=iGI04dIlgEnXrUcb8tAiwqm2lTK9mdXSGDMJEFszLIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kfh9tsXZxieupcqk98YjVmZxypjDGPNRCtk41Dgxfj17CJMb0AHJvkev9EofdXeXW
	 fJC/oFHClW8jL6wyqBqTEtSApEGQdC+ObmM1ndJULA8ja4y55Ac4ZFsR07jxaAlXCV
	 8qDUCEUbhQtkQwGdkDUnUEcm3PYsGeXfAraxy4FqY7LU4JDNUSRWUi2osAdMs94Sjc
	 1xLtJv4BjV01q5wM1v662sYh5oT8+4pwCFH7S150NquA1pKrOhXKi9rQvQjGrN8tq8
	 eU4hZwuXD9H/O9eOWdYQLjVPl3o2eccqymXl8Xdvf1lfw5mHgbEFYB5J6CDxNIWT8h
	 zNUedSK3GHQfQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 17:28:15 +0200
Subject: [PATCH RFC 1/7] fs: add filp_close_sync()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-work-coredump-unlock-self-v1-1-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wwqaQr9DV5pvtNqEjTVs5p5IqN6V55aiRcnvzvbl7ZM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1JEsdP85X4fiiRELkuc6pvS0pe3JU7k18xX7rtvjfw
 rX+598s7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI2UJGhsNWKo0TWtaEuS1v
 X2Ev+Gn3k0JZtxubZv68a9x8qlqhfx3D/xqt513b799hnLk/b+u06Gr7/VaTHPP4fPp7k3t29PF
 6cgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently close() already does a synchronous release of the last
reference since the task is about to return to userspace and the
deferral through task work buys nothing.

Turn that into a filp_close_sync() helper. We'll use that in one of
the next patches.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file_table.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/internal.h   |  3 ++-
 fs/open.c       | 39 +--------------------------------------
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index c68b8c0a4097..3c705917646b 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
+#include <linux/dnotify.h>
 #include <linux/security.h>
 #include <linux/cred.h>
 #include <linux/eventpoll.h>
@@ -606,15 +607,53 @@ void __fput_sync(struct file *file)
 EXPORT_SYMBOL(__fput_sync);
 
 /*
- * Equivalent to __fput_sync(), but optimized for being called with the last
- * reference.
- *
- * See file_ref_put_close() for details.
+ * "id" is the POSIX thread ID. We use the
+ * files pointer for this..
  */
-void fput_close_sync(struct file *file)
+static int filp_flush(struct file *filp, fl_owner_t id)
 {
-	if (likely(file_ref_put_close(&file->f_ref)))
-		__fput(file);
+	int retval = 0;
+
+	if (CHECK_DATA_CORRUPTION(file_count(filp) == 0, filp,
+			"VFS: Close: file count is 0 (f_op=%ps)",
+			filp->f_op)) {
+		return 0;
+	}
+
+	if (filp->f_op->flush)
+		retval = filp->f_op->flush(filp, id);
+
+	if (likely(!(filp->f_mode & FMODE_PATH))) {
+		dnotify_flush(filp, id);
+		locks_remove_posix(filp, id);
+	}
+	return retval;
+}
+
+int filp_close(struct file *filp, fl_owner_t id)
+{
+	int retval;
+
+	retval = filp_flush(filp, id);
+	fput_close(filp);
+
+	return retval;
+}
+EXPORT_SYMBOL(filp_close);
+
+/*
+ * Like filp_close() but without deferring the release of the last
+ * reference, see file_ref_put_close() for details.
+ */
+int filp_close_sync(struct file *filp, fl_owner_t id)
+{
+	int retval;
+
+	retval = filp_flush(filp, id);
+	if (likely(file_ref_put_close(&filp->f_ref)))
+		__fput(filp);
+
+	return retval;
 }
 
 /*
diff --git a/fs/internal.h b/fs/internal.h
index 355d93f92208..7ba8cd26a698 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -127,7 +127,7 @@ static inline void put_file_access(struct file *file)
 	}
 }
 
-void fput_close_sync(struct file *);
+int filp_close_sync(struct file *filp, fl_owner_t id);
 void fput_close(struct file *);
 
 /*
@@ -190,6 +190,7 @@ struct open_flags {
 	int intent;
 	int lookup_flags;
 };
+
 extern struct file *do_file_open(int dfd, struct filename *pathname,
 		const struct open_flags *op);
 extern struct file *do_file_open_root(const struct path *,
diff --git a/fs/open.c b/fs/open.c
index 408925d7bd0b..d036736d5d43 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1453,41 +1453,6 @@ SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
 }
 #endif
 
-/*
- * "id" is the POSIX thread ID. We use the
- * files pointer for this..
- */
-static int filp_flush(struct file *filp, fl_owner_t id)
-{
-	int retval = 0;
-
-	if (CHECK_DATA_CORRUPTION(file_count(filp) == 0, filp,
-			"VFS: Close: file count is 0 (f_op=%ps)",
-			filp->f_op)) {
-		return 0;
-	}
-
-	if (filp->f_op->flush)
-		retval = filp->f_op->flush(filp, id);
-
-	if (likely(!(filp->f_mode & FMODE_PATH))) {
-		dnotify_flush(filp, id);
-		locks_remove_posix(filp, id);
-	}
-	return retval;
-}
-
-int filp_close(struct file *filp, fl_owner_t id)
-{
-	int retval;
-
-	retval = filp_flush(filp, id);
-	fput_close(filp);
-
-	return retval;
-}
-EXPORT_SYMBOL(filp_close);
-
 /*
  * Careful here! We test whether the file pointer is NULL before
  * releasing the fd. This ensures that one clone task can't release
@@ -1502,13 +1467,11 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	if (!file)
 		return -EBADF;
 
-	retval = filp_flush(file, current->files);
-
 	/*
 	 * We're returning to user space. Don't bother
 	 * with any delayed fput() cases.
 	 */
-	fput_close_sync(file);
+	retval = filp_close_sync(file, current->files);
 
 	if (likely(retval == 0))
 		return 0;

-- 
2.53.0

