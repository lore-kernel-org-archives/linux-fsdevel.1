Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4938DC59
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775477; cv=none; b=ujTa/ZXO6zAn7bKKOSzECeY4HnVLGl3sr766C2sCwk/s2pEyylBPJijbCDs0aQ+m4FhyVB+N9jzc/1CqNk3XLBMCStVc4uwGiKtMg9vdJ+IFdw1yOpb+oXhNaFCbaSIwaVmqh/yIgkO0NhADdaz2aRtR30L5FhTh2S+k9kU1ywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775477; c=relaxed/simple;
	bh=H98G8qfHJN9yMfugRU6TXdwqAwxUOCkppKYsUkmzXaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhbAyEDMqBkeK9Jit5jTMNtD5K6qUsvOtXNUAHsAj9hS7aqkkUqQViasVz1hXAHYv7eU81sW7qRxCnpmJOLRpcUNmCqtQgHB8kTQ50s63/rNr6lOD9feavcpmvF9ECCDxLA4+Z0l5mnut+Y2efFsftWGYgQ3B4FflbE9FTj0p7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oI+Ftq7Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SdaodsKJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oyC4x8nG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zhuzRUQD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oI+Ftq7Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SdaodsKJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oyC4x8nG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zhuzRUQD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04F437F29A;
	Mon,  3 Aug 2026 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785775462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7EZt6KO7lG8FcX9WT699sYwppoB9LUKhBecqXvd/dQ=;
	b=oI+Ftq7QHwNOamWLfQlxR1s+VH5H/xHD/n59sLRhbDnUPY9Jvs7OPu/wS6fnjjFWyQ94kH
	L6sBuRsm/vM98uxrAHA2p0PLJrArW8I+I4OKkUUSbVrF7M8JJrzCSxgB3JFmrDgmRulE9/
	pLR5gNZLJOIdmogEzhi5DC5wm+3GtZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785775462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7EZt6KO7lG8FcX9WT699sYwppoB9LUKhBecqXvd/dQ=;
	b=SdaodsKJpIffkXl0rAXcmAW1realq0Vrdd5uFSKLcyUr6W4xjRiWN7LDYcdlxw7f73wVY0
	BSW6Vv0K1rRX8ZDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785775458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7EZt6KO7lG8FcX9WT699sYwppoB9LUKhBecqXvd/dQ=;
	b=oyC4x8nGdSsYhE7uDhFy3mpsZSTObX+6KaI5+nPtQCCSmMzdAbivpkEH580bXfATRx/499
	/rnbBCrFvwRNm/TnnaBO6iCsti8Q5QbYfshEt7TrUbVEgvi8IhaeAPJYfsjflNMtSyP0YU
	D462sgy/vukAbxb8Zj7r80eCdhkeJ1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785775458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7EZt6KO7lG8FcX9WT699sYwppoB9LUKhBecqXvd/dQ=;
	b=zhuzRUQDrnP+Domlzo3/1FCpIz6k8srBWDErZHHbFo3HOpyS4OcSjVjI8vhU471Qe7a4LZ
	81LYndPgkMk3LsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CBBD779E7;
	Mon,  3 Aug 2026 16:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sB/XA2DFcGp/SQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 03 Aug 2026 16:44:16 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
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
Subject: [PATCH v2 5/6] mm: constify generic pte_get*()
Date: Mon,  3 Aug 2026 17:43:59 +0100
Message-ID: <20260803164400.531199-6-pfalcato@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803164400.531199-1-pfalcato@suse.de>
References: <20260803164400.531199-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_CC(0.00)[suse.de,arm.com,kernel.org,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

None of the helpers need write access to the PTE. Constifying the param
allows for const typesafety.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 include/linux/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a..dc418553e57a 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -490,7 +490,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
 #endif
 
 #ifndef ptep_get
-static inline pte_t ptep_get(pte_t *ptep)
+static inline pte_t ptep_get(const pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
 }
@@ -739,7 +739,7 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
  * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
  * operates on present ptes we're safe.
  */
-static inline pte_t ptep_get_lockless(pte_t *ptep)
+static inline pte_t ptep_get_lockless(const pte_t *ptep)
 {
 	pte_t pte;
 
@@ -777,7 +777,7 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
  * We require that the PTE can be read atomically.
  */
 #ifndef ptep_get_lockless
-static inline pte_t ptep_get_lockless(pte_t *ptep)
+static inline pte_t ptep_get_lockless(const pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
-- 
2.55.0

