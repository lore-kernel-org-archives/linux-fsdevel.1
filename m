Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D73EB11D;
	Fri,  9 Oct 2026 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532127; cv=none; b=PBMmFvYTsspEZh6IFtIGkIUe+ENgo5+Y9WBM/DuuwvVxISVUtElpCZgAUM4kh9WAaNKCuFPYWprsGkBkI6BHU+u/ADXvteO+pAWcRKq2CZ9xm3n69dLMmpexPeVPnjr5Uz3+emNZo33AmrMYzjGdp1R9XZauubfxkIk/uQuPWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532127; c=relaxed/simple;
	bh=RdhfLvAs8LoBf6ot8SlajOfSJl+FY3cdxUZOZ16MrOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqiSo5TUgl+aP+mWggswEKpKGOjtp0NPiP0oPg/31P5o6NMXhrPpEDEvOUyij8Q+nc0NTj0+ujXwU2E88mzLXxmg0pO1BcgXGznmdCQdUq1A2u1zVQGp3hbeU7DN8TsmLTJ1PxIKXkYHV8sKeS/I0CLVWusUo6u+wmanZHChNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecz1wTR3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecz1wTR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC58D1F000FF;
	Fri,  9 Oct 2026 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532126;
	bh=rd7t/j3Gr3NUu8OvfP6alBmfJk/l+YTRs8EqdwAgXCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ecz1wTR34LQkMZqwyxxPq0sr4aKrvARBjodnLqMVk0dyaC9mAYSPaVsCPCviegZrw
	 EMKCJLikh5wobm9to/YwCXplZ8kOjWdiwoabDUDMap4ePxMyoj2476MhIKoYb1w3gi
	 7uhBTNe0uuRHHcqdeIPJRoEYQ2icjAD2QrPy2vVCm+1WlnpUe2pj3yMMu5Uw0cLjKG
	 1O1Hszc41HzkVxhHrLwwcdyjoZFUT5HRq3CEAAUe861NLx9bFqMt3PnQbdo2WDdCeh
	 iz5ta7ppNq/IeAN6bt8COdJ/Qk2Eo6Yt6iwVZa4PuRpn6BDPL4nANr/ojRHIdmXZva
	 qGGCLMYdsPTag==
Date: Fri, 9 Oct 2026 09:48:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>
Subject: Re: [PATCH 16/21] fsnotify: let a filesystem refuse marks on its
 objects
Message-ID: <20261009-zinssatz-hinreichend-havarie-9cfa89532412@brauner>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
 <20261002-work-mount-fixes-4-v1-16-dd44b89d44ce@kernel.org>
 <CAOQ4uxh9O4-sUpN5mT-GHriGQ26R_n++mELNh3wOPKSrMYDSRQ@mail.gmail.com>
 <ktwf3k6arjrcezb2ah3fmj7q7qu235ri4yau5c6hmwithutl3l@3xk6vqisfjhj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ktwf3k6arjrcezb2ah3fmj7q7qu235ri4yau5c6hmwithutl3l@3xk6vqisfjhj>

On Mon, Oct 05, 2026 at 08:02:59AM +0200, Jan Kara wrote:
> On Fri 02-10-26 16:26:19, Amir Goldstein wrote:
> > On Fri, Oct 2, 2026 at 3:54 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Don't let nullfs be watched. fanotify refuses mount and filesystem marks
> > > on SB_NOUSER superblocks but inode marks of inotify, fanotify and
> > > dnotify go through. The one inode of knullfs is the root of every
> > > kernel thread and the following patches make it reachable from
> > > userspace as the directory that stands in for an unmounted mount. A
> > > watch placed through one such directory would report the opens through
> > > all the others, across users.
> > >
> > > Add FS_DISALLOW_NOTIFY next to FS_DISALLOW_NOTIFY_PERM, refuse a mark on
> > > any object of such a filesystem in fsnotify_add_mark_list() where every
> > > backend ends up and set it for nullfs. There's nothing to watch on a
> > > permanently empty and immutable filesystem.
> > >
> > 
> > I don't particularly mind this custom opt-out, but
> > shall we perhaps instead deny marks on SB_NOUSER directories?
> > IIRC, we already wanted to deny marks on any SB_NOUSER, but then
> > it turned out that some users set inotify watches on pipes, so we stepped
> > back and restricted SB_NOUSER only for fs/mount marks.
> > I think that the same logic extends well also for directories, because
> > I don't think that any existing SB_NOUSER fs is supposed to be
> > exposing them atm, so no regressions are to be expected.
> 
> Yes, I agree that placing marks on directories of SB_NOUSER filesystems
> should be denied as well because it doesn't make sense which would settle
> this case without a special flag AFAIU.

The problem is that we're introducing a file in another series which
doesn't work with this option. My proposal would be that we do the flag
now to get this fixed and then we follow-up with another more
comprehensive approach.
