Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635638D40D;
	Fri, 17 Jul 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281732; cv=none; b=qh8tSZ1l5QbwxeO23JFTrMd01cns0sZmhn+o6xRJ+MXUUWU+fCcIDo7cvMmY+w+PoYLXmqw24+TC7DeSfTAdo8wmYfvcvGe9h0OAHXmIne5yD16Sog9uwOf6lIhMderyCNr+Z1C0HOfQ+YYOQum6te62dferJsuf+XQw2NMs09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281732; c=relaxed/simple;
	bh=WbbiMz5Bc8pouXsEPT1ErZDq2Ytbta6qXQQnct2xTp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhChKdNhQONl/+otpzWvWmRarDbkPQ+H2Q5jHMZBL62ky8HDBJsuTkokXIaLFA6mhua/S8XxhzPj+TJAjOsOHlorYOKOU3O8TYFx6Z2MprDoq1UUM71yi0BCZxstL2W85QwrhlBD4NP6zSbiFnuBbq4QWSU6wog7R/iy8r9rj1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEDq1Ul3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEDq1Ul3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88D31F000E9;
	Fri, 17 Jul 2026 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784281731;
	bh=WbbiMz5Bc8pouXsEPT1ErZDq2Ytbta6qXQQnct2xTp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XEDq1Ul38/KBMzUPbKg5rIsW+d+o3rwfqzRD4hQy3SIx9V4zsGJKbM9ztOdgEV2M1
	 O6VAMArI44QdyrevREkXo/B/gr3oepK+pTwQWgYtllixOmvUg3MkdaudM0O8HPuA1S
	 w6p5r3KMimnGrtYTw4uj0BooN8imMAgnWONgcwjkmsUMPGPJo7GDfwwaaRVyzX20+m
	 C+8XAwCBgQNYeNDgzHD8ve5alKwdjw00lZBoT6hGC3n7RUOhJt+zd9jWHzoct/h6AG
	 caa5nK2i/zlxgbh3I0JBCPzJ0AQRzC2ekNd1SYWN67G6cEevlVSEAF+keCsO5w65qS
	 XSHbumWrXL1JQ==
Date: Fri, 17 Jul 2026 10:48:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ye Liu <ye.liu@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: expose deferred split folio memory usage in
 meminfo
Message-ID: <aln6SBHcxBY-9Vfl@lucifer>
References: <20260717063025.168436-1-ye.liu@linux.dev>
 <46017e29-48a3-4a74-8c5a-0be9d912deaa@kernel.org>
 <dd037379-cf59-468e-8b42-51546bf2e28c@linux.dev>
 <f041f1e0-8ec4-48d4-8656-a6789c8ad379@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f041f1e0-8ec4-48d4-8656-a6789c8ad379@kernel.org>

On Fri, Jul 17, 2026 at 11:33:05AM +0200, David Hildenbrand (Arm) wrote:
> On 7/17/26 11:31, Ye Liu wrote:
> >
> >
> > 在 2026/7/17 16:37, David Hildenbrand (Arm) 写道:
> >> On 7/17/26 08:30, Ye Liu wrote:
> >>> From: Ye Liu <liuye@kylinos.cn>
> >>>
> >>> Folios on the deferred split list hold physical memory that is
> >>> invisible in meminfo. When a THP becomes partially mapped, the
> >>> unmapped pages are removed from AnonPages but remain physically
> >>> allocated until the shrinker splits the folio. This creates a
> >>> memory accounting gap where used memory cannot be attributed to
> >>> any meminfo field.
> >>>
> >>> Add NR_DEFERRED_SPLIT_PAGES to track the total memory consumed by
> >>> folios currently on the deferred_split_lru, updated via
> >>> mod_node_page_state() at all enqueue/dequeue points. The new field
> >>> DeferredSplitPages is visible in /proc/meminfo, /proc/vmstat, and
> >>> per-node /sys/devices/system/node/node*/meminfo.
> >>>
> >>
> >> Oh no.
> >>
> >> This is really exposing a current implementation detail where we have this
> >> information easily available in a way that we will not be able to change that
> >> implementation later.
> >>
> >
> > Yes, `/proc/meminfo` is a user-space ABI.
> > Adding it there means you can't change the semantics,
> > and the field will become unmaintainable, yet you can't delete it either.
> > But I think this information is still necessary.
> > Where would be a better place to put it?
>
> Don't expose it to user space.

Yeah please stop.

We don't want this change, it exposes internal implementation details. It's a
no.

Next time send an RFC or a discussion thread.

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
