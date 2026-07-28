Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAA3C457A
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234816; cv=none; b=gsCyRgX/TZG9mWZlE6QWpsX4+/lpCi+DjYcRJjSJsyuITtxpTv+QX0+oX55z/V08pv11Nh6ZSR4PkwopQqmXgSE3Folo/vgCcLBWiA27BS5RpzHL59A7dr4hvY4VuaeY6xOZCXb3ewrjGM54VRMCaZ2fTaaCzIREIGMvo3dEYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234816; c=relaxed/simple;
	bh=JEt36yDDZEL76dFXO9sxOTJSXmNdJgGVjufpHh89Ko8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsBzjo6FcKXS9Wcg123VZSdlLAtARa6C1HRrHOwj0jetUjcIUn369T0ngX1WQULOfAFJiehnWdptSqXu1TUrZqTvV7meUT1LOY47I/GBEKjw///KvG44JcaeF5WDvnBU0IsJm3Sb1RV9XcH88N588I4ncONvYARG678pgk5g7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hmspDYhX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dfv9hSEH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vrM7+Kpp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=15VO8SDD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hmspDYhX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dfv9hSEH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vrM7+Kpp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="15VO8SDD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3524B3E03;
	Tue, 28 Jul 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785234809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ScQ16CMjFlPTjKS2k1tW3rCTBpjt7WhqtuW+Eef6SU=;
	b=hmspDYhXrp6nsKgIWnShKcP3m1zateD3bEY3uR3GMErFfIxMI9+7/9QdoMY1OSL1i+d9Ny
	ss+c7CzUHS0b0s/s+ubeJoKE314FUJcdwBRgQPnYA3jZnGclfq6lclfmk1jrAfkFHmjPXD
	ALydB6hGuiNUAt7T35xwF/Q7tGqIIw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785234809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ScQ16CMjFlPTjKS2k1tW3rCTBpjt7WhqtuW+Eef6SU=;
	b=dfv9hSEHvWLKGMbbBNhVjCDz2vk/P4DzXoOYrI4DR42iExQvjuX+5M9j7wSOSUNUvXU0J9
	pxBzL3eURvkQWNAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785234805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ScQ16CMjFlPTjKS2k1tW3rCTBpjt7WhqtuW+Eef6SU=;
	b=vrM7+KpprfezwZJiC2tqWLgrwHwaue0fD8f19jQfJUlGkmYWSlvkowfoF2O9cJqSfmnc2E
	2eRBmU3pjwhTkWXbEm98yaEC3/yIJSvaC3seVOLe1nBu+YacKViosmAP40ubcTMimr6XR/
	8Xli5LeJ4agy1c0nCZRnAXLzkzRjoIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785234805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ScQ16CMjFlPTjKS2k1tW3rCTBpjt7WhqtuW+Eef6SU=;
	b=15VO8SDDjXpk6nGQsh3OpyKNDkmPEvq+Y5DXMA1IPu2e8rn0UdJqkJ/eKY1HHB5Xqxfpku
	TyjJh3Fea260PcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 261BF779B1;
	Tue, 28 Jul 2026 10:33:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mOr2BXSFaGppLAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 28 Jul 2026 10:33:24 +0000
Date: Tue, 28 Jul 2026 11:33:22 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Bo Zhang <zhangbo0325@gmail.com>
Cc: fmayle@google.com, jack@suse.cz, akpm@linux-foundation.org, 
	david@kernel.org, kaleshsingh@google.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, ljs@kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev, 
	oliver.sang@intel.com, surenb@google.com, willy@infradead.org, baohua@kernel.org, 
	Bo Zhang <zhangbo56@xiaomi.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5:
 pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Message-ID: <amiCX6kcQneMZu3-@pedro-suse.lan>
References: <CAHCxdc64d-6qNBwwSZX8mdz4-V+88No2x0wG4mex5WPXBDE9AA@mail.gmail.com>
 <20260727014610.3479784-1-zhangbo56@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727014610.3479784-1-zhangbo56@xiaomi.com>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon, Jul 27, 2026 at 09:46:10AM +0800, Bo Zhang wrote:
> On Thu, Jul 23, 2026 at 01:34:38PM -0700, Frederick Mayle wrote:
> > I maybe missing something subtle, but, I think you've changed it from "don't
> > read beyond the VMA" to "if there is a chance we could read beyond the VMA,
> > don't read beyond the VMA", which seems like a more complex expression of the
> > same behavior.
> 
> Hi Frederick,
> 
> The subtlety is in how async readahead interacts with _max_index. The two
> are not equivalent because async readahead sets ra->start to the end of
> the previous readahead window, not to vmf->pgoff. So even though the user
> is still faulting well inside the VMA, the readahead target (ra->start)
> has already moved past the VMA end, however _max_index blocks it.
> 
> Here is the concrete scenario (ra_pages=128, VMA covers pages 0-1023):
> 
>   1. Fault at page 0 triggers sync readahead: reads pages 0-127,
>      places PG_readahead marker at page ~96.
> 
>   2. Sequential faults continue. Fault at page 96 hits PG_readahead,
>      triggers async readahead in do_async_mmap_readahead().
> 
>   3. page_cache_async_ra() detects sequential pattern (index == expected)
>      and does:
>        ra->start += ra->size;  /* pushes start to end of previous window */
>      So ra->start = 128 (NOT vmf->pgoff=96), ra->size = 256 which is doubled
> 
>   4. page_cache_ra_order() calculates:
>        limit = min(file_end, ractl->_max_index)
> 
>   With the unconditional approach:
>      _max_index = 1023 (always set)
>      limit = 1023, ra->start(128) < limit (It works fine here)
> 
>   But after several ramp-ups, when the window reaches the boundary:
> 
>   5. Fault at page ~896 hits PG_readahead, async readahead fires.
>      page_cache_async_ra() does ra->start += ra->size:
>        ra->start = 1024  (previous window ended at 1023)
>        ra->size  = 128
> 
>   6. page_cache_ra_order():
>        limit = min(file_end, 1023) = 1023
>        ra->start(1024) > limit(1023) (Which will read NOTHING)
> 
>   Result: page 1024 (in VMA2) is never prefetched. When the process
>   enters VMA2, it takes a major fault and readahead ramps up from scratch.

That's on purpose.

> 
> With my conditional approach:
>   At step 5, vmf->pgoff=896, vma_pages_left = 1024-896 = 128
>   128 < 128 (the condition is false), so _max_index stays ULONG_MAX
>   ra->start(1024) < ULONG_MAX, and it will prefetch pages 1024-1151 normally.

This is exactly what we're trying to solve.

>   Page 1024 is already cached when VMA2 is entered, only minor fault happens.
> 
> The key point: when mprotect splits a large file mapping into adjacent
> VMAs (common for ELF segments, or read-then-write patterns), there's no
> benefit in preventing readahead from crossing the boundary, so the data is
> still sequential in the file. The limit only helps when we're actually
> near the end of useful data (within ra_pages of the VMA end).

This is completely missing the point. This change tried to back off from
reading _anything_ past the VMA _on purpose_, due to ELF file spillage. This
patch reintroduces spillage in a very obfuscated way.

-- 
Pedro
