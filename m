Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86B3B994A;
	Tue, 15 Sep 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504815; cv=none; b=IEfCk4K/hLy9qQGV5GLpOm1zrqh9J//w99uiy1H6oQ/E3OPWMSrbCar+ON3DnKKB3NhqDwnw4mRoE+sQm6TKhiHUlFuExUoAjNAEbJ4qIgxhtOf5XYzRsLxF2tKJRTFwt1QWP68Y90S+6QbM9UHC8XNGcKSTXdB9lUG5Qhv/7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504815; c=relaxed/simple;
	bh=H7sqdoHpd2FSG6L//bvppNmxpX0j0UX5TBTUv3u03t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/aR4nJZbdl3QFm2AitjaiIA3Y5Bt0NLd1THG8f5TBK7avNTPzl3HeZY7We3ff3MStYEqkjJGRA0KE3HlO3WuaZO/rLdydAY54QpEflbUB1dN5iESmlQiDZ8s3od63jJQeBkbviIf0AuPNTAAUMGnaqYKnyQaIaSyiStjz+Egiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d/B1jdDY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LsdBuJU+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FomyFzkd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7Qqhmj89; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d/B1jdDY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LsdBuJU+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FomyFzkd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Qqhmj89"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAD911FFBA;
	Tue, 15 Sep 2026 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789504807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efWP/Ao7lVqQt3ZG5A3u/jPr1sBU0pFDIR9eFUcnesA=;
	b=d/B1jdDYPeQ89aeZHQcMAjD5rONhO9jYWhrf7fM2EjyhL5CkoaeVtIEDWyz9LiROc2TKan
	suwSz4ab9msE1MhJoQJ7wXc4ehjYkT84vw4alPDf8d1JvnGGN27pzKSVbT2VezHVkO3Msr
	TnGiHcBpPK7NAJvUGNaSI4k8Qd0NumU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789504807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efWP/Ao7lVqQt3ZG5A3u/jPr1sBU0pFDIR9eFUcnesA=;
	b=LsdBuJU+6lEUc8nySmqukGCKnfzucHOtelMRSJPxKLoyEQAT2eTvsSlo2jLMpJ55Eb9LSH
	92Q8L7XWGst/s7Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789504802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efWP/Ao7lVqQt3ZG5A3u/jPr1sBU0pFDIR9eFUcnesA=;
	b=FomyFzkdV4eQt7COT7Te9sTma/Hop5w7zjTGMaFwJBII3xUzfx5UM0+3MZht7e5sFxxQ8N
	AbNUyupH8dgsJcAHe+S57MBLv1H6yeE3QKhyWckS8ORYAB8oP4lA/5nsKT5gFGpdLQzE5k
	BXImaHKgMurWt3/N3vpMoBsNxP2WWTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789504802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efWP/Ao7lVqQt3ZG5A3u/jPr1sBU0pFDIR9eFUcnesA=;
	b=7Qqhmj89HqAXXJf47JAvCatNjEUAd4WqDKndZDTEl/qDjhucSTAZra9jrefO5t7z5mSkl3
	OYB7K9m79EL+jtAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C47C513432;
	Tue, 15 Sep 2026 20:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GmPgJyKtqWokOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Sep 2026 20:40:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49542A13D6; Tue, 15 Sep 2026 22:40:02 +0200 (CEST)
Date: Tue, 15 Sep 2026 22:40:02 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Carpenter <error27@gmail.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vfs: clean up indenting in lookup_open()
Message-ID: <hftpz62zoc7rjn3xdcaqgnujjnicpgv6betqbqfyvp45tynmep@l7m75b46jxpz>
References: <aql0YTgwtRI0VZyG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aql0YTgwtRI0VZyG@stanley.mountain>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 15-09-26 19:37:53, Dan Carpenter wrote:
> These lines are indented too far.  Delete a tab.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 1dd4ec7d0e62..48b28ed44a9e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4636,9 +4636,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (create_dir) {
>  		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry,
>  						       mode, &delegated_inode);
> -			error = PTR_ERR_OR_ZERO(res);
> -			if (!error)
> -				dentry = res;
> +		error = PTR_ERR_OR_ZERO(res);
> +		if (!error)
> +			dentry = res;
>  	} else {
>  		error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
>  	}
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
