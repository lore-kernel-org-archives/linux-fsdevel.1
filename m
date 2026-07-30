Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253944314B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422332; cv=none; b=BJhjs1jwivtWEgx9laXKLDlBeJIujVWUcjdmV26P7pYZEu8j1TmwGiK2Kf9nzXMKjzyXu6JBCyqkIE2nQP7VKqsOTNtGRV/4x86icKfyZeKif9evn/64Fm6gSQ3uBt4JnZ7e36TLiTvNqJvtYBWOWY3BGBzObOramvc06x6Nc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422332; c=relaxed/simple;
	bh=55gMwQOvbGSKQH3jlkSGS/R4h+PpOabZ0QmL/ie1pWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIIgv7grBDHw+4VrUKjZsagBMmmMHlPiMMLaQrsRwNi3blPyTpmXv/nChEAr882B/mTtCTR8nqABC1hcvSygHkr1Zd9tkicmc9DExbiTvWvQUT2lwQvwRbwwggb4lg4vUGkejwLquc7RFnrCBWG5bHtP3sFNnwUTLBmKlhtf6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPtyvvE3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPtyvvE3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785422330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6V5TFSksfMoInHL4xzB6b30PRrezxwtK/qiNd2+o5uQ=;
	b=OPtyvvE3GIDp1zN84Zm08pKzeEx+sKT4jtSyqtg32X72j+YvAP4Nj0nEc6/bi1w0RkCq0U
	54Jkg4OpDw5Yujt3rC8m6VuYXeSC0sQjx54W6Y8J+5X4tqbvnpF9oMmzj5AdL/eDvcl/nW
	9Gx24cM4DB25qZpdCD/Gh0VwvC+jBl0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-sIgbog2dOs6C_sQCpm_j6A-1; Thu,
 30 Jul 2026 10:38:44 -0400
X-MC-Unique: sIgbog2dOs6C_sQCpm_j6A-1
X-Mimecast-MFC-AGG-ID: sIgbog2dOs6C_sQCpm_j6A_1785422321
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CB04195608E;
	Thu, 30 Jul 2026 14:38:40 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2D44E180049F;
	Thu, 30 Jul 2026 14:38:35 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Jul 2026 16:38:40 +0200 (CEST)
Date: Thu, 30 Jul 2026 16:38:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amth6owVUdVOmyAL@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <amtbxpqJ3pZwyT8D@redhat.com>
 <amteY30qxRuPzFh3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amteY30qxRuPzFh3@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Breno,

thanks for taking a look!

On 07/30, Breno Leitao wrote:
>
> On Thu, Jul 30, 2026 at 04:12:22PM +0200, Oleg Nesterov wrote:
> > -	/* Epoll has some historical nasty semantics, this enables them */
> > -	if (unlikely(!READ_ONCE(pipe->poll_usage)))
> > -		WRITE_ONCE(pipe->poll_usage, true);
> > +	/* Enable edge-triggered (epoll, io_uring) per-write wakeups */
> > +	if ((filp->f_mode & FMODE_READ) &&
> > +	    wait && (wait->_key & EPOLLET) &&
> > +	    unlikely(!READ_ONCE(pipe->poll_et)))
> > +		WRITE_ONCE(pipe->poll_et, true);
>
> Can I ask you to factor this out set code, and comment this nasty
> semantics in the function and why we need to do it?

Dou you mean a new helper?

You can't imagine how much time I spent trying to make the comments more
clear but keep them concise ;) More than writing the test for io_uring.

What exactly do you think the comment should say? I agree with anything in
advance. I thought that "edge-triggered" provides enough info, but I would
be happy to improve the docs.

And the helper's name? pipe_enable_poll_et() ?

Thanks,

Oleg.

