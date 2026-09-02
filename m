Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B94A99DE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364732; cv=none; b=mTb49A3xPMPYhN6AZaLpaFVGz+cdZ1WkCqejez1frL8ru2j+ZTNYJs+C/DMogeoksOW757JL2xxEzvMiGkPHiewyaqj3DV+mOP9DGAO5lC4tgboYGHAuMm/kxNQ71/OtheTpWa9EhAk1WlBolhyz0+evbo/Mlm7pMFvI9Whohu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364732; c=relaxed/simple;
	bh=6d5tK4vp71L8cD9PZeEvhsxQm8G5YTSPMdjt3tdjvUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T06m3n8qmidHv44B28ulgyNz8tuhT8V7G5oYGUhanbZHw+BfZ0IsvudTHd0+NQyoR//GbYxQ9xvaVlHxoXosK7H4wTrrnWTEl7hyXUtnw588ivavpVqhvEf/R/keIvLsOuhgVURjG5tYugbXDll+vfsSvoGAL7TN3XgtK6ghPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iib3jW1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iib3jW1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A241F000E9;
	Wed,  2 Sep 2026 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364729;
	bh=U2hDErg3OB4EPAEqCk9buzYDsFRtnDsnf2hw9ywLZw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iib3jW1e/8P0jwgBzunZfVc7BpIvUpUx485bQkVUtW3DzpD02M0R2hi0spAEHGO8r
	 St/K1WibvB8dNAHLAp1xK4mdRwQ+Pi0c93F/x/FTFp4bFTjE+lxHfU2SpO8TrjDM4/
	 RPAU6+FdDwTuSRZqmVWhfiowI7XkBme/ECPiPaWYEEiaiw9vRE6iHmJkQKHVL/QRku
	 4PNnPMw6/P0FisXFM0lryzBGLbq/s+iW1EBxEYxC1WezQfsg5j6zVR+9wWNb8gUFvO
	 zuZQ+xCbQYPv0hgqM4P1OgQsQ/LzWh3pExvEsoGqQOL/n5gEA+adVMiEXc7hNN5ee/
	 pFPOuX86+9AFA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:22 +0200
Subject: [PATCH RFC v2 04/16] fs: defer the final fput of close-on-exec
 files past the exec locks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-4-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3458; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6d5tK4vp71L8cD9PZeEvhsxQm8G5YTSPMdjt3tdjvUU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF+xZH+h7OKu32c/hnF+5eYoE29K4yhj9v5U8E1qN
 b/jXbmPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh92NkWKZ97eCbu0G3r7n2
 lPJwPrxp4yuoeHo225aMK1Yr+KtVFBn+R1Yqvvd69sip47T3fBXbVBPjG/fdeJ9/+JnrYaD8470
 qKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Taks with lots of file descriptors pay a hefy price for offloading to
task work. Port them to the fput_list() mechanism instead and waste
files in free_binprm().

Link: https://lore.kernel.org/CAGudoHGRvxd-EwwDasqoVhk5VbEvhtjjM7kCXBfFyQ8ykeC9CQ@mail.gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 4 +++-
 fs/file.c               | 6 ++++--
 include/linux/binfmts.h | 4 ++++
 include/linux/fdtable.h | 2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 92a02bce11d5..b1f449dba258 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1220,7 +1220,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * trying to access the should-be-closed file descriptors of a process
 	 * undergoing exec(2).
 	 */
-	close_cloexec_files(me->files);
+	close_cloexec_files(me->files, &bprm->cloexec_files);
 
 	if (bprm->secureexec) {
 		/* Make sure parent cannot signal privileged process. */
@@ -1469,6 +1469,8 @@ static void free_bprm(struct linux_binprm *bprm)
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
+	/* The exec locks are out of the way now, see close_cloexec_files(). */
+	fput_list(&bprm->cloexec_files);
 	/* exec swapped the mm but failed before setup_new_exec() freed it */
 	if (bprm->old_mm)
 		exec_mm_put_old(bprm->old_mm);
diff --git a/fs/file.c b/fs/file.c
index be06e09df41c..88ede1262b3e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -884,7 +884,8 @@ struct file *file_close_fd(unsigned int fd)
 	return file;
 }
 
-void close_cloexec_files(struct files_struct *files)
+/* The caller drains @list with fput_list() once it dropped its locks. */
+void close_cloexec_files(struct files_struct *files, struct llist_head *list)
 {
 	unsigned i;
 	struct fdtable *fdt;
@@ -911,7 +912,8 @@ void close_cloexec_files(struct files_struct *files)
 			rcu_assign_pointer(fdt->fd[fd], NULL);
 			__put_unused_fd(files, fd);
 			spin_unlock(&files->file_lock);
-			filp_close(file, files);
+			filp_flush(file, files);
+			fput_close_list(file, list);
 			cond_resched();
 			spin_lock(&files->file_lock);
 		}
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 2e87faf9a8c2..be935320f1c7 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/unistd.h>
+#include <linux/llist.h>
 #include <asm/exec.h>
 #include <uapi/linux/binfmts.h>
 
@@ -81,6 +82,9 @@ struct linux_binprm {
 	int execfd;		/* File descriptor of the executable */
 	unsigned long exec;
 
+	/* Close-on-exec files awaiting their final __fput(), see free_bprm(). */
+	struct llist_head cloexec_files;
+
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
 
 	char buf[BINPRM_BUF_SIZE];
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e6b641d9eb91..050f4a04157e 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -105,7 +105,7 @@ struct fd_range {
 	unsigned int from, to;
 };
 struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __latent_entropy;
-void close_cloexec_files(struct files_struct *);
+void close_cloexec_files(struct files_struct *, struct llist_head *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);

-- 
2.53.0

