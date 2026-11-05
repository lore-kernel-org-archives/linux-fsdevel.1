Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891698;
	b=ynCCmIjHTDtbigP1tlNN3ne0w/qCMtVERS9OlWZQuqd+Absiz7irVsGdEeK2Z+2BhdCE
	 oUIipn5tWMrIr5auNbHja4wyPROIbKTBxHTEM5XCEUP905+okoQwAEpQKJsWjhEgM+Nbl
	 I6fyEgLNqAGwmzmTi27dKZMj7wChbx3a5i0D/uXE8EnfUV+EJuokIkVx104zLsjLmTdRb
	 4kZ05gCYzn6QqE3nRSXsSNby+Otjrib/JXzQPBcKZjT5ml/X/s+Ux6BIp4EMImP7NuAuB
	 DD0t/OWRY0cpdbgQxQltF4GOYC1sTuq1uehdHAfX+DEzqUEqb0libzNPgtoO9tiDxzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=jUTckbCC9rjXjuWPPD7L+h8Y2E40WDPte3IEx6I+9X8=;
	b=J9Y3rh7JLj6SV1Qy941flh0FOAjxQHlfSMb+Gf5NN2oSt8mncraMvgkn5eZo4sEU9sw0
	 zgWcUG9L78FoWmJU9Cdn3d1D8HyisH++MF+s3XM05qU8hGm4g2Q1sRr4EQ1FtSDenVaeX
	 oNvNC4yRFjUrLLYHXA+QvwJGXLk/EiyHmdhEaWGoZ/nz3XGEe4v6DR8fc1+LIeo95cVHv
	 bv6XF3zdqHTka5c8LC4KMIm/7dXdMdUSCY45b6F1eTZkSp4Y2NATbBJPuMqS6b/rAbMer
	 4YUa6ktVtCM/rwYUoeOgu7AkeUiYhzJcKsh/6DcBGkOjOlT0mv/UKtqyhqEVdwDAz8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=L5WQR7zg;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2F606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA2F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=L5WQR7zg
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-943e8d35f74so179272385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891697; x=1794496497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUTckbCC9rjXjuWPPD7L+h8Y2E40WDPte3IEx6I+9X8=;
        b=L5WQR7zgyUQYmJiASNE4KFCygUcjXYkBJjxzZcxxcsB45vd7FA/DUWSYzLSeNnJq1Z
         vfT30K1c/6H4xm0rvUerSNrXyYCxKMut6850sUN6iEQAyFK+1pbMe0qegoLp1WAx2Jfl
         7tthxxscUQkl6w1IyW6gwaw3fcU/aiLu0rAM6b+ke5GPs1HDZVGe5Y3FfYBN9icFjMLD
         DD72nNmRZl2HPlfOCGgceLAV9wMKUwZrKVSrJo7q9B9d+ZaT56/7ZEiElDDBYxzqFM9O
         8Znr+4y3Gplqg+IseFlua3LstH+ip9z0xboEadNEgeM1qUqSOioCwheQ6b+vt0aBuOBO
         Jflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891697; x=1794496497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUTckbCC9rjXjuWPPD7L+h8Y2E40WDPte3IEx6I+9X8=;
        b=mcZFAZFYZ0xcxgPYwAqH8i2EPUCwf/l64EP7zybmC4p0m3qSBnGeOqpixZ+nYKhhbE
         WrdiBFp1Y6N14Jh3E0yNyhM3ZE7j00kGPuH3VGQFzbknoMcW7ll26RrAi7Eq15eHv4ap
         mh6oxbmBPAUg9n3C5Nkm3L3ta16Hyzfp0KInZSl43sHSPChfoqQhIvyR6tPz4QfjNk47
         SUKhn+YsYNkpe9Ruc3zLDaaM3ksyfyC3KMTFCdmWF7SSK74Ab9gSotm6OKovfXzKKhnn
         cEhZuems6nqr+qxHVfVfu9uwIWHPp/hekU/tu8nYEKPvBdhKTD+TBw0ROqif9zqPcvZu
         U5sQ==
X-Gm-Message-State: APuU4Z9S1CJJNloCkSUCFrhUl2MMW2R3tTL+SZTwXXUmNmpXA3zC46Ny
	FLkT/QdxfEQvTLtczsPeomisBlKPtIXnDg0WnmQOgo8TREiYw30BdheTTPN4oV5mKwc=
