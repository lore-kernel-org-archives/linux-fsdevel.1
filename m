Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B2471CED;
	Tue,  1 Sep 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249716; cv=none; b=B6HVXaChUcuRpgv7K2a4TciVSwrJ0Mu6T00TYLgOlRtN7BEIl3bm9ZxbOJ6wagHOZTHMyL3Y2xPKSPhnk+BaXYr6H6wRxF7cCZXdmHLmXCWyT6uUodUMWpL4oJOA7BN00wqUOqls29U5uqcTRboZtBU8Nhcsqsiz0ocn2g0hxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249716; c=relaxed/simple;
	bh=1+NQ21UE4ohTgTsn4MRFA0UiefKVUcTVyfhdeBGkbSk=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=JVE/Ol1sQCyV3A0ySar3Up6aRWrSkbGLGNslBbMcnyBUA9AUiIYXtzk+1B/ODhUOW/LPvu2IXTzX3jCcrVDogEsCtMYNOh2B+7qiKQgO3cPx+RqXbiIP5WRzJwLma0MNu2Kl+gnHxR8XW+A6/CNuufN8Ck/Rkb5ihbj21bydKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=m/qrrNf8; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RZbxcvwC; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="m/qrrNf8";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RZbxcvwC"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788249689; bh=5iGCuz1H4YwkJWeg/wxwPm6
	A9zDo3R5pq4ps0XW+/Qc=; b=m/qrrNf8ftmvZN/qNE2Pc3i0wW6Y09EeoJyl2bSX9n0nznZvLB
	25HxUS9Q3TshAtOsIsJl0H8Or9DDvKpL9WV3Q9b235oP208nhqKkGzHnL4dYmJdQPYoIiIhFyVl
	UhHxycl/zj1AEhOFuMKU3ANHpo+4Ek13JXacVoudxMKqS55pvR/CncMkytMN8gN7dtQCEpqR4ce
	h9wK8ePpiuWJups3QEyELCuPzzoKnKlvsHOZEJE2tc8nct6PBJJ5mobpHpWP8Xg/+R71O2DL6+d
	tO9DSoj3/to7C+7lgqzPpDlvPwakKONbji3N7ZUjgYKfqPApaMPGjkbKXFiE2Gqcfuw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788249689; bh=5iGCuz1H4YwkJWeg/wxwPm6
	A9zDo3R5pq4ps0XW+/Qc=; b=RZbxcvwCIwIifQWGMeWmq3DKHh4OXZoUPrIhJLd7X51EsoTYKJ
	Uz4DkijC97w/R06UJkJ2QA1KbN6ktABo8KCA==;
Date: Tue, 01 Sep 2026 09:01:28 +0100
From: Bradley Morgan <brads@mainlining.org>
To: 4ncienth@gmail.com
CC: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mjguzik@gmail.com, oleg@redhat.com,
 syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com,
 syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_exit=3A_hold_a_referenc?=
 =?US-ASCII?Q?e_to_thread=5Fpid_across_proc=5Fflush=5Fpid?=
In-Reply-To: <20260831001221.3755948-1-4ncienth@gmail.com>
Message-ID: <842FFDA5-674F-41DA-ADD3-E19B3FB98104@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 31 August 2026 01:12:21 BST, Daehyeon Ko <4ncienth@gmail.com> wrote:
>Commit 0a36bad01731 ("release_task: kill the no longer needed
>get/put_pid(thread_pid)") removed the reference around proc_flush_pid().
>It assumed that free_pids(post.pids) at the end of release_task() would
>keep thread_pid alive until then.
>
>That assumption is wrong.  __change_pid() only records a detached PID in
>post.pids when pid_has_task() is false for every PIDTYPE.  If another task
>still uses the exiting task's PID as its process group or session ID,
>__unhash_process() removes the exiting task's PIDTYPE_PID link but leaves
>the PID out of post.pids.  release_task() therefore holds no reference to
>it after dropping tasklist_lock.
>
>The other task can then remove the remaining PIDTYPE links.  Its
>free_pids() call schedules delayed_put_pid(), and the RCU callback can
>free
>the PID before the first release_task() reaches proc_flush_pid().
>
>An unprivileged reproducer races wait4(-1) against setsid() to trigger
>this

Gnarly!

>ordering.  Three of three fresh v7.2 KASAN boots reported:
>
>    BUG: KASAN: slab-use-after-free in
>    proc_invalidate_siblings_dcache+0x3e2/0x3f0
>    Read of size 8 by task h7_pid_reaper/1921
>
>    Call Trace:
>     proc_invalidate_siblings_dcache
>     release_task
>     wait_consider_task
>     __do_wait
>     do_wait
>     kernel_wait4
>
>    Freed by task 0:
>     kmem_cache_free
>     put_pid
>     delayed_put_pid
>     rcu_core
>
>    Last potentially related work creation:
>     __call_rcu_common
>     free_pids
>     ksys_setsid
>
>KASAN identified a 144-byte object from the pid cache and located the bad
>read 80 bytes into the freed object, matching pid->inodes.  With an
>explicit reference, three of three fresh boots completed without a KASAN
>report.  The concurrent RCU callback dropped its reference while
>proc_flush_pid() was protected, and the balancing put_pid() performed the
>final free afterward.
>

Ok

>Take a reference before __unhash_process() clears p->thread_pid and
>release
>it after proc_flush_pid() completes.
>
>A tested source reproducer is available privately on request.  No
>controlled read or write, information leak, or privilege escalation is
>claimed.  The mainline patch applies directly to v6.19.y and newer;
>v6.16.y through v6.18.y need a context-adjusted backport.
>
>Fixes: 0a36bad01731 ("release_task: kill the no longer needed get/put_pid(thread_pid)")
>Reported-by: syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=0aee5e8066eddbbe7397
>Reported-by: syzbot+e8b3520b53e78e90034e@syzkaller.appspotmail.com
>Link: https://syzkaller.appspot.com/bug?extid=e8b3520b53e78e90034e
>Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for 6.16.y-6.18.y
>Assisted-by: LLM

Thanks,

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
>Changes in v2:
>- Rewrite the root-cause explanation around __change_pid(), pid_has_task(),
>  and the last PIDTYPE detach, as requested by Oleg.
>- Explain in the source comment why thread_pid needs an explicit reference.
>- Rebase onto current Torvalds master cee9395acd80.
>
> kernel/exit.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/kernel/exit.c b/kernel/exit.c
>index 97686af89501..4e028f157597 100644
>--- a/kernel/exit.c
>+++ b/kernel/exit.c
>@@ -261,8 +261,11 @@ void release_task(struct task_struct *p)
> 	pidfs_exit(p);
> 	cgroup_task_release(p);
> 
>-	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
>-	thread_pid = task_pid(p);
>+	/*
>+	 * Pin @thread_pid before __unhash_process() clears it. The last
>+	 * PIDTYPE detach can otherwise free it before proc_flush_pid().
>+	 */
>+	thread_pid = get_pid(task_pid(p));
> 
> 	write_lock_irq(&tasklist_lock);
> 	ptrace_release_task(p);
>@@ -291,8 +294,8 @@ void release_task(struct task_struct *p)
> 	}
> 
> 	write_unlock_irq(&tasklist_lock);
>-	/* @thread_pid can't go away until free_pids() below */
> 	proc_flush_pid(thread_pid);
>+	put_pid(thread_pid);
> 	exit_cred_namespaces(p);
> 	add_device_randomness(&p->se.sum_exec_runtime,
> 			      sizeof(p->se.sum_exec_runtime));
>
>base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
