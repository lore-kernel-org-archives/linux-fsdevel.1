Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD04E5320
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971751; cv=none; b=Cj6+orqK/BmNSb7CtuYOpxj8DzpAzZhj/M7Ct+HJal9r/UxpyevPeUxTGTiD/Iv7eiroSD9yAIVPRoAZEXbmnPOnvcsaqd9yKER1MwSCSYfNZGObOUGpWLql6T0OBJqpLgTIJsAC9cfEoJ04wjct8sJrJYWRMRD86fVH8zIguS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971751; c=relaxed/simple;
	bh=1k0jSncaSaG1GK8A6Gfo0GhCTJx/dG9NhZo9sT8j3iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIOlTfQOB131HWykmZaOza04txMnE+eonTzI+GfAAvh3ILjVkQ6Rbh6/jmPaH44CaHNpwCm2CzsKEAFQJ2nXE6w4knuLR8ip/P2twHCer4bHHJoPoI6ErVctod1UWMVrCBASykHObvp78RhKkMiP7P5C/w0fhYSTS75Uu0nawd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG+ozoJD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG+ozoJD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e934449bb0so4596855ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791971749; x=1792576549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eo7EXw67vjv6v+p6PQKohVa243q8P8L2AoGfCHvln/U=;
        b=gG+ozoJDTBYfmcGzypThUy3iZ/ZTCo3RWvMotm6UehKTDxzS5mWITyvD53X+xLVZXy
         3OeowXT7PXHFFoNajjhu0Mhbdmbrge5rg7eGFRf69va4WqMuvQwmrl2t3Mn/LesOHXaD
         OPIdXmFBPEnt2s1cmTb2aZFgoGr9JRA8RlsKkbycQVbfPo3dSAimCq0zQTyD5NaKZdwf
         fYfu7y4HmNMreKc3bJ6R1h/c2ktcqQdA9MxebCR5+e8Moo66nfr2s08aYHIer1CXvsCf
         vDTQuHwXhfnkpbsaBePqSJpPfPEVOkQrmgvxChFA7DXgdcAd7j028OxGOIEKdPhZs4us
         uTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971749; x=1792576549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eo7EXw67vjv6v+p6PQKohVa243q8P8L2AoGfCHvln/U=;
        b=xwbyQwVswgpgEoJ0NFvK1qDrkm5S3RM5Ti9rlzIOoZ5ReF6ZYH0MoT6hcJrUjX2Ahd
         LyxvywUwG2Q1EYj3WfrBSMEwU/ILQt9BfB2uQWA4dKBv4gRNUQV/itpzfc6/4Xs6Ln5v
         q9YPro4RsLcSHklFCI/JPG/aUUAhHYh1NvlbcWYXdZpjJxUtNXTQoqyAIuDaAIAltCpc
         KzVyqTGiJByVCYzMUsz8/LAHELrYSSDsW/pYduohh2bH9O1pqmuduGDRFhQQrAna9AUD
         BwoBIC7UpBrQwxZiodTBrkGtSKbVlFFwdLBW14RNkwHjsB1F+5GXjTXhPSewC7CVzP5W
         NOwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVCCeiDcCGDwIiERKRsrCdgwP/YqLHkByrCWA9UxX+KXLTb9Wp+C1K8kkX4YqhZXJM4kXif5pyC/NX3ycj@vger.kernel.org
X-Gm-Message-State: AFq9FYK5E8j9Oie8UmEmZdmtieWHsBCJ4gGjXjfgnUAc2Kv8PTBmUybJ
	nz7nwgbmZu/0ts+ugNs49vUmu2i/Nd+vrWLx8NRlMO9lYcZYbPeRhVh7
