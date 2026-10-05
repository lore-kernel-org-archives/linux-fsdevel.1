Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49747728D
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196418; cv=none; b=tcFRk7kuWRsdBp9T23UR2TtUdSqsmnuC4Zf9+b/BpP4WmnnBLLYjQngK5kSTL52ijcQ7xhRKF5EARAdAB8TwSf9UZ9vmg0UOx84iqRAx+HChpzHIvuJESkq10lJdQ6EZP2iCItgK6cZ5nhzLWqYVwVVhcWHjtEZHFThYnKcLtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196418; c=relaxed/simple;
	bh=thP8KWDSrVNaCzZxZkr1NmHDj69fDYFKJ+2q+vBDnJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JftqaPZSX1o584sEbUhbSGukazmBYNzhookSW9gaAHtg/7477Td/lr+ijtYs2FmKao1Q8M3xV3m9OCkfc3ksrHTnukfMH4EfZCQohkgCpfH1JZdG3mODuUYHyS92InT3LzbmiVCzHZ11jrl+H6gv5h8OAIVwlSpNXvhuB5EpYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxsX2him; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxsX2him"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264FA1F000FF;
	Mon,  5 Oct 2026 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791196417;
	bh=JkfdIcgPp/C27k4TuNtN09IrrxL535Nix7hJHiNXmOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nxsX2himrqU8mHsSDOvpaxm/OyFkjLTQ/YE+7b96viXOBkjEDOAdo+FzR01Ga+7Pq
	 RiEyYz1HXIi94E/fKK6ypjJYkhNGa7g+xKM88nhfPN5VuNXVq1i+bgcJOt+/GpDr33
	 vHOUuz5IIBksmIeFd55lUa4mqPCOJkjYeGGYTTqP5bv0nU2xFZ7ad0r0RuCsVmrh0n
	 8lTkedQHVG8bxmIonob5kmWCvgKStp4W8V7Msbuv1g3kdW6DVHLdkPi/MxDOHZV1dA
	 DQRLnX9aHEHZJL+F3/jIsyJZ/JdBREocx1/ZBnixs+xOKm+YNt1Z4J6sNktKkZIXEv
	 F/cEcyaR+5Xlw==
Date: Mon, 5 Oct 2026 12:33:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/3] nullfs: add an empty immutable regular file
Message-ID: <20261005-weilen-funde-abstufung-0c16667b93c4@brauner>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
 <20261002-work-mount-cover-v1-1-232a8f52b43c@kernel.org>
 <CAG48ez3rU3W_93mHwzG8AedMs71Qb57reEbfkgVHj3i2UhKHog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3rU3W_93mHwzG8AedMs71Qb57reEbfkgVHj3i2UhKHog@mail.gmail.com>

On Fri, Oct 02, 2026 at 04:31:58PM +0200, Jann Horn wrote:
> On Fri, Oct 2, 2026 at 4:14 PM Christian Brauner <brauner@kernel.org> wrote:
> > Add nullfs_new_file() to allocate an empty immutable regular file on a
> > nullfs instance as a dentry of its own. It is never hashed under the
> > root and so can't be found by lookup. Reads return nothing, changes are
> > refused, file locks, leases and delegations are refused as.
> [...]
> > +/* a file of nullfs is permanently empty */
> > +static ssize_t nullfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > +{
> > +       return 0;
> > +}
> > +
> > +/* an empty regular file, with the same refusals as the directory */
> > +static const struct file_operations nullfs_file_operations = {
> > +       .llseek         = generic_file_llseek,
> > +       .read_iter      = nullfs_file_read_iter,
> > +       .fsync          = noop_fsync,
> > +       .lock           = nullfs_nolock,
> > +       .flock          = nullfs_nolock,
> > +       .setlease       = nullfs_nolease,
> > +};
> 
> If this is supposed to function as a sort of error sentinel, you could
> also leave out the handlers for .llseek / .read_iter / .fsync. Maybe
> even not set ->f_op at all so that it defaults to no_open_fops and
> open() fails?

The least regression potential is if we model like a sink which is the
goal here. But I did have your intuition initially.
