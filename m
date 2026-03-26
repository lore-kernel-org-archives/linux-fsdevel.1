Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE2405ACE
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542106; cv=none; b=EcBvyxWg9cUPh2OmF3ZuGMK9+hSIhyl1pmWE1DFPeU8EZMXTzk07m0+ZZYLqGsfyeKOo3Y8IMxelBJkYubGJM/4qadSbWhJ1t8KGCD1IQV8CUEQP8VoRqQW8WDTzIQ5PLApawl/ZR5je8+zaYUECt7W/57oIFYD2+THRaWsa2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542106; c=relaxed/simple;
	bh=0wPOAICeD+rGPFI3vAxl55pipiVbkqxU0Dis98VZDVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K01GhKX8Inm4n9u+n6IfYgaXfxYEE6Sg/sZJrS0FCfdOBjrwUg45pc5QEZFOforJRs2EwYjwnDi7dQNiRJ2GVN5KoLEpp2j4KTuU842VKi9wAOi3TryApP7Mqi9QjyeUxYCvexSS027MMElHUvHiupO0ZSohCHzGwXyXV4F6TrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZslg0LL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SB9KOpgW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IfUaDP01; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pqXukDQ9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZslg0LL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SB9KOpgW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IfUaDP01";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pqXukDQ9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77BF74D2D7;
	Thu, 26 Mar 2026 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774542103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3lDg9Qo7P0Jt4agnX1ynDtZ4eMvLfAya4JWT6zRJSo=;
	b=MZslg0LLFo7myS2a/8LFdcUOwp+jbWjCjwYxjb9zD7CAq/CsJCSckh5Xhd8X0ONQovrXj6
	vdAlf71ItuZNco3Wp+mTWGYSDIM00xcSc26QSkqIW7Q8Z/N9jkEqZcUhxkD804IZv4b6kP
	vhz79YOxhk+Pd/nM4DAjZyOGb5aXR8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774542103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3lDg9Qo7P0Jt4agnX1ynDtZ4eMvLfAya4JWT6zRJSo=;
	b=SB9KOpgWgaY0QDbUOTSzS7AxJahXkQzMutR7lF7qmFvKiJO+qwek8ZZAroKdOzArdpMNXN
	oT66Uf9hx7hz+8Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IfUaDP01;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pqXukDQ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774542102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3lDg9Qo7P0Jt4agnX1ynDtZ4eMvLfAya4JWT6zRJSo=;
	b=IfUaDP01F3JH4tgDH5+jfnxK3m3G1zoqejuqCQE6yhtmA6oAwFrdi/+v7rMBKhS6zwD2hb
	azZepBy5BjCsoZCiHZzXYnGoTaf20a+vIweRmXe7jwrEIZbhWhS//HOniOm7orEtE8IWzH
	+C5hfYo6AI0q8FTz0XlPtVsQhoqtvDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774542102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3lDg9Qo7P0Jt4agnX1ynDtZ4eMvLfAya4JWT6zRJSo=;
	b=pqXukDQ9LEbKGqBXtMm7qdmWQVl24WRKq0mylAqbUWZzDjLBCa6wMLBXUUaeb9tpKtyeJx
	LpIY+ySA7rp5lfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A3864A0A3;
	Thu, 26 Mar 2026 16:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eyLhGRZdxWlFIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Mar 2026 16:21:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1091BA0976; Thu, 26 Mar 2026 17:21:34 +0100 (CET)
Date: Thu, 26 Mar 2026 17:21:34 +0100
From: Jan Kara <jack@suse.cz>
To: Usama Arif <usama.arif@linux.dev>
Cc: Jan Kara <jack@suse.cz>, david@kernel.org, ryan.roberts@arm.com, 
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, linux-mm@kvack.org, r@hev.cc, 
	ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@quack3, ziy@nvidia.com, hannes@cmpxchg.org, 
	kas@kernel.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm: replace exec_folio_order() with generic
 preferred_exec_order()
Message-ID: <4pzoddjdplps6wzf7hluwjg7jty7tmrwkq5jk7qzer4kur5o4q@7ge6uatpmkex>
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-3-usama.arif@linux.dev>
 <k45xs6btmt62uerbglqe665jozrtkeoklu4rek6odgxjdj63ni@ftw6ef3ug33x>
 <0ce07bc5-6365-4c54-90e2-4e56ad2b7465@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce07bc5-6365-4c54-90e2-4e56ad2b7465@linux.dev>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL7pfqg7h1m44jupjp7nguhfec)];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 77BF74D2D7
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 26-03-26 08:40:21, Usama Arif wrote:
> On 20/03/2026 17:42, Jan Kara wrote:
> >> +	/* Step down under memory pressure */
> >> +	gfp = mapping_gfp_mask(vma->vm_file->f_mapping);
> >> +	zone = first_zones_zonelist(node_zonelist(numa_node_id(), gfp),
> >> +				    gfp_zone(gfp), NULL)->zone;
> >> +	if (zone) {
> >> +		while (order > 0 &&
> >> +		       !zone_watermark_ok(zone, order,
> >> +					  high_wmark_pages(zone), 0, 0))
> >> +			order--;
> >> +	}
> > 
> > It looks wrong for this logic to be here. Trimming order based on memory
> > pressure makes sense (and we've already got reports that on memory limited
> > devices large order folios in the page cache have too big memory overhead
> > so we'll likely need to handle that for page cache allocations in general)
> > but IMHO it belongs to page_cache_ra_order() or some other common place
> > like that.
> > 
> > 								Honza
> 
> So I have been thinking about this. readahead_gfp_mask() already sets
> __GFP_NORETRY, so we wont try aggressive reclaim/compaction to satisfy
> the allocation. page_cache_ra_order() falls through to the fallback path
> faulting in order 0 page when allocation is not satsified.
> 
> So the allocator already naturally steps down under memory pressure,
> the explicit zone_watermark_ok() loop might be redundant?

Probably yes. I still think we'll have to somehow better tweak the used
order based on expected size of the page cache (2M folios seem unreasonably
large for a machine that has e.g. 1G of memory in total, even if it has
enough free memory at this point in time - we'll benefit from smaller
folios and thus finer grained folio activity tracking for such cases). But
that's not for this patch set.

> What are your thoughts on just setting
> ra->order = min(HPAGE_PMD_ORDER, ilog2(SZ_2M >> PAGE_SHIFT))?
> We can do the higher orlder allocation with gfp &= ~__GFP_RECLAIM
> for the VM_EXEC case.

Yes, it's simple and it makes sense to me so if others are fine with it...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
