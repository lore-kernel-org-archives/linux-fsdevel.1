Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861689;
	b=rlzk8qmJXuk3l/1XaMlfSlLlP5aRpeXc9YAz9rtxx+AvXebPshHUM+BN8Twt6cAm5XYr
	 7/eyiQDWNby4PvyWGiDdHx6Jap43jBfz+YjMGcJVyk88t+pl/OaptAb2avW8ZC59vz8IT
	 67/vuC2FLZ6CeD8tAxeG8Mha6caaHv4j8PzwmbeV53YJQHBhGM4v1vtAaxjl7+x7uyPOq
	 KOs2zOMP2JoJQYH3nEe0tJSLoI8rPAAQlgmb3mMV9Za1hPTjpv3jf7Y6OTYWYwyVDWjUC
	 JGP7RdJo/lwnbEBML4TM9mYigDvjWnJ2RW/zWnTtIm+HEuoG5Yw7zblaM18+k7F0fVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861689;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=9Lskh+N7JQvWM1QZ5Sr9CMmPwP72CT3UqVM90SLhC8k=;
	b=yBc1V12efsWKAB9mvWQbnyIjrG3T9b5VeHiP0z1d3ImUiBFAjab7m/hbNDbxJRKV+tLD
	 Pa6nG0ziVpq3seSPPV3SxLY4gPnZzKnW1l2IOkc6K11ViVYOgQDF8yIf1TObOIQw41n27
	 cVbtajQEfYV7MabsVq/UTO3spFVx2wKtv3vvpp6JNbA1vefBelvMA4m3uLiaosGf1uNe/
	 MsBW1X8Kq786zU9K+9ysPeIVJo2sy/SOvcWPIzgpsGc00boEj1wKZk8VTrExiKfo6IK4Y
	 2Cj6zEHqMxrSEbwS3IImBOtiYF5gsBn/A295GsicBu9e8ktidyf9ejyj0itNDOg0r6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cL2X3L7l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB1606A31C;
	Sat, 28 Nov 2026 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cL2X3L7l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79F21F00897;
	Sat, 28 Nov 2026 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861688;
	bh=9Lskh+N7JQvWM1QZ5Sr9CMmPwP72CT3UqVM90SLhC8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cL2X3L7lNbnr6CCN3wycQ7lBD4D0QUrGFLYnKkWeFpFCi2ohet7l2y6F+B+7o47cC
	 ZhG5JHdwZejbSpHHqqKzoBza+HyuJmbhTRvApnRcbcka5rLnEzHtk86rRaf7PwrnKu
	 xw6T2wXwMxpw6CfNf2cdijFqJR6Mw2zjiHnLiJzkQB+mE1dWmiBuKMaR4im/KvjPgC
	 yONscOLVeaJjIZGw5a2mSY5OV5qCOmN8aS77IEWxJy5rKnKeGxNkyKX5V60kp9Xe2k
	 WNLoN/HQqLHE7JhBdT26jm6MLZfs0iK4P2FcVigb6mTnrEI8VhHJlSsEKd7xlegWvW
	 JYeTqwNC6okbw==
From: Thomas Gleixner <tglx@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, paulmck@kernel.org, boqun@kernel.org,
 shuah@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, oleg@redhat.com, bestswngs@gmail.com,
 xmei5@asu.edu, xujiakai24@mails.ucas.ac.cn, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, Dominik
 Maier <dmnk@google.com>
Subject: Re: [PATCH 00/17] sched/mmcid: fixes for execve, mode switches and
 affinity
In-Reply-To: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
References: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
Date: Sat, 28 Nov 2026 11:28:05 +0100
Message-ID: <87bj79s11m.ffs@fw13>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 17 2026 at 11:17, Mathieu Desnoyers wrote:
> This series fixes six problems of the rseq concurrency IDs (mm_cid),
> and adds selftests for them. I looked for cases the existing tests do
> not reach:
> - a thread count that goes up and down;
> - exit, fork and a failed execve();
> - affinity changes made by another process.
>
> The fixes come first, and all six are marked for stable:
>
>   1  Give a CID to a task that joins its mm while running. A failed
>      execve() then no longer returns to user space with an mm_cid of
>      0x80000000.
>   2  Give no CID to io_uring and vhost workers, so that they do not
>      take IDs from the threads of the process.
>   3  Reset the stale per CPU state of an mm when its first user joins.
>      A machine with two or three CPUs no longer locks up after a failed
>      execve().
>   4  Keep a running joiner inactive until the fixups are done, so that
>      it cannot loop in mm_get_cid() while it holds mm_cid.mutex.
>   5  Add the allowed CPUs of the first user to the mm when it joins.
>      An affinity change by another task during execve() is then not
>      lost. 
>   6  Fix the use after free of the old mm in set_cpus_allowed_common().

#1, #3 and #4 are all caused by the fact that the exec()'ing task
disables MM CID right at the beginning of exec(). But that can be
completely avoided because the only requirement to deactivate it is when
the task is about to switch to the new MM, i.e. after all other threads
are torn down.

So instead of adding duct tape and haywire in the MM CID core code we
really should fix the underlying problem. See untested patch below.

#6 is incomplete vs. exec() switching MMs because the new MM is visible
before MMCID has been initialized on it. I look into that seperately.

Thanks,

        tglx
---
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1171,6 +1171,21 @@ int begin_new_exec(struct linux_binprm *
 	 */
 	posixtimer_exec();
 
+	/*
+	 * Remove the task from the MM CID management which is associated to the
+	 * original MM. This is done here to avoid leaving and rejoining the MM
+	 * CID management _before_ all threads of the the process have been
+	 * terrminated.
+	 *
+	 * On success the task invokes sched_mm_cid_after_execve() in
+	 * bprm_execve().
+	 *
+	 * In case that the below fails, the task will not return to user space
+	 * because bprm->point_of_no_return is set so there is no point to bring
+	 * the task back into MM CID management.
+	 */
+	sched_mm_cid_before_execve(current);
+
 	/* see the comment in check_unsafe_exec() */
 	current->fs->in_exec = 0;
 
@@ -1853,7 +1868,6 @@ static int bprm_execve(struct linux_binp
 	 */
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
-	sched_mm_cid_before_execve(current);
 
 	sched_exec();
 
@@ -1866,7 +1880,14 @@ static int bprm_execve(struct linux_binp
 	if (retval < 0)
 		goto out;
 
+	/*
+	 * Reactivating MM CID is only required for the success case. The
+	 * exec()'ing task deactivates MM CID after bprm->point_of_no_return has
+	 * been set true, so any failure after that point will prevent the task
+	 * from going back to user space.
+	 */
 	sched_mm_cid_after_execve(current);
+
 	rseq_execve(current);
 	/* execve succeeded */
 	current->in_execve = 0;
@@ -1885,7 +1906,6 @@ static int bprm_execve(struct linux_binp
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
 		force_fatal_sig(SIGSEGV);
 
-	sched_mm_cid_after_execve(current);
 	rseq_force_update();
 	current->in_execve = 0;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11166,7 +11166,7 @@ void sched_mm_cid_exit(struct task_struc
 	cancel_work_sync(&mm->mm_cid.work);
 }
 
-/* Deactivate MM CID allocation across execve() */
+/* Deactivate MM CID allocation across execve() switching MM */
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
 	sched_mm_cid_exit(t);

