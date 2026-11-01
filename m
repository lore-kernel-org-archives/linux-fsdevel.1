Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550931;
	b=DRuZGB1PEvrbh021vPLGH7VH8YY/7hYImiYQXzcs47XwImUBLLdmPyvXe9JlxdJLEecZ
	 RUrUq+hGDSzHYGuyOe1IiFhJ6GOB1nrx3VnQKxtt04uPQFoc84fVpekTRf0CeN+K+WcR0
	 /1dv3P0Cnr25ioWiW34yRsvam3qNTOypNlrBtfVwkb+yNBVmD2CsxtInLRanmD6Bpfipx
	 fp+99D+tQRKrVk5RGTHK7WAtRReRLJWlNUXC5fCL4Y2nOcFwZzx17hboSqdBqNCR0g/SE
	 ZxNEZjKKtaBEQAaY9L17OxYDlylpNvpPJNXbPmROz85tjd05wTzLg6vHx/ytCp9Gu1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550931;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YpxeTkJB1bA2U9lceP4MrjPGCxxWE+eVAqMF4TwyDY8=;
	b=SNbGvpbFpKv2QWrKm+jP6Gtv6Ng1uGY6r3XeJtqSYiyf0TuHrq1FGRWMLqKez8PjHnTi
	 BV0/huF4R+NLbNdRLJbz4RxzpBQ0rixMtNJN8Q2E6psACFHLHAuimTqx6y1ACKO896gur
	 uKFRIBRv+unPVX8Zrg3ToJ1t9gCqi+QsXzdV/dcYCbFIcLz+8XPYif/BWzil8VJoxUVo/
	 3ncD5FNhd1U/l6DOa1HX+gKMAZsf9Gf29liUCCrdzZoyQGK3blKqYCaGscLLDlsoRtd56
	 PA6qF0b5ySp2OaSQIZyH/g8vhtL8WG3l+4rrjkRAx8qLhkltacBwZtkBWo1qyMzl5yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVZ+sydb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1F606A325;
	Sun,  1 Nov 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVZ+sydb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D241F0093A;
	Sun,  1 Nov 2026 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793550930;
	bh=YpxeTkJB1bA2U9lceP4MrjPGCxxWE+eVAqMF4TwyDY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lVZ+sydbX4IaalU9rxb8FWIjpvdImbXKLH5nmSn1TvKoHrCByGAdOlIHSgPGu0ujg
	 YWFdM9diqbkgFrSdYdbOKRMdULyhOXXNUGzpWXSeSeXA3uTJ5r+X2PEPdGcvmV9eCQ
	 JXinML6jFJpyK0fuE0V5q4UiEO2L6ovIsJKFc9VX1dTmSSxvsISoSgcvkU4gG+ruS/
	 RPqxN7J/Mi5WxoKltitvI9NDusqY6VaE4IjeUiAwnjI+63r4WGYSxLuIViegZyhki3
	 ecfoM+omSd71pWITyCEvJnoe+ROliHfGpBvENV4Oh0WhMVWUI7OA2A0rEBVJguwyy0
	 KP1sF/5V3O0/g==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Sun, 01 Nov 2026 17:34:49 +0100
Subject: [PATCH 2/2] MAINTAINERS: move SLAB ALLOCATOR under MEMORY
 MANAGEMENT
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
Message-Id: <20261101-maint-page_alloc-update-v1-2-27e8c246b13d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248; i=vbabka@kernel.org;
 h=from:subject:message-id; bh=Yj97FLTqxQQ/XjojdX3j7TfC2CQw8jz0GMpF5tBgTkk=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWQ9z3JaK9ifkLU39plOR/VDcS7ZZXvEBN1+v9f5zBETf
 MTkaIZ1J6M/CwMjB4OlmCJL9e4TjqIzlT2mefh+hBnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMGLk4BmOpLJez/A+aL1+Tn+yxVDl0ty9N/l61VaFrm5tLMORNTJnAmi65ap/KCJWnPGoa
 DDZOfFwkIaj1RNa14GqZ5YHnf29U7YqxnBV639//Q5H7u4IE6l9dpjz6nxzCzHn198NIC/wdr5a
 UPr3LPFjHxnaZr+JJ71Zy9AfF9QVx7r+cd2N6l1uGldjrgwtyT56Ye1dvv6ae7wWLyBf3G24eeP
 0xoKJldnr6c9+07gXdtCyfevJGt81g0bxHLvz1XqlZOO2U++6x251M3ec6UglMXJ6dGx3kKSFs8
 q/n8r9w6xE9xteBG3h0ty7ec3L5Mrb5rJtPc12s4mkqFzi4TDDhyc83ktVI8/JrPAk7sSfRYpzn
 v6YeAfQA=
