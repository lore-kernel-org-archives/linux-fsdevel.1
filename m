Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05E392C3B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735053; cv=none; b=uBWg5JHeaeavCvXLEfNjv8ombQpQjl4mtluqQtRvKbhqKw36Gy7IjYNc6KxvYfHnfq4+31CQi15rFc0E1eTe56f8dZ9scoER0QP+FC9WVWT2K55alOsSnkDYf8Hc2In1w50hKj2kuZ1Si0guduInw2rP/lmdqd8kfdn0aSRBBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735053; c=relaxed/simple;
	bh=8rJ1OZYfYslPNIBV5/5qfAjIm731QhvV1HYeRpOIXDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5jLmlf1yo6nOyBkzFT4bCXmi+Q6b7SICZBETcq07cXE1li9YIKE0TSxRn/YtOjL2rbQE7TMpKNrOP207NDLvhimOkQNyDvyoeSYYt7rQqm5umU/5/HcI8pvBGaRjDE1BHqn101kTxo4zoC1Gf2C5Z3K1gGlDPjz6gbo+7O41ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PP+7iIEl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=58w7F49+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VI0SO//M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fUBhVW/i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PP+7iIEl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="58w7F49+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VI0SO//M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fUBhVW/i"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 165E85BCFD;
	Tue, 17 Mar 2026 08:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773735050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxecvMoTlmFeixFZ1ebr5yl1nb1we3LjrSPC3eW1IOA=;
	b=PP+7iIEldqjo8vbmejfL0p8Wudur7lz0GReEJU0+8iOiAnGRmQ/Gd7wcJqz0DZpiT+06wi
	XkE5JVjqnGMpg0kuyX8OdMzDUkN3jx9Hfus/6bwtrh5eNhp/OlK9JfYlbnLP9k5MIcSafO
	LawOH8c04f6/bL9p0ueLTtbxaL6BOxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773735050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxecvMoTlmFeixFZ1ebr5yl1nb1we3LjrSPC3eW1IOA=;
	b=58w7F49+mg5cZUxKeBodNb2MxRaLuQVFpGJuEFt6T1Ru+i3jx9K4y3eqlB26KF9khRvoBK
	ZcmndbMSXc2NVXBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="VI0SO//M";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="fUBhVW/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773735049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxecvMoTlmFeixFZ1ebr5yl1nb1we3LjrSPC3eW1IOA=;
	b=VI0SO//MNQ4HqUXsUp0WSfKWJ1oBAA6fRadUyLfSKn3svPWHYm/qMYkAxqFD5fRkIbvEhN
	wkmkS0/z1uuyI6GjImoyaxN4qNEaEjx3xGXVLVSgCfg51j2UQ5IwKNqYbdxBF6f0hp5uDO
	QKLmc3U2T0PaD3c5/Pqqt64Fj+4w27U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773735049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxecvMoTlmFeixFZ1ebr5yl1nb1we3LjrSPC3eW1IOA=;
	b=fUBhVW/iUBkNtNyKNtxAVBRtYtc7LjQ5qifpN3Ev8tDso2tQnZub3W5cJtgiscQ6btjxLh
	TUSRlzMrriq2HuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D5484273B;
	Tue, 17 Mar 2026 08:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zbs8A4kMuWlwVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Mar 2026 08:10:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE2DAA0A5B; Tue, 17 Mar 2026 09:10:40 +0100 (CET)
Date: Tue, 17 Mar 2026 09:10:40 +0100
From: Jan Kara <jack@suse.cz>
To: Kit Dallege <xaum.io@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: fix kernel-doc function name mismatch for
 wb_put_many()
Message-ID: <zfesul4xsiosblheei4ikbmtffoqdb3kr4vs3uztntujyqe5dp@l4q2ml2hnzlp>
References: <20260315170931.65852-1-xaum.io@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315170931.65852-1-xaum.io@gmail.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 165E85BCFD

On Sun 15-03-26 18:09:31, Kit Dallege wrote:
> The kernel-doc comment says wb_put but the actual function is
> wb_put_many. Fix the name to match.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Kit Dallege <xaum.io@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev-defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index c88fd4d37d1f..a06b93446d10 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -237,7 +237,7 @@ static inline void wb_get(struct bdi_writeback *wb)
>  }
>  
>  /**
> - * wb_put - decrement a wb's refcount
> + * wb_put_many - decrement a wb's refcount
>   * @wb: bdi_writeback to put
>   * @nr: number of references to put
>   */
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
