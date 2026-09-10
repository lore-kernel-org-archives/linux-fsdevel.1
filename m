Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB089346E5E;
	Thu, 10 Sep 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071332; cv=none; b=SP70djA0/Gy0GG1MuBMPIRqSR/CVcsk1k2ooGGrmeiKDot5+CG9qm/fyXmy7KIkd3oTkM2bWbBg6vCD3k17wBBW+G3yrE4/soHA1YCLa3Vm7G/418WYdF3x0uqOU5OjWISvwKKV+VzAgS11EfvZa5AZkCX5joIR2n7XlBvQLCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071332; c=relaxed/simple;
	bh=dCg6Mn1CYLLoqEy9g8sJNQhK1FmN1t7oByZF7qquY+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfdGaDqHhpWosowCwKsNoPCI0v67QeP6LgbGMXCFFTOoDJmXUUHbXLgI4KfXUkxy0Hd+TtkHopqPzbTgkjiS/nnf89ba/0xDYEczCcFN/97TgFaeUWdruB1k1FoTCfyefI/niwZvese/7t0FEneD6EqfNVpIpzqZyJjemqYTL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAVbE3qM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAVbE3qM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF851F000FF;
	Thu, 10 Sep 2026 20:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789071327;
	bh=kSHhek88oHTukDtNQ/ULnDv09i2DEERy//o7RaNfW+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iAVbE3qM6DNbfCx8nNl8O9n6gMWeqa/oY1v3rfnFeG6HqKBu9T0cf3aVp2Cl7xVWy
	 uSH13Ki6m4B/ptHElyWpFUi74IucdiuLUdITIOth+sG0yLhnm/W/SSjignAUHaCpN1
	 +Ffn99rZP6I1EH2CUSxcu4Io6nmhogByY6ospHkCDJzrROxVph0PhcfVbJ4UvftOzm
	 WciPMDHLDe8Q8e4AaAGkVeajYB4/V+e047cbXkXLr04XaasGEZLxjjL2ntz/8xDraN
	 mbNJ34dW7ofbQ/0oQg1MMEFrHruAMKCAm2FG3okpvZIS/LiS61YNpl32UOO2ZspzNZ
	 JnHq85tzdsThw==
Date: Thu, 10 Sep 2026 10:15:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <christian@brauner.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kernfs: don't repeat or skip an entry when readdir
 resumes
Message-ID: <aqMP3hRFEazxZkeN@slm.duckdns.org>
References: <20260910003650.1680854-1-shakeel.butt@linux.dev>
 <20260910003650.1680854-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910003650.1680854-2-shakeel.butt@linux.dev>

On Wed, Sep 09, 2026 at 05:36:48PM -0700, Shakeel Butt wrote:
> readdir keeps its place as a name hash in ctx->pos and pins the entry in
> file->private_data.  If that entry is gone when the listing comes back,
> kernfs_dir_pos() searches the rbtree for the hash and keeps whatever
> node the descent stopped on.  That is the entry before or after the
> missing one, depending on the shape of the tree.
> 
> Landing before it repeats an entry the previous getdents(2) call already
> reported.  Landing after it, kernfs_dir_next_pos() calls rb_next() and
> steps over an unreported entry.
> 
> With children A(10), B(20), C(30):
> 
>   report A, ctx->pos = 10
>                                     A removed
>   kernfs_dir_next_pos(10, A)
>     A is gone, the search for 10 stops at B
>     rb_next(B) -> C, so B is never reported
> 
> Only the repeat happens today, between two getdents(2) calls.  The skip
> needs the pinned entry to go away inside one call, which the next patch
> allows when it drops kernfs_rwsem around dir_emit().
> 
> Before the commit 4e4d6d860b93 the descent kept a node only on the way
> left, which is a search for the first entry at or after the hash.  That
> commit moved the assignment to the top of the loop, where it runs on
> right turns too.  Restore that search, and step forward only when the
> pinned entry is still there rather than when the hash matches, since two
> entries in one directory can share a hash.
> 
> While here, kernfs_dir_next_pos() called the hash @ino.  It is never an
> inode number, so name it @hash.
> 
> Fixes: 4e4d6d860b93 ("sysfs: Add s_hash to sysfs_dirent and order directory entries by hash")
> Assisted-by: LLM
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
