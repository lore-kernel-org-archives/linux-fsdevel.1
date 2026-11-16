Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833321;
	b=WCRs6MaGk0dvpI/WT77/jg+t5NXuFcTd3iX04ti/mirFoKzPhvx6v4aIjPGPS8h8rlqG
	 gG/UfrGLLeZiAyTX1kOqdfpGROMKxRYfC87jaUW4OuNfXgelSwpmdXJYs7HQ/64qTnOY7
	 3CqSTtXdTk7HMw7dCsuYxOu9Lg7vwXSae2Ebl4Rs5cdc/7XRsy7ZCsRM+HN/a9UaDUU0c
	 Eu1v0QGdVQyWrHm9+qGRrUeldqvIux5O3Z0x/KLHFUK7eJ1raiwi3YeojINWlzTuS+d/A
	 NSGlneH7AQxQCyuQ0tcMOE65P7F0ysGpw8KPvaX5fbhaI6tfIxyZ8QDrotZsgvqhq7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833321;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cHwboy1N0wyypiMyN1HkFeKrDxUYIhWj1+v6URlvrGU=;
	b=AinmKICYeTW5Oac+rDtdSfYbOVwPuXwqCR76ajZRIW38mQDgh5KD7alXL6/3dZRK6sVE
	 hBVFl6pgl4q3hCHcGmbC6Qb8v3okPLUOuTuoei45A0HKuPr7Du2pt/4aMgwrpzK90T+P5
	 IRm3x/ECRv7i+sLNqB0jbS/JDXDXiHcmI02UwBJOuSqUWgLNiW61+Ua6dd4ulU0pxtzg2
	 0P4LNdrEeadR4dA9wJt/HSwoCNjS0YiVi+KlGSqiRadJqyCWpXzqtkXWp+hGhrPXxpJPN
	 Vi762VHgWKN2gq7lY1A5EqGrhlLug3MEeR81q3VX9fnpENfjVfFpbzyIignp8bnAhtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWGzDCEU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E45606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWGzDCEU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3E1F000C4;
	Mon, 16 Nov 2026 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833321;
	bh=cHwboy1N0wyypiMyN1HkFeKrDxUYIhWj1+v6URlvrGU=;
	h=From:To:Cc:Subject:Date;
	b=BWGzDCEUKXr34v4C6Dho8x9jma12SCGGbn8RtpnP3qX45i9pqa/vtpEIy71wryEv4
	 IDWOk5oa3ya3mNqxy+6UT4i70X+uEAWGil+v6ZahGuzUlfN6VIcqcuIrhrZIOo/ekd
	 EV+YXnEY6Cul1fybgHnM8yGocWvdjRFqe1EMtnbAU3dHGFdRStQauSRRT2AvWZgWgS
	 +CxxyH2MmUe3+drsDMXbdVpGvCSVANx8OaC9LoJ0Ma8LURv8oUrYUeQ3kK++srZffw
	 nHuLhWyZR7lw1gAqOMkhLwFNYtFfmVEA6Wq+X7rs6NMUj51o4mJUC4azDZ6J4FQ1Hj
	 5dUfR3eSzgLFA==
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
Subject: [PATCH v3 00/10] mm: highmem cleanups
Date: Mon, 16 Nov 2026 13:48:22 +0100
Message-ID: <20261116124832.662455-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
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

This is an updated series from what I posted last year [1] and
last week[2].

At LPC 2025 [3], we got rough consensus on the plan to keep the
funcationality present for the time being but instead reduce the scope
of highmem in the kernel as much as we can without hurting users.

The short summary is a three stage process:

 1. Nudge users towards using a larger lowmem zone with the
    CONFIG_VMSPLIT_* options if at all possible.

 2. Drop most __GFP_HIGHMEM allocations and corresponding kmap()
    calls from the kernel, leaving only the subset that is likely
    to contain the majority of the actual allocations.
    Specifically we will keep anonymous and regular file backed
    user mappings, zsmalloc, and huge pages.

 3. In a few years, also drop the page cache allocations and leave
    perhaps only zsmalloc using a much simpler interface.  I suggested
    five years as the time until we do this, but the timing depends a
    lot on how the first two stages work out in practice, and how long
    the remaining highmem users plan to keep updating their kernels.

This series implements stage 1, mostly using Kconfig changes to the
default settings but leaving the traditional behavior as a CONFIG_EXPERT
choice in Kconfig. With the new defaults, most installations that use
highmem today with 1 GiB or 2 GiB of system RAM will see all of their
RAM in the lowmem zone after upgrading their kernels. My estimate is
that instead of 80% to 90% of maintained embedded 32-bit systems, this
should cover over 98%.

