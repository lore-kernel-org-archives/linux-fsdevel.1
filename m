Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833333;
	b=xEnsmUtoVqhelM53oJNVkcWZbyAX/VjYSN3P4bGpWOt5vo7JL6i7CAVH67yXWtiJSQR0
	 eN+jeoRNmOwoAh6ORk0uBxucDQQizeRWFF1rnT2JjH4jITF/4ZXwdp9ZHRDSOrtdM9x78
	 xtOGbAIkOntn91xXEk4gtTVSVrc0gWL3Tf2DqNfXSrNPsRaDZ5EOeEuuxtnOywA847tg0
	 NOx6BgNWWReJZtnx3BXRNkA1BTmYI/nBOLithOUpNYR6N4v223gt6iACEN5klM1l3hluf
	 QsgsZjT1tIHD6pVbAT9sougpp6S50hLXPdYus3pnR5G5X/FVzS5j8IlsOolhuPd539Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833333;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D3qZ4d2EoZJBj/rnIT9ZqfnQg+sRwjETd54Rn6zh5+0=;
	b=YWmv2kTXvXmtGsvxMY39rWVkgZIxfcDmqahr1jO3P/VXV9jV+mpUL+nsjWNJp9RalDte
	 dLZ13NIEc04axteB5KViSmXzfqSp0Ul1GpyXc61Hsr6UjlyBI3uTEejf8gWp5A6TZz9R1
	 C3cUYyypfY9XaGdHVXWVawlnsebJpXfBkP7yi8bJ/8D9QGvyrVBODQYmjRhD19BTVwzye
	 KQbqSGv7+kJkw1TijqqHF51nZn20tt56YWvVDLFNs3Zl9Cz7MNEolzpy04JaZkw/Dds24
	 IzY/XXDg/NO6QmbA2ITAebBL+J/G6iClZnwpJfGrsHbXFsveFIkA9ld9NfjyuNAebvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFzBs088;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED0606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFzBs088
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC6A1F000CB;
	Mon, 16 Nov 2026 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833333;
	bh=D3qZ4d2EoZJBj/rnIT9ZqfnQg+sRwjETd54Rn6zh5+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fFzBs088shoTy3rQRvERnUcPbLSDcUJs3516Kbm99pGIrHAGI+mzI+Fjroy1FZoRR
	 SLSxvUR24Ur9ZMnFUaeM6262CXVoWN+NN6FX3EIesA4PFthJY3GJ963+oBQQcnI5+X
	 CxF7nKZzUvWmnMkXLlJ9xJTVUsMKwtlsaRKBJYfJqHGajc8KhKS8Zw151NxBITLk11
	 3f3u+37vYLIpx96RN2dwX3SMGSQ8S06BuVxY5BqJzeFXIzW4GspoVOEMp6v36vSW7x
	 txORGSJshkejNfxqwzDAw5iWblqJrgB37F54/PpRUDzR1w8ESpUpWt/STu40kxByij
	 vtGN4WXjhlbeQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v3 02/10] ARM: drop CONFIG_HIGHPTE support
Date: Mon, 16 Nov 2026 13:48:24 +0100
Message-ID: <20261116124832.662455-3-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116124832.662455-1-arnd@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
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
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                        | 11 -----------
 arch/arm/configs/vt8500_v6_v7_defconfig |  1 -
 arch/arm/include/asm/pgalloc.h          | 13 +++----------
 3 files changed, 3 insertions(+), 22 deletions(-)

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
diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index 2925a1f1dbb6..33a81c5a84d0 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -9,7 +9,6 @@ CONFIG_ARM_ERRATA_754322=y
 CONFIG_ARM_ERRATA_775420=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_HIGHMEM=y
-CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..b01d817fecf3 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -85,22 +85,15 @@ pte_alloc_one_kernel(struct mm_struct *mm)
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
-	if (!pte)
-		return NULL;
-	if (!PageHighMem(pte))
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
+	if (pte)
 		clean_pte_table(page_address(pte));
+
 	return pte;
 }
 
-- 
2.53.0

