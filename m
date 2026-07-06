Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299663E5A27
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379504; cv=none; b=GLI1NP8HZMJXHxkVBKpJuTfCNFYHXsAx5ER/sIyrUpz9vmoqj332IO9xcic9gaEop0YQOu7eSgkoEnNcE71sN6vEyvJf0rJrJ1/DGuA5tSbN4wRC3pt5Cfye+iRPJJAE9WvsAlijGqSx/M4uuDCVmPVOuxoNbtt1+N1fgMmG7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379504; c=relaxed/simple;
	bh=PKlryueQV8w0fzmrUS66kAy6vJ+bEemsUqW0GYo9AyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uE7ZH1gNHoExXagD342EB1xS2VU4P7dD7ZjOCEaA0aUFlhSZl6tbOOCYI/0oHFM/a0j0FzmmyRWiusV8skItHunhcJ9ba6NIwHpWxMIUVbRD3930hlD8ieNQEKg7bhR/JJSXcLWhrrKIitc9u0YiUelkVJpNTGijLwUaEm0ZJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=TCBxDRxS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="TCBxDRxS"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8111c0c7439so26867207b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783379501; x=1783984301; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4H2vJETJJu2784DyFTKHUDkSb5ZqoZtrOGW7kTEpTY8=;
        b=TCBxDRxSf1RG4+DfZHLWoViBS8y+zy5AysnV33HzWZlqsJdZT/ehTWHO4pICkIFegZ
         k0AkxCE0P6akMGRmJbsabERbgWc+WH2ZbMk2xjXJDabWtYf8L859+1UlAAzY3xu6GGha
         k68xOp6oWng519I7uixWJVk/5EKAOaMvdnNhK8BvRfrg+TODtOorzRoHFLhmTcmMUHDM
         2pPXZCIbOYyEaSDnyMrDVjyL4hQGHmF2Q8930kg3UyOFkf5SP8qb47H115+i9rsk9lHr
         sfDI2DuPMklfRejndAQIJP7i9HTJDsKSLlhF2u1DzaspCBegLrhzyEqhjiiIKcWKNXfo
         tY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783379501; x=1783984301;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4H2vJETJJu2784DyFTKHUDkSb5ZqoZtrOGW7kTEpTY8=;
        b=E8H3UCS0hbxnqG5qQSx1KkZ6/eeRHghlMIbqnKOWJzvt597ZkYYQ9IHYQcRhxbZz9C
         zZZ8Jo9IyAaQkwF85q5iVbIV7YqZe3zRdlBt5jf509L2MJz1CLFlihlKtqoZ3dgZ7hVC
         ZrriBsO0Ekd2aIj/SaUuXjAj5LAibWFmQmtUHJxDMXeG8zf10JwHMyCyzos4FAAUXA+7
         ULfGtS7xDK775Xp8avT00IsC5HZz93mnZAetxUeHWQGfFDoytjh60ZCk4VcwdE8oK0Bw
         dBjPnfdji0P3rjDpQ03CdN3XxH6nJdqAaweLZKlPSfRXk3Yx5IBiDKO7tfBlxb0QTFFD
         3Hsw==
X-Forwarded-Encrypted: i=1; AHgh+RpBAEDRW/OCnFRDfwarMFU2oWVkbogs0AmPdPf+NewwA8v4J7zb2lIpmrZCO7HLbP2zkdCyvUjvci23zbo2@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCTbM6wmkdN7DWrIpKokTweEAs+jfOQ8ezSvH/iQCdzNQPDVe
	ih5QK2NufFms6fbcidsDIv4E4Fyf6FH+8pbqRs7vOA++uXnnYbXgk8GpofhriYqKe9U=
X-Gm-Gg: AfdE7cmmT6g2RofzQVWOjlVaVENAYSuK/zFoWQ/UU+pOtZ8Cn8Tj2iadmlhim3PvTWR
	WkHWKP/RZZ3XwoaHDyspyCNB/PICkHKWi1W1DaT6C7SZfcUbMhwyk1vNloiV+hvdra9h41RRPth
	tFwRG+2r510A/pz3AoKYE9+ujTgbKBC2sZa6Q94K5M2HhpH76Sv+g4CBN/4940UasTJ5o9B+2n0
	OEyb7kb4O6L709E/Jk1JGrKfxAGu0XrT/GAWd/td58miea/iq6wzEx7dp4RrNNc1I3rrsSNVPOa
	5btqtI40aosg6RBOjbq564oMZ2pFt51Tq0X5Md7+BXzTwczJXBx/B81ROJ2peG3mJjyEfgF+3G9
	KqyqiB/S8L1+KL+QIHXmvAFQ8zd7s5MgPbdePC/zNmjHO0VLJw2WcbnRGr92QCrMEKA6zqBQ+p3
	omlhi4fBw2zRBXVt7Tsy7ihBtsoeqeCBwwh6FuRS7pnhj4h/IV+G1wSLIO4Ek8mCHQyKH3SUAMQ
	8BSRHBCsy9i1pPZEcgjDC/4mVwJKr0G8bMlcBuBi+lusw==
