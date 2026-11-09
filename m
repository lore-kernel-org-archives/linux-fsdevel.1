Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230045;
	b=VNMc8frNbhLODVjDUpJnnUxTO2sVUbQDDphctEMQnhkrQsydXEKm4gZBVeGZC4GgRsO+
	 XzhZ7eZRai/ZTkMya+X75i924i32i/xmTJyMJOSgxuAQ1EMy64AIEshnigtoAas6dk3Q4
	 Tkm0QtmCelzluzdl+sKGdduYgdK8v9NLpJQJth4M2o9hDvgLiNyh4ONOGxnjTVGLCeDR4
	 Eb3dYXDyvUwnU5WvZfdclLVOBXJ2Qs19KavlRhdJYrGw+wdvxNSo9X9y0S0uWtbTXM0ro
	 yXnF5QbN/wZ+5HmioaoOS7EIuvK2CfYW8nzpA4W4uUFAK491GPaFsQE3XNNxzayJ88Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230045;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=6trJ9wczP37AYaNtcfH5XbErL0q3s27qFQESsRxGE2c=;
	b=oF3CIKx2Psh9Yzavac7L0yGWmv+3pB1tfwogGzF7rYhkBAAw5oE+9Os8fd1M+57ZVtDl
	 1P1hFnsnrdTY5pZAZxkee4EMWt4OqbPtDVeyjv/0F8s/Gt106GCOC9qfdjiSg9hCLcuL4
	 kQQW7E99K1oGxy1/MOBCnUskvhjbUuT5TLOrRebi0yPikAeKHEutXR4hYOQLAv/t9gCzO
	 l/VMUhVqqszqVYQZOrOr00hQ0KlqdElGmPc7x7SLyMrnD4T6Fx6EECv2incmgYMRjV7l+
	 lh0+gX9KRfUcXuO97LyTeM7HLlGRpTCESdOxuR6JChNQmQKduOn9/X9PvsZTVCC8Eiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YfMwmyns;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=x4IfSmHD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YfMwmyns;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=x4IfSmHD;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854D606A31C;
	Mon,  9 Nov 2026 13:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4854D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YfMwmyns;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=x4IfSmHD;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YfMwmyns;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=x4IfSmHD
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6452F21FBA;
	Mon,  9 Nov 2026 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794230043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6trJ9wczP37AYaNtcfH5XbErL0q3s27qFQESsRxGE2c=;
	b=YfMwmynsVNmYqIMTXypZWx+cwgIK9JHQUyosrPprP8O1k23y6eZd2/6lUnDDFDyuk63fCB
	EJqrtLwTc+aBwTxfMLvpCFd1Nfl05H3FNNA36VeRNmB5EPzpKjD7vQ4k/CUtuybV0PTKHi
	fdxgAQP+itQcMWgSz5gR0/3KSZRf844=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794230043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6trJ9wczP37AYaNtcfH5XbErL0q3s27qFQESsRxGE2c=;
	b=x4IfSmHDP9lqPIEJ454ik8hNStOUDM6BJeSzSf44VaXxugPML2kD0nbalRriIZBceyIyaT
	NUfTUqlzfhouZYCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794230043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6trJ9wczP37AYaNtcfH5XbErL0q3s27qFQESsRxGE2c=;
	b=YfMwmynsVNmYqIMTXypZWx+cwgIK9JHQUyosrPprP8O1k23y6eZd2/6lUnDDFDyuk63fCB
	EJqrtLwTc+aBwTxfMLvpCFd1Nfl05H3FNNA36VeRNmB5EPzpKjD7vQ4k/CUtuybV0PTKHi
	fdxgAQP+itQcMWgSz5gR0/3KSZRf844=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794230043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6trJ9wczP37AYaNtcfH5XbErL0q3s27qFQESsRxGE2c=;
	b=x4IfSmHDP9lqPIEJ454ik8hNStOUDM6BJeSzSf44VaXxugPML2kD0nbalRriIZBceyIyaT
	NUfTUqlzfhouZYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A8F713302;
	Mon,  9 Nov 2026 13:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5rosBhvH8WoRGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 13:14:03 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id C2AE02201A; Mon, 09 Nov 2026 14:14:02 +0100 (CET)
Date: Mon, 9 Nov 2026 14:14:02 +0100
From: Jan Kara <jack@suse.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/stat: reject invalid flags for empty paths
Message-ID: <euzvpi6nlgs5hc5oak3de2vi6e5u73jzz2bvwnxdkpzdxwftui@ngew7npmjq7v>
References: <20261108125617.2383285-2-thnkslprpt@gmail.com>
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
In-Reply-To: <20261108125617.2383285-2-thnkslprpt@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Sun 08-11-26 14:56:18, Avi Weiss wrote:
> vfs_fstatat() and statx() take the file descriptor fast path for empty
> paths when AT_EMPTY_PATH is set. These paths bypass the flag validation
> in vfs_statx(), allowing unsupported flags such as AT_RECURSIVE to
> succeed.
> 
> Return -EINVAL for unsupported flags in the vfs_fstatat() fast path,
> and validate flags in vfs_statx_fd() as is already done in vfs_statx().
> 
> Fixes: e896474fe485 ("getname_maybe_null() - the third variant of pathname copy-in")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2:
> - return -EINVAL directly for unsupported flags in vfs_fstatat()
> - validate flags in vfs_statx_fd() instead of changing statx()
>   dispatch (as suggested by Jan Kara)
> 
>  fs/stat.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index a2e63c6c45b7..3013e4ece011 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -322,6 +322,11 @@ static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
>  			  u32 request_mask)
>  {
>  	CLASS(fd_raw, f)(fd);
> +
> +	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
> +		      AT_EMPTY_PATH | AT_STATX_SYNC_TYPE))
> +		return -EINVAL;
> +
>  	if (fd_empty(f))
>  		return -EBADF;
>  	return vfs_statx_path(&fd_file(f)->f_path, flags, stat, request_mask);
> @@ -371,8 +376,12 @@ int vfs_fstatat(int dfd, const char __user *filename,
>  {
>  	CLASS(filename_maybe_null, name)(filename, flags);
>  
> -	if (!name && dfd >= 0)
> +	if (!name && dfd >= 0) {
> +		if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
> +			      AT_EMPTY_PATH | AT_STATX_SYNC_TYPE))
> +			return -EINVAL;
>  		return vfs_fstat(dfd, stat);
> +	}
>  
>  	return vfs_statx(dfd, name, flags | AT_NO_AUTOMOUNT,
>  			 stat, STATX_BASIC_STATS);
> 
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
