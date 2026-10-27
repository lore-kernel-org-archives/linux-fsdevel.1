Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066310;
	b=lJSMOcdKqczXU36g2qLZpGbtm0jYH4ZlJoEFOlNRkNkKRcM57kAyVtcxiekGBs0hIRhv
	 KHIEsPNoriBPDrrXkGQQ/YIgQ28bNTSn8x36T8zIjgMT/MwDeEI/qv810bi1dLKG+xgWs
	 Ddk/b2a11LdDvgsagwvwVKzjnYHvUK5U2NoML4Rx6ywnVut8RUbG/xyjs62EXP0U3VOUL
	 I2QIx9YhyyD7DzqD8EAz1C/aMJi52BaH/lDO5mRHNgfxpBBk4V+EDL6Qd11CMnZRugl+E
	 GO8ZlZeC01pZewKxMWweXL4otrZN5BD6YngCEajK6HlGLY+6/20+gS0r9K2PLOqgCHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066310;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zGerTi+KuLjHiVyIzxX6cGe2EnK4kfi2ibA95mlZjEE=;
	b=2XJvIOM86t+rU5OLTV1KYyz91jMlbnoR4ObxTwCx7FEel9RkGh+lCP4zD+SM4iuXFl67
	 Q0xzEroCzxDjonj7P5cNlZ32tzzBeZZStbxAhi+36Y2o4E2EW6t9BSZ1gC3AncV/MnKcY
	 hsxGgUwTP5wkTgdrc9CEyr6J5oUeDLqIDbKu7V4BLa2lWof1FxatC9J0gOdk3+JmakzJH
	 ClY4qLlt1npHP35S22fh6QmLP6iH6VHNgQYbCHP2mF7RV5JSjDi48T2ceYDz6lpauk4kK
	 eHP3shPeUVikNHktmh6zF30tTN9ivM3JtPvBL9V05tcYRmoLUgmdLe9JgOXgJ0hsrIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39747606A327;
	Tue, 27 Oct 2026 01:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39747606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xLWS5-009QTg-Tf;
	Mon, 26 Oct 2026 21:58:13 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1] fs_pin: do not trust the pin after a spurious wakeup in pin_kill()
Date: Mon, 26 Oct 2026 21:58:13 -0400
Message-ID: <20261027015813.841821-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task waiting in pin_kill() for another task's ->kill() can take
p->wait.lock after the pin has been freed, and can return with its
on-stack wait entry still on p->wait. With BSD process accounting this
is a use-after-free of the acct structure when umount() of the mount
holding the accounting file races with acct(2).

pin_kill() takes a still-queued entry as proof that pin_remove() has not
run, so p is alive. But autoremove_wake_function() dequeues only when
try_to_wake_up() succeeds: if the waiter was already woken spuriously,
pin_remove() leaves the entry queued, acct_pin_kill() frees the acct
with kfree_rcu(), and the grace period can end while the waiter sits
between schedule() and rcu_read_lock().

Dequeue the entry unconditionally in a private wake function;
pin_remove() is the only waker and sets p->done first.

Reproduced under QEMU with KASAN and test-only delays: a
slab-use-after-free in pin_kill() before the patch, no report after.

Fixes: 59eda0e07f43 ("new fs_pin killing logics")
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    This patch was prepared with the help of an AI tool.
    
    Reproducer (CONFIG_BSD_PROCESS_ACCT, KASAN, preemptible kernel, root; the
    window is a few instructions wide and needs a spurious wakeup, so it only
    hits with these test-only delays):
    
      fs/fs_pin.c, pin_kill(), after the rcu_read_unlock() before schedule():
    	if (!strcmp(current->comm, "pin_waiter")) {
    		__set_current_state(TASK_RUNNING);	/* spurious wakeup */
    		rcu_read_lock();
    		while (READ_ONCE(p->done) <= 0)		/* preempted until */
    			cpu_relax();			/* pin_remove() ran */
    		spin_lock_irq(&p->wait.lock);
    		spin_unlock_irq(&p->wait.lock);
    		rcu_read_unlock();
    		ssleep(10);				/* grace period */
    	}
      kernel/acct.c, acct_pin_kill(), before pin_remove():
    	if (!strcmp(current->comm, "pin_killer"))
    		mdelay(1000);
    
      #define _GNU_SOURCE
      #include <fcntl.h>
      #include <stdio.h>
      #include <sys/mount.h>
      #include <sys/prctl.h>
      #include <sys/wait.h>
      #include <unistd.h>
    
      int main(void)
      {
      	pid_t pid;
    
      	if (mount("tmpfs", "/mnt", "tmpfs", 0, NULL) ||
      	    close(open("/mnt/acct", O_CREAT | O_WRONLY, 0600)) ||
      	    acct("/mnt/acct")) {
      		perror("setup");
      		return 2;
      	}
      	pid = fork();
      	if (pid == 0) {
      		prctl(PR_SET_NAME, "pin_waiter");
      		usleep(200000);
      		/* the last mntput runs mnt_pin_kill() on return to user space */
      		if (umount("/mnt"))
      			perror("umount");
      		_exit(0);
      	}
      	prctl(PR_SET_NAME, "pin_killer");
      	if (acct(NULL))		/* runs acct_pin_kill() */
      		perror("acct");
      	waitpid(pid, NULL, 0);
      	printf("pin_race: done\n");
      	return 0;
      }
    
      boot with kasan_multi_shot slab_debug=FZPU, run as root:
      before: BUG: KASAN: slab-use-after-free in _raw_spin_lock_irq
              Write of size 4 ... by task pin_waiter
               pin_kill
               mnt_pin_kill
               cleanup_mnt
              (allocated in sys_acct, freed by kfree_rcu after acct_pin_kill)
      after:  no report

 fs/fs_pin.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index 1a508f2167e0a..a4e5a5a7aca8d 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -28,6 +28,19 @@ void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 	spin_unlock(&pin_lock);
 }
 
+/*
+ * Unlike autoremove_wake_function(), dequeue even if the waiter was already
+ * running: pin_kill() trusts @p only while its entry is still queued.
+ */
+static int pin_kill_wake_function(struct wait_queue_entry *wait,
+				  unsigned int mode, int sync, void *key)
+{
+	int ret = default_wake_function(wait, mode, sync, key);
+
+	list_del_init_careful(&wait->entry);
+	return ret;
+}
+
 void pin_kill(struct fs_pin *p)
 {
 	wait_queue_entry_t wait;
@@ -36,7 +49,7 @@ void pin_kill(struct fs_pin *p)
 		rcu_read_unlock();
 		return;
 	}
-	init_wait(&wait);
+	init_wait_func(&wait, pin_kill_wake_function);
 	spin_lock_irq(&p->wait.lock);
 	if (likely(!p->done)) {
 		p->done = -1;

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.53.0

