Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891564;
	b=NOpx5ZfbXnWTi9GCEcjFBoVfXtCbHxsSdqz9JA4pOTZAIcliwTMjf3QioDNDTejz/SbP
	 C7BRjpjZK7U2QjKJPQPCLmr2Htiza634UMixO2KYZjpmz8cRQV4egYAGqU/8Go+df1bwW
	 HUngPUA2m62WNy5VOv9lu0FN6QbBDC9NJj4Ar/nn1kPK1UJjFZWofgdsA8/PdlXbI39tP
	 FQkEKty4kry7uEf9NHU+nijFjUrtg73PgeXrDxJTnaI4Ja2jCpNgzbttb9GiU5yjSqtuP
	 Tedjmiz14ZK5uD2EmXXLB9+DoczraV3PEJNVM/K3HUIg9SdE/OCsbicrY84a54x5dVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=U/256XJFR1kvdw1JmGryzLrTO5NQ/CnryI746+heYMg=;
	b=dvhl4f5+4ls6ia+GKIm8FU2t1H6YTOGg5rGJleZNAobTzs65r7LurRPnXLMhdECF/Emj
	 +61QfSq0UqxNAHinnR352a3Zel0XfRTGbyxJjuZSTjpjd/Z2Y3Rz4PJQsuXCi3VZn5htO
	 GECs4fC1LSL2J+OfGxbEivE6hIGI9o6xJjKIB0us3Dr7V750MZauCfv1Cb7t6lX/VMUFQ
	 1LDMVL0MU37s3kEJtDS67502BjBgUi594UT5lHqC3uVW/yuQvLQK1BG/OdtKfHWmxJuaQ
	 oYTHdb4w1Ms8lu0bXplTvjWR8ZJyOuEWyoTE5R6AxsGaWoIdsLbSaNSS319X12juNyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eOfSYhfZ;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E59606A336
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E59606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eOfSYhfZ
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53644b28706so28952971cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891563; x=1794496363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U/256XJFR1kvdw1JmGryzLrTO5NQ/CnryI746+heYMg=;
        b=eOfSYhfZnUVkocJpgPKJCXmZYN++oFaDc9qnTkB8VQnfFIrHcVix/90sHPkP0BRaRR
         dqCc0aGcjnCtbey4cdJBGDdzJSx3Q3nTu3kL69W3YljpkehCgtqS1UWrHd5UPFfAHsAV
         D2rmHs0zzJ/vUxVHCPU0LIUPV1sFEjiu/17fvG0JjIbikHcgM3JYdFWD8i9tvJc2Z8wm
         O7TrOzzYG5T5K6zjP0hMCfzn6kOpAbrWr3pbVkx2p2xpPz19+IL2r2yVsCdRyPWH+2cK
         phzr1UlXslR20eqqCfUGCTgFM9ywfgdGwhvvj1qDPGxhE17KK0PQS0IWuI5pu7XlDF0N
         sQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891563; x=1794496363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/256XJFR1kvdw1JmGryzLrTO5NQ/CnryI746+heYMg=;
        b=zJcplQyqhtS1rtAKzaPBkto3kcxnw7gEmWAhvjfKcg3dcVSQoQNVre93VagN56qG9X
         wZplN6yuLNS3dd+PYy+UHwfIyrdqKC9gAW+jNHBJhaoYwV9hZ+cxIKbKcY8KqsZA7b/C
         8XLepMrifNuPOB+aN7NmNmnClwYYeSInOrzgzi57dHlL1hjKxacWOKtdoaWyDRUtdKVr
         fq5m8OtWJB0huuITCinnvdI1Oid6V4RBDDDyYbf20iOQY8cgPgOvroa+mZdOHUyIde3K
         Ml6ugPoQa227W0Ka+D1JWvbzKvt7ns9zdtWuMyzcx2zuHOgp7Cr/216XDP5buYbCjHyh
         o4Vg==
X-Gm-Message-State: APuU4Z+Ce2tLRJmKaGefW3qAVeJ88ulqhIG5T/HTQvt1SmxfxHF0wTPb
	d1icuRjO7C7Uskdvr+VGxNWa/5h30v+eDZ4342tYKAExWk4o6Y+c7zJ7jh6IzaATRsBr6+2vZK5
	Hlho7oos=
