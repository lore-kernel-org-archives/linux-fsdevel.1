Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6C3E5A1F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835995; cv=none; b=oIwmuImPOCwbrLF55g0VZe+Ew6kaEO4/BaIK0VA3UPzmiH6R1jyZZc8uL3iqzK6DLTYnMxYwEYsgQiXWrdzw3vVRD4MKs5NpA0VgeYPPTFaPTaB+Niz7BrA8KruhYGyDlgKHlgDRp+pL1QuW3JKPDaox9agaZYjfs4EuWdjPt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835995; c=relaxed/simple;
	bh=pL76gp63eetquYt2cMpYtstQ7Ln83CdCwdqMRZSwOZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcHJa2E/uMisuT2R/6MEJKEV9JpkvohleIJmoiTCdy/7twu2K4M//19gyxw+HCmpbaiXG7nIhvD/Dzj0BRE0K4EX9ob00v65Fhy9XJz/BZBpNulu5snE+g22V0SwpCckfgdOIOsc/Kwr8X9HyckkRcwFtIexUti+/38iv7qj1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MAHDBuau; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MtmB2X6h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qqxEoGcM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qmnYJIrL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MAHDBuau";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MtmB2X6h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qqxEoGcM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qmnYJIrL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E4513FE7;
	Tue,  4 Aug 2026 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785835987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfS5kTPoHbjJQjspRuzWs36NOOVOLy8wFE1xEhOR7qM=;
	b=MAHDBuauP0mUYtVH7RNc3Nz6X2bGGkSF832neu2jB+uD9INP9jilJ5Ttn3MKaxfKGzurW2
	5w6JFgvbixjlV035MSH9qHTOwJA9z5zFx50ZWVbTt1s5DEel/TAyX8gwhJF2mBWpTk2L9j
	87rKeJgpeWdrCnxBK2mTvj9susoICiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785835987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfS5kTPoHbjJQjspRuzWs36NOOVOLy8wFE1xEhOR7qM=;
	b=MtmB2X6hAuWeg24IKp/EfgG1yZDrAcbNT6ynGNay0BNaqOTyiJX2vWPKVDouybzQB/Gcrx
	ssLluf0sNjCZrJBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785835983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfS5kTPoHbjJQjspRuzWs36NOOVOLy8wFE1xEhOR7qM=;
	b=qqxEoGcMpJNYS/Z6XPrJzqkwBgo0mqfReaioqfXdQd4VJisefKXpwzboJm0bwBdifBO8TW
	ezbnGmi3mcbfMXDBvyapSCWUChoOabPhtAWsEYwzwpWtd0A489uaj262j0zJ1U54yngTFv
	ASgYpbUZqud//tIS9Q/cxkz1Tt3S/tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785835983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfS5kTPoHbjJQjspRuzWs36NOOVOLy8wFE1xEhOR7qM=;
	b=qmnYJIrLY1hJb9OcJMaxwgNEWfy76mxB6p8lQMyFuHyycXdChE7Kre3GtWfDoXtAmXwbMv
	tYqh/oBZTG0onvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D4B2779BB;
	Tue,  4 Aug 2026 09:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZJK8Fs+xcWqIGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Aug 2026 09:33:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F21E3A13A6; Tue, 04 Aug 2026 11:32:58 +0200 (CEST)
Date: Tue, 4 Aug 2026 11:32:58 +0200
From: Jan Kara <jack@suse.cz>
To: Zi Yan <ziy@nvidia.com>
Cc: Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <hongbohbli@tencent.com>, 
	Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 07/14] fs/erofs: mm/pagemap: add
 readahead_folio_reverse() to avoid folio->private
Message-ID: <huzyeqj6a57nbcqc23v6f6rdhkob5552fcwy4mlrsagycqi4rz@ggsapkumc2gq>
References: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
 <20260731-remove-pg_private-v1-7-142c97ba3562@nvidia.com>
 <332rknj4vo3cfhvfhhlf6pvg37s3lbrnzbbnv4swa6gctsiu6a@ndotgokvnglc>
 <DKFGTVA0XD01.OZYNYUOU9FTX@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKFGTVA0XD01.OZYNYUOU9FTX@nvidia.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	URIBL_BLOCKED(0.00)[nvidia.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,vivo.com:email,suse.cz:email,tencent.com:email,infradead.org:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLc5chj8mdhigtayhgqted7wkp)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,infradead.org,linux-foundation.org,linux.dev,google.com,suse.com,linux.alibaba.com,arm.com,gourry.net,nvidia.com,cmpxchg.org,tencent.com,kvack.org,vger.kernel.org,gmail.com,vivo.com,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,nvidia.com:email,vivo.com:email,tencent.com:email,imap1.dmz-prg2.suse.org:helo,ozlabs.org:email,kvack.org:email,infradead.org:email,alibaba.com:email]

