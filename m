Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE363B5318
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287523; cv=none; b=Wzj9xkhgCObedyxcy4Moz7Y3VeCh7KLB1El8/lDruT5Eqa84U4JhNnlb3EZaOWjbI6VqYSkt7QNh+gFXaqdBWSSXog+e3boJUPuUl716vgFNdKqrIiFVfF3gKV/gzUNFVLq8C9WBuiENgVG21cHZklAxf0T7oCosH2vx5kkOvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287523; c=relaxed/simple;
	bh=hMA6U2Q7RE6I0HDNNnPT9I6PVdakaK+F4QpOyZaSSRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZ09raFa3wYnb8hLMolM7oC7e+69Bk49JvF5jQpgRFWx+iFtXdZ/n07OGdRLuHOWhCzzQ3lNgGXM3V3mR7ydqzLNf/w9bJCqeW3bpKCYLMKoY+VTB1S0bkma5c+NzEYvViBx5kbqcrus93pFWiTaSBrOYKGngg1YVIrwamkEbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P6kmlTS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rp1bCjPB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P6kmlTS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rp1bCjPB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P6kmlTS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rp1bCjPB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P6kmlTS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rp1bCjPB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 276FE6A8FE;
	Mon, 27 Apr 2026 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777287520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XX2NxFHxauaQXxfrBlC1ECx26qRNAbCeJhn8PWW6alc=;
	b=P6kmlTS9Pdo3IeIYOwOS2mRmo95a+4+PC8l9ENey6eojwVgNA37n4TzYDC9ryZ/P9CdHr2
	RpBPODgubspzFXN48MStI6+7vGpj+7IAtTN8dhHWT+jPrTuz0vjWrxdplbvQM0b5tezayM
	jl5SFsf0ip5riKxJ+Jn/opWZcbtLNds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777287520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XX2NxFHxauaQXxfrBlC1ECx26qRNAbCeJhn8PWW6alc=;
	b=Rp1bCjPBgA/gpj65Kz8n8JwBj9iUx9Daa///w/Z5pvjFdZLJmH+yibwkuzu5hPpQv2HDXU
	xs17GC7+VoA3DXDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P6kmlTS9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Rp1bCjPB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777287520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XX2NxFHxauaQXxfrBlC1ECx26qRNAbCeJhn8PWW6alc=;
	b=P6kmlTS9Pdo3IeIYOwOS2mRmo95a+4+PC8l9ENey6eojwVgNA37n4TzYDC9ryZ/P9CdHr2
	RpBPODgubspzFXN48MStI6+7vGpj+7IAtTN8dhHWT+jPrTuz0vjWrxdplbvQM0b5tezayM
	jl5SFsf0ip5riKxJ+Jn/opWZcbtLNds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777287520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XX2NxFHxauaQXxfrBlC1ECx26qRNAbCeJhn8PWW6alc=;
	b=Rp1bCjPBgA/gpj65Kz8n8JwBj9iUx9Daa///w/Z5pvjFdZLJmH+yibwkuzu5hPpQv2HDXU
	xs17GC7+VoA3DXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E069593B0;
	Mon, 27 Apr 2026 10:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FztLB2BB72nrOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 10:58:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D6F6CA0AFF; Mon, 27 Apr 2026 12:58:35 +0200 (CEST)
Date: Mon, 27 Apr 2026 12:58:35 +0200
From: Jan Kara <jack@suse.cz>
To: Ziran Zhang <zhangcoder@yeah.net>
Cc: Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: isofs: replace dead ECMA-119 FTP link
Message-ID: <nxtjqejbi3nfnxomztmaeu4zbtgn6d247jtp5462fdl64rl5f6@nl6j6fji7tmu>
References: <20260425142943.6809-1-zhangcoder@yeah.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425142943.6809-1-zhangcoder@yeah.net>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[yeah.net];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[yeah.net];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_WP_URI(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ecma.ch:url,suse.com:email,y-adagio.com:url,ecma-international.org:url,suse.cz:dkim,yeah.net:email]
X-Rspamd-Queue-Id: 276FE6A8FE
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sat 25-04-26 22:29:43, Ziran Zhang wrote:
> The original link is no longer valid. Replace it with the official
> PDF of the 2nd edition. The new link points to the exact 2nd edition
> that the existing comment in isofs.rst refers to.
> 
> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>

Thanks. Added to my tree.

								Honza

> ---
>  Documentation/filesystems/isofs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/isofs.rst b/Documentation/filesystems/isofs.rst
> index 08fd46909..2a30999b0 100644
> --- a/Documentation/filesystems/isofs.rst
> +++ b/Documentation/filesystems/isofs.rst
> @@ -57,7 +57,7 @@ Mount options unique to the isofs filesystem.
>  Recommended documents about ISO 9660 standard are located at:
>  
>  - http://www.y-adagio.com/
> -- ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf
> +- https://ecma-international.org/wp-content/uploads/ECMA-119_2nd_edition_december_1987.pdf
>  
>  Quoting from the PDF "This 2nd Edition of Standard ECMA-119 is technically
>  identical with ISO 9660.", so it is a valid and gratis substitute of the
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
