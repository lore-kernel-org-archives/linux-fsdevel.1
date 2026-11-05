Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890686;
	b=gTUcxxqLcWMf+h/5GMuft2h8thYgt4GqBUv6a4Y0lXh44M75tmD73jLK2RNIzRfdFYwW
	 zcnPAGLJIh+YTBiSCjIv5/faCAYHgrhnc7cgwCA0+L3PbSJPW1UAc5ybheaR+nJnPqYSG
	 ETNU3e80Kfp1TFEHkmq4A6T+PlYWZ0z/jK31WZv+/qNRdXt0gB/7wAa9ECwpUXTCrEMia
	 mviWHVmhKxSvTiTM2ZWChgdK0i1vZxozSRQwOPLULwmaQ9vetKDOBPRMgABPnvLoPrDe9
	 1dhl98/bNFOf6xHevkwpmfxO14mDb+6UCd6f79r4CETgqkxOgQ0yUIwTS4nJVQTMfVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=MPGcXNqz02SDF/XdOLnmb2aUdUJzPRwohB5pLRAuLm4=;
	b=VVzp9edrpTWlRXJV0JryeZfV6tRswoYqmLN6AaJH+0oAGJICo3zQzjX9a84icSxFnRSr
	 PHSjLjVAVNzuOVEwGoHSlGzo36OENcjugDia4bIswGZT2cSmdQNoFQgQXUzQe8rhks24t
	 jrrIfy+ipDmpnR1DfiZvUGjInrtHr6/OIiR/85Z6RfRAWWhApxrxszOuk+fUVIyfqhiLM
	 3dKcsqWBJNqGc3aULsduLaLTeNmSKZRt3eI3jA2kx3/pvSzDHXUfy+dj2vV6XT4XNNhz3
	 ZLXZZ4NcK674viR5BhtC/oqhUncfM3ObYNj8apF/rKN7BzR3ZT30YwaFp0SJ+OvcM3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="eW/aKaZH";
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97182606A334
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97182606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eW/aKaZH
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4ad60ec5eaaso775420fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890684; x=1794495484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MPGcXNqz02SDF/XdOLnmb2aUdUJzPRwohB5pLRAuLm4=;
        b=eW/aKaZHJMbGoFcZGndVIeP26RaH+9/2ir9QBQVAL76KmuEa3T3AOIBqA12PbiCHf/
         TAcdzOtaEBYVdtmatRL5zWLLBIRC65tcFYfXTQ0ts8+l04Kj0bVzb4cg9iD8iLP1SYr4
         TsrxiZC3Nqn3l7z9CjWcDiFDIn58J7uQuZd7SxnVSTYHODYrIXYT8PqOn4dVB+cg9oNc
         w9z63U/qKjLLovYgqN9OrH03LeilrtpghEky2KigA16m5GiKQXj+ik1zPZu27uGyDzEr
         xuRnCSmQRgqQ/fxudMSVYGBOQB64LeSOly1vWP/2DZQxQ69W+Q3SHf0lM45FDDnew35F
         DVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890684; x=1794495484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPGcXNqz02SDF/XdOLnmb2aUdUJzPRwohB5pLRAuLm4=;
        b=sGEc7qaqpl3XVBrxlbvIRB8TosQBHc96Mob8NJA6QacE9zju9zypGzZXEaFJekL9ue
         pEUIORw8ZYtHTsMjfMJvdlLFeXmTBBw4bCVc/I+mDRYAAQmyWSNK1s5PfybXOtPbHgpZ
         zKqEQnJGp8Z6AJR21AZaM7Sr/xYWdL7AUJ+fHnT2wJUoWCSbz1thRPtXDCF0fXzjlpGb
         BdNAy1Z4Uf+uIpGPNwFB1n2+XPfVsfDgTdSKeg5IG+JGojd4UpKBiLGjc3XiOHNPrqtU
         ExDPUKWU6+pRkdMEH9FLi1M0LoPAYUddoKlMOuYnsCOsfzeewctx5rdiYxCpyRbaKNRt
         VLAw==
X-Gm-Message-State: APuU4Z+5m4bBTkKQXdDhv16uP9gifpzcW1+F7V6tugti/E9DrbrIqUN0
	CEWBj5G9aj23dqtP6IzDQZ2XZHp0GOZREypD2yeM6p/cdrStLj3Y94tPiYshLyb/Hxo=
