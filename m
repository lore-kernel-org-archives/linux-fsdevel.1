Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C173A7589
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854582; cv=none; b=ahmSmesAvmuCJ5SbjH7DEti+p8GqvQ8akRQM91cfMcNu7jkxFEYfwKDzcwdn/6YzlGZEvkn7rMmUN6XwpAZJbreeL7OqNGibyjuYptfFBZh1hN0iCIdy8YalR0dKOIGjZWzP/7O/uULM3JzNB5kCj+gWWc0hn3LrgwTpQHvXwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854582; c=relaxed/simple;
	bh=u5h1iMm+UdmBguTD7VzXdISEESTRwksw5WhA5Mz1VmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfk96sJkHJBUtJxU1zztjYKlr1RKIzJNVc9pvL3CPx7xdkeRWikcm5F+I6Pls3AknfewNrNWrSgOKvPnSkXfQjvP2HV0xjfxlVXUlo0yyy/A+5BdqmRbHVBmM/bHoMfYBZVla9Emu/6+Xrv9mlXataNPKYXZSjpxzqfFFbYatB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0fShj+ey; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wwMK+R/+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0fShj+ey; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wwMK+R/+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0fShj+ey";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wwMK+R/+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0fShj+ey";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wwMK+R/+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7010F5BCC2;
	Fri, 10 Apr 2026 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775854579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9xV/M6Pi9WCMcCVh2ICHJHx7WicuWqDuyCYoEzfrvE=;
	b=0fShj+eyLYcH42qGsifiG+T1YV+qRicGtDlmj5P8iSkveXQTnctTHfC7uDhZDTbJNxndyO
	+OOqm4O/rkP3nJWuxswUizI2ZWbIWfD1PbLD70M1QMP9dZ9+zDqzCo2eD/kXYv3XLPc8pa
	R4GsXuJ2GFIh9Lq174kDeSmyU5q7qwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775854579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9xV/M6Pi9WCMcCVh2ICHJHx7WicuWqDuyCYoEzfrvE=;
	b=wwMK+R/+26mPovnVbd28xQmOTAYS6sLxiOgm/LSCrCC9XAVn4ZeS90VNYnb/YYt/nNxaVA
	WsQwMpoNIpbk/iAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0fShj+ey;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="wwMK+R/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775854579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9xV/M6Pi9WCMcCVh2ICHJHx7WicuWqDuyCYoEzfrvE=;
	b=0fShj+eyLYcH42qGsifiG+T1YV+qRicGtDlmj5P8iSkveXQTnctTHfC7uDhZDTbJNxndyO
	+OOqm4O/rkP3nJWuxswUizI2ZWbIWfD1PbLD70M1QMP9dZ9+zDqzCo2eD/kXYv3XLPc8pa
	R4GsXuJ2GFIh9Lq174kDeSmyU5q7qwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775854579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9xV/M6Pi9WCMcCVh2ICHJHx7WicuWqDuyCYoEzfrvE=;
	b=wwMK+R/+26mPovnVbd28xQmOTAYS6sLxiOgm/LSCrCC9XAVn4ZeS90VNYnb/YYt/nNxaVA
	WsQwMpoNIpbk/iAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 667C84A0B2;
	Fri, 10 Apr 2026 20:56:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jZkAGfNj2Wm8XQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Apr 2026 20:56:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2C8CA0B52; Fri, 10 Apr 2026 22:56:14 +0200 (CEST)
Date: Fri, 10 Apr 2026 22:56:14 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <4q7d2bi2qjg6crznvr55yfnv2gcomfqdt5j2dgkrwp5hh3ynqo@cfgy5o53zjwr>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <adikj3y6OXgSyObW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adikj3y6OXgSyObW@infradead.org>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 7010F5BCC2
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 10-04-26 00:19:43, Christoph Hellwig wrote:
> I think a patch is more useful than a discussion here, that idea has been
> voiced multiple times, and effecticely implemented in XFS.

I know but after thinking for some time I wanted to get some feedback
before I start coding.
 
> Trying to lift the XFS logic into the VFS and finding other consumers
> for it would be very helpful.

I hope not to get all the complexity of XFS but we'll see :)

> > 1) Filesystems will be required to mark inodes that have non-trivial
> > cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> > whatever :)). Usually I expect this to happen on first inode modification
> > or so. This will require some per-fs work but it shouldn't be that
> > difficult and filesystems can be adapted one-by-one as they decide to
> > address these warnings from reclaim.
> 
> I think otherwise we call this dirty :)

Yup :) I was considering for a while to use another kind of dirty flag for
this and then clean it from flush worker but in the end I decided against
it as it would be IMHO confusing.

> > There's also a simpler approach to this problem but with more radical
> > changes to behavior. For example getting rid of inode LRU completely -
> > inodes without dentries referencing them anymore should be rare and it
> > isn't very useful to cache them. So we can always drop inodes on last
> > iput() (as we currently do for example for unlinked inodes). But I have a
> > nagging feeling that somebody is depending on inode LRU somewhere - I'd
> > like poll the collective knowledge of what could possibly go wrong here :)
> 
> I've heard this theory multiple times, but we really need to valide that
> we don't need the LRU.  It also doesn't really solve the above problem,
> as we still would not want to perform the expensive inode inactivation
> work inline with the last dput.
> 
> So while this might be worth investigating, please keept it separate.

Ack. With the point Jeff made about NFS revalidations I agree it won't be
straightforward.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
