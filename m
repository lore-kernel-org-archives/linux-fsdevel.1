Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517267;
	b=e8DWaYC+7GOjXgxCqv4p+1ggM3uXVZeic3Hyyp5qWUQuKlBuwVFZwSMsak4QHwjqt0o1
	 kmHCxqkUFI4RJhMC5ogcmn6BbyPCMKnclV36wtGtMFeHMdzvrn2iz76tXAR4//S8UwiX5
	 Fi6mS4FgmX8PyEKs996EE3QabVf1h1FTlcn444qQNVseG5PuHlJ1X0fMV6ALN+rDkhemF
	 QHV6BYxXRECF+3OE0gvnj1kZbNVA4QV47J9Y5jWsMAGUtmzuQgVerodCB9Hj+YLWaH6Gf
	 4nQs//RUZwqSz/UkjGt+E+CdcmW2vF6CWk8bZTZraPy5rjQv+PP2KJXwQoZ6Dn5L5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517267;
	h=Received:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yU04/QpgFe3hGyqIUoTM6z5+gKHxPwBv/6QVAeU2r6Y=;
	b=sHKUiC1k2oeWwzaGMYwpzFHFYgQ88LqTm3nf6Gx4MzPUhwcQxl+Ursx2RJFZTprP/18N
	 7uij4NmvezIWU9c65Jv3aLNbiLqjifQMiXeMpgmIuL24mYOK3CxrNXsJca8tlNQl1J3uA
	 vdaLRi/Qpr9ChBwMTiQ3WD81Nj8YKfRP+nD1tBqFTGGkiU3v+wcSaBrhXZkFBjOlxUvlQ
	 1gcHwNcB6Rlp60R0igQXSpvk31hTYVUA8H0HuP4dEzNHceYbBBFYoiGCLI4C7szvaWWKg
	 EjSK0/d3G/lqL6J9HEtZoU/A2bhRZIhtMZLwCDdb8hdDf7JSdn9cKFbz7RVq0y/Lihw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D586606A31B;
	Tue, 20 Oct 2026 17:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB3A1F000C9;
	Tue, 20 Oct 2026 17:27:44 +0000 (UTC)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.ams.internal (Postfix) with ESMTP id DE3A0198003A;
	Tue, 20 Oct 2026 13:27:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 20 Oct 2026 13:27:26 -0400
X-ME-Sender: <xms:dqTXajhhAkytqTNlgANjRk-o93Rtlpoi-Ezo2eNr-yvrypWxigvkoA>
    <xme:dqTXap3VaCSp2pOEbBYe1ZkKPW8sbSwgHzYOcqxs-uQ4aDw1JhDGZ2W6MMl0KiX5F
    n6cbzk1SsrVVgNEt_agSPV4sFIcUGKYnktw3qqF8zk_vl6240UCdrI6>
X-ME-Received: <xmr:dqTXamw4BWbJQ3vzYTcY1e0ey3jevieyfoMrSuzq0XSJ26cqwC1_BnfN5_k>
X-ME-Proxy-Cause: dmFkZTGzP+F9vGPOZyaAazPtUwGQnMUL7fv9cbbx9r1tOaZQdDv97soC3NeH5tlEJqA6MA
    8AB1mvW+ert6FpnONSEWAGkFPR+x/6nRW2wqDxG/x8xhzSPhANNTFTZd8rW1kL2SaYnlii
    9CI3mhrsxtoq1xY4vpBJF2vYlEEH0XnB8T5gYNVsrEhr2hHVW9SAl6G+hpF9cS/72KRnf7
    fX8wTM61liLZyYgaGEdx2EdbDIPJx0z5cvtRj60sqAXPKKMWkjnpExa4OE7h4TrxEplFja
    gINIRlbgECBRkQGX0Y+PF8v3BMTWO8ODfE4TdaqEy7j/P6a++XwxGK7gWEuEvV58vHXkWg
    WOptSd0fB6Ww8rvbb1gSU7DkB+If5hEwJrAAF94suydCEtNuR68UWN7C18EE9EBmf7vpTF
    DVZwc4RymnasVGbQFGCY0HDcvIk8ASkm8W4hyO2amxhWiWEg/ItJJoQ22r4YQs+iaV0nrf
    YxI5i3jEm7+V4W88aFGO3OjJf9X0g0VikjKzXcF/VABnLpgxgh2c55aD7z1uLzqqhrE0Un
    L7UjVXQhOuSZh6QuXmTr5pRCs28i6LGHt1HXz8ISWHDlSYVzyrNKfw/r3zNUG58zDm+fPw
    MpWHZg0Pmo8unfVtRtd10UaJA3WTyjHukRe0nCFdaaJMNHrjLQz2ivfer5jA
