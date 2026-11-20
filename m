Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165182;
	b=zgEvuhr2U8jTM9NUlRZSLFLqPyZqZBdeSj89Er8GVbkVHEbJAdAw6xqDpzwz/SR4l8dM
	 Q/yi4OyU0ebDFmyoGeirJHxRfzXrhhLU4LGqXiYPR7vVTGujq4ZmsYe77UNKCt2OZnU2b
	 p4b2mLKI9iCZYx/I7dEN+2iTGbdKHvrhTYhtWDMhB5XsKC86491jE94WGe7SS6YK0qpQS
	 0POkjylhXa2xziN+HLeewBsIbjVx8sZlWBoPGRewEZM9VKlZ1fQT2VwR1yh1+8iiJkdgk
	 AtRKfM56kWKkHbqb8LOHajcILZrI0L20odSzfCyRXwxbeFdTPGvSdxXVk+RVEVSmHeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165182;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2ccnweT/dXUZnBEt2kANRtABkZdQMfgjKD0LcKfebxQ=;
	b=4fWlA8koM/8zLtIlSznmkU+U7uZ8XyQSj+akdU16s2AMrii8YBJ6EatZSWy33TuvHPim
	 KKngYww2i7AcsjnSCf8qN62WIIoKUMDwGIudmQQ0AOOT0VaDaOI3UF0BRBWgVGkrVX27n
	 Ziua+wmQ+MHToT9AU2cHbpaFb7dAdqoZ4/h4E7RdLhDMmYfNEQPMoE+pBsfNplmTzmA0h
	 de59jgcm4pviviziByo/FAiwC8EPQ3CJwR5Wxt3rMxaS6pmj+YjJO8Wpxw1V6mO/dQAq/
	 qBCnG1e4foCUppJVXVWmBXLLfqCH3vslFTWSaTZOh39qdEC4umlx4/vC3aDwRgnuXGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTgP8oc7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1705606A33C;
	Fri, 20 Nov 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTgP8oc7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B329E1F000CA;
	Fri, 20 Nov 2026 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795165182;
	bh=2ccnweT/dXUZnBEt2kANRtABkZdQMfgjKD0LcKfebxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bTgP8oc7MznmCSpH1M6XjrNMtHy+szYjRB2CiT5DyR/c6I9yFd/hDffzc87GAtzLE
	 5OdLrwugRdy2r4poGAJ1MQ132kIFAw1dcXyICT9v9c1FjDK5RaOoiy45s3E04TyEQU
	 REBtzS9O77iD6CsDYzgBXUP8oUlFwFMHUZDyR4KavOvEu+KSBR+OyEe5Ku6WwrLcYX
	 AcidueS6sDErdg4gxx1d/YirwPbZBAL4/kN6fLQRTKRtQ6nkWNMhezu31LJ9lvE/sI
	 i/uz4elWGPio01/QaWDUwHRp3OHDcUZZEgd7rzFD1pNXTIUhxbb2EFtX2ri3jI1pKZ
	 ywx9JxWUQw0aA==
Date: Fri, 20 Nov 2026 09:59:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, neil@brown.name, cyphar@cyphar.com, jlayton@kernel.org, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, tj@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20261120-archaisch-angleichen-wucht-037d8888abf0@brauner>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
 <20261118-moment-gehhilfe-gefangen-ce4618af6b54@brauner>
 <av3U2jLO8Q01swyg@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <av3U2jLO8Q01swyg@linux.dev>

On Wed, Nov 18, 2026 at 08:42:47AM -0800, Shakeel Butt wrote:
> On Wed, Nov 18, 2026 at 05:30:20PM +0100, Christian Brauner wrote:
> > On Sat, Oct 24, 2026 at 11:35:27PM +0200, Jori Koolstra wrote:
> > > This series implements new semantics for the O_CREAT|O_DIRECTORY flag
> > > combination for open*(2): perform a mkdir and open the resulting
> > > directory; return a pinning fd (which mkdir does not).
> > 
> > I've applied this to vfs-7.5.directory and folded a bunch of fixes into
> > it. Each fixup is attached as a git note to the commit I folded it into
> > so you can see what I massaged:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git \
> >     +vfs-7.5.directory:refs/remotes/vfs/vfs-7.5.directory \
> >     +refs/notes/vfs-7.5.directory:refs/notes/vfs-7.5.directory
> > git log --notes=vfs-7.5.directory v7.4-rc1..vfs/vfs-7.5.directory
> > 
> > The biggest change is kernfs. kernfs_iop_mkdir() now just looks up the
> > new node by name so the kernfs_syscall_ops change is gone and cgroup and
> > resctrl aren't touched at all anymore.
> > 
> > The kernfs patches are in vfs-7.5.kernfs as "kernfs: instantiate the
> > dentry in kernfs_iop_mkdir()". I'll sent that out soon.
> > 
> > I split out of 09/12, your kernfs_iattr_rwsem fix and the kernfs part of
> > 11/12. vfs-7.5.directory is based on the first one.
> > 
> > I dropped "vfs: move ->create check in lookup_open() to before
> > try_break_deleg()". vfs_create_no_perm() does that check itself now.
> > 
> > Let me know if I messed something up.
> 
> Just a heads up from my side. I will be sending couple of kernfs series over the
> next couple of weeks. First one will be removing kernfs_iattr_rwsem from
> mkdir/rmdir paths and later ones will be trying to make open, lookup, stat and
> readdir operations lockless for kernfs.

Sounds good!
