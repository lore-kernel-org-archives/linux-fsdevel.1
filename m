Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F944238A;
	Thu, 24 Sep 2026 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253648; cv=none; b=PUxt6CfgnyV5Q7WH9T5Nj/s7C610xtQxD33rpBzhsLIP366y2PKN587+yziUF6/aa1ooHY2TlK/royEWpAM3hvldvA6Pkgnx3Otn3JRcmp+bf+hBjliMlAJ8fB3eRWth3ePaEoSrJFASPldfTQh18C3eR859/ALnDI9ZDTkhA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253648; c=relaxed/simple;
	bh=KLc/0KaGWRXRWkCSETkAxDTozBHdOG7F1ZL7dVdNAOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WheggAeQFPg5tWn+vsR0LVyeWgv1xiqI55mw07in7czCOpGQEFRiTk8rJW8NOQJwk8IjMFna++g9EXm3DXtPASMWZdcI7qDuxiv+nEzVSmp/mwWtXm3sS7B1E9Gawsaqs62XJj3aTRfy4rF7f7IgB9HVZDO/qTtgzRnTBRbZqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3DybY/fA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tr15XjMK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OJ4I8g6t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PotMu/y+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3DybY/fA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tr15XjMK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OJ4I8g6t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PotMu/y+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30CAD1FF08;
	Thu, 24 Sep 2026 12:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790253636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wzi0LteWqjCI9XJwRsd2witZUdQ/E4/G6nLNS1Gi+SQ=;
	b=3DybY/fA2h6CWddHfVV+rq2FcHHMJeRzAt+QuExXfvKp8JOkZkSnh29m458aeIq9wrDJWp
	VBNEvpVVd3RgUvsAyLqVxTf9BcjHTxxvz+hx+Lo1WNjCaqpncNZtxTwBIi2fB0tTA//dKW
	MIb+nv7ug1u11uD12tSPS7UZBy98ma8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790253636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wzi0LteWqjCI9XJwRsd2witZUdQ/E4/G6nLNS1Gi+SQ=;
	b=tr15XjMKOUHuafCdXsQHtRKFftNuQTLs9Km/mpx02YhVuf6rTPTIvZt25buZeehxUDtBhu
	QOZAqg0Ra7suseDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OJ4I8g6t;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="PotMu/y+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790253632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wzi0LteWqjCI9XJwRsd2witZUdQ/E4/G6nLNS1Gi+SQ=;
	b=OJ4I8g6t3zFdWPv62MH9j1+Ssskzhzj80ufhfNk0DpyLsV1zBfknaC5SiS02Qlw+OqTP1x
	g/IeXq0V9RztP3h/EALKqKwyPOUPEZKSdClMwvctHUVYBo9B1TSW9x3zCBvit5jI4uH7Rb
	uRBjXw8AsvnpkzX1Xn1Sc1hUI3dqRuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790253632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wzi0LteWqjCI9XJwRsd2witZUdQ/E4/G6nLNS1Gi+SQ=;
	b=PotMu/y+FSda8/YBKY9PZiZuWpLqqkUcHZSXjME0JwqnplavTAdVz22M13kA12uW4IFSzk
	p7qM4SpzYVpPNXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07EEB13354;
	Thu, 24 Sep 2026 12:40:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7hxvNT8atWqldAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 12:40:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C939A132E; Thu, 24 Sep 2026 14:40:23 +0200 (CEST)
Date: Thu, 24 Sep 2026 14:40:23 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] isofs: bound the Joliet iocharset conversion by the
 output buffer
Message-ID: <h6vl5fsecegk7m6ichtrsypsob4covbadynlmgwvf3b4khrzjx@ztemht3exabe>
References: <20260922155524.1993425-1-matthias.goergens@gmail.com>
 <20260922155524.1993425-3-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922155524.1993425-3-matthias.goergens@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 30CAD1FF08
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Tue 22-09-26 23:55:24, Matthias Goergens wrote:
> uni16_to_x8() has no output-size parameter.  It passes
> NLS_MAX_CHARSET_SIZE to uni2char() on every iteration, which bounds what
> that one character may write but says nothing about how much of the
> buffer is left, and then writes a terminator wherever it stopped.
> 
> Nothing bounds the total.  It fits today only because the caller's input
> is bounded: de->name_len is a single byte, so at most 255 >> 1 units,
> each expanding to at most NLS_MAX_CHARSET_SIZE bytes.  The previous
> patch asserts that relationship at build time, but the conversion itself
> should not depend on it.
> 
> Pass the buffer size in and hand uni2char() the space that actually
> remains, stopping on -ENAMETOOLONG, as fs/hfsplus/unicode.c does.
> 
> The result is unchanged for every name a valid image can carry; only a
> caller that passed a smaller buffer would now truncate rather than
> overrun.  Listings of plain, Rock Ridge, Joliet, Rock-Ridge-plus-Joliet
> and zisofs images are unchanged.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

This looks mostly good except that I'd prefer get_joliet_filename() gets
the buffer length as an argument and just passes it down instead of
hardcoding it. That way the place allocating the buffer can just pass
proper size.

								Honza

> ---
>  fs/isofs/joliet.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
> index b1f4a105ee87..0832f40a9a2b 100644
> --- a/fs/isofs/joliet.c
> +++ b/fs/isofs/joliet.c
> @@ -15,19 +15,26 @@
>   * Convert Unicode 16 to UTF-8 or ASCII.
>   */
>  static int
> -uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls)
> +uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls,
> +	    int outsize)
>  {
>  	__be16 *ip, ch;
> -	unsigned char *op;
> +	unsigned char *op, *end;
>  
>  	ip = uni;
>  	op = ascii;
> +	end = ascii + outsize - 1;	/* leave room for the terminator */
>  
>  	while ((ch = get_unaligned(ip)) && len) {
>  		int llen;
> -		llen = nls->uni2char(be16_to_cpu(ch), op, NLS_MAX_CHARSET_SIZE);
> +
> +		if (op >= end)
> +			break;
> +		llen = nls->uni2char(be16_to_cpu(ch), op, end - op);
>  		if (llen > 0)
>  			op += llen;
> +		else if (llen == -ENAMETOOLONG)
> +			break;
>  		else
>  			*op++ = '?';
>  		ip++;
> @@ -59,7 +66,8 @@ get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, st
>  				outname, ISOFS_NAME_BUF_SIZE);
>  	} else {
>  		len = uni16_to_x8(outname, (__be16 *) de->name,
> -				de->name_len[0] >> 1, nls);
> +				de->name_len[0] >> 1, nls,
> +				ISOFS_NAME_BUF_SIZE);
>  	}
>  	if ((len > 2) && (outname[len-2] == ';') && (outname[len-1] == '1'))
>  		len -= 2;
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
