Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA939FCCA;
	Mon, 31 Aug 2026 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177371; cv=none; b=t+XBiFOjYJBobDBplUvn/7QMPYG68ONzv4k72U1G8iEXPUyCjJZ1MXhipVSqVhHrjkxSReOBLRRgu5ckDTZ29JP8jjCC/uG2fwx7ZpOfn0NM1364IkhyKXGDBwNhLGz9PfI/hLnBVdpIaqWvOjErGdqswJ5z4hUW1rem0Gho4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177371; c=relaxed/simple;
	bh=m5OC9McQ46lCqsW5XUd7hph9SRPh+hIOwsIfXXol6og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/n+oTb32gCgN2JMx31+h45kU42FO57Aw9cuaW1v3DKLl2hp7FYTtBngojavPcnZY0r3z1D/UUsgZjn0csxFfUCIUnLVvUzpio+96E4e5yIXh1PeufkEWng6lWnzG70DaaOJ10rG2MkqxaYy5awLob4sxR22+VcQ1pXmfGyKQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTmIYMlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTmIYMlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6D41F000E9;
	Mon, 31 Aug 2026 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788177370;
	bh=iv1g2a/BPCURzyjERuiT2KgQt/5FQjoRURW2yzaMRD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CTmIYMlmQx64UQUiggbx3OFP8+JY8gdznfCHr9ZNfQPuETMsNOVLTgFm7Jq16WrDj
	 DS6tT3CRzkghVydbepFuxVWRQNaeDmRRmgvGs/BOtR0M+NCxkHFFiR2MQpwoUUhgQh
	 bOeLWaehWaunefgkTJGCZLQWkky3vGKLovL4SoQTI/pwEUjwh3OG+2v9zhqErIHO0t
	 wRCVvs268uRWOB3cCnfAyS0qCMczKNYWUNoICPis+6CUSFVsSxoAiZKlFix2/SpTBf
	 LxIDHOrmOTNueigvtZBIcB4cmC9lgMHZI+8HqsEajzGYym1s/F54tz1VUKqeevvC7U
	 QG9qwGdIficWw==
From: Thomas Gleixner <tglx@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Kees
 Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "Eric
 W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Hyunwoo Kim
 <imv4bel@gmail.com>
Subject: Re: [PATCH v2] posix-cpu-timers: Dequeue per-thread timers before
 exchange_tids()
In-Reply-To: <ao7Q8miiuLAPVnWv@v4bel>
References: <ao7Q8miiuLAPVnWv@v4bel>
Date: Mon, 31 Aug 2026 13:56:07 +0200
Message-ID: <87bjaicxm0.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 26 2026 at 20:41, Hyunwoo Kim wrote:
> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e6..9b2d140bd9f2a 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1003,6 +1003,18 @@ static int de_thread(struct task_struct *tsk)
>  		 * the former thread group leader:
>  		 */
>  
> +#ifdef CONFIG_POSIX_TIMERS
> +		/*
> +		 * exchange_tids() hands this thread's PID to the old leader,
> +		 * which is reaped right after. The PID lookup in
> +		 * timer_lock_sighand() then fails while the per thread CPU
> +		 * timers are still queued here, so dequeue them first.
> +		 */
> +		spin_lock(lock);
> +		posix_cpu_timers_exit(tsk);
> +		spin_unlock(lock);
> +#endif
> +
>  		/* Become a process group leader with the old leader's pid.
>  		 * The old leader becomes a thread of the this thread group.
>  		 */

Similar to the other issue vs. POSIX timer signals this really wants to
be solved in exit() independent of non-leader exec(). Let me have a
look.
