Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9644E045
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556269; cv=none; b=lVfzhctIVPKVYm4uToeBAGOVaKC00vOB9QD/wPfp6YKq5SRaloGvjGSCzNp4KZwUlj9hQ9htVrL2SJYc8sYZNZCr6Oc1UciB9l9FISjHiY2kW+NewRGEI2pJGEKd6YK7rIuOvxoQjHGpHp5A9He4kBwwBgYnzSk9Ut1XqZedrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556269; c=relaxed/simple;
	bh=Gd9zyWYFw1QH2ZRXdXVBrrEIh1NzLmvtiduUY2z1j/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4GmgIWSQpCO06dQX+HQZrQfx6Vx9HvpxQAlQejh5MmBRdVQlWdmSxonzMt/BbmxUClZmEmQNNm4XK7FNmuun9URwjWTeTnByl+EveJtmWJ992JB/tX87b6uIz6u5KqoY4r+LnBAdJId5VXhIILguDJKmbTAukgDEP0L9yxQeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTLbueeK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTLbueeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789556242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIBZsoX/9/BL0tooHzw9F+swNS7rjfL51CWf3EsHVog=;
	b=RTLbueeKHrheKoYyLUwVYG86H1qQRmvX/UP7PxAL76qE077unCOwkJtkxF4FT/JLacUN4E
	Rm3jAUxsbTdGiG4jlkMKY75fSlUGXMagAokAfumfnI301MOw+IadrtDhnFLRw/80qj3x3s
	+dlmzS9A+sGESPMr6Zn2y3XSVtgVTzM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-lY7J0SfAPCev4CenNrCiVQ-1; Wed,
 16 Sep 2026 06:57:19 -0400
X-MC-Unique: lY7J0SfAPCev4CenNrCiVQ-1
X-Mimecast-MFC-AGG-ID: lY7J0SfAPCev4CenNrCiVQ_1789556237
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EEE4180065F;
	Wed, 16 Sep 2026 10:57:17 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E8A72195604C;
	Wed, 16 Sep 2026 10:57:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 16 Sep 2026 12:57:16 +0200 (CEST)
Date: Wed, 16 Sep 2026 12:57:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	mjguzik@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] splice: pass a poll key when waking pipe readers and
 writers
Message-ID: <aqp2CcOnuVEeRV8L@redhat.com>
References: <20260916-b4-splice-poll-key-v1-1-438a19351efb@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-b4-splice-poll-key-v1-1-438a19351efb@debian.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/16, Breno Leitao wrote:
>
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -179,7 +179,8 @@ static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
>  {
>  	smp_mb();
>  	if (waitqueue_active(&pipe->rd_wait))
> -		wake_up_interruptible(&pipe->rd_wait);
> +		wake_up_interruptible_poll(&pipe->rd_wait,
> +					   EPOLLIN | EPOLLRDNORM);
>  	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  }
>
> @@ -415,7 +416,8 @@ static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
>  {
>  	smp_mb();
>  	if (waitqueue_active(&pipe->wr_wait))
> -		wake_up_interruptible(&pipe->wr_wait);
> +		wake_up_interruptible_poll(&pipe->wr_wait,
> +					   EPOLLOUT | EPOLLWRNORM);
>  	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>  }

Acked-by: Oleg Nesterov <oleg@redhat.com>

While at it... I think they both should use wq_has_sleeper().

If you agree, feel free to send V2 with this additional change.
Or I will send this trivial cleanup on top of your patch.

Oleg.

