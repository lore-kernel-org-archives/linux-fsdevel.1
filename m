Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1523BB48
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776550739; cv=none; b=N2uE0atb53lXsqbqDWnRbwcauL1bWcKsvhw+SvmPdNbbWOI5lx4zHRk42+3VzJMH7vWUOXq0m+qrlXIsMIsihkrF19E43VOG/PJtPKAX78wIKEm8XQirOTztSEhT+Q3HDAssud4fgRWLaA0bQ3CuQsnjeMaAKNqhAjyfeLRikcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776550739; c=relaxed/simple;
	bh=GY9s5G+l2f1sZVgIL40eKhrxCPHTgtR02kS600LK4f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf48nAAW4/bHtp1+NoLrFsIIp8Ext8LmO0jyN+Ci/gj8aHAAHx7rgxmKgYbGXKs5b2mz0JH0RK9o8tuRicbBl/kwhjhQ7Jr2/F/g4QMclsL0Msb6PkjmMHqIXcAoJKXuC8CPTn7MhsjzOFRTiXFtrTKa77UmAQ0wNKPzs0dk1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0tl8o43; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0tl8o43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D923C2BCB7;
	Sat, 18 Apr 2026 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776550738;
	bh=GY9s5G+l2f1sZVgIL40eKhrxCPHTgtR02kS600LK4f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0tl8o43MDiC1s6ySDM43KN7Z6NR9+dSzPwAXEBN60XK8D350YPKotHln+Y35t7Nv
	 LXj7mqn9eB9aSrwKYPltnwiDocN93kJJ1OYidpRrnlxvr55GdASVdJE8ootxNPUb7A
	 yGKiuxsaCLIZvmnrwyzJSnswpzZeVlRrbqDUSFmiJt/qBqsLLZ/En2Rfg8wHU2GlVC
	 WFxPVRUrBn2HCGtJynQRs6Hk2crQ74hRFc4UF33KFIl8jMBRugm8jShpOuZNKCa9X8
	 OaK+sXHQL8fddGLHKkLd7EupGD5ZA5+jkN/W8ECFsjQZYkhqZYyJ7wxoz4282PauwG
	 NNu7Anzjv2iaw==
Date: Sat, 18 Apr 2026 22:18:56 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <aeQDUIaxc5qBvLA4@google.com>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <aeJTecsykkHMSvNh@casper.infradead.org>
 <aeJr8Wq3qmpGk6m9@google.com>
 <CAOQ4uxhG0wgTAfn-XQz2Kkosh=upeE4x5r_PuYmc_H2X9snogQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhG0wgTAfn-XQz2Kkosh=upeE4x5r_PuYmc_H2X9snogQ@mail.gmail.com>

On 04/18, Amir Goldstein wrote:
> On Fri, Apr 17, 2026 at 7:20 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > On 04/17, Matthew Wilcox wrote:
> > >
> ...
> > > I kind of want a section on "no weird ioctls".  Anything you want to
> > > implement beyond ioctls already implemented by other filesystems,
> > > you need to bring to linux-fsdevel as a separate proposal from "please
> > > merge my filesystem".  Almost anything implemented by f2fs is a good
> > > example here.
> >
> > I disagree to this. As a filesystem developer, I belive ioctl provides a way
> > to tune the filesystem-specific features which are not supported by all the
> > other filesystems.
> >
> 
> Jaegeuk,
> 
> Note that, despite Matthew's unhidden opinion about "weird ioctls",
> the proposed clause does not say that they are not allowed.
> 
> The section refers to the way to submit a new filesystem for review
> and requests that special ioctls will be clearly submitted separately.
> Here is how I have added it in my work branch:
> 
>  - Structure the submission logically.  It is neither acceptable to send one
>    large patch containing the entire filesystem, nor is a replay of the full
>    development history helpful to reviewers.  Instead, split the series by
>    topic -- for example: superblock and mount handling, inode operations,
>    directory operations, address space operations, and so on -- so that each
>    patch is reviewable in isolation.
> 
>  - Separate any filesystem-specific ioctls into their own patches with
>    dedicated justification.  Interfaces beyond those already common across
>    other filesystems will receive additional scrutiny because they are hard
>    to maintain and may conflict with future generic interfaces.
> 
>  - Expect thorough review.  Filesystem code interacts deeply with the VFS,
>    memory management, and block layers, so reviewers will examine the code
>    carefully.  Address all review feedback and be prepared for multiple
>    revision cycles.

Thanks, those are all reasonable to me, as I did quite similarly in 2012,
https://lwn.net/Articles/518718/.

Some useful tips before submission might be helpful:
1) find a company sponsorship for long-term maintenance support
2) present key differentiating features to filesystem/kernel leads (e.g., Ted)
3) check any patent/copyright violation
4) share the results of xfstests/fsstress/power-off recovery test/code coverage

Thanks,

> 
> Thanks,
> Amir.