X-Gm-Gg: AYBFou37y2RQUSMjK66u5FZv735batFmzebLMfYhlzwea0DbVXkXP46MLOm8HD4M4T9
	i3xdqvpw064aJ030R2qzkTVe7+6LmT+9zz4rItZYnpX3vL8YVmrswBwNERmdVWWPUhjJ3zi7MDC
	2GZ7rKWV2+Nmtlw70jr5hYFeNJIgj01XvsNlG50pLRery2BE/N43dp/zabduhLS5jAB/zYIA+62
	kzzQhNkjTuGCylPUaom8lbPIfHP0nU2oMVHucO5Sy8TffokFUyBKwnDummui9KvBxBb1tSMyS7S
	J2PFUEEaYFVfln70I86PymO/KDFKtp3ySIiRnmMpezLmfKiO2WyNzfIjyKzg/G2i2uSQbuH/zYW
	X6YVyQe/VgKAiucQGDZVDrV78PDlV6DF9HYfRlGUz2ZDYU+1vBNDM5k1E5gP4FcRJX/7nK58Qzh
	VDCYJmQAOCECLtpea0DS1US+s9fFMnSDvXEtRcywuFnH6b5l79ZzqSvvNIodqmPszADVkDCJDwE
	lezobU43x+J/ltO0h46i7FV3aWP3xzI27WJlBY9U6wMDdZnlZ8TtREDiCISPCdzf8I9rfxeJCis
	9lUFf7BWN2eixr6k0H26NBmoC2+9Cy+WRXktzJuC1J/alZmujGCRYfwLjYBRxV3Fptc=
X-Received: by 2002:a05:620a:a788:20b0:945:f0ca:436a with SMTP id af79cd13be357-945f0ca48demr1247985a.2.1793891563443;
        Thu, 05 Nov 2026 07:12:43 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468f69asm482079385a.1.2026.11.05.07.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:12:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:26 +0000
Subject: [PATCH RFC v3 34/90] pid: allocate a struct pid ahead of its
 numbers
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
Message-Id: <20261105-b4-cells-v3-34-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=7400;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VEEWcPfShIG+AbxmrBWfVb3lHZuCkN5vwM31ISrPZmg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPs+4y2UDDexVbhBorKCMrZMZ/Ns/VfaIL7TlOuRCjGxO64jcEMLAMDULM8QYey+2Lx7QCH0RgD
 fyvBD+uCIVgM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

alloc_pid() does two things. It allocates and initialises a struct pid,
and it assigns the pid a number in its pid namespace and in every ancestor
of that namespace.

Make the first step available on its own:

  - alloc_pid_struct() returns a struct pid that can be referenced, waited
    on and added to pidfs. It has no task and no numbers. So nothing can
    find it, it uses up no pid, and zap_pid_ns_processes() does not count
    it.
  - alloc_pid() can take such a struct pid and assign its numbers.
  - kernel_clone_args.pid passes one to copy_process().
  - free_pid_struct() frees one that never got its numbers.

This makes it possible to create a pidfd before there is a task.

No functional change. Nothing passes a struct pid to alloc_pid() yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/pid.h        | 13 ++++++-
 include/linux/sched/task.h |  1 +
 kernel/fork.c              |  2 +-
 kernel/pid.c               | 93 ++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 91 insertions(+), 18 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 185bf0cde2d1..d590baf155d7 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -183,8 +183,10 @@ extern struct pid *find_vpid(int nr);
 extern struct pid *find_get_pid(int nr);
 extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
 
+struct pid *alloc_pid_struct(struct pid_namespace *ns);
+void free_pid_struct(struct pid *pid);
 extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
-			     size_t set_tid_size);
+			     size_t set_tid_size, struct pid *pid);
 extern void free_pid(struct pid *pid);
 void free_pids(struct pid **pids);
 extern void disable_pid_allocation(struct pid_namespace *ns);
@@ -207,6 +209,15 @@ static inline struct pid_namespace *ns_of_pid(struct pid *pid)
 	return ns;
 }
 
