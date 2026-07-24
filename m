Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB341E6A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888440; cv=none; b=edAG1c6p/P0aJNodSFld6/6BYYOF+051lc4uwZ569ifbJv+bxcvwa+DdRStAu693hm/ERR44UloghYag2TutgzP42pflmtR8/HNYXwt4C0buKNMUU+vHZn/OQmcTpCzdO79zRnX5P4VWIDqJa0La5fv7gqGjYLcZ146aWT1RFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888440; c=relaxed/simple;
	bh=tWvu3oAZ5tp6oGLz1MDLVrKNKwrsyZDIThUcD3PRXSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gdp4bwIE29JGfMtRldYY3gRMuibP6ow/AoHUmJWXcPBjyZ33L7rciezvqEYlqAnqkicngmmRRgjG0zqRZwiXfUBvn5n0Gk8XzPl7FCwfSBuaCW79CN/X8oLlXOiFFtM7uSO0JKYqyll4w7+j4ezUhv6k10NTDl98oKDx27l1/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxlDuhdm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ujI4Wd2G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxlDuhdm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ujI4Wd2G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxlDuhdm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ujI4Wd2G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxlDuhdm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ujI4Wd2G"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41C557B6D1;
	Fri, 24 Jul 2026 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twduMmeEWgelZFZshyHJ1uGfEjZlzuBRFqWfJVNkv/M=;
	b=SxlDuhdm9/gJHTiydudXOtHLrbiAAe4QPGMGricn9OURt/YQ1jYLoNASQ7rLBFmCqz2nh7
	LHoCXMRcnonSZLvrYSKtJyKCm58cs12ud3kPnjRbVQWGzRncaUWw91EbQfsX/gLtynDW3M
	SrbJvmgWvNFfcNslZjZ6wm9gi/WZ6Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twduMmeEWgelZFZshyHJ1uGfEjZlzuBRFqWfJVNkv/M=;
	b=ujI4Wd2GfWYZueixCfqt1ZdfL+YX/avZQzXLSVhOTjMbmIwZDL0nLfgZgfAjO8WL3FIdfd
	9ua5XK298g4YhNDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784888427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twduMmeEWgelZFZshyHJ1uGfEjZlzuBRFqWfJVNkv/M=;
	b=SxlDuhdm9/gJHTiydudXOtHLrbiAAe4QPGMGricn9OURt/YQ1jYLoNASQ7rLBFmCqz2nh7
	LHoCXMRcnonSZLvrYSKtJyKCm58cs12ud3kPnjRbVQWGzRncaUWw91EbQfsX/gLtynDW3M
	SrbJvmgWvNFfcNslZjZ6wm9gi/WZ6Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784888427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twduMmeEWgelZFZshyHJ1uGfEjZlzuBRFqWfJVNkv/M=;
	b=ujI4Wd2GfWYZueixCfqt1ZdfL+YX/avZQzXLSVhOTjMbmIwZDL0nLfgZgfAjO8WL3FIdfd
	9ua5XK298g4YhNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC3F3779BA;
	Fri, 24 Jul 2026 10:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4CtyNmg8Y2oSaQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 24 Jul 2026 10:20:24 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] mm/arm64: constify pte_get*() and contpte get logic
Date: Fri, 24 Jul 2026 11:20:14 +0100
Message-ID: <20260724102017.141532-3-pfalcato@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724102017.141532-1-pfalcato@suse.de>
References: <20260724102017.141532-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.de,arm.com,kernel.org,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

None of the contpte code needs write access to the PTEs.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 arch/arm64/include/asm/pgtable.h | 10 +++++-----
 arch/arm64/mm/contpte.c          |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a2681d755358..043bc0649cee 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -378,7 +378,7 @@ static inline void __set_pte(pte_t *ptep, pte_t pte)
 	__set_pte_complete(pte);
 }
 
-static inline pte_t __ptep_get(pte_t *ptep)
+static inline pte_t __ptep_get(const pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
 }
@@ -1652,8 +1652,8 @@ extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte);
 extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte);
-extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
-extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
+extern pte_t contpte_ptep_get(const pte_t *ptep, pte_t orig_pte);
+extern pte_t contpte_ptep_get_lockless(const pte_t *orig_ptep);
 extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr);
 extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
@@ -1732,7 +1732,7 @@ static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
  */
 
 #define ptep_get ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
+static inline pte_t ptep_get(const pte_t *ptep)
 {
 	pte_t pte = __ptep_get(ptep);
 
@@ -1743,7 +1743,7 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 
 #define ptep_get_lockless ptep_get_lockless
-static inline pte_t ptep_get_lockless(pte_t *ptep)
+static inline pte_t ptep_get_lockless(const pte_t *ptep)
 {
 	pte_t pte = __ptep_get(ptep);
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 2de12656b4d8..3853ecd2cee9 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -310,7 +310,7 @@ void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(__contpte_try_unfold);
 
-pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
+pte_t contpte_ptep_get(const pte_t *ptep, pte_t orig_pte)
 {
 	/*
 	 * Gather access/dirty bits, which may be populated in any of the ptes
@@ -367,7 +367,7 @@ static inline bool contpte_is_consistent(pte_t pte, unsigned long pfn,
 			pgprot_val(prot) == pgprot_val(orig_prot);
 }
 
-pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
+pte_t contpte_ptep_get_lockless(const pte_t *orig_ptep)
 {
 	/*
 	 * The ptep_get_lockless() API requires us to read and return *orig_ptep
-- 
2.55.0

