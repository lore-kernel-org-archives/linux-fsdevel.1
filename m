Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69334EF0F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442240; cv=pass; b=A5Mgb7lbtebRHOumgr3Oa1rBP0eNanAzqw7XXk4ToXXnH2O4N4krOSu2SraPdd4ErSkVHr42p0nkqqU/Jlbs2ESXFZbbIe+slXYJGoijpy1uWBynjoNMZTVlRidEFdIPhh5ECTWTViR3aDuym+tw8N/0raGddFooGeiRWMZpwAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442240; c=relaxed/simple;
	bh=aBdslvXGMnRqLTzvdCU5aMGGW6vevm2X9iSBMg2C/Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQAE1aDqYqkm3PzTa4lPNtPMb/BrciFXYcrSY7GBpyCNrOVKrQn6iMm84wi/uLcMcol8F51Oh43wfsn9SsTRBAiIplCY0c5A9xVfT0MMzA0dcm7WgVHkqNcv8hDD6XXKlSWirwbiVV2CwAP4GFxbiY8IZHySh5EWO3F9ILeaMIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UV5DAAxK; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UV5DAAxK"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91173f20ccdso325836185a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 02:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779442236; cv=none;
        d=google.com; s=arc-20240605;
        b=c9JbCMuTFeofY9+VRbLkfNLR858xfQq0/cgU5w1KZ/AdIFOmZFvR10biqnfu1GA+IK
         KMTofTRLeZqLhRKBgNCRBDP+rCd3cW5Mm20fy9YkscQ3egoW0zdtBPqR85KN7PMR9GZD
         1/I89dBlachpuWAr6tvJQuWAMK8qPY1LrVg571oaDFLvnaPlsWWeReUq2QOpT/wr53+X
         /JYCzgeBKdgOoDsVbJ1VXIyc50EIL9xgV85EIvA9l2qbMKImWXjfl+3i+8iM8WwCN6Tj
         rQ4b7SzNnBY0ILU2KxkN56sixdrhas4q42uTMmtqHXe6rygPBJWT3cQqSH1DKFo6Pndo
         j1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iVU+TziQs+gOx7M+66kD16PammlxtEook1omqWZrRgs=;
        fh=QLFSpk9m55aHaGp226XWVBuHjxQcck3s5SHqV2KOIko=;
        b=kefIdrSDpyhOWBuFsNwkHLjvY1la7p9Pj3SlrAyvwU4o2ZNsphqDUA7I1RWt4xNJbf
         1dJlcyrss2ohLp3LK3D0bl6eZLI57shNN6xDtOfrpw2IAMqieFjtbAjr+34yQsMt04HQ
         hT9BWNA9OAoln8ZxUSIiwrjmTb2r2hgy7pNbx6H55pEZ3XDitd65oaz+RJ765ieD46wb
         CMddWPpEmjMQStbhZ49rNhHJO8rRadf8gw7WUNlRvfzd2a220M85e4dvzad2OlzDDf17
         p/phHr2o+ZuHYtou7JC4ayCsopxk3zPAhV7q4EV27ClQL4d/uzkaCy1CXHS5YvgFkw+Y
         5Rlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779442236; x=1780047036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iVU+TziQs+gOx7M+66kD16PammlxtEook1omqWZrRgs=;
        b=UV5DAAxKQvzCtosm5nwsvasQ171CEXNhpleIxwT2zaYCRdUOaUH+dlanbp2ebg98qa
         oSnTNZW/vxCvhBe1v9L5sG9sAIer4HjjwBKHwmReSy0kKvFHjdH1kIFTUV24NYiK1GVv
         zmbJw+JZ/jNKGPT5epaby7el7uXw3DxirrbgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779442236; x=1780047036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVU+TziQs+gOx7M+66kD16PammlxtEook1omqWZrRgs=;
        b=IYRssycA+UwgYwnA2hwCCOI1e5D9OQ88f+NZuKuS6pfGhMx1c9Vi/swdo82sIWkKsW
         lYZheiEVoAXn4tqfs/Ybe28W4b7BaXuG5JwX8hCwEal0jgXXn6wLU7xPkJFQKFdhSlFD
         vUKrJX+d1OEkNQZ183W39Xx0K0ShgstNs6aeRdLAQjv5TA2DjvkUSpyKTBimNWPsaZ9C
         MSV7MZKgYRNILRj4QV7efsgaWa2MX3/iRT733GV0Q+VHbar6xdNFzw0srplBaaVQSvDT
         rihC2MtY1xqXenWcKX44hQK878p8CQk6R2Ml8/REMFSbe6kn5fLD6GgfGYLB98ZJmFkU
         k1kQ==
