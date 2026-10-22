Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669283;
	b=pntzR2lDB8Ds/Bvf08Kyy+j1GW/ctteF+bE9oNncAsFtqh7ldJYA4NF4NZPF22iTrB8Y
	 d8eIoAxzojP4L6QJbRt7Rt34STKZ50AM1Ept0XMCRfq1Rq/eWcTdyAsiEzqNltXS6JdMe
	 +Ma9TqHs4EuuYYhvhM0huLOcK8PIde3CvecPTuK0uI3gtl0lNtXbpVRQ6NLZkG2U1X9Cm
	 k3YyDNPltbwoILnVSf2Lg3Mr7XcId9BlvCFhJZ4oFIi7D100GCTNHadWd5FF8Gg1ywETu
	 JUXlxOJLJTU/11ZQosfvTtjTNzaxPP5980vbDo02indf8iDWWLtmpPboaqPhdpT2O1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669283;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=O/GpDnaCAHI1nEQpDM/+W22P17N3Zfe9ncy6nDWopbc=;
	b=LTOJDIfhZLMfdIna7hjE8qna53oZrnfiRY+KywkjGXlTjAG9U8d1KGSUTAPn5LKIOKSN
	 WeL3r28lVEgKFg6nf3ReJGKRc/SmWsDzKNetUE16YiU1ggyLl25FqThfebRDs38JOMtJS
	 VmP0a1PArjnYnqXz7aDMX2JCQYixyaRJtNQVkPHDcZiJKxNOG7v8a3A4g663JTz2njF1L
	 qL7wV9HEqogIulz0oifsRl7CQsd0I8nKOqbtUut7VE8QUPo41qqQVh6DJnmEH0WTnqfuU
	 JUEoo9MKLqY7YSQU/WLksfKY6xe6xwmnJCz8y1hl3pp9o3tpmiuAVcCf7r1yws+mmPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="2/Sn/1ht";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P9faRgZp;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="2/Sn/1ht";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P9faRgZp;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C424606A32E;
	Thu, 22 Oct 2026 11:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C424606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2/Sn/1ht;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P9faRgZp;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2/Sn/1ht;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=P9faRgZp
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 59AD11F44F;
	Thu, 22 Oct 2026 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792669281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/GpDnaCAHI1nEQpDM/+W22P17N3Zfe9ncy6nDWopbc=;
	b=2/Sn/1htdzOt5TFoNdLvkUshpu5nvgf7frD3x0+p4NDIECzHZmp8NhFuq1eKT8XRPRbf3g
	6q2Jv6QwbOmaQ2Xw9UlpH0RoLVTxNFc7YfCdZB8RzmfqkzsIAS31OnALsLsRDcQMlYpmBq
	v1tDSxKVl7fPTlBvO9S1slbBrzcphSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792669281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/GpDnaCAHI1nEQpDM/+W22P17N3Zfe9ncy6nDWopbc=;
	b=P9faRgZp30Re2WVWhtWTgXPEXnvIJMCThYCeJ8d0OzbLi88mh4fnX415W8cCdM1hnf2VRl
	GKolWNtFzfweKVAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2/Sn/1ht";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=P9faRgZp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792669281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/GpDnaCAHI1nEQpDM/+W22P17N3Zfe9ncy6nDWopbc=;
	b=2/Sn/1htdzOt5TFoNdLvkUshpu5nvgf7frD3x0+p4NDIECzHZmp8NhFuq1eKT8XRPRbf3g
	6q2Jv6QwbOmaQ2Xw9UlpH0RoLVTxNFc7YfCdZB8RzmfqkzsIAS31OnALsLsRDcQMlYpmBq
	v1tDSxKVl7fPTlBvO9S1slbBrzcphSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792669281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/GpDnaCAHI1nEQpDM/+W22P17N3Zfe9ncy6nDWopbc=;
	b=P9faRgZp30Re2WVWhtWTgXPEXnvIJMCThYCeJ8d0OzbLi88mh4fnX415W8cCdM1hnf2VRl
	GKolWNtFzfweKVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31650133F3;
	Thu, 22 Oct 2026 11:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ngQmA2H22WqxdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 11:41:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B243EA1417; Thu, 22 Oct 2026 13:41:16 +0200 (CEST)
Date: Thu, 22 Oct 2026 13:41:16 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] fs: make ustat() and quotactl() killable in lookup
Message-ID: <m5vkae2g7dj43dyktfvexwdhjkfvbatyykbqaigyjtcwkagood@e7buwoogjqhy>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
 <20261021-b4-super-lock-unborn-v1-2-0265eddb6dee@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-unborn-v1-2-0265eddb6dee@toxicpanda.com>
X-Rspamd-Queue-Id: 59AD11F44F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01

On Wed 21-10-26 16:46:58, Josef Bacik wrote:
> user_get_super() looks up the superblock for a device number on behalf of
> ustat(2) and quotactl(2).  If that superblock is still being mounted it
> waits for SB_BORN, and then for s_umount, in super_lock().  With a mount
> which is stuck on its device neither system call ever returns, and neither
> can be killed.
> 
> Both fail if there is no superblock for the device, which is what
> user_get_super() returning NULL means to them.  Use super_lock_killable()
> and return NULL when the task is killed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 7164c92fe70e..40f92ffa39c1 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1172,9 +1172,15 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  
>  	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
>  		struct super_block *sb = sb_dev->sd_sb;
> +		int ret;
>  
> -		if (!super_lock(sb, excl))
> +		ret = super_lock_killable(sb, excl);
> +		if (ret == -ENOENT)
>  			continue;
> +		if (ret) {
> +			super_dev_put(sb_dev);
> +			return NULL;
> +		}
>  
>  		/* The pinned entry holds a passive reference, take our own. */
>  		refcount_inc(&sb->s_passive);
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
