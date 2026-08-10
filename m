Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EA35F182
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377765; cv=none; b=lv6muKtwIRUsPsPiZgpQ9wH3VN00+4TPeRLdp2+oLdjLZkPvg8VpAH+FKPyd3F+3bDKuGhKVSdGC5CPYoQKRlmEmLsCF/AEV1d7fqOCN+EZyBA9tX8J1JVmTM+mNgS/cZ74m+6UZlxKpjC2Z/0CuewVNca6eOkSvaRULnFEUKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377765; c=relaxed/simple;
	bh=mY5dttTZkk9K2JmQQlLj1BdPvr/NSFG5E3voNNy9+fA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HTaF2iQqwCoSe8SeXcX1mfbnAQ7pQ1nSM382VPYf7/akJ2GxtiE0NDnLcSzk6unzxa2dJixPyYvA1vftzwCyyoqFMxVZBpv9CMoeMLWtfIZaAbusdU1wQVXATfIc+AJcKLjdQB5S2uC4QnkW8NwjkccluzZ9RAAGpmlWPZWB06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Akwxyuno; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Akwxyuno"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495509b08ebso75295e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786377762; x=1786982562; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qhLgQ0D45SllBgldcORYJCsFM4ePRReZjhBNf0nbF4o=;
        b=Akwxyuno1tu3TL5LNuO0VmrE6PlZbOG0dl4G56EN2cP6iDAME+IztCVA6F9f6BLJSO
         ODtl3ZD1Vy4rnYwd1fQdIA52Az3A8NTFIOtoo7rQsOB7DFQImd55apmIQDH0XEWmfqvY
         jTP2Ud6/A/0vLS+my4NCLWjHUQuVPWDyjU3FwPfowxNAiLBfLhKHClZNy/8+vRyvmieq
         H8SVR4JKXKOsdjg0s1SO4SDqJpaCrfmZ3cR22xHmz8wwNKsE9LcAAj5qzY+NY6Y+ulvs
         Ytu+MY50bFi8vUe6WGgoEFDZlB0TCnVbgaNYb/i2k0cqsQd0XN2xNY67h9BJskUoP7fl
         M63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377762; x=1786982562;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qhLgQ0D45SllBgldcORYJCsFM4ePRReZjhBNf0nbF4o=;
        b=Pb6f5duP0RZRlqkXlxu/k+UXAAElSkU9RGitfcHd9m7pHx0Pd4otf/y6OqUo2CYWGo
         xt83GS4BF9UT96vlI898zBSIiwJryBkZq1hyeRe7t3Pnx7R5PZ5QOhpe8xC6zr44zUDY
         p9NeTtTjS5/CsMMgVJ/eAG3DOctzoT7EpbFCpVbj0b2ltEgWcQnvl1M5KHGCsn+JnpMm
         UjiUm05crqeZsAy0N+bcHX2PTJHvoIxwXIMDNd4MhVwD11W7SQMOV5T2Mege/fgIDLxS
         Obmx382nJ+Xx/hEAkBdCvqM8jW0986s4fWrVGl4fGHoLNu+o4t6IIGfII9BNMWPnM5qB
         3pvg==
X-Gm-Message-State: AOJu0YwH5+WAjSrlQgI521pYboJstibm+BZ0s3NnDo+kVIWLs3JwE5e9
	TqKrwq7de0k5jV32n64FAB67OyCc2sN8YD03bwHl3TF/c6RGbekc1jFalWZrAfKTKg==
