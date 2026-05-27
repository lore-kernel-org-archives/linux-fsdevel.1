Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5E3D8106
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877548; cv=none; b=n9CKxIE2SnNUzIV6qUwHTaZRIR+qw7RbkhTiZ+pc/tA+VYRGMFZ81tYtNaak9uZV1gMt6zJzgQq9C8ozYtM64tKi0EOhiNB9s1zLM1btgDEzP2KuPsyx8hX7MG30HzGdqZOkPx+DCfu1ZaTViTaEzrlOXjaUGkG7pL/kVDBHGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877548; c=relaxed/simple;
	bh=AphB7QPiL+Vgyhyb2GG2wTbQzXZDyZdJyAUjU3i/wMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScVngs6DTZRBiMTCvbTL1fyFiZ6htSlAd72BKcltZKMCyIn0uSTUDBod3+wIEKoussqtnnjir9xS0NMV9jghHJi3BcbEdwroHNilj+eZplQulD0lorrX/eVsUDsUM1GpSoZ/DMX8IBhYXtqKHQ08BRJ2DDGMtQ9B3u4ezMU+XUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJhw3tfl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RO1W6RrM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3KigZ5gb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jjKkqSoP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJhw3tfl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RO1W6RrM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3KigZ5gb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jjKkqSoP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E28E06AA6B;
	Wed, 27 May 2026 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdyKzJja7nP2rgbmpg/9hzcvcUWg73xPPkWDXzeAwEs=;
	b=nJhw3tflakdjCdnGMnPI9Yvo77mm4LIxz1pvxEPVyJ3DtOG63m1B4KNf8RRp5rHKDDQCmX
	RcoSaKoPQ549RMyvbZFBa6ox8vG736BI27QVbY4Um6/5bjCLENN2x+MpxRgatu0XBfD3ph
	FsRBPRjDVgYlwLfMOT/hxhTN98bii5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdyKzJja7nP2rgbmpg/9hzcvcUWg73xPPkWDXzeAwEs=;
	b=RO1W6RrMGAW+5rZHuTmTk02bjF5IW2vJAhU9LZc/XfvTfyvJOJmfUx6Yr2gp/XxwDcCMjn
	4vhJRqoqKeWGoPCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3KigZ5gb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jjKkqSoP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdyKzJja7nP2rgbmpg/9hzcvcUWg73xPPkWDXzeAwEs=;
	b=3KigZ5gb2nIDntPss8qgS2LfHNR57drz/dwmsmkqheG9NeVY77cz1Zk8YJIxbX75nwHvyT
	0l3eHOJa3ZGkH26i/PpB5ajT4fdvjC2Lpx6xytt6ab6NiqngzdKAg5uHf2fOZIvFYwE5xg
	zRJ7AcfXReajLZE7GxmdX8WDxGa8cjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdyKzJja7nP2rgbmpg/9hzcvcUWg73xPPkWDXzeAwEs=;
	b=jjKkqSoPIIHjZIk8GJ7Lu0/APz+JwP5r78VmtVwaslx5AXqDds6XUwLSFRtyO3KaHdOe7D
	03KtVEWQXyHhSPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA58B5A7A5;
	Wed, 27 May 2026 10:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y7xNNajGFmrYaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 10:25:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9938CA0EB5; Wed, 27 May 2026 12:25:44 +0200 (CEST)
Date: Wed, 27 May 2026 12:25:44 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/34] buffer: Convert __bh_read_batch to bh_submit()
Message-ID: <wpx6qsu7cbv5at4lawql4sxrhcpgl47ohydpiusw5nu2hej3r4@zpbzjhgejtqi>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-10-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-10-willy@infradead.org>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E28E06AA6B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 25-05-26 18:19:02, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using bh_submit() instead of
> submit_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 48b4480e9915..44b14f0642f4 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3125,9 +3125,8 @@ void __bh_read_batch(int nr, struct buffer_head *bhs[],
>  			continue;
>  		}
>  
> -		bh->b_end_io = end_buffer_read_sync;
>  		get_bh(bh);
> -		submit_bh(REQ_OP_READ | op_flags, bh);
> +		bh_submit(bh, REQ_OP_READ | op_flags, bh_end_read);
>  	}
>  }
>  EXPORT_SYMBOL(__bh_read_batch);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
