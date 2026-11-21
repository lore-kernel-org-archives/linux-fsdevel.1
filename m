Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299510;
	b=44AOlBsRLzO+a9x9XNkHv5ubRNt7nMiXbqMbSo0p4GjoPnCIN+vKwc4QZIy2sqSBTX+A
	 /M5/O5bKwtRqIv8nhuL/hpj8Qi+Phxe63Y4sEZZbEfCBfqsdSr/Jz+m4nxqhGtln9C8ut
	 VKYWbFbZcWRr8Tdpfwm54J1oF+fUFTPcrcAczjPR6fnBSPmeC+R8QUPlBzMxe37zaFWOK
	 +d3Ukwo7C7DINLcsGx4ugmq2XAK2WtgfsKIX6g7gkw6xp1tEwUKMb+1QMOy1KcznCmWyJ
	 ydkE6N/4v8xOUpHCQNRwo5yE+cj07KcxHl3kDZB+AzkB2PWdl7IbxBBM2QW+UXJwF1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299510;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:In-Reply-To:
	 References:Subject;
	bh=2ljPbviUXKu1SCaRavSk4LhU7mdn/H04EXeK9PLuTmo=;
	b=oWX3jeMX7TYbk27WPeDCRVuQ6yk53DyJgAtiihaYtIG3uuJ8dDmC9Jx/q/zPdFzan/eJ
	 qhd96G386wQe6dEHyHiUGS+psOkvTHpJAaVE0XTL3aQkTCBKcrk3DX2WfX8m4RDYR8tmI
	 ya50MYEgIfAmkAdKeeldFf/DpI/3+F2svoN6MfudnbPZVjeAngkA634PUqqflffByg9Ip
	 i9UxL6Cm9YpglbWy8v//DzByk6mN8ZEzUj9EsRlmW9kmdAHQr+znU04KPLmRdD1g+ApeR
	 S9plDHYHKwcqduYLqIvftBF4rkpZTIznXyc54uqKG3gBdK0auvmZUNAXRI4c7OAU9xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=netKusrG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50097606A335;
	Sat, 21 Nov 2026 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=netKusrG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D4A1F000CF;
	Sat, 21 Nov 2026 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795299509;
	bh=2ljPbviUXKu1SCaRavSk4LhU7mdn/H04EXeK9PLuTmo=;
	h=Date:To:Cc:From:In-Reply-To:References:Subject;
	b=netKusrGp+sRX3aLeD14XWKNNKdUwuLOvn3Qwv4wmun0xK7jJndf5dxL330bWqmqY
	 UgbTecV3leJ3kDr1miff/ZmDYs8G6aaGo6zgPqM0/xUVGCyH6XSS3c1hDgFGzs8i2Q
	 mAlbHFhWgb5PyOwx7vpMdKc1AZ+sf7o1DGSj03jU=
Date: Sat, 21 Nov 2026 14:18:29 -0800
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Nickolai Zeldovich <nickolai@csail.mit.edu>,
 Baoli Zhang <baoli.zhang@intel.com>,
 syzbot+73641b60a3bc11dfca8c@syzkaller.appspotmail.com
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <08ceefcb212e4dda9767389fe7f162a8.1@linux-foundation.org>
In-Reply-To: <08ceefcb212e4dda9767389fe7f162a8.0@linux-foundation.org>
References: <08ceefcb212e4dda9767389fe7f162a8.0@linux-foundation.org>
Subject: [PATCH v2 1/2] lib/test_xarray: check the offset of new root nodes
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

From: Nickolai Zeldovich <nickolai@csail.mit.edu>

Free XArray nodes whose offsets are nonzero, then check that roots
created by xas_create() and xas_expand() have offset zero. An old
root with a stale offset can make a concurrent iterator resume in
the wrong slot after expansion.

Link: https://lore.kernel.org/r/20261024014344.830116-1-nickolai@csail.mit.edu
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Baoli Zhang <baoli.zhang@intel.com>
Cc: <syzbot+73641b60a3bc11dfca8c@syzkaller.appspotmail.com>

 lib/test_xarray.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/lib/test_xarray.c~lib-test_xarray-check-the-offset-of-new-root-nodes
+++ a/lib/test_xarray.c
@@ -370,6 +370,38 @@ static noinline void check_xa_shrink(str
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
@@ -2336,6 +2368,7 @@ static int xarray_checks(void)
 	check_xa_load(&array);
 	check_xa_mark(&array);
 	check_xa_shrink(&array);
+	check_xa_root_offset(&array);
 	check_xas_erase(&array);
 	check_insert(&array);
 	check_cmpxchg(&array);
_
