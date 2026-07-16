Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9873F99F5
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227247; cv=none; b=dG/rbAjiFt0Wc5axJlau8GVlsnV344jr7sju4+VicWY8Wa5qmezxOihCW1RroA7zCejeNcR07rNkX5P2/5fvSN2lyv2g36lgfAs7lRzHAQzapk9gkGCnfTvpvLtzjN5rZCiYnPhw7SRCGQOeqDClvx6ncDVfu8hleOh822shWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227247; c=relaxed/simple;
	bh=ODTMwkCkSLRy00cr58DdZi88uC4XC16VI0Hq3Qdwtww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C4zruec8GRVJQ7a87qBRnR6di9xbLDjO/B2C42H84V4Vi9xR1Kv92SVDXWNIYsFeniSn7rXXq+em7/3FmhStuGPSyhZDy305FX+IwLGAr6nDwZS7Kfn4COJuwRQ2zsU31nL6q35IArumpaauVNplKWHNVy7mAimFEyzWPh4VIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=xigU0t0x; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="xigU0t0x"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81eb41c1f1aso50315567b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784227244; x=1784832044; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vdSy1R8iBM3oBFxb7L5pKTCR5nmCXrmLm7RioHMDBNw=;
        b=xigU0t0xoT5Mj0Rcpi56QlDdjCLkDlqrn1ArSFNp5+XfyQ+yT2YKscOrm8LTV3h1QZ
         +gyqtgW26Ii7nFV0D0FpGyv5M5b9KiB+mLr/YgISUGVZFC6xoz7tGf4LDLjSrsnjqLtX
         jQ9Wz5yqy6waK1KSid27n1gdotlgNy6SSgq0F9fEqm+/JLomTVZXhBAqNKkmnWhSmPO4
         aRNyRKEpLFMqnUCkBcF5/a159CTDPjCmyAiscmmm8aYWBMOFVsTRHUp/69ij2vQvCKku
         5C7ceaKzBm7Fob2QxytU3vyJaYPcsqP4/D1naK+WQk2gn2pQKDkRu/90gUzM/Kbpp23y
         zQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784227244; x=1784832044;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vdSy1R8iBM3oBFxb7L5pKTCR5nmCXrmLm7RioHMDBNw=;
        b=AgDrskP7t45pq8oQLKpDIDmRt0xx56F0V0DlJI/QLrOR9ilWI3tJ3pmXfLYnWhK+QP
         IKLLK30ahtD5dtY6OrzNwjMow/qj0E+Yxu5JTRf/XNPLWJRLkoLwt2LExbX7xYnFd/nW
         g8Iiu5VJT9HCpM/xBNf1ByF/J3lFChGjorIUWVLVNAIU0s7FFrjXBmWI2Tt1wMhduUcl
         TcDiW1NxFBWgJZN2j4ekLY1fBtsCA020lwaEmm/QWfeCnYZb7N+z4W342csSCvc8q2yu
         mAYOo6N7WOsrMRU03m2QNosn9b5Pb1rGQ4ZuY3mWVkrbQTYhjWW+5Z9PNjDNJGwx07Bi
         pS0g==
X-Forwarded-Encrypted: i=1; AHgh+RpkD9s1B8UGMIh1+x7MsTwmKz5myt+r/VTUQRd5ffTbnrFzk26EFLqJSkaziO/P37C5KnfFovItF3+082+T@vger.kernel.org
X-Gm-Message-State: AOJu0Yznlg/6zZS170FpdbHeJ4xmJc1Eyja7AicX+5U/bav8leV5rlk5
	/g1FM+GQ0S8sWlFIr9M1DeZWWhLKYQ7zG+qdLOb/lkgI2VbLVJhiCxn5xeqmJmkBYnU=
X-Gm-Gg: AfdE7clA7d4TBelwJI8HSdp1PMPgNvbiLnuogFxZpGfdQl0DqKbk0exLHs8Oo3sMJ8Q
	hDwrm6fFeGsw9Je7iGx+dcF0Yelr8sDs5iXZk+Mjk25KjqseV5/IEatjhKB8FJOIoHAywkaY7x8
	qvNd2SqkgzYFk464BZJCPpc0cJjgWaVZVPUFbvgyPGcftj5P0mOrjdZtAtOczil0RWNW8B2SFOM
	ez5/prX17ZLip1Vt/3tV7CECkyT42c4neN4RqPb6ZjYXPuNEgowWBhdtzVEIG9Q4jtwwFqswUHE
	tuzBiRA9eIu+tnuXJDoi4ojrq1qeMtQtqSNoi4QNpL9FnDZBkFQhUWPf7sT1FB0EjyKNwR6Qu0s
	p+3mWSGQ9Hn/y6kLRjvgQk/AgY1aLKE7NM/QFDCRyZxLRqZCV2E5MgxhtXKUz6LuSqZYsx6BeP8
	nL6rL3jx+plamUP+of0pzhCAdxB/X+7qeDFgrPk7Oy7FvSpQ9sEMXEjN7DPjAv0vkgGZ9udGD1z
	ASHMZLugpSqcZlOheJJ3fc7GjviKmKTQjDy8KY/s088Li42GX8khOsVxipmAevrb4lSxqI=
