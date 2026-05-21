Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373A1374E67
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380714; cv=pass; b=nDsoPSsFyNUnsI1t7qfTj8BQYAYB+IT7a54DDCGQX608gnLFQmiYq1MM91XI9UYMuh45RXVSucU3jiUigVNJChYvSby01DbQOM7g1RfeTX8ikbqNKR1Brf8VnAzV3fOdBj08EhqaI7bFAbsx32it1z+3fyZyga4xL5yoZbdp4E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380714; c=relaxed/simple;
	bh=3+81ZsrNLXQJ9DUPEmuG9xZigh5fkfhJooRWa3gEQzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASTTKNEHxq36dxLsntkqr+MY6CPuBjpFk12K6oGbhgptmTiYUdRpXNutseEZj5mBNE6hhzKpe31SM87nExdMN+fVDOoAlvwC9Kihv50ld2I2xDpcweecZF+MvI1/6ntTgg91VfomcVrOS284AIKM4PfZtIpuhE4UCIqHxrGT2JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IWpYAdsM; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IWpYAdsM"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516d15ed2bcso2304671cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779380710; cv=none;
        d=google.com; s=arc-20240605;
        b=FLaBKof9eQCLW8sqZSTFa9BMAglcHj9Wky53tObKWE024FL4bbbxledDq1aKRi8HeL
         808TYfK5ON3XPDYXtbnptK1Btw0/8TQxuE+CD8EnQPTtgWKjZtnsJDYzTuxZYWGqSmKR
         zbB+oMkeXXMP2KuPouJyN1fHO/cFsCYEBnnOGCWYR0R/PfXormvD2oP0n7w5cfrSy/9R
         CXRdfbGIN/Mf8A+9zQF0EvjpHvw8X0lTjYoRzQcw9SLO6KVhC4jaVgEBs0iyOqKinrzO
         C5aRR5K1ieiJPDIF//0AFWogBjoY/dbwCzMHAfQAEOAAnymQg3yTii3gmfPZo4w6yy7n
         GI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/LTCGjUcQUdvT8rvxs/zI7FC7JwU4McChqmewlp+Uyg=;
        fh=Li7TFldRScaf7c8HnzaNvAckI9eX5hs0w83Wjfwoyn4=;
        b=dflkaNKVOR8E9HJIDo8cC9rXyVTxzB4aZFV3gK//2XJpW06I05JpruVyhZbLhiCQ0M
         amYXQtDMvHSw9Wg2RqG1Ir/cgFZk7XtHKyPhWxmzjlbu4UAzkVkOZpMGkC6b+vjuISyo
         bORSX0JkNHB9oKkrVEYaRTQThFWjnTUfZnN16oqqvrAwl5OrAcQkK4f4xRw8cTpjBQVe
         0X/ol26/1pUwjGGn0fKtXOF3s82dTv8kjITt0hWwIe7xV7qqxMl5kwPwQa+CjWZBDDhf
         /Gnf7BMQZGf0YKXTtcyj4ReyjOQ732MsDNyKDDgJEkik8w04I17l52xQFH91+IZ1BSIV
         f0fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779380710; x=1779985510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/LTCGjUcQUdvT8rvxs/zI7FC7JwU4McChqmewlp+Uyg=;
        b=IWpYAdsMCZ95Wsxl4qxbtsM7em7mmaaxU10Es3xk578XIveCHFqSbr011qu9nRoPv4
         mE7epnXZkPHU3LiZYAijFxHBdyr4PVtgjhBl85rViPhwJWLrFKGOzGJm1AUavOETVifz
         cMN1cOt1OJpKStwiJAaM0EQq0XJIdqxCuMwOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380710; x=1779985510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LTCGjUcQUdvT8rvxs/zI7FC7JwU4McChqmewlp+Uyg=;
        b=UYDvuuEolIJAMjGoKRHIV+o6rZC2AKGGW+jSKuGP6Ls8bnKu8uU8xscTIX2ewflA1D
         iDrHeC2+/gpklorkTyqnv5ktbpQbwzXOJVD2eqfcLPG0BBhiFzR3c1vCsKKwO3g2j1qR
         fF12s4GeBSjB4WyTghzQqJ9rK7BhRXkROX8GaG+yXbdJ8HlVGpXaQOhDcN/ubVgvkf7R
         GnVHMVqdXeBPiDVqDeme5g6B3Bmdd932xoA5px+zWhATuad4pkpN0B039e577cX2ba4+
         LAOJp2LkZ33wn1tNNUDanhpCxJyxAdgpal6A/yAZGrbqtb7+XOMuacE/TfNqWh9qYIBF
         YWaw==
