Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75024DCF9
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588925; cv=none; b=rr4VJckf6PlJiHy1EOP6NIJIxR2WXsfM+la1vRHCTbJA0ReDU6iCFfQM6ixf0IzFSYezjQAYxGzXI0iWRy2393BzsYXD0Ek56jH4FIEJe51MVUwKhzJrffTYjaT97dgGoPVpOIrsarnoiN1Hyww+jnMdA9ax20rHLtj9Qsxd6wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588925; c=relaxed/simple;
	bh=En5Pyp75wWUADac5w9w7in3IXtzuFrbpxxBMlr+HmNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEI7gBtUnUktGdeX6k9fLHJIsZKk4OoKsgKzEtd4Tfkq5J3DRYe+Etx8f8Z1WgDFd6+XDrrBdjsl7hN3cTMrf8df3a3RrX7NOA5RH5HRpePN4UcGvfG3m23sK1kUVa/WJDXSxOvsFciV7eCJVORGHAu+GEokUphhQsINSTLkA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnDYTHI4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMTrMrNX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnDYTHI4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMTrMrNX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775588921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kS4n/3ltYPu7BwZrFjD+zI77sgzKdk2SudluJa6MIvw=;
	b=AnDYTHI45JUXzTpTkTeoqHE9aWi3G4JfS4mvJhNtm+DGQzG0SKLIGkfUaYxsCuegWZVafH
	7seWwho0kALEETC8D3FyWEI0liERnzKhlNJnrPZIeLVNKT82aI16hrXFt2xUm+3/69WG+f
	Gj+WFmO0+VK5KkKli+4bhuxs9xBhqPc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-o5LQMFgcMfKWsbJMlobs7A-1; Tue, 07 Apr 2026 15:08:40 -0400
X-MC-Unique: o5LQMFgcMfKWsbJMlobs7A-1
X-Mimecast-MFC-AGG-ID: o5LQMFgcMfKWsbJMlobs7A_1775588920
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7985951fa83so68351537b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775588919; x=1776193719; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kS4n/3ltYPu7BwZrFjD+zI77sgzKdk2SudluJa6MIvw=;
        b=TMTrMrNXNe0zPZN4QSvZjw+B4cIeN7Of6wiazHV26auTxbsTCSlDxk2LcQiEHiPyc8
         FhxJgvDESgpfKpaRfBS2K5hUdR2/VJAh3gIvDXugU0icFTZL/unQCu+kxtk4jNksQOLJ
         BPKKWA0ERUlclm6kP58Y4glqh6hgMNHVX5gncm4QndHG9giwK4ZKAfCDOQ2DP7W/8dHH
         +jj+Ml/e4w/J7TgFb6RnLLHmROq4X858NZEoWp16BM04Tggs0tFgnNL0dHpKdjy0Cf7j
         zqHt/y2m4B1pryFm25HQAV2MWcWfKYI+23keK3fe6VvomQ4GJkdgyfcdZkV8muNDRwoD
         s26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588919; x=1776193719;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kS4n/3ltYPu7BwZrFjD+zI77sgzKdk2SudluJa6MIvw=;
        b=ZzebYBgQQXQq6DOqq3SkeAvl6JjhN71RB9YJZjprw075oXi5J8mlP18uAsj0/aoqST
         6cNE6HuJQzpffpYPw+vXH968X8JI9HIq08oumrpZZZknN2HaEg6yAoTCnHV3F8Nfr4Jy
         XmOj4Ev6NskVeJHA4yBzt01HnxvfXNT7auE0xzBy9My/HC8eAsEjMaco54zW/V3AJ++4
         ckGGRC0DrzYx4O6Rd/5AF6fGouiMe/tGJCV6r38q/DcotC3kYIObx/znuHO6Nm9R6lSd
         7GBuBBK/qObMRrtwwcv3zxbnjwtmGSVTLNwCiVFfFTIVxl4x+v4iohssqXicKCS+QrKL
         0ihw==
X-Forwarded-Encrypted: i=1; AJvYcCW1+2+yaoCpewCgrP+8sDNasXkyQmrR8755MkXbDTXdQmCSXUeYO4rRMNHCeebJkgQqZR/KkNcR80BRxsnV@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+qJvCIlBdCgnHN9AcFXL4Lb9L0nXLxKpswdWgWtDQUC91Gk3
	dyyjzvt43amOMqsqQ/R0bod9xrVMIuJChRkLd+uoRFDLejOTPxWfXfxDX9QtOwXywTpX4pAn8Bm
	pjMEYJGtdmDFZXQGjkKcF1nOVjFlXOKP/lnkXZlVmVq2bYzVsJ+COxPxrmTRa1ZbHPgR378FFOH
	8=
