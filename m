Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482745;
	b=aNVeUCAahCfoenbb1Bqk6Opyolr8BYw1xMciw3EZkdr9B/9q/jC/XjwbJb4l8XSDbl+p
	 Jjt4IaFE4pDBWRYTdAzjBRtKJ3dE8A5vwwH+m9x7nBaj/s+xKWzt2I2mn47x56fz067F4
	 nPbE6hyK+ViuOaSwv23pjDgULwfl/Dk6OAGuInYuOI5HrOissOoBGkbk2GFq5Vcz7HohX
	 +UJfDRZiz8z4wPWanSQ/zP/jsaeTjXqDu34ddEJuEIeUHaG1BVFYPZ0Rhbl6lDI0iT68v
	 OW6iLwFRRsNgCxkXebqxO4Vd4F4egQu7Emgj0qIXN0c2V1p59771YO4xCB6UKPCv3yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482745;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nyAii04iv1TnyOOBwPCAP2EPWogK/SwQRxxQEJCCSUM=;
	b=k8gLISfgPPP/qsQMfJ7tkKINIkiIuEabrsZWUGPeGHRNRfwufRbBMkKPDTmSL/yV/1ey
	 OVynuhWppcSH9V0k2fj9BEiCBKus8WbtHGz09icGpdOifkUH9wqDZnPZP2EfaDyPfzEOE
	 DzK/4+XQ6jvzUn61t/2zFsaJ+w5SQHM04H4z64sSh89GSEeiZFP8MkO0M6jA6357Y7JfK
	 gzMT3lqiIDFeawBwZR13pRGcPHrTJPEqP/c2bcB7jJvvODjUirhR7gs+fQ3fIuLuSmQ3L
	 JB+/wnBFZafTIm+YV+xUgDLDmx1lXd5/gb05FHDxo52hbhqconeCX1tm3oiakjxi49w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcej4SeG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E82606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcej4SeG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300D51F00A05;
	Thu, 12 Nov 2026 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482744;
	bh=nyAii04iv1TnyOOBwPCAP2EPWogK/SwQRxxQEJCCSUM=;
	h=From:To:Cc:Subject:Date;
	b=kcej4SeGNio953kxVJadAgWpMDZMpkWZMd+hDFdcbwBD6YqxOi5/s7jcM3dn5qkSo
	 JFjFFCvvWKdz0/D/1LD7AfJxJtAvjrb04S93zIylNgx499dpN+NQzloWAY3IS00PNX
	 ToYfTeKT9AfjBIh/2/JCQ81cMF4nF8JdQ1YgKhO3z3Kktfl6XBnC2mXQC5Rf4jyLim
	 a1Ar7lPvE18Ei+2zQ8KLCKzraZ0pFf7T7mxc8wFRF7N0eo1VNdCzDQiEsxnUr4MWL9
	 O/jp1yId0/ROUbt1HXRPmXoqR1BggR72fUy+EYYXcSYsvO7uJLDMn8zIE51FGdcUnE
	 GisdYH+T+tgPQ==
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
Subject: [PATCH v2 0/6] mm: highmem cleanups
Date: Thu, 12 Nov 2026 12:25:22 +0100
Message-ID: <20261112112528.1116405-1-arnd@kernel.org>
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

This is an updated series from what I posted last year [1], sorry for
taking way longer with this than I had planned. Linus brought it up today,
which triggered me to rebase the earlier patches and post it again.

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

As I had to change the powerpc version a bit for the rebase, this
current version is entirely untested, but I hope that Richard and
Christophe are able to help out there, as they both understand this
code better than I do.

The change to use VMSPLIT_3G_OPT by default on Armv5 means that I could
include a patch to no longer support highmem at all on VIVT caches,
as suggested by Jason Gunthorpe. I also included the patch to drop
HIGHPTE support now, as suggested by David Hildenbrand.

The patches from this series are available in [4] for testing.

     Arnd

[1] https://lore.kernel.org/all/20251219161559.556737-1-arnd@kernel.org/
[2] https://lore.kernel.org/all/CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com/
[3] https://lwn.net/Articles/1051010/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=highmem-7.4

Arnd Bergmann (5):
  ARM: remove support for highmem on VIVT
  mm: remove ARCH_NEEDS_KMAP_HIGH_GET
  ARM: drop CONFIG_HIGHPTE support
  mm: drop HIGHPTE support altogether
  arch/*: increase lowmem size to avoid highmem use

 arch/arm/Kconfig                            | 17 ++--
 arch/arm/configs/aspeed_g5_defconfig        |  1 -
 arch/arm/configs/gemini_defconfig           |  1 -
 arch/arm/configs/multi_v5_defconfig         |  1 -
 arch/arm/configs/mvebu_v5_defconfig         |  1 -
 arch/arm/configs/u8500_defconfig            |  1 -
 arch/arm/configs/vt8500_v6_v7_defconfig     |  2 -
 arch/arm/include/asm/highmem.h              | 56 +-------------
 arch/arm/include/asm/pgalloc.h              |  8 +-
 arch/arm/mach-omap2/Kconfig                 |  1 -
 arch/arm/mm/cache-feroceon-l2.c             | 31 +-------
 arch/arm/mm/cache-xsc3l2.c                  | 47 ++---------
 arch/arm/mm/dma-mapping.c                   | 12 +--
 arch/arm/mm/flush.c                         | 19 +----
 arch/microblaze/Kconfig                     |  9 ++-
 arch/microblaze/configs/mmu_defconfig       |  1 -
 arch/powerpc/Kconfig                        | 14 ++--
 arch/powerpc/configs/44x/akebono_defconfig  |  1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig |  1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig |  1 -
 arch/x86/Kconfig                            |  4 +-
 include/linux/hugetlb.h                     |  5 +-
 include/linux/mm.h                          |  1 -
 include/linux/pgtable.h                     |  9 ---
 mm/highmem.c                                | 86 +++------------------
 25 files changed, 50 insertions(+), 280 deletions(-)

-- 
2.53.0

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Malin Jonsson <malin.jonsson@est.tech>
Cc: Richard Weinberger <richard@nod.at>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
