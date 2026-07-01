Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C63F871E
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900791; cv=none; b=mkYVeIqIHftU9kd+BMMz40QGBHtE/ZhfrsCHY6+ekwbnAp3OLseP472axAfVME01ylRD0EQg29YM2Mr4yVUZ1qLmrHYs5sXot8Lz3Hm6s/J2G40CPPcTmtP8cOisgmjkv6ky/I0rjZRhuMAchG1JFIBAtCkqNK3cZ/kGnV2RZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900791; c=relaxed/simple;
	bh=KX5qNTYx6yij/qMwvM14hODxXSQJIaitR/QcfoOYarc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNsN1iL181OcK5POC8ofLxUaeojInNra9rD20lW9i4rPp5fk2XWtZOlCFibU6Ml9vPHtl4zRVf747G01s63z47Ns6RdYpB86511orphCWoA/tDE67vWHjrk+MZhVMoADsJcdpItNcmpfW0daGM2l4edSsiuMqEwuIesl+3hBVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rOvSg2nJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EbbUjiGy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rOvSg2nJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EbbUjiGy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rOvSg2nJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EbbUjiGy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rOvSg2nJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EbbUjiGy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2EB2872013;
	Wed,  1 Jul 2026 10:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3TJ9p6nuilGiLvVShi++XWOIUNy82df3+BieSNANVs=;
	b=rOvSg2nJxvglWGXcpbaeTTM+LXSa5f57iD6Vv/yjaxAAdO5belxVQA8QTVLKiLfx6Ke9fw
	Refai7qkaXJOmiaGRZomNUrSnxlf6RHLB/N/4ksdOh7fkG60JBxr4bGRvUjRI7torAqJBk
	jOhjsSwzYY2p+Lq28eJCxH+3lyAO13Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3TJ9p6nuilGiLvVShi++XWOIUNy82df3+BieSNANVs=;
	b=EbbUjiGy89Vsqq4LDAB12hPAfmYdxA4bFzmy6IsJQH+crIDVvluOUoltmEjsbsdKnFntYb
	ruKaCaUhSF5OcwCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rOvSg2nJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EbbUjiGy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3TJ9p6nuilGiLvVShi++XWOIUNy82df3+BieSNANVs=;
	b=rOvSg2nJxvglWGXcpbaeTTM+LXSa5f57iD6Vv/yjaxAAdO5belxVQA8QTVLKiLfx6Ke9fw
	Refai7qkaXJOmiaGRZomNUrSnxlf6RHLB/N/4ksdOh7fkG60JBxr4bGRvUjRI7torAqJBk
	jOhjsSwzYY2p+Lq28eJCxH+3lyAO13Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i3TJ9p6nuilGiLvVShi++XWOIUNy82df3+BieSNANVs=;
	b=EbbUjiGy89Vsqq4LDAB12hPAfmYdxA4bFzmy6IsJQH+crIDVvluOUoltmEjsbsdKnFntYb
	ruKaCaUhSF5OcwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B9F779AA;
	Wed,  1 Jul 2026 10:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nLX9BzToRGrQQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Jul 2026 10:13:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2D8AA10B7; Wed, 01 Jul 2026 12:13:03 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:13:03 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/31] ocfs2: dlmfs: drop redundant S_IFDIR from mkdir
Message-ID: <eyflzaf4cjlvqkmjyfl4yvp5zcadtp6nzhhol3xdh27x667qu6@h546cinhhccz>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260630105400.68459-23-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105400.68459-23-jkoolstra@xs4all.nl>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
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
	FREEMAIL_TO(0.00)[xs4all.nl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2EB2872013
X-Spam-Score: -4.01

On Tue 30-06-26 12:53:51, Jori Koolstra wrote:
> vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
> ->mkdir(), so OR-ing S_IFDIR into the mode again in dlmfs_mkdir() is
> redundant. Drop it.
> 
> Assisted-by: Claude Opus 4.8 (1M context)
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/dlmfs/dlmfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 5821e33df78f..dc538fd8d9f8 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -422,7 +422,7 @@ static struct dentry *dlmfs_mkdir(struct mnt_idmap * idmap,
>  		goto bail;
>  	}
>  
> -	inode = dlmfs_get_inode(dir, dentry, mode | S_IFDIR);
> +	inode = dlmfs_get_inode(dir, dentry, mode);
>  	if (!inode) {
>  		status = -ENOMEM;
>  		mlog_errno(status);
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
