Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656005;
	b=arLmA0UG/K7JPmyNUYs1G36VbqrGmvTItqcQMeR/akmgzyJieNkdU3WC/K/epmt0tiNj
	 gHMvplHAAopH7+r2s1mrj9erwLptdDIIc5ZXDe8zv5/S4rn7ELhfz2zwNeQvO45wCOagR
	 cMfzOhqCCOwyfjpBu7kp1B8c/Z4LA66nSr9eCd/tbslxPRXxAHa2XAsUxESB/wD8jjmHI
	 XtNr2QSzcAqC6QhRF2U3fLtCy5Xd+YiW6J7UO0q/MGKLMKj6zg1+re7cPJ1uiVFmzmGcY
	 9K0fl8rewFhsM6zOwftbVywV5kNi8A+A/9gqqExxrkLvQ/E+77QsOew1aWiulCZec/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656005;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=GbOlEoeEjn4AmnKwJIfj7iQ/wucai9bwBp3Ox/nzMzA=;
	b=fy6lsSdFySJB9b61513HyELYOJrb2vHYZ5BfytMhy/73upIJjmhpUlHZ4hPV8ITVWJh6
	 WsIIW2PxYn/I/YhG2wo3j/wSlBN3mCfM1/1qDA+qoRUqBW1Rb8CJ16AVBAwNZrdnXpDVd
	 k+To5kz2FomBeh5FyRzlSuvMs8+OjXnMHZ3fmk9U3txcK8txLFGvSH3fVYZ01SIqHiiIT
	 OZtvPtXNGpnKY1H1eZhknfEj+6IoLSkxA5zojZlt69XZTAC5w3G8prvVbPvcHHBkbRxud
	 eRozJXhqietMDkHZ3y8pWhu5zM4rAuwsNQNa5ETtlJQXV6ZDzWgnZIcRrvifomwik4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KnQgBc5L;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b9Dy6Zmv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KnQgBc5L;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b9Dy6Zmv;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B81606D80A;
	Mon,  2 Nov 2026 21:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67B81606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KnQgBc5L;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b9Dy6Zmv;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KnQgBc5L;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b9Dy6Zmv
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3A411FB0A;
	Mon,  2 Nov 2026 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbOlEoeEjn4AmnKwJIfj7iQ/wucai9bwBp3Ox/nzMzA=;
	b=KnQgBc5LSsfJB0vBErHP4sXiwRevi1h4AwYob2DboFHAo2gNhr4DMvTb/zodgjrfgN08h0
	xkSaev+zFffkbIepELvuAWCWQ7bZbqK3uE+15+MBwXr8Gu7WDJVi20W7eXK8R6RTmz+VFu
	mq3hjR+FGMzjR98w9uDe3yyK+Hcmjjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbOlEoeEjn4AmnKwJIfj7iQ/wucai9bwBp3Ox/nzMzA=;
	b=b9Dy6Zmv6zas3gtle7HmkEI71NHDs135kPvAFgqTESsMQP1iAfIAOKsOC066PRJG2GxyLM
	0WCCYUoyS7Df5CDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbOlEoeEjn4AmnKwJIfj7iQ/wucai9bwBp3Ox/nzMzA=;
	b=KnQgBc5LSsfJB0vBErHP4sXiwRevi1h4AwYob2DboFHAo2gNhr4DMvTb/zodgjrfgN08h0
	xkSaev+zFffkbIepELvuAWCWQ7bZbqK3uE+15+MBwXr8Gu7WDJVi20W7eXK8R6RTmz+VFu
	mq3hjR+FGMzjR98w9uDe3yyK+Hcmjjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbOlEoeEjn4AmnKwJIfj7iQ/wucai9bwBp3Ox/nzMzA=;
	b=b9Dy6Zmv6zas3gtle7HmkEI71NHDs135kPvAFgqTESsMQP1iAfIAOKsOC066PRJG2GxyLM
	0WCCYUoyS7Df5CDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A917E134B3;
	Mon,  2 Nov 2026 21:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E7BdI8ME6Wp3AQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Nov 2026 21:46:43 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 58D03B16B; Mon, 02 Nov 2026 22:46:43 +0100 (CET)
Date: Mon, 2 Nov 2026 22:46:43 +0100
From: Jan Kara <jack@suse.cz>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: clear page cache marks once when removing a
 folio
Message-ID: <zchm3kq5yykwhxbqgdr5sqkws2bp4qjmah4pcka5ancv4isk2t@co2erj67xpoe>
References: <20261030-bug-mm-filemap-init-marks-once-v1-1-699835fc6690@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-bug-mm-filemap-init-marks-once-v1-1-699835fc6690@gmail.com>
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -11.30
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 30-10-26 01:52:38, Qiliang Yuan wrote:
> xas_store() clears the marks of an entry before it replaces the entry
> with NULL.
> 
> page_cache_delete() calls xas_init_marks() after xas_store() whether it
> stored a shadow entry or NULL, so a folio removed without a shadow, as
> POSIX_FADV_DONTNEED and drop_caches do, has its marks cleared twice.
> With 4K folios that is about 6% of the time it takes to drop clean page
> cache.
> 
> Call xas_init_marks() only after storing a shadow entry, whose marks
> xas_store() leaves alone. Dropping 8 GiB of 4K folios, median of five
> runs, averaged over two boots of each kernel, in a 32 vCPU VM:
> 
>                           before    after
>   POSIX_FADV_DONTNEED    1517 ms  1423 ms
>   drop_caches            1515 ms  1422 ms
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Correct but please add a short explanation before the condition like:

	/* If xas_store() didn't clear marks, do it now */

With that feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b74bc1e5015c6..a0c959e74533e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -140,7 +140,8 @@ static void page_cache_delete(struct address_space *mapping,
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
>  	xas_store(&xas, shadow);
> -	xas_init_marks(&xas);
> +	if (shadow)
> +		xas_init_marks(&xas);
>  
>  	folio->mapping = NULL;
>  	/* Leave folio->index set: truncation lookup relies upon it */
> 
> ---
> base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
> change-id: 20261030-bug-mm-filemap-init-marks-once-b83c6aa67bab
> 
> Best regards,
> -- 
> Qiliang Yuan <odys.yuan@gmail.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
