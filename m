Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27BD41834A
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618567; cv=none; b=fBkcrfssQ5dlNHgQbIImfoHxPKFDaGrhVXGLNCDJC+sauUZbK0BHgCapAHeEhYwUW+AgD3MpiPrYNJU6YQ0zHGY8K4QgTOnqtRFrtcYd8R14vtoJwTsxydkkC6Zgu8vtW9Z7hgpq9opDlbU6Ofrib7x22yiScbaZQThiZen308Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618567; c=relaxed/simple;
	bh=raENc2+9Js4fl2BOX8+TDuOKEMH4GJ69Gi+AI1bSu8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNrzgthkviGh6WFVgCTATTiCZqgjB5JKqWP+YumhP23SI/IoprvqUXrk9pYaa2Tc+fum54JmBukUhn+wV9fn8BPf5ecnGptV2DLggtrz6D7heMdKitcR2rLK0D8Zk4lQcN3AdrZyr+aUXwaxf1FY0eLF1LP1Cw4P6h9D/Vqk4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZoiC5Odd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bb5BgboJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wRcuQgd1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8sRnAnOq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZoiC5Odd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bb5BgboJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wRcuQgd1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8sRnAnOq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A0F282825;
	Thu, 13 Aug 2026 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786618551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hbLhs+/j3Cz0sDWAJRAQZic3afitzbliqORlRQmHF4=;
	b=ZoiC5Odd6uCHh37vb9iQfJIMmkOoSfljVMyUPJ+JMoJcxIeJG8/upf+XNBXOsnO0zDNDBw
	am++F6RTK91PqaiYVT2R+R3zCV3YuOtCGl4jcq0SiUhamJSAgnk3wOh5ehj9wLt1PDNKa4
	+ux3+ytacGPc3v2TtBrgcNPRrVa3vQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786618551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hbLhs+/j3Cz0sDWAJRAQZic3afitzbliqORlRQmHF4=;
	b=bb5BgboJTcGchzO50OJCkEMW/uNbHO1/t/Vp0I6iT/FdE8mMsM0xEe38gB1aHa9fRJA9bU
	QZ/B0eZMOmRGmYCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wRcuQgd1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8sRnAnOq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786618547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hbLhs+/j3Cz0sDWAJRAQZic3afitzbliqORlRQmHF4=;
	b=wRcuQgd1JhDxD0pV4DVCzCVf0xL7o/LQr6qsWamUVfNKLrxtAuTDtuM40ENCE2DTeKFKAW
	MZdtXyJZ/H7MXfCgKOQpZR+j/9gWmYDsRYH1RA9SfZdhYVYXzDgOiuDGQ7r2B/CJ9hnZWA
	jxs3MwzXHoGjeHAHhRxAgRlfLv0yefY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786618547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hbLhs+/j3Cz0sDWAJRAQZic3afitzbliqORlRQmHF4=;
	b=8sRnAnOqPXfT26gjWEZjhzAg7Wb5bD8Hrk2tGG5CdkFWGFKIvtuhI0kxrd6u9hyYaRCaki
	iQNpKeBrR+FTrgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70EED77DA3;
	Thu, 13 Aug 2026 10:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AMFIGLKifWoNeAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 13 Aug 2026 10:55:46 +0000
