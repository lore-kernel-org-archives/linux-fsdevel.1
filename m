Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3848C8B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137058; cv=none; b=uQzLmJbofMcYnP9WtVFtfSHl3VuuMMvhkK2bypMwb8U/hCmf6rHs4+tNLiLl75+2gqOU3iaXs9kimDwt4J9sZr5Fmrhb5yuVF3Yt4eadvBpndj6ttiTbX/PInkRyEv8azYuph0NfmBfkAjibuVLrdxfm6lys+X8Syt8NzMUTj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137058; c=relaxed/simple;
	bh=Of4fzvNTCgrVaJLvSsyLtJwJGWstyJJJVHYirNpl+nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cIBYZXnDGRHe2x2iB7vzvTSbZVOoMkzJtxx4wgfJdx495qabrAP0Qglmda1dE2n7zV9hL1mdrgw33GqEnd+ZH1goSjI2YRsfDn7/h0fMLDN3xH0f+uKldlYkLXFEeQAZkiG8+BTlqBjOjoSjjDH0woCve4dF4V/WFuy4X7LX4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=UWQfeRjx; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="UWQfeRjx"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6626b5ace23so1418759d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784137055; x=1784741855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkWu60zSB0C+7mxaTrozGgmBrFwprz7xtoMjl9fcfXA=;
        b=UWQfeRjxajT3FfNhGmbIb2bfCp8U5NtEp+kzqD/EzNMCwRa/5tf7W7dXJ2UtIJrFrJ
         hKinKSICwGjcGTPOuMbCGkPb9smZbP/G4SvQQ2j2ueAuYDq0mUvaVqbe3I+t3V29NbPz
         WD9MfDvg67r7RCj8m0Fbd51ducTKgNyM+ISLN2ziHgl6CzXg2V1ZR8HPSwDjF3PTD8rK
         KV5zoDQYqYu7hiI/B+8d/+xGCqI4xAtKuB95hZ8xeshq1W4DZxDKM+pysPHvTXCVEbHO
         5zGaau5KkMyNf5eoX0LpqoB7TIkAyIf0Mlw2OS4jrAvLNP0bjfewTMRzIIWHq/nlCL4p
         sBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137055; x=1784741855;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lkWu60zSB0C+7mxaTrozGgmBrFwprz7xtoMjl9fcfXA=;
        b=tG6qw27dIoxBTngI7YDNWTZsBhpANrRsfhCBocRNBrYuGTwJTpDwfP/MEn1jlgdzOI
         n+lH0Sa8uGnv2LZOG3cTJMT1AyQcEXgDhoJknaldfrXOrEeeGr+/r75mf3RBo1zl8iq5
         AEge0swlu1Ax6QxS3elYAjBd0t6rsP9WQFAz8Oc4NpkLWmcEiZAakxO3VRe335oscc6T
         3AIMzMs35cgzdZi6klGGbA0a4eFsXiVUNo+MakjXEImLRYO/esFvwKFKf+CenYhEBzKZ
         b9N3RVQz0w1hNdkyQKqBs06sdi+L8axqUHG+my6YOxIkDUv/x5RuDgWsska/2Bh1pfrK
         3yIA==
X-Forwarded-Encrypted: i=1; AHgh+RqMcAU20IzvsxvtMbeo+kzfdGJxsvW/WzgsPm5N3P5OJ6/4PHLh0poQuI6MNEb0JYDDr44gRjmPBVHv7dJu@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKwltpp6rULwbTXwqQT4nhf/XTVrc3dGJJ1nnJMaa9n5oShxx
	4jy7fhrV8zNgpi6AKA/kgIK5B17wWanIo3x1a5k8Elyb0HBeJktptefW8H1/q7eoRrSFIQQUzol
	kYSTWqrsICw==
X-Gm-Gg: AfdE7ckllklW4YZVnQsxldfgxfCWDBXfVZQvL8C1KH3v15wncFypocccDPYSJEIxJcQ
	/5Myblge76gMFYS9wfqGlf+YquefuAc5A832IWbku0rqplUM/k5B1XcZHnG2pmaVIaVaHSxnUG8
	ETCx0c7FxxOdXuqrLiq/5exlD9esJFvjF4Ozdl9epswZmajnxZ8RV6qP77WXH6+OwLVme5xD7Py
	j7aLJNvfBpSNCXp5jJMPsoOO5gKPm67CRsw5sHAnqEbtP3YlIg4hzRTmzUDE6XgplLRIrVSn9fc
	Oj3ARGl1p2b4Px74a1ToWOjRQUw/16uZPxwtepN6UShbRBzlsmoURPVu7Tnd3quI68jPtMVRB0j
	YxLyQtwEu3fAHMT6XauAeEPVDbfc2zYK+ykmFRIsfGwrriS6xsiivYGJ/E25soh9+tPxtVGFYvQ
	LkUrA2zTWgEvq+1lbwIHx1RglWREtwnMfbqqgX7lDhp8q76jU39UIybRoGn0d4ubJ7wyhnEjvxL
	LDQBrzej1rQ3kVaJ5HTm9TRIScyZvEG91R1jS7fOzL/tmasEJs8TETfKl24hHmx4AnIuHCPOKGz
	1EYSJg==
