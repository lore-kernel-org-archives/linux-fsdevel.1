Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACC220F2A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095131; cv=none; b=PMklBKeM99wIoagyF4p7hncA2wjkjIIsjKfz8LBGIelDnvFnzyuqkv41K2KKk66+ldP/hl8ayrD6jLfXsoDRmtufO3HsXSRTyEz0YjeOxnSiIMc5eVHUR2mgwT+3wf5WWO3RduxfEj//dezZlCuMMMWpICjrJ34WUfRgMmOPSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095131; c=relaxed/simple;
	bh=vRzj5Flh5u+C5ern6lzsIE9rix1S1n2DW5JsYl+5qkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaXLVMUzKeyBfP3aj0fMFnGWzGnLwT0puBlM8l6Eog4XOCl6zE3k2MsjBnMtJ3RbtrGLxZkpFtKqy7UvozoGeTofujjmrCa6EUPzOuo5MwSPKG3DXFPrLEZ5jzw5/04Ma2XcZIVZWZ73+ANOpxEBZAX+0Z2+MLA/8n0T6N7XL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vTwkZoVz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u/wHFMc+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vTwkZoVz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u/wHFMc+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vTwkZoVz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u/wHFMc+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vTwkZoVz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u/wHFMc+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7328D749DF;
	Fri,  3 Jul 2026 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783095128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijMtc3MCBHGNOviCoWJsWrc7FWeY40uHwWhK+MEoRA0=;
	b=vTwkZoVzpGLu2AJifs6k5D87jzoN03Eoq9YSel5GpDQKUBQcYPf+gUEn0Mve9ZtWrBcYwd
	tUGGMAsx77ofnLG2Zuc4i1UoLbijh6T6gmfcRfO0Qp+qQUz9xEKyvlxtiBSx+pkP4QDmvS
	KnjcxapUOt/FY0K9blDxvUE2zL5VPvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783095128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijMtc3MCBHGNOviCoWJsWrc7FWeY40uHwWhK+MEoRA0=;
	b=u/wHFMc+jC5mJ3GYVfq4ZGPYnWhHClXiC3lua/CLdum/oZxn9ehREW9LHZci7SbXiLQSC+
	0gaNTlJjK+g44qCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vTwkZoVz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="u/wHFMc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783095128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijMtc3MCBHGNOviCoWJsWrc7FWeY40uHwWhK+MEoRA0=;
	b=vTwkZoVzpGLu2AJifs6k5D87jzoN03Eoq9YSel5GpDQKUBQcYPf+gUEn0Mve9ZtWrBcYwd
	tUGGMAsx77ofnLG2Zuc4i1UoLbijh6T6gmfcRfO0Qp+qQUz9xEKyvlxtiBSx+pkP4QDmvS
	KnjcxapUOt/FY0K9blDxvUE2zL5VPvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783095128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijMtc3MCBHGNOviCoWJsWrc7FWeY40uHwWhK+MEoRA0=;
	b=u/wHFMc+jC5mJ3GYVfq4ZGPYnWhHClXiC3lua/CLdum/oZxn9ehREW9LHZci7SbXiLQSC+
	0gaNTlJjK+g44qCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69C50779AA;
	Fri,  3 Jul 2026 16:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LtzQGVjfR2qKfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jul 2026 16:12:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C007A12D4; Fri, 03 Jul 2026 18:12:08 +0200 (CEST)
Date: Fri, 3 Jul 2026 18:12:08 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	aivazian.tigran@gmail.com, Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH v3 07/19] fs: Provide way for filesystem to wait for
 metadata writeback
Message-ID: <htrzdu5r74ge6o5i3iwiznz6gdrdnhxtvvlzga6hywpgyehwbx@uy74ybyggrvf>
References: <20260702175436.12226-1-jack@suse.cz>
 <20260702182057.2832980-26-jack@suse.cz>
 <20260703-erdumlaufbahn-sippenhaft-windungen-c95dd273fffc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-erdumlaufbahn-sippenhaft-windungen-c95dd273fffc@brauner>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7328D749DF
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,mit.edu,mail.parknet.co.jp];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri 03-07-26 12:06:05, Christian Brauner wrote:
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index fdb8766d275a..9d96357731a3 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1851,6 +1851,22 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
> >  		if (ret == 0)
> >  			ret = err;
> >  	}
> > +
> > +	/*
> > +	 * Do we need to wait for inode metadata IO possibly submitted
> > +	 * by previous WB_SYNC_NONE writeback?
> > +	 */
> > +	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync &&
> 
> Does this patch need to come earlier in the series before the ext2 and
> ext4 changes? I'm asking because ext2 - I think - changes behavior in a
> similar manner in an earlier patch.

There's no strict ordering between these changes. But logically I agree it
makes sense to put ext2 changes together after this patch so I'll reorder
them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
