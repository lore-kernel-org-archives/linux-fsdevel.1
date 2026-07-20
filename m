Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A086406816
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548410; cv=none; b=JCE/Jjuj8gfSm7baNND+GK5BCBfJ4OAQvYSnW42XAKxcxAM5nRKDuRWDo2oihswJg+/p3Laxo6HEurBlHqa/MO5jEuy/PEbDfLGmxqKq3RqzMs8DLHJSrAoGS/OdivTtoYQIsds4zfzgPhtSyct/zMITLGCSbL166PnutFjwbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548410; c=relaxed/simple;
	bh=VHEQeDQcQ8hQNSKVqUBJLGtp3S5o4yFUb3C9FREoZvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRuPEqoHiA0i6jD0T8RA8P3CDLDzHh7QW5pp7neVCTvDKsWjDunkb3AK/YqTt9KJ2pXXLx8LfFcIvivU7ZggP46H6Ws6ac5HqqQ3S6Kg0WWlFlQ3wqfraonXl4DZ6qQZ0YstZxsDofyl8URFUYsYxjYq/vdvQhVjYKywkQjrQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjIM38P2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjIM38P2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784548408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX1qciW3YToqJ7WN/x28/hmdDw58K7wiF7yPElpwvmk=;
	b=GjIM38P2VwSFOSgCfYiMmgQyF/1+MjX/3mwgVf/pmHrej6f/hg6DQHiRyCM2RezmM1JFct
	g+b9meRYhQHiF602uIQzdul0Ak2nJwgi4ce8AVxMfuFowkWDTGs8qRNIm4wcBe3eAneCr3
	DfX5jl2JHaunVBjl1rpcBpW9akp4fDU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-EFqhOOtyPP2lh3AGPOLUMg-1; Mon,
 20 Jul 2026 07:53:23 -0400
X-MC-Unique: EFqhOOtyPP2lh3AGPOLUMg-1
X-Mimecast-MFC-AGG-ID: EFqhOOtyPP2lh3AGPOLUMg_1784548401
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72C361956070;
	Mon, 20 Jul 2026 11:53:20 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 54051300418D;
	Mon, 20 Jul 2026 11:53:15 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 20 Jul 2026 13:53:20 +0200 (CEST)
Date: Mon, 20 Jul 2026 13:53:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>, Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, mjguzik@gmail.com,
	josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org,
	axboe@kernel.dk, shakeel.butt@linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4] fs/pipe: unify the page pools into a single per-pipe
 pool
Message-ID: <al4MKZc7AqcUUN5i@redhat.com>
References: <20260710-b4-pipe-unification-v4-1-ff31c39f1c16@debian.org>
 <alpWISUKMvqrp5ET@redhat.com>
 <al3w54SsdZEjKVj4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al3w54SsdZEjKVj4@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/20, Breno Leitao wrote:
>
> On Fri, Jul 17, 2026 at 06:19:45PM +0200, Oleg Nesterov wrote:
> >
> > And READ_ONCE() is enough correctness wise.
> >
> > But AFAIK it is not enough to make KCSAN happy. anon_pipe_prealloc_pop/push
> > which modify ->count under pipe->mutex need WRITE_ONCE() to please KCSAN.
> >
> > Or anon_pipe_prefill_and_lock() can use data_race(READ_ONCE()).
>
> I am not sure that is correct. I got the impression if the reading side
> has READ_ONCE or data_race(), that is enough to please KCSAN.

And quite possibly I am wrong! I was never able to convince myself I
understand the should_watch() logic. See below.

> I will respin with, an additional "__data_racy" attribute in `count`
>
>   struct anon_pipe_prealloc {
>     struct page *pages[PIPE_PREALLOC_MAX];
>     unsigned int __data_racy count;

Ah! I didn't even know we have __data_racy. Much better than what I suggested.
I see you have already sent V5 and it looks good to me.

----------------------------------------------------------------------------
But just for my education, let me abuse this thread and ask KCSAN maintainers
to shed a light...

Marco, Dmitry. to simplify, suppose we have something like

	int DATA;
	struct mutex LOCK;

	void set(void)
	{
		mutex_lock(&LOCK);
		DATA++;
		mutex_unlock(&LOCK);
	}

	int get(void)
	{
		return READ_ONCE(DATA);
	}

My understanding is that KCSAN can complain if get() races with set(),
READ_ONCE() in get() is not enough.

Is it correct?

Oleg.

