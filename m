Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DF2C21F1;
	Fri, 17 Jul 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278072; cv=none; b=etjSxueaMSmKEfulDFiJfrJQ+4/b5aVLHhV+qC9CoMsVusUeZZC1izRZTq5yI8w7doNbJr4ubjSTavjR7VVEAKZ/mVc01c02dzSjZ/QJpCiHOzuSSPoNXG/HkeHRK3Ob7ZTxtjj049QvJb3sMcjz2kFy7YrO7P7mgF4oO760ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278072; c=relaxed/simple;
	bh=Np7IQ8IEu0RusFpuqJoQ1OWpIU9tI5HB4aOLC2XXgto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nguyt2yd50MCAI5JHT4Akxiw1IZHvvH/wOM+X/uvWSh/xU2FR0BpIZ7u6r7bHYTDmd4+yom5jccfLTVHRNAK1GPfi/l3TdcsUBILua8Whb36JDsJv6YVSASpOz/H5FTdNh2L6hdKwY460MAZ2XE4YdTX7NyiQaZehDTFlb62WBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmZ+jBwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmZ+jBwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498FF1F000E9;
	Fri, 17 Jul 2026 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784278070;
	bh=Np7IQ8IEu0RusFpuqJoQ1OWpIU9tI5HB4aOLC2XXgto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WmZ+jBwNWeAxtyx5aezA6KyvkpfxVkaLqDEEG83OvsUOFT/+hXyWCxtGq6s2W0vs4
	 fQqwkRU8sPFkBslvvecyOFCbY81ghCcCvaBPgikt0CPJRyt9OiTCVULqPdRJQqMoSf
	 I7a3iVmpD4XPKLggaaaTD3ilRukPIkMhoffU+/xffizr5uRp9k5gIwnh9N/f9vXV6G
	 QEcy5C1AwagJAoqghnfI184o7x8HMHU6TyTAEbIdWFz4M/TtI/OlSYqeDun9seOh+4
	 hB4sQfXue19QvhUZHTcnI8az3dWPFp1SncgIg8zEylT4Isq24pHdB0yMrv7h0idsCu
	 voQPyBqXUnuQQ==
Date: Fri, 17 Jul 2026 09:47:31 +0100
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
Message-ID: <alnsFbYX5_MWwHjC@lucifer>
References: <20260717063025.168436-1-ye.liu@linux.dev>
 <46017e29-48a3-4a74-8c5a-0be9d912deaa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46017e29-48a3-4a74-8c5a-0be9d912deaa@kernel.org>

On Fri, Jul 17, 2026 at 10:37:21AM +0200, David Hildenbrand (Arm) wrote:
> On 7/17/26 08:30, Ye Liu wrote:
> > From: Ye Liu <liuye@kylinos.cn>
> >
> > Folios on the deferred split list hold physical memory that is
> > invisible in meminfo. When a THP becomes partially mapped, the
> > unmapped pages are removed from AnonPages but remain physically
> > allocated until the shrinker splits the folio. This creates a
> > memory accounting gap where used memory cannot be attributed to
> > any meminfo field.
> >
> > Add NR_DEFERRED_SPLIT_PAGES to track the total memory consumed by
> > folios currently on the deferred_split_lru, updated via
> > mod_node_page_state() at all enqueue/dequeue points. The new field
> > DeferredSplitPages is visible in /proc/meminfo, /proc/vmstat, and
> > per-node /sys/devices/system/node/node*/meminfo.
> >
>
> Oh no.
>
> This is really exposing a current implementation detail where we have this
> information easily available in a way that we will not be able to change that
> implementation later.

Yes, also this :) agree entirely.

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
