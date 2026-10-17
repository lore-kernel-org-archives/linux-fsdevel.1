Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902535C1BC
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252196; cv=none; b=ISQVjbftngDqzDS4cTAhccjZyG5vvSJQZlulpxgsQQr6WwPRTswlm5ZDJ0E+azHH1esxbXXJcXG83w/EC4Zy3SscefLWHP3EJaYKB8GRzhzv9u3Hnw8VA7zNBnwHaS/BtS5iVhWmOK60vUN8+ugvbl1Ow4CdasVALgRQCcWiwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252196; c=relaxed/simple;
	bh=EgJX6Oy1WRiWAVKvX2fON5pvsFaJqxF2o17SX4UJtHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfNeNtVn0pX+8VXaA4pNSAlvvepPtbbDtP80evleORkRmHjRiM573W5UB8JP5SB/QIipXZqKR8keXFqZsbY63KxaeMr35PLBoOoVJFk9NRVg/uEYlubdqMCpFj736KXPBXOWkbX/HOfODoaB0htA2oXqWONRVnBE5pOSAqp8iYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckJRxmdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckJRxmdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792252191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fpyd02A29NOi8DLSWCz2R996LjdQgLQ9qsrhJqG9wr8=;
	b=ckJRxmdnhKU+orLF4RPr1jOizEv5AKQAdeP/yExzHFTpKr5jnnWAyHy9z+Z+5SijVuFkHq
	0+lF70aC0P82S1F6OzSXoSDAKAa/BjLyysymTXQcm00JcYMqZMmHYT6ChLe0ABhzQMwVbl
	e9KKo/P/UIjd/TrbL+T7pMQv+QC3xmc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-NgBHafJ3Ne6Dv85a3g4cjw-1; Sat,
 17 Oct 2026 15:49:50 +0000
X-MC-Unique: NgBHafJ3Ne6Dv85a3g4cjw-1
X-Mimecast-MFC-AGG-ID: NgBHafJ3Ne6Dv85a3g4cjw_1792252188
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD4B81800A3F;
	Sat, 17 Oct 2026 15:49:47 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E7CD630001B9;
	Sat, 17 Oct 2026 15:49:44 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sat, 17 Oct 2026 17:49:47 +0200 (CEST)
Date: Sat, 17 Oct 2026 17:49:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: alex.aring@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] add pid::tasks_lock to fix send_sigio() and send_sigurg()
Message-ID: <atOZF5-Xj7vZQ0_h@redhat.com>
References: <atOY-5ZjqVTQw2JE@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atOY-5ZjqVTQw2JE@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

send_sigio() and send_sigurg() assume that do_each_pid_task() is
rcu-safe but it is not. A lockless user can:

	- race with a change_pid() that moves the task to another hlist,
	  and continue to scan the wrong list.

	- race with a copy_process() that adds a new task to the start of hlist,
	  and miss the new child.

As for send_sigio/sigurg in particular, they can also race with de_thread(),
this needs another note.

Add the new per pid lock to protect pid->tasks hlist. Note that detach_pid()
doesn't take this lock, so do_each_pid_task() without tasklist_lock needs
rcu_read_lock().

The "type <= PIDTYPE_TGID" case is wrong too, but this needs another patch.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/fcntl.c          |  4 ++++
 include/linux/pid.h |  1 +
 kernel/pid.c        | 24 +++++++++++++++++++-----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c158f082f1da..74c8a96e64b2 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -930,9 +930,11 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 		rcu_read_unlock();
 	} else {
 		rcu_read_lock();
+		spin_lock(&pid->tasks_lock);
 		do_each_pid_task(pid, type, p) {
 			send_sigio_to_task(p, fown, fd, band, type);
 		} while_each_pid_task(pid, type, p);
+		spin_unlock(&pid->tasks_lock);
 		rcu_read_unlock();
 	}
  out_unlock_fown:
@@ -976,9 +978,11 @@ int send_sigurg(struct file *file)
 		rcu_read_unlock();
 	} else {
 		rcu_read_lock();
+		spin_lock(&pid->tasks_lock);
 		do_each_pid_task(pid, type, p) {
 			send_sigurg_to_task(p, fown, type);
 		} while_each_pid_task(pid, type, p);
+		spin_unlock(&pid->tasks_lock);
 		rcu_read_unlock();
 	}
  out_unlock_fown:
