Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787400;
	b=f8V93qX8qvPeGb/PWulQHb7omtwmbbblUjNS519dUKW8cldpWJXctiUHl01z+ge78A2y
	 gutjzzTs0SDPtncI+0kifshAnGZhotp7obhWluSWrex2EtKSF5DpcyIXaPWAByUHoMd8J
	 oYbbPsKIZiSeBbTtZ+3YVtL0pB6hwbt8p/ePnFxLoATXiMGGbzL3PrLAffaQ2rcDP5uLa
	 752NpcZcxqnL/bCpEXmh5yF5NAGuQ4d7oO/HB9LiPwtzl/AAFPyNkopyJYJJ5VwCEaowf
	 jQK3+7rmPIUFuRYu+AT9mjx+FGtxNC1jefRNDBVXdPYGu0h06ZDsjyng5dk4PMjXn0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787400;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=S/gS3BlmwBekgqi9/q5oJIhOXINLDyFzJjGA2lorCfA=;
	b=k4/V6Qyntjg5FimMPjN2q/US1D5pfvaUXkQ4//p6F/yUGFzlfZWhVvau1feIso/3FkwL
	 dmOWGL0c6oRzS3hzJxdEJDuY1iTNC0d0xv4KxAK1z2F7zjEddURjqqX+PcWO8xQx/0O3Z
	 esa2u8bdso+QsWF3R4qaTVJNL4isLfzjm3i3xe1hzese9ZAJORkMcdToiwKfCrL0QnTZW
	 wq5Bqx6L42UdeCi75Cg5rpCsus5ikeOMFydmSfqZVGuxzrYbmv5JCBf5e7IYCcGXvfkyn
	 epGJFf9Pjc0hmzdLhPtIhKWgjsPoeOC5W/3GL/raqHJO2XATAcP6sg095XNZNCcDIOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=VV9utfOJ;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC64606A31D;
	Fri, 23 Oct 2026 20:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBC64606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=VV9utfOJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S/gS3BlmwBekgqi9/q5oJIhOXINLDyFzJjGA2lorCfA=; b=VV9utfOJx1tEJkpEm9BSPQfel2
	JRPtng5mWajAK1SORvPCY9N6sHojpuqUeUGiEIModXsqcRES58ouPBSI326gmmALL+9ChqFL74ToT
	eP7RZxNHeudHW8xWqJ0KAitpuAF60i0uUyLvXJzDsexi6ymg8+Ca1dhwvppoPkgNZWNVImCR8U1Xs
	4zIxFIz0XW4p82xJ4UL3b2nbgxsBDq680HXzc97ELuZQZpAGXWCmhZg/uf9MIkqHyAooKXw7tkwLD
	cdpkdMOmG+xJjKZA9aHp29+z1EmXFHWweBIW7vPaEmm/Q1/jqWm1LSpRuzYgnDOelPtzo4Z7ViiGe
	+bXwTtWw==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKLti-0000000ER5N-2XP1;
	Fri, 23 Oct 2026 20:29:54 +0000
Date: Fri, 23 Oct 2026 21:29:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xarray: initialise the offset of a new root node
Message-ID: <atvDwsWu-FDwtgnt@casper.infradead.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012181107.772545-1-nickolai@csail.mit.edu>


Same comment about the verbosity of the commit message.

On Mon, Oct 12, 2026 at 02:11:07PM -0400, Nickolai Zeldovich wrote:
> xas_alloc() sets node->offset only when the new node has a parent.  A
> root node, allocated by xas_create() for an empty array or by
> xas_expand() when the tree grows, keeps the offset its slab object had
> before: radix_tree_node_cachep has a constructor, so the slab does not
> clear the object, and radix_tree_node_rcu_free() only clears the slots
> and marks.  A node freed from slot N of its parent comes back as a root
> with offset N.
> 
> xas_expand() stores 0 to the old root's offset just before publishing it
> as slot 0 of the new root, so the value is right once the expansion is
> visible, but an RCU walker can see the old value.  The iterators climb
> out of a node with
> 
> 	xas->xa_offset = xas->xa_node->offset + 1;
> 	xas->xa_node = xa_parent(xas->xa, xas->xa_node);
> 
> (xas_find(), xas_find_marked() and __xas_next(); __xas_prev() uses
> "- 1").  A walker under rcu_read_lock() that reaches the end of the root
> while another thread expands the tree can load the stale offset before
> xas_expand() clears it and the parent pointer after xas_expand() sets
> it.  No reordering is needed: the two loads only have to straddle the
> two stores.  The walker then continues in the new root at slot
> (stale offset + 1) while xa_index is the first index of slot 1.  If that
> slot is populated by then (for example by the store that caused the
> expansion), the walker returns its entry with the wrong index.  With a
> root covering 0-63 and a stale offset of 5, xa_for_each() that runs
> concurrently with xa_store(xa, 384, p) can report p at index 64, and
> then again at 384; xa_find() stores the wrong index in *indexp.  Any
> entries in slots 1..5 of the new root are skipped.
> 
> The radix tree's radix_tree_node_alloc() always sets the offset, and
> radix_tree_extend() passes 0 for a new root.  xas_alloc() dropped this
> for root nodes when the XArray was introduced.
> 
> Set the offset of a node allocated without a parent to 0.  A node's
> offset then never changes while readers can see it: a child's offset is
> set before the node is published, xas_expand()'s store to the old root
> writes the value it already has, and the root that xas_shrink() leaves
> behind was the child in slot 0.  A walker climbing out of a root
> continues at slot 1 whichever parent pointer it loads.
> 
> The new test frees two nodes with non-zero offsets and checks that the
> roots created by xas_create() and xas_expand() have offset 0.  Its
> checks use a new XA_WARN_ON(), which warns and carries on, counted like
> XA_BUG_ON().  The test relies on the slab handing the freed nodes back;
> without this patch both checks fail in the userspace harness and in the
> self-test booted on x86_64 and riscv64 under QEMU.  The race itself has
> no deterministic test.

