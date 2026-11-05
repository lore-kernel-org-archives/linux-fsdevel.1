Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891832;
	b=xEYef/vCD0XaqcST4jURfsHvxLDH1R2NzE60m2vIwiVVXWCWqGhpovtKCYgSaHnJqXp8
	 cWq5+v8HLJXgRSt4HBJ2Ka9m9tO3VaHDXo07YzxX2wXahkHVTcQFlw0lVvWZh/ulAKaKK
	 c6c92832Ap8adcoxj9tJDCROgybV9UJEhVtY02QT3xGyCnXTZPyTG7dSuDBgqy0Q6WUhG
	 LTirR7R144+Bxom87lbX6H3cc/Ffoyskq7BlbTFjRi2bGpoxVedpkD+QvA6x24YKml1Oy
	 v9LX6xphUIm2R0gxduyz/c5XKKO2guG/Mc8UpRB8fzZURPyChZc8bknq55rGFBww89A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=aoPWauBSyVHKPl2oUi1lGa4ZT6nCDPFRYidMRl6RqhM=;
	b=sz4v+6jJZ+AEGOx7EHmDM2hMAs2Z11PG/mkq+om/4nuykosXQQJTShP5ZXTnPJ3foEJ2
	 7anvDDiwUq6KlFVH+co53VEb8MLwxn9Yt2RRqn93nxYCbmaStosenHdUyWTy/uAW7+wtX
	 Ffx6oNx+8kHxb/vgU/w7fmFH+5iWWwMHQYj51PQi5kwMcsfweZZ4GHTsmre5DxSz66VZ/
	 L/ugXR3uZBdoO4KTBdB/Ji98WOhUIwQy/XMnLw2HEzsEIdLSWZ5FQs+Xd5Ip3BAJOieCe
	 7cJ0TuUEXM/sNPVO1weeTVB9OyWvKuFhTZHufRAVlSE66v0LN6Hln44RD66pzE8jE1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CGMPFFJb;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CDF6082BEC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19CDF6082BEC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CGMPFFJb
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b331cad3cfso4435367b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891831; x=1794496631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoPWauBSyVHKPl2oUi1lGa4ZT6nCDPFRYidMRl6RqhM=;
        b=CGMPFFJbayl7AKoKBdcePsu1H19b+8mZQaGdjNkKxUdaAKhHb3xbgSmXTeH6FHDtIS
         7uKS+AvhNMPk4XM2mysj3yAPFFVjrdgwtusROnqMXYcZts5PlIDrLkEn7r9YgV/QkY4f
         sJYYxKaC0UbPxPULy8TdOyHS+8tMuxI7FBbeIUjFDfsVbs1DWlYDAAr7/FVSG9f55hR1
         7Eqr1yhE8m69Dj6ihG5BrRtoaBswDIX40VItZrF9mZHEGC+aRUd8wKo7Yq4nm9ZhxPo+
         0/uyh6PQbCWb/7oI4LWe3puVzHhtO8Ya29RAKXrhT610cyFOM1klOPGp9MeNFATyZuAw
         zMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891831; x=1794496631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoPWauBSyVHKPl2oUi1lGa4ZT6nCDPFRYidMRl6RqhM=;
        b=WcqrWuW3f1XK3/8drwUGO1xr2VSEZqj91LWwBj9Otxcz2eyB0f9fjXlkKEYYdMK7Fn
         pzxmHN7+VU3Uxc/fIOaAsDlh00CTt7cGvS9byPDmzi64ScYxPiqrkEB+BEZbVMxqwZHY
         QbhwIJ4/bKTnvunm1Hid+HXkIorMt4hbsIzbD/9w3Sg3QhNunJtayyXywpNTsAMSlUFw
         ePrrzEvFbmfFSVFEu75Dyvm9i+4S2eWUBSdF06N8i2LJWI9CbAJHtwtE43IVwXjs881l
         koZn29JJA9/ysJu5lAqDgrR6d9mJFJT+Jt2bMaWuwA5cL2bz8EjSkoio0UzLlTQwzL8r
         b3wA==
