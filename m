Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E54C8C49;
	Tue, 22 Sep 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070355; cv=none; b=oidgkI22mkUF3OyaOrBpu6BUBgFnd3HzVLiS+0CsWILEcwVPkaDLBGayvKbKUggt2ihboEWnwQZHHhQ0bauMFxeASvg3MtysoPS9u20nFmWUYZ02b/O/ouzoeTjZGB35AaJ1UwKS7ZTB97whTT/MVUGwVUhD1o5YIgKZ8uC9wVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070355; c=relaxed/simple;
	bh=hkPgMj6V8nxIiV0/ioP/4qUj5o6+3Isvq9cpsjTLfMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPaqK+CDgvm9r8QjwWgY1ktsioDAQIFBJW9cmEr7AS6Qy0SrhqXDkeCzr1WDqVy/dlrwSrjyzVc1IJq9Usa+5C420Jw26KZixcEOjBXh4ntvDIX25qxnXERVB/9YRRc7+FzPnrhDl2OAgIy/s8xar+4eSvVd6FqiQBLachVA8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jm9/EmLl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lkViGiFi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oCz+dN+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mmL4U+ZD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jm9/EmLl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lkViGiFi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oCz+dN+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mmL4U+ZD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4386C1F747;
	Tue, 22 Sep 2026 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790070348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4oDoMpfQHzeTjZzlp/kmyeXgYE0Pl2kt+Su8jYEVvE=;
	b=jm9/EmLlY+CQkI10k6kyCowe+KF5SHWY56q+uv+T4Il0d7fcurqJyKJrKKvLZfpgL765kL
	LsaqMGXhiYa+/p1xsQAUJsc4GgdjtMTGswqrhjn8xMeUSADn/l7wig9FWD7kmii8eZrSR0
	cd9OOql1Fl1QW7aB8iScA80kDGL2E54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790070348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4oDoMpfQHzeTjZzlp/kmyeXgYE0Pl2kt+Su8jYEVvE=;
	b=lkViGiFi/fUoe+eRVPkoFpCHq+jlvXYKtM4dOjkGx7oo4rq7mFeDUMFaMW57grtEtbqry9
	xnSCMes9oujJ4RCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790070344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4oDoMpfQHzeTjZzlp/kmyeXgYE0Pl2kt+Su8jYEVvE=;
	b=oCz+dN+gbCpsV+94+vLEYeOtmSOTZJyiSyx6xV7X1l53QEE6nRmmHEd1B/5MuEZdh9gR0m
	Jvw+oo8XCVN5XpfBffa6L1zefsGGwwUst4cbS/MI4AG6M6gZLk24LCCTHmbaQ0afy3QtsK
	X2LDHuBTJGkhntjWgObLGVhk6qnSI9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790070344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4oDoMpfQHzeTjZzlp/kmyeXgYE0Pl2kt+Su8jYEVvE=;
	b=mmL4U+ZDNrI7ALKAGm0NC6/MWAYGFrxYhy3aBndYZa/bNCrU926PxoIk2fRs+sGXfGwuk2
	rPZzhEQkO/C48TDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8393136D9;
	Tue, 22 Sep 2026 09:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CXZDK0dOsmrveAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Sep 2026 09:45:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 320C6A13D4; Tue, 22 Sep 2026 11:45:37 +0200 (CEST)
Date: Tue, 22 Sep 2026 11:45:37 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <blum@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: Reduce hardlink hash allocation sizes
Message-ID: <cbvwd3loa6edt7tjnd24vuv4dqnu6gul2ysbaooftx7d7o7zlo@xwg2ixm5ac37>
References: <20260919213859.24667-3-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919213859.24667-3-blum@kernel.org>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Sat 19-09-26 23:39:00, Thorsten Blum wrote:
> Each hardlink hash entry reserves N_ALIGN(PATH_MAX) bytes for its name.
> This makes every allocation larger than 4 KiB, placing it in the
> kmalloc-8k bucket even for short names.
> 
> Use a flexible array with the already validated cpio name_len to reduce
> allocation sizes.
> 
> Also use const for the read-only name parameter.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>

...

> @@ -106,14 +106,15 @@ static char __init *find_link(int major, int minor, int ino,
>  			continue;
>  		return (*p)->name;
>  	}
> -	q = kmalloc_obj(struct hash);
> +
> +	q = kmalloc_flex(struct hash, name, nlen);
>  	if (!q)
>  		panic_show_mem("can't allocate link hash entry");
>  	q->major = major;
>  	q->minor = minor;
>  	q->ino = ino;
>  	q->mode = mode;
> -	strscpy(q->name, name);
> +	strscpy(q->name, name, nlen);
>  	q->next = NULL;
>  	*p = q;
>  	hardlink_seen = true;

What about the space for terminating \0 ? This way the stored 'name' will
be actually one character shorter because strscpy() will overwrite the last
character by \0. Or do I miss something?

								Honza

> @@ -355,7 +356,7 @@ static void __init clean_path(char *path, umode_t fmode)
>  static int __init maybe_link(void)
>  {
>  	if (nlink >= 2) {
> -		char *old = find_link(major, minor, ino, mode, collected);
> +		char *old = find_link(major, minor, ino, mode, collected, name_len);
>  		if (old) {
>  			clean_path(collected, 0);
>  			return (init_link(old, collected) < 0) ? -1 : 1;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
