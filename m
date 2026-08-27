Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794D3612CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787836401; cv=none; b=TvQ2+AFX20L3eAI9m2GtMl1Ea7xNXVd94e3g0T+b+PI5wNjR2aIcv5QRvWmvDkEJvTaDQhASlWcSF42UzKgKYjlJ913Bp/jN0+I3YVNrsw/YHpatNihKGfsUlS9ec296zgVSTnXw1iOytuHJkOAYOMfAWjv7RrfLHzBDoP8R9ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787836401; c=relaxed/simple;
	bh=Y4UIaj0/Xb1QS1ysEaFPL+JgpkjKD/CJpN5pvFCbJaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7YP7eCQGpTWzUf4k4MDCdU4rKXzLjlZaEdUctWUZQBvBN5lVBZ0EW+zc57Mh1LbfdYlg5J7xkQhkdET6vTpxoSOjmS6vexLTQo3qvsO0Rk1NYk1d1dvBe+EsknizIaW2Fm6V0c8sqnKidkv5JXw8gzFNeSsoYPG6cFWAuIKTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9rBiClF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9rBiClF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1031765b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787836387; x=1788441187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YyQH4Zg7pq+6kxETlvUNM4xdruhUnmakMDW16/OuM/o=;
        b=l9rBiClF/nHVHbl/iF5IyoIKlxcI/JT33nFTzCxrLdccE+fPpVkOLBtW6QD/lBimO6
         i+ywO2vu/UriKEjsv9hzw/OwnKooOrIcdYHzp/D5+k9tYfRV/pSlzODLNVAj1+I+abfg
         scApNaZL2H8uo4zLlGxyviVUWFjqcIZ/MupJCXikCdfdh/u2Qdv9qxmgtEll4L8fge5r
         wdW8vVY7fjDYrC5Dg1ppYH6L4JUy5fw9PnsMA2qZqWU+6EO6SgAdeoKER8QZddNsv1aJ
         hPRfTxc8mccJjQUwIMpIqjFwQJMlqUxA2PAg8T19d3tZw4xExGsEXU7p0sdrU1Sr2a+c
         ELzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787836387; x=1788441187;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyQH4Zg7pq+6kxETlvUNM4xdruhUnmakMDW16/OuM/o=;
        b=CDLi6VxY6md00OWObgqp44LcNGMY3jZCGV4A0gm1EpzqwQk5mCzTQGUcYtxhkmSRxx
         AQ2eqzVcPCputxmy/kcLHh0AOo0/04vpOOLDLPu4q+tQP/DcKYRuX3+J6p0lo6IlCZnH
         zCLNWAiJJ7czgiLPeGx6OiInTok0WpucSvYVPYn0DEJZC5Nv2DTCeRlMxqV2HlwG62Kw
         uqwP40fKgIMmSSA4UZFQk2PHVXl8Gcv5qziC4foUvrt+NpqI7p2EOev2wVlluUdvcORV
         5jzAYPFJ9TdVY/xNDAOfFot9IBt35k2QTgHlCPREO5n6fWR22Z3100onvbOJNMtSNDTm
         ts2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp1bHGRcLStPlK5LaxhuAQeyGgGNEVs8tnwRc24IRTkuySpuLh5ISuqirrDlcTRXH0VzYaZkSPP0s6aPEeZ@vger.kernel.org
X-Gm-Message-State: AFuF++nm5wS2ywpVV0x/PBwfWUYZiTh5Wg7VMx8NpRtkpqZY7t15M58n
	6tW2l95jZuiHnzcSGmXViRzQzZM2Yjh6bodjpIt/U2zYtJR20n6GJzKz
