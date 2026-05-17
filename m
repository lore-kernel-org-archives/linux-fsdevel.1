Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77782E091B
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779008497; cv=none; b=YTDvhYHli6qB7tSgB+utuolUFqevMb2x5K46g7mHEV00fzKnv/k4iOino6SPtBeTuvBjn2Ofk8/cWLRD3JbSUaslk1MBa2UD3Qifu1t2HgP84WQ85r9ekq80wg4u5BvjmwFF6C6iUE8D9xfmRLta3m0eS2HWt7HR6GYwo+Qz+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779008497; c=relaxed/simple;
	bh=orpVrEDVEfcVuBSm8rNitoNr+TVXqnYtkBQ9Yz+ldk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D65RO1yqqe5eN2X4qaqRHpwFceKRoooiCFdAfB4Ii3m1x3tO5lIly51O0YnbcD+/OlCslJQp+5foU7LdNSwCceyO0lbE8pG8mbGHIkBY8ZJY7KJFtoo6Iza2r0W9xQvKQt8bkuOZ3yPuol25IjInKu7w2cSd9LAamMq48fhIa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IWuZ9Xp/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x2ARWsxV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VtCVOWHt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oJ//3b3p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IWuZ9Xp/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x2ARWsxV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VtCVOWHt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oJ//3b3p"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 006496A815;
	Sun, 17 May 2026 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779008494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5aby9ZwmKZPtiMHVFEb2wDmgq8fqEOg9pkZ9u1EhJM=;
	b=IWuZ9Xp/f6xDBn7X9SLDB1EXwr3GdWXxS96ZTPbApZmQE0DYGFEwlMF5fLrHQXrmT6HoQ+
	QjxOLcjrqKc1Gr9Bzct6/MgZYRnMoplvf4Ilzq5+zFqwBqGorRubfA13kctg2AIM6MuNk2
	aCrZ+tZWV0OFRJcJkRREMU5xm+5sKds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779008494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5aby9ZwmKZPtiMHVFEb2wDmgq8fqEOg9pkZ9u1EhJM=;
	b=x2ARWsxVZy34NTtKOHl7riHkb3hLAoNosfxwL9/MP4BNVQVv7UGtr9vrQ7o17vk/2E8yTr
	0muntm+tAtIITPDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779008493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5aby9ZwmKZPtiMHVFEb2wDmgq8fqEOg9pkZ9u1EhJM=;
	b=VtCVOWHtiJCV8cgxqDBVZk5zp5a/qbIuczEeFfaIMyMgD9dVGA5sg3BuoevATGv05ZFneD
	S64EK0MCGrgTJ8LEW2Xsk3edZSglP/vWwYHGELbzBHGbjzyMCFtQIdutYXsYXoMVcmBSNP
	RqaQMdEfl37MJHKevkq39BbQKVAC1Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779008493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5aby9ZwmKZPtiMHVFEb2wDmgq8fqEOg9pkZ9u1EhJM=;
	b=oJ//3b3pnchq4Yy/Pg0zF2OPn/W8actU/4Oi+SFQo+qFCiL0oKtjZQgt4tQHfoPB4CjgeD
	390jW4t3lktHx3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A6E9593A8;
	Sun, 17 May 2026 09:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gBn0CeyDCWo/FAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Sun, 17 May 2026 09:01:32 +0000
Date: Sun, 17 May 2026 10:01:30 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <agmDiAY-mmlvjX0m@pedro-suse.lan>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <agj4mXKRVW44ZJ18@casper.infradead.org>
 <agkRpj4oU8TPgmTS@pedro-suse.lan>
 <agkXHu_ON_KyWtvP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agkXHu_ON_KyWtvP@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,kvack.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,pedro-suse.lan:mid]
X-Spam-Level: 

On Sun, May 17, 2026 at 02:17:18AM +0100, Matthew Wilcox wrote:
> On Sun, May 17, 2026 at 01:59:41AM +0100, Pedro Falcato wrote:
> > On Sun, May 17, 2026 at 12:07:05AM +0100, Matthew Wilcox wrote:
> > > On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> > > > +static bool may_write_to_page(struct page *page, struct address_space **plast)
> > > > +{
> > > > +	struct folio *folio = page_folio(page);
> > > > +	struct address_space *mapping, *last = *plast;
> > > > +	struct inode *inode;
> > > > +	bool may = false;
> > > > +
> > > > +	if (!READ_ONCE(sysctl_splice_needs_write))
> > > > +		return true;
> > > > +	/*
> > > > +	 * Always fine to write to anon folios.
> > > > +	 */
> > > > +	if (folio_test_anon(folio))
> > > > +		return true;
> > > 
> > > What about KSM?  It's not something we've seen attacked yet, but it'd be
> > > pretty nasty to be able to change a KSM page in another process.
> > 
> > It's my understanding that only anon pages can be KSM'd, and KSM still keeps
> > the FOLIO_MAPPING_ANON bit set. So folio_test_anon() should still test true
> > for those.
> 
> I think you misunderstood what I meant.  If we have a buggy user which
> can write to read-only file pages, then it should also be prevented from
> writing to KSM pages.

Hmm, I see. Are you suggesting we unshare KSM pages here? Or just straight
up reject them?

Rejecting would be relatively sane if only we had access to the VMA here
(in normal GUP), testing on folio_test_ksm() is less robust :/

-- 
Pedro
