Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698640E8FC;
	Sat, 26 Sep 2026 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419296; cv=none; b=R0MrPeHyBInByj0qZ8VRa7glUhBuH6kcQ6BorSdUgv3iXktDX0UzYKX+Xh4/7oyaAZm+9VKmrQ/5uzxpBMR7ZW0hS83ZqfMbmyqjSrgyUryvmVRpcWe5bR4mn8BiNLdsDQyjnS11cb9zC6kGkjFc4krQtkZBnjJUq8Ztzw01cEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419296; c=relaxed/simple;
	bh=A0bJ64HW79psSPlOLCnw7EMt+8G8UJeBpFvBmWrksO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHYS5Bj862L96d//iMaYJfIG9y38eSY1x6Uw5lyZRP27V8MKQO7Q62+0DHey1WyYhdKTujRJ0H2+TrVamlvoHEi9fzVWksujvco+OYdCTJ0GXnzn918Q8NJm3jR0kBqX8YBSArCfXx779sZF5ejk+9CvyiL8X1EB3ir21eEUyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf3UH823; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf3UH823"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051C41F00898;
	Sat, 26 Sep 2026 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790419291;
	bh=QpNjJERy5W0kZ4sRAK5DqssDq5giEzAZ8nJVAHeIm7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bf3UH823SDyPigbs7RNHaNH2jKNNG8Cihq4p8htIHOFP0y5JPaxJKzygUs/G0S41+
	 qvH12ic20EaJ9etadHm39FyDSWwS/1JqRu3taTIBWeIhsTJNSXxxULGOc1zSRZU1e8
	 /NkpnZRm2YbTo5anSZ3jMGIiuSo/Wj6yes7xyynt+PFF7DD8i+JRTRkF4pJCWaqw10
	 YXLw3YB193YrQs0PmKXPMMgvy6eJ1hMGZOeQBbFCQbOFZpAXXIAsss//DISRZ+S18w
	 oD1HDq0RdLj6II9up3zANivAUvWWKAN84FV03dw2h7iZcA3DR2dpboP2KN2P4SXG4U
	 2J+uMGvjwkokQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 11:41:07 +0100
Subject: [PATCH v3 2/6] mm: implement file_is_dev_zero() to uniquely
 identify /dev/zero
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-map-private-dev-zero-v3-2-d4781e84ccfc@kernel.org>
References: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
In-Reply-To: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2988; i=ljs@kernel.org;
 h=from:subject:message-id; bh=A0bJ64HW79psSPlOLCnw7EMt+8G8UJeBpFvBmWrksO0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2L/SZUz/xt+YCHmOZAPNVR/emF+mUGhpznuz9NHu/+
 ZlfkYv7O0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjARUUNGhofakp8W1xypEPqm
 YdMh/+jFtb13zgT8z7tm055uai8VZM3IsF4kyNlMPifU9laL+nZRr5jX7YHa1pt04kysJuazPJb
 mAQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

To lay the foundation for a future change that converts
MAP_PRIVATE-/dev/zero mappings to be truly anonymous, add the ability to
uniquely identify these mappings.

With the memory character device now part of mm/ this is trivially
achievable through a file_is_dev_zero() predicate that simply tests that
the file operation hooks are zero_fops.

Also update userland VMA tests to expose file_is_dev_zero() and provide
a stub zero_fops for testing.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/char-mem.c                   | 13 +++++++++++++
 mm/internal.h                   |  3 +++
 tools/testing/vma/include/dup.h |  7 +++++++
 tools/testing/vma/shared.c      |  9 +++++++++
 4 files changed, 32 insertions(+)

diff --git a/mm/char-mem.c b/mm/char-mem.c
index d2e575545044..e53e89e6ddd8 100644
--- a/mm/char-mem.c
+++ b/mm/char-mem.c
@@ -31,6 +31,8 @@
 #include <linux/uaccess.h>
 #include <linux/security.h>
 
+#include "internal.h"
+
 #define DEVMEM_MINOR	1
 #define DEVPORT_MINOR	4
 
@@ -707,6 +709,17 @@ static const struct memdev {
 #endif
 };
 
+/**
+ * file_is_dev_zero() - is the specified @file associated with the /dev/zero
+ * driver?
+ * @file: File to test.
+ * Returns: true if it is, false otherwise.
+ */
+bool file_is_dev_zero(const struct file *file)
+{
+	return file && file->f_op == &zero_fops;
+}
+
 static int memory_open(struct inode *inode, struct file *filp)
 {
 	int minor;
diff --git a/mm/internal.h b/mm/internal.h
index e16f1250b25c..5d474e5f7709 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1638,4 +1638,7 @@ static inline bool can_spin_trylock(void)
 	return true;
 }
 
+/* char-mem.c */
+bool file_is_dev_zero(const struct file *file);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 57046d8ac81d..0d1a2ac88922 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1641,3 +1641,10 @@ static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
 
 	return pgoff;
 }
+
+extern const struct file_operations zero_fops;
+
+static inline bool file_is_dev_zero(const struct file *file)
+{
+	return file && file->f_op == &zero_fops;
+}
diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
index 4a39c9d50489..8c4826499f40 100644
--- a/tools/testing/vma/shared.c
+++ b/tools/testing/vma/shared.c
@@ -12,6 +12,15 @@ const struct vm_operations_struct vma_dummy_vm_ops;
 struct anon_vma dummy_anon_vma;
 struct task_struct __current;
 
+static int mmap_zero_prepare(struct vm_area_desc *desc)
+{
+	return 0;
+}
+
+const struct file_operations zero_fops = {
+	.mmap_prepare = mmap_zero_prepare,
+};
+
 struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 		unsigned long start, unsigned long end,
 		pgoff_t pgoff, vma_flags_t vma_flags)

-- 
2.55.0

