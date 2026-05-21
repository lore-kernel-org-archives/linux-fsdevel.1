Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675A368D5A;
	Thu, 21 May 2026 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404239; cv=none; b=VREQVZFwQ4XzIKhkCMphH6uS0O8k5b2rribNffeNl44bdzN2joXQn3soDdlWtfd2gLwUVkGZhG2hjfwGhIQWDdzWGS+tuQ5o2TFPlOYTVTvmtwlTHopqmkcD2ZOs8BwobCOHoxqIcWYs+mQAL6isxmPbxxdC7J8SpvgrY0BYiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404239; c=relaxed/simple;
	bh=AMk5GuubOdJzdNEx69oHO4nCBfnMEo+wcvej23YdySw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwh7jnVNZbvPjQ+IOlada7JbxNley5KG0+8RgE8Ke5nvrg6DU37RcPVuWFo7Dc2o9DUDhVcLwjHctWKnuueE8KD0M9+2DavVfbyeZ/Qo42TI7Q4P+It00R9vuaIUwRsmfeBb7Syzq9S58D/tPx3r0yrVJDeHkAI/bnfe0meUaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd3Zlp43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd3Zlp43"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 603F91F000E9;
	Thu, 21 May 2026 22:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779404237;
	bh=GY2einx2LkUUQarc6wUG7BGM4cwCQrkohUFWSgYjUU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rd3Zlp43XzyZYbcmdIOxXLcAGRm3Fy1U6hS3n7oX487Me5AI2exUXxL9rGg/iQsEs
	 GQ2wpbqNtC7tdQoB8ZkcIeFmwIWxawHM1cJOkU2T56J2sz0swkwvd0yKX/dP62aQ8J
	 a8uxEWFFjCwe6LAmo8aucDDumBsJ6Ep9BeDMussH6lzJcyxi6yo76XT6CE4uqYuZjD
	 YniSIe6Ue93ZUW4qVKpQ6ez9uqAwAi4zG8a4/0jHO/93//KbWoiV4as5+BNgUh2sRp
	 P5GjqLgU2Ys1Fs5FruCqneO3jTHndudRUeP0zf1rvtGyzxsdYiUgw7duX0DLZJpnt3
	 qVRZl2/M+teag==
Date: Thu, 21 May 2026 15:57:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
	joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 01/11] fuse: implement the basic iomap mechanisms
Message-ID: <20260521225716.GF9544@frogsfrogsfrogs>
References: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
 <177922945262.2436837.15780670312601539883.stgit@frogsfrogsfrogs>
 <CAJfpegt=ex3B4mAF6xL5m-BZCtVBYWsP130WEVoSO_BrYibXmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt=ex3B4mAF6xL5m-BZCtVBYWsP130WEVoSO_BrYibXmA@mail.gmail.com>

On Thu, May 21, 2026 at 06:24:58PM +0200, Miklos Szeredi wrote:
> On Wed, 20 May 2026 at 00:26, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Implement functions to enable upcalling of iomap_begin and iomap_end to
> > userspace fuse servers.
> 
> iomap_begin - fetch a mapping for an I/O
> iomap_end - submitted I/O, done with the mapping

It would be more accurate to say that we're done with the mapping.  If
the fuse server acquired a resource to provide a mapping (say a cluster
lock since technically speaking iomap could be used for them) then it
ought to release the lock when we're done with it.

> Seems like the latter is more an internal implementation detail, not
> an interface to be exported to the fs server.  Can you explain why
> filesystem servers would or should care?

A second example is, if your fuse server implements speculative
preallocation (aka delayed allocation) and a pagecache write fails due
to ENOMEM or something, you want to notify the fuse server so that it
can release the preallocation.

> > +/* mapping types; see corresponding IOMAP_TYPE_ */
> 
> I think we should not reference the kernel implementation of iomap.
> kAPI is not guaranteed to be stable, while this one must be.  So this
> interface has to make sense without relying on the iomap kAPI
> definition.

Yeah, Christoph had the same reaction.

> [Occurs to me that I made the same mistake for the fuse API, so I
> should definitely try to properly document the interface now.  That
> should also help with getting something saner for fusex]
> 
> I'm adding short definitions, yell if I got something wrong.
> 
> > +#define FUSE_IOMAP_TYPE_HOLE           (0)
> 
> "unallocated, zeros returned"

I would say "mapped" instead of "allocated", but yes.

> > +#define FUSE_IOMAP_TYPE_DELALLOC       (1)
> 
> "unallocated, zeroes returned, space is reserved"

"Unmapped, zeroes returned on read, space is reserved for a write"

