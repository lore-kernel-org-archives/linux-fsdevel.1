Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891587;
	b=f+MZJZXpKtVLgW5mj7hazFpF7VLk3hToAAulJhGfLyGviFmb4OS+kq6MoXIvmqGUpIAH
	 hgH2sZu9EjcDAzY8jMa8lgy0HKB8FCdGKS6T+AgAvNjyV5CSwf3jk6GYyNNXFlHPDiQlT
	 RKPXJ8F0jJszDhgITjCbreSDZMJ7fDN5/BsF91Xte8dDIn9gvyuvFwhAtYpkk0QjQUZNs
	 NnY0oaBuaZPQbp9rI+L7zK8b9Et5x2B8LcvbIIpHUrdgX4prLGpYJf79MvwR8736jQiVZ
	 U2dHlzxlFjPVy57WipLHF8wvvRw+aRuJzXjMO4W2DhuIHaB69atmZEbDL6PK9rFh4kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7ny/M//RZBtBNDdL4X0Mqb72TXtzJ9xO73FJWenyE0Q=;
	b=Zoev1+rZbwQCd841DjhEWGioocqawGlaSAjsjwj9wb7fBBE1DyxHNSc8sX5g7PIP3Z9V
	 h1tmBU9AoFytVGXo/VhNe24WwDx+mFrsU2bDeYqdUqoUoqAgzieeccscVZB+2EXz5uHfw
	 u+TlD/VpjID7ufQtiTgOxVB/Jam+6gim7E7x0VAXUCg1+Vj2BCD/HZXJYgYaaQ91Ew2p8
	 //4ChDFkZ8W0WlXzO96ME4rmJOCGIQELpgZxAQqxUYn3GuVAmiPerQl5tUkROzvZGyR9I
	 XbSDDqj5YWAOt3hKYNv0nrZg86uzasC3uW4igVKiqNuhB9basLhg1UaRAcYkwnkCClw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QF75Y8vp;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6F606A32F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CA6F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QF75Y8vp
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5365f9a04c5so27599891cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891586; x=1794496386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ny/M//RZBtBNDdL4X0Mqb72TXtzJ9xO73FJWenyE0Q=;
        b=QF75Y8vpCh0kDK9oaoo81D8TImAH6w2ypi5spSFuB7c2aleDBzrC8W4yghrvMFuYrM
         AmGLqhE/RXf7Rwr1f9GKHgoxVAm/BwrMB0LclWGqOUSq5Gr/LOo9Mj1Ke3H3iqWdmtdX
         ESkJdiC5sjCTP7UhTyALCsrwEXRuN+jKxmrgn8OvPB+cSBodjLkg1vNVyG6NTfw8st49
         sa3+S+ChY8xbK4jeAKgt9DZ/SLgGfd0hH7ub7a2xvKXJ0E1ee4edyMlSlXDmEuSVvQpT
         e8PXIQLjlpvIUedmmAKJXRmpxN8S/clOWkgKti8DNHHAD94QF5ArcFQCA/7ldUtFtdFU
         xtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891586; x=1794496386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ny/M//RZBtBNDdL4X0Mqb72TXtzJ9xO73FJWenyE0Q=;
        b=1CVf4S/tUD8nvmSovP9HvHEEiFb+GRBoubQJ3wk9m4AZUe0bkD5Z9+hHWcJhM0+2u4
         BcUAp3nCW/wNAtYTbExlJt/nlt97/UU5QJIn+yneXbgxT2jKumyMrxxZG/lBQohyNpKh
         4u4jE2LbtBb0+5/XXzD7Qqdwsrs87rCqRXicc+BKC6j9oaNM8nqIxDuQ6loaz+yxYQz8
         f+YoxnGE9mxuYX+PgrjZZVQihI9bSz3EoNhyOZLP3s3Mkljq5OAyEf7GroQnbaoQWvUk
         3+d6/+3HPIvlH/WbbXlkzP/rjyaoqda3zM1hJa6e3iukMUnXUhhmh6T/3bHd7HV+iuP8
         zHMQ==
X-Gm-Message-State: APuU4Z91uGoaEqYTf4xETTR2AZOzWjZ4spiUcY7W7n1JKMxazxK+xzlw
	j1+SWucQxyLor81zOaTmA0PxIEcrRpseFUa0MPb8Uc+MDlx2Y5TZnJNnhWBYWDe6+kuhdo4wjE7
	32eHdNfk=
