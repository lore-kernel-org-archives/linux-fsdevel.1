Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01427A47F
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937467; cv=none; b=CU/Zq+UcLPJomFz+JJO6YxDuZbQCED9HCYBHjrbN7uzRRJ48oEzcvyvJece5iTkRbWdaVH1lYrSxC4cv7q4Aom722ZerpcV5pFnxHx/utqZ2eVCFUPm0vlHTFDZqpTYRFklwt2vuXTC286Ap5n+GmXP4gOTM5fy7/YujYGQFOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937467; c=relaxed/simple;
	bh=UXqtu+8j7g6Y/iptscRBArYBJCL8LDC5qo6jy0SsgHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OrBcrsPK91owILZNL0Tat+542AFfCfarAYc5e8xVTguXhfkHSkJC4xBvuF2ST3GZFQwCWPEa143/LwKvH4RXTfh8WrNDbgkt6wrQtGKOhTf07mw5CMscl77WB9QuHojIJdxYpeGlcUp5kDiOADOPJyBop8nEpyaYOQxWNVIewtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=mktVg590; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="mktVg590"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66493875766so1411615d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782937464; x=1783542264; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tU+NlMZtfzXce6NqEZf1VNbY4WmO3Yr+TxW5npDraLI=;
        b=mktVg59099FdPEYgNtijKMU0U12LUolLFq8h9JHaDVSOId7yCR4P26Io/Bo9EhJY+Q
         J6StzZ5RUdtw/990NZ4JMRWzvUTGazN1M2xtXyUxlpKDD/9je+n+gZ1K2y0u36HXsNlY
         20MrBwr3CY8aEgoX+O2KQnmS1Rjz7KFdR7Y924mCM5Jkw4DZCN8lrtIxyEi0HwceqqgL
         pTYbqNM4SHyx+C22HYLSvj0gthK8lGXq1bZjnFWrkIdfFSr+L1td3uBGAJYbUEScaGLr
         Nsy62YjK8R9U41PFsVnGm2fAM9NEDipKf0XrlLv5AegyaldYn+uXbArd5OreK3npqtXs
         ll5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937464; x=1783542264;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tU+NlMZtfzXce6NqEZf1VNbY4WmO3Yr+TxW5npDraLI=;
        b=HY8RwQt0Hw9QbCVV2mvWGMGbOO27trk5Ist1tn/oEQns5+272c4Hso+vLjUWKx+6b1
         fvsk/HaK7oUwVlxa2wG6XfYcJ7q0g3WYD29viT7+1DKBNEjjPhWT5hhqhHM7SRj3qTJk
         fiGsCIV87GhfUfyEbbp2wi52M8KBkxZdIWq6h8zD76cE7JR0ju3XFCkHhdfhrvzKyuGI
         D3HLMbr/TQpusfRsu6osFivkxTFs68yhUMFrGy4XJOsbqp9QHzW1/4Rzx7jDV1xM5+i1
         SwV+ii1M2W7kiNp28yGm/CSYhaycYrDh0H+mn2Dlzipgtez1QA8CjvN8vL+AioTFZmLf
         88Ag==
X-Forwarded-Encrypted: i=1; AHgh+RrltQiuakwFOzCMghJHrwMFv+fx9JiTSPjhMEK9iUGLSwPVJYbSgWzqW5KoSc50Hkauce6bnUq/S/hSG92P@vger.kernel.org
X-Gm-Message-State: AOJu0YzOv7PTCMoO94Hhbt/iAzr6mTjAD8z8oWhuzxamiwjSMeZiBtoU
	T8ipk4oODt71ek6jdUZlkCzAMAVvK6bJf/4SewMOnLvqNgcxQns3hPODmZdBeL5Tz+M=
