Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E0409273;
	Mon,  7 Sep 2026 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768805; cv=none; b=ulsOFrSxTEx18XHDBowQCF0zhDnygq7J7aTdv/Ti4LHv3lN/Nr4ARdQOADWs76AwVsN3J5CzNX0j0z/b8ASyDzkC7iFMUI+mR0NZfrRfo7s9BCtllIenN2q4tJWgJ97qm6pt7WTMO7qDo6zqKDZnj3lTE0Ok7VnwUI1C5xTJIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768805; c=relaxed/simple;
	bh=hkZKtEpUa8YeJNQhSxbK0MTF72WCOGzDbh+fOV+xndg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT8wqgxoGXwBCTTmKn9LYLjprEwIbWTb4lylfM8htLqYEG3Q3RGHFXFHH9ASm9rzY3mmVKsstsmCAob/nEMirJLuHofp6wuRSOY6RYsOKJjFWdzLNYH+R0xHM8GX2FUfBNxZCk9YvTt7RcJMnlDmQJ8PAZ7GROCeCo3J7cCqQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YHmDIvjj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W7dnrAfu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltTmMs1c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=quvDt5WN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHmDIvjj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W7dnrAfu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltTmMs1c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="quvDt5WN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC005219AF;
	Mon,  7 Sep 2026 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788768797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wug/DUoehL446uW0Qq0uBHQgP1BZ03ulx6MYrv+f8qI=;
	b=YHmDIvjjqvp/yKJOM3LAJum9jZrPZNrjRX42oO0S8Xd36y0GmyXboc8w1p2PAa3ydsfYJE
	O5WlSbK3Zz/nmleipzXJXhy8BHlWlZ07i603GkYVSyn1dAgwKZ54Ab1obp+V2oXRxnc9gZ
	bK4wsm2jLpfmbt7Ep8vmzbTgF5Bf3oc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788768797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wug/DUoehL446uW0Qq0uBHQgP1BZ03ulx6MYrv+f8qI=;
	b=W7dnrAfuMWqiyqWeQ+uZE0MRbk11dh4fL2e4GVfJ2QKT5Bn19FNxojG2YdpKFU7aaolD/S
	gXUHFYAiCMex0qCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788768793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wug/DUoehL446uW0Qq0uBHQgP1BZ03ulx6MYrv+f8qI=;
	b=ltTmMs1cCbgzkfrmuLY2gZpXnpKlitAQ9xDr2DPYBt6j3tqzYj3+WTFvM7tGqzcl1D87Vs
	rQ5slRe09FQklremEYfdu0KB4RynqRzlc1hfUZ7wfCNdmuWzimcB/Uw4j319i3EKlWajzG
	7rNck9Vh8mJW2OBpvInk20fENoe7dmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788768793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wug/DUoehL446uW0Qq0uBHQgP1BZ03ulx6MYrv+f8qI=;
	b=quvDt5WN9l60cLyEbnSozQLU+fh7PTFHXlUJ6sig7GruxBZXD9foGV0bhDZV81orDfpIFM
	qbsqEpDB8yGwvjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C7BE1339B;
	Mon,  7 Sep 2026 08:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jpRKIhlynmreMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Sep 2026 08:13:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 20865A13B2; Mon, 07 Sep 2026 10:13:09 +0200 (CEST)
Date: Mon, 7 Sep 2026 10:13:09 +0200
From: Jan Kara <jack@suse.cz>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix repeated word 'in' in comment
Message-ID: <hwsl7k6ezrfohhdlk4irrw7rnyxzwnlmerefnatubdahrxicpp@i6yik4tryzxv>
References: <20260904123914.583-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904123914.583-1-hemanth.selam@gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Fri 04-09-26 18:09:13, Hemanth Selam wrote:
> Drop the second 'in', reported by checkpatch.pl as a possible repeated
> word.  Only touches a comment, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/isofs/compress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index f9869d62b850..9efd7a9082e3 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -90,7 +90,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  	/*
>  	 * First block is special since it may be fractional.  We also wait for
>  	 * it before grabbing the zlib mutex; odds are that the subsequent
> -	 * blocks are going to come in in short order so we don't hold the zlib
> +	 * blocks are going to come in short order so we don't hold the zlib
>  	 * mutex longer than necessary.
>  	 */
>  
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
