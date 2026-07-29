Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D413C1D56
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340042; cv=none; b=nxuvKiR0WwnwW8dd1WmOlEmf09cqSPS/STTsC50ATCAgNV3fCdHWbY7atrFjohTjX2UL/Y0Acrb9G0LggI6sdFk1Y704wjdU9B6w1quNXZCqksyEPA29qqxtoL3/lE6VN0YuoV6TonUAbUL5f9H0zu+XAP91nupXEuVFsdIH5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340042; c=relaxed/simple;
	bh=t80hFN66vXiPk2fRNepvXdjAI74lOIcPDPAEG4KB8qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMkGubLDMPbwv0goWrVR12zcz4n37nBOLok5mlZIFCMdXuR90/oBAU1COPYWI8m0GjF1jkJDuqyuC3GJeNfouyNnfI0ifTjuFWbOxNTKX0vYvbQ6hBsWQeUDVLcQyDf6dEJYFgMkKM4xX/lL4WJuT+mHDCWfisLl5H6X1sXjdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlFdlZ18; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlFdlZ18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785340040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNdO5wQyKXTjdfRS/pKROQMH0S6WrLY/Fns1no6aYjk=;
	b=JlFdlZ187pE86w+cRp7FBngv+OZD5OrgL0l22kHIRf83403lQDt2JnkrlX6Q6zTaPCWhnm
	lAcgCdcPK7ivo2Mmb3BPo66BbzLrgh9anSPcfiyWcSiX2AiZFX6mCvh8PhKSZB/s6ZOm4e
	0h9kGETpF6blFEPAUKHtvLhNOetnRII=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-oLZUzhwxMKiRcla2aU_eUQ-1; Wed,
 29 Jul 2026 11:47:14 -0400
X-MC-Unique: oLZUzhwxMKiRcla2aU_eUQ-1
X-Mimecast-MFC-AGG-ID: oLZUzhwxMKiRcla2aU_eUQ_1785340032
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD3D9195608B;
	Wed, 29 Jul 2026 15:47:11 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 32DBE300019F;
	Wed, 29 Jul 2026 15:47:06 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 29 Jul 2026 17:47:11 +0200 (CEST)
Date: Wed, 29 Jul 2026 17:47:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] pipe: only enable the extra wake_up(rd_wait)
 for edge-triggered consumers
Message-ID: <amogeROg0Hthp7HD@redhat.com>
References: <amdNxsTODR4MCl3R@redhat.com>
 <amdPACI3kw8PobPx@redhat.com>
 <1bd5710b-29c8-4a8c-8f26-72d9e71c2321@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd5710b-29c8-4a8c-8f26-72d9e71c2321@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Pavel, thanks for taking the look!

But let me ask a couple of questions to ensure I really understand you.

On 07/29, Pavel Begunkov wrote:
>
> On 7/27/26 13:28, Oleg Nesterov wrote:
> > pipe_poll() unconditionally sets poll_usage on the first call, forcing
> > anon_pipe_write() to wake up readers on every write even if the pipe was
> > not empty. But this is only needed for edge-triggered consumers: epoll
> > with EPOLLET and io_uring without (unsupported) IORING_POLL_ADD_LEVEL.
> > poll() and select() users pay for it for no reason.
>
> Sounds good, especially with prep patches you mentioned.

By prep patches you mean the

	With or without this patch we need to update the comments to document
	that io_uring depends on ->pipe_usage too. And probably rename it to
	(say) ->et_poll.

note in "v2 0/1" ?

If yes, I'll send this change as "v3 1/2", rediff this patch on top of it,
and make it "v3 2/2".

> The only note your problems are caused by IORING_OP_POLL_ADD, which
> is not that important comparing to other polled io_uring requests,
> and they also set EPOLLET while should be fine with level. Not
> asking to change anything, io_uring should just stop setting EPOLLET
> for them. And IIUC poll callback implementations don't care about
> EPOLLET, at least before this patch.

Sorry, I am a bit confused, could you add more details?

In particular, I don't understand the "IUC poll callback implementations
don't care about EPOLLET, at least before this patch" part.

Although it seems you agree that this patch should not break (change the
current behaviour of) io_uring, and right now this is my only concern.

Can you ack/nack my understanding?

Thanks!

Oleg.

