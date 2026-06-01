Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8D2E0B5C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331134; cv=none; b=k500h3HaIxmxhxnUoLadhdrxrgZe4VUwtqNhgMoZB2ETZjZGdiIS4WDcv66U7wdVlqIigWEbBr67RjJ/+qF2DlgmAn2Ft9dRW1UXiROq0Xtmrwp5FbUo51/B2lg6LyqAiEJjXRinyRjM/08yhzI+vGV8PRlSbhmx5Dd7edZdsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331134; c=relaxed/simple;
	bh=P83F2ctrsiBVF0jNCS8hzCqN3JkTeVPW7QfZBcdYkps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8B+VNFdAs/RudtMRK9jv5Wrek7o2EUDT3De7jCj/mWobNu6zDdedgEUw6FygJxaqRiuwql6C+mR+3BhIrmeDtGUqX0b33C5ifDtlFt6vCXddrTbP6PgodmXDJiaMN2Y3nc2J2uJgLErE4VaDP5dSlHgcCspByJBbCpiA8vBNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RzPOoSO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pPzpwVgU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RzPOoSO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pPzpwVgU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RzPOoSO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pPzpwVgU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RzPOoSO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pPzpwVgU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BACF6AF4D;
	Mon,  1 Jun 2026 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780331130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2CzP0iLnWKcwILC9jm502jdM9oamk+/w4JeVs2q8ZI=;
	b=RzPOoSO3L1vuAhLOAMa3Pdxk8vKYyp0ri82h1tkkIww02gN0oXb7cM98fRag5Cc0LSyv1m
	R1dAZ4O/C9cI6xdPNwhbG62sJMzeadPXEWGVRaBZ9no2a6K0DBCH+hN0WM9yQ4VCu+5whR
	J9wo7NpgnRvFrxH07JM1wnd1vunZywU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780331130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2CzP0iLnWKcwILC9jm502jdM9oamk+/w4JeVs2q8ZI=;
	b=pPzpwVgUFKCC16upKhxX1Kx8vfZGoOHR8Cs0MCMiO2a0Ozsw9LB3WuN64Z/+97NNX3srEq
	MFQ0BO3vQ5ha/aAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RzPOoSO3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pPzpwVgU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780331130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2CzP0iLnWKcwILC9jm502jdM9oamk+/w4JeVs2q8ZI=;
	b=RzPOoSO3L1vuAhLOAMa3Pdxk8vKYyp0ri82h1tkkIww02gN0oXb7cM98fRag5Cc0LSyv1m
	R1dAZ4O/C9cI6xdPNwhbG62sJMzeadPXEWGVRaBZ9no2a6K0DBCH+hN0WM9yQ4VCu+5whR
	J9wo7NpgnRvFrxH07JM1wnd1vunZywU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780331130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2CzP0iLnWKcwILC9jm502jdM9oamk+/w4JeVs2q8ZI=;
	b=pPzpwVgUFKCC16upKhxX1Kx8vfZGoOHR8Cs0MCMiO2a0Ozsw9LB3WuN64Z/+97NNX3srEq
	MFQ0BO3vQ5ha/aAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BFAB779A7;
	Mon,  1 Jun 2026 16:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BF/xFXqyHWqleAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 16:25:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE74EA0EC0; Mon, 01 Jun 2026 18:25:25 +0200 (CEST)
Date: Mon, 1 Jun 2026 18:25:25 +0200
From: Jan Kara <jack@suse.cz>
To: tanze <tanze@kylinos.cn>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz
Subject: Re: [PATCH v1] mm/filemap: use folio_next_index() for start
Message-ID: <bzmte6yvhabfy6hvv3gln35b7aujhs3kxgaeenvpctfxqisvig@falgc3o6bhvz>
References: <20260601110425.44784-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601110425.44784-1-tanze@kylinos.cn>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-2.11 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	URIBL_RED(0.50)[kylinos.cn:email];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6BACF6AF4D
X-Spam-Score: -2.11

On Mon 01-06-26 19:04:23, tanze wrote:
> Use folio_next_index() instead of open-coding
> folio->index + folio_nr_pages(folio) when updating @start in
> filemap_get_folios_contig(), filemap_get_folios_tag(), and
> filemap_get_folios_dirty().
> 
> Signed-off-by: tanze <tanze@kylinos.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e636647100c..e233d4a003ce 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2283,8 +2283,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
>  			goto put_folio;
>  
>  		if (!folio_batch_add(fbatch, folio)) {
> -			nr = folio_nr_pages(folio);
> -			*start = folio->index + nr;
> +			*start = folio_next_index(folio);
>  			goto out;
>  		}
>  		xas_advance(&xas, folio_next_index(folio) - 1);
> @@ -2344,8 +2343,7 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
>  		if (xa_is_value(folio))
>  			continue;
>  		if (!folio_batch_add(fbatch, folio)) {
> -			unsigned long nr = folio_nr_pages(folio);
> -			*start = folio->index + nr;
> +			*start = folio_next_index(folio);
>  			goto out;
>  		}
>  	}
> @@ -2403,8 +2401,7 @@ unsigned filemap_get_folios_dirty(struct address_space *mapping, pgoff_t *start,
>  			}
>  		}
>  		if (!folio_batch_add(fbatch, folio)) {
> -			unsigned long nr = folio_nr_pages(folio);
> -			*start = folio->index + nr;
> +			*start = folio_next_index(folio);
>  			goto out;
>  		}
>  	}
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
