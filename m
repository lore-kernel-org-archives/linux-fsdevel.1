Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116029;
	b=Ez2I1GyDZoaEuuo5nzH8AQhx6NHRiMRdrU8EkqqdrfVVtvfbVsQKoO5NepSYiaaK3/PE
	 l6NEP0ej+1TE1hsacfItyV0IBzFOiOYPIC9b8uzsHRYr+8FMYnoUH8PF5NzmT81WNn6D3
	 DkLLZNN0d0YLwhbiADDBC293DlkqkTgLWHI6pdSsHU6gRaakPaRMiOqkNYXm7KWZsumC4
	 xyvBCpw/R+kiQFnQ7PScR9gNnvYh/X3jzDROnwU9CkGaJmMvjcBuTdeKNK5BGvA6tK30F
	 1Uf5xVOPzed9/VTyMhzyDNw9Vuhg8qFzD8NkI4sxmISsDIm09MQ0lYJKhogbOeEDjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I9tKrbL54EVqcIFPPtB7uxrxNAXJtibM80HAzpUcWLM=;
	b=bjKCHk4qVuTdFoBPzU9kYwwRmiPPtzW9UUvkam4HjSRzEDZ/mD7Q124KS6MawzXerG/G
	 EuRwrcmmenqBWbNjHH3ERrtRmqHKPHwsLLy4OTrx1DNLnzeWtMzVr97bw6nPpoNl+iSc0
	 NOu2e3X9GvCLM5XUkWS+/YWl0eouYgiGEX4esfuIkOpgeSA9JKz7GYDt8UW1Oi5tssS52
	 Wkmj0iSLpuvvYjmQuEa/9XzE/dXe6Bh3Ee/WC7d/E+De0WdC2uhRfH9Dbnj1O+WlQRObp
	 f7Cya9U4xKcvhJ1ttnmrDEgSBSb9FWBbchfZ1Audm4UV+Nch7sLPChivcFRGXqENNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRmVMWZO;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BF60A2618
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113BF60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRmVMWZO
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so879583f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116027; x=1793720827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9tKrbL54EVqcIFPPtB7uxrxNAXJtibM80HAzpUcWLM=;
        b=yRmVMWZOSgYOouFJ3XXj5aw0KaSgckQYEvRlJmiAj5iMaleGe121rSWoqxNhtg5N14
         hX5jZ8iCw6nxxKWsfk/jfcRNcK4D5RPZtrs/ZHpXMxQdJwUxLv/D02GyG9ly0itjET0l
         QYJWU9CIDnW5SAScmWpFXXCYGxlIWaup/cyg16ZIu7O9e5Jaz34+seo9RmRvx9F/GpWp
         7s0vaOvPuzftBCOXtxey5t+MSQh2D/edaVW4fxD59EZn55DdlWfybRHvnQ7jdJCtNXnA
         aMKrIfeza+LyTAm3fNuJlj9oeBD8wLhxs5ehug6UvNlcUaWev8fOiNZ+aFqThE2FqT+j
         rlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116027; x=1793720827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I9tKrbL54EVqcIFPPtB7uxrxNAXJtibM80HAzpUcWLM=;
        b=iCRrqcg0x5khViHLV+c1CNuIdFrfqsz8v6yMEJfTWHKSJkEe/749C4iTia1PwpwEHp
         o5TxcRmVujo7hSGTeP0LxDuc44EPtNzORdsbR4ZGSOI2wySuvjLdvT58/e5CVGdqlQ2v
         clJ31SAfUIDpN72BjV/nUMQCqbhim0DwQHb8wOApDlDEnDiByCX+sBOwu9anV166i/3L
         ORwTotxhuYGBmDIhfRFsxYPmBN0bcBaElpLBi9htOTyC8bj+z18/LvaWALQfDZiWfQu2
         3gfNKLVpXRVL3A3QK6K2h0R3QYiQFaojhqPDJWPu2qXgU6xKoKmSGkDExY2SYFiRNS7X
         CGIw==
X-Forwarded-Encrypted: i=1; AKwUvBzfLrLb10sN/lksLF2ISvertXs9KDt0uC4VfyY8vEh2gInQuJkEA9ZsEZ4T6po8mMHEfBEdAE+QlV5z8IIE@vger.kernel.org
X-Gm-Message-State: AFq9FYLedl1XF5R7x8Ab1dCywWWdc3pC54SdewU0d1SqLEt61ZMDBd/e
	ApaMGVSsZCgy5HgrlIyk2csaufj44e6+fgTxOsRzDPtP9l3mtizyzAZ0
