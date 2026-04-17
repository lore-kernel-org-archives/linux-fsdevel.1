Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4F37C109;
	Fri, 17 Apr 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415095; cv=none; b=nDkulQ43dEw6UFjyqCrscLpCHmVmKtqh1KrsJMnzgrpSqKypL2zYJKYlbjBU9bxjQfqLhNK/04qW74yo7adHi9sUdSp/oTod2YqCXNszyb8clKjnqAac4E5FWofpxxFrDnA4inaf1aZJeEGJ6uNtHEqSrkC8W2vaLItx34A1nIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415095; c=relaxed/simple;
	bh=Byuc10OFJu8O2tqDUNfckOXNJnppoxR0FD/taaXxTkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nIDkqpJZmeWldRmv5oxUSWaWbmVsaBGhNkF3Lfhgef68VtZtuIbkfW0mCRrGmvOCle1qidKStrYSBak5oc7mMrhbc1HJ5HtjMSMjEQerHfwnOMfjQPrsYFA1nUWclCP/AXP7nxVIsh1mWAOVNsfYetz086wskYpjs0DHPFu2rCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=bYDJqKkr; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="bYDJqKkr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pHk/jLQMGHz7fnqdKlFUiKmCBiHe34nyuDOwOZa7yL0=; t=1776415090;
	x=1777019890; b=bYDJqKkrCUNiOH85Ns/lsx4cmW89DUoY+lS1h6B/VcB2+2gqH9va+Tll2V9T0
	pkSTn2weR7VKRZ6onHkcDg0eK1K1alNcfYpNmeuaXNdGX1uKQerjyNNlUkj4KAFFwTcnlqB9M53u5
	KaQqcPCEht04JwXUMOfu17k70mT9eB96Dl/zxkfEmm0pAq4gEXVrlBWgvihE9yyT88t2U3HHUxKYx
	m+FtvHF5KPXhXhyWjg4MTIr6F3mlcQen9NC5taSUgdjNojmcF/Qt1XnjNDeGrlrAYqpWtnBkAF04k
	k9NibWB3WXN51QzJkeyZm/f/6FPvzyRTwkX86L1YV202igjtoQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wDef4-00000000Pbh-3o7V; Fri, 17 Apr 2026 10:34:50 +0200
Received: from dynamic-002-245-058-104.2.245.pool.telefonica.de ([2.245.58.104] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wDef4-00000004BcF-2tHX; Fri, 17 Apr 2026 10:34:50 +0200
Message-ID: <54b7990fc554ef446b094bf37b785d91ea68b075.camel@physik.fu-berlin.de>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Christoph Hellwig	 <hch@lst.de>, Jan Kara <jack@suse.cz>, Al Viro
 <viro@zeniv.linux.org.uk>,  linux-m68k <linux-m68k@vger.kernel.org>,
 linux-sh <linux-sh@vger.kernel.org>
Date: Fri, 17 Apr 2026 10:34:49 +0200
In-Reply-To: <9d8eda244e79b3b1c43c45277f225b130e88fa70.camel@kernel.org>
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
		 <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>
	 <9d8eda244e79b3b1c43c45277f225b130e88fa70.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2026-04-15 at 06:44 -0700, Jeff Layton wrote:
> You're pointing me at Phoronix and complaining about clear
> communication? That headline is made to generate clicks. It doesn't
> represent the reality.

Well, your own justification was that 32-bit architectures will be killed
anyway in the future, so it's okay if they are affected by a negative
impact:

> > I think that the biggest problem will be that this will grow struct
> > inode on 32-bit arches by at least 4 bytes. That may have cacheline
> > alignment and slab sizing implications. We're actively talking about
> > deprecating 32-bit arches in the future however, so maybe we can
> > rationalize that away.

> The mention of potential performance impact on 32 bit hosts is entirely
> speculative and not likely to be measurable anywhere. I only mentioned
> it at all in the interest of full disclosure.

It didn't sound like that when you argued it won't be problem because they'=
re
going way. If you think it's not going to be a real impact, why even bring
up the argument that it will only affect targets that "we" want to get rid =
of?

> We're widening the i_ino field from 32 to 64 bits on 32-bit hosts. This
> means that we're adding 4 more bytes to every inode there. Sounds bad
> right?=20

That's not the point here though. Please re-read your own argument.

Phoronix's headline might be somewhat clickbait, but it's not a complete
misrepresentation of what you wrote.

> The reality is more complicated...
>=20
> struct inode is (almost) always embedded in another structure that
> contains the fs-specific fields for it. Many of those (nfs, xfs, etc.)
> have had to carry a separate 64 bit field to hold the "real" inode
> number since we couldn't count on i_ino being big enough on 32-bit
> arches.
>=20
> Those fields can now go away, and once they do, that will represent a
> 4-byte _reduction_ in size of the inode on those filesystems. So there
> are potential upsides here for 32-bit arches as well.

Then why not mention this? Why communicate a message that seems to imply
that performance will be degraded on 32-bit targets?

> The bottom line is that we add and remove fields in struct inode all
> the time. It grows and shrinks as we do this. This change will almost
> certainly not be measurable anywhere.

I'm not arguing against that. All that I am saying that I am not happy when
a change is communicated within a small audience with the assumption that
no one will care. I mean, if you don't notify the audience that might be
affected by the change, it's a self-fulfilling prophecy that you won't hear
from them.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
