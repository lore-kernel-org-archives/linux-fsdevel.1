Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733BA3E0C5E;
	Thu, 28 May 2026 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968002; cv=none; b=M/QJEBA6kTdPMYbiVKY0WTc5CYfZRaTzYuS62VZ/R+o4xGl/BKuZ1sJXpWq1zGvvRZDVlmWdc2Vd3axX/wPi68ZHaoe8/CvbJe72FjAgnyOcKJbBiUO3n/adzzPueM/GZMmEHTxBM7D/QZbpUnFH5tzMUKo/tUz6MzrJFp2/eAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968002; c=relaxed/simple;
	bh=5s4aLFuaGUGjFXQTqGvMMM9FFTXaImxY+lJy6MV+SNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj0+ahylhH8yXYk9TKKfElGvnJKiMAkaljn2xkBxAzm3JjIo9nWNoe9e3ZEkHs+X6Ayhy6HD/+5Mrs5DwwyJhEaQIN/RwfbWdc+HA4OsXh6d7BTKNg1bOi8SkxsNIbNwsiyCafldHZUDWQ795szGIFajUlcspsnwDgskveWKgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfautRlf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfautRlf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A631F00A3A;
	Thu, 28 May 2026 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779967999;
	bh=t6q9GH6uNAR0dK/WzJvVI7KDQXsJgNH7k3u8YFafhHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nfautRlf8sEHgAs0GCndrhzMraJi9WzUSkxix9RqVHBXDsVQuJMFb98Fgr89W2E/P
	 Wzxv0Y41xp74CJ03WxrERIG0lbgJB/xFsH/YddwCkZ3AMxsxgBk+fT/NV6y4Ls8Rjr
	 H8D/t3gDzHL+USqVgWeOH4wa68i/CIFmpH6uxXNCmDcqzNaU66GAUQm1fppv3b+HnS
	 oJzFnD9FPK/Wsm8Ob4n7T0qljZGSOV6rB8joA2V8xQ+EG2I0Sby4yB8JO1+faKFMca
	 33zE1Gtdp++eCoBRdXrmrknwEIf7IY/CEjnhDfhYKx2de9R+Ri6UbO2YF53pjM4rDX
	 sSm0dj0rrkExQ==
Date: Thu, 28 May 2026 13:33:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20260528-abnimmt-befreien-perspektive-a7930659fb40@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
 <20260525202937.466497-2-jkoolstra@xs4all.nl>
 <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
 <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
 <177992025109.3379282.17157116761998684695@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177992025109.3379282.17157116761998684695@noble.neil.brown.name>

On Thu, May 28, 2026 at 08:17:31AM +1000, NeilBrown wrote:
> On Wed, 27 May 2026, Christian Brauner wrote:
> > > 
> > > I'm not convinced the change to EOPNOTSUPP is a good idea.  It should
> > > be a separate patch so that it can be reviewed separately.
> > > 
> > > EOPNOTSUPP is documented as
> > >        EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
> > > 
> > > and we have no sockets here!
> > 
> > Sorry, not even userspace tooling indicates that this has anything to do
> > with sockets.
> > 
> >     > which errno
> >     /usr/bin/errno
> > 
> >     > errno ENOTSUP
> >     ENOTSUP 95 Operation not supported
> >     
> >     > errno EOPNOTSUPP
> >     EOPNOTSUPP 95 Operation not supported
> 
> $ man 3 errno | grep EOPNOT
>      EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).
>                      (ENOTSUP and EOPNOTSUPP have the same value on Linux,  but

(ENOTSUP and EOPNOTSUPP have the same value on Linux, but according to POSIX.1 these error values should be distinct.)

Consistency be damned, I guess.

And if we start caring about POSIX again we should probably remove 90%
of our newer apis. It's irrelevant what the standard says. It matters
what we do in practice. Taking a tour through the kernel and trying to
prove that there's any 1:1 relationship between socket operations and
EOPNOTSUPP fails. Equally, going through large userspace projects to see
whether they treat EOPNOTSUPP as even vaguely socket related also fails.

Even glibc treats EOPNOTSUPP as the universal "not supported" sentinel
and raises it even independent of what the kernel returns. One example I
distincly remember is the fchmodat() AT_SYMLINK_NOFOLLOW userspace
emulation it had to do.

Maybe I really misunderstand the motivation for this discussion. But
this feels a bit like wasting time on something that we've already
established a while ago.
