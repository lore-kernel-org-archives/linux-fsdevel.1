Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A74C9DEA
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352125; cv=none; b=NHRBExXxbeIT9cpEKbzLn1aUb9bw37XZLI4YWvEN4s27Q/1wrdjsw94dVYjyCKqZlDDnCgMMsYYi2CRqsldd3F3LnPvkEaL+q5LiLF3i0LQ3NzpWjLpCeTeXxxMVMIVqLK45ElUWXoo2c3VioLs6pFJXif4bhjCoXPoF0kyK0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352125; c=relaxed/simple;
	bh=GsEMOnixILne7EvEtLkgu8eRpOY0e1jx7bdDKHtIP/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZc2sjhMctd2RXcdJNnwsohh/A0yd7Jrx0EBskqcKnVwlAhlN4A8gHWk7XY+kfBLlqVKNF06RmYD5jGGuUAq0ONn6iIKNYN74NAjzy0adUEshiAk0IsVVKPMWAIWIfk0wG6cWwn+nlMflK25yTnjDZ7SnS3ph1qkr7D0w96ZG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KecdTOMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KecdTOMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C3C1F000FF;
	Fri, 25 Sep 2026 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352124;
	bh=9MHYc7XO6Pw0DyWwwaGqffSv7MpmVDg2RzfrfS9X3uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KecdTOMH/vqXduAv0z8OZ2vbma5MrO789Sroxjo2GbD+Wqa/9HZt7YgQZ5bQp2cRJ
	 AV3tPcEo9YwNJ5VFIX062QmI3/K2tg+XH+yPGfDWjH25u5LH/eGL5bkayeu57v8BGN
	 mdZfAyftQQl7hE5BZPyVbwL8TstI2x4VjRR4qVK+modAS/Se1RN+6GEEnI9jnkNKDp
	 0N/x/czvMyO6YDLP1LFhJVf12pMGEWJrvX7TdO/sYjxYYYa7NVViyPjWUYJzKI3PJf
	 o7DVyS4hpLobGL6UoHznmspHb4uls6GmzitbwNNPYGMeWOreYvgWC5fQDWs94Z+Rop
	 87GjNJs2Gqnpg==
Date: Fri, 25 Sep 2026 18:01:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC v4 15/18] coredump: add COREDUMP_CLOSE_FILES
Message-ID: <20260925-kundgeben-kopfnicken-katapultieren-85e8f57ef815@brauner>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
 <20260910-work-coredump-unlock-self-v4-15-a5c1800dc930@kernel.org>
 <arU4EfGVonMKgzrb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arU4EfGVonMKgzrb@redhat.com>

On Thu, Sep 24, 2026 at 04:47:45PM +0200, Oleg Nesterov wrote:
> On 09/10, Christian Brauner wrote:
> >
> > Add COREDUMP_CLOSE_FILES and allow a coredump server to request that the
> > thread-group closes all files before creating the coredump.
> 
> Perhaps the changelog could explain the motivation for this feature...
> 
> The patch looks correct, but let me ask some question.
> 
> > +static bool coredump_close_files(struct core_state *core_state)
> > +{
> > +	struct files_struct *files;
> > +	struct core_thread *ct;
> > +
> > +	files = alloc_files_struct();
> > +	if (!files)
> > +		return false;
> > +
> > +	for (ct = core_state->tasks; ct; ct = ct->next) {
> > +		/* Tasks without a table such as vhost workers can be skipped. */
> > +		if (!ct->task->files)
> > +			continue;
> > +		atomic_inc(&core_state->threads_remaining);
> > +		/* ct->files holds a reference until the thread switches to it. */
> > +		atomic_inc(&files->count);
> > +		/* Pairs with the acquire in coredump_task_exit(). */
> > +		smp_store_release(&ct->files, files);
> > +		wake_up_process(ct->task);
> 
> I don't understand this smp_store_release() and smp_load_acquire() in
> coredump_task_exit().
> 
> Both wake_up_process() and set_current_state() have the necessary barriers,
> see the comment above set_current_state(). So it seems that we can use the
> plain store/load.

Oh, I wasn't clear on that.

> But what I really can't understand is why coredump_close_files() can't just
> do switch_files_struct() itself. It could do override_creds(ct->task->cred)
> if this is one of the reasons.

It can, it just felt cleaner to let the individual tasks do it. But I
have deferred that part of the patch series until we got the synchronous
close in.
