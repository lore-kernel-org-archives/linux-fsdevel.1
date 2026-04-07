Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E33A6409;
	Tue,  7 Apr 2026 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558157; cv=none; b=eJYm58POhBngnZdSK402Q1glfmEfe2H8Rbknxts5hhrSyRf5w8Cf1VQP47CfD7qFEnI113HXsY6BYiE7waq19503f788T4WrlOkbMRu9XFGP82DOCN71PM95jGWquL56t2DfjCRjnyJvtd3fRIAGQBayy8zOALoyUYrPkpVee8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558157; c=relaxed/simple;
	bh=3OrLtrygmPyg40uo6RyA9usJhsugYG4enMZGA3se92Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvYWyIkVTND/GUX4d4LYYAQtFPQuwh8r1bjv6bA+uQynbw7IA/E/9JjhLil70+jg0bJDpIImXND8AJ6MShA/0FVILdnzGwlWxAPjsltWbDurOz4jV2MTTLovqf/jJq+jcGC6jjNzRiWD7/zAqDsW7m/ywCfKbc9gR3rQVUDeseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYFoAvHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYFoAvHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85DAC116C6;
	Tue,  7 Apr 2026 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775558157;
	bh=3OrLtrygmPyg40uo6RyA9usJhsugYG4enMZGA3se92Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYFoAvHz/JrHivILbzuHJ2vU7uvF3JXigkzkHdZ0/v7czFhqRb+yVlDdB9n20kGL5
	 YXRRSUOjS7iM9LrJ4L39EpoZJgJZk8OpKlOSf1CrY2Tr9zvS2IYaqktazRY46vI7SJ
	 CtUH5F1B6ow8yU6NcjW3FLNOQqePKMixrCOFsdqR0wVRj5KX6Wcrw3Bpzi86X+6pxs
	 65uQg4xAT0xG/pxnrNSLJj7L10nE53Phvr77DCNvF2ae2FpOh9Y5Uhjh1NOPHKFYae
	 ozEpt2+4nnQETEKBBDFRXjRBWy8oUei/uiy7wYw0r4gvM75AJD49P0zcZS4lpKzUwR
	 RPlGe8fJziIVw==
Date: Tue, 7 Apr 2026 12:35:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>, 
	Jay Shin <jaeshin@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Yafang Shao <laoar.shao@gmail.com>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
Message-ID: <20260407-frieden-girlanden-7b761912b2b1@brauner>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner>
 <d8e591a1-d105-408f-b794-48573e1aa2fd@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8e591a1-d105-408f-b794-48573e1aa2fd@themaw.net>

On Wed, Apr 01, 2026 at 10:10:55AM +0800, Ian Kent wrote:
> On 31/3/26 17:39, Christian Brauner wrote:
> > On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
> > > If there's a very large number of children present in a directory dentry
> > > then the benifit from retaining stale child dentries for re-use can
> > > become ineffective. Even hashed lookup can become ineffective as hash
> > > chains grow, time taken to umount a file system can increase a lot, as
> > > well as child dentry traversals resulting in lock held too long log
> > > messages.
> > Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated deletion of dentry")
> 
> I'm pretty sure I saw that earlier on but had forgotten about it when I
> 
> reviewed the bug this time around. It is essentially 681ce8623567 ("vfs:
> 
> Delete the associated dentry when deleting a file") with opt-in of course.
> 
> 
> > 
> > This patch introduces the concept conditionally, where the associated
> > dentry is deleted only when the user explicitly opts for it during file
> > removal. A new sysctl fs.automated_deletion_of_dentry is added for this
> > purpose. Its default value is set to 0.
> 
> I meant to update Documentation/admin-guide/sysctl/fs.rst to also say that
> 
> setting dir-stale-max to 0 disables it. I also get the impression you might
> 
> feel better about this if the default was 0 as well.
> 
> 
> The thing that I don't much like with the d_delete() approach is that it
> 
> fails to cater for files that have been closed and are otherwise unused
> 
> who's dentries make there way to the LRU eventually resulting in the bad
> 
> behaviour being discussed.
> 
> 
> > 
> > I have no massive objections to your approach. It feels a bit hacky tbh
> > as it seems to degrade performance for new workloads in favor old
> > workloads. The LRU should sort this out though.
> 
> My aim was to improve performance so I'm a bit puzzled by the comment.
> 
> 
> The problem is the sheer number of dentry objects and the consequences
> 
> of that. Hash table chains growing will affect performance, umounting
> 
> the mount will take ages, and there are cases of child dentry traversals
> 
> in the VFS. Once you get a large number of stale dentries that necessarily
> 
> need to stay linked into the structures to get the benefit of caching your
> 
> exposed to this problem.
> 
> 
> The LRU mechanism is so far unable to cope with this.

I meant when when you start limiting the number of negative dentries and
start to not accumulate more that some workload was relying on this. It
was just a theoretical musing. That initial "delete on unlink" thing led
to regressions for a bunch of workloads when we did it unconditionally
initially.
