Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216528;
	b=We7L0OZkxI4WaOYgDEZLjS74+NgEHOmOoUkJr4YqtHy4LCdwxwhM+H1eTuJY9JMb3wfy
	 yFfn7kRu6L6fJfrpATLhesPeOXZEc9bKJRbcrk19Md3k13PO8/Sv8xrL1QOdORHYb9P+H
	 nTPbE8vISoLA+C4l6Ko2a23mrq1Mnx1QHiQKs3ot+7qiopCSiShCxholhJBH5ftVCbTTK
	 0h03Vl31hHpBlNDvM57PPz0bLdACdGIQzgB73bjr9CrqcwQqWCDyiHLlmaJohjH+6nMvo
	 w5gxr75jXJnanQ0FAAEvJOHI3Qu0YlMx3UoYoG9aBz7gj08TfB6bv3TV4YvwEou3ekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216528;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=WRMwPw8KdbWL+QrztS6XhfD9X02diXUtZhhuJcO8v+Y=;
	b=HtYBAx77XnSF+g5mzjHNP/coy9qBwlWgfJP6r86+L8VWmruzcXFTZjzs+S7nj3Bib8fw
	 1B/rwmN/0VUMAsN1fifMYMHWNgn+KAfG7+o+OQEtssY8+smLu90pzSrkeXXUkrbvQJiKa
	 qAFqK3tgNaH4NghKH/hjTEjr7q9DPkhs3vEpxqPOd9m4/ep3eIezeb7ksCakv/Vbi+Q1s
	 RtcW0ntm4NZSEZQF125feEo0i/FzvJNe6drWERTMlpiLmLrrjmdV0pPORAhYBwKn6FSGO
	 mSX06dlh7UyiFQq4QqIWnp0f3PWyMJRa916ad9FINWI9LZlbQ81jaHEkGOIVG+U6CYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wSEBWasx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pQSZS2rj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wSEBWasx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pQSZS2rj;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF0B606A31A;
	Wed, 28 Oct 2026 19:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF0B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wSEBWasx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pQSZS2rj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wSEBWasx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pQSZS2rj
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6307922121;
	Wed, 28 Oct 2026 19:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793216525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRMwPw8KdbWL+QrztS6XhfD9X02diXUtZhhuJcO8v+Y=;
	b=wSEBWasxpiMqwRl293U+wK3/34R5iP24e6nPBenMdMSzYUzM/OwT3UZK1LC+NpFa875quc
	NyRs/469BHQVISDWxY8xOVf6C7dCOVq5YdOn7Drq7jXBMiGzfgiDdtDBwPvR55nYRfgFZM
	cE56sKc+rTHVY/HCYyz4RZHs5MzHad4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793216525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRMwPw8KdbWL+QrztS6XhfD9X02diXUtZhhuJcO8v+Y=;
	b=pQSZS2rjh+ABytlaRvlb4XP0cUlap2GJLrpPFCRXFYS0NM0d/Q41Ts+rjGuvMddriD/sQl
	8z/8rbTZWmuLeVAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793216525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRMwPw8KdbWL+QrztS6XhfD9X02diXUtZhhuJcO8v+Y=;
	b=wSEBWasxpiMqwRl293U+wK3/34R5iP24e6nPBenMdMSzYUzM/OwT3UZK1LC+NpFa875quc
	NyRs/469BHQVISDWxY8xOVf6C7dCOVq5YdOn7Drq7jXBMiGzfgiDdtDBwPvR55nYRfgFZM
	cE56sKc+rTHVY/HCYyz4RZHs5MzHad4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793216525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRMwPw8KdbWL+QrztS6XhfD9X02diXUtZhhuJcO8v+Y=;
	b=pQSZS2rjh+ABytlaRvlb4XP0cUlap2GJLrpPFCRXFYS0NM0d/Q41Ts+rjGuvMddriD/sQl
	8z/8rbTZWmuLeVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CEEA13419;
	Wed, 28 Oct 2026 19:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bhvRBAxQ4mokPQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 19:42:04 +0000
Date: Wed, 28 Oct 2026 19:42:02 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	jannh@google.com, liam@infradead.org, willy@infradead.org, paulmck@kernel.org, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
Message-ID: <auJO9al4lmAczLAu@pedro-suse.tail5790ac.ts.net>
References: <20261028051312.1505295-1-surenb@google.com>
 <auHK3k-W4gfL_MhI@pedro-suse.tail5790ac.ts.net>
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
In-Reply-To: <auHK3k-W4gfL_MhI@pedro-suse.tail5790ac.ts.net>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,intel.com:email,suse.de:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Oct 28, 2026 at 10:14:19AM +0000, Pedro Falcato wrote:
> On Tue, Oct 27, 2026 at 10:13:12PM -0700, Suren Baghdasaryan wrote:
> > Pss metrics can be affected by map count even if VMA tree stays unchanged,
> > therefore test checking VMA tree integrity can't use them. Use Rss instead
> > and pre-populate the VMAs so that Rss changes if a VMA gets skipped or
> > double-counted.
> > 
> > Fixes: ca5480fb53fa ("selftests/proc: add /proc/pid/smaps_rollup tearing tests")
> > Reported-by: kernel test robot <yi1.lai@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@intel.com
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

Actually, now I'm wondering: isn't Rss also flaky if memory pressure occurs?

-- 
Pedro