X-Received: by 2002:a05:690c:690f:b0:80c:2326:3d61 with SMTP id 00721157ae682-81be13407f0mr20373777b3.5.1783379501000;
        Mon, 06 Jul 2026 16:11:41 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:7857:e2c9:858d:d189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144af51127sm63389727b3.30.2026.07.06.16.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 16:11:40 -0700 (PDT)
Message-ID: <a53cc141b6f7f91c2dbca637dae261ccf707e6f8.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: port HFS+ b-tree bitmap corruption check
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aditya Srivastava <aditya.ansh182@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 16:11:38 -0700
In-Reply-To: <20260703051617.1832-1-aditya.ansh182@gmail.com>
References: <20260703051617.1832-1-aditya.ansh182@gmail.com>
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

On Fri, 2026-07-03 at 05:16 +0000, Aditya Srivastava wrote:
> From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
>=20
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
> 1. Define struct hfs_bmap_ctx and the relevant map record indices.
> 2. Port hfs_bmap_get_map_page() and the necessary offset and length
> =C2=A0=C2=A0 validation helpers.
> 3. Implement hfs_bmap_test_bit() to inspect the B-tree bitmap using
> the
> =C2=A0=C2=A0 new get_map_page helper.
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
> Changes in v2:
> - Port struct hfs_bmap_ctx and hfs_bmap_get_map_page() helpers to
> =C2=A0 fs/hfs/btree.c, keeping HFS and HFS+ logic unified and easy to
> =C2=A0 library-ize.
> - Re-implement hfs_bmap_test_bit() to take struct hfs_bnode and
> =C2=A0 node_bit_idx, matching HFS+ perfectly.
> - In hfs_btree_open(), use hfs_bnode_find() to retrieve the header
> =C2=A0 node and put it safely after the bitwise verification check.
>=20
> =C2=A0fs/hfs/btree.c | 96
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0fs/hfs/btree.h |=C2=A0 2 ++
> =C2=A02 files changed, 98 insertions(+)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2eb37a2f64e8..36dc8735d01a 100644
> --- a/fs/hfs/btree.
> +++ b/fs/hfs/btree.c
> @@ -23,6 +23,7 @@ struct hfs_btree *hfs_btree_open(struct super_block
> *sb, u32 id, btree_keycmp ke
> =C2=A0	struct address_space *mapping;
> =C2=A0	struct folio *folio;
> =C2=A0	struct buffer_head *bh;
> +	struct hfs_bnode *node;
> =C2=A0	unsigned int size;
> =C2=A0	u16 dblock;
> =C2=A0	sector_t start_block;
> @@ -155,6 +156,20 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	kunmap_local(head);
> =C2=A0	folio_unlock(folio);
> =C2=A0	folio_put(folio);
> +
> +	node =3D hfs_bnode_find(tree, 0);

Probably, we need to have a specially named constant for this node ID.

> +	if (IS_ERR(node))
> +		goto free_inode;
> +
> +	if (!hfs_bmap_test_bit(node, 0)) {

Ditto.

> +		pr_warn("(%s): %s (cnid 0x%x) map record invalid or
> bitmap corruption detected, forcing read-only.\n",
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
> @@ -356,6 +371,87 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> hfs_btree *tree)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +struct hfs_bmap_ctx {
> +	unsigned int page_idx;
> +	unsigned int off;
> +	u16 len;
> +};

I prefer to have comments for this structure likewise HFS+ has.

> +
> +#define HFS_BTREE_HDR_MAP_REC_INDEX	2
> +#define HFS_BTREE_MAP_NODE_REC_INDEX	0

I believe that this should be declared in some proper header.

> +
> +static inline bool is_bnode_offset_valid(struct hfs_bnode *node, u32
> off)

Probably, it makes sense to have this function in some proper header.

> +{
> +	return off < node->tree->node_size;

Are you sure that pointers on node and tree will be always valid?

> +}
> +
> +static inline u32 check_and_correct_requested_length(struct
> hfs_bnode *node, u32 off, u32 len)
> +{
> +	if (off >=3D node->tree->node_size)

Ditto. Are you sure that pointers on node and tree will be always
valid?

> +		return 0;
> +	if ((u64)off + len > node->tree->node_size)
> +		return node->tree->node_size - off;
> +	return len;
> +}
> +
> +static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
> +					=C2=A0 struct hfs_bmap_ctx *ctx,
> +					=C2=A0 u32 byte_offset)
> +{
> +	u16 rec_idx, off16;
> +	unsigned int page_off;
> +
> +	if (node->this =3D=3D 0) {

It will be good to have named constant for this node ID.

Thanks,
Slava.

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
> +bool hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx)
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
> =C2=A0void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 99be858b2446..86036e18095f 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -93,6 +93,8 @@ extern void hfs_btree_write(struct hfs_btree
> *tree);
> =C2=A0extern int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)=
;
> =C2=A0extern struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree);
> =C2=A0extern void hfs_bmap_free(struct hfs_bnode *node);
> +struct hfs_bmap_ctx;
> +extern bool hfs_bmap_test_bit(struct hfs_bnode *node, u32
> node_bit_idx);
> =C2=A0
> =C2=A0/* bnode.c */
> =C2=A0extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32
> off, u32 len);
