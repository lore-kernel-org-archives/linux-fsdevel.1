Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFF3E40F3
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270672; cv=none; b=KIwrnGZppYbkjk5D5Q8RRX0fanw3IHexILVLvbJCrlqNZgzzhNLGJTtpQ8MD87kC0LFCApQWD9bovCLMiKWEvcRzbAVOJduf+jFevOdYGmAPK2TqQo3BcsPzILFCx0gOuEP/qBrtB2TGtiNL7bLbW9NR4TdcN1NruqpevEIAuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270672; c=relaxed/simple;
	bh=Qj+S5hBmTNkZHtWdJHxtjVJDIgDsO2tIwunahkOhvbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwuRjm9rp1+E+y7I5l1dm9/3nQT25oyLdqmluuzQP82iwqGMJskfG3G5oqTFJk72osfLdmBXq4xU27ywxHqsVqqlVgp1Ix8zsZlcBk9salKT6siqZ2gPxHkCXq78EO2dQuBKd4f92fQ7XFFN1SZUI/2o7uADGVQMRH/iTOIcOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dhEWgyGx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VC50vUiM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LR6NReq+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzdn+HWp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dhEWgyGx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VC50vUiM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LR6NReq+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzdn+HWp"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4757721E73;
	Thu, 24 Sep 2026 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790270665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvmWxh/7sadN71Ry+teJ71fIRtn4jq4tR13Iaa3OJy4=;
	b=dhEWgyGxS5Z5ctqdR0yICoWzdBB0/evYvqjpk5eOD1jcIcU4aOxCPylklMp5aBo/6Rmq5I
	dUXZ62pEbl3eetWcqBF0MgLnil7RZTifdXtkp/gE+M3+zD8xTqFzsvM/pq/kkK6t0qV4N8
	VPUIl6MH31xZUMUAowWjb1qWMhkknyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790270665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvmWxh/7sadN71Ry+teJ71fIRtn4jq4tR13Iaa3OJy4=;
	b=VC50vUiMtbYDIbX0z7mDu1x6GjouR4gRpsmavETWMf7FxDOkkNtaAVSvfw7hMqFmDfFvoc
	xCrnojy1ZCfzhBAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790270661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvmWxh/7sadN71Ry+teJ71fIRtn4jq4tR13Iaa3OJy4=;
	b=LR6NReq+TnUe5fdXqufVbr4D3bjuLwcDrpW2pU5O3+qenfciV90e6EhHdfYQPbhFZWo4FV
	ta1usx9+3SVdWMDBaYY4ThbqIs4HZ+B4HbHXslThf0OXSFXTeNHoIahAtWZuOZPozfxvJd
	ovyj1jVSV3EpC7Nvd4rpdichfy5LO3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790270661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvmWxh/7sadN71Ry+teJ71fIRtn4jq4tR13Iaa3OJy4=;
	b=pzdn+HWptHAnoGOU288Z97sHw5tQ7d/athgrR1UmFoXDnphsjPqP6U+o/LPuaivqTfyN4z
	0i9GFyYTvdSFZSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBA3C13354;
	Thu, 24 Sep 2026 17:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YW4xMMRctWrdCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 17:24:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C4EDA132E; Thu, 24 Sep 2026 19:24:16 +0200 (CEST)
Date: Thu, 24 Sep 2026 19:24:16 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>, 
	Mikhail Rudenko <xyzzy@yandex-team.ru>
Subject: Re: [PATCH 0/5 v2] fs: Deferred inode reclaim
Message-ID: <pu4x4cgddu7pcb6gm5bue3eksr5rarbcqu4h3un2z56txi7p6x@ydiql33kyvtb>
References: <20260911081309.14137-1-jack@suse.cz>
 <20260917-entweder-limitieren-kiefer-f033614058bd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-entweder-limitieren-kiefer-f033614058bd@brauner>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Thu 17-09-26 11:56:17, Christian Brauner wrote:
> > Hello,
> > 
> > after a long pause here is a second revision of my patches implementing
> > deferred inode reclaim to deal with MM warnings due to GFP_NOFAIL allocations
> > from reclaim paths. This happens because to reclaim some inodes, filesystems
> > have to do IO including complex operations using journalling and forward
> > progress of these depends on successful memory allocations (which is impossible
> > to guarantee from reclaim context).
> > 
> > This time I have fully tested the patch set. In particular it survives full
> > fstests run on ext4 both as is as well as when marking all loaded ext4 inodes
> > for deferred reclaim to stress the deferred reclaim paths. I have also tested
> > (when marking all inodes for deferred reclaim) the patches by creating a memcg
> > with 128m memory limit and then scanning from 10 processes 600k inodes in total
> > which heavily exercises deferred inode reclaim paths. This also verified
> > efficiency of throttling of marking of inodes for deferred reclaim. Basically
> > we cannot guarantee any particular limit on the number of inodes queued for
> > deferred reclaim as that is bound only by their number in memory and memory
> > pressure. But as the number of queued inodes grows, the tasks creating them
> > get slowed down so eventually some equilibrium is hit. In my VM this was
> > at ~10k inodes (only slightly above the 8k limit when throttling kicks in)
> > but this all very much depends on the reclaim pressure, speed of deferred
> > reclaim etc. so I don't think this is some representative number.
> > 
> > The first patch is a pure fix for a problem I've hit when running fstests.  The
> > second patch deals with lazy timestamp updates which I've decided to handle
> > better directly inside the writeback infrastructure instead of deferring
> > reclaim. The remaining patches implement the inode reclaim deferal. Ext4 use of
> > deferred inode reclaim is there mostly as a demonstration. Other filesystems
> > need to determine which inodes need deferred reclaim and mark them as such
> > which generally requires good internal knowledge of the filesystem. I'm hoping
> > that once the infrastructure is there, fs developers prompted by MM warnings
> > will start using it :). I know for a fact that besides ext4 e.g. btrfs is
> > hitting MM warnings in inode reclaim as well.
> 
> This all looks worthwhile to me!
> Note that Sashiko is complaining about long-term stalls introduced by
> this patchset. If this is intended or bs then please let us know.

Yeah, there are some good suggestions from Sashiko. I'll address them and
respin.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
