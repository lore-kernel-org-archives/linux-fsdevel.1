Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57C4A49A5;
	Wed,  2 Sep 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361128; cv=none; b=eR1b8I1ue2MrdNjhN6/CQdM4/FAPZ4Cee7DMyfi1XQqagzsEL0kjkSfMqB3dDYlZ/HihKs7O0DWI9M0rv8WAuKanuouqLqm/F2Sw9Xy3Tix/D9WUs3G+LlbFpgr++XWtKi0hmk/25ME077MBWWws6ifFHLRL+sukBbNO6tf+u7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361128; c=relaxed/simple;
	bh=vpggP7lwsnCu6s/sqVOT2I8xNLpL8MOaBeFDV9e/ajY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbyIo/BbzG+uyoEfJFKYEn5l62TyEVZ516Bm1aZ4tjFZVdkT4XHc1T347ff9X1cwc52T5dTg9cQUYbFs/aa/hciiz3ulLdkLu59h6r7PyQFocgv+jIESiv+DVS+RwR0GUJuK7pfWrUdjHV9sXhZVMOB2LZcAlBzQy47M98C7ak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yB4II0i0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vw6IATGV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aYHKtq46; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HrSxe+Yz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yB4II0i0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vw6IATGV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aYHKtq46";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HrSxe+Yz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C79D21FB1F;
	Wed,  2 Sep 2026 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788361117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+gn1TAUO4/JHYqM9pNukdAnd9lWGs9C3oFxBr7I6LA=;
	b=yB4II0i0MBU7zS5j/xSWF32ik8O3RA4ImGCMDSNFcDBim5FAi39Ct4aiKMAlX9GYiQWUKv
	J1QGJiIepDAM01WetOkL0vRXo8+005nUmeHYkDMih2Sq6ZSSAc2p5fEGRAu1ylMSDJyteR
	utJa7+yyDoBT+i+2XC/CqVMVQ4Imbcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788361117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+gn1TAUO4/JHYqM9pNukdAnd9lWGs9C3oFxBr7I6LA=;
	b=vw6IATGV16sYLj6IghrydJ+GqQCy5ZVQKXab/WOFjQ2LyXuM6cgtZjGsJZ7jWb0GBsIyUR
	8dPEaIzX6Fh8chBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aYHKtq46;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HrSxe+Yz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788361112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+gn1TAUO4/JHYqM9pNukdAnd9lWGs9C3oFxBr7I6LA=;
	b=aYHKtq46F2CoMksVaFbUxgiNgtz9AbZkmUClCqqE396U4EUGEbYSl3zNVpN/sA6a25lUQC
	1TXgWtZkNiaRGyr7/C5HUEGSdp31OWorBUnvGvCx1hi2eQEf5viaOOKmGJqtwMCGpgjiad
	p9N8O0zhhVkEV/Zzomxm4z1V+54Si4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788361112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+gn1TAUO4/JHYqM9pNukdAnd9lWGs9C3oFxBr7I6LA=;
	b=HrSxe+Yz7nWi5vVuEcn9hTc530rXE1eyHhw7KCmGkEXyK9qmghZAyJQAzp3zxbQaUn+/aU
	QHMeV6nuqe0t2vBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DB4613888;
	Wed,  2 Sep 2026 14:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q9wUC5c5mGq1NAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Sep 2026 14:58:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F442A13B5; Wed, 02 Sep 2026 16:58:30 +0200 (CEST)
Date: Wed, 2 Sep 2026 16:58:30 +0200
From: Jan Kara <jack@suse.cz>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: locking: Fix bracket
Message-ID: <ffoup27vuua4yo5weeyhgdjevtb4c2nkoz45lkk5kzipnnhzsn@wckefd3i2vv4>
References: <20260902143936.703665-4-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902143936.703665-4-manuelebnerli@mailbox.org>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C79D21FB1F
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,mailbox.org:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 02-09-26 16:39:38, Manuel Ebner wrote:
> Remove needless '(' from code block.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
> Should I also replace ')(' with ') (' as it is in the second code block?
> It would improve readability in my opinion.

Dunno, at least I'm used to the way which is written here :)

								Honza

> ---
>  Documentation/filesystems/locking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 844d65eb4..1598cf555 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -27,7 +27,7 @@ prototypes::
>  	int (*d_init)(struct dentry *);
>  	void (*d_release)(struct dentry *);
>  	void (*d_iput)(struct dentry *, struct inode *);
> -	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
> +	char *(*d_dname)(struct dentry *dentry, char *buffer, int buflen);
>  	struct vfsmount *(*d_automount)(struct path *path);
>  	int (*d_manage)(const struct path *, bool);
>  	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
