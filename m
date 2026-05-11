Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DCA4D90D1
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535663; cv=none; b=QC2bB5jynW7Y3/ZkJ8XEo7bUawtJD3k2dBfEdodd1RwzkMtk1tbcsn5HwJiAJdZpNaRVMQG8zbcZipZuo6+1H8l28uHrdoXaEUFmMgLbevPbQigAWsY7xCv0NZXgG6S545tmhlGjKG3e6yGBlf+6Ofl676+vYd/3fBZWkz6JZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535663; c=relaxed/simple;
	bh=ljekVeTJvDasxU8usBmBxCnDSxCzXGYcRwljfuuKbvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pudL9i/wz0u6Q1r9hNFdRrcvIlmqSsfcNdtoYv6f1SGUyoJwcfOi23E7EDwcvb0Y6QYGGUONybQ5nSemERNUaKWZOyVksPPFytFpnMt0MbyNejKwuU+C3HW6b1FlChjrbej9hrp8cKdgLdTL0oE6p1MHW66AJ6JPmIwZtWLg1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com; spf=pass smtp.mailfrom=amlalabs.com; dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b=z4+Accw4; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b="z4+Accw4"
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-47cba53479aso3001340b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amlalabs-com.20251104.gappssmtp.com; s=20251104; t=1778535660; x=1779140460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsyEmMEatHl5JGOKxvyMcGRrS7mW1Z+dscSdDt5bxRY=;
        b=z4+Accw4Fx4gFPQhtHZ+Z5VXb+sSa5sC15b7gTHSGBVhrYlB6TYDAzlyzrD0D5iyex
         oAN3vlMA7EPxsPX7emq/M6uC4Rt4Ni98u5bG3CaxOqEIzWwLoxLD5yG+LYNjhQ+2kIoM
         LEnaqpAhi1s0TYckWYySCBBGtSM0bwPzGJELyoW0LqyWboYLlymJ9hCgtIpmQAbJ1vU4
         9YnK/atz6PXdBBLnsu3m5aIthvH93FktW11Ams1fGWTvjEYtkcEglyu/8UUhOFfBqY/D
         4zKJEYetEpod1+0zXM+O6ygrj0n+jTsXn+C3fFUjvI1YCNjY2uwy8db8mQb9PD1qrYCZ
         HbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535660; x=1779140460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsyEmMEatHl5JGOKxvyMcGRrS7mW1Z+dscSdDt5bxRY=;
        b=BBQS3Cj+mCSw4L/kpSXseACD6Wsyd2VJLtdZXLpIKnoM3l5U2AV5rRUMWogSgCFeRM
         qg9j76dUySxQvk9v7488otIZTrliwodh9JLKfI22WNI4/dnWXI5d8r/rm8g56fP/6ZJ9
         eEFKjBt9p1gNrSo6BKas8Kv1EqA5Sbx5493m6iErJqlJ9lZydiQUsUwWe4r1l2KZ31TL
         +Hnq0KzNrj1YaCaQZ5w9F34oJ5zUfHIxaXA9ITM5Ji8A+2oOhAWIqXkoGjxzKeJSUqSx
         YPbYnM2BOwUyD5f5xOkn3IPcOa81l7UdOxqZbbty6gRDNWwJNEOBFdvqddW+XuxGeYh6
         6keg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ii9HeBCTVWY/NdfTCzI/x+Q+37aZ6N+Aq6rqr6VWCmJRvJgfroDeG7AY23Q6llwAhMbafG9LEL9sUoYiT@vger.kernel.org
X-Gm-Message-State: AOJu0YxhrYhAUxBqkTOwRpO/oVXRTZf4o5N+zgSMwvHuayoaIhIM515a
	opJlaoJ5XRH2/fLjPkS8dLW/eBSH17nJmNOKGv0Sw3AkF3KGQ9fBwSToxlCMnZe4TipkAhRVwZO
	ttCNIx+xFDwylsnJnYas/4WCEZK/kiRkHpwEwMRs=
X-Gm-Gg: Acq92OHJqBFqwNCvhLCA5RbbkJigiSItwL56xekHiCW9+5mD59kSiYNE20yYG0eIfjw
	h3k/xgPxyhfFZMdXq0JrkTItKT/JsMyowQqAFsajdB5r8F147TArbbwzpIrBhf9FtKi+VDKHXKc
	Qys5+jRgf7zyLhP5zxxB6/VDiJPDqBxvSueli869FNrWiCRmXJrNh7pcfjivebMm78ZpZSBdElg
	JzA1/M8K16uC5p+Azr+ntfwms3ZOKf+jMv7zUf9jCQ6IFozryyIhyDRqWuykwUfthfxQ6sy8oTc
	KstF++ozIIvwDJmsn2RttKYhNUU0pkz4e+rBYkPt/GjKtOMB2lEQYSfO1jfQHbTipw3u3eV38sR
	4g6XMGBtCtofACmM1BflRJ+Hd3DCvAOYa6HYdkkrac3wtKU/huHnFfzlqjLGArD+hiMlnHiZI/g
	==
