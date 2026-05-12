Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441E3A872A;
	Tue, 12 May 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618253; cv=none; b=b3/sZHKc8BTIkZPcwTsWXgk/QAUmn0llpNL1MW/TGLpGn0BCbDYVsXUskbb8IKZfOm4B59Zot3HOs8I4EiAW+atWOKxNlUOaJftAkN6JZjqlhmaN3aZZ9I/bLobUew3vxLnwYJrl7EQM7vMdcR7C9x/6cjDQpd64ZDIDmAoWt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618253; c=relaxed/simple;
	bh=T619MJxi1U3iEhZpcB0U7seu6WkqkC+ovVkP0Ms77w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT7h3lXFNC/4ljkzUAxNhwudNDRTgptFpN8n9+p74vvmkcbL+u2DoUG6Ro5dePhLVKWzHGayYmO1RwNIJSI03RYUV0nJQbDeDomWSpTiCltxWGzGBVOkASOxHBkd5cAjGpaadnQJueGBzlhieF2mUGk92gHT0fMBRPdULEGLN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfhIzY51; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfhIzY51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219DBC2BCB0;
	Tue, 12 May 2026 20:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778618253;
	bh=T619MJxi1U3iEhZpcB0U7seu6WkqkC+ovVkP0Ms77w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfhIzY51biXSO08enVtNZXMU4g/Nc+joxU7z3KRPIgaVtmUS3ri7IzATHNRbCS5dJ
	 /3nsPArErYkFCmGlhGj2E0AsTC/tT1jpIbs00qSCJrZgg2zG4M7bGWGUTyFohu1/Dw
	 iLmQGUJR7WyHUS99hXamyZpQWzrato23Arb2hxEcknXJUDtDuKICY9jctfMeKjVBVO
	 9daenbaDE+yk0w2IZmMSzL13IlDxLzHZ30KWb6xgRDW3Gj9rpT/1YaDT95+4sycwQ7
	 qDvkbZoAh6yUQU4CvGoqMWKaK4vr219wkoK4EpFSSH1kBZuIKWMngiPN3u8dC92ZXp
	 UvDi44cJKYERg==
Date: Tue, 12 May 2026 13:37:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: add fusex filesystem
Message-ID: <20260512203732.GE9544@frogsfrogsfrogs>
References: <20260429102058.1362965-1-mszeredi@redhat.com>
 <CAJnrk1Z_JWtuA3UjucF9=YH63AH_-J_0hzr9jbY99Hx3O8YrAw@mail.gmail.com>
 <CAJfpegspraqMp1Z3mi_csiw6haawZPa4zWheSUN7MhBy47aYKQ@mail.gmail.com>
 <CAJnrk1Z+Y2SJ7o-Ms8s9OfEutsYefbQTjRYXBfy3BhWw1hWqAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z+Y2SJ7o-Ms8s9OfEutsYefbQTjRYXBfy3BhWw1hWqAA@mail.gmail.com>

On Tue, May 12, 2026 at 10:33:20AM -0700, Joanne Koong wrote:
> On Tue, May 12, 2026 at 2:18 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 12 May 2026 at 07:05, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > > If it's mostly to clean up interfaces that are now clunky/stale, I
> > > wonder if now is the best time given that, as Amir phrased it in [1],
> > > "FUSE is experiencing a renaissance of new features and protocol
> > > enhancements", and I'm not sure if we know yet if these new interfaces
> > > will also have some things we'll have wished in hindsight we had done
> > > differently, especially since some of these new features are still
> > > actively evolving and gaining new capabilities (including io-uring and
> > > passthrough). Would it make sense to let these new features and
> > > protocol enhancements evolve and stabilize first before baking them
> > > into fusex?
> >
> > Excellent point.
> >
> > Currently fusex concerns only the filesystem layer, and is agnostic to
> > the transport layer (except maybe the SYNC_INIT thing).  That doesn't
> 
> As soon as fusex lands, doesn't this mean with the linux backwards
> compatibility policy that any user-facing transport layer decisions
> are also locked in? Or is the uapi for it still able to change later
> because fusex is marked as "experimental"?

Create a permissions checking predicate, ala:

bool fuse_iomap_enabled(void)
{
	/* Don't let anyone touch iomap until the end of the patchset. */
	return false;

	/*
	 * There are fears that a fuse+iomap server could somehow DoS the
	 * system by doing things like going out to lunch during a writeback
	 * related iomap request.  Only allow iomap access if the fuse server
	 * has rawio capabilities since those processes can mess things up
	 * quite well even without our help.
	 */
	return enable_iomap && has_capability_noaudit(current, CAP_SYS_RAWIO);
}

and a default N Kconfig option, and then the only people who can
actually use the uabi are fuse developers who are willing to patch and
run their own kernels.

--D

> > mean that we shouldn't have the same API cleanup in the transport
> > layer as well.  For example, I'd love to get rid of splice on
> > /dev/fuse, which I feel is more burden than blessing.  And I guess
> > fuse-uring could also do with an API cleanup.
> >
> > As to when and how this should be done?  I guess that's up to you and
> > Bernd to decide.
> >
> > But I feel that we do need to have more high level discussion of APIs,
> > if we want to avoid repeating past mistakes.
> >
> > >
> > > >  - only no-open mode
> > > >  - new requests:
> > > >    + FUSE_LOOKUP_ROOT - return nodeid of root
> > > >    + FUSE_LOOKUPX - FUSE_LOOKUP without the getattr
> > >
> > > Could you explain why it's preferred to have lookup disentangled from
> > > attributes, eg why compounding lookup + attribute fetching is
> > > preferred over embedding the statx directly inside the lookup request
> > > without compounding? it was brought up in Luis's lookup handles
> > > patchset [2] but it's still a bit unclear to me why compounding the
> > > two is better. I think every operation/request that returns a struct
> > > fuse_entry_out uses the attributes immediately after through
> > > fuse_iget(..., &outarg->attr, ...) or fuse_change_attributes(...,
> > > &outarg.attr, ...),
> >
> > That's one argument for decoupling: why include the same fields
> > (attributes, validity) in several ops (LOOKUP_ROOT, LOOKUPX, MKOBJX)
> > if we already have a separate one to do that?  It simplifies the
> > protocol.  If we started with decoupled GETATTR, then we wouldn't be
> > taking about adding these X versions, because it would be a simple
> > GETATTR -> STATX conversion.
> >
> > There's also an interesting side effect of coupling STATX with LOOKUP,
> > which is inherently racy:
> >
> > Thread A:
> > send LOOKUP + STATX for /fuse/dir1/filea
> > [server performs lookup and statx, sends reply]
> >
> > Thread B:
> > send SETATTR for /fuse/dir2/fileb, which is hard linked to /fuse/dir1/filea
> > evict inode for /fuse/dir2/fileb
> >
> > Thread A:
> > looks up inode for /fuse/dir1/filea in cache, doesn't find any
> > creates inode, fills stale attributes
> >
> > This issue is currently solved with fc->evict_ctr in regular fuse, but
> > works fine without any additional checks in fusex because of the
> > decoupled ops.
> >
> > Of course, it is probably desirable to compound LOOKUP with STATX
> > despite this, but it gives the implementation more leeway  (e.g. on a
> > different OS).
> >
> > To conclude:  separating out STATX from LOOKUPX, etc. makes the protocol:
> >
> >  a) simpler
> >  b) more flexible
> 
> This makes sense to me, thanks for the explanation.
> 
> Thanks,
> Joanne
> 
