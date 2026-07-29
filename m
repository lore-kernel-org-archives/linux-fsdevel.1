Received: from mail-yx2-f0.google.com (mail-yx2-f0.google.com [74.125.224.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392F2E7388
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285388; cv=none; b=emx36sR8XI8cJQCuchnBvjpe8MZzLwhmLOKVo7ht2WoJ4UAaEelVCEf7p7F0119eJMBw3bNsXz7Z5TN33JcIrbbDEJTlpb3OcJhPX+XIAXeYmjPWefx81yFMODRsqjfzjpDWBGVpS0LbqclD278Tnkw0+7ii7Ihs0SHN97r57LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285388; c=relaxed/simple;
	bh=YRAXwjNxlinMSyHdxRdIJaEcTCfzsuTeH7Mpc6GSpqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOmRQXXDomoEqOnAQtbBGEe/D0YnkvQsceqa1IzeWgwFpkrNaQY+/Pss2ie6+q+orW1vK8VozE4quh4U4WyfBtnEO4RNSS0+cgzCCQWjvPNInbEa957JKX3PZEPjnZmD7oLd20gQuev/pUFPqbmOQcLSLzRsOUC+cbc5Dx3ki+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=jGP10wW3; arc=none smtp.client-ip=74.125.224.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="jGP10wW3"
Received: by mail-yx2-f0.google.com with SMTP id 00721157ae682-81e7a64294cso1133337b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 17:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1785285383; x=1785890183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7O8KmrgIPIVL+1r8xRbMchbZtavC1vUsuMGk/06G9I8=;
        b=jGP10wW3sZN98xV2DUbefiPUmVOfBiNaONe8oBXq+US1krtCglTGeNSPj+XIf3zLXe
         cUBhTnaQWNIJiUOQulSDun5k11aNttuxlnuSIiDB55od/7KHa5Vi7XyL6/3zhYoZawuI
         ffs29Gq+qMcfJQs/s065lxKsQhjPzR1sj+hlRiHLF69XQf1xZbzBkJ4g1YS6vxDClfcj
         luJZw5oEH7lcm/DfE+DunBGl3RLkqZcl+p1zihlSRmnetUe0ATDRycBTUEEKmwqTcZ/p
         CVzrDiebgWTkliUfw+uGWc5TWDBB39ngx63O037hrMuJDVhbKP9jwkCNwikeHxXbIEku
         PTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785285383; x=1785890183;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7O8KmrgIPIVL+1r8xRbMchbZtavC1vUsuMGk/06G9I8=;
        b=ly5WAPbISRZrvkBgjbz9X9+PISqTbPb7a/r24irsEPkdCtNEjwbgwpO6yaFJiDufM1
         iQgkQRvyMkDsabXig1lSHUEd17pMVQeldQFj2KNpmxka67Q+aOA+maehln47nuvtWMGF
         EYxNRXrZ9a6Txg/OHo7eN75AP2IhFH0SJ2oVsekF1DL57cC2Y55ScayLFP5Uotl5W+1S
         W1/eTmBcRcNofxhwNyealHtQDuYIPyWU2TPMseHbrZTLr7gIgL2ObevYHsl/5D2ylAY6
         YUJMAIa5euUDlZ8I+7pXpmJWQX/IL928SGS6WfccoFxWeX7AZ5vYucZdDB0xLffdg7NU
         2f3A==
X-Forwarded-Encrypted: i=1; AHgh+RqfvoAhVkfh7hf1bgFQ9Hu42WcDO8Ci+JQwtxTegcjK5jfrSQXUB1JuApYa5WALzHRaz9TiaMUQsYuHVRso@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIYTTeStnREJQhegJfEQsCiojjIhSvKTrhOomFK7t4Ey2E+3l
	nzF2+rG7Jan4ke/2tQG9Dz1aVzmRtHRrtIT1ouaxsF6+BduaqsuOQZ2XI2CMCjnuXf8=
X-Gm-Gg: AR+sD11SRSZGwNNGPv46+omgM9cIcKUj0yYQMr5AUk8MYVKO0SseMPIwmOWx5FFAzoK
	9N8GCkIutiSOvVjwCC5GCr7eJz90tStx3XfJAIlK7iEiKexAg6lHhbGi30fIBU6hvYzZxQfvKBH
	8CNiu2cTBLtodxY20fo25VIxSRIA7dEKoRUtez0sifKQ/qMbL2H+VDWlF2wHWjBQlfBTi2uWAEV
	jU/2U0Y5+Ovs28USD3weu9aU7e+bAhrY20b1k0TvfZfN/qIenY9cuvwTtAOI/x+WbyPy2EV6vyp
	nnfTi0/XHhlhkBvr314OZ9VddA41wMpJ6jcwmgwiuYPF3KFFFhm9Qn3UTibNAPtNjMSaWiT2Ikd
	ISzwV7CQoL4YnRP1uN8qFB7r6GoRmASDIA20XKFnmLYGWxmiU99FzN9oIIgfMSJ5MCNs4/4aFWf
	I+B9DeluzuAjpTK32rkZ7v+HQmqtKLC/6U7h4E8IW9zB/1ZT1o15JJ1XZTF239rzWhGSAzAzS1N
	9orDzIY9WAVLNUKL6SnfCyfIenJnGikMn6WC2rCGpbMRS4bJYvbEX6+7ooqIqv0Jg3C/UpdfElB
	EXlhWUoZ+P4s7gSoGYEOjumIT88xsR28JE07Mcdmv4dCJ9+g6L1wIcs=
X-Received: by 2002:a05:690c:4d84:b0:81e:c95e:2bff with SMTP id 00721157ae682-81f993c9843mr20828907b3.60.1785285383340;
        Tue, 28 Jul 2026 17:36:23 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa279773dsm8785897b3.18.2026.07.28.17.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:36:22 -0700 (PDT)
Message-ID: <b9d01b1e5dd06fb8a76a10c81f1f6a438190eea2.camel@dubeyko.com>
Subject: Re: [PATCH v5] hfsplus: validate B-tree record offset table
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Date: Tue, 28 Jul 2026 17:36:20 -0700
In-Reply-To: <20260728101257.1031425-1-r772577952@gmail.com>
References: <49e053c065c675b10daa6f7a4890ffb7625d6dcd.camel@dubeyko.com>
	 <20260728101257.1031425-1-r772577952@gmail.com>
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

On Tue, 2026-07-28 at 18:12 +0800, Jiaming Zhang wrote:
> A crafted HFS+ image can contain a corrupted B-tree node. The node
> descriptor may contain a record count that does not fit in the node,
> and
> record offsets may be unordered, unaligned, outside the node, or
> point into
> the offset table itself.
>=20
> Several B-tree helpers consume these on-disk fields before validating
> them:
> hfs_bnode_dump() can walk past the offset table when num_recs is
> corrupted,
> hfs_brec_lenoff() can produce an underflowed length or a record range
> that
> overlaps the offset table. This can make the unlink/writeback path
> repeatedly call hfs_bnode_read_u16() with invalid offsets while
> holding the
> HFS+ B-tree lock, producing a flood of "requested invalid offset"
> messages.
> Other writeback workers then block on tree->tree_lock and the system
> reports tasks hung in hfsplus_write_inode().
>=20
> Validate num_recs against the node size before walking the record
> offset
> table. Reject record ranges that are unordered, unaligned, outside
> the
> node, or overlapping the offset table. Reject invalid record indexes
> before
> reading their offset entries, and avoid decrementing an already-zero
> leaf_count.
>=20
> Closes:
> https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25=
Vuju10Q@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> Changes in v5:
> - Switch helpers to invalid checker and invert callers.
> - hfs_brec_offsets_invalid(): Drop the redundant offset-table
> argument
> =C2=A0 since it is already covered by the offset-table overlap check and
> take
> =C2=A0 just the two neighboring record offsets (off and next_off).
> - hfs_brec_len_invalid(): reject a length against node_size.
> - Use hfs_brec_len_invalid() for both length checks in
> hfs_bmap_get_map_page().
> - Validate the record offset in hfs_bmap_free().
> - Check the __hfs_brec_find() return code in [2] and [3]. [1] and [4]
> call
> =C2=A0 it to find the insertion slot for a new index key after a split, -
> ENOENT is
> =C2=A0 one of expected, even -EINVAL the following hfs_brec_insert() just
> inserts
> =C2=A0 at slot 0 of a node already validated by hfs_bnode_find(), so it
> stays
> =C2=A0 in-bounds and cannot trigger the invalid-offset flood. Hence no
> check was
> =C2=A0 added.
>=20
> [1]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L160
> [2]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L208
> [3]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L382
> [4]
> https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L449
>=20
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
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 23 ++++++------
> =C2=A0fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++---
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 53 ++++++++=
++++++++++---------
> =C2=A0fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++--
> =C2=A0fs/hfsplus/hfsplus_fs.h | 79
> +++++++++++++++++++++++++++++++++++++++++
> =C2=A05 files changed, 153 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 9a55fa6d5294..ca9813f58a6d 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -18,6 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0
> =C2=A0	fd->tree =3D tree;
> =C2=A0	fd->bnode =3D NULL;
> +	hfs_find_result_init(fd);
> =C2=A0	ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> =C2=A0	if (!ptr)
> =C2=A0		return -ENOMEM;
> @@ -106,17 +107,21 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	u16 off, len, keylen;
> =C2=A0	int rec;
> =C2=A0	int b, e;
> -	int res;
> +	int res =3D -ENOENT;
> =C2=A0
> =C2=A0	BUG_ON(!rec_found);
> +	hfs_find_result_init(fd);
> +	if (hfs_bnode_num_recs_invalid(bnode))
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
> +		if (hfs_brec_len_invalid(bnode, len) ||
> +		=C2=A0=C2=A0=C2=A0 hfs_brec_len_invalid(bnode, keylen)) {
> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -130,7 +135,8 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	if (rec !=3D e && e >=3D 0) {
> =C2=A0		len =3D hfs_brec_lenoff(bnode, e, &off);
> =C2=A0		keylen =3D hfs_brec_keylen(bnode, e);
> -		if (keylen =3D=3D 0) {
> +		if (hfs_brec_len_invalid(bnode, keylen) ||
> +		=C2=A0=C2=A0=C2=A0 hfs_brec_len_invalid(bnode, len)) {
> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -158,11 +164,7 @@ int hfs_brec_find(struct hfs_find_data *fd,
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
> @@ -274,7 +276,8 @@ int hfs_brec_goto(struct hfs_find_data *fd, int
> cnt)
> =C2=A0
> =C2=A0	len =3D hfs_brec_lenoff(bnode, fd->record, &off);
> =C2=A0	keylen =3D hfs_brec_keylen(bnode, fd->record);
> -	if (keylen =3D=3D 0) {
> +	if (hfs_brec_len_invalid(bnode, len) ||
> +	=C2=A0=C2=A0=C2=A0 hfs_brec_len_invalid(bnode, keylen)) {
> =C2=A0		res =3D -EINVAL;
> =C2=A0		goto out;
> =C2=A0	}
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index d088fb7eb0df..3a1a1fa6f2e2 100644
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
> +	if (hfs_bnode_num_recs_invalid(node)) {
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
> +	if (hfs_bnode_num_recs_invalid(node))
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
> +		if (hfs_brec_offsets_invalid(node, off, next_off))
> =C2=A0			goto node_error;
> =C2=A0		entry_size =3D next_off - off;
> =C2=A0		if (node->type !=3D HFS_NODE_INDEX &&
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index e3df89284079..f416e562d439 100644
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
> +	if (hfs_brec_record_invalid(node, rec)) {
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
> +	if (hfs_brec_offsets_invalid(node, *off, next_off)) {
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
> +	if (hfs_brec_record_invalid(node, rec))
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
> +		if (hfs_brec_len_invalid(node, len))
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
> @@ -181,14 +191,20 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> =C2=A0	struct hfs_btree *tree;
> =C2=A0	struct hfs_bnode *node, *parent;
> =C2=A0	int end_off, rec_off, data_off, size;
> +	int res;
> =C2=A0
> =C2=A0	tree =3D fd->tree;
> =C2=A0	node =3D fd->bnode;
> =C2=A0again:
> +	if (hfs_brec_record_invalid(node, fd->record))
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
> @@ -205,7 +221,9 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> =C2=A0		hfs_bnode_put(node);
> =C2=A0		node =3D fd->bnode =3D parent;
> =C2=A0
> -		__hfs_brec_find(node, fd, hfs_find_rec_by_key);
> +		res =3D __hfs_brec_find(node, fd,
> hfs_find_rec_by_key);
> +		if (res && res !=3D -ENOENT)
> +			return res;
> =C2=A0		goto again;
> =C2=A0	}
> =C2=A0	hfs_bnode_write_u16(node,
> @@ -368,6 +386,7 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0	int newkeylen, diff;
> =C2=A0	int rec, rec_off, end_rec_off;
> =C2=A0	int start_off, end_off;
> +	int res;
> =C2=A0
> =C2=A0	tree =3D fd->tree;
> =C2=A0	node =3D fd->bnode;
> @@ -379,7 +398,9 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd)
> =C2=A0	parent =3D hfs_bnode_find(tree, node->parent);
> =C2=A0	if (IS_ERR(parent))
> =C2=A0		return PTR_ERR(parent);
> -	__hfs_brec_find(parent, fd, hfs_find_rec_by_key);
> +	res =3D __hfs_brec_find(parent, fd, hfs_find_rec_by_key);
> +	if (res && res !=3D -ENOENT)
> +		return res;
> =C2=A0	if (fd->record < 0)
> =C2=A0		return -ENOENT;
> =C2=A0	hfs_bnode_dump(parent);
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 394542a47e60..b3d6ee78773e 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -168,8 +168,8 @@ static struct page *hfs_bmap_get_map_page(struct
> hfs_bnode *node,
> =C2=A0	}
> =C2=A0
> =C2=A0	ctx->len =3D hfs_brec_lenoff(node, rec_idx, &off16);
> -	if (!ctx->len)
> -		return ERR_PTR(-ENOENT);
> +	if (hfs_brec_len_invalid(node, ctx->len))
> +		return ERR_PTR(-EINVAL);
> =C2=A0
> =C2=A0	if (!is_bnode_offset_valid(node, off16))
> =C2=A0		return ERR_PTR(-EIO);
> @@ -622,6 +622,11 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0	if (IS_ERR(node))
> =C2=A0		return;
> =C2=A0	len =3D hfs_brec_lenoff(node, 2, &off);
> +	if (hfs_brec_len_invalid(node, len) ||
> +	=C2=A0=C2=A0=C2=A0 !is_bnode_offset_valid(node, off)) {

If I am correct, the off value is never used. So, I think that this
check is not necessary here. Am I right?

> +		hfs_bnode_put(node);

I think we cannot keep silence here. I believe that we should have the
error message for this case. Do you agree?

> +		return;
> +	}
> =C2=A0	while (nidx >=3D len * 8) {
> =C2=A0		u32 i;
> =C2=A0
> @@ -648,6 +653,11 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0			return;
> =C2=A0		}
> =C2=A0		len =3D hfs_brec_lenoff(node, 0, &off);
> +		if (hfs_brec_len_invalid(node, len) ||
> +		=C2=A0=C2=A0=C2=A0 !is_bnode_offset_valid(node, off)) {

Ditto.

> +			hfs_bnode_put(node);

Ditto.

> +			return;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	res =3D hfs_bmap_clear_bit(node, nidx);
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index ec04b82ad927..90fcf1eac913 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -587,6 +587,85 @@ bool is_bnode_offset_valid(struct hfs_bnode
> *node, u32 off)
> =C2=A0	return is_valid;
> =C2=A0}
> =C2=A0
> +static inline
> +bool hfs_bnode_num_recs_invalid(struct hfs_bnode *node)
> +{
> +	u32 node_size;
> +	u32 table_size;
> +	u32 area_size;
> +	u32 rec_size =3D sizeof(__be16);
> +	u32 desc_size =3D sizeof(struct hfs_bnode_desc);
> +
> +	if (!node || !node->tree)
> +		return true;
> +
> +	node_size =3D node->tree->node_size;
> +	if (node_size < desc_size)
> +		return true;
> +
> +	area_size =3D node_size - desc_size;
> +	table_size =3D ((u32)node->num_recs + 1) * rec_size;
> +
> +	return table_size > area_size;
> +}
> +
> +static inline
> +bool hfs_brec_record_invalid(struct hfs_bnode *node, int record)
> +{
> +	if (hfs_bnode_num_recs_invalid(node))
> +		return true;
> +	if (record < 0)
> +		return true;
> +
> +	return record >=3D node->num_recs;
> +}
> +
> +static inline
> +bool hfs_brec_offsets_invalid(struct hfs_bnode *node, u16 off, u16
> next_off)
> +{
> +	u32 table_size;
> +	u32 table_start;
> +	u32 rec_size =3D sizeof(__be16);
> +	u32 desc_size =3D sizeof(struct hfs_bnode_desc);
> +
> +	if (!node || !node->tree)
> +		return true;
> +
> +	if (off < desc_size || (off & 1))
> +		return true;
> +
> +	if (next_off <=3D off ||
> +	=C2=A0=C2=A0=C2=A0 next_off > node->tree->node_size ||
> +	=C2=A0=C2=A0=C2=A0 (next_off & 1))
> +		return true;
> +
> +	table_size =3D ((u32)node->num_recs + 1) * rec_size;
> +	table_start =3D node->tree->node_size - table_size;
> +	if (next_off > table_start)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline
> +bool hfs_brec_len_invalid(struct hfs_bnode *node, u16 len)
> +{
> +	if (!node || !node->tree)
> +		return true;
> +
> +	return len =3D=3D 0 || len > node->tree->node_size;
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

Mostly, I don't see the critical issues in the patch. But some minor
corrections are necessary. Meanwhile, let me run xfstests for the
patch.

Thanks,
Slava.
