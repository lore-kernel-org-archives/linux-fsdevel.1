Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833364;
	b=0OEYPioPA8wnJEjONkLd+E5cavweX4RZorGOsu8tgkTYORtWSqW5JQfG7X6/FhMwjKcV
	 JG5KiJD4YfLdXMWVqEZ9dNY7a285bGjVr3rgJvS6AMKKLVvdfPuVg7KOEF7zmMy26SyGg
	 BPg0YbHYoytk0/dMC2tmmldPNbjXq1ptlXdMvyarB1wOlC17ewLvYVdmZOPhVHGiZFfQh
	 MEPudot+2IPrNVNGmY0+V+ME14avZ6mEGQwOWtN4UOJVGpOhotM/0m8qGYC8PJqjpno58
	 bZqpdVn+redGSSCr+2NTpUWkAZ3mgnn8s7p6I3L6g3jk0nt4yurkKnD8UBeYnBZbn2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833364;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3u1YbP0glgrlPVSZVLO7Md+O8bEthJ8oEllh+tqqYIs=;
	b=jGY+dvXqZtaVQq5z4igNV+4p6fsgmJgpaG+Rj2EXwy6uie74ghC+aTKsAc/LbQz6aPqX
	 hm7JOzPQTXimtNIoIRPRPpR9b2KFL/kFpphe4J7J+Qr0GVHMMFfAzF7346jFeYhEv6S2o
	 enbVIcU2AdwfwLPaAIkoNNwM0G7ersrPPQFJnRoZ7NqlCaXOktzb7EFge5LmcQc7NODwQ
	 S8IRu0Zui53xmPScLbsuXDT95zK/vuEItTJB9MrdRuZsWc4J8zzPsoGTYdsAn9T5jnfQb
	 qf6KxVnLPN9OkbUFYwFTTrqlBJoiYbR+oMJG9yIjN3lnYiqa2MVJXwc8iFePqwDFaqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwjzLPrS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47E606A32C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwjzLPrS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA631F000C4;
	Mon, 16 Nov 2026 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833364;
	bh=3u1YbP0glgrlPVSZVLO7Md+O8bEthJ8oEllh+tqqYIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwjzLPrSZpfGTVk4lN0Ho9oJpr0gZLkBoAC029OaRpb2ldn3xDllvh2HnLoT94Fb/
	 TDYQNRfyLKplvKQWdKlBl5GUJFKxnE1srWWg1c5WgPjV0cA3xM96ik5Y34iJ6OfNWM
	 tbRUmyufSXh88UFfS0u89a2YfwULjV+IbEEPsLcfzSubqsmHTOJaFp8XR9Tk53cMv8
	 y3jkV6Qv3iRMqD1R5bOMquB7vTnY7u7ucMjlf7xKmSttLEz4PA7bTmoUBx4o45yMCr
	 9JeOqh6bWP2quBFFxZQDDDTkeDpCk6/CFlsdoY4DOMT0fwCQe0ZnOIVph7buF6qLKK
	 E1ytUvDgbIMqQ==
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
Subject: [PATCH v3 07/10] ARM: defconfig: turn off highmem in favor of CONFIG_VMSPLIT_2G_OPT
Date: Mon, 16 Nov 2026 13:48:29 +0100
Message-ID: <20261116124832.662455-8-arnd@kernel.org>
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

The multi_v7_defconfig and omap2plus_defconfig attempt to support a
broad range of hardware. This is at odds with the setting for highmem
being slowly phased out on the one hand but still enabled by means of
CONFIG_ARCH_OMAP2PLUS_TYPICAL, leading to a default CONFIG_VMSPLIT_2G_OPT
split.

None of the upstream OMAP2+ DTS files actually list more than 2GiB
of RAM, so it seems fine to just turn off highmem by default and use
CONFIG_VMSPLIT_2G_OPT from the defconfig to still support the same
hardware but not require highmem.

This also changes multi_v7_defconfig, which currently supports all sorts
of ARMv7 systems except those that require LPAE.

The best comprimise I can think of again is to use VMSPLIT_2G_OPT in
place of highmem. Compared to highmem configurations, this should be
an improvement on most machines with 2GiB of installed memory for the
lower overhead and complexity, but it does degrade machines that rely
on highmem to access all memory, as well as reduce the available user
address space (1.75GiB instead of the traditional 3GiB).

For aspeed_g5_defconfig, the decision is trivial, as there are no
4GiB configurations we need to support, but g6 is known to use
up to 2GiB.

If you run into problems on production machines with the new default,
with the absence of highmem, or the smaller user area, please complain.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/aspeed_g5_defconfig | 3 +--
 arch/arm/configs/lpae.config         | 1 +
 arch/arm/configs/multi_v7_defconfig  | 1 +
 arch/arm/configs/omap2plus_defconfig | 1 +
 arch/arm/mach-omap2/Kconfig          | 1 -
 5 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 1327a09e163a..060797cc6726 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -25,9 +25,8 @@ CONFIG_MACH_ASPEED_G6=y
 # CONFIG_CACHE_L2X0 is not set
 CONFIG_SMP=y
 # CONFIG_ARM_CPU_TOPOLOGY is not set
-CONFIG_VMSPLIT_2G=y
+CONFIG_VMSPLIT_2G_OPT=y
 CONFIG_NR_CPUS=2
-CONFIG_HIGHMEM=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_VFP=y
 CONFIG_NEON=y
diff --git a/arch/arm/configs/lpae.config b/arch/arm/configs/lpae.config
index 1ab94da8345d..535696d6de96 100644
--- a/arch/arm/configs/lpae.config
+++ b/arch/arm/configs/lpae.config
@@ -1,3 +1,4 @@
 # Help: Enable Large Physical Address Extension mode
 CONFIG_ARM_LPAE=y
 CONFIG_VMSPLIT_2G=y
+CONFIG_HIGHMEM=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 069d5a49f01c..c3e427ce8d88 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -103,6 +103,7 @@ CONFIG_ARCH_VEXPRESS_TC2_PM=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
 CONFIG_SMP=y
+CONFIG_VMSPLIT_2G_OPT=y
 CONFIG_NR_CPUS=16
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5791953b75ff..b00789279f25 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -36,6 +36,7 @@ CONFIG_POWER_AVS_OMAP_CLASS3=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_SMP=y
+CONFIG_VMSPLIT_2G_OPT=y
 CONFIG_NR_CPUS=2
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 79f8afe3a6bf..d145e448a6b8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -135,7 +135,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	bool "Typical OMAP configuration"
 	default y
 	select AEABI
-	select HIGHMEM
 	select I2C
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
-- 
2.53.0

