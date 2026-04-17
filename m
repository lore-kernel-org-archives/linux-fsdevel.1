Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03165372EED;
	Fri, 17 Apr 2026 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419335; cv=none; b=atf81vILsOW863b1AwlZeObXabqRJdeDmdk4xdMzVxk555bsTfJqUSGuPRX53t42F8UNEJJK+Knq0tn7eKng1NjnTv5/PmfGRZhufHdRpdBumkElxX6rb2e+fQ3A8H8YAYqsUPQfE7RHm1MjfyIL1XE5D8R5xbl9TK2k7zKLSFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419335; c=relaxed/simple;
	bh=9F0BRnvxc+jJ5hlIqJG45SlclSG49XGo/QgxY6f+UIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHBHpzZ1nn1zkGmtW65vUyu2/oHNepYqSyPxEcRUuiJ8xg0TL02dPJvE3Xx42NVj3Vf0cCrJ0PM6nYC+e18Fk08EyABiDWNaPoB68n5ig4yMWpVoz/uV+JPUDVwGS4z/4aW+Wo73dJ9DXZ4hbB5Y3n+r+FC/cu2iMLi1GwbVgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBC9UT/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBC9UT/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E56C19425;
	Fri, 17 Apr 2026 09:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776419334;
	bh=9F0BRnvxc+jJ5hlIqJG45SlclSG49XGo/QgxY6f+UIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBC9UT/QaDmIIMx/mxkNAbtgLdfkWVOdzDZJw2KI8JMlKQWjjIFfmedpjFx0lOHaC
	 vVBbCbCdpExMD3W3NKOY9VlfOO4bMCAY+ONjxr6UXVol5Tmnn9W5pPo7ZKpKyzo7HA
	 noIAgv1Dz3UikCt+60Lf74qDJwSGDXbXEB8Eploe1B9a9srlCHaoJj7520zoSjMiry
	 sQfar/VT2G+Tml9+KOJTLakz0oTndhVgNDgWMaO+ocLbV4G/ZmqwcyjqRfjFHgtVU9
	 M68HgjkVdEcMKR7BJ4biQdPKK8MUqWACFIlT+kYil1Xr9lVCC1E6THWYI/jKWaQhxm
	 OWmx39WtyLSbQ==
Date: Fri, 17 Apr 2026 11:48:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-m68k <linux-m68k@vger.kernel.org>, 
	linux-sh <linux-sh@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
Message-ID: <20260417-anmeldung-vorbehalt-858250959b84@brauner>
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
 <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>

On Wed, Apr 15, 2026 at 11:11:32AM +0200, John Paul Adrian Glaubitz wrote:
> Hello,
> 
> On Wed, 2026-02-18 at 10:36 -0500, Jeff Layton wrote:
> > For historical reasons, the inode->i_ino field is an unsigned long.
> > Because it's only 32 bits on 32-bit CPUs, this has caused a lot of fs-
> > specific hacks on filesystems that have native 64-bit inode numbers
> > when running a 32-bit arch.
> > 
> > It would be a lot simpler if we just converted i_ino to be 64-bits and
> > dealt with the conversion at the kernel's edges. This would be a non-
> > event for the most part on 64-bit arches since unsigned long is already
> > 64 bits there.
> > 
> > The kernel itself doesn't deal much with i_ino, so the internal changes
> > look fairly straightforward. The bulk of the patches will be to format
> > strings and to tracepoints.
> > 
> > I think that the biggest problem will be that this will grow struct
> > inode on 32-bit arches by at least 4 bytes. That may have cacheline
> > alignment and slab sizing implications. We're actively talking about
> > deprecating 32-bit arches in the future however, so maybe we can
> > rationalize that away.
> > 
> > FWIW, I had Claude spin up a plan to do this (attached). It's not bad.
> > I'm tempted to tell it generate patches for this, since this is mostly
> > a mechanical change, but I'm curious whether anyone else might have
> > reasons that we shouldn't go ahead and do it.
> 
> So, this went just over Phoronix [1] and as someone who is still invested
> in 32-bit architectures, I'm only notified about the performance impact on
> these systems now as the pull request has already been sent to Linus.
> 
> I'm frustrated by this poor communication style. If your change affects certain
> users negatively, it should be openly communicated to them on the appropriate
> mailing lists so that they at least get to raise concerns. Disclosing these
> news to a limited set of mailing lists only is not okay.

* You're linking to a Phoronix article as prove that there's a
  performance impact.

* You're complaining that you haven't been Cced even though you
  seemingly maintain mutliple filesystems that have their ML set to
  fsdevel.

* You're trying to mandate what very valuable internal VFS changes we
  get to make based on 32-bit concerns.

I don't see a single coherent argument in this list worth engaging with
- especially with that lamenting tone.

Suggestions for next time:

"I just read this article on Phoronix that mentions a potential
performance impact on 32-bit systems. Is that valid or do you think this
is going to not be an issue?"

I get that you care about 32-bit and legacy hardware a lot. But upstream
Linux has clarified multiple times that we don't jump through any extra
hoops for 32-bit anymore. This is especially true if the claimed perf
regressions so far are purely theoretical.

I don't think there's anything actionable for us here at all. Thanks
again, @Jeff for doing this work we've been talking about for multiple
years. It was about time.
