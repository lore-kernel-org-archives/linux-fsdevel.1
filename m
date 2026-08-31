Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311653B42FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165097; cv=none; b=BFyyXKPEiJGstcGp+2AVIcewgkrRVrZh+yENHneSSgUnFdN85QBUSpoM6xqsl2xUahJWcE9DcbxI4XQAR42C8WTQEeOx1xmNGBX8CnUHADp8ZcCvjyKXrT5QM0wvc6W79QA/Qq7lwlQAYY4zCt+sv/tJjA1eoCnnxk+IEJToieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165097; c=relaxed/simple;
	bh=PaJw5VD/z3cruGAMjsQn9Cn8IkCiNz6ZnPjujlY03LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEOGtWOPa7KobP3A33/4+gXw0DLbm2rb4qa6YosdWM+q3/8DwZkEXi+Qi3s5JfOvKO630JAl1ifvQjmcV0URWtGmHEMYdRgYZhUbx6vMmjgPQN6+voMrfxJF3fXJFgvp5925fCSXo5eskI/ZozPqHLZBtjQtXnUVzIIXqefC8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ErohPR0G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9UDAjYHr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0TUv1MpC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gpc6MYjN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ErohPR0G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9UDAjYHr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0TUv1MpC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gpc6MYjN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2F37222E4;
	Mon, 31 Aug 2026 08:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788165090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ms7oeWxF3zddhpy63eHtcX2/hwpkcrEh4Fb/IcG28Uk=;
	b=ErohPR0GYxbAhapXxOkbvG3vDj82nGZlJhFru6exvFP4mCRV+x81IbIvDcoLTb+I0N1+hu
	FMAx4PlrjpWBOQO8hutsq+iqU60jyM5AJEt8ubeRXq7tUgFTo1sgxphTEqJ/Bl97lS/4tX
	ZXz56HopsWbZ9UbdPU3v+O5maT1Au8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788165090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ms7oeWxF3zddhpy63eHtcX2/hwpkcrEh4Fb/IcG28Uk=;
	b=9UDAjYHr0aMIMMbbrAtBVYFB+Aj+WcnKuDrARRjbIgM4oPIjeQD9o2lkmnMUPcnPjNjAEP
	1RXyDTifeIp09CCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0TUv1MpC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Gpc6MYjN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788165085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ms7oeWxF3zddhpy63eHtcX2/hwpkcrEh4Fb/IcG28Uk=;
	b=0TUv1MpC1xi9KYRfBTBO2cQ+cZOhOFtBySt16EYpEiKdv+z4QB/nQ4IZEo9eVDoUYJ7GuB
	9HJsZAZROgSxW2jRGxZzkWQ8GSI/M2BrEFrj0hsSqjbsYKhAn6tAnzlPAUq03UhBP7O9mL
	ZkrIM+pKS249mYelXcI+z19VhlkM6Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788165085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ms7oeWxF3zddhpy63eHtcX2/hwpkcrEh4Fb/IcG28Uk=;
	b=Gpc6MYjN7ANEsxm3puXDx3MUgPlL01f8RxxEMbquB6B91EZ4ql7zPks69mWW2R4Y0t6lHz
	jVpEy3t+mBPcOsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4BBE13515;
	Mon, 31 Aug 2026 08:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1M8DMN07lWqMGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Aug 2026 08:31:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 52A99A13B5; Mon, 31 Aug 2026 10:31:21 +0200 (CEST)
Date: Mon, 31 Aug 2026 10:31:21 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] buffer: Remove reference to unmap_buffer()
Message-ID: <dm5ofc7koepx5oemgl5bj5ec2l4obztgpai5g7wkmafxpmxbde@4clmie7mcmte>
References: <20260828205429.3678204-1-willy@infradead.org>
 <20260828205429.3678204-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828205429.3678204-2-willy@infradead.org>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E2F37222E4
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 28-08-26 21:54:21, Matthew Wilcox (Oracle) wrote:
> unmap_buffer() was removed 25 years ago in v2.4.10.0.1.  We don't
> need to mention it in a comment any more.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Right. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ed966fa73b1b..90ea52af042a 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1611,9 +1611,7 @@ EXPORT_SYMBOL(create_empty_buffers);
>   * moment when something will explicitly mark the buffer dirty (hopefully that
>   * will not happen until we will free that block ;-) We don't even need to mark
>   * it not-uptodate - nobody can expect anything from a newly allocated buffer
> - * anyway. We used to use unmap_buffer() for such invalidation, but that was
> - * wrong. We definitely don't want to mark the alias unmapped, for example - it
> - * would confuse anyone who might pick it with bread() afterwards...
> + * anyway.
>   *
>   * Also..  Note that bforget() doesn't lock the buffer.  So there can be
>   * writeout I/O going on against recently-freed buffers.  We don't wait on that
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
