Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42423B0AFA
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726224; cv=none; b=Q780ntkYIqxHdTlMURqtdrvKtiH8aA9AyMlWQfFxud+o2un7T7p5Z8F5fvRgwkBmgSUA/M0pTj8Lje9Jj35poYCMN7VWhtK0IDfG87ontbO/dvLo9kmEIe0tINTCvO0TNGMTFPKUsdUxcWNrUoMm8t69WfLFEdNPtXmCz03xSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726224; c=relaxed/simple;
	bh=gDNy2NhTLkwpKihTsErldlf448sw8vQZJeaUq7Q+33g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ip+Um+kcMfsj/upbLIy9lnks0MPdTD7X4r5KPOqz4Diad86CHfYo+5KEXgnd64cT3VLjX90DUo69WIxO3vEq6gMt9AuJaI8AATGpDSIaE4ODcOu+ysAu/PLGQFtqVQJX9f6xF5sYlaEo4pvqnFktSsNEdofb1CNZ9q/b9bRZOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cl2KFsBd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OeDSb5yP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cvjDxRnw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hT9LRiOr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cl2KFsBd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OeDSb5yP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cvjDxRnw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hT9LRiOr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1C584EE6E;
	Thu,  9 Apr 2026 09:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775726213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sGJ0OlHjX4pzaN/+U1PaKFUh61nxkXNQRA9d/Udbj1A=;
	b=Cl2KFsBd0NNf5T3cMlrgNZ9JdJgbCNohOoWbQDCCJYDTxBfJ0XQsmRMVA1j3IRFZN3oFf4
	3APFfJqYtTYYya+QrObagxm1Dz/yfE4srJ2VnvmTgPjOvFxafV1IJDoziDphlL/L2oppwF
	Zfj5ART7BgbD1UzWt+YJq75cEczowHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775726213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sGJ0OlHjX4pzaN/+U1PaKFUh61nxkXNQRA9d/Udbj1A=;
	b=OeDSb5yPLoFewX+U5tmdUAN+FcqjwngXChdeJJGPxAI7qSfTK1WwZCxoktpkGUvupXzoVs
	9zZolrzcUriAfnCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cvjDxRnw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hT9LRiOr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775726212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sGJ0OlHjX4pzaN/+U1PaKFUh61nxkXNQRA9d/Udbj1A=;
	b=cvjDxRnwx32fjl0TKqDidz4CeStb2rfEisTGBm500CvxQ+bU/WKOwo5iZcRQvFC3ZfNrli
	LlkFpdHkAvyiHA1oiN9xt6fMwkEeTHSmMuo/I6r475CtFKm26+5oIWR7S9Uts7TguFqCoN
	qwi2HeEXk6OUrvETVnsPghzpDJmv19A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775726212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=sGJ0OlHjX4pzaN/+U1PaKFUh61nxkXNQRA9d/Udbj1A=;
	b=hT9LRiOrWfkLHz6cWp+9iiJcFoWS/MENUswK30amy/J7wlx1ZIT91EAO8UqSt7Laa7ZJpb
	KFWbKAqlN+8laGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5B304A0B4;
	Thu,  9 Apr 2026 09:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VMfHL4Ru12mTPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Apr 2026 09:16:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 75939A0B66; Thu,  9 Apr 2026 11:16:44 +0200 (CEST)
Date: Thu, 9 Apr 2026 11:16:44 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: D1C584EE6E
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

Hello!

This is a recurring topic Matthew has been kicking forward for the last
year so let me maybe offer a fs-person point of view on the problem and
possible solutions. The problem is very simple: When a filesystem (ext4,
btrfs, vfat) is about to reclaim an inode, it sometimes needs to perform a
complex cleanup - like trimming of preallocated blocks beyond end of file,
making sure journalling machinery is done with the inode, etc.. This may
require reading metadata into memory which requires memory allocations and
as inode eviction cannot fail, these are effectively GFP_NOFAIL
allocations (and there are other reasons why it would be very difficult to
make some of these required allocations in the filesystems failable).

GFP_NOFAIL allocation from reclaim context (be it kswapd or direct reclaim)
trigger warnings - and for a good reason as forward progress isn't
guaranteed. Also it leaves a bad taste that we are performing sometimes
rather long running operations blocking on IO from reclaim context thus
stalling reclaim for substantial amount of time to free 1k worth of slab
cache.

I have been mulling over possible solutions since I don't think each
filesystem should be inventing a complex inode lifetime management scheme
as XFS has invented to solve these issues. Here's what I think we could do:

1) Filesystems will be required to mark inodes that have non-trivial
cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
whatever :)). Usually I expect this to happen on first inode modification
or so. This will require some per-fs work but it shouldn't be that
difficult and filesystems can be adapted one-by-one as they decide to
address these warnings from reclaim.

2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
performance reasons. I expect this to be a significant portion of inodes
on average and in particular for some workloads which scan a lot of inodes
(find through the whole fs or similar) the efficiency of inode reclaim is
one of the determining factors for their performance.

3) Inodes with I_RECLAIM_HARD will be moved by the shrinker to a separate
per-sb list s_hard_reclaim_inodes and we'll queue work (per-sb work struct)
to process them.

4) The work will walk s_hard_reclaim_inodes list and call evict() for each
inode, doing the hard work.

This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
and they can work on freeing memory needed for freeing of hard to reclaim
inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
they should really be addressed.

One possible concern is that s_hard_reclaim_inodes list could grow out of
control for some workloads (in particular because there could be multiple
CPUs generating hard to reclaim inodes while the cleanup would be
single-threaded). This could be addressed by tracking number of inodes in
that list and if it grows over some limit, we could start throttling
processes when setting I_RECLAIM_HARD inode flag.

There's also a simpler approach to this problem but with more radical
changes to behavior. For example getting rid of inode LRU completely -
inodes without dentries referencing them anymore should be rare and it
isn't very useful to cache them. So we can always drop inodes on last
iput() (as we currently do for example for unlinked inodes). But I have a
nagging feeling that somebody is depending on inode LRU somewhere - I'd
like poll the collective knowledge of what could possibly go wrong here :)

In the session I'd like to discuss if people see some problems with these
approaches, what they'd prefer etc.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
