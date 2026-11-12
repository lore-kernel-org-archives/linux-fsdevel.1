Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482753;
	b=WknR1ZEfs3dq6GQJFnjFCcrmvpBzBaG0O83HD6FULmw8I96S6oBha8bYoZwSk0n7jT7a
	 6Sah2eX5a/hJHKF4X2aR5lz/a0ExRncjKxucGLtgT4gat8HbYtZWWSp+5ef5NJCkqB6JJ
	 AY5rC4DdDHfsdlSXA+uqnzgsEd46tlSDKTRF3eN5wkjLfRvGcVquA4ptnZ/S5D5Ba7umT
	 ZfdPGyMgcJOEWLMKGIkP92Q6xFsX8kd/SG8IoBd4Py2twjZ/t739kCbWsC0gIWYCUf/GV
	 gJwc5m9n6eYUi8yv0aJB3jZgJoPcuzrY+4ZfEwzabvdS2/59jIk/s6IvO4A2O3XugbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bsiyTGE3E/PTM1EG/tisvzM/pe3H12wpmJnKZF8EROE=;
	b=dhXX/JL4EjnRhdJ7fDcTPu8BwRYl29bzuU0fVq5Yd3jcJG77Lyzjvghg+XBC/OJvdbk4
	 5RMlQ+lCh0XSgRNb+LJi46knx0ftZvHSwK5xuIjyUOtDt9exzMkj5PcUoglMaFVjtafhB
	 OU8vHTUcJ1hihCcWAme1IC2ixGVWVlHmeGY2M4Yj8APp3+IMtnhieFXEEwt0764FRyN+R
	 r11SFHdQxOEZ2TeAM0ViTXzVyaoUkWdbvTtqNM9raRAKdWVeRhRVNRfVU1jrn653EXgEI
	 xWn+5c0I7JltlFlA1xOSbpQEEp9LfHbUm8X+/HE3h2YxpKQgkGaWf/2/DlTQt4tu4Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gwt/fNWO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAB606A327
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwt/fNWO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584E31F00A05;
	Thu, 12 Nov 2026 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482753;
	bh=bsiyTGE3E/PTM1EG/tisvzM/pe3H12wpmJnKZF8EROE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwt/fNWO4++DPBZwX3yvy9kSW4ZY0iIGZxE1ev1Ec/HjhSJzhR9dp8QRwivd0Ht3p
	 xcyNJ5+Ii5dDH71RIZ/WrlxY6mzgvXWVa02xFA262X3UF1UJDZdpbOOL5DarZthRox
	 DN+DOS9qOr+0ba/mcrRaxwYV+Ybkuc67H7niR6nt9NbeCn7vnFaMQobSRVuEtgl8ug
	 JVUWeJusKt1vvnf9ZAo8P+0iaKoRUjQpRGZXx1MCjtbwdxVohJ1PHAIXYqZs7D2blf
	 R4yqBBDbfrOZMrRPSlacC7QEwj7+AGVoP+3t/kOZWKkOqabrUHAaMtG7o17D4v6tqs
	 QGNisUPNnJRdw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v2 2/6] mm: remove ARCH_NEEDS_KMAP_HIGH_GET
Date: Thu, 12 Nov 2026 12:25:24 +0100
Message-ID: <20261112112528.1116405-3-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112528.1116405-1-arnd@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

Arm has stopped setting ARCH_NEEDS_KMAP_HIGH_GET, so this
is handled using the same wrappers across all architectures
now, which leaves room for simplification.

Replace lock_kmap()/unlock_kmap() with open-coded spinlocks
and drop the now empty arch_kmap_local_high_get() and
kmap_high_unmap_local() helpers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/highmem.c | 100 ++++++---------------------------------------------
 1 file changed, 10 insertions(+), 90 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index a33e41183951..214164f9172b 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -143,25 +143,6 @@ static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
 
 pte_t *pkmap_page_table;
 
-/*
- * Most architectures have no use for kmap_high_get(), so let's abstract
- * the disabling of IRQ out of the locking in that case to save on a
- * potential useless overhead.
- */
-#ifdef ARCH_NEEDS_KMAP_HIGH_GET
-#define lock_kmap()             spin_lock_irq(&kmap_lock)
-#define unlock_kmap()           spin_unlock_irq(&kmap_lock)
-#define lock_kmap_any(flags)    spin_lock_irqsave(&kmap_lock, flags)
-#define unlock_kmap_any(flags)  spin_unlock_irqrestore(&kmap_lock, flags)
-#else
-#define lock_kmap()             spin_lock(&kmap_lock)
-#define unlock_kmap()           spin_unlock(&kmap_lock)
-#define lock_kmap_any(flags)    \
-		do { spin_lock(&kmap_lock); (void)(flags); } while (0)
-#define unlock_kmap_any(flags)  \
-		do { spin_unlock(&kmap_lock); (void)(flags); } while (0)
-#endif
-
 struct page *__kmap_to_page(void *vaddr)
 {
 	unsigned long base = (unsigned long) vaddr & PAGE_MASK;
@@ -238,9 +219,9 @@ static void flush_all_zero_pkmaps(void)
 
 void __kmap_flush_unused(void)
 {
-	lock_kmap();
+	spin_lock(&kmap_lock);
 	flush_all_zero_pkmaps();
-	unlock_kmap();
+	spin_unlock(&kmap_lock);
 }
 
 static inline unsigned long map_new_virtual(struct page *page)
@@ -274,10 +255,10 @@ static inline unsigned long map_new_virtual(struct page *page)
 
 			__set_current_state(TASK_UNINTERRUPTIBLE);
 			add_wait_queue(pkmap_map_wait, &wait);
-			unlock_kmap();
+			spin_unlock(&kmap_lock);
 			schedule();
 			remove_wait_queue(pkmap_map_wait, &wait);
-			lock_kmap();
+			spin_lock(&kmap_lock);
 
 			/* Somebody else might have mapped it while we slept */
 			if (page_address(page))
@@ -313,60 +294,32 @@ void *kmap_high(struct page *page)
 	 * For highmem pages, we can't trust "virtual" until
 	 * after we have the lock.
 	 */
-	lock_kmap();
+	spin_lock(&kmap_lock);
 	vaddr = (unsigned long)page_address(page);
 	if (!vaddr)
 		vaddr = map_new_virtual(page);
 	pkmap_count[PKMAP_NR(vaddr)]++;
 	BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 2);
