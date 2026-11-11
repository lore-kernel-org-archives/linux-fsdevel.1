Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424862;
	b=CLhAf+Ni0OxDCxokiG4G9+XbDVrKVzJ1ikbDZX8ZvGvTRLZ3HK0yIGkwJ/33Z/IGrICf
	 4hSiVL+xREQ0eA8MR90fr+ZNJ1nYngUa9uw9FtCydoXfayruQp9SagM2NFW54X9xdL+jr
	 UIQUjaTd0XSq9zREgDNRxaZEm2ttWF1Vjjq4oPMOKg0jVCOvUddmAK8jNNVMvKaqDhqyb
	 xwvqmvXvKzHvGt8ghvTCqDpv2a33UuBkgDmgNWRu/eBsGJQ8ZpTdpRry8UNfww14LFzyk
	 EgNnNo4DRU68oZXgOeG7/d+hhKL3RMcn9jvwEaCt1XlQ9KSgxChLM7UxkXXlKBlDJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424862;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Soj930bwFBTZxNzA1GiyO1XhwtS7FvpbLkFUPLX9r8c=;
	b=DKTiQJEzgpYDw9MNLF/XMOebFyfxsSdA1dlCM2DGYNyCiTpEiiL5e6AtftpPDBtvB77K
	 Ojgv2DKO7cnMh0Uv50i/MXMp/IcMBFzaenULXhrE6tl9PEMAiA0+pjsyykneUrjGYnBo6
	 nZ1Fke8LzZNsjvhboBhyNiO7muScVGSow9l2CUoG/t7MtE8/u7SNOb9jY5JlfiHOFFh3r
	 37c9kImDf3DER85sGrNQxP+Wi3WCUzri+cZVkjhnKXi2hKLorCYqzvOhcjdPZGbTqEwMY
	 BGgGW6ezlueX/v8fxqrg7DsD0Du8MlmBXJqIwNIN8PBflLbOtAjXiNZGr6MIDyRJkHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1sqXpDL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0397606A324
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1sqXpDL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023FC1F00A05;
	Wed, 11 Nov 2026 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424862;
	bh=Soj930bwFBTZxNzA1GiyO1XhwtS7FvpbLkFUPLX9r8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y1sqXpDLdAdEYxJPXUlN5q9+a+D9q0AIw9kjs9hfnxFdwMfaTrn8wGAI2YVSrHbjv
	 YW9JZ/Y/L1yxqXLESu2IKbxbJcsACHsl0zmEWWkZSxcGPxY8kI7I2xtKnUEKGDuQIz
	 XlUxiyPEZIVWJmsllMBNGhrXl2griP4Nx5PCZmITSsl5FxTWBNRwKEVm+SoRhA2X4Y
	 xFuyyPjHlfu9BiAVl91vrEuaz5Wrs7d9dMW2DbfUJ/EhBAlKPa53M/DqML0HGfvyBA
	 rTFKAw/f18EUatNd62vqptumb/RD83YPnexgHtqdt8dZAJ6gAGZ5DRDr4EGIB4FsWe
	 bVCxIfLOeNhTw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0A217198003A;
	Wed, 11 Nov 2026 14:20:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 14:20:58 -0500
X-ME-Sender: <xms:E8D0akQmBszOOkf2V4Pas9hPJL_ml4TfiVb_k8Fa2fBqNoFSxLhiJg>
    <xme:E8D0aujZHsoBlI9F-DCvDcYq1_1CIV6D_V6XKypQzWFk1y5byz7v7OfPCBgpAP_L0
    YblrrZQPF_O7NZj-3vttgfEaVQoq6az4XXakadlhl-myb-CDEJz5BYD>
X-ME-Received: <xmr:E8D0atbS4S9D5YkzppwCPjfey67EkNJRNTOoPBe_sgiq301jc7kQfv9btT0>
X-ME-Proxy-Cause: dmFkZTFAt7HRtEDW5rAYKA5wJsU/hkNTWmvDTT2530v9ikh1nEEQoMGwn8WkkMXLFvMbzz
    m+5MBTcByYkkaiHHf5Pvb+d+Yec9HEVjgvT8q8NB4D2n+yGRrYH3c0zsKTDEuZP0KKuEfB
    5G61bTEB8knr93RLOGasXpXd5WRbwVHRx2ZWpa9/38aDo1YNO4lx87ZqWFlaYmXeP/Uf1r
    LR0vRe2XGGjLFxegCM1tjgqZ1nDbP7IoHfh96QQs3jwVg4ZbeseYfJFn6+84ytWcS36xsH
    BmTn6jUcDFZuxOoUoW586qRRfthPizlB2CqswLvyPaV8i2Puc2yV63QorfkwBa4BJNHIE6
    FqTumCqimKhqGLg9qa4DTTglotYUJXNph9HpSyzly3WdQluCAku1TIy7mj+ykUg4PmcJn4
    +fahCwVtu5FZv1r/j0XesuMnMeDRheOMiGFVtKbR40OXoen9Vv281WPZUbiClUPF/fjYtR
    HeuGr5eWQ4f1pGSAQUNwoKGYm021RLG8ffdgZZ5HYvt8wZ0s3hwV8XNb0RoxsmTbdrBU4I
    UunpRgweubVVrPj8NpJgrvgQ4haPMbaUV2K6rpJOjgAmv/PN67p7WNex65orWZqBgVmvzn
    nMxnlQKBMTFArL6XMw8QtieEwtXdw0ZyEhCd+ennXm6qWXWhj+JfXJ8kj4XQ
X-ME-Proxy: <xmx:E8D0auIU64qcshTDYMtTsiJmmHKWWTSxs48tFLF_Vms8J9SG77UG1Q>
    <xmx:E8D0asdwFI96dLN1SzY7lP1yS0NevJfzO9LpwUX_eqxefPBa1KHVCA>
    <xmx:E8D0avfjHO4FGyUTBk97IqYVQvWiB-U03Fm8wuCRLtcg16yvobGMYg>
    <xmx:E8D0asP7tE6e5gmctaszQmX-9Sa2SxEpMJV5B5xSVmDlbW7MS4w-tw>
    <xmx:E8D0akCFZ0Bxbsytf5KO62Iqr0VaDHxsJkNrKbCpZd6BwXOwZmyhwqzt>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 14:20:50 -0500 (EST)
Date: Wed, 11 Nov 2026 19:20:49 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/12] mm/mremap: resolve uffd state when the context is
 dropped, not during the move
Message-ID: <avS_43B79K2lUV3Q@thinkstation>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-7-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-7-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:15PM -0500, Tal Zussman wrote:
> However, this adds spurious minor faults on shmem and hugetlb.

"Minor faults" reads as UFFDIO_REGISTER_MODE_MINOR in a uffd changelog.
Maybe "write faults"?

The RWP side keeps its behaviour: vm_page_prot does not depend on RWP,
so resolving with change_protection() gives the same PTEs as the
per-entry code did.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
