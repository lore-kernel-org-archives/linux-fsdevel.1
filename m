Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891337;
	b=1DMiRT4yu1IZmA4i1sldrE2slGzwnmx89T4+OoRAGw1cqJCIsq535UFOaES+RlkLvqKN
	 ug0DwGbMeIDWepv5lbMsYvc3797o7T9tF5ttmQhdR/oLo0JbFdQjh43v7+BKmYETPeTcI
	 EUSGj3zZ5dMXCpQU7l8pgLpcissBRLcMPdes4CP0CAgw5CF4b/4w2k8LAGy7TVXwFEYkI
	 xiHcFSCZDayAimgsCY9OVQaNS2p4G7mcjcj6Sd3HpL06ZDP3ypEPkOCXGzol7jVsXL0z8
	 Pbpngjrxow9mN/nqa7FYiBJr+SRICmb3AX3D7WtM5cwSWNI8CHIZ6dBvzPwlYhkBySA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=dY68tvJnp6gWamN+k8DNUEp72LNVYh68JCB4JZkYFGE=;
	b=cA+wz05O5QmFQUrgUvp0Ewx1EjtCimWvNULGRqNKW/LdBNseVssTiUyBPBvEH7Z/WQQs
	 zGJ80g8HoinycH/E9iFmvzGdn7Qcspd5rAOSezpR1532uWWZxA2dKt4vLpiwR5p1GHuMR
	 Aj4MOqdBf4+2W2M4o3lxtouu2LzQ3AxjhiLd0lOJPdqkEVpfuOv3I+cEmkbRDXKxY8wzW
	 +xdYOkYVgiymescXK80rmaWJhXNoX9h6Va9Cy53KR1WX9SVXVDqPKX8AV9mGMw72vVSoY
	 mCR4tj/ZuLs4ne713mZa0TiumGbtf2RsCFjKPHNpliRMAb9dBilpRa4PK75wD6u0bzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=UCJFSlFY;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B53606A332
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B53606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=UCJFSlFY
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5363c8de563so20420961cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891335; x=1794496135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dY68tvJnp6gWamN+k8DNUEp72LNVYh68JCB4JZkYFGE=;
        b=UCJFSlFY9e2m8JcC4xYidTZVrhNfdRLuXsMQB7mLhrliYB8EpgjnWHhmF9EQb6o1v9
         HioOSQ6LOFx7rHImAEkHw3S9K2KYLj6hUbZyYEE8tWaEb/v1urDJNldtOaFTxq7xnrf2
         G6V95zrkiZhr+IQ48s7JkmDPfQhTP1P5z7dvVR4qqZsJ7Ra65+XtTx8nbznMggyEaxcE
         MOoZzIXPnDS/ENlbrcMuDZdXUNEMOk7e/5cmqH0JmZHeZ5dKcOt0UKr2R4ual0z9JPjT
         PDY5fM0SEgq/urKqwjQJZ0JFzcCIb699Rrnt9ucuxjSKR7egxzIotq4CWC54DrV2N8Cs
         ETEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891336; x=1794496136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dY68tvJnp6gWamN+k8DNUEp72LNVYh68JCB4JZkYFGE=;
        b=JagBB3/934Iv5s+L0SgNkJ/5y5u+rz3yQ5V1WWVadD+3txmzA91D8vSHBHXZmZOIXg
         hUzwSBJYQrWuj7bSHrjZZqGWAAPvtwLsOawT5+IsGAPWU/9nQl3ehQofyOzekKCTA287
         fZotBSTBeGWj4KbvYqAPbFf2K5eZGbmDp6KFzMDQNjhqcmX5G+j5lhD5A9+xNaO8vVTX
         wTEmKzXA93g/3umV39UV/Pqn2kSELtEtAphhM3r8RZ4niH53nh5MkHvlBV1468ocbWH8
         D1BpACd3G0NNny/bCcC4i4oPP1LbNb+dvwNFP3cbOS0wtJooacRBLxSBhz6U3zjGZTKG
         GTUw==
