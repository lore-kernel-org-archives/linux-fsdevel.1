Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425330;
	b=I+GJxei55qrEe1/xDANXqtSZX+V23v6M8riInaesuilpkbNt3XsAM6g3rxZ1HxhQtaFJ
	 4jsYwdqIWcnaSlhdm8eiqCQ+sa0GDLX3XwazQD2qDnAfAEoK9bOkS06aRSBwytX2orcFV
	 1Hg7fB8VpA2TZGcjrr7nHpud93d0KfTrlb4XT7KyZGsjCZd8J+0LEmBvfYlDWtkaA5yhy
	 U4BXtQ4GWnAIw3oGRYtVak2MC2ZXsPInpyxRBrkycj1/IvJJLytGs2mdVmOiKcCnlu6OL
	 HRcUUTsjlMbEmZSZhf3iw5II0/a/eyEvEbr+q9NzIsXtvjvG4iWNqacgQufsSpF6Rfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5QiqAXHt2Hqs0mxyFBDVb49lsswWbsrik6JHjFagC0E=;
	b=uYuZoMmF9Bs7i2ucsEPjS8X2VMpm/79eaU0Pbiej6b8YuMZsm/beCSl4IZYLgcwIw/gp
	 BzodvCh3f1SNfHOy/BWPxpe11Ra9LInw0HEY2RgGhTfpOW0U3cDFp6W8vIh+Qgg1nBHmR
	 rdoxqCQCEuzpqCWYV9pfqMJXyfYV4baqN7xyPZe45XTScYAR6yk3NW+/VZGfi69bHps19
	 KbYAwQ1k4GDS3uBe7bB1JPcT/PZBE+Lo5tZ/ti7jKywN/9CbYKP0BYAtvHNSjhHN9fRtv
	 VZ0yz+olqvQm4RCTx5TnIRRFLpG6jqX1N82YJbMEubct1KISvAkEzMysDEQ3wXuA5rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXosVCnm;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29A606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 09:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D29A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXosVCnm
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-382f4710a17so5229300eec.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 01:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795425328; x=1796030128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5QiqAXHt2Hqs0mxyFBDVb49lsswWbsrik6JHjFagC0E=;
        b=rXosVCnmkvQMppNL8dpOXhyAzDEi1IGOP1Nx3aBGlOPkY0cbK1y6eIGw8YSsw4YWwa
         1ptMwAxATLDGC5bQWLJtvxvDqB4BYH20JUrj67akh6uhInyajbXef6jplynZYq5UX6y+
         U3JamRm+sP+7OfnaTYC2SiwrmiimcfQxLy5Bkq6QZegq+1wbWUeKD2CPMvsrZnloQccu
         ngZUC30bVvRpoRPLbO1k1hn2H9ai93wC/IMod+rud+wlKQMKjUJoMfkykazDwcPXxOaB
         +19ddIUnPh/hV4alyMjT2AGM+nvWhRtLA5VplAgwtPHLxyVF8jEpeVMGY1UJMPdy788K
         10pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425328; x=1796030128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5QiqAXHt2Hqs0mxyFBDVb49lsswWbsrik6JHjFagC0E=;
        b=okGuT1n/U/7DNSpTIhXk68PxXzO3+YwtAxBOouwt9BKgibzzOKoqJOslBvFn7fSg+8
         sbb5Ucx4Uw0XTlJm43Dt8uNWRZcs/lQ54xmo/DEAw6v2AlJv0c5Jx2SZhxvS8h+6CekO
         dN7zGscdh6X0F/h4oym4SP/8mHKHCr7S/rN+jelMYXtWBPxqqXt22mT2AeJd4qniD/1M
         21mXBbADq2uiOlvOqxwZzqW6AslLjCpQ0wC9dZYeW7OMb45wp5wY66xQx+YaN8O7kBiI
         pVFlg0AuyclAe6foGeYvZjQjuFUDHDyXrjDAYj6/Y1+CCoVmLaxPLz/a4Rn3aAuqLDCK
         L18w==
X-Gm-Message-State: APuU4Z9foXwT0se9SfI1mZ9zxoPtJgDBI5Q2cYso376XDMQ19uCt7kxw
	mQEzGWlJu2XSLPfo59oqIbNWlID4V8Z1uoydgCjy8w+uhw56juI7yipzZoN5Cg==
X-Gm-Gg: AZFdTZcXPrpDbC5M40w5VxP6kcman7wFl7Xuap4iS6WjC9Szj5dkSUB0QPvfrbGMOgN
	+LKHC9sPw3laVN9yYgwcNV5ZueMdCHPatILxV5iJa+Mxr9zen005FO2JztVPzGxGpXUyRtvSveC
	t4PHbfqI399PItqigvZjk9g6g7hqjacQVQvVX7n901EwdLIJauJtMhuPlTaicidvY59SSfbblmE
	PpIWF7PUQot0E1LZeQoHGEFGHsbiyFcxtbn5bH3g8QnswRhP9G/IOcsMR5aCyVvUl9o5N9GLeTG
	+cvcuK4gP+h+WHgqJjFGChZoK+YHxP8BtI8PKlTvM6fReK+1fMY1fUFOIP46bBdhd1xDGap8xd2
	jsvGaZ8OgSpxPzejHZVPZnvHPDEWu2vj+i5GQJsbXzG8ZtxfMNKGd4X5IA7vnhlFB8ZrO4LgGYP
	gYLs0c/81VCtrDrmq138V+X8gOW1lGPq6Ak2YsV9dDMfr8AbOncZK3mCdivTVVmcjparP8QBYQC
	+dVHwSL6bceFz2rDp9KnFJ3DfwDnUmexr0WKg4swhxbJKKTOo6in/o2aWYpWy4T0bXryHi/Ev26
	Wkn+QoqygbBCYTs12FAX0B1nJVDYJzcTIhZcnfRrFg==
