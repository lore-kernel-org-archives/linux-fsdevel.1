Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227B41DE01
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748949; cv=none; b=QtBipUNshFE5gTvbl1A/dp3gOfyJbrQ/r88WqRRr8vDUITB7NTEsD+qU3bOm+Ia912e6wuIInQcYNAwOv2WQ1mjq5RT/hd9QUZ0oIobTl+UkKl75VDAsUj3tJ/qF4Y35XLfU8m0qf67ssWJobitSAeuQRqLQJY+ASKUvdQ/n1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748949; c=relaxed/simple;
	bh=yMnzQaobEJbTa3YXl8ltC8e5TTqYmwhe9yUESQw1eiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDiQvYevaMhmE/iOP4BLH/fb/5Lx23lxrhhts3tMJ7SQPSlX0bRsawkVy0LsdOFG73U2kVHuJY2JtnUWLJrlM3U/CMFVyaH+5hPxhYJEzQqcoTKkmG4lpYGdSvsQj2KyZIeNbicvpGfZ+8WWtva7DwYlvrMhgIroOPnk0tWmACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNzyZ+FG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNzyZ+FG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787748946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VnrjRmkdDMOkUOanYpX8DXzjHMEr7A8cKpEvbJBdT7o=;
	b=UNzyZ+FG2ENE+CYAeBLZaMNfATSpHYSllvhaRBZPKsZmNKTgUOOjfUB+erxq7h25MKfknd
	r2TUgAveS2sXG6OTfK1ONQX15V+H6uI3BHoFidyIjViIRZUuHbU07zvVfz7f4gynF9011b
	7glBMozsoyVoJ6e0s5kpzeP1uNZuPbs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-OyLs-H8nPUi38HBJaBo-pg-1; Wed,
 26 Aug 2026 08:55:40 -0400
X-MC-Unique: OyLs-H8nPUi38HBJaBo-pg-1
X-Mimecast-MFC-AGG-ID: OyLs-H8nPUi38HBJaBo-pg_1787748938
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 187341956088;
	Wed, 26 Aug 2026 12:55:38 +0000 (UTC)
Received: from fedora (unknown [10.44.48.90])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CFE3940E;
	Wed, 26 Aug 2026 12:55:32 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Aug 2026 14:55:37 +0200 (CEST)
Date: Wed, 26 Aug 2026 14:55:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] posix-cpu-timers: Dequeue per-thread timers before
 exchange_tids()
Message-ID: <ao7iQ_wOLghOvTsq@redhat.com>
References: <ao7Q8miiuLAPVnWv@v4bel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao7Q8miiuLAPVnWv@v4bel>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

OMG, my head spins ;) I'll try to read your explanation tomorrow.
Right now I am all confused.

But let me ask some stupid questions right now, please help me to
understand the problem.

On 08/26, Hyunwoo Kim wrote:
>
> begin_new_exec() calls posix_cpu_timers_exit(me) right after
> exec_task_namespaces() and that removes the leftover node, so the state
> normally stays invisible. But bprm->point_of_no_return is set before
> de_thread(), so if unshare_files(), set_mm_exe_file(), exec_mmap() or
> exec_task_namespaces() fails, the task dies before it gets there.

Do I understand this correctly? If begin_new_exec() does call
posix_cpu_timers_exit(me), then everything is fine.

Yes? If yes

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

... then why do we need to call posix_cpu_timers_exit(current) before
exchange_tids() ?

And what if another process attaches another cpu timer to the execing
thread right after the code above?

Can we move posix_cpu_timers_exit() or the whole CONFIG_POSIX_TIMERS
sequence in begin_new_exec() up, right after de_thread() before the
"if (retval)" check?

Thank you,

Oleg.

