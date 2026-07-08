Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4043AA1BA
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547539; cv=none; b=NAjhpxiKH0trCYaUooC9d7GheKFpEL+jdvfP3TDcAEM54bt++HCP6C4Fxr8bJhdSq3TxaaC3xTsW3VL6sa/se3LrcVWRCFW28eU3CecwRshQv03OhSFf4fs+GLBkqyegxQ93APAmqRpb08o/B2fW5WVC6+whrG5gEys4jq3IsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547539; c=relaxed/simple;
	bh=QokjjoDamBQsopQBaoLG7JGtzjIEJC4Ff/s0hHTTsOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APeaH4zoRky2lSNvQy1tUZm3cA9PVVt65GIPYWjH713LbrTwfaGBSrnf0ZxzbstNUlDdQRcvJwYudB9wOU2OTDyhXTtnNw/c+zPi1/TnX5epTTNTOP/qmLcIeHor+ayp+IUxUQ03S2qHUNZ5WNqxGft9Do+i7WNoJsjsqZiz8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=x8d/e1T/; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="x8d/e1T/"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6651bc5730dso1853219d50.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783547535; x=1784152335; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zRlhbc4dE0dWvmXF/wM/qzZFzmPWvDUWBoIt0Sf1Hw4=;
        b=x8d/e1T/qIEy2OlcnrFM16mkFe48ruKG7q7GOe2kYyHEvyYm7UFrAxPrU0ydjKOfWE
         a7kcvneUEyFZEj0Vt18brzMyS4F7BZx+7g1uIY5riLXOl3lz9tIbS7UyX+UAPNCqslQp
         1pqvFSed4WWs+Jqu2R79b7Dav66H6TZrIFiXrV4ZRwNmvx5UfGvjCsZpxIv9TMxdcgks
         6UTSSd0pNVEOQ0Cy1J5abHBxUJhwJliE94DuXpDUXcymuWacjz9L3pVGpErem9ndJfzT
         bRIiRU9ay2yk4eRR5tUXY6fPPc4Mya8KAX9lPvaceNt4Gm3mD81mqTrj5UoJTXxaq9xX
         REqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547535; x=1784152335;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zRlhbc4dE0dWvmXF/wM/qzZFzmPWvDUWBoIt0Sf1Hw4=;
        b=Hx42IGRhW7DAKsRMWw+rYJOA0hT9qDx2AzH02Wnho5hUw8dC2qDRF1O3bahugA0Uh7
         upaJqqqesXRckBZ9yJVDCn47Hsq2Y10iZcqBlJAPLlUnGdnaAfYOLjKghDkSUHyrh3ms
         3F3+SKFKVThGHmM4iZT4fJXJdo499nRxujim2wiYh3lS2zkgMmLZKmVKsGfDscRnk9Ks
         FmUyfmEoRHL6EjrTrzO1Kl7o3rKyXey4pUEEktINziJd8tt6Fh/UxVkMVscbKIWXecTA
         2bHv7h2Hzk9VdOS9ranXVVm6UpvAXwM2qMrsfME/KSAt0AtwRIZGXns7bAJbXqoKcMiL
         PH6A==
X-Forwarded-Encrypted: i=1; AHgh+RoQJ+kP0TKEEd7KXcLkpAZsWVSGBE452F8VNPAQRzUzwdGufiCs9fi1k4+31M+OHYO5p5/3K0v1o1eygEh/@vger.kernel.org
X-Gm-Message-State: AOJu0YxqapwnSdNJ/tBIg2CUQZcBRItZme6JBSrO9Ap+1ve7g0fJb3ho
	oN5UqFEOoCxO5WOA6h4g7IWkcWr9X7mtSEEfDmNP96ytxNuyNET+ghLtF9F7Xd205Lc=
