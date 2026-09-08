Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1822432304
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901506; cv=none; b=Z5BWjXc7fAForXKncc7TjlLbFm36rLb2Rf63QHyJYnINHxiz77GZEH59CaXTAMv/HfxVCi+uy/cn8dEkUkIRoWByDJwp0P1d8z/bcuH0fg3oRIo1ggXOXKdusvhjj/bIUlq6+4+8v3XVdhMSmk5+rN/TSioaIrk3TaDD7aRU4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901506; c=relaxed/simple;
	bh=JS4es041X9iQ3ww+X8OGRBNQHXimqemFhijw7rmEypM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyCnY7EacWknq8/XTWVUA7qIJns5T8vXbTl5SNnXtCqK5tXejboE7kqnw3Vhki1w8W26cR6g+V0CObPHrGWD+oPFmTWDtO/KD1aRSwAkDtTltsS3S1v76gHjgs2ZYAy1/OYW0eereA4EvJ7xp1JyAUtpea12DY4uFuagQTDDwlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=TgnpThmI; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="TgnpThmI"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aae3149so432891d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788901504; x=1789506304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+JM2TitCUkHWsoHev5+SihBzZ6SFDmIJWRE6hX8zY3w=;
        b=TgnpThmIp23oMAZm0vH2L2u1SQYiCA//G0VpRSYTlS16DNKXch4r6QhrGo3uSE3Ufs
         nxUuHLG9DJIRA+Yl+c5Xjbz5wTCfJCAbak4Ytx8TAFn/xM0hulguYLvgc5qXRJ/uJ+qf
         vmfOS0pWqTCfZiLdvQKZK3Q+lV4ffTiYD7AXsX+3Zc8biT2eSToycgqbelMqLygq+VMP
         GNqyxbT0ZtoFGEZx4ZqhVod0IQljxG7KkP/An7DZGfiTTHFa3Afj5wxmBOiffaEmX/Tg
         07NJtibWDpsTRQDf2xEfiNTRruB4JX2BF19sfeV6qpImGNuj5htNVBlFb/tTh6986v70
         y4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901504; x=1789506304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+JM2TitCUkHWsoHev5+SihBzZ6SFDmIJWRE6hX8zY3w=;
        b=Zd1U6LRf21cYI36mBCc9V0mau6+hc2n3E78zR8aywKEy5Gld78+b4AymVXnZtDl0nh
         KZriaQ9KqSUPNf71B3jpje5JbWkxjvwW+QuHX2C+0eO4vkowwUFZ0hT63qgQ2V1uP9bS
         Df0zGK1xdfkvI1chjBJ4XAtNJilHNICvbJdSVRFpfZi6qavJM4ERJiloJC7Jxt9HAFbl
         pNTK4JhqOmkNKtOYOeNlGVSK0m+mj75LSvyBSsL7yxS87vVkphmpZ73UyLhYP028nMgn
         Lmk45ewLJJ1k23vgj2AJ2SwtSBvNoMNrCMi6twDEPkB3hi9fRKii23n5dPEcMMA4dpf8
         9DDA==
X-Gm-Message-State: AFuF++mRjRIgWXxmuH/dlUd7jKar+TYEqV9wD/Ytqm3EUt5vROXbgQ3+
	z06UqJ+y3QvoNZqlzLzZ6Xubo3NwZGJ7eNNcYi4RzzrLy+pKdyG9/iPk7+zRKwFoOOrGPatz8Si
	kEG9mY7j5+w==
X-Gm-Gg: AYBFou1Ffjj3aHyo6NMEGZ2zoRPXpzEVcQ6WKp+Ew6ewXXKDtBfqfAufi/9rJEAyCLs
	n+zE5xhfwkBZC3VJzaTkDB+CXn3/aTque1DMS0g1iC3QB7d0S16SoRaoozCL+lY08f5/LIFo4r5
	tNrjr+GU5ADEGAtx1/lP+pPSUFEBdbdHUQV0hzlbjXk+m7yUKSa+B84r5Nzi9jAXsqw5vt13/TU
	oq4U3mfr6n6gMplrDJ61EWHSHpPhqrIgTCESZe7c6jPY/BTcc3B7YTyKpxyYq7u7p7z6PD4ojDn
	kJj7B1l4JuRWbuWRVT6SZVowceGbhG1sdNuJeLSKaYPzm0egVbTX1kfb8kppbD2P/wsSATmckdf
	MCqHPYKGRULGx6d7eD7cTUEYs5QhsiW14G9jf+EpmvcfNaOSAalwwr71FHR+S4soDuS97Hof8xP
	AaXald9m+wfWJjzK5cDQlJJ/oWmcOtE41D0O+XXYIZbyDq4jOrhWQIdPXWDEOxob/yCDCT6DwkJ
	5RqnblRirOFTxuU0620Qdf48PYx7GJQhZoHe1jcLXI/0tgPsMWMDylVEJWNWh4tVnWsyyzkq+Xa
	pkEngzxMcuX4sfyj
X-Received: by 2002:a05:690e:80d:10b0:66d:1a61:5c6 with SMTP id 956f58d0204a3-671036edcbbmr515226d50.29.1788901503692;
        Tue, 08 Sep 2026 14:05:03 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1eca:212:86d0:4e87])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb495eccesm11078129d50.18.2026.09.08.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:05:03 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	willy@infradead.org,
	brauner@kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 3/7] hfsplus: take the bitmap page lock for allocate/free
Date: Tue,  8 Sep 2026 14:04:44 -0700
Message-ID: <20260908210448.296772-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908210448.296772-1-slava@dubeyko.com>
References: <20260908210448.296772-1-slava@dubeyko.com>
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

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
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

v3
Matthew Wilcox recommended to use folio_wait_writeback()
instead of folio_wait_stable().
---
 fs/hfsplus/bitmap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index 1b3af8c87cad..30178ea47362 100644
--- a/fs/hfsplus/bitmap.c
+++ b/fs/hfsplus/bitmap.c
@@ -39,6 +39,8 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 		start = size;
 		goto out;
 	}
+	lock_page(page);
+	folio_wait_writeback(page_folio(page));
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
+		folio_wait_writeback(page_folio(page));
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
+		folio_wait_writeback(page_folio(page));
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
+	folio_wait_writeback(page_folio(page));
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
+		folio_wait_writeback(page_folio(page));
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
-- 
2.43.0

