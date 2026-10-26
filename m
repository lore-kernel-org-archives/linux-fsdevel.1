Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018221;
	b=fbJuw/6dJTf8WM3ARaX/XNhmap59HjAso4HD+nU5iHlaijYQ+YT0MavhZAiNyw/zkU04
	 PhRp2GOLC6cix9DcF6vR8kHDFpd2loinkRocHoxkW7E5FNpALywmwg3LIMWewLr+0hOe9
	 MIIuNsJAp05Bur4qQdgs+uBxkatnIFsAtgPSU0/UPCNHJTLazTxoqlPlYoGntIrizJgSj
	 cvEqPEMT6XNPk86S7Yy7TEycCn6E84FOAzCwkbP1JnwRUZeDGwyGaZ3Bz3NP4kaDcdmsD
	 KfVmXdOEewCISGPslfWnd45Cp7AoM9jCV3VDG5imE+cPUpMO2LJSX8EYemif0GS1naA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018221;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=IapZrkFbN6yZwsYwvNZV/1EXOBGEAI4iKHYi+uhMbcw=;
	b=UoPR9B6eR4/gFrnfuXCizj9efJFHdulKpeTs9LvKbUDLY1oxKRkCakRVoPy53RA+W0pN
	 3XFv6WPg2UiNNaP+o2mhSPiaKK0SA7ghmE5os3q+6p0nujinPwqmtS5I1h/AioNCAL/A0
	 cladgL0v0TRlOInhimNDKX7Sc8XtWXdZHkRiX2Yi5dFq3CRyVnoyObtOoUr7cljRtnBbp
	 ODrAyFMXQaH0DLKUtErekcRes7JjAqTRAxrGvJmIwBmn7MsueVPjFsjDZDuRuAsH2iHWo
	 HLXg7r5JpRzJ9T6eMvUE4roP9aZdKBzJk6NwI+BAfZUg+w0k+/lJ/isM5EQSHihepvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FHN+IrQ2;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=43GhXORS;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FHN+IrQ2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=43GhXORS;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534F606A32A;
	Mon, 26 Oct 2026 12:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3534F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FHN+IrQ2;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=43GhXORS;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FHN+IrQ2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=43GhXORS
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49F1221F14;
	Mon, 26 Oct 2026 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IapZrkFbN6yZwsYwvNZV/1EXOBGEAI4iKHYi+uhMbcw=;
	b=FHN+IrQ20ZBglpHxGfQrW4Y+0ICqCyEG6zdiE83qL/vIZbN+oORyOuCH/74SCCnN+P0KWs
	I/CjzemDjjXOJAGh0dVTdKRiRewj5am00ENCvJnASo27LjTEpfieGE9BdIMvMq8SAKNM0Q
	JVYqQ2zXynxPKggzM7yuo06qk/RhQiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IapZrkFbN6yZwsYwvNZV/1EXOBGEAI4iKHYi+uhMbcw=;
	b=43GhXORSrj5vdJ71hVP4L+mwqWQs8zmm+tFVdHd3tr7WbvA6nFW2r+fM8eThjIqExQ1TPi
	hLZhR77IotezSVDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IapZrkFbN6yZwsYwvNZV/1EXOBGEAI4iKHYi+uhMbcw=;
	b=FHN+IrQ20ZBglpHxGfQrW4Y+0ICqCyEG6zdiE83qL/vIZbN+oORyOuCH/74SCCnN+P0KWs
	I/CjzemDjjXOJAGh0dVTdKRiRewj5am00ENCvJnASo27LjTEpfieGE9BdIMvMq8SAKNM0Q
	JVYqQ2zXynxPKggzM7yuo06qk/RhQiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IapZrkFbN6yZwsYwvNZV/1EXOBGEAI4iKHYi+uhMbcw=;
	b=43GhXORSrj5vdJ71hVP4L+mwqWQs8zmm+tFVdHd3tr7WbvA6nFW2r+fM8eThjIqExQ1TPi
	hLZhR77IotezSVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A479B13319;
	Mon, 26 Oct 2026 12:36:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pRbNH2NJ32oTQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 12:36:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A613A1419; Mon, 26 Oct 2026 13:36:51 +0100 (CET)
Date: Mon, 26 Oct 2026 13:36:51 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] quota: make quotactl_fd(2) killable on s_umount
Message-ID: <6brwbb4yrqgmndji5amhiz6uk4dwsqyq7ga6oxciokd3jo5akk@krzyvlsyc6zt>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
 <20261023-b4-s-umount-killable-v1-2-844a341ff1df@toxicpanda.com>
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
In-Reply-To: <20261023-b4-s-umount-killable-v1-2-844a341ff1df@toxicpanda.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,toxicpanda.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 23-10-26 20:39:31, Josef Bacik wrote:
> quotactl_fd(2) takes s_umount of the filesystem the file descriptor is on,
> exclusively to turn quota on or off and shared for everything else.  If
> the lock is held for a long time, by a syncfs(2) on a device which doesn't
> answer say, the caller sits in D state and can't be killed.  For the
> commands which write it does so holding write access to the mount.
> 
> quotactl(2) with a device can already be killed at this point, it gets the
> lock from user_get_super().
> 
> All that has been done by the time the lock is taken is getting that write
> access.  Use the killable variants, and drop it on the way out.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/quota/quota.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index f906e4fd3f0f..94e6407734c7 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -997,9 +997,11 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
>  
>  	sb = fd_file(f)->f_path.mnt->mnt_sb;
>  	if (quotactl_cmd_onoff(cmds))
> -		down_write(&sb->s_umount);
> +		ret = down_write_killable(&sb->s_umount);
>  	else
> -		down_read(&sb->s_umount);
> +		ret = down_read_killable(&sb->s_umount);
> +	if (ret)
> +		goto out;
>  
>  	ret = do_quotactl(sb, type, cmds, id, addr, ERR_PTR(-EINVAL));
>  
> @@ -1007,7 +1009,7 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
>  		up_write(&sb->s_umount);
>  	else
>  		up_read(&sb->s_umount);
> -
> +out:
>  	if (quotactl_cmd_write(cmds))
>  		mnt_drop_write(fd_file(f)->f_path.mnt);
>  	return ret;
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
