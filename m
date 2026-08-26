Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272448986D
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785007; cv=none; b=hgt6RLB8Or2wt/wdCeDaB6w51sEn1GJkTdufY5rwj+AlwXcwES0TgfUq5gsRUl69DtacWBFBGt/bHtuMQ2R9LEdd1ZptlcaY/U5RO2KA4eAbGZUNkq8wsFElQhKpZQ8BHKLcXOtsQh5un8gAhDkSbY9Vs6ZDr5crOfVRsNt9BDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785007; c=relaxed/simple;
	bh=JaRn8ntKGht+EHMO8Q4DJYkGjwMADCXYs5DA09+Y7PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9OMxcSM5yRSYwbg9yq9nHXobBn+KMpTgWdT4kqObec6g1vSNshz4cbv9pgPCKGT/KQWEmuxLLct5cmiZWBIHAib/chivzwI6YnK7Sve2L3AMD9X8p96teWY3kF/qXe41cSw34hmUE8ggItdc09Gp+d4AJKWmviUMd51ARqWhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=T+NjWJkG; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="T+NjWJkG"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66d25d77713so3350d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787785003; x=1788389803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGiXgoIDnJgT/hJLpTKdlH6ryFUGCP9ayS2UrCnF43Q=;
        b=T+NjWJkG0Wlf9N2vH2x5yLqAO9IRIth0VNzfaGkaoSg/xcFlxG2Wv0xKRFHY7DBwlc
         ddU4iTlja1jIRwf4vOHB+GZwFdMtr+Cg02i19BvR0pCd/77ElGNa2p88Yy4rO/pCz0Pr
         sK68LdMl5x1lgI0qYrjg4OfBkzysPKoaeSjs7OuJgCsymO7Nx9POAmC3KzXOaPLiwNv0
         7H8ehnwhlFlZIKm4JO1aLV0v4KkC+qcQiBVMTw30ccVOphqFUgRRvmFBOZGtV1vdTwy8
         OcceZzLjICh+XN3Oj1JKwhEeEMPF7IA6e+C4NPDxrZHO4mJKNJYeqF4ovDbCjog/YHsM
         RhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785003; x=1788389803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGiXgoIDnJgT/hJLpTKdlH6ryFUGCP9ayS2UrCnF43Q=;
        b=jm4isSSrbhCeIKT9G+DFnPPxW4RGIp9aRX4HJ1hpBYnyJkMZSHoaPzz5fABm0PmmnD
         XB5MNspeYO3r7W/Bg5yaeqbsq3tXYmFfrIG2Gp+xUPUWvEtFKaaBPkId0Ppqv0iSI48/
         J7Ihhv6QXIJHhTOZg80CPUEUvu61XihSeUnLWtVnK0dflbjBlbuojeh1EFR1WlQbRwZ+
         glaMXIrmrH64iORy95fMDRbKTKcN+lWwLWThshv2r9370gHAymEnhpREpUDzrcht+w2b
         exyoJVycQVxQM13MkNA8alEVpnZieqGcXQkeuDUyiAK/88T1DY4OEoGmvJ93+wrt9abu
         rs4A==
X-Gm-Message-State: AFuF++lZaraegv45gr0Hn96kikDfQaanDZaS0aOXm4H+9RYiYCWP9mQM
	qYzbLlAqko2AvQRjRBounZwafu1cmfdp2uJkBuRzKuRQpTw3stvKUTMoSikwlcfhrOM=
X-Gm-Gg: AR+sD11D5qAHVU3Ryf9f/aS+NTn3h15GTRH+QFwnhjbBZFvpp3NZrxU2BpDO170XdFt
	gL42XH3zw2nb9oHiqBM64dmr1VvG6RVomVnCXvBBxPMgJ1iBbLiEcUlByfSasRFnCv+zhtPDj74
	ZYH7aop+bwM+46kNCyE6K2AlQ0/ycSoL/U/VZ6UCDmv1tnaO1LqBBHboqEEQLIatI22ePGsKg2y
	FcEw2pBFSJwUw1Lxx733mmCcJgm3++N0TmdE7YpZAiejQ3vEvd+A1LRftdMR7BVn0vXRjDB5dl+
	Z1Vis0oZeO1psERHpMm5WvzWkP29Hu2cbpnHNkITCZWFp776tZViu5dwhhaviIdllLrVoPLLndP
	N+Mc4ynNSu+iTDQoCO87Z+qzlKRIxb78Gh+os4IYOniVmFBBXKzwNrg1f3+uRY9VzjkHbbakABQ
	gFM6wh8reTUQzziGKzkNDD5lS1ONlKLb3dTZh9DEkN8e+OV0BbpwTjWoYc0IGwZxXk7CiFW6R9E
	sHobgFpZtd3yarNQ+F6aFeLcGCneMEiqqF3vgPej7ZrE/nW3c6PcsPJgEFTlmW5FxNeD+0sAOgg
	OTsAbRavmbsDyOPkz4czdszwy14m