X-Gm-Message-State: APuU4Z+p5/Mb92rxVjWtttlil3LBgvVWTTgJT1r1rlweKBzusftLWmDR
	nJRXLykrFRr/6XgCWKLEfWeBh6SSoNZbDqAHRKBBdSOTqYkl+pvOP3wahHsOiK9SOr4=
X-Gm-Gg: AYBFou2Wr71F+15DQTnqQy6YBhGGp4CFPfwy50TbYGWZGhreocmgLS+JFAY/jO0odhV
	oyiM26POQvgSmVLCpsL9XZ6PcAeOn3lWulu9ak9Hettzr/8OpdD1wu4Voy1oxKC7C5Stybflgeo
	7IZg/nNE2wR9zTG3jfeYogJE5eCbc4E4a2tFng3A+OwuVdZrHXuSJzF7GQRYiNKeceXuolrtf4C
	uv0oWNY7PLXIRoZzS+FAVxxiHb1OaKMpA4YjTtZxD9JtHRU93NgpK8RbwcAIgyP84SCzjgGz6MX
	Uhnj2+BdQwz8eNxBPhsDLw1gh6dgHKxS6bUySFc+AF2EZa9fcYJ4F22DIMr9LeatGozueno15yN
	DM8pF02kkZ2VSrKsoYw11sAFcmKv5uMaGAUrs37WaJ8OJt25m5JSJHcujn8RyMtb94bC3C9kHkv
	MqHOHIQ8FHTD9DkUKE77IHu4ebEKvNgzFmJlgpVly80qLzRO3wT/+1VFY55FsdOw/waIH/X2tVq
	xZypEW/uBXhfucyRVYElFHtOKulx+GwsrlAqx/HYnYS4O2KScz0RtTwiFemAf+EhaV13NM1QsXe
	55MLRPIJKBQCBxlrGFJ1WYIY9PwkLHMzdImgO/4gp1DC2A==
X-Received: by 2002:a05:690c:498f:b0:8b3:1261:e79d with SMTP id 00721157ae682-8b31261ea4fmr33164897b3.33.1793891830814;
        Thu, 05 Nov 2026 07:17:10 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bd1672sm42085697b3.43.2026.11.05.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:17:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:38 +0000
Subject: [PATCH RFC v3 46/90] cells: end a cell when its init exits
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
Message-Id: <20261105-b4-cells-v3-46-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=5281;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=icqex354zf4o5sksQppsVP1wXnBQ1CMP576psdYWpks=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLkFrcfUZwg1+3O/Mj95ZhKUBstSAbFHFFjE1PvHa4Q1pUS1bF3xdXNgJJOZu2oWFeTC9qOe885
 wZsTPvijKdgE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The first task that is spawned into a cell is the init of its pid
namespace. When it exits, the kernel kills everything else in that
namespace, as it does for every pid namespace. That is also the end of the
cell.

Notify the cell from exit_notify(), after zap_pid_ns_processes(). The cell
records the exit status and queues a work item for the rest. The work item
kills whatever may still be in the budget, waits until the budget is no
longer populated, tears the cell down, and only then sets the state to
DEAD.

The waiting is needed because the init itself keeps the budget populated
until it has been scheduled out for the last time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h |  7 +++++++
 kernel/cell/core.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/exit.c        | 14 ++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/cell.h b/include/linux/cell.h
index a68638b7319d..86999efc083d 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -228,4 +228,11 @@ static inline bool embryo_pidfd_is_empty(const struct file *file) { return false
 static inline void embryo_pidfd_release(struct file *file) { }
 #endif
 
+/* The end of a cell. */
+#ifdef CONFIG_CELLS
+void cell_init_exited(struct cell *cell, struct task_struct *tsk);
+#else
+static inline void cell_init_exited(struct cell *cell, struct task_struct *tsk) { }
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/kernel/cell/core.c b/kernel/cell/core.c
index b9494b5fd7b9..c780094ad794 100644
--- a/kernel/cell/core.c
+++ b/kernel/cell/core.c
@@ -172,6 +172,53 @@ static void cell_kill_workfn(struct work_struct *work)
 	cell_put(cell);
 }
 
