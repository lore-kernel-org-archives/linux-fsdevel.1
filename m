Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1132315D43
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581337; cv=none; b=FHmZR+0PqM5pxDokNEhruo368sNLOmVzCs77bKzPE53TNjhZocM/7bIEtGSuqZhYYgJUtkfHyPtaV8CK5GoG56gKv2HI0Ckpn9NaBCVmSkbOByixrq7AypR6Og+4GOm7Zb/Ns8SMIxL7hMQlEZgEAQiirLWpXnx8HvefZt8FRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581337; c=relaxed/simple;
	bh=260nBa8OauKlkn4IJivJ6L/Ksp4wy8okbCE6Waa12Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX8EqzAOKRK95KYR9el3H7jYHMqKOECORIj2MxmInQaF8osrl6MnfS64am9sAVdvO88OJa0MSf4XXrHTzxx6gJZu8VKIgAVo++/TmOCTt0nqHIbRrfQyigKBSLRYLa+Cv0OFrXUwmDNdG1QJ+AskB48v0b+bZCbIiuQZ+EzApLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sx7LnWKS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx7LnWKS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ced3386430so68748555ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581335; x=1785186135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trj3xdGbo7vMPGhOQq9PJ6opHTw89qVUcWA3Blrn+6k=;
        b=sx7LnWKSSfEyglaif2J+umLiAPAVf28aZYQyPRo/7vL3YK38vlOHsUtN2gyKSoNJSe
         oQS7DK2YqYtnb9qUkfHMGrZEZ2+9gF8warVVtQCCqRZs4FUkQtsV3K57+f9mY4JWZVk4
         ONm2YlxYpxBV201xCFiPai/LeUdzX+hwHa/U5G1oDc+AizPqh5ZskQG6ZcencS9D3Pxy
         VivgkJVAUkEnsaiIBYh3O4zGK5KwXfXzs8+WdjjzottVm+KHcibLH+RXiAOa0nDDf5ve
         g2tzmJ3IpquP7RYY7nCAsS0VNYrLZmJx3b4v1SezwXLFRkxolGY4YYaZTK0Ir/VKTIb3
         AgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581335; x=1785186135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=trj3xdGbo7vMPGhOQq9PJ6opHTw89qVUcWA3Blrn+6k=;
        b=RsAlhKVJ7DsoVM4N1fW2WelrbGa9K/62wwpzXfhHQyDj53uZbL9nDuT2wiD03L76hb
         s3V1UZ7VwkAWu5ylHjBNGEEFUG+JSaY0uj9ChJDG+VZI7gDqLWL72mudnw89l7cXqVa6
         Z6EHu9nO+tNpJNnThyf8x6m7yAihH5VMaBTHmCyHXIadJKcWx2GsvqLRNUy9KAOEg8qb
         qW5aaIxeNpUPKgrO9Gg1QADfA3VJyXWvEh1p6YO20QRhAW6423FnM9u4DYBlSdi8AVV1
         uKrE9dSrb9zH5SWtiC6kGuZP0wFjNogEiMsjSKX/FN4EnbX/sO4GBak9gxGfCJJ7k2ub
         urjA==
X-Forwarded-Encrypted: i=1; AHgh+RqFgZMxPnLhGTzJ21vyzHZ55nfVjF2ZWbrsUGOgnpplN11GOpLGoz9VGq1ANnSBEBQTJ9cc9RTxr+a9Sbv7@vger.kernel.org
X-Gm-Message-State: AOJu0YzjukQa/gN9FJozXKVXCV6Q6Vglme2mXfrBq3MN/FKiN7L7qJJx
	8aYDEHZcUIWFsOXPHnjWdRuPVdqMZi3mZH2jlxPCEOPernkDuXQKjK0J
X-Gm-Gg: AR+sD13Vx6ePZYle+rjNAk8rEPjbqcO02/MADoMejzXOT0/K13He6K1FlK8/wK02peP
	8WBDf/EciSVjajgRgqziA3DN4504RY06WImGjaSzrlQV0t2air50VDtmVVf55XdLhKJBZP08gQZ
	D/qkMS00trq0TUkyTvjRidC5uxOu70EtDKpBrVh6lDxGagX69Yo7o9xHo8Z/xc0plTukdqw45K8
	KzJNqGIwT/10IeEJvfrHtBcSalAiaDaCVZP7Gx5/BzUO0AoAWvP2YcfHctxNmX1Yxs8i7hwKRBM
	P+b2GSCvZ2CYEDB4Sl2UaLL+5E11AgG+RERVnqaraOSca3S8gzKSW+FmHycvSxKOaGqDvZwC+UY
	yvxUp6YBI+HAxP2c57IJHRYHiNZSBV0RED5H+Bcr8yPQul8ebGVkJ/1lqxNyssm++5gSQ3W5ykO
	ZWEOjJlsX0esvhScaLwuZfCMCx/zW1VR4sFBPxsgOi7jOakCF/BweJFkq4XbrizfnG
X-Received: by 2002:a17:903:3d06:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2cf348034c3mr178142275ad.3.1784581334971;
        Mon, 20 Jul 2026 14:02:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3477eecdsm62571975ad.78.2026.07.20.14.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:14 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 02/20] iomap: add ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:44 -0700
