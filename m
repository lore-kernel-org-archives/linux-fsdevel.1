Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C2424D51;
	Thu, 16 Jul 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209420; cv=none; b=M99/W0+sKlP7B6LnbG0XIc03jSXR28U4lNTHfAJw+7RyEA6/pMd0uWFdn1KdO5yhNlxWsMlri537xFsgMsPlgIbh5cl5zWN2V9DTSoXDbA8Yobz5BAPaXQKQf//kMmNLaJQFC2Sim0Jd4SLSSmb13KCkrHZLS/hwPmLnHCKUODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209420; c=relaxed/simple;
	bh=bCnbZ236ttt9+tsOYrHXuwG+hplvEL93BRAGDdBCf/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3SkJ1fgFoFckmtBPrx3G18PrCNEP8E6q7ONZUyw5voMb7joI54/mTiKyL/NpzypaPe2PWjAGUoNH75ZqdbVijXmOvBQkw6lNvxelntXY9QZMytMIjaPoOfEUY5/EnBTpuz7gPtZqz59kCVGmuxA2snzlBRYtfE2I4unt9B9ruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5HI6GNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5HI6GNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82D31F000E9;
	Thu, 16 Jul 2026 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209414;
	bh=+H1mNZK4mHGJRYK6baWPpFykIVXk8y/VtJFIxD1CBjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d5HI6GNhbQ/GL2/WgLgxsxRnCCGpvu3Ixr3MEAOZbjWhOYL+Qmu7X6MLActJufiCX
	 FDh0DsWSxkdlZ0wCg2TB0rljgajZjrsTXq9KGreNF18CSoiwsc00C/o3USRY8r2zLU
	 pKcuxwvHICk9KgHSHTWhT8vW0aGiwWwzmIg3MboWMTeAMz7sTRhUwl9Z/tf6mkVY1D
	 QoxPx33rqkx5xz2rBEhChwJv7qr/anvgn/AUm85E67QFbGryS+i/ylXC9xw37ApxJP
	 tbXDq2KWY8BXxhtY6XKabzwKu+t/FKCcQiV/Kngn6cKHK4mXYjQeHqDmsqr3b5xbpv
	 ktoxcWmr4AvXQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 16 Jul 2026 14:43:10 +0100
Subject: [PATCH 2/3] mm/mseal: limit scope of mseal address zero to address
 zero
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-mseal-fixups-v1-2-3a9609bf041b@kernel.org>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
In-Reply-To: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4346; i=ljs@kernel.org;
 h=from:subject:message-id; bh=bCnbZ236ttt9+tsOYrHXuwG+hplvEL93BRAGDdBCf/Q=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIi7n86mzzdwW33t98/WI8kz2T8GZwX69x4N7nh7qK/9
 3b9tIna0VHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJbNvD8N/zaJnitIe8mv6q
 h6a1LT7e1Pm49+eBHFNzV27zJbpGQhKMDO/mHp/z4uWhcM1dHTcK7zqEZ2qfec3d9DZuxYJs8zW
 e7mwA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit 44f65d900698 ("binfmt_elf: mseal address zero") unconditionally
provided do_mseal() to any internal kernel caller in order to address a
corner case slated for possible removal.

It also incorrectly attempts to mseal() without checking to see whether the
mapping even succeeded.

Restrict the scope to the corner case by providing mseal_mmap_page_zero()
which asserts the MMAP_PAGE_ZERO personality.

Avoid unnecessary checks in the start, end range by abstracting the actual
mseal()'ing to mseal() and have mseal_mmap_page_zero() call that instead.

Only try to seal the VMA if we mapped the VMA.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 fs/binfmt_elf.c    |  7 ++-----
 include/linux/mm.h |  8 ++------
 mm/mseal.c         | 48 +++++++++++++++++++++++++++++++++++-------------
 3 files changed, 39 insertions(+), 24 deletions(-)

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
index 207fea89c61e..5930551d84f2 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -32,7 +32,7 @@ static bool range_contains_unmapped(unsigned long start, unsigned long end)
 	return prev_end < end;
 }
 
-static int mseal_apply(unsigned long start, unsigned long end)
+static int __mseal(unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma, *prev;
 	VMA_ITERATOR(vmi, current->mm, start);
@@ -66,6 +66,38 @@ static int mseal_apply(unsigned long start, unsigned long end)
 	return 0;
 }
 
+static int mseal(unsigned long start, unsigned long end)
+{
+	int err;
+
+	err = mmap_write_lock_killable(current->mm);
+	if (err)
+		return err;
+	if (range_contains_unmapped(start, end))
+		err = -ENOMEM;
+	else
+		err = __mseal(start, end);
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
+	err = mseal(0, PAGE_SIZE);
+	if (err)
+		pr_warn_ratelimited("pid=%d, couldn't seal address 0, ret=%d.\n",
+				    task_pid_nr(current), err);
+}
+
 /*
  * mseal(2) seals the VM's meta data from
  * selected syscalls.
@@ -118,10 +150,9 @@ static int mseal_apply(unsigned long start, unsigned long end)
  *
  *  unseal() is not supported.
  */
-int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
+static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 {
 	size_t len;
-	int ret = 0;
 	unsigned long end;
 
 	/* Verify flags not set. */
@@ -144,16 +175,7 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	if (end == start)
 		return 0;
 
-	if (mmap_write_lock_killable(current->mm))
-		return -EINTR;
-
-	if (range_contains_unmapped(start, end))
-		ret = -ENOMEM;
-	else
-		ret = mseal_apply(start, end);
-
-	mmap_write_unlock(current->mm);
-	return ret;
+	return mseal(start, end);
 }
 
 SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,

-- 
2.55.0

