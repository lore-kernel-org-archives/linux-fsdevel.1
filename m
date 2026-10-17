Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452A1DA57
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244896; cv=none; b=MszcmklkyE1PuQCH9y80o0o/rTe4uUbz2n+JAutcYs2VxHimEvnnBzRf1tTikQ++75FdFpnvVstLkt5cp1cvytPab7cew8MKPhB5sj7oguIdR/RLYUNK1QbQRmFKCsO1rdYa2qv+ZpQytVNxTduun/V+wuZGpg8zJfHHXvTFfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244896; c=relaxed/simple;
	bh=eqZrgv+EiUoIZ/21RE0ZAlJTbgxUylH/mpFCAR17Hd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pozCMmxSqDmoq++sKg82jxj+/sCpJGdQ4Lk7mlM7oE1K2QDRZC3DuE/PUiFN26o7sHfKQRLn3eruOCxEXo38CmlcUbCB8BehWwXXzdb7F2LgNjGvYAzABk6OyN1rKjAzSLw9ICrCwPCpfx0X7OthjQPrQhiZVrKfD5eagSQA1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGODcJF8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGODcJF8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792244893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Awoc4UFXT4JKcC04gaVngFZQ/yn32O2NU/ulFXqzV90=;
	b=CGODcJF8EnwcFUbGonfjA0RW3bo87NEsaiMwuxOP6+CJP9ulf65KWuIWbTciPaAYFiKrZV
	YagV87oGYJiKWJBUzdAo4mjaK2kD1dFnfXCooLTx+1I740/SPb5AwLYC6xufyp/ZHcX3jv
	8rOoNRBx8sa3I56eWaVRrusAkR/NlV0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-3H8KBvrCNDSBKKjkiviQpw-1; Sat,
 17 Oct 2026 13:48:11 +0000
X-MC-Unique: 3H8KBvrCNDSBKKjkiviQpw-1
X-Mimecast-MFC-AGG-ID: 3H8KBvrCNDSBKKjkiviQpw_1792244890
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAA1019560AD;
	Sat, 17 Oct 2026 13:48:09 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C0EC41956089;
	Sat, 17 Oct 2026 13:48:07 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sat, 17 Oct 2026 15:48:09 +0200 (CEST)
Date: Sat, 17 Oct 2026 15:48:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: fujo <hooyan2024@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pidfs: don't report autoreaped tasks readable before
 exit info exists
Message-ID: <atN8loOU6bS_QdZ1@redhat.com>
References: <20261017054356.7874-1-hooyan2024@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017054356.7874-1-hooyan2024@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Sorry, I don't understand...

Christian, can you take a look?

On 10/17, fujo wrote:
>
> pidfd_poll() reports a task readable as soon as task->exit_state is set
> and the thread group is empty.  For a task that is going to be
> auto-reaped (CLONE_AUTOREAP, or a parent that ignores SIGCHLD) this
> happens before release_task() runs and before pidfs_exit() publishes
> PIDFS_ATTR_BIT_EXIT.

But this doesn't depend on CLONE_AUTOREAP/etc; unless the exiting task
is delay_group_leader(), exit_notify() always calls do_notify_pidfd().
The pollers get EPOLLIN.

Then release_task()->pidfs_exit() publishes PIDFS_ATTR_BIT_EXIT, and
another wake_up_all(&pid->wait_pidfd) wakes the pollers again, after
that the pollers should get EPOLLIN | EPOLLHUP.

Please add more details, in particular about your test-case.

As for tools/testing/selftests/pidfd/pidfd_autoreap_test.c
At first glance it is wrong, it should use pfd.events = POLLHUP

Oleg.

> A woken poller that immediately calls PIDFD_GET_INFO with
> PIDFD_INFO_EXIT can therefore get an answer without PIDFD_INFO_EXIT.
> For CLONE_AUTOREAP this breaks the documented use of polling the pidfd
> and retrieving the exit status via PIDFD_GET_INFO: the task is
> auto-reaped and cannot be waited for, so the exit status is lost for
> that poll.
>
> Do not report a task that is pending auto-reap readable until its exit
> information has been published, and wake the pidfd waitqueue from
> pidfs_exit() after PIDFS_ATTR_BIT_EXIT has been set so that pollers
> woken early sleep again and are woken once the information exists.
>
> Reproducer: clone3(CLONE_PIDFD | CLONE_AUTOREAP); the child creates a
> thread that exits after 500us and then exits itself; the parent polls
> the pidfd and immediately calls PIDFD_GET_INFO with PIDFD_INFO_EXIT.
> On current mainline 18/300 iterations (SMP 2) and 78/300 (SMP 1) return
> POLLIN without PIDFD_INFO_EXIT; with this change 0/300 in both cases.
> The in-tree pidfd_autoreap_test global.autoreap_multithreaded case
> fails without and passes with this change.
>
> Signed-off-by: fujo <hooyan2024@gmail.com>
> ---
>  fs/pidfs.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index a6a643f15..5245131ea 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -320,8 +320,26 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	task = pid_task(pid, PIDTYPE_PID);
>  	if (!task)
>  		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
> -	else if (task->exit_state && !delay_group_leader(task))
> -		poll_flags = EPOLLIN | EPOLLRDNORM;
> +	else if (task->exit_state && !delay_group_leader(task)) {
> +		struct pidfs_attr *pattr = READ_ONCE(pid->attr);
> +		bool pending_autoreap;
> +
> +		/*
> +		 * A task that is going to be auto-reaped reaches EXIT_DEAD (or
> +		 * carries CLONE_AUTOREAP) before release_task() publishes
> +		 * PIDFS_ATTR_BIT_EXIT.  Don't report readable until the exit
> +		 * information is actually available, or a poller can observe
> +		 * POLLIN and then get PIDFD_GET_INFO without PIDFD_INFO_EXIT.
> +		 * ptraced tasks are not auto-reaped, so they keep the old
> +		 * behavior.
> +		 */
> +		pending_autoreap = (!task->ptrace && task->signal->autoreap) ||
> +				   task->exit_state == EXIT_DEAD;
> +		if (!pending_autoreap ||
> +		    (!IS_ERR_OR_NULL(pattr) &&
> +		     test_bit(PIDFS_ATTR_BIT_EXIT, &pattr->attr_mask)))
> +			poll_flags = EPOLLIN | EPOLLRDNORM;
> +	}
>
>  	return poll_flags;
>  }
> @@ -790,6 +808,13 @@ void pidfs_exit(struct task_struct *tsk)
>  	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
>  	smp_wmb();
>  	set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
> +
> +	/*
> +	 * Pollers may have been woken before the exit information above was
> +	 * published.  Wake them again now that PIDFD_GET_INFO can return
> +	 * PIDFD_INFO_EXIT.
> +	 */
> +	do_notify_pidfd(tsk);
>  }
>
>  #ifdef CONFIG_COREDUMP
> --
> 2.53.0
>

