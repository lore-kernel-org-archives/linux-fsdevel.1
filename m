Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845683CBE6D
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341144; cv=none; b=bdgsJKCSJy3FDujgVyy3vzIxnrM1S3qW77RQ469VbKrqoVl5DKjRX3uxvdfDdBKr3/mUwcZPp5ClTLtOnTg8MlkXU40/QwdmAKCUMTL4rA2PoxVgQH6VLZS7tS9ofT69XfVUHoqLvLq783IroZYz9WKys1e4uRr4ko+SO7Be/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341144; c=relaxed/simple;
	bh=yx1+qf0LHL8iPcxHgZWathnf4QuB2nKoPCx2gRSRAkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcloL3DI/AgNqh9OTyMuiIM4oQCDUAMi22tkpdLn/QZfrdlMU326EhWFgIoF50u55jZ1E5EBQ4i4SUmuxMAUvMb6isErmqkjGqWs713eZvPN9XfT7+JxlmPksKi70P4DwjpP8ZK6YlBTxdwdngyRFmhLd9o/UTA1etbhn7WU8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6O9bqFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6O9bqFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8296A1F000C4;
	Sun, 18 Oct 2026 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341142;
	bh=vXmsXrW9g5ERWqw50Hle81CCneHAZD3UEJaJsVp8ZS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H6O9bqFZP2JKWY4AlFlUDZA2c+Zr9vks4muJaR8nwQIkFX/orrItuOlu3fw3PzZpw
	 JQN+htMQlY9N3DjlxhMaQEYMoh8L/1dxIxa4CHiGRRIHqGErI4HxHvUvc7quSG/yUr
	 4e3hD8bnkLPYbfrb0kxKEd58DOX4ll/PLAKC5pUPcPpPKEUMMNH5A1PztKLFUqn49H
	 E246kZQF96yeRuw0zjkYzsim6As0Yg64K1bBInwl4CugCEzh1cDGRx0E3QylE5sAOB
	 2vmqkzxdiYHahKmE/vv2/6frbH4ck25WIXW2u9eKM65VOQITko2cX7vl5+23CwutwI
	 806TmX/IMKvZQ==
Date: Sun, 18 Oct 2026 18:32:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/3] namespace: rework connected mounts
Message-ID: <20261018-popsong-pracht-quark-a0f9a2d3734c@brauner>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
 <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
 <20261018031522.GC3535232@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018031522.GC3535232@ZenIV>

On Sun, Oct 18, 2026 at 04:15:22AM +0100, Al Viro wrote:
> Is there any point for that to be an hlist?  I mean, you only ever add to
> the head, walk it only forward and remove them one by one as you walk...
> What's wrong with plain struct mnt_cover *next; instead?

Not quite. The parent's final mntput() drops its covers as well and that
removes from the middle of mp->m_covers. A mountpoint can carry covers
of more than one unmounted parent. So with a plain next pointer that
becomes a walk over the mountpoint's covers.

> ... and seeing that the only place where you have a lockless traversal of
> ->node is only looking at ->dentry, it might make sense to make that
> 	struct hlist_node node;		/* parent->mnt_covers, RCU */
> 	struct dentry *dentry;
> 	union {
> 		struct {	// never used by lockless readers
> 			struct mnt_cover *next;
> 			struct mountpoint *mp;
> 		}
> 		struct rcu_head rcu;
> 	}
> perhaps?

Sure. Note that it's a separate allocation so 40 bytes land in
kmalloc-64 just like 64 do. IOW, it's a cleanup, not a saving. I can do
that for 7.4.