X-Gm-Gg: AR+sD13ROsNl8n0oweC9rouKZovL0v5IZkY9JBZIoFvvo9F0p46sr3VqSyBBJp+FPBT
	Vl2HUzT8+a7TyK8zZPwEmCkVY9ZKveM1rHjv+jOX7HLBDe7FV5ZzkbhuD9MwoCrF5lkSY5E6zd3
	67kAjHknz7mqxJ0ptY1qJjcJwQUS+3/AUSscFnVpICvxMutXr+A1qJ7IR9eZU2vLgTdrB6s6daA
	Bb5BVBAPdsudADs4xYoZ/B5YDuxxiFEvTQ0yqGTLisqhGA925M1gCe/ZeTV3O5zfnP6sBJfZhI0
	6vYHNpr72W68CUljIl7fyy2RYo18WC6DV7JkSdWtZvJFQ95jV7ENPSP7U2ct2ggaXQ3RFOU7HG5
	qhBwiIHgGOzEKCMWo1wF5VqhHjS0rF+BsJttnmSF7xjrTon3z7jX2NmKfmIT3lWQXrUzcRAQXP1
	GzuoC/lZxjOVw8p0jfKJSEEYqwGpNA2sdF22coLkECaUjxPwrf1aMydgWxfxgUSCzt795/3WGWQ
	bvYT+agB5O76ZY+gYmAaEoBz91FrdL/HvHioQclVzK7ewU=
X-Received: by 2002:a05:600c:3104:b0:499:5ea5:e493 with SMTP id 5b1f17b1804b1-499624e760dmr5065455e9.6.1786377761425;
        Mon, 10 Aug 2026 09:02:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:5c4:b02b:cff6:9cc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997414694csm1912625e9.9.2026.08.10.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:02:40 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 10 Aug 2026 18:02:36 +0200
Subject: [PATCH] mm/page-writeback: document folio_mark_dirty() locking
 more explicitly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-set-page-dirty-warnings-v1-1-53cad4890808@google.com>
X-B4-Tracking: v=1; b=H4sIABv2eWoC/yXMyw6CQAyF4VchXdukw8Uor2JcDFCwLgbSjlxCe
 HdHWX4nOf8OxipsUGc7KM9iMoYEd8mgffkwMEqXDDnlV7o5QuOIk097Jxo3XLwGCYNhSUQ9kau
 KewnpPSn3sv7Lj+dp+zRvbuMvB8fxBT1K+Ht7AAAA
X-Change-ID: 20260810-set-page-dirty-warnings-4000f0015394
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786377759; l=2162;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=mY5dttTZkk9K2JmQQlLj1BdPvr/NSFG5E3voNNy9+fA=;
 b=9kn4rcVcxjseP/S4RDeNfmc1tWpkZOGT4r8SzeLd1xxvUvuCW2V+reGRw2JoOP3ojpaWIqMBK
 llt9D6UHcHNB8JFvkojIuFXwLbr7wlOPp8DG5xVzoqdEhYDm27GdKPL
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

I have found two out-of-tree driver bugs in the past where set_page_dirty()
was used on a page from GUP without appropriate locking, leading to UAF:

 - https://project-zero.issues.chromium.org/42450908 (in Qualcomm's Adreno
   GPU driver)
 - https://project-zero.issues.chromium.org/494546491 (in Google Pixel's
   GXP driver)

Today I found another instance of this in mainline:
https://lore.kernel.org/r/20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com

I think this shows that set_page_dirty() and folio_mark_dirty() at least
need more explicit documentation; so add a comment on top of
set_page_dirty() and make the comment above folio_mark_dirty() more
explicit.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/folio-compat.c   | 1 +
 mm/page-writeback.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a02179a0bded..6212fdd6761a 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -41,6 +41,7 @@ void set_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL(set_page_writeback);
 
+/* Read the comment above folio_mark_dirty() regarding required locks! */
 bool set_page_dirty(struct page *page)
 {
 	return folio_mark_dirty(page_folio(page));
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e98748112d1e..b0ab687c83be 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2773,6 +2773,11 @@ EXPORT_SYMBOL(folio_redirty_for_writepage);
  * in this folio.  Truncation will block on the page table lock as it
  * unmaps pages before removing the folio from its mapping.
  *
+ * .. DANGER::
+ *    Do not use this on a folio obtained from a function like
+ *    get_user_pages_fast() without holding appropriate locks; you might want to
+ *    use set_page_dirty_lock() or folio_mark_dirty_lock() instead.
+ *
  * Return: True if the folio was newly dirtied, false if it was already dirty.
  */
 bool folio_mark_dirty(struct folio *folio)

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260810-set-page-dirty-warnings-4000f0015394

Best regards,
--  
Jann Horn <jannh@google.com>

