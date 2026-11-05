Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891676;
	b=hGBJmD8z+NMKshlKZhoilUNorA3cRUCtggRgZCA9Umg3Cc/BYmG/oyzr3yNUAusnTHuj
	 qeqbg0ICkH8DZvxt2b7JfvYEr4i7NrOPm4pow/F+l3bee38DI+loNjQeGPKDgBuFgeqh/
	 chaD/FGPICDade7msG2qrTmb8VH2NTQwoSWxqMvy8CqCphIJ+6ehqFURwi5IdT8+ErTmL
	 EqKqfaP+56ZWLjHNXhpg1OURJjs+Em3nMAnrFDXoDLUqqi0BmWqnVn+o4i0I39Nv4SHio
	 XdpkjVI0lsNM30jwW54uAIgCvsdaMIWmgIttLcosk0wuFMb9PH1arfslZWW9IOGci5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ZpQLaT6f6yVDrFv6ga6R249hOvp8BlyRYGeJwo7PKlA=;
	b=0pRMKI5STjgR5LaJme6c9c0icLje0buK6aJHNhLlFL0HhPJuZBbLTz6K/ttKPhfMBE8p
	 PiFUT7akSbnSGdZ+9pVMqEVG4wB+JbD3lD0gRdyB5Z10BedRm7AGBNWzCw/C9l8eeemoE
	 lSUAuqyfqiywhgdBSLqXXK3DP/AKDH8daxIFYanOGRNMPjMc25rjq80FcsZcBNdP2H5EM
	 SozWz4932w0BT9ZAUfpIq1dbzsY8sgrB4cAja7s3IOWc7ioMyxSrSkZoV+Qpb1G6IUdH9
	 FCT41t7sSCgM5p7BN/I01SrHMAawElJq+wu0sTDHF+znqxfCH06cs2KiNI/BP+0y5mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FLALI4kH;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F607606A329
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F607606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FLALI4kH
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e635220b4so187889185a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891675; x=1794496475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpQLaT6f6yVDrFv6ga6R249hOvp8BlyRYGeJwo7PKlA=;
        b=FLALI4kH6zQVj5a2W5vMD1EKLjZ+UalZMytRlWauJdddMGJznxu30PA2eSV7g4OT7L
         NVdu+8VCHxsQBy2hLYsXnJfI/t77zHzBi/qxlzKTaaUiqrMHCux/+m+XTYTroPlciwxt
         krRG0fb694BSib3vQpIoW0HT4mpw/Xo6tuR4lpImshFnWenG5I5PS6wrLdkeWGPkDT+E
         0NFbZaSxWR+n4WFVP9f4LdPOAdo0KkIDWWnqa0elRLVlfJcU2yUl+krCKtNXFlWU9d+Y
         HCKfQDK9LlSQVZVfUIfnAx670MD+WYTDiguJ+OiU+O7saF1uH2yJmVYHTKpQiWNXuICC
         QrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891675; x=1794496475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpQLaT6f6yVDrFv6ga6R249hOvp8BlyRYGeJwo7PKlA=;
        b=W7joN71QpgkzwqKgSOOF/UDqtfCRLP5hccLDJQD7za3L3CZBepCpo3M+Z6THh38PGa
         xfIuUINWJCmAgPzn+pyaiJ8ChiYCErHGjT3I1z71iEZbcGNhUClfjV/cIy/GTMQ6mOgW
         oDvpUHVEBlKwtBIGyMjkO84I5DWQoPNYZ7b/X9Pw1Cuc2Cm17f22geob3mKYDKXhPATU
         cWeAoYiO1eQx7+t0cVUeii1sUy//pqJKIObJXLFkO1zUuu83YkxJR8KTun/LgKqse/p0
         e1E2gptJzQ9RcIYlZTOKii7WljEvEcyE5DIDYZCHDRh7hM3CB3zqcz4wIUBAaSSHeAJY
         MCxQ==
X-Gm-Message-State: APuU4Z+3fsVaehcpE+ezqMdxikJBiqJ18tqJJqHOzcuUp5Ecav/Q9/qM
	yzwNWsdGM390YnoKF2OfCOnbOP1ef3/9DqtiNRNpuVlYuSRG65x4JSZqLJkpTsE66DQ=
