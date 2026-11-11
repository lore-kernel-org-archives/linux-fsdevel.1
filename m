Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406959;
	b=doKeV8OTjwYH6UQTRS2OKSOTs1oMfGncBLINlRc5CiQDpsmPzGRCH50dadldecb5m9aH
	 JnkzxLIBJYIOoB0yeeZ31DS71WVDDJ6FcPsWvfifsXI8Bb2h6le226u/18foYJsJdmQjx
	 0TY//iuemUDIymt7Kaq+ajZ2nzCMIofjHtyItl9AJ03bW/kgz3xCDiluA5Lo9yrGxQFz5
	 qw4/eoEu9UPnfVhT4bftgg3W7YkZuMOLqWPN7shTsHU6ZMCRFJQSY8Ge+LhpqYL2d3XWB
	 oIBr3HgjvdPXOTCqHVow5HgdIt3EMyrdHzW3dh5ux3a+G9iJfyiHIdPbJ0UVum8fF8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406959;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=JS5qcklH788a3feE2zFJsM5Z3VXXZpwSbc4kU/GZnJQ=;
	b=RyDJ9Qx0RwGEHYJjL75bJdwQyE1fGvRIxOPeTH5MQh44xP7GsF8TrH/Y3xC22tEnKZes
	 ZBMBbKw6c5ZSyS92jbCXeo/L8ndoNqC5l/QFGnwOVd54SNDQjvIJCSAYf2GHK641FrYTZ
	 grORPz97+8hp0koSu9yU9Jl+LCjIlYDejq+MxF/r0Hr8rGsBIfpBuSEgZ7+er5RzT3O7/
	 BvP2dUbmvbra4g4cfE7DrwIXsECXcBLybLaHCVW9sIZzyHD9JAvTyZOpsCzsYAwEu6vFX
	 fBCciJ4fWu8uaIZpmm1LnZLUBEpGKxJsNkA9IK7wQHFXXAU+jphQvPcA173aIN0Eovw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=s0tZyWPE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="Hy/odj4k";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=s0tZyWPE;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="Hy/odj4k";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C45606A327;
	Wed, 11 Nov 2026 14:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C45606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=s0tZyWPE;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hy/odj4k;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=s0tZyWPE;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hy/odj4k
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A2DF1FE5C;
	Wed, 11 Nov 2026 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794406957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JS5qcklH788a3feE2zFJsM5Z3VXXZpwSbc4kU/GZnJQ=;
	b=s0tZyWPEWuLA1iuPJcQqc3Fh2zmGXOwdyxcOEX+tZRm60Owsu9wDvzJypBDvsgaRp6SCps
	M3VRoixbDr1B4Bf/caubmio8LumrzfxPHGI4YVKZ7HCxgY8WuuMdGtEZARpQvnYYQZyOrO
	u7hFYlazY8qby6j/jxsUay2cMmhVsbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794406957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JS5qcklH788a3feE2zFJsM5Z3VXXZpwSbc4kU/GZnJQ=;
	b=Hy/odj4kgMLbCiIn5vCkCvcpIqw+0S9hshBkd7LKkwxhnWn4+Qg+oqPF0JBo37lTVRkpx2
	xMTh7Ijmdkor3rCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794406957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JS5qcklH788a3feE2zFJsM5Z3VXXZpwSbc4kU/GZnJQ=;
	b=s0tZyWPEWuLA1iuPJcQqc3Fh2zmGXOwdyxcOEX+tZRm60Owsu9wDvzJypBDvsgaRp6SCps
	M3VRoixbDr1B4Bf/caubmio8LumrzfxPHGI4YVKZ7HCxgY8WuuMdGtEZARpQvnYYQZyOrO
	u7hFYlazY8qby6j/jxsUay2cMmhVsbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794406957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JS5qcklH788a3feE2zFJsM5Z3VXXZpwSbc4kU/GZnJQ=;
	b=Hy/odj4kgMLbCiIn5vCkCvcpIqw+0S9hshBkd7LKkwxhnWn4+Qg+oqPF0JBo37lTVRkpx2
	xMTh7Ijmdkor3rCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13810134E5;
	Wed, 11 Nov 2026 14:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BZMNyx69GpKCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Nov 2026 14:22:37 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id A6DCC2293E; Wed, 11 Nov 2026 15:22:36 +0100 (CET)
Date: Wed, 11 Nov 2026 15:22:36 +0100
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH] fs: constify inode argument of inode_state_read_once()
Message-ID: <zzh3sqprta4o7f3ohkq4bsjuretryd7xkmdbjxkgsyhudou32s@ttreqt3jpa6q>
References: <20261111100148.3665035-2-aalbersh@kernel.org>
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
In-Reply-To: <20261111100148.3665035-2-aalbersh@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80

On Wed 11-11-26 11:01:49, Andrey Albershteyn wrote:
> Constify inode parameter so that callers can pass const inode. Callers
> do not need a change.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Fine by me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Notes:
>     I will have a user with const inode in fsverity
>     https://lore.kernel.org/fsverity/20261105115532.613467-3-aalbersh@kernel.org/
> 
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c..c5ba625c8ae1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -877,7 +877,7 @@ struct inode {
>   *
>   * We hide all of it behind helpers so that we can validate consumers.
>   */
> -static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
> +static inline enum inode_state_flags_enum inode_state_read_once(const struct inode *inode)
>  {
>  	return READ_ONCE(inode->i_state.__state);
>  }
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
