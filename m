Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028D4A2623
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000961; cv=none; b=GgwxyOedGXnh01K9Iwn1STPMHW8XW2dGrlI5iVN4k9GSVrcp/xpk4EcfQr1hOEQtn7pkRR6IQQZhCCg6O8krEREDqLOo00L/bm5bKQh4YD1AT0/nuWb6lrRtlNhXPWbWn6Z9fOmqqpQpjlqPf1vaS9729cfA5u5tBxllgCxH//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000961; c=relaxed/simple;
	bh=vEzudWF0GxwUVOeYAYeKieAjXnCT/L2r+RjOFHt8wK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa1nhYIGvuNfVxjcaYBKN6AzdtCRWgGgrVAxKJSeu7gIlQ1l7mYwkWzEDg7OsYZ2WXLTuh20iBzlp3jaJne/s2xt4kh4RLs5oqlGhgqIzTepiuIOwFGSFADOnMTASOgWmuna57ZEyfephBWgizpQs+EUeebVRg0AZgv4clC074o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIZFtA9o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIZFtA9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790000959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtrGPJYqrgm8GjMEcC9ZPfIvGFNMVcDzHftdMMzdcwQ=;
	b=IIZFtA9oTPVhLRUTyToNXi+lPo3NTmhY0bg15E5ECyEVNcb1kiH+ZhE3C9B2SvwZ71mglR
	ZEna72JlBH6C5JnTxUT4HlV2BteVY1iHWoVllSbP3Dv/GuqHNK2rT3NAvmNmydac20qMk0
	LWroE0ryD1QivivOo+tNhCEcqoY43vs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-5rPfoTMHPbmai33uCsAHrQ-1; Mon,
 21 Sep 2026 10:29:14 -0400
X-MC-Unique: 5rPfoTMHPbmai33uCsAHrQ-1
X-Mimecast-MFC-AGG-ID: 5rPfoTMHPbmai33uCsAHrQ_1790000950
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43C62185126D;
	Mon, 21 Sep 2026 14:29:10 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 37FF61800446;
	Mon, 21 Sep 2026 14:29:06 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Sep 2026 16:29:09 +0200 (CEST)
Date: Mon, 21 Sep 2026 16:29:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH v3 15/17] fork: use SIG_KERNEL_ONLY_MASK for the user
 worker signal mask
Message-ID: <arE_MRAFmuvWsM82@redhat.com>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-15-8e4adb1619e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-work-coredump-fixes-v3-15-8e4adb1619e6@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/21, Christian Brauner wrote:
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2146,12 +2146,9 @@ __latent_entropy struct task_struct *copy_process(
>  	if (args->kthread)
>  		p->flags |= PF_KTHREAD;
>  	if (args->user_worker) {
> -		/*
> -		 * Mark us a user worker, and block any signal that isn't
> -		 * fatal or STOP
> -		 */
> +		/* A user worker takes only the signals nobody can block. */
>  		p->flags |= PF_USER_WORKER;
> -		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
> +		siginitsetinv(&p->blocked, SIG_KERNEL_ONLY_MASK);

Acked-by: Oleg Nesterov <oleg@redhat.com>