X-Gm-Gg: AYBFou3bOExxpeknFZWkMNmsg3T5aXPIaalUZvZFHfn5Y4SQU3aBfKarVaAA6DFxU7t
	TdeJslWHwdIuki6pIQBeUXGSY/nrl3/cvo9z28WZtHSriOjGL7B6RKK+UyvAkv0QHdbSNwGifBc
	X7vCYk4xBIts2dQbSpqTl7SbKxreAw7MTQ7pfzVCNBlBRKr6vxtr4xpZPJAs2TgxLto5XeEq8F9
	Tl0sL6tNn0EtDkDqfmtWofBYufQXOsZROpFiWBfUQ5Cq82M24d/IoK0q5YyOoc/HxqCNSsGPIwM
	CDCasi+RNLdqWDU9qnZ+I6IrzPdrWR9QX6IqoRZJcx6+7GaTGRwBe6fa+TBYU3K3gD2VRCJU0zp
	2jZiKiU9m61eQRSoyPzfCDAfElk0l4aNWoqHGvL5Su3+7UyKZIZBt56XBKcaUHWjkAvhMX+Ql8T
	qXUEpN90j1xPl4TS7I22t0J+1zcc5dJ1mcNr+tQJxiAIoY0+KAE4vd8xX2B8PFqZi2Qg6mkFjFu
	5bKZwxMyrPW+n0UJ10udjE4DDLoB14Aft0lAZhN59evjezaO+x+kW2AfnG4WpYD56vkzQXOxx8+
	5efD9BSzbDHJlutOGUFW++uIBBNoq7ndsBqnAxahvSDMpQc=
X-Received: by 2002:a05:6871:4720:b0:4a8:15a:b062 with SMTP id 586e51a60fabf-4ad6b1469femr1496384fac.25.1793890684070;
        Thu, 05 Nov 2026 06:58:04 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61f0c0sm4772860fac.14.2026.11.05.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:56:55 +0000
Subject: [PATCH RFC v3 04/90] user_namespace: let a cell own a user
 namespace
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
Message-Id: <20261105-b4-cells-v3-4-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=10179;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eUZOcoIoypgnFgaps302hu5NQsLtssPteblxsyzxXh4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH8VYjsQGjbnDX4P0rjvtc77fJN9w1ZaSmpUKpa1D0j3OtuRpsNF2G/Pya5lgV4XLr67JUSxdJ8
 0myOOuIPhVA0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Every user of a kuid in the kernel already knows how to deal with user
namespaces. So give each cell one user namespace, which the kernel creates
together with the cell.

Add create_cell_user_ns(). The namespace holds a reference on its cell for
as long as the namespace exists. The pointer to the cell is set before
anybody else can find the namespace.

This makes the user namespace the link from a credential to its cell. Add
the accessors cred_cell(), current_cell(), task_cell() and a few more.
They return NULL for a task that is in no cell. Because the cell is found
through the credential, override_creds() and file->f_cred work without any
extra code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h           | 148 +++++++++++++++++++++++++++++++++++++++++
 include/linux/cell_ids.h       |   4 ++
 include/linux/user_namespace.h |   7 ++
 kernel/user_namespace.c        |  56 +++++++++++++++-
 4 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/include/linux/cell.h b/include/linux/cell.h