X-Gm-Gg: AYBFou2Lx+GiyUabzDowpqdQpG/VKdp+YPhHi/SNtbprfNI4e/e4tVWBpAajhaBt/PL
	mzYVB2VMu1s2fSWX7R/O2I9rEv1pPOM5o62izcSgK8Qi2FPmt+yFZhmG22eKsGMM3LG2Gsygob2
	m8ExVIzPGllhmfgvOE7jgXVSioubX9sxmA+F4x8krctTkI9EiFXeJlEvwjTnfUMcAKII92FGyka
	OlIQwTFZ2uBPgCLMybpcMbjwRnn6w0CQ6ReQdDsfjoRtItQtuVp55adbGUvt6HF0ykGZbwqcnXw
	0M7hKsIuQk4/ZN/6eBZvbNyse1s2ZrBMubLBOOUd32hEL19mlTRIXq1cSBGQIyQihKVRf81BwrQ
	w/n2y+w0Fwx1AuzKWJrzUSXknOGHI/gqkbSxjwJDmHoA9CNkJkejiKHz4Ce+8UIYoQkaaCKhSRy
	zV3f37PCJ8FyM/TixjMgBuxw0FBA99GFdR98mckv+4DJJDahny3qWvI1IDVTIwKPz5IP8hzDREw
	gkqGCSrCIk08YPq6Ute8gHvH+/mobdEoJh43qazXKqzyDkHOHYh52KintmO7RVibSG3Asble6+4
	FWie/CDIDA68g5RgQVvZfgXVoNyoA36x87ABx+xKCP1TA0B6gN27KJh9yevLSnXkuYc=
X-Received: by 2002:a05:620a:2805:b0:93e:767f:345c with SMTP id af79cd13be357-94421696a14mr3165332285a.39.1793891674856;
        Thu, 05 Nov 2026 07:14:34 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4854ea2sm481570885a.32.2026.11.05.07.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:14:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:31 +0000
Subject: [PATCH RFC v3 39/90] fork: add tasks that start out with nothing
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-39-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=11177;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=B6qtKXYsjLkf/4WERNO+sX9McnZYMfbfYRZSzsHo2ek=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNvchHTNyNjiFcq4thpGzEzUZsAGHl9JQOcKkCjpIfZDHt4XwG0BiSa/aCdfDj3J8SDWEFXdYiO
 Y62GJQimaDQ0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

To start a program in a container today, a process forks. The child then
gets rid of everything it inherited and should not keep, one call at a
time: file descriptors, the working directory, the controlling terminal,
credentials. Whatever it forgets leaks into the container. Until it is
done, it runs code of the parent while it is partly inside of the
container and partly outside.

Add kernel_clone_args.embryo, which makes copy_process() create a task
that has nothing to get rid of. The task works like a usermode helper: it
runs a kernel function and returns to user mode once kernel_execve() has
succeeded. From the start it has no mm, an empty file table, no blocked or
pending signals, and no controlling terminal. It never executes an
instruction of its creator.

The task is called an embryo until its exec has succeeded. struct embryo
describes what it will become, and task_struct.embryo is set for as long
as it is an embryo.

An embryo still inherits resource limits, scheduling attributes, seccomp
filters and LSM state. For the last two this is deliberate: what a
confined task spawns is confined in the same way.

Nothing sets kernel_clone_args.embryo yet. The following patches add the
interface.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h       |  24 +++++++++
 include/linux/sched.h      |   6 +++
 include/linux/sched/task.h |   3 ++
 kernel/embryo.c            | 127 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/fork.c              |  39 +++++++++++---
 5 files changed, 192 insertions(+), 7 deletions(-)

diff --git a/include/linux/cell.h b/include/linux/cell.h
index 564c3e86f3bd..f9975b0fb65c 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -193,4 +193,28 @@ static inline void cell_root(struct cell *cell, struct path *root) { }
 static inline struct cgroup *cell_budget(struct cell *cell) { return NULL; }
 #endif
 
+/* Embryo tasks. */
+#ifdef CONFIG_CELLS
+
+/**
+ * task_is_embryo - is a task still on its way to its first exec?
+ * @task: a task
+ *
+ * Return: true from the time PIDFD_CMD_START made @task until its exec has
+ * succeeded or it is on its way out.
+ */
+static inline bool task_is_embryo(const struct task_struct *task)
+{
+	return READ_ONCE(task->embryo);
+}
+
+void embryo_fork_finish(struct kernel_clone_args *args, struct task_struct *p);
+
+#else
+
+static inline bool task_is_embryo(const struct task_struct *task) { return false; }
+static inline void embryo_fork_finish(struct kernel_clone_args *a, struct task_struct *p) { }
+
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e..3dbe7c13da3b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -85,6 +85,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_exec_state;
+struct embryo;
 struct task_group;
 struct task_struct;
 struct timespec64;
