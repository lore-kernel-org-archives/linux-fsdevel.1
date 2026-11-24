Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556068;
	b=c0xOth+leR+M3BiBrpljKQoWYstpElPMpocqKOqsmyboTI0MWBmlzjb72E4eW8lMg7EN
	 dB/kcUXtLjvfsKG6CPUT5Lint3PkVFDApiGYrCiaXbttTmBnCfpU34sWfSIFaeT5CLfEX
	 mHy+PJHIBMeN7izsNMsBgGAHRWZFYDJyy4t8d7Iqd7RVbVs0HwKYf8zy5of/2wQur88tv
	 cM/vT12SlhIh0MukgF9mLqvJjfRVjfqYIDVOA49i9vytnC+C+2cn4O04Qjep+aqZ4FA6i
	 ebfOk7liGL3Jg5TCN5jcgsJ8tn9kqYKhdqOX8x3yncrGoZ6J/+CXAiHETNwtPryFKww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=O9lMyeWaR2AVa49Y0bfc4zD6I2/RGDgVBYEZU7qaCoU=;
	b=gx1X1yDcQIkCoHdgXVh+iyx43cyGTGgDYGm6bDzxpG3nHdH/cUUesv89IPx0mRC+KGDX
	 xaG++B+N52h9oTeAn/LiRqiP8aM69UTQUx04igQHrSYtnJOli0KcXJqngW/yl5HXRvSif
	 nmBpPrnanb8L5Xvto0JB9XdFaPYRmCzWWYVHDHYK2VuqCLEafNK6iTZeFtlDKNPv0vDg1
	 aSBK2oG3ZYetgcgRvO675MkCe7kfI5P7DYh3/xyuqPmbxbKYqd4c0YDCBRyMbtfAL63t4
	 gc5320/5ghSYnlVri2Fxj6MD8qHo4wgAIy/kXDGz1arT4gze88+Yxmh4QZlWbmmp8Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YnA8H5mb;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9B606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 21:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC9B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YnA8H5mb
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38431138772so6467198eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 13:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556067; x=1796160867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O9lMyeWaR2AVa49Y0bfc4zD6I2/RGDgVBYEZU7qaCoU=;
        b=YnA8H5mbAb87huLraVdskBGdPTT/W3Qs8PqUBuSJEO5p9jqoLnCBe6TimVXsJE/luI
         CqmX+ZsW1ejQGYGkGq1rCauhmPrXsMcoQ92yJgCgGrhBeo2ewA9VcdH1lXPxeOAKZi+N
         Fwi/1uVNs5TrL5KTb7fBYO9i9RGbHPSNFoTmDhJzLS5W3Qxp4G1oZ5/Pgr4j+f7HUghl
         MjN1iF34nSV8JE9MO6X41gR+N9pdCjQMGKXcYk7qxLSDXhWGOtBtZ5FqIr+LAozV37HH
         t1oOx4phLeQMotl3A0RqAdrEvWEfsfmrAlNmeVd5ZIPi5ZRnwWU5bSa05Vc7cg91L00U
         qXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556067; x=1796160867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O9lMyeWaR2AVa49Y0bfc4zD6I2/RGDgVBYEZU7qaCoU=;
        b=R/RHB8+T0e5eo77cr7p2zPTJITZb0zUE/TUVI16Zf1jrhLohGQhbGEJJhYuUSVCCrJ
         oMndcX8n1xmYdTdPMQd595VULdKScBI9RK0d+0x+/E6ljjAuywgfRxwO0WUtX0nG6Opd
         OvWuQs7vDZwzY4Am3XwpO9cVJTx8yYYeVAT1X72z1TDLwyGTZe/8D0SkqjFYn488d1UT
         yXFd6yW0k/dakuUOgx8MajgMwOYhlk8AKmmYjQEZQOMROCJHUG4+lJxzWS0aBb0jhmLp
         Zvp5Yz+sK6iT9bMrSCHDe9FCtJWJ1EM92d0SPMxamDqJn7jrfYVmqI2ro0fUxwnUP2S8
         cL3g==
X-Gm-Message-State: APuU4Z9Z6Zpek1fDQ5xAlXTWmUKBH15rvVZfu1uQJ3uivg4Gn0kkIx/h
	IpSu2KWAuNCYj6uGg6dAZdQushUnurKyZyDyWcRugXcnXXm6AduabcgQoA8K61St
