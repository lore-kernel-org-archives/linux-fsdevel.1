Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5C463B6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619429; cv=none; b=HafOvV6k41AKcF1N0rhkDVYZpItzZQCkX/H3BmbIZONiXXTtgNn5DpbnUebSDomkdFj9k+YlYKAi7xb5hpoDIL6m900x+gC8zdM0VomtIvzTk/7U3A2txYbzJt9gfyoS6bEIbzLFFNxoQPXzAw43XA5Uo9l542GyloQd1Yc8UR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619429; c=relaxed/simple;
	bh=K3ySl1JYu4evmfjWLYM3ICHdjjxJG1td9e+ep2ThaI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9uLYJNC5jq7Gd0o7u4sUZogf3qSHmPIwsFUzYEyTMO1ZFa93MJQ/rVsd6g3dRyB6xUlj7qGK/fIOjVJdMgRoss+CRLHfo4U6MSdvRRJbmUOzNCtzC4OI/F5tDtgUiH0o9XjqcOSRGdTBKVqf09FOwLbmTwoUrk6jungvCvU6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A/Q04QC6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z+nSFKCb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pOKY66lt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=poqy2DMY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A/Q04QC6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z+nSFKCb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pOKY66lt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="poqy2DMY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AA363E62;
	Thu, 13 Aug 2026 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgl9jHe0ZGbfMuJ3FN/ReGeH6xmJZZNK66A/fkMJmts=;
	b=A/Q04QC6/4Sqpc8DhTPBNqln1rI0fV+o6xu3pY39oKZQ/BqbJQnmbhFTKNYRZ3rrh1wZ/D
	mARXB+zLnRADM8Z7yvmbvlJqzSFMWzz+d56J8Q+zA9G09nNzb1N3ZNzW2VZkFPaAPvUqpK
	CeIs/vMaYvjXvUCJ1fRwfQoadXHhXnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgl9jHe0ZGbfMuJ3FN/ReGeH6xmJZZNK66A/fkMJmts=;
	b=z+nSFKCbiZVjYphWTnMzCKRBWMZfg54LrgK0g+EnPU7Aev6qGqVRwAAg9izgr0OEVSBubN
	q3gGF90fPci0T9CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pOKY66lt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=poqy2DMY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786619413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgl9jHe0ZGbfMuJ3FN/ReGeH6xmJZZNK66A/fkMJmts=;
	b=pOKY66ltwNa8NX4f/trwpTqkPwdj/VysdaQNCkuIV1Gutt38Oe5Zc9Aehmm2LdQZVrq/pg
	oLzH8BDe2yBA02fHGihrFw2a98ZUDgHdgmb9GQvwwJ8MXAMKzF3qcCP2Tk+CjcicklnKzq
	3NQz1eNlY3e2LFzpWE+7mijnkI4zWaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786619413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgl9jHe0ZGbfMuJ3FN/ReGeH6xmJZZNK66A/fkMJmts=;
	b=poqy2DMYGfUSGvCindxYJBLwzIma5ewXbma6SgkYVuzYO4cBOb5jPJAbU/WSzUJWQAPOhf
	UEcSHGGWGq4/W4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6676B77DAE;
	Thu, 13 Aug 2026 11:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9RiRFRSmfWozBwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 13 Aug 2026 11:10:12 +0000
Date: Thu, 13 Aug 2026 12:10:10 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v9 14/15] filemap: Add support for authoritative mappings
Message-ID: <an2l7MPFFcXH_By5@pedro-suse.lan>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-15-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805210557.1118966-15-willy@infradead.org>
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4AA363E62
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,kvack.org,linux.dev,suse.de,kernel.org,huawei.com,gmail.com,suse.cz,vger.kernel.org,brauner.io,google.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,infradead.org:email,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed, Aug 05, 2026 at 10:05:54PM +0100, Matthew Wilcox (Oracle) wrote:
> An authoritative mapping knows about all the folios in the mapping.
> If read() finds a missing folio, there's no reason to allocate one and
> try to read it because we know it's a zero region of the file.  We can
> just call iov_iter_zero() instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> ---
>  include/linux/pagemap.h | 11 +++++++++++
>  mm/filemap.c            | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 968b791cfd14..22d48935ffda 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>  	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>  				   account usage to user cgroups */
> +	AS_AUTHORITATIVE = 11,	/* If we miss in the page cache, it's a hole */
>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> @@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
>  	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>  
> +static inline void mapping_set_authoritative(struct address_space *mapping)
> +{
> +	set_bit(AS_AUTHORITATIVE, &mapping->flags);
> +}
> +
> +static inline bool mapping_is_authoritative(const struct address_space *mapping)
> +{
> +	return test_bit(AS_AUTHORITATIVE, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>  {
>  	return mapping->gfp_mask;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 26a5f18121f9..5a8cc20e624e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2697,6 +2697,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	if (!folio_batch_count(fbatch)) {
>  		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
>  
> +		if (mapping_is_authoritative(mapping))
> +			return 0;
>  		if (iocb->ki_flags & IOCB_NOIO)
>  			return -EAGAIN;
>  		if (iocb->ki_flags & IOCB_NOWAIT)
> @@ -2853,6 +2855,22 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  			goto put_folios;
>  		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
>  
> +		if (!folio_batch_count(&fbatch)) {
> +			size_t fsize = mapping_min_folio_nrbytes(mapping);
> +			size_t offset = iocb->ki_pos & (fsize - 1);
> +			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
> +					     fsize - offset);
> +			size_t copied = iov_iter_zero(bytes, iter);
> +
> +			already_read += copied;
> +			iocb->ki_pos += copied;
> +			last_pos = iocb->ki_pos;
> +
> +			if (copied < bytes)
> +				error = -EFAULT;
> +			continue;
> +		}
> +

I was wondering whether this could interact weirdly with EOF, but it doesn't
seem so.

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
