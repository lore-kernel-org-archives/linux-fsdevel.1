Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80575342C98;
	Sat, 23 May 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779523430; cv=none; b=ACW0DqVhbjVoBPdHZXcdHfCkaAzW7PKEgD5o/YaiMQjM+b9Zmjvo6ExyJ8I1YCYE4vMhR5lSMcjYk94zd3P9RFodrTxnsrwjx/wRR057LHVbCLRT47RJ8JzRd/RWPZHL7EHGEO/dJKDWb8lp0u/sztf3NgIXMViv5TlhgOVzLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779523430; c=relaxed/simple;
	bh=ZKv0DHuJ0UAVX4X/01s5lP/LTiBEZ8FT6iMX1uisUl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jFFOfC4H6gECBm5sBrv1UhLMIE1aa3cYTomMegCt0jDrNYQXAd+gdbHGxUbjaaylLL861NXwwA16XL0ak2R9v76AatX9bPiJgn0LIXsQNsuOtqCwRiyTsEvkQ+JrTO9DQBSpnmA0DK1KZH4sdk/8Bdlo+uNH6C9b6SUvwh4GNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CGpJwjHc; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CGpJwjHc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jn
	wYYCMReQic1eYkXST/0EqG6eqS5U7GMD2YDTh672o=; b=CGpJwjHcygGoCWdkWv
	XIa3fG3mPXNz46XQn2okI1ryT5MW1uoylMedvzqByNIuIEm3FD7mgmtRRv65yYpt
	7oQ+folAoucXpC36sF1ev3ee94Bg0TVvVyvhTvEPf3FVf2sJqDx1m9yinwWdpBtf
	uT8RW/qsMJDc2iU8/4dmeBb2U=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnHRUxXxFqG07pCw--.29947S2;
	Sat, 23 May 2026 16:03:07 +0800 (CST)
From: w15303746062@163.com
To: jlayton@kernel.org,
	chuck.lever@oracle.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: alex.aring@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] fs/fcntl: fix SOFTIRQ-unsafe lock order in send_sigio()
Date: Sat, 23 May 2026 16:02:55 +0800
Message-Id: <20260523080255.585201-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnHRUxXxFqG07pCw--.29947S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryDZw15Xr4kZr1xuw4xtFb_yoW5JF1xpF
	9Fg3sakr4UZ3409F1UA3y09r4rWwn7WrWUWFy8t3ySkry5Xry3XFyxKry3XFy5K39rZFs8
	XF45Jr48Cw4kZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5_-PUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4xvEqGoRXzvUfgAA3h

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A SOFTIRQ-safe to SOFTIRQ-unsafe lock order deadlock can occur in
send_sigio() when a process group receives a SIGIO.

When FASYNC is configured for a process group (PIDTYPE_PGID),
send_sigio() uses read_lock(&tasklist_lock) to traverse the task
list. However, send_sigio() is often called from softirq context
(e.g., input_inject_event -> kill_fasync), where it already holds
SOFTIRQ-safe locks like &dev->event_lock and &f_owner->lock.

The deadlock is caused by the rwlock writer fairness mechanism:
1. CPU 0 (process context) holds read_lock(&tasklist_lock) in do_wait().
2. CPU 1 (process context) attempts write_lock(&tasklist_lock) in
   fork() or exit() and spins, which blocks all new readers.
3. CPU 0 is interrupted by a softirq (e.g., keyboard input event).
4. The softirq calls send_sigio() and attempts to acquire
   read_lock(&tasklist_lock), deadlocking because CPU 1 is waiting.

Since PID hashing and do_each_pid_task() traversals are already
RCU-protected, the read_lock on tasklist_lock is no longer strictly
required for safe traversal. Fix this by replacing tasklist_lock with
rcu_read_lock(), aligning the process group signaling path with the
single-PID path.

Lockdep splat:
=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
[...]
Chain exists of:
  &dev->event_lock --> &f_owner->lock --> tasklist_lock

Possible interrupt unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                           local_irq_disable();
                           lock(&dev->event_lock);
                           lock(&f_owner->lock);
  <Interrupt>
    lock(&dev->event_lock);

*** DEADLOCK ***

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 fs/fcntl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index beab8080badf..a6c764ede282 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -929,11 +929,11 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 			send_sigio_to_task(p, fown, fd, band, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_pid_task(pid, type, p) {
 			send_sigio_to_task(p, fown, fd, band, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
-- 
2.34.1