As I don't actually have hardware in the category that still needs
highmem, I tested this using a qemu-system for Armv7 and PPC6xx running a
Debian userland with all combinations of VMSPLIT and HIGHMEM options. I
ran some kernel builds on the Arm guest to ensure that the new options
don't cause functional or performance regressions for regular workloads
that don't exceed the virtual address space. I also ran some tests
with Firefox and was positively surprised to see that this still works
on the VMSPLIT_2G_OPT configuration without highmem, though it gets
close to both the address space and lowmem size limits.

The change to use VMSPLIT_3G_OPT by default on Armv5 means that I could
include a patch to no longer support highmem at all on VIVT caches,
as suggested by Jason Gunthorpe. I also included the patch to drop
HIGHPTE support now, as suggested by David Hildenbrand.

The patches from this series are available in [4] for testing.

Once there are no further concerns about the contents, I would
suggest merging this through the asm-generic tree, as it touches
mostly architecture specific code and that is not easily split
from the core mm/* code. Merging everything through the mm
tree would of course also work.

     Arnd

[1] https://lore.kernel.org/all/20251219161559.556737-1-arnd@kernel.org/  # v1
[2] https://lore.kernel.org/all/20261112112528.1116405-1-arnd@kernel.org/ # v2
[3] https://lwn.net/Articles/1051010/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=highmem-7.4

Changes since v2:

 - Add preparation patch for Arm PXA [sashiko-bot] 
 - Add preparation patch for powerpc32/kvm [sashiko-bot]
 - Fix Arm ARCH_MMAP_RND_BITS_MAX calculation [sashiko-bot]
 - Simplification for pte_alloc_one() [Mike Rapoport]
 - Drop stale references to highpte [David Hildenbrand]
 - improve __print_bad_page_map_pgtable()
 - Split out Arm changes for CONFIG_VMSPLIT_2G_OPT

Changes since v1:
 - rebase to v7.4-rc
 - add patch to drop highpte

Arnd Bergmann (10):
  ARM: remove support for highmem on VIVT
  ARM: drop CONFIG_HIGHPTE support
  ARM: pxa: support arbitrary PAGE_OFFSET
  powerpc: kvm: allow flexible PAGE_OFFSET
  arch/*: increase lowmem size to avoid highmem use
  ARM: add CONFIG_VMSPLIT_2G_OPT option
  ARM: defconfig: turn off highmem in favor of CONFIG_VMSPLIT_2G_OPT
  mm: remove ARCH_NEEDS_KMAP_HIGH_GET
  mm: drop HIGHPTE support altogether
  mm: print pte in __print_bad_page_map_pgtable()

 arch/arm/Kconfig                            |  27 +++---
 arch/arm/configs/aspeed_g5_defconfig        |   3 +-
 arch/arm/configs/gemini_defconfig           |   1 -
 arch/arm/configs/lpae.config                |   1 +
 arch/arm/configs/multi_v5_defconfig         |   1 -
 arch/arm/configs/multi_v7_defconfig         |   1 +
 arch/arm/configs/mvebu_v5_defconfig         |   1 -
 arch/arm/configs/omap2plus_defconfig        |   1 +
 arch/arm/configs/u8500_defconfig            |   1 -
 arch/arm/configs/vt8500_v6_v7_defconfig     |   2 -
 arch/arm/include/asm/highmem.h              |  56 +----------
 arch/arm/include/asm/pgalloc.h              |  13 +--
 arch/arm/mach-omap2/Kconfig                 |   1 -
 arch/arm/mach-pxa/pxa3xx.c                  |   2 +-
 arch/arm/mm/cache-feroceon-l2.c             |  31 +-----
 arch/arm/mm/cache-xsc3l2.c                  |  47 +--------
 arch/arm/mm/dma-mapping.c                   |  12 +--
 arch/arm/mm/flush.c                         |  19 +---
 arch/microblaze/Kconfig                     |   9 +-
 arch/microblaze/configs/mmu_defconfig       |   1 -
 arch/powerpc/Kconfig                        |  24 +++--
 arch/powerpc/configs/44x/akebono_defconfig  |   1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig |   1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig |   1 -
 arch/powerpc/kvm/book3s_32_sr.S             |   4 +-
 arch/powerpc/kvm/booke_interrupts.S         |   4 +-
 arch/powerpc/kvm/e500_mmu_host.c            |   3 +-
 arch/x86/Kconfig                            |   4 +-
 include/linux/hugetlb.h                     |   5 +-
 include/linux/mm.h                          |   1 -
 include/linux/pgtable.h                     |  13 ---
 mm/highmem.c                                | 100 ++------------------
 mm/memory.c                                 |  21 ++--
 mm/pgtable-generic.c                        |  25 +++--
 mm/userfaultfd.c                            |   6 +-
 35 files changed, 104 insertions(+), 339 deletions(-)

-- 
2.53.0

Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Malin Jonsson <malin.jonsson@est.tech>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org

