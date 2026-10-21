Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575952;
	b=zLa5i1o/nCMUuHSfJwCFwsBaL8paGIbdZbI6ddM5zv0lSwaQzB0Pofo0FEssXoKXZPDU
	 zrAiyWSKgV3ycgfU7nuHzMCgisuR1fN9nBN3FRHzEw9uPeGOwy8aFXsnmVnrCvrRHVbPh
	 L8U61jLzZqRiP+A3oz++1NxtOuHjciz8a9F7NRB2CFzLSw6a5Zpj37NTL5u/bpayvIV2D
	 PumURpdH0OFB37lUGtcy58aP70nk+UyklBN6sCwztbUbuGRMO8Afiu/h0R9iBzXGxdcKb
	 6B/ERIHu7xPXUTsErbZEXNMi/8CSLgBeJ87Kucv788ljmaeaGXr121v3DZRf2b+asow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575952;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vLjcBcHzA+WIp+ZJZv4rjSsfmEqKojwOLkyYUmXD/8A=;
	b=YoRV3UzgaldbqkCVKj4b3rL6xN5kjR4JyjdVnmTJEhFFXVwprIltaFymvjwZULivteyD
	 B6pANTxydTHwiq2vYGY4gRjOG0VDKk2I7siavCjZ4C2WuT3NzUahrEdewMwmQRV9dd1F3
	 xDp6j3dZclZnAWW5dg9Miy0YZWUZBENtwXrzrbJQYO09CCAIZQ3BkbdeUV+JjsLlJ2VoO
	 14Sz1ckPdwBkCkPrdStmf4JTdtm+5JYXA/fbtN97sa5VNDi/5jKqjK+eTTZKWX8CRLmHY
	 Mlp2tM/2My0sBifXVJ6mHaft+WN2TLWYmxRlIWcE4uO+LPlXJTwXe+A/fPmWHiYDiIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8XFwqbV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E4606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8XFwqbV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90B51F000CB;
	Wed, 21 Oct 2026 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792575951;
	bh=vLjcBcHzA+WIp+ZJZv4rjSsfmEqKojwOLkyYUmXD/8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d8XFwqbVtLffQpIgAVCqi6vDbWuF9r66/9lYi3EnfcFZXkd9x9xXNTi8kTCp1ZtX+
	 rksyQYgGwm3jgGCUwEyOr4YZUCSHb3GdsRT5x57paDT8CcTKlul8vcIsoJKjIpSTWG
	 seEGv6VFq8GhemCn0YOyB3TafNuP/ahiXp9/ksAe3CoaG2FWLDABtBVPm7HwyGNqtr
	 SWURVe4LehvL6T5OaHqlfVJm1lxOQphIZwCEg6Qy89o1uZ2dHN1d/zS00gSuZXtFXD
	 vhIt45+31SoNdAP3Qo0/QL9at2Cz8sDmDkGVtokem3K1WcbaSEQknxDuzuefW7D5aH
	 z8WEtA5UN+46Q==
Date: Wed, 21 Oct 2026 11:45:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/3] namespace: rework connected mounts
Message-ID: <20261021-zusichern-ausformuliert-wirklich-f8c8c14e2e15@brauner>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
 <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
 <20261018031522.GC3535232@ZenIV>
 <20261018-popsong-pracht-quark-a0f9a2d3734c@brauner>
 <20261020184156.GL989762@ZenIV>
 <20261021-zulassen-flatterhaft-tragik-e7c6cd72a700@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261021-zulassen-flatterhaft-tragik-e7c6cd72a700@brauner>

