Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E38370D5D
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777828616; cv=none; b=MEscl8wXWj9Iu1usIihdgYygFKeQXEnrrL9H73307p+VyLxG+HKLdXYnS3Kj801f1J8KDPDRpeTALl/YSOiBdxwPJBcgoCJ99R30tXjUdpfvIzUw3y+el2aX/yC20dJgOBdtU6Cd+sIExqd2R4Ny2ctvvb6oFk4d4QfbQUzDOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777828616; c=relaxed/simple;
	bh=ehtNrUGg4B31jk7fDTF+qHrW2kqxG2N3yNcGlJkd0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rctNznYvyjvRFb0tGuUZmJvKnJ7TykhitX+FEusBg6Bc0zJF8YjNQewekcvcp5a1KMWYIz1CRFVKijbbH6NvfsUpCxvPFQpwgXJ9KSzE1Pxbb5CmiXHVo1axm9vMIbBStzMQdHH1CU8LmCCpbgBAAehaMQsyr7yz+NejZTD9I5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+LJcVBI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QizszKGV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+LJcVBI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QizszKGV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+LJcVBI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QizszKGV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+LJcVBI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QizszKGV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 594246AAB5;
	Sun,  3 May 2026 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777828611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMnlDjtPDorfK+LxpO0mE9kXpC2eJBd3Y3Tb0JnKjBg=;
	b=Y+LJcVBItvIWLZmClLkv0eww17PSqWOv0bqeLO0MBEziYVoYhugSp0pNtdHnx8BGx686fn
	ri5ZuvZ++pRvBoINATok7tzNWYW9TOVLfR4win5OwKZz0lYJWWw8+2SRfDNuw3Ti+N+DQP
	1AQycUrzefnnlRszyKiDqeb/TEC/ilM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777828611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMnlDjtPDorfK+LxpO0mE9kXpC2eJBd3Y3Tb0JnKjBg=;
	b=QizszKGVSbFankdpGeiqihBaPwK/B8hbFdqb5otdUmCmmeudDNKgX0gUE7YEAKnPk9pxaO
	Ws56X0uBvKBw9zCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y+LJcVBI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QizszKGV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777828611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMnlDjtPDorfK+LxpO0mE9kXpC2eJBd3Y3Tb0JnKjBg=;
	b=Y+LJcVBItvIWLZmClLkv0eww17PSqWOv0bqeLO0MBEziYVoYhugSp0pNtdHnx8BGx686fn
	ri5ZuvZ++pRvBoINATok7tzNWYW9TOVLfR4win5OwKZz0lYJWWw8+2SRfDNuw3Ti+N+DQP
	1AQycUrzefnnlRszyKiDqeb/TEC/ilM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777828611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMnlDjtPDorfK+LxpO0mE9kXpC2eJBd3Y3Tb0JnKjBg=;
	b=QizszKGVSbFankdpGeiqihBaPwK/B8hbFdqb5otdUmCmmeudDNKgX0gUE7YEAKnPk9pxaO
	Ws56X0uBvKBw9zCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC2BC593A3;
	Sun,  3 May 2026 17:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HKOjKQKD92ndXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Sun, 03 May 2026 17:16:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DDCB2A079B; Sun, 03 May 2026 19:16:45 +0200 (CEST)
Date: Sun, 3 May 2026 19:16:45 +0200
From: Jan Kara <jack@suse.cz>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: locking: Fix stale dquot.c path
Message-ID: <ulnz7qjfg2rj6xtgjhdhrejclzhkeacw54jsgvxkchc6wrtsul@pm4cm4mkxdtm>
References: <20260503160221.1594319-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503160221.1594319-2-costa.shul@redhat.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 594246AAB5

On Sun 03-05-26 19:02:22, Costa Shulyupin wrote:
> The quota code was moved from fs/dquot.c to fs/quota/dquot.c
> in commit 884d179dff3a ("quota: Move quota files into separate
> directory"). Update the reference.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Right. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/locking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 8421ea21bd35..277e49314d32 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -584,7 +584,7 @@ write_info:	yes		dqonoff_sem
>  FS recursion means calling ->quota_read() and ->quota_write() from superblock
>  operations.
>  
> -More details about quota locking can be found in fs/dquot.c.
> +More details about quota locking can be found in fs/quota/dquot.c.
>  
>  vm_operations_struct
>  ====================
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
