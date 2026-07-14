Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20F239E60
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059175; cv=none; b=I2kPiri9ud7dB4uHrbvwp0esFnBHTlQh74weylGM1cFt7A+V3zT/yLdr5nvKgV3Ew45ft6sInO+qU/+5hsKz4s3lPMjpCj2QXvDBzYwYHIHD4ib0cs4Ryw3XfbEILKh/i7loi8mvXh/CRjasTkL/VOC5Bh5tEiaGljRng/OL6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059175; c=relaxed/simple;
	bh=3M/CnqpeW266to/pfMAWDwnz2TA/ujiOASA2KhK2d/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/ux9M6qZfCkTAb5+LxOU9NyHc42/3obSp1BhSVC6TrOoL4xNNC/hvZ9mpPGwyxDl4IC0p8cYqq3OJ92oV8a9bOQhZ7BqjnQUyQNoISrOKWHwrtiob5SSSCRz9+zp4k7jJ385+atcaBr4W/6wLu+os6889mBTF4V/MJ6kbuEc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=RSLi21LP; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="RSLi21LP"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66807ba2f0fso1151407d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784059171; x=1784663971; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=miLIv/VT91wTGPrHGi0qTJVZTcz75gkEVWep4QXRaLY=;
        b=RSLi21LPhNduoGRCXeWluUuw16sSYGJ23U5wQqK9mO+Kiv8dYQScIGeTv8WVxKc/HF
         tjC5xyD/4l0LyY1Ek35Nx97e/lE7/ahXYVH4pSzpfnzOjjOP96WQb/daZXaAV4/w3okB
         FHBAJqB93WMBQJPSmQIJAmRIDWHZKt4V0UH9X2IXH15KWRmB09I8vJFjpcnx9Vkr6jG3
         kMZ7IYTU0cvektv+jZnFDiDtRjoyk+A0nhZ0658pzN7ItbHWx9Pq6HhQsIW6uZXVequq
         2A976w5+itql63XJ7v6swPhsy2YQUCLyRzF+iBgraZ9Yno93XKxJcl1gFCrPiJp/5vDw
         fpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784059171; x=1784663971;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=miLIv/VT91wTGPrHGi0qTJVZTcz75gkEVWep4QXRaLY=;
        b=f7tXUiiKP+eIo+xZnTPeoaLE47iLv9Rb1kwtp7i6+4xk/6Fx/gJLyYC71jr09mIC0x
         6fCp5z1X7p4Z4SZgJptcwmU3Ns95lUwiun7Z5dC+Np8Mf+aLb+LmV2BnTlHVM+lW8jog
         E2tDRmI1k6fN3Jb9BpsJZ+bbcdI2DVBSCpHA/lPZou4+tpKk80G3ORfL/KWX/uR9J4Wx
         4QmOCNIYfKBdkO83N3aRkR5vWXDNXDOojIDPldncEX+iDUkYntN8QACZZrSYob0Uvq3f
         JKjfWKCaeQGO+NYeqh5+xQJXjHEo5Kd2+SG5Ir9mtfSCyLbBrgYIsC/fMwUql0hUUaGt
         D6ZA==
X-Forwarded-Encrypted: i=1; AHgh+RrRYWv1wIsUijh7JfWwfDwPEKXEw9CuF0c48HN+whjgf4aT6fGl+XF1N+JKnxXtfTSpNahInIeAvTJBSMWv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wiciZt9X8KcNzVrudYFokiERcNL6EmSH25sLQHmi/RXOO+Uc
	IqD00bh0Nap/HxQR0VRkhYNpvIo3T/GpW6zVHK/4pj68uoFPY9FBygjotTps1xA4NnQ=
X-Gm-Gg: AfdE7ckd6u6o9Qt69mzqfSn4PYy0v4ATlHu2P0CTHxYHglKBKmAW+PaGDzFJgy/3Pqy
	s2lF2OoL1nqgow5NrEKRVYmkwkFwKRlA+Ts/w2PiXoqre4Ozvpe1uAn3Ht5H2CNyOze6zHey/TV
	svYBZZq0JRd8FdXKNmvck1fhSlSNHjcc9OxyoVX6jEAwv0W0hfp5xUcp+ltxD6XZxSTFjp+QYKA
	Pr/Y/wbBCHXCWnRoQ8VoxPNHx32zlOAnhf07jFDQz06q7Nb4ipqDSLcpzlxGjE8zsvPqRU30sIU
	+x5HmOeDs/833A0389e/RwwoizLJcTb5XwYJNMgdmP+aeZL5KZj79WTlt5NmYd5izFplKzBCJB4
	VTjDyVYBVnWCGo5Q40VpKL4c3imWm8rLYqInBX+JasKial9Ica1utdOr6y2r4VV8Yeg9Y+ha4aw
	lPE0C3xJCeLcXOImNGjn6+FWpbwfNlyqSZ9OxnbQndGbN3P6UOSqiOekVx/PnZQURiy0SFJhkqk
	auySJ0z/nHToClIfa0nRMYqdCgQR4cxeb+0KOi1m1X+YA==
