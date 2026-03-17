Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC34396B7D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737018; cv=none; b=Y3l6f0zR8fMhOBZRzs41sEgRYY7rcT+WO/MmHwECrzNRW7QIsCA80ArPo8IKTuk6yBRF+Jvt2AnjCUEaJAZMKGdDAopO7FRUuKZg6SUMh5a4csJBLgVkaAp46IYq8ULXi0rK/nwkk1bJ+Asj1ola5tRetPc5FuTq/8dEDsIagbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737018; c=relaxed/simple;
	bh=C5/r6Nme4UuqaXeEN8iWp6lV5RrbLXRvTWqTseTCESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZO03z6pg+W+knuwYOtbjrQjdfsmMcALnhHPS60kww7VovHvgXMd37mafsSk1tUIAvD8mWxBp/dOjtfGTpgwcwje0mF5xzLdALugcsOBDvCCPV14o9jcj3t2QVl5ByZ7nQsZI/7hxYYBYVEnm6GBatfgaqVWKEFH5UAoio57skk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HLhwX5k4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yea7h1g2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HLhwX5k4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yea7h1g2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HLhwX5k4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yea7h1g2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HLhwX5k4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yea7h1g2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CFCB4D2B9;
	Tue, 17 Mar 2026 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773737014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi+mLRW0ksHh296tBeBeYZPpGRbAQLVh6pu1NUZxFkY=;
	b=HLhwX5k4NzuWu7bFpBwTR2XSs36Ab0+wzrxRFRyVy0PtwuiNazGhYDxgPwyztIjAElohgq
	7E8ugJnLNgzbn3lW4z8flXmNbbacA9Q3vGjd42LDaBEHXsNK6wk6TXEEGAPAwxIqEQ893s
	MhCcUtEM5zdkdpk/ohqlLJ3JdeFG168=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773737014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi+mLRW0ksHh296tBeBeYZPpGRbAQLVh6pu1NUZxFkY=;
	b=yea7h1g2oaVeSC40joCinPZSBI+pQFg1y/JKZpYjHCzvuQzRf0vr3q0sVT7BrlLqIpWwa4
	O/NUzNlsJnl4eSBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773737014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi+mLRW0ksHh296tBeBeYZPpGRbAQLVh6pu1NUZxFkY=;
	b=HLhwX5k4NzuWu7bFpBwTR2XSs36Ab0+wzrxRFRyVy0PtwuiNazGhYDxgPwyztIjAElohgq
	7E8ugJnLNgzbn3lW4z8flXmNbbacA9Q3vGjd42LDaBEHXsNK6wk6TXEEGAPAwxIqEQ893s
	MhCcUtEM5zdkdpk/ohqlLJ3JdeFG168=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773737014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi+mLRW0ksHh296tBeBeYZPpGRbAQLVh6pu1NUZxFkY=;
	b=yea7h1g2oaVeSC40joCinPZSBI+pQFg1y/JKZpYjHCzvuQzRf0vr3q0sVT7BrlLqIpWwa4
	O/NUzNlsJnl4eSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 434844273B;
	Tue, 17 Mar 2026 08:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w1RmEDYUuWnkdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Mar 2026 08:43:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3CFDA0A5B; Tue, 17 Mar 2026 09:43:33 +0100 (CET)
Date: Tue, 17 Mar 2026 09:43:33 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: fix docstring of hash_name()
Message-ID: <3d42elzgtl5igw3xswvo4nc6bygho6oe6zuijqwy2kjpurbv2k@w42aryoa7v2w>
References: <20260312112823.2801-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312112823.2801-1-jkoolstra@xs4all.nl>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,xs4all.nl:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 12-03-26 12:28:22, Jori Koolstra wrote:
> The docstring of hash_name() is falsely reporting that it returns the
> component length, whereas it returns a pointer to the terminating '/'
> or NUL character in the pathname being resolved.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 58f715f7657e..d020b077591b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2437,8 +2437,13 @@ u64 hashlen_string(const void *salt, const char *name)
>  EXPORT_SYMBOL(hashlen_string);
>  
>  /*
> - * Calculate the length and hash of the path component, and
> - * return the length as the result.
> + * hash_name - Calculate the length and hash of the path component
> + * @nd: the path resolution state
> + * @name: the pathname to read the component from
> + * @lastword: if the component fits in a single word, the component bytes,
> + * otherwise 0

The @lastword description is what the function does but not really the
point of the parameter. I think more understandable description would be:
LAST_WORD_IS_DOT, LAST_WORD_IS_DOTDOT, or some other value depending on
whether the component is '.', '..', or something else.

Otherwise the fix looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