X-Gm-Message-State: APuU4Z/RJ8yzHykmHgdZ4bugpk32hkeMlWQt9CIJ7aGJl05nZs7GcWdH
	wfKTYxgLPE1HH1tBnuREwJZzrlJKFpTA63XVtmUQxwMsUdDFPk8TVYju0NMpxX8rf8Q=
X-Gm-Gg: AYBFou1d5Eqrfz6vP9pAdTjJ9k8y+KG0W3t7rkeFn5z7O8tEVAc8kkErAtaVs8DlvNU
	gUPb+e5a7P5fnbHSHy5S8AmKP8xitKVOA77FZ5NLAoZdwPEkyZQkFgxIbKO8fbTbzDxu1m57d8E
	FEwNC+5qOnpcAISs7ibH+vPoUA4sbCaNjv1WE8eVc8xu/tKztUOc/6SkUDBvVwoaAzrHqgp8yTd
	MPIBqji9tnj9d/FVn2qC0nLQufvcx43Sxwtx20g3bwOdF4zLFQ42AyjPZsxiCcvwLHEzbh1U9QM
	uZbtm12CrW7AKPwHjf4d+1xA/j3NXyCrfz0D3XX4J9VMb7oyO5c2sY77aBZdSPCBQ/RzrW91ahJ
	pzGSh5L+F+u/jsp73MNFKt7qVq5w7pxuhuRCwT3lc4H684ghWokBquMy6YqtWzoPmtmUEhlb2Z3
	i4NfyD86FH5Z6fTNY2zYKdwsZAs5lwxrwG0dnF0pGfTOFFLKpamixHR7jYeNqLBsnLrBIhoqgfF
	R584oJZfmYgXHM2HeMM1qsSP6OFyrORrNFtPb6lyttjN50cGGLVm5c/W53zFy9pX3p70KFmfQl+
	K2dijufU+f3wC7Knh5a9lp9kKSFKKnusEm2qU/nElpywPw==
X-Received: by 2002:a05:622a:2b0f:b0:535:2521:f07c with SMTP id d75a77b69052e-542b3c7330bmr308825631cf.7.1793891335226;
        Thu, 05 Nov 2026 07:08:55 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a7ab83sm53518841cf.13.2026.11.05.07.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:08:52 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:16 +0000
Subject: [PATCH RFC v3 24/90] cells: add the cell object and cell_create()
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
Message-Id: <20261105-b4-cells-v3-24-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890932; l=20453;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=C442R3ZTPv8OvTRA52vJxT3/LzychJ0G+Uagg7R58ms=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD8OGVI92/yAU4Nq1jhF0XpHZ7sMLtIWtIizbKubQhKRXBcLPThrecMGwouH3saoBLA0m6PXP28
 5IcXQR1Hs0AU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add the cell object in kernel/cell/, a small filesystem called cellfs that
backs its file descriptor, and the system call cell_create().
cell_create() creates a new, empty cell and returns a cellfd. It requires
no privilege. A task of a cell cannot call it, see cell_may_spawn().

A cell goes through the states BUILDING, SEALED, RUNNING, DYING and DEAD,
in that order and never backwards. This patch implements the two ends: a
cell that holds only its user namespace, and the teardown that drops
whatever a cell holds.

The cellfd becomes readable for poll() once the cell is DEAD. read() then
returns the wait status of the first task of the cell. DEAD is only
reported after the budget is empty and the cell has dropped all of its
references.

A cellfd can be passed to another process, but it cannot be reopened
through /proc/<pid>/fd. So when the last cellfd is closed nobody can reach
the cell any more, and the cell is killed. If the process that created the
cell is killed, the cell dies with it, unless the cellfd was passed on. A
cell without a cellfd could not be killed, spawned into or waited for.

Every cell has a 64 bit id that is never reused. It is meant for code that
has to remember a cell for longer than anything pins it. It is also the
inode number of the cellfd. cell_id() is exported, because some of that
code can be built as a module.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/cellfs.c                | 141 ++++++++++++++++++++
 include/linux/cell.h       |  23 ++++
 include/uapi/linux/cell.h  |  24 ++++
 include/uapi/linux/fcntl.h |   1 +
 include/uapi/linux/magic.h |   1 +
 kernel/cell/Makefile       |   2 +
 kernel/cell/core.c         | 312 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/cell/internal.h     |  62 +++++++++
 8 files changed, 566 insertions(+)

