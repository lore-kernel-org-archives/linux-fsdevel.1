Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4626E70E
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854045; cv=none; b=Yfr8i0a4NGFSqRSbOgxsymjj03CqIJbWRIzl6DjiPTj1gzvPoyX/xlj7AmuVCF/7dK0wKsQDXF3nYMBRtAELneRh634k90E9GBv2hec9BrpYF2Bo9dV+xrAkDZcrBpi0MEmdIpc/pURYMXgDXh6K9BhxsAwcxQgy147NmH/p+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854045; c=relaxed/simple;
	bh=WziwIkkTen1yQCUtxtUU5b/vgzRFZGnW8KXf5bOIgAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZgYcyl1N15IzwryacrrrA8Q3f5hc/gt2Ne3nECcfUJAOrWyMdx3CYLYF2NmfSN4ER4gFt1VDTyseeYK5R1cKR6LrxRQuBEtjNEqFHKqrsnZBAEL726sduFVGmdnDSf+uyoUIpzJCaBq95KBbrUxbG9j2gMWkeTpim6RYP608Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3Kl6kAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3Kl6kAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30AD1F000E9;
	Fri, 19 Jun 2026 07:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781854043;
	bh=ffCdX735c/X/fS6mcU0lzfMnVJJiMp8qf0E4D1Jrt3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F3Kl6kAarmUjT2RFid6FDkI6ugo1VIX2b8YfGeerXP0mQY5UiFiFa8HkqpLl5DF4d
	 8rmeUb/axEDGdUsw6qTrzlvk01/CShOsq2UulfR5foDKE7Yi9orzdVoW71qmjbe2/5
	 dhC7dtVaD9m/H7d+QGadC42iqXbpGsKbxcdcT4aQqw+p4xGK+9VOri3FUoWgPXzWuR
	 rD6v91yuMg5VZ7EC2xw3KkxS4s8r2bBas1yRAU/Ws9DeNXachTK5W5jGb57fv/AbnK
	 f5YzJo4J78gH6Q1FBqBLLxDI0ASE2inldjrvdtM5T9tpPKQnln2atnfAuENi2yKDAW
	 T4N5Sq+gc/PYA==
Date: Fri, 19 Jun 2026 09:27:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
Message-ID: <20260619-geldgeber-boten-aufhielt-9f5f16b4e04f@brauner>
References: <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
 <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
 <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
 <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
 <CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com>
 <xycqm3qrhjg3uplpmozwo7nterl5tnuarghowmh3h3mv3thh6u@apagf4kqlkg6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xycqm3qrhjg3uplpmozwo7nterl5tnuarghowmh3h3mv3thh6u@apagf4kqlkg6>

On Wed, Jun 17, 2026 at 07:33:21PM +0200, Jan Kara wrote:
> On Thu 11-06-26 17:25:56, Amir Goldstein wrote:
> > On Thu, Jun 11, 2026 at 1:32 PM Jan Kara <jack@suse.cz> wrote:
> > > > The rule is that sb_start_write(sb) pushes the sb to the tx stack
> > > > after checking no loops in the stack.
> > > >
> > > > In the common non-stacked case, there are no checks so the push/pop
> > > > should be quite cheap compared to the sb_writers locks.
> > > >
> > > > For the read side I hope that we do not need to track "read transactions"
> > > > in the stack and that it is enough to check the write stack in page faults and
> > > > stacked reads in loop/nbd/backing.
> > >
> > > That's another problem. Reads can create deadlocks as well. If you do
> > > read(imageA_fd, mmap(fsB_fd)) in the setup I've outlined in my previous
> > > email on XFS, you are holding i_rwsem for read for imageA and then doing a
> > > write fault to fsB which translates to a read from imageA which needs
> > > shared i_rwsem for imageA again. If you are lucky, this can pass but if
> > > someone tries to acquire imageA's i_rwsem for write inbetween (and blocks),
> > > your second shared i_rwsem acquisition will block and you have a deadlock.
> > 
> > Yeh we could introduce sb_read(sb) scopes but that would be a bit nasty.
> > The two-fds syscalls (e.g. sendfile()) makes this scoping even more challenging.
> 
> Well, for stuff like sendfile() or splice we take care not to entangle the
> read and write parts:
>   while there's data:
>     read into pipe
>     write from pipe
> 
> So these shouldn't be a problem.
> 
> > > > Note that the unscoped kiocb_start_write() in aio/uring will need to be
> > > > extended so that the write transaction scope will cover the io submission
> > > > to cover the page faults in input buffers.
> > > >
> > > > I have no idea about the feasibility of this and how much of the holes
> > > > this actually closes but if looking at the narrow use case of pre-content
> > > > events it might just be enough.
> > >
> > > What looks like the most feasible approach to me is to record in struct
> > > task we are doing a read/write syscall for fsA
> > 
> > read/write_iter could be nested within stacked fs, so we really need a stack
> > of transactions, but this one could be [FILESYSTEM_MAX_STACK_DEPTH]
> > 
> > > and in the page fault
> > > handler once we have the VMA we can check that fsB isn't fsA's ancestor in
> > > the "filesystem dependency graph". Making the check cheap enough should be
> > > doable (we could for example do the loop check traversal only if the
> > > stacking depth of fsB is higher than that of fsA, caching the stacking
> > > depth in the superblock, which would deal with 99.99% cases) but maintaining
> > > the dependency graph will take some work...
> > 
> > My crystal ball tells me we are probably not going to do that :-/
> 
> Yeah, it won't be *that* complex and for stuff like reliable system
> hibernation we would need that as well but so far it looks like too much
> effort for too little gain...

I think we should see the code first, before dismissing it. A reliably
system is almost always better imho and maybe it isn't even that
difficult to do.
