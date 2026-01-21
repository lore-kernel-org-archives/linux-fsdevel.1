Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6137E306
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977529; cv=none; b=PGQm9Vg1QzPO4iEso1ndgjacXasu56u9m6/Yl82YfdhlZ8Be/tRzA+/e+NxrQzGY7Xh/MCMgOaJcdM8S+KCvpAMFToNkUr0mP9NiF4mIVzh/59gy+IXvosdAFA2KH078Cwdu5yX/Knf1X4fp0S8hNdASYLHN/OYIwM6CpDvi65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977529; c=relaxed/simple;
	bh=Tiut9azeZWxfctDXuqxUgZCu2d0i4fTmsKDRnRBlgoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQs+5XQtQSIMVdwOZ1zmkliYNFkVrrYqTJF8WasBjKwawoP/mRop+6Cs0TQPElk/T+odCK+R6RHHp9TlTfZ8ezi0VjJhTwpvF/oIgQUkGRIX6b+IzmxZ3Vp+HrFPcnwSkk/Rxg7L+RiUChQqjIjuGSqEV2JIPI97Vx1Kq1BlRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RdMO5FM8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RdMO5FM8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I4u8IJVOmEePXbjX+xDPzw9Fz95TVJK6x3yuVVad3RA=; b=RdMO5FM8i5WTJ7VEdnht2EtYIq
	rOCcKGWGEQyb6LXeAgHDAkjx4Fw89srT7KQ5BArMiuH1XizTI0FFdqXzIog8rKC4cPf/PrtGjihxB
	8t9AHLWkxLdjWhtaBRTjCbnCpGp3xBBaJfTs3OEWIcJMPpLyvrNQKbXMSiq1Vf5nJfn9l2HT5lV4A
	atktoik3uXhPt++HSghrOxMZZmRaTxabzmsPOrdbZLsuTBZQeyZf5bOL5pvEbWwmu2wI6c8Vd7O3w
	riGv4kijh3P6qTscVzoq2FyWDaZgbVUBerdh7y1quImqB0enBxniEwFCvqbPTwvPhx88fH+Apjrub
	3fzdOx9A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRrJ-0000000FzUi-3JeI;
	Wed, 21 Jan 2026 06:38:29 +0000
Date: Wed, 21 Jan 2026 06:38:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	shardul.b@mpiricsoftware.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/khugepaged: free empty xa_nodes when rollbacks in
 collapse_file
Message-ID: <aXB0Zcu4bIEvSSuX@casper.infradead.org>
References: <20260121062243.1893129-1-tujinjiang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121062243.1893129-1-tujinjiang@huawei.com>

On Wed, Jan 21, 2026 at 02:22:43PM +0800, Jinjiang Tu wrote:
> collapse_file() calls xas_create_range() to pre-create all slots needed.
> If collapse_file() finally fails, these pre-created slots are empty nodes
> and aren't destroyed.

try this instead

diff --git a/fs/inode.c b/fs/inode.c
index cff1d3af0d57..85886af1e7ab 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -744,22 +744,18 @@ void dump_mapping(const struct address_space *mapping)
 
 void clear_inode(struct inode *inode)
 {
-	/*
-	 * We have to cycle the i_pages lock here because reclaim can be in the
-	 * process of removing the last page (in __filemap_remove_folio())
-	 * and we must not free the mapping under it.
-	 */
-	xa_lock_irq(&inode->i_data.i_pages);
-	BUG_ON(inode->i_data.nrpages);
 	/*
 	 * Almost always, mapping_empty(&inode->i_data) here; but there are
 	 * two known and long-standing ways in which nodes may get left behind
 	 * (when deep radix-tree node allocation failed partway; or when THP
-	 * collapse_file() failed). Until those two known cases are cleaned up,
-	 * or a cleanup function is called here, do not BUG_ON(!mapping_empty),
-	 * nor even WARN_ON(!mapping_empty).
+	 * collapse_file() failed).
+	 *
+	 * xa_destroy() also cycles the lock for us, which is needed because
+	 * reclaim can be in the process of removing the last folio (in
+	 * __filemap_remove_folio()) and we must not free the mapping under it.
 	 */
-	xa_unlock_irq(&inode->i_data.i_pages);
+	xa_destroy(&inode->i_data.i_pages);
+	BUG_ON(inode->i_data.nrpages);
 	BUG_ON(!list_empty(&inode->i_data.i_private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
 	BUG_ON(inode->i_state & I_CLEAR);
