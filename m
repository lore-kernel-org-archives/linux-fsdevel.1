Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818074;
	b=pe30/F4nr2dYye3cT/jGi+pKcVhaLbtb7dSNl+brPvRp4dt1tUOVCeFqBKtRs9nH662N
	 +NBXed59VJ4k/qaP5LFwGvjP5YZgRwkhyUhCf4MI+G2ADBB8togJAQ4ozC91ZgFgVY4mX
	 If95izZU2US0kDuL3R4Mc1zleI7hgEK6ZqIRG+GkCQcGL1yh0nEf9/PGUTSdONqtuAQnf
	 M2La7Mf+Ftnw25rufVXXmLrgwxY+z18rqUgJtptBLEKPOExyuWukJDX22fhGJMjAoBQEw
	 85tFXKdNNL8869sDFcahh5nfZXnTkjoYNn4QM04i+oXls9zeYcnZpXwHhdGACHLIIWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6Ad9yIn1xRY7zD6+qEAblcHr91kNMMVHlVCdY6zTmPc=;
	b=IsQJiorL86pU1VAr7woP1ULB3PYP4ImhHMlXa0Fbr0P/+6WW/fGQHX5y8qtdnmzWxHsz
	 5oLpyxfjkok/UNMCoVUPtXGHKPbB3ylsbfvh5Qrcfcv6tAd7VzXNM7KlmZ2Q3gQjtSR8L
	 PQIY7oT8kaq/SPUKmgT/iAxQjYpw8iFbuXUJdK2SPUYyUevLBFGMX6r3Ka6zB1ybecesT
	 +4f/IC5i4S/QafoT6fq9XNHxL9ZNHie+7U8mAkvSkDPL0lsTL+WDBXToGmZ0WgOOH5Zx4
	 EYrYp1CNv6b/JFQbuKz1JUppOIkxcna8PkSQ9uNbLh+Vll6WBUDQb0XjaXokh0Vim7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KYCWSQ7L;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D7606A31F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 22:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED4D7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KYCWSQ7L
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-386c336eab8so5010665eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795818073; x=1796422873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Ad9yIn1xRY7zD6+qEAblcHr91kNMMVHlVCdY6zTmPc=;
        b=KYCWSQ7LPLPh6fBbGVFq1yPzCWyI76zUzwN+5d6PZz3/O9ofneeyFKL3SZJYKBme0D
         pkcaxFF0lkfPIGFR3eJ6uJqEgGkKOPjstzree325WATBt4up++5k7iwy5kONY9uOUnvN
         I2y9KASTlXY85its5hioa90Hjwwh6jx2pAva8K9wybVKx0KAbhws3TT769bTiIAa/RZV
         KYGSyQkU0HZH53B4A3F2WsadzEMhSeHclG6Wvxy8PTRVOUWO+9NEvo0fiGwH+aiFQmnY
         wYoGXQ5AwH0bkcUnpoh/z33R/Y+MwzK2djPipeAoW0NSTpMWYfGEDDQVvH+r/Z99S4CZ
         CRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795818073; x=1796422873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Ad9yIn1xRY7zD6+qEAblcHr91kNMMVHlVCdY6zTmPc=;
        b=c/TzaCIut4X+2ZNrq0nDC7MlkAruB6M1/5oUJFZv8yDTSIoxvCOyrqfcSX6DJp6PiE
         kYrXBuh5e+Cv1sd+DFUStIJKJ+EAtEWZU4SOLmq0pxhBe9iDtJ8zbT4MxJjF+PknWjIN
         3wWEXJeWKLvc/blxcFYzdHxeaLD9FHQFX9McOTuqPT4m4rl2ecJTZMOkGe/WpLOi0LZe
         SJNNK1CoGzQ7z6Bxfq5QgTCE5GE5OPknYU4Y9sQMmtQRfxyEsolEKvREma3AXTAcrNqA
         sEORG1sc6CpNMki/Tih+B++uwMLgkwbAO2a+qo3UaGpM+Zl3ha9yKwLw8B7160NxYWcl
         M+lQ==
