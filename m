Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63B38552C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281358; cv=none; b=LfkDHp7QRWZ+JBjlnKGQ0ev6oTTthVKEhQAZ9CTWAczBRdvZxvkvkVAs6NHa+dF2Mo0navQEMslzdqaMRh2049AtJZr9qf7vI9YrWiPFtVvj6QejBzDSOvRo6M3oFAa6vEy4Yvti1raLsoe86e677qb5WCsKJh8vcekF5vs8BIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281358; c=relaxed/simple;
	bh=66nRBrO8nbx6YZPEJlTD34nNgufuaSTS5g7/Gm+Lv5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWERudRaCdAPyFW4WVmewFpxQEN1rXkTg6aE0b2YHs4f6M6lnYgUcfZ6S4PQxmokwqeXiNzl5MH0Dib15xtoOCtqVXJGcfk60mYTttQQyTxJ8TpTHKl633LiLo2EBbFAYb/kGkqJgivHrfdd5mhbWZrFf59E0yO1QWdYC3B8cZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=uzLuXTtD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="uzLuXTtD"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39957d210f4so5987281fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782281354; x=1782886154; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PWftbfvoSO+fiIWx+tCIq3YNTgiqrrrq0J+gc3NiFdU=;
        b=uzLuXTtDskutJ3JNGsxUkU34EDP5PKCsHvHpjYDyHNU9yR9FovCzKwIXQD3o3FY0fl
         yHltJF0OmItkLrfMECe1hnmjemvUwDdt4X9nZXkXfSDuR+BChCAUyq7sr1zSe2ZSgJAw
         4Zq9vIt8oFqiJJLNW/nXqDBudblMaWayXO+JBZxbP7lB2sp8hrWR+LkiuuibEE3qg9nI
         60SeP/GKMX4Se4/w3w/KMt2soIOqF5QejF8n/+acdTCVI89wHHNZe7kOtDIgAOWwDP6b
         CbXeX9DQR5moRhiVy8TdTQFdDy81Pgpd9wXCyDNZfZbIK9ElgNUcLD5iDTRcf3D3eWR1
         o41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782281354; x=1782886154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWftbfvoSO+fiIWx+tCIq3YNTgiqrrrq0J+gc3NiFdU=;
        b=RfPiQ2cuX2UnUBaQQqZ/MMHTauzYKTwRWFlhvdiDUmOzRN/kEMj4CHubZJu5FQ+ajc
         Hh2h3UDrE5i7Q5BTPGRVoWbMUS8TSVGX2MM6CPALSfTr60mrxsVOaSmN5GjFw2VMhA85
         5Jn9q/JEMY8yCYrOJMUe2tzpH8G4Z2t3rPA10Zb34YXr9j7NdkNuyEZMfTcEnhiuUnnE
         LdlFyVK3pMNj2uGS8ZZhdB1K5uA/VvJwvEleEmNuBTjlWo1XevZv8GXZu8VQ/N+USp/T
         W4oC11BukrUpOanhknPphA3q9YBe7i+FfHZvfkPnzWNDJf09plHQsu5XW71IMxxBaJTe
         Bx6w==
X-Forwarded-Encrypted: i=1; AFNElJ+YFlHYkQN74GUvGPu/GrZPcICTYSBqZaV1EqDZIjlnF5otKyG71dFApY58n47tRGuxvRSNoKzjkokPCQZo@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwOJ+mHcdnaBJ4ukNNJfOoQydgWgFvrdhpqYEipffjdxGMhHj
	/8f4w4z0PBob1y89Phail3cuTtf3KSHhfeczilTGsxzdUEyLadZxYJ9VjJkzAzW6wEk=
X-Gm-Gg: AfdE7ck4iGC8wMBZ1+6t5hONUgeAkFSeQCY0q5edV1RjeuLDnQl93jQW+Zbyk8pjoeK
	+BhpCUcmACPKDLs6uKFFOdAERGIwKhtmdoan7XzKswqZXLZOzQpAfWDBipW8+5dkZ/gpK219LQ1
	zHRrPbrW07WAFyQqWAudKpNaRDu+xOIcQCXRInIgF7rwoNnVCHF1y/dt3ZFxSqpfnsepLwOT3Oh
	zoF9xD+m2X4cP/uyZjH1SzPsOeQsz6bihFYyF34eF8Tbc49bXbzF8pycEGUNS5HQXQdCBOype4p
	QxsJ+i8aO7hqxXHRiEYDZqHA7RCHSxa18l8pfoWkTqJzBDsDRPpl2TjF1TpNdoclE+fnO2UmMif
	CoKmhgOziwSYiJcL+Kuk7K0C23G0dO2AqdLunOmYFa6H16+jiaUOXDpayAFeFU2824+0h5UsRzn
	3jkrfO1WYH4nh3FOKNjNgX3Z6ae/LK4B4QozU2az5kZjFcw3lvd9hNqsoygOlXF/MG10iXjjC17
	1bDhsHZSYh/NxVZrUzhddNjs94Zk3sAonqgVlpoRWQ1e6z3E6/7vTAQN0+jYFcafpnRqSikh/n2
	Kw==
