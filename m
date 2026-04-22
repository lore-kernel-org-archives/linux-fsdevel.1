Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6CF282F3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867074; cv=none; b=b9SWWTzDdhEsdbBN82Pg1Kj2EFq/iQzSSSjdzWIMx/dN6/w7Q2mL/tS6Wcgt4fKU0bfpXkIeiO5yVpj09lyvKZwmRGGG7dZFlEic6ZQPH0Zrn3dAXTNB1Pm2y2KTL/79PCF64kmaCjAeQ5EBVUdIYPz2NxmE5sJigPvEBY3Lg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867074; c=relaxed/simple;
	bh=/fLAKdqWIyUt/N7fD2f63/Vf3/Y8y6Hw/yj8M0lOoYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxiQVvcARubaHODivwN+oLggtVmJi/JFjF91YFbYkcuev+wUJrpX1XR9cR5GWomYHcMfpwuu48r2WDRyeoKiQl4bH9+EcW+E0vESsaYd0Svgipwd++oMSA/t+1cS0supFMunh1ekdycMElryTwKJ8qqFQAtUjXuiMlMiqbs/CY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=m2F9blQa; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="m2F9blQa"
Received: from macsyma.thunk.org (pool-173-48-114-3.bstnma.fios.verizon.net [173.48.114.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63MEAONS031823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 10:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1776867027; bh=uXS2L3aNQ1hAH4CjrqlOWJw/+8QHLB05BccYZpF4XYk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=m2F9blQapShFA+/fj61hq4ZvxnPiHqPF4bRsVvVaf9XSNJ5rpolFSC+HaIT0gXWXp
	 hLZjm9wAE8coZ7luv+cfG1fr0kA8K1kILuUDwFtQi8fucfVt264dbuhEIW3wHsA2hy
	 iAyVpmjgZSxHqA72Xkca61KBg0UV5IjIh0NfCQnQukPiy7c9BJDuqT2z00jhpGs20P
	 ydZzcmcsBZimXBFOUbA8uzqrNd/j+JFaeQG2eBbQ8BvgFXudngKoh+SIdLpoSzdGw6
	 xIs0k4CEDYIk25+2xPfKgJIz+JNVsMFiqPLTfvVf5ZVq+tFJ/NpYqKg1D1rPQx7lXr
	 nclBMmvjrArxw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D1B1C648BE1F; Wed, 22 Apr 2026 10:09:23 -0400 (EDT)
Date: Wed, 22 Apr 2026 10:09:23 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <20260422140923.GA11127@macsyma-wired.lan>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
 <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
 <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
 <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr>
 <20260421181026.GG7765@frogsfrogsfrogs>
 <CAOQ4uxhq4J+t+6-qhGOoaZn0Fdh9Q05RkX-CRYm+huJSPUJHjw@mail.gmail.com>
 <20260421201502.GH7765@frogsfrogsfrogs>
 <CAOQ4uxg4S=1jBGusNSHDH20+AHdFucFfWie9wqBU9V=LUWqwUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg4S=1jBGusNSHDH20+AHdFucFfWie9wqBU9V=LUWqwUg@mail.gmail.com>

> > >  - Handle security issues and regression promptly.  Both those reported
> > >    by ordinary users and those reported by test bots and fuzzing tools.
> > >    The filesystem must handle corrupted input gracefully without hanging
> > >    or crashing the kernel.
> >
> > How about
> > "...without corrupting memory, hanging, or crashing the kernel."

I will note that security@kernel.org does not consider maliciously
fuzzed file systems as a security issue.  And a long-standing position
by both ext4 and xfs has been that distributions configuring
automounters to blindly mount USB sticks dropped in the parking lot by
the KGB, MSS, or NSA is a Bad Idea.

I'm a bit nervous about stating this as an expectation, especially
given denial of service attacks on maintainer time with a large number
of random academics which fork syzkaller, and send security reports
that mostly duplicate upstream syzkaller reports and don't support the
web site allowing developers to test syzkaller exports which don't
reproduce locally.

It's certainly an ideal, but I'm not sure it's one we can expect or
guarantee.  It's also certainly not the case on most file systems
in-tree today, to a varying degrees, but outside of the most highly
maintained file systems, if we were to state this, (a) I'd be
concerned that we would be setting expectations that will disappoint
Linux users, or worse, class-action lawyers (well, they would be
rubbing their hands with glee), and (b) if we actually enforced it,
would probably result in 90% of the current in-tree file systems
getting removed.

						- Ted