X-Developer-Key: i=vbabka@kernel.org; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664

Following David's consolidation of several other MM subcomponents, do
the same for the slab allocator.

Rename the section to MEMORY MANAGEMENT - SLAB ALLOCATOR and move it to
remain in alphabetical order.

Remove Andrew as M: to signify he's not the primary person for picking
patches in this subcomponent. get_maintainers will continue CCing him on
most patches via the catch-all MM entry. David prefers not being added
for mail volume reasons.

Indicate the primary integration branch (slab/for-next) in the T: entry.
It will now be integrrated via the mm/linux integration tree.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 MAINTAINERS | 59 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7cfb28a9029..e449ee3009ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17815,6 +17815,35 @@ F:	mm/shmem_quota.c
 F:	tools/testing/selftests/memfd/
 F:	tools/testing/selftests/tmpfs/
 
+MEMORY MANAGEMENT - SLAB ALLOCATOR
+M:	Vlastimil Babka <vbabka@kernel.org>
+M:	Harry Yoo <harry@kernel.org>
+R:	Hao Li <hao.li@linux.dev>
+R:	Christoph Lameter <cl@gentwo.org>
+R:	David Rientjes <rientjes@google.com>
+R:	Roman Gushchin <roman.gushchin@linux.dev>
+L:	linux-mm@kvack.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/slab.git slab/for-next
+F:	Documentation/ABI/testing/sysfs-kernel-slab
+F:	Documentation/admin-guide/mm/slab.rst
+F:	Documentation/mm/slab.rst
+F:	include/linux/mempool.h
+F:	include/linux/slab.h
+F:	include/trace/events/kmem.h
+F:	lib/tests/slub_kunit.c
+F:	mm/failslab.c
+F:	mm/mempool.c
+F:	mm/slab.h
+F:	mm/slab_common.c
+F:	mm/slub.c
+F:	scripts/gdb/linux/slab.py
+F:	tools/cgroup/memcg_slabinfo.py
+F:	tools/include/linux/slab.h
+F:	tools/lib/slab.c
+F:	tools/mm/slabinfo-gnuplot.sh
+F:	tools/mm/slabinfo.c
+
 MEMORY MANAGEMENT - SWAP
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Chris Li <chrisl@kernel.org>
@@ -25809,36 +25838,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
 F:	drivers/nvmem/layouts/sl28vpd.c
 
-SLAB ALLOCATOR
-M:	Vlastimil Babka <vbabka@kernel.org>
-M:	Harry Yoo <harry@kernel.org>
-M:	Andrew Morton <akpm@linux-foundation.org>
-R:	Hao Li <hao.li@linux.dev>
-R:	Christoph Lameter <cl@gentwo.org>
-R:	David Rientjes <rientjes@google.com>
-R:	Roman Gushchin <roman.gushchin@linux.dev>
-L:	linux-mm@kvack.org
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/slab.git
-F:	Documentation/ABI/testing/sysfs-kernel-slab
-F:	Documentation/admin-guide/mm/slab.rst
-F:	Documentation/mm/slab.rst
-F:	include/linux/mempool.h
-F:	include/linux/slab.h
-F:	include/trace/events/kmem.h
-F:	lib/tests/slub_kunit.c
-F:	mm/failslab.c
-F:	mm/mempool.c
-F:	mm/slab.h
-F:	mm/slab_common.c
-F:	mm/slub.c
-F:	scripts/gdb/linux/slab.py
-F:	tools/cgroup/memcg_slabinfo.py
-F:	tools/include/linux/slab.h
-F:	tools/lib/slab.c
-F:	tools/mm/slabinfo-gnuplot.sh
-F:	tools/mm/slabinfo.c
-
 SLCAN CAN NETWORK DRIVER
 M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
 L:	linux-can@vger.kernel.org

-- 
2.56.0

