Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7544344D9D
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776508240; cv=none; b=X2xH849ODcQvSRyRLQRFEKs3S2FQFj/mFA5imWkDJApdrQwCCywww1uLNRoUIFb6UrBsHMSHYFjFmN39AQhh9BKFFo5jmS3xqAr1jp5UvrpK4jvVG2+nHDWb1jhMzD53FoUv7zVm/F99WMVxS7nl0R4HpYIxRjWpP4+QHwK9/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776508240; c=relaxed/simple;
	bh=rBloWKDWgYPzre+W5AlpJe79+C5VF9VexWZPi3ZTRfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miUvqNODl/OZtqGMamxGxy7n3xy1dSLEhSz4T55IGA18ljzb12QBP4lwrZP/xgVzsUwujcUiKEDIgt3p/d9oLhXVO4Od9xq5/0MzEawAOjNCGUj9B8et9T1qZQalGOWDiDvK66ucGbtygxSaUX0X7bEb3cdu8U3uuolR7UZgKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JSyIjTdB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/UfXae9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JSyIjTdB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/UfXae9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JSyIjTdB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/UfXae9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JSyIjTdB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/UfXae9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5325BD77;
	Sat, 18 Apr 2026 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776508229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdKG/KmJpak/xxnBuBjYgqMCvpf5rsslxsUnd4fHZII=;
	b=JSyIjTdBdNbHVH1E3bvEcVquoy5Z8ytzV+BXiM9JUvmJkp1TkFTJW2DswPhWBAkAQJCHEg
	PvbiR/gwSq8I1+1J4mqpyX9s7CL5mDqT0/KtvPr/cC3O+TMPgItEVj9B9YAAau5YvELRLY
	zN2xhu84P5YXZbZ5Kxs8W8kSLELPvEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776508229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdKG/KmJpak/xxnBuBjYgqMCvpf5rsslxsUnd4fHZII=;
	b=G/UfXae9u1Bd3AUIU8Otuyrv08UV3aIOwgPn0hscT0IYSZVjJF4ijolyRGT2J6lC2EH1S0
	mJIvIdSXVFUUKPAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JSyIjTdB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="G/UfXae9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776508229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdKG/KmJpak/xxnBuBjYgqMCvpf5rsslxsUnd4fHZII=;
	b=JSyIjTdBdNbHVH1E3bvEcVquoy5Z8ytzV+BXiM9JUvmJkp1TkFTJW2DswPhWBAkAQJCHEg
	PvbiR/gwSq8I1+1J4mqpyX9s7CL5mDqT0/KtvPr/cC3O+TMPgItEVj9B9YAAau5YvELRLY
	zN2xhu84P5YXZbZ5Kxs8W8kSLELPvEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776508229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdKG/KmJpak/xxnBuBjYgqMCvpf5rsslxsUnd4fHZII=;
	b=G/UfXae9u1Bd3AUIU8Otuyrv08UV3aIOwgPn0hscT0IYSZVjJF4ijolyRGT2J6lC2EH1S0
	mJIvIdSXVFUUKPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F400593A3;
	Sat, 18 Apr 2026 10:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xrf0CkVd42nrHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 18 Apr 2026 10:30:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C1BABA0B59; Sat, 18 Apr 2026 12:30:20 +0200 (CEST)
Date: Sat, 18 Apr 2026 12:30:20 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: use kmalloc_flex() in __d_alloc
Message-ID: <574rawzolpt6nsivt5esobahydjata5t2bryw7nbgz3sbzfnhc@7js5cjjcurq5>
References: <20260417094238.551114-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417094238.551114-3-thorsten.blum@linux.dev>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 3E5325BD77
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 17-04-26 11:42:40, Thorsten Blum wrote:
> Use kmalloc_flex() when allocating a new 'struct external_name' in
> __d_alloc() to replace offsetof() and the open-coded size arithmetic,
> and to keep the size type-safe.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index dbcbd0affb26..4568f9530166 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1753,10 +1753,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  		name = &slash_name;
>  		dname = dentry->d_shortname.string;
>  	} else if (name->len > DNAME_INLINE_LEN-1) {
> -		size_t size = offsetof(struct external_name, name[1]);
> -		struct external_name *p = kmalloc(size + name->len,
> -						  GFP_KERNEL_ACCOUNT |
> -						  __GFP_RECLAIMABLE);
> +		struct external_name *p;
> +
> +		p = kmalloc_flex(*p, name, name->len + 1,
> +				 GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>  		if (!p) {
>  			kmem_cache_free(dentry_cache, dentry); 
>  			return NULL;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
