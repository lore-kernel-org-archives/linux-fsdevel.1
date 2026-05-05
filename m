Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326027380A;
	Tue,  5 May 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004475; cv=none; b=QuDNX6S0BmSCbHye9vrw4ujNqRa2orq+udvEbLuoP323OTUDMsqJFBcPw1wUtyy2lTuXQ0k3M6KJQGPlmiJz/ptbwpKWCOiE+lSEwVfnfUo18knT/6W2migu69d1BzSO5dQ1WIAOSfiidRvPaqoe6HD2B0p9UUTNpzHz3NlTKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004475; c=relaxed/simple;
	bh=nTW1FFOU6HDlagnPSEMnDHIHx1gyT83bIkb9h2/EE3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT2NlCIZv+haW2W6tnG0H2ui+syolfn+Shi2U5e01GphECa1Ljac1WUnr4Jj2OJVVa5n1fMoLKobmwiBmSlLr2Qf8+fYztqO/f73Yp1uO81ILldNZ0YLNmhlEv/8Kof0wi/LjIg4lQz1+fJZOjur91XgLDNYvXMZ7jY10D9W6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS4bWKYE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS4bWKYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339F7C2BCB4;
	Tue,  5 May 2026 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778004475;
	bh=nTW1FFOU6HDlagnPSEMnDHIHx1gyT83bIkb9h2/EE3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qS4bWKYEFtWomcLI+M3EN4b8P1d8Rb2lWL1eUOs2U+b0Ic2tJ3GcgQ35/76J4WtLt
	 /AbW5otCJiT2gLNx1APWjeDpFg4EL/iVVn9gFNS2zCSiskQrLSmGjAbs/fZfl9LNTf
	 NMxdEFxveI/h8Z4I+/EtTcOiswZitpbXTAyU1oYAqC2rWNlMSiF2mYkpTowK0MjAyI
	 52YYcKJK15zdg3TrdAu3BmITKYKvIwA9rfbHh8GIPSt7CCiPZqJZCaVNTOSnj9bUTK
	 5tSje0HTEdyOI35vylIfvlpi5L3kIpn51IjJbSi314TdHQUTue2bIXATW61gIvdUFs
	 /pKej4TCRkUWQ==
Date: Tue, 5 May 2026 20:07:50 +0200
From: Andrey Albershteyn <aalbersh@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Colin Walters <walters@verbum.org>, 
	Christoph Hellwig <hch@infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	fsverity@lists.linux.dev
Subject: Re: overlayfs: verity validation broken since f77f281b6118
Message-ID: <lna7qosffjeymh553wfgew6txfhzb567xqfki7cvq5n6lfsrgg@tkb6wvmyvie6>
References: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>
 <20260501180725.GB2260@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501180725.GB2260@sol>

On 2026-05-01 11:07:25, Eric Biggers wrote:
> [+Cc fsverity@lists.linux.dev]
> 
> On Fri, May 01, 2026 at 01:14:54PM -0400, Colin Walters wrote:
> > Hi Christoph & Eric,
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f77f281b6118 broke composefs's usage of overlayfs verity=require, this was reported originally in https://github.com/bootc-dev/bootc/issues/2174
> > 
> > There's some output from an agent run I had in the <details> there, but here's an xfstests patch that passes on without that commit and fails with it.
> > 
> > From 14231122bfd1e41337e4fb847acbbe038457c32a Mon Sep 17 00:00:00 2001
> > From: Colin Walters <walters@verbum.org>
> > Date: Fri, 1 May 2026 09:45:58 -0400
> > Subject: [PATCH] overlay/118: test fsverity lazy load through metacopy overlay
> > 
> > Reproduces the regression reported at:
> > https://github.com/bootc-dev/bootc/issues/2174
> > 
> > A recent change in how fsverity state was cached in memory
> > I think caused inodes not in cache to appear to have
> > missing verity=require for overlayfs.
> > 
> > This test catches that.
> > 
> > Generated-by: OpenCode (Claude Sonnet 4.5)
> > Signed-off-by: Colin Walters <walters@verbum.org>
> 
> Sorry about that.  I guess it's because the semantics of
> fsverity_active() changed to be basically the same as IS_VERITY(), and
> that broke ovl_ensure_verity_loaded() which does
> '!fsverity_active(inode) && IS_VERITY(inode)'.  I guess now it should
> do: IS_VERITY(inode) && fsverity_get_info(inode) == NULL.
> 
> - Eric
> 

I guess this could be also fixed by patch 2 and 3 from my XFS
fsverity support [1]

1: https://lore.kernel.org/fsverity/20260428083332.768693-1-aalbersh@kernel.org/T/#t

-- 
- Andrey
