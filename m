Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691A3BE174;
	Fri, 19 Jun 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888857; cv=none; b=VJkj9d5dKqF4zERkEkfQECahXjkQIpCEew34hsFIeqvOKFL/bGHnimrXxeqjn2H4aH8NbB5QEz6QGl48niN7sF5KWHwFRBzjyoswCWrOvVQek5DBLtj0eXqSDLnWXhM6/uZifhC466o/+AFentLuRLDb3HukIfRw04qmztimL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888857; c=relaxed/simple;
	bh=bPFRyA8q12gfSlPlyamiQLzbMU9I0FS1UPZUp6TlbIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzlXj0X+17/YRoRUeE1fbpi+EkzFStsUUYHhu3hAgTQq2d7Px5IC8ydx32oDTccLxeEhJbccOe9pA3OTZCyj/zWLRvVfEhUguqSr3bh1O4BaXRDVvu+XwloMC3yhs0xWg5lB3MiGrKi9RrWZTSPGIhf9UsIvxJXXjtVdX03bY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brkFo1gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brkFo1gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E131F000E9;
	Fri, 19 Jun 2026 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888856;
	bh=aeuB26U0brIWccqtcDGehQkxyCwlFMLLMddYu0942Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=brkFo1ggwWjEhDRsLhYJemXNMQkQUusqJmybB7qBNJ4XDdafvDSJQKrUxjm7GFIvF
	 tbjbdOhaMOjEc7KzbMFOKfJkEwRbp9IgRt+j0TLFlcACCSahsJsC1TKGj/LLQTHWma
	 ERYxbv7aIel7FiBSISmkvZhd/h2/Bvvf/pvy7Yww5kPmq5CyTThIcM+KOkyqFwz5mZ
	 ZjQdyvNSThJcniisREZm6Iu7/AbIXR5cGATSV4hJ+KQ8ZVmowIAUNKZBcYfXQEMEKm
	 /H2RKK1IiyM12fU7/tQDhVcOasb2rVyqmltwOvmyHiueChRLjggZrNkmLCkRQiMFVZ
	 GPlll8wVbh2bA==
Date: Fri, 19 Jun 2026 18:07:30 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Frederick Mayle <fmayle@google.com>, Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead
 to VMA boundaries"
Message-ID: <ajV0TbwEyaKMzoa6@lucifer>
References: <20260619112852.104213-1-ljs@kernel.org>
 <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajVz1nhMn2JwucMY@casper.infradead.org>

+cc Suren, Pedro, David - I messed up the cc on this patch.

On Fri, Jun 19, 2026 at 05:52:38PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 19, 2026 at 09:37:11AM -0700, Andrew Morton wrote:
> > On Fri, 19 Jun 2026 12:28:51 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > > This reverts commit 7b32f64bc512b40b268776c5ac4d354b325b3197.
> > >
> > > This patch caused a significant performance regression, so revert it, and
> > > we can determine whether the approach is sensible or not moving forwards,
> > > and if so how to avoid this.
> > >
> > > There was a merge conflict with commit de97ae6222c1 ("mm/readahead: no
> > > PG_readahead on EOF"), care was taken to ensure that the revert retained the
> > > behaviour of this patch and cleanly reverts commit 7b32f64bc512 ("mm: limit
> > > filemap_fault readahead to VMA boundaries") only.
> >
> > I'm a little conflicted here.
> >
> > 7b32f64bc512 avoided readahead of "file pages outside the mapped
> > region", which is clearly desirable (arguably a bug fix?) and we care

I wouldn't say it's a bug fix? The kernel has always done this with no reported
bugs.

> > about performance of executable mappings.  Whereas it isn't clear that
> > we care about whatever the heck that test case was doing.
> >
> > IOW, the revert might make the kernel worse, overall.
> >
> > If someone plans to get down and analyse that test case then come up
> > with a new version of 7b32f64bc512 then OK.  Is there such a person?
> >
> > I'll park the revert in mm-unstable for now, but would prefer not to
> > rush it in until we better understand what's going on with that test
> > case and what can be done to address it.

As Willy points out [0], we've identified that it's a real usecase that we're
regressing.

There's likely others too in the real world.

This approach has also not been without debate in the past (see [1]), I think
this patch slipped under the radar on that front a bit.

So yeah, this does not to be reverted, and as a hotfix sooner rather than later.

>
> Suren did that work.
> https://lore.kernel.org/linux-mm/CAJuCfpH_Fp=J-m-kVZ3VVmqH0cAfNX6CQKWt3XmAJq1Rp9sFwQ@mail.gmail.com/

Thanks for highlighting that Willy (copied -> [0]).

Overall, if a patch causes a major regression in a core mm subsystem, people can
wait a cycle to re-evaluate.

Thanks, Lorenzo

[0]:https://lore.kernel.org/linux-mm/CAJuCfpH_Fp=J-m-kVZ3VVmqH0cAfNX6CQKWt3XmAJq1Rp9sFwQ@mail.gmail.com/
[1]:https://lore.kernel.org/linux-mm/CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com/
