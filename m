Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53643DB31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756307; cv=none; b=rhGX2ktpDtJywuabX6kx9g7WLnHHGoVybky0AZAtBsHw1iEFbQFX090Iru1bU/YFqKUV47/1tHKcp4+hyfn5m4/vtyf5UWvG5RK3S8N5HK4V/AnWEpvxjBhla8H9/P9UbYc6q3Tfd2L5qgmALR5iie24zRw2dotQb64cu0wq3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756307; c=relaxed/simple;
	bh=KZUVxOc0p7kFcYrQwMz18I1W9Z4ZYGW7PktGqvdWzAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brd5dsKu2o39rY/rkAv1xOQ0aNVTD7xS2/PM1xaw4CO6nlpMrXm4r3KxvQuo0QVxzlPTB4cVvyZfnN3hg4d2qJ1g3kuZynC9jNX6Hk/AFODkiwEZJRfM3vSVf5k/ML30H1XqdRV0kAsixtAFAXVoOlSdNn+g1AgMU+DaB2vV3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Tp0Echou; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Tp0Echou"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ee6b2da98so69932337b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784756304; x=1785361104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RVd7Tqudr5skQ5e195RHK5b7MVxPD4aNe7kJCADp80=;
        b=Tp0EchouSQ6TdV12IGs1Wx3nFKiTII8rIwBn8uDey5uMhBFHwmaR8OAyY45V2JkRrw
         0yAwjD8GbU04s3RWXRSGgvpTLzdbt8ne/Xt0Yukeua5nnZ4WfGZzQtZAxvLsuva0s4kv
         9xFMhNIT5JeU+DssgR32KZGcrG81s5ZQvkkL1tEQUlYiiMV8EMVdn3mal06e34etjMTp
         XckOSAw0GLi9eGASPx08IaxWdWJ8Lr8r26CBA1io8bdCPC2YdYiqVqFDsKxJJ3bBIqSF
         75C23bUTugPHhgp9HWbKiaj2OocefyjhWH/a73cJzmOIuRN0HwTnUI8yH6R0niIyPjGb
         i1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756304; x=1785361104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3RVd7Tqudr5skQ5e195RHK5b7MVxPD4aNe7kJCADp80=;
        b=PKr0FqRr8s1AlaMCQUppVqae3ahG0Zsy2rBljeZe0ZEeLYXr8kHpE6/hrx+VnL6wQ1
         LVcJQR6YPoAK3Sl+FN6LqWxsELlkqFwaq8xRRuDgCJg/elMW+rBtCO7SepwJtSgCvEVD
         ye2rOrg5fzAfA+L9W97AH61xkozVkjSfwXp6gimF2WHaw0k4C9l+HrQYdO2XzLgqk2iz
         sx8lpEBNzJOUdBXLT2nKIwJAxRdwJQ2Um1qE//pCony2sFKsgZblvKfpgHwYIooKdHSf
         b0qMoMR9d5jADtpFw5eD00J+VlAG+KKlzwwvWgsL19I6geC+GGJztUSvDqJSaGbmoCoS
         NSgQ==
X-Gm-Message-State: AOJu0YwMCh6dzqHA75Wc0Iz7c5eUdNJQ5rpt7hRX84+FJWSq91YgGFSu
	zn76Lg0p8d7PtPxQIzZH/eKYd0yVpP6QzWLFLM5ddp6VueUT/qcTd7a41NO9aSieC06fRKQB0xs
	rkmjHczk=
X-Gm-Gg: AR+sD13oamvq7KvRp+fZYUSehvqiRdC0LLXgYJHnzT5qmv8zt5ApaWlX9RHNVm+ix0K
	3FIvu3yKHKvlXh/txMAH9uiFO0n3M/WWusmMogOZJgf/VpRpdImwIiASNozQelmIa7uGr5W2KKw
	i+oLnR2CUCZECz2CO37iBES/w5xSXLTVmx78I0xW9t2eUlZ5sm3mBcUfzBm2s0xYoIqn6y7OhwO
	IwesEJVHyPCYzsD1cO4wA85jAIyFZwh1ZTLnjrnbP6NTcYX9tXyqkgUkUjeGGDQLbMMxNhq1iMl
	yj3o28fbiJIfniTwhFGU1Xdh5+FOpqdK/AqaLmDdERTxY9BK3iHyWbi0Pm/T5WgPgHqpIQ5LIiK
	B36GefqXipP98JrYMJ9NjyO5KeVrA38RPq3gc97PcpQwBBvtZhLZgNupIcIToYdRQtMnWdEYRhO
	VlfOp+9IibUU8pccodOtUHB45lRV/xvpmLlQgoH4wyBBl6S7H+S1UPrLq044Eyq/jt/BoO87tfH
	vI7SyQo8wIaNlPYuc/rvkq+NPtha7b2QdI=
