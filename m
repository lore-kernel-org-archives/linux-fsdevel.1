Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5841FC10C
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205266; cv=none; b=hc1oSgEKllAeetEDkKBvTNnEfUrwYykmDJR7ihG1HsyptFl2y9uYFvX4hwhBkrXMNXYatPZK6Cl2GGt8pUuae7O5MQX9jQ/hOBItns/qb04augfKjPI7kTGpq6gFuK6mXo2YTnX3zbvp/6QPwiyCnmyJH/I3sKH4KAwCAJWeg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205266; c=relaxed/simple;
	bh=JvbD0U0T+bhy9IJj6fXaNvDa29+thTK1djpSTzYkHgw=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=JeAu10WOx+c4FFWrHOppcoJqo3tLDQ1TCfJiV1+gfnyqxi0d2BCLr7LutG1xa2lrPKWuEJ9WKiNECuQCi1bDs5HrQWItTDaTbwSbvhyfKAjRFf3Yhm0LCPdgdye6oPCVqjMKOi4EMPUrdjanssOCH1rWQwcEwCTIaidgjvU0WRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DH9fQ94j; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DH9fQ94j"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2efc342ef15so2332312eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 18:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778205264; x=1778810064; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nDCNoZ6k2LKNRaJd57QrXwFLyWNzjd5ZsttzB1Naw58=;
        b=DH9fQ94j/vmH8gtjjZEEozd4FIP8es8vfu6caveYEJOARiW/TkWe3r6Wp4CjXL4LZ1
         sYwQHxQ4J2cXHFZt5trf6w27XkfyMdmQJFIM1qV2/dWD7oEsATVSo/qlbhvlpcjYeg/O
         pTvs3F+mKYfIbFSqv1V+Nsu1S4XFFkiUZ57sVZs0Ksaoz+9UZz2eheV1saZdA77+XGxS
         Rnvx9Kt7knMCMiwW4Y8ZyF9ESQ2KKF/z4PUonyvghAFqWqr9NN6ymmdlyZxvvyHUafuw
         HpE/7NhyIR9habje65gdGWufBCDoJHf/OkfJbTYDtL70t5Ig7cJvIdlSIymoWCmc7tmk
         UWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205264; x=1778810064;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDCNoZ6k2LKNRaJd57QrXwFLyWNzjd5ZsttzB1Naw58=;
        b=Q4ijkEUdVg2wfEop/r2mmg6M8nQ2qXlJ4/xfCtbAytk56JQQvEP7ZIhBbICaGNDv8k
         fNPs0Epe9QP9K3SLOA/XB5ETpRxdfDgDtMozLgPzo05aDgu2/XyJUdDZJIzdnXpMgyM2
         wA78Onow6FKnCciVJ4c5MHYscxBk/6o0oPOOI2W93MTJe8rR+sq+y0nb4TGKT7L6hK2f
         RInfhRwd4IC7JynVCKnSjbSyPt499U2wqxgPdzrMNoyVDxMLTpowY0xWPOytsxVlxlrk
         Mizj+ro2jFQLUsIQAzrekLATtoH2b97XNuLBUrwHvy2BGtad5qCL4YIhkMip+1bJF2in
         /Nhw==
X-Forwarded-Encrypted: i=1; AFNElJ9tXGr5YmIgto1jsty62tx2qJbiRDn4kKNEhRXXSVHzs2SLXQxTXLDnSSSQuGRR7EoEojeUP6ydBEJLI7sj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wUTKtMe+OIsnWktCBtMHNSgWWPPrtVjvpKdXPuibfT0KWvxo
	543WOvRRHs+2iIRURyS3qtE8bIFA/lvBwrgqthbLLASzmf3BBKHkn9/Q8tVh6q14DSruqWdMBQD
	TM94BRA==
X-Received: from dlbep12.prod.google.com ([2002:a05:7022:108c:b0:12d:c585:f600])
 (user=fmayle job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7a6:b0:128:d9a1:b68b
 with SMTP id a92af1059eb24-131a69ece6bmr5011504c88.33.1778205263925; Thu, 07
 May 2026 18:54:23 -0700 (PDT)
Date: Thu,  7 May 2026 18:53:57 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508015402.735441-1-fmayle@google.com>
Subject: [PATCH 1/1] mm/readahead: add kerneldoc for read_pages
From: Frederick Mayle <fmayle@google.com>
Cc: android-mm@google.com, kernel-team@android.com, 
	Frederick Mayle <fmayle@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Formalize one of the invariants provided by the current implementation
so that callers can depend on it, as discussed in [1].

Link: https://lore.kernel.org/all/20260501061146.6e61392d125cf1847d7cc181@linux-foundation.org/ [1]
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Frederick Mayle <fmayle@google.com>
---
 mm/readahead.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8c12b63ccd4a..23bec5497308 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -146,6 +146,17 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
+/**
+ * read_pages() - Start IO for a contiguous range of allocated folios in the
+ *                page cache.
+ * @rac: Readahead control.
+ *
+ * When read_pages() returns, it is guaranteed that all of the folios will have
+ * been processed or removed so that ``readahead_count(rac) == 0``. However,
+ * that does not imply that ``readahead_index(rac)`` will be updated to point
+ * to the end of the originally requested range because, for example, the
+ * filesystem may expand the range upwards.
+ */
 static void read_pages(struct readahead_control *rac)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;

base-commit: 2d565cbaafd43b10b75da56e43e5db9852a56afd
-- 
2.54.0.563.g4f69b47b94-goog

