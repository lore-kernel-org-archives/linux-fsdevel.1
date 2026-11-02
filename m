Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621966;
	b=TRhlAHCQPXD6MDaK4PtER/j3dpqXEfiiWBxzlHk0zd1/AoL4rO3RaTLp0NQYNcrK28la
	 ViJNRlQAc1HucPkKHZZQq0nbn5ISz9CjGbrQ5+VLSlVtPU47y9Pmg6fmVR0SH23SzUmKY
	 MagjQ0JHpXf/I40z1AXn4q/doWo8O0QehJfxlFWrf36AZV0m5Tpj/eqCKfXErc/nY3yVk
	 rR+A6JojXtd5GhhxAhztTZYxwbyhjxYOfxphYc9B0OyRPci0y7bxqGRcLvcnLgpjOYpuF
	 KVtqHMYdiB99/j5LalvPDddpKmZSeNPB96ic07BFN8Ei9TrVg9zlnPa9SDZR8oXfEDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621966;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7aamrL1eeNrbIdMSN+jaXpW6b7pg64KUgg9/NR7r4M8=;
	b=HPr60uh5lOP5opcnlXrOPWM+wfu2oRn/nD2jXQ2xYL8cByuaE6GOLPoSWbVlNN8z9gcY
	 CyCaOtBjWvJtm4YOWUfgs/sxZtnNEMop7Mbu3RaVw48LQA9pXzVZKfUpcY2R6vooGhqhU
	 9xYkhxGEznKS5lK38NIGGEflGqQnFCA/XW9BJmV/6b85Rox/IW/U8mL1hNG2fFV0JoZZQ
	 +dlSNUaUkx9toYIUlyoZFgoSfmftEhVJTmv8AZdsetTM+uddGUWHemx06Pu0aS8MB5rDD
	 VFN5mpmlWqleGSFFkkoSOjNrfd4GL6kJZhlhOH+HELvvZ39lfZuwKcFVdj2l2th5UUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z6X9Wt1f;
	arc=none smtp.remote-ip=95.215.58.172
Received: from mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43964606A33F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 12:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43964606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z6X9Wt1f
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r/y28Pr8KNBr61CZIB3z7msn3ARAQOG25oOo8bDyEqs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793621962; v=1; x=1794226762;
 b=Z6X9Wt1f2OM0mk9Cvw5ZsBYTsSsI5PkwaBYJjVaRrHKRsTE9x/ymuRWOcLnrF28+pJweuNV7
 6EzFPwGVjc92CRJwXYeA37ONO25xqpbqAElMy37M/9RJ7oZUyP837HGQFBUQd7QRrP3u8yb4+GD
 5HLS9jSoxykzaPBgfV1a8xbo=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c966688054ce713b;
	Mon, 02 Nov 2026 12:19:21 +0000
X-Mizu-Trace-ID: c966688054ce713b
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
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 31/47] mm/mremap: recheck PUDs under the page table lock
Date: Mon,  2 Nov 2026 20:19:14 +0800
Message-ID: <20261102121914.69229-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-31-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-31-d6437171ecc3@kernel.org>
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


On Sat, Oct 31, 2026 at 10:40:00AM +0100, David Hildenbrand (Arm) wrote:
>Once get_old_pud() is fixed to accept PUD leaves, unmap_mapping_range() can
>clear a leaf between the lookup and the move. Holding mmap_lock in write
>mode does not prevent this.
>
>If the zap happens before move_page_tables() tests the entry, an empty
>PUD can reach move_normal_pud(), where pud_populate() turns it into a
>present page table entry. If it happens after the test, move_huge_pud()
>can instead try to move an empty entry, triggering CONFIG_DEBUG_VM
>warnings on powerpc.
>
>Recheck the source under the page table lock in both helpers. Treat an
>empty source in move_normal_pud() as a completed move, and use
>__pud_trans_huge_lock() in move_huge_pud().
>
>In the future we should likely have the code lookup a PUD/PMD lockless
>once, instead of multiple times, because one of the problematic bits
>here is the:
>
>	pud_trans_huge(*old_pud)
>
>Fixes: 0881ace292b6 ("mm/mremap: use pmd/pud_poplulate to update page table entries")
>Cc: stable@vger.kernel.org
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
