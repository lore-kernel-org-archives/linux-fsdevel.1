Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769D348C6E
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802295; cv=none; b=STb9r/ZH4UGo11bgV3PpLqpacPKs8+Z0Y61MQjZ1Lpda/aokw+EfdUMjXsI7P/3hMIT5Ruk0XVTPQr6az7NM1PmXxv0aKyX2cubAX7zVBvrvEwYkLqGeZM8vkCo80QeMiG3na8Fif5JVRDybADVrZ6BPmioRF36jWr3QhJPfaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802295; c=relaxed/simple;
	bh=ylqouAEifbmXQFC1TeUzLkmMyFrCkNCnOiplDZTJX/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPWhHGKDoa7+Hzyec8szPyLF7v05s6kEtqI93M3PWS+Z4xK12K7yOhjfnXdpWyB1fk5rrXXBOgRulAOzkyJTc6erN1ODNtTLKUnjWuEusTI1ujPEP4s6ApNep5cJEav7iQTVuWY63Jt0wYqD7bmzm3dXgZrEL+rPNykvTUJ8e50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MaWMxVaj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/mzRymC6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MaWMxVaj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/mzRymC6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MaWMxVaj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/mzRymC6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MaWMxVaj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/mzRymC6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3568675EA9;
	Thu, 18 Jun 2026 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781802291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qc1yOiecTR15B4cPIIBnuy8hTfr8/7VbQTJZphQlU8M=;
	b=MaWMxVajctpo+e03XvkpMc1KsblkLrkuvVYXgwJJnKeTY9h+4TpTLQel6SMPT3Iyz9EjUa
	Vh3KDeNHuLpdrjqoPsjjWWC8NgBzKz0o2Fib+I0lxUebFbFl1SmrbtXp5SwcOXLXw75+SJ
	uaCxzhxoNOIh+VJWQwlme0FlgujGg9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781802291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qc1yOiecTR15B4cPIIBnuy8hTfr8/7VbQTJZphQlU8M=;
	b=/mzRymC6CuqoPn33ez3AINVbNHDpZcfz23XpkTgetQYwR9Y3Ci3/aXK/gWaC+NZHrtGJWG
	4xlNNzeKi3wedHDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781802291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qc1yOiecTR15B4cPIIBnuy8hTfr8/7VbQTJZphQlU8M=;
	b=MaWMxVajctpo+e03XvkpMc1KsblkLrkuvVYXgwJJnKeTY9h+4TpTLQel6SMPT3Iyz9EjUa
	Vh3KDeNHuLpdrjqoPsjjWWC8NgBzKz0o2Fib+I0lxUebFbFl1SmrbtXp5SwcOXLXw75+SJ
	uaCxzhxoNOIh+VJWQwlme0FlgujGg9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781802291;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qc1yOiecTR15B4cPIIBnuy8hTfr8/7VbQTJZphQlU8M=;
	b=/mzRymC6CuqoPn33ez3AINVbNHDpZcfz23XpkTgetQYwR9Y3Ci3/aXK/gWaC+NZHrtGJWG
	4xlNNzeKi3wedHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14C58779A8;
	Thu, 18 Jun 2026 17:04:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id itwMBTMlNGpDNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Jun 2026 17:04:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47F41A12D7; Thu, 18 Jun 2026 19:04:50 +0200 (CEST)
Date: Thu, 18 Jun 2026 19:04:50 +0200
From: Jan Kara <jack@suse.cz>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] minix: avoid overflow in bitmap block count
 calculation
Message-ID: <ibmq7hygpgsyyjbdhhah5sv7lpcoh3zlkyp7fw6aeacwrfnwgo@7yf3puqhzxfn>
References: <20260618143922.3066874-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618143922.3066874-1-michael.bommarito@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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

On Thu 18-06-26 10:39:22, Michael Bommarito wrote:
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
> The divisor is the bitmap capacity in bits, blocksize * 8, which is
> always a power of two: minix_fill_super() obtains the block size through
> sb_set_blocksize(), and blk_validate_block_size() rejects any size that
> is not a power of two. Use DIV_ROUND_UP_POW2(), which divides before
> adding the round-up term and so cannot overflow for a power-of-two
> divisor.
> 
> Fixes: 8c97a6ddc956 ("minix: Add required sanity checking to minix_check_superblock()")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> Changes in v2:
> - Use DIV_ROUND_UP_POW2() instead of widening the helper to 64-bit
>   arithmetic (DIV_ROUND_UP_ULL, v1). The divisor blocksize * 8 is always
>   a power of two, so this is the more obvious fix and keeps the helper's
>   original types, per Jan Kara's review.
> 
> Link to v1: https://lore.kernel.org/all/20260617215740.1116778-1-michael.bommarito@gmail.com/
> 
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
>  fs/minix/minix.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index f2025c9b58252..9e52d4302f0d2 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -97,7 +97,7 @@ static inline struct minix_inode_info *minix_i(struct inode *inode)
>  
>  static inline unsigned minix_blocks_needed(unsigned bits, unsigned blocksize)
>  {
> -	return DIV_ROUND_UP(bits, blocksize * 8);
> +	return DIV_ROUND_UP_POW2(bits, blocksize * 8);
>  }
>  
>  #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
