Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980D332917
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787998761; cv=none; b=h/FF+oHaufWr/aM6MYc7iO4qWckS5zX+v0akPVX1NpNr8qHFKOo38kuEHn0r0HJ1YAwBXhfX4UPykRudF3eXcaVAU2aiNegAR6DxaVX0m2SJzvSyw+2plpbXUyk2hE+3+iY1lQYwCTATToxo/6+q8989IIyihU4bAL+6iyvFYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787998761; c=relaxed/simple;
	bh=uWiCJRfkz+8wlvQiwRpUOg5mVsQG8h4166rBb5yTUcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBHvmgZtrzjprFLBfOrulvhrKKXm2YzUOfVQpb2tYeEoohfrSw+0orb2ifsVKxFIOF37zik4SiMbuMt0wt/mC6jJjOa5X17OWokIFqxFYfDW2B9prsZRf+wdq/9+WIq6YSFS/W3Uev+XrR5Ku6T74fl4LUvjLwma8N8XC8pnRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTNsY1op; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTNsY1op"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-852c481415fso2051245b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787998759; x=1788603559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6pLNBZrAnN+v62n4ihU9SPJ7Z60nyT7aNzFPAXTs2g=;
        b=kTNsY1opugBXS0J9NXT+tHBE1bSmgMhe0YhV/IpnUB8lC/YpkXEPKameU9A4D7oBxK
         hE0TairZI0jUW+il7F5m1Jg2+U+kyNGQjca85CIDE6LTrhpdrPyIJKIAw8jYRC1v7YoO
         fJfDcb5FIDeCDA5P9eAbmKXfZYy4tgvI3gRjauJLxqEXjZe9N4jCZN0X73ZB8jklE0Zj
         7TdpU2jpzIHi10gqZ24Zlwsh8dQTbUUQTmUQkRaPax67UII6CdlBKlztneTm6V1JFabM
         ZygKMCFWi2V53rwNtHojaZS2lAI7imsQeDv0PGgx7t3mhE1HP0j+aj3n1AfzXHpnzQaj
         yNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787998759; x=1788603559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6pLNBZrAnN+v62n4ihU9SPJ7Z60nyT7aNzFPAXTs2g=;
        b=QJ0nm5fhmC/n7K4oQDpJFWm6g79LAe7GiDgdcr9FC30W39Lc6aXGThUqfv501RLHig
         Pg3HXeAjxO/Y2uTNejSBdQEJzKPxnYK1bdzoCtYEI3mk9wV5Am20pA5WA9smSbJIKBof
         9GnO4Hi2g55IXCDZ/3ITFME86khsamZUafA5sEJHDjrJaRMyK+R9Rgv4q99RIa7Bt39b
         an4UzmIIJSwHQC6RRFkyw4EdzxH+tpp0ZlcjXCKflz5w/fsbcStNIsAwFwvjsNu3LO3O
         iS7+O2CkdySNsEmG3H16EOOz54JkkzrpYXRHt59X7wSUSfwWVvmlFF/CzQ9ZNCNQLo40
         W0Fw==
X-Forwarded-Encrypted: i=1; AHgh+RqyPSALJ77Y0RNw7LOmHECJyVWCqam+CKgk7dtdZGRK9I++KRn9WVKLwZp/x4MUTPatKlcShFBWJ4FKeMXk@vger.kernel.org
X-Gm-Message-State: AFuF++kRror7uUbvWYtxGISVmM3Q1BQ9VmvWy4fQQPVYuMq7vqldI+kK
	ZbHLQmAD/rtM5WLmp8E7Qk8YrdI/zpgm5TehzM8oht+a0kfEMFPjh0Xn
X-Gm-Gg: AR+sD11fg3bK9J35DZtYleGsX5Ogw3B4tSbJfv338L6jZoTv3fhjcDVsRAqE+Bhawf+
	efAdrj/v7ME8mSZne2VQFiuuDtKg8+x08IYksyLORec2PBMqYIjFSojbM8dGCvKc6AmWPO5WPfT
	TTdK/W2GXdCC9C4S78gi822kzUngxmCAWYip/dJvbvCuiT+V0wNwDlpkn6Igu5wgHTJlwVmpBHu
	9rbV4xJX6CSZZ8xhYV7cWAUMglxg7ZbN0icDpcaBzU6/TGXf8KTa8OlGQzU/L0EcAsnudXelVli
	CXPfDkYfgpQYS2f13ThkIDcL5z7cFPKuV65sotp7Th6XGBKtixDUREcfO3iOQezsVPCnNgTN4FM
	1hetqO1AeJ+NEKiW9j5KWeWdCQ/4qxjy2P/ywEGojgH3/XLDDV74UMQGMrnFfXs/XFIL/y/oZT6
	OcVr8EdqQjDw4YeuY3+P+Zc/xYpNiVwl/CsXADlAtkgfBIZZOHNzXgPKIhT9WMhKn+ek764z0BD
	A==
