Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAE3C5DDE
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767720; cv=none; b=PZQRiY5mHIOnptswmW2iPkNWIjb6egpo3HGmW3cQGEbMglcDjojBAcXgrcn7knzGRtw/nR+d4LEG8D0XcsO6PODGLGIu+IhEUAUY93AsuHz2Q/1c3mB7RM3Bwdpb7Ojd9ExGrCoJCRP2hzl+DbfUXdTBR1K1Ih8RzByOv5CQk14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767720; c=relaxed/simple;
	bh=jZ5U0WoOkXufnBSzCpN3eP23KMrB0f5BZEW5aumZLDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXKpXEPadiRURBLFtEt8x3+dZjOTGnQ39SYu1mJ5EsPt4gzrHZss+KDJQfItyin2KrxoAOPxeevwyA1Ag6dzrjp1h8yijcbdNe7tVUFggwPquqnrGoABInzGwgJYN3HP87jMeQz8IHthfL2Cb+B+Xs6xYyLov14Bh4vHQIKyNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=at7wdnFP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVxREry+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CxpLU6Z/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MqyA/q3h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="at7wdnFP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVxREry+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CxpLU6Z/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MqyA/q3h"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4204275F14;
	Thu, 18 Jun 2026 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781767717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dp6Yoh3VZc/o+XiBeT2zk9IVYLYst/3xfRaVGswqDic=;
	b=at7wdnFPgnYO2lyWzLGWZCnkPXn0VsRYcNq7svN6F3zRUMT3NXx1yKUFW+Rc6iyYJwhySi
	UVUn0RDMTxENUWffySegNBzwIYAeGUQJihk7++Nnbpi31Gr4N0P453Yt+gdvLXnpsycN58
	siqbsxHvEqLnYRJ5MtxXq3TbyHfb1nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781767717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dp6Yoh3VZc/o+XiBeT2zk9IVYLYst/3xfRaVGswqDic=;
	b=ZVxREry+Lhm8+cm7X7agmjkWjUNxoxu4FDBBFIEBlI6wf0H3mwzua1eusbsxUYcO66k8xI
	AbfiKEPLx+GQxECQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781767716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dp6Yoh3VZc/o+XiBeT2zk9IVYLYst/3xfRaVGswqDic=;
	b=CxpLU6Z/+ma3cjv2iLbLdx9zxFCZJ0ua/DhFeE52RfX5xZ71iEtBHa7beMGw6l9d+ktsey
	rmq09QkVxOiutZ984zN6YBQQ4nI+/S/XQirZnW5l32JGAyFfb8/XD8nDtLKLOjvSE+u9K4
	NYBLkK0tyODfbwFU2qCJEl7GKKtrT7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781767716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dp6Yoh3VZc/o+XiBeT2zk9IVYLYst/3xfRaVGswqDic=;
	b=MqyA/q3hqFtHp0oy3g9LyTKY09TZbDoeCfk0AlN5VXa53E3lUD522CL42J6tRNro9pesvO
	lKkrU653u8BDnKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33181779A8;
	Thu, 18 Jun 2026 07:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pxh7CySeM2qHcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Jun 2026 07:28:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE5C9A0EC0; Thu, 18 Jun 2026 09:28:35 +0200 (CEST)
Date: Thu, 18 Jun 2026 09:28:35 +0200
From: Jan Kara <jack@suse.cz>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minix: avoid overflow in bitmap block count calculation
Message-ID: <z2trp3tdvufahohybeteuprexxjdhq2olymutxtpeausnb4nc6@pvqf2fw32n3s>
References: <20260617215740.1116778-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617215740.1116778-1-michael.bommarito@gmail.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -2.30

On Wed 17-06-26 17:57:40, Michael Bommarito wrote:
> minix_check_superblock() uses minix_blocks_needed() to verify that the
> on-disk imap and zmap block counts are large enough for the advertised
> inode and zone counts.
> 
> The helper currently performs DIV_ROUND_UP() in unsigned int arithmetic.
> A Minix v3 image can set s_ninodes or s_zones near UINT_MAX so the
> addition inside DIV_ROUND_UP() wraps to zero. That makes a zero imap/zmap
> block count look valid, after which minix_fill_super() can dereference
> s_imap[0] or s_zmap[0] even though no bitmap buffers were allocated.
> 
> Impact: mounting a crafted Minix v3 image whose s_ninodes or s_zones is
> near UINT_MAX makes minix_check_superblock() accept a zero bitmap-block
> count and minix_fill_super() dereference s_imap[0]/s_zmap[0], panicking
> the kernel.
> 
> Calculate the required bitmap block count with 64-bit arithmetic. Return it
> as unsigned long to match the superblock fields and local comparison.
> 
> Fixes: 8c97a6ddc956 ("minix: Add required sanity checking to minix_check_superblock()")
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Hum, I think this is what DIV_ROUND_UP_POW2() was invented for so using
that might be more obvious?

								Honza

> ---
> Testing: integer overflow (no sanitizer); the oracle is the downstream
> NULL/ZERO_SIZE_PTR dereference crash.
> 
> Reproduction (UML mount, same crafted image, before/after): a Minix v3
> image is crafted with s_ninodes near UINT_MAX so DIV_ROUND_UP(s_ninodes,
> blocksize * 8) wraps to zero, then mounted from /dev/ubda by a one-line
> init.
>   stock:   RIP: minix_fill_super+0x3f6/0x5c3 ; Kernel panic - not syncing:
>            Kernel mode fault at addr 0x10 (ZERO_SIZE_PTR deref of
>            s_imap[0]); UML exit code 134.
>   patched: "MINIX-fs: file system does not have enough imap blocks
>            allocated. Refusing to mount." / "bad superblock"; mount
>            fails cleanly, no crash.
> A KUnit case additionally asserts minix_blocks_needed() no longer wraps
> for near-UINT_MAX inputs; both run on stock and patched.
> 
> Conditions: CONFIG_MINIX_FS=y and an attacker-supplied Minix image is
> mounted (CAP_SYS_ADMIN in the mounting namespace, or a removable-media
> automount path). v3 only: s_ninodes/s_zones are 32-bit; the v1/v2 16-bit
> fields cannot reach the wrap.
> 
> Mitigations: do not mount untrusted Minix images; most distributions do
> not enable CONFIG_MINIX_FS. No sysctl toggle.
> 
> Harness (init script, crafted image, KUnit) available on request.
> 
>  fs/minix/minix.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index f2025c9b58252..8dc83f80bd768 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -95,9 +95,10 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
>  	return container_of(inode, struct minix_inode_info, vfs_inode);
>  }
>  
> -static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
> +static inline unsigned long minix_blocks_needed(unsigned long bits,
> +						unsigned int blocksize)
>  {
> -	return DIV_ROUND_UP(bits, blocksize * 8);
> +	return DIV_ROUND_UP_ULL(bits, blocksize * 8);
>  }
>  
>  #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
