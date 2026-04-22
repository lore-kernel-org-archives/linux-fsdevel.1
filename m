Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F33644D7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885355; cv=none; b=itywoF46UX9jkMngWq/jeh5WRMxdx042tO06Dcc887qhZaicDrW0/NTQMik88BgWJqrpiMUf/d9tvYe0Ap/Oikj5CF6jbdCI6xroHr+D2UIVFE8LCxByn1nuprMKMVYC72u+KMWkdC0IEyoNRZAejHs0Vaz2PP7mZc4r82vNr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885355; c=relaxed/simple;
	bh=reC/3ktwHEf36qZ7CG487Kj9SdhWMZhQYhjyucWyCQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mW7xtOqJa/CNnIw5IUtyX3a3rh+nzs0DDJHHH+j8QM/KC6vWA0OffZr4xu/X0z7Dxtx4z4Xa6pqkWj9aSo7SAMpSRLsrl8tTov6YaYvccfcrTib4Iw1xWVrbFB1dkFaSoQUnea5Ksy6eS0c2fUJJyuDB01nmvbVRMMMb0TT02IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD6A1drZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD6A1drZ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a4113ab355so6119675e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776885345; x=1777490145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY7nrdeX7te85EQwTW8KDmLXz64uBX36qr+ohigMp9c=;
        b=YD6A1drZb461Wf+hVYOMhSj1NbzCLDL/mA5+eJ+GHJXyx4zKrzie0g6/j8tqVOSSGE
         /bzpqjDDaJ0ccXYnFLBLRQSje9F7pPxklUjYFTyFeUJNvAbk2YzKnCb91zZEl79qVY7w
         IFMI2l+Rg0I1x/0FPHTPjJyX0qmvF6RHypKE6YauqRKggFVjlZhcKXbdlbSLmeitG9zl
         kJP1fJ4C5diqVaoZZss5bu7RZIZQHQPtVJmqqdhqWU6H0rlN3uKbbTJFWdGaOzuqO/09
         c6WWkpZnqlST5fEY7YivSL1cjvXMfXzdZV9MW90dMyj0rNn8aKD/kRrKD/3qwuHhOYEY
         oEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776885345; x=1777490145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oY7nrdeX7te85EQwTW8KDmLXz64uBX36qr+ohigMp9c=;
        b=h+AFz/uB8xD7YezJNqzweQIzUrldyM/dq05LMWPtEjeVXmuT3IB1aT5tAujji6LGx5
         V9ZAMDztaoxAhsSy1n5cTjhiN1/BZe62mQ72EBfJByB57tHQHM3GTloPfxg93qMhOhTV
         wPaKgPV50IIvjj0TLIRCyJNsWal1U90TNDTHe8Chab0gBJ/fX1+cWJMbQRnV8M0l3mLp
         NbNvjbhnLwBAD+gWN5LibSjMo5ejfS7e6mjv71ZLzEJPT34qhLdB7UKUUNmW+9EXuQXa
         s/M4eu8Ej3fXRnRzNnHKVUWXgROHjN9S7H78aUAW7Cq/RMASe3zozq9pWkU+/e6u6i5R
         micA==
X-Forwarded-Encrypted: i=1; AFNElJ/s5rE+cxQg8TmfHwXZPRgn4LmUxMzAGvZusKl3ZAJRyArjCYq0g1/P9r4g2O949IsifOXXSayj7YWg0w13@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3y5Bc2BfJvkV89etcPbRjyFo31IGeJpqm7EfJ1CEOcNS7YC4V
	g5UNHi47quvJYVilpq3+q4ZPQOgnfG8+pEdzr3fRzVWLYm6EK9RopnI=
X-Gm-Gg: AeBDievKxyBFGHo/peNb/tAeiG3sEBYVOLMi7lLv9pViXC7nBl2ojPZSDIqEX7DJS4r
	QWMMFsOq7CF8lnvq+xa16WAKfPvfUk6SsRG++UDrFtnS5qutwg5Wr8cHrTtF/+c7PgmYQyfTeKZ
	/av6cMb0+0R6p/f8Ddzq4b2y+qTchU/553xgpoGv5k5Vvjc20FTzGteia2OZn4yb6myue8HRP06
	aIrh2a99diyL2A9yU/3y3d/BP3NSSYwSczfBMf5/qn8FtKE8yyanFAuElYlRTFHpy+Iahj5wv1k
	93ulcTBxAuNBq18gTwPtjoMbVbeLbogYGRy+7CaIQ4Ubaa/4k3gD+0vgkfmeDFkknH3vJj1v/l9
	XEIGhoMSc1p4vONY/PKveQLb4fWLIZSQpL7u0mw9O/i6RePyTynrTlusXCu2jkUh674Z3q7Fwgr
	Dji27mVIuJHMSSEMfotaVtUw==
