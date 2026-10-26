Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018139;
	b=z9dDg31UCBIoDuyVWGJ8QJmPr1q2ok4t0tm3tBuU9lSyaYUPLV+6KVRZ4eOzjSZ92nfV
	 oXoRMnWPzeSmQNn6oBT0jGRQAROnQwlBYAPO83Yp4Yd/pGYOnDKuxShtVIFU0FaNxv6l2
	 2SgAJLZQJv2DodJi7c28QteW9Jq1e7EjiqCgZKNpXwUyH0PUVfhf4xISUKngsbpRaP4DZ
	 m6dY9OhjgQHu7zNsEKNzDcbJ3z4hKtYWac3AVuZfL36v06SUAA40Yz1og2zGr5+GU3F20
	 a5d2lp+V2yd+TZC32h/1jP6TtcLU8fN+39VeEIsJ2+uldGgTAz81rCeXUTbCGtN0TOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018139;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=vP4YYUTd+qzB0M7omJe34s6ZhLhGI8ydxKduc6nJvsA=;
	b=rjqO40yXM/+kreE8lRy2+k7gPB1Pn1Xa6SklHkUASxc4B+S5s4WszFbmC1VXhdaqI+5f
	 OngTHq87t/Y/0VEdg/o6/tB4+eC3gP1xWVkmORj94DgNv0KF74zb3TlHlWNCvlYVIsuFq
	 1U7tKYFb99iBehTyu20wfGlcwYeoXc/5ErPYaPoEep+3QctPKZWfSwklTS/GsXIY7F5Sc
	 zEUkuqUGsPfWmg8o421TdwZnA7NqR3eGs+hzMybpbeDNg+WNlg2k7uoG/mwbJrf71IumL
	 4fJueLSxh0Lnf1KOci6QzGNdHiEmHpUoe3THe35DSzbpZr9nF0yp593PmdqkvITwwtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HK2N8+wJ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WwUX9x8B;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=nII1Vmup;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3bZEomBd;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442A606A31B;
	Mon, 26 Oct 2026 12:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1442A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HK2N8+wJ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WwUX9x8B;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=nII1Vmup;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3bZEomBd
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 221871F7A1;
	Mon, 26 Oct 2026 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP4YYUTd+qzB0M7omJe34s6ZhLhGI8ydxKduc6nJvsA=;
	b=HK2N8+wJIxbPeI1BQrawPYdkfgUEzZdhuQI/vjH5n6Cg857waggzcnEASs1Da6XhuowXWb
	2WS3LkHzEORt/2kCT9jw5Dm9joJaLZmsyhMaaoIMj2SsHnfJCKhjgfNrQejJ9fW8ERwVji
	QY8xV2ueSGwvmj9y1ClpNut/kzI0T/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP4YYUTd+qzB0M7omJe34s6ZhLhGI8ydxKduc6nJvsA=;
	b=WwUX9x8B9Fn9Yq95HtbhHcCMDINnQnSx5L+F8uc0DcHKX57eq2G93SimSNg3PZoEkjtGmS
	NXE407b45I1EhXDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nII1Vmup;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3bZEomBd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP4YYUTd+qzB0M7omJe34s6ZhLhGI8ydxKduc6nJvsA=;
	b=nII1VmupP4FF6JYsyCYIjJ3OZVBEkg8fvoAJHUF6IZic67yPR2+OtfQpi2PjFgRXnJSeFa
	Ni89Hab8YNvsOVlNRsn0FGyMGg64l869rFX04VnpbFoNVkWcLm35rvzJniSnwrlW7Q39+j
	LH2lfJu4hdpOhQLZu2vINxflxyuQKsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vP4YYUTd+qzB0M7omJe34s6ZhLhGI8ydxKduc6nJvsA=;
	b=3bZEomBdzzyUepgs7o7LdZWBOKtbhBCo6tVed0DZlUAO1Rj/IjmlNionZjD+vxRM+dN4p5
	Si0RIwDy8mkr70Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDC7B13319;
	Mon, 26 Oct 2026 12:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k4XzMRdJ32okPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 12:35:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 730B5A1419; Mon, 26 Oct 2026 13:35:35 +0100 (CET)
Date: Mon, 26 Oct 2026 13:35:35 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] fs: make syncfs(2) killable on s_umount
Message-ID: <sxq7j7eeetrgbhcogf7orm76oxggtulfbhx5umc4k6v3jfmrz6@bns6uybd5jkj>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
 <20261023-b4-s-umount-killable-v1-1-844a341ff1df@toxicpanda.com>
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
In-Reply-To: <20261023-b4-s-umount-killable-v1-1-844a341ff1df@toxicpanda.com>
X-Rspamd-Queue-Id: 221871F7A1
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01

On Fri 23-10-26 20:39:30, Josef Bacik wrote:
> A syncfs(2) which has to wait for s_umount sits in D state and can't be
> killed, for as long as whoever has the lock takes.
> 
> That can be very long.  Another syncfs(2) holds s_umount shared while it
> writes the filesystem out, which on a slow or dead device takes forever.
> That alone doesn't keep other readers out, but as soon as somebody wants
> the lock exclusively, a remount say, that writer queues up, and every
> reader which comes after it queues up behind the writer.
> 
> Taking the lock is the first thing syncfs(2) does and it can return an
> error, so use down_read_killable().
> 
> This only covers the wait for the lock.  Once syncfs(2) has it, it still
> waits for the writeback uninterruptibly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/sync.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/sync.c b/fs/sync.c
> index 0681bfcb2da6..ea54af59cf4a 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -156,7 +156,9 @@ SYSCALL_DEFINE1(syncfs, int, fd)
>  		return -EBADF;
>  	sb = fd_file(f)->f_path.dentry->d_sb;
>  
> -	down_read(&sb->s_umount);
> +	ret = down_read_killable(&sb->s_umount);
> +	if (ret)
> +		return ret;
>  	ret = sync_filesystem(sb);
>  	up_read(&sb->s_umount);
>  
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
