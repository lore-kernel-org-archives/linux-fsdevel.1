Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817727;
	b=jOHBut9RC9xc8WRDi65Ov06r0uXX1WBJqu5YMl1juToL+jUO4ZNBIuHADasjT6NQFSyq
	 B4eBmpCr2a/tqcYZW9KaeN6u9qs2EYvv5DwcN98mfMiFh1IPZAQP/uQ2wpyc+Sdsa9Oq8
	 7NnIfrFdsvrV64wfxRyV4kYPAF8c6kDRQuxJESUvysksSA94+L/ICnl3gsNezB1ESubjr
	 +aXmAsQGcHFRqdiMw/2b2mF2qSSTmtUwtyPpqw95p/h6SW4ng9pqDWAKyTAxYktRi8DGq
	 +EklOGdXQjSUxnMHL7Mh6vyCnWT5bJsWJe9fMTofMeOKMuh02u/b9RxhE+0Kan52PvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817727;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=RN/B4N8caDlaycAleYE1eEx7HfJ61p5JGE1Xsxo0c2U=;
	b=JLY0Y4O0WOOo0n2W1eo3IwKZ75geIFnuUr93oh4FdjWp0zSWDzC/6ZBocQUfufy9jn7F
	 giTBoBTm0w3K71JQldUM/5/0FIqNxo6VHegoMTZKLpCHMKDjn4sqdnyOUxw1QyNzTYuDz
	 cBw4j7Z0Tzi7GFvK2NhQekb9DLob0qll+54bHfilN7rFnqgxRrW8eE0RuUqaFNXEunvOP
	 2+I4wql/ZmtuefcoSnXr34pw2PaWb7tfa8X4UBeQmzh5a+jekzl44zQ1K1WlIArJSWfmu
	 F9Bd47XzKz7qlurJtcogQ9jEDjt/+lTjpE2s8kzCb8DOimitN45oqy8ztLHnFyjmbiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hKxBmuPW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QUL6W3jH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hKxBmuPW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QUL6W3jH;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96144606A31E;
	Fri, 27 Nov 2026 22:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96144606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hKxBmuPW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QUL6W3jH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hKxBmuPW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QUL6W3jH
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0DAA1FE50;
	Fri, 27 Nov 2026 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795817724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RN/B4N8caDlaycAleYE1eEx7HfJ61p5JGE1Xsxo0c2U=;
	b=hKxBmuPWjwk1OXmTM4Wm7OwsAF/UcSrNjkeBGyq1seGNljMTKooCco5tV5TIPYOWpcbjLl
	cfVVfzPUtPqsaachD+iuwsYhhfSzqyg///KN2OqugZFfqLytUUUYcgGhlieeEwWl8U/d1F
	TACRCts70EMexEobu4a1zyxXhwZGwKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795817724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RN/B4N8caDlaycAleYE1eEx7HfJ61p5JGE1Xsxo0c2U=;
	b=QUL6W3jHVbLqIEXq1Knc5v0gTslFRVOOZvrbjoASjm7e93tMKDSLr8K7D5Va0hOkP8zFGc
	kO3DoEkJyqKtDKBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795817724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RN/B4N8caDlaycAleYE1eEx7HfJ61p5JGE1Xsxo0c2U=;
	b=hKxBmuPWjwk1OXmTM4Wm7OwsAF/UcSrNjkeBGyq1seGNljMTKooCco5tV5TIPYOWpcbjLl
	cfVVfzPUtPqsaachD+iuwsYhhfSzqyg///KN2OqugZFfqLytUUUYcgGhlieeEwWl8U/d1F
	TACRCts70EMexEobu4a1zyxXhwZGwKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795817724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RN/B4N8caDlaycAleYE1eEx7HfJ61p5JGE1Xsxo0c2U=;
	b=QUL6W3jHVbLqIEXq1Knc5v0gTslFRVOOZvrbjoASjm7e93tMKDSLr8K7D5Va0hOkP8zFGc
	kO3DoEkJyqKtDKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C558D134E8;
	Fri, 27 Nov 2026 22:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jT/OJPoACmtnKgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 27 Nov 2026 22:15:22 +0000
Date: Fri, 27 Nov 2026 22:15:21 +0000
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
Subject: Re: [PATCH 3/4] mm/mprotect: fix unpaired notifier start at address 0
Message-ID: <awoA3jdrhuogntQD@pedro-suse.tail5790ac.ts.net>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
 <20261127-mlock-madvise-mprotect-ai-fixes-v1-3-e46b2b1eb435@kernel.org>
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
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-3-e46b2b1eb435@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[cs.cmu.edu,linux-foundation.org,readahead.eu,google.com,kernel.org,infradead.org,cmpxchg.org,redhat.com,suse.com,lwn.net,linuxfoundation.org,rere.qmqm.pl,arndb.de,canb.auug.org.au,arm.com,coda.cs.cmu.edu,kvack.org,gmail.com,vger.kernel.org];
	R_RATELIMIT(0.00)[to_ip_from(RL45qnsmh45s86h1s1babgqt3g)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30

On Fri, Nov 27, 2026 at 07:45:42PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A protection change on a VMA that starts at address 0 can leave an MMU
> notifier invalidation open forever.
> 
> Waiters for its end, such as kvm_swap_active_memslots() and
> mmu_interval_read_begin(), then sleep uninterruptibly and never wake up.
> 
> Fix by using a boolean value to track this instead of the start address of
> the range.
> 
> Fixes: a5338093bfb4 ("mm: move mmu notifier call from change_protection to change_pmd_range")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: commit msg tweak ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
