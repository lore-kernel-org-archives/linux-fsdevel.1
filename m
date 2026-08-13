Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4D31ED83;
	Thu, 13 Aug 2026 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651756; cv=none; b=p/liAFUBDvVIdFZOPcHu88YLOc8ABbc6elHxD12tiigdr/jWcFtZU37enGfskgtRHpXT0YHZ7hBQoxJYquFw5SoCq4uEvQ54opIB/UBiAqHAJQNDcIBtXMywZbpimiDQd+Fl1TcKt6e7cQXpItqPgeLOPI5PMa9L229yqpR8rTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651756; c=relaxed/simple;
	bh=RfKzSi4yhE3RujD+5R8WEPDFZVI3w2Le+BVb2PgAZTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV/fDuhNtmaDFOJlHUjCq+5KeAN/6oxNtSWI93Yp7fkcv+Snr9YS/wWxU0DAm1Y/imKvKBL6pOORP5Jn7+Q24hw488koCpaKAXQtsR4bifQY7ExPYvUwrB1BbUb0EEyWQC2iGK1bKnDhNbdaVjyvACrO5GziWcPYXSvHWrSAc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkhpR6Wu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkhpR6Wu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 38D9E1F000E9;
	Thu, 13 Aug 2026 20:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786651755;
	bh=HhaLsv22raD8jApFo4b8JM+GDP2JdkEdADTQvqg0tWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VkhpR6WuZSvjjnOQIS06CZEjUWs5mlWuE2DtPNljSTRR4Y1D/TQPMoUDIb+D8oqjI
	 z1mcClipasj6XLSCUN32Us3hgg8BhhaY3Uto5/zediPtqFhzTy3IT/DJrIFKnlEaxN
	 0cfTh/jurq3OZMwrZ0Pq9uWOczI5ovBhcw7zMGY+tvc+UPENugBt4zAa2dT2OagpdR
	 HHnwhPsOLW0A50hG7mwB4PxyuMqspelzcuv2MuK2H4gCOT7Kz32Ag+JGyV/sRIA14D
	 b48Y3eO4c1JJuh9XCAGokRJleyWclJKcwPcd0zCnzrW63yri/wiycvsvUDtfukmRxG
	 C+q+M34R97MPQ==
Date: Thu, 13 Aug 2026 13:09:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthias Goergens <matthias.goergens@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ansgar =?iso-8859-1?B?TPbfZXI=?= <ansgar.loesser@kom.tu-darmstadt.de>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/2] vfs: report truthful FIDEDUPERANGE progress safely
Message-ID: <20260813200914.GA7398@frogsfrogsfrogs>
References: <20260805071414.3414870-1-matthias.goergens@gmail.com>
 <20260812-gastgewerbe-dementieren-landzunge-db991673a96a@brauner>
 <CAOQ4uxiiE0kks+4F92qJu2QnkL+rkHFvEz2ujZDgVYjGw0AVYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiiE0kks+4F92qJu2QnkL+rkHFvEz2ujZDgVYjGw0AVYA@mail.gmail.com>

On Thu, Aug 13, 2026 at 05:33:36PM +0200, Amir Goldstein wrote:
> On Wed, Aug 12, 2026 at 9:46 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On 2026-08-05 15:14 +0800, Matthias Goergens wrote:
> > > FIDEDUPERANGE currently reports the requested length even when the
> > > filesystem shortens a destination range and deduplicates fewer bytes. A
> > > previous one-line correction was reverted after generic/517 exposed the old
> > > expectation and reviewers raised the risk that existing consumers could loop
> > > on a successful zero-progress result.
> > >
> > > Patch 1 makes a non-zero request shortened to zero fail per destination with
> > > -EINVAL, while preserving explicit zero-length success. Patch 2 then reports
> > > the filesystem's actual positive progress. This ordering keeps every
> > > intermediate kernel safe for callers that advance by bytes_deduped.
> > >
> > > The paired fstests update corrects generic/517 and adds raw ioctl coverage for
> > > zero-length and mixed multi-destination results. Both tests pass on Btrfs and
> > > XFS. Installed duperemove exits successfully on the measured corpus. Installed
> > > rmlint does not hang or silently over-report; it exits 1 after the final
> > > unaligned tail receives -EINVAL, which is recorded explicitly for review.
> > >
> > > A current-source consumer audit supports that ABI choice: duperemove completes
> > > the request on a non-zero status; rmlint, bees and jdupes surface -EINVAL as
> > > failure without retrying; dduper and xfs_io stop but can still report command
> > > success. None retries, hangs or risks data corruption. Thus -EINVAL is the
> > > only truthful result that also avoids exposing successful zero progress to
> > > deployed duperemove binaries.
> > >
> > > Matthias Goergens (2):
> > >   vfs: fail dedupe requests that cannot make progress
> > >   vfs: report the amount of bytes actually deduplicated
> >
> > Needs input from Amir.
> >
> 
> The logic seems sound to me.
> Main well tested and accounted for,
> the suggested fixed already aligned with the man page documentation
> even:
> EINVAL The  filesystem does not support deduplicating the ranges of
> the given files.
> could be interpreted to apply to this unaligned dedupe case

The problem is that the weird bytes_deduped = len behavior has been
around for years, even before any of it got hoisted to the VFS:
https://elixir.bootlin.com/linux/v4.0.9/source/fs/btrfs/ioctl.c#L3025

IOWs, the manpage is wrong.

I suppose you could just merge this fix and the changes for
xfsprogs/fstests and take your chances that nobody complains, but afaict
duperemove isn't going to be happy:

$ git grep bytes_deduped
btrfs-extent-same.c:40: uint64_t bytes_deduped;         /* out - total # of bytes we
btrfs-extent-same.c:138:                printf("i: %d, status: %d, bytes_deduped: %llu\n", i,
btrfs-extent-same.c:139:                       info->status, (unsigned long long)info->bytes_deduped);
btrfs-extent-same.c:141:                bytes += info->bytes_deduped;
dedupe.c:110:                   "%llu, bytes_deduped: %llu, status: %d\n",
dedupe.c:113:                   (unsigned long long)info->bytes_deduped, info->status);
dedupe.c:233:   info->bytes_deduped = 0;
dedupe.c:279:           if (info->bytes_deduped > max_deduped)
dedupe.c:280:                   max_deduped = info->bytes_deduped;
dedupe.c:282:           req->req_loff += info->bytes_deduped;
dedupe.c:283:           req->req_total += info->bytes_deduped;
dedupe.c:348:                     uint64_t *off, uint64_t *bytes_deduped,
dedupe.c:364:   *bytes_deduped = req->req_total;
dedupe.h:77:                      uint64_t *off, uint64_t *bytes_deduped,
ioctl.h:16:     __u64 bytes_deduped;    /* out - total # of bytes we were able

Notice how it increments a file offset based on bytes_deduped?

A safer option would be to define a flags field and add a flag to enable
the behavior that is documented and obviously makes more sense.

I don't know when you'd get bytes_deduped==0 since you'd think that
would result in info->status being set to FILE_DEDUPE_RANGE_DIFFERS?

--D

> Feel free to add
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> to both patches,
> 
> Thanks,
> Amir.
