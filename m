Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718635;
	b=VPxNeU3Btk/Obmo3KTklkeBNwcrXzlgZtBtijmXxjbqDHNmE8lmMRH68tfy3ZcizQQtb
	 EXCOJ7ltYVw2X+/7W+5BU2puPTplLODOB2Zl4xnLfceFDE9buDIyUjeizSQSrfHD/C7fu
	 zUcTmd32gxItB7Jr40T9SinlLyNLlUKXYOgrvwvrnRO4pKGD3SQyY4hL0aImhbTLMCF97
	 p4qysvarNEIx1qzjlVZkLxBG7E3lM1RIR/s+Rqs48kUMU9ExaNR9nv06D+tGcn+90qitQ
	 uN8R1EP9M4ath1taJAdAKzAv1O+Yg7cV8jzXsIomSsIZkOYuhPaUuz9lreG0zweyedg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718635;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y4ejFprHMn7fbA6AWJoEiEq8rfSRXpFulq4sNe2AGUA=;
	b=v0miR7iciAvQZSlzc5W88nEjGSF+nRZ0iWpT1+D3LjGBfBYnGgM4XHVE2ZKuQdUEPAyo
	 rTFQwSiiN7xWBGEBDv81Mh0ZWRA2getVKDhBbw8eTxRcrrmmxDjO2IumNpgo0jvZnsr1V
	 YPsKWoAGJXWfsThxqmwNGjt/hGSK21ImhX6nUe8Hk+ZGEFQ1allonqcTrvZ12Kh2d76+O
	 UGmZ5mcPBkpssMfF4604FByJzfVRepByIw8SQfm6Vyzcv73zeFIpWbYu2zyY9Otlaaeit
	 tXSOgHc5+7teORa9nzP5UzVxb1zQGUK3EYurbAzWwVHo5VbEzumBvM5nfJw5n+dXu2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Qjph4BUN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B147606A78A;
	Tue,  3 Nov 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Qjph4BUN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224FA1F00A02;
	Tue,  3 Nov 2026 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793718634;
	bh=y4ejFprHMn7fbA6AWJoEiEq8rfSRXpFulq4sNe2AGUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qjph4BUN/7Bx65go6uOjaS6ro8gpXeSXABxtg2sKX1STgEQbQocSdVe/GUvVSZBL6
	 /WV94KXfhUMncqUJ+s8QUo9vlBuudYt5mH9DSWfyjvwA6FpjLONymuSiKLTWWo7H1j
	 UweUoz3VZpQlfrR5Z1r0qnEjCKrgoPx5ReOz+1Lg=
Date: Tue, 3 Nov 2026 07:10:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Alistair Popple
 <apopple@nvidia.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>, Brendan Jackman
 <brendan.jackman@linux.dev>, Byungchul Park <byungchul@sk.com>, Chengming
 Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, Christoph
 Lameter <cl@gentwo.org>, Dave Chinner <david@fromorbit.com>, David Rientjes
 <rientjes@google.com>, Dennis Zhou <dennis@kernel.org>, Dev Jain
 <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, Hao Li
 <hao.li@linux.dev>, Harry Yoo <harry@kernel.org>, Jann Horn
 <jannh@google.com>, Johannes Weiner <hannes@cmpxchg.org>, John Hubbard
 <jhubbard@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Kairui Song
 <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Kiryl
 Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, Muchun
 Song <muchun.song@linux.dev>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Nhat Pham <nphamcs@gmail.com>, Nick Piggin <npiggin@gmail.com>, Nico Pache
 <nico.pache@linux.dev>, Oscar Salvador <osalvador@suse.de>, Pedro Falcato
 <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>, Rakie Kim
 <rakie.kim@sk.com>, Rik van Riel <riel@surriel.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Shakeel
 Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Usama Arif
 <usama.arif@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon
 <will@kernel.org>, Xu Xin <xu.xin@linux.dev>, Ying Huang
 <ying.huang@linux.alibaba.com>, Youngjun Park <youngjun.park@lge.com>, Zi
 Yan <ziy@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Manfred Spraul
 <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 2/7] MAINTAINERS: TMPFS (SHMEM FILESYSTEM) updates
Message-Id: <20261103071031.803bcf7ef27349e5035625e3@linux-foundation.org>
In-Reply-To: <b04d8d01-b42d-d948-b7b8-c360f8ec6002@google.com>
References: <20261030-maintainers-v1-0-97278f8a5f54@kernel.org>
	<20261030-maintainers-v1-2-97278f8a5f54@kernel.org>
	<b04d8d01-b42d-d948-b7b8-c360f8ec6002@google.com>
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

On Tue, 3 Nov 2026 00:27:22 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> On Fri, 30 Oct 2026, David Hildenbrand (Arm) wrote:
> 
> > I am not really the best shmem/tmpfs/memfd expert around, but it should
> > be good enough to judge when something is ready to be picked up, to then
> > pick it up. I'll have to heavily rely on Hugh and Baolin on judgment
> > for the more involved and more controversial bits.
> > 
> > Rename "TMPFS (SHMEM FILESYSTEM)" to "MEMORY MANAGEMENT - SHARED MEMORY
> > (SHMEM/TMPFS/MEMFD)" and move it accordingly. Add myself as a MAINTAINER
> > so people know whom to CC.
> 
> Thank you for taking this on, David. And thank you of course to the
> unlisted Andrew Morton, who has been uncomplainingly filling in for
> me year after year; and thank you to Baolin too.
> 
> "SHARED MEMORY": should ipc/shm.c be added to our list of files below,
> as mm/memfd.c is? (Though both can also go off to hugetlbfs instead.)
> Or do you prefer to regard ipc/shm.c more as a client of mm/shmem.c,
> rather as drivers/gpu/drm is?
> 
> We don't often have to touch ipc/shm.c, and generally ipc/ is well cared
> for by Manfred Spraul (but I couldn't see a block in MAINTAINERS for it).

I actually have this queued in mm-nonmm-hotfixes-stable:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: MAINTAINERS: add an IPC entry
Date: Tue, 27 Oct 2026 21:09:52 -0700

Add an entry covering ipc/ and its IPC and POSIX message queue selftests,
with Andrew Morton as maintainer and Manfred Spraul and Davidlohr Bueso as
reviewers.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
---

 MAINTAINERS |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/MAINTAINERS~maintainers-add-ipc-maintainers
+++ a/MAINTAINERS
@@ -14070,6 +14070,16 @@ S:	Maintained
 F:	io_uring/bpf-ops.*
 F:	io_uring/loop.*
 
+IPC
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	Manfred Spraul <manfred@colorfullife.com>
+R:	Davidlohr Bueso <dave@stgolabs.net>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	ipc/
+F:	tools/testing/selftests/ipc/
+F:	tools/testing/selftests/mqueue/
+
 IPMI SUBSYSTEM
 M:	Corey Minyard <corey@minyard.net>
 L:	openipmi-developer@lists.sourceforge.net (moderated for non-subscribers)
_