X-Gm-Gg: AfdE7ckRx7LYIYw9I5dI0J9kcCv6wzVDlwTnROLAgm/oyECm4btnqzfaHbi2pwPjpIA
	heY6tGjVVbMfF6yjCky43k9XSgXjxI3FTCVpkrTM5zvn7cgvfM5AQmMX+3UIzutqZa5vYery92n
	leF7jTz9Ko9LXqeSb6xK2voERypZOhlrTzHxoCUzxdBydXEHkC96//aZYS1LvnMSEIpyTVY1Xnj
	i2BDJAIH+Q+cEdfnRYjEAcGGAPbKkUM5EsrL8/J6C4PhrBMLhkwLRXPy9eJ+Wy5W7Jq9rxeGxpa
	XSqoQqBw2AqSxLIHCyJ7Lw7ToPk3EmUsfBRoCHkQEL93IIcAHft7HGvhlZE2QTBR/zJu6qp6h3k
	jYLo99KaItnj3YSG7nv77acMo3LacqMK7UboaUpm1LhM2EtlLn3+UHnJr5IBuNYgRU7WaGZRypJ
	+VsRrjnIRg3HBzoSlDN4IlimF65HwdXTkU4MEBItF10PFLw8M0kgP3iY6u1dVtlpfXTxIwHNdkK
	FBVfOj042zRg0WMTSkoNFACuhKw4/xjluXcRD4078cr7Q==
X-Received: by 2002:a05:690e:14c4:b0:664:c3aa:66f0 with SMTP id 956f58d0204a3-6679f07bae3mr3070791d50.39.1783547535341;
        Wed, 08 Jul 2026 14:52:15 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:a313:50b6:1c3c:8459])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66787a5b4adsm2781761d50.18.2026.07.08.14.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:52:14 -0700 (PDT)
Message-ID: <96beade6e2a14b66e80053df0209598e11eb7986.camel@dubeyko.com>
Subject: Re: [PATCH v2 1/1] hfsplus: validate B-tree record offset table
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Date: Wed, 08 Jul 2026 14:52:13 -0700
In-Reply-To: <20260702082201.286288-2-r772577952@gmail.com>
References: <6074d91cefcc32cb54f48a1ee214530836e6c948.camel@dubeyko.com>
	 <20260702082201.286288-1-r772577952@gmail.com>
	 <20260702082201.286288-2-r772577952@gmail.com>
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

On Thu, 2026-07-02 at 16:22 +0800, Jiaming Zhang wrote:
> A crafted HFS+ image can contain a corrupted B-tree node. The node
> descriptor may
> contain a record count that does not fit in the node, and record
> offsets may be
> unordered, unaligned, outside the node, or point into the offset
> table itself.
>=20
> Several B-tree helpers consume these on-disk fields before validating
> them:
> hfs_bnode_dump() can walk past the offset table when num_recs is
> corrupted,
> hfs_brec_lenoff() can produce an underflowed length or a record range
> that overlaps
> the offset table. This can make the unlink/writeback path repeatedly
> call
> hfs_bnode_read_u16() with invalid offsets while holding the HFS+ B-
> tree lock,
> producing a flood of "requested invalid offset" messages. Other
> writeback workers
> then block on tree->tree_lock and the system reports tasks hung in
> hfsplus_write_inode().
>=20
> Reject corrupted B-tree metadata earlier: validate num_recs against
> the node size
> before walking the record offset table, reject record offsets that
> are unordered,
> unaligned, outside the node, or overlapping the offset table, stop B-
> tree record
> walkers on invalid records, and avoid decrementing an already-zero
> leaf_count.
>=20
> Closes:
> https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v...@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 27 +++++++++++++=
+++--
> =C2=A0fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++---
> =C2=A0fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 37 ++++++++=
+++++++---------
> =C2=A0fs/hfsplus/hfsplus_fs.h | 62
> +++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 122 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 9a55fa6d5294..363faf214a1c 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -108,15 +108,28 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	int b, e;
> =C2=A0	int res;
> =C2=A0
> +	fd->record =3D -1;
> +	fd->keyoffset =3D -1;
> +	fd->keylength =3D -1;
> +	fd->entryoffset =3D -1;
> +	fd->entrylength =3D -1;

