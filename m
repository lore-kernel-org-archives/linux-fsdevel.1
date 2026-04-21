Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C34288D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795027; cv=none; b=eD5eChdj1JTqo+axrZPsjEdD6JnkazcPASyV+PHGWVzNfZT420RPQOuqeS7My4+Yfp7a4pW4VFHo9gSrd1Axwk5FoCfW8xvSSmXEZpCH8Zc7pD7ahTpN9glInM8vinCkPfZ/nps5lAu3BDwYGbDAXs+ztYeOU4zANZul79epCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795027; c=relaxed/simple;
	bh=dX0yFQetRJ3yUps6w+GnTclOBxQv+wlcHdc4n57Uzec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNjO2tAc9PX0TssAiNob6+cpT2vZGNKWDI+mIeAJwtG7UyKF9RVeayY+LHMn9zxTe0KQHmPHM/Gw+rTSvP8FQmw1jYPDKgmQ2k9YLD3ajNla6ArKT8O/oG80Qr1N4aakfeU1zDDQ5La89eoao44YTGHc6zJ8BPNdqFGBxcYBjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZC7NGdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZC7NGdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3AFC2BCB0;
	Tue, 21 Apr 2026 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776795027;
	bh=dX0yFQetRJ3yUps6w+GnTclOBxQv+wlcHdc4n57Uzec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZC7NGdqn8xBVpDknBI/jgoLxrqGQNnYhjpli3KusZqwwEZs/cpAR7Lt7+0iOrT8v
	 jxbUlIKxZp+Knign8IcuKxg1ShxJTS0YJnlbm/ZHUbtvGWn+bKUsgVkk8HgaMbz2O9
	 NpwZFsJ7hcDXiZQjrIPnnXzCjScfj/DqWW5s7Ant5moT805w0oLNqA8wV1yeZtuWAj
	 YaniWfco9b+7ywheI0llpeNhBDWA4dm//dDxC6Lx14xAKZwQph5fInSsTXEE1t3Z0Y
	 4QI64oBkAHYzmL1CBOz6TFJOL+iizD0ZATa8l9gp/S9HGu8uamWxoigssqfsdfPeL6
	 xQYu5duQofArg==
Date: Tue, 21 Apr 2026 11:10:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <20260421181026.GG7765@frogsfrogsfrogs>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
 <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
 <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
 <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr>

On Tue, Apr 21, 2026 at 02:08:13PM +0200, Jan Kara wrote:
> On Tue 21-04-26 13:17:34, Amir Goldstein wrote:
> > On Tue, Apr 21, 2026 at 12:16 PM Jan Kara <jack@suse.cz> wrote:
> > > I definitely want to keep a clause like this. Maybe I'd just reformulate it
> > > like:
> > >
> > >   - Handle security issues promptly.  Both those reported by ordinary users
> > >     as well as those reported by fuzzing tools. Expect that your filesystem
> > >     will be subject to syscall fuzzing as well as filesystem image fuzzing.
> > >     Dealing with maliciously corrupted filesystem images is not generally
> > >     considered a high severity security issue but still it is considered a
> > >     quality-of-implementation issue that should be fixed.
> > >
> > 
> > I can take this version, but tbh feels like debating this clause misses
> > the main goal of the doc, so I'd rather go with something a lot shorter:
> > 
> > - Handle security issues and regression promptly.  Both those reported
> >   by ordinary users as well as those reported by test bots.
> > 
> > IMO, getting into more details doesn't really add much value to the
> > prospect reader of the doc before submitting a new filesystem nor to
> > the filesystem reviewer.
> 
> Agreed. Your shorter version conveys the idea and the details aren't that
> useful. So the short version is fine.

I still want

"The filesystem must handle corrupted input gracefully without hanging
or crashing the kernel."

to be part of this.  Not screwing over a running system is important,
The guidelines ought to make that explicit.

--D

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
