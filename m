Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0F349CFD
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337396; cv=none; b=gwv2ECwIMRI2kAYy2HK9e/FcgorasyKOh/KE1ptXYRaxdzfJyuucwlPPXVgPm14U9sIyio8AR16zTFazTtd9hd/aUhuucCSd5MHfkx49ti4spXZxtrkERtjaT/fYA9ZrzqGAxirMPUma+5/vfckuCfW4Zc07V3bdqMWWxu5++HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337396; c=relaxed/simple;
	bh=r0p2adqwMj/5lT7C+TYVmZHcVYZ+gdU2HSJ4o7+sSAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnfJeeeAhdBwu2sn8G6yBFPS0vPBf5ybfglSGbrFccyw2L6yDdt3IMYzEloJ3TKMzzpYXno2eNvrLt9OpNSx5lz6QmpxwLTZoIbHBwOhyN13+xqlA445Grn1R4RCP4uqS3xYLIxcCNqnliqXUUt1QNbymr6rdtAiknFGu61NRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhhQVTXv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhhQVTXv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso33741895e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337392; x=1791942192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=;
        b=GhhQVTXvY202l3e+Oje/xWWNMLai8qPWiyR3saei7h3jpT2tqtn2VxwYqjULPuJDk0
         r6NJeypG8ebTuze5EDXJz/4UXDeVfMJszECurDvgiGTZ8KpExI1LjQoIUx3+vo/rRrWw
         MRvi+lT+bXSPgd7/sMODvQVvilfcdXu1bU9ijxVRqu4LJcMnPoDbP1T6QY2Dn12ekzfu
         mZ80+jS5PIsyAphaBmt6wDM7OzK9s87WeplsHzt2u8BN5tU7iqZwbPruNv/qDNEcZfXs
         fcloDN1R79Beh0UJYrwQoAlZUmdBOfUegsdCmVki+pTY8eFshzm39KUMutEu6DJitbWh
         aIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337392; x=1791942192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2SC7dcI1Y+PPMkABrALMaBjWk253olXayI/6F0cq90=;
        b=RTsZikryW2DFlSg9S6cxOZ+J1kOflPWg1DCylkbXpnjJRDxCbQTQYox/hsY6YKpAYC
         IeNpYLvz9w3tFC8Xe22nvvxtxz1daKvvFbZ2GFO11TY7lGfpAMIZQ99WH/KVVvzOLmk2
         9YgV7EawcA0knpYWbEtRX593xhpE3Y+jiroAagYlFUdsUzjSBgjJ8PjGT7s+T01X6r97
         MU8yAc+M8AMaLVug5UHgLhnK7A9ecDMW20HBahclAxnmeA41yS7sVi0rKQR8EnZnp+6Q
         3RK7PXcOa4ygLQK0wIlf6/pH8AKGwlcnBmqjnObnmstGiq/z0L2IC77A4HRh3liBu44f
         3vtg==
X-Forwarded-Encrypted: i=1; AKwUvBwAAQVS3Qol5EsFRW3iwOqR9h3aFdzJv87+4rf95byCIqSw+OEJ12fd+wTCNjrsPAQCcHYI51kpVx/BKN2Q@vger.kernel.org
X-Gm-Message-State: AFuF++mVt1zymznUTenqY9QYj/mTSDCmrU7TxG+P1OuSLLB/dEqgYCqH
	RPLhHk1x/s32MO9WCOcYF024LgCvTB17tGZoyt1jHyJl8O18Ceki+lxF
X-Gm-Gg: AYBFou2Pje0+4qmeSGwibQ5MmnGygxvRC286K5bJVNFA1nNDpenQdNNV9PLlwCu3Tq4
	3YdbivpZU4YVafdI8jyw5m772P23dIR2ZOPxqg8uNkemFoxkBEhfu3fH59SAzue9rfUFFT5fN0m
	8EO82YO04HBiEgqZwAc509nk3tmLnGgCbilh5dboZeD/9Y2I6OxNHudH+IGl3tAMs5XFt8+7v8I
	cn+mI5iPS7VeEtdSsyYioJ3GshAv3HiznCgjr0DrW++0OlK1suqKM+w0mfSwSrWNoewdzOPrpNv
	JYCPJNBIdeigW67hzOPnEOvJBa9buV8fdZuRD6PRl24RNj5yBPX0uioHlUuZJXm1vm3voVxL7oe
	hP8HxjjTIO3sRH4lUbxyZB7yR9V3uEe48OEEBt75X5QgyOFJdbsC9AAvExhT+6bq/tNDKP70qTj
	UYDvXop6up19w4jxUh7h9+ra7NFwLhZKOT/XOvI/kvUVK+TEly/EZC9+qAwb1vwuYU2kpdKnzew
	OaAxpBl2oWWsFPR2iH/RUbE8z2Jir5N9SNnsjYIJhalg+4B5Dg9rbNleuvWLMjfeKvJyWb6d489
X-Received: by 2002:a05:600d:82e3:b0:4a1:7f8e:6e6c with SMTP id 5b1f17b1804b1-4a18042351amr7480995e9.5.1791337392295;
        Tue, 06 Oct 2026 18:43:12 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:11 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v9 02/13] iov_iter: add iterator type for dmabuf maps
Date: Wed,  7 Oct 2026 02:42:45 +0100
Message-ID: <c6259482b609b9c98c74cedcc2d600774e2ac3a4.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new iterator type for dmabuf maps. The map in an opaque
object with internals and format specific to the subsystem / driver, and
only it can use that subsystem / driver for issuing IO. The task of the
middle layers is to pass the map / iterator further down, maybe doing
basic splitting and length checking. The iterator can only be used by
operations of the file the associated map was created for.

Suggested-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/iov_iter.h |  2 ++
 include/linux/uio.h      | 11 +++++++++++
 lib/iov_iter.c           | 29 +++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index f9a17fbbd398..2f91884d733b 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -310,6 +310,8 @@ size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
+	if (WARN_ON_ONCE(iov_iter_is_dmabuf_map(iter)))
+		return 0;
 	return iterate_discard(iter, len, priv, priv2, step);
 }
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index fe2e985d74d2..638c1116e912 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -12,6 +12,7 @@
 
 struct page;
 struct folio_queue;
+struct dma_buf_io_map;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -29,6 +30,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMABUF_MAP,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +73,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct dma_buf_io_map *dmabuf_map;
 			};
 			size_t count;
 		};
@@ -155,6 +158,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dmabuf_map(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMABUF_MAP;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -300,6 +308,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			struct dma_buf_io_map *map,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2072c04e99d0..6831a5d9396e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
+	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
+	    unlikely(iov_iter_is_dmabuf_map(i))) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
@@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
+	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
+	    iov_iter_is_dmabuf_map(i)) {
 		BUG(); /* We should never go beyond the start of the specified
 			* range since we might then be straying into pages that
 			* aren't pinned.
@@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			 struct dma_buf_io_map *map,
+			 loff_t off, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMABUF_MAP,
+		.data_source = direction,
+		.dmabuf_map = map,
+		.count = count,
+		.iov_offset = off,
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -856,7 +872,7 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 		return iov_iter_alignment_bvec(i);
 
 	/* With both xarray and folioq types, we're dealing with whole folios. */
-	if (iov_iter_is_folioq(i))
+	if (iov_iter_is_folioq(i) || iov_iter_is_dmabuf_map(i))
 		return i->iov_offset | i->count;
 	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
@@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return 0;
 
 	if (WARN_ON(!iter_is_iovec(i)))
@@ -1469,11 +1485,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dmabuf_map(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return;
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
-- 
2.54.0

