Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111DA3D1CD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862283; cv=none; b=Zn6hHns5Lrjo4qUw0Zy4rz0A3GyN2GCHJnJBUDqX1ley5A2DUFF940KvuoxGIokr3cNCXyWrfiWtWL6cv9Zy7x0CAkXuhXngcGQqgHe8p0k9LQ1Q86210ZodnUgCaWmNqBq5yur17ddxfzGa8Kx/CeDOkN1T7ZEOopCTefaeZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862283; c=relaxed/simple;
	bh=pNuVyfWqC8N+XscoqS+nqAYh7IhD+O+3XckeTarQP1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUb8PyrRXdyiAKUsn7qxvpVBjrcFW10wbyBy5GLpznnaTnIIIRHabZ3KEvIS8fOpvxbRheurnpWmuGsnFRPWQ9VbYe5uRvx23t9LtrzGMIQlQxLcyzBaq5n/ud895RZsmfHSKH3mCwY1whoUEuORwJQujYimD82Qdc9mtMhBnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IH3iiiA8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UmtIN0ks; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IH3iiiA8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UmtIN0ks; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IH3iiiA8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UmtIN0ks";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IH3iiiA8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UmtIN0ks"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 415656A82E;
	Wed, 22 Apr 2026 12:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776862280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uI3fewQhkVe2cQYbA/jdYYB5hkstqTO3z05eoDnk8bY=;
	b=IH3iiiA8FbSHY8JMlkDDQOVCEGIGMF7meiVRHY2/AntHHlRYJ31Oj6LHlnJgCejWPGAXPm
	yHRwlfUQyBszlUA9T1HPQwdOV8C1D/0BbS+te77qNtqVoRZhrvzGgl2v/CfnVnGrAlGg6D
	zFjvSQD/hD/aczvHfVkWumsVdLlGODk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776862280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uI3fewQhkVe2cQYbA/jdYYB5hkstqTO3z05eoDnk8bY=;
	b=UmtIN0ksh0dClJb+EGHjTQi2tY0QO9EQRm15eH3JnoA49CcZxH3kyh6O6N/AUpndsSqmAh
	T6VAx4ruL2CaVCBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776862280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uI3fewQhkVe2cQYbA/jdYYB5hkstqTO3z05eoDnk8bY=;
	b=IH3iiiA8FbSHY8JMlkDDQOVCEGIGMF7meiVRHY2/AntHHlRYJ31Oj6LHlnJgCejWPGAXPm
	yHRwlfUQyBszlUA9T1HPQwdOV8C1D/0BbS+te77qNtqVoRZhrvzGgl2v/CfnVnGrAlGg6D
	zFjvSQD/hD/aczvHfVkWumsVdLlGODk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776862280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uI3fewQhkVe2cQYbA/jdYYB5hkstqTO3z05eoDnk8bY=;
	b=UmtIN0ksh0dClJb+EGHjTQi2tY0QO9EQRm15eH3JnoA49CcZxH3kyh6O6N/AUpndsSqmAh
	T6VAx4ruL2CaVCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35FD5593AF;
	Wed, 22 Apr 2026 12:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RI8hDUjE6GkxAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 12:51:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EED64A0B44; Wed, 22 Apr 2026 14:51:19 +0200 (CEST)
Date: Wed, 22 Apr 2026 14:51:19 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: use QSTR() instead of QSTR_INIT()
Message-ID: <4pinx2ihfsrbk5wypfhfx46p3g4wd3ko3i6dxqyy64m7fquzqy@dnob2jlgqqt3>
References: <20260422123345.100436-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422123345.100436-2-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 22-04-26 14:33:46, Thorsten Blum wrote:
> Drop the hard-coded length arguments and use the simpler QSTR().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 2c61aeea41f4..c5536da1634d 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -89,11 +89,11 @@ EXPORT_SYMBOL(rename_lock);
>  static struct kmem_cache *__dentry_cache __ro_after_init;
>  #define dentry_cache runtime_const_ptr(__dentry_cache)
>  
> -const struct qstr empty_name = QSTR_INIT("", 0);
> +const struct qstr empty_name = QSTR("");
>  EXPORT_SYMBOL(empty_name);
> -const struct qstr slash_name = QSTR_INIT("/", 1);
> +const struct qstr slash_name = QSTR("/");
>  EXPORT_SYMBOL(slash_name);
> -const struct qstr dotdot_name = QSTR_INIT("..", 2);
> +const struct qstr dotdot_name = QSTR("..");
>  EXPORT_SYMBOL(dotdot_name);
>  
>  /*
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