new file mode 100644
index 000000000000..6a65d035ffca
--- /dev/null
+++ b/include/linux/cell.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CELL_H
+#define _LINUX_CELL_H
+
+/*
+ * Cells, see Documentation/userspace-api/cells.rst.
+ *
+ * Each group of declarations below comes with its own stubs for a kernel
+ * without CONFIG_CELLS.
+ */
+
+#include <linux/cell_ids.h>
+#include <linux/cred.h>
+#include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/stat.h>
+#include <linux/uidgid.h>
+#include <linux/user_namespace.h>
+
+struct cell;
+struct cgroup;
+struct file;
+struct kernel_clone_args;
+struct nsproxy;
+struct path;
+struct pid;
+struct task_struct;
+
+/* Who is in which cell. */
+#ifdef CONFIG_CELLS
+
+/**
+ * userns_cell - the cell a user namespace belongs to
+ * @ns: a user namespace
+ *
+ * Return: the cell, or NULL if @ns is a legacy user namespace. No reference is
+ * taken: @ns holds one for as long as it lives.
+ */
+static inline struct cell *userns_cell(const struct user_namespace *ns)
+{
+	return ns->cell;
+}
+
+/**
+ * cred_cell - the cell a credential belongs to
+ * @cred: a credential
+ *
+ * The cell is reached through the user namespace of the credential, so it
+ * follows override_creds() and file->f_cred without any help.
+ *
+ * Return: the cell, or NULL for the host. No reference is taken: @cred pins its
+ * user namespace, which pins the cell.
+ */
+static inline struct cell *cred_cell(const struct cred *cred)
+{
+	return userns_cell(cred->user_ns);
+}
+
+/**
+ * current_cell - the cell the caller acts in
+ *
+ * Goes by the subjective credentials, so a caller that has overridden its
+ * credentials acts in the cell of those.
+ *
+ * Return: the cell, or NULL for the host.
+ */
+static inline struct cell *current_cell(void)
+{
+	return cred_cell(current_cred());
+}
+
+/**
+ * task_cell - the cell a task is in
+ * @task: a task
+ *
+ * A task is born in a cell and never changes cell.
+ *
+ * Context: The caller holds rcu_read_lock(), or otherwise keeps the objective
+ * credentials of @task from going away.
+ * Return: the cell, or NULL for the host.
+ */
+static inline struct cell *task_cell(const struct task_struct *task)
+{
+	return cred_cell(__task_cred(task));
+}
+
+/**
+ * cell_same - do two credentials belong to the same cell?
+ * @a: a credential
+ * @b: another
+ *
+ * Across cells an equal uid means nothing: a one-id cell runs on the kuid of
+ * whoever made it. A check that lets one task act on another because their uids
+ * are equal asks this as well, and otherwise falls back to whatever capability
+ * check it has.
+ *
+ * Return: true if both belong to the same cell, or both to the host.
+ */
+static inline bool cell_same(const struct cred *a, const struct cred *b)
+{
+	return cred_cell(a) == cred_cell(b);
+}
+
+u64 cell_id(const struct cell *cell);
+
+/**
+ * cred_cell_id - the id of the cell a credential belongs to
+ * @cred: a credential
+ *
+ * For where a cell has to be remembered beyond the life of anything that pins
+ * it. Ids are never reused, so they can be compared at any later time.
+ *
+ * Return: the id of the cell, or 0 for the host.
+ */
+static inline u64 cred_cell_id(const struct cred *cred)
+{
+	struct cell *cell = cred_cell(cred);
+
+	return cell ? cell_id(cell) : 0;
+}
+
+/**
+ * current_cell_id - the id of the cell the caller acts in
+ *
+ * Return: the id of the cell, or 0 for the host.
+ */
+static inline u64 current_cell_id(void)
+{
+	return cred_cell_id(current_cred());
+}
+
+struct cell *cell_get(struct cell *cell);
+void cell_put(struct cell *cell);
+
+#else
+
+static inline struct cell *userns_cell(const struct user_namespace *ns) { return NULL; }
+static inline struct cell *cred_cell(const struct cred *cred) { return NULL; }
+static inline struct cell *current_cell(void) { return NULL; }
+static inline struct cell *task_cell(const struct task_struct *t) { return NULL; }
+static inline bool cell_same(const struct cred *a, const struct cred *b) { return true; }
+static inline u64 cred_cell_id(const struct cred *cred) { return 0; }
+static inline u64 current_cell_id(void) { return 0; }
+static inline void cell_put(struct cell *cell) { }
+
+#endif
+
+#endif /* _LINUX_CELL_H */
diff --git a/include/linux/cell_ids.h b/include/linux/cell_ids.h
index df0b874d5788..dcb0a559d0e9 100644
--- a/include/linux/cell_ids.h
+++ b/include/linux/cell_ids.h
@@ -53,9 +53,13 @@ static inline bool cell_range_in_window(u32 first, u32 count)
 	return first <= CELL_ID_WINDOW_LAST && last >= CELL_ID_WINDOW_FIRST;
 }
 
+bool userns_is_cell(const struct user_namespace *ns);
+
 #else
 
 static inline bool cell_id_in_window(u32 id) { return false; }
 static inline bool cell_range_in_window(u32 first, u32 count) { return false; }
