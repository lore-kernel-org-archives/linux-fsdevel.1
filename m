Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A4436371;
	Mon, 29 Jun 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745471; cv=none; b=OOl24NqfpuN9y4+bUbKVo2gj65GcSQWrpiCtJs/4cTAfbQssgIqKsa6q2ii2OdMby3Omzl8XsFvwLBDxNpz7Jyfegmav3HxAVXz+D3TXGpU55iDyYRvAufkKBOWfD022RXlONQsfmg57pD1iFbadSBql1XIg1N/z471JOtXHPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745471; c=relaxed/simple;
	bh=O4avcRsyf8+0gUCxxo/NyVLU8Y23EYpL4KhL+iQahKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDIRFWtzi0t0mDHWTnOpEhRP0SeFxYOq3BwajvtCkkoZfu2fIjJAEY1SiTQj40oK5ueDS+vLQnf+ArRuYfA7lTcROWvDFtjdjMeydknhZb0hH4cxbd+ayq9/Y2Zu3ayfyOvABEFvXfFuL1fNF8kUPt1HesiBzNfI+Fpi1F6vvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDdHoGFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDdHoGFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447B01F00A3D;
	Mon, 29 Jun 2026 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745470;
	bh=nA2C3XBTN1q0WcJk6ELo4naB4k1FNURRRYd8Aaer7J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aDdHoGFhbHBHr9Wo2nZbV+UXVCXPYo+/kr/CvVZZvKtagVRqkoFHd0CJmm1V4rkVj
	 ABBHKI3OCUZWK8YPsNmTFfaxkGTbnrpQO4HPI5WM9D02JzkwwYwms1yiRb5bW8wTC3
	 brFIAueYWhP0KB56B7ETbMcWd8XVHuhjcOc/PbV7ol1U8ogSL78VtSlVAAf7arIxux
	 9wB1+OTFwTiAB0Mri28H7PA2z76FQYL8d4zmGSBrMLF1uYAILp/uvBJWaCtgtkzj3R
	 aqcA8RiQ4+xzFKXeaHcxvcqPXjc/eW0CvFAyKxsw4SeXf57PlE9v3XbHQHmSWkCDDM
	 8WfSrSn2Usi3A==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 10/10] tools/testing/vma: expand VMA merge tests to assert virt pgoff
Date: Mon, 29 Jun 2026 16:03:50 +0100
Message-ID: <4a9091aed50a851deac9947523ee8a08f4183113.1782745153.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782745153.git.ljs@kernel.org>
References: <cover.1782745153.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we have introduced the VMA virtual page offset attribute and update it
when VMAs are manipulated, update VMA merge tests to assert that the
virtual page offset is as expected.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 tools/testing/vma/tests/merge.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/vma/tests/merge.c b/tools/testing/vma/tests/merge.c
index ed8fa0d7da97..ca415052fd8c 100644
--- a/tools/testing/vma/tests/merge.c
+++ b/tools/testing/vma/tests/merge.c
@@ -121,6 +121,7 @@ static bool test_simple_merge(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 	ASSERT_FLAGS_SAME_MASK(&vma->flags, vma_flags);
 
 	detach_free_vma(vma);
@@ -153,6 +154,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_start, 0x1000);
 	ASSERT_EQ(vma->vm_end, 0x2000);
 	ASSERT_EQ(vma_start_pgoff(vma), 1);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 1);
 
 	/*
 	 * Now walk through the three split VMAs and make sure they are as
@@ -165,6 +167,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x1000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 
 	detach_free_vma(vma);
 	vma_iter_clear(&vmi);
@@ -174,6 +177,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_start, 0x1000);
 	ASSERT_EQ(vma->vm_end, 0x2000);
 	ASSERT_EQ(vma_start_pgoff(vma), 1);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 1);
 
 	detach_free_vma(vma);
 	vma_iter_clear(&vmi);
@@ -183,6 +187,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_start, 0x2000);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma_start_pgoff(vma), 2);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 2);
 
 	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
@@ -212,6 +217,7 @@ static bool test_simple_expand(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 
 	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
@@ -234,6 +240,7 @@ static bool test_simple_shrink(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x1000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 
 	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
@@ -346,6 +353,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x5000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
@@ -367,6 +375,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
 	ASSERT_EQ(vma->vm_start, 0x6000);
 	ASSERT_EQ(vma->vm_end, 0x9000);
 	ASSERT_EQ(vma_start_pgoff(vma), 6);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 6);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
@@ -387,6 +396,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x9000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
@@ -407,6 +417,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
 	ASSERT_EQ(vma->vm_start, 0xa000);
 	ASSERT_EQ(vma->vm_end, 0xc000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0xa);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0xa);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
@@ -426,6 +437,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0xc000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
@@ -446,6 +458,7 @@ static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky,
 		ASSERT_EQ(vma->vm_start, 0);
 		ASSERT_EQ(vma->vm_end, 0xc000);
 		ASSERT_EQ(vma_start_pgoff(vma), 0);
+		ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 
 		detach_free_vma(vma);
@@ -808,6 +821,7 @@ static bool test_vma_merge_new_with_close(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x5000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 	ASSERT_EQ(vma->vm_ops, &vm_ops);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
@@ -868,6 +882,7 @@ static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bo
 	ASSERT_EQ(vma->vm_start, 0x2000);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma_start_pgoff(vma), 2);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 2);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 2);
@@ -934,6 +949,7 @@ static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bo
 	ASSERT_EQ(vma->vm_start, 0x6000);
 	ASSERT_EQ(vma->vm_end, 0x7000);
 	ASSERT_EQ(vma_start_pgoff(vma), 6);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 6);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
@@ -1419,6 +1435,7 @@ static bool test_merge_extend(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x4000);
 	ASSERT_EQ(vma_start_pgoff(vma), 0);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
 
@@ -1459,6 +1476,7 @@ static bool test_expand_only_mode(void)
 	ASSERT_EQ(vma->vm_start, 0x3000);
 	ASSERT_EQ(vma->vm_end, 0x9000);
 	ASSERT_EQ(vma_start_pgoff(vma), 3);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 3);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(vma_iter_addr(&vmi), 0x3000);
 	vma_assert_attached(vma);
-- 
2.54.0

