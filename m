Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A732572F;
	Thu, 14 May 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797320; cv=none; b=IYQ7eJfZkQbHovQ8zedyICRN3lkqBlIOAU9/cQKTc5shwpLEkix74vEH9Wx4ymRe5JMVEQ7+K3XNzslIwoZI4jXwqoUKV+8xzYWD9CtWw0J7pwhQMlHDOP/DLQ65weqAS/u4eRTMWZ7gtZFRD/Y+UVys/eN4o+y98mObHKaRLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797320; c=relaxed/simple;
	bh=hvptvZ6FRcltMx3J8j6jYk+c4K8SPImWEu9NVmydtmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jen5Rq2IX0sfp4djwINZ+R3xy8boM4hwBSL3g0CyVgVOWwehbcna9j8wRArrifJIo/SCHqIMYlJ2P8GAAfNNUBC3iy6P+U3qNOPXyF3u2iL3Dmh5hr3kDZJ+I5nO/3hqmLKz7lEu7D4Y2Ow8EbtNNCW51+1dc//UjfQkkgCN5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po8+qXpN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po8+qXpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F14C2BCB3;
	Thu, 14 May 2026 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797320;
	bh=hvptvZ6FRcltMx3J8j6jYk+c4K8SPImWEu9NVmydtmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Po8+qXpNXeVYWW9Oc068XojBc6SZNnBs/DP0TSIayOYdqzYJNkNTXgtHUcQbZ06mV
	 OebyCoQb6im0c1bNy5GxgrqlXWckvfn3G63G3x8ZN6DXMAfq/tB1E933oaPRMKz/5E
	 7LVkTEDSM4GkHsVjwbM2I/twRQ/vX/gCb9HQOg9ir8r7+KbF6KmEvnTKdDkx3nhnOX
	 XHZFw+I1jy5A4Y0hW+0BJxJTXktVD+Fn7d0sQS1x2TAsaivJDQMv721nPMKTAixqFm
	 UHlI4eV7miKzNcELk6Yt0OOBVbnkuDE44XbC0uFTtalUHC9A9ZBM0WGOKLoSgdy7SP
	 FceiuDG/DSd7A==
Date: Thu, 14 May 2026 15:21:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev,
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] fuse: move the passthrough-specific code back to
 passthrough.c
Message-ID: <20260514222159.GO9544@frogsfrogsfrogs>
References: <177747204594.4101743.18108570914300152558.stgit@frogsfrogsfrogs>
 <177747204624.4101743.10110436900437243535.stgit@frogsfrogsfrogs>
 <20260514183826.GB9544@frogsfrogsfrogs>
 <CAOQ4uxjc=6cdTCuPiH8trqyHzJ1dR+oZ1Aidfos8mqgB4Bv8EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjc=6cdTCuPiH8trqyHzJ1dR+oZ1Aidfos8mqgB4Bv8EA@mail.gmail.com>

On Thu, May 14, 2026 at 09:48:31PM +0200, Amir Goldstein wrote:
> On Thu, May 14, 2026 at 8:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Apr 29, 2026 at 07:23:26AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > In preparation for iomap, move the passthrough-specific validation code
> > > back to passthrough.c and create a new Kconfig item for conditional
> > > compilation of backing.c.  In the next patch, iomap will share the
> > > backing structures.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> I think I RVB this on v6:
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxgW4=6KRuR6Qh3uMQyxtdRPLwAXZ8VY4yuduzTVqz7+dA@mail.gmail.com/
> does not look like this was changed?
> Hard to keep track...

Yeah. :(

<snip>

> > >  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> > >  {
> > > -     struct fuse_backing *fb = NULL;
> > > +     struct fuse_backing *fb = NULL, *test_fb;
> > > +     const struct fuse_backing_ops *ops;
> > >       int err;
> > >
> > >       pr_debug("%s: backing_id=%d\n", __func__, backing_id);
> > >
> > > -     /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> > > -     err = -EPERM;
> > > -     if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > > -             goto out;
> > > -
> > >       err = -EINVAL;
> > >       if (backing_id <= 0)
> > >               goto out;
> > >
> > >       err = -ENOENT;
> > > -     fb = fuse_backing_id_remove(fc, backing_id);
> > > +     fb = __fuse_backing_lookup(fc, backing_id);
> > >       if (!fb)
> > >               goto out;
> > > +     ops = fb->ops;
> > >
> > > -     fuse_backing_put(fb);
> > > +     err = ops->may_admin ? ops->may_admin(fc, 0) : 0;
> > > +     if (err)
> > > +             goto out_fb;
> > > +
> > > +     err = ops->may_close ? ops->may_close(fc, fb->file) : 0;
> > > +     if (err)
> > > +             goto out_fb;
> > > +
> > > +     err = -ENOENT;
> > > +     test_fb = fuse_backing_id_remove(fc, backing_id);
> > > +     if (!test_fb)
> > > +             goto out_fb;
> > > +
> > > +     WARN_ON(fb != test_fb);
> >
> > I think I should pass @fb into fuse_backing_id_remove so that it
> > performs a second lookup under fc->lock and only calls idr_remove if the
> > result of the second lookup matches the passed-in @fb.
> >
> 
> I agree. That makes sense.

Thanks for the feedback!

--D
