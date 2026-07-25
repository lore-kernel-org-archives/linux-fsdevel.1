Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB55286D5E;
	Sat, 25 Jul 2026 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784953569; cv=none; b=Fu9DuHuPLVvgFzQ66okwXuLZ/YFasMsGSjpA8D7XsY//PBo7cFB7Is14wzMR/p+X0Hmhw/hagZl2lECkhU06uMDmoastRM9DzDqkenhWG2L1pgVc5w3qkZ6ARACFOV5woaOvY11NlkqrvwXweLaiEXcOPceYP8KPZJyrNW1kuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784953569; c=relaxed/simple;
	bh=NdboRLjSmvK4WcXwYFzFarL+ZANEJ3oobXd/wnOBNSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD1AoHCBnHPUbvZCs+Jrrj5D+elVzpA01RVPvRTUFa9PatAe7ZYVXtIrHdNwlk6QjL3z9OEl43E54kk8pZVDhzB3+EY4Zw8tLTW82f71p0Wa8dkVaNzEkZyYQ4t6DxfRSMzaiwFLFkzqH5hbjS8AQ72dx5Bkbcpdf7T3Af59F/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeFE3RCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeFE3RCU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DE4071F000E9;
	Sat, 25 Jul 2026 04:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784953568;
	bh=TwbbX45A3LL7KUF0UTHWbBvZAFugn2SD99AzgLXoJyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CeFE3RCUkTNxkkW7gED2+mbvRmuO4XPySDJ15AyfaOKkj6Y6Cvsi9txr5TW65lzVM
	 AK5bMUfmuUAgg4i4NSC1T5zgdyYGDGC/OFi2T1Ht1SUZKH8XZ3qiG21oEebqzFWKrT
	 K1dGxd9phi4w6QjALfVvi/h/WBno56lT5fOq+afQ0S8dMh48SkWnJjoX1Aj4CpmV9m
	 2YKc8crvay75xTpW3tJyTqTndzPJA/WEmrCWutj+92z51bOXy8K8FE4z+bRLq5AgPe
	 E8MKXBqMpUY6oKiSs7Gg+E3pYE7ucJ7xmGIDeD9kXABgO6MNSA/UbtlaV+AJrIGTRq
	 VFMFBqtFaZxgw==
Date: Fri, 24 Jul 2026 21:26:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: preserve allocated extents for swap activation
Message-ID: <20260725042607.GD7398@frogsfrogsfrogs>
References: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
 <CAKYAXd--N_2nY5XPr3vNyb7Ai+xYbuR3EE4ivecVf6Eur-vC_w@mail.gmail.com>
 <20260724155307.GA7398@frogsfrogsfrogs>
 <CAKYAXd8Mat6dcNAnRbaNcy-9KP-OKJhbkP-W5gEQQ6JmWJPCpA@mail.gmail.com>
 <CAKYAXd94zxWLSMZst=jQZwSn3n=s=GSdY4F2wA79U5sx69Th4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd94zxWLSMZst=jQZwSn3n=s=GSdY4F2wA79U5sx69Th4w@mail.gmail.com>

