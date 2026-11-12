Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482757;
	b=0W2MBNjov/UOzXCFUlkBU4hlk3KZUutpsZGZaCdrgTXE4WD31ZvdsNUNlTviuXNZmzpk
	 gQsitnw/8Iqkj2BCkOlSRA4uEAiDxEp2XoNeYtFz6GKiSJBo3you/yk8V/0MLy0Jm3gpC
	 GeLgb5ddOgZoaQP0sruoAjBMgEv139fdUpJYFtUhnoCgyGRWc4bsBUaLuqO2+vX1OroXS
	 Gu2/eb5hEUlOH/aGzNfQu9qJdxUmX4drMumj4HeHlP+IMuw9ys4yYTt5rbdThzYdWLd+C
	 mB6E7MBcICnku5OSXdpHQtaiMaxnUmAAj5SljuK6QiE1bR5KIVmMJ1vfB+loNa0ZuDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482757;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FD/V4+e8O0iqTKVI3Ylc4RORwqMbtboEEa/TKhMeE7M=;
	b=Ze6Msoh5sco/+xhcPPMepPalM92OGmLdzus4FEWeWBTCHs/2BcOG6XhmEnehV1F1N0af
	 NYvBL7LbbpJT4vM/UNwfAF1+ArbJsJQhw7tawE6gf9Czfq1fQ4Uk8YibFsyCeQtp+4cnY
	 UdnKYXyrVSlreAJv1mpuOwL7EiERlFpYFDd6jPAGwMZvls/U2hhS56gIQxnWS/1tK6M06
	 R5UJCuUBp2vuQ/AcLN2ituavV1tio7AyNXkuILD1q/kpvb8Bqbe+9dh02YBEjwezmj0Y+
	 43FfJxZhOdtv5N5kGon2+oEa2qWRFtt8u1yQtQiv+XdB8r3kxNNWRkoW5Bb9JrxprAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JETWMfWj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FA606A89A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JETWMfWj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A91F00A05;
	Thu, 12 Nov 2026 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482757;
	bh=FD/V4+e8O0iqTKVI3Ylc4RORwqMbtboEEa/TKhMeE7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JETWMfWjkKeINJWiPkhAD/QsItp30dH2rFFfUxvvsc0JyhM1taj1AERUtJ/N3Cjs3
	 AwYVFzZ/m6zQ7KYBU+YiTIl9hTHpftthT74h5Nr4oeuYEHYYSiIf3AXVs+RKZKKHrV
	 mIOmMwkG2K3nP1x7rGrbfTQKpZOVBqfxi9f/LcxqS5J0K6eBwmu7A8mogUZQyc4cgy
	 znPGEVxp9AgLlfDVNExZSLItcLclY123hZKVh9JoHVE3H6OQiccRm+Ibc4Tk7V2+rw
	 AM4h3/ZJfG+Yk80QegP3t50LRsE3vQEfEM9YcerbVpZJF++E9cU7QgrbnSemDfJFmG
	 qhJVBLKkuZ+CQ==
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
Subject: [PATCH v2 3/6] ARM: drop CONFIG_HIGHPTE support
Date: Thu, 12 Nov 2026 12:25:25 +0100
Message-ID: <20261112112528.1116405-4-arnd@kernel.org>
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

CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
systems with 16GB of memory that made lowmem a particularly scarce
resource, and the HIGHPTE implementation gave feature parity with 32-bit
x86 and frv machines.

Since Arm is the last architecture remaining that uses this, and almost
no 32-bit machines support more than 4GB of RAM, the cost of continuing
to maintain HIGHPTE seems unjustified, so remove it here to allow
simplifying the generic page table handling.

Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.org/T/#u
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent a patch to drop HIGHPTE support on x86 today, see
https://lore.kernel.org/lkml/20241210144945.2325330-9-arnd@kernel.org/T/#u

If that one gets merged, we can merge this one instead of the one
that makes HIGHPTE depend on !PREEMPT_RT, but if we decide against
the x86 change, then we probably don't want this one either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig               | 11 -----------
 arch/arm/include/asm/pgalloc.h |  8 +-------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fd01ccab9c12..fc66d52d847e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1225,17 +1225,6 @@ config HIGHMEM
 
 	  If unsure, say n.
 
-config HIGHPTE
-	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
-	depends on HIGHMEM && !PREEMPT_RT
-	default y
-	help
-	  The VM uses one page of physical memory for each page table.
-	  For systems with a lot of processes, this can use a lot of
-	  precious low memory, eventually leading to low memory being
-	  consumed by page tables.  Setting this option will allow
-	  user-space 2nd level page tables to reside in high memory.
-
 config ARM_PAN
 	bool "Enable privileged no-access"
 	depends on MMU
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..ef6cb3e6d179 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -85,18 +85,12 @@ pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-#ifdef CONFIG_HIGHPTE
-#define PGTABLE_HIGHMEM __GFP_HIGHMEM
-#else
-#define PGTABLE_HIGHMEM 0
-#endif
-
 static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
 
-	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
 	if (!pte)
 		return NULL;
 	if (!PageHighMem(pte))
-- 
2.53.0