X-Gm-Message-State: APuU4Z+TX3R3tIkp7lgPaNfNAPyy/3FgvwwHlYWW6Usd/1yhWTJU9mqd
	FW0n1H4iUf2chWTrxPc5RDJoM+L92lHz87nEXwyRudj0mQEWXh12ekF1
X-Gm-Gg: AZFdTZdAk8RSGW0GrG3S5Ew5qJIQnu4z/vTbRZ5SvjiTIW2kNWIwL+QFaxYMwPnfvM9
	IHOKDezu8bUCCgMQm39AFHoGN4NGL5CCu6hbPn9DPmc+A84AZ18ZgaS4dgmnQbCDnVT9BXfHjFF
	sqJQu5bsh09NncW9SlJZxc5dyyB6wyltFErBKdwo4VDHlp4BFShwbu0+Dmq80fJctoARdEJkSU8
	CVwXEL/xQnH6wIp/go6luurq/XqocGUgikyvFcnR/9/Od01Bqx64v4RwrzCntR8B8qp+aE36weq
	oiePNGW9qNo586MLhhAKU7wYlhC6mFKUr+Vrjo6dMVbw2MlYxjSin0n6p2THkgtgpMb2FpvmY0K
	Josb3CEffoE2f3ITxwssPmcBWzI+O6KOACTDXq5EjVkiJWtJri/kYDU3DSVW0rvXKMUfLxgfX92
	kNGIzmzXfNP1rugofJY8gBxW6mkGPEcI2wv0Omgv+tbGEdoUt2105Dm7teLIqgGfA6/UKONM4i7
	9BwC4UmR9ENJd1oa6x2RWRnFPKR3tkuPTPt1BlB5FNzYHwglLWnjd2k0E7x1C3cbApNF/o13OLi
	abpfNRTGwcxgplGO9fjrrxpZgG24rrq+o5IWlKUhv486hhjjYKYtP1ORa1CkSQEIOssHXoxDpYh
	SLR8YFWhYXRA=
X-Received: by 2002:a05:7301:a0b:b0:386:a416:6c91 with SMTP id 5a478bee46e88-386a4166fdemr19591656eec.20.1795818072796;
        Fri, 27 Nov 2026 14:21:12 -0800 (PST)
