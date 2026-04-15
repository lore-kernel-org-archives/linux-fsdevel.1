Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7ADF507;
	Wed, 15 Apr 2026 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244305; cv=none; b=euSKONmm1I2DvD4NWBPBgggVrjIZ3gtao8PZs/XAdLjGXmV+ogq1U6KtGh9RHE4kqoGaOXtApa2YrKO/ZgXioIr5fcWXZQD91GrwB4gbBAOhkaJsIkbS0iXSWZwE8nV1hTttKvqeB3xEpEIvd3chyd4cP9lkSRLi+haG5O+jhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244305; c=relaxed/simple;
	bh=FM60Cc+RMZ1Ci/6xQYKWbpb2loHJQJNwtImo2YQmoPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHONyK0Fcen/m0UQzh0JTL99VADe4FaNGgP8g+1ebax8KDa8fYJP/Mbjs3prXmy3TGxGjv6Mad9QiC27XufKUaURROaUxAGCjV+Y/1WEXbk+bi1lwk/dEhPo0Jd1XxZPEszUmkfjH8foM538Mh98TeV8QvPETn2ivfCeGFP3AiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=V31O2XYd; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="V31O2XYd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=RR4jDF3OH1EBcbm0Ei4yVB1tLADjBhkBAZR0bHEtox8=; t=1776244301;
	x=1776849101; b=V31O2XYd4i53HPPl0K1aYOdY/ycTM5msUoGo7W7R5Xgysorn8qnyYJs8P+Yne
	JnKwXWphAg1vi4jEWjMAUjSOkv3SNi39Ehj4233o9HQDHvfytMhyZlVSUOEJzWi0doyKcQ1TxLCJr
	gT1D/4d4vqK5UNdgqT7lZEKFZ+HMD/jAWE3bia/G9EVrgtwxatOKXYNP8G93lM8v7V5oR/Myql9We
	e5eoHA+xIoiwCjJfx0j7b0zQpKZhntzRPuxFNosq2h8/05oruQWQMvjjSgRZmgm+39B3iRpuiTQZn
	1L9QLvgxtYEjl8L9dlg8kCMHVfNDD3BjQUAh44VDLeHllh+3lA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wCwHV-00000002Ugp-239B; Wed, 15 Apr 2026 11:11:33 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wCwHV-000000020Eo-11eI; Wed, 15 Apr 2026 11:11:33 +0200
Message-ID: <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Christoph Hellwig	 <hch@lst.de>, Jan Kara <jack@suse.cz>, Al Viro
 <viro@zeniv.linux.org.uk>,  linux-m68k <linux-m68k@vger.kernel.org>,
 linux-sh <linux-sh@vger.kernel.org>
Date: Wed, 15 Apr 2026 11:11:32 +0200
In-Reply-To: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
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

Hello,

On Wed, 2026-02-18 at 10:36 -0500, Jeff Layton wrote:
> For historical reasons, the inode->i_ino field is an unsigned long.
> Because it's only 32 bits on 32-bit CPUs, this has caused a lot of fs-
> specific hacks on filesystems that have native 64-bit inode numbers
> when running a 32-bit arch.
>=20
> It would be a lot simpler if we just converted i_ino to be 64-bits and
> dealt with the conversion at the kernel's edges. This would be a non-
> event for the most part on 64-bit arches since unsigned long is already
> 64 bits there.
>=20
> The kernel itself doesn't deal much with i_ino, so the internal changes
> look fairly straightforward. The bulk of the patches will be to format
> strings and to tracepoints.
>=20
> I think that the biggest problem will be that this will grow struct
> inode on 32-bit arches by at least 4 bytes. That may have cacheline
> alignment and slab sizing implications. We're actively talking about
> deprecating 32-bit arches in the future however, so maybe we can
> rationalize that away.
>=20
> FWIW, I had Claude spin up a plan to do this (attached). It's not bad.
> I'm tempted to tell it generate patches for this, since this is mostly
> a mechanical change, but I'm curious whether anyone else might have
> reasons that we shouldn't go ahead and do it.

So, this went just over Phoronix [1] and as someone who is still invested
in 32-bit architectures, I'm only notified about the performance impact on
these systems now as the pull request has already been sent to Linus.

I'm frustrated by this poor communication style. If your change affects cer=
tain
users negatively, it should be openly communicated to them on the appropria=
te
mailing lists so that they at least get to raise concerns. Disclosing these
news to a limited set of mailing lists only is not okay.

Thanks,
Adrian

> [1] https://www.phoronix.com/news/Linux-7.1-VFS-Kino-32-bit

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