X-Received: by 2002:a53:ea8c:0:b0:664:ae6a:f06 with SMTP id 956f58d0204a3-667d7c3e7f8mr6960692d50.80.1784059171072;
        Tue, 14 Jul 2026 12:59:31 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667877aaadesm17134558d50.7.2026.07.14.12.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:59:30 -0700 (PDT)
Message-ID: <3d0cb82335583659fa6d044bcf4b8083907712bc.camel@dubeyko.com>
Subject: Re: [PATCH v3] hfsplus: validate B-tree record offset table
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Date: Tue, 14 Jul 2026 12:59:29 -0700
In-Reply-To: <20260712060928.26430-1-r772577952@gmail.com>
References: <96beade6e2a14b66e80053df0209598e11eb7986.camel@dubeyko.com>
	 <20260712060928.26430-1-r772577952@gmail.com>
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

On Sun, 2026-07-12 at 14:09 +0800, Jiaming Zhang wrote:
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
>=20
> Closes:
> https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25=
Vuju10Q@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> Changes in v3:
> - Drop the keylen =3D=3D len check.
> - Drop the explicit zero-record check in __hfs_brec_find().
> - Move find cursor reset into hfs_find_reset() and call it from
> hfs_find_init() and hfs_brec_find().
> - Rename helper-local variables as suggested.
>=20
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++----
> =C2=A0fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++---
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 35 ++++++++=
+++++-------
> =C2=A0fs/hfsplus/hfsplus_fs.h | 72
> +++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 113 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 9a55fa6d5294..a5391ff07c70 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -18,6 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0
> =C2=A0	fd->tree =3D tree;
> =C2=A0	fd->bnode =3D NULL;
> +	hfs_find_reset(fd);

The hfs_find_reset() sounds weird. We are trying to initialize the
result section of the b-tree search data structure. So,
hfs_find_result_init() sounds like more proper name, for my taste.

> =C2=A0	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> =C2=A0	if (!ptr)
> =C2=A0		return -ENOMEM;
> @@ -106,12 +107,14 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	u16 off, len, keylen;
> =C2=A0	int rec;
> =C2=A0	int b, e;
> -	int res;
> +	int res =3D -ENOENT;
> =C2=A0
> =C2=A0	BUG_ON(!rec_found);
> +	if (!hfs_bnode_num_recs_valid(bnode))
> +		goto fail;

Are you sure that we don't need to call the hfs_find_reset() here?
Because, __hfs_brec_find() could be called not only from
hfs_brec_find() context.

> +
> =C2=A0	b =3D 0;
> =C2=A0	e =3D bnode->num_recs - 1;
> -	res =3D -ENOENT;
> =C2=A0	do {
> =C2=A0		rec =3D (e + b) / 2;
> =C2=A0		len =3D hfs_brec_lenoff(bnode, rec, &off);
> @@ -158,11 +161,7 @@ int hfs_brec_find(struct hfs_find_data *fd,
> search_strategy_t do_key_compare)
> =C2=A0	__be32 data;
> =C2=A0	int height, res;
> =C2=A0
> -	fd->record =3D -1;
> -	fd->keyoffset =3D -1;
> -	fd->keylength =3D -1;
> -	fd->entryoffset =3D -1;
> -	fd->entrylength =3D -1;
> +	hfs_find_reset(fd);

Ditto.

> =C2=A0
> =C2=A0	tree =3D fd->tree;
> =C2=A0	if (fd->bnode)
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index d088fb7eb0df..f185c012d090 100644
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
> @@ -579,6 +586,9 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree
> *tree, u32 num)
> =C2=A0		goto node_error;
> =C2=A0	}
> =C2=A0
> +	if (!hfs_bnode_num_recs_valid(node))
> +		goto node_error;

We assign the num_recs value here [1]:

	node->prev =3D be32_to_cpu(desc->prev);
	node->next =3D be32_to_cpu(desc->next);
	node->num_recs =3D be16_to_cpu(desc->num_recs);
	node->type =3D desc->type;
	node->height =3D desc->height;

I think that it is better place for the check.

