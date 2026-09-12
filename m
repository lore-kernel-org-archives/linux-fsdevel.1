Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8647CA64
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789216117; cv=none; b=rV3EWqNZqiqTR6rDzdsh+05Oq3DJElHcEeCbbFDT2Cs4lfb/917XXJM5lLRZjlZdBAg5PMGLh0bWBVvVCleabWHoRtjSsb6b/MMYpB98yQTOZGf79+nQ3VgqQBhM/dUCt3qQlgaGTqIB89gZntx0p51FAkwIceZiPAMUHRxacMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789216117; c=relaxed/simple;
	bh=UEfjtaP+OjZfpUGS2B7a5BTw/P5s5UMLg0m29u/MkCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3CBBL0+rKbNEvY6tFIs/x7DutPg3p2l09jLUuBAP5eX1Wuw/5u+UITROYatwQa9Qy4QuERKhu733CfEFGoARRIfFJMRWRY4DNZfd7+8QDJQvAa9ms9S/KaH4GrCmaHZpiOT/8+A7TyhNRvYcoNswmcUdkYjqPVZ3BYfRL4iX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PzY1BsZe; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PzY1BsZe"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb7692a57so5440511cf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789216114; x=1789820914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJXH9rrJbZbgym50NMM/+P+67cMUDF3IUxD6O+4ZOuc=;
        b=PzY1BsZeB34yYpF6aAkHGcZER2wdBN+Q0+slK07ZNp4fmrDxqF1enSV618spjWCcAn
         ssCputSccsXGMHyvZJxeWHNBewFM95YapJJvGTmS38DYNNPcUMaFwucyTPKSEm4vb4u2
         cSSTZ/QOD6wkzOAxC64TcIRXzMJPPkmf+RyWjp+/LdqjZTgRvvnEWnyi6z4RQohZBu93
         sHZZH5wU+AD7W1BxPjb8WC7MCcymf8w9knqxISx9kfvCIFbZ0vaP94hr1OA1F1L0XYHx
         GF/ECDIt+U86egjq0XUBVOwxR/YUrkdj/azpCeXfUgsQaNY3d7T12FoJerj+fdoRHj3J
         hrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789216114; x=1789820914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJXH9rrJbZbgym50NMM/+P+67cMUDF3IUxD6O+4ZOuc=;
        b=tAieb98RshzwCAQRq62SmxBzriDw/0dXw9zutUUMPTMy4VxRg3C4F1Qzw0wJ9N009t
         w3r1/C5/nGdGWCce/S3K+BhQJyjxGcgVbJyXckto3aGT1+nFWtOvVnKw1QSzvUIOCmQ9
         Gpzmlp4XcwQrEpvOP1WA6kK7xZwImk4vyEeQJ/TyS+d0XtwW95hAQhtL3XlP1a249GEV
         z4H6l+BpPS7Ir4wAubHd3mn6MGj4+/LU1cQYOGiUNVbDRWUiIHLcWdP0oF4a4HLT0mhD
         sFJfHMMKS7FOzKz8IdctMGg245/vC3OoWWIH/Dcp80ZfwBKwK/G626E1DBCQR1iw3iNS
         e7yA==
X-Gm-Message-State: AFuF++kCFczOyEQ1jbSJHn9IESxDQqECrPrDj7WFewdp97tNtpb0Drok
	Lanp4RX1Ncwwz4M3c0x7xCRV57J+UiALEWPwolAsItkdfyvnWiIbDgoERlfmT3CG6Q8=
X-Gm-Gg: AYBFou2QbFlVZzefGv5WfB79V1hE1bdlU2dAJbN1NPX8g6MDpHDNMXh7TuFimZWKhJy
	bdnRI/csUdCrQmJkatVniucWRqsI8+FGMm30gJNHD2LyVbX/GAGpB9urOTc6gIRTT3It5RrqbP/
	cvZBCWMv2bEiUgjXpMWBLdelokCc6vZ2KlJS/Wn3CSHpYGVh1ROAkNYo1jnZh5uOEWXInOiupEo
	rJwnAPpkGexBnTF9Y4vCY3Lvs6hkGOngRmuBa0S71XMS8LjEWdcRyOsOHaoxIWoQZDujpVqFSVU
	VKl8OHxUaB/+9zYqCxXjwir7MUelgWloMRAqWmCGYyRU60CMhfN/LnBu+KXodP5zOH12uWD+JyN
	o7ymWIcEND5hEe+ziHiq768gYx/OwoS3FjCC4FvecchWkX5IxeMF0Oa23gON8+aZX1SRPt4jFyv
	CZ5t0dCALVEj5PcnbLtLPdBS6yHMUpQ4WVT2rQth3P8rfyGNgYQCKJxX4ZrHVvA8QCOQahxbRWO
	/xsfmhr71g2cq8Dq9MYvtET7sO5wqC2uh/e7axuGEmWOB22R+WQuMRKdvDt
