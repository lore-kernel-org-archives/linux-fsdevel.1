Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9A3B14BF;
	Mon, 20 Jul 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558469; cv=none; b=ByrCnWvsUyytVfs0ExkBI3BmX9dQ+lZjCYQtOCsJAjwokHsF3Ef00qw51xaQLzCroWdy98aAHTr11Sif79kTlOiYo9LoB+/jX+KED/xFbflrhGsjBG36t/De1YQWZrvbydYN9Fe41aQi39+h6nZY5ZLuDP6FA4pQZdIsmJltubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558469; c=relaxed/simple;
	bh=Ek6diG5p2xt2cOjPk+/pZ4HE6uM0F3720J7ylrqFTU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vy90WguiH+F+HM3CA5eRwEzpwUXePkrFivX3ptVnrKTol35LhQT+pGTGMEt1mwTYVZg6Tg41pc4SjDE1quyvETNu/XpvNIj66bQhPHIpVNa/rWXbny0DfUuqSKyry0TuLLv3Wd+PHPuUJCdU1JXBGHfv2dErp9rr8XRsce0jSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or2RLRHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or2RLRHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01771F00A3E;
	Mon, 20 Jul 2026 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784558467;
	bh=mUfRyzu4r4T3oUIBL7M02RpvtLmtjfRfrYDjBQ2+mno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=or2RLRHU8FZwq15jHcSooMC21IyoNtOp2GAZj/MrF6axYBvTNV5uuVRhkwy97o22r
	 OtDicyiXwFPWkpvl1dOPymS/Qe/t1Y8TtBDz1vt8shmD8fc7fVZFjMsIIGq0pDAbMT
	 NEunsqU5yT3+joKbcNdlW2MFk++0CSOSMMj9cUFxSY/qCI6bR+MzJKHdFNP81JYzWT
	 RgoknuUd+ZMEk3ra5UvSUMW9jiyLbnWKqUF8YBlVMfNVK0LoF6bQZujd/XSteqQhyf
	 UNDN78ZwWWQ179KcfKz6vHJsHmgTxY4KHFmfaCQgv/KM3UKNe4+dl/kRMUpPxTguPd
	 6fzeDCZTPffng==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Mon, 20 Jul 2026 15:38:40 +0100
Subject: [PATCH v2 14/15] tools/testing/vma: add test to assert
 MAP_PRIVATE-/dev/zero is anon
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-b4-scalable-cow-virt-pgoff-v2-14-2d549757a76f@kernel.org>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
In-Reply-To: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2647; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Ek6diG5p2xt2cOjPk+/pZ4HE6uM0F3720J7ylrqFTU4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLijN76quqn5K107j4fvE6K3TnS47qE7YWVRk2REkVey
 geW287rKGVhEONikBVTZHn+RXx/kEjYvM4L/m4wc1iZQIYwcHEKwETu3Gf4Z1JTuHbi4ju35yhz
 fVfL/51gdelDycsli5nXV0zqua2/I5/hn+3//4d27ee+rvoqR0m4wfroafmaoNzze3bv22idx9N
 gxwQA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Now we've made MAP_PRIVATE-mapped /dev/zero mappings truly anonymous, add a
VMA userland test to assert that this is the case and everything is as
we would expect for an anonymous mapping.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 tools/testing/vma/include/dup.h |  1 +
 tools/testing/vma/tests/mmap.c  | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index c5191b9718fd..47a91e35efe5 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -20,6 +20,7 @@ struct task_struct *get_current(void);
 
 #define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
 #define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
+#define MKDEV(ma, mi)	(((ma) << MINORBITS) | (mi))
 
 #define S_IFMT  00170000
 #define S_IFCHR  0020000
diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
index c85bc000d1cb..b720deb4227d 100644
--- a/tools/testing/vma/tests/mmap.c
+++ b/tools/testing/vma/tests/mmap.c
@@ -45,7 +45,57 @@ static bool test_mmap_region_basic(void)
 	return true;
 }
 
+static int dummy_mmap_prepare(struct vm_area_desc *desc)
+{
+	return 0;
+}
+
+static bool test_pure_anon_dev_zero(void)
+{
+	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
+	const struct file_operations f_op = {
+		.mmap_prepare = dummy_mmap_prepare,
+	};
+	struct inode inode = {
+		.i_mode = S_IFCHR,
+		.i_rdev = MKDEV(MEM_MAJOR, DEVZERO_MINOR),
+	};
+	struct file file = {
+		.f_inode = &inode,
+		.f_op = &f_op,
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
+	 * offset of 0x10, which we expect to be reset to the virtual page
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
+	/* Expect virtual page offsets. */
+	ASSERT_EQ(vma->vm_pgoff, 0x300);
+	ASSERT_EQ(vma_start_virt_pgoff(vma), 0x300);
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

