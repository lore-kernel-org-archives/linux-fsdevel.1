Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78861CA4E
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325552; cv=none; b=aIe7KAponIcl/UU3NCGaUKzPhAzRDFSL06xImaoRKD4Ye2UyPtujfo2HVYtGCb2YmbzKkrb+SfiRW87T/TDxpy3XofWaJQk8j4Xv76Y3EyVJvPZV+b2kl7WntPoBCs0lPTfM8ybgsZOauVd/pfNuG9QFeG0r+4dNUCUcwDT65gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325552; c=relaxed/simple;
	bh=BL5Q9ex0YK8XdXngnpUrzOHULueKaGCMaWaK3FtKlYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcYL5yfZjhH+MDi/mCi02w2cQSpau2uzIWyqWfdQ86xNDNRNCzZ1jVKuQXwScPY1LAeLOc/lKreLv0Q7WAkpiOoJZ3HVc1nZtTbwxNxVilKdyhBaWf6pZ328X8fksFjORYzgNJv+wA5WaQ48Nlhk3d86r2sXJ2KGcZnu+e5uAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlD4hmrX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlD4hmrX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785325550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEIaC/USJlvZJ28ngxcO5Ge7IarI/7jvjyNfBB0K81I=;
	b=BlD4hmrXWK4org52SEXs/eTAcCLKQTeJxSWIQBYOUnHca8xSr7q2YdPIRU1EoipDgxbsvR
	Dbm+/9nqNCkPOqDOnTdQcqJwcmK8u55Q2WllDz9gvsmVka5Q7WaYeMdUxw7wLzABV5qig/
	s20EeSUIT1abeMJ+5Xp8exYdzmm37Zw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-R11FulqQM02du31ezgYBDw-1; Wed,
 29 Jul 2026 07:45:46 -0400
X-MC-Unique: R11FulqQM02du31ezgYBDw-1
X-Mimecast-MFC-AGG-ID: R11FulqQM02du31ezgYBDw_1785325544
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E50C18002C0;
	Wed, 29 Jul 2026 11:45:44 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 180BF1956044;
	Wed, 29 Jul 2026 11:45:39 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 29 Jul 2026 13:45:43 +0200 (CEST)
Date: Wed, 29 Jul 2026 13:45:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
Message-ID: <amnn4nS70qcKFX_o@redhat.com>
References: <amIqfCo25rLtM2U0@redhat.com>
 <amIu5WWgTNkdvqIz@redhat.com>
 <amNvebqiG2fH0W_L@redhat.com>
 <amTT60nc1QNIyPfL@redhat.com>
 <4877b1e6-f4d2-4522-b318-29b49c66b117@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4877b1e6-f4d2-4522-b318-29b49c66b117@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/29, Pavel Begunkov wrote:
>
> On 7/25/26 16:19, Oleg Nesterov wrote:
> > On 07/24, Oleg Nesterov wrote:
> > >
> > > Jens, could you confirm? If yes, we need to update the comments in pipe.c
> > > (I've attached 1/1 at the end, so that you can see what this patch does)
> > ...
> > > It seems that IORING_OP_POLL_ADD / IORING_POLL_ADD_MULTI is edge-triggered
> > > by default! Like EPOLL_CTL_ADD / EPOLLET.
> >
> > Yes, sashiko is right. With some help from AI I wrote the simple test-case
>
> https://github.com/axboe/liburing/blob/master/man/io_uring_enter.2#L400
>
> Seems like it's even documented, which is a shame because I deem
> IORING_OP_POLL_ADD + IORING_POLL_ADD_MULTI to be a half broken API that
> should be deprecated after investigating lxc problems with it some years
> back. Makes me wonder, likely it wouldn't even break anything if shifts
> from strict edge definition for pipes. It's a stream, and the user doesn't
> generally know the number of bytes sitting there.

Can't comment, as I said I know nothing about io_uring ;)

Can you look at

	[RFC PATCH v2 1/1] pipe: only enable the extra wake_up(rd_wait) for edge-triggered consumers
	https://lore.kernel.org/all/amdPACI3kw8PobPx@redhat.com/

?

Not that I think this patch can improve performance, but to me the
"wait->_key & EPOLLET" check documents the purpose of ->poll_usage.

However, from v2 0/1:

	With or without this patch we need to update the comments to document
	that io_uring depends on ->pipe_usage too. And probably rename it to
	(say) ->et_poll.

Oleg.