X-Received: by 2002:a05:6a00:a221:b0:857:7337:5db9 with SMTP id d2e1a72fcca58-85773375f9cmr7598086b3a.23.1787998759043;
        Sat, 29 Aug 2026 03:19:19 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569f49ed7asm1445775b3a.8.2026.08.29.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:19:18 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com,
	syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
Subject: [PATCH] exit: hold a reference to thread_pid across proc_flush_pid
Date: Sat, 29 Aug 2026 19:19:05 +0900
Message-ID: <20260829101905.4163730-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

release_task() keeps a task's thread_pid across the point where it
drops tasklist_lock and calls proc_flush_pid().  The commit named in Fixes
removed the PID reference.  It assumed that the PID cannot go away before
this release_task() invocation calls free_pids().

That assumption does not cover references represented only by PIDTYPE
links.  Process B can still use exiting process A's PID as its session and
process group ID.  A is reaped with wait4(-1); PID-specific waits take
their own PID reference and mask the bug.  After A's reaper drops
tasklist_lock, B can call setsid(), remove the final PIDTYPE links, and
queue the PID from B's own free_pids() call.  The RCU callback can then
free the object before the reaper dereferences pid->inodes and pid->lock in
proc_flush_pid().

A timing-only diagnostic forced this legal ordering on final v7.2.  It only
gated the real setsid(), RCU callback, and proc_flush_pid() operations; it
did not change PID links or reference counts.  Three of three fresh KASAN
boots reported:

    BUG: KASAN: slab-use-after-free in
    proc_invalidate_siblings_dcache+0x3e2/0x3f0
    Read of size 8 by task h7_pid_reaper/1921
    CPU: 0 UID: 65534 PID: 1921 Comm: h7_pid_reaper

    Call Trace:
     proc_invalidate_siblings_dcache
     release_task
     wait_consider_task
     __do_wait
     do_wait
     kernel_wait4

    Freed by task 0:
     kmem_cache_free
     put_pid
     delayed_put_pid
     rcu_core

    Last potentially related work creation:
     __call_rcu_common
     free_pids
     ksys_setsid

KASAN identified a 144-byte object from the pid cache and located the bad
read 80 bytes into the freed object, matching pid->inodes.  Restoring the
balanced PID reference completed without a KASAN report on three of three
fresh boots: the concurrent RCU callback reduced the count from two to one,
proc_flush_pid() completed, and the balancing put_pid() performed the final
free.

Public syzbot reports have independently observed proc_flush_pid() reading
a freed pid-cache object, including a last reference released by a proc
inode callback.  Pin thread_pid explicitly so every last-reference path is
excluded until proc_flush_pid() completes.

A tested source reproducer is available privately on request.  No
controlled read or write, information leak, or privilege escalation is
claimed.  The mainline patch applies directly to v6.19.y and newer;
v6.16.y through v6.18.y need a context-adjusted backport.

Fixes: 0a36bad01731 ("release_task: kill the no longer needed get/put_pid(thread_pid)")
Reported-by: syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0aee5e8066eddbbe7397
Reported-by: syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=e8b3520b53e78e90034e
Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for 6.16.y-6.18.y
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 kernel/exit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 97686af895013b..461e2834fcb45f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -261,8 +261,8 @@ void release_task(struct task_struct *p)
 	pidfs_exit(p);
 	cgroup_task_release(p);
 
-	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
-	thread_pid = task_pid(p);
+	/* Pin @thread_pid before __unhash_process() may set it to NULL. */
+	thread_pid = get_pid(task_pid(p));
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
@@ -291,8 +291,8 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	/* @thread_pid can't go away until free_pids() below */
 	proc_flush_pid(thread_pid);
+	put_pid(thread_pid);
 	exit_cred_namespaces(p);
 	add_device_randomness(&p->se.sum_exec_runtime,
 			      sizeof(p->se.sum_exec_runtime));

base-commit: cf72cbb39da84b6f02f90c07f33b102fc10b16f0
-- 
2.54.0

