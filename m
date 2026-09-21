Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340913BB104
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007399; cv=none; b=TzjUTYy7+QoiRbEb1U0yiAZtygRAFLSZbmVjaLeaNOLEKubrJXFWG58Ua1in90Hjo/yUOtDoipTbRX4YZmeIe44UCkrG0T84GGzO177S0tDSJ7wwb1ikgQgHSgTpozQRpSim720XEGCzQn1xE6XZfy3iArnrB1J95LIty8hszBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007399; c=relaxed/simple;
	bh=zX3Y+Hl4A7s17CiC//iSg8LfnMHq7LM6R9NWd2f2AH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm9HZI9wVChX+Zjn73XIWGwPS3H0lwA0lviimUik0StlIZetIGJ7BDJ0hs9UXK37h72Tpqw7rrdvVBVn5UUQ9T8HkpXoaZf7xMLKb7V/wDDX7q3Y/KDnxawIevUPYDyQablAlSq6vE1O7yHOIK6hEsxiDjbk73PiErI1xhu7vD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AW/leKeT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AW/leKeT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790007395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7FXFbQgnyVFHazdwMvEWtM/nOP8qDBJcZZSaid5hmo=;
	b=AW/leKeTMjwzA+oPm725odS+aAC3qGw856fGHshuZHXtiHKIyTlk7KSWW+7qeNPEh8Nrl4
	kycNvPHM6QeyOkYEIeZMfZWI3q/ayBL3MzTzAcsUBwqADaWkan0S1Jh27Y4pLZJ3fcRum9
	mavEcgjqe2f0mKFLD5R8GzbfLuFlGSY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-dsFLz2KPPiuUUHBpXd39VQ-1; Mon,
 21 Sep 2026 12:16:32 -0400
X-MC-Unique: dsFLz2KPPiuUUHBpXd39VQ-1
X-Mimecast-MFC-AGG-ID: dsFLz2KPPiuUUHBpXd39VQ_1790007390
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4736197702B;
	Mon, 21 Sep 2026 16:16:29 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3C3211956041;
	Mon, 21 Sep 2026 16:16:25 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 18:16:29 +0200 (CEST)
Date: Mon, 21 Sep 2026 18:16:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH v3 16/17] signal: enforce the user worker signal mask in
 __set_task_blocked()
Message-ID: <arFYWLJ8yzpS325k@redhat.com>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-16-8e4adb1619e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-work-coredump-fixes-v3-16-8e4adb1619e6@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/21, Christian Brauner wrote:
>
> The in-kernel sigprocmask() users block more signals for a critical
> section and restore the saved mask afterwards. cifs used to do that in
> __smb_send_rqst() and ocfs2 in ocfs2_block_signals(). Both were
> reachable from an io-wq worker. Both only add SIGKILL and SIGSTOP to the
> user workers's and then put the fork-time mask back.

Ooh, this reminds me... see below.

> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3212,6 +3212,16 @@ long do_no_restart_syscall(struct restart_block *param)
>
>  static void __set_task_blocked(struct task_struct *tsk, const sigset_t *newset)
>  {
> +	sigset_t floor, floored;
> +
> +	/* A user worker never unblocks anything but SIGKILL and SIGSTOP. */
> +	if (unlikely(tsk->flags & PF_USER_WORKER)) {
> +		siginitsetinv(&floor, SIG_KERNEL_ONLY_MASK);
> +		sigorsets(&floored, newset, &floor);
> +		WARN_ON_ONCE(!sigequalsets(&floored, newset));
> +		newset = &floored;
> +	}

OK, Acked-by: Oleg Nesterov <oleg@redhat.com>

although to me something like a more simple version

	/* A user worker never unblocks anything but SIGKILL and SIGSTOP. */
	if (unlikely(tsk->flags & PF_USER_WORKER)) {
		sigset_t xxx;
		siginitsetinv(&xxx, SIG_KERNEL_ONLY_MASK);
		if (WARN_ON_ONCE(has_pending_signals(&xxx, newset)))
			return;
	}

makes more sense. But this is minor.

In fact I think that __set_task_blocked() should simply do

	if (WARN_ON_ONCE(tsk->flags & PF_USER_WORKER))
		return;

but yes, we can't do this right now, we have in-kernel abusers of sigprocmask().

IMO, they should be changed to not rely on sigprocmask(). Lets look at
ocfs2_delete_inode() for example,

	/* We want to block signals in delete_inode as the lock and
	 * messaging paths may return us -ERESTARTSYS. Which would
	 * cause us to exit early, resulting in inodes being orphaned
	 * forever. */
	ocfs2_block_signals(&oldset);

ocfs2_block_signals() blocks everything including SIGKILL and SIGSTOP.
I guess to protect against signal_wake_up / TIF_SIGPENDING ?

But this can only help in the single-threaded case. And PF_USER_WORKER's
are never single-threaded.

Blocking SIGSTOP can't protect from SIGSTOP if another thread dequeues
SIGSTOP or another sig_kernel_stop() signal. This another thread will do
do_signal_stop() -> signal_wake_up().

Same for SIGKILL...

In short, I agree with this patch, but mostly because of WARN_ON_ONCE()
it adds.

Oleg.