X-Gm-Gg: AYBFou0KTy9A03zQba7hVidj3Dckgq7lPoqhkm2pOpm1agbIUOSlEIhmT7m261wpuP+
	X8Xm+MrkdeiuIYYjYuUkUhVt712sVyrt4f+swjmh7L7NKbtCE/eSnCXaw5gL457R9WJnQvYBCpS
	uHT3YtLwK1TkiG/oDR7CSxDa411iFTwBI6T3Hl4Sb4jDENPiff8IzxKZHNvBHkwmmBNFQcIBXUZ
	Gim42NhQ9kYuGW7q91fCF0tMO4fSQAFR6jPqBs7MDpKspQzjjJLrtURMz6mffXY6PwLhagHURKs
	I89QnWy0QIX6zMOEjcnHPVzOfFMJfc1hiugZFvckPRNP91jAPTM8SZ7TeDBtfC5Vx4tBbMbAA68
	iFaI9vYrPBAwTqDHN1qb2X/Tjoh9cHHpTgUvjuSh4iKP0w7KH9zbYmfQ6nNPUUXm14GzZUoTGEO
	ki3GYzj8SelddJoNKAPUbyqizF54LE+GeSwPhR7aC/z6WfqCU64YL3E2fUq1Z3rACGodai9xXtP
	2bE3bbRB5fYKEKFniiAGKX3nJ99QOXXqxAFdPm6iuwifh8eIQPWJ6z+Yj/P5LR7lGOAbUwq7Ptf
	CLuCdbKOGqvZCp16zBFEmLlcc207quNWcUqda5gnBItNOuwYE5lVIltIagENkhBgmLzWW6Nqxdm
	gHKjnv9yu3cUKQ4LHkHp9/X4ItwKZ529gh3KWsQ==
X-Received: by 2002:adf:ebcd:0:b0:48e:4ad2:32e0 with SMTP id ffacd0b85a97d-48e55a5a8bemr4605062f8f.29.1793116027147;
        Tue, 27 Oct 2026 08:47:07 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:06 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: [RFC PATCH 06/14] KVM: guest_memfd: Report the size of holes in export lookups
Date: Tue, 27 Oct 2026 15:46:41 +0000
Message-ID: <20261027154649.91571-7-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027154649.91571-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

A lookup reports a hole as a single page, so a consumer walks a large
private or unbacked range one page at a time, and cannot map a large
hole with one entry, e.g. to a scratch page.

Report the largest aligned hole around the page, up to the order the
caller asks for. The search checks one half-block at a time, so it
costs about one lookup per page of the hole it finds.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 virt/kvm/guest_memfd.c | 48 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 015f6657c386..1c5826c5384e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1417,6 +1417,48 @@ static int __kvm_gmem_export_lookup(struct inode *inode, pgoff_t index,
 	return 0;
 }
 
+/* Does no page of [start, start + nr) have a frame to map? */
+static bool kvm_gmem_export_is_hole(struct inode *inode, pgoff_t start,
+				    pgoff_t nr)
+{
+	unsigned long pfn;
+	pgoff_t index;
+	u32 attrs;
+	int order;
+
+	for (index = start; index < start + nr; index++) {
+		order = 0;
+		if (__kvm_gmem_export_lookup(inode, index, &pfn, &order,
+					     &attrs) != -ENOENT)
+			return false;
+		cond_resched();
+	}
+	return true;
+}
+
+/*
+ * The order, up to @max_order, of the largest naturally aligned block around
+ * @index that lies inside the file and has no frame to map.  Each step checks
+ * only the half of the larger block that does not hold @index.
+ */
+static int kvm_gmem_export_hole_order(struct inode *inode, pgoff_t index,
+				      int max_order)
+{
+	pgoff_t npages = i_size_read(inode) >> PAGE_SHIFT;
+	int order;
+
+	for (order = 0; order < max_order; order++) {
+		pgoff_t n = 1UL << order;
+		pgoff_t first = round_down(index, 2 * n);
+
+		if (first + 2 * n > npages ||
+		    !kvm_gmem_export_is_hole(inode, index & n ? first : first + n,
+					     n))
+			break;
+	}
+	return order;
+}
+
 /**
  * kvm_gmem_export_lookup_pfn - The frame behind a shared page.
  * @e:         The export.
@@ -1424,7 +1466,8 @@ static int __kvm_gmem_export_lookup(struct inode *inode, pgoff_t index,
  * @pfn:       The frame.
  * @max_order: In: the largest order the caller can map.  Out: the order of
  *             the naturally aligned block around @index that is contiguous,
- *             shared and of the same @attrs; 0 for -ENOENT.
+ *             shared and of the same @attrs or, for -ENOENT, that has no
+ *             frame to map at all.
  * @attrs:     The GUEST_MEMFD_PFN_* attributes of the block.
  *
  * Takes no reference and allocates nothing, and may be called from the
@@ -1438,6 +1481,7 @@ int kvm_gmem_export_lookup_pfn(struct guest_memfd_export *e, pgoff_t index,
 			       unsigned long *pfn, int *max_order, u32 *attrs)
 {
 	struct inode *inode = file_inode(e->file);
+	int order = *max_order;
 	int r;
 
 	if (index >= i_size_read(inode) >> PAGE_SHIFT)
@@ -1445,7 +1489,7 @@ int kvm_gmem_export_lookup_pfn(struct guest_memfd_export *e, pgoff_t index,
 
 	r = __kvm_gmem_export_lookup(inode, index, pfn, max_order, attrs);
 	if (r == -ENOENT)
-		*max_order = 0;
+		*max_order = kvm_gmem_export_hole_order(inode, index, order);
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_export_lookup_pfn);
-- 
2.47.3