On Mon 03-08-26 12:56:36, Zi Yan wrote:
> On Mon Aug 3, 2026 at 5:54 AM EDT, Jan Kara wrote:
> > On Fri 31-07-26 22:13:30, Zi Yan wrote:
> >> erofs needs to traverse readahead folios in reverse order to achieve
> >> maximum performance by
> >> 1. reading all folios from readahead_folio();
> >> 2. storing the prior folio pointer in folio->private;
> >> 3. traverse from the last folio to the first one.
> >> 
> >> Add readahead_folio_reverse() to achieve the same function without using
> >> folio->private.
> >> 
> >> It prepares for a future commit that replaces PG_private checks with
> >> !folio->private checks. After switching the checks, erofs's use of
> >> folio->private without bumping folio refcount can cause unexpected
> >> outcomes, e.g., in filemap_release_folio(), try_to_free_buffers() becomes
> >> reachable.
> >> 
> >> No funtional change intended.
> >> 
> >> Assisted-by: Claude:claude-opus-4-8
> >> Assisted-by: Codex:gpt-5
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> To: Gao Xiang <xiang@kernel.org>
> >> To: Chao Yu <chao@kernel.org>
> >> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >> To: Jan Kara <jack@suse.cz>
> >> Cc: Yue Hu <zbestahu@gmail.com>
> >> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> Cc: Sandeep Dhavale <dhavale@google.com>
> >> Cc: Hongbo Li <hongbohbli@tencent.com>
> >> Cc: Chunhai Guo <guochunhai@vivo.com>
> >> Cc: linux-erofs@lists.ozlabs.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-fsdevel@vger.kernel.org
> >> Cc: linux-mm@kvack.org
> >
> > One comment regarding the generic infrastructure below.
> >
> >> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> >> index 4e8b2b29f6d3e..90904a4d173b7 100644
> >> --- a/include/linux/pagemap.h
> >> +++ b/include/linux/pagemap.h
> >> @@ -1549,6 +1549,37 @@ static inline struct folio *readahead_folio(struct readahead_control *ractl)
> >>  	return folio;
> >>  }
> >>  
> >> +/**
> >> + * readahead_folio_reverse - Get the next folio to read, from the tail.
> >> + * @ractl: The current readahead request.
> >> + *
> >> + * Like readahead_folio(), but walks the range back-to-front. The folio is
> >> + * returned locked with its refcount dropped; the caller unlocks it once I/O
> >> + * completes. Compound folios are returned once, at their head index.
> >> + *
> >> + * Context: The folio is locked.
> >> + * Return: A pointer to the next folio, or %NULL when done.
> >> + */
> >> +static inline struct folio *readahead_folio_reverse(struct readahead_control *ractl)
> >> +{
> >> +	struct folio *folio;
> >> +
> >> +	if (!ractl->_nr_pages)
> >> +		return NULL;
> >> +
> >> +	/* xa_load() follows sibling entries, so a tail index returns the head */
> >> +	folio = xa_load(&ractl->mapping->i_pages,
> >> +			ractl->_index + ractl->_nr_pages - 1);
> >> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> >> +
> >> +	/* Shrink the window from the tail down to this folio's head index */
> >> +	ractl->_nr_pages = folio->index - ractl->_index;
> >> +	ractl->_batch_count = 0;
> >
> > Thanks for the patch! Currently there's the invariant that the returned
> > folio is still inside the _index .. _index+_nr_pages range. I think when we
> > are providing a generic helper, we should keep that to make code more
> > robust for the future when more people start using it.
> 
> Definitely.
> 
> >
> > What I'd suggest doing is add bool in struct readahead_control telling
> > whether the last folio (batch) was taken from the head or tail of the
> > range, advance _nr_pages and _index accordingly in the functions returning
> > folios (probably hide this in a helper function __readahead_advance()
> > because it will be used in 3 places) and maybe call this new function
> > readahead_folio_last() instead of _reverse() (but I have only a slight
> > preference here so .._reverse() is ok with me if other people prefer it).
> 
> The below is what I come up with. I did not add a bool to
> readahead_control, since I think that is the decision of caller of
> __readahead_advance(). But let me know if you disagree.

The reason why I wanted bool in readahead_control is that if some code
ends up mixing readahead_folio() with readahead_folio_last() things will
get confused (because __readahead_advance() really wants to skip the batch
returned from the *previous* call to readahead_folio[_last]()). With the
bool in rac, even mixed use will properly advance the state of the
readahead_control. I don't think mixed use is very realistic (at this
point at least) so I'm ok with leaving that for later if you don't like it.

