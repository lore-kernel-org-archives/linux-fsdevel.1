Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605197;
	b=pwliVGOhaaQzCYw+gMD8kzEAgyZxQcCjRnLhzTla8VIEv9dT0lKlfsZmQZudtXnvZwva
	 ih9kVFzCLVnZUOFvrKvIGZD4lGOrDKq/4WQH27H92xYJloyu4OWymBEPP/rheIGLSHEym
	 +r8f1wabLWjuQVBIZryAagVlkQje1an3mXth6u238EZudsntj2G4ttbqKRk4t1Yfw9+33
	 wqNQPYiX8A82hI+lf8xg+V+82sCXcTshxL0xGuNbZ/u3TlGJGYS82zIVRtKjA4mRzzwXI
	 2wib1oT8Q+nT2GUqlLq8Om51DQKFoR0SY+LsKcVDAxquNV4ZJEh3RcvGkBaNnIr+70Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605197;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E8yCXp8faGSQwgD+KEglK48bXByCKj/OR8JWpMaiRFw=;
	b=1uo8JUOpHJhwU/hK5ZyqqixCjqcZtSUzm1Yf+Q7TeYcxWYNQ/ssX6ZQsUge3XcurgKbj
	 xbKK30inL9ke0nR3xiXhImQYdMqSCOOB05zh49ZYs/iUg1imGniY5zFVKHLZtwXgJgVY+
	 a2xEJ1OfPI2f/7xCThPS4ryS15Gbx3i1QUDpqw25LGBWWwtJs5m7wOhEM8CoaAd4r07V2
	 GmYp1EbyIE3oWIgojAgAhKaTPVknfD3GePIqwowbRLc7sPDcJGG8pUHXgR5MF9H7BIbeg
	 0o4eKtvhyH/h3UXoTDIaVrJAD+RemJN1Rvy8eA0u3h4P0J3457tY4//w8WGTULnivXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1gtGWuH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9F606A332;
	Fri, 13 Nov 2026 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1gtGWuH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605197;
	b=a697GhvWXyWYo62oODXnwbBQOUtmrcRFi48G9JCW96l1OpieO+XnKIFXdzJ/aJBhwXh0
	 oeFemGp5rGUMi9GzAUq7ynbOjsalS6g/k46lb8ZeijRgPs5nGRKftVYidkcXnvRd2cKsY
	 TZ+nQI7b2+EZQY4Tq7bCdAAEWdDXhs6RhSyOjr+nDhTlTqR8q7xMbX2+ZMrMfKpIVRoGG
	 DeiSmAOhoea4pNeMFS/37mU/wPHEkwA5w+00qf1IC8VNPs8GnVa21OcP1xsUpO7KxRwUK
	 ZxmVWpt+IKCSaeLRlTLjw1vf5AWphf5G9uGWei+A5yeqauada5ThYrRTPpUxevV7l4w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605197;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E8yCXp8faGSQwgD+KEglK48bXByCKj/OR8JWpMaiRFw=;
	b=e18Ixe42YfyNxK32sgeaciGU92dKM/AzgzLWi9SMng9lh2CpYPQEzpmuI2MIdTZRgayE
	 ec+xuLiplkTQhJMMFlFBsHJv1NPhu6mCb4G47Uz5ZqJ1d2CKbmGLhepDWKYh6u5qC7V/T
	 wDdAfrVJjJzTFwF594uKDbYhwnw9A1N0Po2TSI0q7twRU3TaBr088wqBmedQ9yL1nf4d4
	 SDv96IrQDv5G5L2vYwBiwmyeMEYic0+rTMYHr16hq6ueisvIfXpyL5LKyCgd3ylhovV8O
	 DeVL4fWxDr/MFXiGZPItpDX6DHbsmlWgZWH4RM7RRkwKrRxzBjGfbFV5Ld8H9GsxfrQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7707D1F000C6;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605197;
	bh=E8yCXp8faGSQwgD+KEglK48bXByCKj/OR8JWpMaiRFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=L1gtGWuHMldpnkv1B2eRqRSgMVyDyp6RKjdRYbOYqRBauBvsYdpbzzUonAeO18572
	 EC5QuTdn0cL7c6+/RQF3txYeFEWwGb0HcvPnPKHq0CHl3A+CzlVd8VzBix8YvVm00o
	 TKID0ahqEqnj7lA88M/nu3KNXoNyn+f/8KoVoSjcPYaU51JkVJkNSjgdRJMSK73Xmn
	 /FV256jN942QZnT2jPEu5XMYKB36oUTKjfUm4QREMSzIprYO9h5mj5sCGIrynhqwfR
	 6S1knQWqO7Q5kwO8Li1Y5bypWZTQQTIye3grqMNTJ8hC+OLL2XRQUNWQX+4nAshgK+
	 SOWBjc6r1xu5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 039D949B16;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sat, 14 Nov 2026 05:26:18 +0800
