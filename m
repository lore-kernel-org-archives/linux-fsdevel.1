Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB222FFFB5
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686376; cv=none; b=OPi9IIQNY3Y+xLCqes7anmGytpVjw/I4BBikcNQwXsFZ7YdfWvGSJ35hU3Jo/AiMKXIiMFER8RXeaIS+Gmx8ijELLp51MLqqkWu5yjaEBVBFiDpRIfsN8XtoXJOWa0S+M36HlYyFHExVG8MT9iW6qvG7yzR3o89QmWo59V93EA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686376; c=relaxed/simple;
	bh=2fN8/T+cfqifizgv0Zy/OFN+fYVdQCBq8wVfmK8kEwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPLB7kQemX3XBCF8jwt1R4TmxR+FtkYoNd6zUQ1pLOZYCdxVu8Gy3YfhItzgx9/KtDHp6zqxWThV3AdmDsqKoOqkslLSU0AOo+SsBPjy9H93pteyAI912FCNmw+RKPMAhxHr//KxHGNzt+TunJvGtUJf/lFx3MfwsrqzuanYFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnLJG9i4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnLJG9i4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781686373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fN8/T+cfqifizgv0Zy/OFN+fYVdQCBq8wVfmK8kEwo=;
	b=bnLJG9i47AXSBx4v5CRKbHunkon6PKEqsqiN+SA6UM423oxGgsU/4KtT0AoOiSCeVW1ym5
	clzjxGJuYIPR8b8uB9nMmWJa9sP2TWHd+QMcptjaKv228iT6aLl4fdLjdP0WZaAjPPn807
	XX8u0HT5PbHtXfsZlC17B+pBRgfaeNw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-aYefdb43OuKhaVR0c9iWJw-1; Wed,
 17 Jun 2026 04:52:50 -0400
X-MC-Unique: aYefdb43OuKhaVR0c9iWJw-1
X-Mimecast-MFC-AGG-ID: aYefdb43OuKhaVR0c9iWJw_1781686368
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50FDC1800EF3;
	Wed, 17 Jun 2026 08:52:47 +0000 (UTC)
Received: from fedora (unknown [10.44.33.75])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C91D13008DC3;
	Wed, 17 Jun 2026 08:52:41 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Jun 2026 10:52:46 +0200 (CEST)
Date: Wed, 17 Jun 2026 10:52:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Breno Leitao <leitao@debian.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev,
	jlayton@kernel.org, axboe@kernel.dk, kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajJgWBCFYwz9OIo3@redhat.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajG2bmhu6j9UWvh4@localhost>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/16, Josh Triplett wrote:
>
> On Sun, May 24, 2026 at 07:44:57AM -0700, Breno Leitao wrote:
> > This series pre-allocates pages outside pipe->mutex in
> > anon_pipe_write(): for writes that span more than one full page, up
> > to PIPE_PREALLOC_MAX (8) pages are allocated via a per-page
> > alloc_page() loop before the mutex is taken. anon_pipe_get_page()
> > then drains the prealloc array first, falls back to the per-pipe
> > tmp_page[] cache, and only enters the allocator under the mutex for
> > the leftover pages (writes larger than PIPE_PREALLOC_MAX, single-page
> > writes that skip prealloc, or shortfalls when the prealloc loop
> > fails). Leftover prealloc pages are recycled into tmp_page[] before
> > unlock and any remainder is put_page()'d after unlock, keeping the
> > allocator out of the critical section on both sides.
> [...]
> > I also vibe-coded a microbenchmark to validate the change. It sweeps
> > writers x readers over {1,2,5} x {1,5,10} with 64KB writes against a
> > 1 MB pipe and prints throughput + latency percentiles per config.
>
> How do the numbers compare with 1-byte writes/reads? (It's fine if
> they're not *faster*, just want to make sure they don't get any
> *worse*. This case comes up a lot with pipes used for synchronization or
> event reporting, such as with make.)

Note the "for writes that span more than one full page" above. Pre-allocate
does nothing if total_len <= PAGE_SIZE.

Oleg.