Message-ID: <20260720210202.1163861-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have one ->iomap_next() callback instead of ->iomap_begin() and
->iomap_end(). ->iomap_next() finishes the previous mapping if needed,
and produces the next mapping.

Collapsing to a single callback lets a performance-critical caller
inline its iteration loop and pass its ->iomap_next() function as a
compile-time constant, so the compiler can devirtualize that callback
into a direct call instead of an indirect call through a function
pointer.

iomap_iter() uses ->iomap_next() when the filesystem provides that
callback and otherwise falls back to the ->iomap_begin()/->iomap_end()
path, so filesystems can be converted one at a time.

Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/direct-io.c  | 49 ++++++++++++++++++++++++++++++++-----------
 fs/iomap/iter.c       |  8 +++++--
 include/linux/iomap.h |  9 ++++++++
 3 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ca790239e5eb..a89c7c697c63 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -1000,6 +1000,21 @@ iomap_dio_simple_supported(struct kiocb *iocb, struct iov_iter *iter,
 	return true;
 }
 
+static inline void
+iomap_dio_simple_finish(struct iomap_iter *iomi, const struct iomap_ops *ops,
+		size_t len, size_t written)
+{
+	if (ops->iomap_next) {
+		iomi->iter_start_pos = iomi->pos;
+		iomi->pos += written;
+		iomi->len -= written;
+		ops->iomap_next(iomi, &iomi->iomap, &iomi->srcmap);
+	} else if (ops->iomap_end) {
+		ops->iomap_end(iomi->inode, iomi->pos, len, written,
+			       iomi->flags, &iomi->iomap);
+	}
+}
+
 /*
  * Fast path for small, block-aligned direct I/Os that map to a single
  * contiguous on-disk extent.
@@ -1062,11 +1077,25 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	inode_dio_begin(inode);
 
-	ret = ops->iomap_begin(inode, iomi.pos, count, iomi.flags,
-			       &iomi.iomap, &iomi.srcmap);
-	if (ret) {
-		inode_dio_end(inode);
-		return ret;
+	if (ops->iomap_next) {
+		ret = ops->iomap_next(&iomi, &iomi.iomap, &iomi.srcmap);
+		if (ret <= 0) {
+			inode_dio_end(inode);
+			/*
+			 * the first iteration must yield a mapping (>0) or an
+			 * error
+			 */
+			if (WARN_ON_ONCE(!ret))
+				return -EFAULT;
+			return ret;
+		}
+	} else {
+		ret = ops->iomap_begin(inode, iomi.pos, count, iomi.flags,
+				       &iomi.iomap, &iomi.srcmap);
+		if (ret) {
+			inode_dio_end(inode);
+			return ret;
+		}
 	}
 
 	if (iomi.iomap.type != IOMAP_MAPPED ||
@@ -1125,14 +1154,12 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 		WRITE_ONCE(iocb->private, bio);
 	}
 
-	if (ops->iomap_end)
-		ops->iomap_end(inode, iomi.pos, count, count, iomi.flags,
-			       &iomi.iomap);
+	iomap_dio_simple_finish(&iomi, ops, count, count);
 
 	if (!wait_for_completion) {
 		bio->bi_end_io = iomap_dio_simple_end_io;
 		submit_bio(bio);
-		trace_iomap_dio_rw_queued(inode, iomi.pos, count);
+		trace_iomap_dio_rw_queued(inode, iocb->ki_pos, count);
 		return -EIOCBQUEUED;
 	}
 
@@ -1144,9 +1171,7 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 out_bio_put:
 	bio_put(bio);
 out_iomap_end:
-	if (ops->iomap_end)
-		ops->iomap_end(inode, iomi.pos, count, 0, iomi.flags,
-			       &iomi.iomap);
+	iomap_dio_simple_finish(&iomi, ops, count, 0);
 	inode_dio_end(inode);
 	return ret;
 }
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 66ccb87441ab..e05574602946 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -107,8 +107,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
 
-	ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
-			ops->iomap_begin, ops->iomap_end);
+	if (ops->iomap_next)
+		ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
+	else
+		ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
+				ops->iomap_begin, ops->iomap_end);
+
 	iter->status = 0;
 	if (ret > 0)
 		iomap_iter_done(iter);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3df851d0f76b..74d79b963533 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -230,9 +230,18 @@ typedef int (*iomap_iter_begin_fn)(struct inode *inode, loff_t pos,
 typedef int (*iomap_iter_end_fn)(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned flags, struct iomap *iomap);
 
+/*
+ * Produce the next mapping (finishing the previous one if needed).
+ * Return 1 to continue iterating, 0 if the range is fully consumed, or a
+ * negative error on failure.
+ */
+typedef int (*iomap_iter_next_fn)(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap);
+
 struct iomap_ops {
 	iomap_iter_begin_fn iomap_begin;
 	iomap_iter_end_fn iomap_end;
+	iomap_iter_next_fn iomap_next;
 };
 
 /**
-- 
2.52.0