X-Gm-Gg: AeBDiespiRHV/iqvYws5Kl3lma5Dyngoa9W1DykDNt5jxnWTJZr6kwWtr//lXhP/V8k
	kX2ZIbb56rtLI1ofe6HPyvkRsd3JtIIyUZ+wh8MqqfIoZ22wWGGRMawpCoj+HxJ85P+tWh+ZG/+
	lQOUUZSYTUko61bOCL4ya+QM3ZwZ5sX9RC6pHWOmXUrA9yuV1VPnYLjuwk53Y/S0robQjekMzZu
	RXOtLmuazxJdz75XuTeHGqdMGVzqZ173rh6XplY5lV/RKgLjNe8Jyy7YgXq1Jli4s9qn2FD98za
	NFqeOXCjfcH9XGorI67hm3kvnvbs3POUXgY5yA4HQToAPyR/WQogjzXgVp8YhYkFqgkmw3vpgUK
	QFW9Y43d7TRkwjLUBbZ7H7balS23KcynXENw5T6iLiauVImr0Jq4m
X-Received: by 2002:a05:690c:dc9:b0:798:e281:a4f3 with SMTP id 00721157ae682-7a4d604f1edmr187964737b3.40.1775588919381;
        Tue, 07 Apr 2026 12:08:39 -0700 (PDT)
X-Received: by 2002:a05:690c:dc9:b0:798:e281:a4f3 with SMTP id 00721157ae682-7a4d604f1edmr187964397b3.40.1775588918872;
        Tue, 07 Apr 2026 12:08:38 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e229135sm73884807b3.3.2026.04.07.12.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:08:38 -0700 (PDT)
Message-ID: <885c1b36fb06e8c5bb81738cbb64256267c1a8f3.camel@redhat.com>
Subject: Re: [PATCH 1/1] hfsplus: switch hfs_bmap_alloc() to next-fit
 allocation using alloc_hint
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Tue, 07 Apr 2026 12:08:36 -0700
In-Reply-To: <20260406053027.1672425-2-kalpan.jani@mpiricsoftware.com>
References: <20260406053027.1672425-1-kalpan.jani@mpiricsoftware.com>
	 <20260406053027.1672425-2-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-06 at 11:00 +0530, Kalpan Jani wrote:
