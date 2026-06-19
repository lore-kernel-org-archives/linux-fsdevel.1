Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFA2F2910
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889506; cv=none; b=tAml2K4+zF/mlwCKVwzUe6MpXe360TZOyQwYv5+IP75dtxmgx9Hd3B8aP1qnAEgk4zCexHfMTVkYcdZ6DOF51E5q7AHs7fiiX7sb2+9AtvigkwxuAFgYr3PMKO4blx/fMKOnlQD0rUKQ24ifEPRCG9wes4LcX5ELcL3aX8i9B44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889506; c=relaxed/simple;
	bh=loZ+dplKhOFGCeSjvWox/68AKGxqKy+MC5j72RugbGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANGbpXxsiXO6ZlCn4pIt1P+W2S853rsHOAJHiUN815xbeia7oO+yFRnQv34o3i6jxhb5WMcdRBXLr4sZinSU1v0l8iyXYn80IEvQisxYbCBw5lOvSqvzW5A+9jelXdt0/5QiJO+pTr6tOmN28XyBpRfF2QYL4ujHP/XqRhystOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uWBRj2KH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xEFirPK+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VmI8JyI5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QbBLgmTW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uWBRj2KH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xEFirPK+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VmI8JyI5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QbBLgmTW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD4A26DA90;
	Fri, 19 Jun 2026 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781889503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oqPpewONjUG7ValzHPKgr56a2oPjvYPPkirjUicRP8=;
	b=uWBRj2KHeH/VdEln9lE0zJGzrD3Rsjo2qvigFa9RJFnl3W0mRwK4kHc3Aa4fX9C/6aROEi
	GjxjptELaUhb659lHo45VA5bYewDgjlD4ZYprKPlaMHtAA+lzKu/EcvqXnAiERLFLI8pBc
	qcRPSy5OUQZuGPoDSw+kyY/ubczq9uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781889503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oqPpewONjUG7ValzHPKgr56a2oPjvYPPkirjUicRP8=;
	b=xEFirPK+ac4gMVnxt0HjyAp0+gUgMbnxLCEgB3ZL1GcHkT/qLmhZVSXltHHsVlPM01+qLY
	bNL+Wqdk0tiVMmBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VmI8JyI5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QbBLgmTW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781889502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oqPpewONjUG7ValzHPKgr56a2oPjvYPPkirjUicRP8=;
	b=VmI8JyI5c3QN5t0j/8lz0RSLO0cxyyWmDioT/AKIdNasMGrwbKJsMCK3AOEoxyoTWyEnna
	91e2cXEKw91DHAwP5fCdy3gxrbxJs1eS20vP8jwRfvEa7sBhk5q2qJidk/AQLAZ6i/Ag9R
	kHPimRnB9ZRpX7ShT9AUe6OKFW88UYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781889502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oqPpewONjUG7ValzHPKgr56a2oPjvYPPkirjUicRP8=;
	b=QbBLgmTWa6XvIUrZCT7X88SCJxb2z81dSoArM9vgo36gCqu01H8Zr7XmIH+pdSMIBAqvEK
	HgEIagkEhphrdwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7620779A8;
	Fri, 19 Jun 2026 17:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wWAvNd15NWqnQgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 19 Jun 2026 17:18:21 +0000
Date: Fri, 19 Jun 2026 18:18:20 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Frederick Mayle <fmayle@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajV49Fyogfa6aIjy@pedro-suse>
References: <20260619112852.104213-1-ljs@kernel.org>
 <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org>
 <ajV0TbwEyaKMzoa6@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajV0TbwEyaKMzoa6@lucifer>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AD4A26DA90
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, Jun 19, 2026 at 06:07:30PM +0100, Lorenzo Stoakes wrote:
> +cc Suren, Pedro, David - I messed up the cc on this patch.
> 
> On Fri, Jun 19, 2026 at 05:52:38PM +0100, Matthew Wilcox wrote:
> > On Fri, Jun 19, 2026 at 09:37:11AM -0700, Andrew Morton wrote:
> > > On Fri, 19 Jun 2026 12:28:51 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> > >
> > > > This reverts commit 7b32f64bc512b40b268776c5ac4d354b325b3197.
> > > >
> > > > This patch caused a significant performance regression, so revert it, and
> > > > we can determine whether the approach is sensible or not moving forwards,
> > > > and if so how to avoid this.
> > > >
> > > > There was a merge conflict with commit de97ae6222c1 ("mm/readahead: no
> > > > PG_readahead on EOF"), care was taken to ensure that the revert retained the
> > > > behaviour of this patch and cleanly reverts commit 7b32f64bc512 ("mm: limit
> > > > filemap_fault readahead to VMA boundaries") only.
> > >
> > > I'm a little conflicted here.
> > >
> > > 7b32f64bc512 avoided readahead of "file pages outside the mapped
> > > region", which is clearly desirable (arguably a bug fix?) and we care
> 
> I wouldn't say it's a bug fix? The kernel has always done this with no reported
> bugs.
> 
> > > about performance of executable mappings.  Whereas it isn't clear that
> > > we care about whatever the heck that test case was doing.
> > >
> > > IOW, the revert might make the kernel worse, overall.
> > >
> > > If someone plans to get down and analyse that test case then come up
> > > with a new version of 7b32f64bc512 then OK.  Is there such a person?
> > >
> > > I'll park the revert in mm-unstable for now, but would prefer not to
> > > rush it in until we better understand what's going on with that test
> > > case and what can be done to address it.
> 
> As Willy points out [0], we've identified that it's a real usecase that we're
> regressing.
> 
> There's likely others too in the real world.

Yeah, the mmap usage on SVT-AV1 is a little suspicious, but I guess the
pattern may come up time and time again for people doing chunked mmap
reads. I think we need to take a closer look at this change.
> 
> This approach has also not been without debate in the past (see [1]), I think
> this patch slipped under the radar on that front a bit.

Yeah, sadly it seems like the patch _may_ need a rather substantial rework :|
So I would err on the side of caution for now and revert it as well.

-- 
Pedro
