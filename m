Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116042;
	b=K29eCFJiBaAyTAjIrvWhtX5pGPiL9opW8JoZTXLsq+TxIs1MPfF99wwKuPkCLCTBW5dg
	 2VWuwi+7nTzfyejDkl7wrU8+tUGWk7GG+I02Mdewpn89skr0euC6ChyRjaf67p0P04x9W
	 ZbE1e36u8a23i/O1HprSJwCgeETwVcBBwVDa/w4F92Ywbs/MVZoaaDi74UrgLmgqwI0pp
	 x+5dZ3ymVXvhcJTpEwzukmQutzfxyJkyq9fE202d5/NFU5f7Wek3FJm7kdcfPh3v7maaa
	 Ykyhr0y0RzVK21bHT3m+6dZMPHNcwyLbYqbE52zDwFK+L0/Y5Om/BvIPWgSkI5w6Wjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6vMAPCp1wpjFuFIUnktZkIDiiA7zyUFU2h3UC7p8Or8=;
	b=NFd0prblB6t4GS+bpQpbQn4+ouJg+pdMQ2iubHICMj9TSVKTyNVWvL4r99jlE4ACEQ1h
	 tTrVTY9GKa6/vyioDVrUulHbITykclVdALyKfk9iLcZdmFndhINz84MydHmTzXmCbOfe0
	 jEXuVahYvOyE3a2rYz6VuqlDdBBP0dwsJ61kj6jztWXKGaif6bgd2f+TQqBpDwkCAsVOu
	 k0e+MJnoVwNaSCUmTKgvxSuptFtmJwTs7F9hKsgVGK+UF9rZvy2gHz3sHYEusUU2/jHL9
	 /B85oW+i5LCIufSDgyYe0KeoTxtP85r0SNMA0/3cXJiZklQshhWz6FXcwXjv5zThbWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVhWHHvN;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF6606E6D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBDF6606E6D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVhWHHvN
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b042c0759so2401911f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116040; x=1793720840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vMAPCp1wpjFuFIUnktZkIDiiA7zyUFU2h3UC7p8Or8=;
        b=YVhWHHvN4Punh+vUCOenlsDd5c3BwRws3SY32mhX6zlcwjUouXMlSjAtraM9gcXkrk
         8FhCpFNOpaTBLYuZon6spJ1+peXOCRX5aF7B/ezAqFWKCU16OHspcFTXFZvcqtkhmdlW
         2zC3gKwq9cAVp4J/rKYoEGjKpTYCEMiVShOin7bOapDpKROEbXONtTFoVY/Upbf4PvIT
         085Xql4nG04IjXPIj/CQifSTPiozfkS2TaZ57mOx2M5RpvuvLJkhXw26t3N6dm6KANGe
         MMgP65/rohcVdOUfSwIbfnLojzNaoTt6ohcbonp6/naJmt1EqIUDc/iiRIOzp7vEarEQ
         8WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116040; x=1793720840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6vMAPCp1wpjFuFIUnktZkIDiiA7zyUFU2h3UC7p8Or8=;
        b=fWvT1nftj7V9C84GH+hMSMznMBjUPGCnlTeJHWtJCuDNlzqM4sZQDYyyGnodyMT9aM
         qV5yDeOOgsIRaoQ6IRSOmshIRycszcOxoOvrZ4MEH28sssCKlL/srdO7J0LOWQiIvMhD
         KapAEVZboDb7gQDcXosd3WSLT1DjobGNHRiqU21kmNEheppEiD0ZijCXWZ5SdipUuQUC
         qbpzI1yoQUJupV0iT+LdBq1shzAt0B/jThNPZKpctz8RJwuQpveGTUQRCqqmFYhQc2uA
         zUmtmKuUzIvJToRQlYaX0ulIAQnA96cGPpvvp5o9boqrqWOIy7CKwtJBRFVkz4/5iOXd
         7JpA==
X-Forwarded-Encrypted: i=1; AKwUvByfl8Bf8/q0ixpWyUmBxDpYXZ1WB4ZyuzIiF2nojErH7uxhRbHLPq+2WET/opt1M3+Advga0bmxbfjSeyQ1@vger.kernel.org
X-Gm-Message-State: AFq9FYLWdmIPmoHPkqU3vvOYe1rxmzYhDRu2paxkO2meLTU17NVWCgR5
	7ZWBOarw5BdJsNJc3NFDjwHzm6Of6Pb8YJ93tp/I4vKPRSjlRZNUusKh
