Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D74071C7;
	Sat,  6 Jun 2026 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721656; cv=none; b=fTJJhcNq6+bUhDJeOzHQ/0pTyubJStoYsL6JvygIjudQQX4/zMXWaqNH3dABl9hc0R4/cNyjtkFbFqs9pz/Abbq2JIZ3OvCaHTlIAnajqmK4e4Jv7r/fNpsmKVl/KnN1ehG3QkbQdlreYBKvX8e3qVM++cDI+vDVkP12CUUVKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721656; c=relaxed/simple;
	bh=JMwG1FBhlDByS+DEtTmWqWUqaXX4UHAiZdXLUSNtySI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8u0is5DQuZPPspUNL40+waNkmetY64paQXh5hQs1TlSiG65MAePDgycqNi8Ndq25Fs9B3EnJ5S8Goe43mpY5VcMRimNIlGoZEIlCSe8j42HmkYr3toYs3Grx5q2c0C8rY/su8bl3NS0UzfHaR9WIZMnMtAiKH2CPZKuh5MPwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irJJkGuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irJJkGuF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 317111F00893;
	Sat,  6 Jun 2026 04:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780721655;
	bh=oCaZ4/AuDFl5siHMCuM8mODmsptbEq2GNEMKW/fCEnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=irJJkGuF5syUGJ/lc6hjJUJRZVRJmxfMMOmEIS0BlBnqWFBZyvegxRACpCKigVtmO
	 UxkMDwbiOdjb/sHyMJqH13BCD2kWtf+BwbP/BC3FDBdObkNvbC5QGUyeTlSw3VlGZU
	 xspzQ7UFeQvvy41xoJin5QrE3hv28GcmEgIpjimKvXQUNyBZ2e2NUesuXsO0ETvR2n
	 uFvZH7FAioQqFzGIlKy1nfccPoPVkMw0fAejaoRZ9K1diMMMr4Wt8o4UCq2xksrffL
	 h9E4s6Vq22gPLUfwL0CFyiQWmMnOUWtJGBsGrUttBRMe7PEu8fidQfsRfmC5vr6X72
	 HzKVgWeGu1oAg==
Date: Fri, 5 Jun 2026 21:54:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	bernd@bsbernd.com, joannelkoong@gmail.com,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH 1/4] fuse: move the passthrough-specific code back to
 passthrough.c
Message-ID: <20260606045414.GK6095@frogsfrogsfrogs>
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
 <177922944844.2436629.11205124993260163523.stgit@frogsfrogsfrogs>
 <CAOQ4uxjJ0eF0vE0hgsNoWqqD+UQ4r-1-b7493cYNPUGSUR+tcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjJ0eF0vE0hgsNoWqqD+UQ4r-1-b7493cYNPUGSUR+tcA@mail.gmail.com>

On Fri, May 22, 2026 at 12:03:38PM +0200, Amir Goldstein wrote:
> On Wed, May 20, 2026 at 12:29 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > In preparation for iomap, move the passthrough-specific validation code
> > back to passthrough.c and create a new Kconfig item for conditional
> > compilation of backing.c.  In the next patch, iomap will share the
> > backing structures.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Please add
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> and please keep in it future postings even with minor changes.
> I realize that fuse_backing_id_remove() was changed in this version,
> so that's fine, but I only know that because recent revision still fits in
> my ever shrinking context window..
> 
> We discussed the fact that no one has lots of spare time for review
> and re-review is a big production killer (in general).
> 
> You must know that very well as a review and also that having
> a "what has changed since last patch rev" is very useful for reviewers
> and also very expensive for authors to maintain...
> ...unless AI agents can help to generate per patch Changes
> for the post --- notes?
> 
> I assume that Agent can do that on a patch set after it was created
> just by giving it two sets of patches?
> For the very least, producing a "No changes since v.." should be easy
> and useful.
> Letting Agent go over mailbox and verifying that all RVBs have been
> applied is also trivial.
> I realize that patchworks and b4 review can help with these tasks
> but they are more tuned for maintainers and less for authors
> (I think).
> 
> Obviously, I could do that with an agent on my side, but that is not
> a good use of resources and not a good model to put this burden
> on all the reviewers.
> 
> Worth a try IMO.

How about a range diff? e.g.

https://lore.kernel.org/linux-fsdevel/177758364789.1315233.15610945404741826500.stg-ugh@frogsfrogsfrogs/

I think I'd rather spit those out than either (a) try to remember all
the changes (esp. minor ones) that I slipped in between two patchbombs,
or (b) go all agenthappy.

--D

> 
> Thanks,
> Amir.