+/*
+ * Has alloc_pid() given it its numbers? It keeps them for good, free_pid() only
+ * gives them back to the pid namespaces.
+ */
+static inline bool pid_has_numbers(const struct pid *pid)
+{
+	return pid->numbers[pid->level].nr;
+}
+
 /*
  * is_child_reaper returns true if the pid is the init process
  * of the current namespace. As this one could be checked before
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 90ed5bc3c7af..aca22f08c8f0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -45,6 +45,7 @@ struct kernel_clone_args {
 	struct cgroup *cgrp;
 	struct css_set *cset;
 	unsigned int kill_seq;
+	struct pid *pid;
 };
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 8b108ed37152..7937052def66 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2334,7 +2334,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	if (pid != &init_struct_pid) {
 		pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid,
-				args->set_tid_size);
+				args->set_tid_size, args->pid);
 		if (IS_ERR(pid)) {
 			retval = PTR_ERR(pid);
 			goto bad_fork_cleanup_thread;
diff --git a/kernel/pid.c b/kernel/pid.c
index adf721606768..0611406e9a9a 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -156,13 +156,75 @@ void free_pids(struct pid **pids)
 			free_pid(pids[tmp]);
 }
 
+/**
+ * alloc_pid_struct - allocate a struct pid that has no numbers yet
+ * @ns: the pid namespace it is going to get its numbers in
+ *
+ * What comes back can be referred to, waited on and added to pidfs. It
+ * has no task and no number in any pid namespace, so nothing finds it and it
+ * keeps no pid namespace from dying. Pass it to alloc_pid() for the numbers.
+ *
+ * Return: the struct pid, to be passed to alloc_pid() or free_pid_struct(), or
+ * NULL.
+ */
+struct pid *alloc_pid_struct(struct pid_namespace *ns)
+{
+	struct pid_namespace *tmp;
+	enum pid_type type;
+	struct pid *pid;
+	int i;
+
+	pid = kmem_cache_alloc(ns->pid_cachep, GFP_KERNEL);
+	if (!pid)
+		return NULL;
+
+	get_pid_ns(ns);
+	pid->level = ns->level;
+	refcount_set(&pid->count, 1);
+	spin_lock_init(&pid->lock);
+	for (type = 0; type < PIDTYPE_MAX; ++type)
+		INIT_HLIST_HEAD(&pid->tasks[type]);
+	init_waitqueue_head(&pid->wait_pidfd);
+	INIT_HLIST_HEAD(&pid->inodes);
+	pidfs_prepare_pid(pid);
+	for (tmp = ns, i = ns->level; i >= 0; tmp = tmp->parent, i--) {
+		pid->numbers[i].nr = 0;
+		pid->numbers[i].ns = tmp;
+	}
+	return pid;
+}
+
+/**
+ * free_pid_struct - free a struct pid that never got its numbers
+ * @pid: what alloc_pid_struct() returned, and no alloc_pid() succeeded on
+ *
+ * Drops the reference that alloc_pid_struct() returned.
+ */
+void free_pid_struct(struct pid *pid)
+{
+	WARN_ON_ONCE(pid_has_numbers(pid));
+	pidfs_remove_pid(pid);
+	call_rcu(&pid->rcu, delayed_put_pid);
+}
+
+/**
+ * alloc_pid - allocate a struct pid with a number in @ns and all its ancestors
+ * @ns:               the pid namespace
+ * @arg_set_tid:      the numbers to use, the most nested pid namespace first
+ * @arg_set_tid_size: how many of them there are
+ * @pid:              what alloc_pid_struct() returned for @ns, or NULL
+ *
+ * A @pid that is passed in has been added to pidfs already. If this fails it is
+ * as it was and still the caller's.
+ *
+ * Return: the struct pid, to be passed to free_pid(), or an ERR_PTR().
+ */
 struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
-		      size_t arg_set_tid_size)
+		      size_t arg_set_tid_size, struct pid *pid)
 {
 	int set_tid[MAX_PID_NS_LEVEL + 1] = {};
 	int pid_max[MAX_PID_NS_LEVEL + 1] = {};
-	struct pid *pid;
-	enum pid_type type;
+	const bool prepared = pid;
 	int i, nr;
 	struct pid_namespace *tmp;
 	struct upid *upid;
@@ -179,26 +241,19 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	 */
 	if (arg_set_tid_size > ns->level + 1)
 		return ERR_PTR(-EINVAL);
+	if (prepared && (ns_of_pid(pid) != ns || pid_has_numbers(pid) || !pid->ino))
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Prep before we take locks:
 	 *
 	 * 1. allocate and fill in pid struct
 	 */
-	pid = kmem_cache_alloc(ns->pid_cachep, GFP_KERNEL);
+	if (!prepared)
+		pid = alloc_pid_struct(ns);
 	if (!pid)
 		return ERR_PTR(retval);
 
-	get_pid_ns(ns);
-	pid->level = ns->level;
-	refcount_set(&pid->count, 1);
-	spin_lock_init(&pid->lock);
-	for (type = 0; type < PIDTYPE_MAX; ++type)
-		INIT_HLIST_HEAD(&pid->tasks[type]);
-	init_waitqueue_head(&pid->wait_pidfd);
-	INIT_HLIST_HEAD(&pid->inodes);
-	pidfs_prepare_pid(pid);
-
 	/*
 	 * 2. perm check checkpoint_restore_ns_capable()
 	 *
@@ -337,6 +392,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	idr_preload_end();
 	ns_ref_active_get(ns);
 
+	if (prepared)
+		return pid;
+
 	retval = pidfs_add_pid(pid);
 	if (unlikely(retval)) {
 		free_pid(pid);
@@ -349,14 +407,17 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	while (++i <= ns->level) {
 		upid = pid->numbers + i;
 		idr_remove(&upid->ns->idr, upid->nr);
+		upid->nr = 0;
 	}
 
 	spin_unlock(&pidmap_lock);
 	idr_preload_end();
 
 out_abort:
-	put_pid_ns(ns);
-	kmem_cache_free(ns->pid_cachep, pid);
+	if (!prepared) {
+		put_pid_ns(ns);
+		kmem_cache_free(ns->pid_cachep, pid);
+	}
 	return ERR_PTR(retval);
 }
 

-- 
2.55.0