X-Gm-Gg: AYBFou3dRHjJBcHrsODlTzE9tMdVLOhzpeKL8HAKRzkLXVZyedUe6tFoCn8X/7LLWC+
	1FeLIWTa45RXSzRSeOkhnyH/FCPudtZ1WrcGyb8FzrOWdI76YAQjuHUxHXRZGfAr+hZAZ2xyiqJ
	bNCv5S7JtroRjlgI+Dq8vgeP3NWJgTQkMDF7hc3O9nbp0HYyCr2rbswlcelg4r6hj5M2sx08ZxC
	1OzHG4AcpAvYgFMFPWG2RJ8NnuVcDuXrWLVmKmw3t7YckrLey/Wcue6+r01tDeLxEbqGy4O1aux
	/o8/KxZ9orAgQc1y2Cd+Kumh7OEHLWbW0+TorybrLfgugA6scp590WNNLnRkvKMprq6Fk8xlxlb
	k71O7Xp+CTbcoZ+x4WuzGmq8H/BI2WbgvK12RjQupRUmO8OkYdQ5u4V/P3Sez7I8Om/S85ocVta
	6K1bZJyP9Xfvtq1mIBrM6jZ8WtmLhNCTp8qW+ctELaUCLtZ0Ju+ZMpm/rbhiGQ78EsJls1iX4bj
	B6gPizj8A6LWjCONN2TUkVgmI54NEioBVRFd6jRfDFh8msdTOtpSZLj7XPK/XyHhEdQdB6BNqCg
	FgPxOs6pnR8NEUaLqxpKRbs296JMcILO/W8Z2ssQV3p2q4dd10bAL0EAyDY65oaaStsQ8cg+TUT
	VZ+7QpO990qQv4OEI3H0FNsteQIEQUHEgXF0ZYw==
X-Received: by 2002:a5d:5d0b:0:b0:48d:f39b:83de with SMTP id ffacd0b85a97d-48e3eb46758mr20927440f8f.3.1793116040069;
        Tue, 27 Oct 2026 08:47:20 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:19 -0700 (PDT)
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
Subject: [RFC PATCH 11/14] KVM: guest_memfd: Add kvm_gmem_restore() for PFN mode providers
Date: Tue, 27 Oct 2026 15:46:46 +0000
Message-ID: <20261027154649.91571-12-griffoul@gmail.com>
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

A device cannot fault, so when a PFN mode provider gives frames to pages
that had none, or makes a read-only frame writable, a subsystem that
maps the file must be told. kvm_gmem_revoke() does not fit: it would
zap the guest's and the VMM's mappings and reclaim frames that a guest
may already use.

Add kvm_gmem_restore(), the counterpart to kvm_gmem_revoke() that the
sample provider leaves for users that cannot fault. It only updates the
exports, under the shared invalidate lock.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/Makefile       |  1 +
 include/linux/guest_memfd.h | 37 ++++++++++++++++++++++---------------
 virt/kvm/guest_memfd.c      | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 25fb3d6e2032..3255280884b5 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -63,6 +63,7 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_write_track_remove_gfn \
 				-e kvm_file_to_kvm_fn \
 				-e kvm_gmem_revoke \
+				-e kvm_gmem_restore \
 				-e kvm_gmem_export
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index f8e89723dd68..45572d929bd7 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -75,12 +75,18 @@ struct guest_memfd_provider_operations {
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_pages,
 		    const unsigned long *pfn);
