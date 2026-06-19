Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249133F8B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897171; cv=none; b=iYWMCbaZZqcfHMXFsBp8PS+0EZ+plcjsAxMjW7XTOkZ//n8iuPT5cf7vbse+NcDnwL4J/33OYcFDb88yqFAbUl81CLh1XImLYuYEa+Qt3PCnQI5Yj0rVo5G2Zj27MzjYPIcNT9v3QXafCSxyrnnGk1Em3SlNL6wvaMgfAAy7f18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897171; c=relaxed/simple;
	bh=tFd8vutGtIovkSPr2D4GpH7sEREAm2kJ/LYVYEhhg6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgoAaUfhhObLxHvlmhKRfHUBYD9xVCwrgOIuvxXnhIXnkIcyvVyVrmasQSdBPEkhxq1cFGQbPUcuGL+rvjwy4gyZ3CijZ4vyExfYG8/qrhjLH1qUzOJa5K1gJZUuJ3WE6mtAk1i9hQm1sK4gX5jFW832C3UpXWtSbY2OsWynzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oMEO8hZa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bTCPSDDb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=06fyhC6H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JeIK+lkQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oMEO8hZa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bTCPSDDb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="06fyhC6H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JeIK+lkQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CBEA6D951;
	Fri, 19 Jun 2026 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781897168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdvOATWDJgsgvJ4pTMkmozjLJqD5xTNUgtRdb7I0nlA=;
	b=oMEO8hZaAB3s+yMA3xxmwcE96tG6O97KNtS/9p8M7zkAfahUukMyrolns/UC/uiOhX6cKy
	zw96pI8H8R3UxobMu2v3dJqosw9bpYnwYlh807U7WhhY82ndp4nkCkDuBgSpNBFPNWu7Sj
	Y0lnl/MaFUMsLafPOYqINGtwOdHCPRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781897168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdvOATWDJgsgvJ4pTMkmozjLJqD5xTNUgtRdb7I0nlA=;
	b=bTCPSDDbbYCypVwaT1zoifJOs+W7Kk0oOX5w+E4OeC+1WG4FylOZc60OZdHKRO64BokwM5
	Fqhcd2e/ZflMUoBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781897167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdvOATWDJgsgvJ4pTMkmozjLJqD5xTNUgtRdb7I0nlA=;
	b=06fyhC6Hc4LG7XFbzycWP5Nshs3yEiLXtlTcbzFg89KEbdJyCRrf6nxIYS61Ekp1MTo8xe
	IcN+Jqrc+pCFfYTX0w1jh2x9eiPfl+3Bi547DhRBYUtTA4Y5X+glZtD4lSuZt56FmWmeMZ
	21SMexJn5qSq3vbpnnoakXkvJVVKY7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781897167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdvOATWDJgsgvJ4pTMkmozjLJqD5xTNUgtRdb7I0nlA=;
	b=JeIK+lkQc7kqWzspBwkOBkhSZJmVrKSExZWW84cZYO5e6kEdZTkGQ0slsfkZXV8hABe+VP
	aCUHzA35//8rdQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD73B779A8;
	Fri, 19 Jun 2026 19:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gPtPLs6XNWo4OwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 19 Jun 2026 19:26:06 +0000
Date: Fri, 19 Jun 2026 20:26:05 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Frederick Mayle <fmayle@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajWXEn7gECvgG7F5@pedro-suse.lan>
References: <20260619112852.104213-1-ljs@kernel.org>
 <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org>
 <ajV0TbwEyaKMzoa6@lucifer>
 <ajV49Fyogfa6aIjy@pedro-suse>
 <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org>
 <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:helo,pedro-suse.lan:mid]
X-Spam-Level: 

On Fri, Jun 19, 2026 at 10:52:07AM -0700, Suren Baghdasaryan wrote:
> On Fri, Jun 19, 2026 at 10:46 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jun 19, 2026 at 10:43:06AM -0700, Suren Baghdasaryan wrote:
> > > > Yeah, the mmap usage on SVT-AV1 is a little suspicious, but I guess the
> > > > pattern may come up time and time again for people doing chunked mmap
> > > > reads. I think we need to take a closer look at this change.
> > >
> > > Frame-by-frame mmapping for a streaming workoad is quite questionable
> > > IMHO and I don't think we should be optimizing or encouraging such
> > > usage, but I understand the reasoning for the revert.
> >
> > If userspace is properly tuned, it doesn't need automatic readahead
> > at all; it can disable it and issue manual readaheads.  The point of
> > automatic readahead is to cope with userspace which is doing stupid
> > things like calling read() for a single byte at a time.
> >
> > Could it have better defaults?  Maybe!  It's worth a try.  But those
> > attempts need to have a very low bar for reversion when it turns out
> > they affect other workloads.
> 
> That what I meant in the last part of my reply :)
> 
> But in general, I think that benchmark measuring "how many frames per
> second a CPU can encode" should be revised so it doesn't depend on
> file prefetching mechanisms. Otherwise it's measuring something else.

To be clear, that's not (necessarily) a benchmark, the code we were
looking at is their encoder app.

(it's also generally not possible to prefetch the whole thing into RAM
because, well, raw video files are quite large)

-- 
Pedro