X-Received: by 2002:a05:690e:1381:b0:66c:c1a7:b6 with SMTP id 956f58d0204a3-66d256ba339mr3170699d50.23.1787785003037;
        Wed, 26 Aug 2026 15:56:43 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d243b9d47sm2130161d50.0.2026.08.26.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:56:42 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 3/7] hfsplus: take the bitmap page lock for allocate/free
Date: Wed, 26 Aug 2026 15:56:10 -0700
Message-ID: <20260826225614.486112-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826225614.486112-1-slava@dubeyko.com>
References: <20260826225614.486112-1-slava@dubeyko.com>
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

v2
Christoph Hellwig has detected that taking the page lock around
the kmap/modify/kunmap section is not enough on its own:
writeback drops the page lock before the write actually completes,
so a mutator that only waits on the lock can still start rewriting
a page whose old contents are still in flight to the device.
Mark the allocation file's mapping with mapping_set_stable_writes()
and call folio_wait_stable() right after taking the page lock in
both functions, so a mutator also waits out any writeback that was
already in progress when it acquired the lock.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/bitmap.c | 18 ++++++++++++++++++
 fs/hfsplus/super.c  |  1 +
 2 files changed, 19 insertions(+)

diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index 1b3af8c87cad..61c49cca4a7a 100644
--- a/fs/hfsplus/bitmap.c
+++ b/fs/hfsplus/bitmap.c
@@ -39,6 +39,8 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 		start = size;
 		goto out;
 	}
+	lock_page(page);
+	folio_wait_stable(page_folio(page));
 	pptr = kmap_local_page(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	i = offset % 32;
@@ -75,6 +77,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			curr++;
 		}
 		kunmap_local(pptr);
+		unlock_page(page);
 		offset += PAGE_CACHE_BITS;
 		if (offset >= size)
 			break;
@@ -84,6 +87,8 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			start = size;
 			goto out;
 		}
+		lock_page(page);
+		folio_wait_stable(page_folio(page));
 		curr = pptr = kmap_local_page(page);
 		if ((size ^ offset) / PAGE_CACHE_BITS)
 			end = pptr + PAGE_CACHE_BITS / 32;
@@ -98,6 +103,9 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 	start = offset + (curr - pptr) * 32 + i;
 	if (start >= size) {
 		hfs_dbg("bitmap full\n");
+		kunmap_local(pptr);
+		unlock_page(page);
+		start = size;
 		goto out;
 	}
 	/* do any partial u32 at the start */
@@ -128,6 +136,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 		}
 		set_page_dirty(page);
 		kunmap_local(pptr);
+		unlock_page(page);
 		offset += PAGE_CACHE_BITS;
 		page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS,
 					 NULL);
@@ -135,6 +144,8 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 			start = size;
 			goto out;
 		}
+		lock_page(page);
+		folio_wait_stable(page_folio(page));
 		pptr = kmap_local_page(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
@@ -152,6 +163,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 	*curr = cpu_to_be32(n);
 	set_page_dirty(page);
 	kunmap_local(pptr);
+	unlock_page(page);
 	*max = offset + (curr - pptr) * 32 + i - start;
 	sbi->free_blocks -= *max;
 	hfsplus_mark_mdb_dirty(sb);
@@ -185,6 +197,8 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 	page = read_mapping_page(mapping, pnr, NULL);
 	if (IS_ERR(page))
 		goto kaboom;
+	lock_page(page);
+	folio_wait_stable(page_folio(page));
 	pptr = kmap_local_page(page);
 	curr = pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
 	end = pptr + PAGE_CACHE_BITS / 32;
@@ -216,9 +230,12 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 			break;
 		set_page_dirty(page);
 		kunmap_local(pptr);
+		unlock_page(page);
 		page = read_mapping_page(mapping, ++pnr, NULL);
 		if (IS_ERR(page))
 			goto kaboom;
+		lock_page(page);
+		folio_wait_stable(page_folio(page));
 		pptr = kmap_local_page(page);
 		curr = pptr;
 		end = pptr + PAGE_CACHE_BITS / 32;
@@ -232,6 +249,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 out:
 	set_page_dirty(page);
 	kunmap_local(pptr);
+	unlock_page(page);
 	sbi->free_blocks += len;
 	hfsplus_mark_mdb_dirty(sb);
 	mutex_unlock(&sbi->alloc_mutex);
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 5777e31de45a..459ca6f3b814 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -571,6 +571,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto out_close_attr_tree;
 	}
 	sbi->alloc_file = inode;
+	mapping_set_stable_writes(inode->i_mapping);
 
 	/* Load the root directory */
 	root = hfsplus_iget(sb, HFSPLUS_ROOT_CNID);
-- 
2.43.0

