Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029763B6BE3
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788024981; cv=none; b=WWfwJ7uDsWHvd/3gjAl8FqUpI/rxBIj6mtNVFJAwXDX2TeqECKZvKKpo8P4S/2k7W5vkYrI3NtXS564u8QTDPTJmL/lf6E7IeLJeCLo+d96ZfGb3Ru5PYUpl1JDqjYdlT4vHBUNE1SqEqqw5v5vfFy99jtWhN6A4rAO0Zy44l8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788024981; c=relaxed/simple;
	bh=2C8NK5/BEtwI65M83AGDMTCuoGhQlU4pL5z9yKc64ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKFGp31EUlffcRi5G9KKScx9AlnEhRcSRMwXcX35q9uSddzif7YrZAby3OhEqj6XQ6i5AZjvuA4oeFZ+0n4Q91TaA2umEIjaZ3KuRRUS1J3AMNuGTLdpIKK9QRlr+lmy/JFSeO7scs2JlVRHI3BfXkUROazH69itKTXqETcwmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4f2jgjw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4f2jgjw"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2424631a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788024979; x=1788629779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bZl8fb/65j4ubuzPzNdm3TBI6GilXwgRUv7xSKODXo=;
        b=i4f2jgjwAZBb9eMSLXp3t15cg0NwaMawAz3PJK2c9l+crE8PeGEu2p8nVkbbMAO7lG
         9JjKKiBg8g2XjLslfvU/a4xHWLEbDXN3BVl/J0IbrK+Yx+RTEIO6X/4tfjFDGe58+PTT
         OPdw2ZI3fChZahBahfsA6gOI0bV+fpMFpuP6ev9zHOMdHn79ooisKREKEXZnS/t7lzkh
         A7AYQyIJqXKil0zoESB9i/qO6krcKi7LkWoTL7EIATVt/I5sK6RU+q6Ll/n/A59xYOUt
         6NAH/WojmR2U9omXA7+QKA56oL/RoJj+oSrUjUSVFqNaOP8QVodIl/MRnf2UqEykiDZU
         bNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788024979; x=1788629779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bZl8fb/65j4ubuzPzNdm3TBI6GilXwgRUv7xSKODXo=;
        b=YxRT/V5tSx7GFs8E1e1le46p+0BGoCV/jR7ivzvwl7l0LWtJz71QdbkzgMWUbQHdB7
         RI9PXwsX/Ppi05zUBHNKxZ3ezBB5F89iKlSi24SAFHkKhfuqxZvXmG4jceOoIGeQ5bkN
         Qg/FvUIJuZbAyZXD7WyzStRbhnzsEL2mE6CVqePk6UhJ0TeLoErLi/tgkZVRf6oZMv3X
         UTl44mqtq1LXqxQf0KwGw3AZu6d2rHt79W6cx4uaOwo+f1y4DC2I9cnoHyl2TeNzL8g4
         paWvs3DmfiSps32cQruH64yPGYWvN6CEEcwJO5n8rTI8lq627R1AlyQtqsFM4f8aF8cd
         O0IQ==
X-Gm-Message-State: AFuF++nUZh8xeSCBJLsqgJIGnU3GO21GUxkubUAgcQm77mmCGIZWPdpp
	cpdu1OH0zgfV54RxGtj2QhQ94HdvxUPI9STl1Ysw5i5CNnEy0F1/Az3R
X-Gm-Gg: AYBFou2W3DWxUAuK3mOlvrw92ZuqvuFI4CTUeFmvNZAYks+x26h4KgJGvpTv2UFt43h
	UmhUMSMyZ7CvRJShJRfbByRucBoD/7MgyR4/J7Js69MifzHyqA19HMj7+LPPoPR7sMN3gOEANGz
	tAny+4u0WBlamSMevGic9MxDSj4stKazyAE+hdqKPA2ArREjvQaee1+Kcu4xJ4AEPOkY+vhvnqf
	ttgp2MsdH2B3wHKz3dyFP1ZaLS235XDQe/kPA/UbGXff4HhqHpMRTNQOhFl68AlHOViuUGxeDfs
	eP5XbGCXCcTQ3OzA0H4nCyephd3wuxZkDNDsYIAl8ed5EwYpUWkNtVsIXvFhW3CaRhygO3SlV2w
	L7nog4RbDoH/aOdvCjBSwP9RD0icL1o6RF5Sn9TlKkImQThLqYzKR6fsYwtk2RfYwCjDHqykuoP
	0xJwGAckKQlxIBRHc8W+xsxnrU+rx6zEnN6ONbYhCEPNFVIYaJtoV0lF09zsDvK8d6+0yjeKvxg
	mQPiy3vehO96iJoxU2aOsS1dbvZh/H0
X-Received: by 2002:a17:90b:4d88:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-3989bd3d8c8mr6030350a91.14.1788024979256;
        Sat, 29 Aug 2026 10:36:19 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396dda36ed6sm7634942a91.2.2026.08.29.10.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 10:36:18 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baohua@kernel.org,
	axboe@kernel.dk,
	trond.myklebust@hammerspace.com,
	tz2294@columbia.edu,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v3] mm: filemap: retain mapped dropbehind folios
Date: Sun, 30 Aug 2026 01:36:12 +0800
Message-ID: <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com> <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qiwenjie@xiaomi.com>

Fault-around can map ready dropbehind folios without going through the
normal page-cache lookup that clears dropbehind. A mapping represents a
competing cached user, so retain the folio instead of forcibly unmapping it
when writeback completes.

For a mapped folio, folio_unmap_invalidate() can call
unmap_mapping_folio(), which takes i_mmap_rwsem and may sleep. Retaining
mapped folios avoids this path when folio_end_dropbehind() runs in
non-preemptible task context.

Unmapped dropbehind folios continue through the existing invalidation path.

Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Tal Zussman <tz2294@columbia.edu>
---
Changes since v2:
- Explain why retaining mapped folios avoids a sleepable unmap path.
- Add the Fixes and Reviewed-by trailers.

 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6afec636881f..00fd89cf6f55 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1616,7 +1616,7 @@ static void filemap_end_dropbehind(struct folio *folio)
 		return;
 	if (!folio_test_clear_dropbehind(folio))
 		return;
-	if (mapping)
+	if (mapping && !folio_mapped(folio))
 		folio_unmap_invalidate(mapping, folio, 0);
 }
 
-- 
2.43.0
