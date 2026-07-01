Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC23BA222
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907520; cv=none; b=u4RRr4kZLgr5vKmHYVVbE/BVAtbj+2mALmT98XRdfMTsJILMB0C3Mp3Z1DY7h6rPccRu42yNhxv+PwJrbL5dx6A8u8m9YBDY+4HTFqq+KXuJFh42CcGCT8DqYJxV4MxRkcDWovw8FetyYSbKdVvS6wX1a+qqK89AXqQlt9AdPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907520; c=relaxed/simple;
	bh=p9i1eKV5v44/pLCRYu0f4YuiLr8/3n5SxK4frrD6U6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMCgOcYaPu/pqkHlacvHQAch4bFuzFejAUkrCs8nfAzmq8sZ/OjqFVgBHB9suzG9wvJUm0LhpMr6RpSXiKPlWFno10Z8ODk1UulKoW44xLxPMVPqZPbde0/7AFIVxUaK8I3I6gAYv2a7V8KG/XI3DHgcYCSjhjKIbw2n2CYXMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iQKRemWA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HMFxpWNz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mHOcNFi5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Inykshk1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iQKRemWA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HMFxpWNz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mHOcNFi5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Inykshk1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2A4673A87;
	Wed,  1 Jul 2026 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782907516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWAjt+Z5M5aCYbFA65hD8FRE5iZm55B9+U5Z+re2dO4=;
	b=iQKRemWAEfDbRzZ6IFy4PuEOM8F4Nehx6zhjBR+dDQQjSLGxIVbJVmzjw0io7AOLhAd6hb
	fcHGOVIGnjAPpTE6Q6QxYtl+XdcgT6FXMWc6eFd1bgkEuCqXGpxnid7v7l0JRQKyU+C7BE
	cGkTIMzHjIwa+NzSClO9/YueVI7LNM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782907516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWAjt+Z5M5aCYbFA65hD8FRE5iZm55B9+U5Z+re2dO4=;
	b=HMFxpWNz4c7KsgoT4zlQVBmBSkK+t3w+LKn254Ggpsx++aipkABmI3UMcjAOOIq7RDAfkD
	+L8gpkR6XKmcj4Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mHOcNFi5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Inykshk1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782907515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWAjt+Z5M5aCYbFA65hD8FRE5iZm55B9+U5Z+re2dO4=;
	b=mHOcNFi5SNfdu5VZO/H2YRlkXvfKiieKe0mlcSkoC0ifMqZPKK1p1ew/2qeErR6svGk2fH
	arF5CLI+997wXccLPMKfRmPdRw3A4ulKdzOgYal7FFNpMDs941kI5ZGoGpT5WPjP9GELom
	TTeiVA0JX23RKkN6RDDpmd2+5/6ZW4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782907515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWAjt+Z5M5aCYbFA65hD8FRE5iZm55B9+U5Z+re2dO4=;
	b=Inykshk1SZu0toM7yV2EH1MDG4BnoNjfZskmMT6F1GdN2Uv7cEWsRknlhHbBiKp9gx5Naz
	9ZK7rJk4TqNu4XBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C775E779AA;
	Wed,  1 Jul 2026 12:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7SVzLXoCRWoPMwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 01 Jul 2026 12:05:14 +0000
Date: Wed, 1 Jul 2026 13:05:13 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Zi Yan <ziy@nvidia.com>
Cc: Gregg Leventhal <gleventhal@janestreet.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eric Hagberg <ehagberg@janestreet.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
 dirty page cache
Message-ID: <akUCbsNo2krhSV03@pedro-suse>
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
 <akQIIav_zaK6RmIC@pedro-suse.lan>
 <akQO8JtTxmp89GS8@pedro-suse.lan>
 <akQekZUyoKadiGCH@pedro-suse.lan>
 <DJMR0W6NUSAI.3UF6I74VFDFSH@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJMR0W6NUSAI.3UF6I74VFDFSH@nvidia.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C2A4673A87
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jun 30, 2026 at 06:48:39PM -0400, Zi Yan wrote:
> On Tue Jun 30, 2026 at 3:55 PM EDT, Pedro Falcato wrote:
> > On Tue, Jun 30, 2026 at 07:49:12PM +0100, Pedro Falcato wrote:
> > snip
> >> 
> >> Other idea: perhaps doing filemap_write_and_wait() after the nr_thps
> >> increment in collapse_file() will Just Work and result in a _much_
> >> simpler fix. And it avoids any weird forward-progress issues as no one can
> >> write to folios at that point.
> >> 
> >
> > Gregg, if you could test this patch, it would be much appreciated. This patch
> > (hopefully) makes it so no dirty folio will ever coexist with a ro-THP, thus
> > hopefully sidestepping the entire issue in a simple way. Only compile-tested
> > and not reviewed.
> 
> I tested the patch on v6.12 kernel with the reproducer from Gregg and
> confirmed that the issue is fixed.
> 
> Feel free to add
> Tested-by: Zi Yan <ziy@nvidia.com>

Awesome, thanks!

-- 
Pedro
