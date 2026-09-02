Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC4383C8D;
	Wed,  2 Sep 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372057; cv=none; b=Zyso6Jq9ynyL5KpGe3F8rcJuO6Tjf3rMRvJaH+/ob4ql37133b6mpbzGRgh6YSLKvcfkzzodHLN/tGZctvhIbitE0JQ/z6WjQnJFAN76lFi7HvwbxWdISW0OhoQIIPjJdKMOsoG4k+w+582kIqc++KgCcnviYek6yFA5CDynLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372057; c=relaxed/simple;
	bh=8RUVAZRLPzU4llnS3oLrE03c3Dx8Fmtq1pWNn43ElvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZnPc/s+ojawkxaXGhVPBIRclcaL6kHhWiOR+Rl3+R5a5bonCqR8Lj9oXZiJChKCJr0ScEZLLDsJCbAJRjE0xuB/Q2VEWLt7gwz1eBnva/w1Pc60Gn9ZvtDj6ECcVCxhuVVo4VtBnlLK7YdjkvBuYu69pGiJ/w61dLOkezgm7U2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doxzFlR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doxzFlR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618101F000E9;
	Wed,  2 Sep 2026 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788372056;
	bh=jalqcGbTgpiwMOKCsH/rxa3bYllTMGaMYpLwBNB765E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=doxzFlR+siE8INCIvg2cvuz6MHpVNZMF68w2lxnCxkffbz1ZHhmabPy8brvZyPiaB
	 QnZToLPbA8CMmcfXQZeQkjbEtUfFMArC1EX06mMDwjMMCckjtZk5t1nxZ8/ZHv0ZAe
	 1bcr1zeQFzHK+bmBpqwtxYp9gQRp4RiFVGfahnqXT5zTP8gIvKBUNvGrIqJ6QYmbXb
	 GKSkmcJ6lxk7qWSFTH2WfCLTnWRC8noM0Vp8qi8kmAsw0MzXy+DqlaGD7nqJBmTdmN
	 0cn4w4vj63IRafwXlO9E2GjPAgLcsvqdUKtIomG+HD/Cm3WYilI4HzJgHj36RUbwSQ
	 34eVzChAWze1g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 02 Sep 2026 19:00:19 +0100
Subject: [PATCH 2/6] mm: implement file_is_dev_zero() to uniquely identify
 /dev/zero
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-map-private-dev-zero-v1-2-a578c730cec7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=ljs@kernel.org;
 h=from:subject:message-id; bh=8RUVAZRLPzU4llnS3oLrE03c3Dx8Fmtq1pWNn43ElvA=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJmpHiVax5h8JvsqLRXeYlzx+f1kz1m7N39TEJCWcg8e
 VmK26cXHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZhIXwTDf5esEO3qK6I3JjL+
 EF/356EG67sPB9dVcgX1COy/8+d57VSGX8wzGk9dfDZ5g87s/3Mapy92fMJc+C1KQNFpZ1yPUfW
 MeDYA
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