X-Gm-Message-State: AOJu0YwbLAV89RAbepvl+fG4XLW8Y00aBSjRip4YCGJetNZowQL/yq44
	IWVJ1ou21bHV7m7wWnuzIK0iSM9NNzH6Q8GzZBjNul9kVlj13MT5Piin2G2nxueyJEyvxyBd8tH
	4+HHyAtEvP9o2q+hZiPyod7rRZYjD7kqpIhGI8KhhiA==
X-Gm-Gg: Acq92OE3mrlJNVusd1l6pfY3RIprUjwwTfIReUnH2OiIXfJWTf75sRakrpn6S7yXJLQ
	/D8dn0vYOLIYR6yo/y2gNBb0Kt8l3d0WZYiLoN8y82fYC2/D894Kp+PDDBzUTgFpYnFuNRzh5Vp
	q4PTgpCeOW67I04Xb62291i/dXtDfsieFBL95Nu6KabNt2Ge6oKRy+AnCQl4GrHDF4wcjsU2ILN
	jIodeqWkV2G9MKHQ8ezEhY/cbLQ+lnH3xZC/KQUeB+dbwRl0y94FuFaMwEGMXNYIDk6MpKbvekR
	FLc/hVn9akyfjvN4kt66if59nVNS+k0DRdEjMKo=
X-Received: by 2002:a05:620a:4407:b0:912:bd42:b46d with SMTP id
 af79cd13be357-914b492c5b3mr409068185a.25.1779442236272; Fri, 22 May 2026
 02:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
 <177922945262.2436837.15780670312601539883.stgit@frogsfrogsfrogs>
 <CAJfpegt=ex3B4mAF6xL5m-BZCtVBYWsP130WEVoSO_BrYibXmA@mail.gmail.com> <20260521225716.GF9544@frogsfrogsfrogs>
In-Reply-To: <20260521225716.GF9544@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 22 May 2026 11:30:24 +0200
X-Gm-Features: AVHnY4L53GWAls7HMJ0QgWsDUXxwAk-3vpNcwJbphhev2bphhsFBhqyJFUqti2E
Message-ID: <CAJfpegtjFT6Hw_YpOHe17Rfi16qMKsbm2Db2Lo7U=f2_CP6Pkw@mail.gmail.com>
Subject: Re: [PATCH 01/11] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com, 
	joannelkoong@gmail.com, fuse-devel@lists.linux.dev, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"

[Cc: Christoph]

On Fri, 22 May 2026 at 00:57, Darrick J. Wong <djwong@kernel.org> wrote:

> On Thu, May 21, 2026 at 06:24:58PM +0200, Miklos Szeredi wrote:
> > On Wed, 20 May 2026 at 00:26, Darrick J. Wong <djwong@kernel.org> wrote:

> > iomap_begin - fetch a mapping for an I/O
> > iomap_end - submitted I/O, done with the mapping
>
> It would be more accurate to say that we're done with the mapping.  If
> the fuse server acquired a resource to provide a mapping (say a cluster
> lock since technically speaking iomap could be used for them) then it
> ought to release the lock when we're done with it.

You are talking about things that this first version definitely
doesn't want to handle.  Stick to local fs for now, especially if it
just means leaving out parts of the interface that can later be added.

And that's a general comment, if we don't want to get bogged down with
reviewing thousands of lines of new code, then try to minimize the
functionality.  If the first version only supported R/O mounts, I'd be
totally fine with that.

Your current patchset is a prototype: it shows what's possible, but
that doesn't mean it has to be merged in one go.   Let's try to go in
baby steps towards the goal that your prototype has set.   But cluster
locks are even beyond that goal, so just ignore them for now.

> A second example is, if your fuse server implements speculative
> preallocation (aka delayed allocation) and a pagecache write fails due
> to ENOMEM or something, you want to notify the fuse server so that it
> can release the preallocation.

That's a FALLOC_FL_PUNCH_HOLE operation, no?  Fuse already supports that.