X-Gm-Message-State: AOJu0YzgYblaO3FmxBlYvRLddg2ylxTOQmn45nJ4ajvBhkCnMXaY+khG
	Yw8XfA5J9YuRK80WyZJ5KqUEAoIyqNakzb4yRST8+OOcmq0bFu4oXXhiDmsn1XVvOk4Q/tDSifd
	dU3LGTtNVZLlaJgNWIIPCRFRV4uhdpWZPF3mgJB9s5A==
X-Gm-Gg: Acq92OFM7eFKlgMmPmDFyogjQOrLfmfZULAVVLw3FuSTDrzF2JXVygeVjcjk1Np530m
	ll7MPEiUBh5BOsXOLjkp6fgpxUe20G5wxXDzqVcnYRVEwjr9tHR3HeLFkjf5ABGLeQ7OL3oY/vQ
	fJsxEa0c9eeE12unqsp31fl4HRxFRo3x1p+jKzmCTTtC7KxxrS8wXIDhDp+0zKD6fsvP5fJKw2J
	oih6BOAqv706UaTUSmxHmJObkb6+Cvv19We0y8sZl96ZbPjvhogmoMFrK1Xh9lvapPsS3GsUZGf
	PcZ0mmMk/yMutwX7VvwInYyXf+EbKazecc4C
X-Received: by 2002:a05:622a:5c89:b0:50d:6fd3:421 with SMTP id
 d75a77b69052e-516c5847b1emr45515351cf.6.1779380709850; Thu, 21 May 2026
 09:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs> <177922945262.2436837.15780670312601539883.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945262.2436837.15780670312601539883.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 21 May 2026 18:24:58 +0200
X-Gm-Features: AVHnY4JHDkP8LojUlU7pXgsLzon3eXride3IivgsgbZT2iv0KMFhFNrym3zbEv8
Message-ID: <CAJfpegt=ex3B4mAF6xL5m-BZCtVBYWsP130WEVoSO_BrYibXmA@mail.gmail.com>
Subject: Re: [PATCH 01/11] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com, 
	joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 00:26, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Implement functions to enable upcalling of iomap_begin and iomap_end to
> userspace fuse servers.

iomap_begin - fetch a mapping for an I/O
iomap_end - submitted I/O, done with the mapping

Seems like the latter is more an internal implementation detail, not
an interface to be exported to the fs server.  Can you explain why
filesystem servers would or should care?

> +/* mapping types; see corresponding IOMAP_TYPE_ */

I think we should not reference the kernel implementation of iomap.
kAPI is not guaranteed to be stable, while this one must be.  So this
interface has to make sense without relying on the iomap kAPI
definition.

[Occurs to me that I made the same mistake for the fuse API, so I
should definitely try to properly document the interface now.  That
should also help with getting something saner for fusex]

I'm adding short definitions, yell if I got something wrong.

> +#define FUSE_IOMAP_TYPE_HOLE           (0)

"unallocated, zeros returned"

> +#define FUSE_IOMAP_TYPE_DELALLOC       (1)

"unallocated, zeroes returned, space is reserved"

> +#define FUSE_IOMAP_TYPE_MAPPED         (2)

"allocated, data is valid"

> +#define FUSE_IOMAP_TYPE_UNWRITTEN      (3)

"allocated, data is invalid, zeroes returned"

> +#define FUSE_IOMAP_TYPE_INLINE         (4)

"cannot be mapped"

