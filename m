Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8543806B8;
	Wed,  1 Apr 2026 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047434; cv=none; b=NVUztbsCeDAxyzqEO/ekPQBlD8ljDBNQ/cf8s0qFeFDeCCQl5q2f0Cnt0mymGjHW1gRc0OZlRkW+KTczhC0i5wEAbs0LPuQPu8sDrfWsPFGbcXRgLZ2hkTK3XA0Wc6AGBH0RGm7df2jE2uBo8thLY0hcV3XK9fQwlmlO1cSlSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047434; c=relaxed/simple;
	bh=YTafpp9aQiVxn3x/jn/2IGfUCEaISkfN1iPjJa/mH7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StLBr63CuvX3RMIpyfjxaG3Z1oJJpRTMJ8fYTujsZT+S1He4+rCHNtqg9rPxTag4IP7HuyuE9IECXPPmPzMWGptnIZFAFsPnR30F6+ikYNDnaH/8p8LCjjaLNGzb0fApkXoKCQJ7s4Q3F0PWTkzaEkbikWyl9RE4ogw7IfqVARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vipl/XmG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vipl/XmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9FCC116C6;
	Wed,  1 Apr 2026 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775047433;
	bh=YTafpp9aQiVxn3x/jn/2IGfUCEaISkfN1iPjJa/mH7c=;
	h=From:To:Cc:Subject:Date:From;
	b=Vipl/XmGWS9LJNsgnGTL2acnml0qlK40fhQlIXvqYSIz5eywRSMx9vqeDgvOrvmQQ
	 XeqQK5GxT9k6EP2/dCAuW4Nju8XxkiUae810lc8kHOZCFibvk+H6Fkgmag4BtkvAvE
	 Rlj7ONqYKE/V91LgFa6g6HtzQHtQr7uWYOp7l+0rsMenVlzVQXEC2nrO2ne0aW15xt
	 wNQA13D41c+peZ3BroiYoh9t7z2IepAxh/yIeVC5tDtAz20Rm7YZbWtm3L62OyJU5Q
	 DOEiPIIGXYgqb/OWV2HNFy5ZqD45nBNQY+hIhwql3dqNOyaJfGE7OBLoYkTVA+LSyR
	 QFrxQqJ/fAJeA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] vfs: require verified birth date for file creation
Date: Wed,  1 Apr 2026 14:43:21 +0200
Message-ID: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8012; i=brauner@kernel.org; h=from:subject:message-id; bh=YTafpp9aQiVxn3x/jn/2IGfUCEaISkfN1iPjJa/mH7c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSeFXpVsbVrU33FDvFvlxxu3Ze6Oz1sb7Tz1BTVa/6Pt 53ezH/8dkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEdrsxMpzIS9zSoKZcwn2J LSGvRjIoW/k2b/PnArs1ryWyhPafiWD4Z3O5L9f7xjbWy2xm+ft+ftRs8HjBx1cs9T8qXTOyUuQ tCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

New regulation mandates that all digital content
creation operations must be performed by verified adults. As file
creation is the most fundamental content creation primitive in any
operating system, the kernel must enforce age verification at the VFS
layer.

This patch introduces CONFIG_VFS_AGE_VERIFICATION which, when enabled,
requires every process to register a valid birth date via
prctl(PR_SET_BIRTHDATE) before being permitted to create files. The
birth date is stored in struct task_struct and inherited across fork().

File creation will fail with the new ETOOYOUNG error code if:
  (a) no birth date has been registered, or
  (b) the registered birth date indicates the user is under 18 years
      of age.

A new errno, ETOOYOUNG (134), has been added. Userspace is expected to
handle this error by displaying a calming message and suggesting the
user ask a parent or guardian to create the file on their behalf.

The birth date is deliberately NOT cleared across execve() to avoid
the obvious loophole of spawning a new shell to bypass verification.
Some may argue this violates the principle of least privilege. Those
people are probably too young to create files anyway.

Note: setting a birth date that makes the caller appear older than 150
years is rejected with EINVAL, as the kernel does not support vampires
or other immortal entities at this time. Patches to add undead process
support are welcome but will require a separate Kconfig option.

Tested-by: Someone's nephew/niece (confirmed they cannot create files)
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Kconfig                        |  17 ++++++++
 fs/namei.c                        |  45 +++++++++++++++++++++
 include/linux/sched.h             |   8 ++++
 include/uapi/asm-generic/errno.h  |   2 +
 include/uapi/linux/prctl.h        |   4 ++
 kernel/sys.c                      |  42 ++++++++++++++++++++
 6 files changed, 118 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 1c2036..424242 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -42,6 +42,23 @@ source "fs/crypto/Kconfig"
 source "fs/verity/Kconfig"
 source "fs/notify/Kconfig"

+config VFS_AGE_VERIFICATION
+	bool "Require birth date verification for file creation"
+	default y
+	help
+	  When enabled, every process must register a valid birth date via
+	  prctl(PR_SET_BIRTHDATE, day, month, year) before being allowed to
+	  create files. Processes that have not registered a birth date or
+	  whose registered birth date indicates they are under 18 years of
+	  age will receive -ETOOYOUNG on any file creation attempt.
+
+	  If unsure, say Y. Failure to comply may result in stern letters
+	  from lawyers. You don't want that. Trust us. Say Y.
+
 source "fs/quota/Kconfig"

 source "fs/autofs/Kconfig"
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 1..2 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -20,4 +20,6 @@

 #define EHWPOISON	133	/* Memory page has hardware error */