diff --git a/fs/cellfs.c b/fs/cellfs.c
new file mode 100644
index 000000000000..744ed39abbba
--- /dev/null
+++ b/fs/cellfs.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cellfs: the pseudo filesystem a cellfd lives on.
+ *
+ * Modelled on pidfs. One inode per cell, numbered by the cell's id, which is
+ * never reused. The inode holds a reference on the cell.
+ */
+#include <linux/cell.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/magic.h>
+#include <linux/mount.h>
+#include <linux/pseudo_fs.h>
+
+#include "internal.h"
+
+static struct vfsmount *cellfs_mnt __ro_after_init;
+
+static void cellfs_evict_inode(struct inode *inode)
+{
+	struct cell *cell = inode->i_private;
+
+	clear_inode(inode);
+	cell_put(cell);
+}
+
+static const struct super_operations cellfs_sops = {
+	.drop_inode	= inode_just_drop,
+	.evict_inode	= cellfs_evict_inode,
+	.statfs		= simple_statfs,
+};
+
+static char *cellfs_dname(struct dentry *dentry, char *buffer, int buflen)
+{
+	return dynamic_dname(buffer, buflen, "cell:[%llu]",
+			     d_inode(dentry)->i_ino);
+}
+
+static const struct dentry_operations cellfs_dentry_operations = {
+	.d_dname	= cellfs_dname,
+	.d_prune	= stashed_dentry_prune,
+};
+
+static int cellfs_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
+			  struct iattr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct inode_operations cellfs_inode_operations = {
+	.setattr	= cellfs_setattr,
+};
+
+static int cellfs_init_inode(struct inode *inode, void *data)
+{
+	struct cell *cell = data;
+
+	inode->i_private = data;
+	inode->i_flags |= S_PRIVATE | S_ANON_INODE;
+	inode->i_mode |= 0700;
+	inode->i_op = &cellfs_inode_operations;
+	inode->i_fop = &cell_file_operations;
+	inode->i_ino = cell_id(cell);
+	return 0;
+}
+
+static void cellfs_put_data(void *data)
+{
+	cell_put(data);
+}
+
+static const struct stashed_operations cellfs_stashed_ops = {
+	.init_inode	= cellfs_init_inode,
+	.put_data	= cellfs_put_data,
+};
+
+static int cellfs_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, CELL_FS_MAGIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->s_d_flags |= DCACHE_DONTCACHE;
+	ctx->ops = &cellfs_sops;
+	ctx->dops = &cellfs_dentry_operations;
+	fc->s_fs_info = (void *)&cellfs_stashed_ops;
+	return 0;
+}
+
+static struct file_system_type cellfs_type = {
+	.name			= "cellfs",
+	.init_fs_context	= cellfs_init_fs_context,
+	.kill_sb		= kill_anon_super,
+};
+
+/**
+ * cell_from_file - the cell a file is a handle on
+ * @file: any file
+ *
+ * Return: the cell, or NULL if @file is no cellfd. No reference is taken: @file
+ * pins the inode, which holds one.
+ */
+struct cell *cell_from_file(const struct file *file)
+{
+	if (file->f_op != &cell_file_operations)
+		return NULL;
+	return file_inode(file)->i_private;
+}
+
+/**
+ * cellfs_alloc_file - make a new handle on a cell
+ * @cell: the cell. The caller keeps its own reference
+ *
+ * This is the only way to a handle. A cellfd cannot be opened again through
+ * /proc/<pid>/fd.
+ *
+ * Return: a file open for reading and writing, or an ERR_PTR().
+ */
+struct file *cellfs_alloc_file(struct cell *cell)
+{
+	struct path path __free(path_put) = {};
+	int ret;
+
+	ret = path_from_stashed(cell_stashed(cell), cellfs_mnt, cell_get(cell),
+				&path);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return dentry_open(&path, O_RDWR, current_cred());
+}
+
+static int __init cellfs_init(void)
+{
+	cellfs_mnt = kern_mount(&cellfs_type);
+	if (IS_ERR(cellfs_mnt))
+		panic("Failed to mount cellfs pseudo filesystem");
+	return 0;
+}
+fs_initcall(cellfs_init);
diff --git a/include/linux/cell.h b/include/linux/cell.h
index 37fde4bfea44..75dc59518c91 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -69,6 +69,20 @@ static inline struct cell *current_cell(void)
 	return cred_cell(current_cred());
 }
 
