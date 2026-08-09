Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7ED377016
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Aug 2026 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786241204; cv=none; b=D6BEuKhL8+q4RItW1XHFeL8YGAZb7JZq3YQ1tqkIMuUkX+OOOmtA+9HkCMdfptLJJJzhhtluwGuPxHcAJBlA8kuuYR65zg5btJnQyy8vQH0Loy4M8nxQOYDAD0MamIAGkY3vWO6Aw/l3VoZ1Xn/8G//qJI5Xhg3UV0crdK8znpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786241204; c=relaxed/simple;
	bh=hJrKzkOWzxqkGrUmikEr/V20FKCfell32fsSs9xXSVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AgHbBvlxDlMb5G6oZ8Cp3uCnXoU5tdodueyiB34DkTZjqeCNjV8Dc22/FHN45BFyYN8/+ZUWc163DKDvBHoifiL8OlaJ/cm0J5C3pPHAWsDmauwf+2or4scx+y27dvwGyUIit02qWvaJXbXDPF0PQ2vrL20q9qLFYWn6sk5lKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7thCw3+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7thCw3+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so707065a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 19:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786241202; x=1786846002; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUi5CZ/mm/6LIkM/Ynog72l5rYYaKtcE2jJwcesfnKA=;
        b=O7thCw3+oS6AYLbRYh5I08vzcAGwWjvk2KII2htdapj+YOp9BTFaeZ0PdvusZE1ldC
         Rv4ijXPsS1/Bkg7HVtNt/MOuuDMg6GtE4RYa1o4my7gixQ+EqliHHEvxpXusY5ZjmvMF
         Ocrhds8Yz4v0fIWFaac2FMkjd9cd35LfKVy6M1+NA/TkaGTC3FaoESaIHhvJgqQYPRQh
         Lk3Ch8uPVyFT8MXHPW2w60J4FSlMHmSx1wSCEOwSjmHRanSOSOqZNuQQyFE4J02L+tjp
         Cc79R2jW1qpDTY1HGZsGsMYQ90t40/opd9nYQcXE+NO2mOcBkFN4H0Ys4iI0EGMOjBYZ
         0sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786241202; x=1786846002;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUi5CZ/mm/6LIkM/Ynog72l5rYYaKtcE2jJwcesfnKA=;
        b=NBPc5Nx+kuzHiSE9Z0K0WMtKgdq+CniuiVs1KP9h/nXyv2KtJCPiMnBQre2mzGPtUi
         rnYuFZs0WuH22UsnaiJsfnjM1otJYXU8G778qeEK5HfvqgRrf/DAHI7pnu920POfKxxZ
         R1upWmLWbYytuDyXsimx9xCZipdpkBskh2hJNGd8IJTvcPSx8HAGWaYFKw3PSB3aG1z6
         EoE1rGBEYLuxChIqS9WVh75CF13WdGjiWdfDFb+ZAWR7zn0womD0hNUt1uskeqA3qv5I
         ZGJ0NbQyFA6s3ckISc3+bGhgY5Zm1guU4HsxQp7ZwpqmRDp6qrpInSQaYKmTREC2aS1b
         fVnQ==
X-Gm-Message-State: AOJu0YwB2YKvFxn/gpHJyCnVN8k9HVkGfvmwVyh8oemmEH+RYXjNOUNd
	7Onery1ZIf/FRVOQ0MQFpQQXjIZBjHs5YZ8psFVJgKbYyd1f2cluEdvC
X-Gm-Gg: AR+sD12jz3vUKtipRRK4wi1FW/V3A5uoICAxDuJIvuQk2BS5cSWr+k6UefQa95/ueOW
	SKAr6FXY0s3pw+0LBgFujl9N5JkIyDBSJ9BdbZ25SmJhPPobMJl2ajr/X8yzB/7yZlM8FN7RWA2
	vitbz0I4g9D0dMwkDl+OZAcxAd1k6Pmc2/cUkkjj7lPZmbwIA+aAUCb5OGvH6QxI6K6m/A013Eo
	jH4hYsjBXbA3Z8E2QHBAC3Klg/RSeo1s8qa+HzAFgGsTkvXrRWZ8UXyoTJxdIym6j458N15xZo4
	lSPAdeJnemXDsCgP5mYQoFZbzj4CIxFrjTiPOb5I8w+lSa6UL8ZbW9hoVB6vh2ZW7s05NbAYw5r
	Qmp31o1MFQOSZLsnjIAI2/sn9Sn/mTLP63pCWvAZE0vwqWRQYYPg/fvAvzMV7XedIshAu9oQt6B
	t6qtGN8tzmit6rVSLNWmqBlrCwbb0M3t44gEBYNO2hKjNLEwvJqDagLnZqo7V0Q2h8gYcTdb2B3
	oYmevC1pn3d8g1UsJc=
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-3903c58bdd2mr33450215a91.11.1786241202015;
        Sat, 08 Aug 2026 19:06:42 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dc396dsm10023664a91.3.2026.08.08.19.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 19:06:41 -0700 (PDT)
Date: Sun, 9 Aug 2026 11:06:38 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tglx@kernel.org,
	ebiederm@xmission.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] posix-cpu-timers: Dequeue per-thread timers before
 exchange_tids()
Message-ID: <anfgrsPlUdwBhdrp@v4bel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A per-thread CPU timer holds a reference to the PID of the thread it is
attached to and, while it is armed, its node is queued in that thread's
posix_cputimers. The task is looked up by that PID.

When a non-leader thread exec()s, de_thread() changes which task owns
that PID:

  de_thread(tsk)
    exchange_tids(tsk, leader);		// tsk's PID now belongs to leader
    ...
    release_task(leader)
      __exit_signal(leader)
        posix_cpu_timers_exit(leader);	// cleans leader's queue, not tsk's
        __unhash_process(leader)	// that PID has no task anymore

pid_task(timer->it.cpu.pid, PIDTYPE_PID) then returns NULL, but the node
is still queued on tsk, which is alive. timer_lock_sighand() takes a
failed lookup to mean that the node is already dequeued, so it has
nothing to undo.

begin_new_exec() calls posix_cpu_timers_exit(me) right after
exec_task_namespaces() and that removes the leftover node, so the state
normally stays invisible. But bprm->point_of_no_return is set before
de_thread(), so if unshare_files(), set_mm_exe_file(), exec_mmap() or
exec_task_namespaces() fails, the task dies before it gets there.
exit_itimers() then frees the k_itimer while its node is still queued,
and reaping tsk later erases that freed node from the rbtree.

Dequeue the per-thread CPU timers of tsk before the PID changes hands, so
that a failed lookup again implies a dequeued node. Process-wide timers
are looked up with PIDTYPE_TGID and transfer_pid() moves that link to
tsk, so they are left alone.

Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 fs/exec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index c7b8f2d6366c44..f80f70e1c26de4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1000,6 +1000,18 @@ static int de_thread(struct task_struct *tsk)
 		 * the former thread group leader:
 		 */
 
+#ifdef CONFIG_POSIX_TIMERS
+		/*
+		 * exchange_tids() hands this thread's PID to the old leader,
+		 * which is reaped right after. The PID lookup in
+		 * timer_lock_sighand() then fails while the per thread CPU
+		 * timers are still queued here, so dequeue them first.
+		 */
+		spin_lock(lock);
+		posix_cpu_timers_exit(tsk);
+		spin_unlock(lock);
+#endif
+
 		/* Become a process group leader with the old leader's pid.
 		 * The old leader becomes a thread of the this thread group.
 		 */
-- 
2.43.0

