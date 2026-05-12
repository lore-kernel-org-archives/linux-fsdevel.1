Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB13C343C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617949; cv=none; b=NmBXeXXcb1s4xZgGYET8wPSVln3R8AyLuTUQtazqeMZmnzhzKbCN/ZJm84Y1rGyCFmYaucTRTARWmzmnZzbomTl2CKboF3109u3jbHTX7XTkZ2xwVUMA7gNzAs4NLXgUynxWIeBtkvraiT3SWKSk2IC0Be1/CTSzkL4n9Z7iCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617949; c=relaxed/simple;
	bh=UYreWyiRU/oVctAqMN7crrT6Vxk3LLDPMzN27TYlxBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=HyjQdU3wHgvEEFEaT0HE6Ph91UbdLlm4fzZCfr5AtScMHzCjj+CIcPsqdYgzqhllOChxuc2KpzZzwY++cwJNyWegAeGiY9tijGAnoelNrg/ie682GUinUkBYdcJZ0z2m/aYzdFPCf3OLqmaqgr+/7XFBitGtmr/CA1CkfTiVzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwN8cGIb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwN8cGIb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9429f49cso7528858b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778617948; x=1779222748; darn=vger.kernel.org;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvqclSxC3Le+gG/fDpqgZ0WbLWL5hpox9DRtNNA0cQ0=;
        b=hwN8cGIb4ax6nR99Vx2OzzPe+3UBAojp3J0G/cLLdhqpvbLSZ0fmGv79oQ/JdO+DAD
         nQh/oZaTDw6QV4HA0yxUPUVzUUHXhHLpuAU2ad2u2uRxvQ0vnAV3VD+yR0Rh4HwHL5rC
         /FbBBiXPuVbD9eTY8GFpLoP2H6mYnTixKeVerV+zrMZVTN6zOPSV+BLuXkvvGfKtEofV
         vKfhBxBSeZoZ2oS8Zs/GDJx2ux5AVyeo36qnqCj2RIzdBzUR8avnUxjrQWA4oudcnghX
         k/ZDgZCojblfGFacKHV8eiFktcHQPwNm0a0GS92yOuryS90tlObV8amueDwKKkuQVTbS
         0z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617948; x=1779222748;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvqclSxC3Le+gG/fDpqgZ0WbLWL5hpox9DRtNNA0cQ0=;
        b=Kr2iqNk+adcV2huWgJLAGoUGm/ZaDMeQag1yZSK4SUWxIcg9utHrMUeSGsdYzvc3ZN
         urfQuCcsVyawJMaSrXV/H6ZqXfE4Iq7H+ftz1YwFBh7DXv+PSFyD8OniWN/1yOedh9Od
         ZSzz/5SJAZ6cp+BSy0WyuLMGqDc9HfK6PrAX/npBNHkF5/4028dHj7J0bv8JrB+AjO1b
         5ezmkua/Bkghq8HHQ/uX8qSDQGCasAcXfANtAM650a6UvPKcSU1/+bdeWRpcWBClsbmA
         b2xDxzsDtvfY9wD5tktEf5xOppn56qLVrqDhWCA+7IJ2Wkvc0Gvqc7p8ltVQHws89dcp
         B0Mg==
X-Forwarded-Encrypted: i=1; AFNElJ/6nJIJwjch0AP49ko4I56EJkeNDmkiZCuwZmvhddiGSzPnja1R7twbaBapWd18eKfG2GFczfMHg6L7uJ8f@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQh/goOUs1ZC4+D8uuR+wJLxvivuN5d0NhkXLrm29YydMB9yE
	hYt8iP2p/lRSlQA+WCbS3miIhRfQsHTfsX+aw+HXkOdgaIlExGxgApo/KQicHPKcaN9uy0SbhRG
	1whkIZg==
X-Received: from pfhh2.prod.google.com ([2002:a05:6a00:2302:b0:82f:7163:35c4])
 (user=fmayle job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21d1:b0:827:447f:7dbd
 with SMTP id d2e1a72fcca58-83f042dd3admr190592b3a.46.1778617947724; Tue, 12
 May 2026 13:32:27 -0700 (PDT)
Date: Tue, 12 May 2026 13:31:35 -0700
In-Reply-To: <20260512203154.754075-1-fmayle@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512203154.754075-1-fmayle@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512203154.754075-2-fmayle@google.com>
Subject: [PATCH 1/2] mm/readahead: add kerneldoc for read_pages
From: Frederick Mayle <fmayle@google.com>
Cc: android-mm@google.com, kernel-team@android.com, 
	Frederick Mayle <fmayle@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Formalize one of the invariants provided by the current implementation
so that callers can depend on it, as discussed in [1].

Link: https://lore.kernel.org/all/20260501061146.6e61392d125cf1847d7cc181@linux-foundation.org/ [1]
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
-- 
2.54.0.563.g4f69b47b94-goog

