Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAE364026;
	Wed, 18 Mar 2026 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814164; cv=pass; b=BNCvxsPy/1baufaXkpoD17u9zybh7D/qf1NfUUEStTt0MLm9GxUjKZzBcD5+CUXj5RiGXu2BqD4EAgilXjP9iErA9hnq0qQtKA4NIbrQjMJRqPnYvHJg7SiIfZufhiZ3Ngmq82pq+RYGUBUg5EApGJsJ55ztlrK1NcmyIytkkwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814164; c=relaxed/simple;
	bh=4Dl1fN7BizUvKpgX/ywHHzGNmyktIxXJkwLH9hQ/W4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJOPfuNty8hRPmnPyeLycfiCabjVC9Vc+p1UXZM8dzuQdOo2bFhm7QXJiKE7es2CLGfmPtMcIaAH1rhGIgk3g2ghcVk97K5L8rGoSip8y5ScoH4yTJFuXYcvKifCZI6Yei7A3GGpk2M1Tg4TDYpsfk14OGhL6TkkOvF5HCJi7qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=fTe3c1O4; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="fTe3c1O4"
ARC-Seal: i=1; a=rsa-sha256; t=1773814138; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=igVUegsErK7FYgHlCcKgHQ6wQk0nIHQgFJ/WQpxvELBJCxhk/bKgHyMD46Tot+yo2vrhYPdfpv7kF4Eh5Ct4fhuf0tGkygTum0uP5DIaQvvIbjbOV7b6qv383kH7yY0LWeyMCd86LDOFKToGzxXJU4Yt2w5nrXdJqOdT7sQK0RI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773814138; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Dl1fN7BizUvKpgX/ywHHzGNmyktIxXJkwLH9hQ/W4k=; 
	b=E2f9TsFaKhK2D7xssjbdLv5ZGuPgbgU879ekTEKAnThrBXwfw3PGusEa1LqUlYkyjDIsNIcTSmsTTDoCy5uYEOWvEz7cmUKb6oTwcFZ9X/GOIVBIEcDs6rELoawx/MKQO/8mk8/Jzow8xzIMSSrICjQu4Sw5tXHcFBSLBUe1Ngg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773814138;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=4Dl1fN7BizUvKpgX/ywHHzGNmyktIxXJkwLH9hQ/W4k=;
	b=fTe3c1O488Q+vObwKxieByIDL2nAc/yZsU5+okuShPgPTgmxbE90RfDD6/57bjW9
	hhKqj0bPAKK/CA0URBQjxbLf0zBXWh4TtbETwwrDnatOJfala0IGorXhVDwodEH47DE
	bUotIWwu3AZVZd8KJ11Elgk1vROfWDP8M1Lg1IwY=
Received: by mx.zohomail.com with SMTPS id 1773814136768910.7303281025;
	Tue, 17 Mar 2026 23:08:56 -0700 (PDT)
Message-ID: <56feeef2affaf7f44c3b8b37d70130da70b431f5.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v6 1/2] hfsplus: refactor b-tree map page access and
 add node-type validation
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "janak@mpiric.us" <janak@mpiric.us>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, shardulsb08@gmail.com
Date: Wed, 18 Mar 2026 11:38:50 +0530
In-Reply-To: <1f0be90d77f28c27c29877df848829ec31d2787a.camel@ibm.com>
References: <20260315172005.2066677-1-shardul.b@mpiricsoftware.com>
	 <20260315172005.2066677-2-shardul.b@mpiricsoftware.com>
	 <1f0be90d77f28c27c29877df848829ec31d2787a.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2026-03-16 at 22:21 +0000, Viacheslav Dubeyko wrote:
> On Sun, 2026-03-15 at 22:50 +0530, Shardul Bankar wrote:
> >=20
> > diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> > index 1220a2f22737..1c6a27e397fb 100644
> > --- a/fs/hfsplus/btree.c
> > +++ b/fs/hfsplus/btree.c
> > @@ -129,6 +129,95 @@ u32 hfsplus_calc_btree_clump_size(u32
> > block_size, u32 node_size,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return clump_size;
> > =C2=A0}
> > =C2=A0
> > +/* Context for iterating b-tree map pages
> > + * @page_idx: The index of the page within the b-node's page array
> > + * @off: The byte offset within the mapped page
> > + * @len: The remaining length of the map record
> > + */
> > +struct hfs_bmap_ctx {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int page_idx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int off;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 len;
> > +};
> > +
> > +/*
> > + * Finds the specific page containing the requested byte offset
> > within the map
> > + * record. Automatically handles the difference between header and
> > map nodes.
> > + * Returns the struct page pointer, or an ERR_PTR on failure.
> > + * Note: The caller is responsible for mapping/unmapping the
> > returned page.
> > + */
> > +static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
> > struct hfs_bmap_ctx *ctx,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 byte_offset)
>=20
> I am simply guessing here... Should it be byte_offset? Why do we not
> use bit
> index here? Probably, byte_offset looks reasonable. However, all
> callers
> operates by bit index. I am not insisting of changing the interface.
> I am simply
> sharing some thoughts. :) What do you think?
>=20

Keeping it as `byte_offset` felt slightly cleaner to me because the
helper's primary job is calculating page-level and byte-level
boundaries, leaving the bitwise mask math strictly to the wrapper
functions (`test_bit` and `clear_bit`). Since `hfs_bmap_alloc()` also
scans byte-by-byte, keeping the helper focused on bytes seemed like a
good separation of concerns. I will leave it as `byte_offset` for now
if that works for you!

> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 rec_idx, off16;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int page_off;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (node->this =3D=3D HFSPLU=
S_TREE_HEAD) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (node->type !=3D HFS_NODE_HEADER) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err=
("hfsplus: invalid btree header
> > node\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ERR_PTR(-EIO);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rec_idx =3D HFSPLUS_BTREE_HDR_MAP_REC_INDEX;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (node->type !=3D HFS_NODE_MAP) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err=
("hfsplus: invalid btree map
> > node\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ERR_PTR(-EIO);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rec_idx =3D HFSPLUS_BTREE_MAP_NODE_REC_INDEX;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->len =3D hfs_brec_lenoff=
(node, rec_idx, &off16);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ctx->len)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-ENOENT);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!is_bnode_offset_valid(n=
ode, off16))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EIO);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->len =3D check_and_corre=
ct_requested_length(node, off16,
> > ctx->len);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (byte_offset >=3D ctx->le=
n)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EINVAL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0page_off =3D off16 + node->p=
age_offset + byte_offset;
>=20
> I worry about potential overflow error here because off16 is u16 and
> all other
> variables are unsigned int. What's about (u32)off16 here?
>=20

Ah, great catch. While the C compiler will implicitly promote the u16
to an unsigned int during the addition, explicitly casting it to '(u32)
off16' makes the intention clear and silences any potential static
analysis warnings. I will add the cast in v7.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->page_idx =3D page_off >=
> PAGE_SHIFT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->off =3D page_off & ~PAG=
E_MASK;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return node->page[ctx->page_=
idx];
> > +}
> > +
> > +/**
> > + * hfs_bmap_clear_bit - clear a bit in the b-tree map
> > + * @node: the b-tree node containing the map record
> > + * @node_bit_idx: the relative bit index within the node's map
> > record
> > + *
> > + * Returns 0 on success, -EALREADY if already clear, or negative
> > error code.
>=20
> I assume that error code is -EINVAL now.
>=20

You are correct, I updated the code in v6 but missed updating the
docstring! I will fix this in v7.

Thanks,
Shardul
