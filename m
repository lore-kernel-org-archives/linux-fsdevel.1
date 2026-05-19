Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3B314B6D
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157500; cv=none; b=VzZGHNZioluJB80gA9TFM/RS7HWugU3Vmhjax3/8jbOWkI/8ljqVdEf7ijeHKJ8C+Vb2S/68wogLK816jc7t+HJObnlYwQ7xmLtpzsOt9AWnSQuHqJ5Y3EHvE0TfhPGdt7eRg6HaZDhiQ2aBSCcmzlpv1Lk3FkLQnEMGuiC9Mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157500; c=relaxed/simple;
	bh=cmy1ufkVzZsD9Gqn6B+aIM7IHl6dvtacLg9ArMxyJzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOx/lXhh505O5jM056OPgYm+/+QuU1ymZqv0KqCvEs3xh1yHvdRt+XJ6RWgu4pV2HfWkBQCHND1w9mDL9GZ4wKh8TApA4uNe3lqbMfk+dzznnLSV6s65GTW3B/uSFP/vquNCCNHgKHFiP9i1aWhL+xOmxTt7O1/WsoYxAABDvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QpHACNaJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QpHACNaJ"
Received: from macsyma.thunk.org (pool-173-48-113-30.bstnma.fios.verizon.net [173.48.113.30])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64J2ORCC009257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 22:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779157471; bh=uo72BMdIiWgzcBTlKsAzj6klqmrB2g0RwiE/Y2184RM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=QpHACNaJdPVMLXuWcf7MC+9UsJdZUd4kJrvo4STVKFIWDZh0PGnYa9jOuq7aOTuZx
	 3IFdSAq628BgElE7A4vyYyoi/HBG3hknKitJo0Pf3qscJmwxrQJBae+6TeypRPk2A4
	 ZCy9DfzQZFt0nFkDs0zWStgbp6Yr7dRt42Lq6yQ7CKQHs3gbe/REWTWRe0RnUlUMeU
	 eMe2iZBvmVexIYLvxXZPynHBxAMHA/v++ZAIX7ExlqeJh8Ycj65s4TgrELNWH4qShV
	 SJCu5qXdE9H2DZfnoPx1G72a1WPvijDawlSdIroai+FPkQshVxfTRRu5AUnkw3dyIm
	 hfA/BmIx9HIjw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7AD0C68484D8; Mon, 18 May 2026 22:23:27 -0400 (EDT)
Date: Mon, 18 May 2026 22:23:27 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Cyber_black <Cyberblackk@proton.me>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Mark Fasheh <mark@fasheh.com>, linux-api@vger.kernel.org
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
Message-ID: <20260519022327.GA11894@macsyma-wired.lan>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agqevS--YYBVW2Oz@infradead.org>

On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
> On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
> > Option B) Add a capability check to ioctl_fiemap() to match FIBMAP.
> > This restores the intended restriction, at the cost of breaking
> > unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefrag).
> > This option is a larger ABI impact and likely undesirable.
> > 
> > The preferred fix is Option A, since FIEMAP has been available
> > unprivileged since 2008 with no reported security issues, and read
> > access to physical block layout is already implicitly available
> > through open() permission on the file.
> 
> No, FIEMAP really should not be available unprivileged.  So I think B is
> the right thing.  Can you send a proper patch with a proper signoff?
> 

I disagree.  As I recall, we discussed whether or not FIEMAP needed to
be unprivileged many years ago, and it was a conscious choice not to
require root privs.  I don't believe it is a security issue to allow
users to see the logical -> physical block mappings for inodes.

Users might misuse it, and we did have that issue many years ago when
cp attempted to use FIEMAP in a way way that it wasn't intended to be
used[1].  However, that was over 15 years ago.

[1] https://lwn.net/Articles/429345/

But just because an interface could be misued doesn't mean that we
should restrict it, IMHO.

					- Ted