No, we don't want XA_WARN_ON.  We want XA_BUG_ON so it _stops_.  This
is really important.

> Found while formally verifying the lockless XArray iterators against the
> kernel binary.
> 
> Fixes: 58d6ea3085f2 ("xarray: Add XArray unconditional store operations")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> ---
> 
> Notes:
>     - The patch and its analysis were drafted with an LLM coding assistant
>       and then reviewed and tested as described here and in the commit
>       message.
>     
>     - Reproduction of the race (test build only, not part of this patch): in
>       tools/testing/radix-tree (XA_CHUNK_SHIFT 3), a hook between the two
>       loads of the climb in xas_find() runs the expanding store, i.e. the
>       writer runs after the walker loaded the root's offset and before it
>       loaded the parent.  The root was reallocated from a leaf freed at
>       offset 5.  Without this patch xa_for_each() prints "index 8 entry 48",
>       then "index 48 entry 48"; with it, only "index 48 entry 48".  Nothing
>       was reproduced without the injected hook: the window is two loads wide.
>     
>  lib/test_xarray.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>  lib/xarray.c      |  2 ++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/lib/test_xarray.c b/lib/test_xarray.c
> index 5ca0aefee9aa..27988441e71c 100644
> --- a/lib/test_xarray.c
> +++ b/lib/test_xarray.c
> @@ -32,6 +32,22 @@ void xa_dump(const struct xarray *xa) { }
>  } while (0)
>  #endif
>  
> +/*
> + * Warn if @x holds and return whether it did, so that the caller can skip
> + * checks which would not terminate or would not mean anything on the
> + * broken state.  Counted with tests_run and tests_passed like the rest.
> + */
> +#define XA_WARN_ON(xa, x) ({					\
> +	bool __failed = WARN_ON(x);				\
> +								\
> +	tests_run++;						\
> +	if (__failed)						\
> +		xa_dump(xa);					\
> +	else							\
> +		tests_passed++;					\
> +	__failed;						\
> +})
> +
>  static void *xa_mk_index(unsigned long index)
>  {
>  	return xa_mk_value(index & LONG_MAX);
> @@ -370,6 +386,39 @@ static noinline void check_xa_shrink(struct xarray *xa)
>  	}
>  }
>  
> +static noinline void check_xa_root_offset(struct xarray *xa)
> +{
> +	DEFINE_XARRAY(tmp);
> +	struct xa_node *node;
> +
> +	/* Free two nodes with non-zero offsets so the slab can reuse them */
> +	xa_store_index(&tmp, 0, GFP_KERNEL);
> +	xa_store_index(&tmp, 5UL << XA_CHUNK_SHIFT, GFP_KERNEL);
> +	xa_store_index(&tmp, 6UL << XA_CHUNK_SHIFT, GFP_KERNEL);
> +	xa_store_index(&tmp, 7UL << XA_CHUNK_SHIFT, GFP_KERNEL);
> +	xa_erase_index(&tmp, 5UL << XA_CHUNK_SHIFT);
> +	xa_erase_index(&tmp, 6UL << XA_CHUNK_SHIFT);
> +	rcu_barrier();
> +
> +	/* A root created by xas_create() must have offset 0 */
> +	XA_WARN_ON(xa, xa_store_index(xa, 0, GFP_KERNEL));
> +	XA_WARN_ON(xa, xa_store_index(xa, 1, GFP_KERNEL));
> +	rcu_read_lock();
> +	node = xa_to_node(xa_head(xa));
> +	XA_WARN_ON(xa, node->offset != 0);
> +	rcu_read_unlock();
> +
> +	/* And so must a root created by xas_expand() */
> +	XA_WARN_ON(xa, xa_store_index(xa, XA_CHUNK_SIZE, GFP_KERNEL));
> +	rcu_read_lock();
> +	node = xa_to_node(xa_head(xa));
> +	XA_WARN_ON(xa, node->offset != 0);
> +	rcu_read_unlock();
> +
> +	xa_destroy(xa);
> +	xa_destroy(&tmp);
> +}
> +
>  static noinline void check_insert(struct xarray *xa)
>  {
>  	unsigned long i;
> @@ -2235,6 +2284,7 @@ static int xarray_checks(void)
>  	check_xa_load(&array);
>  	check_xa_mark(&array);
>  	check_xa_shrink(&array);
> +	check_xa_root_offset(&array);
>  	check_xas_erase(&array);
>  	check_insert(&array);
>  	check_cmpxchg(&array);
> diff --git a/lib/xarray.c b/lib/xarray.c
> index bfe7bef80f34..720d46e8b14a 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -387,6 +387,8 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
>  		parent->count++;
>  		XA_NODE_BUG_ON(node, parent->count > XA_CHUNK_SIZE);
>  		xas_update(xas, parent);
> +	} else {
> +		node->offset = 0;
>  	}
>  	XA_NODE_BUG_ON(node, shift > BITS_PER_LONG);
>  	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
> 

I think we should include Baoli's addition as well, but other than that,
I think the patch is correct.  (I have a suspicion that xas->xa_offset
will be 0 if !parent, so we could just initialise node->offset to
xas->xa_offset unconditionally, but I'm not sure that level of
microoptimisation is worth it at this point).
