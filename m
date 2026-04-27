Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABFF372EE3
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326456; cv=none; b=PPXm87yIlkvA4jTLZYc5dCiqVRYcGWMnaw2170OumKFyenI92noRTWxiXZTrQIbK2sw5q2uGU+csO5mabaAhXvtHnDyDPeERECqTAaez1RIXVQR8ofpo7m4v37oC1T0lQdlVJ8EfvyVhQNqAbNNq4A8Cf26M8RD+ASIig6/HiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326456; c=relaxed/simple;
	bh=U5c27N0ckDLv4k1dlDUccmykfOjgGIkOAfcL4RPgEuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6D7BzYxIoIlxUIds8vbvLCvm5+vxILmV6XFE17iDs3pPy/TNrwne0NnP5lB3y70pkoUfQOxpTvUTd5pnF9vLZ7x7dKiFYtu2ZWi0YsHma+VJyf3vQASdOuB3aaxUeamTCBT/I2v3WSNlIVeSn2O+mGtb6F2nRzNfLay620PNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlwPtfW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlwPtfW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264E4C19425;
	Mon, 27 Apr 2026 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777326456;
	bh=U5c27N0ckDLv4k1dlDUccmykfOjgGIkOAfcL4RPgEuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlwPtfW1R3PC38xnIc8kjK66mm1PgoPHEDImz9RBrHnU6Jm4B7c0UoDC/GF567hWl
	 yFobNCARz/iGfzj9lv9qab/aBhMx1H7d/ueTRmn0GOc/9cY5Yl2vlOS9NhNtETYPKI
	 Ze6PH8f0HxRC8IMhMOhSAICMcs+YYtxJZCGfeZxsTejf+AIBpKZKTD8qdIcrBscWl3
	 /tiSVmmdX+U/FdJMLtmbARb5Q9BQ0KDVkfEB04wl9Od/j97rYxiYXmMcP9ZNhm/nqH
	 3eGlRu1LeKH7CLhK2EJV4suhmKteUdZjK2jjxFpPazBUH2GiTv2Uk153ot/rO1bfGZ
	 bUoqqVsjTallw==
Date: Mon, 27 Apr 2026 14:47:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] docs: add guidelines for submitting new filesystems
Message-ID: <20260427214735.GM7765@frogsfrogsfrogs>
References: <20260422125212.1743006-1-amir73il@gmail.com>
 <20260427154818.GL7765@frogsfrogsfrogs>
 <CAOQ4uxg=Yi5eOPshMsA9HV6vrs9SnZ3XFvoqjR4s-AJQPX4FSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg=Yi5eOPshMsA9HV6vrs9SnZ3XFvoqjR4s-AJQPX4FSw@mail.gmail.com>

On Mon, Apr 27, 2026 at 09:30:06PM +0200, Amir Goldstein wrote:
> > > +Be testable
> > > +  The filesystem must be testable in a meaningful way.  The
> > > +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> > > +  framework (also known as xfstests) is the standard testing infrastructure
> >
> > It's been known as 'fstests' (without the leading 'x') ever since other
> > filesystems started using it for their QA.
> 
> Sorry, I couldn't parse the requested fix.
> The document already refers to it as 'fstests'.
> I'd rather just drop "(also known as xfstests)".

The '(also known as xfstests)' part was what I was complaining abou...
oh, that's some weird markdown thing.  Never mind.

Dropping the whole phrase also works.

--D

> The aliases of fstests and their history are  out of scope for this doc.
> The repo URL link does not leave any room for confusion.
> 
> Christian, assuming that we all agree on this, could you make this change?
> 
> >
> > With that fixed,
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> 
> Thanks,
> Amir.
