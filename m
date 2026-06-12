Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424E347505
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261455; cv=none; b=LA8ahc5NtcjDcjH5paa914dlWPneJXFw+8G2W/BVopv8ovvmsr1KEBQbwPZxh1HEBzVICjmBoNoNBjKPkBuwi3nsU0XT+gb3fP+Q1Bu1UZFC84ZRKwkwRpaMqLclukmTwwTlyT3jytLWwHM3PoxV6hddgR+1PnCoLVUS13NZnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261455; c=relaxed/simple;
	bh=peCkeTeq6YhiATAmlWLQ0ZorEu132I57JlTHHZavqvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGtwdUyXpBGrhSt/pjCjPqE5aCPiF3ZDv/3//ziipOzb8Kejd3fGaUEg/zX/Oi3adby8r3KIgJhLJVhWonNKN6p7Zg2jKKPsRivI+z/MyGqKxArPaLX/sQO3bf38OQjRBVo0TXkNMtF1fqD2pm0EyhGX0k00bTITlbGpBZxNi3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ic4ihajP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=afHAKkL4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ic4ihajP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=afHAKkL4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ic4ihajP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="afHAKkL4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ic4ihajP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="afHAKkL4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A528765DD;
	Fri, 12 Jun 2026 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781261452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adKl1uuNS0qC0pRfF9ZlrempdpJ1NBm/6W7s3a2+pZY=;
	b=ic4ihajPNq/lbLlsoV9jLdG4Ql2OYTigg3X8QIDy2VQ12Qgh7eZR0rCSCw9ojOEViIkZbO
	dsrnKG3fR4Yr7SIYStYX6wmXzTw7qdAFAhyjk2TEMDb6F048Pws9K4nWqSkYRuIQYE86dQ
	dKxPhmMqpLebbreuLQjU3nkVFQvffFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781261452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adKl1uuNS0qC0pRfF9ZlrempdpJ1NBm/6W7s3a2+pZY=;
	b=afHAKkL4J+9RQUl9eO1cfNbw08pahbI6Hei0/BiJ5d69UJuPDmaybm03fJxEhVovf4t9AE
	UgSMpXwJ5M4QqeDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781261452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adKl1uuNS0qC0pRfF9ZlrempdpJ1NBm/6W7s3a2+pZY=;
	b=ic4ihajPNq/lbLlsoV9jLdG4Ql2OYTigg3X8QIDy2VQ12Qgh7eZR0rCSCw9ojOEViIkZbO
	dsrnKG3fR4Yr7SIYStYX6wmXzTw7qdAFAhyjk2TEMDb6F048Pws9K4nWqSkYRuIQYE86dQ
	dKxPhmMqpLebbreuLQjU3nkVFQvffFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781261452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adKl1uuNS0qC0pRfF9ZlrempdpJ1NBm/6W7s3a2+pZY=;
	b=afHAKkL4J+9RQUl9eO1cfNbw08pahbI6Hei0/BiJ5d69UJuPDmaybm03fJxEhVovf4t9AE
	UgSMpXwJ5M4QqeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70EEE779A7;
	Fri, 12 Jun 2026 10:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJCLG4zkK2p1UAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Jun 2026 10:50:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1820EA0EB4; Fri, 12 Jun 2026 12:50:48 +0200 (CEST)
Date: Fri, 12 Jun 2026 12:50:48 +0200
From: Jan Kara <jack@suse.cz>
To: hexlabsecurity@proton.me
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: validate sparing table length as an entry count,
 not a byte count
Message-ID: <wudlwpcg7gldrzgrab7sjcp3tiex436snwp3tgiwzenskszmmh@kar23ttnlsz7>
References: <20260612-b4-disp-91780c4e-v1-1-f15112ff6882@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-b4-disp-91780c4e-v1-1-f15112ff6882@proton.me>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri 12-06-26 01:40:01, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> udf_load_sparable_map() accepts a sparing table when
> 
> 	sizeof(*st) + le16_to_cpu(st->reallocationTableLen) > sb->s_blocksize
> 
> is false, i.e. it treats reallocationTableLen as a number of BYTES that
> must fit in the block.  But the table is walked as an array of 8-byte
> sparingEntry elements:
> 
> 	for (i = 0; i < le16_to_cpu(st->reallocationTableLen); i++) {
> 		struct sparingEntry *entry = &st->mapEntry[i];
> 		... entry->origLocation ...
> 	}
> 
> in udf_get_pblock_spar15() and udf_relocate_blocks().  A
> reallocationTableLen of N therefore passes the check whenever
> sizeof(*st) + N <= blocksize, yet the consumers index
> sizeof(*st) + N * sizeof(struct sparingEntry) bytes -- up to ~8x the
> block.  On a crafted UDF image this is an out-of-bounds read in
> udf_get_pblock_spar15(); udf_relocate_blocks() additionally feeds the
> same length to udf_update_tag(), whose crc_itu_t() reads far past the
> block, and its memmove() through st->mapEntry[] is an out-of-bounds
> write.
> 
> Validate reallocationTableLen as the entry count it is, with
> struct_size().
> 
> Fixes: 1df2ae31c724 ("udf: Fortify loading of sparing table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Good catch. Thanks for the fix. I've added the patch to my tree.

								Honza

> ---
>  fs/udf/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index cad2e15d633b..d75bfc733975 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1418,7 +1418,8 @@ static int udf_load_sparable_map(struct super_block *sb,
>  		if (ident != 0 ||
>  		    strncmp(st->sparingIdent.ident, UDF_ID_SPARING,
>  			    strlen(UDF_ID_SPARING)) ||
> -		    sizeof(*st) + le16_to_cpu(st->reallocationTableLen) >
> +		    struct_size(st, mapEntry,
> +				le16_to_cpu(st->reallocationTableLen)) >
>  							sb->s_blocksize) {
>  			brelse(bh);
>  			continue;
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260612-b4-disp-91780c4e-fb52a746d9df
> 
> Best regards,
> -- 
> Bryam Vargas <hexlabsecurity@proton.me>
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
