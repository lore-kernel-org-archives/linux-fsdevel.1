Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B8364026;
	Wed, 18 Mar 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814208; cv=pass; b=RNCGKAYoIuY4VS9HWdWr1pKuH5oYClXWjHJdqrm6Y68ZQ+ujZauHMLzkDn2V5KPzjoV6y5UZcPfLczl3wo9nrDwtQiIjPOkn4GPBjjUIDUSeEsToISQg2AsswgeDgTHngCNyHUztlciH7AVlfVt3LxQYGtR6TYpm9d36qD+cdgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814208; c=relaxed/simple;
	bh=PQ9OK3zNDreS8EAK8cn2MHAlSHSRUDkGA6LTkk/2eE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hND2qlQhG3Id6P+Lf9eDz4f1u9hTa1HNCjYBQoFyrdnUE9apxMxI9mBgy2EzVuCJ3TvBz3ijym46Ly2bXI3tkh1bwU6XzAlzDE2Vk7zV8Yyz9vEvjb8r2BvpRVbRsX/C39Ft/vmmkXVaX8YNtYY+2MncuuosfTFyqfHhpOFSSes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=uf3eydJI; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="uf3eydJI"
ARC-Seal: i=1; a=rsa-sha256; t=1773814188; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jQdoH5TmIkUylL7lXsbAwXcvY1VLoq3epri1MtFmHt3yiwR+/tdkIKqCmz6vM007lJCfWCYtL98LewohN8Bxz7NSkfiZFzHemtQ9ua0zXUrI8FRttoerhkmZIKVG8nYEQURHvJIo48jnv2WdbR6Cj5UEo19+hPGI0Usj44iaQdk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773814188; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PQ9OK3zNDreS8EAK8cn2MHAlSHSRUDkGA6LTkk/2eE0=; 
	b=T3i5006Yuqyvriz99BEFz4c88ForFYFZv8OKv/CgYn0bXlkucRXLTFBjKrjrAgp6KqjVhkKsgulzGrC/b9jjAHLPjv2/ZevftzR26HxfxQaqd/dHYPDB9Li90RLm8nrdCVIFAi9AtycYX9EkgYHicrq3t/xzQWwECYwadMGEH2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773814188;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=PQ9OK3zNDreS8EAK8cn2MHAlSHSRUDkGA6LTkk/2eE0=;
	b=uf3eydJIWjjM3LyX6cYZiaI5GkuixYcmymqWiADumP4sUPMAwCgthMqfVbBf3Ghb
	74612CJUe7xn0WIyFCcnpDO3ra9HF7VbqvXrWlA/xsb5SoTXr6rB0hb0HBHEqB2y4pr
	se2ALBWw7gNBM0bB7M5E0IfxP77ptBr2BgDKJrG8=
Received: by mx.zohomail.com with SMTPS id 177381418653085.38810802689352;
	Tue, 17 Mar 2026 23:09:46 -0700 (PDT)
Message-ID: <462cd1c4f31f6cc2d7077d076f4b07eed185e57a.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v6 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "janak@mpiric.us" <janak@mpiric.us>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, 
	"syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	shardulsb08@gmail.com
Date: Wed, 18 Mar 2026 11:39:40 +0530
In-Reply-To: <c4df4e9ea51ac7cf02ece60e258b19cdcd628b7e.camel@ibm.com>
References: <20260315172005.2066677-1-shardul.b@mpiricsoftware.com>
	 <20260315172005.2066677-3-shardul.b@mpiricsoftware.com>
	 <c4df4e9ea51ac7cf02ece60e258b19cdcd628b7e.camel@ibm.com>
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

On Mon, 2026-03-16 at 22:35 +0000, Viacheslav Dubeyko wrote:
> On Sun, 2026-03-15 at 22:50 +0530, Shardul Bankar wrote:
> >=20
> > +/**
> > + * hfs_bmap_test_bit - test a bit in the b-tree map
> > + * @node: the b-tree node containing the map record
> > + * @node_bit_idx: the relative bit index within the node's map
> > record
> > + *
> > + * Returns 1 if set, 0 if clear, or a negative error code on
> > failure.
> > + */
> > +static int hfs_bmap_test_bit(struct hfs_bnode *node, u32
> > node_bit_idx)
>=20
> Why not return bool data type?
>=20
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hfs_bmap_ctx ctx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct page *page;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *bmap, byte, mask;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0page =3D hfs_bmap_get_map_pa=
ge(node, &ctx, node_bit_idx /
> > BITS_PER_BYTE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(page))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(page);
>=20
> We can return false for the case of error.
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bmap =3D kmap_local_page(pag=
e);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte =3D bmap[ctx.off];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunmap_local(bmap);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mask =3D 1 << (7 - (node_bit=
_idx % BITS_PER_BYTE));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (byte & mask) ? 1 : 0=
;
>=20
> This is why I would like to see bool data type. :)
>=20

I completely agree. Changing the return type to `bool` and returning
`false` on both an IO error and a cleared bit vastly simplifies the
caller. I will update `hfs_bmap_test_bit()` to return a `bool`, and I
will collapse the two `res < 0` and `res =3D=3D 0` validation checks in
`hfs_btree_open()` into a single `if (!hfs_bmap_test_bit(node, 0))`
block in v7.

> > +}
> > +
> > +
> > =C2=A0/**
> > =C2=A0 * hfs_bmap_clear_bit - clear a bit in the b-tree map
> > =C2=A0 * @node: the b-tree node containing the map record
> > @@ -218,15 +244,36 @@ static int hfs_bmap_clear_bit(struct
> > hfs_bnode *node, u32 node_bit_idx)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> > =C2=A0
> > +#define HFS_EXTENT_TREE_NAME=C2=A0 "Extents"
>=20
> Maybe we need to have Extents Overflow File (or B-tree), Catalog
> file,
> Attributes file?
>=20

Good point, those are the proper structural names. For v7, I will
update the macros to "Extents Overflow File", "Catalog File", and
"Attributes File", and I will slightly tweak the `pr_warn` format
string to accommodate the new names gracefully.

> > +#define HFS_CATALOG_TREE_NAME "Catalog"
> > +#define HFS_ATTR_TREE_NAME=C2=A0=C2=A0=C2=A0 "Attributes"
> > +#define HFS_UNKNOWN_TREE_NAME "Unknown"
> > +
> > +static const char *hfs_btree_name(u32 cnid)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (cnid) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case HFSPLUS_EXT_CNID:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return HFS_EXTENT_TREE_NAME;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case HFSPLUS_CAT_CNID:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return HFS_CATALOG_TREE_NAME;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case HFSPLUS_ATTR_CNID:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return HFS_ATTR_TREE_NAME;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return HFS_UNKNOWN_TREE_NAME;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +}
> > +
> > =C2=A0/* Get a reference to a B*Tree and do some initial checks */
> > =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hfs_btree *tree;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hfs_btree_header=
_rec *head;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct address_space *m=
apping;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hfs_bnode *node;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *inode;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct page *page;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int res;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tree =3D kzalloc_obj(*t=
ree);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tree)
> > @@ -331,6 +378,26 @@ struct hfs_btree *hfs_btree_open(struct
> > super_block *sb, u32 id)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunmap_local(head);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0put_page(page);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0node =3D hfs_bnode_find(tree=
, HFSPLUS_TREE_HEAD);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(node))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto free_inode;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D hfs_bmap_test_bit(no=
de, 0);
>=20
> We definitely can return false for both cases.
>=20

Ack'ed

I will prepare the v7 patchset with these final stylistic polishings.=20

Thanks for the guidance throughout this series!
Shardul
