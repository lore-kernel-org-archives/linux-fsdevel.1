Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4E31F99E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990926; cv=none; b=eCgJSHDPRaUOHNwlBZkElabbV2DV4AmgYiecsMbDvkrTSIXDKWw8ZDx6wStIaCywMWdNjbNK4bIEllP7SxMeIv/oqxPApppkLQVHYx7b6V566GtJSidn8XgIQyoMbKu63x951BGKjJmHZ2oYXYGdoWWNLpW9/Jofpfdyn9TTlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990926; c=relaxed/simple;
	bh=WaCn6cSE6c3EIldRIlS5W/LPD3rlBHG4K2wtGwGG4qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxB9ixKKCUgWHLgBYZYU44OXETKngu/wWboJSH0FPRX22BdaQkj5uu2NFFVKM451PrywM8dNoGxiPMXTS1Z1BAGZmkyn5b16sN0b1Utw/L+GgxPXQKORlQbHVgH4kEI0i3CN+9bLSIoa7emH3sGblG4s3ALFaDUCyej8mCGFcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s3InSHRW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s3InSHRW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=36mo/RbE1Rm6ksRenGPEp1nCzYhMc4Y6VfyMJOT5g7o=; b=s3InSHRWrdXLgLQ/nMu6AYrTJ1
	KUzTIz+cUiIZMc3Zm8l3uu+V5FdxQewP48qtLOM9fx22z6yZ4NQwVZgES4Lo9wf5gjSerM656hiHT
	ZgHM6//SnKuJPoQ0OW+3wYnxz9RpMrN7yU/PiRc2uJgkTLvkrpqQwRvlQoq/NNX8f2Oh2BNpfd14g
	CuFODemQJIVsUJQ7KKhMwydhsNxN0tfyU5E1BoQ/lZ1D9tduHaMtgp37k43swVE3u67VKSpdVUH2O
	tLDEk+wCFX8NHl0sMYI+MIwjurf3MaPoysZligSQ+/nvQblZLjGBTmjqipWmDmoq3erF9Qhkm4T/J
	DXXSfRUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKGfF-00000006YiC-43b4;
	Tue, 05 May 2026 14:22:22 +0000
Date: Tue, 5 May 2026 15:22:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 12/25] reducing rcu_read_lock() scopes in dput and
 friends, step 1
Message-ID: <20260505142221.GD3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
 <177797133377.1474915.1770170197135589795@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177797133377.1474915.1770170197135589795@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 06:55:33PM +1000, NeilBrown wrote:
> On Tue, 05 May 2026, Al Viro wrote:
> > rcu_read_lock() scopes in dentry eviction machinery are too wide;
> > worse, quite a few of the function involved are not neutral wrt
> > that, making them harder to reason about.
> > 
> > rcu_read_lock() scope is not the only thing establishing an
> > RCU read-side critical area - spin_lock scope does the same and
> > they can be mixed - the sequence
> 
> Does it?  I can't find any document or code which supports that clain.
> Could you provide a pointer?

Documentation/RCU/whatisRCU.rst in the section on rcu_read_unlock().

See the subthread back in April:
https://lore.kernel.org/all/CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com/

including this, for example:

https://lore.kernel.org/all/4e59837d-567b-4678-8a15-e933def32fcb@paulmck-laptop/

Basically, "if ain't true, RCU implementation has a bug that needs fixing"
