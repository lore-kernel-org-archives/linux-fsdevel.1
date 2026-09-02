Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3A368D78;
	Wed,  2 Sep 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372071; cv=none; b=bnJO9RAeNhXrEZlivqY0nRPJGVoLCWVtVVt2ojglIqXJ/8rR7BnQ63TzV4GOKTrCFFB0kQlekitArzn+d6t0rP/C9ucmGoaP0bnPJmFqtLqRhb9/YUmDcCpxKfmUtLZFI2lxTZha/rUnqby1KMBD52KPPaThaV9+nOFAp9LRLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372071; c=relaxed/simple;
	bh=MuW0MgECKFqsgKYanDvHZ2zzAEiQ7iCtWQ9chN/jOZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7k/QaVKX2SQvJ3ansWPVlXaFiaF9MprlFbN6XHp+jLAPC9TloUgtpRNW4RdxDW6g1MNdOrpWzRG8M901/suxFqUpSfvu/7FMamXm/k+76gbhb4A8Vl19t0/6JW2xw68vO4bOLoQvtU10pN8cO22xbbulvbJSzn9igGDgvqUp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHevDBYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHevDBYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87DA1F00A3A;
	Wed,  2 Sep 2026 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788372070;
	bh=7INaOtP/gm2Q0CwFqGyhMMm+FXe4/enBYyOAMoEMKqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aHevDBYl5hjaNDNwhdaa8kY7f11J7SCp88tnXt+ak5jBNNMaNCZL/SLusgaHNCK/p
	 SZK9/Y1HaQ+x9hnq/BEjr+Jny3I4XQV12hx0fC7aOkDw5uke0RQGFPEeQuvkqKMyrr
	 0WvkYPYhDB9F7/zmeNrKwq/onEoa1yXvZ5cH60X1b40vRUdiOkMTl2B2viY2Qd6yP1
	 4SJeiZIVXf3dYH6RVJ5WXuaNVVV6XkbNx5hZfC6qjhrLTcDiGSqVoAlI6zr9Lylkrx
	 9poIzuEr+0GEGqSLXCLnwbqno0TlpN3MYCs/drYw5DrjU9FgggUiglJXMEQ29by99m
	 SqrfqhwqLkHWg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 02 Sep 2026 19:00:22 +0100
Subject: [PATCH 5/6] tools/testing/vma: add test to assert
 MAP_PRIVATE-/dev/zero is anon
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-map-private-dev-zero-v1-5-a578c730cec7@kernel.org>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
In-Reply-To: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=ljs@kernel.org;
 h=from:subject:message-id; bh=MuW0MgECKFqsgKYanDvHZ2zzAEiQ7iCtWQ9chN/jOZY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJmpHi9nvw5TIiDx717l+IWCYn9hvfbghpNU3+UHZhwd
 Ifr/36GjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzkmDkjwzuF0m63Ml359V7H
 NU1u3tJ+G1/wwdk+yDO64Ny5w3PjNzL8Yv678MJ/N2c2vfUGW7bmrdtdyCK598aDmPgrHVk5E5Z
 c4QcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Now we've made MAP_PRIVATE-mapped /dev/zero mappings truly anonymous, add a
VMA userland test to assert that this is the case and everything is as we
would expect for an anonymous mapping.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 tools/testing/vma/tests/mmap.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
index c85bc000d1cb..fa73faff2262 100644
--- a/tools/testing/vma/tests/mmap.c
+++ b/tools/testing/vma/tests/mmap.c
@@ -45,7 +45,44 @@ static bool test_mmap_region_basic(void)
 	return true;
 }
 
+static bool test_pure_anon_dev_zero(void)
+{
+	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
+	struct file file = {
+		.f_op = &zero_fops,
+	};
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma;
+	unsigned long addr;
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	current->mm = &mm;
+
+	/*
+	 * Map a MAP_PRIVATE-/dev/zero mapping at address 0x300000 with a page
+	 * offset of 0x10, which we expect to be reset to the anonymous page
+	 * offset.
+	 */
+	addr = __mmap_region(&file, 0x300000, 0x3000, vma_flags, 0x10, NULL);
+	ASSERT_EQ(addr, 0x300000);
+
+	/* Assert that it truly is an anonymous mapping. */
+	vma = vma_lookup(&mm, addr);
+	ASSERT_NE(vma, NULL);
+	ASSERT_TRUE(vma_is_anonymous(vma));
+	ASSERT_EQ(vma->vm_file, NULL);
+	ASSERT_EQ(vma->vm_private_data, NULL);
+	/* Expect anonymous page offsets. */
+	ASSERT_EQ(vma->vm_pgoff, 0x300);
+	ASSERT_EQ(vma_start_anon_pgoff(vma), 0x300);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
 static void run_mmap_tests(int *num_tests, int *num_fail)
 {
 	TEST(mmap_region_basic);
+	TEST(pure_anon_dev_zero);
 }

-- 
2.55.0

