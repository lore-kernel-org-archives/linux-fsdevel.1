Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DFB3C873C;
	Thu, 12 Mar 2026 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327984; cv=none; b=bnD68mdi/09MBvY/6EkBLnFFrhfRJDw8BvyCA9Jhh+oAYz25P4AwVN25ztwOFDXSJQH1C+u3qZdgpgOVO5hnBaYNOsSVSQlRZt9+diCjPMURWD1G5ys0FPlzwyKJUPmpIGMXhhA6X5idUJsELvvxAKd91ZfCIWCQ0yowZQZt694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327984; c=relaxed/simple;
	bh=dz7TRAk7opGVxI1KALhdSRmGMIJN17TJjZrzPAIAIrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpCv1KSqU8yyyy/CBFjlyugNCuvfrcJ68W8iDT6tSet1mJL30iM5aygeUO+330rTHyJbu93Be2hBtEglVduMIMeI8GF8e+gIzUOB08ZMMUsYsHhGy4QtW2vzeHnzEpiPAet9Z1fURRFfyl0RYi+HLoj4NBjRaab+N1VPZlkWBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT+NOxVy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT+NOxVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2DFC4CEF7;
	Thu, 12 Mar 2026 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327983;
	bh=dz7TRAk7opGVxI1KALhdSRmGMIJN17TJjZrzPAIAIrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JT+NOxVy/lq4c5N1iu7Lgzc/7EkFG18uqPPAXGN1eWV2+CJwwK7k7irygtPlbX8yX
	 BaVZlXwuoyo6QYNGqm8j6lYZrR8zBbnd3WW+tQ8iqCH2m8khEKtPyW63Lt+Cy+ECJM
	 b3Ac20oVxMw3Uk6cIhnbIwKAXm/r3/mdryos4/5+54PaBE8h/Nt3bwZcc1uOtJ9avk
	 k7lCi46ZJT+v3MvhU5hjKNvR2P08TwS/2FKKrfMemS3rOyDl3tS3Wej4HkvMnYU78f
	 K3fFD6bvNo/RU/ZDss/h04ATBEMUHucp4SzXfFV12tg+3Jt297RUlUeAAQzezrA59i
	 v0juCUR1YU5PA==
Date: Thu, 12 Mar 2026 08:06:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Timber <dxdt@dev.snart.me>, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
Message-ID: <20260312150623.GB1742010@frogsfrogsfrogs>
References: <20260311222613.2010177-1-dxdt@dev.snart.me>
 <abIxl8XEftpku8yf@casper.infradead.org>
 <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me>
 <abLUQECuMuxHNXjZ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLUQECuMuxHNXjZ@casper.infradead.org>

On Thu, Mar 12, 2026 at 02:57:04PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 12, 2026 at 11:02:29PM +0900, David Timber wrote:
> > On 3/12/26 12:23, Matthew Wilcox wrote:
> > > We already have two interfaces for this on Linux.  One is SEEK_HOLE /
> > > SEEK_DATA and the other is fiemap (Documentation/filesystems/fiemap.rst)
> > > Why are both of these interfaces unsuitable?
> > https://lore.kernel.org/linux-fsdevel/cf6c2b08-b7ff-4f70-95f4-cdb12ef5a666@dev.snart.me/
> > 
> > Because exFAT is not a sparse file system. The VDL is only a shorthand
> > for fast cluster allocation without writing actual data to them. In
> > other words, the range between the VDL and isize is not actually a hole.
> > The blocks in the range are actually allocated, filled with garbage data
> > on the disk. The kernel has to be careful not to return it to userspace,
> > which is something Linux kernel actually does.
> 
> Uh, no it's not.  If you try to read from the file at positions mapped
> to those blocks, Linux will return zeroes.
> 
> You seem to be under the impression that SEEK_HOLE only finds blocks
> which have not been allocated.  That's not the behaviour of any
> filesystem whch uses iomap.  Look:
> 
> static int iomap_seek_hole_iter(struct iomap_iter *iter,
>                 loff_t *hole_pos)
> {
>         loff_t length = iomap_length(iter);
> 
>         switch (iter->iomap.type) {
>         case IOMAP_UNWRITTEN:
>                 *hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
>                                 iter->pos, iter->pos + length, SEEK_HOLE);
>                 if (*hole_pos == iter->pos + length)
>                         return iomap_iter_advance(iter, length);
>                 return 0;
>         case IOMAP_HOLE:
>                 *hole_pos = iter->pos;
>                 return 0;
> 
> Yes, if there's literally a hole, that counts as a hole, but what you're
> talking about is an unwritten extent.  And that counts as a hole
> *unless* we've written to the page cache covering the hole.

/me wonders if the problem here is that the "unwritten" post-VDL range
is worse than a regular unwritten range in the sense that you have to
write zeroes to all the space between the VDL and wherever your write()
starts, e.g. if the VDL is set to 1G and I pwrite a single byte at 8GB,
that turns into a 7-billion-x write amplification.

OTOH its exfat so nobody's expecting it to be fast, so we could just
treat the post-vdl area as unwritten, as far as SEEK_HOLE is concerned.

Also FIEMAP is evil because (a) the filesystem can change/optimize
mappings in the background so the results can be obsolete by the time
the syscall returns and (b) it doesn't tell you about dirty pagecache
fronting unwritten areas.

--D
