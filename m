Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1B363C6A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920773; cv=none; b=jPR2hYtHlhtBrJGkCdVkIg1FvqXsp/Vx1lSWma0bFr6uQmvnZqFDr0g8DREVKYllx0CBezQ1kHv7OeMcAExrEUYhIjkAIdnzdwfU4ysU5YQaE38xr6FpJ5688Ab/hfxBIztDlifssJUe3QL1tN32DrjBUWc3UBlRUwaS8Zpo5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920773; c=relaxed/simple;
	bh=o08lmplaObeL6tg6aUljAQ0GPmHbjPOgCvHZnFKwvjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QuFhq+OAyjNYqNn54te7xOwno69zBLegJhl7M6UFRChevUqUgC0Rjc5TiNqMHsrtRU1tcIMSFKqLyT0+KiTNAOv8XDAO8Sy4SauMdTv0UHSXN2pFsugo+huSamn+uPrIPyqLvfHi4Lx0x9VeGwHSKS0NY5R0FDOzMVkJoZ8C2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=pvyLPAIm; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="pvyLPAIm"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ea0b7d137so4287677b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784920771; x=1785525571; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dROqPddZe7WwgphB8SyAGeHLtw80N4YjRK58ySFo3RA=;
        b=pvyLPAIm1Fm9Po6FYDVyrUkCqe82kEWjiDswHIBGw0XW2zS93Rr9lPXINv1YfbXiX3
         MAK7aKB770e2COMh1lX5PZuSsBKC+CSTIqWhQG2s1c+tosObyp/+rQP2fJ3gd+PJtlRv
         VT3BR+VPyaWK8x57lymF3cFNnf7/nC5/EwvrW6jJZlMyfjLZ+Gh1KTnSltRsVB+lhTld
         SoUrtPS3hB5kBbXLa9NrZnSQalsty41oPjkTHYS14yBpxqvgQEkVEPFxt7XdsFMIpjkM
         GpWvRkZl+KlwA+83NcB3jyoYXGU10n1vOc2q2O2XWl8I1OVKHeETnNhgVeIncvpstwRx
         HwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920771; x=1785525571;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dROqPddZe7WwgphB8SyAGeHLtw80N4YjRK58ySFo3RA=;
        b=THn/FKwS/qzO//mAv0xe7W9kjP5/2NZjsiae1SnEoe3BeITjNUig1FedlmANRKGNnX
         zYr9dSWbLiXp3yoE8rh29jVaMQnaTV/5RDASQNVxjHREhJc8Hi079hRlCDzH+7DSf8zk
         ZLhB/RWjBsrZkbknX4TBTFvggOGzczgsXPUE5EHHUTGokC4kwWwOU65mopL4LSyn2S7G
         UPFjtc9rDDJA/EpS+hSlIBOvgrlvPF6CuBq+fR6NX5au3RDW2ULWx/0eIqgnmAczlLYB
         FBEjARjFFusgnhLsKefX+lrx2TOglFNVuCkkwes2UIzUdHxD4rQt0/qS2DbGP3WuCtHb
         vDWA==
X-Forwarded-Encrypted: i=1; AHgh+Rpi7AXhzT2n7XfpcBDfCVnhwqaE9+jx3vEPrsfiUFzh2mBa+ImfRiL7cnFuk/IuiudUVmZHl7iAIwOZRCjc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0SdZ8YxLVV8vMg3kEeD6F4y99hM/Vdg0lpoNBfKRibaxoqAUx
	uALLjXtW7vgHbP5OvFcUtCrH6WZMXVMRnqf9Uw76ztZepC1wYqdGKSvUROhJbVO4w+U=