X-Received: by 2002:a05:690c:e1f:b0:80d:5978:9730 with SMTP id 00721157ae682-81ebffea556mr86174907b3.43.1784227243634;
        Thu, 16 Jul 2026 11:40:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:1ec9:9caa:73bc:e646? ([2600:1700:6476:1430:1ec9:9caa:73bc:e646])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1a32e2sm201582307b3.30.2026.07.16.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:40:43 -0700 (PDT)
Message-ID: <b4239533adf8a57f5e3fc2debd715ad904d77870.camel@dubeyko.com>
Subject: Re: [PATCH v6] hfs: port HFS+ b-tree bitmap corruption check
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 16 Jul 2026 11:40:39 -0700
In-Reply-To: <20260716074150.1660-1-aditya.ansh182@gmail.com>
References: <20260716074150.1660-1-aditya.ansh182@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-16 at 07:41 +0000, Aditya Prakash Srivastava wrote:
> In HFS+ filesystems, during b-tree open (hfs_btree_open()), the code
> verifies that the allocation map bit for the tree header (node 0) is
> set. If not, it indicates a corrupted map record/bitmap and mounts
> the volume as read-only (SB_RDONLY) to prevent further damage.
>=20
> HFS filesystems share the same b-tree structure but currently lack
> this corruption detection check.
>=20
> Port this check to HFS, aligning its implementation with HFS+ to
> maintain consistent b-tree logic across both filesystems:
> 1. Define struct hfs_bmap_ctx, and define HFS_TREE_HEAD and the
> relevant
> =C2=A0=C2=A0 map record indices in include/linux/hfs_common.h.
> 2. Port the necessary offset and length validation helpers to
> =C2=A0=C2=A0 fs/hfs/btree.h as static inline functions with robust null p=
ointer
> =C2=A0=C2=A0 checks.
> 3. Implement static hfs_bmap_get_map_page() in fs/hfs/btree.c.
> 4. Implement static hfs_bmap_test_bit() in fs/hfs/btree.c to inspect
> =C2=A0=C2=A0 the B-tree bitmap using the get_map_page helper.
> 5. Implement static hfs_bmap_clear_bit() in fs/hfs/btree.c.
> 6. Rewrite hfs_bmap_alloc() in fs/hfs/btree.c to use the unified
> =C2=A0=C2=A0 hfs_bmap_get_map_page() helper, eliminating redundant page a=
nd
> offset
> =C2=A0=C2=A0 calculation code.
> 7. Refactor hfs_bmap_free() in fs/hfs/btree.c to use the new
> =C2=A0=C2=A0 hfs_bmap_clear_bit() helper.
> 8. In hfs_btree_open(), retrieve the header node via
> hfs_bnode_find(),
> =C2=A0=C2=A0 test its allocation bit with hfs_bmap_test_bit(), and releas=
e it
> =C2=A0=C2=A0 using hfs_bnode_put().
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Link:
> https://lore.kernel.org/all/6a36101b.be22b350.2a3e9.0001.GAE@google.com/T=
/#r446d0fed2a2900bd805534bbcb799d86619ae2ea
> Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
> ---
> =C2=A0fs/hfs/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 --------
> =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 210 +++++++++++++++++++++++++++++------
> --
> =C2=A0fs/hfs/btree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 40 +++++++
> =C2=A0include/linux/hfs_common.h |=C2=A0 13 ++-
> =C2=A04 files changed, 218 insertions(+), 87 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index da8e5342c91c..1b331108d9c0 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -15,48 +15,6 @@
> =C2=A0
> =C2=A0#include "btree.h"
> =C2=A0
> -static inline
> -bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
> -{
> -	bool is_valid =3D off < node->tree->node_size;
> -
> -	if (!is_valid) {
> -		pr_err("requested invalid offset: "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "NODE: id %u, type %#x, height %u=
, "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node_size %u, offset %u\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off);
> -	}
> -
> -	return is_valid;
> -}
> -
> -static inline
> -u32 check_and_correct_requested_length(struct hfs_bnode *node, u32
> off, u32 len)
> -{
> -	unsigned int node_size;
> -
> -	if (!is_bnode_offset_valid(node, off))
> -		return 0;
> -
> -	node_size =3D node->tree->node_size;
> -
> -	if ((u64)off + len > node_size) {
> -		u32 new_len =3D node_size - off;
> -
> -		pr_err("requested length has been corrected: "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "NODE: id %u, type %#x, height %u=
, "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node_size %u, offset %u, "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "requested_len %u, corrected_len =
%u\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off, len, =
new_len);
> -
> -		return new_len;
> -	}
> -
> -	return len;
> -}
> -
> =C2=A0void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32
> len)
> =C2=A0{
> =C2=A0	struct page *page;
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2eb37a2f64e8..41b4e8fc9463 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -15,6 +15,121 @@
> =C2=A0
> =C2=A0#include "btree.h"
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
> +					=C2=A0 struct hfs_bmap_ctx *ctx,
> +					=C2=A0 u32 byte_offset)
> +{
> +	u16 rec_idx, off16;
> +	unsigned int page_off;
> +
> +	if (node->this =3D=3D HFS_TREE_HEAD) {
> +		if (node->type !=3D HFS_NODE_HEADER) {
> +			pr_err("hfs: invalid btree header node\n");
> +			return ERR_PTR(-EIO);
> +		}
> +		rec_idx =3D HFS_BTREE_HDR_MAP_REC_INDEX;
> +	} else {
> +		if (node->type !=3D HFS_NODE_MAP) {
> +			pr_err("hfs: invalid btree map node\n");
> +			return ERR_PTR(-EIO);
> +		}
> +		rec_idx =3D HFS_BTREE_MAP_NODE_REC_INDEX;
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
> + * hfs_bmap_test_bit - test a bit in the b-tree map
> + * @node: the b-tree node containing the map record
> + * @node_bit_idx: the relative bit index within the node's map
> record
> + *
> + * Returns true if set, false if clear or on failure.
> + */
> +static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32
> node_bit_idx)
> +{
> +	struct hfs_bmap_ctx ctx;
> +	struct page *page;
> +	u8 *bmap, byte, mask;
> +
> +	page =3D hfs_bmap_get_map_page(node, &ctx, node_bit_idx /
> BITS_PER_BYTE);
> +	if (IS_ERR(page))
> +		return false;
> +
> +	bmap =3D kmap_local_page(page);
> +	byte =3D bmap[ctx.off];
> +	kunmap_local(bmap);
> +
> +	mask =3D 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
> +	return (byte & mask) !=3D 0;
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
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
> btree_keycmp keycmp)
> =C2=A0{
> @@ -23,6 +138,7 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	struct address_space *mapping;
> =C2=A0	struct folio *folio;
> =C2=A0	struct buffer_head *bh;
> +	struct hfs_bnode *node;
> =C2=A0	unsigned int size;
> =C2=A0	u16 dblock;
> =C2=A0	sector_t start_block;
> @@ -155,6 +271,20 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	kunmap_local(head);
> =C2=A0	folio_unlock(folio);
> =C2=A0	folio_put(folio);
> +
> +	node =3D hfs_bnode_find(tree, HFS_TREE_HEAD);
> +	if (IS_ERR(node))
> +		goto free_inode;
> +
> +	if (!hfs_bmap_test_bit(node, HFS_TREE_HEAD)) {
> +		pr_warn("(%s): %s (cnid 0x%x) bitmap corrupted,
> forcing rdonly\n",
> +			sb->s_id, id =3D=3D HFS_EXT_CNID ? "extents" :
> "catalog", id);
> +		pr_warn("Run fsck.hfs to repair.\n");
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +
> +	hfs_bnode_put(node);
> +
> =C2=A0	return tree;
> =C2=A0
> =C2=A0fail_folio:
> @@ -285,11 +415,9 @@ int hfs_bmap_reserve(struct hfs_btree *tree, u32
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
> @@ -301,24 +429,26 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> hfs_btree *tree)
> =C2=A0	node =3D hfs_bnode_find(tree, nidx);
> =C2=A0	if (IS_ERR(node))
> =C2=A0		return node;
> -	len =3D hfs_brec_lenoff(node, 2, &off16);
> -	off =3D off16;
> =C2=A0
> -	off +=3D node->page_offset;
> -	pagep =3D node->page + (off >> PAGE_SHIFT);
> -	data =3D kmap_local_page(*pagep);
> -	off &=3D ~PAGE_MASK;
> +	page =3D hfs_bmap_get_map_page(node, &ctx, 0);
> +	if (IS_ERR(page)) {
> +		res =3D PTR_ERR(page);
> +		hfs_bnode_put(node);
> +		return ERR_PTR(res);
> +	}
> +
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
> @@ -327,13 +457,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct
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
> @@ -347,22 +478,22 @@ struct hfs_bnode *hfs_bmap_alloc(struct
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
> =C2=A0	tree =3D node->tree;
> @@ -396,23 +527,18 @@ void hfs_bmap_free(struct hfs_bnode *node)
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
> +
> +	res =3D hfs_bmap_clear_bit(node, nidx);
> +	if (res =3D=3D -EINVAL) {
> =C2=A0		pr_crit("trying to free free bnode %u(%d)\n",
> -			node->this, node->type);
> -		kunmap_local(data);
> -		hfs_bnode_put(node);
> -		return;
> +			nidx, node->type);
> +	} else if (res) {
> +		pr_crit("fail to free bnode %u(%d)\n",
> +			nidx, node->type);
> +	} else {
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
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 99be858b2446..b4c3f2a31471 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -129,3 +129,43 @@ extern int __hfs_brec_find(struct hfs_bnode
> *bnode, struct hfs_find_data *fd);
> =C2=A0extern int hfs_brec_find(struct hfs_find_data *fd);
> =C2=A0extern int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32
> rec_len);
> =C2=A0extern int hfs_brec_goto(struct hfs_find_data *fd, int cnt);
> +
> +static inline bool is_bnode_offset_valid(struct hfs_bnode *node, u32
> off)
> +{
> +	bool is_valid;
> +
> +	if (!node || !node->tree)
> +		return false;
> +
> +	is_valid =3D off < node->tree->node_size;
> +
> +	if (!is_valid) {
> +		pr_err("invalid offset: id %u, type %#x, h %u, sz
> %u, off %u\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off);
> +	}
> +
> +	return is_valid;
> +}
> +
> +static inline u32 check_and_correct_requested_length(struct
> hfs_bnode *node, u32 off, u32 len)
> +{
> +	unsigned int node_size;
> +
> +	if (!is_bnode_offset_valid(node, off))
> +		return 0;
> +
> +	node_size =3D node->tree->node_size;
> +
> +	if ((u64)off + len > node_size) {
> +		u32 new_len =3D node_size - off;
> +
> +		pr_err("corrected len: id %u, type %#x, h %u, sz %u,
> off %u, len %u->%u\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_size, off, len, new_len);
> +
> +		return new_len;
> +	}
> +
> +	return len;
> +}
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> index 45fb4c9ff9f5..d6a615e74b26 100644
> --- a/include/linux/hfs_common.h
> +++ b/include/linux/hfs_common.h
> @@ -510,14 +510,21 @@ struct hfs_btree_header_rec {
> =C2=A0						=C2=A0=C2=A0 b-tree but not in
> extents
> =C2=A0						=C2=A0=C2=A0 b-tree (hfsplus).
> */
> =C2=A0
> +/* HFS BTree misc info */
> +#define HFS_TREE_HEAD				0
> +#define HFS_BTREE_HDR_MAP_REC_INDEX		2	/* Map
> (bitmap) record in Header node */
> +#define HFS_BTREE_MAP_NODE_REC_INDEX		0	/* Map
> record in Map Node */
> +
> =C2=A0/* HFS+ BTree misc info */
> -#define HFSPLUS_TREE_HEAD			0
> +#define HFSPLUS_TREE_HEAD			HFS_TREE_HEAD
> =C2=A0#define HFSPLUS_NODE_MXSZ			32768
> =C2=A0#define HFSPLUS_NODE_MINSZ			512
> =C2=A0#define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
> =C2=A0#define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
> -#define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/*
> Map (bitmap) record in Header node */
> -#define HFSPLUS_BTREE_MAP_NODE_REC_INDEX	0	/* Map
> record in Map Node */
> +/* Map (bitmap) record in Header node */
> +#define
> HFSPLUS_BTREE_HDR_MAP_REC_INDEX		HFS_BTREE_HDR_MAP_REC_INDEX
> +/* Map record in Map Node */
> +#define
> HFSPLUS_BTREE_MAP_NODE_REC_INDEX	HFS_BTREE_MAP_NODE_REC_INDEX
> =C2=A0#define HFSPLUS_BTREE_HDR_USER_BYTES		128
> =C2=A0#define HFSPLUS_BTREE_MAP_NODE_RECS_COUNT	2
> =C2=A0#define HFSPLUS_BTREE_MAP_NODE_RESERVED_BYTES	2

Looks good. Thanks a lot for the patch.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