@@ -983,6 +984,11 @@ struct task_struct {
 
 	struct task_exec_state __rcu	*exec_state;
 
+#ifdef CONFIG_CELLS
+	/* Set from PIDFD_CMD_START until the first exec has succeeded. */
+	struct embryo			*embryo;
+#endif
+
 	int				exit_state;
 	int				exit_code;
 	int				exit_signal;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index eaf939ac4bef..97e3675101bd 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,8 @@ struct css_set;
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
 struct cell;
+struct embryo;
+
 struct kernel_clone_args {
 	u64 flags;
 	int __user *pidfd;
@@ -48,6 +50,7 @@ struct kernel_clone_args {
 	unsigned int kill_seq;
 	struct pid *pid;
 	struct cell *cell;
+	struct embryo *embryo;
 };
 
 /*
diff --git a/kernel/embryo.c b/kernel/embryo.c
new file mode 100644
index 000000000000..163115c56ab4
--- /dev/null
+++ b/kernel/embryo.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Empty pidfds: fsopen() for processes.
+ *
+ * pidfd_open() with PIDFD_EMPTY returns a pidfd that no task is attached to yet.
+ * It is a pidfd like any other, on a struct pid that has no numbers, so whatever
+ * it is passed to finds no task. Whoever has it says with pidfd_configure() what
+ * the task is to be like and starts it. Only then is there a task, which never
+ * runs a single instruction of its creator's and execs. The creator does not
+ * fork.
+ *
+ * The task is an embryo until its exec has succeeded. It has no mm and an empty
+ * file table. What it is to reach, it is given. It does inherit attributes of
+ * whoever started it, as any new task does, see
+ * Documentation/userspace-api/cells.rst.
+ *
+ * It takes the shape of a usermode helper: a task with a kernel function to
+ * run, that returns to user mode once kernel_execve() has succeeded.
+ */
+#include <linux/binfmts.h>
+#include <linux/cell.h>
+#include <linux/completion.h>
+#include <linux/cred.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/io_uring.h>
+#include <linux/personality.h>
+#include <linux/nsproxy.h>
+#include <linux/pid.h>
+#include <linux/pidfs.h>
+#include <linux/proc_fs.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
+#include <linux/sched/user.h>
+#include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/user_namespace.h>
+#include <net/af_unix.h>
+#include <uapi/linux/pidfd.h>
+
+struct embryo_strings {
+	char		*block;		/* NUL terminated strings, back to back */
+	const char	**vec;		/* NULL terminated, points into @block */
+};
+
+struct embryo {
+	struct rcu_head		rcu;
+	refcount_t		ref;
+	struct mutex		lock;		/* everything down to @result */
+	bool			started;
+	bool			settled;	/* there is a task, or never will be */
+
+	char			*exec;
+	struct embryo_strings	argv;
+	struct embryo_strings	envp;
+
+	struct pid		*pid;		/* the reference alloc_pid_struct() returned */
+	struct cell		*cell;		/* where the task is going to be */
+
+	int			result;
+	struct completion	done;		/* embryo -> starter */
+};
+
+static void embryo_strings_free(struct embryo_strings *s)
+{
+	kvfree(s->block);
+	kvfree(s->vec);
+	s->block = NULL;
+	s->vec = NULL;
+}
+
+/*
+ * What was configured has been used, or never will be. The pidfd may be around
+ * for long, and must not keep the other end of a pipe from seeing the last
+ * writer go.
+ */
+static void embryo_drop_config(struct embryo *e)
+{
+	kfree(e->exec);
+	e->exec = NULL;
+	embryo_strings_free(&e->argv);
+	embryo_strings_free(&e->envp);
+}
+
+static void embryo_put(struct embryo *e)
+{
+	if (!e || !refcount_dec_and_test(&e->ref))
+		return;
+
+	embryo_drop_config(e);
+	cell_put(e->cell);
+	kfree_rcu(e, rcu);
+}
+
+/**
+ * embryo_fork_finish - done creating an embryo, one way or the other
+ * @args: the arguments of the clone, with @args->embryo set
+ * @p:    what copy_process() returned, a task or an ERR_PTR()
+ *
+ * Unlocks the cell, which embryo_start() had locked.
+ *
+ * Context: kernel_clone(), before the new task is woken.
+ */
+void embryo_fork_finish(struct kernel_clone_args *args, struct task_struct *p)
+{
+	struct embryo *e = args->embryo;
+
+	if (!IS_ERR(p))
+		cell_task_spawned(args->cell);
+	cell_fork_finish(args->cell);
+
+	/* Nothing has happened yet, see embryo_start(). */
+	if (p == ERR_PTR(-ERESTARTNOINTR)) {
+		embryo_put(e);
+		return;
+	}
+
+	/* From here on the pidfd polls like any other. */
+	WRITE_ONCE(e->settled, true);
+	if (IS_ERR(p)) {
+		wake_up_all(&e->pid->wait_pidfd);
+		/* The reference that was to be the task's. */
+		embryo_put(e);
+	}
+}
diff --git a/kernel/fork.c b/kernel/fork.c
index 4db060281448..119b59f30f4d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1565,7 +1565,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	return NULL;
 }
 
-static int copy_mm(u64 clone_flags, struct task_struct *tsk)
+static int copy_mm(u64 clone_flags, struct task_struct *tsk, bool embryo)
 {
 	struct mm_struct *mm, *oldmm;
 
@@ -1583,9 +1583,12 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 	 * Are we cloning a kernel thread?
 	 *
 	 * We need to steal a active VM for that..
+	 *
+	 * An embryo is in the same position until it execs. It must never
+	 * get to see the mm of whoever created it.
 	 */
 	oldmm = current->mm;
-	if (!oldmm)
+	if (!oldmm || embryo)
 		return 0;
 
 	if (clone_flags & CLONE_VM) {
@@ -1693,10 +1696,19 @@ static int copy_fs(u64 clone_flags, struct task_struct *tsk,
 }
 
 static int copy_files(u64 clone_flags, struct task_struct *tsk,
-		      int no_files)
+		      int no_files, bool embryo)
 {
 	struct files_struct *oldf, *newf;
 
+	/* An empty table. What pidfd_configure() was given goes in there. */
+	if (embryo) {
+		newf = dup_fd(&init_files, NULL);
+		if (IS_ERR(newf))
+			return PTR_ERR(newf);
+		tsk->files = newf;
+		return 0;
+	}
+
 	/*
 	 * A background process may not have any files ...
 	 */
@@ -2187,6 +2199,14 @@ __latent_entropy struct task_struct *copy_process(
 	}
 	if (args->io_thread)
 		p->flags |= PF_IO_WORKER;
+#ifdef CONFIG_CELLS
+	p->embryo = args->embryo;
+	if (args->embryo) {
+		sigemptyset(&p->blocked);
+		sigemptyset(&p->saved_sigmask);
+		clear_tsk_restore_sigmask(p);
+	}
+#endif
 
 	if (args->name)
 		strscpy_pad(p->comm, args->name, sizeof(p->comm));
@@ -2330,7 +2350,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p, args->no_files);
+	retval = copy_files(clone_flags, p, args->no_files, args->embryo);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p,
@@ -2344,7 +2364,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_signal(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_sighand;
-	retval = copy_mm(clone_flags, p);
+	retval = copy_mm(clone_flags, p, args->embryo);
 	if (retval)
 		goto bad_fork_cleanup_signal;
 	retval = copy_namespaces(clone_flags, p, args->cell);
@@ -2568,8 +2588,10 @@ __latent_entropy struct task_struct *copy_process(
 				WRITE_ONCE(ns->child_reaper, p);
 				p->signal->flags |= SIGNAL_UNKILLABLE;
 			}
-			p->signal->shared_pending.signal = delayed.signal;
-			p->signal->tty = tty_kref_get(current->signal->tty);
+			if (!args->embryo)
+				p->signal->shared_pending.signal = delayed.signal;
+			if (!args->embryo)
+				p->signal->tty = tty_kref_get(current->signal->tty);
 			/*
 			 * Inherit has_child_subreaper flag under the same
 			 * tasklist_lock with adding child to the process tree
@@ -2817,6 +2839,9 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
 	add_latent_entropy();
 
+	if (args->embryo)
+		embryo_fork_finish(args, p);
+
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 

-- 
2.55.0