+static inline bool userns_is_cell(const struct user_namespace *ns) { return false; }
+
 #endif
 #endif /* _LINUX_CELL_IDS_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 91232053775d..5c8cf31ab9d4 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -40,6 +40,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
 #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
 
 struct ucounts;
+struct cell;
 
 enum ucount_type {
 	UCOUNT_USER_NAMESPACES,
@@ -117,6 +118,9 @@ struct user_namespace {
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 	struct binfmt_misc *binfmt_misc;
 #endif
+#ifdef CONFIG_CELLS
+	struct cell		*cell;		/* whose namespace this is, counted */
+#endif
 } __randomize_layout;
 
 struct ucounts {
@@ -184,6 +188,9 @@ static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 }
 
 extern int create_user_ns(struct cred *new);
+#ifdef CONFIG_CELLS
+int create_cell_user_ns(struct cred *new, struct cell *cell);
+#endif
 extern int unshare_userns(unsigned long unshare_flags, struct cred **new_cred);
 extern void __put_user_ns(struct user_namespace *ns);
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index cd748e1cbace..9301d0d41cb9 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -2,6 +2,7 @@
 
 #include <kunit/visibility.h>
 #include <linux/export.h>
+#include <linux/cell.h>
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
@@ -64,6 +65,21 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 	cred->user_ns = user_ns;
 }
 
+#ifdef CONFIG_CELLS
+/**
+ * userns_is_cell - is this the user namespace of a cell?
+ * @ns: a user namespace
+ *
+ * Out of line for the headers that cannot see into struct user_namespace.
+ *
+ * Return: true if it is, false for a legacy user namespace.
+ */
+bool userns_is_cell(const struct user_namespace *ns)
+{
+	return ns->cell;
+}
+#endif
+
 static unsigned long enforced_nproc_rlimit(void)
 {
 	unsigned long limit = RLIM_INFINITY;
@@ -83,8 +99,10 @@ static unsigned long enforced_nproc_rlimit(void)
  *
  * This is called by copy_creds(), which will finish setting the target task's
  * credentials.
+ *
+ * @cell is the cell the namespace is made for, or NULL for a legacy one.
  */
-int create_user_ns(struct cred *new)
+static int __create_user_ns(struct cred *new, struct cell *cell)
 {
 	struct user_namespace *ns, *parent_ns = new->user_ns;
 	kuid_t owner = new->euid;
@@ -162,6 +180,11 @@ int create_user_ns(struct cred *new)
 	if (!setup_userns_sysctls(ns))
 		goto fail_keyring;
 
+#ifdef CONFIG_CELLS
+	/* Before anybody can find it. */
+	if (cell)
+		ns->cell = cell_get(cell);
+#endif
 	set_cred_user_ns(new, ns);
 	ns_tree_add(ns);
 	return 0;
@@ -175,6 +198,34 @@ int create_user_ns(struct cred *new)
 	return ret;
 }
 
+/**
+ * create_user_ns - create a new, legacy, user namespace
+ * @new: the credentials to derive the creator from, and to put into it
+ *
+ * Return: 0 or a negative error.
+ */
+int create_user_ns(struct cred *new)
+{
+	return __create_user_ns(new, NULL);
+}
+
+#ifdef CONFIG_CELLS
+/**
+ * create_cell_user_ns - create the user namespace of a cell
+ * @new:  a scratch credential, as for create_user_ns()
+ * @cell: the cell
+ *
+ * The namespace holds a reference on @cell for as long as it lives, and knows
+ * its cell before anybody can find it.
+ *
+ * Return: 0 or a negative error.
+ */
+int create_cell_user_ns(struct cred *new, struct cell *cell)
+{
+	return __create_user_ns(new, cell);
+}
+#endif
+
 int unshare_userns(unsigned long unshare_flags, struct cred **new_cred)
 {
 	struct cred *cred;
@@ -221,6 +272,9 @@ static void free_user_ns(struct work_struct *work)
 #endif
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
+#ifdef CONFIG_CELLS
+		cell_put(ns->cell);
+#endif
 		ns_common_free(ns);
 		/* Concurrent nstree traversal depends on a grace period. */
 		kfree_rcu(ns, ns.ns_rcu);

-- 
2.55.0