> > +#define FUSE_IOMAP_TYPE_MAPPED         (2)
> 
> "allocated, data is valid"
> 
> > +#define FUSE_IOMAP_TYPE_UNWRITTEN      (3)
> 
> "allocated, data is invalid, zeroes returned"
> 
> > +#define FUSE_IOMAP_TYPE_INLINE         (4)
> 
> "cannot be mapped"

Inline is a weird one, it means that we have to call the server to do
actual IO.

> I'm not clearly seeing the difference between HOLE and DELALLOC in
> terms of how the iomap code deals with them.  We really want
> description of semantic details, and I'm not finding those except in
> the code.

You can't buffered write into a hole because that means there's no space
available to land the write, but you can write if there's a reservation.
Writeback isn't supposed to fail with ENOSPC.

(You can't direct write into a hole or a reservation either, but that's
not illustrative for my argument.)

It's critical that the kernel knows the mapping state is correct even if
iomap itself doesn't care about the difference.

> I also have a slightly bad feeling about IOMAP_BEGIN being used twice
> in the buffered write case for different purposes:
> 
>  1) write to cache - AFAICS this is two functions rolled into one:
> 
>    - space reservation: doesn't need the mapping, just returns
> ACK/NACK, may need undoing on partial or failed I/O.  May not be
> needed
>    - read-modify-write: mapping to initialize cache.  Should be rare,
> most writes are not this type
> 
>  2) write to device - maybe allocate space, needs destination mapping

Yes it is.  I actually had half a mind *not* to duplicate the IOMAP op
flags and instead provide an enumeration:

IOMAP_OP_READ		read{ahead}ing the pagecache from disk
IOMAP_OP_WRITE		writing to the pagecache
IOMAP_OP_ZERO		zeroing folios around an unaligned write
IOMAP_OP_WRITEBACK	writing to disk

IOMAP_OP_UNSHARE	trigger cow for shared extents

IOMAP_OP_DIRECTIO_READ	directio
IOMAP_OP_DIRECTIO_WRITE

IOMAP_OP_FIEMAP		fiemap/bmap

IOMAP_OP_LEASE_LAYOUT	swapon, effectively
IOMAP_OP_REVOKE_LAYOUT	swapoff

IOMAP_OP_DAX_READ	fsdax "io"
IOMAP_OP_DAX_WRITE

The tricky part is that some of these op flags are mutually exclusive
and some are really just flags.  Well, maybe we can have a u8 op type
and a u24 flags field.

> > +/* fuse-specific mapping type indicating that writes use the read mapping */
> > +#define FUSE_IOMAP_TYPE_PURE_OVERWRITE (65535)
> 
> Does this need to be special cased?  Based on the above, read and
> write mappings are never both used.  The write mapping is only used
> when data is written to the device (DIO write or writeback) and in
> that case the read mapping is ignored.

I'll get to read vs. write mapping at the bottom, but let's just say yes
provisionally for now. :)

> > +
> > +#define FUSE_IOMAP_DEV_NULL            (0U)    /* null device cookie */
> 
> This is for unallocated mappings?  Not sure that it needs an explicit
> constant.  Unused fields are always assumed to be zeroed.

Correct, this is for any mapping type that isn't MAPPED or UNWRITTEN.
Yes, we can assume it's zero, but in light of the recent rseq input
validation mess I decided to crank up the level of validation.

> > +
> > +/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F_ */
> > +#define FUSE_IOMAP_F_NEW               (1U << 0)
> 
> Definition in iomap.h implies this is about the need to zero blocks,
> but isn't that exactly the same as UNWRITTEN vs MAPPED?
> 
> Looking at iomap code: IOMAP_UNWRITTEN does imply zeroing, so
> FUSE_IOMAP_F_NEW is only useful for IOMAP_MAPPED.  Confused.

Old unix filesystems don't have unwritten mappings, so any newly
allocated blocks get MAPPED status and have to be zeroed.

> > +#define FUSE_IOMAP_F_DIRTY             (1U << 1)
> 
> The only affect this seems to have is to prevent FUA write in DIO
> write path.   FUA writes are an optimization?  Or lack of FUA write is
> an optimization?

Correct -- if the inode is dirty, directio writes can't just issue an
FUA with the write and call it a day; it also needs the ioend callback
to know when to flush the dirty inode.  This flag just turns off the FUA
since we can write the data + metadata and then issue CACHE FLUSH.

> > +#define FUSE_IOMAP_F_SHARED            (1U << 2)
> 
> This is passed onto fiemap, it's useful to userspace but does not
> change iomap semantics.  I note that while BTRFS obviously does use
> shared extents, it does not set this (or any other) iomap flag.

btrfs doesn't use iomap for pagecache operations

> > +#define FUSE_IOMAP_F_MERGED            (1U << 3)
> 
> Same as above.  Only applies to fs which have block mappings instead
> of extent mappings.

Right, this one's for FIEMAP.

