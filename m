Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657272FE05B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698894; cv=none; b=Z5sJZJ0iEJXhQNyGMFLOM8aB/2N/RZSh8bmRqmZA7xYMGLA+hS1SBHav2wkIq+cEwVNuCNkX9FFtE2wJpDSeWIHdG1yu4QV0wo8mA/HLDc+PA9bulT6jfErewRlk3W/qd69cSrvLOSkDQjes6c8hwIjfoWqeajrhVcnCh0RA51w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698894; c=relaxed/simple;
	bh=HS6riPG1mcdiVtjkx0tH94slVBecOIxYODdNGaXC7KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjeDG4RtjrNhyfrueSV9d0E4zJmSgGrmrisSU/RyAxXIVn+LTFLtzgdb0rBiM1H7ViZvZi1/dc0kO+s1JThL47i33q0UzuX7GVRdrfzcLd88ikHe/NkEyz9eu56q3HpkVe5Ym8tDdmF7FhusuugcrcbPPEHZQ48Q90uIqBv6IiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B53pvGdV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=euEnih8U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B53pvGdV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=euEnih8U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B53pvGdV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="euEnih8U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B53pvGdV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="euEnih8U"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 581C06A7D9;
	Mon, 20 Apr 2026 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776698890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAxEcdFy9Gyh1+fthp++qk1lEvDmOKUZPOdlP5NYJjg=;
	b=B53pvGdVvel4GgLnm8PoDSl5DovVCd2CQQXuFf9EdVj/Fcbq/FMwbGmIqKaK+cKNyv86So
	AD/R+UJjwYfcUNkMO4yP7Aih/dvixgn3SugvS5PkVDOo005Bo+vgWMXKtR6EJlSbfuOIjy
	HlezSv2NbRT9SJPnBkvYk/9pBLuX7wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776698890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAxEcdFy9Gyh1+fthp++qk1lEvDmOKUZPOdlP5NYJjg=;
	b=euEnih8UQRRPdyJkMjC9AwFbxQctLmNC73i9EE9nKnYgkQ2bnFFWr0UccG8EKmu46KhcPJ
	Du6XLhmRYLZ6TWCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B53pvGdV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=euEnih8U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776698890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAxEcdFy9Gyh1+fthp++qk1lEvDmOKUZPOdlP5NYJjg=;
	b=B53pvGdVvel4GgLnm8PoDSl5DovVCd2CQQXuFf9EdVj/Fcbq/FMwbGmIqKaK+cKNyv86So
	AD/R+UJjwYfcUNkMO4yP7Aih/dvixgn3SugvS5PkVDOo005Bo+vgWMXKtR6EJlSbfuOIjy
	HlezSv2NbRT9SJPnBkvYk/9pBLuX7wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776698890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAxEcdFy9Gyh1+fthp++qk1lEvDmOKUZPOdlP5NYJjg=;
	b=euEnih8UQRRPdyJkMjC9AwFbxQctLmNC73i9EE9nKnYgkQ2bnFFWr0UccG8EKmu46KhcPJ
	Du6XLhmRYLZ6TWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F0D2593AE;
	Mon, 20 Apr 2026 15:28:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 04VeDwpG5mmZJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 15:28:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD637A0913; Mon, 20 Apr 2026 17:28:09 +0200 (CEST)
Date: Mon, 20 Apr 2026 17:28:09 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: use QSTR_LEN() in isofs_cmp
Message-ID: <k42xsqoglxq3ekjjlxfqfhhsf7vb2ssjctannloxzrwkbepi52@q6shyyuewtgp>
References: <20260420102544.8924-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420102544.8924-3-thorsten.blum@linux.dev>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,linux.dev:email];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Queue-Id: 581C06A7D9
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 20-04-26 12:25:46, Thorsten Blum wrote:
> Use QSTR_LEN() and inline the code in isofs_cmp(). Remove the stale
> function comment while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/isofs/namei.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
> index 8dd3911717e0..3ace3d6a55e7 100644
> --- a/fs/isofs/namei.c
> +++ b/fs/isofs/namei.c
> @@ -10,20 +10,13 @@
>  #include <linux/gfp.h>
>  #include "isofs.h"
>  
> -/*
> - * ok, we cannot use strncmp, as the name is not in our data space.
> - * Thus we'll have to use isofs_match. No big problem. Match also makes
> - * some sanity tests.
> - */
>  static int
>  isofs_cmp(struct dentry *dentry, const char *compare, int dlen)
>  {
> -	struct qstr qstr;
> -	qstr.name = compare;
> -	qstr.len = dlen;
>  	if (likely(!dentry->d_op))
>  		return dentry->d_name.len != dlen || memcmp(dentry->d_name.name, compare, dlen);
> -	return dentry->d_op->d_compare(NULL, dentry->d_name.len, dentry->d_name.name, &qstr);
> +	return dentry->d_op->d_compare(NULL, dentry->d_name.len, dentry->d_name.name,
> +				       &QSTR_LEN(compare, dlen));
>  }
>  
>  /*
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
