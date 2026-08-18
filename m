Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228534D3BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063345; cv=none; b=OmLYmRkVOsluDScTbdwWvYe3ozcY40OiZfPUOckXgvvn/MO8jsGHxJoQ1mMgdHZOjQxShYJZEo4MR/2GDMDF7rSJ94YY84lUXlpkQm0d+xgr+EuMeXBk/DWYwTZYAWg8kLErlkshmxDoxAuNUCOp3yiQbpdOSuSRvqoeGnhwsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063345; c=relaxed/simple;
	bh=G16yvnUofWqubmTNbE0CckKPXO3rt5xKFI9KLzmi6xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io2xTPLVYNOh3r5nM0g0y2ZO+C2x7ldm2S+qIgkM6RzgRch/h+xgGYWgKffz2PlzryzhChi43HGwlXOzE7T0ur4pi5dRslOpUNL9nOBSnDpQ5KU5obe+Egk49271lFXRorUeZ21T8HCaUXyfCMax8+n7qJ2V+pvbJFYTxMCqnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iFJGBBO0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a8FJfeSb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3MmVRBWn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=74LQIP2q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iFJGBBO0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a8FJfeSb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3MmVRBWn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="74LQIP2q"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17EAF3E35;
	Tue, 18 Aug 2026 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787063275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtxWyVcD4k4OSKeBM7VkgBLU+VO11ooDqMtTDibnhG0=;
	b=iFJGBBO0k92sLpc424a5IGq7uxV9pI+vqDYaw2T8n9r6F/xW9sJ6160EqTHWnxPTvseGvG
	8Bb2gOWQGefgESflqY36WWBgjOVkFjDZcN7EpLLykYrxaMSEljxPRdjyxToLXtHOJHQmyb
	VtUBzBjpeHTgM6OH39KR+055zB/xogc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787063275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtxWyVcD4k4OSKeBM7VkgBLU+VO11ooDqMtTDibnhG0=;
	b=a8FJfeSbxk/4lz7bpEJtzJdIiTtfjWyq3nvKaQp4ikVBZhNRrQGLBMNtzI8bqq6uZXaoy0
	lMPbOfkoc3paIBDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3MmVRBWn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=74LQIP2q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787063271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtxWyVcD4k4OSKeBM7VkgBLU+VO11ooDqMtTDibnhG0=;
	b=3MmVRBWnwnmWz1bAav5lZW2s9e/Em/xoU8jWppRWoZRCLXQiRqv7GF7vneCAGLq4bOaiy3
	tL7zKcPRGe0JGWGqTioV+L3tEg6+Q3Dt3BzczstMAMPJuFt+k7yaxEy3VWUKts/Gh/fkSv
	5Td4nY0LL4j4amPNXZ3/MrTeeCTLWcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787063271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtxWyVcD4k4OSKeBM7VkgBLU+VO11ooDqMtTDibnhG0=;
	b=74LQIP2qBKmBB59l3XtMg6HlBTujpe9G88u6g+ou1xwu2qCIEYzmr6Od8KHIwRljN45Sw1
	h9FIHr4ITXXuuLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 060A3339C;
	Tue, 18 Aug 2026 14:27:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LM50AedrhGpmfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Aug 2026 14:27:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C3B9A13AB; Tue, 18 Aug 2026 16:27:42 +0200 (CEST)
Date: Tue, 18 Aug 2026 16:27:42 +0200
From: Jan Kara <jack@suse.cz>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: fix comment typo in inode.c
Message-ID: <ggiji43bphyef2b6kn2lzh5hce6e7cxfh5tlai6hgjvgm53ym4@q4cqw2lxpp7z>
References: <20260813093603.1971-1-manushprajwal555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813093603.1971-1-manushprajwal555@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 17EAF3E35
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Thu 13-08-26 15:06:03, Manush Prajwal wrote:
> Fix "funtion" -> "function" in find_inode_nowait()'s comment. No
> functional change.
> 
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 31c5b9ee3a..059094e40a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1775,7 +1775,7 @@ EXPORT_SYMBOL(ilookup);
>   * function must never block --- find_inode() can block in
>   * __wait_on_freeing_inode() --- or when the caller can not increment
>   * the reference count because the resulting iput() might cause an
> - * inode eviction.  The tradeoff is that the @match funtion must be
> + * inode eviction.  The tradeoff is that the @match function must be
>   * very carefully implemented.
>   */
>  struct inode *find_inode_nowait(struct super_block *sb,
> -- 
> 2.46.2.windows.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