X-Gm-Gg: AYBFou2/s2pIneedk43Vs/WXytqwnpGhkwbSzsZ1fgjj1vx4fhc/oU7VWTeAZeK1LL+
	nIif1ZaGoZY7ga+33b1NIo/xEZcEw21Oxl4r2hb3Qn1Jajbze+08lxT+X6e02mHsliPbwYXum2n
	8s9VqUl9+Hh63WIRXBBzugZWhK76vcUFBLL9Pj4C0XCD6qQiR9ndaklKxjKMYyuFNk+INPBKAsE
	6eU8NiqzfnbnqGPuX47dckb6jD6+uJeKYsqCFRR6HeuYc26oqWIDipgd/bJT99mcAkAZmkLCEHg
	3+xS4ORfOIQWN7LK0v4VlKmCLvFJln/LNl1NraUJYhmp0FOkbbZlqjWabYc3Zdv6GjII1SJjcJM
	tiz4lqxychXy8XH5M7DV4Qhc8dMd3mCL1llhnAUM4qAuJ++qNcWQW4Ccr8m6kwDcefi9dckYNNJ
	aImw4ajaqbFWw7wYAYkN+EoYIFkorpDrBR3oQjH3/a1g5swDf3fuLqQoaH9O0ezzPvVNxe2rMg9
	WDh1K9f9zSIhvPenq7LX0LIguUq7sZLKxOWQEFmTc4ZUOH2LSl1yuD0AnQl97Bo9FOb8hHcNg2S
	LSt4JDLiMh3bIW3Nf+yEkbqfnbDS88mbRx3g29bMy8U2DoA0GRT61IyXtqmmSl957X8=
X-Received: by 2002:a05:620a:2724:b0:93e:c12c:f11f with SMTP id af79cd13be357-94421850475mr3060123785a.75.1793891696863;
        Thu, 05 Nov 2026 07:14:56 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48577ebsm480134385a.33.2026.11.05.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:14:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:32 +0000
Subject: [PATCH RFC v3 40/90] pidfd: add PIDFD_EMPTY
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
Message-Id: <20261105-b4-cells-v3-40-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=10904;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Hxvh8WLoMdSZwPDiDs4Iw6xH/PJiwBrZQ87vRVIx4uI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDtd2KksDM0mM1DV0gEGzuw3vnXPU6sQ5IJ7oTnWtC7RkU/yhM7y8pyFKxrZFrXgEny1YQZOdpS
 a8wVGAAtPOAk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Do for tasks what fsopen() did for mounts. pidfd_open() with PIDFD_EMPTY
returns a pidfd that has no task yet. The caller then describes the task
and starts it.

It is an ordinary pidfd, for a struct pid that has no task and no numbers.
Everything that takes a pidfd already handles a pidfd without a task: it
returns ESRCH, or ECHILD in the case of waitid(). Once the task exists it
is still the same pidfd on the same inode, and pidfd_open() on the pid of
the task finds that inode.

pidfs itself needs changes, because it takes a missing task to mean that
the task has exited. Teach it the difference between "no task yet" and "no
task any more" in three places:

  - poll() must not report an exit.
  - PIDFD_GET_INFO has no exit status to report.
  - fdinfo shows "Pid: 0" instead of -1.

The namespace ioctls already return ESRCH, and a struct pid without
numbers cannot be found by file handle.

Nothing is reserved ahead of time. The struct pid gets its numbers when
the task is created. So the task that is started first becomes the init of
its pid namespace, an empty pidfd that is closed leaves nothing behind,
and one that is never started does not keep zap_pid_ns_processes()
waiting.

The size of a struct pid depends on the level of its pid namespace, so the
namespace must be known when the pidfd is created. With PIDFD_EMPTY the
first argument of pidfd_open() is therefore a cellfd instead of a pid.
Such a task would be useful outside of a cell as well. That is not
implemented, and -EBADF in place of the cellfd is reserved for it.

The configuration is attached to the file. So only the file that
pidfd_open() returned can be used to configure the task, no matter who
else can open a pidfd for it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/pidfs.c                 |  27 ++++++++---
 include/linux/cell.h       |  11 +++++
 include/uapi/linux/pidfd.h |   1 +
 kernel/embryo.c            | 117 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/pid.c               |   5 ++
 5 files changed, 155 insertions(+), 6 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index ef305cc359eb..b1c1e0ea1e4a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/anon_inodes.h>
+#include <linux/cell.h>
 #include <linux/compat.h>
 #include <linux/exportfs.h>
 #include <linux/file.h>
@@ -278,6 +279,9 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 	if (likely(pid_has_task(pid, PIDTYPE_PID))) {
 		ns = proc_pid_ns(file_inode(m->file)->i_sb);
 		nr = pid_nr_ns(pid, ns);
+	} else if (embryo_pidfd_is_empty(f)) {
+		/* No task yet is not the same as no task any more. */
+		nr = 0;
 	}
 
 	seq_put_decimal_ll(m, "Pid:\t", nr);
