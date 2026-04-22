Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77D3D9DDF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861245; cv=none; b=szK3nXVbwOuUG2/rn2k5DRQWbz62xW5irc8Hk9t4N5vrXHNydwXsm4F2HMnWhRMgWrGji4hDtu1+cAu5cB8l9XlPrS8uOIbHt90duGaOnfwRGeSN+nK/soBDhPBFWRqBw4DaoUnjeAOtHX8gie65M65poz2ykq1+j8b7OBxDwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861245; c=relaxed/simple;
	bh=dgDRYinNhgOtyJdwnOG6nhxVjs++vPXX6BRIHblX/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td/OoO/YKhYlGS4/LNc4ndBNVnHrDYEZKoL9Ld5Azwq8V2aYEFAwDWZeJIhx/+Vb2LCK5mOSb1/4Z2CzWRd8qlwK89bt3Ga9/4xvO2NqRp0avWUU2EE2clGR7gKwoEVzyHJ6f7IfdOC7KRi9aDeBgTdZ9QeCx1PlO/O6DirppVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX8hmkBr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX8hmkBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445BDC19425;
	Wed, 22 Apr 2026 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776861244;
	bh=dgDRYinNhgOtyJdwnOG6nhxVjs++vPXX6BRIHblX/NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bX8hmkBrsYaov9jHMJ1Qh28o1cVtZ0V+D2bf9KBeNooGcKYXn8xp2zklnrhzPwMcQ
	 ILSLjIMfyme4pL2PskMMBEfXaznJngD3nLIHotgmjLyxmdz/jw2hbx/+AQ73FJNhV5
	 qmMOqcBKsMEuNlb/5vC/xJgzMuJmzDyK0yTELzewasCltapZu52FyXT3oVag2FxIeZ
	 /G2xx/oMfIpe2eCYC+baR72cRdpJuieJn4BuFBU23KXzPFWGoWkjTuIgWCbayD2AMm
	 VI8/3Ga+igKd+VCMPv0RAUAL0mRy81loBW4NmPzHXlKkgyp9vsHwr7PIwOSf9/ioGl
	 BNiwav1r9liQw==
Date: Wed, 22 Apr 2026 14:34:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem breakout sessions
Message-ID: <20260422-unzeit-gepachtet-8632ca58584d@brauner>
References: <1270238484.1040011.1776859746395@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1270238484.1040011.1776859746395@kpc.webmail.kpnmail.nl>

On Wed, Apr 22, 2026 at 02:09:06PM +0200, Jori Koolstra wrote:
> On Wed, Apr 22, 2026 at 10:58:25AM +0200, Amir Goldstein wrote:
> > 
> > In this setting, I would like to open the stage for people to talk
> > about whichever topic they like -
> > An idea they have been toying with,
> > An item on their TODO lists they never get to
> > A WIP branch that is bit-rotting on their work station.
> > We could of course use this time for FS specific BoFs and
> > Ask Me Anything sessions with fs/subsystems maintainers.
> > 
> 
> Not sure whether I may bring up a topic, otherwise just tell me to GFTO.
> 
> In relation to the doc changes you've proposed over the last week, there
> is another gnarly topic. Namely, what to do with the "kind of deprecated"
> filesystems like minix, efs, jfs, etc.
> 
> Months ago I contributed some patches to minix and in the ensuing
> discussion the idea was floated to maybe replace it with a FUSE
> driver (perhaps in-tree under /tools or something). I am quite familiar
> with minix, so I suggested I was OK with doing that. However, naturally,
> other (more interesting) things came in-between and I haven't moved a
> lot on that.
> 
> One of the reasons is, I wonder if this strategy makes sense. minix is
> not too difficult to port, but what about jfs for instance? Who is going
> to spend time on that? And if I remember well, Linus has been quite
> outspoken against just removing them.
> 
> Some questions I have:
> 
> 1) Is the FUSE driver thing the way forward with old filesystems?

Possibly not clear how feasible that actually will be.

> 2) If so, do we want to maintain them in-tree?

No. Then we're back to square one.

> 3) If so, will we accept for instance a Rust implementation? Or do we
> want to stick to C?

We don't care what userspace uses to implement the fs but see 2) it
won't be part of the kernel.

> 4) In the mean time, what is the policy with regard to unmaintained
> filesystems? Are we looking for maintainers or does this come onto the
> vfs people? efs is listed orphaned in MAINTAINERS, minix has no entry at
> all. jfs is odd-fixes, but I remember David Kleikamp rather get rid of
> it.

It falls onto the VFS maintainers and we pick up bugfixes but don't
actively spend time on deprecated filesystems ourselves. We port them to
new APIs where it's required but otherwise they bitrot - that's the
reality. Ultimately they will be removed as we did with things such as
reiserfs.