X-Received: by 2002:a05:693c:8803:20b0:386:9b9c:ef1b with SMTP id 5a478bee46e88-3869b9cf99amr6973944eec.3.1795425328281;
        Mon, 23 Nov 2026 01:15:28 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm33641787eec.15.2026.11.23.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:15:27 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] iomap: fix kernel-doc warnings in iomap.h
Date: Mon, 23 Nov 2026 09:15:23 +0000
Message-ID: <20261123091523.3976398-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
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

kernel-doc -Wall reports eight distinct warnings for include/linux/iomap.h,
each printed twice:

  struct member 'fbatch' not described in 'iomap_iter'
  struct member 'private' not described in 'iomap_iter'
  No description found for return value of 'iomap_length_trim'
  No description found for return value of 'iomap_length'
  function parameter 'iter' not described in 'iomap_iter_advance_full'
  No description found for return value of 'iomap_iter_advance_full'
  No description found for return value of 'iomap_iter_srcmap'
  No description found for return value of 'iomap_iter_next'

Document @fbatch (the batch of dirty folios iomap_zero_range() passes for
iomap_fill_dirty_folios() to fill) and @private (the file system's own
data, opaque to iomap), add the missing @iter to
iomap_iter_advance_full(), and add Return: sections.

iomap_iter_next() ended its description with "Returns 1 to continue
iterating, 0 once the range is fully consumed, or a negative errno on
error." without a colon, so kernel-doc found no return description.  Add
the colon, and say that 0 is also returned when the file system made no
progress without marking the mapping stale, as iomap_iter_continue() does.

Fix the two typos in the iomap_iter_srcmap() description, and the
&i->iomap that renders as a broken cross-reference, while there.

After:

  $ scripts/kernel-doc -Wall -none include/linux/iomap.h
  (no output)

No functional change.

The changelog and the added kernel-doc text were written with Hermes Agent
(deepseek-v4.1-flash); I reviewed them against the code and ran
kernel-doc -Wall on the file before and after.  No build was run, as only
comments change.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 include/linux/iomap.h | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 372453dbf2d4..c82608169077 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -259,6 +259,9 @@ struct iomap_ops {
  * @flags: Zero or more of the iomap_begin flags above.
  * @iomap: Map describing the I/O iteration
  * @srcmap: Source map for COW operations
+ * @fbatch: Optional batch of dirty folios for zero-range processing, set up
+ *	by iomap_zero_range() and filled by iomap_fill_dirty_folios()
+ * @private: File system specific data for this iteration; opaque to iomap
  */
 struct iomap_iter {
 	struct inode *inode;
@@ -282,8 +285,9 @@ int iomap_iter_advance(struct iomap_iter *iter, u64 count);
  * @pos: File position to trim from.
  * @len: Length of the mapping to trim to.
  *
- * Returns a trimmed length that the operation applies to for the current
- * iteration.
+ * Return: The length that the operation applies to for the current
+ * iteration: @len, limited to the end of the current mapping and, if
+ * @iter->srcmap is not a hole, to the end of the source mapping.
  */
 static inline u64 iomap_length_trim(const struct iomap_iter *iter, loff_t pos,
 		u64 len)
@@ -299,7 +303,9 @@ static inline u64 iomap_length_trim(const struct iomap_iter *iter, loff_t pos,
  * iomap_length - length of the current iomap iteration
  * @iter: iteration structure
  *
- * Returns the length that the operation applies to for the current iteration.
+ * Return: The length of the current iteration: @iter->len, limited to the end
+ * of the current mapping and, if @iter->srcmap is not a hole, to the end of
+ * the source mapping.
  */
 static inline u64 iomap_length(const struct iomap_iter *iter)
 {
@@ -308,6 +314,9 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
 
 /**
  * iomap_iter_advance_full - advance by the full length of current map
+ * @iter: iteration structure
+ *
+ * Return: Always 0.
  */
 static inline int iomap_iter_advance_full(struct iomap_iter *iter)
 {
@@ -319,9 +328,12 @@ static inline int iomap_iter_advance_full(struct iomap_iter *iter)
  * @i: iteration structure
  *
  * Write operations on file systems with reflink support might require a
- * source and a destination map.  This function retourns the source map
- * for a given operation, which may or may no be identical to the destination
- * map in &i->iomap.
+ * source and a destination map.  This function returns the source map
+ * for a given operation, which may or may not be identical to the destination
+ * map in ``i->iomap``.
+ *
+ * Return: The source map for the current iteration, or a pointer to
+ * ``i->iomap`` if there is no separate source map.
  */
 static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 {
@@ -350,7 +362,8 @@ int iomap_iter_continue(const struct iomap_iter *iter, struct iomap *iomap,
  * compile-time-constant @begin and @end callbacks, the compiler can call them
  * directly, avoiding the indirect-call overhead.
  *
- * Returns 1 to continue iterating, 0 once the range is fully consumed, or a
+ * Return: 1 to continue iterating, 0 once the range is fully consumed or the
+ * file system made no progress without marking the mapping stale, or a
  * negative errno on error.
  */
 static __always_inline int iomap_iter_next(const struct iomap_iter *iter,

base-commit: 4c7bbc7f82ff8820a4c9be8f662430bec640e2da
-- 
2.53.0

