Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833383;
	b=4bT9NeWTpDF6jpnqT/W3/7EyGcPt02XFHaj7DEfSXvbQoG354YVByxWx0Y+rQVQuuwP4
	 lm47hXgbxm1jKvpoo1W/M5SqAWgZMHMPHmKmIbChUpqTLOnlfqqr2y5UGIKJ3Vw3M4O7H
	 p/j5wl1w0e2+jOXf2nUY9Vo7IhOo5a2jFXnbIk1fXmirTORZRqY/b1hcXOkExTdW2CNQo
	 0kEjzP0Ra3jRBc6tN+dpqUrlko47lsP7qfH0dP2TqzBKPYhm1PvVSZpqRMJBzlkBPnS8O
	 +9eJF+k+tbqOVnkbPJZQc0GxU5llMs0zbGk/3XfYlOuosScjlgsEsu2DyMRRcvIFAjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SkKlFLJh0bHRqw2u6qo7FKqMD2VqM3GiEa/4Vt9PFN8=;
	b=jb9/MdICQGrIrG5HHiAZkxwvOKkds7vFM/C6udx1qAqc/945j4gCvRfwxq1kK+/VmyP3
	 ly2aYJ/EDMV1hCFIDOw38EmkSN+iLURkVIMXoZhVIxGCKH++AKd6eDCfIXK32MdLXgTce
	 wVfKD88MW9E58STinTV+p04fJYPl9nazH+r0s0gOPRs0uKBXSG4nBEFDpJKfqPn2mlAY9
	 LTfoKNs/pTCA9NI8jvtOJRGuSWW4fHwnKCvFWRo9OwDTba2jxcIkhekaziyFRKA0Wk/Wa
	 4n7BEis5/wuk3jhfRkYYAqb/sCzA50QuCDRU1GZOrNZmZbuJvE7QXDkyf158sEsNk9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YN6vXP2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65A606A337
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN6vXP2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7A81F000C4;
	Mon, 16 Nov 2026 12:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833382;
	bh=SkKlFLJh0bHRqw2u6qo7FKqMD2VqM3GiEa/4Vt9PFN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YN6vXP2/30cO412t3zjUajzb81yQ99gS8AJH9uEGiLmyUcS+qgSf/HMMiYqZRaboR
	 ZUFcOr5HG9bo2sXqK49utjfTBexB9GVMo4s30Q88My/RcnmlqYraEayTKRWAaUPYBv
	 gJD87jCCGbOS1fLcEpdk6WBb9etOKPgjDOEYZ83r/ZxRTQUrtiQYy4ZjKVlbAQ0+AG
	 gOt7Oq3YkH4zTVirFjUmewxyf0ab6ZbbxAwI2IJ2lwpk9XMrXjGusor5THb7GEcBg7
	 cbyEw+CgHbue8NDj72vH/de54rhuF8daoE/kSNW/EKSHRf3CGYKQi/RoPfiBxBVMN6
	 r2cGCwk/VJD7A==
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
Subject: [PATCH v3 10/10] mm: print pte in __print_bad_page_map_pgtable()
Date: Mon, 16 Nov 2026 13:48:32 +0100
Message-ID: <20261116124832.662455-11-arnd@kernel.org>
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

HIGHPTE support is gone now, so it's easy enough to print the
PTE here along with the upper level entries.

Acked-by: "David Hildenbrand (Arm)" <david@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/memory.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ec3d9d99ccee..6404bb447d9c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -528,9 +528,11 @@ static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long add
 	char p4d_str[PTVAL_STR_MAX];
 	char pud_str[PTVAL_STR_MAX];
 	char pmd_str[PTVAL_STR_MAX];
+	char pte_str[PTVAL_STR_MAX];
 	p4d_t p4d, *p4dp;
 	pud_t pud, *pudp;
 	pmd_t pmd, *pmdp;
+	pte_t pte, *ptep;
 	pgd_t *pgdp;
 
 	/*
@@ -567,13 +569,18 @@ static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long add
 	pmd = pmdp_get(pmdp);
 	ptval_to_str(pmd_str, pmd_val(pmd));
 
-	/*
-	 * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
-	 * because the table should already be mapped by the caller and
-	 * doing another map would be bad. print_bad_page_map() should
-	 * already take care of printing the PTE.
-	 */
-	pr_alert("pgd:%s p4d:%s pud:%s pmd:%s\n", pgd_str, p4d_str, pud_str, pmd_str);
+	if (!pmd_present(pmd) || pmd_leaf(pmd)) {
+		pr_alert("pgd:%s p4d:%s pud:%s pmd: %s\n",
+			 pgd_str, p4d_str, pud_str, pmd_str);
+		return;
+	}
+
+	ptep = pte_offset_kernel(pmdp, addr);
+	pte = ptep_get(ptep);
+	ptval_to_str(pte_str, pte_val(pte));
+
+	pr_alert("pgd:%s p4d:%s pud:%s pmd:%s pte:%s\n",
+		 pgd_str, p4d_str, pud_str, pmd_str, pte_str);
 }
 
 /*
-- 
2.53.0

