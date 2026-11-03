Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.160
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687198;
	b=qnLhQQexl1WHFwmp43WfOsy1ZSqtveVkWPaTSWGTXXr73djQdb0Z1+ickh7tUrHyFBh3
	 pBsu+7rTcoGdLOJRkJ83WZDirexrI0LaQHxUcVj2vHA3LfV6398QNx5K+EpXd/dx/OCT2
	 zBugs5Tl+VrqLpX9XWfVGzI8ksqAOk21Wf53WQF/Ehl0YgTSsO/GGZkbXg0Xrbi2xQEWZ
	 8qg6KLrOScXGRdYXoL+64VsdovrM3e0DdO/mZepNSIwB+5ZHmJ3ih3fiZJVPNL9hC2IFK
	 MWI6AJChPiRaic/bWte3V0pEHVrPZxDpRJfumDHZg6sfQ9+PkiaWLhUDXx3CCXu4vmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687198;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=89WHsBI4UooPN0e/fzWqgj/M9hLD/tFhYxvpr6aA8I0=;
	b=ve/6BsZV6I8v/FwyzBsNDjRjHkP3KoA2xjleTiF0dPOtsFovQw0cUbPHQtHIp69meUSq
	 6rlsR9ESo2+nHNLmblsFALxIfVnbmKk8ynKpfCg8cu5ltpEhCn9lR0IbJKisIfdxTOM5z
	 VC/WTtVAKcphitZDI3nXOS09SeMUohcq0aUU0OyZmmtzA9IL1wyZNqtAGC+1p1bXtqwMW
	 kB0j7ZbANCOg84Q8Nd0WloL5GjOMLrZaKAsJxIJnhm84yiklFJf7ngszFyU62LkRiUMwI
	 eN+B0/QV0bRFWnFXJt8Nk7eISCAzB6z5A6wDL3RRW493d/aZWxJVrS4PgiNsPcFtYDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BrQ5Opza;
	arc=none smtp.remote-ip=95.215.58.160
Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA9606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 06:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABA9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BrQ5Opza
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=R4qncA5U596ba8pavgxH4k05FBMaxgAUsAOufRDPVI0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793687194; v=1; x=1794291994;
 b=BrQ5OpzasmaKN5c4rG+lUhIWYHYwU9Zu/yaL7ECDfW6bWPv8oJYd/xoJtaPXoBVLlimlpMUD
 hxMHJYVuqCPlSy9lE3cTmbFIqjIxFUJWVmK1PEWGFGvTx3eyIQsy580HKxs6eKEmRludRp7iNyI
 96WyFglyjScKawmHaqcOgHAs=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 650e1e2cc95fd22e;
	Tue, 03 Nov 2026 06:26:33 +0000
X-Mizu-Trace-ID: 650e1e2cc95fd22e
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 38/47] mm: fix deadlock of mremap() against UFFDIO_MOVE
Date: Tue,  3 Nov 2026 14:26:28 +0800
Message-ID: <20261103062628.92242-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-38-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-38-d6437171ecc3@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:40:07AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>With per-VMA locks, UFFDIO_MOVE can run concurrently with mremap()
>on different VMAs in the same mm. Those VMAs can share page tables, so
>both operations can acquire the same pair of page-table locks.
>
>UFFDIO_MOVE orders the locks by address, while mremap() takes the source
>lock first. These conflicting orders can deadlock; mremap() holding
>mmap_lock for writing no longer helps.
>
>Move double_pt_lock() and double_pt_unlock() to mm/internal.h and use
>them for all page-table moves in mremap(). Preserve the source entry
>checks after acquiring both locks. Remove the comments claiming that
>exclusive mmap_lock makes lock ordering irrelevant.
>
>In move_ptes(), make sure to just recheck source and destination PMD
>after taking the locks and drop the overly-long comment.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>[ david: use new helpers consistently; simplify description and comments;
>         move_ptes() fixup ]
>
>Fixes: 867a43a34ff8 ("userfaultfd: use per-vma locks in userfaultfd operations")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Acked-by: Muchun Song <muchun.song@linux.dev>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
