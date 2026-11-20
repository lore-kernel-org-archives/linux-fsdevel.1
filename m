Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136844;
	b=KFkOikQVndabV6XbDgaP9TCewOEvy5n7lqW+SaYe7Y2JISLjuXogLddJkrkFvLSCOz9k
	 XrJ1tP8uriKE9kfwL1HIGlIVCA6D+w2OK5rz4oc89RAoZc0v/hgcwLQG+GQgRw3zO2kQ4
	 q5qEoNgGfbSy5tixVjguvzpY2VKqfWRe8MJ1dS0FnZMHpK0oMU9+nhOM2hRuwwbKLIM+o
	 i2cqmgGUEjryTOXNc6mqlaM/7atsnf8R6RqF5GG3TrZcZm1hUdBYq1las9GDDGOqgbhlA
	 7RFWpKMY1GW+JM+v3+hzACbovVAirRpLMC4DpC3yrAFyF+9GxlJ36l32ZewZ6Ppn6Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dRkr2BvKaK0JNp+xEr+CP1uqN9jcKW992wqEJ/xsaHY=;
	b=zpRfvC1/Vg9FuNv1pvgtCNpPJpjTYxzfCliqFnroQ+5n7NOzGMuebrJOFjNatQJKP5EK
	 yF9Y1p2lIIcehoNbC/zlrA6RJKref7aqeenV5KsstHlNMp1ZVwc1evS2tzCOtO8OamPJD
	 Ts7XJxIUqZbdGV/5NdR2i3bDfZq1aPQ8FNWn+4R/Q1Rri39EdRrBe3kGoDEcqMbvu4Ov2
	 qqSRXAfHOLcbt37DW4GZk0JsTmPKfbevSKSQ0raA8gFGLX1WEDEUQwnAChpL84fmiqgJE
	 8MLXilWawXtoBW34PhVbiwPZgiAyyrLPLW/XDefv6236IBUNOlL6cLkjlnTxVEh8K4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ES4ennDZ;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BD60A5BCC
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586BD60A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ES4ennDZ
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b9095eeb5bso1951241a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136843; x=1795741643; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRkr2BvKaK0JNp+xEr+CP1uqN9jcKW992wqEJ/xsaHY=;
        b=ES4ennDZTflXaeQYEQfAfoxa0BxH02PkL8QJTPLMmiyR8dGrQsgV/SPDpmfK9jWggM
         8PsX/g1+mZvKeuRNgQkM8SEyf2GEO9at10u0q9ywBXwoo9l49k6G4O/x40PqgY030zP/
         igs4cHyJTjN/xg8fABXqLn9FfqPtAL28NK9ZFbdjjzUI7ufY/4gx3bAOAuFk3MLlq7VR
         qpTGXQmaxwPLPGIKBdDahDSf6RCltzeLW6C+1MDEgwNoiZxMqqYB14/uaR1OzpKhQwlL
         S9hgbuZSqmEyW1dCCCazJwkmHAGJfc27Sv+lSoZqyUK6hrlaDOSC4YVeqtW5w+FUWT9B
         kYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136843; x=1795741643;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRkr2BvKaK0JNp+xEr+CP1uqN9jcKW992wqEJ/xsaHY=;
        b=N1AVD1XsVI4ka+sg6VY1ucHfq2awdn53Cfk806IlH5lNTo/t7UXXJDOX4iUPSzthlQ
         up7t6dHWCKEkUiTQAIYBT2Ek+fRE7d/dkA2SCFzdB/AiZe0/ZGT8TzllX1z+cINhNOII
         KQ1U4jFNxKPRtwrAWOK2VYJbujl4ixWJBiQjDNH3OuReapxQpMfJPdVfNNZbXSYwmBkg
         osmLp9n2QUUHRsqcjPTx1VwzTY4attYNyI2qJwrZDdfp7tkuik22g9YiY0Rk5N/jjXBE
         ac6FgJCMhvRZBlo6HXQBGnYTQew9VlZP+wrYHi7pfMt1rS6/e9K8vd+Hv17PaQhnjRKQ
         DC3A==
X-Forwarded-Encrypted: i=1; AL+hErGDSTxv+uHXdAy0ogjYxPlnWhWNAjob4zMDyvaAq4CioNsZurim7dOFjDJinEBqvtNC5MEksES1khT09pfD@vger.kernel.org
X-Gm-Message-State: APuU4Z9mRObWk0KIYRUY3v4Gct6n/IiJ0MVvC+74R6KKpT2eP9Eyl7ni
	FRGXTB15NwBREKxiFVZ6AuLJG1V5cbkRmaPi5fpcshzdvyt2yIxz8MHWf4BuFjS7GoPq7NXcEyC
	Rm/ayMg==
X-Received: from ejcfw45.prod.google.com ([2002:a17:907:502d:b0:c50:519f:c790])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:370b:b0:c51:34ae:dd7
 with SMTP id a640c23a62f3a-c5134ae12d8mr166377466b.17.1795136842505; Thu, 19
 Nov 2026 17:07:22 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:50 +0000
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261120010655.467825-21-lrizzo@google.com>
Subject: [RFC PATCH v3 20/25] arm64/mm, mm: Support decrypted PISA pages in Realms
From: Luigi Rizzo <lrizzo@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Naman Gulati <namangulati@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

An arm64 Realm (ARM CCA guest) only reports CC_ATTR_MEM_ENCRYPT, so PISA
did not treat it as a CoCo guest and refused to initialize there.

