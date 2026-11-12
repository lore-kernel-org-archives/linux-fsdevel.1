Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479791;
	b=SS5r26kRJL4G4ZxtwmI45TnYH3ltKpnyt3J3+ivy7hKs7zv7+Sg0IIWQvgVySsw8lx7M
	 wzFGDQzm78otaWR7XXQ6xXM5AZFrqFolc31cYjGqQ/2UvBaWzbHpV+QkgRgXjLK01sEDF
	 D9FZxcbH/JR52fg3oPnBTzpMcxJr5pm3nIxuslJBxHSDJD1thNpVyWbrIYj/s4l2Ct/Cc
	 tBbMkrX0ZNf0QPLojBnCbEyD7dOV7Y8L8OlYrAR+jFbWTa1xPxCUXnXS5EPx/HJLz+bpA
	 yxbYLf7PsY/5p7WVZKwl562LrQVPx2MLbHsgs/z/Mzpc67iHmKUxu2GPv0Xeu41A9Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479791;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=D/2XQ7ncDhSBVFrS9AI6XolCxT4hxWA0EjuRpadrVdI=;
	b=wagY9Q0rKjjuvjIcwxFZxTwikZY3T+r0UINE0BB0pdFjfUoxEvIAwvbB//Pr2J656ZXc
	 B6p3+sFJ0wCV1cSRtpJyKpASKDEZna8mJIQuHGxDyhYdCDWWnnzaAxX/svTe+whEg6qll
	 9Kb6tHW+dgkWSFTnqUJXJ7l32hndMweWND6heVOeSf0DeEjZ/OJCU/++i29Qc3ogtYG50
	 kq9f0ngqbwMV8O5Gr3M6HleqrbXRxhif6Npf+bGOKUMYSYd5kI1QrjLij3d0VOmQcqLPm
	 MrsqRnWkKbcW+//bAOWl7t6cQLDuWPex2qTMlIywBLJF+nCeB7OGgGRdxN+C4cM86cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tWCN2rWX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cniGN0eP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oJZZLYyR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WZ4QAStE;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AA606A327;
	Thu, 12 Nov 2026 10:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4AA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tWCN2rWX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cniGN0eP;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oJZZLYyR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WZ4QAStE
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8A2B21C76;
	Thu, 12 Nov 2026 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794479789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/2XQ7ncDhSBVFrS9AI6XolCxT4hxWA0EjuRpadrVdI=;
	b=tWCN2rWXg6Jc6hML+rU1RIt5XKgQfxl/g2XI1/mgon8qIZaTHQApi/R37OJvUSL2YIwSWJ
	16Ls8dPn6SQQx396r9SMIBmN656Why4nSIsO2Dcq5G6y0m3/02Yj1ROSPOqMc1mMWvjRsJ
	8LfzySu4Sl+wVI0a3B5QG7HF/ukk69k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794479789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/2XQ7ncDhSBVFrS9AI6XolCxT4hxWA0EjuRpadrVdI=;
	b=cniGN0ePsb+osUWCEq4BYyPuGoEI0GqMu9zJGCzrEAu9QLPtmlLdnKToVaebgW2JhLIRrR
	bH8bWuPkJYtZPJDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794479788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/2XQ7ncDhSBVFrS9AI6XolCxT4hxWA0EjuRpadrVdI=;
	b=oJZZLYyReIEzYwEkcLWh37+a9w0I2bGWD+4SpK6Fd/dGf5c7UI2wgD41ZaTW3+pOqSSVmv
	0Az5uLlUnr/634XcJUi8FuCsxMEeIbZ9XcivKpNA9RgvyGFxhbb+4NCK7hWRstDj4BVXSE
	BgP34lMlYx+Q7jdSjaiFVkWYOFe17FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794479788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/2XQ7ncDhSBVFrS9AI6XolCxT4hxWA0EjuRpadrVdI=;
	b=WZ4QAStES6ug3df4SVOPu4DwhaWzYh48R4ZUAH1bXsNAkS0mb58af8mNPw/rsrmay+0MDN
	0pcMrcxVawTBV3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC9B413432;
	Thu, 12 Nov 2026 10:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id evncKKuW9WqpTQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 10:36:27 +0000
Date: Thu, 12 Nov 2026 10:36:26 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] mm/memory: refuse to map page cache folios that are
 not uptodate
Message-ID: <avWWjD-SRRfgAWiS@pedro-suse.tail5790ac.ts.net>
References: <20261111182445.656620-1-kas@kernel.org>
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
In-Reply-To: <20261111182445.656620-1-kas@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30

On Wed, Nov 11, 2026 at 06:24:43PM +0000, Kiryl Shutsemau (Meta) wrote:
> A page cache folio that is not uptodate holds data that was never read
> in or cleared. shmem fallocate(2), for one, adds such folios and clears
> them only on first use. Mapping one hands userspace whatever the memory
> held before.
> 
> Each path that maps page cache checks for this itself: fault-around in
> next_uptodate_folio(), a fault in filemap_fault() or shmem_get_folio().
> Nothing in the mapping code does, so a caller that misses the check
> leaks stale memory silently. MADV_COLLAPSE did exactly that with
> fallocated shmem THPs until recently.
> 
> Warn and refuse the mapping in __do_fault() and do_set_pmd().
> 
> __do_fault() checks the folio ->fault() returned while it is still
> locked. For CoW, that is the page cache folio that do_cow_fault()
> copies from. do_set_pmd() covers MADV_COLLAPSE, which maps without a
> fault.
> 
> do_shared_fault() then unlocks the folio for ->page_mkwrite(). A
> filesystem that clears PG_uptodate on a folio in the page cache is
> buggy, so that window gets no check of its own.
> 
> The fault gets SIGBUS, as for a folio that fails to read in.
> MADV_COLLAPSE fails and leaves the range to be faulted in.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>
 

-- 
Pedro
