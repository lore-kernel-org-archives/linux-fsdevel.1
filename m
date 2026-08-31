Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B89471254;
	Mon, 31 Aug 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193150; cv=none; b=gzvLPgUS5ry0qT2eCl43uYcXJgISFp/ll0fx7SghkVblYsJI+J2trTH0aAAsz/nH0nyK/r16dqDHg8ITDprFaD1dXEQYZxGMrShix/JJ9v+4rNudTCxjr5QRelYWmI7GDd2YZ/N7MddRC8DAHReNQhgjwmLH9XqION3ajWwsL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193150; c=relaxed/simple;
	bh=AG/H4fV+OQAtx44XPt7s66zZbIJIItCNTCuY7ZNbuIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WEqsQ13VwL0TM08Gv+DmA0nJH7cRRcDO/O6Rh8pD6t4bMCopGHqUK85O0jkKfz5q+DHmiA4COboNu5nh1UDYGyvqZe70QrCA8E3xhRHG62r6/cuQk+LGN+GoZ5fLMJmDWoOv00TVbVQdzxdW02GWsE004+IyTwayqPkL3L/bLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGJbox2L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGJbox2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911111F000E9;
	Mon, 31 Aug 2026 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788193148;
	bh=SHhHAXohzn8l8P7iQ2bTOcRyRwykV6bPfvLQtf0G7Ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jGJbox2LSWuG5z7srjqQgIsOFUWtGu+aUDw6+QB45QEGMNTx4Q6d9Vlf1c9HHU1/U
	 wLNMf8Zcnydr4bbADfj2JmEmrBVXcl1+tHRdFreJIjBendMpiNugCA019BhzUTSJWp
	 zW5Vsl0fPmcWy3lKl+wGIhuEtwymF0rmvIRKSZ+DXlVJli27XQGHt/sk/l24iinReR
	 OggJ0kToqFctARCDPnCzcW5ufJT9zGgZ1cNz5eWFCbjQGPpRWLtWvyXjXh5IS3fuar
	 Xm0iOHFhYFMK4YcTICYElXpfQ+pxpXeab9fW81u6d/cycjk83mKzhmpp/4l92ZEnhP
	 Kt1ATiRml5+yQ==
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
In-Reply-To: <87bjaicxm0.ffs@fw13>
References: <ao7Q8miiuLAPVnWv@v4bel> <87bjaicxm0.ffs@fw13>
Date: Mon, 31 Aug 2026 18:19:05 +0200
Message-ID: <878q5mclfq.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 31 2026 at 13:56, Thomas Gleixner wrote:
> On Wed, Aug 26 2026 at 20:41, Hyunwoo Kim wrote:
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 745f6eb5279e6..9b2d140bd9f2a 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1003,6 +1003,18 @@ static int de_thread(struct task_struct *tsk)
>>  		 * the former thread group leader:
>>  		 */
>>  
>> +#ifdef CONFIG_POSIX_TIMERS
>> +		/*
>> +		 * exchange_tids() hands this thread's PID to the old leader,
>> +		 * which is reaped right after. The PID lookup in
>> +		 * timer_lock_sighand() then fails while the per thread CPU
>> +		 * timers are still queued here, so dequeue them first.
>> +		 */
>> +		spin_lock(lock);
>> +		posix_cpu_timers_exit(tsk);
>> +		spin_unlock(lock);
>> +#endif
>> +
>>  		/* Become a process group leader with the old leader's pid.
>>  		 * The old leader becomes a thread of the this thread group.
>>  		 */
>
> Similar to the other issue vs. POSIX timer signals this really wants to
> be solved in exit() independent of non-leader exec(). Let me have a
> look.

Duh. That's about the non-leader itself....

Why did anyone think that swapping TIDs is a brilliant idea?

I still think that this should be done differently. There is no point in
doing the disarming in release_task(). Let me think some more.