> hfs_bmap_alloc() currently performs a linear scan starting from bit 0 of
> the allocation bitmap on every call. This rescans already-used regions
> at the front of the bitmap, causing unnecessary overhead that grows with
> filesystem size and fragmentation.
>=20
> Introduce a next-fit allocation strategy by caching the last successful
> allocation position in a new alloc_hint field in struct hfs_btree.
> Allocation begins from alloc_hint instead of zero and wraps around when
> the end of the map chain is reached, so the full bitmap is still
> searched before returning -ENOSPC.
>=20
> The map chain extension path (hfs_bmap_new_bmap) is preserved: when the
> scan reaches the end of the chain with idx < node_count, a new map node
> is created before any wrap-around, ensuring that nodes reserved by
> hfs_bmap_reserve() are always reachable. Bounds checking against
> tree->node_count prevents allocation beyond valid filesystem boundaries.
>=20
> The seek phase that advances to the map node containing alloc_hint uses
> the existing hfs_bmap_get_map_page() API for node-type validation and
> offset checking, rather than open-coding hfs_brec_lenoff() calls. As a
> minor API refinement, hfs_bmap_get_map_page() now sets ctx->len to the
> remaining bytes from the requested byte_offset rather than the total
> record length, eliminating the need for callers to adjust it externally.
>=20
> hfs_bmap_free() pulls alloc_hint back when a node is freed below the
> current hint, so the freed slot is found immediately on the next
> allocation without requiring a full wrap-around scan.
>=20
> No on-disk format changes.
>=20
> Link: https://lore.kernel.org/all/7194aa49efdb85c7cfc9578f1460aaa9a1c6709=
5.camel@mpiricsoftware.com/
> Co-developed-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
> ---
>  fs/hfsplus/btree.c      | 114 +++++++++++++++++++++++++++++++++++-----
>  fs/hfsplus/hfsplus_fs.h |   1 +
>  2 files changed, 101 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 04304f952f6b..6f2448e332f3 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -132,7 +132,7 @@ u32 hfsplus_calc_btree_clump_size(u32 block_size, u32=
 node_size,
>  /* Context for iterating b-tree map pages
>   * @page_idx: The index of the page within the b-node's page array
>   * @off: The byte offset within the mapped page
> - * @len: The remaining length of the map record
> + * @len: The remaining bytes of the map record from the requested offset
>   */
>  struct hfs_bmap_ctx {
>  	unsigned int page_idx;
> @@ -178,6 +178,8 @@ static struct page *hfs_bmap_get_map_page(struct hfs_=
bnode *node, struct hfs_bma
>  	if (byte_offset >=3D ctx->len)
>  		return ERR_PTR(-EINVAL);
> =20
> +	ctx->len -=3D byte_offset;
> +

It looks really dangerous out of context. Why do we need to modify the ctx-=
>len
in hfs_bmap_get_map_page()? Is it right place? It looks like really good wa=
y to
introduce really not trivial bugs.

>  	page_off =3D (u32)off16 + node->page_offset + byte_offset;
>  	ctx->page_idx =3D page_off >> PAGE_SHIFT;
>  	ctx->off =3D page_off & ~PAGE_MASK;
> @@ -525,19 +527,29 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *=
tree)
>  	struct hfs_bnode *node, *next_node;
>  	struct hfs_bmap_ctx ctx;
>  	struct page *page;
> -	u32 nidx, idx;
> +	u32 start, target, nidx, idx;
> +	u32 bit_offset, found;
>  	u8 *data, byte, m;
>  	int i, res;
> +	bool wrapped =3D false;

I am not really like this wrapped approach. :) But, please, check my commen=
ts
related to alloc_hint. Potentially, we don't need in wrapped variable at al=
l.

> =20
>  	res =3D hfs_bmap_reserve(tree, 1);
>  	if (res)
>  		return ERR_PTR(res);
> =20
> +	if (tree->alloc_hint >=3D tree->node_count)
> +		tree->alloc_hint =3D 0;
> +
> +	start =3D tree->alloc_hint;

Please, see my comment related to alloc_hint below.

> +
>  	nidx =3D 0;
>  	node =3D hfs_bnode_find(tree, nidx);
>  	if (IS_ERR(node))
>  		return node;
> =20
> +	target =3D start;

Why do we need to introduce the target variable at all?

> +
> +	/* Seek to the map node containing the target bit */
>  	page =3D hfs_bmap_get_map_page(node, &ctx, 0);
>  	if (IS_ERR(page)) {
>  		res =3D PTR_ERR(page);
> @@ -545,27 +557,82 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *=
tree)
>  		return ERR_PTR(res);
>  	}
> =20
> +	while (target >=3D (u32)ctx.len * BITS_PER_BYTE) {
> +		target -=3D (u32)ctx.len * BITS_PER_BYTE;

Why do we decrement target?

> +		nidx =3D node->next;
> +		if (!nidx) {
> +			/* target is out of bounds, reset to start of map */
> +			target =3D 0;
> +			start =3D 0;
> +			hfs_bnode_put(node);
> +			node =3D hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
> +			if (IS_ERR(node))
> +				return node;
> +			break;
> +		}
> +
> +		hfs_bnode_put(node);
> +		node =3D hfs_bnode_find(tree, nidx);
> +		if (IS_ERR(node))
> +			return node;
> +
> +		page =3D hfs_bmap_get_map_page(node, &ctx, 0);
> +		if (IS_ERR(page)) {
> +			res =3D PTR_ERR(page);
> +			hfs_bnode_put(node);
> +			return ERR_PTR(res);
> +		}
> +	}

It looks like a specialized function.

I don't quite follow to purpose of this loop. Are we trying to find the map=
 node
here? But every node has fixed size bitmap and we can simply calculate the =
node
index and, then, get it on this basis. Am I right? I assume this logic take=
s
place because we need to follow node->next. But if we know the index in the=
 map
nodes chain, then we simply need pass by the several nodes by means of node=
-
>next without this logic. However, I think you selected simpler logic and,
anyway, you need to get the node to access the header. So, maybe, your appr=
oach
is not bad. I believe we need to have it as static inline function.

> +
> +	/* Position within the target node at the exact byte */
> +	page =3D hfs_bmap_get_map_page(node, &ctx, target / BITS_PER_BYTE);
> +	if (IS_ERR(page)) {
> +		res =3D PTR_ERR(page);
> +		hfs_bnode_put(node);
> +		return ERR_PTR(res);
> +	}
> +
>  	data =3D kmap_local_page(page);
> -	idx =3D 0;
> +	idx =3D (start / 8) * 8;
> +	bit_offset =3D target % 8;

I really dislike the hardcoded constants. Do you mean BITS_PER_BYTE here?