X-Gm-Gg: AfdE7ckyGrk0CSW9F2hqDr2vWIijDATOJYSa3JX3j91SVURM8uzoKb5Xl8btXysqrq+
	dwJehZ/iBjr0GvIqx2sO/k+TeEf215wlA2NB99MuivRRGkO+vmymhHXVRUTGwQu91VAPVdcctBX
	8wWgqaiIwLDYH/mr/ITUTkkEQVxv+xzFnQTIHFwZLKHgAEakKP8a0gWVxUz71umdjOZLKzkrmF9
	qsvl6ZqVOcmTn32xQIOteQv6K0ueqwd0p+CBTnLz7bVdmm3qMuijEyXYo/XM36o5n0dk1fX+EAy
	3ttyqMVqMUOaL0vmtfyOwWeKh58fGIeJLyZrBLtWjKjtd+e6H3Po9NtTg+UtV35PEDxNeKmvRz/
	wpafOQcEW4xKvorCrguXqWu868Zl/fdk0lKBQXoEQ4+P+Xfyntqhuxhplv0kdkRSWVi/yfYLldO
	JZ6TpxMnuDxh1UhPShi96qrRoo8tjzHNgdYIXmGMonYgXOQj005mTNOm0z66FW4vKL+8aIIWt1X
	Hcv41cmNyOXBZbMpSOyZdCS3eGkoETdAkWoCEHdGJVMXB67/Cik3pmmrIbXyjO3DA2h8OQawq84
	RDfMPoBKR3nTh87Irw==
X-Received: by 2002:a05:690c:ed0:b0:80e:38c5:bc17 with SMTP id 00721157ae682-812e8bf0f35mr35919297b3.7.1782937463935;
        Wed, 01 Jul 2026 13:24:23 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144783cc5esm4692777b3.9.2026.07.01.13.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:24:23 -0700 (PDT)
Message-ID: <6074d91cefcc32cb54f48a1ee214530836e6c948.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: validate B-tree record offset table
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Date: Wed, 01 Jul 2026 13:24:21 -0700
In-Reply-To: <20260701055020.385680-1-r772577952@gmail.com>
References: <4ef15f553f01e959209273f5a170288af6ecdc91.camel@dubeyko.com>
	 <20260701055020.385680-1-r772577952@gmail.com>
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

On Wed, 2026-07-01 at 13:50 +0800, Jiaming Zhang wrote:
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
> Reject corrupted B-tree metadata earlier: validate num_recs against
> the node
> size before walking the record offset table, reject record offsets
> that are
> unordered, unaligned, outside the node, or overlapping the offset
> table, stop
> B-tree record walkers on invalid records, and avoid decrementing an
> already-zero
> leaf_count.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Closes:
> https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25=
Vuju10Q@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++++++++---
> =C2=A0fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++++++++++=
--
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 35 ++++++++=
++++++++++++++++++++++-----
> =C2=A0fs/hfsplus/hfsplus_fs.h | 18 ++++++++++++++++++
> =C2=A04 files changed, 70 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 9a55fa6d5294..ace9ba027a9d 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -112,11 +112,13 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	b =3D 0;
> =C2=A0	e =3D bnode->num_recs - 1;
> =C2=A0	res =3D -ENOENT;
> +	if (!bnode->num_recs)

Do you mean bnode->num_recs =3D=3D 0?

> +		return res;

In majority of cases, we check fd->record:

	__hfs_brec_find(parent, fd, hfs_find_rec_by_key);
	if (fd->record < 0)
		return -ENOENT;

So, this is not completely correct to simply return error because, we
do not check the returned error code.

