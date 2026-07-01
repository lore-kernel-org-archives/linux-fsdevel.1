Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A443416D03
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900739; cv=none; b=unfGc0bZ3RSxEnVyYj2cm1f7C9EOids9vcU3unkXDnhPnZBh6z4VcJdv9Zc+cYSzcOfn/I8wfxaowffytJH3APyNdE+FjY/ToxDOo8M4Z2OrKc2vGsMFQcbzDc3YyioyVtHkflRovZIDLPj0NUrDY1dukg7y2uuEO6ba+neJm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900739; c=relaxed/simple;
	bh=OUctuitR7UIadANLjl421Z5t6Oezp4iPMsg4QnNoEjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/bd32y/Cf5zKqrKunAhkrH1zJe1yj3/DAAWfnKOByqGxwzaNSjKPziUN36HwdvAIl4+2n/lNwQcxE5ArP2YIKduQ7L4dpv7EY4lso/1731U4fOmrGi3luCKR4e38CqqcSChaonVQAyma8p1W6moeCsogVzN61sYbGHBrcqSRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPEzHiNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UcnDp5qv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cPEzHiNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UcnDp5qv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPEzHiNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UcnDp5qv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cPEzHiNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UcnDp5qv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74A3F72013;
	Wed,  1 Jul 2026 10:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gl25i9vm01Q0gEOg+Lx3z5uTosFbSYDEM89XHc/Y4k=;
	b=cPEzHiNbRPB+rx6SIWofuaHfRVaTkODKV4B4Mo/22HRNUAifdt9WsdkwVk51vYoPhJrQdJ
	9NuMnbKngcxTegZSzWc2vEq8/mb+gITc3PciYIFXSGyBbq+O/xuUXj5w3P6GA8nbpXsNPM
	eSXgQCwQsfWZO4ks/3HKoWJjXntjRQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gl25i9vm01Q0gEOg+Lx3z5uTosFbSYDEM89XHc/Y4k=;
	b=UcnDp5qvVHQeuHWMtP7PrrhIKY1E0vfV0FWCCmX/m1l+LG+/C+918hhoUUkMq7AF7rgoXY
	vSctps79bEdcRTBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cPEzHiNb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UcnDp5qv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gl25i9vm01Q0gEOg+Lx3z5uTosFbSYDEM89XHc/Y4k=;
	b=cPEzHiNbRPB+rx6SIWofuaHfRVaTkODKV4B4Mo/22HRNUAifdt9WsdkwVk51vYoPhJrQdJ
	9NuMnbKngcxTegZSzWc2vEq8/mb+gITc3PciYIFXSGyBbq+O/xuUXj5w3P6GA8nbpXsNPM
	eSXgQCwQsfWZO4ks/3HKoWJjXntjRQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gl25i9vm01Q0gEOg+Lx3z5uTosFbSYDEM89XHc/Y4k=;
	b=UcnDp5qvVHQeuHWMtP7PrrhIKY1E0vfV0FWCCmX/m1l+LG+/C+918hhoUUkMq7AF7rgoXY
	vSctps79bEdcRTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E6AC779AA;
	Wed,  1 Jul 2026 10:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8k8FF/7nRGqRPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Jul 2026 10:12:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F1642A10B7; Wed, 01 Jul 2026 12:12:09 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:12:09 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/31] ocfs2: drop redundant S_IFDIR from mkdir
Message-ID: <aj4xnbm3wf7qi3kbnrggf3pyjeenyu3fsfpwa4trz6fvoelffn@erxa5nxv35su>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260630105400.68459-22-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105400.68459-22-jkoolstra@xs4all.nl>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,xs4all.nl:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 74A3F72013
X-Spam-Score: -4.01

On Tue 30-06-26 12:53:50, Jori Koolstra wrote:
> vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
> ->mkdir(), so OR-ing S_IFDIR into the mode again in ocfs2_mkdir() is
> redundant. Drop it.
> 
> Assisted-by: Claude Opus 4.8 (1M context)
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 1277666c77cd..b87eb6a2fa38 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -657,7 +657,7 @@ static struct dentry *ocfs2_mkdir(struct mnt_idmap *idmap,
>  
>  	trace_ocfs2_mkdir(dir, dentry, dentry->d_name.len, dentry->d_name.name,
>  			  OCFS2_I(dir)->ip_blkno, mode);
> -	ret = ocfs2_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
> +	ret = ocfs2_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
>  	if (ret)
>  		mlog_errno(ret);
>  
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
