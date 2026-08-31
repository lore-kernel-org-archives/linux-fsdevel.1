Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FB29408
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135158; cv=none; b=Iju43YWZBBNNouGqHF74iHJjLbezs6hh9mZQGFlNu+6Yh7726YmATuhRuokOjtbrU+DZJ6Lrk8ri64fboYNvZJw4vMawiesJ+1VRt+E1A4qg9sJEkYAJSJRWugeSpxLGhS+Cu7kBswnGORqYkKlFiFic/zvczzRpjUJ2wVnZ+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135158; c=relaxed/simple;
	bh=kNrbOsCEPY0M5OftSW2I5EzAkoMiQPi8tHEFlCA/ZTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYx4N8wpg2pvngsGoya9JvpERBK3GP5Uv9B8UsCbNLrlKbMDcP9YNlB6xG5+l+xoka0LDu2s5iYygymbUHEJbNXrR7LgcSK7B6jqY3Ng0B9psShVDhZYCH/O7MeCHzfC4DSOrQdoVw/e8WR7qFY3KIdXHr4HfY6R8tRnY84ytIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3iiqS6b; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3iiqS6b"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1954084b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788135156; x=1788739956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TS9zFXHclAz7UpENmLtE6ii1ULHUCqAUDk+wz8SniSw=;
        b=a3iiqS6btElZV109O5NNgr6Eh3R4zh+u/7VG6/lyaH5GMdL7rW1V7rzl8xxZ1Q0kwe
         gsPnYBLQdCSFoH4GMfhccYDKeqKSIUcXa3rptlB9oxgEPjjLCo+Mlzufr5SlZUz+Ct+P
         XyFMKvV2gaRq1zuvWX7+bvxuJ1PSx45Wxs/CCk4DBB1GSObn1It6LVz6FmsirhDImDZx
         O1zxGbUX8xjJxyhHaZI2E9cNxxqJ0F66Q3McKFYJd/5aumOk4IKLNHyOR9oBHRsGNFPG
         lSE79CPY47fjxM6HqiAj/JliOtJZHYMxSOOxOeQJaTFAeDML+ioQtPXhZJ1z5l4I+AQz
         QGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788135156; x=1788739956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TS9zFXHclAz7UpENmLtE6ii1ULHUCqAUDk+wz8SniSw=;
        b=bGN1DZgdYhcfYFoE2l+1NaawkC92SbSfaM+V4jvaskBFN3L55Go9wxglpDw6Oe07US
         NCRONgeIU8dO0kOa+xWQsZKeLz7Rch3ZwqkB7Mdn9p1eaKnLmEBCerSRw6kfR+dbuRHw
         BVqVyvsjQKkBcBeITBye+tHxqR9aaKCEIMeSuesEH3HZPpXpx/lyhWhLcqhfGNqaylRM
         Pqt/rwsA2YAVqoeVlAu+vCtxfLFLabZEptPDVC6uQG+ZAOsR/dg3vyIP6MPBJMVDzKwv
         dAry9OZIud4W8bUEHnQLRZyGy+U8mPsDf+CHFO9Oyv31NxGyJL7MXo9+Ren8QwVC3p3O
         qq0A==
X-Forwarded-Encrypted: i=1; AHgh+Roaj1WqvksV7DWrBhUQh+UkLeb8uAGgS6Hg093qs7PGAZbxYwvWPXHD2JbSNBvNlxr2c3YlgDFdaC9OHFdk@vger.kernel.org
X-Gm-Message-State: AFuF++kwQ5F0A6+x11+87WOzG0aKbpfFuVvtZsDbpk05kPK2ltjY4sij
	kTGIQLyuzO8eO1/gQIxy4b0a3UrENNB2AtDYf3kSS+/gK37jDdsg/DRf