X-Gm-Gg: AYBFou1Mqi3U7Jx7SS7UWQ/1O67p8DTs1V9TrEW1b739LiDuUm1qRkPCdmgW3Qk0l4E
	7SFv+XRzFKU0ZCrj5SR1bL3EOj4jeQpSIgit6q0V7JmdsQN+zDLUlbrA16nlNfZqePv2UFkbkPS
	qlfW9qRX/UfiQ83Tl/ZmHV6appOz30v3MG1vfmsV6NM2B1ezRW3D9hI6QZUtWEZayTgz+Kguhnm
	DKkU+TkwU2mLzVasUBVoC2paBjKcjGjDUELuleGvR9QOFwErz6LmYgnTx/K7+FsqZlt7z8AHpJT
	AhE49nPowcoDYUhjG4/dDHdBCxcVz7Tu0XUPtIxLWLkSxsZrF2qOlwlafQvNXDuABd7Gvl60A+f
	IOJhp4pZMYJXNb5kRpAIZYBojBYbcuj1kLSgpjf0z7pMy61QFbBnjWzNmI1hpY0xnQO92KFmauz
	OTwkEaYkWkquYznRUGOGOEqCDJBu2zQvOqLpg7dwMg9ztgF5cya0dcKAMdDOPGCj5AZ3wYZg0lb
	9rTnIVNEFg/eolvfWsOueonNeybA9jNLHIIB7sV5lJba14WX/pgKiy19qBAGQSZ03FsYCc1jcaQ
	Rby2OvZ8Z3lCIh4h34dkfVESEWQotoJOj9FXnugQ8BPjVw==
X-Received: by 2002:ac8:5e09:0:b0:535:a5f8:a5c7 with SMTP id d75a77b69052e-542b83f1527mr330835401cf.71.1793891585680;
        Thu, 05 Nov 2026 07:13:05 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm53778871cf.20.2026.11.05.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:13:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:27 +0000
Subject: [PATCH RFC v3 35/90] fork: let copy_process() place a task in a
 cell
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
Message-Id: <20261105-b4-cells-v3-35-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=19210;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=sZFWoOad+OJFdd0ecThWtVmMP3DShaKmz82IilX6y8g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE2kBK2RoJSgaPaNs1EOPzQX1adaiNuA3TMSlCdCAjiE6RefUSwbDxnJZ4XFOvztx6TX/35hB7b
 tTfiUerR5wwE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A task is born in a cell. Add kernel_clone_args.cell, and teach the
helpers of copy_process() what to do when it is set:

 - copy_creds() creates credentials that belong to the cell. Everything
   that identifies the spawner is replaced: ids, groups, capabilities,
   keyrings and the user namespace. The LSM state is kept, so that a
   spawner cannot escape its confinement by spawning.
 - copy_namespaces() uses the nsproxy of the cell.
 - copy_fs() starts at the root of the mount tree of the cell.
 - copy_exec_state() creates a new one that is owned by the user namespace
   of the cell.

The task starts as uid 0 of the cell. In a cell with a single id it starts
with that id, and with the supplementary groups of the user who created
the cell. The groups are kept because a group can be used to deny access.

Neither identity comes with any privilege. The permitted, effective and
bounding sets of the task are the capabilities in the "caps" slot, which
apply to the user namespace of the cell.

Add cell_fork_prepare() and cell_fork_finish(), which hold cell->lock
across copy_process(). A kill therefore either happens first, and the
spawn fails, or it waits for the lock and then finds the new task in the
budget.

Nothing sets kernel_clone_args.cell yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h           |  18 ++++
 include/linux/cred.h           |   3 +-
 include/linux/nsproxy.h        |   2 +-
 include/linux/sched/task.h     |   2 +
 include/linux/user_namespace.h |   1 +
 kernel/cell/Makefile           |   1 +
 kernel/cell/spawn.c            | 211 +++++++++++++++++++++++++++++++++++++++++
 kernel/cred.c                  |  21 +++-
 kernel/fork.c                  |  39 ++++++--
 kernel/nsproxy.c               |  23 ++++-
 kernel/user_namespace.c        |  16 ++++
 11 files changed, 321 insertions(+), 16 deletions(-)

diff --git a/include/linux/cell.h b/include/linux/cell.h
index 75dc59518c91..564c3e86f3bd 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -175,4 +175,22 @@ struct cell *cell_from_file(const struct file *file);
 struct dentry **cell_stashed(struct cell *cell);
 #endif
 
