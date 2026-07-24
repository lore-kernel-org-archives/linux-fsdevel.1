Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21EC3382C7;
	Fri, 24 Jul 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908390; cv=none; b=M3uNO9Z97VHnJtWd20OwH1EJGIkwvE4LH7lgQ1J2n7MzN3uSiJt2ELEBCQpgrkBNn5xJXxCFNCaOLD0bMxJJ2Er+3Y7wPcDdOSOt4YOCpr1dqZZlv/4WlPwQDDuGeBo6iwrQtPHvQDWvwjH7SdypdclrmwdjHMOQpS8mvQi9Rdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908390; c=relaxed/simple;
	bh=zCk3xc0UlgJlc06LMJzmE66E79omDiXT+OT0lkBAP7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrDAGKOi1W0HOhT5dlHBErbv26CGndKMg8ZOaUaX0k3nrx1HYzgn6nWQV5DJqQWfH09jMO4Qr0U2xWJwi9P0Y4b8Z5s5SBGoe9KeemqGjRiFLHrytGuKPLlyIYHhavkgIlvuGxTjKT6H6shdiiBOR4NGpY6FHo61kYcklvp1Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ/5hR2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ/5hR2H"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 333691F000E9;
	Fri, 24 Jul 2026 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784908388;
	bh=uOZiq8OWT/avS5oLoopGtVyIBHY0bCTmfT5dBxhzSis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LQ/5hR2HfB2zeVRuEY+hdzoo2HXc6VyrPB4pUzORmyST8aE6gSGUS7BXVLF1Vcowk
	 8Ive9AiNt2a7lVTdNYc2ECH59OcyqMcFA6fo/9rci+BfMSKttDjcjrY9U9FpoUBOxp
	 xbgD40aDmebQL5OFoo8u0W2GIPknZfUI8anIKY77HVylOTAB1WaVCggf9pzT5rdtgA
	 uO8zofK9qJRb64zK5XLeuiVEw81p7ovqnpkcx3loHGKOMlalR26OYTDNTN7fjGtSZt
	 /5/o3zfzZhE07vGj1oCYk7RmbOmoQDnfk8hkIVW3y9rZ1aMttsjQJUcfSZMpL8Sn6D
	 U1CV67pyEQTpQ==
Date: Fri, 24 Jul 2026 08:53:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: preserve allocated extents for swap activation
Message-ID: <20260724155307.GA7398@frogsfrogsfrogs>
References: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
 <CAKYAXd--N_2nY5XPr3vNyb7Ai+xYbuR3EE4ivecVf6Eur-vC_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd--N_2nY5XPr3vNyb7Ai+xYbuR3EE4ivecVf6Eur-vC_w@mail.gmail.com>

On Fri, Jul 24, 2026 at 09:57:49AM +0900, Namjae Jeon wrote:
> On Fri, Jul 24, 2026 at 4:19 AM Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
> >
> > exFAT reports allocated ranges beyond valid_size as IOMAP_HOLE whenever
> > IOMAP_REPORT is set. iomap_swapfile_activate() also uses IOMAP_REPORT
> > while collecting a swapfile's physical extents, so it treats the
> > preallocated tail as unallocated and rejects the file with -EINVAL.
> >
> > Allocated space beyond valid_size is not a hole. Keep it as
> > IOMAP_UNWRITTEN so iomap consumers that need physical extent identity,
> > such as swap activation, can still use it. The iomap seek helpers
> > already handle unwritten extents appropriately for SEEK_HOLE and
> > SEEK_DATA.
> >
> > Fixes: b4b7fe2c7cbf ("exfat: add support for SEEK_HOLE and SEEK_DATA in llseek")
> > Assisted-by: Codex:GPT-5.6
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > LTP swapon/swapoff tests failed on exFAT, with this patch the tests
> > pass.
> > ---
> >  fs/exfat/iomap.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> > index 190fc6471f84..24d93288a432 100644
> > --- a/fs/exfat/iomap.c
> > +++ b/fs/exfat/iomap.c
> > @@ -105,18 +105,14 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
> >                  * marks the exact boundary between valid data and
> >                  * holes (or unwritten space).
> >                  *
> > -                * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
> > -                * and SEEK_DATA), we return IOMAP_HOLE. This allows
> > -                * iomap_seek_hole_iter() to directly return the
> > -                * precise byte position.
> > -                *
> > -                * For normal I/O paths (without IOMAP_REPORT) we
> > -                * return IOMAP_UNWRITTEN so the write path can
> > -                * distinguish it from a real hole.
> > +                * Allocated space beyond valid_size is not a hole. Report it
> > +                * as IOMAP_UNWRITTEN so iomap consumers that need physical
> > +                * extent identity, such as swap activation, can still use it.
> > +                * The iomap seek helpers already handle unwritten extents
> > +                * appropriately for SEEK_HOLE and SEEK_DATA.
> >                  */
> >                 if (offset >= ei->valid_size) {
> > -                       iomap->type = flags & IOMAP_REPORT ?
> > -                               IOMAP_HOLE : IOMAP_UNWRITTEN;
> > +                       iomap->type = IOMAP_UNWRITTEN;
> Returning IOMAP_UNWRITTEN with IOMAP_REPORT can make SEEK_HOLE rely on
> page-cache/block-granularity handling, which can lose the
> byte-accurate valid_size boundary. Before activating the swapfile,
> extending ->valid_size to i_size through exfat_extend_valid_size()
> safely zeroes the preallocated range and makes it valid for swap use.

iomap swapfile activation can handle unwritten extents (unlike the bmap
activation codepath) so you probably only need to bump valid_size up to
the next max(PAGE_SIZE, i_blocksize) boundary.  The swap code writes
to the underlying disk blocks directly, bypassing the filesystem.

--D