> > +#define FUSE_IOMAP_F_BOUNDARY          (1U << 4)
> 
> Prevent merging of ioend calls.  Fringe functionality, used by xfs for
> request trace group separation.

It prevents merging of writes to a zoned block device.

> > +#define FUSE_IOMAP_F_ANON_WRITE                (1U << 5)
> 
> Write mapping has a target device but no address. Only used by XFS.
> Don't really see if/how this applies to fuse-iomap.

This triggers the "WRITE APPEND" command for zbd devices, so the
FUSE_IOMAP_IOEND handler can use the returned disk address to update its
own file mapping.

> > +#define FUSE_IOMAP_F_ATOMIC_BIO                (1U << 6)
> 
> Filesystems (ext4, xfs) just turn IOMAP_ATOMIC request into
> IOMAP_F_ATOMIC_BIO.   Not quite sure why a trip through the filesystem
> is needed.

For any atomic write that crosses an allocation unit boundary, you have
to ask the filesystem so that it has the opportunity to reject the write
if it can't atomically persist a multi-fsblock mapping update.

It might be the case that we can relax that if the awu min/max would
allow it.

> > +/* fuse-specific mapping flag asking for ->iomap_end call */
> > +#define FUSE_IOMAP_F_WANT_IOMAP_END    (1U << 7)
> 
> AFAICS, nothing actually uses this at this point.  Can be dropped?

I don't know.  There are filesystems like gfs2 that hold a transaction
open between ->iomap_begin and ->iomap_end, so the ->iomap_end call is
definitely required.  This may or may not be necessary for userspace
filesystems, but I wouldn't wager against giving userspace a flag to
force the FUSE_IOMAP_END command.

> > +
> > +/* mapping flags passed to iomap_end */
> > +#define FUSE_IOMAP_F_SIZE_CHANGED      (1U << 8)
> 
> This is used in fuse[24]fs, but with an XXX.  It'd be really nice to
> be able to just drop FUSE_IOMAP_END, especially since it's easily
> confused with FUSE_IOMAP_IOEND, which does something very similar (and
> which I'd rename FUSE_IOEND, but let's save bikeshedding for later...)

That's a good point, FUSE_IOMAP_IOEND should just be FUSE_IOEND.

> > +#define FUSE_IOMAP_F_STALE             (1U << 9)
> 
> Unused.

This can be set by iomap internally.  I don't think there's a need to
expose ths one to userspace.

> > +
> > +/* operation flags from iomap; see corresponding IOMAP_* */
> > +#define FUSE_IOMAP_OP_WRITE            (1U << 0)
> 
> This is where it becomes really confusing.  IOMAP_WRITE is used by
> buffered write and DIO write, but not for writeback. While DIO write
> and writeback has much more in common: actual write to device, needs
> write mapping.
> 
> > +#define FUSE_IOMAP_OP_ZERO             (1U << 1)
> 
> Unused.  FUSE_FALLOCATE already did this, no?

This is for pagecache zeroing when doing an unaligned write to the
pagecache.

> > +#define FUSE_IOMAP_OP_REPORT           (1U << 2)
> 
> In all examples the code for READ and REPORT are identical.  This
> seems to just add confusion and complexity at this point.



> > +#define FUSE_IOMAP_OP_FAULT            (1U << 3)
> 
> Unused.

page_mkwrite (aka mmap write faults)

> > +#define FUSE_IOMAP_OP_DIRECT           (1U << 4)
> 
> Is this just  part of the IOMAP_WRITE / IOMAP_WRITEBACK confusion, or
> is it useful for something else as well?

FUSE_IOMAP_OP_WRITE writes to the pagecache
FUSE_IOMAP_OP_WRITEBACK writes pagecache to disk

FUSE_IOMAP_OP_WRITE | FUSE_IOMAP_OP_DIRECT is a directio write

> > +#define FUSE_IOMAP_OP_NOWAIT           (1U << 5)
> 
> Unused.  If it's NOWAIT, it probably has no business in userspace.

Later on it means that we can query the cache but not call the server.

> > +#define FUSE_IOMAP_OP_OVERWRITE_ONLY   (1U << 6)
> 
> Unused.  Used by XFS for optimization purposes.
> 
> > +#define FUSE_IOMAP_OP_UNSHARE          (1U << 7)
> 
> Fuse doesn't yet support reflinks.

Actually it can already, if a fuse server only does directio and catches
FICLONERANGE/FICLONE directly in its FUSE_IOCTL handler.

> > +#define FUSE_IOMAP_OP_DAX              (1U << 8)
> 
> Unused.

BUt probably needed for famfs.

