Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711B42A80
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581335; cv=none; b=EiMJ3RRca0kU2fNpcHvlIEMW4gXLRqmM/hBd26+JS+Uqu2VE1d/5JkC2y1C0tmV+GxKYwnNV8KSi+wKQdDHoBeeEBlQkIuMqYbC60S2rLxfymfH5bNwcrnvyHeZwmnSJBJNdNJ2+Kl0F05oAdz1buuLl3gr5VJ11AiMCJSEZ0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581335; c=relaxed/simple;
	bh=TESRqTGVfnmU4E6qWyGcxMpTfLcGsEkW4/YgFf2xn5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBIxOlk5OK9jp999mqW8Oc3q/snPYsIJNShFo7HqRfCe+tVQwuRHeDtQd7SjheuQishJVoGFRhDFe3Sdt7Q939T+LAcpZQyrv+8Fc9YlUO/jpQBsvTFddeq9Dsas3phwxEQUFdPXZ7Yop9W0vjN2NcLKxaMbsMVcBo4eDEyBQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw8qLe1v; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw8qLe1v"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso7143044b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581333; x=1785186133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AK3CIUWgq5IKjQFOjGxJ82HDU1au+RQ9JUc17O6px88=;
        b=Xw8qLe1vkJgqvrOxyxsJcsMwcMzlr9qfcvSJMSZ2Pmy7MCEmCWikHeKcfTxvBWmInX
         ipdsFLnBPX4t/R11YdLcwtQtCFD4g/01xb7dMcdH2UrFKBEQHX6fLT0zMgZ43tjjnZJc
         RZzqLJOHvSwx7z2DwnIcA4pz3icrXBIGHVx6f707T76A4yICuQygLUYhNeFYAg++1MYD
         Z3D46H421HEZD/pxSElRYK4v60bafpNkui7pK0HOrYMoPTXWMvSjxTNC6Cd/fOEKZg4M
         gtw7Sjh70skwOsjx2s7oj+9aVxfwFYU6VOHAvji5Zu3FQThjrV43054+e4CgCGLXLBgU
         MRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581333; x=1785186133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AK3CIUWgq5IKjQFOjGxJ82HDU1au+RQ9JUc17O6px88=;
        b=XsmOjROoJ/bhoQ+aPe6h1YPj6RQPI+ZTjmx9tLn2ISx+c8BB4CoCcA3KGUkkU6xN9Y
         Qxk4Acgj+EAstsqiirItqI06W1PSRrWyYXqhTrOP2U+8Bn0YNuCBe2EM7PyfyF97pPAp
         frvcGffg8T4ZGcW2fPqADuD6pZQpOY7f+9dRvJSZNLViufy8OYmCdjY1dS5P1UEv2/zl
         1kLQGO9QdXwQPB0+dyc+mXjPs51asMLfI9s0+ufNc46acjDuycY5hqv4OSdtoEjmd2y3
         k7wwu+n4RyipJwFnySeJvhbXn/ZQO0sbOaY20NKlTA6rUBnKCmIRpJbV4P1Op3kFrCNM
         fWYw==
X-Forwarded-Encrypted: i=1; AHgh+RqkFA3VKa8pU1OTFLbiVx/0hnGDMFfqvRk2Cz/hYp2ujrWJ0yNFPSC5SI9UoyL7bK3W5T86J7q6CiuRGH7J@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1BUuE9kc2dhG/Zlqm09IzVH4Fs7+qPx6Jfy5Nu8bfmAb9mI5
	LnHhLUQqz7YN3SJGE9QNa+7E4IjO7PwmjNtdQnzZ1wLxDed41rmssbEK
