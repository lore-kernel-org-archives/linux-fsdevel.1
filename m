Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD52E2665
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960701; cv=none; b=Ss+Csm+eEUpRICShlEqRDg9k267g3pr1WoeeTUeouCkkKg2M1vzBP3WkDfLwKMVkq6GRI/Dz08pmUNFekhCa2splqzE9hykegNLWBY4rWLRzNHs10RLFs00ylmF8yjNAhYxqjk6D4VNe0eMWA9NmVTgEhzB0uDinAcPuih7izfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960701; c=relaxed/simple;
	bh=V0x/oRKmXyzA99OcxL+ymCBukz00CJvdCuqcgXqPmIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtnV1iKmDLXUPKF2mXTHR5wKBjVgwus5WW9Vkh+UO5toYC9s5wNZfB3MJHFSNkTh1I3uyAxqw5wjXJEEydy9mg0N8+KiTTH+XrZ3taS0wlZGzfxg6hTcXqkfVHl4mSs1nHKcaEDaJnVwkxvsG+ZvZtChfCT+Aj8eQfXbPS5jpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Fm9NIA61; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Fm9NIA61"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37fad5eca09so139992a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 19:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782960699; x=1783565499; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3RFGh0L09z2qJ73+1GutVAoI4X0OVaLMsgkVwAPf0q4=;
        b=Fm9NIA61VAajvs37OUDi+hA1zj/+APEX48OF0001V7eDXDViQ0nCac8Hr88c3GihL1
         FSMrhrvw1d4m/6QARw7nV9tHO9THcA1IRA/npWt2wNes/7TcHl2KBKXflXu11Z6lsEB3
         IUzL6Gc+q6kSxxtTVPCZzVKyf9uN98KyRPJKYkBbIjDq5qsHbbBtg7WqwYhP9fYh7R6d
         geplPPUHDQQDAY+KLlNKbBZnRyo0OpOE+EzazSaBf8/i3GiJtyT1DA5WJ9Z/V5VhR0/I
         ItjtWsOa0bdC88KhV8k7bEYLCSEUolHqB/rg6Hk4aCnhkFmUCUawksuuxGmIrPz3ji9g
         LiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960699; x=1783565499;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RFGh0L09z2qJ73+1GutVAoI4X0OVaLMsgkVwAPf0q4=;
        b=a7MrD1qpEGshUw3H5v5Ad6/OJfofqObjSdxO0xkNh60pPZ1TkyrZcx0HKnpykUxD7n
         ImGk1OhY4bq7DshsfgNKieJNkOZJ2U8WR89pDzPRdzYuCjHRjnR497KITT+7gjVV9ciC
         w2GqPI/ZV2/6FShR7SZOy0Q3ubRvsX7divzOsQpg2SS/lHvj1OMujUl+mwNSwSb/N8bY
         /J+RcKlsUaHkCJDvm/pU6ftcr6ak6p6vFFukU8u/cXdsmIiiTmGyiyreRcSYMUUXs9Yp
         biehUcNyftzrFeSibL3KXoNlebZ/rsvIvDSjgUr+0PgJ6sTEjV91p8TRvU5CE5t9HcDM
         F66w==
X-Forwarded-Encrypted: i=1; AFNElJ9F7jaFsfThEXeVlwtNEWOpN78L12QbX4Nff3UD9VHMl+JCkS7AX+grUG/XBGqtRkgsu9jXbR17r21ChK/V@vger.kernel.org
X-Gm-Message-State: AOJu0YzODgQzyJ27OAE2xANn69nROzl79EvjU/ZvmuGXNBhuZZ0rK4yl
	rQxxw8BJx/dJ1Ntxhn2lku7WXCRuwKXU/vdtjJcfNo1XvQZ3BN/EWNzgzpFkfrrCH+o=
X-Gm-Gg: AfdE7cnuQcSzeMmmT2umZ8zo0jTPi79D19mJra41K81EpATsr7PJ6HSeBHbZYPJZo29
	Mu9nyR3T9JlEviNTXBjhLAHVKrUpO6WT64eY1RLcMqCjbfACUs49w2F6mokUV6agn9BuHohQnxV
	VdYw67IEyY3+d6gGzCjZLxT6vCjm0GOr6ciJxV0m+7pZTAlSD7XijUhaT3ZNUuv9wxLMLIh1gVY
	4KABxUF51sTxRQhCWKLPeRon3b5E7L96sFzLi6XyKBrXfYNrg65CJej8dN0gVT2k6qKf9xeJIwu
	VB0Bb/SOSO7CyEGwAb86yIjH2y9QD27rjj+r7LpcF7WmLyeysV0tK8QvBHrutR1eQgr5z1gnTt5
	/bVe5ZaEHGqJIHguZdxEASfWtgiBOiNO1+4gzGkaSMlxZor2LJN0a/0lhoKs13lOjJnOuVCTCBe
	ywFZ88Mv2x8zKYMz1ivIgpVi5g7vtxrelWc0ymJoZ2MLHFdds769cAxo8x0SRcY0llbmZRknqc9
	P4Nim634lS5Ksk/+xbp/V4EK4/WVoR56dzNIwZXU2pDeVnk8kGtGAMlYinZu6mEB+MGuUD7Ma/l
	twjDSKc=
X-Received: by 2002:a05:6a21:7008:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3bfd263989amr8432816637.2.1782960698977;
        Wed, 01 Jul 2026 19:51:38 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7682acsm3249960c88.0.2026.07.01.19.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 19:51:38 -0700 (PDT)
Message-ID: <5c6c46993f8fbf44300814e2b37ca62e637cdc66.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: port HFS+ b-tree bitmap corruption check
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aditya Srivastava <aditya.ansh182@gmail.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 Jul 2026 19:51:36 -0700
In-Reply-To: <20260623093750.2311-1-aditya.ansh182@gmail.com>
References: <20260623093750.2311-1-aditya.ansh182@gmail.com>
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

Why we cannot follow to the approach is implemented in HFS+?

static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx)
{
	struct hfs_bmap_ctx ctx;
	struct page *page;
	u8 *bmap, byte, mask;

	page =3D hfs_bmap_get_map_page(node, &ctx, node_bit_idx /
BITS_PER_BYTE);
	if (IS_ERR(page))
		return false;

	bmap =3D kmap_local_page(page);
	byte =3D bmap[ctx.off];
	kunmap_local(bmap);

	mask =3D 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
	return (byte & mask) !=3D 0;
}

Currently implemented function looks slightly complicated. Also, I
would like to have similar logic in HFS and HFS+ with the goal to make
b-tree logic something like library that HFS and HFS+ code can use.

Thanks,
Slava.

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
