Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644D2737F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163357; cv=none; b=upke0fT+pWyP3+7RQlaox4DW02ucTfnXOSR9B88lSnDAPxC8TF7OOnK5acSHdkyD2YkDEIyDoJ87hjsAhBE1gULSy19lkX3JpnYZa5EC2Oqh9WqHWHDCiL3NDOqF7B6cCZx/io9nApa3PsZSLJvrpra3zw32j55mRI4ksEwgl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163357; c=relaxed/simple;
	bh=2ug483NQU1p3+g3avWFgpHHr3uwh/TRSD7qUf9rfgwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYoCD58yW7pMe7yIOoYGBm9JBhcnFrpbrfxUXnIkrjT+sHz2/0rPs6A6fD8OprNmJMpfhOz6HTXUAn016Xt/9wEPnTvC7ruKckqQ2p7cuDOsOUO9ZoQxJk1i7cASzBO0wd7MhnTAEDvdwPyzsOTQylhwKX1NVMjkiK574FwztRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MxyHSQlD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OUU2hofn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ml+ViLlw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w7zZKOd6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MxyHSQlD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OUU2hofn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ml+ViLlw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w7zZKOd6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D51E93F50;
	Mon, 27 Jul 2026 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785163350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhvlMZ7K0Bmpq+QvOYJQNyf7E+S5QeNFAuQGwLUrofo=;
	b=MxyHSQlDy0pZyuhqkpYtcdeYJz+56qEtjxDXwkF+YWlK6S8gSvNqiZQny9l47p7V45z7OH
	9bjcb42fliZScsAQ4jjObRWK5fNp2afzqIALuGD20YyAYCHobgfKyIhq1KT9rIJdJMopKd
	Tjmv1KbJUDogOlQLGSHdmI41m7FA0mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785163350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhvlMZ7K0Bmpq+QvOYJQNyf7E+S5QeNFAuQGwLUrofo=;
	b=OUU2hofnSFIYQrBqixSwp9Smd9WD1DNSj0Y1nDz0oioXbsZEn2MuPv0wCozRP9aPeciu72
	8oVFxkLHXA4ciZAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ml+ViLlw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w7zZKOd6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785163345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhvlMZ7K0Bmpq+QvOYJQNyf7E+S5QeNFAuQGwLUrofo=;
	b=Ml+ViLlwaRaAtFeIOTYVRgxPxboD0cXINS4knRcCZbvhof/60auQvQyRPyI79UV3FTBH4H
	3AsdLRnjs5Y568A2JtrXEj1FMDLnESqxJLe/KKWggUP8dW6cqHQHSnTiEpLPovPpe+74nX
	N9++njsn01dEvMG5fgCr9JiVypKdVpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785163345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RhvlMZ7K0Bmpq+QvOYJQNyf7E+S5QeNFAuQGwLUrofo=;
	b=w7zZKOd6tbNAWqDfaCD4Vm/nKzmFZf1cSYfYg7w0geSQkAXD1plym29g4GkOzSa/yzQpsp
	kQ9B2GVnYjjOABCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCDA5779B9;
	Mon, 27 Jul 2026 14:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W/AAMlFuZ2olUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 14:42:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D54FA0BA1; Mon, 27 Jul 2026 16:42:21 +0200 (CEST)
Date: Mon, 27 Jul 2026 16:42:21 +0200
From: Jan Kara <jack@suse.cz>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: release zisofs block pointer buffer head
Message-ID: <yyirb2malhkxypbryd3ud244tuelmi4m626cf5sqs3gqdyxzt3@77asbyv5yejo>
References: <20260721091152.1450622-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721091152.1450622-1-chenyichong@uniontech.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D51E93F50
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Tue 21-07-26 17:11:52, Yichong Chen wrote:
> zisofs_fill_pages() reads the compressed block pointer table.
> 
> The error paths release the current buffer_head.
> 
> The loop also releases the old buffer_head when it advances.
> 
> However, the success path leaves the last buffer_head referenced.
> 
> Release it before returning success.
> 
> Fixes: 59bc055211b8 ("zisofs: Implement reading of compressed files when PAGE_CACHE_SIZE > compress block size")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/isofs/compress.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 3fda92358e22..f9869d62b850 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -293,6 +293,7 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
>  		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
>  		SetPageUptodate(*pages);
>  	}
> +	brelse(bh);
>  	return 0;
>  }
>  
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
