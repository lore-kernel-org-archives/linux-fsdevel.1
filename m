Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F453C4155;
	Mon,  1 Jun 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322260; cv=none; b=O9PuSipvMTWGJkO4ZY0wShVx2azdsNpKTlQ4KBJ3sOCpibnw4HBbC+x81PbfGsQQp4udtvj54fFEN+sNlhjTAfluKRCux57vkd6Al9s/13sztCN60a5FCybA/08MqZeE230jFc4LzmZyIpjg4pP4E9iYq0+dLsp9/GkcYF9+2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322260; c=relaxed/simple;
	bh=Um5qFBTonfqtToK8ivjVhOxkc2Bf9eG0Su0nAvqlLJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5yN6w5NWTmwBkdrVD/V/DXm1G+s7f033Ick7w/9+TZQuze5Dj+Rq7agimbiOHO2GGbO8dqoID5YL5Mz1cmtCxRlYO8c+TLvEXG15QF6bfNrYbMhtCulGVYvkcEk63tHEfpqHFCocCCpWBLIj/crO3QgQB4NESglBiWZhiZ6PMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbrrku9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbrrku9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70541F00893;
	Mon,  1 Jun 2026 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322259;
	bh=ezJrg3c6vUTHy3zJ0IWV8cRNjVA2L6WwpesMAQucO4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Sbrrku9xOIJMny16jvq6oAeRXrV402IT67789XF9sn2Fe7jThJBQGBFfAWIRmw0+1
	 TPL7q11gD2/aZxRrLIIRpTmMfyWCUdNwoiOqEIKH6tI9LIrAxooT25DSHi7PYniYFw
	 fwOMlSkLwCiOhWf7fd++NSLF/rkh00F0PN3VlxYLpx4b6s+8dKUGX1usa4ucREKgve
	 TUUE29eGY4muzGl5ljjusNCXMMQuywqMUEGaqSs7gHIJ6b8bExxezG6Ne5+/XcYRjG
	 pcaZdf6ZGIM83L9VEE8lAAFqcbGtGoPALG2/REtMULGen6wLv+qBqpYyFG5TLju3UV
	 OFTC+ZAmThj4Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:53 +0200
Subject: [PATCH RFC v4 20/25] fs: add umh argument to struct
 kernel_clone_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-20-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3653; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Um5qFBTonfqtToK8ivjVhOxkc2Bf9eG0Su0nAvqlLJY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i/PWM9TGKy87P0Kr5MTG2Jql+ZukFwTp6xvtX/rB
 8XzNn2JHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5toyRYVdBoeNUJbNvS7Qv
 zfwau/z88p6r1+7v3TznvW7EAesD3WoMPxnlsuL+eDpPrvCa8UbE8Ye0sf66srSbm59/WOdY/6i
 ymw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a umh field to struct kernel_clone_args. When set, copy_fs() copies
from pid 1's fs_struct instead of the kthread's fs_struct. This ensures
usermodehelper threads always get init's filesystem state regardless of
their parent's (kthreadd's) fs.

Usermodehelper threads are not allowed to create mount namespaces
(CLONE_NEWNS), share filesystem state (CLONE_FS), or be started from
a non-initial mount namespace. No usermodehelper currently does this so
we don't need to worry about this restriction.

Set .umh = 1 in user_mode_thread(). At this stage pid 1's fs points to
rootfs which is the same as kthreadd's fs, so this is functionally
equivalent.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 25 +++++++++++++++++++++----
 kernel/umh.c               |  6 ++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 41ed884cffc9..e0c1ca8c6a18 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -31,6 +31,7 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
+	u32 umh:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index bf153b2929d4..f1accd7a2455 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1593,11 +1593,27 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_fs(u64 clone_flags, struct task_struct *tsk)
+static int copy_fs(u64 clone_flags, struct task_struct *tsk, bool umh)
 {
-	struct fs_struct *fs = current->fs;
+	struct fs_struct *fs;
+
+	/*
+	 * Usermodehelper may copy userspace_init_fs filesystem state but
+	 * they don't get to create mount namespaces, share the
+	 * filesystem state, or be started from a non-initial mount
+	 * namespace.
+	 */
+	if (umh) {
+		if (clone_flags & (CLONE_NEWNS | CLONE_FS))
+			return -EINVAL;
+		if (current->nsproxy->mnt_ns != &init_mnt_ns)
+			return -EINVAL;
+		fs = userspace_init_fs;
+	} else {
+		fs = current->fs;
+		VFS_WARN_ON_ONCE(current->fs != current->real_fs);
+	}
 
-	VFS_WARN_ON_ONCE(current->fs != current->real_fs);
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		read_seqlock_excl(&fs->seq);
@@ -2252,7 +2268,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_files(clone_flags, p, args->no_files);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
-	retval = copy_fs(clone_flags, p);
+	retval = copy_fs(clone_flags, p, args->umh);
 	if (retval)
 		goto bad_fork_cleanup_files;
 	retval = copy_sighand(clone_flags, p);
@@ -2796,6 +2812,7 @@ pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.exit_signal	= (flags & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
+		.umh		= 1,
 	};
 
 	return kernel_clone(&args);
diff --git a/kernel/umh.c b/kernel/umh.c
index cffda97d961c..d3f4b308b85d 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -71,10 +71,8 @@ static int call_usermodehelper_exec_async(void *data)
 	spin_unlock_irq(&current->sighand->siglock);
 
 	/*
-	 * Initial kernel threads share ther FS with init, in order to
-	 * get the init root directory. But we've now created a new
-	 * thread that is going to execve a user process and has its own
-	 * 'struct fs_struct'. Reset umask to the default.
+	 * Usermodehelper threads get a copy of userspace init's
+	 * fs_struct. Reset umask to the default.
 	 */
 	current->fs->umask = 0022;
 

-- 
2.47.3