Subject: [PATCH RFC 2/8] xarray: add xas_prev_canonical()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-swap-thp-split-v1-2-dfa8d4fa448d@tencent.com>
References: <20261114-swap-thp-split-v1-0-dfa8d4fa448d@tencent.com>
In-Reply-To: <20261114-swap-thp-split-v1-0-dfa8d4fa448d@tencent.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=8119;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=F1Xh8X4E0iUXFanXwmpaX6dnEVbj5dOQIdvLxxlmNoQ=;
 b=l5BlWayWK/H3mc/6q/UJE4gWzCpMxj2+G0VExlA1+S1X0md5aFyGgy37Sayjtiec9Kjgx0f8C
 etPS5lgKfU/BWase7XmBFH+du30T8Fs+gRYkvZo1+UtwN/H3Wep4hfG
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

xas_prev() moves one index at a time, so stepping backwards into a
multi-index entry can stop on a sibling slot. The new xas_prev_canonical()
steps back over an entry as a whole: it leaves the state on the slot
holding the entry and on the first index that entry covers, so
xas_get_order() also reports its order.

A cursor already inside an entry reports it instead of stepping off.

Cover it in the test suite too.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/xarray.h | 49 +++++++++++++++++++++++++
 lib/test_xarray.c      | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           |  8 -----
 3 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index be850174e802..b76d24e7a46b 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1502,6 +1502,15 @@ static inline bool xas_top(struct xa_node *node)
 	return node <= XAS_RESTART;
 }
 
