Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6A3A7F40;
	Fri, 29 May 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040604; cv=none; b=S4/vu/reIfncDwVcn+epaEinHWplFbaUP1rBGLPGe6iODrm3Y6EF6gHe9HLaBo9wK0uV2erucLh1ovV6FWFmmofkjuyDplDjsXvwKvJByq7MmXbZLMWj7I82NtsBuqqlupPGBr8X2sfuuXrhfeBXY4T3LztD0u6eaSO5Jv/4OFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040604; c=relaxed/simple;
	bh=A2h+DOJzxIR+ZJRWgzMvpaPggw9iRlvJcV2DtYE4rEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfxFTI4OLWw/XOPGReVTddKJl1fu8zC1Ercf08QrIYz7vTz12ZHKQpZ4BhdFYQ8CV5fgiOGgKdfdkdLDoxdCYx7mHRSe10FZjBAa3fwbvkBz5+7ftFeZXNUR6Zges+xgMox2idIO3tSoBGmP2MlVuJIDf9hJo4NtWv3iy/G6zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAWLGC5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAWLGC5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46501F00893;
	Fri, 29 May 2026 07:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780040602;
	bh=p0g5VfVUP3z7rnjp/sO36pzOo6+7QCC3VQWkht+TjOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DAWLGC5QNK3NMAIVDGKeDyea4wIaMb2FCL2bHxcEBlaNFntXZuDWgnUUbHLt/N2Nz
	 DTXpC1Jm2qimdV5JhSQhiYtldq354eTStsm35JzjP8AO0CKuUuBNMyGW/fDckm6roS
	 lyVUJrKjvfKshE3AsGVePz36ONoJsbDhP1JZrvAGbLseM3Awwlzt2cerWu9Hg+1UGl
	 MuZg+EqOXh6Epc+ySeZ9Zel/MnPcpq8+6JNYuLKFuxvvpC6dFw1tnbTMtzMxrpOZ2B
	 uE+MoQw3i5CODrVwMXa4AYN85l1PkL63o/6sl1n0QNu5lHCKgneFgxtrn07pU4HMNk
	 akS6Bxw7WVV8w==
Date: Fri, 29 May 2026 09:43:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20260529-einmieten-fotoreporter-marken-c57a623b2ee7@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
 <20260525202937.466497-2-jkoolstra@xs4all.nl>
 <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
 <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
 <177992025109.3379282.17157116761998684695@noble.neil.brown.name>
 <20260528-abnimmt-befreien-perspektive-a7930659fb40@brauner>
 <178001270913.3379282.7350422637224934642@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178001270913.3379282.7350422637224934642@noble.neil.brown.name>

On Fri, May 29, 2026 at 09:58:29AM +1000, NeilBrown wrote:
> On Thu, 28 May 2026, Christian Brauner wrote:
> > On Thu, May 28, 2026 at 08:17:31AM +1000, NeilBrown wrote:
> > > On Wed, 27 May 2026, Christian Brauner wrote:
> > > > > 
> > > > > I'm not convinced the change to EOPNOTSUPP is a good idea.  It should
> > > > > be a separate patch so that it can be reviewed separately.
> > > > > 
> > > > > EOPNOTSUPP is documented as
> > > > >        EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
> > > > > 
> > > > > and we have no sockets here!
> > > > 
> > > > Sorry, not even userspace tooling indicates that this has anything to do
> > > > with sockets.
> > > > 
> > > >     > which errno
> > > >     /usr/bin/errno
> > > > 
> > > >     > errno ENOTSUP
> > > >     ENOTSUP 95 Operation not supported
> > > >     
> > > >     > errno EOPNOTSUPP
> > > >     EOPNOTSUPP 95 Operation not supported
> > > 
> > > $ man 3 errno | grep EOPNOT
> > >      EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
> > >                      (ENOTSUP and EOPNOTSUPP have the same value on Linux,  but
> > 
> > (ENOTSUP and EOPNOTSUPP have the same value on Linux, but according to POSIX.1 these error values should be distinct.)
> > 
> > Consistency be damned, I guess.
> > 
> > And if we start caring about POSIX again we should probably remove 90%
> > of our newer apis. It's irrelevant what the standard says. It matters
> > what we do in practice. Taking a tour through the kernel and trying to
> > prove that there's any 1:1 relationship between socket operations and
> > EOPNOTSUPP fails. Equally, going through large userspace projects to see
> > whether they treat EOPNOTSUPP as even vaguely socket related also fails.
> > 
> > Even glibc treats EOPNOTSUPP as the universal "not supported" sentinel
> > and raises it even independent of what the kernel returns. One example I
> > distincly remember is the fchmodat() AT_SYMLINK_NOFOLLOW userspace
> > emulation it had to do.
> > 
> > Maybe I really misunderstand the motivation for this discussion. But
> > this feels a bit like wasting time on something that we've already
> > established a while ago.
> > 
> 
> Maybe someone should update the man-page?

Yeah, someone did yesterday actually and it was merged the same day.

> My main point was not that EOPNOTSUPP was a poor choice, but that an API
> change needs to be managed properly (and I'm not sure it is worth it in
> this case).

Right. That's certainly a valid concern!