Date: Thu, 13 Aug 2026 11:55:44 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v9 11/15] filemap: Add hwpoison handling to filemap_read()
Message-ID: <an2e1j3C_4DA5KXK@pedro-suse.lan>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-12-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805210557.1118966-12-willy@infradead.org>
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5A0F282825
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,kvack.org,linux.dev,suse.de,kernel.org,huawei.com,gmail.com,suse.cz,vger.kernel.org,brauner.io,google.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,infradead.org:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed, Aug 05, 2026 at 10:05:51PM +0100, Matthew Wilcox (Oracle) wrote:
> From: Jane Chu <jane.chu@oracle.com>
> 
> Add hwpoison handling to filemap_read() such that .read_iter() could
> make best effort copying data out of clean pages without risking
> MCE in case page cache contains HWpoison.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Co-developed-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/linux/hugetlb.h    |  2 --
>  include/linux/page-flags.h | 11 +++++++++++
>  mm/filemap.c               | 33 +++++++++++++++++++++++++++++++--
>  3 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ec604cee8d22..639c0a772856 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1088,8 +1088,6 @@ void hugetlb_register_node(struct node *node);
>  void hugetlb_unregister_node(struct node *node);
>  #endif
>  
> -bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page);
> -
>  static inline unsigned long huge_page_mask_align(struct file *file)
>  {
>  	return PAGE_MASK & ~huge_page_mask(hstate_file(file));
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5d01e5b28d0f..f75d66c42509 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1095,6 +1095,7 @@ static inline bool PageHuge(const struct page *page)
>  	return folio_test_hugetlb(page_folio(page));
>  }
>  
> +bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page);
>  bool hugetlb_unref_page_hwpoison(const struct page *page);
>  
>  /*
> @@ -1116,6 +1117,16 @@ static inline bool is_page_hwpoison(const struct page *page)
>  	return PageHWPoison(page);
>  }
>  
> +static inline bool is_ref_page_hwpoison(const struct folio *folio,
> +		const struct page *page)
> +{
> +	if (PageHWPoison(page))
> +		return true;
> +	if (folio_test_hugetlb(folio))
> +		return hugetlb_page_hwpoison(folio, page);
> +	return false;
> +}
> +
>  static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
>  {
>  	return PageHWPoison(&folio->page) ||
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 58eb9d240643..26a5f18121f9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2483,6 +2483,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
>  
>  		if (!folio_batch_add(fbatch, folio))
>  			break;
> +		if (folio_has_hwpoisoned_page(folio))
> +			break;
>  		if (!folio_test_uptodate(folio))
>  			break;
>  		if (folio_test_readahead(folio))
> @@ -2749,6 +2751,29 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
>  	return (pos1 >> shift == pos2 >> shift);
>  }
>  
> +static size_t adjust_range_hwpoison(const struct folio *folio, size_t offset,
> +		size_t bytes)
> +{
> +	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
> +	size_t safe_bytes;
						    offset >> PAGE_SHIFT would probably be more idiomatic
> +
> +	if (!folio_has_hwpoisoned_page(folio))
> +		return bytes;
> +	if (is_ref_page_hwpoison(folio, page))
> +		return 0;
> +
> +	/* Safe to read the remaining bytes in this page. */
> +	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
			similarly, offset_in_page(offset)

(yes, no codegen difference in both cases, but there could be a difference
if the ARM dynamic page size stuff ever moves forward)

> +	page++;
> +
> +	/* Check each remaining page as long as we are not done yet. */
> +	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
> +		if (is_ref_page_hwpoison(folio, page))
> +			break;
> +
> +	return min(safe_bytes, bytes);
> +}

Wouldn't this whole logic fit better in copy_folio_to_iter? shmem for
instance also handrolls its own hwpoison read_iter logic with
per-page-copies, etc; not amazing.

> +
>  static void filemap_end_dropbehind_read(struct folio *folio)
>  {
>  	if (!folio_test_dropbehind(folio))
> @@ -2862,14 +2887,18 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  			if (writably_mapped)
>  				flush_dcache_folio(folio);
>  
> -			copied = copy_folio_to_iter(folio, offset, bytes, iter);
> +			copied = adjust_range_hwpoison(folio, offset, bytes);
> +			if (copied < bytes)
> +				error = -EIO;

I don't love reusing copied here, but I guess there isn't much better
(in order to detect hwpoison-derived truncation)

> +			copied = copy_folio_to_iter(folio, offset, copied, iter);
>  
>  			already_read += copied;
>  			iocb->ki_pos += copied;
>  			last_pos = iocb->ki_pos;
>  
>  			if (copied < bytes) {
> -				error = -EFAULT;
> +				if (!error)
> +					error = -EFAULT;

Logic looks good though.

-- 
Pedro