> > +#define FUSE_IOMAP_OP_ATOMIC           (1U << 9)
> 
> Examples just do the FUSE_IOMAP_OP_ATOMIC -> FUSE_IOMAP_F_ATOMIC_BIO,
> exactly like in the kernel.  A feature flag would allow getting rid of
> both flags.
> 
> > +#define FUSE_IOMAP_OP_DONTCACHE                (1U << 10)
> 
> Unused.
> 
> > +#define FUSE_IOMAP_OP_WRITEBACK                (1U << 11)

overwrite_only, atomic, and dontcache are actually flags.
And yeah, they're not needed right now but I don't want to have to burn
FUSE_CAP_ flags to add them later when I could just -EOPNOTSUPP them
now. ;)

> > +
> > +/* file write operations */
> > +#define FUSE_IOMAP_OP_WRITE_MASK       (FUSE_IOMAP_OP_WRITE | \
> > +                                        FUSE_IOMAP_OP_ZERO | \
> > +                                        FUSE_IOMAP_OP_UNSHARE | \
> > +                                        FUSE_IOMAP_OP_WRITEBACK)
> 
> So this should instead be just FUSE_IOMAP_OP_WRITE: a single flag
> indicating that this is a request for a write mapping.

That's how iomap started, and now we have zero and unshare too.

> > +#define FUSE_IOMAP_NULL_ADDR           (-1ULL) /* addr is not valid */
> 
> Hmm.

LBA 0 is valid.

> > +
> > +struct fuse_iomap_io {
> > +       uint64_t offset;        /* file offset of mapping, bytes */
> > +       uint64_t length;        /* length of mapping, bytes */
> > +       uint64_t addr;          /* disk offset of mapping, bytes */
> > +       uint16_t type;          /* FUSE_IOMAP_TYPE_* */
> > +       uint16_t flags;         /* FUSE_IOMAP_F_* */
> > +       uint32_t dev;           /* device cookie */
> > +};
> > +
> > +struct fuse_iomap_begin_in {
> > +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> > +       uint32_t reserved;      /* zero */
> > +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> 
> Ugh, what is this for?

This is an ugly hack for high level fuse servers, because libfuse
assigns internal nodeids which may have nothing to do with what the fuse
server thinks are its own inode numbers.

The reason why this is necessary at all is that iomap operations can
target files that are no longer open (e.g. writeback after the last file
closes) so there might not be a fuse_file available to imprint a fh
value.

Another strike against high level fuse servers using iomap is that you
can't support hardlinks because if you hardlink /mount/a to /mount/b,
the high level fuse library will assign different nodeids (and create
separate kernel inodes) for a and b.

That might be a bug in libfuse?

> > +       uint64_t pos;           /* file position, in bytes */
> > +       uint64_t count;         /* operation length, in bytes */
> > +};
> > +
> > +struct fuse_iomap_begin_out {
> > +       /*
> > +        * Read file data from here.  This must be set even for a write
> > +        * operation due to the possibility of a read-modify-write.
> > +        */
> > +       struct fuse_iomap_io    read;
> > +
> > +       /*
> > +        * Write file data to here.  This must be set even for a read
> > +        * operation.  If writes are not allowed, reply to the IOMAP_BEGIN
> > +        * command with EIO or EROFS.
> > +        */
> > +       struct fuse_iomap_io    write;
> > +};
> 
> So this is definitely an improvement over the kABI iomap/srcmap, but I
> do wonder if we could get away with a single map, OP_WRITE indicating
> which direction it should referring to.

Not really.  Pagecache write operations can require both a read source
and a(n alleged) write destination if someone tries an unaligned write
to an uncached region of the file.

XFS/iomap started with a single iomap, and the direction was implied by
the opflags.  This didn't work so well when I added out of place writes
to XFS; for that, the "srcmap" was stapled on the side.  I don't like
that, and various porters get confused by it, so I decided I'd instead
have explicit read and write mappings for fuse-iomap.

Note that a log structured filesystem (aka what iomap_ow_ll.c does) also
needs the out of place write ability.

> > +struct fuse_iomap_end_in {
> > +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> > +       uint32_t reserved;      /* zero */
> > +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> > +       uint64_t pos;           /* file position, in bytes */
> > +       uint64_t count;         /* operation length, in bytes */
> > +       int64_t written;        /* bytes processed, or a negative errno */
> > +
> > +       /* mapping that the kernel acted upon */
> > +       struct fuse_iomap_io    map;
> 
> If we do end up with this being needed, I wonder if we just need to
> save the needed state in the server and reference it with a cookie?

You'd have to enlarge the iomap_begin response to have a cookie field,
and the fuse server would then have to track those cookies.  I think
it's easier just to echo back whatever mapping got used, particularly
since the server won't know to make a cookie if the mapping came from
the cache.

(Or it has to create the cookie at upsert time, and maintain that until
whatever unspecified point the cache drops the mapping.  Then the cache
has to be able to tell the fuse server that XX cookie can go away.)

--D
