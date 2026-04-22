Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F203A6F07
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862575; cv=none; b=kwMMCO4v+lANhD0lkrRTLHqAj8+EByyieF0k6EGBnha7RDhbGZ7yRpVQ2L+Tf13b0xXadkFYkAVLKSc+WJrwtMMp0j0uXsbAZeQPyWJu7HTCZH6Ef4zEF9HjKsGQeSde77jTUtViAFRgFvE1OxLy8DrCANwOYHLtVTiXLS7oPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862575; c=relaxed/simple;
	bh=FpvEACxf+mnpgZiEiniNTbXAwgacQ4+UG8AlnsyDw8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPb8ablvXrj3RHemS36f1q61ZK5HZNeGhhKhnb7I8kgyDgBFrlqq6EPHRuOERm0puzDfF7BAb/APxiWZdl3Di4Deh99gnw0m05u0koPC3X3EcBXvUTzfn++zKTeMBhwl1YLxpaZuFM0wIrmm3MuI4+dND8pdcIMUytbagSxozzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0QkewOs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E5DruJoR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0QkewOs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E5DruJoR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0QkewOs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E5DruJoR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0QkewOs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E5DruJoR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CC745BD5D;
	Wed, 22 Apr 2026 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776862573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fE6IDxVoUkquxq5pDa4brdX8WdMdoNs2B8vTHhjhhd0=;
	b=Z0QkewOslpetixy9qs52tWUQSyd3NqHtiJpTdRVb6vd6itAS7edKymMOK2gYCyWgvGCw39
	YIuNjYu5mHbffgN1sGUCTZGqC0guOraIIks3lsYga90t2L2pMrvv16I8l7V94hyo9Wpv0X
	+2/q0krp34emJRJcIzmO55DWwr7b4js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776862573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fE6IDxVoUkquxq5pDa4brdX8WdMdoNs2B8vTHhjhhd0=;
	b=E5DruJoRKN4CGrP1gg9MYy4u3h+2lqSUDVtAtmLjxJBvwO7JUaxZkkH3Hkn4P/EFZCBxG2
	qmvvhSOUXa2LJpAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776862573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fE6IDxVoUkquxq5pDa4brdX8WdMdoNs2B8vTHhjhhd0=;
	b=Z0QkewOslpetixy9qs52tWUQSyd3NqHtiJpTdRVb6vd6itAS7edKymMOK2gYCyWgvGCw39
	YIuNjYu5mHbffgN1sGUCTZGqC0guOraIIks3lsYga90t2L2pMrvv16I8l7V94hyo9Wpv0X
	+2/q0krp34emJRJcIzmO55DWwr7b4js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776862573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fE6IDxVoUkquxq5pDa4brdX8WdMdoNs2B8vTHhjhhd0=;
	b=E5DruJoRKN4CGrP1gg9MYy4u3h+2lqSUDVtAtmLjxJBvwO7JUaxZkkH3Hkn4P/EFZCBxG2
	qmvvhSOUXa2LJpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E873593AF;
	Wed, 22 Apr 2026 12:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id px2BA23F6GllBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 12:56:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BFAE0A0B44; Wed, 22 Apr 2026 14:56:08 +0200 (CEST)
Date: Wed, 22 Apr 2026 14:56:08 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Frederick Mayle <fmayle@google.com>, 
	David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: limit filemap_fault readahead to VMA boundaries
Message-ID: <qmojyvlsbjcgavnecbvfwax6o3d7edzifpxp7raxbevbfcxtbi@mox2z7njeodb>
References: <20260422005608.342028-1-fmayle@google.com>
 <aei_d5KMKmLhMx3S@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aei_d5KMKmLhMx3S@casper.infradead.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Wed 22-04-26 13:30:47, Matthew Wilcox wrote:
> On Tue, Apr 21, 2026 at 05:56:07PM -0700, Frederick Mayle wrote:
> > When a file mapping covers a strict subset of a file, an access to the
> > mapping can trigger readahead of file pages outside the mapped region.
> > Readahead is meant to prefetch pages likely to be accessed soon, but
> > these pages aren't accessible via the same means, so it fair to say we
> > don't have a good indicator they'll be accessed soon. Take an ELF file
> > for example: An access to the end of a program's read-only segment isn't
> > a sign that nearby file contents will be accessed next (they are likely
> > to be mapped discontiguously, or not at all). The pressure from loading
> > these pages into the cache can evict more useful pages.
> 
> The problem is that we might (for example) use mprotect() to mark a
> portion of the file as being unmodifiable, but nevertheless still want
> to prefetch through it (since it will be read, just not written).  I'm
> sure this solves your problem, but I'm not sure it covers all use cases.

Well, I'm not sure whether all the usecases are covered either but is what
you describe above something you'd expect people to commonly do? In general
sequential reading through mmap seems to be already relatively rare...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
