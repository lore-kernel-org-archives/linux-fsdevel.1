Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF61223DFF;
	Sat,  6 Jun 2026 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780720274; cv=none; b=awyIMeCA89el2tVJf+bM/EHDEzIbptudeCatj6JHkFGO/twgqU3KqDQinVAySEiRMOzBP3F/cp/vyNsaUMZ2WmXt6eT2BMm/Ifncxqp10hhtPQEu3UccyiUiJ2/3BUZ2kTEJ78NSU19J2+Nf7B6oCDyhk51Xhg3HlO0XEEIP8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780720274; c=relaxed/simple;
	bh=KqLoNcL/KcPcF9Hi2luBorm0xFyC/O00ISteSGkE154=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AObFBL+8QHSFL8emB9rIMQ4xG3Knem0M2BzRL4Ma1d2eA2ttee0/bHihv2ANgh3n81IzvHsVqGfdA283ufNc0jFaVeralX5h6xrYkZv+KFTruJlsWpUisq+IM351u/Jsv3bkeuvBMTnoDUKU0t0XCxUg6it8b69zV6ykABc9RNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvx/K6j7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvx/K6j7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A952E1F00893;
	Sat,  6 Jun 2026 04:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780720272;
	bh=1W9IV2ZLDqB+Xsc4gZrXRsp7mZULuCmGGcJEJACtO0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uvx/K6j7LgmHVnEzvj4OekXJwUYgy5MSjGM2c20RDDS85Js8XVoeL82T00AN7uF93
	 AbY8YQIrBUPqlHzCKIC9y+SUO4aUojf2kKh3XLqDw16ubrNfy+Ym9wsBYtAtNLX09x
	 Em62IZOpiplsevuuOKjaQ3T1Oj0N201+KwiUiS0KyLWPniWqlUZ9cR7Thar85W1yh5
	 G/z+qHIUSWtX+rLTDFWX7MSVyxTXsDw58AE/+gdBahd62V+1iN/ND6A7vfjl9QweVd
	 lOEHfFIB8Tf1DT4YG8W5GIQwlqnhF/7qyOMXBy22IX6+x9Ex5I4P1WCVexSNDdJzcE
	 b5C2emd9Qvdlg==
Date: Fri, 5 Jun 2026 21:31:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 7/9] fuse: invalidate ranges of backing devices being
 used for iomap
Message-ID: <20260606043111.GI6095@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
 <177922946329.2439242.17189876954349215664.stgit@frogsfrogsfrogs>
 <CAJnrk1bvmZ0htacx8sqZ+aBVVS_x+7kap77SEctwwB_F6ttsSw@mail.gmail.com>
 <20260604235304.GI6070@frogsfrogsfrogs>
 <CAJnrk1Yvcet5rqUHLPxgf=YxMG9Lw_-eKkMdXak2-5jchnUq-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yvcet5rqUHLPxgf=YxMG9Lw_-eKkMdXak2-5jchnUq-g@mail.gmail.com>

On Fri, Jun 05, 2026 at 09:56:09AM -0700, Joanne Koong wrote:
> On Thu, Jun 4, 2026 at 4:53 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, May 22, 2026 at 06:29:16PM -0700, Joanne Koong wrote:
> > > On Tue, May 19, 2026 at 3:32 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > Make it easier to invalidate the page cache for a block device that is
> > > > being used in conjunction with iomap.  This allows a fuse server to kill
> > > > all cached data for a block that is being freed, so that block reuse
> > > > doesn't result in file corruption.  Right now, the only way to do this
> > > > is with fadvise, which ignores and doesn't wait for pages undergoing
> > > > writeback.
> 
> Rereading this patch... (or maybe just reading it correctly for the
> first time now :P)
> 
> If I'm understanding it correctly, the problem it's trying to solve is
> that the block device has its own page cache (separate from the fuse
> inode page cache)

Right.

>                   and when the fuseblk server or fuse iomap server is
> unmounted and done interacting with the block device, there's still
> data in the block device's cache that lingers - is this correct?

Not quite -- the fuse server could allocate a block to a file (well
before unmount) that was previously a metadata block, and now it wants
to dump the pagecache and ensure the kernel isn't doing any writeback
that could race with a subsequent iomap write.

(fuse4fs does it the other way -- every time it frees a block, it wants
to flush the pagecache to quiesce any IO, just in case it later wants to
reallocate it.  Technically you only have to do that with metadata
blocks, but libext2fs isn't smart enough to know the difference.)

> Is userspace not able to handle this themselves by flushing +
> invalidating the block device's cache with the BLKFLSBUF ioctl call?

We don't want to flush the entire bdev page cache, just the block that
we're freeing or allocating.

> > >
> > > imo this would be cleaner going through the ioctl backing interface
> > > instead of through notifications.
> > >
> > > I was thinking of something similar in idea for this for passthrough
> > > where you're able to dynamically update or invalidate a mapping
> > > corresponding to a backing id. It'd be great if we could both use the
> > > same uapi.
> >
> > What do you mean by update a mapping?
> 
> I don't think my previous comment applies to your patch - I had
> misinterpreted "invalidate ranges of backing devices" as meaning
> invalidating the range of a file that is mapped to a backing
> file/device.

Ah, ok.  Glad I could clear up some confusion then. :)

--D

> Thanks,
> Joanne
> 
> >
> > FWIW the functionality here is a lot like POSIX_FADV_DONTNEED, except
> > that we actually want to wait for writeback and tear down all the folios
> > in the range because it's mandatory, not advisory.
> >
> > (TBH it's more like what filesystems do to the pagecache prior to a
> > fallocate punch-hole operation).
