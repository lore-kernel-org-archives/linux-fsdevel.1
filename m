Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D822BEC2A;
	Tue,  2 Jun 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407440; cv=none; b=NpIWuWmZj0ObTHnly1RNAZEx+op198Ab1zRRq0iZYdtsVo5ARhOxmozXmQ+AjmtIK1ERXAc0MLjBHtvnwE9OxRCFJxDm1u/9mbFufXNRQczMbtZfP3cipeGPZ7co2tkk823TK7w2n3/z+CBQyIDnyBc+3Iw8n1LsqLdCbw3MhXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407440; c=relaxed/simple;
	bh=7ze1nAJji6FOv3ep1jxDWz6DNSzgX13iL686BW1qNlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK8qyN/I83MuWyM3XXsZb92LGh4g43o0Uw5nKd1JXw0OyyrM0yybSnLV+XjXmYJTEqvTPgPVP7rjgIGi/xA7icYQUR7gVla1E9ThPmtUQz6F8WKurRUx/qyobKoC9HzMsRzNGkKyDCqSpofT1ttxY5TYJltlszPxi8Z19y2CmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQt9yOhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQt9yOhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE691F00893;
	Tue,  2 Jun 2026 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407438;
	bh=c8qFlzOVSaK0CDSFvoDW0SZ3dq9wefgDQJGvJSAcsy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WQt9yOheeiq+6V1f9CBx+hSiTXByEUiQ28a554C/L85qgxElNK63D8v10FicJLqt1
	 dtIsOQ2YvcatViDmD2PB5GkrePj7y6xxDsA07NfW3oJC23ruKSWmlkkn/j51mnMMEe
	 LfURoKPGsMZXNiYm08s1duf+Drb+5RSDJdJ9G+PgUdOvzK1WHWjbwxeUZJRyGGvKoP
	 YpdxDDjAx8uLO4g0IxxqrCOKq8sXshPiAh2YE3I+XVQlm4AJTjPHimJzcfX8fPh76N
	 8eOmEcoh9iOljln551PwWbzUo5UsKYfkHbCiGWVK4eaEURXONNP0iRv97uoWOXaBcc
	 7ALfIRdXHeJ0w==
Date: Tue, 2 Jun 2026 15:37:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20260602-gebaggert-sellerie-produkt-f9c5e8362cfe@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
 <20260525202937.466497-2-jkoolstra@xs4all.nl>
 <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
 <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
 <653344520.138270.1780347144618@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <653344520.138270.1780347144618@kpc.webmail.kpnmail.nl>

On Mon, Jun 01, 2026 at 10:52:24PM +0200, Jori Koolstra wrote:
> 
> > Op 27-05-2026 13:43 CEST schreef Christian Brauner <brauner@kernel.org>:
> > 
> > I agree, let's not do booleans if we can avoid them. But fwiw, some
> > userspace projects require naked booleans to come with a comment like:
> > 
> > may_o_create(..., /* create_dir */ true)
> > 
> > Which makes this easier to handle. But conventions like this are
> > difficult to enforce - especially in the kernel.
> > 
> > Years ago I added vfs_prepare_mode() which should handle all that
> > uniformly. Back then I didn't pass S_IFDIR and wrote:
> > 
> >  * Note that it's currently valid for @type to be 0 if a directory is created.
> >  * Filesystems raise that flag individually and we need to check whether each
> >  * filesystem can deal with receiving S_IFDIR from the vfs before we enforce a
> >  * non-zero type.
> 
> Yeah, I think this confused me. Now that I look at it again we can just get
> rid of that bool flag in may_o_create() since we just prepared the mode with
> vfs_prepare_mode(). It would be nice to also remove it from o_create_mode(),
> but off the top of my head, nothing is stopping you from passing a mode type
> to open(2) that has more than one bit set (e.g. both S_IFDIR and S_IFREG), and
> this is precisely what vfs_prepare_mode() is for to fix.
> 
> I was planning to get rid off this comment and enforce S_IFDIR, but I think
> that should be separate from this patchset. Agree?

Sure.
