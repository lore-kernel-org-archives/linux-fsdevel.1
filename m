Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2728B7DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784004611; cv=none; b=DnhAFjwl0L5b9AbFx0HTUBT+AQ6qvY1M8loElpaMELkHRiBPXyRqzAs8zpn7SXpBCJbup4+NOmnlNgE6bQdVM3v7r0tGny8qtK2nu75PPCb6z6iIWg2gVf69Vd5gTzuM16x2wkqhMhE2MfTusFxWkGyxxC/QsaksOlAa8lyK5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784004611; c=relaxed/simple;
	bh=QyEC7dr/Adrstbxig7bYw4tNjhCaAYr6QcLSk7Upklw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyXfyFxl9DBhLBo1S2awoAWiAwSHmM0mDVX/3Z+Aux8iUoNGWHuNJaIIdz9i8QUIFXP0uODc0QfWbttr2IF9SAx/5mF0JA/AlZN8G3S80iiWa5ZvioobiptZCoe+KaCMmKxIa45cfzAAQHXJcsgGoqqDznGoXgYR0dYiIf6cMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GwuUeZJT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GwuUeZJT"
Received: from macsyma.thunk.org ([151.240.45.25])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66E4nxkh004905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 00:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1784004602; bh=Zuhdq7fmKsTxvc6x7VbX1GqB9gdUJzvGWsaU5wDLXrw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GwuUeZJT6HeR3VVBnhJ+4T+RCIf5WnCLVKlXDnqEccBh8TJzgbDrYZuJ6E7jmGBhN
	 Db5RYv7jBn2HJXov1R9KMm3XWReDhVmOLDaSa6wtAv7b5lsnt60rLsBRp/16DOUZ0X
	 E+b+tGaO2O0zPkTkm0ayLtMNPcoFNuSDvPj/EqZ77XpTPekd4HviWPq3FfrSBFdBv/
	 HLsH75z/TlKUDOk4bCG+YtchjFH0p4kezjeX49UnuWX6iqMCtfLWI/vEuvMqwjTvhZ
	 9WcihLtbn7P4L66zy1em1HX1msDjWdZB6m12u201hLljJ6DUBZbn1pEiSlUivOMoHG
	 yAo4k2M3JpwPA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 66581A05C4F; Tue, 14 Jul 2026 00:49:59 -0400 (EDT)
Date: Tue, 14 Jul 2026 00:49:59 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Timothy Day <timday@thelustrecollective.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Marco Elver <elver@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] ext2: fix ext2_xattr_delete_inode() context
 analysis warning
Message-ID: <alW-Sr3TuNiZNK6H@mit.edu>
References: <20260712165610.366474-1-timday@thelustrecollective.com>
 <20260712165610.366474-2-timday@thelustrecollective.com>
 <alT2yHlfzhTZ9n4T@mit.edu>
 <20260713164417.350710-1-timday@thelustrecollective.com>
 <alWJFP2k7bR8REK2@mit.edu>
 <20260714041724.3186239-1-timday@thelustrecollective.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714041724.3186239-1-timday@thelustrecollective.com>

On Tue, Jul 14, 2026 at 12:17:24AM -0500, Timothy Day wrote:
> It's mostly convenience, I think. If the context analysis could be
> made to work without any runtime penalty, then you don't need a
> separate debug build.

That's a fair.  I don't mind doing two back-to-back compiles passes,
one with and one without context analysis enabled, but that's because
I have a fairly high end development machine.  I can see tht people
might avoid using context analysis if it slowed down their build times
too much, or if you had to explicitly enable it.  As a maintainer who
is used to periodically running lockdep and KASAN builds against
dozens of hours of VM time worth of regression testing, sharded across
many different VM's, an extra compile-only build is in the noise.  But
I'm probably an outlier.  :-)

					- Ted
