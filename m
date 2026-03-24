Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D822261B71
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360027; cv=none; b=ErKBuKZvD9EBI2eNo2xL9pldyKHPKknt3eroXXS0KVRFPUYTwgjht/xNDzcJLmYQ7YFtaIDiajWkHiNWpRS5i13wJFY+N6zaOdQes7CXEr2lIZwAraVxqnhs7o52dng9dfQ9oCJv0lEAOCkXZw7YAZGofokTeNlfpTsj8NCwroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360027; c=relaxed/simple;
	bh=GZDPSJK4BGrgclngqLsOiPnRtJDY+Y63O745+iApqjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W25YBBKpEgv4YSM12Gmv7yw5J/m2Ppz6GgXMLoZgP8wI5wIKDbIPMaMk/yQyhD7lpNH64Ag5tU87xT0m4fcdC6BN+kGisXl8JmDnZ77+Tq9dcO2XHTQEXefCmDU1gBbvr7Qm2Uw1iwRV+tZeRF1cM+N7VRzJw+9MC+CGVuu5nD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=grG0rRGQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q2r/7MtT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SVntJyeR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mtNPsWaY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="grG0rRGQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q2r/7MtT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SVntJyeR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mtNPsWaY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 037415BCEB;
	Tue, 24 Mar 2026 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774360024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZ8XaIcbcS3gsBVApx8xsMBe+Uhtsty5+TnjaVhqvRM=;
	b=grG0rRGQOPhkmll8THfXDq5XriNaRRkCU3217/EggysM4T1hQzKBNfHS/jfbrFanMpfvKt
	/jb5Pb3bQ91vsyK8OsKxiGn87J5hHcBrpl0KI+s/Zmlu9Lqbx9RJlE8maQYWdD+yYG2NYI
	nU/fTVweRd6fGOxaEHbrdjRCvFvdzh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774360024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZ8XaIcbcS3gsBVApx8xsMBe+Uhtsty5+TnjaVhqvRM=;
	b=Q2r/7MtTi8sndxTOA9MAG9Zxlh7InDkz9V31DKfO9yt3OsKAO27zG4ywHrXASVMxy9+Gj9
	2dLgqQTCOmxwxMAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774360023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZ8XaIcbcS3gsBVApx8xsMBe+Uhtsty5+TnjaVhqvRM=;
	b=SVntJyeRYmEoxCMNL/xRKPtuUtD36srCFUEAhqceARJ/c1/VDiJ094KwXLu+kl7yEqrMiP
	7neXehNGgdq0rk7GsxrCaI5Hp5/5GOQRpO28feROGP6D+oLOdd95oto33vvgb4GssIeFtK
	vjQLiO4bihlul+9t2umAiEEKx4EhPE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774360023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZ8XaIcbcS3gsBVApx8xsMBe+Uhtsty5+TnjaVhqvRM=;
	b=mtNPsWaYXtTsrmoVNvHZ99HtxgHzh4aWNYJTMFlXVqMTxss+7WHWv1hiPEEDkDyKKab9zG
	eKCjF3SwDSJwS2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED50A43E80;
	Tue, 24 Mar 2026 13:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jKjfOdaVwmnSPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Mar 2026 13:47:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ACA43A0B32; Tue, 24 Mar 2026 14:46:58 +0100 (CET)
Date: Tue, 24 Mar 2026 14:46:58 +0100
From: Jan Kara <jack@suse.cz>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	David Laight <david.laight.linux@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] readdir: Introduce dirent_size()
Message-ID: <6iwtsxdgu7qd3lwtsbiu2itldr7ofkysx2lbfzxivn266eocnn@lggfct55zvpj>
References: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux-foundation.org:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,linux-foundation.org,linutronix.de,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Tue 24-03-26 12:41:15, Christophe Leroy (CS GROUP) wrote:
> In several places in readdir.c there are calculations of the total size
> of a dirent, which contains a few fixed fields plus a name field with
> variable size. To add fun every dirent is of a slightly different type:
> - struct old_linux_dirent
> - struct linux_dirent
> - struct linux_dirent64
> - struct compat_old_linux_dirent
> - struct compat_linux_dirent
> 
> Replace ugly size calculation by a macro called dirent_size() which
> calculates the size of the structure based on the pointed type and
> the name field len.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/readdir.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 73707b6816e9..fb910dc2f52b 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -22,6 +22,8 @@
>  #include <linux/compat.h>
>  #include <linux/uaccess.h>
>  
> +#define dirent_size(dirent, len) offsetof(typeof(*(dirent)), d_name[len])
> +
>  /*
>   * Some filesystems were never converted to '->iterate_shared()'
>   * and their directory iterators want the inode lock held for
> @@ -198,9 +200,7 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> -	if (!user_write_access_begin(dirent,
> -			(unsigned long)(dirent->d_name + namlen + 1) -
> -				(unsigned long)dirent))
> +	if (!user_write_access_begin(dirent, dirent_size(dirent, namlen + 1)))
>  		goto efault;
>  	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>  	unsafe_put_user(offset, &dirent->d_offset, efault_end);
> @@ -263,8 +263,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
>  	struct getdents_callback *buf =
>  		container_of(ctx, struct getdents_callback, ctx);
>  	unsigned long d_ino;
> -	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
> -		sizeof(long));
> +	int reclen = ALIGN(dirent_size(dirent, namlen + 2), sizeof(long));
>  	int prev_reclen;
>  	unsigned int flags = d_type;
>  
> @@ -352,8 +351,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
>  	struct linux_dirent64 __user *dirent, *prev;
>  	struct getdents_callback64 *buf =
>  		container_of(ctx, struct getdents_callback64, ctx);
> -	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
> -		sizeof(u64));
> +	int reclen = ALIGN(dirent_size(dirent, namlen + 1), sizeof(u64));
>  	int prev_reclen;
>  	unsigned int flags = d_type;
>  
> @@ -460,9 +458,7 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
>  	}
>  	buf->result++;
>  	dirent = buf->dirent;
> -	if (!user_write_access_begin(dirent,
> -			(unsigned long)(dirent->d_name + namlen + 1) -
> -				(unsigned long)dirent))
> +	if (!user_write_access_begin(dirent, dirent_size(dirent, namlen + 1)))
>  		goto efault;
>  	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
>  	unsafe_put_user(offset, &dirent->d_offset, efault_end);
> @@ -519,8 +515,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
>  	struct compat_getdents_callback *buf =
>  		container_of(ctx, struct compat_getdents_callback, ctx);
>  	compat_ulong_t d_ino;
> -	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
> -		namlen + 2, sizeof(compat_long_t));
> +	int reclen = ALIGN(dirent_size(dirent, namlen + 2), sizeof(compat_long_t));
>  	int prev_reclen;
>  	unsigned int flags = d_type;
>  
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