+#define ETOOYOUNG	134	/* Process too young to create content */
+
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 3..4 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,8 @@

 #define PR_LOCK_INDIR_BR_LP_STATUS      82

+/* age verification for file creation */
+#define PR_SET_BIRTHDATE		83
+#define PR_GET_BIRTHDATE		84
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5..6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1215,6 +1215,14 @@ struct task_struct {
 #endif
 	struct seccomp			seccomp;
 	struct syscall_user_dispatch	syscall_dispatch;
+
+#ifdef CONFIG_VFS_AGE_VERIFICATION
+	/* compliance - birth date for age verification */
+	u8				birthdate_day;
+	u8				birthdate_month;
+	u16				birthdate_year;
+	bool				birthdate_verified;
+#endif

 	/* Thread group tracking: */
 	u64				parent_exec_id;
diff --git a/kernel/sys.c b/kernel/sys.c
index 7..8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2345,6 +2345,48 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		break;
+
+#ifdef CONFIG_VFS_AGE_VERIFICATION
+	case PR_SET_BIRTHDATE:
+	{
+		u8 day = (u8)arg2;
+		u8 month = (u8)arg3;
+		u16 year = (u16)arg4;
+		struct tm now;
+		int age;
+
+		/* Basic date validation */
+		if (month < 1 || month > 12)
+			return -EINVAL;
+		if (day < 1 || day > 31)
+			return -EINVAL;
+		if (year < 1900)
+			return -EINVAL;
+
+		time64_to_tm(ktime_get_real_seconds(), 0, &now);
+
+		/* The kernel does not support vampires or immortal entities */
+		if ((now.tm_year + 1900) - year > 150)
+			return -EINVAL;
+
+		/* No time travelers either */
+		if (year > (now.tm_year + 1900))
+			return -EINVAL;
+
+		me->birthdate_day = day;
+		me->birthdate_month = month;
+		me->birthdate_year = year;
+		me->birthdate_verified = true;
+
+		age = (now.tm_year + 1900) - year;
+		if (now.tm_mon + 1 < month ||
+		    (now.tm_mon + 1 == month && now.tm_mday < day))
+			age--;
+
+		if (age < 18)
+			pr_info_ratelimited("Process %d (comm: %s) registered as minor (age %d). "
+				"File creation will be denied. Please ask a "
+				"parent or guardian for assistance.\n",
+				task_pid_nr(me), me->comm, age);
+		break;
+	}
+	case PR_GET_BIRTHDATE:
+		if (!me->birthdate_verified)
+			return -EINVAL;
+		if (put_user(me->birthdate_day, (u8 __user *)arg2) ||
+		    put_user(me->birthdate_month, (u8 __user *)arg3) ||
+		    put_user(me->birthdate_year, (u16 __user *)arg4))
+			return -EFAULT;
+		break;
+#endif /* CONFIG_VFS_AGE_VERIFICATION */
+
 	default:
 		error = -EINVAL;
 		break;
diff --git a/fs/namei.c b/fs/namei.c
index 9..10 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4148,6 +4148,45 @@ static int vfs_mknodat(struct mnt_idmap *idmap, struct dentry *dentry,
 		       umode_t mode, dev_t dev);

+#ifdef CONFIG_VFS_AGE_VERIFICATION
+/**
+ * check_age_verification - verify the calling process has registered a valid
+ *                          birth date and is old enough to create files.
+ *
+ * Returns 0 if the caller is verified as an adult (>= 18 years old).
+ * Returns -ETOOYOUNG if the caller is a minor or has not registered a
+ * birth date.
+ *
+ * This function exists because the fundamental UNIX
+ * principle of "everything is a file" was insufficiently regulated.
+ */
+static int check_age_verification(void)
+{
+	struct task_struct *tsk = current;
+	struct tm now;
+	int age;
+
+	if (!tsk->birthdate_verified) {
+		pr_warn_ratelimited(
+			"Process %d (comm: %s) attempted to create a file "
+			"without age verification. Set birth date via "
+			"prctl(PR_SET_BIRTHDATE, day, month, year).\n",
+			task_pid_nr(tsk), tsk->comm);
+		return -ETOOYOUNG;
+	}
+
+	time64_to_tm(ktime_get_real_seconds(), 0, &now);
+
+	age = (now.tm_year + 1900) - tsk->birthdate_year;
+	if (now.tm_mon + 1 < tsk->birthdate_month ||
+	    (now.tm_mon + 1 == tsk->birthdate_month &&
+	     now.tm_mday < tsk->birthdate_day))
+		age--;
+
+	if (age < 18) {
+		pr_warn_ratelimited(
+			"Process %d (comm: %s) is only %d years old. "
+			"Must be 18 or older to create files. "
+			"Ask a parent or guardian for help.\n",
+			task_pid_nr(tsk), tsk->comm, age);
+		return -ETOOYOUNG;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_VFS_AGE_VERIFICATION */
+
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
@@ -4170,6 +4209,12 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 	if (error)
 		return error;

+#ifdef CONFIG_VFS_AGE_VERIFICATION
+	error = check_age_verification();
+	if (error)
+		return error;
+#endif
+
 	if (!dir->i_op->create)
 		return -EACCES;	/* shouldn't it be ENOSYS? */

--
2.49.0
