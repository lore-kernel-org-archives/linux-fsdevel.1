Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80552199FAB
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775191403; cv=none; b=VNbch4m8hV9YIuPeyylA+eJWvGKH55iwlybFHFji+Rt7WVO7ZIDdx1XCuWD1gJEvUd49aOGvkX7faCQ/0Aj0MDplN6FZY1iISz2Ktqp2CHlSEu9Gph+rMqN9VYxnYz+DpUqLAfubscA+JJbk67sAQWjRqJBB9YI/RDA89OAHgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775191403; c=relaxed/simple;
	bh=hvprZegQyaLcHOzps7Pnq/Jwhi5/Oi6fWRXeO9/0SZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBhmy84iNr2+Fr4MkC4nn3Vx/zgmknFay4FvqxkgjAd5pY9XxKCf+RcK2cBxeYNPavZ93pjbeqG0t02saLgDBXtovXrOTUb8F2BknGS3RE6HyQ5znDpGRsb9xk3fEy8wZXGK05ySXPzKRTcjOxzgT7XgcRWlPCtkNmnOueKODDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OyqZdjXo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OyqZdjXo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oFVomIA8TWgXViwyg1umeg/JgcE0X+k+dI7YgXGok5k=; b=OyqZdjXoaGcPboZ72WwVjoIy+J
	+X/5EApWBC+gZJcTyNAdBvnPG+zh0sdCfYLMoDn4Yczf1ZO2Iy4XZNpFSjwx/5WHdJuVgI2J2qd0L
	FYg9VL+ASJmyfbTzfVpGNtck9N63RGBw5iwGKopXho/yShgY0eN+qeL6DcVhT+MzLbbamOvQ8x46u
	wWzrhLI60t+CXvoITqf/Q8yW0InJ5rZKpi5Y3xDrNT9PbIpYqD5kPc4NZfAaGOMVjBikAqs8NgKiH
	HjfsaZfurwnVTxXMghfUHXcPuWgnMbff20X36mBAPGoYi6WdyHvdMx1s6ZgnKXkc0hkReLiRZT1Gn
	B6iCI78A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8WQo-000000086rP-3rak;
	Fri, 03 Apr 2026 04:46:55 +0000
Date: Fri, 3 Apr 2026 05:46:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paulo Alcantara <pc@manguebit.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] getting rid of busy-wait in
 shrink_dcache_parent()
Message-ID: <20260403044654.GL3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <48017c1409ddff65ab776a8ff3d25df7@manguebit.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48017c1409ddff65ab776a8ff3d25df7@manguebit.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 02, 2026 at 05:28:58PM -0300, Paulo Alcantara wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > Note: in -next CIFS has grown a local copy of d_mark_tmpfile(), which would need
> >  the same modification of sanity checks the original gets in #3/4 here.  I wonder
> > if that cifs_d_mark_tmpfile() should be turned into to d_mark_tmpfile_name() and
> > lifted into fs/dcache.c...  Anyway, that's a separate story...
> 
> Yeah, I would love to have a helper like that and don't mess up with any
> ->d_name outside fs/dcache.c.  That's why I'd suggested it in [1].
> 
> I'll send a separate patch adding it as soon as I'm done with testing
> O_TMPFILE support in CIFS.
> 
> [1] https://lore.kernel.org/r/20260401011153.1757515-1-pc@manguebit.org

OK...  IMO we'd be better off with never-rebased branch adding the helper with
cifs branch pulling it and busy-wait branch based on top of the "add the helper"
one - no merge conflicts that way...
