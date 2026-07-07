Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553303DB65A;
	Tue,  7 Jul 2026 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422409; cv=none; b=kiBmLQy3KGDxRVBeMb9E1NnQu/rOg5S7WcJeckVaiCGutEkAnqDAGladgCX373ls2XHZfU63D25Bu2bqO34zB7HQsUK7X56KD9CNwZ+0Hs5ny73bRuDSRCSjexfRaV8GzK0OKK+zLQTSyZ6bileSLpZxP/J0zyFQYr1r0cng4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422409; c=relaxed/simple;
	bh=qngC33WR9/kx24F16EevrpbDDdP9gfTUT8wCtufnanM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhJXv8WV7KM6Et735k7RZBBcGd3sCCltYWIYYtfkV/3Xb12kwaL1Vak6PKXL1tb1KMcKCCwtY/TwOqVdT4mmyCG5ZNvVGAXfXSoQUhaAz4kVaIwFlEoYbF0IDZ8nnHxgkfLMg9WM8b8q0yyLODfSV8JLKeXme15EEMdyAa2pXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNsHbIf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNsHbIf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59441F00A3A;
	Tue,  7 Jul 2026 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422407;
	bh=uxQP3gLmIUzYBfoacOtJptD05zMRflOQs+DB0wW0xpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eNsHbIf4sOdWw6JCQpCaE2eEgsRjvyXM0TUxaM/x+HUWu/rR2CciAzQqnoECZaJQP
	 7TEpqs6ZE12aRoYV3bMmMfsJau6Ydnj7iFnb8pWmuEa7H4SjEhfeIyGFpJzvYC6GGY
	 SOGdrZDZKX1RaGFDjE/2DkMaQfkQQOEGEpNHVXONMHdyHm4vLv+qJfHghVL5y708KS
	 t9P1p7NQR2ry1N2SYphqCNTE7QJEopIIn2vS5+Af0aTIrPWOdVs50g/I8sZiuNvaK2
	 Botwhf8za+Mg5LB4L/RmIP19QXFqK+9FfHiMyVhKffEK6HkilXr+z8tpQAyIPS2CXS
	 13E8O5UYUzRVg==
Date: Tue, 7 Jul 2026 12:06:34 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Sourav Panda <souravpanda@google.com>, muchun.song@linux.dev, osalvador@suse.de, 
	akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, mhklinux@outlook.com, fvdl@google.com, 
	gthelen@google.com, mike.kravetz@oracle.com, pasha.tatashin@soleen.com, 
	rientjes@google.com, riel@surriel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] mm/hugetlb: Dynamic, NUMA-aware HugePage Cache &
 Free Page Reporting
Message-ID: <akzZr2jfJ0J8zox4@lucifer>
References: <20260707064235.1386552-1-souravpanda@google.com>
 <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>
 <20260707062428-mutt-send-email-mst@kernel.org>
 <b9a48d89-74f1-43d4-b7bb-be988b6855c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a48d89-74f1-43d4-b7bb-be988b6855c9@kernel.org>

On Tue, Jul 07, 2026 at 12:28:44PM +0200, David Hildenbrand (Arm) wrote:
> On 7/7/26 12:25, Michael S. Tsirkin wrote:
> > On Tue, Jul 07, 2026 at 09:29:07AM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/7/26 08:42, Sourav Panda wrote:
> >>> Overview
> >>> This patch series introduces a dynamic, NUMA-aware HugePage Cache,
> >>> backed by a kernel shrinker to safely return memory under pressure, and
> >>> integrates it with Free Page Reporting (virtio-balloon) for HugeTLB,
> >>> specifically targeting gigantic (1GB) hugepages. The goal is to solve
> >>> the tradeoff between allocation latency and memory
> >>> fungibility in virtualized and heterogeneous cloud environments.
> >>
> >> Hi,
> >>
> >> in general, we consider hugetlb nowadays to be mostly in feature freeze, as we
> >> realized a while ago that adding more special casing on top of something too
> >> special for all of MM is only going to hurt us more in the long run.
> >>
> >> We want to have less special casing and less special sauce, not more.
> >>
> >> Now, there is nothing wrong in making hugetlb be less special, by making it use
> >> more of core infrastructure etc.
> >>
> >> But optimizing for surplus hugetlb pages by teaching hugetlb about new caches
> >> and its custom free-page-reporting support rather looks like the wrong direction
> >> for me?
> >>
> >> --
> >> Cheers,
> >>
> >> David
> >
> >
> > It is currently bypassing free-page-reporting completely.
> > Making existing free lists not ignore free-page-reporting would
> > maybe considered "making it be less special"?
> >

You have this completely backwards.

You're advocating making hugetlb _more special_ by duplicating functionality that
core mm already supports.

I mean:

mm/hugetlb.c                                 | 590 ++++++++++++++++++-

Tells the whole story right?

The whole issue with hugetlb is the very fact that it's a parallel
implementation of a bunch of mm stuff in its own little world.

We make it less special by mm/hugetlb.c smaller and smaller and implementing
what it does sanely elsewhere in _core mm_.

>
> Depends. We don't really want an orthogonal implementation of something we have
> in core-mm.

Yes, exactly.

Feature freeze means feature freeze, not 'feature that core mm doesn't support
feature freeze'.

Hugetlb is a poster child for poor decision making in mm that has left us
saddled with maintenance nightmares because we allowed 'just one more feature
in' (TM) with little to no thought to the future.

And we've all learned from that and don't want to repeat these kinds of
mistakes, nor make existing mistakes worse.

And work to improve hugetlbfs and make changes like the above are VERY welcome
:)

Laying a foundation for hugetlbfs to be more of a sane mm citizen through rework
series is really the asking price for stuff like this in my opinion.

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