-	unlock_kmap();
+	spin_unlock(&kmap_lock);
 	return (void *) vaddr;
 }
 EXPORT_SYMBOL(kmap_high);
 
-#ifdef ARCH_NEEDS_KMAP_HIGH_GET
-/**
- * kmap_high_get - pin a highmem page into memory
- * @page: &struct page to pin
- *
- * Returns the page's current virtual memory address, or NULL if no mapping
- * exists.  If and only if a non null address is returned then a
- * matching call to kunmap_high() is necessary.
- *
- * This can be called from any context.
- */
-void *kmap_high_get(const struct page *page)
-{
-	unsigned long vaddr, flags;
-
-	lock_kmap_any(flags);
-	vaddr = (unsigned long)page_address(page);
-	if (vaddr) {
-		BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 1);
-		pkmap_count[PKMAP_NR(vaddr)]++;
-	}
-	unlock_kmap_any(flags);
-	return (void *) vaddr;
-}
-#endif
-
 /**
  * kunmap_high - unmap a highmem page into memory
  * @page: &struct page to unmap
  *
- * If ARCH_NEEDS_KMAP_HIGH_GET is not defined then this may be called
- * only from user context.
+ * This may be called only from user context.
  */
 void kunmap_high(const struct page *page)
 {
 	unsigned long vaddr;
 	unsigned long nr;
-	unsigned long flags;
 	int need_wakeup;
 	unsigned int color = get_pkmap_color(page);
 	wait_queue_head_t *pkmap_map_wait;
 
-	lock_kmap_any(flags);
+	spin_lock(&kmap_lock);
 	vaddr = (unsigned long)page_address(page);
 	BUG_ON(!vaddr);
 	nr = PKMAP_NR(vaddr);
@@ -393,7 +346,7 @@ void kunmap_high(const struct page *page)
 		pkmap_map_wait = get_pkmap_wait_queue_head(color);
 		need_wakeup = waitqueue_active(pkmap_map_wait);
 	}
-	unlock_kmap_any(flags);
+	spin_unlock(&kmap_lock);
 
 	/* do wake-up, if needed, race-free outside of the spin lock */
 	if (need_wakeup)
@@ -508,30 +461,11 @@ static inline void kmap_local_idx_pop(void)
 #define arch_kmap_local_unmap_idx(idx, vaddr)	kmap_local_calc_idx(idx)
 #endif
 
-#ifndef arch_kmap_local_high_get
-static inline void *arch_kmap_local_high_get(const struct page *page)
-{
-	return NULL;
-}
-#endif
-
 #ifndef arch_kmap_local_set_pte
 #define arch_kmap_local_set_pte(mm, vaddr, ptep, ptev)	\
 	set_pte_at(mm, vaddr, ptep, ptev)
 #endif
 
-/* Unmap a local mapping which was obtained by kmap_high_get() */
-static inline bool kmap_high_unmap_local(unsigned long vaddr)
-{
-#ifdef ARCH_NEEDS_KMAP_HIGH_GET
-	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
-		kunmap_high(pte_page(ptep_get(&pkmap_page_table[PKMAP_NR(vaddr)])));
-		return true;
-	}
-#endif
-	return false;
-}
-
 static pte_t *__kmap_pte;
 
 static pte_t *kmap_get_pte(unsigned long vaddr, int idx)
@@ -575,8 +509,6 @@ EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
 
 void *__kmap_local_page_prot(const struct page *page, pgprot_t prot)
 {
-	void *kmap;
-
 	/*
 	 * To broaden the usage of the actual kmap_local() machinery always map
 	 * pages when debugging is enabled and the architecture has no problems
@@ -585,11 +517,6 @@ void *__kmap_local_page_prot(const struct page *page, pgprot_t prot)
 	if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
 		return page_address(page);
 
-	/* Try kmap_high_get() if architecture has it enabled */
-	kmap = arch_kmap_local_high_get(page);
-	if (kmap)
-		return kmap;
-
 	return __kmap_local_pfn_prot(page_to_pfn(page), prot);
 }
 EXPORT_SYMBOL(__kmap_local_page_prot);
@@ -607,14 +534,7 @@ void kunmap_local_indexed(const void *vaddr)
 			WARN_ON_ONCE(1);
 			return;
 		}
-		/*
-		 * Handle mappings which were obtained by kmap_high_get()
-		 * first as the virtual address of such mappings is below
-		 * PAGE_OFFSET. Warn for all other addresses which are in
-		 * the user space part of the virtual address space.
-		 */
-		if (!kmap_high_unmap_local(addr))
-			WARN_ON_ONCE(addr < PAGE_OFFSET);
+		WARN_ON_ONCE(addr < PAGE_OFFSET);
 		return;
 	}
 
-- 
2.53.0

