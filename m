Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654725B0AA;
	Sat, 23 May 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544535; cv=none; b=UKV4neDmH9ZFI9KT4eTvQl7mzxcz45RaLJligGM2s7kswxXPYZmA4mh3ps+L8ajnZU+w03W0fNOU6r6srAcFGYLYgLjRzyYJKx3awlAIrzQY6xSHc5y21KI47ro0h5C+YTClNRLzhLN9rNWqR1S3Zjbkbo6uxb/OlvCVNUVN4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544535; c=relaxed/simple;
	bh=b0zlhsmx70J9HgL76q2WWXdx5Fkz++Tgp2VJIR9jSJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izYDnyv9xwjEVSuaTqGV2YVDKWNCf0AyLqv/pmtAi61AYlo3e763/mOFrVrZeW8dFcwZke/+obUoZwBMh8yMpXP+lyarbRKX6ZJjikaJ6PT2qtDPMFu4tZms/vadjHdnLAWdaIqeV43E7jfkV6NGpUks5uobdLY+jpT1n+M/B6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yz3V9keK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yz3V9keK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=RW
	O4O1Ij6XyY86YLn/lnnVslMvDSevfaW0ukpTwXCKU=; b=Yz3V9keKc8R5Ng0DC0
	dYZ04nH8fmu2e5b2V1b/W+YuBCIYuezcVlV1HABQDJ2ZFUd0VXE1VRyv8q/Pe5kw
	/tzwc5tysouWgNGxsdiJ8QW22GIjXAC14Znw9Wn588CPNWLeAXBFibiZG+eR8zxD
	1VXFbinrIzcSZfQgbIYYzc8jo=
Received: from 163.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDn1_gLsRFqCr25Eg--.39320S2;
	Sat, 23 May 2026 21:52:23 +0800 (CST)
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
Subject: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling
Date: Sat, 23 May 2026 21:52:10 +0800
Message-Id: <20260523135210.590928-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
References: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDn1_gLsRFqCr25Eg--.39320S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4fWw48KrW7Ww43uw47twb_yoW5ZFW5pF
	9Fgr9akr18Zry09r1UAay8ur1rWwn7WrWUXry0q3yS9ryDXr13Xry7tryfWry5K39rAFs8
	Xa1UJr4kCw4DZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5VyxUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDABdQNGoRsRelVQAA3e

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A SOFTIRQ-safe to SOFTIRQ-unsafe lock order deadlock can occur in
send_sigio() and send_sigurg() when a process group receives a signal.

When FASYNC is configured for a process group (PIDTYPE_PGID), both
functions use read_lock(&tasklist_lock) to traverse the task list.
However, they are frequently called from softirq context:
- send_sigio() via input_inject_event -> kill_fasync
- send_sigurg() via tcp_check_urg -> sk_send_sigurg (NET_RX_SOFTIRQ)

The deadlock is caused by the rwlock writer fairness mechanism:
1. CPU 0 (process context) holds read_lock(&tasklist_lock) in do_wait().
2. CPU 1 (process context) attempts write_lock(&tasklist_lock) in
   fork() or exit() and spins, which blocks all new readers.
3. CPU 0 is interrupted by a softirq (e.g., TCP URG packet reception).
4. The softirq calls send_sigurg() and attempts to acquire
   read_lock(&tasklist_lock), deadlocking because CPU 1 is waiting.

Since PID hashing and do_each_pid_task() traversals are already
RCU-protected, the read_lock on tasklist_lock is no longer strictly
required for safe traversal. Fix this by replacing tasklist_lock with
rcu_read_lock(), aligning the process group signaling path with the
single-PID path. This also mitigates a potential remote denial of
service vector via TCP URG packets.

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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
- Also apply the RCU replacement to send_sigurg() to fix an identical
  deadlock vector triggered by TCP URG packets.
- Add Reviewed-by tag from Jeff Layton.

 fs/fcntl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index beab8080badf..92d643a14196 100644
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
@@ -975,11 +975,11 @@ int send_sigurg(struct file *file)
 			send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_pid_task(pid, type, p) {
 			send_sigurg_to_task(p, fown, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
-- 
2.34.1

