Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806234;
	b=beJX3B26wRHJxaFQDGJPpQ/OFGU4LFqMUXua5zgl0F1Zd2q3RHula7a2Wg3sIRIQuKtt
	 0zMNcjKdbJTCUvfsMs17i3nkfJT8S2Q0iVMfSi2EBQXdYMyMuItiuWVxNv2KuwI75Q6D/
	 xv/Xl8mIu23vl/4+id0e5JE9LDmsLEMeEQfhr0tOuR2hMEcWp2N0AR3Uj4W9p9C/PsN4q
	 yn/Jgdc+C9fGx9xGh05L8ShU3LCcM44nSroshH7x6cbB6CC+/goyfOM4Wnoqk4L2OWxAt
	 xfqmOW4S5zXIusCfOERZk3KmrGAU7Wg01iFxl2mC3isnd/sxRvqUdwbewXfFMxpGdUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806234;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wyVREYXOxjrzUhwVsdrv5z52bG4LokTjT1gazbHkJ+o=;
	b=AuFGneTT1baedeHDGOUVrcTo2evNsQEInZU5UKdVw5afKnSfbRyayNcJ7Usg57ajWOJd
	 azY5V3ar7CQLFAPLbkyLua8MjtjXOl2YlK8unhE4du4yfPRjCRyMf98o3vcMw1F9SLOPm
	 s4etPxByiyGgivPYx92F6eHi7bwpTt2YYhRyoKI99BSHYPk6xSy1+d9GpnyNAkMr1ScIV
	 Q3hlDcaA2ZoquTYuO5R1EUa/+WBk6Gmv2lx0dxBT14LpCr9JmDwugP0s18wkZ8AhAL5nP
	 0U1kSAHVolXRu0TC1s7aXUW+3Lpd/HjQuIQZIH2YhmrTBBZ6H2KUb3+aNPx1EFEtoAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1813B606A31A;
	Sat, 24 Oct 2026 01:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1813B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xKQnR-00DwZT-3H;
	Fri, 23 Oct 2026 21:43:45 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Baoli Zhang <baoli.zhang@intel.com>,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v2] xarray: initialise the offset of a new root node
Date: Fri, 23 Oct 2026 21:43:44 -0400
Message-ID: <20261024014344.830116-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012181107.772545-1-nickolai@csail.mit.edu>
References: <20261012181107.772545-1-nickolai@csail.mit.edu>
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

An RCU walker such as xas_find() that climbs out of the root while
xas_expand() adds a level above it can resume in the new root at the
wrong slot and return an entry with the wrong index.

xas_alloc() sets node->offset only for a node with a parent, so a new
root keeps the offset its slab object had before.  xas_expand() stores
0 to the old root's offset just before linking it below the new root,
and a walker can load the stale offset before that store and the new
parent pointer after it.

Set the offset of a node allocated without a parent to 0.  The store in
xas_expand() then writes the value the old root already has, so remove
it.

Fixes: 58d6ea3085f2 ("xarray: Add XArray unconditional store operations")
Reported-by: syzbot+73641b60a3bc11dfca8c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=73641b60a3bc11dfca8c
Tested-by: Baoli Zhang <baoli.zhang@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    Changes in v2:
    - The test uses XA_BUG_ON() instead of a new XA_WARN_ON() (Matthew Wilcox).
    - Remove the store to the old root's offset in xas_expand(), which now
      writes the value already there (Baoli Zhang).
    - The first root in the test now comes from xas_create(); in v1 both
      came from xas_expand().
    v1: https://lore.kernel.org/all/20261012181107.772545-1-nickolai@csail.mit.edu/
    
    Setting node->offset = xas->xa_offset for a root too does not work:
    xas_set() keeps xa_offset, so a loop like the one in check_xas_erase()
    (xas_set(&xas, j); xas_store(&xas, ...)) grows the tree with the offset
    of the previous index.  In the XArray tests 2929 of 104963 allocations
    without a parent see a non-zero xa_offset, and with that variant
    check_xas_erase() fails.
    
    The syzbot report is this race seen by KCSAN: xas_expand() changes the
    old root's offset from 3 to 0 while xas_find() reads it.  After this
    patch xas_expand() no longer writes it.
    
    Reproducer (tools/testing/radix-tree with a hook in xas_find() between
    "xas->xa_offset = xas->xa_node->offset + 1;" and the xa_parent() load:
    "if (xa_climb_hook) xa_climb_hook();"; add "rootoff: rootoff.o
    $(CORE_OFILES)" to the Makefile):
    
    #include <stdio.h>
    #include <linux/xarray.h>
    #include "test.h"
    
    extern void (*xa_climb_hook)(void);
    static DEFINE_XARRAY(tmp);
    static DEFINE_XARRAY(xa);
    
    static void expand(void)
    {
    	xa_climb_hook = NULL;
    	xa_store(&xa, 6UL << XA_CHUNK_SHIFT, xa_mk_value(48), GFP_KERNEL);
    }
    
    int main(void)
    {
    	unsigned long index;
    	void *entry;
    
    	rcu_register_thread();
    	radix_tree_init();
    
    	/* free a leaf that sat in slot 5 of its parent */
    	xa_store(&tmp, 0, xa_mk_value(0), GFP_KERNEL);
    	xa_store(&tmp, 5UL << XA_CHUNK_SHIFT, xa_mk_value(0), GFP_KERNEL);
    	xa_store(&tmp, 7UL << XA_CHUNK_SHIFT, xa_mk_value(0), GFP_KERNEL);
    	xa_erase(&tmp, 5UL << XA_CHUNK_SHIFT);
    	rcu_barrier();
    
    	/* the new root of xa reuses it */
    	xa_store(&xa, 1, xa_mk_value(1), GFP_KERNEL);
    	printf("root offset %u\n", xa_to_node(xa.xa_head)->offset);
    
    	xa_climb_hook = expand;
    	xa_for_each(&xa, index, entry)
    		printf("index %lu entry %lu\n", index, xa_to_value(entry));
    	return 0;
    }
    
    $ make rootoff && ./rootoff
    Without this patch:       With it:
    root offset 5             root offset 0
    index 1 entry 1           index 1 entry 1
    index 8 entry 48          index 48 entry 48
    index 48 entry 48
    
    Tested with tools/testing/radix-tree and with test_xarray built in on
    x86_64 and riscv64 under QEMU; without the lib/xarray.c change both new
    checks fail.
    
    The analysis, the patch and the tests were done with the help of an AI
    coding assistant.

 lib/test_xarray.c | 33 +++++++++++++++++++++++++++++++++
 lib/xarray.c      |  6 +++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 5ca0aefee9aa5..046abad609648 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -370,6 +370,38 @@ static noinline void check_xa_shrink(struct xarray *xa)
 	}
 }
 
