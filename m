Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01198304972
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802504; cv=none; b=PBM25giSTUu1+zMsUaW6eId6CjRolA45FKWl51fIySyechG9ddz4z27msFwj8SrD2dWazdys92jr+F99teIp3V5ebzZGVuJ/PMmJdv8yaf3O52uT+oJI51dRLXKKuThwpwibrMtYj6n00FID/G/yJ3QQIrazs1N7bgRjIln71Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802504; c=relaxed/simple;
	bh=i4GrSkNV0+GlSKOYb2ufgHE/8hL/vL5arRP815PCWDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhUtIL6gjZEmdrRP03MGU2tH97ooABY8QEib82MT5Yh5sXz/OjdT1OYhCMfq6jXNj8XeO17dIPWJkYWQyrnsf+ENZnmNSrIrM2rDGU+Wdde94BaWzWNEpZusx/61SX3zg0GO2ZQuCNHH1pzDYJtAD3db0dcqEC3Z4kdevE47r+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9uB+LGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9uB+LGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766FBC2BCB0;
	Tue, 21 Apr 2026 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776802503;
	bh=i4GrSkNV0+GlSKOYb2ufgHE/8hL/vL5arRP815PCWDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9uB+LGor+EG09tC+dASoBmmQaJCOjP/CeUOnIr06gLvR+BnKHuTEuohoFeenWdVI
	 Tujkf/OwjQnE3Dy/P0GkwCWk+GZlx7hByEafn/ZzcyyTrRKJAMszKlpLnbrPDDNxIf
	 4UWUJe39kh0Ni7Io4d4IcaFTjoMN1E5xpv+L5xdVEcuaVXcGk42eF3RgAboKY+PV1u
	 F3acSCiWjtth4+iUy3NdQB03iOA72AbwRUMpiUxV+3qz3BbP1NaRhDU9eI7d7U+U8U
	 HuDq2nTrnoTQ4rX+iwHKZHB6xxCyVpccWerR65JC/DJG2yN6WanS2cFmTN3tFYWFP6
	 ah1KavWz3Gflg==
Date: Tue, 21 Apr 2026 13:15:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <20260421201502.GH7765@frogsfrogsfrogs>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
 <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
 <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
 <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr>
 <20260421181026.GG7765@frogsfrogsfrogs>
 <CAOQ4uxhq4J+t+6-qhGOoaZn0Fdh9Q05RkX-CRYm+huJSPUJHjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhq4J+t+6-qhGOoaZn0Fdh9Q05RkX-CRYm+huJSPUJHjw@mail.gmail.com>

On Tue, Apr 21, 2026 at 09:42:23PM +0200, Amir Goldstein wrote:
> On Tue, Apr 21, 2026 at 8:10 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Apr 21, 2026 at 02:08:13PM +0200, Jan Kara wrote:
> > > On Tue 21-04-26 13:17:34, Amir Goldstein wrote:
> > > > On Tue, Apr 21, 2026 at 12:16 PM Jan Kara <jack@suse.cz> wrote:
> > > > > I definitely want to keep a clause like this. Maybe I'd just reformulate it
> > > > > like:
> > > > >
> > > > >   - Handle security issues promptly.  Both those reported by ordinary users
> > > > >     as well as those reported by fuzzing tools. Expect that your filesystem
> > > > >     will be subject to syscall fuzzing as well as filesystem image fuzzing.
> > > > >     Dealing with maliciously corrupted filesystem images is not generally
> > > > >     considered a high severity security issue but still it is considered a
> > > > >     quality-of-implementation issue that should be fixed.
> > > > >
> > > >
> > > > I can take this version, but tbh feels like debating this clause misses
> > > > the main goal of the doc, so I'd rather go with something a lot shorter:
> > > >
> > > > - Handle security issues and regression promptly.  Both those reported
> > > >   by ordinary users as well as those reported by test bots.
> > > >
> > > > IMO, getting into more details doesn't really add much value to the
> > > > prospect reader of the doc before submitting a new filesystem nor to
> > > > the filesystem reviewer.
> > >
> > > Agreed. Your shorter version conveys the idea and the details aren't that
> > > useful. So the short version is fine.
> >
> > I still want
> >
> > "The filesystem must handle corrupted input gracefully without hanging
> > or crashing the kernel."
> >
> > to be part of this.  Not screwing over a running system is important,
> > The guidelines ought to make that explicit.
> 
> Agree.
> 
>  - Handle security issues and regression promptly.  Both those reported
>    by ordinary users and those reported by test bots and fuzzing tools.
>    The filesystem must handle corrupted input gracefully without hanging
>    or crashing the kernel.

How about
"...without corrupting memory, hanging, or crashing the kernel."

--D

> 
> Thanks,
> Amir.
