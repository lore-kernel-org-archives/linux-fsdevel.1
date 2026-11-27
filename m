Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817686;
	b=3JvTS3cTXonhhwzntgm3WIcyaTGHmggVRqbBqbhyLhCq2CZlKk/05vFykVCm9rmwJveQ
	 Hsjf4CZ6/3GR5M8JqF8M2wTLszEk/+7eGZ2kShymeee2FX/Pai2V3U3d4dsL3xLH525xI
	 cCp0QlM8XwFYDKgsYoSIpoHCmkGRcEqHdGIRXT1ceqY5u09lAooE4iumb4Ig1YyJ//Fpq
	 vvTevd+AMrjQwL92tIrGHuk6yovsnQryZuioYM+NrWs5GnN0lJRH5UC3z3zaYA4037Qk8
	 k61cfzXcv8bwu1uTUmwLiGsuOruCfWF74BAt0rOGxWg4Gvv9CPNu5hjJkdHlnLAbdqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817686;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=3Bi05ngae937veh3VTPCl3E+t1DmeQqROSZ274a2qhw=;
	b=Jp1PuOkcauaAIB1waT9o5+ZPqhkYcM7wyLJ4XN9j4ZZB9vS2P4+tQPL3g2+bc70Kuu/k
	 uoV2mX0zMNWIyuaWirWzBIUPuGpI7LNl/hGiezel5X07i6sPnX0JR+DQh9pgP7OlunNaV
	 D+7dGxuEidmtsaqB/4aPAD6gM3lkSNj94fBi2nVpRywwjzt3NGjeHXYWj3toqIkspL3dB
	 u9O1vxlGwE/l39S9AGVR9ebMejlShYUOrsv0/bPvvFdqtr8x1oGiTi/M+p2ztYLgi0cM8
	 F+llyaE9Gzfy0ktAL+ZFjGJVWJ7oUb9iEDXCOaEyW+5yXkkKnjh000oX1XmqjyeV+JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=arSMc7Jk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xzmt3b16;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=arSMc7Jk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xzmt3b16;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7972606A31C;
	Fri, 27 Nov 2026 22:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7972606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=arSMc7Jk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xzmt3b16;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=arSMc7Jk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xzmt3b16
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 945F521CCB;
	Fri, 27 Nov 2026 22:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795817683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Bi05ngae937veh3VTPCl3E+t1DmeQqROSZ274a2qhw=;
	b=arSMc7JkORFVEr/Ng4920N9REF+5mWhQYk9Vbe06+nDQ+Lpxr0w1oc+N0aTyOWn37BsY6Y
	ULK9ZOpM4vJughdfsjvUBAk7eBgOt/moe9xiqS0ESwqWkyQC34PTCsfjHuUiVHWA9GHEEe
	xTvpHfzgRmwWng4AbKqGzqeMK1pZyrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795817683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Bi05ngae937veh3VTPCl3E+t1DmeQqROSZ274a2qhw=;
	b=xzmt3b16eGWvBe6vNk78O3ka+SO6Nqz7t8hhrHRxf9l87ulmLm2N7l65Xc0Fq6P1JMzgQK
	bqRkDQ/nl57MYBCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795817683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Bi05ngae937veh3VTPCl3E+t1DmeQqROSZ274a2qhw=;
	b=arSMc7JkORFVEr/Ng4920N9REF+5mWhQYk9Vbe06+nDQ+Lpxr0w1oc+N0aTyOWn37BsY6Y
	ULK9ZOpM4vJughdfsjvUBAk7eBgOt/moe9xiqS0ESwqWkyQC34PTCsfjHuUiVHWA9GHEEe
	xTvpHfzgRmwWng4AbKqGzqeMK1pZyrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795817683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Bi05ngae937veh3VTPCl3E+t1DmeQqROSZ274a2qhw=;
	b=xzmt3b16eGWvBe6vNk78O3ka+SO6Nqz7t8hhrHRxf9l87ulmLm2N7l65Xc0Fq6P1JMzgQK
	bqRkDQ/nl57MYBCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92313134E8;
	Fri, 27 Nov 2026 22:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2bMxGNEACmuzKQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 27 Nov 2026 22:14:41 +0000
Date: Fri, 27 Nov 2026 22:14:39 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Andrew Morton <akpm@linux-foundation.org>, David Rheinsberg <david@readahead.eu>, 
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Jann Horn <jannh@google.com>, Alex Shi <alexs@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>, 
	Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Arnd Bergmann <arnd@arndb.de>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org, Andrei Vagin <avagin@gmail.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 2/4] mm/madvise: don't declare OOM for MADV_WILLNEED
 swapin
Message-ID: <awn_JzICZBkxK8Qn@pedro-suse.tail5790ac.ts.net>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
 <20261127-mlock-madvise-mprotect-ai-fixes-v1-2-e46b2b1eb435@kernel.org>
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
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-2-e46b2b1eb435@kernel.org>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[cs.cmu.edu,linux-foundation.org,readahead.eu,google.com,kernel.org,infradead.org,cmpxchg.org,redhat.com,suse.com,lwn.net,linuxfoundation.org,rere.qmqm.pl,arndb.de,canb.auug.org.au,arm.com,coda.cs.cmu.edu,kvack.org,gmail.com,vger.kernel.org];
	R_RATELIMIT(0.00)[to_ip_from(RL45qnsmh45s86h1s1babgqt3g)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Nov 27, 2026 at 07:45:41PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> MADV_WILLNEED on memory in swap can OOM kill a task when the memcg that
> the swap entries are charged to is at its limit.
> 
> The hint is only a prefetch, so it has to give up on a page when memory
> is short. But swapin_walk_pmd_entry() and shmem_swapin_range() call
> read_swap_cache_async() with GFP_HIGHUSER_MOVABLE and with the gfp mask
> of the mapping, so the allocation and the memcg charge can both go as
> far as the OOM killer.
> 
> The charge goes to the memcg of the swap entry, which need not be the
> caller's.
> 
> The fix used here is to allocate with the gfp mask of readahead, and to
> flush the block plug when a page fails. madvise_do_behavior() plugs the
> whole walk, so the swap writes of reclaim can sit in that plug. Their
> folios stay under writeback, and with no retries the rest of the range
> can fail as well.

How about we don't do that? Something something separation of concerns.
If we want this functionality (and we very well might), I would suggest
we do this in reclaim code itself. Something like

blk_finish_plug_or_flush().

Because I really don't want to set the precedent of making every direct reclaim
caller aware of block plugs.

Either that, or we let it fail.

> 
> The hint can now skip pages when memory is short, whether in a memcg at
> its limit or on the system as a whole, since neither the allocation nor
> the memcg charge is retried any longer.
> 
> This applies in particular where reclaim has to write to swap to make
> room. Skipped pages stay in swap until a fault reads them.
> 
> Fixes: 4c6355b25e8b ("mm: memcontrol: charge swapin pages on instantiation")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: commit message tweak ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Aside from the above:
Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro
