Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252753C4552;
	Fri, 17 Jul 2026 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281647; cv=none; b=cVg7+Y4PQKyKGst9Yg90yHH3l6fVkgXqSI0vY0x5G+Ftm8VZXw30FkqNfa3hnaUfe8wz3bK/ydtmu95zduznh7C7e9mDYcGh0LqVLDI9RrHBQuMj+BM5qQ8w/Ltl0Nulsp/afu6BTq1jRr0SvVEayEO2Ulhn39mWmRcfuSJcRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281647; c=relaxed/simple;
	bh=tT9wIZbjfws8z2YHRMT2t7mPzaXGPWEPamITAohL4rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIYpO8vhL8O5NbWXbmLBpsPxA+kyHFPH7qaY7i7hy9ndVCr5h+H6Ztqij3tkSDdJCAPpE4StjouqViOTeoRBvSkp7//Lni9gz+d9tJIAvo7OxwBMC+wk7PzLTKBjVLPGtWPIJvBWndm+5ADJjL8le15jHbtQZbVCd73ltTJ1qmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx3qxWDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx3qxWDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042611F000E9;
	Fri, 17 Jul 2026 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784281645;
	bh=tT9wIZbjfws8z2YHRMT2t7mPzaXGPWEPamITAohL4rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vx3qxWDgOoBopSmws9bVs/inhNgT4mAi0Y2iKsfZfTFKKyjMfJnJuGETUmeTmDuE8
	 Tys+7fZWhqH0vCuOJKYD3vaU8hxOK74idErFUkpalVHf8OQIhLbWYc6vKikTsDETvL
	 BLSK9bsCwir7n54LejniUHeoi3TT2mEJtWACYAeIm7ci798Tafj+OgkxOVxOHffUBI
	 0PHO7tCelk7spPnWk/a5dXg3pyhQxsAeSY+Qc+IPYqfWq7hvHKRf/yn4WGhNyLsGVT
	 aXX/7zZFtBzrTH0h8xJFe6vgSSZZJeGj2sYzpRMNh+WhbPefqAGazScaLCxnugDca9
	 WnmXwCmsDaBrg==
Date: Fri, 17 Jul 2026 10:47:06 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: liuye <liuye@kylinos.cn>
Cc: Ye Liu <ye.liu@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/thp: expose deferred split folio memory usage in
 meminfo
Message-ID: <aln4u93ImjHF_mLn@lucifer>
References: <20260717063025.168436-1-ye.liu@linux.dev>
 <alngSdkM6iEGpETe@lucifer>
 <102bada7-66ae-415d-abc8-12d5939b7ebb@linux.dev>
 <70294b26-86e1-4de0-832f-d5cb488cdb3e@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70294b26-86e1-4de0-832f-d5cb488cdb3e@kylinos.cn>

On Fri, Jul 17, 2026 at 05:38:10PM +0800, liuye wrote:
>
> 在 2026/7/17 17:24, Ye Liu 写道:
> >
> > 在 2026/7/17 16:08, Lorenzo Stoakes (ARM) 写道:
> >> +cc Johannes
> >>
> >> On Fri, Jul 17, 2026 at 02:30:22PM +0800, Ye Liu wrote:
> >>> From: Ye Liu <liuye@kylinos.cn>
> >>>
> >>> Folios on the deferred split list hold physical memory that is
> >>> invisible in meminfo. When a THP becomes partially mapped, the
> >>> unmapped pages are removed from AnonPages but remain physically
> >>> allocated until the shrinker splits the folio. This creates a
> >>> memory accounting gap where used memory cannot be attributed to
> >>> any meminfo field.
> >> Is this really that much of an issue? You're not giving any use cases here.
> >>
> >> What real-world use case motivated this?
> >>
> > I have indeed encountered this situation in a customer environment,

And determined the cause so not sure what the issue is.

It must be quite a strange workload for it to be a meaningful amount.

> > but the environment is complex, and I cannot clearly explain why this memory
> > black hole occurs in that scenario.
> > However, I will provide an example to reproduce it below.
> > Use case: The system has 100GB of memory. A user-space program requests 80GB of memory.
> > For each 2MB block, only one page is retained, and the mapping of all other pages is unmapped,
> > while the process continues to run.
> > You'll find that in meminfo, MemFree: only 12GB remains,
> > but the process actually uses very little memory.
> > This creates a memory black hole situation.
> > Below is the test program I used, from AI.

Let me stop you there at AI-generated. Not interested.

As David said this exposes internal implementation details so it's a non-starter. NAK.

Thanks, Lorenzo
