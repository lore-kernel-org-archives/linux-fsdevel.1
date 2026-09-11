Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875BA382F03
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139122; cv=none; b=GwS2TUj3Cu7hOW7ZAhf91rkb5CaecnhZR94o9pVoLkQMiRg79b8Qr0NeBb3LSz3IGmYzWC6fc/4OzRogDAjy8td0z5PQU2W03Khf25a0lT5CdPIBsHQDMEaqlpje+TXOrbTOAgqmD55aOASFnnZkX6IJZfx6Gz2VOhXUk6XXusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139122; c=relaxed/simple;
	bh=UuClxPvD/iLaa9HmHTroe7XSTpG5mMnwGP5zVXEdvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWh6aILW7GMK9BFDCVqRUurDGAWjmq4pu/KieKyyQhArxzwHaiB+0BHndIjbOinJLOSKSozYIhHq/vwBtSS8w4XCS7ufDAkEhWhdPzr07ExnvKkbSlvUuAbXEp2R3ncuFRabJtktJtcz7h+kJvNv36+SrUTw0EfB5+w9yFXZo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEbzkop0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEbzkop0"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 124B91F000FF;
	Fri, 11 Sep 2026 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139120;
	bh=F1/KDdS2USdUyGR5XiWg3ho+mGEZKHR3GUWPOY9FID8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IEbzkop05s/iqjVqRTFhoFeuXLx2TOQ1ht2oPNufR5t4VeP5RNyxjyi5qYgqLxrhO
	 kUBE0G5W+aB1FsvHjbY3UwbjjREYCpcYaRV97qCPRQ49YMrBElE9lw2Nq9ZXU/wzEE
	 JEz324WTIFeQzjFweLL+x9QsAJCmam/MvENPDMv2FYF/9X2UVi870KlyPiGi3VNszd
	 XSWYeTlHITdTP81xB/WczWAUNpjIQGXwxP4QuPeU/a2D76PqlNEvDWpM4QbuCMmc0r
	 3EBAhFZnTX5eOops8UnxEbEqLtD2Oit8h6JssMRtHO0Vr/lMKQ35G7Pi7UpRn+cpu4
	 mdFUPRuUIqXTw==
Date: Fri, 11 Sep 2026 08:05:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>
Subject: Re: [PATCH 0/5 v2] fs: Deferred inode reclaim
Message-ID: <20260911150519.GA6244@frogsfrogsfrogs>
References: <20260911081309.14137-1-jack@suse.cz>
 <aqQV6Uwma_KjUH0O@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQV6Uwma_KjUH0O@mit.edu>

On Fri, Sep 11, 2026 at 10:55:53AM -0400, Theodore Tso wrote:
> On Fri, Sep 11, 2026 at 10:51:36AM -0500, Jan Kara wrote:
> > 
> > after a long pause here is a second revision of my patches implementing
> > deferred inode reclaim to deal with MM warnings due to GFP_NOFAIL allocations
> > from reclaim paths. This happens because to reclaim some inodes, filesystems
> > have to do IO including complex operations using journalling and forward
> > progress of these depends on successful memory allocations (which is impossible
> > to guarantee from reclaim context).
> 
> Thanks for the patch set!  I wonder if it is worthwhile to wait for
> inode reclaim before freezing a file system for suspend.  On the plus
> side, it leaves the file system in a more cleaned-up state, and
> reduces the amount of memory that might need to be written in a
> hibernation scenario.  On the other side of the argument there's more
> opportunity for freeze/suspend deadlocks, and more complexity.  So
> maybe it's not worth it.
> 
> What do folks think?

xfs doesn't flush any pending inode reclaim work on freeze, since the
log will be dirty and log recovery (if the frozen fs image gets
remounted) will take care of that.  Freezing to make a snapshot is fast,
mounting the snapshot is not.

--D

> 						- Ted
> 
