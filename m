Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09143C5526
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015479; cv=none; b=pFXTMnEj/2xE1ItyhEZQgHALvnvi7DdHQ+oLcXmfRahZC1UWkJocuWoPWoCPK2JnAKudO4pLLMy7Is5gzDZi9Pw6FXmV/oiGI0iw8UEfQDzyfAovGjVLlVk6Ger4DhqFMnRhX4MRFOzg4V062GZy4OawQJgxSpB7A8wWnNT/LTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015479; c=relaxed/simple;
	bh=0mNrZix0gV7plNTuW4VVE4zt2Qq9mKGrk+eq8XuLpV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3TKnJGMXrg3gJbsM3sRb4poHsdNOXTcJjRdW35Z/FHR8clS+jT3uns6vSeDRDv96B5MR6ni/NU4LMXrXiftHsn5vFjQEEkRpuYOlQVSisuvKCb3s+FZUJS8u9IpDBE9j7QNB17wTF4oJNuFKxmQTYfvKbnC/Eh8zw2MHIhw8PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wS9n9+fY; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wS9n9+fY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774015472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmRxXvLU2NeOq/5VK9R2/fqL97zGqJrwy25018suKSw=;
	b=wS9n9+fYt23GFUct+LfGUjkJm/ZIwaGL6fzpdAvRLF26yPQFBZkuayNfpKCsRPYw7iImAQ
	abZc2PDiq+w02KVbtGI2L3QKF6Utof/q4A1U+08yA0+RdbXAXuvOhpJhn/znvXZcET7rtY
	rTe+wuWgnlNaW+s3aXCk+3jQmfCSrwM=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: r@hev.cc,
	jack@suse.cz,
	ajd@linux.ibm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	wilts.infradead.org,
	linux-fsdevel@vger.kernel.l@kernel.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v2 4/4] mm: align file-backed mmap to max folio order in thp_get_unmapped_area
Date: Fri, 20 Mar 2026 06:58:54 -0700
Message-ID: <20260320140315.979307-5-usama.arif@linux.dev>
In-Reply-To: <20260320140315.979307-1-usama.arif@linux.dev>
References: <20260320140315.979307-1-usama.arif@linux.dev>
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

Add a fallback in thp_get_unmapped_area_vmflags() that uses the
filesystem's mapping_max_folio_size() to determine alignment, capped to
the mapping length via rounddown_pow_of_two(len). This aligns mappings
to the largest folio the page cache will actually allocate, without
over-aligning small mappings.

The fallback is naturally a no-op for filesystems that don't support
large folios and skips the retry when the alignment would equal PMD_SIZE
(already attempted above).

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e2746ea74adf..4005084c9c65b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1242,6 +1242,20 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 	if (ret)
 		return ret;
 
+	if (filp && filp->f_mapping) {
+		unsigned long max_folio_size =
+			mapping_max_folio_size(filp->f_mapping);
+		unsigned long size = rounddown_pow_of_two(len);
+
+		size = min(size, max_folio_size);
+		if (size > PAGE_SIZE && size != PMD_SIZE) {
+			ret = __thp_get_unmapped_area(filp, addr, len, off,
+						      flags, size, vm_flags);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return mm_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags,
 					    vm_flags);
 }
-- 
2.52.0

