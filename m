Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670967;
	b=4sEbtRdn8PI8TWMoE//8aUnoDbXTaie907rahYhqQyJtzzEPnWNrAGflImjj6Un1mJbg
	 TU+4RoaYoVDfVOIHiHRxjiL0nC2mZzBGMMEodk5c/ITtT89goqhrtqDCNFv2hVU4DhJ+p
	 vGxJzT6GzqQV7zgtwoLCiWfin3OblVZOXwjjVq+R5fVh5jGzTjQixXrKsI6uj7hySil1q
	 Tx/2FIlJAAIRJlfcRBj/khuZXFsYPT5YepOtdtkQFpW1g9Cn1vSFGUQjZqi18Ey06hAnq
	 M8C3HSrH3AuPRhqdHmgykvxJvEjunmP0GdDnmQRt68UtG+yMGINyu9Jw/TWBcLoqGRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670967;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/yEmlIGT8Rm47P5/YaksZujPOe2/Vjk0RWJKshG5qqM=;
	b=GrUrU4+CQUnkiOpv0HNHlPNCwfD7kT+1wK7HlbQT+7N4K5Hhd+YPKxywCUh4b8K5Gq4n
	 zGge1CFynJornHiR3DViik4DP/HNrkDrBe3cfztAtyp9hK/+4XER2wvJ6RO9tuOs8zHt7
	 Vg3+ZSmT/X6UosnIE5YljYAHRNmIeqRSG8BbsTunKMMYF3iciBvbWJ1ltxZhxnw25/1EA
	 PImdvki4YCpMhtmZ3mfv3l/HfArb/+31sdXN79QcxXfvUbAXdCG/r/JCEVpDZJiLUS+rO
	 VO5zp6I2RJ447yb+4og4OtewRvnll8ofNN3WdnlUV9ngNpXlo3NlmDHH4ZlE3lwsvzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=sC4V93ww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C53606A324;
	Tue,  3 Nov 2026 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=sC4V93ww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B01F000C1;
	Tue,  3 Nov 2026 01:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793670967;
	bh=/yEmlIGT8Rm47P5/YaksZujPOe2/Vjk0RWJKshG5qqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=sC4V93wwNcAEqLkI5tERpnFGjyTFE/S7+D0PuojsTyfZtKBtUMHkOnNhI598gNx9f
	 ZNuZjjfJBBjamVORdQd4cPVcMwjB1xQRT+bRH6a6iRkbNyypZrP9Hlqg3FRTecSDXm
	 lNzKIn8M4Nf2nS5PpDpoBb7fi0J0bjWNCvuoCMF4=
Date: Mon, 2 Nov 2026 17:56:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara
 <jack@suse.cz>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan
 <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard
 <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: remove newly-unused page wrapper APIs
Message-Id: <20261102175605.a0d9caee8279ffb5f6fdf15f@linux-foundation.org>
In-Reply-To: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Nov 2026 17:54:05 -0500 Tal Zussman <tz2294@columbia.edu> wrote:

> After some folio conversions done last cycle (namely ceph, f2fs, btrfs,
> fuse, and page_io.c), there are a number of newly-unused page APIs.
> Let's remove them and update comments as necessary.
> 
> Patches 1 and 8 are taken from the ceph writeback folio series [1],
> along with tags.

Thanks.

>  9 files changed, 8 insertions(+), 110 deletions(-)

Tal, you obviously haven't been following along ;)


This development cycle is not the one for cleanups and new features,
but this one sneaks through!