I'm not clearly seeing the difference between HOLE and DELALLOC in
terms of how the iomap code deals with them.  We really want
description of semantic details, and I'm not finding those except in
the code.

I also have a slightly bad feeling about IOMAP_BEGIN being used twice
in the buffered write case for different purposes:

 1) write to cache - AFAICS this is two functions rolled into one:

   - space reservation: doesn't need the mapping, just returns
ACK/NACK, may need undoing on partial or failed I/O.  May not be
needed
   - read-modify-write: mapping to initialize cache.  Should be rare,
most writes are not this type

 2) write to device - maybe allocate space, needs destination mapping

> +/* fuse-specific mapping type indicating that writes use the read mapping */
> +#define FUSE_IOMAP_TYPE_PURE_OVERWRITE (65535)

Does this need to be special cased?  Based on the above, read and
write mappings are never both used.  The write mapping is only used
when data is written to the device (DIO write or writeback) and in
that case the read mapping is ignored.

> +
> +#define FUSE_IOMAP_DEV_NULL            (0U)    /* null device cookie */

This is for unallocated mappings?  Not sure that it needs an explicit
constant.  Unused fields are always assumed to be zeroed.

> +
> +/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F_ */
> +#define FUSE_IOMAP_F_NEW               (1U << 0)

Definition in iomap.h implies this is about the need to zero blocks,
but isn't that exactly the same as UNWRITTEN vs MAPPED?

Looking at iomap code: IOMAP_UNWRITTEN does imply zeroing, so
FUSE_IOMAP_F_NEW is only useful for IOMAP_MAPPED.  Confused.

> +#define FUSE_IOMAP_F_DIRTY             (1U << 1)

The only affect this seems to have is to prevent FUA write in DIO
write path.   FUA writes are an optimization?  Or lack of FUA write is
an optimization?

> +#define FUSE_IOMAP_F_SHARED            (1U << 2)

This is passed onto fiemap, it's useful to userspace but does not
change iomap semantics.  I note that while BTRFS obviously does use
shared extents, it does not set this (or any other) iomap flag.

> +#define FUSE_IOMAP_F_MERGED            (1U << 3)

Same as above.  Only applies to fs which have block mappings instead
of extent mappings.

> +#define FUSE_IOMAP_F_BOUNDARY          (1U << 4)

Prevent merging of ioend calls.  Fringe functionality, used by xfs for
request trace group separation.

> +#define FUSE_IOMAP_F_ANON_WRITE                (1U << 5)

Write mapping has a target device but no address. Only used by XFS.
Don't really see if/how this applies to fuse-iomap.

> +#define FUSE_IOMAP_F_ATOMIC_BIO                (1U << 6)

Filesystems (ext4, xfs) just turn IOMAP_ATOMIC request into
IOMAP_F_ATOMIC_BIO.   Not quite sure why a trip through the filesystem
is needed.

> +
> +/* fuse-specific mapping flag asking for ->iomap_end call */
> +#define FUSE_IOMAP_F_WANT_IOMAP_END    (1U << 7)

AFAICS, nothing actually uses this at this point.  Can be dropped?

> +
> +/* mapping flags passed to iomap_end */
> +#define FUSE_IOMAP_F_SIZE_CHANGED      (1U << 8)

This is used in fuse[24]fs, but with an XXX.  It'd be really nice to
be able to just drop FUSE_IOMAP_END, especially since it's easily
confused with FUSE_IOMAP_IOEND, which does something very similar (and
which I'd rename FUSE_IOEND, but let's save bikeshedding for later...)

> +#define FUSE_IOMAP_F_STALE             (1U << 9)

Unused.

> +
> +/* operation flags from iomap; see corresponding IOMAP_* */
> +#define FUSE_IOMAP_OP_WRITE            (1U << 0)

This is where it becomes really confusing.  IOMAP_WRITE is used by
buffered write and DIO write, but not for writeback. While DIO write
and writeback has much more in common: actual write to device, needs
write mapping.

> +#define FUSE_IOMAP_OP_ZERO             (1U << 1)

Unused.  FUSE_FALLOCATE already did this, no?

