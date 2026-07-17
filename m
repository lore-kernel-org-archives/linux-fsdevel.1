Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51B20E6E2;
	Fri, 17 Jul 2026 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309256; cv=none; b=VXyBwLC8DwM3X73tSYKKyduPCokEpCx6Qm61TlOn71NbmytmqUelqPxn3UuKVU5TC5FDaE3FTuvH0OCIPkYxLx3El2W4Qd4fXEVTZioigIcnl9EDjoS9aIDgOWjT2V5qB/5ydlqTtGCL7o+UP/2heCxKH9KHiKuXHobhixgVhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309256; c=relaxed/simple;
	bh=yUQSFiVMSo4TV1a3z7ol+UBtUlj0DW3ZdJam6kMHRng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oO86faiLPoq8b3wUpyy/OI59JKIO4j8hM7dCC2WgQ3OI1FjqYAABeTrt0zECvkIgqWYema+AWlkD3x7QpMzQ2JOtKiapoTPl1BrBISfSvkSdZkYks4yLl54siYWAkWRF5JJF6MXdncvxM4QoBdAjHoV9piejkKEBQ2gn3cey1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpEOJsk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpEOJsk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4261F00A3A;
	Fri, 17 Jul 2026 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309255;
	bh=22AOIFpaEY/MXo5bsXfXAlnPYUw1Afv74uPUeSMlE9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IpEOJsk2frc8eyhvJm4BcPXFLrXxsdBkHqL19fZg1vnPXC+48dHkloZxVht2sgCIn
	 3Bu+5pASl13J+//bgdKiwEZ1UCxEPTW7XzhSqO7JHRrO3u0okpezfFpsJBdKHsmBy5
	 EPAyRmjuTtojLouYKrO6iHtMhB10PfCaLnwL92/CYOErIFgfYGr6MyPpthqKOWeaMt
	 zhlDu3S2Gs+yoi0BUvk4ne/FRV9hPc8kS2qu/AtOYTlA9Obkr8jD7Yc/fniXStQsqb
	 lDN0Ai0KQGHrwbbhW1nTPx2BZrJf0538sghQwnu04NAKOGdDvChp6D27opKGXs9n4j
	 19AdIWrDlBsiA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 17 Jul 2026 18:27:09 +0100
Subject: [PATCH v2 1/3] mm/mseal: remove superfluous comments, fix
 confusion around mm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mseal-fixups-v2-1-0daa0014b813@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3558; i=ljs@kernel.org;
 h=from:subject:message-id; bh=yUQSFiVMSo4TV1a3z7ol+UBtUlj0DW3ZdJam6kMHRng=;
 b=kA0DAAoWz53NioHifxQByyZiAGpaZfSgorz2kS+U4gg7UETrRRwkLBS0VyFbGJotbwMb7eS9K
 4h1BAAWCgAdFiEE5/QXv1IUVp6J0E9Gz53NioHifxQFAmpaZfQACgkQz53NioHifxR//wEAupG9
 sJD43zKwgDi1oGAHZDvCDYERsMWdIkTPWSz+/1IA/jTXq4+KsWA2XeJowvtlFH/SxE5JTMDwG6n
 7bP8c41gC
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Remove comment blocks that don't add value and eliminate any confusion
about whether or not we permit mseal()'ing of remote mm's by not passing
through an mm parameter but rather referencing current->mm in each
function.

Also while we're here, avoid an ugly goto by using an else branch, and move
local parameters declarations into reverse xmas tree order.

No functional change intended.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mseal.c | 53 +++++++++++------------------------------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 9781647483d1..430a252a6da4 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -16,32 +16,11 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-/*
- * mseal() disallows an input range which contain unmapped ranges (VMA holes).
- *
- * It disallows unmapped regions from start to end whether they exist at the
- * start, in the middle, or at the end of the range, or any combination thereof.
- *
- * This is because after sealing a range, there's nothing to stop memory mapping
- * of ranges in the remaining gaps later, meaning that the user might then
- * wrongly consider the entirety of the mseal()'d range to be sealed when it
- * in fact isn't.
- */
-
-/*
- * Does the [start, end) range contain any unmapped memory?
- *
- * We ensure that:
- * - start is part of a valid VMA.
- * - end is part of a valid VMA.
- * - no gap (unallocated memory) exists between start and end.
- */
-static bool range_contains_unmapped(struct mm_struct *mm,
-		unsigned long start, unsigned long end)
+static bool range_contains_unmapped(unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *vma;
-	unsigned long prev_end = start;
 	VMA_ITERATOR(vmi, current->mm, start);
+	unsigned long prev_end = start;
+	struct vm_area_struct *vma;
 
 	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_start > prev_end)
@@ -53,11 +32,10 @@ static bool range_contains_unmapped(struct mm_struct *mm,
 	return prev_end < end;
 }
 
-static int mseal_apply(struct mm_struct *mm,
-		unsigned long start, unsigned long end)
+static int mseal_apply(unsigned long start, unsigned long end)
 {
+	VMA_ITERATOR(vmi, current->mm, start);
 	struct vm_area_struct *vma, *prev;
-	VMA_ITERATOR(vmi, mm, start);
 
 	/* We know there are no gaps so this will be non-NULL. */
 	vma = vma_iter_load(&vmi);
@@ -142,10 +120,10 @@ static int mseal_apply(struct mm_struct *mm,
  */
 int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 {
-	size_t len;
-	int ret = 0;
-	unsigned long end;
 	struct mm_struct *mm = current->mm;
+	unsigned long end;
+	int ret = 0;
+	size_t len;
 
 	/* Verify flags not set. */
 	if (flags)
@@ -170,20 +148,11 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	if (range_contains_unmapped(mm, start, end)) {
+	if (range_contains_unmapped(start, end))
 		ret = -ENOMEM;
-		goto out;
-	}
-
-	/*
-	 * Second pass, this should success, unless there are errors
-	 * from vma_modify_flags, e.g. merge/split error, or process
-	 * reaching the max supported VMAs, however, those cases shall
-	 * be rare.
-	 */
-	ret = mseal_apply(mm, start, end);
+	else
+		ret = mseal_apply(start, end);
 
-out:
 	mmap_write_unlock(mm);
 	return ret;
 }

-- 
2.55.0

