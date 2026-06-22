Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D4369D64
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120382; cv=none; b=LbeAJeTgABszrz+SfuZMk/2XqlMhD9Q3j7OEoLCNy95Qt6uuIUG8icksMayq0qnY50kOqt4BqDWNbFIi5acSzR4yqhHsxVplOh02L4eHMcgioWDBRXbHAwKy3iqcmTnNZLkbXoCD2xYPDypW9yVc4PuMfNDyVf9vx+PlL3qODSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120382; c=relaxed/simple;
	bh=96+jYLb1oZI78vaLxF5pm6/nQbLeFDmaqJrVofGEWp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf99Ft1NlzSwIFaNheyJHCsfn+1Ztg9WbMV6IvhGIV0sj3B1sssSBpmrWwuMB7ys47coJ9jZ9ANgIuWv2HAW+7WkJ4jwLdH04LqqYT1CNdjhbguQTwyIcW3oz+8E61vr58T2Rkb1LUgmhJL4+esg/LNJwxwvZFlA0bpErmnju8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CgfTfYOH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eKDzHnWl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FB4GzeeA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJzo8WJN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CgfTfYOH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eKDzHnWl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FB4GzeeA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJzo8WJN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E923275B66;
	Mon, 22 Jun 2026 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782120379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orwbBsy9A3Mw4ETnXQSohuB+yc1BDjfxHVYxLaRkDCg=;
	b=CgfTfYOHzgCuAEDV6LZxxxGIEKT93w1A9JeIJ1CENppexvpWPFKJutv3ajSWJsJfU0FH64
	sHQccFX+Iicch9cGypsO4gZmzeTHJ9pBKyOI45z2Z8wHKWZynAJDUdjH6NlSHeyHUXOBzj
	fUo2jox0tWk0NUDAPLSh6fTWro94gec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782120379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orwbBsy9A3Mw4ETnXQSohuB+yc1BDjfxHVYxLaRkDCg=;
	b=eKDzHnWlTd8E7gl331pvxrGGnSL+SLDtxZC44RBqoj/Vrk80/UfgRd9hrisd+Z/HdtHolA
	hOYnIqJ1ex4KOcDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FB4GzeeA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nJzo8WJN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782120378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orwbBsy9A3Mw4ETnXQSohuB+yc1BDjfxHVYxLaRkDCg=;
	b=FB4GzeeAVTGqfX9cH62JAiufzhjfKjEcn5R3s7WJlHH1/xiIXkBviIcj2klEQuhjUbbH8m
	U0Tcd2oVGNnA/xymmyRevtgtRqkFKbyPWtjB3ePHf8ychf6MVNmYBlXSS1wrNGmBD9vmNX
	szaAnae507RvGUeGzp1uWQ0iWbmEFW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782120378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orwbBsy9A3Mw4ETnXQSohuB+yc1BDjfxHVYxLaRkDCg=;
	b=nJzo8WJNS9zt1umxMA0YYCX7/5u1rCgVBZsUCrK49vYgGvZWYayErBZiMZPR08Vrx8WEGa
	B+yZ0CKhuvHTwAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE466779A8;
	Mon, 22 Jun 2026 09:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C2c/Nrr/OGrFNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 09:26:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 840DBA12DE; Mon, 22 Jun 2026 11:26:18 +0200 (CEST)
Date: Mon, 22 Jun 2026 11:26:18 +0200
From: Jan Kara <jack@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Frederick Mayle <fmayle@google.com>, Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <7ftrqtta2bw2xxtrzelrs46t7khr7tf2vmh2ur2mhdphtymlsr@rqbd3pfjxdp7>
References: <20260619112852.104213-1-ljs@kernel.org>
 <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org>
 <ajV0TbwEyaKMzoa6@lucifer>
 <ajV49Fyogfa6aIjy@pedro-suse>
 <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org>
 <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
 <ajWXEn7gECvgG7F5@pedro-suse.lan>
 <CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E923275B66
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.de:email];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri 19-06-26 12:33:43, Suren Baghdasaryan wrote:
> On Fri, Jun 19, 2026 at 12:26 PM Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > On Fri, Jun 19, 2026 at 10:52:07AM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Jun 19, 2026 at 10:46 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Fri, Jun 19, 2026 at 10:43:06AM -0700, Suren Baghdasaryan wrote:
> > > > > > Yeah, the mmap usage on SVT-AV1 is a little suspicious, but I guess the
> > > > > > pattern may come up time and time again for people doing chunked mmap
> > > > > > reads. I think we need to take a closer look at this change.
> > > > >
> > > > > Frame-by-frame mmapping for a streaming workoad is quite questionable
> > > > > IMHO and I don't think we should be optimizing or encouraging such
> > > > > usage, but I understand the reasoning for the revert.
> > > >
> > > > If userspace is properly tuned, it doesn't need automatic readahead
> > > > at all; it can disable it and issue manual readaheads.  The point of
> > > > automatic readahead is to cope with userspace which is doing stupid
> > > > things like calling read() for a single byte at a time.
> > > >
> > > > Could it have better defaults?  Maybe!  It's worth a try.  But those
> > > > attempts need to have a very low bar for reversion when it turns out
> > > > they affect other workloads.
> > >
> > > That what I meant in the last part of my reply :)
> > >
> > > But in general, I think that benchmark measuring "how many frames per
> > > second a CPU can encode" should be revised so it doesn't depend on
> > > file prefetching mechanisms. Otherwise it's measuring something else.
> >
> > To be clear, that's not (necessarily) a benchmark, the code we were
> > looking at is their encoder app.
> 
> Ack.
> 
> > (it's also generally not possible to prefetch the whole thing into RAM
> > because, well, raw video files are quite large)
> 
> For such streaminig workload I think read() would be more appropriate,
> and the change limiting read-ahead by VMA size would not affect it.

In fact if you look at that app, it has three different methods of reading
the input frames (mmap, normal read, fully buffered file in memory) and one
is chosen based on config option. So the benchmark apparently configures
the mmap method of accessing the input file.

Anyway I agree with you using mmap-frame-by-frame approach for this usecase
is kind of odd but not completely insane and it does demostrate people do
odd things like this. For others the usecase of Android doing tons of small
sparse mmaps into executable might look odd as well :) So this seems to be
one of the cases where it's difficult to please everybody with the same
behavior and we usually stick to the legacy behavior in cases like that (as
much as I personally find restricting mmap readahead to a VMA a sensible
thing to do). We just need to figure out how to improve the Android
usecase.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
