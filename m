Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85E370AE5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475300; cv=none; b=B6v94PsEpLObEvLDY5bb2c8AnBm9N3FvOnS92s6jG56oPCGnlPPFZZyCrYfBJg6KDMkUa36mxRO5CFshniwtPTsN0NNaZc1fKHUg2Dtt7yS4a007QHSiPW+3C88Wcti4olnjhlJGvXzLKI9qREUyzbCBvUZ9EEU0ZEVurCiSbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475300; c=relaxed/simple;
	bh=9vTlcg9EZmAG4dHTV+dzPJYlc0XR8zbRIw1eeHZOSQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ZXg5zzdKGZPmLaDnqJm1Oo97R9+RnlcFGfQD2xuATB4kWu3JJ8W0SOIdjCNSipWQ3k7U53YZXJs40aVeyugch7hOeJrhyWw8GYGdh/GP6nnEQxULcPCLoWMR56GR+iLvI0bzsh+IMh/ysUx0pc8JNxlNwI1oyinIslSAmhNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nmAEwMdD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nmAEwMdD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fE1qcc15iqL1LiM7ClMVA/UAf+hjSf0CFGF1oQImv+0=; b=nmAEwMdDomNJeMu2+T+53cGFOh
	i+bazR6bFByU9uNusGhvxtaRe2/Ut7EWMp9mkl2q9B3fD3EGiWDdhEnS3Gu9LO3xpi7Tpb9+r8C0T
	C0eU7vxUFSCZKJrg3AJEtBblr9757gciNdVKgRaDtlANUflLF5s5SyyrJwJm97w+XlPQOEc2QoDmy
	MrtdXT4KBzK3o7lUO6M1roPEcrJ7bTF+VpIZ8LasnRbIYLj0Zpi4XHHrZgc8BgjpmupUIUQn+Xomj
	rGkDsp6W4ImaUBdh61yZ4+COLEsBK+DH1Wy7+9jA6PPuuCnaEAMewiYsXAZ/kRhZafITv2bDyRAjz
	otdOjZKQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgxU-0000000CswW-0G5z;
	Wed, 03 Jun 2026 08:28:16 +0000
Date: Wed, 3 Jun 2026 09:28:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/3] get rid of impossible checks in
 detach_attrs()/configfs_detach_item()
Message-ID: <20260603082816.GV2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-3-viro@zeniv.linux.org.uk>
 <20260603075340.GU2636677@ZenIV>
 <20260603-lausbub-meerjungfrau-hierher-272084648719@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-lausbub-meerjungfrau-hierher-272084648719@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 03, 2026 at 10:09:37AM +0200, Christian Brauner wrote:
> On Wed, Jun 03, 2026 at 08:53:40AM +0100, Al Viro wrote:
> > 	Argh...  Please disregard the 1--3/3 part of the thread -
> > I've missed the stale (and really ancient - it is from back in
> > 2019) files sitting around.  Sorry, should've checked what the glob
> > had expanded to... ;-/
> 
> I'm more worried about what time it is where you currently are... ;)

4am ;-/

FWIW, the followups in #more.configfs switch the sucker to
..._recursive_removal() and massage it to building subtrees
detached from the main dentry tree; as the result, the locking
is _much_ milder there - all lockdep magic goes away and so
does the configfs_dirent_is_ready() crap.

Diffstat of that part:
 Documentation/filesystems/porting.rst |   8 +
 fs/configfs/configfs_internal.h       |  12 +-
 fs/configfs/dir.c                     | 705 +++++++-------------------
 fs/configfs/file.c                    |  43 --
 fs/configfs/inode.c                   |  41 +-
 fs/configfs/symlink.c                 |   9 -
 fs/dcache.c                           |   2 +-
 fs/libfs.c                            |  61 ++-
 include/linux/fs.h                    |   2 +
 include/linux/fsnotify.h              |  13 -
 net/sunrpc/rpc_pipe.c                 |   2 +-
 11 files changed, 243 insertions(+), 655 deletions(-)

and it even seems to survive light testing.  There still are bits
in old branches that need to be ported on top of that, but most
of the tricky massage is already in.  Unlike #work.configfs that's
the next cycle fodder, though.

I suspect that #fixes-configfs (first two commits on #work.configfs)
might be worth merging before -final; the rest of #work.configfs is
-next fodder if nobody has problems with it.  #more.configfs is
going to be rebased on top of 7.2-rc1 at the end of merge window...

Anyway, I'm really too sleepy right now - will post other stuff
intended for -next (starting with updated #work.dcache) after I get
some sleep.
