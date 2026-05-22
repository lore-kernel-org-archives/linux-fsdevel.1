Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDF356775;
	Fri, 22 May 2026 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472531; cv=none; b=os7HVeGDVwsEMz4qckUAxn9R6I0Jm95RTIzJ5xCmIgiKirEJuJq2dkWipIr8pR+hq1P+wAytcIN0SgXLsslsIubnRH76TLtRfwAF5uZn7VGnMcrOtRKal1MDn5FfYbDIORU1WvemTRdfPzqAS0VTjDIgy8BAGep0O5HEdlBxtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472531; c=relaxed/simple;
	bh=FbGlXdsHLt/17ZuhYpJxIcwjQOXhPiZ+BXktx4vTI58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1lSSbws9iIDM/qg/2mWmap/8LAnE8Wms4adJ1RVoOwZKD5+cNsK6O9kOh15c7kTbBtzJLQV1axIEUdneQS5Z+9BmYnjGJf12opNkPmAEKnkRue0KitxBm+xwUcqvsVOh3wulPDDnCEPmBKrRTHyAUBUnrZ+AjoMIlf+4hUaBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vMY4mfIH; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vMY4mfIH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R4TDQynBhD9geROEnW7skk79FDDsBfSrq/gB2Hv8zSM=; b=vMY4mfIHxeZzT+V/BWCqC1mpsM
	gfr1ORDBytlvoJOejNL0+bZ2dxODJQIjDySWo/9/MIRwirPWuLI25sLr/IAUB9T/W9zloML6oC+cN
	dODY72dCHy6gm49xc43WhBvCyVNGz2+9IAXbLKWK8d2JTyOxz1Cb78GdDUQtTYm4g5QFjqdQohZ5h
	Jm4B/MriVs93R+4zYA/luZxw5Mo9mhYpCINbHvTF5gQLljN1K+M0u8NkUUHdIejbkW+onZmdj+CPX
	WTbwIdAngO3Wc0OCOJTsX3nZViRETucuWygchPnlJB8Z4tBgDzMVEXVXYYNZJp+L9ekBIIbvqzBZa
	RwrFqu5Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQU5i-004q32-00;
	Fri, 22 May 2026 17:55:22 +0000
Date: Fri, 22 May 2026 10:55:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, oleg@redhat.com, axboe@kernel.dk, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] fs/pipe: pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Message-ID: <ahCX3oPphW9QGySQ@gmail.com>
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
 <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
 <024fd2e28a2b9bce470178b8c510ed014b9bb039.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024fd2e28a2b9bce470178b8c510ed014b9bb039.camel@kernel.org>
X-Debian-User: leitao

On Fri, May 22, 2026 at 12:51:40PM -0400, Jeff Layton wrote:
> On Fri, 2026-05-22 at 09:44 -0700, Breno Leitao wrote:
> > +/*
> > + * Pre-allocate pages outside pipe->mutex for multi-page writes.
> > + * alloc_page() with GFP_HIGHUSER can sleep in reclaim and runs memcg
> > + * charging; doing it under the mutex stalls a concurrent reader.
> > + *
> > + * Loop alloc_page() instead of alloc_pages_bulk_*(): the bulk path refuses
> > + * __GFP_ACCOUNT under memcg (see commit 8dcb3060d81d "memcg: page_alloc:
> > + * skip bulk allocator for __GFP_ACCOUNT") and silently degrades to a single
> > + * page. A per-page loop keeps memcg accounting and the task NUMA mempolicy
> > + * honoured for every page; the per-call overhead is small compared to the
> > + * pipe->mutex hold-time being shrunk. Any shortfall is covered by the
> > + * in-lock alloc_page() fallback in anon_pipe_get_page().
> > + */
> > +static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
> > +					size_t total_len)
> > +{
> > +	unsigned int want, i;
> > +	struct page *page;
> > +
> > +	prealloc->count = 0;
> > +	if (total_len <= PAGE_SIZE)
> > +		return;
> > +
> > +	want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
> > +		     PIPE_PREALLOC_MAX);
> > +
> > +	for (i = 0; i < want; i++) {
> > +		page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
> > +		if (!page)
> > +			break;
> > +		prealloc->pages[prealloc->count++] = page;
> > +	}
> 
> I believe alloc_pages_bulk() is supposed to be more efficient when
> allocating several pages at once like this.

Thanks Jeff. I understand bulk allocators refuses __GFP_ACCOUNT under memcg.
(That is the reason I've CCed Shakeel in this patchset).

Anyway, reading the code it shows me:

  unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
                          nodemask_t *nodemask, int nr_pages,
                          struct page **page_array)
  {

	...
        /* Bulk allocator does not support memcg accounting. */
        if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT))
                goto failed;


Thanks for the review,
--breno
