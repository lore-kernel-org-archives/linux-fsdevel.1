Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21537756B
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750891; cv=none; b=BiZTEvrqQdtcYAnTa+kOTZrF8braUGYHL8EhDekYSETK8UVjXGUTqBLNgAT60IjNiPoyoXXpeDnwKhIYICZZUUBxjhyRf1unwjXH5SjKakPmmJPmqeUuIaBg6xLF7mO2VlmQLo71GM2UfUc1MtA3kLz/EWJuUOBzfAILPge73n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750891; c=relaxed/simple;
	bh=cI6Gb3KYhrpuYRQyR4sEjZjWagLIHM1p6bY62PkLZW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n293N8Z1rv3UK4nwtlxGVuaf7aGgEBGKQYHYkz6B4JXVDE85Qly7U1+hnzZ09IAe6XpBTfQ/wJI45bujUbgmWTTm5CzSS+fRzlZ7MJCoqW7UCBZW3rOkTr/HKiuJKK69wD99mx4iQHimkVvO6c4XYOUaQM6X7G6D/b2hdiqhgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fHiUgDc/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lqn1zzlt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pDooKbr/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CLT1mS7S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fHiUgDc/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lqn1zzlt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pDooKbr/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CLT1mS7S"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B5F77EFF8;
	Mon,  3 Aug 2026 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785750881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iROqidNnIXSZtIIk8nl3VK4dOUo3dfGu6PFD6UoFhbw=;
	b=fHiUgDc/gBWZNPYTfUL+/RKtJMvY4YDCOJBMBuxQzU5xto7ubw4eaPSQkzSlU46dks7UBX
	ruxnjVfs10OfQlbHXoApIdA1V9BstCp9eGS8uYEWOZo6w+PuO0/uuVZs4UhrgGet0VOHQS
	ALWCsVaUyzTGnAoYHqbDwYDkvPKvxQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785750881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iROqidNnIXSZtIIk8nl3VK4dOUo3dfGu6PFD6UoFhbw=;
	b=Lqn1zzltP7SCM9HQ6qrUpcN9jfu8MXAXViLUoliKx+AzkXpws+spjIvH4se097r8DHkyEP
	Kfu4eglMl+CVnBCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785750877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iROqidNnIXSZtIIk8nl3VK4dOUo3dfGu6PFD6UoFhbw=;
	b=pDooKbr/7Sc7/HRKzOzWRfK+N7685sWi2sBn2+fcCVca6XP+3RJ0SzE+9VqVH3VR9aO+Ub
	RmCm+VpxU6OwY8SqzrioAod+X5fHjMen/sbX/cAD9QfOdkGUoTmtjhfVH57TYfX1Ue9JPa
	elh4I9oIIZ0Mjc4RhC+lll0YdIppR/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785750877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iROqidNnIXSZtIIk8nl3VK4dOUo3dfGu6PFD6UoFhbw=;
	b=CLT1mS7SoLb60oRjTZ+JbcfZfJ79SMp450+duotun2UxsMTeGEme3vUvdiIRHgqn4qsUvq
	zAmEZumhqT1xMcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FE4A779A1;
	Mon,  3 Aug 2026 09:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1MAWI11lcGoWNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Aug 2026 09:54:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C4BFA13A4; Mon, 03 Aug 2026 11:54:33 +0200 (CEST)
Date: Mon, 3 Aug 2026 11:54:33 +0200
From: Jan Kara <jack@suse.cz>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>, 
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
	Jan Kara <jack@suse.cz>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <hongbohbli@tencent.com>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 07/14] fs/erofs: mm/pagemap: add
 readahead_folio_reverse() to avoid folio->private
Message-ID: <332rknj4vo3cfhvfhhlf6pvg37s3lbrnzbbnv4swa6gctsiu6a@ndotgokvnglc>
References: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
 <20260731-remove-pg_private-v1-7-142c97ba3562@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-remove-pg_private-v1-7-142c97ba3562@nvidia.com>
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
	URIBL_BLOCKED(0.00)[vivo.com:email,infradead.org:email,suse.cz:email,alibaba.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLc5chj8mdhigtayhgqted7wkp)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,linux-foundation.org,linux.dev,google.com,suse.com,linux.alibaba.com,arm.com,gourry.net,nvidia.com,cmpxchg.org,tencent.com,kvack.org,vger.kernel.org,suse.cz,gmail.com,vivo.com,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tencent.com:email,alibaba.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email]

On Fri 31-07-26 22:13:30, Zi Yan wrote:
> erofs needs to traverse readahead folios in reverse order to achieve
> maximum performance by
> 1. reading all folios from readahead_folio();
> 2. storing the prior folio pointer in folio->private;
> 3. traverse from the last folio to the first one.
> 
> Add readahead_folio_reverse() to achieve the same function without using
> folio->private.
> 
> It prepares for a future commit that replaces PG_private checks with
> !folio->private checks. After switching the checks, erofs's use of
> folio->private without bumping folio refcount can cause unexpected
> outcomes, e.g., in filemap_release_folio(), try_to_free_buffers() becomes
> reachable.
> 
> No funtional change intended.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Gao Xiang <xiang@kernel.org>
> To: Chao Yu <chao@kernel.org>
> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> To: Jan Kara <jack@suse.cz>
> Cc: Yue Hu <zbestahu@gmail.com>
> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Hongbo Li <hongbohbli@tencent.com>
> Cc: Chunhai Guo <guochunhai@vivo.com>
> Cc: linux-erofs@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org

One comment regarding the generic infrastructure below.

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 4e8b2b29f6d3e..90904a4d173b7 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1549,6 +1549,37 @@ static inline struct folio *readahead_folio(struct readahead_control *ractl)
>  	return folio;
>  }
>  
> +/**
> + * readahead_folio_reverse - Get the next folio to read, from the tail.
> + * @ractl: The current readahead request.
> + *
> + * Like readahead_folio(), but walks the range back-to-front. The folio is
> + * returned locked with its refcount dropped; the caller unlocks it once I/O
> + * completes. Compound folios are returned once, at their head index.
> + *
> + * Context: The folio is locked.
> + * Return: A pointer to the next folio, or %NULL when done.
> + */
> +static inline struct folio *readahead_folio_reverse(struct readahead_control *ractl)
> +{
> +	struct folio *folio;
> +
> +	if (!ractl->_nr_pages)
> +		return NULL;
> +
> +	/* xa_load() follows sibling entries, so a tail index returns the head */
> +	folio = xa_load(&ractl->mapping->i_pages,
> +			ractl->_index + ractl->_nr_pages - 1);
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +
> +	/* Shrink the window from the tail down to this folio's head index */
> +	ractl->_nr_pages = folio->index - ractl->_index;
> +	ractl->_batch_count = 0;

Thanks for the patch! Currently there's the invariant that the returned
folio is still inside the _index .. _index+_nr_pages range. I think when we
are providing a generic helper, we should keep that to make code more
robust for the future when more people start using it.

What I'd suggest doing is add bool in struct readahead_control telling
whether the last folio (batch) was taken from the head or tail of the
range, advance _nr_pages and _index accordingly in the functions returning
folios (probably hide this in a helper function __readahead_advance()
because it will be used in 3 places) and maybe call this new function
readahead_folio_last() instead of _reverse() (but I have only a slight
preference here so .._reverse() is ok with me if other people prefer it).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