+static void cell_exit_workfn(struct work_struct *work)
+{
+	struct cell *cell = container_of(to_delayed_work(work), struct cell,
+					 exit_work);
+
+	scoped_guard(mutex, &cell->lock) {
+		if (cell->state == CELL_DEAD)
+			break;
+		WRITE_ONCE(cell->state, CELL_DYING);
+		/*
+		 * DEAD means gone. zap_pid_ns_processes() has reaped everything
+		 * else in the pid namespace, but the init itself is still on
+		 * its way out. It populates the budget until it is off the cpu
+		 * for good. Come back until then.
+		 */
+		if (cgroup_cell_kill(cell->budget)) {
+			queue_delayed_work(system_dfl_wq, &cell->exit_work,
+					   max(HZ / 100, 1));
+			return;
+		}
+		cell_teardown(cell);
+	}
+	cell_put(cell);
+}
+
+/**
+ * cell_init_exited - the init of the pid namespace of a cell is gone
+ * @cell: the cell
+ * @tsk:  the last thread of that init, which is the caller
+ *
+ * With its init everything else in the pid namespace is gone, and so the cell.
+ * This notes the exit status and owes the teardown to a work item.
+ *
+ * Context: The exit path of @tsk, after zap_pid_ns_processes(), with no locks
+ * held. The cell has not been torn down, since only this sets that off once a
+ * cell has run anything.
+ */
+void cell_init_exited(struct cell *cell, struct task_struct *tsk)
+{
+	cell->exit_status = (tsk->signal->flags & SIGNAL_GROUP_EXIT) ?
+			    tsk->signal->group_exit_code :
+			    tsk->group_leader->exit_code;
+	cell_get(cell);
+	if (!queue_delayed_work(system_dfl_wq, &cell->exit_work, 0))
+		cell_put(cell);
+}
+
 /* The cellfd. */
 
 static int cell_file_open(struct inode *inode, struct file *file)
@@ -286,6 +333,7 @@ SYSCALL_DEFINE2(cell_create, int, parent, unsigned int, flags)
 	mutex_init(&cell->lock);
 	init_waitqueue_head(&cell->wait);
 	INIT_WORK(&cell->kill_work, cell_kill_workfn);
+	INIT_DELAYED_WORK(&cell->exit_work, cell_exit_workfn);
 	strscpy(cell->hostname, "(none)");
 
 	/* The scratch credential is only here to carry the new namespace. */
diff --git a/kernel/exit.c b/kernel/exit.c
index d5e7bc2af804..1ae82e7ac29f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/cell.h>
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/mm.h>
@@ -741,11 +742,20 @@ static void forget_original_parent(struct task_struct *father,
  */
 static void exit_notify(struct task_struct *tsk, int group_dead)
 {
+	struct cell *cell = NULL;
 	bool autoreap;
 	struct task_struct *p, *n;
 	LIST_HEAD(dead);
 
 	write_lock_irq(&tasklist_lock);
+	/*
+	 * Is this the end of the init of a cell? Asked of the pid namespace
+	 * and not of the task, and asked now: once the lock is dropped the
+	 * parent may reap us, pids and all. The cell holds on to its pid
+	 * namespace until it is torn down, which only this sets off.
+	 */
+	if (group_dead && is_child_reaper(task_tgid(tsk)))
+		cell = userns_cell(ns_of_pid(task_tgid(tsk))->user_ns);
 	forget_original_parent(tsk, &dead);
 
 	if (group_dead)
@@ -776,6 +786,10 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		wake_up_process(tsk->signal->group_exec_task);
 	write_unlock_irq(&tasklist_lock);
 
+	/* With its init, and so everything else in it, gone, so is a cell. */
+	if (cell)
+		cell_init_exited(cell, tsk);
+
 	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
 		list_del_init(&p->ptrace_entry);
 		release_task(p);

-- 
2.55.0

