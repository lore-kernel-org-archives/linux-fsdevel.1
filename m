Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2C3D522E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179974; cv=none; b=XWsXSwgbxyrOOzutRqyiC3joy3+3ZVcpp+Ew/v7DHhXihcLriOv3aRJoxDbtwbQ+paS8U4atEg05+SyMlA4ocZlqEpDQ2CDDotidT8rjzVYlFHrkl9Z4JkyjnP565lT2i66KssbKqu/XR4G7/dMCzb6llNj+BKCWsmOAONp6JrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179974; c=relaxed/simple;
	bh=i4e3S1WTtwXMpzPXG28zPiDwaxS3iaJh8uPQPeD9o1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp0HH6RUMaPEMEJ/jXcpwt6Ki/oN7PBC6nmtMAEtEmVwdXI0tMoq90XVyUN85Qf5mqXzVcnTH4n99f3zQCiT6IwnHOqlEHRzKeeSCco41/2rBMsyBPEphLR7lqxTID4o3Lxif0R9I3+ClTytLOWDWUgY5YcEqua2aPg6ylzYX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m88D6kgA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m88D6kgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD911C19423;
	Tue, 10 Mar 2026 21:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773179973;
	bh=i4e3S1WTtwXMpzPXG28zPiDwaxS3iaJh8uPQPeD9o1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m88D6kgACNzIqhY0TrTegpF8oWgY2zL6enjNhAh+2j+Y806oN5fIIGX5mBl1YidVR
	 cu6UZUi87yXOOS3L6uquM7y+I4ZElsGJurzc8H8c3SvycRO5rjTrmZaDXSKBFvyaO0
	 bJz2tyIwT3mSq9jFuQ3UbjTeJb5FpCBq8fDST2LGRr9MH/Fz4fVvD1HkMXa+K7niPq
	 Yd6iiK62f1dETqeeuI4O8i3B0LahtCqRZ1GlVABQLn1OoYJyxhmkRmQDef4kfb4XtX
	 xDfxZOKq3agOADwfE6dRHE5r4vPR61FIGCWp0rrD2PzLvcvRi7x1Hca+Dj1gyDrngH
	 5y1zTr7xalHOQ==
Date: Tue, 10 Mar 2026 14:59:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
Message-ID: <20260310215933.GA1742010@frogsfrogsfrogs>
References: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com>
 <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
 <35327273-23ae-4fc7-93b9-03bd4abf631a@wdc.com>
 <CAJnrk1YSW5m6mHuFX6cMxZHBt2qdc8aEx9B623WGoTyL1cjjBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YSW5m6mHuFX6cMxZHBt2qdc8aEx9B623WGoTyL1cjjBg@mail.gmail.com>

On Tue, Mar 10, 2026 at 02:08:28PM -0700, Joanne Koong wrote:
> On Tue, Mar 10, 2026 at 4:44 AM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
> >
> >
> > >
> > > 3. If you're able to repro this consistently, would you be able to add
> > > these lines right above the WARN_ON on line 487 and sharing what it
> > > prints out?
> > >
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -484,6 +484,17 @@ static void iomap_read_end(struct folio *folio,
> > > size_t bytes_submitted)
> > >                   * to the IO helper, in which case we are responsible for
> > >                   * unlocking the folio here.
> > >                   */
> > > +               if (bytes_submitted) {
> > > +                       struct inode *inode = folio->mapping->host;
> > > +                       struct block_device *bdev = inode->i_sb->s_bdev;
> > > +
> > > +                       pr_warn("bytes_submitted=%zu folio_size=%zu
> > > blkbits=%u isize=%lld "
> > > +                               "logical_bs=%u physical_bs=%u\n",
> > > +                               bytes_submitted, folio_size(folio),
> > > inode->i_blkbits,
> > > +                               i_size_read(inode),
> > > +                               bdev ? bdev_logical_block_size(bdev) : 0,
> > > +                               bdev ? bdev_physical_block_size(bdev) : 0);
> > > +               }
> > >                  WARN_ON_ONCE(bytes_submitted);
> > >                  folio_unlock(folio);
> > >          }
> >
> > Here we go:
> >
> > [   17.872952] bytes_submitted=1024 folio_size=4096 blkbits=12
> > isize=5278880768 logical_bs=0 physical_bs=0
> 
> Thank you, this is very helpful.
> 
> Is it correct that the block device's inode->i_blkbits doesn't reflect
> its actual logical block size (512) or is that itself a bug somewhere
> in the block layer?

For a bdev, i_blkbits is only loosely tied to the storage device's block
size.  i_blkbits can't be smaller than log2(lba_size) and it can't be
larger than PAGE_SHIFT (or the max folio order if LBS is present).

Typically it starts out matching PAGE_SIZE, but a program that opens the
block device can call BLKBSZSET to set the block size.  This is usually
done by userspace filesystem tools to improve performance and/or ensure
that the kernel actually supports that block size.

Note that kernel filesystem drivers also call sb_set_blocksize to set
the block size.

The bdev block size seemingly resets to 4k after closing.

> On the iomap side, it uses inode->i_blkbits to
> determine whether or not an ifs should be attached and what logic to
> correspondingly call. For this case, shouldn't the inode's i_blkbits
> be 9 since "isize= 5278880768" indicates it's 512-byte aligned, not
> 4096-byte aligned? I'm not familiar with the block layer, so your
> thoughts on this would be appreciated.

<shrug> Regular files can have a larger i_blkbits than the underlying
storage device, so I don't see why bdevs would be different?

--D

> If it is fine for the block device's inode->i_blkbits to be a
> different value from the logical block size, then I think the iomap
> side needs this fix:
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 867e8ac761c8..03a97361570f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -543,7 +543,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>                          * helper, then the helper owns the folio and will end
>                          * the read on it.
>                          */
> -                       if (*bytes_submitted == folio_len)
> +                       if (*bytes_submitted == folio_len || !ifs)
>                                 ctx->cur_folio = NULL;
>                 }
> 
> Could you verify that this fixes the hang?
> 
> Thanks,
> Joanne
> >
> 
