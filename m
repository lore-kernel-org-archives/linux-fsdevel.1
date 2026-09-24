Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95291392C4C
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261280; cv=none; b=HsOEqfU0e03hdpzz+P5Y89jpqLhEfNdkZQsSg4JGXR4wUMvK/IiokxSHtEybLqUTED0qG3nYQ07Pjr2nLRth6ghqh0xMZ6mrmASsLnXEsJHajkycPHDm5vmQfe5I12BK2pZRLyuisAMHIfRWTe0SyMY9OgQGWVrgcj8C2DJ/2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261280; c=relaxed/simple;
	bh=w+5Y+gQIKmUWfkGa1lzCBH5WbGfCDMhxWHvyf7Zqkg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTR2v/dCTeMlVmn4yn6g7SovrgbPBJBHFZfNIh9ECuQG8Oo1OM/4AbSM9ttlNWvUC/FwMBQQy7yRz8PjcYjeR3S8BYeJm9CUJxYfDhjPzCa8XKRlzb62yIL3HIrqNK24xmhUZRZcjIAEle/BfGgkk+tMnCcGZMxjxM/pUJ93jgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mam8G1Fm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mam8G1Fm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790261277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXtD/VeImw+3QxNdTouXsPRojgAQeQrARPweEV2ZWxc=;
	b=Mam8G1Fmdjs3f/YumDDcLI/HqhcZxkJymLxXZlNdVtHy17K+vuHopxJO7/SdR3hhpA+mOI
	RPtxlHpwX/++wjnJ4GnfpHaFnvcDZydx7v5Urj41phM6wgBRNJeO2p64EdsTWPj9UCUM51
	5HHg4wt9LDNlAl2aCj3+8mWUIlPVWW8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-DTvszu7WOfOBRa4k6hpTlw-1; Thu,
 24 Sep 2026 10:47:51 -0400
X-MC-Unique: DTvszu7WOfOBRa4k6hpTlw-1
X-Mimecast-MFC-AGG-ID: DTvszu7WOfOBRa4k6hpTlw_1790261270
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B92F196F752;
	Thu, 24 Sep 2026 14:47:49 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B477A18005B5;
	Thu, 24 Sep 2026 14:47:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 24 Sep 2026 16:47:49 +0200 (CEST)
Date: Thu, 24 Sep 2026 16:47:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC v4 15/18] coredump: add COREDUMP_CLOSE_FILES
Message-ID: <arU4EfGVonMKgzrb@redhat.com>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
 <20260910-work-coredump-unlock-self-v4-15-a5c1800dc930@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-work-coredump-unlock-self-v4-15-a5c1800dc930@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/10, Christian Brauner wrote:
>
> Add COREDUMP_CLOSE_FILES and allow a coredump server to request that the
> thread-group closes all files before creating the coredump.

Perhaps the changelog could explain the motivation for this feature...

The patch looks correct, but let me ask some question.

> +static bool coredump_close_files(struct core_state *core_state)
> +{
> +	struct files_struct *files;
> +	struct core_thread *ct;
> +
> +	files = alloc_files_struct();
> +	if (!files)
> +		return false;
> +
> +	for (ct = core_state->tasks; ct; ct = ct->next) {
> +		/* Tasks without a table such as vhost workers can be skipped. */
> +		if (!ct->task->files)
> +			continue;
> +		atomic_inc(&core_state->threads_remaining);
> +		/* ct->files holds a reference until the thread switches to it. */
> +		atomic_inc(&files->count);
> +		/* Pairs with the acquire in coredump_task_exit(). */
> +		smp_store_release(&ct->files, files);
> +		wake_up_process(ct->task);

I don't understand this smp_store_release() and smp_load_acquire() in
coredump_task_exit().

Both wake_up_process() and set_current_state() have the necessary barriers,
see the comment above set_current_state(). So it seems that we can use the
plain store/load.

But what I really can't understand is why coredump_close_files() can't just
do switch_files_struct() itself. It could do override_creds(ct->task->cred)
if this is one of the reasons.

Could you explain this please?

Oleg.

