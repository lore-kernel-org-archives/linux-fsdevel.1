Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.89.141.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521721;
	b=Byx1Qdn5Ar3tmhDa99qv5ja/1sFL5VJsW4w6fOe0+Ix2MwsjGxe5bsGfdgpUbpcXRIjV
	 hdQcbTKW8FB/MpH01ohLIb/YI3AS4VO3ZrbOzXqfjCspiZ6tufFCdqDfwDFXXFP3kwWrp
	 1yqQZWVZMkpBmq58QDwVRqGMaS1R542T42eFrfNdfNEFmbK9uEavHaXWCzy39s7Fe1Jbt
	 c7clPSB/79Az8ayHDmZXSp9RNwjJz92X+UJkcGlTLCcvGbeZQM57qV+Rjc9fE9rc2JYuw
	 KOXa2BGKwrUy1Nr8z+a3nwVF3pYFLpdncdIKJv+2JewPUgoF5bkSByup6fwo8iZA+5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521721;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender;
	bh=cow/wQ1JXXby/wtXMJUrg5EzhM78TluzTu6F5y9CKuk=;
	b=Wz8cndAegZykDE0bW34zdjczZMukBWBjtxI+QpGS8XiBgd56obROp2hbKa73uZtWcWTt
	 P9s9jNI4v2t113f/DW9VuSmmYnvAkvLwxbLO8N8X79HXm8JRxpvbtYxsg0XVKzA2+SVN2
	 2a6wYldfpMdZ8qiv1ux2hLffV9DGmYexaGz8A/dS3oZ9FNvxlBbxT/2wor2MHWE/XKPNT
	 Q1FWzddSde/6GqQGBwUXp9QpWBuskXCh/KCfG+KLj+LMe+nRWlyrPJrj165B9zMnopKnM
	 mQnLVUokQkPycOSyM+2eBa7Q2LocwTpxSANHcFxucm1LXp4Xq2sOgHu51h+YYFNTBlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zeniv.linux.org.uk;
	spf=none smtp.mailfrom=ftp.linux.org.uk;
	dkim=pass header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=BDAHNb50;
	arc=none smtp.remote-ip=62.89.141.173
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32C606A319
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 18:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E32C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=BDAHNb50
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cow/wQ1JXXby/wtXMJUrg5EzhM78TluzTu6F5y9CKuk=; b=BDAHNb50JfoceCDr9ElD7gef4Z
	5b/ihxCGasgmIcMgAFX7Pq/4+GXnmwJLBMgmti4u2/QOdjp/C2vpLvVHygVTGmTu5uN34L5YOdiSA
	Umrud51iEiCg450Kt+P0pQssuG6jwgBrZv+tkHgj0RPXoIVsY9AjuMDCJvgn7mBfIQgV2Vs9dnxEn
	W21oOmKxA64hyi0yJ+Lw4aPZ79/GL6KY4nE8PnOQP3FrpHYhnGfPiK87HARlscE8QvUstNVsFowDR
	IgqnCsAnIeQ1K9p/xF/yCbSaFWVGZFdtpNWu3boh077PYRH6xVNQsznvx7H4sDduh8DOJW9s+TWF2
	edEWxktg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJEma-0000000GxrY-3EPU;
	Tue, 20 Oct 2026 18:41:56 +0000
Date: Tue, 20 Oct 2026 19:41:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/3] namespace: rework connected mounts
Message-ID: <20261020184156.GL989762@ZenIV>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
 <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
 <20261018031522.GC3535232@ZenIV>
 <20261018-popsong-pracht-quark-a0f9a2d3734c@brauner>
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
In-Reply-To: <20261018-popsong-pracht-quark-a0f9a2d3734c@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 18, 2026 at 06:32:19PM +0200, Christian Brauner wrote:

> Sure. Note that it's a separate allocation so 40 bytes land in
> kmalloc-64 just like 64 do. IOW, it's a cleanup, not a saving. I can do
> that for 7.4.

FWIW, I really don't like that separate allocation ;-/  For the majority
of struct mount instances we never access that thing after it's been set
up...

Sure, I see your point re separating the cleanup_mnt() guts and
detaching from the parent, and yes, having two separate structures
is a simple way to achieve that.  However, your variant pays for
that with overhead and I'm not convinced that it's actually simpler.

Consider the situation when mount reaches
	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
in the end of cleanup_mnt().  Possible states:

1) never called leave_cover() at all.
2) called leave_cover(), matching drop_cover() has already happened.
3) called leave_cover(), matching drop_cover() is yet to come.

(1) is by far the most likely.  Suppose we have leave_cover() set
a new flag (MNT_COVER) and _not_ clear ->mnt_cover; that happens
under mount_lock and always ordered before cleanup_mnt().
Then we can have cleanup_mnt() do the following:

	if no MNT_COVER		// case 1
		call_rcu(...)
	else
		read_seqlock_excl(&mount_lock);
		set MNT_MAY_FREE
		if cover is already off the lists	// case 2
			call_rcu(...)
		read_sequnlock_excl(&mount_lock);

and in drop_cover()
	remove from lists
	if MNT_MAY_FREE		// case 3
		call_rcu(...)
with delayed_free_vfsmnt() doing all freeing.  But then we don't
need the separate allocation at all.  What's more, we can reuse
->mnt_mp for ->mnt_cover->mp and ->mnt_mp_list for ->mnt_cover->pin
just by having __umount_mnt() make
	hlist_del_init(&mnt->mnt_mp_list);
	mp = mnt->mnt_mp;   
	mnt->mnt_mp = NULL;  
	maybe_free_mountpoint(mp, shrink_list);
conditional upon the lack of MNT_COVER.  That kills your extra
check in maybe_free_mountpoint(), with the loops in __detach_mounts()
folded together (they'd walk the same list, using MNT_COVER to
discriminate between umount_tree() and drop_cover()).

->cover->node moves to mount itself; it would be tempting to union
it with mnt_hash (making removal from mnt_hash in __umount_mnt()
also conditional upon !MNT_COVER).  _Probably_ safe - callers of
__lookup_mnt() either have mount_lock or check the seqcount side
of things soon enough.  Will need to check how that affects the
proof of safety in your "skip synchronize_rcu if possible" series,
though...

->cover->dentry...  Fuck knows - might union with ->mnt_mountpoint
(again, conditional upon MNT_COVER), might put it separately;
->mnt_cover goes away, so the size of struct mount won't grow.
Bits in ->mnt_flags are not scarce these days - we can afford stealing
two easily...

I'll try to cook something along those lines; looks at least plausible...
