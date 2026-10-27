Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072706;
	b=s5xfkUGIcRuuKkLBt6bSK2sZPt9HneY+yuhLyN2OdnGKPSvEGt5XiyQ9vEQuvYBDZlBb
	 8nkNOLP5vpwALyAbwBHiNPRFgYWhFzwZTEhT1knGjlTi4+iXq8hSRqPqF7+qLj58dttNy
	 BY1I3tbZ5M85+4EO3gYQgXK7LyqaKE2u0n0sKqz7StNFBRUP9SG09s1CMjJgs4L2OopEH
	 jC9NI4LzTD2HkIpWqhbye+TDh6zydtv5CRCyYngjCbKwxztrHplBmrTm7ny+5aNiOcAEk
	 wtzeX60/D49inOTRRGuoHQlrFpClMeTYYrKngF3gqps0K09z9CITlA8xWNVMSa6l9Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=7Mznwc8GrpzJ8tK5EL1ob+iPEtoev+BzmKX7CHPnJ74=;
	b=CKXfkd5GHSom2goRYSXDHo1WmzWa0x+n4GqtpHB+ANhTbqt2fzSI5lO18y2yI5IzDICf
	 iUzf2GWW5CfQ/8tk+RONY2V7oPIIFFj5aPMMPgwYuiU4nR7ak+rg6Zn40CoJk41+nmPdW
	 0ytXlFKnvAJ/qfy2DUAcPJkZXREcCZ3TplUN0gkiEMMryaX9M+mHyuMOhypgaqjAQ8YzS
	 GUtRD8HxsNJdXjJdRICcwgAG7sODA/aVJ4R5qYzmuySC0sECj9lRyJYn4uQd3H/xCBwf1
	 sgtLXP3lSw7K3QNs+W+lPT96+VCFmg1CKPSuneearYp5IfkJ5FTabV6uFMjZCGi0YLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LpEct1xf;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A69606A328
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 03:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77A69606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=LpEct1xf
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso570921766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 20:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072704; x=1793677504; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Mznwc8GrpzJ8tK5EL1ob+iPEtoev+BzmKX7CHPnJ74=;
        b=LpEct1xfjN1thI8TbP1fFa5w4w7QpAjyNF4cILo4hjgANhwzNTKcYl0/OAf4qytQ+D
         bTfw0B3W1YrJQBpG4CQa8BYUw8l2YA95j8Iad3IOM19h6jXJAZgZVZG4NeFqABxjmQVx
         cqyrWzfJOtShgzKATE8MA+KO/cZ6XpKKBzqfRYPV63n+KEkSREwYLpTIdKLylOucISku
         0b4t0cDOYZZ8VUkN5GYjeY7kLbNFUAZvUWcO7vKMGLuSX/T0QUI3kWhBk14nybsQgrpx
         sgvekJqRyNLDD3CwyDUMJUgSY/E+TGZ5+ZTFoQY3fbSMcNnskQ516a1VLRqdlAxCgpFM
         NMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072704; x=1793677504;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Mznwc8GrpzJ8tK5EL1ob+iPEtoev+BzmKX7CHPnJ74=;
        b=TZI/mvwxuXBbu28s3ZOLZ1SWsYqw+rLC0v5jxdiaotWyRt7kc3exAjwtAbxH12FoAC
         K/oC4dTfE6Kanxiwo4C4YAydep7VTII+C8Oselflco1htIf2dsri3/jaSmDHMUB23Lgq
         EYyig+ymwYVbuLbEHfMabE0psuk2KilF8+DpI91yQ63sV1vCFRV2z0S0U1hFRnj+7hEk
         X74WwTGacflejbL8Crgu1B7VKNVruFZh0OpFVJYfkXzoqlhS3KmeUSCbA4ypm4ObjrdA
         JWOT5VhDmz02OsVEN/fKLIHwBlkgfIDyNt1gshMcikC322bQN1BYXHHApwxXuawgJOuK
         yS1A==
X-Forwarded-Encrypted: i=1; AKwUvBzajDRGLqgTmfRsa9hdFhJcQLjTZ5jKK5ZjnXFtOzyl6/irLfIHN+NCA/98YPn1l9+0ZAlxYZ0FOM8BC97Z@vger.kernel.org
X-Gm-Message-State: AFq9FYKCi/TSzR7db2XXfdftIZ3qqnecWGqw0D+LCj/s7vqdQgK1Xf2X
	lfiu/tzCZ1+6CUIsJdG5wdboqZZ0gVeB+7Y72BD7EnqRJYTMDBBv6v4EZIjVcvg46nE=
X-Gm-Gg: AYBFou0nnTgzDs52dutDpG/e8BI+ln1rrg6EQKWwBFfCf7e+KNnkGCCfi9iKPz7XjL4
	SktZ8vfuecq4D70mLICVq73Gcd+XyvjEZ/cfORZfBvs/bpUWkXN9kM0BzFf0JvQWfCGKranMgsb
	RyiwyKm/9hO7OFxVuv1e/5PI2h40CCtrdZEHGdSeFEmzi99PP/RVcCO6Ji5ZQ+GQ8F6k3gJIYDY
	yRYnbXvKjSnErxZkGWa4pywIOvf0dW33mOqHU+FostQ2cbVCx2Q81sAKPmm5OgjbYek1XqVm67G
	6C67yQdC+8c9zxP8jVkfmu6z6aweE6AzFO04hKAetUk+F49yqQd1kLk344r1UMsG575QaP6bhHd
	dskZdMHovdCaeyLaq5OueHeSzsGgYxY34Tan1plqdUIwKrbsgpCto1F8j/EKWaPYxSs/WJnG3rr
	3gZOFOXtRwM/meT2XNQ0dv4NfRSUwScZ5vww33JpYU2yXG4aB/u4zWKi8+5AFKHo7aqMlA9BOeP
	g+1FlObVvHu02Y74uBgRHu84G3IRtny1qO7WAXps4Lc0/o=