+/* Move the index either forwards (find) or backwards (sibling slot) */
+static inline void xas_move_index(struct xa_state *xas, unsigned long offset)
+{
+	unsigned int shift = xas->xa_node->shift;
+
+	xas->xa_index &= ~XA_CHUNK_MASK << shift;
+	xas->xa_index += offset << shift;
+}
+
 /**
  * xas_reset() - Reset an XArray operation state.
  * @xas: XArray operation state.
@@ -1883,6 +1892,46 @@ static inline void *xas_prev(struct xa_state *xas)
 	return xa_entry(xas->xa, node, xas->xa_offset);
 }
 
+/**
+ * xas_prev_canonical() - Move iterator to the previous entry, onto the slot
+ * which stores it.
+ * @xas: XArray operation state.
+ *
+ * Same as xas_prev(), but it steps back over a multi-index entry as a
+ * whole: the state is left on the slot which stores the entry and on its
+ * first index, so xas_get_order() reports its order.  A cursor already
+ * inside an entry reports that entry instead of stepping off it.
+ *
+ * Context: Any context.  Hold the xa_lock or the RCU lock across the
+ * whole walk; xas_pause() is forward-only.
+ * Return: The entry at the new position, or %NULL (empty slot, error
+ * state, or the end of the walk).  The result may be an internal entry,
+ * which needs xas_retry().
+ */
+static inline void *xas_prev_canonical(struct xa_state *xas)
+{
+	void *entry = NULL;
+
+	/* step back unless @xas is already inside an entry */
+	if (!xas_is_node(xas) ||
+	    xas->xa_offset >= XA_CHUNK_SIZE ||
+	    xas->xa_offset == ((xas->xa_index >> xas->xa_node->shift) &
+			       XA_CHUNK_MASK))
+		entry = xas_prev(xas);
+	if (!xas_is_node(xas))
+		return entry;
+	if (xa_is_sibling(entry))
+		xas->xa_offset = xa_to_sibling(entry);
+
+	entry = xa_entry(xas->xa, xas->xa_node, xas->xa_offset);
+	/* a concurrent store or split can leave a sibling or a node here */
+	if (xa_is_sibling(entry) ||
+	    (xas->xa_node->shift && xa_is_node(entry)))
+		return XA_RETRY_ENTRY;
+	xas_move_index(xas, xas->xa_offset);
+	return entry;
+}
+
 /**
  * xas_next() - Move state to next index.
  * @xas: XArray operation state.
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 615f7730a5bd..ad4507982b5b 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -2011,6 +2011,101 @@ static noinline void check_split(struct xarray *xa)
 static void check_split(struct xarray *xa) { }
 #endif
 
+/* Only the head holds an entry, and there is no node to walk */
+static noinline void check_prev_canonical_no_walk(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+
+	xa_store(xa, 0, xa_mk_value(0x123), GFP_KERNEL);
+	xas_lock(&xas);
+	XA_BUG_ON(xa, xas_prev_canonical(&xas) != xa_mk_value(0x123));
+	XA_BUG_ON(xa, xas.xa_index != 0);
+	xas_unlock(&xas);
+	xa_destroy(xa);
+}
+
+static noinline void check_prev_canonical(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+	void *entry;
+	unsigned long index;
+
+	/* Order 0 entries at [XA_CHUNK_SIZE / 2, XA_CHUNK_SIZE * 3 / 2 - 1] */
+	for (index = XA_CHUNK_SIZE / 2; index < XA_CHUNK_SIZE * 3 / 2; index++)
+		xa_store(xa, index, xa_mk_value(index), GFP_KERNEL);
+	/* A single order 0 entry at the very end */
+	xa_store(xa, XA_CHUNK_SIZE * 17 / 4, xa_mk_value(0xef), GFP_KERNEL);
+
+#ifdef CONFIG_XARRAY_MULTI
+	/* Entry A at [XA_CHUNK_SIZE * 3 / 2, XA_CHUNK_SIZE * 2 - 1] */
+	xa_store_order(xa, XA_CHUNK_SIZE * 3 / 2, XA_CHUNK_SHIFT - 1,
+		       xa_mk_value(0x123), GFP_KERNEL);
+	/* Entry B at [XA_CHUNK_SIZE * 2, XA_CHUNK_SIZE * 4 - 1] */
+	xa_store_order(xa, 2 * XA_CHUNK_SIZE, XA_CHUNK_SHIFT + 1,
+		       xa_mk_value(0x456), GFP_KERNEL);
+	/* Entry C at [XA_CHUNK_SIZE * 4, XA_CHUNK_SIZE * 17 / 4 - 1] */
+	xa_store_order(xa, 4 * XA_CHUNK_SIZE, XA_CHUNK_SHIFT - 2,
+		       xa_mk_value(0x789), GFP_KERNEL);
+#endif
+
+	xas_lock(&xas);
+#ifdef CONFIG_XARRAY_MULTI
+	/* A cursor inside the entry A reports it */
+	xas_set_order(&xas, 2 * XA_CHUNK_SIZE - 1, 0);
+	xas_load(&xas);
+	XA_BUG_ON(xa, xas_prev_canonical(&xas) != xa_mk_value(0x123));
+	XA_BUG_ON(xa, xas.xa_index != XA_CHUNK_SIZE * 3 / 2);
+	XA_BUG_ON(xa, xas_get_order(&xas) != XA_CHUNK_SHIFT - 1);
+	/* Replacing it to 0xABC: an order 0 store keeps its siblings */
+	XA_BUG_ON(xa, xas_store(&xas, xa_mk_value(0xABC)) !=
+		       xa_mk_value(0x123));
+#endif
+
+	/* A bounded walk over the last leaf ends past its last slot */
+	xas_set(&xas, 4 * XA_CHUNK_SIZE);
+	xas_for_each(&xas, entry, 5 * XA_CHUNK_SIZE - 1) { }
+	XA_BUG_ON(xa, xas.xa_offset != XA_CHUNK_SIZE);
+	XA_BUG_ON(xa, xas_prev_canonical(&xas) != NULL);
+	XA_BUG_ON(xa, xas.xa_index != 5 * XA_CHUNK_SIZE - 1);
+
+	/* Walk, and every step lands one entry back */
+	xas_set_order(&xas, XA_CHUNK_SIZE * 17 / 4, 0);
+
+	/* Read back the ending order 0 entry */
+	XA_BUG_ON(xa, xas_prev_canonical(&xas) != xa_mk_value(0xef));
+	XA_BUG_ON(xa, xas.xa_index != XA_CHUNK_SIZE * 17 / 4);
+	XA_BUG_ON(xa, xas_get_order(&xas) != 0);
+
+#ifdef CONFIG_XARRAY_MULTI
+	/* Read entry C */
+	XA_BUG_ON(xa, xas_prev_canonical(&xas) != xa_mk_value(0x789));
+	XA_BUG_ON(xa, xas.xa_index != 4 * XA_CHUNK_SIZE);
+	XA_BUG_ON(xa, xas_get_order(&xas) != XA_CHUNK_SHIFT - 2);
+	/* Read entry B */
+	XA_BUG_ON(xa, xas_prev_canonical(&xas) != xa_mk_value(0x456));
+	XA_BUG_ON(xa, xas.xa_index != 2 * XA_CHUNK_SIZE);
+	XA_BUG_ON(xa, xas_get_order(&xas) != XA_CHUNK_SHIFT + 1);
+	/* Read entry A, holding the value stored above */
+	XA_BUG_ON(xa, xas_prev_canonical(&xas) != xa_mk_value(0xABC));
+	XA_BUG_ON(xa, xas.xa_index != XA_CHUNK_SIZE * 3 / 2);
+	XA_BUG_ON(xa, xas_get_order(&xas) != XA_CHUNK_SHIFT - 1);
+#endif
+
+	/* The order 0 entries, in the leaf below entry A */
+	xas_set_order(&xas, XA_CHUNK_SIZE * 3 / 2 - 1, 0);
+	for (index = XA_CHUNK_SIZE * 3 / 2; index > XA_CHUNK_SIZE / 2; index--) {
+		XA_BUG_ON(xa, xas_prev_canonical(&xas) !=
+			       xa_mk_value(index - 1));
+		XA_BUG_ON(xa, xas_store(&xas, xa_mk_value(2)) !=
+			       xa_mk_value(index - 1));
+	}
+
+	/* The hole ends the walk */
+	XA_BUG_ON(xa, xas_prev_canonical(&xas) != NULL);
+	xas_unlock(&xas);
+	xa_destroy(xa);
+}
+
 static void check_align_1(struct xarray *xa, char *name)
 {
 	int i;
@@ -2328,6 +2423,8 @@ static int xarray_checks(void)
 	check_store_iter(&array);
 	check_align(&xa0);
 	check_split(&array);
+	check_prev_canonical_no_walk(&array);
+	check_prev_canonical(&array);
 
 	check_workingset(&array, 0);
 	check_workingset(&array, 64);
diff --git a/lib/xarray.c b/lib/xarray.c
index 48f440d114e1..1c295b9404dc 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -152,14 +152,6 @@ static void xas_set_offset(struct xa_state *xas)
 	xas->xa_offset = get_offset(xas->xa_index, xas->xa_node);
 }
 
-/* move the index either forwards (find) or backwards (sibling slot) */
-static void xas_move_index(struct xa_state *xas, unsigned long offset)
-{
-	unsigned int shift = xas->xa_node->shift;
-	xas->xa_index &= ~XA_CHUNK_MASK << shift;
-	xas->xa_index += offset << shift;
-}
-
 static void xas_next_offset(struct xa_state *xas)
 {
 	xas->xa_offset++;

-- 
2.56.1