diff --git a/include/linux/pid.h b/include/linux/pid.h
index f5476d7140a3..ca5177fdae81 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -59,6 +59,7 @@ struct pid {
 	refcount_t count;
 	unsigned int level;
 	spinlock_t lock;
+	spinlock_t tasks_lock;
 	struct {
 		u64 ino;
 		struct rhash_head pidfs_hash;
diff --git a/kernel/pid.c b/kernel/pid.c
index 95b8ccfa8269..41fe55fefc3c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -45,9 +45,11 @@
 #include <linux/pidfs.h>
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
+#include "sched/sched.h"	/* double_lock() */
 
 struct pid init_struct_pid = {
 	.count		= REFCOUNT_INIT(1),
+	.tasks_lock	= __SPIN_LOCK_UNLOCKED(init_struct_pid.tasks_lock),
 	.tasks		= {
 		{ .first = NULL },
 		{ .first = NULL },
@@ -193,6 +195,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	pid->level = ns->level;
 	refcount_set(&pid->count, 1);
 	spin_lock_init(&pid->lock);
+	spin_lock_init(&pid->tasks_lock);
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 	init_waitqueue_head(&pid->wait_pidfd);
@@ -396,7 +399,8 @@ void attach_pid(struct task_struct *task, enum pid_type type)
 	lockdep_assert_held_write(&tasklist_lock);
 
 	pid = *task_pid_ptr(task, type);
-	hlist_add_head_rcu(&task->pid_links[type], &pid->tasks[type]);
+	scoped_guard(spinlock, &pid->tasks_lock)
+		hlist_add_head_rcu(&task->pid_links[type], &pid->tasks[type]);
 }
 
 static void __change_pid(struct pid **pids, struct task_struct *task,
@@ -427,10 +431,15 @@ void detach_pid(struct pid **pids, struct task_struct *task, enum pid_type type)
 }
 
 void change_pid(struct pid **pids, struct task_struct *task, enum pid_type type,
-		struct pid *pid)
+		struct pid *new)
 {
-	__change_pid(pids, task, type, pid);
-	attach_pid(task, type);
+	struct pid *old = task->signal->pids[type];
+
+	double_lock(&old->tasks_lock, &new->tasks_lock);
+	__change_pid(pids, task, type, new);
+	hlist_add_head_rcu(&task->pid_links[type], &new->tasks[type]);
+	spin_unlock(&old->tasks_lock);
+	spin_unlock(&new->tasks_lock);
 }
 
 void exchange_tids(struct task_struct *left, struct task_struct *right)
@@ -441,6 +450,7 @@ void exchange_tids(struct task_struct *left, struct task_struct *right)
 	struct hlist_head *head2 = &pid2->tasks[PIDTYPE_PID];
 
 	lockdep_assert_held_write(&tasklist_lock);
+	double_lock(&pid1->tasks_lock, &pid2->tasks_lock);
 
 	/* Swap the single entry tid lists */
 	hlists_swap_heads_rcu(head1, head2);
@@ -452,6 +462,9 @@ void exchange_tids(struct task_struct *left, struct task_struct *right)
 	/* Swap the cached value */
 	WRITE_ONCE(left->pid, pid_nr(pid2));
 	WRITE_ONCE(right->pid, pid_nr(pid1));
+
+	spin_unlock(&pid1->tasks_lock);
+	spin_unlock(&pid2->tasks_lock);
 }
 
 /* transfer_pid is an optimization of attach_pid(new), detach_pid(old) */
@@ -460,7 +473,8 @@ void transfer_pid(struct task_struct *old, struct task_struct *new,
 {
 	WARN_ON_ONCE(type == PIDTYPE_PID);
 	lockdep_assert_held_write(&tasklist_lock);
-	hlist_replace_rcu(&old->pid_links[type], &new->pid_links[type]);
+	scoped_guard(spinlock, &old->signal->pids[type]->tasks_lock)
+		hlist_replace_rcu(&old->pid_links[type], &new->pid_links[type]);
 }
 
 struct task_struct *pid_task(struct pid *pid, enum pid_type type)
-- 
2.55.0