X-Gm-Gg: AR+sD12bUA8wDHYQDVi9yFDqDwlVQ8tix4z/KzBaEb2QyT7GOWoM67Nsmc+MXqt5kTS
	a1IR4h8yZ6a8tOH7eryiyCbiJYRWXic1aGWxcBn9bJMDt7NnCo511L3kmeZfVIDqD+lpeXdVd6J
	Ze1Qv9a3YBwIu6PathhvZUI+f2ITjlBAHD1SE1/ndN79QGV6J2UvTz2QrVYPciLEJkCAJ5A5Mz/
	0Xzp/ccbh61nwbWg/j4TmJ15eH6q3LrbxibnZAAmmxw5MXzqRfQPTyAmonlj2aEfWdx8A7Ekg3X
	SkPbce1uBIh6W+AmjZeYIy3zA1sieXOf33u2GVA8a8gQWF7LSxg2qQmzeFJZHDp7CyEk0l8rY1y
	dfZsb2CxLD3XrFJ5Ga1xDHU+WsQuRTSR0ZMMHrAK2p7Atxmt3tPL43L338nEdaWWqPeBhHuv13e
	nypWjXvMW7qHk1Yh8j6jqhSwiJchije5o8oDyFR6swtWPO80EgWVxgPE0X4yxpX+sJ3j+HhfykY
	SGIFVT/yyxS+TLk0eiz8FL8FiHGjP20tK4jGePRvT38Wxsy1TunLjLRktf+QKzXBgbfNac=
X-Received: by 2002:a05:690c:b95:b0:81d:d035:eb4f with SMTP id 00721157ae682-81f4c35b9ebmr30349767b3.49.1784920770716;
        Fri, 24 Jul 2026 12:19:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6576ee96sm4691967b3.6.2026.07.24.12.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:19:30 -0700 (PDT)
Message-ID: <49e053c065c675b10daa6f7a4890ffb7625d6dcd.camel@dubeyko.com>
Subject: Re: [PATCH v4] hfsplus: validate B-tree record offset table
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Date: Fri, 24 Jul 2026 12:19:28 -0700
In-Reply-To: <20260723063910.765543-1-r772577952@gmail.com>
References: <3d0cb82335583659fa6d044bcf4b8083907712bc.camel@dubeyko.com>
	 <20260723063910.765543-1-r772577952@gmail.com>
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