> =20
>  	for (;;) {
> -		while (ctx.len) {
> +		while (ctx.len && idx < tree->node_count) {
>  			byte =3D data[ctx.off];
>  			if (byte !=3D 0xff) {
> -				for (m =3D 0x80, i =3D 0; i < 8; m >>=3D 1, i++) {
> +				/* After wrapping, only check bits before the start position */
> +				int end_bit =3D (wrapped && idx =3D=3D (start / 8) * 8) ? (start % 8=
) : 8;

It's definitely longer than 80 symbols per line.

The same comment about hardcoded constants.

I think this logic needs to be in static inline function.

> +
> +				for (i =3D bit_offset, m =3D 0x80 >> bit_offset;
> +				     i < end_bit; i++, m >>=3D 1) {

Could we make this more simple and understandable?

Why m =3D 0x80 >> bit_offset and m >>=3D 1 not inside the loop's body?

I prefer to see first and second code patterns as functions of macros. It w=
ill
make the code much easier to follow.

>  					if (!(byte & m)) {
> -						idx +=3D i;
> +						found =3D idx + i;
> +
> +						/* past valid node range */
> +						if (found >=3D tree->node_count)
> +							break;
> +
>  						data[ctx.off] |=3D m;
>  						set_page_dirty(page);
>  						kunmap_local(data);
>  						tree->free_nodes--;
>  						mark_inode_dirty(tree->inode);
>  						hfs_bnode_put(node);
> -						return hfs_bnode_create(tree,
> -							idx);
> +
> +						tree->alloc_hint =3D (found + 1) % tree->node_count;

Please, see my comment related to alloc_hint.

> +						return hfs_bnode_create(tree, found);
>  					}
>  				}
>  			}
> +
> +			/* Terminate precisely if we've checked the start byte after wrapping=
 */
> +			if (wrapped && idx =3D=3D (start / 8) * 8) {

The same comment about wrapped and hardcoded constants.

> +				kunmap_local(data);
> +				hfs_bnode_put(node);
> +				return ERR_PTR(-ENOSPC);
> +			}
> +
> +			bit_offset =3D 0;
>  			if (++ctx.off >=3D PAGE_SIZE) {
>  				kunmap_local(data);
>  				page =3D node->page[++ctx.page_idx];
> @@ -577,16 +644,32 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *=
tree)
>  		}
>  		kunmap_local(data);
>  		nidx =3D node->next;
> +
>  		if (!nidx) {
> -			hfs_dbg("create new bmap node\n");
> -			next_node =3D hfs_bmap_new_bmap(node, idx);
> -		} else
> +			if (idx < tree->node_count) {
> +				/* Extend the map chain to cover newly reserved nodes */
> +				hfs_dbg("create new bmap node\n");
> +				next_node =3D hfs_bmap_new_bmap(node, idx);
> +			} else if (!wrapped) {
> +				/* Chain exhausted, wrap to scan [0, start) */
> +				wrapped =3D true;
> +				idx =3D 0;
> +				bit_offset =3D 0;
> +				next_node =3D hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
> +			} else {
> +				hfs_bnode_put(node);
> +				return ERR_PTR(-ENOSPC);
> +			}
> +		} else {
>  			next_node =3D hfs_bnode_find(tree, nidx);
> +		}
> +
>  		hfs_bnode_put(node);
> +
>  		if (IS_ERR(next_node))
>  			return next_node;
> -		node =3D next_node;
> =20
> +		node =3D next_node;
>  		page =3D hfs_bmap_get_map_page(node, &ctx, 0);
>  		if (IS_ERR(page)) {
>  			res =3D PTR_ERR(page);
> @@ -601,13 +684,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
>  {
>  	struct hfs_btree *tree;
>  	u16 off, len;
> -	u32 nidx;
> +	u32 nidx, node_id;
>  	int res;
> =20
>  	hfs_dbg("node %u\n", node->this);
>  	BUG_ON(!node->this);
>  	tree =3D node->tree;
> -	nidx =3D node->this;
> +	node_id =3D node->this;
> +	nidx =3D node_id;
>  	node =3D hfs_bnode_find(tree, 0);
>  	if (IS_ERR(node))
>  		return;
> @@ -647,6 +731,8 @@ void hfs_bmap_free(struct hfs_bnode *node)
>  	} else if (!res) {
>  		tree->free_nodes++;
>  		mark_inode_dirty(tree->inode);
> +		if (node_id < tree->alloc_hint)
> +			tree->alloc_hint =3D node_id;
>  	}
> =20
>  	hfs_bnode_put(node);
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 5f891b73a646..170ef2644204 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -49,6 +49,7 @@ struct hfs_btree {
>  	u32 leaf_tail;
>  	u32 node_count;
>  	u32 free_nodes;
> +	u32 alloc_hint;

Do we really need to introduce the alloc_hint? Could we use node_count inst=
ead?
Even if we've freed some nodes in the range lower than node_count, then doe=
s it
really makes sense to search in the lower region? If we have a lot of
free_nodes, then, probably, yes. But if we have low number of free_nodes, t=
hen
the search in lower region will be still inefficient. If we have mane
free_nodes, then we can simply start the search from the beginning. Otherwi=
se,
it doesn't make sense to try.

Thanks,
Slava.

>  	u32 attributes;
> =20
>  	unsigned int node_size;

