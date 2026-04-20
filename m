Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96534DB59
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710067; cv=none; b=jSecs0NpPUVVDF8RTilopGmJNunESgfEdJbmZFjfK9LtNtR5A21afhpOYt9tigi64x2Kq1TKWvJe+NN/nO7G4Bl6XnvoWZgtbwVaCBi5fhClxdGeqL1nqsUZpTUXtzNA4D3nvFVnndBKXKL7gM8ug9EQsz9tmOwhjq8n0UQXzk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710067; c=relaxed/simple;
	bh=ebA0LSvPJGszmXTy36OTMbUkPbfwVT5P/JEKrfuZrs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kks1aqvSRvEBDkjR2GPCQcxDX/41bGKk304kAFKRnzQ5qJ2A3+wkewgWFXzUbIqBpUbsCLCrS8V3a/KgSnlw0/2x2iBEGxwtEjBFnxXpI+UIZkRpvTpdyzQhGNZVXeuCBN3AjSZQ1QEiMLE38ANZ7sazBGB3eSUo5eXMjqCwIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNJ54rAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNJ54rAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11919C19425;
	Mon, 20 Apr 2026 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776710067;
	bh=ebA0LSvPJGszmXTy36OTMbUkPbfwVT5P/JEKrfuZrs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNJ54rAx5NJaSPDjcAvdquEodJ/0oC7keGKucmlKjVb6gqX2QEz/7pbUkq/FsGZ9M
	 e8JGo313egRCykDsQqvn38mTDMabqwUouQ8JflTcDndRpmSPelnmeDW8VM/ojBeFRC
	 0wpYPm013wza1sNElRhXjpKpkTob7fIvYHcnO5E17TeIflw4P8GdEVqiDFGXi6N/wb
	 kfNDTPO62kZR4N7gCSZhVtdl/7d+bwaO23XKoLeDf7uxLdz25ZajOniTOjCkRJG3Kl
	 784xb2WMoDw93HYaXjUuYyZGBc3D5uwmfNxlS+Y/96K+NQksp/Oud9dPp7jWS/X2/f
	 LXwdVUEXAFQ8A==
Date: Mon, 20 Apr 2026 11:34:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <20260420183426.GP7727@frogsfrogsfrogs>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <u2scvjd522tdhb35r7ge2fqclt2qo3y4x5nxwprwcritxir2wj@5u4zhohrv6aw>
 <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>

On Mon, Apr 20, 2026 at 08:14:58PM +0200, Amir Goldstein wrote:
> On Mon, Apr 20, 2026 at 4:37 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 17-04-26 16:25:03, Amir Goldstein wrote:
> > > + - Handle security issues promptly.  Filesystems parse complex on-disk
> > > +   structures from potentially untrusted media and must treat security
> > > +   reports with urgency.
> >
> > I've commented on this in reply to Matthew. I agree syzbot results must be
> > reviewed and identified security issues treated in a timely manner. However
> > dealing with maliciously corrupted on-disk data isn't (IMO) a serious
> > attack vector. Even current well maintained filesystems (e.g. ext4 and
> > others) have some issues in this area so it seems unfair to ask this from a
> > new filesystem.
> >
> 
> This is what I posted in v2:
> 
>  - Handle security issues promptly.  Filesystems parse complex on-disk
>    structures from potentially untrusted media and must treat security
>    reports with urgency.  Expect the filesystem to be subjected to fuzzing
>    of both syscalls and filesystem images.  The filesystem must handle
>    corrupted input gracefully without hanging or crashing the kernel.
> 
> Are you saying that ext4 and others do not react to crash reports from
> image fuzzing which result in crash/hang?

I think it's more that nearly every filesystem has severe resource
constraints w.r.t. developer time, so reports from automated fuzzers are
assigned idle priority.

> Can you suggest a more relaxed clause or should I remove it altogether?

I think that what you've got there is a good expectation.  Each
filesystem implementation should have a mechanism to handle corruptions
with grace, and (presumably) new fuzz reports will result in patches
that use that graceful mechanism, whatever it is.

Anyone who wants specific response times to fuzzer reports can enter a
contract with a company or hire any of the many recently laid off
kernel people (or AISLOPFAFO) to provide SLA-like support.

--D
