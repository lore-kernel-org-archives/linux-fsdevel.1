Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE220156F45
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553601; cv=none; b=IqZo0hUvm23Jx3WSy4E8rahBoWurDGowquqJTHABnRklQ7rFM8iP1G6gDBfYHdUuNADevgF/ObLin4gjxS4DnA8AcAIjQH0V1mBPs+H4nj5jwRQe7zdl052i/tuhyYZNyjZJ7BvOv7pawaWhi8/ME0te4FjI2dBttihKBFTRUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553601; c=relaxed/simple;
	bh=dYgZOsmcHUQcn9PYLBi6YYIEvvuH1jQb/eUNvw4Eij0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE4VFQLkMfAmeh+iy5YazlPV+3jJDX9BH/ympz2xjqz2n0UvgXmthgznwmVs4YEXR8DGKr1jVVHXV+nL1+ijxqsQBRfmNxilmPh650X2JiznFbcHQOGOgkbwAoq9NqXA9LetUp3/lMyesGlDVw2UQY1aL/TukxGc50A1lGvcMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjT9t8vw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjT9t8vw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779553598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WgYwXMpcWonA1bRZnYmpV9NmKbzNvgbEWwUQotrxMzE=;
	b=TjT9t8vwBJVr1XxdzgvSbe/WRnlPsE6hFxamujDlzL1g7seETf5aJiOyxrKnYxR5AbopV5
	Cyh5T9ivvPzgEesNs+xBi62jfdLJNZMgEE6KqiRA22B1Nf8TTLWatywU+Itpmu2TZL8Vh4
	eC6cUQeNpTtVrA6X2oRFkiHUjqfpdvk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-z6LmAlC8ONG4O-RWok-n2Q-1; Sat,
 23 May 2026 12:26:37 -0400
X-MC-Unique: z6LmAlC8ONG4O-RWok-n2Q-1
X-Mimecast-MFC-AGG-ID: z6LmAlC8ONG4O-RWok-n2Q_1779553595
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CFF51800451;
	Sat, 23 May 2026 16:26:34 +0000 (UTC)
Received: from fedora (unknown [10.44.48.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0114B1800349;
	Sat, 23 May 2026 16:26:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 23 May 2026 18:26:33 +0200 (CEST)
Date: Sat, 23 May 2026 18:26:27 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev,
	jlayton@kernel.org, axboe@kernel.dk, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] fs/pipe: pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Message-ID: <ahHVM9hCP65hH82S@redhat.com>
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
 <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

To be honest, I didn't read this patch carefully, but let me ask anyway.

On 05/22, Breno Leitao wrote:
>
> @@ -432,6 +524,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *filp = iocb->ki_filp;
>  	struct pipe_inode_info *pipe = filp->private_data;
> +	struct anon_pipe_prealloc prealloc;
>  	unsigned int head;
>  	ssize_t ret = 0;
>  	size_t total_len = iov_iter_count(from);
> @@ -455,6 +548,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  	if (unlikely(total_len == 0))
>  		return 0;
>  
> +	anon_pipe_get_page_prealloc(&prealloc, total_len);
> +
>  	mutex_lock(&pipe->mutex);
>  
>  	if (!pipe->readers) {
> @@ -512,7 +607,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  			struct page *page;
>  			int copied;
>  
> -			page = anon_pipe_get_page(pipe);
> +			page = anon_pipe_get_page(pipe, &prealloc);
>  			if (unlikely(!page)) {
>  				if (!ret)
>  					ret = -ENOMEM;
> @@ -566,7 +661,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  		 * after waiting we need to re-check whether the pipe
>  		 * become empty while we dropped the lock.
>  		 */
> +		anon_pipe_refill_tmp_pages(pipe, &prealloc);
>  		mutex_unlock(&pipe->mutex);
> +		anon_pipe_free_pages(&prealloc);

Do we really want to call anon_pipe_free_pages() at this point?

The main loop will continue when pipe_writable() becomes true again...

Oleg.