X-Received: by 2002:a05:690c:f0d:b0:7fd:a7b6:8d87 with SMTP id 00721157ae682-81f4c2a005dmr1135137b3.25.1784756304551;
        Wed, 22 Jul 2026 14:38:24 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c7706dsm20034827b3.21.2026.07.22.14.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:38:23 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 3/6] hfsplus: take the bitmap page lock for allocate/free
Date: Wed, 22 Jul 2026 14:37:55 -0700
Message-ID: <20260722213759.1360225-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722213759.1360225-1-slava@dubeyko.com>
References: <20260722213759.1360225-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hfsplus_block_allocate() and hfsplus_block_free() kmap
the allocation bitmap's pages and modify their bits in place
under sbi->alloc_mutex, but without holding the page lock.
That leaves the read-modify-write of the bitmap bits
unprotected against a concurrent writeback of the same page,
which can read a partially-updated bitmap word or race with
the dirty-bit update.

This patch adds taking lock_page()/unlock_page() around each
page's kmap/modify/kunmap section.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/bitmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index 1b3af8c87cad..571652fbaeda 100644
--- a/fs/hfsplus/bitmap.c
+++ b/fs/hfsplus/bitmap.c
@@ -39,6 +39,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 		start = size;
 		goto out;
 	}
+	lock_page(page);
 	pptr = kmap_local_page(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	i = offset % 32;
@@ -75,6 +76,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			curr++;
 		}
 		kunmap_local(pptr);
+		unlock_page(page);
 		offset += PAGE_CACHE_BITS;
 		if (offset >= size)
 			break;
@@ -84,6 +86,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			start = size;
 			goto out;
 		}
+		lock_page(page);
 		curr = pptr = kmap_local_page(page);
 		if ((size ^ offset) / PAGE_CACHE_BITS)
 			end = pptr + PAGE_CACHE_BITS / 32;
@@ -98,6 +101,9 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 	start = offset + (curr - pptr) * 32 + i;
 	if (start >= size) {
 		hfs_dbg("bitmap full\n");
+		kunmap_local(pptr);
+		unlock_page(page);
+		start = size;
 		goto out;
 	}
 	/* do any partial u32 at the start */
@@ -128,6 +134,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 		}
 		set_page_dirty(page);
 		kunmap_local(pptr);
+		unlock_page(page);
 		offset += PAGE_CACHE_BITS;
 		page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS,
 					 NULL);
@@ -135,6 +142,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			start = size;
 			goto out;
 		}
+		lock_page(page);
 		pptr = kmap_local_page(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
@@ -152,6 +160,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 	*curr = cpu_to_be32(n);
 	set_page_dirty(page);
 	kunmap_local(pptr);
+	unlock_page(page);
 	*max = offset + (curr - pptr) * 32 + i - start;
 	sbi->free_blocks -= *max;
 	hfsplus_mark_mdb_dirty(sb);
@@ -185,6 +194,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 	page = read_mapping_page(mapping, pnr, NULL);
 	if (IS_ERR(page))
 		goto kaboom;
+	lock_page(page);
 	pptr = kmap_local_page(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	end = pptr + PAGE_CACHE_BITS / 32;
@@ -216,9 +226,11 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 			break;
 		set_page_dirty(page);
 		kunmap_local(pptr);
+		unlock_page(page);
 		page = read_mapping_page(mapping, ++pnr, NULL);
 		if (IS_ERR(page))
 			goto kaboom;
+		lock_page(page);
 		pptr = kmap_local_page(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
@@ -232,6 +244,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 out:
 	set_page_dirty(page);
 	kunmap_local(pptr);
+	unlock_page(page);
 	sbi->free_blocks += len;
 	hfsplus_mark_mdb_dirty(sb);
 	mutex_unlock(&sbi->alloc_mutex);
-- 
2.43.0