> +#define FUSE_IOMAP_OP_REPORT           (1U << 2)

In all examples the code for READ and REPORT are identical.  This
seems to just add confusion and complexity at this point.

> +#define FUSE_IOMAP_OP_FAULT            (1U << 3)

Unused.

> +#define FUSE_IOMAP_OP_DIRECT           (1U << 4)

Is this just  part of the IOMAP_WRITE / IOMAP_WRITEBACK confusion, or
is it useful for something else as well?

> +#define FUSE_IOMAP_OP_NOWAIT           (1U << 5)

Unused.  If it's NOWAIT, it probably has no business in userspace.

> +#define FUSE_IOMAP_OP_OVERWRITE_ONLY   (1U << 6)

Unused.  Used by XFS for optimization purposes.

> +#define FUSE_IOMAP_OP_UNSHARE          (1U << 7)

Fuse doesn't yet support reflinks.

> +#define FUSE_IOMAP_OP_DAX              (1U << 8)

Unused.

> +#define FUSE_IOMAP_OP_ATOMIC           (1U << 9)

Examples just do the FUSE_IOMAP_OP_ATOMIC -> FUSE_IOMAP_F_ATOMIC_BIO,
exactly like in the kernel.  A feature flag would allow getting rid of
both flags.

> +#define FUSE_IOMAP_OP_DONTCACHE                (1U << 10)

Unused.

> +#define FUSE_IOMAP_OP_WRITEBACK                (1U << 11)
> +
> +/* file write operations */
> +#define FUSE_IOMAP_OP_WRITE_MASK       (FUSE_IOMAP_OP_WRITE | \
> +                                        FUSE_IOMAP_OP_ZERO | \
> +                                        FUSE_IOMAP_OP_UNSHARE | \
> +                                        FUSE_IOMAP_OP_WRITEBACK)

So this should instead be just FUSE_IOMAP_OP_WRITE: a single flag
indicating that this is a request for a write mapping.

> +
> +#define FUSE_IOMAP_NULL_ADDR           (-1ULL) /* addr is not valid */

Hmm.

> +
> +struct fuse_iomap_io {
> +       uint64_t offset;        /* file offset of mapping, bytes */
> +       uint64_t length;        /* length of mapping, bytes */
> +       uint64_t addr;          /* disk offset of mapping, bytes */
> +       uint16_t type;          /* FUSE_IOMAP_TYPE_* */
> +       uint16_t flags;         /* FUSE_IOMAP_F_* */
> +       uint32_t dev;           /* device cookie */
> +};
> +
> +struct fuse_iomap_begin_in {
> +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> +       uint32_t reserved;      /* zero */
> +       uint64_t attr_ino;      /* matches fuse_attr:ino */

Ugh, what is this for?

> +       uint64_t pos;           /* file position, in bytes */
> +       uint64_t count;         /* operation length, in bytes */
> +};
> +
> +struct fuse_iomap_begin_out {
> +       /*
> +        * Read file data from here.  This must be set even for a write
> +        * operation due to the possibility of a read-modify-write.
> +        */
> +       struct fuse_iomap_io    read;
> +
> +       /*
> +        * Write file data to here.  This must be set even for a read
> +        * operation.  If writes are not allowed, reply to the IOMAP_BEGIN
> +        * command with EIO or EROFS.
> +        */
> +       struct fuse_iomap_io    write;
> +};

So this is definitely an improvement over the kABI iomap/srcmap, but I
do wonder if we could get away with a single map, OP_WRITE indicating
which direction it should referring to.

> +
> +struct fuse_iomap_end_in {
> +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> +       uint32_t reserved;      /* zero */
> +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> +       uint64_t pos;           /* file position, in bytes */
> +       uint64_t count;         /* operation length, in bytes */
> +       int64_t written;        /* bytes processed, or a negative errno */
> +
> +       /* mapping that the kernel acted upon */
> +       struct fuse_iomap_io    map;

If we do end up with this being needed, I wonder if we just need to
save the needed state in the server and reference it with a cookie?

Thanks,
Miklos
