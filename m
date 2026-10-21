Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593281;
	b=RjZRBicYimxmHtBYdW8VFmFHiVOOAfazT4kx78UqGARivbkEmaaMx4cWNoD42KYfrd8S
	 fYWqRrdh2LmZq46qzWdL5fto0mhJooQwqQFh0EYx0Ulya/FmRy/14UL0z/k5NQrcpEIQg
	 upJqhR/ol7JQOD1L8mQpGVT/km31gf1ijbmBmfvIPfh72shJNhVLKl41OxCI0B6+mW84L
	 lZ6l8TpvyyqJg9hksQl6KKcBVN/xK8o0h1VbbZrFRu1XSh3gltOvHJOEtH26aeUoLadAE
	 diwS9aLIRjqF5A/hf6Uuy5V4ScedNx8nZkpUneB3uYryRDuFCmkmmYwbeOLNxQk/zEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593281;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=zoHxJawmn48TVslOQ/jdCKDgR9kw9ytGoeHt+YEjdDI=;
	b=5TmqWx70VdRvZQrv+zfnmTX2Bh2BY1jtGKbGcyGsp2jLTCb0AYj/WDyHmPC/dIgjhDzz
	 q2Epnr/TNYkBNyUPMTcpIdnRoLYdbQLW3IYdbhPlIlUQAhui60pPogCiOp2Uw4OYKWpdP
	 yd2Q/ubw/HB4ONPosZ4W12ireZnWZv6MCtgssNbpaZpFh6b8nmERIxyYRfwGyaeo1PbZ+
	 VEOxxH2TgEnbNTYh+qnju7xro+p5kM2hVvKsahEdZqlrl//EzXxcEmEsoozBIBUej2t9T
	 1o8BZ7RE2EvC9RuO51Du4Dcp3e0ZHVESYW2L1aHqo8v6dXa+Q7jDgkBzM30e6ave6Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IPzjSjbW;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAYHbYKC;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IPzjSjbW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAYHbYKC;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB52606A31D;
	Wed, 21 Oct 2026 14:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB52606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IPzjSjbW;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAYHbYKC;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IPzjSjbW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAYHbYKC
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 788241FA84;
	Wed, 21 Oct 2026 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792593279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoHxJawmn48TVslOQ/jdCKDgR9kw9ytGoeHt+YEjdDI=;
	b=IPzjSjbWcc2T3LgkE5uS8MIP3IMJOBLElT4NZC2Kcem6r7CzGASc9XLc5JAxwT4GyIWLi6
	ewy1Blosu6vmC1PH/VQf831nukEt9D6FQVXuTvHpFgn7zJjbhWwsrNYBoYW6B26TUm3j9+
	8OUqsoHVr81v2a/QpOw2lix9Ms54438=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792593279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoHxJawmn48TVslOQ/jdCKDgR9kw9ytGoeHt+YEjdDI=;
	b=pAYHbYKCw7CLO4c8hyrhLCUxcAwuLdbQrBdNWrUvCmeMbGtGWXnl8swglzPI5G0qIIYBQS
	GGD+fp0sY/VCvZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792593279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoHxJawmn48TVslOQ/jdCKDgR9kw9ytGoeHt+YEjdDI=;
	b=IPzjSjbWcc2T3LgkE5uS8MIP3IMJOBLElT4NZC2Kcem6r7CzGASc9XLc5JAxwT4GyIWLi6
	ewy1Blosu6vmC1PH/VQf831nukEt9D6FQVXuTvHpFgn7zJjbhWwsrNYBoYW6B26TUm3j9+
	8OUqsoHVr81v2a/QpOw2lix9Ms54438=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792593279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoHxJawmn48TVslOQ/jdCKDgR9kw9ytGoeHt+YEjdDI=;
	b=pAYHbYKCw7CLO4c8hyrhLCUxcAwuLdbQrBdNWrUvCmeMbGtGWXnl8swglzPI5G0qIIYBQS
	GGD+fp0sY/VCvZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F1781351D;
	Wed, 21 Oct 2026 14:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dEfuBn/N2GoJWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 14:34:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6F2BA1421; Wed, 21 Oct 2026 13:34:57 +0200 (CEST)
Date: Wed, 21 Oct 2026 13:34:57 +0200
From: Jan Kara <jack@suse.cz>
To: Hui Peng <benquike@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/namespace: reject bufsize < sizeof(struct statmount)
 in prepare_kstatmount()
Message-ID: <e6ysb6lyld5remaojkqqbaffvlsxwhr4tmurifp7mhbqrj7l54@6yqqwu3d7e3y>
References: <20260919221732.3707664-1-benquike@gmail.com>
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
In-Reply-To: <20260919221732.3707664-1-benquike@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -12.80

On Sat 19-09-26 22:17:32, Hui Peng wrote:
> In prepare_kstatmount(), kstatmount.buf_size is initialized from the
> caller's bufsize argument without rejecting buffers smaller than
> sizeof(struct statmount), allowing string offset calculations relative
> to sizeof(struct statmount) to underflow or write past the user buffer.
> Reject bufsize < sizeof(struct statmount) in prepare_kstatmount().
> 
> Fixes: 68385d77c05b ("statmount: simplify string option retrieval")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Yeah, indeed it looks like we could overrun the user buffer. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ae5dc64f8b45..7f7905286fa6 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5882,7 +5882,7 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>  	ks->bufsize = bufsize;
>  
>  	if (ks->mask & STATMOUNT_STRING_REQ) {
> -		if (bufsize == sizeof(ks->sm))
> +		if (bufsize <= sizeof(ks->sm))
>  			return -EOVERFLOW;
>  
>  		ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