X-Gm-Gg: AR+sD11q3Y0TiY1SPHzpu0Pz57Oed8ZMJoAIAGf8UR36XxTP+VyDIA1hH5GvR0m9RDl
	W+WUMLNqyyczr7qITSUmruwCzcVdJ6fucc0t81BaGOrLJHwKtDKhVRY4OB87kZDVuG3rQb/SG55
	8/MperR0e4Ums5GVxM/x6pK+FvacBmR0WUa+RD7hwTA6dyRTg2qHBZYWW7chA0P9WYEEDr1wJ+n
	cxUxt2OgrNovwQgWZLq/88PHnb+QzOsSnVEttRUBqZ3ZwhxIR3QWO1ffChXD5tUnV9/Fe7TmRRE
	67gCTAfxagbtjm5uuLSTtAYaqSYqEGFOXyXVnu5xVY/TR3e101QZHpfBYwX7qJ2/UmCm87BjthE
	D7SxKccTDT01dJd/nv28kHIyj/MmvXFhLksWZMsPW2hGaJdPTxsuBCdmoGb3vOXEx+UGD/0EVey
	VAWGD3GEsgGPavvoGcQDjj1fP2iL3H+IoaxllQ5dpoGu412Z6CTvDhcU8T/j5JFsHjFAkABY7zZ
	DsvNWqJ
X-Received: by 2002:a05:6a00:27a5:b0:84a:65e8:137e with SMTP id d2e1a72fcca58-854c8f0d4admr7999711b3a.17.1787836386527;
        Thu, 27 Aug 2026 06:13:06 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535acbbb6bsm2096885b3a.24.2026.08.27.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:13:05 -0700 (PDT)
Date: Thu, 27 Aug 2026 22:13:01 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] posix-cpu-timers: Dequeue per-thread timers before
 exchange_tids()
Message-ID: <apA33QXNSwDBxeXK@v4bel>
References: <ao7Q8miiuLAPVnWv@v4bel>
 <ao7iQ_wOLghOvTsq@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao7iQ_wOLghOvTsq@redhat.com>

On Wed, Aug 26, 2026 at 02:55:31PM +0200, Oleg Nesterov wrote:
> OMG, my head spins ;) I'll try to read your explanation tomorrow.
> Right now I am all confused.
> 
> But let me ask some stupid questions right now, please help me to
> understand the problem.
> 
> On 08/26, Hyunwoo Kim wrote:
> >
> > begin_new_exec() calls posix_cpu_timers_exit(me) right after
> > exec_task_namespaces() and that removes the leftover node, so the state
> > normally stays invisible. But bprm->point_of_no_return is set before
> > de_thread(), so if unshare_files(), set_mm_exe_file(), exec_mmap() or
> > exec_task_namespaces() fails, the task dies before it gets there.
> 
> Do I understand this correctly? If begin_new_exec() does call
> posix_cpu_timers_exit(me), then everything is fine.

Yes. A failure after it, e.g. unshare_sighand(), is harmless.

> 
> Yes? If yes
> 
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1003,6 +1003,18 @@ static int de_thread(struct task_struct *tsk)
> >  		 * the former thread group leader:
> >  		 */
> >
> > +#ifdef CONFIG_POSIX_TIMERS
> > +		/*
> > +		 * exchange_tids() hands this thread's PID to the old leader,
> > +		 * which is reaped right after. The PID lookup in
> > +		 * timer_lock_sighand() then fails while the per thread CPU
> > +		 * timers are still queued here, so dequeue them first.
> > +		 */
> > +		spin_lock(lock);
> > +		posix_cpu_timers_exit(tsk);
> > +		spin_unlock(lock);
> > +#endif
> 
> ... then why do we need to call posix_cpu_timers_exit(current) before
> exchange_tids() ?

Strictly we don't. posix_cpu_timers_exit() walks tsk->posix_cputimers
directly and never does the PID lookup, so it only has to happen before
exit_itimers()

I put it before exchange_tids() so that the state timer_lock_sighand()
warns about never exists in the first place.

> 
> And what if another process attaches another cpu timer to the execing
> thread right after the code above?

Not for a per-thread timer, pid_for_clock() requires same_thread_group()
and there is no other thread left at that point.

A process wide timer has no such check, but it goes to
signal->posix_cputimers and the TGID lookup stays valid, so it isn't
affected.

> 
> Can we move posix_cpu_timers_exit() or the whole CONFIG_POSIX_TIMERS
> sequence in begin_new_exec() up, right after de_thread() before the
> "if (retval)" check?

posix_cpu_timers_exit(me) there is enough. I haven't tested moving the 
whole block.


Best regards,
Hyunwoo Kim