+static noinline void check_xa_root_offset(struct xarray *xa)
+{
+	DEFINE_XARRAY(tmp);
+	struct xa_node *node;
+
+	/* Free two nodes with non-zero offsets so the slab can reuse them */
+	xa_store_index(&tmp, 0, GFP_KERNEL);
+	xa_store_index(&tmp, 5UL << XA_CHUNK_SHIFT, GFP_KERNEL);
+	xa_store_index(&tmp, 6UL << XA_CHUNK_SHIFT, GFP_KERNEL);
+	xa_store_index(&tmp, 7UL << XA_CHUNK_SHIFT, GFP_KERNEL);
+	xa_erase_index(&tmp, 5UL << XA_CHUNK_SHIFT);
+	xa_erase_index(&tmp, 6UL << XA_CHUNK_SHIFT);
+	rcu_barrier();
+
+	/* A root created by xas_create() must have offset 0 */
+	XA_BUG_ON(xa, xa_store_index(xa, 1, GFP_KERNEL));
+	rcu_read_lock();
+	node = xa_to_node(xa_head(xa));
+	XA_BUG_ON(xa, node->offset != 0);
+	rcu_read_unlock();
+
+	/* And so must a root created by xas_expand() */
+	XA_BUG_ON(xa, xa_store_index(xa, XA_CHUNK_SIZE, GFP_KERNEL));
+	rcu_read_lock();
+	node = xa_to_node(xa_head(xa));
+	XA_BUG_ON(xa, node->offset != 0);
+	rcu_read_unlock();
+
+	xa_destroy(xa);
+	xa_destroy(&tmp);
+}
+
 static noinline void check_insert(struct xarray *xa)
 {
 	unsigned long i;
@@ -2235,6 +2267,7 @@ static int xarray_checks(void)
 	check_xa_load(&array);
 	check_xa_mark(&array);
 	check_xa_shrink(&array);
+	check_xa_root_offset(&array);
 	check_xas_erase(&array);
 	check_insert(&array);
 	check_cmpxchg(&array);
diff --git a/lib/xarray.c b/lib/xarray.c
index bfe7bef80f34e..1e2380e3194d6 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -387,6 +387,8 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 		parent->count++;
 		XA_NODE_BUG_ON(node, parent->count > XA_CHUNK_SIZE);
 		xas_update(xas, parent);
+	} else {
+		node->offset = 0;
 	}
 	XA_NODE_BUG_ON(node, shift > BITS_PER_LONG);
 	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
@@ -616,10 +618,8 @@ static int xas_expand(struct xa_state *xas, void *head)
 		 * Now that the new node is fully initialised, we can add
 		 * it to the tree
 		 */
-		if (xa_is_node(head)) {
-			xa_to_node(head)->offset = 0;
+		if (xa_is_node(head))
 			rcu_assign_pointer(xa_to_node(head)->parent, node);
-		}
 		head = xa_mk_node(node);
 		rcu_assign_pointer(xa->xa_head, head);
 		xas_update(xas, node);

base-commit: 26344c0dd32af8790d8474d233619db825441138
-- 
2.53.0