X-Gm-Gg: AR+sD105Y5qE5eBBkJ1xker5MMN8oTxIpT9EjEXi4Xx3sW77Th5KPtaFbC0qLxGTOLk
	V+LAFydR/W4hjfKLEy/c0xNE+JCT9pdEQGk4iNmSCYy5IwatxAcWK45uO8SdJnafJ4JCVRiMlsK
	SW3RfTmVyZpBGE+u9iXNKiRj/trL5C0CBeDnC0l9geZY/KiQ6DIh2ZEYbq9WqrPItcKYKi1KGbM
	hTBCDc0X909/tANaQs2wfHi/3AsyTbdwNzjf8qzlYrTJJFvwqVGCD3GsVP9jbkgrneiQtY1/gng
	bbQ3ZvRPNOnXHS5VJPjES/y+8kNZxL7xTlAD0JYHJUE+bBM+i05Z4K0KKP+OEsiq7+bROZTcueA
	NDKgZg0YrkGGW/zJYRdHKzykZHXCZ59uzS07sS2bGkNF4PwzLSU2eN3Il7CIXfAaVbHxSwlB0N2
	cuYZPIYc3D+F9m/WKF+pvRgvQSAh5p35DUzbRrhrUrsu1EAl1G8NEh4BplpbYIrmqbA45fY4gd
X-Received: by 2002:a05:6a00:909e:b0:83e:b443:965e with SMTP id d2e1a72fcca58-85628893892mr39231859b3a.3.1788135156299;
        Sun, 30 Aug 2026 17:12:36 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569ff73a9asm2700400b3a.27.2026.08.30.17.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 17:12:35 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com,
	syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
Subject: [PATCH v2] exit: hold a reference to thread_pid across proc_flush_pid
Date: Mon, 31 Aug 2026 09:12:21 +0900
Message-ID: <20260831001221.3755948-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0a36bad01731 ("release_task: kill the no longer needed
get/put_pid(thread_pid)") removed the reference around proc_flush_pid().
It assumed that free_pids(post.pids) at the end of release_task() would
keep thread_pid alive until then.

That assumption is wrong.  __change_pid() only records a detached PID in
post.pids when pid_has_task() is false for every PIDTYPE.  If another task
still uses the exiting task's PID as its process group or session ID,
__unhash_process() removes the exiting task's PIDTYPE_PID link but leaves
the PID out of post.pids.  release_task() therefore holds no reference to
it after dropping tasklist_lock.

The other task can then remove the remaining PIDTYPE links.  Its
free_pids() call schedules delayed_put_pid(), and the RCU callback can free
the PID before the first release_task() reaches proc_flush_pid().

An unprivileged reproducer races wait4(-1) against setsid() to trigger this
ordering.  Three of three fresh v7.2 KASAN boots reported:

    BUG: KASAN: slab-use-after-free in
    proc_invalidate_siblings_dcache+0x3e2/0x3f0
    Read of size 8 by task h7_pid_reaper/1921

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
read 80 bytes into the freed object, matching pid->inodes.  With an
explicit reference, three of three fresh boots completed without a KASAN
report.  The concurrent RCU callback dropped its reference while
proc_flush_pid() was protected, and the balancing put_pid() performed the
final free afterward.

Take a reference before __unhash_process() clears p->thread_pid and release
it after proc_flush_pid() completes.

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
Changes in v2:
- Rewrite the root-cause explanation around __change_pid(), pid_has_task(),
  and the last PIDTYPE detach, as requested by Oleg.
- Explain in the source comment why thread_pid needs an explicit reference.
- Rebase onto current Torvalds master cee9395acd80.

 kernel/exit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 97686af89501..4e028f157597 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -261,8 +261,11 @@ void release_task(struct task_struct *p)
 	pidfs_exit(p);
 	cgroup_task_release(p);
 
-	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
-	thread_pid = task_pid(p);
+	/*
+	 * Pin @thread_pid before __unhash_process() clears it. The last
+	 * PIDTYPE detach can otherwise free it before proc_flush_pid().
+	 */
+	thread_pid = get_pid(task_pid(p));
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
@@ -291,8 +294,8 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	/* @thread_pid can't go away until free_pids() below */
 	proc_flush_pid(thread_pid);
+	put_pid(thread_pid);
 	exit_cred_namespaces(p);
 	add_device_randomness(&p->se.sum_exec_runtime,
 			      sizeof(p->se.sum_exec_runtime));

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0
