Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFB444717;
	Tue,  4 Aug 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878831; cv=none; b=RF1QTyRATTk7etvEN9P0rP4GnMot8nCh7OCi/xmB4PoStrxI8bdIO0KiW5FnoevVE2RcI4U3X+hlObhl3K4z/lJbL3EsM4MqTvyL1WVpMvJ8Tqm5BK3nZIqVp2E++hFKN8Cw4I4jN4m69hSbESW1ViqUbcCnLamtQY8ELnj9eyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878831; c=relaxed/simple;
	bh=VdLhk7u0pXiiokMxl9zJoreTFVdU3hELABA32UTZ2zA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E5u3LRmxc880TLr6+YGorTokM9KX6lUDTFLG1e9k5FVC1XLP6MkU0lIh0tEYFVU1ouOGv8M5n4p2iBtXa2WU7wepeIYaszx1lcDzWE+1XLPEPZfJdqqOYCPhzUuSBdKVaJwNL7DntmILxk5E+509SJGitZNPGT4WmSemUSZOMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=njuvaOw0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="njuvaOw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9781F000E9;
	Tue,  4 Aug 2026 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785878829;
	bh=Jc8DztnvJAtNJ0O48g/cNmZXd6zTWCvVblHZX5gxwbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=njuvaOw0C0aJ4woC1WNHQV44+ODTPuQfNGE3Yw7zQ9VrkO147HTJJPDmnN77mCLCb
	 Vc+qpei6tQrhdhnFr7IRv0CtzUsDSvkVvoAxTAakELvPu2WhaISGJGv4xl0uFdziP5
	 Adx/5fBcD0m9JbgSDHYbK6wcSYkqeSlQXCJFUJ38=
Date: Tue, 4 Aug 2026 14:27:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, William Kucharski
 <william.kucharski@oracle.com>, David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
Message-Id: <20260804142708.f002cf20a34420874b8dbb21@linux-foundation.org>
In-Reply-To: <anJP-FXqH3iNjTJ_@cmpxchg.org>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
	<20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
	<am28pV2PEfHsi4p-@lucifer>
	<DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>
	<anJP-FXqH3iNjTJ_@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 16:47:52 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> > Like you said above, only xas_split_alloc() is affected. And we have not
> > seen related workingset regression report (like what Johannes reported
> > in commit 7b785645e8f13 ("mm: fix page cache convergence regression")).
> > It might be OK to not backport.
> > 
> > Johannes, what is your take on this?
> 
> Yeah, let's Cc stable.
> 
> It would be a bear to debug if you ran into this at scale. Which I
> think you could with certain workloads.
> 
> The patches are straight-forward enough. It favors a backport.

I've added cc:stable to both and updated the [2/2] changelog as
suggested in
https://lore.kernel.org/all/DKFELWPHSJNO.3GGVW270HENEG@nvidia.com// So
afaik this series is good-to-go, thanks.