@@ -310,6 +314,9 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	__poll_t poll_flags = 0;
 
 	poll_wait(file, &pid->wait_pidfd, pts);
+	/* No task yet is not the same as no task any more. */
+	if (embryo_pidfd_is_empty(file))
+		return 0;
 	/*
 	 * Don't wake waiters if the thread-group leader exited
 	 * prematurely. They either get notified when the last subthread
@@ -437,6 +444,10 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		 */
 		if (!(mask & PIDFD_INFO_EXIT))
 			return -ESRCH;
+		/* What was opened empty may never have had a task to exit. */
+		if ((file->f_flags & PIDFD_EMPTY) &&
+		    !test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
+			return -ESRCH;
 
 		goto copy_out;
 	}
@@ -729,6 +740,9 @@ static int pidfs_file_release(struct inode *inode, struct file *file)
 	struct pid *pid = inode->i_private;
 	struct task_struct *task;
 
+	if (file->f_flags & PIDFD_EMPTY)
+		embryo_pidfd_release(file);
+
 	if (!(file->f_flags & PIDFD_AUTOKILL))
 		return 0;
 
@@ -1004,7 +1018,8 @@ static struct file *pidfs_dentry_open(const struct path *path,
 	file = dentry_open(path, flags | O_RDWR, cred);
 	/* do_dentry_open() strips O_EXCL and O_TRUNC. */
 	if (!IS_ERR(file))
-		file->f_flags |= flags & (PIDFD_THREAD | PIDFD_AUTOKILL);
+		file->f_flags |= flags & (PIDFD_THREAD | PIDFD_AUTOKILL |
+					  PIDFD_EMPTY);
 	return file;
 }
 
@@ -1033,10 +1048,10 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
 {
 	/*
-	 * Opening via file handle may never raise PIDFD_AUTOKILL. That can
-	 * only be done at task creation!
+	 * Opening via file handle may never raise PIDFD_AUTOKILL or
+	 * PIDFD_EMPTY. That can only be done at task creation, or ahead of it!
 	 */
-	if (WARN_ON_ONCE(oflags & PIDFD_AUTOKILL))
+	if (WARN_ON_ONCE(oflags & (PIDFD_AUTOKILL | PIDFD_EMPTY)))
 		return ERR_PTR(-EINVAL);
 	/* Clear O_LARGEFILE as open_by_handle_at() forces it. */
 	return pidfs_dentry_open(path, oflags & ~O_LARGEFILE, current_cred());
@@ -1226,8 +1241,8 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	 * Ensure that internal pidfd flags don't overlap with each
 	 * other or with uapi pidfd flags.
 	 */
-	BUILD_BUG_ON(hweight32(PIDFD_THREAD | PIDFD_NONBLOCK |
-				PIDFD_STALE | PIDFD_AUTOKILL) != 4);
+	BUILD_BUG_ON(hweight32(PIDFD_THREAD | PIDFD_NONBLOCK | PIDFD_STALE |
+			       PIDFD_AUTOKILL | PIDFD_EMPTY) != 5);
 
 	ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
 	if (ret < 0)
diff --git a/include/linux/cell.h b/include/linux/cell.h
index f9975b0fb65c..a68638b7319d 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -217,4 +217,15 @@ static inline void embryo_fork_finish(struct kernel_clone_args *a, struct task_s
 
 #endif
 
+/* An empty pidfd. */
+#ifdef CONFIG_CELLS
+int embryo_pidfd_open(int cfd, unsigned int flags);
+bool embryo_pidfd_is_empty(const struct file *file);
+void embryo_pidfd_release(struct file *file);
+#else
+static inline int embryo_pidfd_open(int cfd, unsigned int flags) { return -EINVAL; }
+static inline bool embryo_pidfd_is_empty(const struct file *file) { return false; }
+static inline void embryo_pidfd_release(struct file *file) { }
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 0919246a1611..eb3704687c04 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -10,6 +10,7 @@
 /* Flags for pidfd_open().  */
 #define PIDFD_NONBLOCK	O_NONBLOCK
 #define PIDFD_THREAD	O_EXCL
+#define PIDFD_EMPTY	O_NOCTTY /* No task yet. See pidfd_configure(). */
 #ifdef __KERNEL__
 #include <linux/sched.h>
 #define PIDFD_STALE CLONE_PIDFD
diff --git a/kernel/embryo.c b/kernel/embryo.c
index 163115c56ab4..e052c09f9192 100644
--- a/kernel/embryo.c
+++ b/kernel/embryo.c
@@ -125,3 +125,120 @@ void embryo_fork_finish(struct kernel_clone_args *args, struct task_struct *p)
 		embryo_put(e);
 	}
 }
