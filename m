Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819D391E5C;
	Wed, 11 Mar 2026 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266221; cv=none; b=KJKAO71ahSCPWld/Xc3pXSRo05B1r396yQU+hNbPYrHLMobl9Vz5nZTNAaHysrz7SnyvHBYcJQ2q2d6zD9UUkK3nOOME1aQSMkgpHch8ESyvsUIenZq+E+K5yRCETuyD27ZVu//eiim5RV0Z+cseN4b0KGJXKtL/kyhtfvM1d1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266221; c=relaxed/simple;
	bh=2u79D1NrEAVE1PW8puRWthwb+bEwcxesCsBnDajL7O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZoxb7h9fg0gsyAdKqyDkuFv5gLTu79NfSj18eODUmi1rU7bb/f4hxs3UOSBkPRWEobJxVIXKcI+Lgb0a2jC1LW5qpNny5FzQMWg78k1o4B/Jy1CzFbeYx06hBTzw1FDI5ZdGWwuuqom+R/kxpnm1vWwJm6va1ZnWpmDa5vs5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONGgoDpr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONGgoDpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B82C116C6;
	Wed, 11 Mar 2026 21:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266221;
	bh=2u79D1NrEAVE1PW8puRWthwb+bEwcxesCsBnDajL7O4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ONGgoDprpl3MBS/8/pvmmoLsxC9MT0EkjFFzEvQaJ/FH+7SeqDpMXXSuru3h5en3e
	 Il2887nvqUIu4g+XLo3CkZfwU+trdf6L9lsVyauERvogKHVmqyE5NSnpO6V6E4Glk5
	 tyOy/3gvrmEjwe9i1LsGWsRCcZtuLtGAmkfrNm4Fj6Y+u50lW9cCfeOzw4ZXAwO8lC
	 qt+zq04snIxZ9hiNts2S26WVUv1YP9epHkjjvNgw+Ufgf2L2db40PJWUesqGi7oyHG
	 dpBuculIJR3ib/TOSN27G5j5a075hIqXDH800TTppOVr0BdlfPrjmod8qPTLau2PKf
	 b5vrzBDnqXh+Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:03 +0100
Subject: [PATCH RFC v3 20/26] fs: add umh argument to struct
 kernel_clone_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-20-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2u79D1NrEAVE1PW8puRWthwb+bEwcxesCsBnDajL7O4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPLzdvvcACb+YvZyRjMb1bg8pQ3fap58CHHu/ynXL
 /29rbG8o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLnLzAytK//9nnLhJnp+xKt
 n+b+5VPQvX6yYe2H2MkcfvPP2xy4rM3I0Gn54lzNd/2TplZbLs/eX8AQEfHn64QXi5/dv6XLefn
 9fAYA
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

Signed-off-by: Christian Brauner <brauner@kernel.org>
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
index 154703cf7d3d..f62b4c370f74 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1590,11 +1590,27 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_fs(u64 clone_flags, struct task_struct *tsk)
+static int copy_fs(u64 clone_flags, struct task_struct *tsk, bool umh)
 {
-	struct fs_struct *fs = current->fs;
+	struct fs_struct *fs;
+
+	/*
+	 * Usermodehelper may use userspace_init_fs filesystem state but
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
@@ -2213,7 +2229,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_files(clone_flags, p, args->no_files);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
-	retval = copy_fs(clone_flags, p);
+	retval = copy_fs(clone_flags, p, args->umh);
 	if (retval)
 		goto bad_fork_cleanup_files;
 	retval = copy_sighand(clone_flags, p);
@@ -2727,6 +2743,7 @@ pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
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

