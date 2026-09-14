Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901B41D657;
	Mon, 14 Sep 2026 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380337; cv=none; b=nU27m7HbMFg8wiugxXMbOG7mkuNrv3+jwYE5uVOP4Ce4Sbz4dSRX5E9+YgV7lImjvapzfMGCBvIZ9bQYj1gFHsXsclMYHT6M3xtkFc7A2DeeY7TDzIJ63vrhCZtTQE/Ll1c9c2St1UUKTSIpr3K0+oYve/N6l3YOjf/A2gvRcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380337; c=relaxed/simple;
	bh=RPxJHl8fG6Za+XlU6ps927tP4ZN2Ost4ugkP6pMt4BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3IiKLcKrAhSFHWR5RE7JJHNtR1cnDs26qOnAKdapApEKW0V2UBQr7eDLQnhj4PKMwrVkiT0qYAyIKYV7WWy8wBOAH8uzpwpR/vM5ezgxK/d+lPDhBjNqISvCCCwTQFMJyYCeTJPzwK3pL/XM3vd02djvbVplhFGQDPF+RZr5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YnFaqGVT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkigB1Yg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KD9oUBgB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=om4PdHd8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YnFaqGVT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkigB1Yg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KD9oUBgB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="om4PdHd8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B97C51F7D7;
	Mon, 14 Sep 2026 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789380329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmBWl0mHYf0yLACdOrccuowLiTsIHpW0AATNzUDZUMM=;
	b=YnFaqGVTGYwDfGfEj++30T9Olqw3hIHWRGXKY2SmM+XlKUky+i90UxQSeidZ0OwK7+NtIj
	t6irSIjnVjRWKAifzaWNzR+b6wHaZ317ilLNIHYmdvGIYN2RXNhLkscemObySsN9SF28sV
	CyZyVsGQO9lPClX74KNwj5k4JVkoDis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789380329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmBWl0mHYf0yLACdOrccuowLiTsIHpW0AATNzUDZUMM=;
	b=EkigB1YgH0iCLKv73cUBF1d0qHxDnSqIoadVck5eZDLz1jvCOSQF/AnO/DYq/SSNIILfYI
	Q4naDwfFSiKT2lCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KD9oUBgB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=om4PdHd8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789380325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmBWl0mHYf0yLACdOrccuowLiTsIHpW0AATNzUDZUMM=;
	b=KD9oUBgB9J+QLYJ41r0FyeE/f94xrisxj/OIKWLa6D550JtSqWIKsr9Y+HXSYXRIHFdlyC
	ie02mPr0f960klJ2v8orbij9sSy7p3nUioViQUvmyFaH26yeVJC5C7oETlU+06p14pDmq4
	MxghZEXpxFr+BysEH8rN61RuqOvOc54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789380325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmBWl0mHYf0yLACdOrccuowLiTsIHpW0AATNzUDZUMM=;
	b=om4PdHd8ws4Pfe1hfqUPS9aQ7709BKqsCUr9uZO2AM96lebDewlT4JU/v9Dk1n2G52sxoX
	05BYJzLyJ8TbJzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F0B713865;
	Mon, 14 Sep 2026 10:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wiXiIuXGp2oYAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 10:05:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 20BCFA12E4; Mon, 14 Sep 2026 12:05:25 +0200 (CEST)
Date: Mon, 14 Sep 2026 12:05:25 +0200
From: Jan Kara <jack@suse.cz>
To: Yingchao Deng <dengyingchao@kylinsec.com.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, qinyungao@kylinsec.com.cn
Subject: Re: [PATCH] fs: fix misleading comments in read_write.c
Message-ID: <nqzii2t5rbrj4bfpng63vdo3npajak5wprv2xrscqlibicsszt@l3ycwknmopxd>
References: <918177B3298981ED+20260914075337.1739-1-dengyingchao@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918177B3298981ED+20260914075337.1739-1-dengyingchao@kylinsec.com.cn>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B97C51F7D7
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,kylinsec.com.cn:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 14-09-26 15:53:37, Yingchao Deng wrote:
> generic_write_checks() returns the number of bytes that may be written
> (possibly truncated by generic_write_check_limits()), not zero.  The
> comment was likely copied from generic_copy_file_checks(), which is the
> analogous function for copy_file_range() and does return 0 on success.
> 
> Also, no_seek_end_llseek() and no_seek_end_llseek_size() are helpers for
> files that do not support SEEK_END (they only handle SEEK_SET and
> SEEK_CUR), not for "fixed-sized devices"; that description was copied
> from fixed_size_llseek().
> 
> Signed-off-by: Yingchao Deng <dengyingchao@kylinsec.com.cn>

Nice, thanks. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index e8c14e2760b2..4da846a2bf17 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -274,7 +274,7 @@ loff_t fixed_size_llseek(struct file *file, loff_t offset, int whence, loff_t si
>  EXPORT_SYMBOL(fixed_size_llseek);
>  
>  /**
> - * no_seek_end_llseek - llseek implementation for fixed-sized devices
> + * no_seek_end_llseek - llseek implementation for files without SEEK_END
>   * @file:	file structure to seek on
>   * @offset:	file offset to seek to
>   * @whence:	type of seek
> @@ -293,7 +293,7 @@ loff_t no_seek_end_llseek(struct file *file, loff_t offset, int whence)
>  EXPORT_SYMBOL(no_seek_end_llseek);
>  
>  /**
> - * no_seek_end_llseek_size - llseek implementation for fixed-sized devices
> + * no_seek_end_llseek_size - llseek implementation for files without SEEK_END
>   * @file:	file structure to seek on
>   * @offset:	file offset to seek to
>   * @whence:	type of seek
> @@ -1761,8 +1761,8 @@ EXPORT_SYMBOL(generic_write_checks_count);
>   * Performs necessary checks before doing a write
>   *
>   * Can adjust writing position or amount of bytes to write.
> - * Returns appropriate error code that caller should return or
> - * zero in case that write should be allowed.
> + * Returns the number of bytes that may be written on success (which
> + * may be less than requested if truncated), or a negative error code.
>   */
>  ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  {
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
