Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343342668F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516025; cv=none; b=FsLdN/f6SgYrp6bbw/aaVxJpoql82zD97qqNvXPuF5WoUnuCNeioHSmgz8Z5oCeOA/HICK72LF5VFmV85gvd45rbrrkqJss2fE2vHKuYuHAcPCr03kOEhSTlqJiyNuGbDlQpYtZAMyLwGCM1vtKoOPgI85WDlyTx2AeoY6Y459M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516025; c=relaxed/simple;
	bh=m7PmLs9fX/W7oa4wPxD5TrYsLZ8QfsvpSCJUU1hkzcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA6cFWFDzqwqyQHQoWLIpD/qqJKsmQoqCJQQ0rKZdaMT1f0ECqIR4UC844ywiWYAE6GAuBrze4stOxy+W5/MTXmYfSCoch5MVkDVRkAR+TiLICRRw7x3C1uzFZ9mn2Rcs5Ic4XqaNyDFXv/cT5LMLJxxoSipYsiyPquMTgSL5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gosQfWbV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzhsbR38; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfiqduZz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bf8bJbRQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gosQfWbV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzhsbR38";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfiqduZz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bf8bJbRQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3424B68313;
	Mon, 11 May 2026 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778516022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naDTUG5+t3MblNlXPx8l4nltGWN12WLoUDO44K7jTe0=;
	b=gosQfWbVgWIzxjBhiUPwxINtFADcQkAu7jgT0YEZ+YgOWEl0kjlBzXgwLDloWXpSawC2tJ
	9qM/7zWcMp8gtmUltFuoTqZNYxYgAyTWIifoN7EKlxyxfVD58SjJAr9Exo54lBjerM1jj/
	HCf/J3X8uCr6y6Ll0YsMjvyJmLisnvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778516022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naDTUG5+t3MblNlXPx8l4nltGWN12WLoUDO44K7jTe0=;
	b=pzhsbR38qycy/Hn9qbIwOE63cyJAnhtTHB8n8yGbJNA5cN/GRdUgWTJK7R6MUeCmJTKq5n
	jc9/19TtQ5e3WUBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778516018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naDTUG5+t3MblNlXPx8l4nltGWN12WLoUDO44K7jTe0=;
	b=QfiqduZzTe8ls6yreylc2xe7WoWR1cluW8s62wW0WdSu0NaIdUe+aUbjDrWy8InUtyWlLL
	yucPKCKZ83lGBdQ+pg0QWgy5d6oGaEApKm7VCL8VtvHLYQrvTUfmWSR1JaCVrgR0+d61Xv
	h0Yze2Vlh0h3FB8TrZSR2yZKTYkx24o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778516018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=naDTUG5+t3MblNlXPx8l4nltGWN12WLoUDO44K7jTe0=;
	b=Bf8bJbRQLvUkUi3SoYurVfzEyUyaqduth4znF/flzv4z31rj3Y+RPFP89X9jh+litPBfxc
	sU0yrpfBXfSWF5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 276EA593A3;
	Mon, 11 May 2026 16:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2wOYCTIAAmoeTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 May 2026 16:13:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9B246A079E; Mon, 11 May 2026 18:13:37 +0200 (CEST)
Date: Mon, 11 May 2026 18:13:37 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: unexport drop_super_exclusive
Message-ID: <ugorsaywcbpdihifeiamdbrobm6yp4l67tboh3ywlsuwuuf6pd@7jfmfbqyenxd>
References: <20260511072239.2456725-1-hch@lst.de>
 <20260511072239.2456725-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511072239.2456725-2-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.com:email]
X-Spam-Level: 

On Mon 11-05-26 09:22:28, Christoph Hellwig wrote:
> drop_super_exclusive is only used by the built-in quota code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 378e81efe643..5d46a0d5b616 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -882,7 +882,6 @@ void drop_super_exclusive(struct super_block *sb)
>  	super_unlock_excl(sb);
>  	put_super(sb);
>  }
> -EXPORT_SYMBOL(drop_super_exclusive);
>  
>  enum super_iter_flags_t {
>  	SUPER_ITER_EXCL		= (1U << 0),
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
