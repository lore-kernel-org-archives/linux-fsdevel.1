Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE1288B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305201; cv=none; b=RL9hDK0ybhzIDDsRDjPv1aDFszpnwaj/CJk2R3ml7bMVWl8/rYOL4h19FwxLCCBFiJUw4DC8NCONllwdXaN4nF5oV3Q/vu6Z5cJQCoOsNQIn1J0g0sTggPsUiMKFi6Ts89LzmX2nTftpSIYzOV4538bPAY/3DZddT/T15V8M4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305201; c=relaxed/simple;
	bh=I4oEC7eVVoHJ7LPeHbe06OAnX49CyDZ1/GEyKQ1sewg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqPyDwj6aWtBHPFgIbUp5D5tX0XhVVU1vIDUPUOBNqpNpFjqdXQ6W1xEyS6DnbXEppsfPd97C+UhbzrqrpyAtFFF/nKOE8YlpxNOa47iihbo34JjQJwa+ggCRdlcH5yv228F8Gyflq3yPCT94LwHFha9+jmSC0jv6T318Q5OUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sywt6SMx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sywt6SMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784305199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjn0BTXdoWDlsvPbzHjlCdZk5hB1e9jv57zTgacjfgs=;
	b=Sywt6SMxsR7EWF9Fk6hTCTChBEn45OUNa103qmv5LsFvQLKPn4X56iMgpSutSrT4PAjnD0
	/PGEk/zAdNA5h0D7GyEmKZgt4xsdWmFzv2aC9gpSBGIZ/tGfLpZOD9xhLRxWquwxbe3ycF
	r3P52bQeUiXQCPIXRdlV+ZauBZGtoQQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-rwWyWlgePbObXgIb80ts2g-1; Fri,
 17 Jul 2026 12:19:54 -0400
X-MC-Unique: rwWyWlgePbObXgIb80ts2g-1
X-Mimecast-MFC-AGG-ID: rwWyWlgePbObXgIb80ts2g_1784305192
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93327195D00C;
	Fri, 17 Jul 2026 16:19:51 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6E0601587;
	Fri, 17 Jul 2026 16:19:47 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 17 Jul 2026 18:19:51 +0200 (CEST)
Date: Fri, 17 Jul 2026 18:19:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, mjguzik@gmail.com,
	josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org,
	axboe@kernel.dk, shakeel.butt@linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4] fs/pipe: unify the page pools into a single per-pipe
 pool
Message-ID: <alpWISUKMvqrp5ET@redhat.com>
References: <20260710-b4-pipe-unification-v4-1-ff31c39f1c16@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pipe-unification-v4-1-ff31c39f1c16@debian.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 07/10, Breno Leitao wrote:
>
> Pipes keep two separate page caches:
>  a) The per-pipe, lock-protected tmp_page[2]
>  b) An on-stack anon_pipe_prealloc burst pool of up to eight pages
>     filled before the lock
>
> Converge them into a single per-pipe pool (struct anon_pipe_prealloc
> embedded in pipe_inode_info) with the same budget as before: up to
> PIPE_PREALLOC_MAX (8) pages, trimmed back to PIPE_PREALLOC_KEEP (2)
> after each operation. tmp_page[2] is removed.
>
> Pages are still allocated and freed outside pipe->mutex; only the
> assignment into the pool is done under it.
>
> anon_pipe_prefill_and_lock() tops the pool up to the write's page count
> -- and returns with pipe->mutex held, so a write acquires the lock only
> once.
>
> anon_pipe_trim_and_unlock() trims the pool under that same lock before
> dropping it, then frees the excess.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>

I personally like this change. To me it really makes this logic more
simple/clear.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


One comment below...

> +static void anon_pipe_prefill_and_lock(struct pipe_inode_info *pipe, size_t total_len)
>  {
> -	unsigned int want, i;
> -	struct page *page;
> -
> -	prealloc->count = 0;
> -	if (total_len <= PAGE_SIZE)
> -		return;
> +	struct page *pages[PIPE_PREALLOC_MAX];
> +	unsigned int want, have, need, n = 0;
>
>  	want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
>  		     PIPE_PREALLOC_MAX);
> +	/* Unlocked read; the pool is refilled under the lock below. */
> +	have = min_t(unsigned int, READ_ONCE(pipe->prealloc.count), want);

And READ_ONCE() is enough correctness wise.

But AFAIK it is not enough to make KCSAN happy. anon_pipe_prealloc_pop/push
which modify ->count under pipe->mutex need WRITE_ONCE() to please KCSAN.

Or anon_pipe_prefill_and_lock() can use data_race(READ_ONCE()).

Oleg.