On Sat, Jul 25, 2026 at 10:51:21AM +0900, Namjae Jeon wrote:
> On Sat, Jul 25, 2026 at 10:18 AM Namjae Jeon <linkinjeon@kernel.org> wrote:
> >
> > On Sat, Jul 25, 2026 at 12:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Fri, Jul 24, 2026 at 09:57:49AM +0900, Namjae Jeon wrote:
> > > > On Fri, Jul 24, 2026 at 4:19 AM Harshit Mogalapalli
> > > > <harshit.m.mogalapalli@oracle.com> wrote:
> > > > >
> > > > > exFAT reports allocated ranges beyond valid_size as IOMAP_HOLE whenever
> > > > > IOMAP_REPORT is set. iomap_swapfile_activate() also uses IOMAP_REPORT
> > > > > while collecting a swapfile's physical extents, so it treats the
> > > > > preallocated tail as unallocated and rejects the file with -EINVAL.
> > > > >
> > > > > Allocated space beyond valid_size is not a hole. Keep it as
> > > > > IOMAP_UNWRITTEN so iomap consumers that need physical extent identity,
> > > > > such as swap activation, can still use it. The iomap seek helpers
> > > > > already handle unwritten extents appropriately for SEEK_HOLE and
> > > > > SEEK_DATA.
> > > > >
> > > > > Fixes: b4b7fe2c7cbf ("exfat: add support for SEEK_HOLE and SEEK_DATA in llseek")
> > > > > Assisted-by: Codex:GPT-5.6
> > > > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > > > ---
> > > > > LTP swapon/swapoff tests failed on exFAT, with this patch the tests
> > > > > pass.
> > > > > ---
> > > > >  fs/exfat/iomap.c | 16 ++++++----------
> > > > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> > > > > index 190fc6471f84..24d93288a432 100644
> > > > > --- a/fs/exfat/iomap.c
> > > > > +++ b/fs/exfat/iomap.c
> > > > > @@ -105,18 +105,14 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
> > > > >                  * marks the exact boundary between valid data and
> > > > >                  * holes (or unwritten space).
> > > > >                  *
> > > > > -                * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
> > > > > -                * and SEEK_DATA), we return IOMAP_HOLE. This allows
> > > > > -                * iomap_seek_hole_iter() to directly return the
> > > > > -                * precise byte position.
> > > > > -                *
> > > > > -                * For normal I/O paths (without IOMAP_REPORT) we
> > > > > -                * return IOMAP_UNWRITTEN so the write path can
> > > > > -                * distinguish it from a real hole.
> > > > > +                * Allocated space beyond valid_size is not a hole. Report it
> > > > > +                * as IOMAP_UNWRITTEN so iomap consumers that need physical
> > > > > +                * extent identity, such as swap activation, can still use it.
> > > > > +                * The iomap seek helpers already handle unwritten extents
> > > > > +                * appropriately for SEEK_HOLE and SEEK_DATA.
> > > > >                  */
> > > > >                 if (offset >= ei->valid_size) {
> > > > > -                       iomap->type = flags & IOMAP_REPORT ?
> > > > > -                               IOMAP_HOLE : IOMAP_UNWRITTEN;
> > > > > +                       iomap->type = IOMAP_UNWRITTEN;
> > > > Returning IOMAP_UNWRITTEN with IOMAP_REPORT can make SEEK_HOLE rely on
> > > > page-cache/block-granularity handling, which can lose the
> > > > byte-accurate valid_size boundary. Before activating the swapfile,
> > > > extending ->valid_size to i_size through exfat_extend_valid_size()
> > > > safely zeroes the preallocated range and makes it valid for swap use.
> > >
> > > iomap swapfile activation can handle unwritten extents (unlike the bmap
> > > activation codepath) so you probably only need to bump valid_size up to
> > > the next max(PAGE_SIZE, i_blocksize) boundary.  The swap code writes
> > > to the underlying disk blocks directly, bypassing the filesystem.
> > That makes sense. We can call exfat_extend_valid_size() to extend
> > ->valid_size only to the next page/block boundary in
> > exfat_iomap_swap_activate().
> Thinking about this more, returning IOMAP_UNWRITTEN for the
> preallocated tail under IOMAP_REPORT would affect normal
> SEEK_HOLE/SEEK_DATA as well, where we need to preserve the
> byte-accurate valid_size boundary. Would extending valid_size through
> the full swap-usable range, i.e.  ALIGN_DOWN(i_size, PAGE_SIZE),
> before activation be the better approach? That would let us retain the
> existing IOMAP_REPORT hole handling for normal seeks.

Manually zeroing by pushing valid_size out would also work, but that's a
lot of zeroes to write to the storage, flash wearout, blah blah blah.
In the ideal world the whole swapfile would be all unwritten blocks
(except the swapfile header) so that nobody could reread the swapfile
contents after swapoff.

--D
