Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8EC20E6E2;
	Fri, 17 Jul 2026 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309264; cv=none; b=SPit0TsvFAhQ8Qv4E7UviLhp0aQ2uOnYFiBLbgMsIVmbK3+9muIBjLmJPILg6+RP3kK2Wy6e758IawdoBMieDDN1MPDgj7IqQIgXFzahQ/jR8Tl9WOtIT8cJbRLBwCoRh/A77aMgNwHATdvqrLq2Fc4goNuC/bmcmlbLgWj2FZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309264; c=relaxed/simple;
	bh=MDOTli1ONneEZj3m3sNVoalGk6wNclirN2tJYNxD1yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7pYxIldSLQi7YrA+60pVZZtLPaB5COAe5GEkI0PF9AImPHqGiw8e/cQumSWDTlRgeXFHqhndDuVvwmYsjkLsk5GBGX6QgHSIoAfIZqWVIMokER4gNrP8nUjOJ79inmYGugqFKdBrDe+Eg4vbU7mj5Q4VzPccCt/dslmyL8/ORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L87zM+vX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L87zM+vX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5F21F00A3D;
	Fri, 17 Jul 2026 17:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309263;
	bh=6pQm/Ojh5C3HMOQwR66ivQbCKfkvu5WSMILH5D2c3DA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L87zM+vX3nYW7/x31SZ8P1ixK6XcMEKB+Lfgk3QLsMu4NHWMKlAFtv7FCyDtW4WFk
	 SUXf75Saw0cu/nF94tgqw+ytukguPjC/QRj0rrCiD54C+07h5RSWQGj4g+cUmpYSwA
	 ZOriBrDMr3pEI4dc1fubJ4nW71n1+MoSgyor5yJ64XQbIt6LqtzH//tuVcl0QH6O3W
	 Wjw24fXun3+j3jZOnO/mjVq3S4oMqCU9Tj/2HgRbhF2C2rOJeZheVCexT9JOrTx9fT
	 1CNdEAJ40J3NhAjwYYn5kppvkK/SxsY8sGlBh+VVt6Phkn+X/p70dWY2kozf2/B4WR
	 OT3JHT/z826Iw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 17 Jul 2026 18:27:11 +0100
Subject: [PATCH v2 3/3] mm/mseal: remove further superfluous comments,
 do_mseal()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mseal-fixups-v2-3-0daa0014b813@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4363; i=ljs@kernel.org;
 h=from:subject:message-id; bh=MDOTli1ONneEZj3m3sNVoalGk6wNclirN2tJYNxD1yY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKiUr+86nw2y1b1D+esnC0ORWVN159smf6hsWfnPH+tR
 Yc8a4tfd5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiN94x/DN7nrwvm3ulVDBb
 53PW7wECgSy2Ey5tXWRzVCOmu6tVl42R4c33DseQqdfFa5mSr/nVXrm28l7z3ZB5L348Tlq28OY
 Hbg4A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

There's no need to abstract do_mseal() any longer so put the system call
implementation in the system call declaration.

The comment around do_mseal() is strangely formatted, overly long and adds
a lot of superfluous information that the code already provides, so boil it
down to the essentials.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mseal.c | 74 ++++++++++++++------------------------------------------------
 1 file changed, 16 insertions(+), 58 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 2a516da694c6..7a8ac66dc215 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -99,61 +99,25 @@ void mseal_mmap_page_zero(void)
 }
 
 /*
- * mseal(2) seals the VM's meta data from
- * selected syscalls.
+ * Seal VMAs in the specified input range to prevent an attacker replacing what
+ * is mapped in the range with something else.
  *
- * addr/len: VM address range.
+ * Disallows:
+ * - VMA unmapping, remapping or shrinking.
+ * - Overwriting the VMA with another one via mmap(), mremap() or similar.
+ * - Alteration of properties via mprotect()/pkey_mprotect().
+ * - Destructive madvise() behaviours (like MADV_DONTNEED) on anonymous read-only
+ *   ranges.
  *
- *  The address range by addr/len must meet:
- *   start (addr) must be in a valid VMA.
- *   end (addr + len) must be in a valid VMA.
- *   no gap (unallocated memory) between start and end.
- *   start (addr) must be page aligned.
+ * Since unmapped ranges can be mapped at any time, the input range must span
+ * mapped ranges only.
  *
- *  len: len will be page aligned implicitly.
- *
- *   Below VMA operations are blocked after sealing.
- *   1> Unmapping, moving to another location, and shrinking
- *	the size, via munmap() and mremap(), can leave an empty
- *	space, therefore can be replaced with a VMA with a new
- *	set of attributes.
- *   2> Moving or expanding a different vma into the current location,
- *	via mremap().
- *   3> Modifying a VMA via mmap(MAP_FIXED).
- *   4> Size expansion, via mremap(), does not appear to pose any
- *	specific risks to sealed VMAs. It is included anyway because
- *	the use case is unclear. In any case, users can rely on
- *	merging to expand a sealed VMA.
- *   5> mprotect and pkey_mprotect.
- *   6> Some destructive madvice() behavior (e.g. MADV_DONTNEED)
- *      for anonymous memory, when users don't have write permission to the
- *	memory. Those behaviors can alter region contents by discarding pages,
- *	effectively a memset(0) for anonymous memory.
- *
- *  flags: reserved.
- *
- * return values:
- *  zero: success.
- *  -EINVAL:
- *   invalid input flags.
- *   start address is not page aligned.
- *   Address range (start + len) overflow.
- *  -ENOMEM:
- *   addr is not a valid address (not allocated).
- *   end (start + len) is not a valid address.
- *   a gap (unallocated memory) between start and end.
- *  -EPERM:
- *  - In 32 bit architecture, sealing is not supported.
- * Note:
- *  user can call mseal(2) multiple times, adding a seal on an
- *  already sealed memory is a no-action (no error).
- *
- *  unseal() is not supported.
+ * The flags parameter is currently reserved.
  */
-static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
+SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long, flags)
 {
+	size_t len_aligned;
 	unsigned long end;
-	size_t len;
 
 	/* Verify flags not set. */
 	if (flags)
@@ -163,12 +127,12 @@ static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	if (!PAGE_ALIGNED(start))
 		return -EINVAL;
 
-	len = PAGE_ALIGN(len_in);
+	len_aligned = PAGE_ALIGN(len);
 	/* Check to see whether len was rounded up from small -ve to zero. */
-	if (len_in && !len)
+	if (len && !len_aligned)
 		return -EINVAL;
 
-	end = start + len;
+	end = start + len_aligned;
 	if (end < start)
 		return -EINVAL;
 
@@ -177,9 +141,3 @@ static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 
 	return mseal_range(start, end);
 }
-
-SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
-		flags)
-{
-	return do_mseal(start, len, flags);
-}

-- 
2.55.0

