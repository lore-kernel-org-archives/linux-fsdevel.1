Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7919CD1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889293; cv=none; b=GTZDlf5wJ5p5R0LpuHarC4+CZvioqxc/rMUgT48Gdlqv66+uZCyfYyTnUYpiuu9dXm/llfGK7LTBjOXynG977GzH/Ncx76l77tfU1albDFHtmh9EUuNC/DVna0dKta+/hwvDEwkq2AooGN9nSNxv96x5y5JAw4VHzHpo2zLFybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889293; c=relaxed/simple;
	bh=98DRMKun/zb3uveopVlTSZimCPpHmZmNudZFmY9TYec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mEzN65zi4gg1Kzl08zEQrGs+7OOR97rvOEPE1tqYQEdrPFTTpwYv/wA9L4lIUtguUo2R6NAC8CtJh6NspWKeeHUKQ87DDWwjZmNW6fVmnXTD0sRlidwTBwUlFCrKq/Qvs2WvHrZ/ss2wTHL7iaDlMqFL1aSJ/0xYBmGND1C7/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=W5G1uSnT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="W5G1uSnT"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a40fb9890so6169077b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 20:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773889290; x=1774494090; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dTxilh9rTWTv+fcGpttSAC6bvdIVxRtk5w2Cn9IfqPc=;
        b=W5G1uSnTZ1o4N5capMZOXNzRLgb7HkYqFtvTsju1SGG9SLVILeAy0MO2C3bn0iHYxp
         kcyXgzYMV/TjXwCxh3Ki1i6mOuJNT0M5nMnlkxD+n0+l2s68VfKGTP9VbQqArpKYpozg
         5htjhslrQb1N+02uwwkCWgt92tw6sUnc+jjxBtbjmknKhSR/sfVDcipx0CW+22pT27x3
         T85mFaMeUAQz0vaj+LtQwoxpcqFvT4gNSxCH5Zh0DJXZpLUv2W76hJvt2Z0kKzcklE6N
         53B1NG2kc7HRKNv4Ri/OcO2opucYxv6PndMSmRfhHDTspffH/o/H3Q7qLe0NQ0jCwlU0
         yJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773889290; x=1774494090;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTxilh9rTWTv+fcGpttSAC6bvdIVxRtk5w2Cn9IfqPc=;
        b=UspQrjtdvDp+vEHcQ7ijoiU3V7LXovHxeTZvWu0DUo9FysFFiBaCbqUzIG5OAEE+np
         tmnWGV0g6GYhzOIQLyJ7zZ0+gVwIv14MRtW8l542vZ56llgfoMwBVNWOr536seG9bDYq
         Xq36t1ip8I2H/RCrL3qXRixc7wDwkgxBkcszUk/7CSXEB5Nda4pyuv+JCr+mZQSdQL/h
         WAipRVg9Njz+3GQAQRbpW+ZFCu6FFJA2QFJqtFN/+baGTDs1QOkPlnSD9TFMjE855RL3
         BIh5zv4GDGdXD/8Rtv2sdA1liDotTUngQzDEu07ZpAXt1qPBKVG01kGMPOPNBzdKTds4
         x4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWoEOXUovTzGZtlMVaD882TXWIjmz12dPF2hyLXJ/tTv6yKEqfz4yi/+PHkITsSCH0luN5Si4VpikV1Pz5u@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9DxkR9gZ9UyY6u7QKLWZH1L5lJL7rTDP2T4nY0wq0cfLDvkWL
	+XaTaPpbP8F/ul8ZrLFIezEltRx5BekLMzrZKOkNP0MAXGmC0guqlJqOYMt17PyDikw=
X-Gm-Gg: ATEYQzwGZZ3D9p4bcb70fwwS7qtM2dGv01CV3yrJD/p53S0tFp7Nik5t1Mp2YEH/9fi
	J3LaVJtWTAlgh36b/g3Y8qnzfkCD6PsI9ix1FPDbjJx6rWLnq+eTnIKg96oLeU6KCFsRdeS3sGw
	kJi2T1lueBw21W0EIg2ktfQDL2ItpVUgZn2ibZgWAdGX7ngBsuCn6J1E1lCyKk2VBglP62+ru4V
	d3hYSM8saO/4bB8O6ptdgHMfVIL6Ar0xm6QIj8Fx2SC445Q+vjV0GaJfQzX0Etih4a2wF9cxCWQ
	USLnWW+VeKkl7wBI+YTqkoZHk157kYwUVYho/Cv7wgwrxElOVWXyEObTZJj/iuiIMGDlM2jy/nG
	NGLuHBVlcvub2AUOQmE5PRByqdql3LMqqNidIM4Uz6R4D4hlvhl3MkY2tlHcpA/KxaWPbJbTd/X
	hmvo1tGlKMGI9jNKqBAHRpHdB5GBtNt+uLuARI41mO/UeS9yP4orMI/PDEMhA5ODgguDOToK1vt
	JIxSTG4SE12dHjpZ0oGmdvAvzOEY68uUWoaS5NjO0VkYUjGHCBX9Lhmu0fN
