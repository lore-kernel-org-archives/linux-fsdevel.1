Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485534534B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992078; cv=none; b=Uc/ZSpxeB91TIdNAUYsqqi2JhTVxVI/Ud0xFfRztlVToS+n7R8g9IVdxEYSPXMu0TgTop+1eYwMHA0+E1rpZbqoMo8fVbCpXkGokAm/R6jc4GhgMvx5uC4mFX3oInwrnkuZizNJGJmrqSrGbik6b1dgiodFKm1fLYY1PH1B5rvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992078; c=relaxed/simple;
	bh=5GMRx+RGj0GfKQqYkNUz0E+HE02JDPPg5CEANTUb7ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnQ6CXjcI8uSX0FVUYDaaC86pWQEMRxRZXdGPNfvE/6MPVcQOU8pCpySNsQGdXBtz9aHSu0McW/yyos6zDFpgZaMyCZwFyut+CJavwsx3XH3RhmapdDleZq7J2vClQn1eXFjAn5/D9vtRYrt8xbOkrTwXovNUEUcQbUm7Sl8GDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EhtxzyQz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFjM2dkE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EhtxzyQz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFjM2dkE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhtxzyQz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFjM2dkE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhtxzyQz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFjM2dkE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BCC44D26E;
	Tue, 31 Mar 2026 21:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774992069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnzfKx5Upeq/sF2uvwEe4YZyvV2k+Y/3mRbeHnU7NJU=;
	b=EhtxzyQzbVQ14mggnEpjSxkIC2WylB1t6EbM7WDwcNztbysjdELWGO/mJnRRVyA0IXR9pp
	ZbwH9tojogXEWuyafJ4/5dkLBR5Uk8kd1djdo+sHCEHl51M5lBhLMAH4gGjkJA+t1pJDHg
	w6Xn6gvc81/83T9L1OLH38064QGDa3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774992069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnzfKx5Upeq/sF2uvwEe4YZyvV2k+Y/3mRbeHnU7NJU=;
	b=aFjM2dkETsCQMCG8uA5usKaTPAe1nobM/5cMrIzcNefEP4NbOqrBNX/IJhrgm6SJ4NojnT
	RERPzGMe+zFLu6AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774992069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnzfKx5Upeq/sF2uvwEe4YZyvV2k+Y/3mRbeHnU7NJU=;
	b=EhtxzyQzbVQ14mggnEpjSxkIC2WylB1t6EbM7WDwcNztbysjdELWGO/mJnRRVyA0IXR9pp
	ZbwH9tojogXEWuyafJ4/5dkLBR5Uk8kd1djdo+sHCEHl51M5lBhLMAH4gGjkJA+t1pJDHg
	w6Xn6gvc81/83T9L1OLH38064QGDa3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774992069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnzfKx5Upeq/sF2uvwEe4YZyvV2k+Y/3mRbeHnU7NJU=;
	b=aFjM2dkETsCQMCG8uA5usKaTPAe1nobM/5cMrIzcNefEP4NbOqrBNX/IJhrgm6SJ4NojnT
	RERPzGMe+zFLu6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72F954A0A2;
	Tue, 31 Mar 2026 21:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IWUKHMU6zGn8PwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 31 Mar 2026 21:21:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3213FA0AFD; Tue, 31 Mar 2026 23:21:09 +0200 (CEST)
Date: Tue, 31 Mar 2026 23:21:09 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: gregkh@linuxfoundation.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: replace ints with enum component_type for LAST_XXX
Message-ID: <2pzoyiq5xcuj5bix37ikli24k22l5cgcz5zygyxheoxro5pgh3@jwri2dpuhuyu>
References: <20260331173726.3517440-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331173726.3517440-1-jkoolstra@xs4all.nl>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,brown.name,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Tue 31-03-26 19:37:22, Jori Koolstra wrote:
> Several functions in namei.c take an "int *type" parameter, such as
> filename_parentat(). To know what values this can take you have to find
> the anonymous struct that defines the LAST_XXX values. I would argue
> that the readability of the code is improved by making this an explicit
> type. Also, when we have this "enum component_type" is does not really
> make sense anymore to talk about LAST_XXX, but we should just use XXX,
> as there is nothing specific about the component type showing up at the
> end of a path.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks fine to me besides one whitespace damage. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -3009,12 +3010,13 @@ struct dentry *kern_path_parent(const char *name, struct path *path)
>  	CLASS(filename_kernel, filename)(name);
>  	struct dentry *d;
>  	struct qstr last;
> -	int type, error;
> +        enum component_type type;

Damaged whitespace here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