+void kvm_gmem_restore(struct inode *inode, pgoff_t start, size_t nr_pages);
 #else
 static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_pages,
 				  const unsigned long *pfn)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void kvm_gmem_restore(struct inode *inode, pgoff_t start,
+				    size_t nr_pages)
+{
+}
 #endif
 
 /*
@@ -90,14 +96,15 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * nor fault them.  It attaches to the file, looks up the frame behind each
  * shared page without taking a reference, and guest_memfd calls its update()
  * whenever what a lookup returns for a range may have changed: conversions,
- * punch holes, memory failure, a provider's kvm_gmem_revoke(), fallocate() and
- * pages getting their first frame.  update() makes the consumer's mappings of
- * the range match what a lookup returns now: a frame, or a hole for a private
- * page or a page without a frame.  It may be called for pages that did not
- * change, and for ranges that do not follow the blocks that lookups report:
- * the consumer may then remap whole blocks, also outside the range, e.g. to
- * merge them into larger mappings.  A consumer that can fault may instead only
- * remove its mappings of the range.
+ * punch holes, memory failure, a provider's kvm_gmem_revoke() or
+ * kvm_gmem_restore(), fallocate() and pages getting their first frame.
+ * update() makes the consumer's mappings of the range match what a lookup
+ * returns now: a frame, or a hole for a private page or a page without a
+ * frame.  It may be called for pages that did not change, and for ranges that
+ * do not follow the blocks that lookups report: the consumer may then remap
+ * whole blocks, also outside the range, e.g. to merge them into larger
+ * mappings.  A consumer that can fault may instead only remove its mappings of
+ * the range.
  *
  * Until update() returns, the frames it replaces stay valid, so a consumer
  * may switch each mapping to its new target in one step; once it returns,
@@ -106,14 +113,14 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * beforehand.
  *
  * guest_memfd calls update() with its invalidate lock held, exclusive when it
- * takes frames away or pages convert, and shared when pages only gain frames
- * and on memory failure, possibly with a folio of the file locked; so update()
- * may only call kvm_gmem_export_lookup_pfn().  Under the shared lock, updates
- * may run at the same time, also for overlapping ranges.  The consumer holds a
- * lock across a lookup and the mapping it installs, which update() also takes.
- * Lock order:
+ * takes frames or write access away or pages convert, and shared when pages
+ * only gain frames or write access and on memory failure, possibly with a
+ * folio of the file locked; so update() may only call
+ * kvm_gmem_export_lookup_pfn().  Under the shared lock, updates may run at the
+ * same time, also for overlapping ranges.  The consumer holds a lock across a
+ * lookup and the mapping it installs, which update() also takes.  Lock order:
  *
- *   PFN mode provider lock (across kvm_gmem_revoke())
+ *   PFN mode provider lock (across kvm_gmem_revoke() and kvm_gmem_restore())
  *     guest_memfd invalidate lock
  *       consumer lock
  *         provider leaf lock (get_pfn(), lookup_pfn_range())
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 42bb5f263e23..37ff2fae89ae 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -431,8 +431,8 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 
 /*
  * What a lookup returns for [start, end) may have changed: exclusive lock when
- * frames were taken away or pages converted, at least shared when pages only
- * gained frames and on memory failure.
+ * frames or write access were taken away or pages converted, at least shared
+ * when pages only gained frames or write access and on memory failure.
  */
 static void kvm_gmem_update_exports(struct inode *inode, pgoff_t start,
 				    pgoff_t end)
@@ -592,6 +592,37 @@ int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_pages,
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_revoke);
 
+/**
+ * kvm_gmem_restore - Tell guest_memfd that memory of a range is now available.
+ * @inode:    The guest_memfd inode.
+ * @start:    Starting page index within the file.
+ * @nr_pages: Number of pages.
+ *
+ * A PFN mode provider calls this when it gives frames to pages that had none,
+ * unless get_pfn() does so for the block it reports, and when it makes a
+ * read-only frame writable.  Nothing is taken away, so the guest and the VMM
+ * need nothing: they fault the pages in, or get write access on their next
+ * write.  The subsystems that map the file cannot, and are told to map the
+ * range again.  A change that takes something away, a frame or write access,
+ * needs kvm_gmem_revoke() instead, which updates them too.  Does nothing past
+ * the end of the file.
+ *
+ * Context: May sleep.  Must not be called with the provider's leaf lock held.
+ */
+void kvm_gmem_restore(struct inode *inode, pgoff_t start, size_t nr_pages)
+{
+	pgoff_t max_pages = i_size_read(inode) >> PAGE_SHIFT;
+
+	if (start >= max_pages)
+		return;
+	nr_pages = min_t(size_t, nr_pages, max_pages - start);
+
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	kvm_gmem_update_exports(inode, start, start + nr_pages);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_restore);
+
 /*
  * Zero a folio on its first use.  Lookups find it from then on, with no
  * reference held, so mark it dirty: memory-failure handling drops clean
-- 
2.47.3