X-Received: by 2002:a17:906:9f85:b0:c41:5a0e:3356 with SMTP id a640c23a62f3a-c46bded5befmr907107666b.41.1793072703836;
        Mon, 26 Oct 2026 20:45:03 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:49::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e7c83sm382468666b.30.2026.10.26.20.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:45:02 -0700 (PDT)
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
Subject: Re: [PATCH 41/46] mm/vma: call ->may_split() before a partial
 merge
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-41-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-41-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:45:01 -0700
Message-Id: <179307270137.1171062.14886397073081900278.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:18 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A driver can use the ->may_split() hook to forbid a VMA boundary at
> certain addresses.
> 
... snip ...
> 
> Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: improve description; cleanup the code ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Attached a vma unit test I used to test this

-- >8 --
From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] tools/testing/vma: test may_split during partial merges

A partial VMA merge moves a boundary just as a split does, so it must
consult the driver's may_split callback. Removing an entire VMA during a
merge needs no split check.

Exercise permitted and rejected partial merges in both directions through
vma_modify_flags(). Check the callback address and resulting boundaries,
including unchanged boundaries on rejection. Also check that a full merge
succeeds without calling a rejecting may_split callback.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/vma/tests/merge.c | 87 +++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/vma/tests/merge.c b/tools/testing/vma/tests/merge.c
index b26f1a66a1707..fcc052be15601 100644
--- a/tools/testing/vma/tests/merge.c
+++ b/tools/testing/vma/tests/merge.c
@@ -1488,8 +1488,95 @@ static bool test_expand_only_mode(void)
 	return true;
 }
 
+static unsigned long split_checked_addr;
+static unsigned int split_checks;
+static bool split_allowed;
+
+static int merge_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	split_checked_addr = addr;
+	split_checks++;
+	return split_allowed ? 0 : -EINVAL;
+}
+
+static const struct vm_operations_struct merge_split_ops = {
+	.may_split = merge_may_split,
+};
+
+static bool check_partial_merge_split(bool left_edge, bool allow)
+{
+	struct mm_struct mm = {};
+	vma_flags_t left_flags = mk_vma_flags(VMA_READ_BIT, VMA_MAYREAD_BIT,
+					      VMA_MAYWRITE_BIT);
+	vma_flags_t right_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					       VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
+	struct vm_area_struct *left = alloc_and_link_vma(&mm, 0x1000, 0x3000,
+							1, left_flags);
+	struct vm_area_struct *right = alloc_and_link_vma(&mm, 0x3000, 0x5000,
+							 3, right_flags);
+	struct vm_area_struct *middle = left_edge ? right : left;
+	unsigned long start = left_edge ? 0x3000 : 0x2000;
+	unsigned long end = left_edge ? 0x4000 : 0x3000;
+	vma_flags_t flags = left_edge ? left_flags : right_flags;
+	struct vm_area_struct *result;
+	VMA_ITERATOR(vmi, &mm, start);
+
+	left->vm_ops = &merge_split_ops;
+	right->vm_ops = &merge_split_ops;
+	split_checks = 0;
+	split_allowed = allow;
+	result = vma_modify_flags(&vmi, left, middle, start, end, &flags);
+	ASSERT_TRUE(split_checks > 0);
+	ASSERT_EQ(split_checked_addr, left_edge ? end : start);
+	if (allow) {
+		ASSERT_EQ(result, left_edge ? left : right);
+		ASSERT_EQ(left->vm_end, left_edge ? end : start);
+		ASSERT_EQ(right->vm_start, left_edge ? end : start);
+	} else {
+		ASSERT_EQ(PTR_ERR(result), -EINVAL);
+		ASSERT_EQ(left->vm_end, 0x3000);
+		ASSERT_EQ(right->vm_start, 0x3000);
+		ASSERT_EQ(mm.map_count, 2);
+	}
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_partial_merge_may_split(void)
+{
+	ASSERT_TRUE(check_partial_merge_split(true, false));
+	ASSERT_TRUE(check_partial_merge_split(false, false));
+	ASSERT_TRUE(check_partial_merge_split(true, true));
+	ASSERT_TRUE(check_partial_merge_split(false, true));
+	return true;
+}
+
+static bool test_full_merge_no_split(void)
+{
+	struct mm_struct mm = {};
+	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_MAYREAD_BIT);
+	struct vm_area_struct *left = alloc_and_link_vma(&mm, 0x1000, 0x3000,
+							1, flags);
+	struct vm_area_struct *right = alloc_and_link_vma(&mm, 0x3000, 0x5000,
+							 3, flags);
+	VMA_ITERATOR(vmi, &mm, 0x3000);
+
+	left->vm_ops = &merge_split_ops;
+	right->vm_ops = &merge_split_ops;
+	split_checks = 0;
+	split_allowed = false;
+	ASSERT_EQ(vma_modify_flags(&vmi, left, right, 0x3000, 0x5000, &flags), left);
+	ASSERT_EQ(split_checks, 0);
+	ASSERT_EQ(left->vm_start, 0x1000);
+	ASSERT_EQ(left->vm_end, 0x5000);
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
 static void run_merge_tests(int *num_tests, int *num_fail)
 {
+	TEST(partial_merge_may_split);
+	TEST(full_merge_no_split);
 	/* Very simple tests to kick the tyres. */
 	TEST(simple_merge);
 	TEST(simple_modify);

-- 
Gregory Price <gourry@gourry.net>
