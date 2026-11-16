Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837579;
	b=v0zCN5oZS0Iy7a51n7QMgsY1O2/Unq87ESTxrmEgw04PJ6N0iq/mDuHdY0PT1CAu+KNO
	 uR3lqs078lkI1FLx082DobjRaVRoTkXUN4ELmE0X9cXOUj6bSB0axfMeb667KKXPqEZXC
	 /hVGgRza5wkMmOLJw1XGR3GyOaRxqtzlHneuctxxMuLfsD/y24ZEsx8E+RjHiFAyv6psA
	 c2p+UavirfEtRYdNwy6nI6+Rbj2Re326+PX8W50CHnZUYtZR7MHsOsdd5Cu6uhNTdU1WJ
	 +eqRKpnB+xpF7ZSXphUjDn44TrFYyH7iMjp+vsfHuE9llN7aeiUkTlIYwvlB/2E2RsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837579;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+0F/BYp4W2Rhn1Nomgj2rP/Jj1y5yUU++uEAdL1QZkk=;
	b=UGwjC2yosH4Rr4bglW+7DRMQMuaLXeL9fxgDI1aX+eeiOPjBKYXXlIDA4EfMWYxPIRN1
	 4che1iEJukdOfgNP/NegE8Q9Nw0JJJ80gSIp5fmsSmZclmKP32dswImu70TYDEdXSDNSA
	 b/XDB4gGV0TcaxQs2ANvFUfDaXwDlp+QUF2/ltKUGzO6IOfNOfeNls2ziW5NnZxML3gxt
	 iiNSWMXrnJ+bBZyzgy+7k3fsCeiynG2dDlC99vl9K1CN0LHFiCvGlNZA/J8kDBjtAHcdB
	 O9BxhME/9JByL+jRi+2FpzZr0f/yJ1v8i/qC2e3opMVWOUcg3VTLTXUIYvHA7CKCdvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ad6JLZi/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78181606A888
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad6JLZi/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043DA1F000C6;
	Mon, 16 Nov 2026 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837579;
	bh=+0F/BYp4W2Rhn1Nomgj2rP/Jj1y5yUU++uEAdL1QZkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ad6JLZi/9/bL58prXRETP/G6UDvQC51DcwZ9YedzBDHfRS8lIdTCzGoNmhiW2GQEw
	 /aSnNCr7xLeLGcwcuVHHKjHJJJ0gWuIagIky16dvjoensJg2yhfinHV8891lvckpwy
	 xS2uMM3xU+EEEFvngPxS3vjY4XpGkH9EK5Fp8D6Q8oHgaOzbWZ0qePIcaWFrkgtN/Y
	 vimEzAmjSDCG7us4M2PmVgBopDZkWwzY2QFSCP4Q8ZT09qyxyz+4qwSsHY97055bpb
	 Xqfi3jJ3tNEHdQBCupkqnbtFeqm0Hitdm6qb6/wGsxqgeAzNyErcrbDMsevZz/f8kY
	 txcLDTtijySvA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 39564198004A;
	Mon, 16 Nov 2026 08:59:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Nov 2026 08:59:35 -0500
X-ME-Sender: <xms:QQz7aqj1qeMiPG-z-Dgb1cG-n7hCkX50jw3cTnX1khXuV-tvPJ7u3g>
    <xme:QQz7airZTcMK3nJvnmcrfLb8eDJIqIzjj_rdu3AkWA3TybTsQbroaSapMunU3ocP7
    v4p2BTTeaYv5_mOijVpsuNfRdo-viWHof7_n-FoMDNRr6dblbh_qTY3>
