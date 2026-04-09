Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148D34D38B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719160; cv=none; b=JWZBjRncin8PqOH6VX2TRl3PIszLbtGWrSQtDZhuUZfV8tM+FZOEYkaxM4FVYn571I4Ik4+0VsvDq5zGzko0zTdWj1ZD6Zgeu4D3QGM24Ny8tPxe8rH8GFl4S5r9r6QLY6SkmYMGrT2TZf70DLG4QrgvAZMoKtGlJCAV8MVLisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719160; c=relaxed/simple;
	bh=my6LXn8xmgzajdOla0euu8Ri/1WZ4QR4CXhOVlghjT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMPFr7Js8/B6Vxi5w7UINfJdwD45S6O5mfQVAmpyzTdtuucAZNH3MpomIwZSdxyG9OIdFGywkEJx5NKPSkPIeXKvu1IbRxdfx008msp0xcIw3bjarMBLjhz5HBYjEg0Umj29+/wdFxUvV9K9628U6iRmDWRqxUNfpK/lPirGfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkPQXE2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkPQXE2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D789AC4CEF7;
	Thu,  9 Apr 2026 07:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775719160;
	bh=my6LXn8xmgzajdOla0euu8Ri/1WZ4QR4CXhOVlghjT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkPQXE2OV9lhdm+b7H4aSgxRaoDCoYGrSQ12jMsAv3+DSapTtrBfG+ibb6XjBr4Lj
	 iRKUx0U2FlzhVuuLSF5gYDCOWd4Zrp6t4pXODl90fgBQqoErjBWwkIVfhqzSP59mH4
	 /V5RPQitO2Ww3CqrUF6W+sUybi0mB1Kt4834r1PTqhEGI7nX5gtB9k7HPJg9nToZdN
	 DiPwFt99EAo6sAlGhgW2wviRWtMGGLfswjU9bBbfBLnJfl7/YODT8n1ui3Shj1YWAD
	 AD9Dq5hdWqIWwUKSRXg0+W96XVATFE9DpuBuLceVFcI18zIIXZwBN85m3qozzIy6uo
	 GvTroDgy7uqVA==
Date: Thu, 9 Apr 2026 08:19:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
Message-ID: <addRr9Vn_LNiXp11@lucifer>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addP4MKmA8zfSN1o@tiehlicka>

On Thu, Apr 09, 2026 at 09:06:08AM +0200, Michal Hocko wrote:
> On Thu 09-04-26 14:35:03, Kefeng Wang wrote:
> > Add a sysfs interface at /sys/devices/system/node/nodeX/drop_caches
> > to allow dropping caches on a specific NUMA node.
> >
> > The existing global drop_caches mechanism (/proc/sys/vm/drop_caches)
> > operates across all NUMA nodes indiscriminately, causing,
> > - Unnecessary eviction of hot cache on some nodes
> > - Performance degradation for applications with NUMA affinity
> > - Long times spent on large systems with lots of memory
> >
> > By exposing a per-node interface, admistrator can,
> > - Target specific nodes experiencing memory pressure
> > - Preserve cache on unaffected nodes
> > - Perform reclamation with finer granularity
>
> Quite honestly drop_caches is not the best interface to build any new
> functionality on top of. It has backfired a lot in the past and we have
> tried to make it extra clear that this should be used for debugging
> purposes only. Extending it further sounds like a bad step.

Agreed, there is still _huge_ confusion out there as to what this is for.

(If I hear another person tell me this is a way to 'free up memory' I'll scream
:)

Really I think it should be seen as a legacy thing for, as Michal says,
debug purposes (it would have been a good idea to put this in debugfs tbh).

And adding something to sysfs as a permanent, maintained interface for this
purpose seems problematic.

What is the use-case for this? Why are you dropping the caches? Presumably
for debugging/perf measuring/etc. purposes? The cover letter is lacking
that.

I wonder, if this is something we should move forward with, whether we
might be better off putting it in debugfs as a result?

>
> > One use cases is hot-pluggable NUMA nodes, during hot-remove, simply
> > dropping pagecache is far more efficient than migrating large amounts
> > of pages to other nodes, which also eliminating the risk of accessing
> > potentially faulty memory.
>
> Does the per-node reclaim interface can help with this by
> any means?
>
> --
> Michal Hocko
> SUSE Labs

Thanks, Lorenzo