Also I have some minor comments below.

> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b59f2745a8e72..23f423c22ac8c 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1908,8 +1908,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
>  	z_erofs_pcluster_readmore(&f, rac, true);
>  
> -	/* traverse in reverse order for best metadata I/O performance */
> -	while ((folio = readahead_folio_reverse(rac))) {
> +	/* traverse from last to first for best metadata I/O performance */
> +	while ((folio = readahead_folio_last(rac))) {
>  		err = z_erofs_scan_folio(&f, folio, true);
>  		if (err && err != -EINTR)
>  			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 5ca5aa365f319..2cc3de5594518 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1510,13 +1510,21 @@ void page_cache_async_readahead(struct address_space *mapping,
>  	page_cache_async_ra(&ractl, folio, req_count);
>  }
>  
> +static inline void __readahead_advance(struct readahead_control *rac,
> +		bool read_from_head)
> +{
> +	if (read_from_head)
> +		rac->_index += rac->_batch_count;
> +
> +	rac->_nr_pages -= rac->_batch_count;
> +}

Maybe we can add:

	rac->_batch_count = 0;

as well since after the advance the _batch_count isn't valid anymore? We
can then also remove it from the callers.

> +
>  static inline struct folio *__readahead_folio(struct readahead_control *ractl)
>  {
> -	struct folio *folio;
> +	struct folio *folio = NULL;

Not sure why this initialization got here...

>  
>  	BUG_ON(ractl->_batch_count > ractl->_nr_pages);
> -	ractl->_nr_pages -= ractl->_batch_count;
> -	ractl->_index += ractl->_batch_count;
> +	__readahead_advance(ractl, /* read_from_head= */ true);
				   ^^^^
This is not really a kernel style :), please delete this comment. I'm ok with
pure false/true here - it is an internal helper used in few places. If
things get wider use, we tend to switch to 'unsigned flags' with explicit
flag names to ease code reading. But that's not the case here.

> @@ -1548,7 +1556,7 @@ static inline struct folio *readahead_folio(struct readahead_control *ractl)
>  }
>  
>  /**
> - * readahead_folio_reverse - Get the next folio to read, from the tail.
> + * readahead_folio_last - Get the next folio to read, from the tail.
>   * @ractl: The current readahead request.
>   *
>   * Like readahead_folio(), but walks the range back-to-front. The folio is
> @@ -1558,21 +1566,24 @@ static inline struct folio *readahead_folio(struct readahead_control *ractl)
>   * Context: The folio is locked.
>   * Return: A pointer to the next folio, or %NULL when done.
>   */
> -static inline struct folio *readahead_folio_reverse(struct readahead_control *ractl)
> +static inline struct folio *readahead_folio_last(struct readahead_control *ractl)
>  {
>  	struct folio *folio;
>  
> -	if (!ractl->_nr_pages)
> +	/* Shrink the window from the tail down to this folio's head index */
> +	__readahead_advance(ractl, /* read_from_head= */ false);
> +
> +	if (!ractl->_nr_pages) {
> +		ractl->_batch_count = 0;
>  		return NULL;
> +	}
>  
>  	/* xa_load() follows sibling entries, so a tail index returns the head */
>  	folio = xa_load(&ractl->mapping->i_pages,
>  			ractl->_index + ractl->_nr_pages - 1);
>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>  
> -	/* Shrink the window from the tail down to this folio's head index */
> -	ractl->_nr_pages = folio->index - ractl->_index;
> -	ractl->_batch_count = 0;
> +	ractl->_batch_count = folio_nr_pages(folio);
>  
>  	folio_put(folio);
>  	return folio;
> @@ -1583,11 +1594,10 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
>  {
>  	unsigned int i = 0;
>  	XA_STATE(xas, &rac->mapping->i_pages, 0);
> -	struct folio *folio;
> +	struct folio *folio = NULL;

Again not sure why this initialization got here...

>  	BUG_ON(rac->_batch_count > rac->_nr_pages);
> -	rac->_nr_pages -= rac->_batch_count;
> -	rac->_index += rac->_batch_count;
> +	__readahead_advance(rac, /* read_from_head= */ true);
>  	rac->_batch_count = 0;
>  
>  	xas_set(&xas, rac->_index);
> 
> 
> 
> 
> -- 
> Best Regards,
> Yan, Zi
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
