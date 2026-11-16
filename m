Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833346;
	b=U0a41fZRJQM5bjjTnkHMtLmaUbiGCLOY2NouUWXr9hPtEvg4qxi7haK/rTUU68HrlSZM
	 HQOgQGn5ZThnE64EWPjidOt3AcY9913Xw+sTUXG8QgPqiQjO5E04KnzfzuVdbAwS74BlP
	 0iys3F8x7llM4nldRDdHBg59d4GxEsftrrai2+G8ncOA8eloxePLLh6GpMv6GJn4T+iVO
	 Q0C4CvOJdtNw6H9Emw4f8CPBat1f2TU9AsyDssW/jku2y0pfCIW3bZf/NokYjwVIeAyoT
	 ij3CGEx6YdOtjQkKufrMqJCnjJwFbU2bzgOc8XMzpX6GH6potNnCXeSr2FES0mzFpSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833346;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T+kkEjnaw2ySVd4lLiujiWW53ZRBsmmAWW3cy3wlJjw=;
	b=DwVZJtV14ZFLTIoaHPUzwNLAZYmKRhZBbw82Vq6Pnhtd2QaEGa4CXA/9fiU54mYw2hP9
	 eU//TneK3bJCrK0BKdfMJbyb29PE/w81ZkV3Q0vI36EGKvUUj+8OPoE3Wd4uFUxSZNnPv
	 Bk333BijKXUnWBt7/QW/2ZzIlDyaz41NN3tyoKh7OMxSgOOo1EHsrxzcANf2CNWJ5cc2W
	 MPt2IV//lFNPcdnQyw+GkJpiRwxsOVhCUyvZuYEwAJVhJztRzv7rmMam/mkl8HQSbYxNL
	 QxNgcildvr5QvVakPCsD/kpqS2nlzTiqlz6TxJQpFHBHgpQs50eIXTVfW6bVRpsktbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1iRwSzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227CA606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1iRwSzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FCF1F000C4;
	Mon, 16 Nov 2026 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833345;
	bh=T+kkEjnaw2ySVd4lLiujiWW53ZRBsmmAWW3cy3wlJjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J1iRwSzPkXkJExltWHVg0O8oGOL+tawW+ZmYEGgM1jmGAKgXx8sy7HnmkDQVv80Ss
	 yg4kn+EGjPt1JGKZYyWmr96BKjuswmbOXfgaSRJVySsDYEtOeJ/ovVXA3/PGYaEEQg
	 e3V7fokGmh+Jawesd3SW+NFvr+/7WMp05FEXbQ8wK0id5O9GLzTl/BNPOe8HMP9wyx
	 SXMkzQFD+Nl7UMGApCdcv5Ze+xW2cYq4ISMrZw9YTpwVIzOyl4tI/WGNsQAg4Yn1Op
	 xm4CxP/9WVSS9d5AIaFwkOz7gzndFMorMFu1XaBI6AixyyII7UmWDW9Dxmurqq67j6
	 wYW15Z/uOQhDA==
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
Subject: [PATCH v3 04/10] powerpc: kvm: allow flexible PAGE_OFFSET
Date: Mon, 16 Nov 2026 13:48:26 +0100
Message-ID: <20261116124832.662455-5-arnd@kernel.org>
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

As described by the Sashiko bot, the KVM code on powerpc has multiple
hardcoded PAGE_OFFSET values. In order to change the default, make these
compute the correct register values from configuration symbols.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kvm/book3s_32_sr.S     | 4 ++--
 arch/powerpc/kvm/booke_interrupts.S | 4 ++--
 arch/powerpc/kvm/e500_mmu_host.c    | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_sr.S b/arch/powerpc/kvm/book3s_32_sr.S
index 6cfcd20d4668..0d8a7857f2bd 100644
--- a/arch/powerpc/kvm/book3s_32_sr.S
+++ b/arch/powerpc/kvm/book3s_32_sr.S
@@ -113,8 +113,8 @@
 
         li      r0, 4
         mtctr   r0
-	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * 0xc))
-        lis     r4, 0xc000
+	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * (PAGE_OFFSET >> 28)))
+        lis     r4, (PAGE_OFFSET >> 16)
 3:      mtsrin  r3, r4
         addi    r3, r3, 0x111     /* increment VSID */
         addis   r4, r4, 0x1000    /* address of next segment */
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
index 205545d820a1..ede394f3f63f 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -230,8 +230,8 @@ _GLOBAL(kvmppc_resume_host)
 #endif
 
 	/* Restore host IVPR before re-enabling interrupts. We cheat and know
-	 * that Linux IVPR is always 0xc0000000. */
-	lis	r3, 0xc000
+	 * that Linux IVPR is always PAGE_OFFSET. */
+	lis	r3, PAGE_OFFSET >> 16
 	mtspr	SPRN_IVPR, r3
 
 	/* Switch to kernel stack and jump to handler. */
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index fa6128119874..9edad9bed589 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -115,7 +115,8 @@ static u32 get_host_mas0(unsigned long eaddr)
 	mtspr(SPRN_MAS6, 0);
 	mas4 = mfspr(SPRN_MAS4);
 	mtspr(SPRN_MAS4, mas4 & ~MAS4_TLBSEL_MASK);
-	asm volatile("tlbsx 0, %0" : : "b" (eaddr & ~CONFIG_PAGE_OFFSET));
+	asm volatile("tlbsx 0, %0" :
+		: "b" (eaddr & (rounddown_pow_of_two(PAGE_OFFSET)-1)));
 	mas0 = mfspr(SPRN_MAS0);
 	mtspr(SPRN_MAS4, mas4);
 	local_irq_restore(flags);
-- 
2.53.0