> > I'm not clearly seeing the difference between HOLE and DELALLOC in
> > terms of how the iomap code deals with them.  We really want
> > description of semantic details, and I'm not finding those except in
> > the code.
>
> You can't buffered write into a hole because that means there's no space
> available to land the write, but you can write if there's a reservation.
> Writeback isn't supposed to fail with ENOSPC.
>
> (You can't direct write into a hole or a reservation either, but that's
> not illustrative for my argument.)
>
> It's critical that the kernel knows the mapping state is correct even if
> iomap itself doesn't care about the difference.

IDGI.  When a write to device (DIO write/writeback) happens, and iomap
queries the mapping, the filesystem must return one with
IOMAP_UNWRITTEN or IOMAP_MAPPED, no?

So where does the kernel check the state?

> > I also have a slightly bad feeling about IOMAP_BEGIN being used twice
> > in the buffered write case for different purposes:
> >
> >  1) write to cache - AFAICS this is two functions rolled into one:
> >
> >    - space reservation: doesn't need the mapping, just returns
> > ACK/NACK, may need undoing on partial or failed I/O.  May not be
> > needed
> >    - read-modify-write: mapping to initialize cache.  Should be rare,
> > most writes are not this type
> >
> >  2) write to device - maybe allocate space, needs destination mapping
>
> Yes it is.

-ECANTPARSE

>  I actually had half a mind *not* to duplicate the IOMAP op
> flags and instead provide an enumeration:
>
> IOMAP_OP_READ           read{ahead}ing the pagecache from disk

Okay.

> IOMAP_OP_WRITE          writing to the pagecache

This is not an IOMAP operation.  Writing to the page cache does not
need to know the mapping.    It needs to reserve/allocate space, but
that's private to the filesystem, the page cache couldn't care less
about where that data will eventually go.

If the pagecache write need to read data, then make that an IOMAP_OP_READ.

If we wan't to combine allocation with read, that's fine, we'll do
that with compound requests in due course.

> IOMAP_OP_ZERO           zeroing folios around an unaligned write

Again, fuse already supports FALLOC_FL_ZERO_RANGE.  Having two
interfaces for the same thing doesn't make sense.

> IOMAP_OP_WRITEBACK      writing to disk

Call this IOMAP_OP_WRITE.

> IOMAP_OP_UNSHARE        trigger cow for shared extents

FALLOC_FL_UNSHARE_RANGE + IOMAP_OP_WRITE

> IOMAP_OP_DIRECTIO_READ  directio
> IOMAP_OP_DIRECTIO_WRITE

What's the difference from their non-DIO counterparts?

> IOMAP_OP_FIEMAP         fiemap/bmap

Why is this different from IOMAP_OP_READ?

> IOMAP_OP_LEASE_LAYOUT   swapon, effectively
> IOMAP_OP_REVOKE_LAYOUT  swapoff

This can also be a new "exclusive lease" op + IOMAP_OP_WRITE

> IOMAP_OP_DAX_READ       fsdax "io"
> IOMAP_OP_DAX_WRITE

All parties should know about what sort of device they are dealing
with, block or dax or whatever.   This info doesn't need to be sent
across the interface again and again.

> > > +#define FUSE_IOMAP_DEV_NULL            (0U)    /* null device cookie */
> >
> > This is for unallocated mappings?  Not sure that it needs an explicit
> > constant.  Unused fields are always assumed to be zeroed.
>
> Correct, this is for any mapping type that isn't MAPPED or UNWRITTEN.
> Yes, we can assume it's zero, but in light of the recent rseq input
> validation mess I decided to crank up the level of validation.

I'm not against validating unused fields, that's fine.  But the
initialization can be implicit.  This simplifies the interface and the
code.

> > > +/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F_ */
> > > +#define FUSE_IOMAP_F_NEW               (1U << 0)
> >
> > Definition in iomap.h implies this is about the need to zero blocks,
> > but isn't that exactly the same as UNWRITTEN vs MAPPED?
> >
> > Looking at iomap code: IOMAP_UNWRITTEN does imply zeroing, so
> > FUSE_IOMAP_F_NEW is only useful for IOMAP_MAPPED.  Confused.
>
> Old unix filesystems don't have unwritten mappings, so any newly
> allocated blocks get MAPPED status and have to be zeroed.

So why can't old unix filesystems just say this is an IOMAP_UNWRITTEN
extent instead of a IOMAP_MAPPED extent with an FUSE_IOMAP_F_NEW flag?
 Seems the two are exactly equivalent from an interface PoV.

