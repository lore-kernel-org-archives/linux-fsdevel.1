Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307074;
	b=I0Z4S+xdeBlnX/TjhGRaXaWSDlv+Ln+mZhUX3+scGCjPbOY7cOMWvAAMZySBeHs8Zdmf
	 w+8I5pRiDB2Rubk+hzeN2ygAfHVAXz1cKce3uReTVoBc74p8tQ1MhCmQ6rQnMBWVC2Q1Q
	 nj4cKujU9GCFcA0gcoRt6DVMjUoslvJKKdwifSRgzfWpkV7rrsYLnoWEIVHvvr8dTRYCu
	 2h4CJbVb7PG5AdJw/6Qy75quATFSaXqUijIzcdh9vcez4cxFApswPnmT2WOc2MnHXUegy
	 bBJBFSlql7YdGW63t7eS/U7LNy1v0aAdJGRhNTHSMdnTInQdNgNVf8fQs7wrv0Ckpaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307074;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=UlV+p7Ntb3+w27D9HU+z/TWwQDK7MyawCat5dRFi5NM=;
	b=LULMD410PX8/baK0jTJ0ax8z/jfaXbrvb6JaGmdeNvjPZxBua0EEhJ6FlP8iEM3d5rb/
	 HLmzL/MQEJn5mHoyxy/KdDHEMNn4wq+27zqyBhyIwWDGrE6FuFftdGjJMXZCFl3tVwjlQ
	 vYmpGCLMKxUmUEUcoud05K1hov+liTzA0oAI1DqeU7hpB7G0+CtexAS78IDEpb49gh6JW
	 nwvqaBWr5HdzIBGsgirvckCaTPCPF7Yf4CHteWkM1z1h27uKd6J7ikHZMNTcaFdmQXEv0
	 XGcicg7kKoDbI0Yo9p5hmTWHesGNIUa93rbmmg2s8GmF8HMAE4CNK+HWluKqZDh+NKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=li9W2jHU;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RTsnqhdh;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tovQQbFU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z1UIzdV2;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A6606A331;
	Tue, 10 Nov 2026 10:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 213A6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=li9W2jHU;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RTsnqhdh;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tovQQbFU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Z1UIzdV2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E701D21D9F;
	Tue, 10 Nov 2026 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794307072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlV+p7Ntb3+w27D9HU+z/TWwQDK7MyawCat5dRFi5NM=;
	b=li9W2jHUQBd8RF/mnIdAvDFGeOiTFnpMBUfryhtYKGN+o/AboED3XJpT6teCcrfnBljg06
	VIMmX88Fmu9f4dJoEcCcB8uw3XAm+FJ8TKFBfOL25wXa04QWnGhgmdYoYzlR29eURCk+Sv
	Gx61YrQxgt2Bw4QvTvCK2Oj0lGykOxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794307072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlV+p7Ntb3+w27D9HU+z/TWwQDK7MyawCat5dRFi5NM=;
	b=RTsnqhdhTgKVgkdt2CCeVQ6GrHLrS/wKLyJEGkbvqXQYZQ8BcZY4hh3cif5ogfotYB2Z+D
	tiooSCRlFQZyCsDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tovQQbFU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Z1UIzdV2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794307071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlV+p7Ntb3+w27D9HU+z/TWwQDK7MyawCat5dRFi5NM=;
	b=tovQQbFU/F6wNXLEsnCezRZ9VBPvbjiXFYg/arT6r3gP1F0Ha7TVBbDTX0EmcF92VQaPN+
	eHCAl3qCl+XE8CjXLTpE7WPQnk5Xavez9V3lCqc1Roj5OaV+RLFBTd3gh62njXYPZl9+85
	sn4rnpsSmuRrK+DEpgVbPz+l4pu+B64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794307071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlV+p7Ntb3+w27D9HU+z/TWwQDK7MyawCat5dRFi5NM=;
	b=Z1UIzdV28HX3HA/oFk93aVP0slCgu+1wQXXSLucK19h1jFXZRVVHKNky5zmkLo4HxAv82X
	zyNbKYs8l+AbThBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF0A1339F;
	Tue, 10 Nov 2026 10:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZrdcJv/z8moPNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 10:37:51 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 4FFCF22485; Tue, 10 Nov 2026 11:37:47 +0100 (CET)
Date: Tue, 10 Nov 2026 11:37:47 +0100
From: Jan Kara <jack@suse.cz>
To: Alireza Haddadi <alireza.haddadi@it.uu.se>
Cc: Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vishal Moola <vishal.moola@gmail.com>, fujunjie <fujunjie1@qq.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/filemap: let sequential faults restart mmap readahead
Message-ID: <vna2y3gpsdkntml6fzfvhf55vjbetoitnqv5bitfkh24gfecz6@iihzrvi2g2kf>
References: <20261109-mmap-miss-v1-1-8b44b33f3358@it.uu.se>
 <gewwqi2kcu4nsitueyw2nd6g6eqjb3wqh4mks5lqcbkc6re4sn@eaqpgn2hxls5>
 <5310BD2F-6626-44C9-A156-3B985552030A@it.uu.se>
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
In-Reply-To: <5310BD2F-6626-44C9-A156-3B985552030A@it.uu.se>
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,infradead.org,linux-foundation.org,gmail.com,qq.com,vger.kernel.org,kvack.org,linux.dev];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -11.51
X-Spam-Level: 
X-Rspamd-Queue-Id: E701D21D9F

On Mon 09-11-26 20:23:29, Alireza Haddadi wrote:
> As Sashiko noticed, with a minimum folio order (large block size
> filesystems), the 2-page request ends up as a single folio with the
> mark on the faulting folio itself. That folio gets mapped in full on
> the retry, so the mark is never hit and the readahead does not
> restart there.
> 
> I checked it myself, and it's right. In v2 I'd read two minimum-size
> folios instead and mark the second one:
> 
> unsigned int nr = mapping_min_folio_nrpages(mapping);
> ra->size = 2 * nr;
> ra->async_size = nr;
> ra->order = mapping_min_folio_order(mapping);
> 
> With a minimum order of 0, this is the same as now. The cost stays the
> same in proportion: a miss that follows a cached page reads two
> minimum-size folios instead of one. I'll also test it on XFS with 16k
> blocks before sending v2. Would you be OK with me keeping your
> Reviewed-by for that, or would you rather look at v2 first?

Yes, I agree with this solution so feel free to keep my Reviewed-by.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
