Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550926;
	b=lzdnp09o8nwLndLLgEKP3Ia1+Ilvh7I8rJvtUlIbKXDyg/R5WeK8Z+UzTb1CP87rrBlo
	 6eLA+xe1pEUzoLLtCpBqe+aebJbwklqZIIzJcC5Qe72mWr/4Mnp28treTQ+kGvwO3hoc7
	 l+N/izHpkuM6maZoOGheT9lLgGRFOxMMySvQsRzcLCtxAZ01LvNWzOuYhLHf5WlHOkCwj
	 0d6eoYr9yAivHCpQuwSa7r2uIPRhPEHprsf39w+wCpEY5mIXLSHlVYIIdKaVfFK2i/buu
	 PeHzqnyfTpzYz69/oQawwkmE09GIkTF7DayoK1JbSkDiEp2YpI9SHFvAmipgpIgQo3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550926;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3x8oCRFRszEq/Mgj7LYVJrisRBnIHOK0MAHeiUidi/U=;
	b=x8XApQwqGCI7+8nqP1cnBw99bvvuFnCfHfhk9OZidfi1N0/BjKMHFJKMbTIXfZJRqbh6
	 PCHYIzXArEB5uUWghkbh2cnyPrNe/TgsrkY4eyUgIBWokzq2Jgz1YPjl8k9weNN2d7sQ8
	 UzblPx2mORccqxlUYqYkDkxJ0W3qjxNTc8eZizne/AN1m6XlvTMIll+TeOH9iZ14CYqTv
	 +eCTDERUlHZC+G2vezwkFXWQssPhSB+0r1RgQ4wIBdfhcLBc55UWbWs2xSAE+aLnBPK2N
	 eBLJKy4j6HDLrOi9O3g3VUBOULL48Gdg0wuhKbOdhQysy2nOSHJFVxdirPdvFnCLfEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MW7y6eVm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88163606A329;
	Sun,  1 Nov 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MW7y6eVm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2021F00919;
	Sun,  1 Nov 2026 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793550926;
	bh=3x8oCRFRszEq/Mgj7LYVJrisRBnIHOK0MAHeiUidi/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MW7y6eVmJ/5BQ2b6bdHTHfO68F/8BO7ev4sibK7Mfs8jCUEbSemQgDc0mTspF1mJ/
	 7KP20anDE+Z6Nnl+9gkUVS8XzZmSPrnVA2gYhl8TCBEjhMZHKs+drq1mv6MLeYQQhC
	 j2XRX/q/tFJBpSbjLhwU8y5Tf8stdsxQ44Rn/F4GdEXqq6dSR0E0HdkG9Tv0Sge/E/
	 LUciTRMA9J9ZXmWpIkcF9RhokZd5R1s+sB4IywUSGEbnEiiG7RHG12AkBNuw8ho4wZ
	 fkUPTJFIF92M3wRHhfVn5z+8Oao4mvUQCZhfnStstzluEa/X7qYIEtGSQK+ENp6hpT
	 O9BKIGXuxrdRA==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Sun, 01 Nov 2026 17:34:48 +0100
Subject: [PATCH 1/2] MAINTAINERS: add Johannes as the page allocator
 co-maintainer
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>
References: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
In-Reply-To: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=vbabka@kernel.org;
 h=from:subject:message-id; bh=ZGfKSf7whFZ9UN/85d/sfF5g2ZOOiNMW9NElTJJp5oA=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWQ9z7KXP2x4Sv6Snu8ln4zbZ07XXS/oevDk1K8LqyIeP
 2J8o6VT3snoz8LAyMFgKabIUr37hKPoTGWPaR6+H2EGsTKBTJEWaWAAAhYGvtzEvFIjHSM9U21D
 PUMgQ8eIgYtTAKY6ei/7//QGvquMAmxXX/tsZhS4bLVxBetFQ6/PR1utO6em8zRY3F+83DemNfD
 c/AM+j1a/F8j+yiZpZLpGasPBo0Fbz19p6Xs0u+KNctctpayFJ1k2cdlqxK1OLw6rfTdN4V/Lug
 tTi+UfTiid6Ciylrl0nrn3nyod2XNPn2YcP1qxxcRXwkXusKCGX+A5yWgtba2+VVNiA5uNt/d7p
 9l5PtwwY/0M02qf2H/e+1/NKjD9x8y5ZPXXH8J1Z+bLXJ69Snfzh8ut9/LfxB5v7px3P+vIutcG
 oRHFDoG/re3af5T9+bfJOWD+pYlFarftuNmeu22PrRXkySk9F+XGdekWX/3n/pXdv+694Kvuco3
 okDYWAAA=
X-Developer-Key: i=vbabka@kernel.org; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664

Johannes is a long-time expert and reviewer for the page allocator and
has agreed to step up to a co-maintainer role, so do that. Thanks!

Additionally, page allocator is joining the MM transition, following the
MM core updates from David [1].

Patches will be collected in the mm/page_alloc git tree and integrated
via the mm/linux integration tree. To signify the change from Andrew's
mm tree, remove Andrew as M: - get_maintainers will continue CCing him
on most patches via the catch-all MM entry. David prefers not being
added for mail volume reasons.

[1] https://lore.kernel.org/all/20261030-maintainers-v1-7-97278f8a5f54@kernel.org/

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b68bc3626709..d7cfb28a9029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17720,15 +17720,15 @@ F:	include/uapi/linux/oom.h
 F:	mm/oom_kill.c
 
 MEMORY MANAGEMENT - PAGE ALLOCATOR
-M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Vlastimil Babka <vbabka@kernel.org>
+M:	Johannes Weiner <hannes@cmpxchg.org>
 R:	Suren Baghdasaryan <surenb@google.com>
 R:	Michal Hocko <mhocko@suse.com>
 R:	Brendan Jackman <brendan.jackman@linux.dev>
-R:	Johannes Weiner <hannes@cmpxchg.org>
 R:	Zi Yan <ziy@nvidia.com>
 L:	linux-mm@kvack.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/page_alloc.git page_alloc/for-next
 F:	include/linux/compaction.h
 F:	include/linux/gfp.h
 F:	include/linux/page-isolation.h

-- 
2.56.0

