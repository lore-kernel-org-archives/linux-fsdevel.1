Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482772;
	b=KB5/+j6BAyJdXOoh+Ke0Xs0731Q/AGp3n418AhB7iuWCH9VlfogSkLDfPh6AJB4iq8vW
	 d1TX3x0cayRrNm/JC86aG8ONlwS0rwXOyzQikhChwWpcW2JD9iz42Kyyb5kRGcZulPLrk
	 f2biOkyRf0yJy8XgaZJSh90Ep3+CppfvXu4e99S57mkHYIDJiI7GgfHsoyUgLL4WUnQgd
	 ELue5ZYGJGYSbvhjb9KD9bJPmi+TnbjjLDZN23bKamcBjYdyWZ3AKj10X6p+qX3jMB4Va
	 aTi/UqRVfc1295YmvIyQ6YCuaYrA2RtlfTHyR0m2qfKPj/WthSkqKhjJgyGs8qGPOFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482772;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GZ4lZp1oW2s0U2uL8ErHvlu8up2Pjx215zhjtPcKJ2Q=;
	b=m23vMnoQdBlVg9pA+fp81MVkufdvXJxcQkkUP4qTYR83FhTEZPXmZjB4rFiwtYbbe9fN
	 2f6K3PZ+OuHLh80x55yFcZpuQ23v9ZcpJUZctlKxePRPGD4hFbbZcmDIY1pXY9Esc1PhD
	 8XUd7HPZ/JZb7/9OOJDmwPAHyJv39gdVdp0tw41b2n5oae+roU26meK5dzyRly2Tf9XVJ
	 CQCY9NpW8qKO21nGaTnVrRmsA2a87TmfcRKr7KXoL6sTPe+8i1lIMTsvvyNvFHvyhCxDg
	 1/XfD1oyOo4flIMp9nMzV+hVkvSfCgofmKJrRQu0B/VwAzozv6QH2MQk1CNJ4tAjAaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/r3xrdE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41947606A895
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/r3xrdE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC0C1F00A05;
	Thu, 12 Nov 2026 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482772;
	bh=GZ4lZp1oW2s0U2uL8ErHvlu8up2Pjx215zhjtPcKJ2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/r3xrdEhQleZV4yGgXPVqBfanfjsSKJ/g60PP/OJoc5XviAAJAUlX2KuMamvkihO
	 6S5H6k5b1RNd4xXJLVJ91kcuCCQCZTXO1k+1hQn6/O+7RvV8jNjkBRJXIlQ1V9idnR
	 9XiRe0gigvMNyWa7iIbigaFbf2JOHB8+iOYN0Ye9RreZ/JWwevZQj5VfLzPUXudYPN
	 9zN8Zh9SPvZmpMfi3VkkfJS4yMkZoVwR2dg8Pxff5QMrY76ACoV9Zd44FOHqSG8vPH
	 /mQ1HwpQ/1l+8doGR2M/t4fFEC8tmhl4Zq43fF36z8VjNjv8+aaMf4c4pJisKk9Stz
	 Dl7K858NfhsuA==
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
Subject: [PATCH v2 6/6] ARM: add CONFIG_VMSPLIT_2G_OPT option
Date: Thu, 12 Nov 2026 12:25:28 +0100
Message-ID: <20261112112528.1116405-7-arnd@kernel.org>
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

Unlike x86 and powerpc, there is currently no option to use exactly 2GiB
of lowmem on Arm. Since 2GiB is still a relatively common configuration
on embedded systems, it makes sense to allow this to be used in
non-highmem builds.

Add the Kconfig option and make this the default for non-LPAE builds
with highmem enabled instead of CONFIG_VMSPLIT_2G.  LPAE still requires
the vmsplit to be on a gigabyte boundary, so this is only available for
classic pagetables at the moment, same as CONFIG_VMSPLIT_3G_OPT.

Tested in qemu -M virt, both with and without HIGHMEM enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 797705a94b28..8992fedfdf37 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1025,7 +1025,8 @@ config BL_SWITCHER_DUMMY_IF
 choice
 	prompt "Memory split"
 	depends on MMU
-	default VMSPLIT_2G if HIGHMEM || ARM_LPAE
+	default VMSPLIT_2G if ARM_LPAE
+	default VMSPLIT_2G_OPT if HIGHMEM
 	default VMSPLIT_3G_OPT
 	help
 	  Select the desired split between kernel and user memory.
@@ -1042,6 +1043,9 @@ choice
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
+	config VMSPLIT_2G_OPT
+		depends on !ARM_LPAE
+		bool "2G/2G user/kernel split (for full 2G low memory)"
 	config VMSPLIT_1G
 		bool "1G/3G user/kernel split"
 endchoice
@@ -1050,6 +1054,7 @@ config PAGE_OFFSET
 	hex
 	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
+	default 0x70000000 if VMSPLIT_2G_OPT
 	default 0x80000000 if VMSPLIT_2G
 	default 0xB0000000 if VMSPLIT_3G_OPT
 	default 0xC0000000
@@ -1058,6 +1063,7 @@ config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
 	default 0x1f000000 if PAGE_OFFSET=0x40000000
+	default 0x4f000000 if PAGE_OFFSET=0x70000000
 	default 0x5f000000 if PAGE_OFFSET=0x80000000
 	default 0x9f000000 if PAGE_OFFSET=0xC0000000
 	default 0x8f000000 if PAGE_OFFSET=0xB0000000
-- 
2.53.0