It looks like static inline function that needs to be re-used
everywhere. And, first of all, it should be called hfs_find_init(). Do
we really need to call this initialization somewhere else? Do you think
that hfs_find_init() if not enough?

> +
> =C2=A0	BUG_ON(!rec_found);
> +	if (!hfs_bnode_num_recs_valid(bnode)) {
> +		res =3D -EIO;

Are you sure that it should -EIO but not -ENOENT? Is hfs_brec_find()
ready to process -EIO? There are multiple __hfs_brec_find() calls that
never analyze the return error code. Are we OK with that?

> +		goto fail;

OK. I see. You need this initialization because you are going to fail
case.

> +	}
> +
> =C2=A0	b =3D 0;
> =C2=A0	e =3D bnode->num_recs - 1;
> =C2=A0	res =3D -ENOENT;
> +	if (bnode->num_recs =3D=3D 0)
> +		goto fail;

Are you sure that we should go to fail? Why should we change the logic
here? I think we can continue the logic even if bnode->num_recs =3D=3D 0.

> =C2=A0	do {
> =C2=A0		rec =3D (e + b) / 2;
> =C2=A0		len =3D hfs_brec_lenoff(bnode, rec, &off);
> =C2=A0		keylen =3D hfs_brec_keylen(bnode, rec);
> -		if (keylen =3D=3D 0) {
> +		if (keylen =3D=3D 0 || keylen >=3D len) {

Are you sure that keylen =3D=3D len is invalid case? What is wrong with
equality?

> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -130,7 +143,7 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd,
> =C2=A0	if (rec !=3D e && e >=3D 0) {
> =C2=A0		len =3D hfs_brec_lenoff(bnode, e, &off);
> =C2=A0		keylen =3D hfs_brec_keylen(bnode, e);
> -		if (keylen =3D=3D 0) {
> +		if (keylen =3D=3D 0 || keylen >=3D len) {

Ditto. What is wrong with equality?

> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -232,6 +245,14 @@ int hfs_brec_goto(struct hfs_find_data *fd, int
> cnt)
> =C2=A0
> =C2=A0	bnode =3D fd->bnode;
> =C2=A0	tree =3D bnode->tree;
> +	if (!hfs_bnode_num_recs_valid(bnode)) {
> +		res =3D -EIO;
> +		goto out;
> +	}
> +	if (bnode->num_recs =3D=3D 0) {
> +		res =3D -ENOENT;
> +		goto out;
> +	}

I am not completely sure that it is proper place for these checks.
Because, we could work with multiple nodes in this method.

> =C2=A0
> =C2=A0	if (cnt < 0) {
> =C2=A0		cnt =3D -cnt;
> @@ -274,7 +295,7 @@ int hfs_brec_goto(struct hfs_find_data *fd, int
> cnt)
> =C2=A0
> =C2=A0	len =3D hfs_brec_lenoff(bnode, fd->record, &off);
> =C2=A0	keylen =3D hfs_brec_keylen(bnode, fd->record);
> -	if (keylen =3D=3D 0) {
> +	if (keylen =3D=3D 0 || keylen >=3D len) {

Ditto. What is wrong with equality?

> =C2=A0		res =3D -EINVAL;
> =C2=A0		goto out;
> =C2=A0	}
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
> =C2=A0			goto node_error;
> =C2=A0		entry_size =3D next_off - off;
> =C2=A0		if (node->type !=3D HFS_NODE_INDEX &&
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index e3df89284079..fe2e0636798c 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -20,38 +20,44 @@ static int hfs_btree_inc_height(struct hfs_btree
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
> +		return 0;
> +	}
> +
> +	data_off =3D node->tree->node_size - (rec + 2) * 2;
> +	hfs_bnode_read(node, retval, data_off, 4);
> =C2=A0	*off =3D be16_to_cpu(retval[1]);
> -	return be16_to_cpu(retval[0]) - *off;
> +	next_off =3D be16_to_cpu(retval[0]);
> +	if (!hfs_brec_range_valid(node, *off, next_off, data_off))
> +		return 0;
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
> +		if (len =3D=3D 0)
> =C2=A0			return 0;
> -		}
> =C2=A0
> =C2=A0		retval =3D hfs_bnode_read_u16(node, recoff) + 2;
> -		if (retval > node->tree->max_key_len + 2) {
> +		if (retval >=3D len || retval > node->tree-
> >max_key_len + 2) {
> =C2=A0			pr_err("keylen %d too large\n",
> =C2=A0				retval);
> =C2=A0			retval =3D 0;
> @@ -185,10 +191,15 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> =C2=A0	tree =3D fd->tree;
> =C2=A0	node =3D fd->bnode;
> =C2=A0again:
> +	if (!hfs_brec_record_valid(node, fd->record))
> +		return -EIO;
> +
> =C2=A0	rec_off =3D tree->node_size - (fd->record + 2) * 2;
> =C2=A0	end_off =3D tree->node_size - (node->num_recs + 1) * 2;
> =C2=A0
> =C2=A0	if (node->type =3D=3D HFS_NODE_LEAF) {
> +		if (tree->leaf_count =3D=3D 0)
> +			return -EIO;
> =C2=A0		tree->leaf_count--;
> =C2=A0		mark_inode_dirty(tree->inode);
> =C2=A0	}
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index ec04b82ad927..7a345c4d1c06 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -587,6 +587,68 @@ bool is_bnode_offset_valid(struct hfs_bnode
> *node, u32 off)
> =C2=A0	return is_valid;
> =C2=A0}
> =C2=A0
> +static inline
> +bool hfs_bnode_num_recs_valid(struct hfs_bnode *node)
> +{
> +	u32 node_size;
> +	u32 rec_off_size;

u32 rec_size =3D sizeof(__be16);

> +	u32 rec_off_tab_size;
> +	u32 rec_area_size;

Why not?

u32 table_size;
u32 area_size;


> +
> +	if (!node || !node->tree)
> +		return false;
> +
> +	node_size =3D node->tree->node_size;
> +	rec_off_size =3D sizeof(__be16);

We don't need it here.

> +	if (node_size < sizeof(struct hfs_bnode_desc) +
> rec_off_size)

Do you really need to add the rec_off_size? Because, you subtract only
sizeof(struct hfs_bnode_desc).

> +		return false;
> +
> +	rec_area_size =3D node_size - sizeof(struct hfs_bnode_desc);

You reuse sizeof(struct hfs_bnode_desc). We need local variable
instead.

> +	rec_off_tab_size =3D ((u32)node->num_recs + 1) * rec_off_size;
> +
> +	return rec_off_tab_size <=3D rec_area_size;
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
> +{
> +	u32 rec_off_size;

u32 rec_size =3D sizeof(__be16);

> +	u32 rec_off_tab_size;

table_size

> +	u32 rec_off_tab_start;

table_start

Thanks,
Slava.

> +
> +	if (!node || !node->tree)
> +		return false;
> +
> +	if (off < sizeof(struct hfs_bnode_desc) || (off & 1))
> +		return false;
> +
> +	if (next_off <=3D off ||
> +		next_off > node->tree->node_size ||
> +		next_off > rec_off ||
> +		(next_off & 1))
> +		return false;
> +
> +	rec_off_size =3D sizeof(__be16);
> +	rec_off_tab_size =3D ((u32)node->num_recs + 1) * rec_off_size;
> +	rec_off_tab_start =3D node->tree->node_size -
> rec_off_tab_size;
> +	if (next_off > rec_off_tab_start)
> +		return false;
> +
> +	return true;
> +}
> +
> =C2=A0static inline
> =C2=A0u32 check_and_correct_requested_length(struct hfs_bnode *node, u32
> off, u32 len)
> =C2=A0{
