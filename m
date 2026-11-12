Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518331;
	b=DH/Pmtoa2zFRS8guduYu5QoZnyqIyHOzV9tH9/tV7skKDveMFmp9N84Ys5HwdHkiR4MC
	 dF7WV3k2Gq0Ht+eT2ixQEzgcd/+n1TBXaeVjcxSi+MG2E1hC2TI/AuQ7lgLR+9GnUEFiP
	 N8MopdE1HwQOp2QPNcrwjslwTKME7SjO2WyOnep17xrXGdopomvJQ6Mpung/iR9C/VOZE
	 bbs1nj18McQ4ikZpYFD+1zhwSY1gWkR4qJRZu7+MLjLiZug+p6G0f2ChCRTMdqhq2xHHC
	 LQOTOwHWiI7elMKqnGCOEOb48e0jKygtcMmYSv7fXD+y8v+J/vjv7i/kSScXUvOtnNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518331;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=oR1ZjXRhUcdoMnMdn9TMY7271yE7yog6gXeZYHWU2oU=;
	b=yfxEUkIkijxar3SY1YuW9icotsETYQm2ZxXyf7WH0LYLf+NwpOAh6kHTPfEBsUsPP+4G
	 Hzw8G3VPPq1cV+UHMX9Z26voHtKqYZAejlydEPMiIKQS+KY2Ld/kOrhSqxfYqNLtQIGWa
	 NaJePScmDdc14csz4p8FU1CMfZEcL7g9mCR+6kl0+47y+Wwd5mN7PYG3egctWp/7oC8AN
	 eYsxcF/EVJam6YFo8RyZg9p0PHluTOKYcLEl3lZo5Ga5Yw1orZIwFRp78W8e3WdoXcTfF
	 eTMcWE7lT15vyCSU/+tq4nTQNwIt5lVCm7jSyGWeQL3mwjqkTQ/P6/QFyY3yzn/L+rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TSGMLEGx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1UNwTerQ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TSGMLEGx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1UNwTerQ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE1606A327;
	Thu, 12 Nov 2026 21:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98AE1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TSGMLEGx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1UNwTerQ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TSGMLEGx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1UNwTerQ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F14922290;
	Thu, 12 Nov 2026 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794518328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oR1ZjXRhUcdoMnMdn9TMY7271yE7yog6gXeZYHWU2oU=;
	b=TSGMLEGxWuiJ8RKvtKhE60V739Y3gABoW1gbRjIG+5wDLwx8VeZsv6h9bnwgs1bMFC1nX5
	5P+sgBtdHPPtdwvxAgsW+Vj3b9aAqxYV7LQ1x7oISsRQidB1eW/M8FX5tES2RkMJAFR6sV
	j+Ax8fxvdQDrvrITnkwolzBA6rC1sqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794518328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oR1ZjXRhUcdoMnMdn9TMY7271yE7yog6gXeZYHWU2oU=;
	b=1UNwTerQ+Bk1aljOcyoL+YElSiCCf6QBTZdK5Am0rzc5vsE0y98QajhTayBgFZ6idK1iIS
	X5dUXtByg0uBKPCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794518328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oR1ZjXRhUcdoMnMdn9TMY7271yE7yog6gXeZYHWU2oU=;
	b=TSGMLEGxWuiJ8RKvtKhE60V739Y3gABoW1gbRjIG+5wDLwx8VeZsv6h9bnwgs1bMFC1nX5
	5P+sgBtdHPPtdwvxAgsW+Vj3b9aAqxYV7LQ1x7oISsRQidB1eW/M8FX5tES2RkMJAFR6sV
	j+Ax8fxvdQDrvrITnkwolzBA6rC1sqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794518328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oR1ZjXRhUcdoMnMdn9TMY7271yE7yog6gXeZYHWU2oU=;
	b=1UNwTerQ+Bk1aljOcyoL+YElSiCCf6QBTZdK5Am0rzc5vsE0y98QajhTayBgFZ6idK1iIS
	X5dUXtByg0uBKPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 458CB134A0;
	Thu, 12 Nov 2026 21:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ssYHCTgt9mqkZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Nov 2026 21:18:48 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id B9D4722BD9; Thu, 12 Nov 2026 22:18:43 +0100 (CET)
Date: Thu, 12 Nov 2026 22:18:43 +0100
From: Jan Kara <jack@suse.cz>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] buffer: Annotate the remote buffer LRU occupancy check
Message-ID: <dzuz4ea2o4d3nismuvcis56awwl636rnm3ecgbzhb3ylevgheu@5t433wwg45wq>
References: <20261112015047.114119-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261112015047.114119-1-zhujun2@cmss.chinamobile.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 12-11-26 09:50:47, Zhu Jun wrote:
> has_bh_in_lru() reads another CPU's buffer LRU while that CPU may install
> or invalidate entries. The local BH LRU lock does not serialize this
> remote occupancy check, which KCSAN reports as a data race.
> 
> The check only decides whether to send a drain IPI and never dereferences
> the sampled pointer. Mark the occupancy check as an intentional data
> race with data_race().
> 
> Fixes: 42be35d0390b ("fs: only send IPI to invalidate LRU BH when needed")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Use data_race() without READ_ONCE().
> - Drop the added comment, as suggested by Jan Kara.
> 
>  fs/buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 5d3852b726d6..2d2d61495b4d 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1437,7 +1437,7 @@ bool has_bh_in_lru(int cpu, void *dummy)
>  	int i;
>  	
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
> -		if (b->bhs[i])
> +		if (data_race(b->bhs[i]))
>  			return true;
>  	}
>  
> -- 
> 2.51.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