+
+static int embryo_pidfd_create(struct embryo *e, unsigned int flags)
+{
+	struct file *file;
+
+	CLASS(get_unused_fd, fd)(O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+	file = pidfs_alloc_file(e->pid, flags | O_RDWR);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	file->private_data = e;
+	fd_install(fd, file);
+	return take_fd(fd);
+}
+
+/**
+ * embryo_pidfd_open - pidfd_open() with PIDFD_EMPTY
+ * @cfd:   the cell the task is going to be in
+ * @flags: PIDFD_EMPTY, and PIDFD_NONBLOCK if wanted
+ *
+ * The struct pid is made here and gets no numbers before the task is started.
+ * Its size goes by the pid namespace, which is why the cell has to be known by
+ * now. It reserves nothing in there: whichever task is started first is the init
+ * of the cell, and a pidfd that is left empty keeps no cell from dying.
+ *
+ * Return: the pidfd, which is always close-on-exec, -EPERM if the caller is in a
+ * cell, -EOPNOTSUPP without a cell, what cell_fork_prepare() has to say about the
+ * cell, or another negative error.
+ */
+int embryo_pidfd_open(int cfd, unsigned int flags)
+{
+	struct embryo *e;
+	struct cell *cell;
+	int ret;
+
+	if (flags & ~(PIDFD_EMPTY | PIDFD_NONBLOCK))
+		return -EINVAL;
+	/* Whatever the file descriptor is. */
+	if (!cell_may_spawn())
+		return -EPERM;
+	/* A task like this outside of a cell makes sense. It is not done yet. */
+	if (cfd == -EBADF)
+		return -EOPNOTSUPP;
+
+	CLASS(fd, f)(cfd);
+	if (fd_empty(f))
+		return -EBADF;
+	cell = cell_from_file(fd_file(f));
+	if (!cell)
+		return -EINVAL;
+
+	e = kzalloc_obj(struct embryo, GFP_KERNEL_ACCOUNT);
+	if (!e)
+		return -ENOMEM;
+	refcount_set(&e->ref, 1);
+	mutex_init(&e->lock);
+	init_completion(&e->done);
+
+	ret = cell_fork_prepare(cell);
+	if (ret) {
+		kfree(e);
+		return ret;
+	}
+	e->pid = alloc_pid_struct(cell_nsproxy(cell)->pid_ns_for_children);
+	e->cell = cell_get(cell);
+	cell_fork_finish(cell);
+
+	ret = -ENOMEM;
+	if (!e->pid)
+		goto err_put;
+	ret = pidfs_add_pid(e->pid);
+	if (ret)
+		goto err_pid;
+	ret = embryo_pidfd_create(e, flags);
+	if (ret >= 0)
+		return ret;
+err_pid:
+	free_pid_struct(e->pid);
+err_put:
+	embryo_put(e);
+	return ret;
+}
+
+/**
+ * embryo_pidfd_is_empty - is there no task yet, rather than no task any more?
+ * @file: a pidfd
+ *
+ * Return: true for what pidfd_open() returned for PIDFD_EMPTY, until there is a
+ * task or it is known that there never will be.
+ */
+bool embryo_pidfd_is_empty(const struct file *file)
+{
+	const struct embryo *e = file->private_data;
+
+	return (file->f_flags & PIDFD_EMPTY) && !READ_ONCE(e->settled);
+}
+
+/**
+ * embryo_pidfd_release - what pidfd_open() returned for PIDFD_EMPTY was closed
+ * @file: the pidfd
+ *
+ * A task that was started is left alone. If there never was one, neither is
+ * there anything to kill.
+ *
+ * Context: The ->release() of the file.
+ */
+void embryo_pidfd_release(struct file *file)
+{
+	struct embryo *e = file->private_data;
+
+	/* Otherwise free_pid() has dropped, or is going to drop, that reference. */
+	if (!pid_has_numbers(e->pid))
+		free_pid_struct(e->pid);
+	embryo_put(e);
+}
diff --git a/kernel/pid.c b/kernel/pid.c
index 0611406e9a9a..9b75daf407ca 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -39,6 +39,7 @@
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/anon_inodes.h>
+#include <linux/cell.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
@@ -760,6 +761,10 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	int fd;
 	struct pid *p;
 
+	/* There is no task to name yet. @pid says where it is going to be. */
+	if (flags & PIDFD_EMPTY)
+		return embryo_pidfd_open(pid, flags);
+
 	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
 		return -EINVAL;
 

-- 
2.55.0