X-Received: by 2002:a05:6512:a90:b0:5a4:d4:5c5e with SMTP id 2adb3069b0e04-5a4172dc775mr6123332e87.22.1776885345324;
        Wed, 22 Apr 2026 12:15:45 -0700 (PDT)
Received: from p183 ([178.172.147.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad108sm4640295e87.3.2026.04.22.12.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:15:45 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ebiederm@xmission.com
Subject: [PATCH 2/2] proc: rewrite next_tgid()
Date: Wed, 22 Apr 2026 22:17:45 +0300
Message-ID: <20260422191745.435556-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260422191745.435556-1-adobriyan@gmail.com>
References: <20260422191745.435556-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* deduplicate "iter.tgid += 1" line,
  Right now it is done once inside next_tgid() itself and second time
  inside "for" loop.

* deduplicate next_tgid() call itself with different loop style:

	auto it = make_tgid_iter();
	while (next_tgid(&it)) {
		...
	}

  gcc seems to inline it twice:

  	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
	add/remove: 0/1 grow/shrink: 1/0 up/down: 100/-245 (-145)
	Function                                     old     new   delta
	proc_pid_readdir                             531     631    +100
	next_tgid                                    245       -    -245

* make tgid_iter.pid_ns const
  it never changes during readdir anyway

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c | 57 +++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f2db455dbbfd..f38ac943ec32 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3543,30 +3543,43 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 struct tgid_iter {
 	unsigned int tgid;
 	struct task_struct *task;
-	struct pid_namespace *pid_ns;
+	struct pid_namespace *const pid_ns;
 };
 
-static struct tgid_iter next_tgid(struct tgid_iter iter)
+static
+struct tgid_iter
+make_tgid_iter(unsigned int init_tgid, struct pid_namespace *pid_ns)
 {
-	struct pid *pid;
+	return (struct tgid_iter){
+		.tgid = init_tgid - 1,
+		.pid_ns = pid_ns,
+	};
+}
+
+static bool next_tgid(struct tgid_iter *it)
+{
+	if (it->task) {
+		put_task_struct(it->task);
+		it->task = NULL;
+	}
 
-	if (iter.task)
-		put_task_struct(iter.task);
 	rcu_read_lock();
-retry:
-	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, iter.pid_ns);
-	if (pid) {
-		iter.tgid = pid_nr_ns(pid, iter.pid_ns);
-		iter.task = pid_task(pid, PIDTYPE_TGID);
-		if (!iter.task) {
-			iter.tgid += 1;
-			goto retry;
+	while (1) {
+		it->tgid += 1;
+		const auto pid = find_ge_pid(it->tgid, it->pid_ns);
+		if (pid) {
+			it->tgid = pid_nr_ns(pid, it->pid_ns);
+			it->task = pid_task(pid, PIDTYPE_TGID);
+			if (it->task) {
+				get_task_struct(it->task);
+				rcu_read_unlock();
+				return true;
+			}
+		} else {
+			rcu_read_unlock();
+			return false;
 		}
-		get_task_struct(iter.task);
 	}
-	rcu_read_unlock();
-	return iter;
 }
 
 #define TGID_OFFSET (FIRST_PROCESS_ENTRY + 2)
@@ -3574,7 +3587,6 @@ static struct tgid_iter next_tgid(struct tgid_iter iter)
 /* for the /proc/ directory itself, after non-process stuff has been done */
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
-	struct tgid_iter iter;
 	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
 	struct pid_namespace *pid_ns = proc_pid_ns(file_inode(file)->i_sb);
 	loff_t pos = ctx->pos;
@@ -3592,12 +3604,9 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
-	iter.tgid = pos - TGID_OFFSET;
-	iter.task = NULL;
-	iter.pid_ns = pid_ns;
-	for (iter = next_tgid(iter);
-	     iter.task;
-	     iter.tgid += 1, iter = next_tgid(iter)) {
+
+	auto iter = make_tgid_iter(pos - TGID_OFFSET, pid_ns);
+	while (next_tgid(&iter)) {
 		char name[10 + 1];
 		unsigned int len;
 
-- 
2.52.0