> +
> =C2=A0	rec_off =3D tree->node_size - 2;
> =C2=A0	off =3D hfs_bnode_read_u16(node, rec_off);
> =C2=A0	if (off !=3D sizeof(struct hfs_bnode_desc))
> @@ -586,9 +596,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree
> *tree, u32 num)
> =C2=A0	for (i =3D 1; i <=3D node->num_recs; off =3D next_off, i++) {
> =C2=A0		rec_off -=3D 2;
> =C2=A0		next_off =3D hfs_bnode_read_u16(node, rec_off);
> -		if (next_off <=3D off ||
> -		=C2=A0=C2=A0=C2=A0 next_off > tree->node_size ||
> -		=C2=A0=C2=A0=C2=A0 next_off & 1)
> +		if (!hfs_brec_range_valid(node, off, next_off,
> rec_off))

Please, see my comment below.

> =C2=A0			goto node_error;
> =C2=A0		entry_size =3D next_off - off;
> =C2=A0		if (node->type !=3D HFS_NODE_INDEX &&
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index e3df89284079..3112c3bcf9cf 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -20,35 +20,41 @@ static int hfs_btree_inc_height(struct hfs_btree
> *);
> =C2=A0u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
> =C2=A0{
> =C2=A0	__be16 retval[2];
> -	u16 dataoff;
> +	u16 data_off;
> +	u16 next_off;
> =C2=A0
> -	dataoff =3D node->tree->node_size - (rec + 2) * 2;
> -	hfs_bnode_read(node, retval, dataoff, 4);
> +	if (!hfs_brec_record_valid(node, rec)) {
> +		*off =3D 0;

Are you sure that assigning 0 is correct? We will assign fd->keyoffset
=3D off. What if fd->keyoffset is used in the case of error? Maybe
U16_MAX will be better?

> +		return 0;

Ditto. Are you sure that 0 is a safe value? Maybe U16_MAX will be
better?

> +	}
> +
> +	data_off =3D node->tree->node_size - (rec + 2) * 2;
> +	hfs_bnode_read(node, retval, data_off, 4);
> =C2=A0	*off =3D be16_to_cpu(retval[1]);
> -	return be16_to_cpu(retval[0]) - *off;
> +	next_off =3D be16_to_cpu(retval[0]);
> +	if (!hfs_brec_range_valid(node, *off, next_off, data_off))
> +		return 0;

Ditto.

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
> +		return 0;

Ditto.

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
> +		len =3D hfs_brec_lenoff(node, rec, &recoff);

Ditto.

> +		if (len =3D=3D 0)
> =C2=A0			return 0;
> -		}
> =C2=A0
> =C2=A0		retval =3D hfs_bnode_read_u16(node, recoff) + 2;
> =C2=A0		if (retval > node->tree->max_key_len + 2) {
> @@ -185,10 +191,15 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> =C2=A0	tree =3D fd->tree;
> =C2=A0	node =3D fd->bnode;
> =C2=A0again:
> +	if (!hfs_brec_record_valid(node, fd->record))
> +		return -EIO;

We check the fd->record. If this value is incorrect, then it's internal
logic error but not -EIO error code.

> +
> =C2=A0	rec_off =3D tree->node_size - (fd->record + 2) * 2;
> =C2=A0	end_off =3D tree->node_size - (node->num_recs + 1) * 2;
> =C2=A0
> =C2=A0	if (node->type =3D=3D HFS_NODE_LEAF) {
> +		if (tree->leaf_count =3D=3D 0)
> +			return -EIO;

Ditto.

> =C2=A0		tree->leaf_count--;
> =C2=A0		mark_inode_dirty(tree->inode);
> =C2=A0	}
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index ec04b82ad927..d87d55a35d25 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -587,6 +587,78 @@ bool is_bnode_offset_valid(struct hfs_bnode
> *node, u32 off)
> =C2=A0	return is_valid;
> =C2=A0}
> =C2=A0
> +static inline
> +bool hfs_bnode_num_recs_valid(struct hfs_bnode *node)
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
> +bool hfs_brec_range_valid(struct hfs_bnode *node, u16 off, u16
> next_off,
> +			=C2=A0 u16 rec_off)

We are checking not range but neighboring items. So, I cannot agree
with hfs_brec_range_valid() name because there are no range here in the
check.

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
> +		next_off > node->tree->node_size ||
> +		next_off > rec_off ||
> +		(next_off & 1))
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
> +void hfs_find_reset(struct hfs_find_data *fd)

Please, see my comment above.

Thanks,
Slava.

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
https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/bnode.c#L559