X-Received: by 2002:a05:6512:4509:b0:5aa:73a6:b34e with SMTP id 2adb3069b0e04-5addb81c0c6mr1792491e87.13.1782281353972;
        Tue, 23 Jun 2026 23:09:13 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a268sm1437262e87.38.2026.06.23.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:09:13 -0700 (PDT)
Message-ID: <54c9f92340ce1a9002feebffa595605470a58294.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: port HFS+ b-tree bitmap corruption check
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aditya Srivastava <aditya.ansh182@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Jun 2026 23:09:12 -0700
In-Reply-To: <20260623093750.2311-1-aditya.ansh182@gmail.com>
References: <20260623093750.2311-1-aditya.ansh182@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-23 at 09:37 +0000, Aditya Srivastava wrote:
> From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
>=20
> In HFS+ filesystems, during b-tree open (hfs_btree_open()), the code
> verifies that the allocation map bit for the tree header (node 0) is
> set.
> If not, it indicates a corrupted map record/bitmap and mounts the
> volume
> as read-only (SB_RDONLY) to prevent further damage.
>=20
> HFS filesystems share the same b-tree structure but currently lack
> this
> corruption detection check, which was highlighted by the maintainer.
>=20
> Port this check to HFS:
> 1. Implement hfs_bmap_test_bit() in fs/hfs/btree.c (which safely
> traverses
> =C2=A0=C2=A0 the b-tree map nodes to inspect the desired bit, identical t=
o
> HFS+).
> 2. Invoke hfs_bmap_test_bit() for node 0 at the end of
> hfs_btree_open(),
> =C2=A0=C2=A0 warning and forcing read-only if corruption is detected.
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Link:
> https://lore.kernel.org/all/6a36101b.be22b350.2a3e9.0001.GAE@google.com/T=
/#r446d0fed2a2900bd805534bbcb799d86619ae2ea
> Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
> ---
> =C2=A0fs/hfs/btree.c | 52
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0fs/hfs/btree.h |=C2=A0 1 +
> =C2=A02 files changed, 53 insertions(+)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2eb37a2f64e8..4293399d377e 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -155,6 +155,14 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	kunmap_local(head);
> =C2=A0	folio_unlock(folio);
> =C2=A0	folio_put(folio);
> +
> +	if (!hfs_bmap_test_bit(tree, 0)) {
> +		pr_warn("(%s): %s (cnid 0x%x) map record invalid or
> bitmap corruption detected, forcing read-only.\n",
> +			sb->s_id, id =3D=3D HFS_EXT_CNID ? "extents" :
> "catalog", id);
> +		pr_warn("Run fsck.hfs to repair.\n");
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +
> =C2=A0	return tree;
> =C2=A0
> =C2=A0fail_folio:
> @@ -356,6 +364,50 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> hfs_btree *tree)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +bool hfs_bmap_test_bit(struct hfs_btree *tree, u32 nidx)
> +{
> +	struct hfs_bnode *node;
> +	struct page *page;
> +	u16 off, len;
> +	u8 *data, byte, m;
> +	bool res =3D false;
> +
> +	node =3D hfs_bnode_find(tree, 0);
> +	if (IS_ERR(node))
> +		return false;
> +
> +	len =3D hfs_brec_lenoff(node, 2, &off);
> +	while (nidx >=3D len * 8) {
> +		u32 i;
> +
> +		nidx -=3D len * 8;
> +		i =3D node->next;
> +		if (!i) {
> +			hfs_bnode_put(node);
> +			return false;
> +		}
> +		hfs_bnode_put(node);
> +		node =3D hfs_bnode_find(tree, i);
> +		if (IS_ERR(node))
> +			return false;
> +		if (node->type !=3D HFS_NODE_MAP) {
> +			hfs_bnode_put(node);
> +			return false;
> +		}
> +		len =3D hfs_brec_lenoff(node, 0, &off);
> +	}
> +	off +=3D node->page_offset + nidx / 8;
> +	page =3D node->page[off >> PAGE_SHIFT];
> +	data =3D kmap_local_page(page);
> +	off &=3D ~PAGE_MASK;
> +	m =3D 1 << (~nidx & 7);
> +	byte =3D data[off];
> +	res =3D (byte & m) !=3D 0;
> +	kunmap_local(data);
> +	hfs_bnode_put(node);
> +	return res;
> +}
> +
> =C2=A0void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 99be858b2446..efe88f66c856 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -93,6 +93,7 @@ extern void hfs_btree_write(struct hfs_btree
> *tree);
> =C2=A0extern int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)=
;
> =C2=A0extern struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree);
> =C2=A0extern void hfs_bmap_free(struct hfs_bnode *node);
> +extern bool hfs_bmap_test_bit(struct hfs_btree *tree, u32 nidx);
> =C2=A0
> =C2=A0/* bnode.c */
> =C2=A0extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32
> off, u32 len);

I am still in personal trip and I am on the move until the end of this
week. I'll be able to review the patch around this Sunday or Monday.
Please, ping me if I am keeping silence too long.

Meanwhile, have you tried to run xfstests for current state of HFS
code? Please, be ready that we still have multiple test-case failures
for the case of HFS file system. The point of my request is to check
that number of failed test-cases is not growing by applying this patch.

Thanks,
Slava.
