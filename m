Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F97476681;
	Mon, 12 Oct 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813828; cv=none; b=W/FeuzFUlPQ/SHe1yFiyFZ0N8jAjHGNfr6BGJISJ3mjs8sQmXkwehNN8HK+6XNo7cx0/H5SAK+T/ZbxRlVvznTN7Scs10/p6Ior3lyBVYAFU8vX++7akFnHJVCVSNr2aGAPtiSjmsBolFua804JELHNuXpdZwvtnm8nrsAcLUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813828; c=relaxed/simple;
	bh=+1QKd8Jr1KCnu4yXZZ3rmMeo9LPyc3brv++uan6aklA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIqK9L47uJroQZfJMGJdrwRNn6s6SP5lkh/UnbSMbdWwz0y+hehMaV6bd1TXcsFucN0v/p0wZF2xz1F460oLKEwky4EcZjdpYiXtPzBZlZyP+psfCDmSu+rHco7cATzX3CnUWS2vMALJmqcxqm4kThYmRPHm6WawmtXxXijzBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WUQUmKbW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O74MO2LT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YbZVSdZW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=19dypBJS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WUQUmKbW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O74MO2LT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YbZVSdZW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="19dypBJS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0742F21DF9;
	Mon, 12 Oct 2026 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791813825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMuzhFir/rTUnCzgemgYrRCOBUti0kDEikdV99mQG8c=;
	b=WUQUmKbWymjU5N8nE7wanBZv2alOdU7ykNv63GK+IgKkTXzEz4ldstZDu/0WKLlzZPVj2J
	dH+EvOwJdvtB02cJzXWe7KLUlL2OH4svy6Juf20hH1MtWrCsDlOGmrC/KTpBfNRdKyS3UD
	Vu6hadmfEylax0a+9VPqHXYrQ4Wp25M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791813825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMuzhFir/rTUnCzgemgYrRCOBUti0kDEikdV99mQG8c=;
	b=O74MO2LTqvjcm1xeNuhTSHKU+WrcrAbZeW3ymwtxg0i4V4jbP0g4AFm5sLinQqKAXO8i2E
	2Cxwo//YcA3z+xDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791813824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMuzhFir/rTUnCzgemgYrRCOBUti0kDEikdV99mQG8c=;
	b=YbZVSdZWDuxFHB4kSACBLFcxZxglS99yIYXCsx9LpR7PwmvButO4kzu0H+6SMMbcGDP6dX
	Q7VfPs/DgwNlU1seSl93K2cb5sXXgBpUn7lHWIrGAa3l/SlhLJGeXF5HcOm0adLHYB827K
	t4jP7pKsB7pWUjEb5cZJEOne3YdRzAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791813824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMuzhFir/rTUnCzgemgYrRCOBUti0kDEikdV99mQG8c=;
	b=19dypBJSpSB8VpG9k68dspCu59qOZsosN9V46nHSXiwCSa0QOalR3rHZKiHUIfwEsHsX7U
	+/pNDnqubKp7WWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF9EA13314;
	Mon, 12 Oct 2026 14:03:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1E/GIb/ozGo8GAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 14:03:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B7BEA1407; Mon, 12 Oct 2026 16:03:39 +0200 (CEST)
Date: Mon, 12 Oct 2026 16:03:39 +0200
From: Jan Kara <jack@suse.cz>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1cfd29c242c7cd26da02@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/dcache: annotate the lockless d_unhashed() check in
 retain_dentry()
Message-ID: <xfg44tmmmuse7snjoqhreqbkvlny2vyrrqh5jtvame3mw5ycby@jxrrtmsfl66l>
References: <20261012132218.106771-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012132218.106771-1-ngocthang2710.1999@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[1cfd29c242c7cd26da02];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email]
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO

On Mon 12-10-26 20:22:18, Nguyen Ngoc Thang wrote:
> KCSAN reports a data race between __d_drop() clearing d_hash.pprev
> and the d_unhashed() test in retain_dentry(), reached from fast_dput()
> without ->d_lock held:
> 
>   BUG: KCSAN: data-race in dentry_kill / fast_dput
> 
>   write to 0xffff888107394e50 of 8 bytes by task 3667 on cpu 0:
>    __d_drop fs/dcache.c:578 [inline]
>    dentry_kill+0x139/0x500 fs/dcache.c:824
>    finish_dput+0x16/0x1d0 fs/dcache.c:1001
>    dput+0x48/0x50 fs/dcache.c:1042
>    lookup_one_qstr_excl+0x156/0x240
>    filename_unlinkat+0x149/0x410
> 
>   read to 0xffff888107394e50 of 8 bytes by task 3668 on cpu 1:
>    hlist_bl_unhashed include/linux/list_bl.h:54 [inline]
>    d_unhashed include/linux/dcache.h:396 [inline]
>    retain_dentry fs/dcache.c:872 [inline]
>    fast_dput+0x64/0x300 fs/dcache.c:971
>    dput+0x1f/0x50 fs/dcache.c:1040
>    handle_mounts fs/namei.c:1753 [inline]
>    step_into_slowpath+0x38c/0x4c0 fs/namei.c:2104
>    path_lookupat+0x2eb/0x4c0
>    do_readlinkat+0x74/0x2f0
> 
>   value changed: 0xffff8882376dc230 -> 0x0000000000000000
> 
> The race is intentional. As the comment above retain_dentry() says,
> without ->d_lock the predicates are not stable, and it is enough that
> the dentry was hashed at some point after the reference was dropped.
> If the lockless reader sees a stale "hashed" value, the dentry is kept
> with a zero refcount, exactly as if it had been dropped just after the
> check. If it sees "unhashed", it takes ->d_lock and rechecks. A single
> aligned pointer load cannot tear, so neither outcome is harmful.
> 
> Mark the read with data_race() to document this and silence KCSAN.
> No functional change.
> 
> Reproduced with the syzbot C reproducer on a KCSAN kernel in QEMU;
> with this patch the dentry_kill race no longer shows up.
> 
> Reported-by: syzbot+1cfd29c242c7cd26da02@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1cfd29c242c7cd26da02
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 1b1a81f10da6..3eb3d7e7ab0f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -868,8 +868,9 @@ static inline bool retain_dentry(struct dentry *dentry, bool locked)
>  	smp_rmb();
>  	d_flags = READ_ONCE(dentry->d_flags);
>  
> -	// Unreachable? Nobody would be able to look it up, no point retaining
> -	if (unlikely(d_unhashed(dentry)))
> +	// Unreachable? Nobody would be able to look it up, no point retaining.
> +	// Racy when !locked: a stale answer only costs a recheck under ->d_lock.
> +	if (unlikely(data_race(d_unhashed(dentry))))
>  		return false;
>  
>  	// Same if it's disconnected
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