X-Received: by 2002:a53:bc89:0:b0:668:1550:f254 with SMTP id 956f58d0204a3-66825594dc7mr144033d50.40.1784137054532;
        Wed, 15 Jul 2026 10:37:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:3705:6d89:7b16:2a59? ([2600:1700:6476:1430:3705:6d89:7b16:2a59])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6681fe46cd8sm1082059d50.15.2026.07.15.10.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:37:34 -0700 (PDT)
Message-ID: <771aefbfbf18e60ee6c36698dece92c082a9a389.camel@dubeyko.com>
Subject: Re: [PATCH v5] hfs: port HFS+ b-tree bitmap corruption check
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 15 Jul 2026 10:37:32 -0700
In-Reply-To: <20260715033829.1698-1-aditya.ansh182@gmail.com>
References: <20260715033829.1698-1-aditya.ansh182@gmail.com>
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

On Wed, 2026-07-15 at 03:38 +0000, Aditya Prakash Srivastava wrote:
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
> 2. Implement static hfs_bmap_get_map_page() in fs/hfs/btree.c, and
> port
> =C2=A0=C2=A0 the necessary offset and length validation helpers to
> fs/hfs/btree.h
> =C2=A0=C2=A0 as static inline functions with robust null pointer checks.
> 3. Implement static hfs_bmap_test_bit() in fs/hfs/btree.c to inspect
> =C2=A0=C2=A0 the B-tree bitmap using the new get_map_page helper.
> 4. In hfs_btree_open(), retrieve the header node via
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
=A0=C2=A0=C2=A0=C2=A0 | 42 -------------------
> =C2=A0fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 84
> ++++++++++++++++++++++++++++++++++++++
> =C2=A0fs/hfs/btree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++++++++++++++
> =C2=A0include/linux/hfs_common.h | 13 ++++--
> =C2=A04 files changed, 134 insertions(+), 45 deletions(-)
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
> index 2eb37a2f64e8..88810b1c90c3 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -15,6 +15,75 @@
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
> +static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
> +					=C2=A0 struct hfs_bmap_ctx *ctx,
> +					=C2=A0 u32 byte_offset)

We have really nice comments of functions [3,4] for the case of HFS+. I
believe it makes to keep the comments for the case of HFS too.

Mostly, patch looks good. However, we have one critical issue in the
patch. Current code uses hfs_bmap_get_map_page() only in
hfs_bmap_test_bit(). But, we have the same logic in hfs_bmap_alloc()
[1, 2]. It is not good to have the same logic implemented several times
in different places. Also, hfs_bmap_free() could benefit from
hfs_bmap_clear_bit() function. Could you please improve your patch?

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
> =C2=A0/* Get a reference to a B*Tree and do some initial checks */
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
> btree_keycmp keycmp)
> =C2=A0{
> @@ -23,6 +92,7 @@ struct hfs_btree *hfs_btree_open(struct super_block
> *sb, u32 id, btree_keycmp ke
> =C2=A0	struct address_space *mapping;
> =C2=A0	struct folio *folio;
> =C2=A0	struct buffer_head *bh;
> +	struct hfs_bnode *node;
> =C2=A0	unsigned int size;
> =C2=A0	u16 dblock;
> =C2=A0	sector_t start_block;
> @@ -155,6 +225,20 @@ struct hfs_btree *hfs_btree_open(struct
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
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 99be858b2446..f8afa33f709a 100644
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
> +		pr_err("invalid offset: id %u, type %x, h %u, sz %u,
> off %u\n",

type %#x

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
> +		pr_err("corrected len: id %u, type %x, h %u, sz %u,
> off %u, len %u->%u\n",

type %#x

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

Thanks,
Slava.

[1]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfs/btree.c#L307
[2]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfs/btree.c#L352
[3]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/btree.c#L144
[4]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/btree.c#L190