> > > +#define FUSE_IOMAP_F_DIRTY             (1U << 1)
> >
> > The only affect this seems to have is to prevent FUA write in DIO
> > write path.   FUA writes are an optimization?  Or lack of FUA write is
> > an optimization?
>
> Correct -- if the inode is dirty, directio writes can't just issue an
> FUA with the write and call it a day; it also needs the ioend callback
> to know when to flush the dirty inode.  This flag just turns off the FUA
> since we can write the data + metadata and then issue CACHE FLUSH.

Okay, so it's just an optimization.   I'd say, omit for now.

> > > +#define FUSE_IOMAP_F_SHARED            (1U << 2)
> >
> > This is passed onto fiemap, it's useful to userspace but does not
> > change iomap semantics.  I note that while BTRFS obviously does use
> > shared extents, it does not set this (or any other) iomap flag.
>
> btrfs doesn't use iomap for pagecache operations

What does fiemap has to do with the pagecache?

> > > +/* fuse-specific mapping flag asking for ->iomap_end call */
> > > +#define FUSE_IOMAP_F_WANT_IOMAP_END    (1U << 7)
> >
> > AFAICS, nothing actually uses this at this point.  Can be dropped?
>
> I don't know.  There are filesystems like gfs2 that hold a transaction
> open between ->iomap_begin and ->iomap_end, so the ->iomap_end call is
> definitely required.  This may or may not be necessary for userspace
> filesystems, but I wouldn't wager against giving userspace a flag to
> force the FUSE_IOMAP_END command.

Please drop all "I wouldn't wager against" types of features without a thought.

> > > +#define FUSE_IOMAP_OP_FAULT            (1U << 3)
> >
> > Unused.
>
> page_mkwrite (aka mmap write faults)

But filesystems (at least the prototype ones) simply don't care.  Just drop.

> > > +#define FUSE_IOMAP_OP_NOWAIT           (1U << 5)
> >
> > Unused.  If it's NOWAIT, it probably has no business in userspace.
>
> Later on it means that we can query the cache but not call the server.

So it's internal to the cache and doesn't ever reach the server.  Please drop.

> overwrite_only, atomic, and dontcache are actually flags.
> And yeah, they're not needed right now but I don't want to have to burn
> FUSE_CAP_ flags to add them later when I could just -EOPNOTSUPP them
> now. ;)

Don't worry about that.  Really.   Just drop everything that is not
needed RIGHT NOW to have a working implementation.  And I mean
working, not optimized.  Optimization is the last step.

Dropping code is easy and it makes review faster, and at this point
review is the biggest bottleneck.  Yeah, <insert favorite AI> can
review patches by the truckful, but it cannot evaluate design
decisions and high level stuff.

> > > +#define FUSE_IOMAP_NULL_ADDR           (-1ULL) /* addr is not valid */
> >
> > Hmm.
>
> LBA 0 is valid.

So what?  It's an unmapped extent, the address is not used.  Leave it
zero and validate that it's zero.

> Another strike against high level fuse servers using iomap is that you
> can't support hardlinks because if you hardlink /mount/a to /mount/b,
> the high level fuse library will assign different nodeids (and create
> separate kernel inodes) for a and b.
>
> That might be a bug in libfuse?

Right.   Just drop highlevel support for iomap and be done with that.

> > > +struct fuse_iomap_begin_out {
> > > +       /*
> > > +        * Read file data from here.  This must be set even for a write
> > > +        * operation due to the possibility of a read-modify-write.
> > > +        */
> > > +       struct fuse_iomap_io    read;
> > > +
> > > +       /*
> > > +        * Write file data to here.  This must be set even for a read
> > > +        * operation.  If writes are not allowed, reply to the IOMAP_BEGIN
> > > +        * command with EIO or EROFS.
> > > +        */
> > > +       struct fuse_iomap_io    write;
> > > +};
> >
> > So this is definitely an improvement over the kABI iomap/srcmap, but I
> > do wonder if we could get away with a single map, OP_WRITE indicating
> > which direction it should referring to.
>
> Not really.  Pagecache write operations can require both a read source
> and a(n alleged) write destination if someone tries an unaligned write
> to an uncached region of the file.

Why does that need a write destination?  It needs a promise that the
space was reserved for the write.  It doesn't need the actual
destination.   And DELALLOC is exactly that: a promise.   A zero
return value is perfectly fine for that.  A failed reservation would
return -ENOSPC.

Thanks,
Miklos