+/**
+ * cell_may_spawn - may the caller make cells and start tasks in them?
+ *
+ * This is the "spawn" slot of the cell the caller acts in. There is nothing to
+ * fill it with yet, so it is always empty, and the host holds everything. That
+ * no cellfd gets into a cell is not what this rests on.
+ *
+ * Return: true if it may.
+ */
+static inline bool cell_may_spawn(void)
+{
+	return !current_cell();
+}
+
 /**
  * task_cell - the cell a task is in
  * @task: a task
@@ -137,6 +151,7 @@ void cell_put(struct cell *cell);
 static inline struct cell *userns_cell(const struct user_namespace *ns) { return NULL; }
 static inline struct cell *cred_cell(const struct cred *cred) { return NULL; }
 static inline struct cell *current_cell(void) { return NULL; }
+static inline bool cell_may_spawn(void) { return true; }
 static inline struct cell *task_cell(const struct task_struct *t) { return NULL; }
 static inline bool cell_same(const struct cred *a, const struct cred *b) { return true; }
 static inline u64 cred_cell_id(const struct cred *cred) { return 0; }
@@ -152,4 +167,12 @@ void cell_block_release(u32 block);
 static inline void cell_block_release(u32 block) { }
 #endif
 
+/* The cellfd. */
+#ifdef CONFIG_CELLS
+extern const struct file_operations cell_file_operations;
+struct file *cellfs_alloc_file(struct cell *cell);
+struct cell *cell_from_file(const struct file *file);
+struct dentry **cell_stashed(struct cell *cell);
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/include/uapi/linux/cell.h b/include/uapi/linux/cell.h
new file mode 100644
index 000000000000..f3589a23a596
--- /dev/null
+++ b/include/uapi/linux/cell.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_CELL_H
+#define _UAPI_LINUX_CELL_H
+
+#include <linux/types.h>
+
+/*
+ * A cell is a container: one kernel object that a task is born into and never
+ * leaves. It is built from the outside, by filling named slots from file
+ * descriptors the builder holds, and then sealed.
+ */
+
+/* cell_create(): @parent is CELL_SELF, see <linux/fcntl.h>. */
+
+/* Life of a cell. It only ever moves down this list. */
+enum cell_state {
+	CELL_BUILDING		= 0,	/* Slots may be filled */
+	CELL_SEALED		= 1,	/* Immutable, nothing spawned yet */
+	CELL_RUNNING		= 2,	/* Has, or had, its first task */
+	CELL_DYING		= 3,	/* Killed, or its init exited */
+	CELL_DEAD		= 4,	/* Nothing left. The status can be read */
+};
+
+#endif /* _UAPI_LINUX_CELL_H */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index e43e3de3e9ee..951c97e47e99 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -125,6 +125,7 @@ struct delegation {
 #define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
 #define FD_NSFS_ROOT			-10003 /* Root of the nsfs filesystem */
 #define FD_FAILFS_ROOT			-10004 /* Root of the failfs filesystem */
+#define CELL_SELF			-10005 /* The caller's own cell */
 #define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 66a91c8b1cb9..093e68790b47 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -107,5 +107,6 @@
 #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
 #define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
 #define FAIL_FS_MAGIC		0x4641494C	/* "FAIL" */
