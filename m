Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E238F651
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055314; cv=none; b=WjGEuWzHMerG68ct07miLv4LC5k+HESjQfgJb0YQSB+mhb2NPBxODK+mAOYimeVFBfJGJJK8QK5Zif7SHfrHj8P2sXXy0o06rJW5XB9+cVxdxXVUc4qgGYEMO0i6XWhbQLdH2iX9BWiSKoDiyVfT6avxb9phYlrmDQP8tHDxfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055314; c=relaxed/simple;
	bh=b32lmMKncNOmG+WheXILOMZ4OyNB1cgTVt5bTc016Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVJ1w2UWBiaKlsnQe9jTsJt6O9sqILOxnzzkO7SXmd9VrCBI/5swcgouT2piFiKvuIb9V7/0WyxM1Dkby7nyphawmGeamBMJH7lWSDmiBgWPGFYFw+QAfk9IMLkds0LTSuyY7cNKvWgAhLzik3+l3QsUK83cIH1Tn9fMsA/WGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3cpHFRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3cpHFRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBFA1F00893;
	Thu, 10 Sep 2026 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055312;
	bh=0rMp3Udi9crq9QDvGtG+jnsfPPoSnxR8dm2bejGt75A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A3cpHFRH/MB+IrR4VX2M0Ih20rFukZi3KCGYIxqX5tyGGOqBlcCuiu1DPIian2DOB
	 354JUPVhCe/WTtTUQI+4MwgWaC035M7+tc3W4AK5qcprXYlGjGcfVL2suH/OVTKqyi
	 uvZnP/3UNWSN7wy9KBNmuX1ZVRRfl0ClB/qYnddHccz7hz3zoyrcqw0e9pofimT80z
	 mF/MzF+DanBrTonGE81luUWCyWEIhLvPwtJGv/1p54OxSK17H3pkUQwP6I6OvWcJ96
	 8+/XIOB9I9VUlfuG9BnCAOUeRBq35ojvaZNcNo/AMOWN8BTnO+7RiSN9y3saD1RMoY
	 mN4zzREw7kofA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:03 +0200
Subject: [PATCH RFC v4 05/18] fs: add filp_close_sync()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-5-a5c1800dc930@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2185; i=brauner@kernel.org;
 h=from:subject:message-id; bh=b32lmMKncNOmG+WheXILOMZ4OyNB1cgTVt5bTc016Us=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumgro+WZqcG05NflpUnXAw59+cGh/cPzr/T7l2++J
 5/abh2wvKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiPr0M/+P2PJGyf7r6cWFr
 5GWzD1+zJKV8jTS4G/2EF3xReHZtgzUjQ6cdm9L+o5sSwrwCvnfn//eOeHP+LMt5hvbGtNyzqc5
 MTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently close() already does a synchronous release of the last
reference since the task is about to return to userspace and the
deferral through task work buys nothing. Add a filp_close_sync() helper.
We'll use that in the next patches.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/internal.h |  1 +
 fs/open.c     | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..8812de210d3f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -198,6 +198,7 @@ extern struct file *do_file_open_root(const struct path *,
 extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
+int filp_close_sync(struct file *filp, fl_owner_t id);
 
 int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
 int chmod_common(const struct path *path, umode_t mode);
diff --git a/fs/open.c b/fs/open.c
index 6b1c14e684a9..998e42ac319a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1537,6 +1537,19 @@ int filp_close(struct file *filp, fl_owner_t id)
 }
 EXPORT_SYMBOL(filp_close);
 
+/* Like filp_close() but the last reference is put right here. */
+int filp_close_sync(struct file *filp, fl_owner_t id)
+{
+	int retval;
+
+	/* Kernel threads must never put their final reference here. */
+	VFS_WARN_ON_ONCE(current->flags & PF_KTHREAD);
+	retval = filp_flush(filp, id);
+	fput_close_sync(filp);
+
+	return retval;
+}
+
 /*
  * Careful here! We test whether the file pointer is NULL before
  * releasing the fd. This ensures that one clone task can't release
@@ -1551,13 +1564,11 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
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