X-Received: by 2002:a05:6808:2e45:b0:47c:3415:3726 with SMTP id 5614622812f47-48297388e0fmr335122b6e.33.1778535659807;
        Mon, 11 May 2026 14:40:59 -0700 (PDT)
Received: from amlalabs.com (104-10-255-95.lightspeed.sntcca.sbcglobal.net. [104.10.255.95])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-435f250853csm538701fac.10.2026.05.11.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:40:59 -0700 (PDT)
X-Relaying-Domain: amlalabs.com
From: Souvik Banerjee <souvik@amlalabs.com>
To: djbw@kernel.org
Cc: david@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	apopple@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Souvik Banerjee <souvik@amlalabs.com>
Subject: [PATCH v2] fs/dax: check for empty/zero entries before calling pfn_to_page()
Date: Mon, 11 May 2026 21:40:20 +0000
Message-ID: <20260511214020.208939-1-souvik@amlalabs.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
added zero/empty-entry early returns to dax_associate_entry() and
dax_disassociate_entry(), but placed them *after* the
`struct folio *folio = dax_to_folio(entry);` line.  dax_to_folio()
expands to page_folio(pfn_to_page(dax_to_pfn(entry))), which calls
_compound_head() and performs READ_ONCE(page->compound_info) -- a real
dereference of the struct page pointer derived from a bogus PFN
extracted from the empty/zero XA value.

On systems where vmemmap covers all of RAM that dereference reads
garbage and is harmless: the early return then discards the result.
On virtio-pmem with altmap (vmemmap stored inside the device), only
the real device PFN range is mapped, so the dereference triggers a
kernel paging fault from the truncate / invalidate path and from the
PMD-downgrade branch of dax_iomap_pte_fault when an entry is being
freed:

  Unable to handle kernel paging request at
  virtual address ffff_fdff_bf00_0008 (vmemmap region)
  Call trace:
   dax_disassociate_entry.isra.0+0x20/0x50
   dax_iomap_pte_fault
   dax_iomap_fault
   erofs_dax_fault

Close the residual gap by moving the dax_to_folio() call after the
zero/empty guard in both dax_associate_entry() and
dax_disassociate_entry().  Apply the same treatment to dax_busy_page(),
which has the identical pattern but was not touched by the prior fix.
dax_associate_entry() is reachable with a zero entry via
dax_insert_entry() -> dax_associate_entry(new_entry, ...), where
new_entry can carry DAX_ZERO_PAGE (built by dax_make_entry() in
dax_load_hole() / dax_pmd_load_hole()).  dax_disassociate_entry() and
dax_busy_page() additionally see DAX_EMPTY entries created by
grab_mapping_entry().

The remaining users of dax_to_folio() / dax_to_pfn() in fs/dax.c are
either guarded or only reachable on real-PFN entries, so this exhausts
the anti-pattern.

Fixes: 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
Cc: stable@vger.kernel.org # v6.15+
Cc: Alistair Popple <apopple@nvidia.com>
Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
---
Changes in v2:
  - Also fix dax_associate_entry() (Suggested-by: David Hildenbrand,
    confirmed by Alistair Popple).  The same anti-pattern existed there:
    dax_to_folio(entry) ran before the zero/empty guard.  new_entry on
    that path can carry DAX_ZERO_PAGE via dax_load_hole() /
    dax_pmd_load_hole(), so the dereference reads a struct page derived
    from the zero-page PFN before the early return discards it.
  - Audited remaining dax_to_folio() / dax_to_pfn() call sites in fs/dax.c;
    no further instances of the pattern.
  - Updated the page_folio() expansion in the commit message to refer to
    the current field name (page->compound_info via _compound_head()).

v1: https://lore.kernel.org/all/20260501233933.2614302-1-souvik@amlalabs.com/

 fs/dax.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6d175cd47a99..4bca6e2bc342 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -480,11 +480,12 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 				unsigned long address, bool shared)
 {
 	unsigned long size = dax_entry_size(entry), index;
-	struct folio *folio = dax_to_folio(entry);
+	struct folio *folio;
 
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return;
 
+	folio = dax_to_folio(entry);
 	index = linear_page_index(vma, address & ~(size - 1));
 	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
 		if (folio->mapping)
@@ -505,21 +506,23 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 				bool trunc)
 {
-	struct folio *folio = dax_to_folio(entry);
+	struct folio *folio;
 
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return;
 
+	folio = dax_to_folio(entry);
 	dax_folio_put(folio);
 }
 
 static struct page *dax_busy_page(void *entry)
 {
-	struct folio *folio = dax_to_folio(entry);
+	struct folio *folio;
 
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
 		return NULL;
 
+	folio = dax_to_folio(entry);
 	if (folio_ref_count(folio) - folio_mapcount(folio))
 		return &folio->page;
 	else
-- 
2.51.1

