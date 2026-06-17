Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75849252B
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710282; cv=none; b=gJpaObR5uQn1+fOsCEKuWhOc5pWVbyYA8yRfkVYMjJyGcH4sdEaJJEowCbv2MvXS5Ku8mcIXMlSzDJEVvG0OMDe3H1fu4LdWB4rq+99iFwadQZp1+Z33iF6RO3JIEk4erxqhsWRe1vI4RLj6twcCXK33z+xlyU33Gsd6VWlyXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710282; c=relaxed/simple;
	bh=Ovcsr+HA/j9A5UnPiO2TTU0W/WwIr3zx47bIiZy6JI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7t8kns8Lu1d/8QM/k+cCvDmLqskwgpfBI+MEQHEGU4CQUsA16eG9igytJa6AiRLhLH70dcBkI8pVNepqYdaVSHqaAl4ny8GfiMeZbIJJDHw0gMjm0hiZ2ul3RV47VIygAFnYVftxWDUI4sUx2AVgAzqeVAO6OoW+CnCqYHUdi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/zx+Hrr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/zx+Hrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781710273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqHmGlcVmNayXFxDMXDHlRlK71LPqMZcp2Btpj8sLwE=;
	b=i/zx+HrrvxvZIHzejEZs9PSIeii5xJ35Yuja/bKigDoN9w974Y3eyIV+6zVkkYql9QRRN6
	d8rnxNeQ8XIO1gtB3NIM7LxARR4lypKgMHl4KF6zxrV0rwKDthWCGF/b3oEMfnpFAvn+5U
	lD7Lxs62pqaem5aFD3Y74pA/wEeCQ0c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673--WNwFOAzNkmQV4Xapt6MPw-1; Wed,
 17 Jun 2026 11:31:09 -0400
X-MC-Unique: -WNwFOAzNkmQV4Xapt6MPw-1
X-Mimecast-MFC-AGG-ID: -WNwFOAzNkmQV4Xapt6MPw_1781710267
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73C1C195C25F;
	Wed, 17 Jun 2026 15:31:06 +0000 (UTC)
Received: from fedora (unknown [10.44.33.75])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 829F81688;
	Wed, 17 Jun 2026 15:31:01 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Jun 2026 17:31:06 +0200 (CEST)
Date: Wed, 17 Jun 2026 17:30:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Josh Triplett <josh@joshtriplett.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajK9s-ZFviSxEoia@redhat.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com>
 <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
 <ajKxJM5k9U5L05AF@redhat.com>
 <CAGudoHG4r09syjknUo7rsZV1G01o0OGBvY3X3S8tQ0dfdSYSaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHG4r09syjknUo7rsZV1G01o0OGBvY3X3S8tQ0dfdSYSaQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 06/17, Mateusz Guzik wrote:
>
> > -static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
> > +static void anon_pipe_get_page_prealloc(struct pipe_inode_info *pipe,
> > +                                       struct anon_pipe_prealloc *prealloc,
> >                                         size_t total_len)
> >  {
> >         unsigned int want, i;
> > @@ -144,6 +145,11 @@ static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
> >         want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
> >                      PIPE_PREALLOC_MAX);
> >
> > +       for (i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> > +               if (pipe->tmp_page[i] && !--want)
> > +                       return;
> > +       }

> As proposed this will guarantee a big write which fits fine into pages
> cached into tmp_page followed by a small write will have to resort to
> an allocation under the mutex, partially defeating the original patch.
> So you would need to add some provisions to check if you need to
> allocate something even in that case.

Yes, with the change like this, at least the "total_len <= PAGE_SIZE"
check should be revisited.

But let me repeat: I'm not sure this makes sense, and I have no idea how
it would impact performance in "real" workloads.

In particular, I don't know if the case when another writer steals the
pages from ->tmp_page[] is actually "unlikely".

Oleg.