On Wed, Oct 21, 2026 at 11:42:20AM +0200, Christian Brauner wrote:
> On Tue, Oct 20, 2026 at 07:41:56PM +0100, Al Viro wrote:
> > On Sun, Oct 18, 2026 at 06:32:19PM +0200, Christian Brauner wrote:
> > 
> > > Sure. Note that it's a separate allocation so 40 bytes land in
> > > kmalloc-64 just like 64 do. IOW, it's a cleanup, not a saving. I can do
> > > that for 7.4.
> > 
> > FWIW, I really don't like that separate allocation ;-/  For the majority
> > of struct mount instances we never access that thing after it's been set
> > up...
> > 
> > Sure, I see your point re separating the cleanup_mnt() guts and
> > detaching from the parent, and yes, having two separate structures
> > is a simple way to achieve that.  However, your variant pays for
> > that with overhead and I'm not convinced that it's actually simpler.
> > 
> > Consider the situation when mount reaches
> > 	call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt);
> > in the end of cleanup_mnt().  Possible states:
> > 
> > 1) never called leave_cover() at all.
> > 2) called leave_cover(), matching drop_cover() has already happened.
> > 3) called leave_cover(), matching drop_cover() is yet to come.
> > 
> > (1) is by far the most likely.  Suppose we have leave_cover() set
> > a new flag (MNT_COVER) and _not_ clear ->mnt_cover; that happens
> > under mount_lock and always ordered before cleanup_mnt().
> > Then we can have cleanup_mnt() do the following:
> > 
> > 	if no MNT_COVER		// case 1
> > 		call_rcu(...)
> > 	else
> > 		read_seqlock_excl(&mount_lock);
> > 		set MNT_MAY_FREE
> > 		if cover is already off the lists	// case 2
> > 			call_rcu(...)
> > 		read_sequnlock_excl(&mount_lock);
> > 
> > and in drop_cover()
> > 	remove from lists
> > 	if MNT_MAY_FREE		// case 3
> > 		call_rcu(...)
> > with delayed_free_vfsmnt() doing all freeing.  But then we don't
> > need the separate allocation at all.  What's more, we can reuse
> > ->mnt_mp for ->mnt_cover->mp and ->mnt_mp_list for ->mnt_cover->pin
> > just by having __umount_mnt() make
> > 	hlist_del_init(&mnt->mnt_mp_list);
> > 	mp = mnt->mnt_mp;   
> > 	mnt->mnt_mp = NULL;  
> > 	maybe_free_mountpoint(mp, shrink_list);
> > conditional upon the lack of MNT_COVER.  That kills your extra
> > check in maybe_free_mountpoint(), with the loops in __detach_mounts()
> > folded together (they'd walk the same list, using MNT_COVER to
> > discriminate between umount_tree() and drop_cover()).
> > 
> > ->cover->node moves to mount itself; it would be tempting to union
> > it with mnt_hash (making removal from mnt_hash in __umount_mnt()
> > also conditional upon !MNT_COVER).  _Probably_ safe - callers of
> > __lookup_mnt() either have mount_lock or check the seqcount side
> > of things soon enough.  Will need to check how that affects the
> > proof of safety in your "skip synchronize_rcu if possible" series,
> > though...
> > 
> > ->cover->dentry...  Fuck knows - might union with ->mnt_mountpoint
> > (again, conditional upon MNT_COVER), might put it separately;
> > ->mnt_cover goes away, so the size of struct mount won't grow.
> > Bits in ->mnt_flags are not scarce these days - we can afford stealing
> > two easily...
> > 
> > I'll try to cook something along those lines; looks at least plausible...
> 
> My original proposal reused struct mount just like this. It did it
> differently in other aspects but the idea was the same.
> 
> And note that I had about 5 different solutions to this and every single
> one of them was performance tested and profiled and only this one didn't
> actually cause meaningful performance regressions.
> 
> Note that as written the pin cannot be mnt_mp_list. It's unioned with
> mnt_umount and umount_tree() puts every unmounted mount on the unmounted
> list through it right after umount_mnt(). A cover that stays on the
> mountpoint's list and goes on the unmounted list corrupts one of the
> two.
> 
> The hash union is safe afaict. We already move a hash node between
> buckes without a gp in mnt_change_mountpoint() under the seqlock. That's
> fine a read will retry. It doesn't matter for the gp series.
> 
> But it makes dead mounts reachable when walking buckets and that's
> exactly the "nobody can find it anymore" argument in my gp series. So
> just put the cover into mnt_child. Nothing walks the mnt_child under rcu
> and a reader can't end up in the covers list through a stale next
> pointer. Plus, the proof stays as it is.
> 
> But, my main objection is this really ugly zombie state this creates and
> that I hate with a passion and tried to get rid of by explicitly not
> reusing struct mount itself and using a separate allocation.
> 
> In this variant above a cover is a struct mount that has been through
> cleanup_mnt(). After that point its superblock has been deactivated and
> its root dentry put, so mnt_sb and mnt_root are unpinned and maybe
> freed. Its mount id has been freed and can be handed to the next mount.
> So the zombie carries a live mount's id and its counters are zero.
> 
> Yet, the mount stays linked. It sits on the parent's covers list, which
> the lookup walks under rcu. It sits on the mountpoint's m_list which
> __detach_mounts() walks and maybe_free_mountpoint() counts.
> 
> That struct mount-as-cover variant also keeps pinning completely
> arbitrary things like the devname, the idmap reference and the percpu
> counters and whatever else we might end up glueing to it.
> 
> This has a bunch of ugly side-effects:
> 
> * A parentless mount sits on its own root. Both vfs_create_mount() and
>   __umount_mnt() make that a fact. Now, a cover in this idea has itself
>   as parent and a mountpoint maybe on another superblock.
> 
> * Current readers are only fine because they test for a parent first,
>   but the invariant itself is gone.
> 
> * Since covers aren't mounted anywhere every walker of the mountpiont
>   list now needs to branch on yet another flag, forever.
> 
> * Doomed and unreferenced on mainline now means: unlinked and rcu freed.
>   A cover here is doomed, unreferenced, yet on two lists, and
>   freed by whichever of two parties does touch that thing last.
> 
> I dislike all of this fragility. I had to go through UMOUNT_CONNECTED
> and I kinda had enough of this.
> 
> In the current approach nothing in struct mnt_cover can ever dagnle.
> Which was the point.
> 
> With struct mount itself as a cover walking the covers,
> __detach_mounts() and any debug printk are one added dereference away
> from a UAF.
> 
> So I'm not really on board with reusing struct mount for this. I think
> it adds unnecessary sublety without actually buying us anything just to
> shave off that allocation. For all I care we can make it a kmem cache.
> But I did profile this heavily and the performance numbers didn't move
> because of it.

Oh, and I have more fixes coming on top of what I did in mainline
because UMOUNT_CONNECTED is one of the most broken "security mechanisms"
I have ever seen. I know this wasn't your doing ofc but this whole thing
should not have been an acceptable solution. It is a giant can of worms
and full of holes.