X-Gm-Gg: AZFdTZcKCFjwq3Rlqv/R9h8pz3pi2HG5BGw3Wx+C6H8fvYuGSwSSdVCJjiklp+8Nbc+
	uRlKJGK4ktKXVZ6h3b+doo6dsOs8FSAU7k5n9eSQhFw/XjMUn+Q+B8qOmpSJwCX8UN3bl2ICSdv
	K2Bhne+fdDBBhYHsxSqtonCxS5s2YuXiPirKNKLRoo8gzUOxtlmbITAA2NqKQjbEY3cCuEykIeO
	0azx2jXlGmR8c9NtsORPTG+qcwGkik1SvWHJ0MbbbnH5vR36JIymbSNWvIpVoASMJZk7ptP2Xax
	6jyQ6xczRVNv9mNSHNdBNZQODJV386OQSu0poExSpZqw3Qz81xPcX7OpwJCsGvv9kZ4OpEe84Bm
	Y9QbfMsGQcbs5LwNEg+ObTQPTSfEvvj9XqSSdxmVCLwSN9wjVc60zjScegrPk+k0/P9Q+ZBpql2
	huRBGdn0QH1e0tUXzrF1bepyGeNH8Z0BOZpES4picgGsg7EnO2tTdW6fw+SIY+hBXyvu+Oz5Zom
	vusx8Bp3xY5u3llFSoq+NUBpat0QnKzIx1rMSWVzYHQZXVY1gYlT6g9jt3gRacpSQTzG3rwd3Zk
	70xAaGwsIknx61ONef4CqssZMfgupM11lwR9Jlx+FUpuChX3B6cvdRGLDpGLe8T7F+2BfAfRW+K
	bnDvGpqxL1/WV
X-Received: by 2002:a05:7300:e91e:b0:384:2780:8757 with SMTP id 5a478bee46e88-38570a3e793mr18231095eec.22.1795556066685;
        Tue, 24 Nov 2026 13:34:26 -0800 (PST)
Received: from dev-oss-0.tail8d7c7c.ts.net (c-73-70-201-200.hsd1.ca.comcast.net. [73.70.201.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm49448857eec.6.2026.11.24.13.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:34:26 -0800 (PST)
From: Qian Xiao <heyheyco@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	Qian Xiao <heyheyco@gmail.com>
Subject: [PATCH] xarray: fix index jumping backwards in xas_find_marked()
Date: Tue, 24 Nov 2026 13:34:24 -0800
Message-ID: <20261124213424.2224554-1-heyheyco@gmail.com>
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
xas_find() does. Keep skipping sibling entries at the return site.

The userspace XArray test suite passed. The kernel was not built.

Fixes: b803b42823d0 ("xarray: Add XArray iterators")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qian Xiao <heyheyco@gmail.com>
---
 lib/test_xarray.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c      |  12 ++++--
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 615f7730a5bd..ddc392d42d29 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1316,6 +1316,109 @@ static noinline void check_multi_find_4(struct xarray *xa)
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
+out:
+	xa_destroy(xa);
+	XA_BUG_ON(xa, !xa_empty(xa));
+#endif
+}
+
 static noinline void check_find_1(struct xarray *xa)
 {
 	unsigned long i, j, k;
@@ -1440,6 +1543,7 @@ static noinline void check_find(struct xarray *xa)
 	check_multi_find_2(xa);
 	check_multi_find_3(xa);
 	check_multi_find_4(xa);
+	check_multi_find_marked_nonleaf(xa);
 }
 
 /* See find_swap_entry() in mm/shmem.c */
diff --git a/lib/xarray.c b/lib/xarray.c
index 48f440d114e1..4d943791a7b4 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1495,6 +1495,14 @@ void *xas_find_marked(struct xa_state *xas, unsigned long max, xa_mark_t mark)
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
@@ -1507,10 +1515,8 @@ void *xas_find_marked(struct xa_state *xas, unsigned long max, xa_mark_t mark)
 
 		if (!advance) {
 			entry = xa_entry(xas->xa, xas->xa_node, xas->xa_offset);
-			if (xa_is_sibling(entry)) {
+			if (xa_is_sibling(entry))
 				xas->xa_offset = xa_to_sibling(entry);
-				xas_move_index(xas, xas->xa_offset);
-			}
 		}
 
 		offset = xas_find_chunk(xas, advance, mark);
-- 
2.53.0

