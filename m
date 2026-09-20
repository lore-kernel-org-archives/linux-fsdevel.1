Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6D3AFCF0
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789917323; cv=none; b=pZqNr73s+rc4Clw28G+VdJ2t6k2b+ggTv/Yrxcjd1jnZfCaOuKTtdupgj2/0gouzFz5VF093QhJudc7/s+zuPuIdL9AJflCHX/WlzKgCFhpO8Q89LsAHm1T0xgicPGpY1P2QlfzzSMGlL5NnJvQWIYqOM3EWiyV911o2Athb8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789917323; c=relaxed/simple;
	bh=GzgnvIUZuTISolfks6jtEGpq+PCFa+IpBleh23SiJ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLZQ5cRcBEXyu9WkaiWwb7iHNaAMlJU5HP8MgBllQwy3X9DzLrAj7xyDFwyRIXULxh8NRkR60jH5AsAbscdf5j4zSaz2o+aRQvzwNRO4WHI3Zl+rxdI/0AhOVxxo2nWiDca3BvBjA9U3ID9aWeVdIzYmILReb/jvUCLk/v8hZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htm0S7lQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htm0S7lQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789917320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPP3HBXD0HVoCCj/kBuPA6/lcgb/IF+n7p3Pg2EkF+g=;
	b=htm0S7lQxePtjOgHqz8YM9IzTV62G8f9d4w9J3VegL3c7wUIXyejnPwuALpOoJ5oWaP99r
	avwVryqdOYfMOaVHVBvnV737dJxsFuWulTRbDWWSkzsJ5UfvpdgVuE+x0b66khq6tJptr/
	DIUZSmZlDwKjH5uh8ctOfVpJtrNH3Nc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-GlfUHkt8N1uLLTONHapGaQ-1; Sun,
 20 Sep 2026 11:15:17 -0400
X-MC-Unique: GlfUHkt8N1uLLTONHapGaQ-1
X-Mimecast-MFC-AGG-ID: GlfUHkt8N1uLLTONHapGaQ_1789917315
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6C3118009E7;
	Sun, 20 Sep 2026 15:15:14 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9D0F21956095;
	Sun, 20 Sep 2026 15:15:10 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 20 Sep 2026 17:15:14 +0200 (CEST)
Date: Sun, 20 Sep 2026 17:15:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Chris Mason <mason@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org
Subject: Re: user workers as coredumpers [Re: [PATCH 1/6] coredump: don't
 switch a dumper that has no files] table
Message-ID: <aq_4fY6GVtK47Njq@redhat.com>
References: <20260915-work-coredump-fixes-v1-1-f354ca41780c@kernel.org>
 <20260916194837.3732307-1-mason@kernel.org>
 <20260917-staunen-sparsam-infusion-83238c68d21f@brauner>
 <178960987412.207413.3957049392884487413@noble.neil.brown.name>
 <20260917-zahnpasta-aufweichen-flackern-1182320f5c81@brauner>
 <20260918-tonart-umgeladen-gesponnen-519fca5172bd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-tonart-umgeladen-gesponnen-519fca5172bd@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/18, Christian Brauner wrote:
>
> So I thought a bit about this yesterday and had some brief discussions
> bout this as well. I think we should kill this whole bug class by
> ensuring that PF_USER_WORKERs never participate in a coredump.

Agreed,

> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3021,6 +3021,21 @@ bool get_signal(struct ksignal *ksig)
>  		 */
>  		current->flags |= PF_SIGNALED;
>
> +		/*
> +		 * PF_USER_WORKER threads will catch and exit on fatal signals
> +		 * themselves. They have cleanup that must be performed, so we
> +		 * cannot call do_exit() on their behalf. Note that ksig won't
> +		 * be properly initialized, PF_USER_WORKER's shouldn't use it.
> +		 *
> +		 * They must not dump core either. The dumper waits for every
> +		 * other thread in the group to exit, and a sibling's exit path
> +		 * may in turn wait for this worker's own exit, which only runs
> +		 * after get_signal() returns: io_sq_thread() ends up in
> +		 * io_wq_exit_workers() and waits there for its io-wq workers.
> +		 */
> +		if (current->flags & PF_USER_WORKER)
> +			goto out;

This probably makes sense anyway... but see below.

Perhaps it makes sense to change ptrace(PTRACE_SETSIGMASK) to fail if
child->flags & PF_USER_WORKER ?

Currently get_signal() from PF_USER_WORKER can only return SIGKILL,
I think we should keep this rule.



I don't think your change can fix all problems. Suppose we have a main
thread T and a PF_USER_WORKER sub-thread W.

Some signal, say, SIGHUP has a handler. Debugger unblocks SIGHUP for W.

Now, kill(SIGHUP, T) can choose W as a target, complete_signal() can
choose any thread if wants_signal(t) is true. W will "drop" this signal,
its signal handler won't be called.


In the longer term it would be nice to rework this logic somehow to not
rely on ->blocked...

Oleg.