X-Gm-Gg: AfdE7ckeM75ePkL/402ftJoZkqO0NiQ39JMywtpzGQ2MlPXpRp5ekJg5kQXeqhh2TSX
	kERmsiZgZXRHfIZj3RVVUXDGcyIoPlQ9w72i6zAK30RWzNB/twzGZ7t1M1eCuWiYyWNpeILTMtx
	DQw/35Lgts7i2i3f+YT9z9k42G3DqHZojGtlfBf7bxE7ckuJE4IlA0OdJ4sAnXbPzca+yvK9W+a
	MqTEA8ihkd7RVkxb/5XAo7YdEd5dhIaea3OcmJSlmVUdhCTdlVgGD915xPSr9VBl+Z3P/iQN8+t
	PCu3MUM+hiNToTeWfrcQ7S5ntpGMCe+KY85ykpnJFXUcHc7nCtQVj9xGwkNSpC85IoBPUmd30Tz
	wDm1GEofG3fj1z0KVkctvIZ4b/Gna0tzkLqUUE8WDjUTChOY09vENPV/UTuk+rgXW+VlfW04k9e
	IhgPHVHHPVSBP+GZGItsGlKEZdQD0C+CsrPNTHZzrUbkJBqultSLKHYP5uGWPzZHEs
X-Received: by 2002:a05:6a00:2383:b0:847:77e9:acbb with SMTP id d2e1a72fcca58-84c29238ddemr15421523b3a.13.1784581333130;
        Mon, 20 Jul 2026 14:02:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad89d0csm6293016b3a.6.2026.07.20.14.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:12 -0700 (PDT)
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
Subject: [PATCH v3 01/20] iomap: split iomap_iter() logic into iomap_iter_next()
Date: Mon, 20 Jul 2026 14:01:43 -0700
Message-ID: <20260720210202.1163861-2-joannelkoong@gmail.com>
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

In preparation for changing iomap to use an in-iter (->iomap_next())
model, move the iomap_iter() logic out into the new iomap_iter_next()
helper function.

iomap_iter_next() is added as an inlined helper so it can be called
directly by ->iomap_next() implementations where the begin()/end()
callbacks can be direct calls.

The DEFINE_IOMAP_ITER_NEXT() and DEFINE_IOMAP_ITER_NEXT_END() macros are
also provided to generate the boilerplate ->iomap_next() wrapper
functions that simply forward to iomap_iter_next() with the appropriate
begin/end callbacks. DEFINE_IOMAP_ITER_NEXT() is for the common case
where there is no end() callback. DEFINE_IOMAP_ITER_NEXT_END() is for
the case where there is an explicit end() callback.

No functional change intended. The only code-level difference is that on
the iomap_end() error path (ret < 0 && !advanced), the old code returned
with iter.status left as the caller's last value whereas the new code
zeroes it, but this is not observable in practice as there are no in-tree
callers that read iter.status after the iteration loop.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/iter.c       | 123 +++++++++++++++++++++---------------------
 include/linux/iomap.h | 102 +++++++++++++++++++++++++++++------
 2 files changed, 147 insertions(+), 78 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index e4a29829591a..66ccb87441ab 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -6,15 +6,6 @@
 #include <linux/iomap.h>
 #include "trace.h"
 
-static inline void iomap_iter_clean_fbatch(struct iomap_iter *iter)
-{
-	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
-		folio_batch_release(iter->fbatch);
-		folio_batch_reinit(iter->fbatch);
-		iter->iomap.flags &= ~IOMAP_F_FOLIO_BATCH;
-	}
-}
-
 /* Advance the current iterator position and decrement the remaining length */
 int iomap_iter_advance(struct iomap_iter *iter, u64 count)
 {
@@ -40,51 +31,28 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 }
 
 /**
- * iomap_iter - iterate over a ranges in a file
- * @iter: iteration structue
- * @ops: iomap ops provided by the file system
+ * iomap_iter_continue - decide whether iteration should continue
+ * @iter: iteration structure
+ * @iomap: the mapping that was just processed
+ * @srcmap: the source mapping that was just processed
  *
- * Iterate over filesystem-provided space mappings for the provided file range.
+ * Helper normally called via iomap_iter_next(). Called after the previous
+ * mapping has been finished to determine whether there is more of the file
+ * range left to process.
  *
- * This function handles cleanup of resources acquired for iteration when the
- * filesystem indicates there are no more space mappings, which means that this
- * function must be called in a loop that continues as long it returns a
- * positive value.  If 0 or a negative value is returned, the caller must not
- * return to the loop body.  Within a loop body, there are two ways to break out
- * of the loop body:  leave @iter.status unchanged, or set it to a negative
- * errno.
+ * Returns 1 if there is more work to do, in which case @iomap and @srcmap are
+ * cleared so the caller can produce the next mapping; zero if the range is
+ * fully consumed; or a negative errno on error. Any folio batch attached to
+ * the mapping is released before returning.
  */
