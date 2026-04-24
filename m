Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED813BE644
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031933; cv=none; b=gzHa4qXTNLFFiOLrs+/i+Mhrn1188lFcnS3LbLwqOvWs2Px5rH9+tBiJtR3ZzoIDRNWIwyPdAPL/W5Xb9exoUM/TNOMhsuWYwbHjWjucHLdyCanXHA7LfV1zmWfkza7j2+ds3P188slByZQ5gT7tjibP/6prbz6ahE9PCaHqnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031933; c=relaxed/simple;
	bh=cwXw/hk7xxL51Y+Zsrzjz0CLFN9hpTQm4SQyyAX0yCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5u1mnK6zw4uPWSX+0oyEGxECrdN2IF7zp7M7AhdpfzDXU/WGFALG+mi5d1uzks8h91QuAjGoZFwC+yWKyHYJLEgRod9S5MovrGVl2fJoR0Z8wmvKFysefp59tfsqTQtl3Vm09KxIh/E+Oi6Ty0lsDdVZ1GLTMCMdVvBVFLNcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mKdNEitJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mKdNEitJ"
Received: from macsyma.thunk.org (pool-173-48-114-3.bstnma.fios.verizon.net [173.48.114.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63OBwFh3025426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 07:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1777031898; bh=7Do7ZOMPRUWDQKzANcmTBnWE/rKlX816lGdx5pwJjw4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mKdNEitJOMuylAGTjSYqUb5sJ/1wAK74lkSwm0FClBm52cDqN57RuGxYNZ94a/xm6
	 5NimJpUyuPimpLJdxGDhK5PkNx/Gw0J6qQrgZ7D4UPbS5/BC9BIwcKNCg5ixF4TcZL
	 LYFQM8fmhsKwLspPnYXBEKV31v56kB28uSPLYbsUhpqbCZCGXyw/hbVov/vVF5XOkU
	 naqFmltjK+BWmfXpt1FO5BNN7ohRz87YcsBrgoVCOnq6phQm6vHModmHGkdgd6C3nJ
	 /V/1gdgoFgFPruJ5Y5ViW3Pk8+9ud5esBHMOJ5FxpFtvUc8VioDHaqNPYMb3dnCcyg
	 UtSjdJkUdyMNw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 3642064E1102; Fri, 24 Apr 2026 07:57:15 -0400 (EDT)
Date: Fri, 24 Apr 2026 07:57:15 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: =?iso-8859-1?Q?Kolbj=F8rn?= Barmen <linux-m68k@kolla.no>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
Message-ID: <20260424115715.GC11127@macsyma-wired.lan>
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
 <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>
 <20260415144722.GB74178@macsyma-wired.lan>
 <f48c40f6-ae26-d16b-5332-554042cd85fa@kolla.no>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f48c40f6-ae26-d16b-5332-554042cd85fa@kolla.no>

On Fri, Apr 24, 2026 at 08:38:56AM +0200, Kolbjørn Barmen wrote:
> 
> This tells me that it is time for "the 32-bit community" (wtf) to either
> look elsewhere, or start thinking of forking the Linux kernel perhaps
> sooner rather than later, so we don't bother "the 64-bit community" so
> much.

My point was that having people whine about a decision isn't a
particularly productive way to engage with the kernel development
community.  Especiually when the person who was complaining was the
HFS maintainer, and the mailing list that he *should* have been paying
attention to was linux-fsdevel, since it's marked as the primary list
where HFS bugs and development issues should be discussed, and
linux-fsdevel was one of the mailing lists where the 64-bit inode
proposal was cc'ed --- maybe that says something about how engaged he
*really* was with Linux Kernel development.

But hey, it's open source.  Forking is always allowed.  My guess is
that a fork would involve a stagnating code base that won't be to keep
up with bug fixes, including security bugs.  This is especially if
most people working on 32-bit architectures are as engaged as the OP.
Most forked projects don't end up working well, but everyone has the
right to find that out for themselves.

Cheers,

						- Ted