Received: from dev-oss-0.tail8d7c7c.ts.net (c-73-70-201-200.hsd1.ca.comcast.net. [73.70.201.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm74080760eec.15.2026.11.27.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:21:12 -0800 (PST)
From: Qian Xiao <heyheyco@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	Qian Xiao <heyheyco@gmail.com>
Subject: [PATCH v3] xarray: fix index jumping backwards in xas_find_marked()
Date: Fri, 27 Nov 2026 14:21:09 -0800
Message-ID: <20261127222110.3755894-1-heyheyco@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126190847.3064508-1-heyheyco@gmail.com>
References: <20261126190847.3064508-1-heyheyco@gmail.com>
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

xas_find() keeps xa_index when a lookup starts inside a multi-index
entry stored in a non-leaf node, and aligns xa_offset with that index
before advancing. xas_find_marked() still does neither.

Walking from a sibling slot to the canonical slot calls
xas_move_index(), so a start index such as 127 becomes 0. After the
cursor has been walked, xa_offset can also stay on the canonical slot
while xa_index is inside a later slot of the same entry. The next
xas_find_marked() then recomputes xa_index from the stale offset. If
the entry is split, the call returns a marked entry below the index
already reached. xas_find() returns the following entry in the same
situation.

Resolve the sibling without moving xa_index. Before advancing a cursor
that has already been walked, set xa_offset from xa_index the same way
xas_find() does. xas_next_marked() uses that path when the offset and
index disagree, as xas_next_entry() already does. xas_pause() aligns
xa_offset before its existing calculation, so the resume index stays at
the end of the entry.

If the tree changes while a sibling is being resolved, do not descend
into a node that does not contain xa_index, and do not move xa_index
backwards. Compare the next marked slot with get_offset() instead of
recomputing xa_index with a 32-bit shift. Return XA_RETRY_ENTRY.
xa_find_after() handles that retry before xas_sibling(), so a rewind
that then retries restarts the walk. Callers that use xas_retry()
restart from the same index.

The userspace XArray test suite passed. The kernel was not built.

Fixes: b803b42823d0 ("xarray: Add XArray iterators")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qian Xiao <heyheyco@gmail.com>
---
v3:
- Compare the next marked slot with get_offset() instead of shifting
  in 32-bit arithmetic.
- Handle XA_RETRY_ENTRY in xa_find_after() before xas_sibling().

v2:
- Use the slow path in xas_next_marked() when the offset and index disagree.
- Align xa_offset in xas_pause() so the resume index stays at the end of
  the entry.
- Return XA_RETRY_ENTRY when a concurrent change would descend into the
  wrong node or decrease xa_index.

 include/linux/xarray.h |   3 +-
 lib/test_xarray.c      | 165 +++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           |  24 ++++--
 3 files changed, 186 insertions(+), 6 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..8c42d899d94c 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1778,7 +1778,8 @@ static inline void *xas_next_marked(struct xa_state *xas, unsigned long max,
 	void *entry;
 	unsigned int offset;
 
-	if (unlikely(xas_not_node(node) || node->shift))
+	if (unlikely(xas_not_node(node) || node->shift ||
+			xas->xa_offset != (xas->xa_index & XA_CHUNK_MASK)))
 		return xas_find_marked(xas, max, mark);
 	offset = xas_find_chunk(xas, true, mark);
 	xas->xa_offset = offset;
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 615f7730a5bd..02e6843d0227 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1316,6 +1316,170 @@ static noinline void check_multi_find_4(struct xarray *xa)
 #endif
 }
 
+static noinline void check_multi_find_marked_nonleaf(struct xarray *xa)
+{
+#ifdef CONFIG_XARRAY_MULTI
+	unsigned int order = XA_CHUNK_SHIFT + 1;
+	unsigned long next = 1UL << order;
+	unsigned long start = next - 1;
+	XA_STATE(xas, xa, start);
+	XA_STATE_ORDER(split, xa, 0, 0);
+	void *entry;
+	unsigned long i;
+
+	/* Multi-index entry in two slots of a non-leaf node, both marked. */
+	xa_store_order(xa, 0, order, xa_mk_index(0), GFP_KERNEL);
+	xa_set_mark(xa, 0, XA_MARK_0);
+	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+	xa_set_mark(xa, next, XA_MARK_0);
+
+	rcu_read_lock();
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != xa_mk_index(0));
+	XA_BUG_ON(xa, xas.xa_index != start);
+
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != xa_mk_index(next));
+	XA_BUG_ON(xa, xas.xa_index != next);
+
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != NULL);
+	rcu_read_unlock();
+
+	xa_destroy(xa);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* Split the multi-index entry after a lookup begins inside it. */
+	xa_store_order(xa, 0, order, xa_mk_index(0), GFP_KERNEL);
+	xa_set_mark(xa, 0, XA_MARK_0);
+	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+	xa_set_mark(xa, next, XA_MARK_0);
+
+	xas_set(&xas, start);
+	rcu_read_lock();
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != xa_mk_index(0));
+	XA_BUG_ON(xa, xas.xa_index != start);
+	rcu_read_unlock();
+
+	xas_split_alloc(&split, xa_mk_index(0), order, GFP_KERNEL);
+	if (xas_error(&split)) {
+		XA_BUG_ON(xa, true);
+		goto out;
+	}
+	xas_lock(&split);
+	xas_split(&split, xa_mk_index(0), order);
+	for (i = 0; i < next; i++)
+		__xa_store(xa, i, xa_mk_index(i), 0);
+	xas_unlock(&split);
+
+	rcu_read_lock();
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != xa_mk_index(next));
+	XA_BUG_ON(xa, xas.xa_index != next);
+
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != NULL);
+	rcu_read_unlock();
+
+	xa_destroy(xa);
+
+	/* Nothing marked past the index already walked. */
+	xa_store_order(xa, 0, order, xa_mk_index(0), GFP_KERNEL);
+	xa_set_mark(xa, 0, XA_MARK_0);
+	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+
+	xas_set(&xas, start);
+	rcu_read_lock();
+	entry = xas_load(&xas);
+	XA_BUG_ON(xa, entry != xa_mk_index(0));
+	XA_BUG_ON(xa, xas.xa_index != start);
+	rcu_read_unlock();
+
+	xas_set(&split, 0);
+	xas_split_alloc(&split, xa_mk_index(0), order, GFP_KERNEL);
+	if (xas_error(&split)) {
+		XA_BUG_ON(xa, true);
+		goto out;
+	}
+	xas_lock(&split);
+	xas_split(&split, xa_mk_index(0), order);
+	for (i = 0; i < next; i++)
+		__xa_store(xa, i, xa_mk_index(i), 0);
+	xas_unlock(&split);
+
+	rcu_read_lock();
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != NULL);
+	rcu_read_unlock();
+
+	xa_destroy(xa);
+
+	/* Pausing resumes at the next marked entry, without repeating. */
+	xa_store_order(xa, 0, order, xa_mk_index(0), GFP_KERNEL);
+	xa_set_mark(xa, 0, XA_MARK_0);
+	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+	xa_set_mark(xa, next, XA_MARK_0);
+	xas_set(&xas, start);
+	rcu_read_lock();
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != xa_mk_index(0));
+	XA_BUG_ON(xa, xas.xa_index != start);
+	xas_pause(&xas);
+	XA_BUG_ON(xa, xas.xa_index != next);
+	entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+	XA_BUG_ON(xa, entry != xa_mk_index(next));
+	XA_BUG_ON(xa, xas.xa_index != next);
+	rcu_read_unlock();
+
+	xa_destroy(xa);
+
+	/*
+	 * A leaf multi-index entry.  The next step must not use a canonical
+	 * slot left behind by the first lookup.
+	 */
+	if (XA_CHUNK_SHIFT > 2) {
+		unsigned int leaf_order = 2;
+		unsigned long leaf_next = 1UL << leaf_order;
+		unsigned long leaf_start = leaf_next - 1;
+
+		xa_store_order(xa, 0, leaf_order, xa_mk_index(0), GFP_KERNEL);
+		xa_set_mark(xa, 0, XA_MARK_0);
+		XA_BUG_ON(xa, xa_store_index(xa, leaf_next, GFP_KERNEL) != NULL);
+		xa_set_mark(xa, leaf_next, XA_MARK_0);
+
+		xas_set(&xas, leaf_start);
+		rcu_read_lock();
+		entry = xas_find_marked(&xas, ULONG_MAX, XA_MARK_0);
+		XA_BUG_ON(xa, entry != xa_mk_index(0));
+		XA_BUG_ON(xa, xas.xa_index != leaf_start);
+		rcu_read_unlock();
+
+		xas_set(&split, 0);
+		xas_split_alloc(&split, xa_mk_index(0), leaf_order, GFP_KERNEL);
+		if (xas_error(&split)) {
+			XA_BUG_ON(xa, true);
+			goto out;
+		}
+		xas_lock(&split);
+		xas_split(&split, xa_mk_index(0), leaf_order);
+		for (i = 0; i < leaf_next; i++)
+			__xa_store(xa, i, xa_mk_index(i), 0);
+		xas_unlock(&split);
+
+		rcu_read_lock();
+		entry = xas_next_marked(&xas, ULONG_MAX, XA_MARK_0);
+		XA_BUG_ON(xa, entry != xa_mk_index(leaf_next));
+		XA_BUG_ON(xa, xas.xa_index != leaf_next);
+		rcu_read_unlock();
+	}
+
+out:
+	xa_destroy(xa);
+	XA_BUG_ON(xa, !xa_empty(xa));
+#endif
+}
+
 static noinline void check_find_1(struct xarray *xa)
 {
 	unsigned long i, j, k;
@@ -1440,6 +1604,7 @@ static noinline void check_find(struct xarray *xa)
 	check_multi_find_2(xa);
 	check_multi_find_3(xa);
 	check_multi_find_4(xa);
+	check_multi_find_marked_nonleaf(xa);
 }
 
 /* See find_swap_entry() in mm/shmem.c */
