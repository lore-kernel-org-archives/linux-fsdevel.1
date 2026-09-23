Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF85494816;
	Wed, 23 Sep 2026 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160077; cv=none; b=CxaVoD6by6BjBONwwFvSzQ0sFgK4ewT+XpXDS3TfsooqvxfH0sVMgoch/sA0pb2xI3WFGzL+WKG0HbOZTKkqd/ysxDzNSweqaFMSnBFoFg0RDop3i1e0+cTudLQ2Z9TtMkOEYaIevYXXHlNbmhlbExRGcm68MPCm64g4NgCVfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160077; c=relaxed/simple;
	bh=46tmE3Ve/Nk87FjWMhpAuTzX3HjMfVusUTFEdxS2Q7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9cih+xyS9CzMdhHxYcJnXejsu9tvVckwwnFY7k0yYGObWv7wN8onpCbFhlprLrCYt2FYyBe1Faov6QhSCEJ+sttC1Bd54m0VkkFywn6H0/8cXwk7VHlIY8o3kY8EyrtidL7+ZRN8iELGyotqmLbyrNILE7YnJN4B44c1U7gwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BPwZpArg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kLBDNicC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h7lzvjM0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jQxrD/jE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BPwZpArg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kLBDNicC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h7lzvjM0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jQxrD/jE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89FBF21A29;
	Wed, 23 Sep 2026 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790160052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdlLWRMURnyFzXNNGpWG5gQwOZdkQCfoP7TBERvJXHk=;
	b=BPwZpArgWiz5VJJpy5wZ0xqH9wYyFZtKluK1MCUYPV3Ll6sH5lZVy7UVdxNhuywsSGn4px
	3ED+ZXfZ7bboQVio206HWOCG610dPOeAO1BYbgXP3DUXveb/tkkKiByDaAkj6hwYdBLgcZ
	rXYzB3ZeHWPJAgoUUFJvhZrb3HMhGRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790160052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdlLWRMURnyFzXNNGpWG5gQwOZdkQCfoP7TBERvJXHk=;
	b=kLBDNicCM1/r04ryQHA0MfYMrRBjafwkIyTXFd1HMcuFyZz7Gk3km4ESsE8mqwuJHoIs9h
	zRLFhDs5NaZrHXDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h7lzvjM0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="jQxrD/jE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790160048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdlLWRMURnyFzXNNGpWG5gQwOZdkQCfoP7TBERvJXHk=;
	b=h7lzvjM0xXmB5bZTo+jOfDiQCPyF6+hdvGvf2Um67eWT1/bbY7aSnJmHR6mQ/QA+ypfGTc
	fK6PWUXWnICAbOw5Hy536DmKYWGgQeH8FKFNI9elt04A6X+6nEtXwGPgbabGX9D3wEL4zK
	vk98p1MAn3UeCluAbA3r0FFAmwX2i14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790160048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdlLWRMURnyFzXNNGpWG5gQwOZdkQCfoP7TBERvJXHk=;
	b=jQxrD/jEb8CJzM5R6OlODXRvwUFfY1qCO8mZvumsIYMTJxSW6Uo9GdiipVWuuOYkAb7eYy
	wf7bTwrsDSZ7fwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BEC513432;
	Wed, 23 Sep 2026 10:40:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QinLDbCss2p9aAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 10:40:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DFDAEA13D4; Wed, 23 Sep 2026 12:40:43 +0200 (CEST)
Date: Wed, 23 Sep 2026 12:40:43 +0200
From: Jan Kara <jack@suse.cz>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: remove unused vfs_empty_path()
Message-ID: <aki35tz5ddykjr7xgmqs6pgmqgopqgcrlstei6okzhionqgcu4@uivzxkbbabg6>
References: <20260918165105.1013792-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918165105.1013792-1-ekffu200098@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 89FBF21A29
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Sat 19-09-26 01:51:03, Sang-Heon Jeon wrote:
> Since commit e896474fe485 ("getname_maybe_null() - the third variant of
> pathname copy-in"), vfs_empty_path() has no callers.
> 
> So remove it.
> 
> No functional change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 05d05bb9c951..ef8eb5af06c5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3653,23 +3653,6 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
>  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
>  			   int advice);
>  
> -static inline bool vfs_empty_path(int dfd, const char __user *path)
> -{
> -	char c;
> -
> -	if (dfd < 0)
> -		return false;
> -
> -	/* We now allow NULL to be used for empty path. */
> -	if (!path)
> -		return true;
> -
> -	if (unlikely(get_user(c, path)))
> -		return false;
> -
> -	return !c;
> -}
> -
>  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
>  
>  static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
