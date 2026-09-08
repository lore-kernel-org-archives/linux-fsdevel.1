Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475752B1F3;
	Tue,  8 Sep 2026 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866718; cv=none; b=kSUsRwB0zS0G1QLAkrxhMEbhg10gZxbrd4WmUkGT3UJZkhXdLW2Jdfz1cUSVE5T37ntylUgVaZ/TChVZMshsjY3hXSppF1A4WO6YayvuUWYu6Zg136qR5lSsOOzvg5xuZsF+t+4AKsKkahCSfXuD7C/QhEnbQ8TOL9IDEBg640U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866718; c=relaxed/simple;
	bh=MuW0MgECKFqsgKYanDvHZ2zzAEiQ7iCtWQ9chN/jOZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlvPVHdLQSA/dtp4K3Je5ktZPOh4p79lAP0I5NUD31SL+38aHviqxtOOQ8Siy7Vy1kHJF/3jtv4ZLbribK/fYrpyx0baVc2iSVsnM2jtxmngU4lCXcAVc+PqhxaS1dDj/NgyErX6XNeprb4ws/ogStgEGUjzevNrxNOAkcZvGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCMynEAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCMynEAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AD51F00ACA;
	Tue,  8 Sep 2026 11:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788866704;
	bh=7INaOtP/gm2Q0CwFqGyhMMm+FXe4/enBYyOAMoEMKqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MCMynEAKWBBtZhM3TavPM2jvsMzLi/wfyDztSX3NadK30N7sH/KYNxbJTPna0++4M
	 lE5/YW5SRBTlhkna4Lws5EybILgPvC0mz3bRN3o/XuXaHJSrijVmszq4RtwnMsPVBk
	 tOxdnuRIffeKcofQSiJ2BFhlxP7re6LrwYSQqSruLSMCYgIi7gSFC1fU3mWxbSwn4C
	 2U+Gg1vY0dCzE7kFhijpKTkoX/Y/4vufVgfmUDopjMu7NmDgrK2ifxh9J+NzmNpcQz
	 W22w2Kx727HvIXnbGmnxss/iKzUM2ixk4xg/yUsDdYwCClDW/MQzaRRQij+TWvnTyd
	 xTbP10Rd5uwfA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 08 Sep 2026 12:23:42 +0100
Subject: [PATCH v2 5/6] tools/testing/vma: add test to assert
 MAP_PRIVATE-/dev/zero is anon
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-map-private-dev-zero-v2-5-acc7b5625305@kernel.org>
References: <20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org>
In-Reply-To: <20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org>
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
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLmfyg80KuTMs9Z7srfjee93Bu2eq+dea5h49YnP6/36
 a5/o1EQ3FHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJyGQzMhzsOGP3+heLprbt
 OzWrS8qzdvEn8PpYXC9/MOmUscrVH5sY/udIy2aduTOvet7fSVJMds/c3ydt2yGZ4hOf4VAdVFu
 zjAEA
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