X-ME-Proxy: <xmx:dqTXarMZAHnl-2VfPFpCVLhSbIyQ8eiCVvp8RDdJTT7SdGmmdBNKrg>
    <xmx:dqTXasuSLTcjkFNVxoGGymoNkeMRJ4TmCNlACvbvralnp8AeSs0OXw>
    <xmx:dqTXahw8P6Ddpi2XRDE8N8zFmRAaAflhBcRy-Fefac_t226a92ea5w>
    <xmx:dqTXat5joCdsDY05-ygPYgGmt6bbzdoYQlnK8jCHFK_SS14gocQfoA>
    <xmx:dqTXasUj_G7FDmOs-kp4WRZ1iUv4_A1bbyHE3n5OYDJmSq9S0lNvc__p>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 13:27:17 -0400 (EDT)
Date: Tue, 20 Oct 2026 18:27:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Harry Yoo <harry@kernel.org>
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
Message-ID: <atejY_iL7U29bV4Q@thinkstation>
References: <20261019154913.1765974-1-kas@kernel.org>
 <atZurH8mp-yW3Upg@thinkstation>
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
In-Reply-To: <atZurH8mp-yW3Upg@thinkstation>

On Mon, Oct 19, 2026 at 10:20:52PM +0100, Harry Yoo wrote:
> On Mon, Oct 19, 2026 at 04:48:53PM +0100, Kiryl Shutsemau (Meta) wrote:
> > Small reads of one file from many CPUs all take and drop a reference on
> > the same folio, and its refcount bounces between the CPUs.  This series
> > lets filemap_read() and shmem copy from the page cache without taking a
> > reference.  It is Linus' RFC [1], reworked: a folio that such a reader
> > may copy from is freed only after an RCU grace period.
> >
> > Only the folios that reads keep coming back to get the flag,
> > PG_rcu_free: those that folio_mark_accessed() finds as accessed as the
> > LRU records.  Streaming reads and data that never gets hot are not
> > deferred, so the memory held back stays small and most frees are not
> > touched.
> 
> By applying this to hot folios only, small reads would benefit only when
> they contend on the refcount. That further narrows down the scope of
> workload that would benefit from this. Random or sequential small reads
> still perform the atomics on the refcount.

They do, but an atomic on a cache line the CPU already owns is cheap.
The cost is the line bouncing between CPUs, and that takes many reads of
the same folio, which is what the hot marking looks for.

Single thread, 16-byte pread() of one page, mitigations=off: base does
7.4-7.7M reads/s, the series 7.7-8.0M.  Dropping the reference saves a
few percent when nothing contends.  With 64 threads on the same page,
base falls to 17M reads/s in total and the series does 220M.

> Maybe we should try to either 1) find a better heuristic to mark
> which folios should have PG_rcu_free to make it beneficial for wider
> range of workloads or 2) identify workload that heavly contends on the
> refcount of a small set of folios...

Marking more is not free either.

A flagged folio goes back to the page allocator only after a grace
period, so what reclaim and compaction free is not usable right away,
and they have to work harder to keep up.

I am all for finding a better heuristic. But it is hard balance.

I will get back with data from real workloads.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