+/* A task is born in a cell. */
+#ifdef CONFIG_CELLS
+int cell_fork_prepare(struct cell *cell);
+void cell_fork_finish(struct cell *cell);
+void cell_task_spawned(struct cell *cell);
+int cell_copy_creds(struct cred *new, struct cell *cell);
+struct user_namespace *cell_user_ns(struct cell *cell);
+struct nsproxy *cell_nsproxy(struct cell *cell);
+void cell_root(struct cell *cell, struct path *root);
+struct cgroup *cell_budget(struct cell *cell);
+#else
+static inline int cell_copy_creds(struct cred *n, struct cell *c) { return -EINVAL; }
+static inline struct user_namespace *cell_user_ns(struct cell *cell) { return NULL; }
+static inline struct nsproxy *cell_nsproxy(struct cell *cell) { return NULL; }
+static inline void cell_root(struct cell *cell, struct path *root) { }
+static inline struct cgroup *cell_budget(struct cell *cell) { return NULL; }
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 7fb1663a5fc6..cabde3c1ba31 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -152,7 +152,8 @@ struct cred {
 
 extern void __put_cred(struct cred *);
 extern void exit_creds(struct task_struct *);
-extern int copy_creds(struct task_struct *, u64);
+struct cell;
+int copy_creds(struct task_struct *p, u64 clone_flags, struct cell *cell);
 extern const struct cred *get_task_cred(struct task_struct *);
 extern struct cred *cred_alloc_blank(void);
 extern struct cred *prepare_creds(void);
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 02101d96e4dd..baa7c1acafde 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -95,7 +95,7 @@ static inline struct cred *nsset_cred(struct nsset *set)
  *
  */
 
-int copy_namespaces(u64 flags, struct task_struct *tsk);
+int copy_namespaces(u64 flags, struct task_struct *tsk, struct cell *cell);
 void switch_cred_namespaces(const struct cred *old, const struct cred *new);
 void exit_nsproxy_namespaces(struct task_struct *tsk);
 void get_cred_namespaces(struct task_struct *tsk);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index aca22f08c8f0..eaf939ac4bef 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
+struct cell;
 struct kernel_clone_args {
 	u64 flags;
 	int __user *pidfd;
@@ -46,6 +47,7 @@ struct kernel_clone_args {
 	struct css_set *cset;
 	unsigned int kill_seq;
 	struct pid *pid;
+	struct cell *cell;
 };
 
 /*
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 4a48ead45820..59a081b9aaf6 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -199,6 +199,7 @@ int userns_set_cell_map(struct user_namespace *ns,
 			const struct uid_gid_extent *uids,
 			const struct uid_gid_extent *gids,
 			u32 block, struct ucounts *ucounts);
+void userns_enter_cell(struct cred *cred, struct user_namespace *ns);
 void userns_retire_cell_block(struct user_namespace *ns);
 #endif
 extern int unshare_userns(unsigned long unshare_flags, struct cred **new_cred);
diff --git a/kernel/cell/Makefile b/kernel/cell/Makefile
index 61ca8e9cb216..1a2dcd469d10 100644
--- a/kernel/cell/Makefile
+++ b/kernel/cell/Makefile
@@ -2,3 +2,4 @@
 obj-y += core.o
 obj-y += slots.o
 obj-y += ids.o
+obj-y += spawn.o
diff --git a/kernel/cell/spawn.c b/kernel/cell/spawn.c
new file mode 100644
index 000000000000..70073eff9005
--- /dev/null
+++ b/kernel/cell/spawn.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cells: a task is born in a cell.
+ */
+#include <linux/cgroup.h>
+#include <linux/fs_struct.h>
+#include <linux/key.h>
+#include <linux/pid_namespace.h>
+#include <linux/sched/task.h>
+#include <linux/security.h>
+#include <uapi/linux/cell.h>
+#include <uapi/linux/keyctl.h>
+
+#include "internal.h"
+
+/**
+ * cell_fork_prepare - get ready to create a task in a cell
+ * @cell: the cell
+ *
+ * On success the cell is locked, until cell_fork_finish(). A kill therefore
+ * either comes first, and this fails, or waits and finds the new task in the
+ * budget.
+ *
+ * The pid namespace of the caller must be an ancestor of that of the cell: a
+ * parent can see its children.
+ *
+ * Return: 0, -EPERM if the caller is in a cell, whose "spawn" slot is empty,
+ * -EINVAL if the cell is not sealed or out of the caller's sight,
+ * -ESRCH if it is dying or dead, -EINTR on a fatal signal.
+ */
+int cell_fork_prepare(struct cell *cell)
+{
+	int ret;
+
+	if (!cell_may_spawn())
+		return -EPERM;
+
+	if (mutex_lock_killable(&cell->lock))
+		return -EINTR;
+
+	ret = cell->state == CELL_BUILDING ? -EINVAL : -ESRCH;
+	if (cell->state != CELL_SEALED && cell->state != CELL_RUNNING)
+		goto err;
+	/* The caller must be able to see what it spawns. */
+	ret = -EINVAL;
+	if (!pidns_is_ancestor(cell->pid_ns, task_active_pid_ns(current)))
+		goto err;
+
+	return 0;
+err:
+	mutex_unlock(&cell->lock);
+	return ret;
+}
+
+/**
+ * cell_fork_finish - done creating a task in a cell, one way or the other
+ * @cell: what cell_fork_prepare() succeeded on
+ *
+ * Unlocks the cell.
+ */
+void cell_fork_finish(struct cell *cell)
+{
+	mutex_unlock(&cell->lock);
+}
+
+/**
+ * cell_task_spawned - a task was created in a cell
+ * @cell: the cell
+ *
+ * Context: Between cell_fork_prepare() and cell_fork_finish(), once
+ * copy_process() has succeeded.
+ */
+void cell_task_spawned(struct cell *cell)
+{
+	lockdep_assert_held(&cell->lock);
+
+	if (cell->state == CELL_SEALED)
+		WRITE_ONCE(cell->state, CELL_RUNNING);
+}
+
+/**
+ * cell_user_ns - the user namespace of a cell
+ * @cell: a cell that has not been torn down
+ *
+ * Context: The caller holds the lock of the cell, as between
+ * cell_fork_prepare() and cell_fork_finish().
+ * Return: the user namespace. No reference is taken.
+ */
+struct user_namespace *cell_user_ns(struct cell *cell)
+{
+	return cell->user_ns;
+}
+
+/**
+ * cell_nsproxy - the nsproxy every task of a cell shares
+ * @cell: a sealed cell that has not been torn down
+ *
+ * Context: Between cell_fork_prepare() and cell_fork_finish().
+ * Return: the nsproxy. No reference is taken.
+ */
+struct nsproxy *cell_nsproxy(struct cell *cell)
+{
+	return cell->nsproxy;
+}
+
+/**
+ * cell_root - the root of the tree of a cell
+ * @cell: a sealed cell that has not been torn down
+ * @root: where to return it, with a reference
+ *
+ * Context: Between cell_fork_prepare() and cell_fork_finish().
+ */
+void cell_root(struct cell *cell, struct path *root)
+{
+	*root = cell->root;
+	path_get(root);
+}
+
+/**
+ * cell_budget - the cgroup that is the budget of a cell
+ * @cell: a sealed cell that has not been torn down
+ *
+ * Context: Between cell_fork_prepare() and cell_fork_finish().
+ * Return: the cgroup. No reference is taken.
+ */
+struct cgroup *cell_budget(struct cell *cell)
+{
+	return cell->budget;
+}
+
+/**
+ * cell_copy_creds - make the credentials of a new task of a cell
+ * @new:  a copy of the credentials of the spawner that nobody else can see yet
+ * @cell: the cell
+ *
+ * Nothing that says who the spawner is survives: ids, groups, capabilities,
+ * keyrings and user namespace become those of the cell. The LSM state does
+ * survive, since a spawner must not shed a confinement by spawning.
+ *
+ * The task starts as the root of the cell, or in a one-id cell as the one id, with
+ * the groups of whoever made the cell. Neither comes with anything: it has the
+ * capabilities in the "caps" slot, over the user namespace of the cell, and that
+ * is its bounding set too. In a one-id cell the slot is empty.
+ *
+ * Context: Between cell_fork_prepare() and cell_fork_finish().
+ * Return: 0 or a negative error, in which case the caller discards @new.
+ */
+int cell_copy_creds(struct cred *new, struct cell *cell)
+{
+	struct user_namespace *ns = cell->user_ns;
+	struct group_info *groups;
+	struct user_struct *user;
+	kuid_t uid;
+	kgid_t gid;
+
+	if (cell->ids_count == 1) {
+		uid = ns->owner;
+		gid = ns->group;
+	} else {
+		uid = make_kuid(ns, 0);
+		gid = make_kgid(ns, 0);
+	}
+	if (WARN_ON_ONCE(!uid_valid(uid) || !gid_valid(gid)))
+		return -EINVAL;
+
+	/*
+	 * A one-id cell is its maker as far as files go, and that includes the
+	 * groups that are there to deny it something. It cannot change them.
+	 */
+	if (cell->ids_count == 1)
+		groups = get_group_info(cell->groups);
+	else
+		groups = groups_alloc(0);
+	if (!groups)
+		return -ENOMEM;
+	user = alloc_uid(uid);
+	if (!user) {
+		put_group_info(groups);
+		return -EAGAIN;
+	}
+	free_uid(new->user);
+	new->user = user;
+
+	new->uid = new->euid = new->suid = new->fsuid = uid;
+	new->gid = new->egid = new->sgid = new->fsgid = gid;
+	put_group_info(new->group_info);
+	new->group_info = groups;
+
+	userns_enter_cell(new, ns);
+
+	/*
+	 * What the builder named, for good. The task gets no_new_privs, so it
+	 * gains nothing from a file, or from being uid 0 when it runs one, and
+	 * it cannot make a user namespace to have a full set in.
+	 */
+	new->cap_bset = cell->caps;
+	new->cap_permitted = cell->caps;
+	new->cap_effective = cell->caps;
+
+#ifdef CONFIG_KEYS
+	key_put(new->session_keyring);
+	new->session_keyring = NULL;
+	key_put(new->process_keyring);
+	new->process_keyring = NULL;
+	key_put(new->thread_keyring);
+	new->thread_keyring = NULL;
+	new->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
+#endif
+
+	return set_cred_ucounts(new);
+}
diff --git a/kernel/cred.c b/kernel/cred.c
index 5e10e0bdd11e..3aa1b1e3eade 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "CRED: " fmt
 
 #include <linux/export.h>
+#include <linux/cell.h>
 #include <linux/cred.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -252,16 +253,22 @@ struct cred *prepare_exec_creds(void)
 	return new;
 }
 
-/*
- * Copy credentials for the new process created by fork()
+/**
+ * copy_creds - copy credentials for the new process created by fork()
+ * @p:           the new task
+ * @clone_flags: the flags of the clone
+ * @cell:        the cell @p is born in, or NULL if it stays where its parent is
  *
  * We share if we can, but under some circumstances we have to generate a new
  * set.
  *
  * The new process gets the current process's subjective credentials as its
- * objective and subjective credentials
+ * objective and subjective credentials. One that is born in a cell gets
+ * credentials of that cell instead, see cell_copy_creds().
+ *
+ * Return: 0 or a negative error.
  */
-int copy_creds(struct task_struct *p, u64 clone_flags)
+int copy_creds(struct task_struct *p, u64 clone_flags, struct cell *cell)
 {
 	struct cred *new;
 	int ret;
@@ -297,6 +304,12 @@ int copy_creds(struct task_struct *p, u64 clone_flags)
 			goto error_put;
 	}
 
+	if (cell) {
+		ret = cell_copy_creds(new, cell);
+		if (ret < 0)
+			goto error_put;
+	}
+
 #ifdef CONFIG_KEYS
 	/* new threads get their own thread keyrings if their parent already
 	 * had one */
diff --git a/kernel/fork.c b/kernel/fork.c
index 7937052def66..4db060281448 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -14,6 +14,7 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/slab.h>
+#include <linux/cell.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/user.h>
@@ -1602,10 +1603,20 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_exec_state(u64 clone_flags, struct task_struct *tsk)
+static int copy_exec_state(u64 clone_flags, struct task_struct *tsk,
+			   struct cell *cell)
 {
 	struct task_exec_state *exec_state;
 
+	/* Born in a cell: nothing of the parent's, and not dumpable. */
+	if (cell) {
+		exec_state = alloc_task_exec_state(cell_user_ns(cell));
+		if (!exec_state)
+			return -ENOMEM;
+		rcu_assign_pointer(tsk->exec_state, exec_state);
+		return 0;
+	}
+
 	/* CLONE_VM siblings refcount-share the parent's exec_state. */
 	if (clone_flags & CLONE_VM) {
 		exec_state = rcu_dereference_protected(current->exec_state, true);
@@ -1624,10 +1635,26 @@ enum copy_fs_flags_t {
 };
 
 static int copy_fs(u64 clone_flags, struct task_struct *tsk,
-		   enum copy_fs_flags_t flags)
+		   enum copy_fs_flags_t flags, struct cell *cell)
 {
 	struct fs_struct *fs;
 
+	/* Born in a cell: at the root of the cell's tree. */
+	if (cell) {
+		struct path root;
+
+		fs = copy_fs_struct(current->fs);
+		if (!fs)
+			return -ENOMEM;
+		cell_root(cell, &root);
+		set_fs_root(fs, &root);
+		set_fs_pwd(fs, &root);
+		path_put(&root);
+		fs->umask = 0022;
+		tsk->real_fs = tsk->fs = fs;
+		return 0;
+	}
+
 	/*
 	 * Usermodehelper may copy userspace_init_fs filesystem state but
 	 * they don't get to create mount namespaces, share the
@@ -2147,7 +2174,7 @@ __latent_entropy struct task_struct *copy_process(
 	 * free the parent's ret_stack.
 	 */
 	ftrace_graph_init_task(p);
-	retval = copy_exec_state(clone_flags, p);
+	retval = copy_exec_state(clone_flags, p, args->cell);
 	if (retval)
 		goto bad_fork_free;
 	p->flags &= ~PF_KTHREAD;
@@ -2177,7 +2204,7 @@ __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_PROVE_LOCKING
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
 #endif
-	retval = copy_creds(p, clone_flags);
+	retval = copy_creds(p, clone_flags, args->cell);
 	if (retval < 0)
 		goto bad_fork_free;
 
@@ -2308,7 +2335,7 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p,
 			 (args->umh ? COPY_FS_UMH : 0) |
-			 (args->idle ? COPY_FS_IDLE : 0));
+			 (args->idle ? COPY_FS_IDLE : 0), args->cell);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_sighand(clone_flags, p);
@@ -2320,7 +2347,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_mm(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_signal;
-	retval = copy_namespaces(clone_flags, p);
+	retval = copy_namespaces(clone_flags, p, args->cell);
 	if (retval)
 		goto bad_fork_cleanup_mm;
 	retval = copy_io(clone_flags, p);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index bfdd392f4007..dfe47a235cb5 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -163,16 +163,31 @@ static struct nsproxy *create_new_namespaces(u64 flags,
 	return ERR_PTR(err);
 }
 
-/*
- * called from clone.  This now handles copy for nsproxy and all
- * namespaces therein.
+/**
+ * copy_namespaces - give a new task its namespaces
+ * @flags: the flags of the clone
+ * @tsk:   the new task
+ * @cell:  the cell @tsk is born in, or NULL if it stays where its parent is
+ *
+ * Shares the nsproxy of the parent, or makes a new one with new namespaces for
+ * the CLONE_NEW* in @flags. A task that is born in a cell shares the nsproxy of
+ * the cell.
+ *
+ * Return: 0 or a negative error.
  */
-int copy_namespaces(u64 flags, struct task_struct *tsk)
+int copy_namespaces(u64 flags, struct task_struct *tsk, struct cell *cell)
 {
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
 
+	/* Born in a cell: every task of a cell shares the one nsproxy. */
+	if (cell) {
+		tsk->nsproxy = cell_nsproxy(cell);
+		get_nsproxy(tsk->nsproxy);
+		return 0;
+	}
+
 	if (likely(!(flags & (CLONE_NS_ALL & ~CLONE_NEWUSER)))) {
 		if ((flags & CLONE_VM) ||
 		    likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 5c2cf3dc02c1..e9543bd91329 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -138,6 +138,22 @@ void userns_retire_cell_block(struct user_namespace *ns)
 		pr_warn_ratelimited("cell: kuid block %u retired\n", ns->cell_block - 1);
 	ns->cell_block = 0;
 }
+
+/**
+ * userns_enter_cell - make a credential one of the user namespace of a cell
+ * @cred: a credential that nobody else can see yet
+ * @ns:   the user namespace of a cell
+ *
+ * As for a task that enters a user namespace: a full set of capabilities, which
+ * are good for nothing outside of @ns, and default securebits. The caller sets
+ * the ids and cuts the capabilities down to what the cell is to have. Only a new
+ * task gets credentials this way, nobody enters a cell.
+ */
+void userns_enter_cell(struct cred *cred, struct user_namespace *ns)
+{
+	put_user_ns(cred->user_ns);
+	set_cred_user_ns(cred, get_user_ns(ns));
+}
 #endif
 
 static unsigned long enforced_nproc_rlimit(void)

-- 
2.55.0