> =C2=A0	do {
> =C2=A0		rec =3D (e + b) / 2;
> =C2=A0		len =3D hfs_brec_lenoff(bnode, rec, &off);
> =C2=A0		keylen =3D hfs_brec_keylen(bnode, rec);
> -		if (keylen =3D=3D 0) {
> +		if (!keylen || keylen >=3D len) {

I really dislike this !keylen pattern is used not for pointer. Should
we expect that that keylen =3D=3D len? Then, we could use keylen !=3D len
here.

> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -130,7 +132,7 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	if (rec !=3D e && e >=3D 0) {
> =C2=A0		len =3D hfs_brec_lenoff(bnode, e, &off);
> =C2=A0		keylen =3D hfs_brec_keylen(bnode, e);
> -		if (keylen =3D=3D 0) {
> +		if (!keylen || keylen >=3D len) {

Ditto.

> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -232,6 +234,10 @@ int hfs_brec_goto(struct hfs_find_data *fd, int
> cnt)
> =C2=A0
> =C2=A0	bnode =3D fd->bnode;
> =C2=A0	tree =3D bnode->tree;
> +	if (!bnode->num_recs) {

I dislike this !bnode->num_recs.

> +		res =3D -ENOENT;
> +		goto out;
> +	}
> =C2=A0
> =C2=A0	if (cnt < 0) {
> =C2=A0		cnt =3D -cnt;
> @@ -274,7 +280,7 @@ int hfs_brec_goto(struct hfs_find_data *fd, int
> cnt)
> =C2=A0
> =C2=A0	len =3D hfs_brec_lenoff(bnode, fd->record, &off);
> =C2=A0	keylen =3D hfs_brec_keylen(bnode, fd->record);
> -	if (keylen =3D=3D 0) {
> +	if (!keylen || keylen >=3D len) {

Ditto.

> =C2=A0		res =3D -EINVAL;
> =C2=A0		goto out;
> =C2=A0	}
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index d088fb7eb0df..df406f75a5b3 100644
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
> +	num_recs =3D be16_to_cpu(desc.num_recs);
> =C2=A0	hfs_dbg("next %d, prev %d, type %d, height %d, num_recs
> %d\n",
> =C2=A0		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
> -		desc.type, desc.height, be16_to_cpu(desc.num_recs));
> +		desc.type, desc.height, num_recs);
> +
> +	if (!hfs_bnode_num_recs_valid(node, num_recs)) {
> +		hfs_dbg("invalid num_recs %u\n", num_recs);
> +		return;
> +	}
> =C2=A0
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
> +	if (!hfs_bnode_num_recs_valid(node, node->num_recs))
> +		goto node_error;
> +
> =C2=A0	rec_off =3D tree->node_size - 2;
> =C2=A0	off =3D hfs_bnode_read_u16(node, rec_off);
> =C2=A0	if (off !=3D sizeof(struct hfs_bnode_desc))
> @@ -588,6 +598,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree
> *tree, u32 num)
> =C2=A0		next_off =3D hfs_bnode_read_u16(node, rec_off);
> =C2=A0		if (next_off <=3D off ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 next_off > tree->node_size ||
> +		=C2=A0=C2=A0=C2=A0 next_off > rec_off ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 next_off & 1)
> =C2=A0			goto node_error;
> =C2=A0		entry_size =3D next_off - off;
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index e3df89284079..dce397be9151 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -20,12 +20,27 @@ static int hfs_btree_inc_height(struct hfs_btree
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
> +	if (rec >=3D node->num_recs ||
> +		!hfs_bnode_num_recs_valid(node, node->num_recs)) {

Ditto. We need static inline function for such check that can be reused
in multiple places.

> +		*off =3D 0;
> +		return 0;
> +	}
> +
> +	data_off =3D node->tree->node_size - (rec + 2) * 2;
> +	hfs_bnode_read(node, retval, data_off, 4);
> =C2=A0	*off =3D be16_to_cpu(retval[1]);
> -	return be16_to_cpu(retval[0]) - *off;
> +	next_off =3D be16_to_cpu(retval[0]);
> +	if (*off < sizeof(struct hfs_bnode_desc) ||
> +		*off & 1 ||
> +		next_off <=3D *off ||
> +		next_off > node->tree->node_size ||
> +		next_off > data_off ||
> +		next_off & 1)

It looks like a static inline function for the check. I dislike such
multi-line check logic.

> +		return 0;
> +	return next_off - *off;
> =C2=A0}
> =C2=A0
> =C2=A0/* Get the length of the key from a keyed record */
> @@ -35,6 +50,9 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16
> rec)
> =C2=A0
> =C2=A0	if (node->type !=3D HFS_NODE_INDEX && node->type !=3D
> HFS_NODE_LEAF)
> =C2=A0		return 0;
> +	if (rec >=3D node->num_recs ||
> +		!hfs_bnode_num_recs_valid(node, node->num_recs))

Ditto.

> +		return 0;
> =C2=A0
> =C2=A0	if ((node->type =3D=3D HFS_NODE_INDEX) &&
> =C2=A0	=C2=A0=C2=A0 !(node->tree->attributes & HFS_TREE_VARIDXKEYS) &&
> @@ -43,7 +61,7 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16
> rec)
> =C2=A0	} else {
> =C2=A0		recoff =3D hfs_bnode_read_u16(node,
> =C2=A0			node->tree->node_size - (rec + 1) * 2);
> -		if (!recoff)
> +		if (recoff < sizeof(struct hfs_bnode_desc) || recoff
> & 1)

I don't quite follow what this check means. Could we rework it somehow?

> =C2=A0			return 0;
> =C2=A0		if (recoff > node->tree->node_size - 2) {
> =C2=A0			pr_err("recoff %d too large\n", recoff);
> @@ -185,10 +203,17 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> =C2=A0	tree =3D fd->tree;
> =C2=A0	node =3D fd->bnode;
> =C2=A0again:
> +	if (fd->record < 0 ||
> +		fd->record >=3D node->num_recs ||

I think it makes sense to call hfs_bnode_num_recs_valid() before
checking fd->record.

> +		!hfs_bnode_num_recs_valid(node, node->num_recs))

It looks like method of fd->record. I suggest to introduce static
inline method of fd->record. Could we reuse this method for another
cases?

> +		return -EIO;
> +
> =C2=A0	rec_off =3D tree->node_size - (fd->record + 2) * 2;
> =C2=A0	end_off =3D tree->node_size - (node->num_recs + 1) * 2;
> =C2=A0
> =C2=A0	if (node->type =3D=3D HFS_NODE_LEAF) {
> +		if (!tree->leaf_count)

Ditto. I dislike this !tree->leaf_count pattern.

> +			return -EIO;
> =C2=A0		tree->leaf_count--;
> =C2=A0		mark_inode_dirty(tree->inode);
> =C2=A0	}
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index ec04b82ad927..8b2f2041b8b9 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -587,6 +587,24 @@ bool is_bnode_offset_valid(struct hfs_bnode
> *node, u32 off)
> =C2=A0	return is_valid;
> =C2=A0}
> =C2=A0
> +static inline
> +bool hfs_bnode_num_recs_valid(struct hfs_bnode *node, u16 num_recs)

What the point to provide num_recs? You can access it by node-
>num_recs.

> +{
> +	u32 node_size;
> +	u32 offs_size;
> +
> +	if (!node || !node->tree)
> +		return false;
> +
> +	node_size =3D node->tree->node_size;
> +	if (node_size < sizeof(struct hfs_bnode_desc) +
> sizeof(__be16))

You use sizeof(__be16) several times. Also, nobody can follow why you
need to make this addition. So, you need to introduce the local
variable with good name.

> +		return false;
> +
> +	offs_size =3D ((u32)num_recs + 1) * sizeof(__be16);

Ditto.

> +
> +	return offs_size <=3D node_size - sizeof(struct
> hfs_bnode_desc);

It cannot cover all potential corruptions. Because, offs_size could be
smaller one but still to overlap with node's content.

Thanks,
Slava.

> +}
> +
> =C2=A0static inline
> =C2=A0u32 check_and_correct_requested_length(struct hfs_bnode *node, u32
> off, u32 len)
> =C2=A0{
