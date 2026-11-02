Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624889;
	b=vzPRLiYacYHYx+XNVCkNINaMiqkju1uX7QrYsaFl4RM0K2SspCWf6wOCF42gsFFG4XTj
	 jtyTg+zNpzTqHJoS6SaLBptcAHkIycWfpsAPF4Gq9sXeET+DEyflkjh6ONA7hGCznHJCo
	 fUKv1hUszo4v6BrZo6AcG6Oj/2lwOvLRMqjSzODy5Yk5d4ZeOSu+ajou34BTycMbs6e20
	 kf5uzeTvlT//4VkUjEhwc/ra333rUPi8Y8ewd1kJIlq/n95DBdYNHjYOFLH+ZzgOoE2Ml
	 toBFYtLpjP82ZyEijWH8j1vf/t0dEvbEPTZeP6FlOHCckm/D8kuLT45wni/QpYTR8HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624889;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=g3tTgLkyAwBFWlCI/FbAHsBH9T0WE64sP/L2ZFLzl+s=;
	b=jTXmvJlfoXlbvNjpuXL+vPZFhMRnNtbrLVeQgJrtN5qi+q4unOG0qMlKTRl8p5ie94uU
	 tWavz/pVcNEvNtDn2i5dPzQumxbS0CJOwfTHKXHcYfn88HEW7oEmyMlLIyZMh/n+l1OoB
	 4e7W3NVgxlcQzGykCRCAs6o05QDiac2b6tlmgR9iHQGtbBtEIOkkGuufr16gHgOCcm+E3
	 I2O6yLbZvXNInMXKF19Wbj0Jq8hVdGjlVc53HQbNeWecQZHi0NHlftJZ74Dcue80JzC5J
	 bLlSggpBlQIIC8GxEEekW5XXBk6cz9pO7Yv9Y8VVvhzq7/qmrWUwbVV6QU1V+mlbfUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T+jtve37;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BNTmvdF+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T+jtve37;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BNTmvdF+;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A51606A326;
	Mon,  2 Nov 2026 13:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T+jtve37;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BNTmvdF+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T+jtve37;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BNTmvdF+
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D167C21DC3;
	Mon,  2 Nov 2026 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793624886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3tTgLkyAwBFWlCI/FbAHsBH9T0WE64sP/L2ZFLzl+s=;
	b=T+jtve37/06SQqCKBcPZN/o6MfxbnDZaT1HKv4egW5dbUAFZAia6uyfaN66ds1tlXwvLOE
	CcSn9/fc7w9enekMovX8wGQl9E5ATpd0l93SKl+agmLVPPpFYLON+L07QQrMW7UVbmfcbJ
	ybnWPiqfzR7LgUdAefKOGr/QRT6xamg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793624886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3tTgLkyAwBFWlCI/FbAHsBH9T0WE64sP/L2ZFLzl+s=;
	b=BNTmvdF+MgOrfF46D4oqTIWLXOAg9Nmzi9uj1klzhcnEeekbsvQnG1rKOFn4Cg6iGMs9DS
	9FYa7OdkCVPcEoBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793624886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3tTgLkyAwBFWlCI/FbAHsBH9T0WE64sP/L2ZFLzl+s=;
	b=T+jtve37/06SQqCKBcPZN/o6MfxbnDZaT1HKv4egW5dbUAFZAia6uyfaN66ds1tlXwvLOE
	CcSn9/fc7w9enekMovX8wGQl9E5ATpd0l93SKl+agmLVPPpFYLON+L07QQrMW7UVbmfcbJ
	ybnWPiqfzR7LgUdAefKOGr/QRT6xamg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793624886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3tTgLkyAwBFWlCI/FbAHsBH9T0WE64sP/L2ZFLzl+s=;
	b=BNTmvdF+MgOrfF46D4oqTIWLXOAg9Nmzi9uj1klzhcnEeekbsvQnG1rKOFn4Cg6iGMs9DS
	9FYa7OdkCVPcEoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B05CD1351F;
	Mon,  2 Nov 2026 13:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B547HjWL6GpyYgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 02 Nov 2026 13:08:05 +0000
Date: Mon, 2 Nov 2026 13:08:03 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, david@kernel.org, 
	ljs@kernel.org, jannh@google.com, liam@infradead.org, willy@infradead.org, 
	paulmck@kernel.org, usama.arif@linux.dev, vbabka@kernel.org, 
	linux-fsdevel@vger.kernel.org, yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
Message-ID: <auiKq8zbQTMyY2tG@pedro-suse.tail5790ac.ts.net>
References: <20261101154503.3203036-1-surenb@google.com>
 <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30

On Sun, Nov 01, 2026 at 11:01:00AM -0800, Andrew Morton wrote:
> On Sun,  1 Nov 2026 07:45:03 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > Pss metrics can be affected by map count even if VMA tree stays unchanged,
> > therefore tests checking VMA tree integrity can't use them. Use Rss instead
> > and pre-populate the VMAs so that Rss changes if a VMA gets skipped or
> > double-counted.
> > 
> > To ensure all test VMAs are populated with anonymous pages, remain
> > mergeable across VMA operations, and do not have their Rss changed by
> > memory reclaim:
> > - Toggle PROT_EXEC instead of PROT_WRITE between adjacent test VMAs so
> >   all test VMAs remain writable and MAP_POPULATE faults in anonymous pages
> >   (rather than the shared zero page, which is not accounted in Rss).
> > - Use mprotect() instead of mmap(..., MAP_FIXED) in split_vma() and
> >   merge_vma() so the first page of the split VMA stays resident.
> >   mprotect(..., PROT_NONE) splits the VMA without unmapping the first page
> >   (pte_present() remains true for PAGE_NONE PTEs), and
> >   mprotect(..., self->mod_info->prot) merges it back. Both parts of the
> >   split VMA retain their non-zero Rss.
> > - Lock all present pages in the child with mlockall(MCL_CURRENT |
> >   MCL_FUTURE | MCL_ONFAULT) so memory pressure cannot reclaim pages and
> >   alter Rss during the test.
> > - In remap_vma(), unlock next_addr before mremap(..., MREMAP_DONTUNMAP)
> >   so next_addr is not split, use mmap(..., MAP_FIXED) in patch_vma() to
> >   merge the middle VMA back into addr, and exclude smaps_rollup tests
> >   from test_maps_tearing_from_remap since remapping moves and unmaps the
> >   page from next_addr.
> 
> Thanks.  This is proving tricky.
> 
> My evolving reviewbot still isn't happy:
> 
> : This fixes the v1 RSS issues, but two things remain.
> : 
> : Alternating PROT_EXEC breaks with READ_IMPLIES_EXEC: both mappings

This is nonsense btw. Not sure we'll ever support random personality()
flags being set on selftests.

-- 
Pedro
