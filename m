Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833351;
	b=VVwgypHUCzYSwKq1rySEizDDI99L5GxrGHRoc1j+/u4hhe7MHCItboiSxYzNdjJxFR/G
	 Rx8dehInqyPggMXuRTSDzYRFenR7l+4+sq/UpsBk4BfWr7qesvj4cIRV0jUaUHuJVjnH+
	 uwFzChAFcK3HpFyUuK0+P1gfM6gotAe3B218tnZ7dFymKaJB/7QEEKGDzCyIb3rvkeCih
	 mT/269lDWK4QRf+jAtfeeI5OTi+VmUtaNzZkp0HG+AqBB1I3gZIFtpznMRmzKSiKcwmEn
	 en0D44yLn45ei1lz0J/EXEyI9+ovTEzNrKruR5xKb65zmA4DSDUfltNsObyqJ/bXaJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yqMiao7IUsYqKs54ICvEuqwO8zDV+6ATbJVBuhC4jzs=;
	b=bi8h0hBE8Xos3PQ/RPsCpc+r9weDjleGAuFXgy3vo7Mie4OviW0HIjATcvEmN1699dG3
	 Q2gbG2QBgN3yyO0/tHBoNxQWycUvGb9J+FlGZVqwSKr52FD0w+glrbvreW4UeJ68UsKs3
	 2mUL/+P1rjwvzX85+EUK0u5PbZo5sYQuYw0b0uZcGVGhrF9qLnnJ/g05AsQzLWR1pJNMh
	 A+lQYhK3pniMnDN2waEIZ/Hz9GDGIz+X3NcNGjyDYVUoDHZCKsyk58yu2EvqKvc4Ae8+U
	 Z9e6CDMVDHdxnEPzIDBdhWaf91bKw/Xper9g3wsrpJ+LdNtm0S2Dl6d0ZclZRNMz0VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpjC7PZJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C2606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpjC7PZJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C31F000C5;
	Mon, 16 Nov 2026 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833351;
	bh=yqMiao7IUsYqKs54ICvEuqwO8zDV+6ATbJVBuhC4jzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpjC7PZJmXae3Ug6YBRcR+8bfcqu4PinQAZYVOw+KwcZk6WxhZD4lN24ddrIomqNG
	 Tjc7iRfpoEVYgnl2OjTRIDVmKZYCzKQYV4Xkj263XiW4qgji+556X1K0E+4G//fyn/
	 i1HzLH6xsPRXu/fCpishNMA/oZUalIKcIOocxcogWC/je5O4ts9z97s/t6sw2F+N9R
	 4Euy1GQaelLkbtRVa05un7cyZynZsXxkTqTSnvzvbZE0hIUN5oy/ekJ6RyfbXl+zPx
	 z8Vx7uVvTxw3/gInPP+Kn5cYLwYfOUuXpks2xvFUidQy15WoNQKtH2MtWImunv6Cw9
	 zU6NBp8N1IOtw==
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
Subject: [PATCH v3 05/10] ARM: add CONFIG_VMSPLIT_2G_OPT option
Date: Mon, 16 Nov 2026 13:48:27 +0100
Message-ID: <20261116124832.662455-6-arnd@kernel.org>
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

Unlike x86 and powerpc, there is currently no option to use exactly 2GiB
of lowmem on Arm. Since 2GiB is still a relatively common configuration
on embedded systems, it makes sense to allow this to be used in
non-highmem builds.

Add the Kconfig option and make this the default for non-LPAE builds
with highmem enabled instead of CONFIG_VMSPLIT_2G.  LPAE still requires
the vmsplit to be on a gigabyte boundary, so this is only available for
classic pagetables at the moment, same as CONFIG_VMSPLIT_3G_OPT.
Keep ARCH_MMAP_RND_BITS_MAX at 15 for this.

Tested in qemu -M virt, both with and without HIGHMEM enabled.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: Change ARCH_MMAP_RND_BITS_MAX for PAGE_OFFSET=0x70000000 (Sashiko bot)
---
 arch/arm/Kconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc66d52d847e..270ae2b89407 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -333,8 +333,8 @@ config ARCH_MMAP_RND_BITS_MIN
 	default 8
 
 config ARCH_MMAP_RND_BITS_MAX
-	default 14 if PAGE_OFFSET=0x40000000
-	default 15 if PAGE_OFFSET=0x80000000
+	default 14 if PAGE_OFFSET<=0x40000000
+	default 15 if PAGE_OFFSET<=0x80000000
 	default 16
 
 config ARCH_MULTIPLATFORM
@@ -1039,6 +1039,9 @@ choice
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
+	config VMSPLIT_2G_OPT
+		depends on !ARM_LPAE
+		bool "2G/2G user/kernel split (for full 2G low memory)"
 	config VMSPLIT_1G
 		bool "1G/3G user/kernel split"
 endchoice
@@ -1047,6 +1050,7 @@ config PAGE_OFFSET
 	hex
 	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
+	default 0x70000000 if VMSPLIT_2G_OPT
 	default 0x80000000 if VMSPLIT_2G
 	default 0xB0000000 if VMSPLIT_3G_OPT
 	default 0xC0000000
@@ -1055,6 +1059,7 @@ config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
 	default 0x1f000000 if PAGE_OFFSET=0x40000000
+	default 0x4f000000 if PAGE_OFFSET=0x70000000
 	default 0x5f000000 if PAGE_OFFSET=0x80000000
 	default 0x9f000000 if PAGE_OFFSET=0xC0000000
 	default 0x8f000000 if PAGE_OFFSET=0xB0000000
-- 
2.53.0