On Thu, 2026-07-23 at 14:39 +0800, Jiaming Zhang wrote:
> A crafted HFS+ image can contain a corrupted B-tree node. The node
> descriptor
> may contain a record count that does not fit in the node, and record
> offsets may
> be unordered, unaligned, outside the node, or point into the offset
> table
> itself.
>=20
> Several B-tree helpers consume these on-disk fields before validating
> them:
> hfs_bnode_dump() can walk past the offset table when num_recs is
> corrupted,
> hfs_brec_lenoff() can produce an underflowed length or a record range
> that
> overlaps the offset table. This can make the unlink/writeback path
> repeatedly
> call hfs_bnode_read_u16() with invalid offsets while holding the HFS+
> B-tree
> lock, producing a flood of "requested invalid offset" messages. Other
> writeback
> workers then block on tree->tree_lock and the system reports tasks
> hung in
> hfsplus_write_inode().
>=20
> Validate num_recs against the node size before walking the record
> offset table.
> Reject record ranges that are unordered, unaligned, outside the node,
> or
> overlapping the offset table. Reject invalid record indexes before
> reading their
> offset entries, and avoid decrementing an already-zero leaf_count.
> ---
> Changes in v4:
> - Rename hfs_find_reset() to hfs_find_result_init().
> - Reset find result fields in __hfs_brec_find().
> - Move num_recs validation next to descriptor field initialization.
> - Rename hfs_brec_range_valid() to hfs_brec_offpair_valid().
> - Use U16_MAX for invalid offset/len/keylen sentinels and update
> callers.
> - Add hfs_brec_len_valid() to check validity of len/keylen.
> - Handle invalid B-tree map record lengths in hfs_bmap_get_map_page()
> =C2=A0 and hfs_bmap_free().
> - Return -EINVAL instead of -EIO for invalid remove cursor/leaf_count
> state.
>=20
> Changes in v3:
> - Drop the keylen =3D=3D len check.
> - Drop the explicit zero-record check in __hfs_brec_find().
> - Move find cursor reset into hfs_find_reset() and call it from
> hfs_find_init() and hfs_brec_find().
> - Rename helper-local variables as suggested.
>=20
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++------
> =C2=A0fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++---
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 43 ++++++++=
++++++--------
> =C2=A0fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++
> =C2=A0fs/hfsplus/hfsplus_fs.h | 79
> +++++++++++++++++++++++++++++++++++++++++
> =C2=A05 files changed, 142 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 9a55fa6d5294..301e653f029d 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -9,6 +9,7 @@
> =C2=A0 * Search routines for btrees
> =C2=A0 */
> =C2=A0
> +#include <linux/limits.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include "hfsplus_fs.h"
> =C2=A0
> @@ -18,6 +19,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0
> =C2=A0	fd->tree =3D tree;
> =C2=A0	fd->bnode =3D NULL;
> +	hfs_find_result_init(fd);
> =C2=A0	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> =C2=A0	if (!ptr)
> =C2=A0		return -ENOMEM;
> @@ -106,17 +108,20 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	u16 off, len, keylen;
> =C2=A0	int rec;
> =C2=A0	int b, e;
> -	int res;
> +	int res =3D -ENOENT;
> =C2=A0
> =C2=A0	BUG_ON(!rec_found);
> +	hfs_find_result_init(fd);
> +	if (!hfs_bnode_num_recs_valid(bnode))
> +		goto fail;
> +
> =C2=A0	b =3D 0;
> =C2=A0	e =3D bnode->num_recs - 1;
> -	res =3D -ENOENT;
> =C2=A0	do {
> =C2=A0		rec =3D (e + b) / 2;
> =C2=A0		len =3D hfs_brec_lenoff(bnode, rec, &off);
> =C2=A0		keylen =3D hfs_brec_keylen(bnode, rec);
> -		if (keylen =3D=3D 0) {
> +		if (!hfs_brec_len_valid(len) ||
> !hfs_brec_len_valid(keylen)) {
> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -130,7 +135,7 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	if (rec !=3D e && e >=3D 0) {
> =C2=A0		len =3D hfs_brec_lenoff(bnode, e, &off);
> =C2=A0		keylen =3D hfs_brec_keylen(bnode, e);
> -		if (keylen =3D=3D 0) {
> +		if (!hfs_brec_len_valid(keylen) ||
> !hfs_brec_len_valid(len)) {
> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -158,11 +163,7 @@ int hfs_brec_find(struct hfs_find_data *fd,
> search_strategy_t do_key_compare)
> =C2=A0	__be32 data;
> =C2=A0	int height, res;
> =C2=A0
> -	fd->record =3D -1;
> -	fd->keyoffset =3D -1;
> -	fd->keylength =3D -1;
> -	fd->entryoffset =3D -1;
> -	fd->entrylength =3D -1;
> +	hfs_find_result_init(fd);
> =C2=A0
> =C2=A0	tree =3D fd->tree;
> =C2=A0	if (fd->bnode)
> @@ -274,7 +275,7 @@ int hfs_brec_goto(struct hfs_find_data *fd, int
> cnt)
> =C2=A0
> =C2=A0	len =3D hfs_brec_lenoff(bnode, fd->record, &off);
> =C2=A0	keylen =3D hfs_brec_keylen(bnode, fd->record);
> -	if (keylen =3D=3D 0) {
> +	if (!hfs_brec_len_valid(len) || !hfs_brec_len_valid(keylen))
> {
> =C2=A0		res =3D -EINVAL;
> =C2=A0		goto out;
> =C2=A0	}
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index d088fb7eb0df..e5babf3a03b7 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -352,15 +352,22 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> =C2=A0	struct hfs_bnode_desc desc;
> =C2=A0	__be32 cnid;
> =C2=A0	int i, off, key_off;
> +	u16 num_recs;
> =C2=A0
> =C2=A0	hfs_dbg("node %d\n", node->this);
> =C2=A0	hfs_bnode_read(node, &desc, 0, sizeof(desc));
> +	num_recs =3D node->num_recs;
> =C2=A0	hfs_dbg("next %d, prev %d, type %d, height %d, num_recs
> %d\n",
> =C2=A0		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
> =C2=A0		desc.type, desc.height, be16_to_cpu(desc.num_recs));
> =C2=A0
> +	if (!hfs_bnode_num_recs_valid(node)) {
> +		hfs_dbg("invalid num_recs %u\n", num_recs);
> +		return;
> +	}
> +
> =C2=A0	off =3D node->tree->node_size - 2;
> -	for (i =3D be16_to_cpu(desc.num_recs); i >=3D 0; off -=3D 2, i--)
> {
> +	for (i =3D num_recs; i >=3D 0; off -=3D 2, i--) {
> =C2=A0		key_off =3D hfs_bnode_read_u16(node, off);
> =C2=A0		hfs_dbg(" key_off %d", key_off);
> =C2=A0		if (i && node->type =3D=3D HFS_NODE_INDEX) {
> @@ -561,6 +568,9 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree
> *tree, u32 num)
> =C2=A0	node->height =3D desc->height;
> =C2=A0	kunmap_local(desc);
> =C2=A0
> +	if (!hfs_bnode_num_recs_valid(node))
> +		goto node_error;
> +
> =C2=A0	switch (node->type) {
> =C2=A0	case HFS_NODE_HEADER:
> =C2=A0	case HFS_NODE_MAP:
> @@ -586,9 +596,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree
> *tree, u32 num)
> =C2=A0	for (i =3D 1; i <=3D node->num_recs; off =3D next_off, i++) {
> =C2=A0		rec_off -=3D 2;
> =C2=A0		next_off =3D hfs_bnode_read_u16(node, rec_off);
> -		if (next_off <=3D off ||
> -		=C2=A0=C2=A0=C2=A0 next_off > tree->node_size ||
> -		=C2=A0=C2=A0=C2=A0 next_off & 1)
> +		if (!hfs_brec_offpair_valid(node, off, next_off,
> rec_off))
> =C2=A0			goto node_error;
> =C2=A0		entry_size =3D next_off - off;
> =C2=A0		if (node->type !=3D HFS_NODE_INDEX &&
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index e3df89284079..42cc09aca80e 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -9,6 +9,8 @@
> =C2=A0 * Handle individual btree records
> =C2=A0 */
> =C2=A0
> +#include <linux/limits.h>
> +
> =C2=A0#include "hfsplus_fs.h"
> =C2=A0#include "hfsplus_raw.h"
> =C2=A0
> @@ -20,41 +22,49 @@ static int hfs_btree_inc_height(struct hfs_btree
> *);
> =C2=A0u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
> =C2=A0{
> =C2=A0	__be16 retval[2];
> -	u16 dataoff;
> +	u16 data_off;
> +	u16 next_off;
> +
> +	if (!hfs_brec_record_valid(node, rec)) {
> +		*off =3D U16_MAX;
> +		return U16_MAX;
> +	}
> =C2=A0
> -	dataoff =3D node->tree->node_size - (rec + 2) * 2;
> -	hfs_bnode_read(node, retval, dataoff, 4);
> +	data_off =3D node->tree->node_size - (rec + 2) * 2;
> +	hfs_bnode_read(node, retval, data_off, 4);
> =C2=A0	*off =3D be16_to_cpu(retval[1]);
> -	return be16_to_cpu(retval[0]) - *off;
> +	next_off =3D be16_to_cpu(retval[0]);
> +	if (!hfs_brec_offpair_valid(node, *off, next_off, data_off))
> {
> +		*off =3D U16_MAX;
> +		return U16_MAX;
> +	}
> +	return next_off - *off;
> =C2=A0}
> =C2=A0
> =C2=A0/* Get the length of the key from a keyed record */
> =C2=A0u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)
> =C2=A0{
> -	u16 retval, recoff;
> +	u16 retval, recoff, len;
> =C2=A0
> =C2=A0	if (node->type !=3D HFS_NODE_INDEX && node->type !=3D
> HFS_NODE_LEAF)
> =C2=A0		return 0;
> +	if (!hfs_brec_record_valid(node, rec))
> +		return U16_MAX;
> =C2=A0
> =C2=A0	if ((node->type =3D=3D HFS_NODE_INDEX) &&
> =C2=A0	=C2=A0=C2=A0 !(node->tree->attributes & HFS_TREE_VARIDXKEYS) &&
> =C2=A0	=C2=A0=C2=A0 (node->tree->cnid !=3D HFSPLUS_ATTR_CNID)) {
> =C2=A0		retval =3D node->tree->max_key_len + 2;
> =C2=A0	} else {
> -		recoff =3D hfs_bnode_read_u16(node,
> -			node->tree->node_size - (rec + 1) * 2);
> -		if (!recoff)
> -			return 0;
> -		if (recoff > node->tree->node_size - 2) {
> -			pr_err("recoff %d too large\n", recoff);
> -			return 0;
> -		}
> +		len =3D hfs_brec_lenoff(node, rec, &recoff);
> +		if (!hfs_brec_len_valid(len))
> +			return len;
> =C2=A0
> =C2=A0		retval =3D hfs_bnode_read_u16(node, recoff) + 2;
> =C2=A0		if (retval > node->tree->max_key_len + 2) {
> =C2=A0			pr_err("keylen %d too large\n",
> =C2=A0				retval);
> -			retval =3D 0;
> +			retval =3D U16_MAX;
> =C2=A0		}
> =C2=A0	}
> =C2=A0	return retval;
> @@ -185,10 +195,15 @@ int hfs_brec_remove(struct hfs_find_data *fd)

We call __hfs_brec_find() in several places [1 - 4]. Do we need to
check the returned error code for [1] case? We need to check the
returned error code for [2,3] cases. Do we need to check the returned
error code for [4] case?

> =C2=A0	tree =3D fd->tree;
> =C2=A0	node =3D fd->bnode;
> =C2=A0again:
> +	if (!hfs_brec_record_valid(node, fd->record))
> +		return -EINVAL;
> +
> =C2=A0	rec_off =3D tree->node_size - (fd->record + 2) * 2;
> =C2=A0	end_off =3D tree->node_size - (node->num_recs + 1) * 2;
> =C2=A0
> =C2=A0	if (node->type =3D=3D HFS_NODE_LEAF) {
> +		if (tree->leaf_count =3D=3D 0)
> +			return -EINVAL;
> =C2=A0		tree->leaf_count--;
> =C2=A0		mark_inode_dirty(tree->inode);
> =C2=A0	}
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 394542a47e60..85ba6cf1a803 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/log2.h>
> +#include <linux/limits.h>
> =C2=A0
> =C2=A0#include "hfsplus_fs.h"
> =C2=A0#include "hfsplus_raw.h"
> @@ -168,6 +169,8 @@ static struct page *hfs_bmap_get_map_page(struct
> hfs_bnode *node,
> =C2=A0	}
> =C2=A0
> =C2=A0	ctx->len =3D hfs_brec_lenoff(node, rec_idx, &off16);
> +	if (ctx->len =3D=3D U16_MAX)
> +		return ERR_PTR(-EINVAL);
> =C2=A0	if (!ctx->len)
> =C2=A0		return ERR_PTR(-ENOENT);

Why not hfs_brec_len_valid() for both checks?

> =C2=A0
> @@ -622,6 +625,10 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0	if (IS_ERR(node))
> =C2=A0		return;
> =C2=A0	len =3D hfs_brec_lenoff(node, 2, &off);
> +	if (!hfs_brec_len_valid(len)) {

As far as I can see, you check as len as off everywhere. But why not
here?

> +		hfs_bnode_put(node);
> +		return;
> +	}
> =C2=A0	while (nidx >=3D len * 8) {
> =C2=A0		u32 i;
> =C2=A0
> @@ -648,6 +655,10 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0			return;
> =C2=A0		}
> =C2=A0		len =3D hfs_brec_lenoff(node, 0, &off);
> +		if (!hfs_brec_len_valid(len)) {

Ditto.

> +			hfs_bnode_put(node);
> +			return;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	res =3D hfs_bmap_clear_bit(node, nidx);
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index ec04b82ad927..41d1e24309d4 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -16,6 +16,7 @@
> =C2=A0#include <linux/buffer_head.h>
> =C2=A0#include <linux/blkdev.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/limits.h>
> =C2=A0#include "hfsplus_raw.h"
> =C2=A0
> =C2=A0/* Runtime config options */
> @@ -587,6 +588,84 @@ bool is_bnode_offset_valid(struct hfs_bnode
> *node, u32 off)
> =C2=A0	return is_valid;
> =C2=A0}
> =C2=A0
> +static inline
> +bool hfs_bnode_num_recs_valid(struct hfs_bnode *node)

I prefer invalid check for all cases because it is safe to state that
value is invalid. Because, validity check requires more precise
calculation.

> +{
> +	u32 node_size;
> +	u32 table_size;
> +	u32 area_size;
> +	u32 rec_size =3D sizeof(__be16);
> +	u32 desc_size =3D sizeof(struct hfs_bnode_desc);
> +
> +	if (!node || !node->tree)
> +		return false;
> +
> +	node_size =3D node->tree->node_size;
> +	if (node_size < desc_size)
> +		return false;
> +
> +	area_size =3D node_size - desc_size;
> +	table_size =3D ((u32)node->num_recs + 1) * rec_size;
> +
> +	return table_size <=3D area_size;
> +}
> +
> +static inline
> +bool hfs_brec_record_valid(struct hfs_bnode *node, int record)

Ditto. The invalidity check is more safe statement.

> +{
> +	if (!hfs_bnode_num_recs_valid(node))
> +		return false;
> +	if (record < 0)
> +		return false;
> +
> +	return record < node->num_recs;
> +}
> +
> +static inline
> +bool hfs_brec_offpair_valid(struct hfs_bnode *node, u16 off, u16
> next_off,
> +							u16 rec_off)

Ditto. The invalidity check is more safe statement.

I am slightly confused by argument names. What is the difference
between off, next_off, and rec_off? We need to have more clear names
here.

The hfs_brec_offpair_valid() name sounds really weird. I believe that
you simply check the off value. Am I correct? So, it means that you
don't check the pair. You check only one item but not two or three
ones.

> +{
> +	u32 table_size;
> +	u32 table_start;
> +	u32 rec_size =3D sizeof(__be16);
> +	u32 desc_size =3D sizeof(struct hfs_bnode_desc);
> +
> +	if (!node || !node->tree)
> +		return false;
> +
> +	if (off < desc_size || (off & 1))
> +		return false;
> +
> +	if (next_off <=3D off ||
> +	=C2=A0=C2=A0=C2=A0 next_off > node->tree->node_size ||
> +	=C2=A0=C2=A0=C2=A0 next_off > rec_off ||
> +	=C2=A0=C2=A0=C2=A0 (next_off & 1))
> +		return false;
> +
> +	table_size =3D ((u32)node->num_recs + 1) * rec_size;
> +	table_start =3D node->tree->node_size - table_size;
> +	if (next_off > table_start)
> +		return false;
> +
> +	return true;
> +}
> +
> +static inline
> +bool hfs_brec_len_valid(u16 len)
> +{
> +	return len !=3D U16_MAX && len !=3D 0;

Frankly speaking, I believe that it could be better to check the len
with the node_size but not U16_MAX. Does it makes sense to you?

Moreover, the comparison with 0 and U16_MAX cannot guarantee that len
is valid. If len is 0 or bigger that node_size, then it is definitely
invalid length. It will be better to name the method as
hfs_brec_len_invalid(). Oppositely, hfs_brec_len_valid() requires more
precise check.

Thanks,
Slava.

> +}
> +
> +static inline
> +void hfs_find_result_init(struct hfs_find_data *fd)
> +{
> +	fd->record =3D -1;
> +	fd->keyoffset =3D -1;
> +	fd->keylength =3D -1;
> +	fd->entryoffset =3D -1;
> +	fd->entrylength =3D -1;
> +}
> +
> =C2=A0static inline
> =C2=A0u32 check_and_correct_requested_length(struct hfs_bnode *node, u32
> off, u32 len)
> =C2=A0{

[1]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L160
[2]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L208
[3]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L382
[4]
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L449