diff --git a/lib/xarray.c b/lib/xarray.c
index 48f440d114e1..9f29a064849f 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1283,6 +1283,9 @@ void xas_pause(struct xa_state *xas)
 	if (xas_invalid(xas))
 		return;
 
+	if (node && xas->xa_offset != get_offset(xas->xa_index, node))
+		xas->xa_offset = get_offset(xas->xa_index, node);
+
 	xas->xa_node = XAS_RESTART;
 	if (node) {
 		unsigned long offset = xas->xa_offset;
@@ -1495,6 +1498,14 @@ void *xas_find_marked(struct xa_state *xas, unsigned long max, xa_mark_t mark)
 		xas->xa_offset = xas->xa_index >> xas->xa_node->shift;
 	}
 
+	if (advance &&
+	    xas->xa_offset != get_offset(xas->xa_index, xas->xa_node)) {
+		if (!xas->xa_node->shift)
+			xas->xa_offset = ((xas->xa_index - 1) & XA_CHUNK_MASK) + 1;
+		else
+			xas->xa_offset = get_offset(xas->xa_index, xas->xa_node);
+	}
+
 	while (xas->xa_index <= max) {
 		if (unlikely(xas->xa_offset == XA_CHUNK_SIZE)) {
 			xas->xa_offset = xas->xa_node->offset + 1;
@@ -1507,14 +1518,14 @@ void *xas_find_marked(struct xa_state *xas, unsigned long max, xa_mark_t mark)
 
 		if (!advance) {
 			entry = xa_entry(xas->xa, xas->xa_node, xas->xa_offset);
-			if (xa_is_sibling(entry)) {
+			if (xa_is_sibling(entry))
 				xas->xa_offset = xa_to_sibling(entry);
-				xas_move_index(xas, xas->xa_offset);
-			}
 		}
 
 		offset = xas_find_chunk(xas, advance, mark);
 		if (offset > xas->xa_offset) {
+			if (offset <= get_offset(xas->xa_index, xas->xa_node))
+				return XA_RETRY_ENTRY;
 			advance = false;
 			xas_move_index(xas, offset);
 			/* Mind the wrap */
@@ -1532,6 +1543,8 @@ void *xas_find_marked(struct xa_state *xas, unsigned long max, xa_mark_t mark)
 			continue;
 		if (!xa_is_node(entry))
 			return entry;
+		if (xas->xa_offset != get_offset(xas->xa_index, xas->xa_node))
+			return XA_RETRY_ENTRY;
 		xas->xa_node = xa_to_node(entry);
 		xas_set_offset(xas);
 	}
@@ -2258,12 +2271,13 @@ void *xa_find_after(struct xarray *xa, unsigned long *indexp,
 		else
 			entry = xas_find(&xas, max);
 
+		if (xas_retry(&xas, entry))
+			continue;
 		if (xas_invalid(&xas))
 			break;
 		if (xas_sibling(&xas))
 			continue;
-		if (!xas_retry(&xas, entry))
-			break;
+		break;
 	}
 	rcu_read_unlock();
 
-- 
2.53.0