Treat a Realm as a CoCo guest: PISA pages are decrypted (shared with the
host) when they are allocated, as on SEV-SNP and TDX.

A decrypted page is mapped with PROT_NS_SHARED, the top IPA bit, set in
the address field of its PTEs. PISA maps such pages into user space with
ordinary PTEs (page cache, migrated user pages, zerocopy receive), and
for those pte_pfn() must be the PFN of the page, or vm_normal_page() and
GUP see a PFN that has no struct page.

Make __pte_to_phys() strip the bit when what is left is a decrypted PISA
page. The check is behind pisa_decrypt_key, so outside CoCo guests it
costs one static branch, and every other shared mapping (ioremap() of
emulated MMIO, swiotlb, DMA mmap) keeps the address it has today.

pisa_decrypt_key and the lookup are exported because pte_pfn() is used
by modules.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 arch/arm64/include/asm/pgtable.h | 28 ++++++++++++++++++++++++++--
 mm/pisa-meta.c                   |  9 +++++++++
 mm/pisa-node.c                   |  9 +++++++--
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a474c9fb485ad..86c60b8f43ae0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -108,7 +108,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 			  TLBF_NOBROADCAST | TLBF_NONOTIFY | TLBF_NOWALKCACHE)
 
 #ifdef CONFIG_ARM64_PA_BITS_52
-static inline phys_addr_t __pte_to_phys(pte_t pte)
+static inline phys_addr_t __pte_to_phys_raw(pte_t pte)
 {
 	pte_val(pte) &= ~PTE_MAYBE_SHARED;
 	return (pte_val(pte) & PTE_ADDR_LOW) |
@@ -119,7 +119,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
 }
 #else
-static inline phys_addr_t __pte_to_phys(pte_t pte)
+static inline phys_addr_t __pte_to_phys_raw(pte_t pte)
 {
 	return pte_val(pte) & PTE_ADDR_LOW;
 }
@@ -130,6 +130,30 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 }
 #endif
 
+#if defined(CONFIG_PISA) && !defined(__DISABLE_EXPORTS)
+DECLARE_STATIC_KEY_FALSE(pisa_decrypt_key);
+bool __pisa_phys_decrypted(phys_addr_t phys);
+#endif
+
+static inline phys_addr_t __pte_to_phys(pte_t pte)
+{
+#if defined(CONFIG_PISA) && !defined(__DISABLE_EXPORTS)
+	/*
+	 * In a Realm, PISA maps its decrypted pages into user space with ordinary
+	 * PTEs. Those have PROT_NS_SHARED, the top IPA bit, set in their address
+	 * field, but pte_pfn() must be the PFN of the page: strip the bit when
+	 * what is left is a decrypted PISA page. Other shared mappings keep it.
+	 */
+	if (static_branch_unlikely(&pisa_decrypt_key) && (pte_val(pte) & PROT_NS_SHARED)) {
+		phys_addr_t phys = __pte_to_phys_raw(__pte(pte_val(pte) & ~PROT_NS_SHARED));
+
+		if (__pisa_phys_decrypted(phys))
+			return phys;
+	}
+#endif
+	return __pte_to_phys_raw(pte);
+}
+
 #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
 #define pfn_pte(pfn,prot)	\
 	__pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
diff --git a/mm/pisa-meta.c b/mm/pisa-meta.c
index 99c5bc42eed10..b608ef71152af 100644
--- a/mm/pisa-meta.c
+++ b/mm/pisa-meta.c
@@ -189,6 +189,15 @@ bool __is_pisa_direct(phys_addr_t phys, size_t size)
 	       (phys & (PISA_SIZE - 1)) + size <= PISA_SIZE;
 }
 
+#ifdef CONFIG_ARM64
+/* For __pte_to_phys(): true if @phys is in a decrypted PISA page. */
+bool __pisa_phys_decrypted(phys_addr_t phys)
+{
+	return pisa_pfn_flags(PHYS_PFN(phys)) & PISA_DECRYPTED;
+}
+EXPORT_SYMBOL(__pisa_phys_decrypted);
+#endif
+
 /*
  * Update @meta's position on @pa's lists under @pa->lock. When all blocks
  * become available (avail == bpp), either queues @meta to @pisa_free_list (and
diff --git a/mm/pisa-node.c b/mm/pisa-node.c
index 12fbb617c342b..aa4f8759ae5e8 100644
--- a/mm/pisa-node.c
+++ b/mm/pisa-node.c
@@ -36,11 +36,16 @@ unsigned int pisa_reservoir_max __read_mostly = 16;
 
 /* Enabled in CoCo guests by pisa_node_init(): new PISA pages are decrypted for DMA. */
 DEFINE_STATIC_KEY_FALSE(pisa_decrypt_key);
+EXPORT_SYMBOL(pisa_decrypt_key);
 
-/* A confidential guest: PISA pages are decrypted for DMA. A bare-metal SME host is not one. */
+/*
+ * A confidential guest: PISA pages are decrypted for DMA. A bare-metal SME host
+ * is not one. An arm64 Realm only reports CC_ATTR_MEM_ENCRYPT.
+ */
 static bool pisa_coco_guest(void)
 {
-	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
+	       (IS_ENABLED(CONFIG_ARM64) && cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 }
 
 /* Memory encryption that PISA cannot handle: neither an SME host nor a guest it decrypts for. */
-- 
2.56.1.809.ga0b61035b5-goog

