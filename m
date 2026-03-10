Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B2303C8A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154503; cv=none; b=Dw8aY4HDV/exGtdrDSImey2j2oZ5gH8sS567xdieyS6y08pobRImsjUprl5vxXaa5oo67N/LiH3wvEcwQ3iWf2BO3pb4/QP0FZzB1eMsj4c9KS3530+9szAr8vH0sEQ7azV/+Vr1QScOtCJm5YczJvTFiyJpk3MWwfR6rVAd+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154503; c=relaxed/simple;
	bh=39Q8LnkGEp9VfwdObsoI4kOYowjYOmfnHABtQZKmgIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIhpVUIhr6gS+/lgEcfDswEuUKv4MKzWCj7LCs0TQJ/43I7QAceB9VHxv1D8cOiGxYdyz9FH9W5QJg6p0sjTxnIbbexjgh7jvu25h6j4uMlmlVAFx0IvfBtQFW6Bo5bYE0VwY/IIonCDGCPpTTmOCl8H9oSgp3K2Vwl5AWHIQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q7J9Xayb; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q7J9Xayb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773154499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Koap7c4nmBUn1jQcRs2TKnT3RilQxG9yZc8gbf4yHA=;
	b=Q7J9Xayb3tuq1RwczoR+kkYcwmbHr2IBdva+1kWyUfpOmeUqFxY8p3HhUG0VvkvFVRO7cq
	rcbAym+WsHWFr//SsTKMXbfjnthBN1AVMJKC4S1BQIu+Y4f+asu6YqEK9FjMKM6HNAuqFg
	o+kIhQjL1lj8wyLdBd5OI3jV01FKMB4=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	ryan.roberts@arm.com,
	david@kernel.org
Cc: ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	jack@suse.cz,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	rmclure@linux.ibm.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 4/4] mm: align file-backed mmap to exec folio order in thp_get_unmapped_area
Date: Tue, 10 Mar 2026 07:51:17 -0700
Message-ID: <20260310145406.3073394-5-usama.arif@linux.dev>
In-Reply-To: <20260310145406.3073394-1-usama.arif@linux.dev>
References: <20260310145406.3073394-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

thp_get_unmapped_area() is the get_unmapped_area callback for
filesystems like ext4, xfs, and btrfs. It attempts to align the virtual
address for PMD_SIZE THP mappings, but on arm64 with 64K base pages
PMD_SIZE is 512M, which is too large for typical shared library mappings,
so the alignment always fails and falls back to PAGE_SIZE.

This means shared libraries loaded by ld.so via mmap() get 64K-aligned
virtual addresses, preventing contpte mapping even when 2M folios are
allocated with properly aligned file offsets and physical addresses.

Add a fallback in thp_get_unmapped_area_vmflags() that tries
PAGE_SIZE << exec_folio_order() alignment (2M on arm64 64K pages)
when PMD_SIZE alignment fails. This is small enough that shared
libraries could qualify, enabling contpte mapping for their executable
segments.

This applies to all file-backed mappings (not just exec). Non-exec
file-backed mappings also benefit from contpte mapping when large
folios are used. Aligning all file-backed mappings ensures that any
large folio in the page cache can be contpte-mapped regardless of
the mapping's protection flags, reducing dTLB misses for read-heavy
workloads.

The fallback is gated by exec_folio_order() which returns 0 by default,
making this a no-op on architectures that don't define it.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e2746ea74adf..1c9476a5ed51c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1242,6 +1242,23 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 	if (ret)
 		return ret;
 
+	/*
+	 * If the arch requested large folios for exec memory, try to align
+	 * to the folio size as a fallback. This is much smaller than PMD_SIZE
+	 * (e.g. 2M vs 512M on arm64 64K pages), so it succeeds for mappings
+	 * that are too small for PMD alignment. Proper alignment ensures that
+	 * the hardware can coalesce PTEs (e.g. arm64 contpte) when large
+	 * folios are mapped.
+	 */
+	if (exec_folio_order()) {
+		unsigned long folio_size = PAGE_SIZE << exec_folio_order();
+
+		ret = __thp_get_unmapped_area(filp, addr, len, off, flags,
+					      folio_size, vm_flags);
+		if (ret)
+			return ret;
+	}
+
 	return mm_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags,
 					    vm_flags);
 }
-- 
2.47.3