-int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
+int iomap_iter_continue(const struct iomap_iter *iter, struct iomap *iomap,
+		struct iomap *srcmap, int ret)
 {
-	bool stale = iter->iomap.flags & IOMAP_F_STALE;
-	ssize_t advanced;
-	u64 olen;
-	int ret;
-
-	trace_iomap_iter(iter, ops, _RET_IP_);
-
-	if (!iter->iomap.length)
-		goto begin;
-
-	/*
-	 * Calculate how far the iter was advanced and the original length bytes
-	 * for ->iomap_end().
-	 */
-	advanced = iter->pos - iter->iter_start_pos;
-	olen = iter->len + advanced;
-
-	if (ops->iomap_end) {
-		ret = ops->iomap_end(iter->inode, iter->iter_start_pos,
-				iomap_length_trim(iter, iter->iter_start_pos,
-						  olen),
-				advanced, iter->flags, &iter->iomap);
-		if (ret < 0 && !advanced)
-			return ret;
-	}
+	const bool stale = iomap->flags & IOMAP_F_STALE;
+	const ssize_t advanced = iter->pos - iter->iter_start_pos;
 
-	/* detect old return semantics where this would advance */
-	if (WARN_ON_ONCE(iter->status > 0))
-		iter->status = -EIO;
+	if (ret < 0 && !advanced)
+		return ret;
 
 	/*
 	 * Use iter->len to determine whether to continue onto the next mapping.
@@ -92,25 +60,58 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	 * advanced at all (i.e. no work was done for some reason) unless the
 	 * mapping has been marked stale and needs to be reprocessed.
 	 */
-	if (iter->status < 0)
+	if (WARN_ON_ONCE(iter->status > 0))
+		/* detect old return semantics where this would advance */
+		ret = -EIO;
+	else if (iter->status < 0)
 		ret = iter->status;
 	else if (iter->len == 0 || (!advanced && !stale))
 		ret = 0;
 	else
 		ret = 1;
-	iomap_iter_clean_fbatch(iter);
-	iter->status = 0;
+
+	if (iomap->flags & IOMAP_F_FOLIO_BATCH) {
+		folio_batch_release(iter->fbatch);
+		folio_batch_reinit(iter->fbatch);
+		iomap->flags &= ~IOMAP_F_FOLIO_BATCH;
+	}
+
 	if (ret <= 0)
 		return ret;
 
-	memset(&iter->iomap, 0, sizeof(iter->iomap));
-	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
+	memset(iomap, 0, sizeof(*iomap));
+	memset(srcmap, 0, sizeof(*srcmap));
 
-begin:
-	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
-			       &iter->iomap, &iter->srcmap);
-	if (ret < 0)
-		return ret;
-	iomap_iter_done(iter);
-	return 1;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iomap_iter_continue);
+
+/**
+ * iomap_iter - iterate over ranges in a file
+ * @iter: iteration structure
+ * @ops: iomap ops provided by the filesystem
+ *
+ * Iterate over filesystem-provided space mappings for the provided file range.
+ *
+ * This function handles cleanup of resources acquired for iteration when the
+ * filesystem indicates there are no more space mappings, which means that this
+ * function must be called in a loop that continues as long it returns a
+ * positive value.  If 0 or a negative value is returned, the caller must not
+ * return to the loop body.  Within a loop body, there are two ways to break out
+ * of the loop body:  leave @iter.status unchanged, or set it to a negative
+ * errno.
+ */
+int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
+{
+	int ret;
+
+	trace_iomap_iter(iter, ops, _RET_IP_);
+
+	ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
+			ops->iomap_begin, ops->iomap_end);
+	iter->status = 0;
+	if (ret > 0)
+		iomap_iter_done(iter);
+
+	return ret;
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3582ed1fe236..3df851d0f76b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -212,24 +212,27 @@ struct iomap_write_ops {
 #define IOMAP_ATOMIC		(1 << 9) /* torn-write protection */
 #define IOMAP_DONTCACHE		(1 << 10)
 
-struct iomap_ops {
-	/*
-	 * Return the existing mapping at pos, or reserve space starting at
-	 * pos for up to length, as long as we can do it as a single mapping.
-	 * The actual length is returned in iomap->length.
-	 */
-	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
-			unsigned flags, struct iomap *iomap,
-			struct iomap *srcmap);
+/*
+ * Return the existing mapping at pos, or reserve space starting at pos for up
+ * to length, as long as we can do it as a single mapping.
+ * The actual length is returned in iomap->length.
+ */
+typedef int (*iomap_iter_begin_fn)(struct inode *inode, loff_t pos,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap);
 
-	/*
-	 * Commit and/or unreserve space previous allocated using iomap_begin.
-	 * Written indicates the length of the successful write operation which
-	 * needs to be commited, while the rest needs to be unreserved.
-	 * Written might be zero if no data was written.
-	 */
-	int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
-			ssize_t written, unsigned flags, struct iomap *iomap);
+/*
+ * Commit and/or unreserve space previously allocated by iomap_iter_begin_fn.
+ * Written indicates the length of the successful write operation which needs
+ * to be committed, while the rest needs to be unreserved.
+ * Written might be zero if no data was written.
+ */
+typedef int (*iomap_iter_end_fn)(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned flags, struct iomap *iomap);
+
+struct iomap_ops {
+	iomap_iter_begin_fn iomap_begin;
+	iomap_iter_end_fn iomap_end;
 };
 
 /**
@@ -317,6 +320,71 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 	return &i->iomap;
 }
 
+int iomap_iter_continue(const struct iomap_iter *iter, struct iomap *iomap,
+		struct iomap *srcmap, int ret);
+
+/**
+ * iomap_iter_next - finish the previous mapping and produce the next one
+ * @iter: iteration structure
+ * @iomap: mapping to finish and then repopulate
+ * @srcmap: source mapping to finish and then repopulate
+ * @begin: callback that produces a mapping for the current position
+ * @end: optional callback that finishes the previous mapping, or NULL
+ *
+ * Inline helper that implements the common body of an ->iomap_next()
+ * callback: it finishes the previous mapping via @end (if present), decides
+ * via iomap_iter_continue() whether to keep going, and obtains the next
+ * mapping via @begin.
+ *
+ * This helper is marked __always_inline so that when a caller passes
+ * compile-time-constant @begin and @end callbacks, the compiler can call them
+ * directly, avoiding the indirect-call overhead.
+ *
+ * Returns 1 to continue iterating, 0 once the range is fully consumed, or a
+ * negative errno on error.
+ */
+static __always_inline int iomap_iter_next(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap,
+		iomap_iter_begin_fn begin, iomap_iter_end_fn end)
+{
+	int ret = 0;
+
+	if (iomap->length) {
+		if (end) {
+			/*
+			 * Calculate how far the iter was advanced and the
+			 * original length bytes for end().
+			 */
+			ssize_t advanced = iter->pos - iter->iter_start_pos;
+			loff_t len;
+
+			len = iomap_length_trim(iter, iter->iter_start_pos,
+					iter->len + advanced);
+
+			ret = end(iter->inode, iter->iter_start_pos, len,
+					advanced, iter->flags, iomap);
+		}
+		ret = iomap_iter_continue(iter, iomap, srcmap, ret);
+		if (ret <= 0)
+			return ret;
+	}
+
+	ret = begin(iter->inode, iter->pos, iter->len, iter->flags, iomap,
+			srcmap);
+
+	return ret < 0 ? ret : 1;
+}
+
+#define DEFINE_IOMAP_ITER_NEXT_END(name, begin_fn, end_fn)		\
+int name(const struct iomap_iter *iter, struct iomap *iomap,		\
+		struct iomap *srcmap)					\
+{									\
+	return iomap_iter_next(iter, iomap, srcmap, begin_fn, end_fn);	\
+}
+
+#define DEFINE_IOMAP_ITER_NEXT(name, begin_fn)				\
+	DEFINE_IOMAP_ITER_NEXT_END(name, begin_fn, NULL)
+
 /*
  * Return the file offset for the first unchanged block after a short write.
  *
-- 
2.52.0