X-Received: by 2002:a05:622a:1f8b:b0:530:42e5:f3a4 with SMTP id d75a77b69052e-530e81e3f69mr37044771cf.45.1789216113681;
        Sat, 12 Sep 2026 05:28:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530e64da059sm17780461cf.24.2026.09.12.05.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 05:28:32 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	peterx@redhat.com,
	jgg@ziepe.ca,
	david@kernel.org,
	sashiko-bot <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] proc/task_mmu: handle special PMDs in clear_refs and pagemap
Date: Sat, 12 Sep 2026 08:28:22 -0400
Message-ID: <20260912122822.3348978-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mshv_vtl_low can install a special PMD from a PFN supplied in the mmap file
offset.  That PFN need not have a memmap entry.  Reading /proc/PID/pagemap
or writing /proc/PID/clear_refs for such a mapping oopses the kernel.

With a test driver mapping the PFN at the 1 TiB mark:

  echo 1 > /proc/self/clear_refs

  BUG: unable to handle page fault for address: fffffb5b80000008
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  RIP: 0010:clear_refs_pte_range+0xb1/0x1e0
  Call Trace:
   walk_pgd_range+0x50a/0xad0
   __walk_page_range+0x6a/0x1d0
   walk_page_range_mm_unsafe+0x193/0x230
   clear_refs_write+0x18e/0x3f0

  pread(pagemap_fd, buf, 512 * 8, addr / PAGE_SIZE * 8)

  BUG: unable to handle page fault for address: fffff57840000008
  RIP: 0010:pagemap_pmd_range+0x3cf/0x6b0
  Call Trace:
   walk_pgd_range+0x50a/0xad0
   __walk_page_range+0x6a/0x1d0
   walk_page_range_mm_unsafe+0x193/0x230
   pagemap_read+0x1dc/0x350

clear_refs_pte_range() passes the PMD to pmd_folio(), while
pagemap_pmd_range_thp() uses pmd_page() followed by page_folio().

Both paths assume the PFN has a struct page and dereference bad address.

Use vm_normal_folio_pmd() and vm_normal_page_pmd() so clear_refs skips
folio operations and pagemap skips folio-derived flags for special PMDs.
This matches the PTE paths, which already use vm_normal_folio() and
vm_normal_page().

User-facing notes:
 - Pagemap still reports PM_PRESENT and the PFN to a CAP_SYS_ADMIN reader.

 - For a special PMD backed by a valid memmap entry and for the huge
   zero PMD, PM_FILE changes from set to clear.

 - PM_MMAP_EXCLUSIVE is already clear in both cases.

 - The output for an anonymous THP is unchanged.

Tested in QEMU with the test driver on broken and fixed kernels.  Both proc
operations oops before the fix and return 0 after it.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260912034833.2952750-1-gourry%40gourry.net
Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
Cc: <stable@vger.kernel.org> # v6.19+
Assisted-by: LLM
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 fs/proc/task_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 24425e230895..501cd038b4e4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1671,7 +1671,9 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pmd_present(*pmd))
 			goto out;
 
-		folio = pmd_folio(*pmd);
+		folio = vm_normal_folio_pmd(vma, addr, *pmd);
+		if (!folio)
+			goto out;
 
 		/* Clear accessed and referenced bits. */
 		pmdp_test_and_clear_young(vma, addr, pmd);
@@ -1991,7 +1993,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		goto populate_pagemap;
 
 	if (pmd_present(pmd)) {
-		page = pmd_page(pmd);
+		page = vm_normal_page_pmd(vma, addr, pmd);
 
 		flags |= PM_PRESENT;
 		if (pmd_soft_dirty(pmd))
-- 
2.55.0