X-Gm-Gg: AYBFou06fwZ4RONmVZx+5bFydfpROlGEBx8TN1jIFuEksd9wXw1vbtDAEjBjhqK2pgZ
	D9yWgrQkKqb2jl/YkZYp6Gx/zsIIk5laNgkpjOi02uZo7hub1LIaNK7Slc2B5ssaja9Uel6k+6Q
	9Dzg3vLF3dcPX77teVXhQCiiyCn0rwc+xBeViiV7nNAuDS7SJruDBkIRahHVKRxr0F//kT/V3aq
	vU8m6vh7YF45nLfr/O1vxXwAtWnQkJtdOBvvF5lEppbWViRLovcCah6gM8pHr72yS8Tw8KoUmAS
	welkv5YjX2o8EBZHt0Rp3KPCUGdyaGnGNWteKuHDmZleUcT7R8nS2Wz5EVJ07sSuGvt9dJGbPC9
	QDUJVmTXdYrQ0rgi5jdeaCB5RJ6tukOJ7P2kN2AHhiIYgtdKxw2swz/+9+QYHiEkm1X1N77Bk5r
	jaMr7HjeZKL4tC58ZbkCpwfP358CpFm5cm1JhQijGj6orWIEbpIKRhe8DQSyg5NDif8D8I7x1pr
	pe9
X-Received: by 2002:a17:902:f688:b0:2dd:ad74:ac22 with SMTP id d9443c01a7336-2e842cfcd6emr137809885ad.29.1791971748657;
        Wed, 14 Oct 2026 02:55:48 -0700 (PDT)
Received: from chinocute.lan ([123.20.221.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b5924sm67131405ad.47.2026.10.14.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:55:48 -0700 (PDT)
From: Ngoc Quy <ngocquy0700@gmail.com>
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: pin mm_users in do_pagemap_scan()
Date: Wed, 14 Oct 2026 16:55:40 +0700
Message-ID: <20261014095540.3261469-1-ngocquy0700@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PAGEMAP_SCAN ioctl takes mmap_read_lock() on an mm obtained from
/proc/<pid>/pagemap without holding a reference to mm_users.

proc_mem_open() deliberately grabs only mm_count, so a consumer that
touches the address space has to call mmget_not_zero() first. Every
other consumer in this file does -- m_start(), do_procmap_query(),
show_smaps_rollup() and pagemap_read() -- but do_pagemap_scan() does
not.

Without that reference the target can reach exit_mmap() concurrently,
and exit_mmap() calls unmap_vmas() while holding mmap_lock only for
reading, which does not exclude the scanner. For ordinary VMAs this is
harmless, as free_pgtables() and remove_vma() run afterwards under
mmap_write_lock. A shared hugetlb VMA is different: __hugetlb_zap_end()
frees the VMA's hugetlb_vma_lock inside the read-locked phase.

walk_hugetlb_range() can therefore load vma->vm_private_data, have the
lock freed underneath it, and then down_read() a freed rw_semaphore.
The load happens before the freeing side clears the pointer, so this is
a use-after-free and not a NULL dereference. Any unprivileged user can
reach it with no huge pages configured, as hugetlb_reserve_pages()
allocates the lock before the VM_NORESERVE early return.

Pin mm_users across the scan, the way the other consumers do. mmput()
from the exiting task can then no longer reach exit_mmap() while a walk
is in progress.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ngoc Quy <ngocquy0700@gmail.com>
---
 fs/proc/task_mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe2118..8825b01f5e38 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3231,15 +3231,18 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 	size_t n_ranges_out = 0;
 	int ret;
 
+	if (!mm || !mmget_not_zero(mm))
+		return -ESRCH;
+
 	ret = pagemap_scan_get_args(&p.arg, uarg);
 	if (ret)
-		return ret;
+		goto out_mmput;
 
 	p.masks_of_interest = p.arg.category_mask | p.arg.category_anyof_mask |
 			      p.arg.return_mask;
 	ret = pagemap_scan_init_bounce_buffer(&p);
 	if (ret)
-		return ret;
+		goto out_mmput;
 
 	for (walk_start = p.arg.start; walk_start < p.arg.end;
 			walk_start = p.arg.walk_end) {
@@ -3294,6 +3297,8 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 		ret = -EFAULT;
 
 	kfree(p.vec_buf);
+out_mmput:
+	mmput(mm);
 	return ret;
 }
 

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.53.0

