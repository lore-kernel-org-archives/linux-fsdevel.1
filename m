Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C063C5520;
	Fri, 13 Mar 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419049; cv=none; b=FTKGNFqACWD7EqpVog1kx/lXuPf/DurWAOhx4/iADvhn/MEJgcQ8eIGrM9GbBbU7q3MnVdG6bSJ4xuQ6ymxSaISxFyI7no3aZeNuJ/OoLGae1cg9cKUPTb4zdgAa+AVYfY3tgubvUsh3wHV0L0JABuiMsPLBxq/puNysfHnZ5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419049; c=relaxed/simple;
	bh=lJoNBJQMcrN1Zzv9aLC4vR9jkUZ1MPOuyiBIO3eiDoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kad/iJoNny48KjYCUXokX3lAkCW+NjY12S2Y21Jvjcz2ONHWo/MJpIY2hnNsxOwdqXmf3xt7qGunbopQqnEK5mM9r9sPUUx6WAog3z/NZnRMl8gysBUfPWYcgJMVpBLSc1gRdN/NO0Rk1PI5iqZ6VquTq1efDY5NldcGqdqBP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFOsat0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFOsat0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B7CC19421;
	Fri, 13 Mar 2026 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773419048;
	bh=lJoNBJQMcrN1Zzv9aLC4vR9jkUZ1MPOuyiBIO3eiDoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFOsat0cE9Z7G4xgLB2pA8/ocyScQZne+TTj3tQP4Xz+vLgJsSr3CtneBnxIaNabT
	 1+ieOgUr37JOxzzXEb9nnO6HYw/wSAzwo7TpF7izB/16KbpnIU0q/A+oEksfyjdE9B
	 0rG+qQ+46uLwTG2uwRPLJRZnLAstA8qhOU/2WBggCSwq2KHVrl4H6TIWL8clqLWP2+
	 q5DqV6xTKblMCJXrgs34mFSeW2HtK6RFjwjZrMooP0U9ejoeli1nIR+6X91YF/wsTq
	 FF/7VGV87fgBkIFoK1voGCr40raaC2GG7b8lrLsddBzwmkq8nyo9ruUM2X49XFqYEo
	 FK3Cqkf/hU8jQ==
Date: Fri, 13 Mar 2026 09:24:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Timber <dxdt@dev.snart.me>
Cc: Matthew Wilcox <willy@infradead.org>, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
Message-ID: <20260313162408.GE6023@frogsfrogsfrogs>
References: <20260311222613.2010177-1-dxdt@dev.snart.me>
 <abIxl8XEftpku8yf@casper.infradead.org>
 <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me>
 <abLUQECuMuxHNXjZ@casper.infradead.org>
 <20260312150623.GB1742010@frogsfrogsfrogs>
 <14dc2f67-7916-4990-b1c4-5d442c5d51fc@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14dc2f67-7916-4990-b1c4-5d442c5d51fc@dev.snart.me>

On Fri, Mar 13, 2026 at 04:59:27PM +0900, David Timber wrote:
> On 3/13/26 00:06, Darrick J. Wong wrote:
> > /me wonders if the problem here is that the "unwritten" post-VDL range
> > is worse than a regular unwritten range in the sense that you have to
> > write zeroes to all the space between the VDL and wherever your write()
> > starts, e.g. if the VDL is set to 1G and I pwrite a single byte at 8GB,
> > that turns into a 7-billion-x write amplification.
> Yes. That's the problem being addressed here.

Ah, ok.  Does it do that zeroing at write() time, or only when you're
initiating writeback from the pagecache?  I'm guessing write() time,
since otherwise you're signing the kernel up for initiating a lot of IO
at a time when memory could be scarce.

> Again, imho, VDL is NOT a hole. It should be treated differently. VDL is
> not required to be aligned to the block/extent/cluster size(holes in
> sparse files tend to be albeit not a requirement). You can't punch or
> dig holes in exFAT. Using SEEK_*HOLE* to find *VDL* doesn't make any
> sense(to me, at least).

