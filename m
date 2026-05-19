Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519D36C0CE;
	Tue, 19 May 2026 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228241; cv=none; b=dO0yK4FbjO4uLKNR5Qhg6PmjwJA+iHwWttes3cBeQCvT8Wq07HrmAU7nj5q/9jfuVAQtBrR9RBqXLUhz3k2XKL0xqLoSZUfo3xYeZFuPQoO5AVfDcB1uP53UXrznsjWa4Bss9VTEssTvn7jax7fvAb2du3QKvi8jiL+VnjYjwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228241; c=relaxed/simple;
	bh=ELz1q0F4yjVdBmENRhPSaU1guOVJu5AXgcdbAeBIXj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvy0S0IR6KC2jD3M7b/A2WTrOYK/jcRUgTYzFmIP7lZbYVVt0wZ9toxIcbEUK0y1jvI7eE0zbzlEw/NXOngOsHGtpS1og86AUcKh5DUfyOmZyjC2JUQqNfWVgLA0kWBEAfgEDO3PTf2REBhSMJOmLUsoTHKVgfSKbqmN2m86Bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAXjqxsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAXjqxsY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 38A381F00893;
	Tue, 19 May 2026 22:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779228240;
	bh=4/vqCU2hcMuC2CiMXmM38qoAM+nZkTtP8PTRKNqfkWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DAXjqxsY7opeu/G7VC0n3MjH4yagnSgDJ/6Qu6xPoRPTEU8uBbyQ7MkNeIiS6Zvla
	 BfPgd460Lc6ZXC8P6S5VFlRFIeoDg5ECOW9hF0HJzifwk3BX86Y0t42RcQn9BIm+1T
	 MOdUJ83vEaSJvlncAsQpK8ttweV+3v+dMeWO44G+o+G2Gy4oFGy6uX/4cai1mJB1hO
	 JaFbilpgejgFf5cA/hfid+xQoLDdUhC668cHcjgxPNfI4eSd8bsHxRvd80lvFZuwaH
	 182/+M+k04l6Jzn/oeB6s1VummZo5EyzMTuJAsa+wxo6J6WZ6lKDpwhQ0fukbozIKh
	 ikf/1nt1SU03g==
Date: Tue, 19 May 2026 15:03:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org,
	John Groves <John@groves.net>,
	Joanne Koong <joannelkoong@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	Luis Henriques <luis@igalia.com>
Subject: Re: [post LSFMM summary] where is fuse going?
Message-ID: <20260519220359.GJ9568@frogsfrogsfrogs>
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <20260512202336.GC9544@frogsfrogsfrogs>
 <CAJfpegsPqja+MzfmvCE5054y9pv1_cwPRH2uGmFws-wwxJmrZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsPqja+MzfmvCE5054y9pv1_cwPRH2uGmFws-wwxJmrZQ@mail.gmail.com>

On Tue, May 19, 2026 at 11:01:18AM +0200, Miklos Szeredi wrote:
> On Tue, 12 May 2026 at 22:23, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > As for fuse-iomap I'm not sure how to proceed
> 
> I will try to dedicate this week to reviewing fuse-iomap, hopefully
> without too many distractions.

Well gosh I had better get going on posting v9 then.

Since 30 April I've:

* Ripped out the BPF stuff after all the shouting
* Added a simplistic iomap filesystem striping mechanism
* Tightened some of the checking of the iomaps being given to the kernel
* Made it so that you can remove backing devices
* Actually check read/write access with the iomap bdevs
* Improved inline data write handling to be less flakey
* Amended iomap writeback so that you can run a standard ->iomap_begin
  to collect mappings
* Banned freeze except on iomap filesystems

* Fixed some integer truncation issues
* Add some iomap helpers to libfuse to make it easier for fuse server
  authors

> >  -- in the long run I think
> > it would be cleaner if each file IO path (virtiofs dax, passthrough,
> > writeback_cache, iomap, and whatever we call the original one) had its
> > own file_operations.  But that would require us to refactor the common
> > code chunks from each file operation function into a bunch of smaller
> > functions, which I think would sharply increase the review backlog.
> 
> And so the plan is rather to basically start from scratch and do that
> form the beginning in fusex code.

Heh.  In reading through the fuse code to figure out how I'd get that
done, I came to a few realizations:

1. It really *is* easier if the server can set FUSE_CAP_IOMAP and from
then on every file on the filesystem does things the iomap way.

2. Many of the random weird callers of fuse_inode_has_iomap() outside of
the regular file IO path are *actually* looking for "is this an
exclusive-mode inode"?  That's pretty much all of the file attribute and
ACL handling code.

3. iomap and exclusive mode are mostly orthogonal concepts.  One deals
with plumbing, the other deals with attributes.

   3a: iomap without exclusive: This is a clustered filesystem client.
   The client grabs a file layout lease from the server, and uses that
   to populate the iomappings.  Timestamp updates are forced out after
   each write, but otherwise it's the same attr cache and timeout that
   regular fuse uses

   3b: iomap with exclusive: This is basically fuse4fs and all the other
   local filesystems.  The kernel knows that the fuse server isn't going
   to change the file attrs out from underneath it, so it can cache
   timestamp updates in the kernel and only flush them periodically.

4. Figure out how all the attribute handling works in fuse is really
really complicated.

But there are questions here -- I'd like it if the fuse server could set
FUSE_CAP_IOMAP and all files are iomap.  All the weird userspace inode
flags setup setup code goes away.  It'd be even nicer for 3b if you
could declare at mount time (or FUSE_IOMAP_CONFIG time) whether you want
exclusive mode or not, at which point all files *also* become exclusive
files.

The problem with 3a is that I don't have a client or any way to test
that.  If I just don't allow iomap && !exclusive, how sad would anyone
be?

I also have no idea how grody it's going to be to retarget fusex and how
much QA is going to break because now all the iomap stuff branches off
from an *unstable* base.

The other wart of course is how mad will John be when I tell him that
fuse+iomap+dax+raid is now a looong way away...

--D
