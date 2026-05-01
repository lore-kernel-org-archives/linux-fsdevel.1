Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19162329C71
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678780; cv=none; b=KtAJjnx+sNLGMMkTIYRb/Yhpx/Z93wsnU1o3brR4Fr3it2Ag+icSkjApdcmH6vhIax4fsnbJsqsJMt/YeehoPr7Zk0AiJHOYTWZq8h9f+7XaxsKndjAOUwE1GvG56XbHbMXO5F6pVZoQFqR9FewaxSzRafojZXr3fTCzYl+UpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678780; c=relaxed/simple;
	bh=MQlW50n380xfH4YSLTJFu5splwcmM0wqWdXlHGJpjXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLsIE85EJj1rMc2EYqMVmzqd5DQd7dp/gcTmKesM/1Zq4PjCBGkZVf+x1cJXmG7zdaERCfyIfsdUgLlby9pXk7MvjD/62hNa0NMMHTtvhDgJG5yfZIjO9WCREmrvyLZM2kFqCp9VotaFttFgZSnM4OralSAk3FojAXxzIz/j+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com; spf=pass smtp.mailfrom=amlalabs.com; dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b=Jo0TF+pU; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b="Jo0TF+pU"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-6949831a7bcso1321224eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amlalabs-com.20251104.gappssmtp.com; s=20251104; t=1777678778; x=1778283578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qFO2NeB0Skobdzpthr8c1Mn9L79Z6O0Ds9iXE6n6s0=;
        b=Jo0TF+pUjzgyZkOGcV1NdwCDthNAFPhlu603OU85L26A7GhwkIjvCfrBxlpL+24yVW
         jrGPSwQyDhaZe10csr1h6IwzeRfhkfzUN3MRmbd/llzAaFSjTxP0cH2lgacZA5ORkNUI
         zF6PTk8+ccP/sxWtsqsiw36YjRup6hcVL8UeT2z01b9TaQVDMJITztrRNJP4fC+lYcJd
         mssGWt34VrRGw9bN3xRMltC/X64+yT4Qh0uzL3brVwcryXbjFw9QjcTPlxNDP7H4Cyd8
         RE5RpdBlsuB8QORqrNNRosR1yqfLzv8h2jfff98fdlRke7VHrjjx7JCXTX7rCSuhTmi0
         zwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777678778; x=1778283578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qFO2NeB0Skobdzpthr8c1Mn9L79Z6O0Ds9iXE6n6s0=;
        b=AVzXvKVlbdaHZFOElVqHFrMpWX+GUMfvI6Gqd7HsR3yDskcHeoDg3ZbrYh6T8hgnbp
         PYUuD4KdJrncIK7sn/hoI14E4RGTH4zLIz9UMjv6yxgi5q0gnCSbEvQnyZc3rtBj7LJh
         EOKSmZBAOzGoWzsE4IU3LB/SkZUc8a6OUsf5yvlN8GJG00/4gBHTOSLzsn/Z0wQVBP0c
         WhVf0dL5n58Uqgn0HyyeFxRis123UiWNh2DdUwz1dKlMdWF5nddFgBg6lHCZq2Y7m8e4
         krEvcrOPFbQLb2VBSP5FGs9QwqL0Yv5KnRs5qcJ2LNjLepqaVSWJ0t86fC1+Wr5Uiw5I
         fCEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SZmjzK0bmJrEHHgIgXZ8B3qsoBWpnnAdud/Y/3WEVvJmw+9dE9JXO4lhEVXejeMugfV2yzRIbO/Rcznd5@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNE+a6IQpOJjkRLwe9+sIZoyAkwQRO12inrb3Jya5K91zFE2I
	mbw7IdI0CN6vZiz2Hc/jSgm0epp38sz2IzCdTc7ssL3PTgSig3txYkGWisykXz25X+baJFUcv/V
	qYL2DfQlKIwQCkeYP5LZ0cVGrNpjYrt5aTHe4cqE=
X-Gm-Gg: AeBDievjJ36csfuThJfADfgLX1r8lRxLSUyKefzNxB5xrif6sWj3nu5gx+4E1OMZg50
	kfkgBxupMx98PZiIYdEluiY+WOtLWAA3InH8ZqqB/hMWUG6bIuRMFatdypVzCrpO13ojqlfude5
	zxOJL/krkba3KNrNagZnVAJSSWkbQ5ovVCOTx5Q01r4oXH4+dOEyKUiQmcxeycu1bqXQzGyjEhO
	aYdbnz3hg/4ihWromyRaY5pPl8N5M2CsYsT6xlo32hClhV0G5Y9DxPPWqXPL6ozcH/l4ha06kXI
	wxXd66hJLdNWIAH58ODYv5TQFpY+ielT6xXuwmu09oV+bMTz2HzuRRbec7thU+b6M93kTWGlwqc
	/Wz/g6QBontyrP0UOzwVuJidSV5J8e+TM2NSXqIeN1ilP6ltadBYiwoR8QxIj7q4LOwA95qcply
	OysTpe8J6a
X-Received: by 2002:a05:6820:61e:b0:67e:160c:36ba with SMTP id 006d021491bc7-69697d6a089mr608506eaf.48.1777678778004;
        Fri, 01 May 2026 16:39:38 -0700 (PDT)
Received: from amlalabs.com (104-10-255-95.lightspeed.sntcca.sbcglobal.net. [104.10.255.95])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-434549400e9sm365539fac.5.2026.05.01.16.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:39:38 -0700 (PDT)
X-Relaying-Domain: amlalabs.com
From: Souvik Banerjee <souvik@amlalabs.com>
To: dan.j.williams@intel.com
Cc: willy@infradead.org,
	jack@suse.cz,
	apopple@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Souvik Banerjee <souvik@amlalabs.com>
Subject: [PATCH] fs/dax: check for empty/zero entries before calling pfn_to_page()
Date: Fri,  1 May 2026 23:39:33 +0000
Message-ID: <20260501233933.2614302-1-souvik@amlalabs.com>
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
expands to page_folio(pfn_to_page(dax_to_pfn(entry))), and page_folio()
performs READ_ONCE(page->compound_head) -- a real dereference of the
struct page pointer derived from a bogus PFN extracted from the
empty/zero XA value.

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
zero/empty guard in dax_disassociate_entry().  Apply the same
treatment to dax_busy_page(), which has the identical pattern but
was not touched by the prior fix.

Fixes: 98c183a4fccf ("fs/dax: don't disassociate zero page entries")
Fixes: 38607c62b34b ("fs/dax: properly refcount fs dax pages")
Cc: stable@vger.kernel.org # v6.15+
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
---
 fs/dax.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6d175cd47a99..6878473265bb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -505,21 +505,23 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
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

