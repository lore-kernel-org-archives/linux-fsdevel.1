Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7653D6663
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571547; cv=none; b=mt8jodovXp4let1IU1OIpKGWG4wQuQQeWvdYxK3gCiRJInMVj8yCjbcpw8YfFHQpMF6b1hT+PveJgZIYvCBOuwrd6pSNz4o5eqljbguXfCBnrjeyESCZGFBO6o8Ntw3U+TzgPXcYs+yZQSAqkak1vEBV7tBvkI7jcCGufZmdBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571547; c=relaxed/simple;
	bh=G0W4yELFYsuE/5le6C4I+zLnzFPk0TJBZRf/JDSNzuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rthg4GDmfVor8MQ4VQf9sXPnXIETqpRelxIwRPvHLEOipwjDYMRk14sNStpVFJmu98NgrljWIBPzmn8xrX6GZPy87TD7yLj0Y0RCEhzYinGpIwHUjMK979AunBTlfsqwa2oEjGccfcZxcfEWzBOAghsBKkbs4SxyxrZPiEcHWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CJC94ErJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9CHJqyUE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CJC94ErJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9CHJqyUE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CJC94ErJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9CHJqyUE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CJC94ErJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9CHJqyUE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACA7775CFE;
	Tue, 12 May 2026 07:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778571541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YazKQQ4f7Xtj2bwB4n8Hki+UhzT6K854g9SreOa59BY=;
	b=CJC94ErJRYdTvyGm5j04VDtMDONCAoR7qI24x8ISmaPjyEj4T9ZuNFe9iyYdrXwuu613nn
	SuEIbfJpJql9t/ox88nKZ5lG0D054ESqPFZQr40EMOU7cIkTgnwwEjE0jDRvJVVjKt+z20
	gDC5ineRr57kJ5e7fYNUKPJyf/v4Jio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778571541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YazKQQ4f7Xtj2bwB4n8Hki+UhzT6K854g9SreOa59BY=;
	b=9CHJqyUEer6dkjksYo9fhBIUf959UuzIQqkso3tZSxL9EzxJjqSfYaumtLZihgV3Ov65GD
	pG/jF8BAk/Hf1mDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CJC94ErJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9CHJqyUE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778571541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YazKQQ4f7Xtj2bwB4n8Hki+UhzT6K854g9SreOa59BY=;
	b=CJC94ErJRYdTvyGm5j04VDtMDONCAoR7qI24x8ISmaPjyEj4T9ZuNFe9iyYdrXwuu613nn
	SuEIbfJpJql9t/ox88nKZ5lG0D054ESqPFZQr40EMOU7cIkTgnwwEjE0jDRvJVVjKt+z20
	gDC5ineRr57kJ5e7fYNUKPJyf/v4Jio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778571541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YazKQQ4f7Xtj2bwB4n8Hki+UhzT6K854g9SreOa59BY=;
	b=9CHJqyUEer6dkjksYo9fhBIUf959UuzIQqkso3tZSxL9EzxJjqSfYaumtLZihgV3Ov65GD
	pG/jF8BAk/Hf1mDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1C61593A9;
	Tue, 12 May 2026 07:39:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A7F2JxXZAmr/SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 May 2026 07:39:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A3C4A093D; Tue, 12 May 2026 09:38:53 +0200 (CEST)
Date: Tue, 12 May 2026 09:38:53 +0200
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jan Kara <jack@suse.cz>, Vishal Moola <vishal.moola@gmail.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: fix page_cache_prev_miss() when no hole is
 found
Message-ID: <oshbymv7qwgi6ffxbglw7r7pzrlqmhs3tuwe65gj3752u3nepx@65svx4bkaya2>
References: <20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu>
 <agHPIcZHHyzBjcGN@fedora>
 <s6hnqm4bbi5j2ergudihydboj3uw7gsu7te4dfmjgv2qeosfbd@yvhp5oy3r3b6>
 <5280b6f9-e6d7-4854-bbdc-ed5349a478ed@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5280b6f9-e6d7-4854-bbdc-ed5349a478ed@columbia.edu>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,infradead.org,linux-foundation.org,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ACA7775CFE
X-Spam-Level: 

On Mon 11-05-26 14:15:41, Tal Zussman wrote:
> On 5/11/26 12:26 PM, Jan Kara wrote:
> > On Mon 11-05-26 13:44:17, Vishal Moola wrote:
> >> On Sun, May 10, 2026 at 05:54:17PM -0400, Tal Zussman wrote:
> >> > page_cache_prev_miss() is documented to return a value outside the
> >> > searched range when no gap is found. However, the no-gap-found path
> >> > returns xas.xa_index, which after a successful loop is the first index
> >> > in the range. As such, that index is misreported as a gap.
> >> > 
> >> > The sole caller, page_cache_sync_ra(), uses the return value to estimate
> >> > the cached run preceding a sequential read. In some cases, the buggy
> >> > return value can undercount the contiguous range by one, shrinking the
> >> > readahead window or pushing borderline requests into the
> >> > small-random-read branch.
> >> > 
> >> > Mirror the fix in commit bbcaee20e03e ("readahead: fix return value of
> >> > page_cache_next_miss() when no hole is found"): preserve max_scan in a
> >> > separate variable across the loop and return `index - max_scan` from the
> >> > no-gap-found path.
> >> 
> >> IMO, this way of fixing it hurts the readability. I'd prefer something
> >> similar to the fix in the original commit. Or...
> >> 
> >> > -	while (max_scan--) {
> >> > +	while (nr--) {
> >> >  		void *entry = xas_prev(&xas);
> >> >  		if (!entry || xa_is_value(entry))
> >> > -			break;
> >> > +			return xas.xa_index;
> >> >  		if (xas.xa_index == ULONG_MAX)
> >> > -			break;
> >> > +			return ULONG_MAX;
> >> >  	}
> >> 
> >> If I understand this correctly, couldn't we just do something like:
> >> if (!max_scan)
> >> 	return xas.xa_index - 1;
> > 
> > I think the easiest to understand would be to do the above two explicit
> > returns instead of 'break' and change below to:
> > 
> > 	/* Return start of the range - 1 when no hole is found */
> > 	return xas.xa_index - 1;
> 
> I can do that, but I think it should be consistent with
> page_cache_next_miss(), which does index + max_scan. If the xas.xa_index
> approach is preferred, I'll change it in both functions, and also get rid of
> nr.
> 
> The nice part of 'index - max_scan' is that the kdoc describes the range in
> terms of that already.

Frankly, whatever you pick :) I'm fine also with the patch as you've
originally written it. I was mostly suggesting this as a variant that also
looks sensible to me and maybe it would look better for Vishal.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
