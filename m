Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770E3A4F22
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695868; cv=none; b=iCI0ZaV/yrvjqC7C0V/RO4CtFMYGxfls+r/kfs14byf4BHjaUu2l+aqUjquj9LQPWS61XYcsvv0T3s/OFrn91XRIFGZq4sN433e9+yIj0kSThRGCv08F9YEdQLfKjrgypbYQo/n9aJ28H0VgOy/ftqG6NY6W9BwG30w1bYd/UK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695868; c=relaxed/simple;
	bh=zOFcjxN5dTT49n/q6v/h/YCoeKK5mmwMMER71BqIKDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLxZf1FoVcoEiymevp+9r9VpiXNdHAtQpTLoZZKUrM75t91Qoooec0Iwmvhsk2MdOPLFfC+LwLCFumfVroeN7f+lNX6onbQgOfPh80M3UC/acH6vKO+wf9ujmMErGBuzmjTTMisX83KEP9Zv1DZS0CrX0YeM7YHvlIr/dVYII+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gQtcfZ7y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oo+OSOBG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gQtcfZ7y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oo+OSOBG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gQtcfZ7y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oo+OSOBG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gQtcfZ7y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oo+OSOBG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61AF86A7EF;
	Mon, 20 Apr 2026 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrsUSWtwszhMHAn+15tFQGJfKu47e8GbhEimizzBnyk=;
	b=gQtcfZ7y/R/ucFRfsQoDBG/ZF5qTa3Bj7IFlqNhzObhHLx8mYB/JhMiyTuxYMInv68jKT5
	2weJG0h4j5Z1bjmQimHObS3KgxHWEsaGbwpACtW8sBYx9AXu9ba7MXRQNpSNczPXSaipIi
	BB3cADVCxF1FpVwTH4nOhEm7neGoQ+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrsUSWtwszhMHAn+15tFQGJfKu47e8GbhEimizzBnyk=;
	b=oo+OSOBG6Yh5+L7vyUyGOCjuF+BqrPK+FX7x2LvJ8ArQXuQOSHg0oDCAqA+PBT3etiby+E
	/1yTOctMl2MBDVDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gQtcfZ7y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oo+OSOBG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrsUSWtwszhMHAn+15tFQGJfKu47e8GbhEimizzBnyk=;
	b=gQtcfZ7y/R/ucFRfsQoDBG/ZF5qTa3Bj7IFlqNhzObhHLx8mYB/JhMiyTuxYMInv68jKT5
	2weJG0h4j5Z1bjmQimHObS3KgxHWEsaGbwpACtW8sBYx9AXu9ba7MXRQNpSNczPXSaipIi
	BB3cADVCxF1FpVwTH4nOhEm7neGoQ+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrsUSWtwszhMHAn+15tFQGJfKu47e8GbhEimizzBnyk=;
	b=oo+OSOBG6Yh5+L7vyUyGOCjuF+BqrPK+FX7x2LvJ8ArQXuQOSHg0oDCAqA+PBT3etiby+E
	/1yTOctMl2MBDVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48E70593B4;
	Mon, 20 Apr 2026 14:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ft3KESI65mnBcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 14:37:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B833A0BA9; Mon, 20 Apr 2026 09:56:26 +0200 (CEST)
Date: Mon, 20 Apr 2026 09:56:26 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] fs: allow lockless ->i_count bumps as long as it
 does not transition 0->1
Message-ID: <dfif7yuf2bwgfrow75cm3jgss2wsmpdhgybnshhn62z2wi3pnd@vnpinqr2vx73>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
 <20260331160851.3854954-5-mjguzik@gmail.com>
 <4fhhn57gzilze4bgkwinanbfovd3iez2s7ajujiob3kkpu6kcy@ic55f5utqogs>
 <CAGudoHFLT3qDQ703Ttmu6ZgPAiSeaXpEtND12+8tdVa=RYqAag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFLT3qDQ703Ttmu6ZgPAiSeaXpEtND12+8tdVa=RYqAag@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 61AF86A7EF

On Sat 18-04-26 14:32:42, Mateusz Guzik wrote:
> On Wed, Apr 8, 2026 at 7:01 PM Jan Kara <jack@suse.cz> wrote:
> > > +/*
> > > + * igrab_try_lockless - special inode refcount acquire primitive for the inode hash
> > > + * (don't use elsewhere!)
> >
> > Why is this special for inode hash? Because of I_NEW & I_CREATING checks?
> > Then I'd call this function igrab_from_hash() or something like that and
> > integrate there also all the i_state checking and waiting common between
> > find_inode() and find_inode_fast().
> 
> I was looking at deduplicating find_inode stuff and doing other clean
> ups (notably pulling in waiting on I_NEW inodes into it), I don't like
> the idea of making churn changes in this area with this patchset
> though -- the hash code has proven itself to be weirdly eroror-prone,
> so I want to keep everything incremental and submit further rework
> later.

Well, I find this particular suggestion unproblematic since it deduplicates
two places with completely identical code into one. Further refactoring
belongs to a different series I agree. If you still don't want to move
these 10 lines in this series, I can live with that but at least don't call
the function igrab_try_lockless() with the comment "don't use elsewhere".
That just looks silly. Just call it igrab_from_hash() and later we can
move more code into it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