X-Received: by 2002:a05:690c:c50a:b0:79a:65af:7f4d with SMTP id 00721157ae682-79a7180070emr62495577b3.1.1773889290093;
        Wed, 18 Mar 2026 20:01:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:fbb1:1a9c:e8af:d8ed? ([2600:1700:6476:1430:fbb1:1a9c:e8af:d8ed])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a715dab4esm29019357b3.41.2026.03.18.20.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:01:29 -0700 (PDT)
Message-ID: <51586c26d1bdacaafb2d6396450d980e860f4104.camel@dubeyko.com>
Subject: Re: [PATCH v7 1/2] hfsplus: refactor b-tree map page access and add
 node-type validation
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Wed, 18 Mar 2026 20:01:26 -0700
In-Reply-To: <20260318073823.3933718-2-shardul.b@mpiricsoftware.com>
References: <20260318073823.3933718-1-shardul.b@mpiricsoftware.com>
	 <20260318073823.3933718-2-shardul.b@mpiricsoftware.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-18 at 13:08 +0530, Shardul Bankar wrote:
> In HFS+ b-trees, the node allocation bitmap is stored across multiple
> records. The first chunk resides in the b-tree Header Node at record
> index 2, while all subsequent chunks are stored in dedicated Map
> Nodes
> at record index 0.
>=20
> This structural quirk forces callers like hfs_bmap_alloc() and
> hfs_bmap_free() to duplicate boilerplate code to validate offsets,
> correct
> lengths, and map the underlying pages via kmap_local_page(). There is
> also currently no strict node-type validation before reading these
> records, leaving the allocator vulnerable if a corrupted image points
> a
> map linkage to an Index or Leaf node.
>=20
> Introduce a unified bit-level API to encapsulate the map record
> access:
> 1. A new `struct hfs_bmap_ctx` to cleanly pass state and safely
> handle
> =C2=A0=C2=A0 page math across all architectures.
> 2. `hfs_bmap_get_map_page()`: Automatically validates node types
> =C2=A0=C2=A0 (HFS_NODE_HEADER vs HFS_NODE_MAP), infers the correct record
> index,
> =C2=A0=C2=A0 handles page-boundary math, and returns the unmapped `struct=
 page
> *`
> =C2=A0=C2=A0 directly to the caller to avoid asymmetric mappings.
> 3. `hfs_bmap_clear_bit()`: A clean wrapper that internally handles
> page
> =C2=A0=C2=A0 mapping/unmapping for single-bit operations.
>=20
> Refactor hfs_bmap_alloc() and hfs_bmap_free() to utilize this new
> API.
> This deduplicates the allocator logic, hardens the map traversal
> against
> fuzzed images, and provides the exact abstractions needed for
> upcoming
> mount-time validation checks.
>=20
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
> =C2=A0fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 169 ++++++++++++++++++++++++++---------
> --
> =C2=A0include/linux/hfs_common.h |=C2=A0=C2=A0 2 +
> =C2=A02 files changed, 124 insertions(+), 47 deletions(-)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 1220a2f22737..64d168347b4b 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -129,6 +129,95 @@ u32 hfsplus_calc_btree_clump_size(u32
> block_size, u32 node_size,
> =C2=A0	return clump_size;
> =C2=A0}
> =C2=A0
> +/* Context for iterating b-tree map pages
> + * @page_idx: The index of the page within the b-node's page array
> + * @off: The byte offset within the mapped page
> + * @len: The remaining length of the map record
> + */
> +struct hfs_bmap_ctx {
> +	unsigned int page_idx;
> +	unsigned int off;
> +	u16 len;
> +};
> +
> +/*
> + * Finds the specific page containing the requested byte offset
> within the map
> + * record. Automatically handles the difference between header and
> map nodes.
> + * Returns the struct page pointer, or an ERR_PTR on failure.
> + * Note: The caller is responsible for mapping/unmapping the
> returned page.
> + */
> +static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
> struct hfs_bmap_ctx *ctx,
> +				u32 byte_offset)
> +{
> +	u16 rec_idx, off16;
> +	unsigned int page_off;
> +
> +	if (node->this =3D=3D HFSPLUS_TREE_HEAD) {
> +		if (node->type !=3D HFS_NODE_HEADER) {
> +			pr_err("hfsplus: invalid btree header
> node\n");
> +			return ERR_PTR(-EIO);
> +		}
> +		rec_idx =3D HFSPLUS_BTREE_HDR_MAP_REC_INDEX;
> +	} else {
> +		if (node->type !=3D HFS_NODE_MAP) {
> +			pr_err("hfsplus: invalid btree map node\n");
> +			return ERR_PTR(-EIO);
> +		}
> +		rec_idx =3D HFSPLUS_BTREE_MAP_NODE_REC_INDEX;
> +	}
> +
> +	ctx->len =3D hfs_brec_lenoff(node, rec_idx, &off16);
> +	if (!ctx->len)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (!is_bnode_offset_valid(node, off16))
> +		return ERR_PTR(-EIO);
> +
> +	ctx->len =3D check_and_correct_requested_length(node, off16,
> ctx->len);
> +
> +	if (byte_offset >=3D ctx->len)
> +		return ERR_PTR(-EINVAL);
> +
> +	page_off =3D (u32)off16 + node->page_offset + byte_offset;
> +	ctx->page_idx =3D page_off >> PAGE_SHIFT;
> +	ctx->off =3D page_off & ~PAGE_MASK;
> +
> +	return node->page[ctx->page_idx];
> +}
> +
> +/**
> + * hfs_bmap_clear_bit - clear a bit in the b-tree map
> + * @node: the b-tree node containing the map record
> + * @node_bit_idx: the relative bit index within the node's map
> record
> + *
> + * Returns 0 on success, -EINVAL if already clear, or negative error
> code.
> + */
> +static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32
> node_bit_idx)
> +{
> +	struct hfs_bmap_ctx ctx;
> +	struct page *page;
> +	u8 *bmap, mask;
> +
> +	page =3D hfs_bmap_get_map_page(node, &ctx, node_bit_idx /
> BITS_PER_BYTE);
> +	if (IS_ERR(page))
> +		return PTR_ERR(page);
> +
> +	bmap =3D kmap_local_page(page);
> +
> +	mask =3D 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
> +
> +	if (!(bmap[ctx.off] & mask)) {
> +		kunmap_local(bmap);
> +		return -EINVAL;
> +	}
> +
> +	bmap[ctx.off] &=3D ~mask;
> +	set_page_dirty(page);
> +	kunmap_local(bmap);
> +
> +	return 0;
> +}
> +
> =C2=A0/* Get a reference to a B*Tree and do some initial checks */
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
> =C2=A0{
> @@ -374,11 +463,9 @@ int hfs_bmap_reserve(struct hfs_btree *tree, u32
> rsvd_nodes)
> =C2=A0struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
> =C2=A0{
> =C2=A0	struct hfs_bnode *node, *next_node;
> -	struct page **pagep;
> +	struct hfs_bmap_ctx ctx;
> +	struct page *page;
> =C2=A0	u32 nidx, idx;
> -	unsigned off;
> -	u16 off16;
> -	u16 len;
> =C2=A0	u8 *data, byte, m;
> =C2=A0	int i, res;
> =C2=A0
> @@ -390,30 +477,26 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> hfs_btree *tree)
> =C2=A0	node =3D hfs_bnode_find(tree, nidx);
> =C2=A0	if (IS_ERR(node))
> =C2=A0		return node;
> -	len =3D hfs_brec_lenoff(node, 2, &off16);
> -	off =3D off16;
> =C2=A0
> -	if (!is_bnode_offset_valid(node, off)) {
> +	page =3D hfs_bmap_get_map_page(node, &ctx, 0);
> +	if (IS_ERR(page)) {
> +		res =3D PTR_ERR(page);
> =C2=A0		hfs_bnode_put(node);
> -		return ERR_PTR(-EIO);
> +		return ERR_PTR(res);
> =C2=A0	}
> -	len =3D check_and_correct_requested_length(node, off, len);
> =C2=A0
> -	off +=3D node->page_offset;
> -	pagep =3D node->page + (off >> PAGE_SHIFT);
> -	data =3D kmap_local_page(*pagep);
> -	off &=3D ~PAGE_MASK;
> +	data =3D kmap_local_page(page);
> =C2=A0	idx =3D 0;
> =C2=A0
> =C2=A0	for (;;) {
> -		while (len) {
> -			byte =3D data[off];
> +		while (ctx.len) {
> +			byte =3D data[ctx.off];
> =C2=A0			if (byte !=3D 0xff) {
> =C2=A0				for (m =3D 0x80, i =3D 0; i < 8; m >>=3D
> 1, i++) {
> =C2=A0					if (!(byte & m)) {
> =C2=A0						idx +=3D i;
> -						data[off] |=3D m;
> -
> 						set_page_dirty(*pagep);
> +						data[ctx.off] |=3D m;
> +						set_page_dirty(page)
> ;
> =C2=A0						kunmap_local(data);
> =C2=A0						tree->free_nodes--;
> =C2=A0						mark_inode_dirty(tre
> e->inode);
> @@ -423,13 +506,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> hfs_btree *tree)
> =C2=A0					}
> =C2=A0				}
> =C2=A0			}
> -			if (++off >=3D PAGE_SIZE) {
> +			if (++ctx.off >=3D PAGE_SIZE) {
> =C2=A0				kunmap_local(data);
> -				data =3D kmap_local_page(*++pagep);
> -				off =3D 0;
> +				page =3D node->page[++ctx.page_idx];
> +				data =3D kmap_local_page(page);
> +				ctx.off =3D 0;
> =C2=A0			}
> =C2=A0			idx +=3D 8;
> -			len--;
> +			ctx.len--;
> =C2=A0		}
> =C2=A0		kunmap_local(data);
> =C2=A0		nidx =3D node->next;
> @@ -443,22 +527,22 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> hfs_btree *tree)
> =C2=A0			return next_node;
> =C2=A0		node =3D next_node;
> =C2=A0
> -		len =3D hfs_brec_lenoff(node, 0, &off16);
> -		off =3D off16;
> -		off +=3D node->page_offset;
> -		pagep =3D node->page + (off >> PAGE_SHIFT);
> -		data =3D kmap_local_page(*pagep);
> -		off &=3D ~PAGE_MASK;
> +		page =3D hfs_bmap_get_map_page(node, &ctx, 0);
> +		if (IS_ERR(page)) {
> +			res =3D PTR_ERR(page);
> +			hfs_bnode_put(node);
> +			return ERR_PTR(res);
> +		}
> +		data =3D kmap_local_page(page);
> =C2=A0	}
> =C2=A0}
> =C2=A0
> =C2=A0void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> -	struct page *page;
> =C2=A0	u16 off, len;
> =C2=A0	u32 nidx;
> -	u8 *data, byte, m;
> +	int res;
> =C2=A0
> =C2=A0	hfs_dbg("node %u\n", node->this);
> =C2=A0	BUG_ON(!node->this);
> @@ -495,24 +579,15 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0		}
> =C2=A0		len =3D hfs_brec_lenoff(node, 0, &off);
> =C2=A0	}
> -	off +=3D node->page_offset + nidx / 8;
> -	page =3D node->page[off >> PAGE_SHIFT];
> -	data =3D kmap_local_page(page);
> -	off &=3D ~PAGE_MASK;
> -	m =3D 1 << (~nidx & 7);
> -	byte =3D data[off];
> -	if (!(byte & m)) {
> -		pr_crit("trying to free free bnode "
> -				"%u(%d)\n",
> -			node->this, node->type);
> -		kunmap_local(data);
> -		hfs_bnode_put(node);
> -		return;
> +
> +	res =3D hfs_bmap_clear_bit(node, nidx);
> +	if (res =3D=3D -EINVAL) {
> +		pr_crit("trying to free free bnode %u(%d)\n",
> +				node->this, node->type);
> +	} else if (!res) {
> +		tree->free_nodes++;
> +		mark_inode_dirty(tree->inode);
> =C2=A0	}
> -	data[off] =3D byte & ~m;
> -	set_page_dirty(page);
> -	kunmap_local(data);
> +
> =C2=A0	hfs_bnode_put(node);
> -	tree->free_nodes++;
> -	mark_inode_dirty(tree->inode);
> =C2=A0}
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> index dadb5e0aa8a3..be24c687858e 100644
> --- a/include/linux/hfs_common.h
> +++ b/include/linux/hfs_common.h
> @@ -510,6 +510,8 @@ struct hfs_btree_header_rec {
> =C2=A0#define HFSPLUS_NODE_MXSZ			32768
> =C2=A0#define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
> =C2=A0#define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
> +#define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/*
> Map (bitmap) record in Header node */
> +#define HFSPLUS_BTREE_MAP_NODE_REC_INDEX	0	/* Map
> record in Map Node */
> =C2=A0#define HFSPLUS_BTREE_HDR_USER_BYTES		128
> =C2=A0
> =C2=A0/* btree key type */


Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

The xfstests run hasn't revealed any new issues.

Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