X-ME-Received: <xmr:QQz7apdBVAiNyAF_et2VScCAMJZA0xxSw6C2vOqEILECRiZShYaN2tlxNLY>
X-ME-Proxy-Cause: dmFkZTGw7Ek27OkttPtA0Uz12TIRY+fdCmOBGTdrDghB0eLcttPx19DupuImOjFBtxaU6o
    JpeXLrgoMfTu/lRKHCIbMj8TzWKHmfHCUY1G1XUscv97+KfE4ZgUv3URbsjMgtUtdZeyxZ
    SgpYcwu9pXmzrr5EJzFIwQG92uYZOBq7pK07CTnxZhIOY2LLT1RQ4TYNmjWVB5mI/QlLrd
    lgMB1n608lO6GGOFzonO3YCxKtuKcIqa2yW4weia5Qzv8gyUD2hS5o7CzQGTr7cuwDbUa0
    lJoWxHsuV1AHsxtoMgIcDdVvIbsfeBRmZr2ToyOJqhisBH0S/Tg40BJ9RANd8a+DCyuOEi
    hn098RuATgD8qEKVgtdPugOq0uT6bGPyrMOntKLKkq+ZkA01R44yfH+YH0c9YDbYmzrQIA
    Iopzse1Ct7eMKJwAWqXgcNivcm0iyHT2OhWNgV+VWC0Q82FfCdXJRs/ieaQi7IDVGGntxr
    2IHkGaGTAT12B8bkGtjQix6jaqugDGh3lm423/jNh60ZAHjmjuCDYvMBwXk5+ytJbrwnWB
    7dMtlkUuY/1t0syakAczXa7L80fTrhVuFAPUFWNIqdlWtI7V0N8u5qe93gMfQIbb2CGwXy
    M0D8RdnYRzDAUCTOKXcrl+5HZfFQvkzD95yUO5jtbnlC2gt1X6l6UfYs85/A
X-ME-Proxy: <xmx:QQz7atyEKDj06BUWZSenI9BcQjUGATvIgsIXq027hGWgFApDfXXGkg>
    <xmx:QQz7avTOcYMA16LqFIE-4PZjPp6l7Sfra25M7fhVcGDr_O5nYkk8sQ>
    <xmx:QQz7arlAtzq6xhRodDWJnvXKtlxZGt6D7-GsazYmLfD-SWfZxg7NNQ>
    <xmx:QQz7aqeKOk5ehpHc2ZTy-jLZG_fiZ1OP4vKyP4CZ9R_qovBM46JmsQ>
    <xmx:QQz7ajyqGivGQB206Ld8BHvW9UTez-MXUa_VwzqnnC6fvXEdvu6kRNI0>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 08:59:28 -0500 (EST)
Date: Mon, 16 Nov 2026 13:59:27 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/userfaultfd: prevent poison marker loss
Message-ID: <avsLuMTVBFfDwfsw@shutemov.name>
References: <20261107-b4-uffd_marker_loss-v1-0-82926b22704c@kernel.org>
 <20261107-b4-uffd_marker_loss-v1-1-82926b22704c@kernel.org>
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
In-Reply-To: <20261107-b4-uffd_marker_loss-v1-1-82926b22704c@kernel.org>

On Sat, Nov 07, 2026 at 12:51:05AM +0100, David Hildenbrand (Arm) wrote:
> Unregistering userfaultfd leaves poison markers in the page tables.
> However, once unregistered, hugetlb PMD tables can be shared again.
> 
> Further, shmem page-table retraction can discard poison markers even
> while registered in missing mode, and fork() can skip copying page
> tables containing poison markers.
> 
> To fix it, add VM_MAYBE_UFFD_POISON and set it before installing poison
> markers. Preserve it across unregistration, splits, merges and fork(),
> just like we do with guard markers.
> 
> Use the new atomic VMA flag to disable PMD sharing and page-table
> retraction, and to force page-table copying during fork().
> 
> Move VM_UFFD_WP to bit 44 and make HAVE_ARCH_USERFAULTFD_WP depend on
> 64BIT, freeing bit 12 for the new flag on both 32-bit and 64-bit systems.
> Expose the flag as "up" in smaps.
> 
> Losing poison markers, while unpleasant, is not really fatal, and the
> use case is rather a niche thing. In addition, we rely on the atomic
> VMA flags infrastructure ... so let's not CC stable.
> 
> Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
> Fixes: 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  Documentation/filesystems/proc.rst |  1 +
>  fs/proc/task_mmu.c                 |  3 +++
>  include/linux/mm.h                 | 45 ++++++++++++++++++++++++--------------
>  include/linux/userfaultfd_k.h      |  7 ++++--
>  include/trace/events/mmflags.h     |  9 +++++++-
>  mm/Kconfig                         |  1 +
>  mm/khugepaged.c                    |  9 ++++----
>  mm/userfaultfd.c                   |  3 +++
>  tools/testing/vma/include/dup.h    | 20 ++++++++++++-----
>  9 files changed, 70 insertions(+), 28 deletions(-)

Oh, that's a lot of boilerplate for what it worth...

Anyways,

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
