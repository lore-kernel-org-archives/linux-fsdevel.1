Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63F43552F
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385413; cv=none; b=Xc+cBRd9s4ajJZSuIACh8du5bXdCAdNYROgJh1lk2fTZ/c3ZKBSknEBPqmgdDkMxcubntgndxsukS2yG78/uVYdL/rnvBSlxBC8+QYjG9yllUmZTGVA3Tv2llph5GI60Zk3MQPuTtlPJ5I1ZzrXklM4VuAhDkXdnG76QUd5ltLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385413; c=relaxed/simple;
	bh=bJXRfg3f1kV3ccy2QSpAR+7YljKtfWl7hXv2p8G7tDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HzC8kJbztQiBUftjtrXaG0Mg6SSfcWJhun3W+VwW75yrWqVw5mH/UdJ2QkW/J2iS8YhMX1N6q0U+koB9I19gKDbBlpJOirIHumh3uDVtaUyLBjPu2B0BFFFyrPHKzlLiOpsXc8Bt5E642ECtfrYxhO7N99+fT0am2SMla8TsgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnwI6LS7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnwI6LS7"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-498012a61f6so6155e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786385410; x=1786990210; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MxlbjW9Gub36tupqbS+bClfYkYoCr7n6Y2ztqAqDsEc=;
        b=XnwI6LS7t2Z8W2Cz9lwjpXK5z1zDiWF5FkF+g89cWWTRLra+eHUcZmvL0kM9g5PXpQ
         bO/yMV75GuZ7BRlehxzAcfy72re7jKYuOR5TPnzZ2GGn/AN527WOD4EUSwNf3rnXZ2Ux
         AQnPksMFoGFMKwdJqHf7tJNKNybNXNEThi/75dNUAAXrSQZ9lQbb1IEsLoHVOZGYAK4Y
         YdtkxSPEVUN2SHq4Vv8lYpZOLf2mVst9y76V/SIsImlaGLx/uDiEkFLKliSobPYyltHf
         Lr2xVsu8MTGX5p3Rs4ceoVLXV/xiiRBQg/VjWQwHUfaMPdqA4EcsPmXZNIv2FI9JtTYI
         qMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786385410; x=1786990210;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MxlbjW9Gub36tupqbS+bClfYkYoCr7n6Y2ztqAqDsEc=;
        b=IxtBjcQ48hYLaKzOiGASdM7ijWBe1Gf7p1xICk5dArns+KlsMUwihtDNttxbYpFKMI
         eSuHIEidI+TA1kS40Yvj2pPTEEcXO+eMeKnJE93CmWF4zr7VORXhGKKfboRFgG6e3L1T
         8OrGHzWlBPXoyTRFZZlLPRnMGCi3uoUqKFLq8zlpC9/Gt/RMvf+FowG38ctTDRutrv1X
         XYMPqkTNvqGyVzSdRYUiIu7aB1TZB9FD9On2nrOEE8GXC8Wn+J6piM3TiYIN7db5OeZI
         OfKz7PCqJiPT7P1DWj3uPeo8DwcogjrRLoAnxQxiQ+7+mJ74zgSR3miPLdshvnABfMAq
         aDGQ==
X-Gm-Message-State: AOJu0YyxeJtCPCfpY0dtSzrKN9zwnlv2acRtcvRHSKXEZ1pplMRYHXDk
	beLoVqDgy7Q6PGv1Pqge8xua3QNRW+5yvig/Ocdir+whZ8RkTaFt09xcpSes1/6SRA==
X-Gm-Gg: AR+sD12hA7BvrcwyPeOvif5ixnC02n93LMdDzi6OaStotAEfg1j8Kf7wJLgLrOqEx3a
	F6jv7VmnoAUM41/xt3/+j+iX0JgBTkKGFsUUFiGwpgv2zqRBbKWN8CZ3a9ZCLGyJYGDeUAmYeMJ
	zNxSzSvCdur5dz3cN0B5N2Z7L/bf3C1xLEwjssVqCqBNWUXLR0sEwYYQhhN6hNTqmGCAQIx9Iz+
	JjqLXK6NCsSep9aamaP9oCtK2Ozh1fE4kurZ480moKkewnQ+gNdnVeSj2xiWtcxE+ja3liPuPSb
	b8MYn4SVrdcempc8+HE8TJQ7BjAvep6/4HiRZxsHVj9JtMPuPVsP+mf+Y3qS68MNwzLOgkeRiaS
	886UpAjMAjir7iiZgKrC8s5hBAcoHWRQRFg4JGxLnqatMVgZcuQmfFQRD2NtRA1KZ8PysuTVNnW
	UHWswYrbmC6WxjkcDqkjDLEN9IMQ+SuvWv1O9aeC5i2gh4yJcxyisvSe5I83hscQuY4+ousHxuM
	eW9/TAKqCWxR8czU0NjxrYsDADqFWJWVkMSSl/i5ECBYgg=
X-Received: by 2002:a05:600c:4288:b0:495:3ffd:5e39 with SMTP id 5b1f17b1804b1-499745be994mr58225e9.3.1786385409115;
        Mon, 10 Aug 2026 11:10:09 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:5c4:b02b:cff6:9cc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740e13e3sm9004625e9.10.2026.08.10.11.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:10:08 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 10 Aug 2026 20:10:01 +0200
Subject: [PATCH v2] mm/page-writeback: document folio_mark_dirty() locking
 more explicitly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-set-page-dirty-warnings-v2-1-1bd40fadfacd@google.com>
X-B4-Tracking: v=1; b=H4sIAPgTemoC/4WNQQ6CMBREr0K6tua3gCmuvIdhUcunfKMtaStKC
 He34AFcvsnMvIVFDISRnYuFBZwokncZ5KFgZtDOIqcuM5MgT6AE8IiJjzrnHYU087cOjpyNvAK
 AHkDUZVOxvB4D9vTZn6/tj+PrdkeTtrutMVBMPsy7ehJb779lElzwujS6q1QDCtTFem8feDT+y
 dp1Xb9B6MN50QAAAA==
X-Change-ID: 20260810-set-page-dirty-warnings-4000f0015394
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786385403; l=2530;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=bJXRfg3f1kV3ccy2QSpAR+7YljKtfWl7hXv2p8G7tDE=;
 b=df8Qhd2Ukq3GZytYeSVtH/STCIAEcIKcgxQNFYPewQdmLafxN/6eI7SK/34O21LsVc2ZWwJz7
 KDS3Rs9yYdZCQoVCsnjhEF0af9LPwr0Xw2mJuc5ohMjYJYaw+SCGnq8
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

We have had bugs where set_page_dirty() was used on a page from GUP without
appropriate locking, leading to UAF, in:

 - KVM, see
   https://lore.kernel.org/r/20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com
 - i915, see commit 0d4bbe3d407f ("drm/i915/userptr: Try to acquire the
   page lock around set_page_dirty()").
 - VMCI, see commit 5a16c535409f ("VMCI: Use set_page_dirty_lock() when
   unregistering guest memory")
 - kpc2000 staging driver, see commit b6d13bd9f2c1 ("staging: kpc2000:
   kpc_dma: Convert set_page_dirty() --> set_page_dirty_lock()")

I think set_page_dirty() and folio_mark_dirty() need more explicit
documentation on how they should be used with pages from GUP; so add a
comment on top of set_page_dirty() and make the comment above
folio_mark_dirty() more explicit.

Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v2:
- reword commit message to drop references to out-of-tree drivers, and
  instead add more examples of upstream bugs
- Link to v1: https://patch.msgid.link/20260810-set-page-dirty-warnings-v1-1-53cad4890808@google.com
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

