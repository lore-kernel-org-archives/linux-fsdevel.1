Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20E606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 22:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C20E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=owy5ZthE
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91791ec1b83so1174656d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1792533833; x=1793138633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAW+AstcWY6xdbUMT8c6ejV79mSagbIvsiRflolJ1vg=;
        b=owy5ZthEue6QQOxJtKsPfLLvXClheXOgjB8GiT1eOxQ/hmKXG1JKJzBAtXwdjOpOPy
         vw/A4kjVaWZEmv8IOnjSn6UshuyEeiFwTuaXtbVkg7x1hK8igt8jiWNLOJKLdHisjGUt
         bL0bh4jLto6ckmgbI2Y1wAPuGKTyuuftNuqBafVfa+U3uTOadx7ktxxAIwQGSpSahCs8
         97Ts/r3eDxhwApG1Dx9QzgTx4+rg6hEoNAkAsj/MUA3NXB7aoi8OYklWOTv2jH/Hy3mn
         cH8nYuITdCyNmf4dk1aiQsrNkwbCMwULI3y7+QBq1mVUP4ExUOo1jMlVl5HnYlJL1rw+
         V9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533833; x=1793138633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XAW+AstcWY6xdbUMT8c6ejV79mSagbIvsiRflolJ1vg=;
        b=D+CMjDVLNEui9FYFHHJOUk+f/gh241cwnOX0yDeRRVrAe6UWoUXeOTz+U/ohL8HRj+
         gkx+PgdmlLanH0YATpO53XsqIErGlg5+y9fhTcOr90yImjFKH9Bw/jjY8TRM9aIhHuHN
         bzf1teknoQkD0hsyYqfeqlKHjDJxgIFHTbjlrCWdoYL+j2pw1eQrpzHqgUp9tQuGyQzA
         IrhctUfAj3sXxA4BxcwZL8BWDpYp13atP+OjIHDNR4yZd8bXntJyeDbM0hNPeblQuNfD
         vTxdNIBql7EAKdhwnFgyMsGShecfe7SAw+BzXavMY3vkb/YKMHIiVb6uU1+PbrzwsXzv
         KKmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZfbeAiMdlD0KJiSYSSV3LB1iZTIN7McJau6f+6EP5tsS1MQixI4a5cAui/Hdywv4q9wI60QZE+5NklJa8@vger.kernel.org
X-Gm-Message-State: AFq9FYIHdUKbWsR2r3x5ay5ekojdwAeXfs2CvOuCBh3+hZxgMVqBiPyL
	JX+RY/607NwkveFaliBp1uoGzD1D3X73D+Jepu6NdSEC73HbXI1axp+DmBPRimRWnsI=
X-Gm-Gg: AYBFou0oKn8+JGcsDzRvdAvFYcxvM7E/wuMt0thzKjqo9R2jmepAFzupP7fj0NmRBUF
	GCggRDyi0vyCVv7obn2cGWhkqpYu/VI6kzJ204oQmiZzuz5gnkjT/JfLQ0GyzQ0lud/4dLWcF5m
	E4E7fvYM5z8LMb9XJnzfxH9CkVt4solAfaepqwTW55LNFRSwy2tE+ZqysSreD7qzqGnXS17jLNS
	xCtJhLFTSa2gPyc9pYc12ZA1Ek1G4SmPnb0nry9Pq9WHgZOcwnHrIn/A6AhAIJ+0dwaSXhECx5i
	+C1OXT755c9S2S6z2GsHKCsBdUfTcvLiEcuh1jbDVRxbMbg9I9IsGZ1HQdLpqMpYxx34X8NL91d
	t07Uizt7wtGZ+4NUIhMUX5GiWST8d48A1qLRSUC2IvblWuQWvQi8+hqqTclALtsFM6wDRH9XUgr
	o8mI+OKRO04xIoshClCmokEMbasYjwafmYOC+DJEwPAp9Zy/5RhT0X/Jh84rguVksBeGwqkNm5w
	XqFm80qExUu1TDfwe4cXMLIDbuu2y4NxvgUlxj2f5MdpIwwNhc18St5IXEKyTo45TNvo5HPAg==
X-Received: by 2002:a05:6214:3c86:b0:91b:5d3a:5105 with SMTP id 6a1803df08f44-91c12f580cemr2460656d6.51.1792533833063;
        Tue, 20 Oct 2026 15:03:53 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10bd5d8csm8763286d6.24.2026.10.20.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:03:52 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 3/5] mm, iomap: keep a partly covered page until an uncached write completes it
Date: Tue, 20 Oct 2026 18:03:44 -0400
Message-ID: <20261020220346.28020-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20261020220346.28020-1-snitzer@kernel.org>
References: <20261020220346.28020-1-snitzer@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An uncached (RWF_DONTCACHE) buffered write marks drop-behind every folio
it creates, so writeback drops each one as soon as this write's data is
on disk.  A page the write covers only partly is usually shared with the
neighbouring write, the one that ends or starts in it.  Once the first
of the two has been written back, the page is gone, and the second has
to read the block back from disk before it can write its part: one read
per misaligned write.

Measured locally on XFS (emulated 4Kn NVMe, 4 KiB pages), 32 threads
writing interleaved records to one file with pwritev2(), 1 GiB per run,
before and after this patch:

  record  flags                     4 KiB device       MiB/s
  bytes                             reads per write
                                    before   after     before  after
  47008   RWF_DONTCACHE             0.97     0.000     831     2281
  47008   RWF_DONTCACHE|RWF_DSYNC   0.99     0.000     601     1227
  6000    RWF_DONTCACHE             0.97     0.000     121      488
  6000    RWF_DONTCACHE|RWF_DSYNC   0.99     0.000      90      206

