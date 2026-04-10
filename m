Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C902BE644
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829515; cv=none; b=YcpWvM6dDZUvd2RcXOejAoDSUuLBfh2jxQcpaQdiZazSKszV2Zcw6N4mxqsljIqqngsZTKM+tBQQw8/3jUTI61f5Usem2nlHgO6IMDy9sEUYa6pUSk3ucM8FO3AFrz6b6vR/qxC2VYmpw2uMlrRGcU/N8KVKicw7Yby3EFy0fNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829515; c=relaxed/simple;
	bh=ln2b9l9WAdYUbN9CbMsn1nZ0voo3wyCIe1fahqqjUTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgSrbitmiitpQfvPDVz+Yh8GHvgIO4lSb6KYIpqBjEdkUfo/5g9vP44HHbHvxVEPS0Q+kQ/0yaoMcU4FuIWgKS1ALsjwx+czAFdmHMco7gbefc7QkPHRaMxfgxtzGMGS9EHTNkpKmls8Be0poEYS/sVj8MwpDtHXwzQ+5cU/zRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vWZbIC2N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KsEebD9c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJqwGUfF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O/BHxZuF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vWZbIC2N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KsEebD9c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJqwGUfF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O/BHxZuF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 968725BCD3;
	Fri, 10 Apr 2026 13:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775829512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RVDMTcGQhdEmFHIKJeFRI47IlLZziJTl8kPSrRvHwM=;
	b=vWZbIC2NF8lkBqvyg0/EKfRmpKCfCO8hWFxuxCG/0dqa35SGiEkRtyN9ux11DxKdWxsB9d
	6LVXevyYhjYl0xDX8a4MUph28w13wGTbnS4KKqURt7I6kHLw2jf1npOneAHXUvG/h6o5O4
	pWjaUSPmK2k8Ruq03LEXNFU2Sho5y1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775829512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RVDMTcGQhdEmFHIKJeFRI47IlLZziJTl8kPSrRvHwM=;
	b=KsEebD9cw7SKDbtzjRs+Gy0ivdIvMTCEHq7de8c68gdHEukRkKEFz2AiZtpAQFso9XnKU0
	iSZt9REZLnlOgDAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775829511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RVDMTcGQhdEmFHIKJeFRI47IlLZziJTl8kPSrRvHwM=;
	b=IJqwGUfFZOg6Ih1PGrjkVkCodwQXc9MzVBVf4F2uPkGyiaonkUmB5VJ/i3zHDmUKBtMBx/
	9we4LYDep/v1o6fOy24k8F8PG74KW/pSg4O6gUn0RNUYw7ll4D42pUmI991YWSb/ctgO59
	ivVKlB2m5Zbqg2xqTjwOnHDem+kvqFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775829511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RVDMTcGQhdEmFHIKJeFRI47IlLZziJTl8kPSrRvHwM=;
	b=O/BHxZuFthF5OZ99+JtGVSFI5mxo4uruRfNy8NVjgRY6DST5ZIPGNPcabwMNbYhsCtIkJc
	7pUBpxPp0JHXiFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 889D24A0B2;
	Fri, 10 Apr 2026 13:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PCJUIQcC2WlASgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Apr 2026 13:58:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3C560A0A81; Fri, 10 Apr 2026 15:58:27 +0200 (CEST)
Date: Fri, 10 Apr 2026 15:58:27 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Boris Burkov <boris@bur.io>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <ntokc2yg35cn5etqp4bljd7wkbt2tydl2hhpxamh5svoikzv2k@zvbpiymsxozv>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <CAOQ4uxgYYt8LQqR+feSwqGccqD7Ns3sNgiVHw76mYsbKSwq5ng@mail.gmail.com>
 <20260409164834.GA3472346@zen.localdomain>
 <adjaHn7RnvaMp7mc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adjaHn7RnvaMp7mc@infradead.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bur.io,gmail.com,suse.cz,vger.kernel.org,kvack.org,infradead.org,lists.linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Fri 10-04-26 04:08:14, Christoph Hellwig wrote:
> On Thu, Apr 09, 2026 at 09:48:34AM -0700, Boris Burkov wrote:
> > > > This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> > > > and they can work on freeing memory needed for freeing of hard to reclaim
> > > > inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> > > > they should really be addressed.
> > 
> > One question that pops in my mind (which is similar to an issue you and
> > Qu debugged with the btrfs metadata reclaim floor earlier this year) is:
> > what if the hard to reclaim inodes are the *only* source of significant 
> > reclaimable space?
> 
> (disk)space or memory?  If this about disk space, make sure your file
> system ENOSPC handling triggers inode reclaim, XFS already does it.
> 
> If it is the only source of memory we just need to do the slow reclaim
> to gain memory.  You better use mempools or similar to make it safe.

AFAIU he spoke about memory. Yes, mempools are the standard answer for
guaranteeing forward progress but in this case good luck with properly
tracking down all that needs to be "mempoolized" (and how large the pools
should be!) to guarantee you can run transactions to cleanup inode - for
each filesystem. I don't say it's impossible but IMO its way too big effort
for the gain. So I think just throttling hard to reclaim inode creation is
way more practical solution, although strictly speaking you cannot
guarantee forward progress in all the insane configurations you can think
of.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