+#define CELL_FS_MAGIC		0x43454C4C	/* "CELL" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/kernel/cell/Makefile b/kernel/cell/Makefile
new file mode 100644
index 000000000000..e343e0fa72b0
--- /dev/null
+++ b/kernel/cell/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += core.o
diff --git a/kernel/cell/core.c b/kernel/cell/core.c
new file mode 100644
index 000000000000..d0243779af19
--- /dev/null
+++ b/kernel/cell/core.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cells: a container as one kernel object.
+ *
+ * A task is born in a cell and never leaves it. There is no way to enter one.
+ * A cell is built from the outside: the builder fills named slots from file
+ * descriptors it holds, seals the cell, and spawns the first task into it.
+ * Holding the cellfd is the authority to do all of that.
+ *
+ * Life:  BUILDING -> SEALED -> RUNNING -> DYING -> DEAD
+ *
+ * References. The cell owns a reference on its user namespace until it is torn
+ * down. The user namespace owns a reference on the cell until it is freed, so
+ * that current_cell() can be followed from any credential. Teardown breaks the
+ * cycle, and every cell is torn down: by a kill, by the exit of its first task,
+ * or by the last cellfd going away before anything ran.
+ *
+ * Locking. cell->lock serialises configuration, sealing, spawning and killing.
+ * It is held across copy_process(), which is what closes a kill against a spawn
+ * in flight. It nests outside cgroup_mutex and namespace_sem.
+ */
+#include <linux/cgroup.h>
+#include <linux/fs.h>
+#include <linux/mnt_namespace.h>
+#include <linux/nsproxy.h>
+#include <linux/pid_namespace.h>
+#include <linux/poll.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <net/net_namespace.h>
+#include <uapi/linux/cell.h>
+
+#include "internal.h"
+
+static atomic64_t cell_next_id = ATOMIC64_INIT(0);
+
+/**
+ * cell_id - the id of a cell
+ * @cell: a cell
+ *
+ * Return: the id. It is never 0, which stands for the host, and never reused.
+ */
+u64 cell_id(const struct cell *cell)
+{
+	return cell->id;
+}
+EXPORT_SYMBOL_GPL(cell_id);
+
+/**
+ * cell_stashed - where cellfs keeps the dentry of a cell
+ * @cell: a cell
+ *
+ * Return: the location to hand to path_from_stashed().
+ */
+struct dentry **cell_stashed(struct cell *cell)
+{
+	return &cell->stashed;
+}
+
+/**
+ * cell_get - take a reference on a cell
+ * @cell: a cell the caller already holds a reference on
+ *
+ * A reference keeps the memory of the cell around and nothing else. It neither
+ * keeps the cell alive nor is it a handle on it.
+ *
+ * Return: @cell.
+ */
+struct cell *cell_get(struct cell *cell)
+{
+	refcount_inc(&cell->ref);
+	return cell;
+}
+
+/**
+ * cell_put - drop a reference on a cell
+ * @cell: a cell, or NULL
+ *
+ * Context: Process context. The cell is freed after a grace period.
+ */
+void cell_put(struct cell *cell)
+{
+	if (!cell || !refcount_dec_and_test(&cell->ref))
+		return;
+	if (cell->groups)
+		put_group_info(cell->groups);
+	kfree_rcu(cell, rcu);
+}
+
+/*
+ * Teardown. Drops every reference the cell holds and only then says DEAD. What
+ * that sets off, the release of mounts, of the network namespace and of the
+ * block of ids, completes on its own time.
+ */
+static void cell_teardown(struct cell *cell)
+{
+	struct cgroup *budget = cell->budget;
+
+	lockdep_assert_held(&cell->lock);
+
+	/* cell_may_migrate() looks at this under nothing but RCU. */
+	WRITE_ONCE(cell->budget, NULL);
+
+	if (cell->nsproxy)
+		put_nsproxy(cell->nsproxy);
+	cell->nsproxy = NULL;
+	path_put(&cell->root);
+	memset(&cell->root, 0, sizeof(cell->root));
+	if (cell->mnt_ns)
+		put_mnt_ns(cell->mnt_ns);
+	cell->mnt_ns = NULL;
+	if (cell->pid_ns)
+		put_pid_ns(cell->pid_ns);
+	cell->pid_ns = NULL;
+	if (cell->net)
+		put_net(cell->net);
+	cell->net = NULL;
+	if (budget) {
+		/*
+		 * The ids of the cell were only lent, so nothing may go on
+		 * being owned by them. If that cannot be had, the block is
+		 * never handed out again.
+		 */
+		if (cgroup_cell_budget_put(budget, cell->sealed, cell->budget_uid,
+					   cell->budget_gid))
+			userns_retire_cell_block(cell->user_ns);
+	}
+	put_user_ns(cell->user_ns);
+	cell->user_ns = NULL;
+
+	/* Pairs with the acquire of whoever goes on to read the status. */
+	smp_store_release(&cell->state, CELL_DEAD);
+	wake_up_all(&cell->wait);
+}
+
+static void cell_kill_locked(struct cell *cell)
+{
+	lockdep_assert_held(&cell->lock);
+
+	switch (cell->state) {
+	case CELL_BUILDING:
+	case CELL_SEALED:
+		/* Nothing ever ran. */
+		cell->exit_status = SIGKILL;
+		cell_teardown(cell);
+		break;
+	case CELL_RUNNING:
+		WRITE_ONCE(cell->state, CELL_DYING);
+		fallthrough;
+	case CELL_DYING:
+		/* The exit of the cell's init finishes the job. */
+		cgroup_cell_kill(cell->budget);
+		break;
+	case CELL_DEAD:
+		break;
+	}
+}
+
+static void cell_kill(struct cell *cell)
+{
+	guard(mutex)(&cell->lock);
+	cell_kill_locked(cell);
+}
+
+/* The last cellfd is gone, and there is no way to get another. */
+static void cell_kill_workfn(struct work_struct *work)
+{
+	struct cell *cell = container_of(work, struct cell, kill_work);
+
+	cell_kill(cell);
+	cell_put(cell);
+}
+
+/* The cellfd. */
+
+static int cell_file_open(struct inode *inode, struct file *file)
+{
+	/*
+	 * A handle is handed out, by cellfs_alloc_file(), and passed on. It is
+	 * not opened again through /proc/<pid>/fd: the inode is immutable, so
+	 * may_open() refuses that for writing, and this refuses the rest.
+	 */
+	if (!(file->f_mode & FMODE_WRITE))
+		return -ENXIO;
+
+	return 0;
+}
+
+static int cell_file_release(struct inode *inode, struct file *file)
+{
+	struct cell *cell = inode->i_private;
+
+	/*
+	 * A cell has the one file that cell_create() made, however many file
+	 * descriptors refer to it. Nobody can reach the cell any more, and there
+	 * is no way to get another handle, so it goes: a cell lives for as long
+	 * as somebody holds it. The last fput() may come from anywhere, so only
+	 * owe the kill here.
+	 */
+	cell_get(cell);
+	if (!queue_work(system_dfl_wq, &cell->kill_work))
+		cell_put(cell);
+	return 0;
+}
+
+static bool cell_is_dead(struct cell *cell)
+{
+	/* Pairs with the release in cell_teardown(): the status is there. */
+	return smp_load_acquire(&cell->state) == CELL_DEAD;
+}
+
+static __poll_t cell_file_poll(struct file *file, poll_table *pts)
+{
+	struct cell *cell = cell_from_file(file);
+
+	poll_wait(file, &cell->wait, pts);
+	if (cell_is_dead(cell))
+		return EPOLLIN | EPOLLRDNORM;
+	return 0;
+}
+
+/* Reads the wait status of the cell's first task. Repeatable. */
+static ssize_t cell_file_read(struct file *file, char __user *buf, size_t count,
+			      loff_t *ppos)
+{
+	struct cell *cell = cell_from_file(file);
+	__s32 status;
+	int ret;
+
+	if (count < sizeof(status))
+		return -EINVAL;
+
+	if (!cell_is_dead(cell)) {
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		ret = wait_event_interruptible(cell->wait, cell_is_dead(cell));
+		if (ret)
+			return ret;
+	}
+
+	status = cell->exit_status;
+	if (copy_to_user(buf, &status, sizeof(status)))
+		return -EFAULT;
+	return sizeof(status);
+}
+
+const struct file_operations cell_file_operations = {
+	.open		= cell_file_open,
+	.release	= cell_file_release,
+	.poll		= cell_file_poll,
+	.read		= cell_file_read,
+	.llseek		= noop_llseek,
+};
+
+/**
+ * sys_cell_create - make a new, empty cell
+ * @parent: CELL_SELF
+ * @flags:  none yet, must be 0
+ *
+ * The cell holds nothing, is in state CELL_BUILDING and can already be killed.
+ * It takes no privilege beyond what making a user namespace takes. A task of a
+ * cell cannot make one.
+ *
+ * Return: a cellfd, which is always close-on-exec, or a negative error.
+ */
+SYSCALL_DEFINE2(cell_create, int, parent, unsigned int, flags)
+{
+	struct cell *cell;
+	struct cred *cred;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+	if (parent != CELL_SELF)
+		return -EINVAL;
+	if (!cell_may_spawn())
+		return -EPERM;
+
+	cell = kzalloc_obj(struct cell, GFP_KERNEL_ACCOUNT);
+	if (!cell)
+		return -ENOMEM;
+
+	refcount_set(&cell->ref, 1);
+	cell->id = atomic64_inc_return(&cell_next_id);
+	mutex_init(&cell->lock);
+	init_waitqueue_head(&cell->wait);
+	INIT_WORK(&cell->kill_work, cell_kill_workfn);
+	strscpy(cell->hostname, "(none)");
+
+	/* The scratch credential is only here to carry the new namespace. */
+	cred = prepare_creds();
+	if (!cred) {
+		kfree(cell);
+		return -ENOMEM;
+	}
+	ret = create_cell_user_ns(cred, cell);
+	if (ret) {
+		abort_creds(cred);
+		kfree(cell);
+		return ret;
+	}
+	cell->user_ns = get_user_ns(cred->user_ns);
+	cell->groups = get_group_info(cred->group_info);
+	abort_creds(cred);
+
+	ret = FD_ADD(O_CLOEXEC, cellfs_alloc_file(cell));
+	if (ret < 0)
+		cell_kill(cell);
+	cell_put(cell);
+	return ret;
+}
diff --git a/kernel/cell/internal.h b/kernel/cell/internal.h
new file mode 100644
index 000000000000..01a7a8581ff7
--- /dev/null
+++ b/kernel/cell/internal.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _KERNEL_CELL_INTERNAL_H
+#define _KERNEL_CELL_INTERNAL_H
+
+#include <linux/capability.h>
+#include <linux/cell.h>
+#include <linux/file.h>
+#include <linux/mutex.h>
+#include <linux/path.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/uidgid.h>
+#include <linux/utsname.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#define CELL_KEY_MAX	64
+
+struct cell {
+	refcount_t		ref;
+	u64			id;
+	struct dentry		*stashed;
+
+	struct mutex		lock;
+	unsigned int		state;		/* enum cell_state */
+
+	/* Gone once the cell is DEAD. */
+	struct user_namespace	*user_ns;
+	u32			ids_count;
+	struct group_info	*groups;	/* of whoever made the cell */
+
+	/* Slots. */
+	struct mnt_namespace	*mnt_ns;
+	struct pid_namespace	*pid_ns;
+	struct net		*net;
+	struct cgroup		*budget;
+	u64			budget_id;
+	kuid_t			budget_uid;	/* who owned it before */
+	kgid_t			budget_gid;
+	bool			sealed;		/* the budget was handed over */
+	char			hostname[__NEW_UTS_LEN + 1];
+	kernel_cap_t		caps;		/* what a task starts with */
+
+	/* What sealing makes of them. */
+	struct nsproxy		*nsproxy;
+	struct path		root;
+
+	int			exit_status;
+	wait_queue_head_t	wait;
+	struct work_struct	kill_work;
+	struct delayed_work	exit_work;
+	struct rcu_head		rcu;
+};
+
+static inline struct cell *cell_from_fd(const struct fd *f)
+{
+	if (fd_empty(*f))
+		return ERR_PTR(-EBADF);
+	return cell_from_file(fd_file(*f)) ?: ERR_PTR(-EINVAL);
+}
+
+#endif /* _KERNEL_CELL_INTERNAL_H */

-- 
2.55.0