<remembers to put on his language lawyering glasses>

The lseek manpage states:

   lseek() allows the file offset to be set beyond the end of the file
   (but this does not change the size of the file).  If data is later
   written at this  point,  subsequent  reads of the data in the gap (a
   "hole") return null bytes ('\0') until data is actually written into
   the gap.

IOWs, a "hole" is defined here to be a region of a file which has never
been written to, and therefore reads will return all zeroes.  It doesn't
say anything about the storage that may or may not be backing that
range.

Mild logic leap here: ftruncate() to increase file size also creates a
gap where reads will return null bytes.  From ftruncate:

   If the file previously was larger than this  size,  the  extra  data
   is lost.   If  the file previously was shorter, it is extended, and
   the extended part reads as null bytes ('\0').

In contrast, lot of people call readable file regions not backed by any
space "sparse holes".  Unfortunately the fallocate manpage muddies
things up by saying:

   Deallocating file space
       Specifying  the FALLOC_FL_PUNCH_HOLE flag (available since Linux
       2.6.38) in mode deallocates space (i.e., creates  a  hole)  in
       the byte  range starting  at  offset and continuing for len
       bytes.  Within the specified range, partial filesystem blocks are
       zeroed, and whole filesystem blocks are removed from the file.
       After a successful  call,  subsequent  reads from this range will
       return zeros.

Note that it doesn't say "sparse hole", just "hole".  This ambiguity wrt
fallocate is very unfortunate, because it regularly causes confusion on
fsdevel and other places.  Note that classic Unixy filesystems will, in
creating the "hole" as part of writing at a point past the end of the
file, also create a "sparse hole" by not mapping blocks into the gap.

Also, I sorta lie, because XFS and ext4 are Unixy filesystems, but they
both have modes (large rt extent size and bigalloc) where they actually
can map unwritten blocks into a never-written hole.

exfat doesn't support "sparse holes".  But it does support holes per the
lseek definition, because you can increase the file size via ftruncate,
it'll allocate clusters to back the whole range, and (VDL, i_size] is
the part that exfat knows has never been written and will always return
null bytes in response to a read.

Ok, back to lseek:

  SEEK_HOLE
      Adjust  the file offset to the next hole in the file greater than
      or equal to offset.  If offset points into the middle of a  hole,
      then  the file offset is set to offset.  If there is no hole past
      offset, then the file offset is adjusted to the end of  the  file
      (i.e., there is an implicit hole at the end of any file).

So, SEEK_HOLE jumps to the next file range that has never been written.
It doesn't say anything about backing storage at all.  For exfat, that
would be the start of the VDL.  This is what willy was getting at.

It's too bad that lseek, being a generic interface, has no way to convey
that writes to a lseek hole will be potentially very expensive.  A
program could infer that by the existence of SEEK_HOLE holes and
FALLOC_FL_PUNCH_HOLE returning EOPNOTSUPP.

OTOH I guess they could confirm that by calling the VDL ioctl and
getting a non-error response.  But if we've solved finding the VDL by
making SEEK_HOLE return values below EOF, then why do we need the ioctl?
What if we added a statx flag to advertise sparse hole support on a
file?  And then didn't set it for exfat?

> thb, I don't really care if the ioctl patch is accepted or not. If
> SEEK_HOLE/SEEK_DATA is really what maintainers see fit despite these
> deviations, I'd have to honour that decision and bring iomap to exFAT, I
> guess. That'd be a lot of work though because it mean will the rework of
> the entire exFAT code base. Not saying exFAT doesn't deserve iomap but
> that might be a little over my paygrade since there are thousands of
> embedded devices already using in-kernel exFAT.

/me notes that you can implement iomap only for lseek.

--D

> I retract the patches regarding the ioctl. For the time being, the focus
> should be on making exFAT and NTFS useable and stable before introducing
> ioctls. Sorry for my poor judgement.
> 
> Davo
> 
> 
