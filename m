Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444854;
	b=IVnaWEPF0OZNLu+Dr+1458LIiwPHgOSm1XE7IeEi8+LpohnG+YFuPKt4S6AoViO/ZwPd
	 UzhG0NY0bOmybP8E1dLZzfPbhuEGRN/aWqpZ9UHIwPNOLFC+MXY2sRY6kvKtfIykemuCo
	 fCyTNdC2fuXAto76NbLfMRQEZ2Z5FnBiCTe6PMM7MDBCHcSLLvvdfUQAJ5pRjkg3Zj225
	 Y98eo/yC3+PmBd0Fhfiw5CDxRXINEDupNgqjlqVtpa7MMBFo8GqVjHSA7ynXlSYS4bwjN
	 1ajrwiN0E+NH0cHkgNBYt13icunyyrQmvNmbNMdwSCJMuR1llmilDnBFytE+5S2s1PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444854;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ptUqxl+FSgqXww7qutPBzfxssS1laHZAufEmAd4CAbg=;
	b=ejVJVDZ8AJ5pHlA+qtzP677kdCj0/DYXGYdUBa/AcOI+vzklboibYTHKmrPVJCg7FwGA
	 GvRL5gXt5h/Z1x72WQrCrvGnc1ZSU54vR5gxza0ewBUte9tm1hPzIbYbvtQHJjaLI+Ia7
	 MJS6ZofkQ9PWHFkDgJ+GzY5u6Rkatcr1leSGXqfkf5unjuF5n37K8iyLWEaDjnp4CW486
	 nqnrc3BbudEuugagci/94yLIpPbbvDmKErVWwBU3JlUgHM5BvrqRnH/KWEqtntDR6YbsL
	 SC8O4FEbz9wwNiV1HyN3t4DWOJQSIckoCL+Dl9QkBfApHcLlWHwA126yXcA+/f/MM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO1g0dwR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19B606A31A;
	Mon, 19 Oct 2026 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO1g0dwR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5FC1F000C4;
	Mon, 19 Oct 2026 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444854;
	bh=ptUqxl+FSgqXww7qutPBzfxssS1laHZAufEmAd4CAbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZO1g0dwR2An6DWTYT1MnRSMy0VDM3lT2LPQ4okidvUTthZv9inrUnniecU775G5v/
	 IwLDeAYpkFiHXGIcKPYk+00oVgSlARzg/q3CRw/dtv/UQpMJ/CuvQkD9RLKURTc1ts
	 0Mo2k0XFL8Db7+9a7nN7ptrIDTBUtHafTOMp5f2222OHcFxmcMHkSShXVldqgwjS2t
	 6ofKlh6RWERZAUhWbI+YcbuIDpkSKgMCXyxVc35VBndwRXW3whm/Q0c2suU1n1LSL7
	 JcQJj0Lve42/9/rgOTFsFnIetEg27twNWpp7hgoYhxXqU3HA0TE/cB4MyORyZ+iuM1
	 z4JDvU6goV5wQ==
Date: Mon, 19 Oct 2026 22:20:52 +0100
From: Harry Yoo <harry@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	"Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Ilya Gladyshev <ilya.gladyshev@linux.dev>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, kernel-team@meta.com
Subject: Re: [RFC PATCH 00/18] mm: read the page cache without folio
 references
Message-ID: <atZurH8mp-yW3Upg@thinkstation>
References: <20261019154913.1765974-1-kas@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019154913.1765974-1-kas@kernel.org>

On Mon, Oct 19, 2026 at 04:48:53PM +0100, Kiryl Shutsemau (Meta) wrote:
> Small reads of one file from many CPUs all take and drop a reference on
> the same folio, and its refcount bounces between the CPUs.  This series
> lets filemap_read() and shmem copy from the page cache without taking a
> reference.  It is Linus' RFC [1], reworked: a folio that such a reader
> may copy from is freed only after an RCU grace period.
>
> Only the folios that reads keep coming back to get the flag,
> PG_rcu_free: those that folio_mark_accessed() finds as accessed as the
> LRU records.  Streaming reads and data that never gets hot are not
> deferred, so the memory held back stays small and most frees are not
> touched.

By applying this to hot folios only, small reads would benefit only when
they contend on the refcount. That further narrows down the scope of
workload that would benefit from this. Random or sequential small reads
still perform the atomics on the refcount.

Looking at what Linus mentioned as "Willy reported real users having
scalability issues in that area a couple of years ago in a discussion
about buffereed IO scalability limits:

  https://lore.kernel.org/all/Zds8T9O4AYAmdS9d@casper.infradead.org/
"

On that thread, from Willy:
> Not artificial; this was a real customer with a real workload.  I don't
> know how much about it I can discuss publically, but my memory of it was a
> system writing a log with 64 byte entries, millions of entries per second.
> Occasionally the system would have to go back and look at an entry in the
> last few seconds worth of data (so it would still be in the page cache).
> 
> This customer was quite savvy, so they actually implemented and tested
> the lookup-copy-lookup-again algorithm in their custom kernel, and saw
> a speedup from it.

https://lore.kernel.org/all/Zdz9p_Kn0puI1KEL@casper.infradead.org

Again from willy, from the same thread:
> On Mon, Feb 26, 2024 at 09:17:33AM -0800, Linus Torvalds wrote:
> > Willy - tangential side note: I looked closer at the issue that you
> > reported (indirectly) with the small reads during heavy write
> > activity.
> > 
> > Our _reading_ side is very optimized and has none of the write-side
> > oddities that I can see, and we just have
> > 
> >   filemap_read ->
> >     filemap_get_pages ->
> >         filemap_get_read_batch ->
> >           folio_try_get_rcu()
> > 
> > and there is no page locking or other locking involved (assuming the
> > page is cached and marked uptodate etc, of course).
> > 
> > So afaik, it really is just that *one* atomic access (and the matching
> > page ref decrement afterwards).
>  
> Yep, that was what the customer reported on their ancient kernel, and
> we at least didn't make that worse ...

https://lore.kernel.org/all/Zduto30LUEqIHg4h@casper.infradead.org

From the discussion I'm not sure if the scenario above would benefit
from this.

Maybe we should try to either 1) find a better heuristic to mark
which folios should have PG_rcu_free to make it beneficial for wider
range of workloads or 2) identify workload that heavly contends on the
refcount of a small set of folios...

-- 
Cheers,
Harry / Hyeonggon
