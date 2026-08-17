Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF4439F89;
	Mon, 17 Aug 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985320; cv=none; b=MFBBdesSzGYo5RrhFjzQI9H0PUo/1SB1Lvk2Mtfo+3R2Di8OnbJzDKFKlXPN4QTv5UFDI+dGh/w8uu7lGWTPeybQo0nTGuTdF+Kmf1z05CIQKy8qoqACrojC3jbqldR7g2F4Zy7Mcd50gAOiP2utB6mzo3PY/hCLWdH9dsgiuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985320; c=relaxed/simple;
	bh=GZkohxpiTondKOXydUIjDw/BMv4TECtdXXUHQYxiVMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc5m8EBjR2vUv2s3hgQfSnOEIV+Oeiyh0glhdPLUoorFpUdxxZQPKnRFXYB3LGzFrK7OE/d0MFqJSGHeCnUSF5u/KxisSRfk1B+9oNZbfcDhYWDWPb3J8jOVbCbQ6ijLUkrlCsO+B1ll+qfJink5yHtYvHX0ojEvzYofCDgQmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eh4wirmh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x/a5xipD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0OOXJSPA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RT94AgWl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eh4wirmh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x/a5xipD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0OOXJSPA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RT94AgWl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03366840BC;
	Mon, 17 Aug 2026 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786985313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3zLzmZPTjsyeCNJxTMPQyOwGFcxlb4bymJngOb4M0I=;
	b=Eh4wirmhcatW88qg37SQqCKT4u6kSfztchn54o9nW/VyKqNgizumXLKO+CRy+7MidtwIWW
	iMtl+3/EeWgvvGAY974PBfD+rNUfIsWW5rSf89ITMqSgrvtCm3dYGw6MBdNaMqvVlxtVAz
	xEKaIO823UqlNHyQSwojB7qs+ixG408=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786985313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3zLzmZPTjsyeCNJxTMPQyOwGFcxlb4bymJngOb4M0I=;
	b=x/a5xipDgyFLGvK6XE/nRtUc6MTEfeJ1/+o4af+1OqxzVZmDb8ZQ8DwU9uAjSjq7x4afuC
	ihcWoR0RulW0bRBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786985309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3zLzmZPTjsyeCNJxTMPQyOwGFcxlb4bymJngOb4M0I=;
	b=0OOXJSPABxSA44ExlLIczk02MA3Z2jPvtNH8h14C6N+eyYK9PKpDg4moQg+kI5qp5iuv8K
	plU9ims/KnCKnsjizeg3dSdGtAuLcgzB9qBVuwgNItwLnaE+wmTu+8eO7ffBf9QqiZ64VG
	VYXQFK/6uFSDVrj25rF6p03NAbmAZPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786985309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3zLzmZPTjsyeCNJxTMPQyOwGFcxlb4bymJngOb4M0I=;
	b=RT94AgWlmYM9MlGg6BqMycisJT2UJTpR5HSuvHhxMNdPB4qGhLwSRoaR1kHpU2aRjkTf9q
	UYTsjD68+tbEmEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E181C79577;
	Mon, 17 Aug 2026 16:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kqKiNlw7g2ryDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Aug 2026 16:48:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 78A7CA13AA; Mon, 17 Aug 2026 18:48:28 +0200 (CEST)
Date: Mon, 17 Aug 2026 18:48:28 +0200
From: Jan Kara <jack@suse.cz>
To: Jann Horn <jannh@google.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page-writeback: document folio_mark_dirty()
 locking more explicitly
Message-ID: <eref4jpa2fvzssamgks2qmt63enkfeioetj7jk57xhd2tejeio@smd77j22s2wa>
References: <20260810-set-page-dirty-warnings-v2-1-1bd40fadfacd@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-set-page-dirty-warnings-v2-1-1bd40fadfacd@google.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,msgid.link:url,imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 10-08-26 20:10:01, Jann Horn wrote:
> We have had bugs where set_page_dirty() was used on a page from GUP without
> appropriate locking, leading to UAF, in:
> 
>  - KVM, see
>    https://lore.kernel.org/r/20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com
>  - i915, see commit 0d4bbe3d407f ("drm/i915/userptr: Try to acquire the
>    page lock around set_page_dirty()").
>  - VMCI, see commit 5a16c535409f ("VMCI: Use set_page_dirty_lock() when
>    unregistering guest memory")
>  - kpc2000 staging driver, see commit b6d13bd9f2c1 ("staging: kpc2000:
>    kpc_dma: Convert set_page_dirty() --> set_page_dirty_lock()")
> 
> I think set_page_dirty() and folio_mark_dirty() need more explicit
> documentation on how they should be used with pages from GUP; so add a
> comment on top of set_page_dirty() and make the comment above
> folio_mark_dirty() more explicit.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - reword commit message to drop references to out-of-tree drivers, and
>   instead add more examples of upstream bugs
> - Link to v1: https://patch.msgid.link/20260810-set-page-dirty-warnings-v1-1-53cad4890808@google.com
> ---
>  mm/folio-compat.c   | 1 +
>  mm/page-writeback.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index a02179a0bded..6212fdd6761a 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -41,6 +41,7 @@ void set_page_writeback(struct page *page)
>  }
>  EXPORT_SYMBOL(set_page_writeback);
>  
> +/* Read the comment above folio_mark_dirty() regarding required locks! */
>  bool set_page_dirty(struct page *page)
>  {
>  	return folio_mark_dirty(page_folio(page));
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index e98748112d1e..b0ab687c83be 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2773,6 +2773,11 @@ EXPORT_SYMBOL(folio_redirty_for_writepage);
>   * in this folio.  Truncation will block on the page table lock as it
>   * unmaps pages before removing the folio from its mapping.
>   *
> + * .. DANGER::
> + *    Do not use this on a folio obtained from a function like
> + *    get_user_pages_fast() without holding appropriate locks; you might want to
> + *    use set_page_dirty_lock() or folio_mark_dirty_lock() instead.
> + *
>   * Return: True if the folio was newly dirtied, false if it was already dirty.
>   */
>  bool folio_mark_dirty(struct folio *folio)
> 
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20260810-set-page-dirty-warnings-4000f0015394
> 
> Best regards,
> --  
> Jann Horn <jannh@google.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