Before this patch every write waited for its read, and because XFS holds
its IOLOCK exclusively across a buffered write, the other 31 writers
waited too: both record sizes ran at about 20 thousand writes a second,
one device read per write; after it nothing is read back.  With
RWF_DSYNC each write still waits for its own sync, so the gain is
smaller: the uncached write now runs as fast as the same write without
RWF_DONTCACHE, 1237 and 209 MiB/s against 1227 and 206 in the table.
Records of 49152 bytes, which cover only whole pages, read nothing
before or after.

NFSD DIRECT issues the misaligned ends of a WRITE as buffered uncached
segments and gains the same way.  Without any handling of the shared
page, 32 interleaved writers of 47008-byte records read 45144 blocks
for 45664 WRITEs; with this patch, and no NFSD code for the shared page,
0.0001 to 0.0008 blocks per WRITE whether each record is sent as one
FILE_SYNC WRITE, as two one after the other, as two together, or as two
UNSTABLE.  The page cache then marks the completed page while it is
still dirty, so each segment of a stable WRITE wakes the DONTCACHE
writeback kick (23 to 65 thousand rounds a run); the next two patches
let NFSD mark it after its sync instead.

Let the write path say which pages a write covers only partly
(FGP_DONTCACHE_EDGE, set by iomap when the write starts inside a page or
ends before its end) and get such a page as a single page.  A folio
created for it is not marked, so writing back this write's part does not
drop it.  A folio found uptodate is the neighbour's, already written:
this write completes it, so mark it, under the folio lock and before its
own data goes in, and the writeback that cleans both writes' data drops
it.  The folio lock orders the two writes, so the second always finds
the first's data in place.

A page whose neighbour never writes, such as the last page of a file,
stays cached until reclaim.  A partly covered page another task had
cached and that is uptodate is now dropped after the write's writeback,
where before an uncached write never dropped a page it did not create.

Only iomap file systems say which pages a write covers partly so far;
write_begin_get_folio() users such as ext4 and the NFS client do not.
With blocks smaller than a page, a write that crosses an extent boundary
inside a page asks for it as two partly covered halves, so the page,
though one write covers it whole, stays cached until reclaim.

Assisted-by: LLM
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/iomap/buffered-io.c  | 12 +++++++++++-
 include/linux/pagemap.h |  5 +++++
 mm/filemap.c            | 19 ++++++++++++++++++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a5ebfda90f1..780a0186045d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -802,8 +802,18 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
-	if (iter->flags & IOMAP_DONTCACHE)
+	if (iter->flags & IOMAP_DONTCACHE) {
 		fgp |= FGP_DONTCACHE;
+		/*
+		 * A page this write covers only partly is shared with a
+		 * neighbouring write: get it as a single page, which is
+		 * kept until the write that completes it.
+		 */
+		if (offset_in_page(pos) || len < PAGE_SIZE) {
+			fgp |= FGP_DONTCACHE_EDGE;
+			len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
+		}
+	}
 	fgp |= fgf_set_order(len);
 
 	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3012bd95812a..0c1d6bd09aa0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -701,6 +701,10 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_NOWAIT - Don't block on the folio lock.
  * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
  * * %FGP_DONTCACHE - Uncached buffered IO
+ * * %FGP_DONTCACHE_EDGE - With %FGP_DONTCACHE: the write covers this page
+ *   only partly, and a neighbouring write may complete it.  A folio created
+ *   for it is not marked drop-behind; a folio found uptodate is, as the
+ *   write that completes it.
  * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
  *   implementation.
  */
@@ -715,6 +719,7 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
 #define FGP_STABLE		((__force fgf_t)0x00000080)
 #define FGP_DONTCACHE		((__force fgf_t)0x00000100)
+#define FGP_DONTCACHE_EDGE	((__force fgf_t)0x00000200)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index ed7e4dbea653..0397ec771547 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2016,6 +2016,16 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 
 	if (fgp_flags & FGP_STABLE)
 		folio_wait_stable(folio);
+
+	/*
+	 * An uncached write that covers this folio only partly, finding it
+	 * uptodate, is the write that completes it: the neighbouring write
+	 * that left it here has written its part.  Mark it now, under the
+	 * folio lock, so the writeback that cleans both writes' data drops it.
+	 */
+	if ((fgp_flags & FGP_DONTCACHE) && (fgp_flags & FGP_DONTCACHE_EDGE) &&
+	    (fgp_flags & FGP_LOCK) && folio_test_uptodate(folio))
+		folio_mark_dropbehind(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
 		unsigned int min_order = mapping_min_folio_order(mapping);
@@ -2053,7 +2063,14 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 			/* Init accessed so avoid atomic mark_page_accessed later */
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
-			if (fgp_flags & FGP_DONTCACHE)
+			/*
+			 * A folio the write covers only partly is left
+			 * unmarked, so that writing back this write's part
+			 * does not drop it before a neighbouring write has
+			 * written the rest.
+			 */
+			if ((fgp_flags & FGP_DONTCACHE) &&
+			    !(fgp_flags & FGP_DONTCACHE_EDGE))
 				__folio_set_dropbehind(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
-- 
2.52.0

