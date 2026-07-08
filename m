Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBD3FF88D;
	Wed,  8 Jul 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499193; cv=none; b=DJlpy257wo0GUadcmipGvm6q1GvNHs4Ymf4lZdS2Y/yRK0u7adjlPs3jTRqWhmVIHdrMeVExewl+Ly8BKZ3HLlNhrPqel4rGyuO+qt5YRurqxaVIsxLNce/8d12oYsPZupHHUP8frbKV8MNv0ZsrdUAWatf3uB9gjYdeBBR1kcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499193; c=relaxed/simple;
	bh=2rbRSYYAKVsxwEQ1SKtO08FrLJoHwAJY4BdmthThYeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSdaClv44zSSCNcmlXD0qmR8a7q9yASZEIzpUDZgtCXtW253E7G+VxaHikHqS56DScyYwd9jHT8PSKiim7tlPgZp4KgKNbfTAwmZr6XPWEsti4YzkIp7UQW3IIA9NPDYNmVslQUH1j54mXSaBcgTzSZyINV7vlglYK+QQBWapD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDbBrbjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDbBrbjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0731F00A3A;
	Wed,  8 Jul 2026 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499191;
	bh=KfIXZqSgSsUZkySMKxA7SKZcwl2Zc6IkJcaMTw/YlhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PDbBrbjkPqdVS5TD0vAimCfeEp4blPivZriBE2HX7XOgXGaecJZzeftn4t1gYCotr
	 5E6eDrdYBo/GmEX8RK2v/RQVfYsmyy6nXiGDXFTSudi7JSNSsl4ojeIhdeDGinlvpG
	 x6UQHphDexQbaiVQpmGW839TpNkCGA5W1JMz2kvXArr4esBX3VTINld1V360zcGRU/
	 ITdXfNUJ3yxcteVsj1F4XfypLdJb5KNkkN0An3Wn44niXV7CQfSVddpg8gWIH9Emla
	 FVeXYahfi2eoj6Bpn7t3vT0XK6O2mjtrRjQuWG53acrfbthLXqAGinGGaXinBzKtic
	 sSxE11kH+/Ijw==
Date: Wed, 8 Jul 2026 09:26:18 +0100
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
Message-ID: <ak4JiBcvi29sYx0v@lucifer>
References: <20260707064235.1386552-1-souravpanda@google.com>
 <9624988a-366e-4884-9408-3f3b88c27290@kernel.org>
 <20260707062428-mutt-send-email-mst@kernel.org>
 <b9a48d89-74f1-43d4-b7bb-be988b6855c9@kernel.org>
 <akzZr2jfJ0J8zox4@lucifer>
 <20260707095843-mutt-send-email-mst@kernel.org>
 <ak0xWgpJPSaNWPsl@lucifer>
 <20260707152755-mutt-send-email-mst@kernel.org>
 <f9bad4b3-93ee-4daf-84d5-97f6ca305240@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9bad4b3-93ee-4daf-84d5-97f6ca305240@kernel.org>

On Tue, Jul 07, 2026 at 09:46:14PM +0200, David Hildenbrand (Arm) wrote:
> On 7/7/26 21:32, Michael S. Tsirkin wrote:
> > On Tue, Jul 07, 2026 at 07:46:28PM +0100, Lorenzo Stoakes wrote:
> >> On Tue, Jul 07, 2026 at 10:01:55AM -0400, Michael S. Tsirkin wrote:
> >>>
> >>> Fair enough.
> >>>
> >>>
> >>> Lorenzo, do you know *how* you want it reworked? Could you write it up
> >>> at a high level?
> >>> Because if not, it's not really practical to make it the asking price.
> >>
> >> Michael, you're an experienced maintainer, I'm surprised I have to tell you that
> >> the burden for that lands on the submitter.
> >
> > Oh sure, "fix bugs A,B,C before you add to this mess" is a classic way
> > to actually not end up with even more of a mess.  But I usually do try
> > to be explicit of what are specific issues I want submitter to address.
> > I don't really feel figuring that out lands on the submitter.
>
> Sometimes it's certainly easier. With things like hugetlb there often just isn't
> a feasible way to integrate it nicely into core-mm. It's just too special.

Yeah exactly :) once you reach a certain level of 'specialness' it is more like
pointing at a flaming trash pile and crying ;)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
