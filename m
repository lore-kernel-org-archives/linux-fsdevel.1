Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658142586F;
	Thu, 16 Jul 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209412; cv=none; b=O8Rv2S/UwCNMZNmg8FLiX5E2K6A7j+Y0ajTHerkW4Eilfe2fzr1SJcazy28HWRSIytaE5FQ090B9aqgLXeUwQiIOzsvC/0XT61qaxzrgOdpzvJZaYmvqBM8eljQIM+mIeAP0G3OTVIiRHx3EgRg3b/HXKDMeEVgCLQx1qrZWhcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209412; c=relaxed/simple;
	bh=JEKI5OwncHBGRVO2u9xfmyB4w0tHgvkQ1WO1V8Kh+So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooLxAzHJa0n/c5B0CXfmYjpSTz7HmmM1Ajt1oI+XpaUIXNJbtkRR4FM/vbWNBGcKigVCz8rgLZQT/spW6CtTUKmmGtGGEsj2O/WPAwz47/f5QLma/pXgTNTweLDHRXsXzsXBrT5AcWYv84JB/3kbKQ+DXeWQm8tiyFCcxj2OII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZndhMEV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZndhMEV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0763E1F00A3E;
	Thu, 16 Jul 2026 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209410;
	bh=8Sj/M25oVbH+rWO7PSpE7fI/tkji4kX40FPXf3ZlljY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZndhMEV4yXOR6uNgwH7/Yu7m/bBTKhQxI9l2/KGYfYj3sBtF5tnwNJOTXnwJipmPA
	 VcMu+NnjqrdT+xJ+sH/DN1I7Hcu011RnzjyxWUPZAYD5fvy21omYi/9+FrNp+jmIyX
	 PTm13cGymX6UBlZXC1C2iTYMQGZek5Fz158O9hHJXv654tNbE7QDq6+3AFurFPuVU0
	 OZveC0rkxatzoD8hnNkeh+mC5Tw9nWzVpcz6q8Ds8mcQC9KOfK2rGKaJNakK9hKrzH
	 rHAwyOO4knuImOwmEDflobCq3ftAg6uC/bKphsVJsZBKPkDzM/E6+AtfTGbhPjNk82
	 kNK03QGsCS6CA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 16 Jul 2026 14:43:09 +0100
Subject: [PATCH 1/3] mm/mseal: remove superfluous comments, fix confusion
 around mm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-mseal-fixups-v1-1-3a9609bf041b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3144; i=ljs@kernel.org;
 h=from:subject:message-id; bh=JEKI5OwncHBGRVO2u9xfmyB4w0tHgvkQ1WO1V8Kh+So=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIi7n/M1bye0Ojznz8pYLrszfC+B7v0a8U4D6e9+rp+z
 V5rXquYjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEykrp2RYeOBxUbdL953TMux
 4lW7ELFuo/pJLRZd61AFFj2dmXc9pRn+19kYn4+3OzvhRJ2Fc49jjOh0xxfXRdoW+UlFvdr3/Pt
 3bgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Remove comment blocks that don't add value and eliminate any confusion
about whether or not we permit mseal()'ing of remote mm's by explicitly
referencing current->mm consistently.

Also avoid ugly goto by using an else branch.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mseal.c | 48 ++++++++----------------------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 9781647483d1..207fea89c61e 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -16,28 +16,7 @@
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
 	struct vm_area_struct *vma;
 	unsigned long prev_end = start;
@@ -53,11 +32,10 @@ static bool range_contains_unmapped(struct mm_struct *mm,
 	return prev_end < end;
 }
 
-static int mseal_apply(struct mm_struct *mm,
-		unsigned long start, unsigned long end)
+static int mseal_apply(unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma, *prev;
-	VMA_ITERATOR(vmi, mm, start);
+	VMA_ITERATOR(vmi, current->mm, start);
 
 	/* We know there are no gaps so this will be non-NULL. */
 	vma = vma_iter_load(&vmi);
@@ -145,7 +123,6 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	size_t len;
 	int ret = 0;
 	unsigned long end;
-	struct mm_struct *mm = current->mm;
 
 	/* Verify flags not set. */
 	if (flags)
@@ -167,24 +144,15 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	if (end == start)
 		return 0;
 
-	if (mmap_write_lock_killable(mm))
+	if (mmap_write_lock_killable(current->mm))
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
-	mmap_write_unlock(mm);
+	mmap_write_unlock(current->mm);
 	return ret;
 }
 

-- 
2.55.0

