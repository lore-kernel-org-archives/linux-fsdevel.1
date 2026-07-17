Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3A35B137;
	Fri, 17 Jul 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309260; cv=none; b=XgvIJBCSwOQ4zHZWFxXYVa/CO0MNe3G8sXMJR5Rg5lGjNMQC+mDXXRSOIkTTvgcgPVhq4cVNH4W7QD4Ur+TmtBPjf0uh8yXuISfWliE7G9Zyvialj0CAyAghLOKr9tpapvaf37C0hZRCa2bS07R9DnwFN8FpSrKqKjwa/CkLZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309260; c=relaxed/simple;
	bh=zNaXN89YTmnYqq+jHnFLlAdY8+gqqdMCq58SBYujaWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULCPdhY51LgxR86MKHrknZ61m/CJQGHZikQABFe+9x1AdP+vfz62gQzzTy/ptHsUbe5KfG2x6CRwUOzgIK+8s5Lgn/W+/C7dSo2i5f5MaluZBC7pZ5QXjt+vienKrdk43xW//XgD+Sd7anSGko3GMPk7L5nnXYCsbB8QvWRgXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5lrnV+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5lrnV+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E87D1F000E9;
	Fri, 17 Jul 2026 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309259;
	bh=C8715hya/g0NKVec9bzb/sd63YPbKJXZUIO5+V7cVQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h5lrnV+NVw1sZK8KnxqV+HWsnNdAyHsFT0M3MXrmdEn2VGhpfscesbf5LsHGWtqVz
	 wLyNn4Y+o/JXKEzS/O35+n4FwxEefrTM13NDrKh4ilX2wQTHIqJXpNkB9BCqqoVCzk
	 O+BQMJLV46NT74u7C5nX2Ze4ZgIzk9JwCa5TcLExD7Ht+U7aEEzO146bEO3iMEAfcy
	 jOHNVEHGqAOBJBoW6nSTe7wPtZQe1UxCe15QrB3/napbdHrbLhWwebKMARAOHDpFz0
	 Up8aK7M1f/Pf17zrGP+18lrqY8d9fa7nNOY6EuOo81Vr20d0wQhGp6jIk7aKAK0x1g
	 bY71h2H032Sbg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 17 Jul 2026 18:27:10 +0100
Subject: [PATCH v2 2/3] mm/mseal: limit scope of mseal address zero to
 address zero
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mseal-fixups-v2-2-0daa0014b813@kernel.org>
References: <20260717-mseal-fixups-v2-0-0daa0014b813@kernel.org>
In-Reply-To: <20260717-mseal-fixups-v2-0-0daa0014b813@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4628; i=ljs@kernel.org;
 h=from:subject:message-id; bh=zNaXN89YTmnYqq+jHnFLlAdY8+gqqdMCq58SBYujaWg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKiUr84Xw99n3I+OZ+lMKKvQ/3vuTfauvFFfZ0OPk8kP
 ZYL7LvbUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIlYv2P473dJM6mISfj9x9O3
 g58wGGennVrx5fWRU1MqeW85Pzj07i/D/5AVCc/mhy48O0FoaZmc3qeXy/5xWFzfOXPx6XOOxwQ
 ufOEEAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit 44f65d900698 ("binfmt_elf: mseal address zero") unconditionally
provided do_mseal() to any internal kernel caller in order to address a
corner case slated for possible removal.

It also incorrectly attempts to mseal without checking to see whether the
mapping even succeeded.

Restrict the scope to the corner case by providing mseal_mmap_page_zero()
which asserts the MMAP_PAGE_ZERO personality.

Avoid unnecessary checks in the start, end range by abstracting the actual
mseal()'ing to mseal_range() and have mseal_mmap_page_zero() call that
instead.

Also only try to seal the VMA if we mapped the VMA. This isn't strictly
necessary as the operation would error out anyway, but it's useless work
and could be problematic if me make future changes to mseal semantics.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 fs/binfmt_elf.c    |  7 ++-----
 include/linux/mm.h |  8 ++------
 mm/mseal.c         | 49 +++++++++++++++++++++++++++++++++++--------------
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3f6c..e3131a311995 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1353,11 +1353,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		   emulate the SVr4 behavior. Sigh. */
 		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
-
-		retval = do_mseal(0, PAGE_SIZE, 0);
-		if (retval)
-			pr_warn_ratelimited("pid=%d, couldn't seal address 0, ret=%d.\n",
-					    task_pid_nr(current), retval);
+		if (!error)
+			mseal_mmap_page_zero();
 	}
 
 	regs = current_pt_regs();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 550fb92957d1..87feaa5a2b78 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5291,13 +5291,9 @@ int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *
 int reserve_mem_release_by_name(const char *name);
 
 #ifdef CONFIG_64BIT
-int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
+void mseal_mmap_page_zero(void);
 #else
-static inline int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
-{
-	/* noop on 32 bit */
-	return 0;
-}
+static inline void mseal_mmap_page_zero(void) {}
 #endif
 
 /*
diff --git a/mm/mseal.c b/mm/mseal.c
index 430a252a6da4..2a516da694c6 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -32,7 +32,7 @@ static bool range_contains_unmapped(unsigned long start, unsigned long end)
 	return prev_end < end;
 }
 
-static int mseal_apply(unsigned long start, unsigned long end)
+static int __mseal_range(unsigned long start, unsigned long end)
 {
 	VMA_ITERATOR(vmi, current->mm, start);
 	struct vm_area_struct *vma, *prev;
@@ -66,6 +66,38 @@ static int mseal_apply(unsigned long start, unsigned long end)
 	return 0;
 }
 
+static int mseal_range(unsigned long start, unsigned long end)
+{
+	int err;
+
+	err = mmap_write_lock_killable(current->mm);
+	if (err)
+		return err;
+	if (range_contains_unmapped(start, end))
+		err = -ENOMEM;
+	else
+		err = __mseal_range(start, end);
+	mmap_write_unlock(current->mm);
+	return err;
+}
+
+/**
+ * mseal_mmap_page_zero() - If the MMAP_PAGE_ZERO personality is set, mseal()
+ * the page mapped at address zero.
+ */
+void mseal_mmap_page_zero(void)
+{
+	int err;
+
+	if (WARN_ON_ONCE(!(current->personality & MMAP_PAGE_ZERO)))
+		return;
+
+	err = mseal_range(0, PAGE_SIZE);
+	if (err)
+		pr_warn_ratelimited("pid=%d, couldn't seal address 0, ret=%d.\n",
+				    task_pid_nr(current), err);
+}
+
 /*
  * mseal(2) seals the VM's meta data from
  * selected syscalls.
@@ -118,11 +150,9 @@ static int mseal_apply(unsigned long start, unsigned long end)
  *
  *  unseal() is not supported.
  */
-int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
+static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 {
-	struct mm_struct *mm = current->mm;
 	unsigned long end;
-	int ret = 0;
 	size_t len;
 
 	/* Verify flags not set. */
@@ -145,16 +175,7 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	if (end == start)
 		return 0;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
-	if (range_contains_unmapped(start, end))
-		ret = -ENOMEM;
-	else
-		ret = mseal_apply(start, end);
-
-	mmap_write_unlock(mm);
-	return ret;
+	return mseal_range(start, end);
 }
 
 SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,

-- 
2.55.0

