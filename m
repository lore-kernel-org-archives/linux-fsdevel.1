Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A452D8DB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899115; cv=none; b=LBZk6rkGLh32tCtyESUvXJq26oeEXoBij5y3Uca7+Q17Y6K1CM0gm/sSiHulrRy1cQrYAQUAcOIt0e8IqjKQBlJiyXzoPJmQLb/kkZv3Zd/i+37+cpPZYg20DUaxvdfQYSjroU2etkiSTFokAXm2y7eO5fb/bJWLB9Y7HzrR3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899115; c=relaxed/simple;
	bh=thLiyIcNke4TCPMCu3CUKpsUc5eDoR3oMMoAXIyJAkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8B/QLPJ65JyH7FCFsPJQzsIfr5LjzAqDE+4+YGQTsk2L6/tgELMb38VymxnQcYfF3SbPxHdTY/iDgwSFu3QXGa6VTkjfj7XIs0OxMqwyZDE1Pb+SSmWHIuyHAVSUOrQmNifNMabAvLLO5Nz4VJDZM3VmsJ52qVfybKvr19XivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmDyoeAq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGao34y8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmDyoeAq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGao34y8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776899112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/Yb5z7akaYaPjtq31YYTPejINDkMWFksvY9tqU2bIs=;
	b=YmDyoeAqf1YFktXbXsWDhk43FJld1XVB+Qp9YG37GnuRARyCiSflzhfqoj0vPKOQhpx2jj
	RHRsjOf9X23S45oFUwh9P7b1qe+56brTaS4SGNwe1knQZnFiR8Wb5WZL0OLuwVkRBgrJvl
	m/jFHXZ3dVNL64dRCjOcx6zAQx7HUCA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-YwubxidwOgKSOhlm38L4MQ-1; Wed, 22 Apr 2026 19:05:11 -0400
X-MC-Unique: YwubxidwOgKSOhlm38L4MQ-1
X-Mimecast-MFC-AGG-ID: YwubxidwOgKSOhlm38L4MQ_1776899111
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45a8cdc7e01so7991184b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776899110; x=1777503910; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z/Yb5z7akaYaPjtq31YYTPejINDkMWFksvY9tqU2bIs=;
        b=bGao34y88xn4p47FpPfzGbGOHz7KrsQTxak2k9QkW7YcIDmIbPVt+6ih+m1cXDmRfr
         F2zI/u9NY+gbFYs8cMrXGio5Lhl6/Ax+7L2ugzcgtS0uru2wp+nghIeWwJ85/dEEq3iU
         gUJ4p2m7EdSEI4gc852NklokUDLjZM/X8hh30/NhqokR/H3/jNGpOZSl0mXZrxCrbV+7
         J/BWRFkSH2/JcAqko9G5k8jk1nZJyTgTKSCuxQ75fmnFqZ33hyWo0DV8Dtp0K979Ge9r
         VcagC9IrBMLzySoT5omQaLBU+BaIde7mk4ghui/4woS7owflOjewOhGz12HZLBlv4uDs
         D6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776899110; x=1777503910;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/Yb5z7akaYaPjtq31YYTPejINDkMWFksvY9tqU2bIs=;
        b=nQeUDDrrS27N1ZHGcotQyYebFAD6rngs1yNAT5jhDMv0rVFH+eFXUK59CoXZxCwUPu
         clggWJIpCr2Entn4SCgLZbyeD2dVroT6I4OwzO9MnHVe8oD0pBip9LCzDDXEfSij2d1+
         S/Rzv69TYNvNYDf44o6LbLrUolbNyBUXGmvjaISU3T++gYpxweyqq7Pqk1aMVrgp7d5Z
         8pqdVMsLZ4xwFfxjgBG2XoFcf2NdyNDHGK5qz8ZfEZq/EfrgIgctGwL1Ky28Fc5NAKfS
         UPRNsnt8kQj+1y3RCh1Wixgp4nlA2F45j/GK0zAlz8uHYL93zBFdReOJF4UKIfKPRqUX
         BFjw==
X-Gm-Message-State: AOJu0YyY+av6G6DsRtLu42lD+muzxC5+lHgltI1TZCnWUM1a9X34N2aA
	r+jYRs/RKwgVHKgAPqdE412QJ9tI5PRPvRwVOh9nQao9hqRnvud5xcuHwB+pXLhxP9Ou+VrgfGd
	vnBuIR+c93XZoKHjX5L4U8dbG9MlyE/RplSlQCQg4s4mwd2UGtRd5+Dwq3+i5LtA9zho=
X-Gm-Gg: AeBDies6yMkZ8PcZfUrzJsffEuF2QuNXoDyI+nC3HcQZTuN2exABvwue+gAlZguBobr
	fiBWzsJ2kKGxGUAlKz16ragqpenKHosXsKUDxKmRi0ESoM1xvOB+2e04PB2zcMi2ubdsWmD7SKv
	xDClpk6kZusBSKlMu78DNIPvLq9EZ8fEYSbJ/dJNP2tiuawTK5i2hKjfg1IUKe+NB+rvYK3gGRl
	kgZC9W+EIRCiEIn5FhHui59cKiCXwkqjCWpA4XKR3N1fOqZ7qtYaBZIImXGP6d1H3Ct/qCh+/3Z
	0nJaZ/smDh70ZpC1nvJy/eD/4JEtuUYdr08vrCTsMFs454o+D9ubFnz2ue2BpHPzT8mEvLEbh6l
	aBjVwofMBqTaVFl8BPQCYhn1Y686CAMcMJ+kCuuMkE6iKz/wasL6I91/uamOAuEQ=
X-Received: by 2002:a05:6808:8888:b0:479:d57b:839e with SMTP id 5614622812f47-479d57b8c70mr5326078b6e.24.1776899110573;
        Wed, 22 Apr 2026 16:05:10 -0700 (PDT)
X-Received: by 2002:a05:6808:8888:b0:479:d57b:839e with SMTP id 5614622812f47-479d57b8c70mr5326071b6e.24.1776899110107;
        Wed, 22 Apr 2026 16:05:10 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799ff36814sm12431712b6e.7.2026.04.22.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:05:09 -0700 (PDT)
Message-ID: <a274aafb30abfee53d81525028ae64ebe9316620.camel@redhat.com>
Subject: Re: [PATCH] hfs: validate bitmap record offset in hfs_bmap_alloc
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org,
 syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com,  Tristan Madani
 <tristan@talencesecurity.com>
Date: Wed, 22 Apr 2026 16:05:08 -0700
In-Reply-To: <20260418133949.1713416-1-tristan@talencesecurity.com>
References: <20260418133949.1713416-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-18 at 13:39 +0000, Tristan Madani wrote:
> hfs_bmap_alloc() retrieves the bitmap record from the header node
> using hfs_brec_lenoff() but does not validate the returned offset
> and length before using them to compute page pointers.  On a crafted
> HFS image with corrupted B-tree data, the offset can exceed the node
> size, causing an out-of-bounds page access.
>=20
> Additionally, when the bitmap has node 0 bit incorrectly unset,
> hfs_bmap_alloc() calls hfs_bnode_create(tree, 0) for the already-
> hashed header node, triggering a WARN_ON and returning the existing
> node without incrementing its reference count.
>=20
> Port the fixes already applied to HFS+ (commits d8a73cc46c84 and
> 738d5a51864e) to the HFS side:
>=20
> 1. Move is_bnode_offset_valid() and check_and_correct_requested_length()
>    from bnode.c to btree.h so they can be used by btree.c.
>=20
> 2. Validate the record offset and length in hfs_bmap_alloc() before
>    computing page pointers, preventing out-of-bounds access.
>=20
> 3. Return ERR_PTR(-EEXIST) from hfs_bnode_create() when the node is
>    already hashed, properly signaling filesystem corruption to callers.

I assume that we have the second version of the patch again. Am I correct?

> Reported-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
> Tested-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da19ca73b21fe8bc69101
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c | 44 +-------------------------------------------
>  fs/hfs/btree.c |  6 ++++++
>  fs/hfs/btree.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 43 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 13d58c51fc46b..26c2e65ab5935 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -15,48 +15,6 @@
> =20
>  #include "btree.h"
> =20
> -static inline
> -bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
> -{
> -	bool is_valid =3D off < node->tree->node_size;
> -
> -	if (!is_valid) {
> -		pr_err("requested invalid offset: "
> -		       "NODE: id %u, type %#x, height %u, "
> -		       "node_size %u, offset %u\n",
> -		       node->this, node->type, node->height,
> -		       node->tree->node_size, off);
> -	}
> -
> -	return is_valid;
> -}
> -
> -static inline
> -u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, =
u32 len)
> -{
> -	unsigned int node_size;
> -
> -	if (!is_bnode_offset_valid(node, off))
> -		return 0;
> -
> -	node_size =3D node->tree->node_size;
> -
> -	if ((off + len) > node_size) {
> -		u32 new_len =3D node_size - off;
> -
> -		pr_err("requested length has been corrected: "
> -		       "NODE: id %u, type %#x, height %u, "
> -		       "node_size %u, offset %u, "
> -		       "requested_len %u, corrected_len %u\n",
> -		       node->this, node->type, node->height,
> -		       node->tree->node_size, off, len, new_len);
> -
> -		return new_len;
> -	}
> -
> -	return len;
> -}
> -
>  void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
>  {
>  	struct page *page;
> @@ -518,7 +476,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *=
tree, u32 num)
>  	if (node) {
>  		pr_crit("new node %u already hashed?\n", num);
>  		WARN_ON(1);
> -		return node;
> +		return ERR_PTR(-EEXIST);
>  	}
>  	node =3D __hfs_bnode_create(tree, num);
>  	if (!node)
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2eb37a2f64e86..e8bc24c8baf1a 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -304,6 +304,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *t=
ree)
>  	len =3D hfs_brec_lenoff(node, 2, &off16);
>  	off =3D off16;
> =20
> +	if (!is_bnode_offset_valid(node, off)) {
> +		hfs_bnode_put(node);
> +		return ERR_PTR(-EIO);
> +	}
> +	len =3D check_and_correct_requested_length(node, off, len);
> +
>  	off +=3D node->page_offset;
>  	pagep =3D node->page + (off >> PAGE_SHIFT);
>  	data =3D kmap_local_page(*pagep);
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 99be858b24465..6032b14b1639d 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -85,6 +85,48 @@ struct hfs_find_data {
>  };
> =20
> =20
> +static inline
> +bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
> +{
> +	bool is_valid =3D off < node->tree->node_size;
> +
> +	if (!is_valid) {
> +		pr_err("requested invalid offset: "
> +		       "NODE: id %u, type %#x, height %u, "
> +		       "node_size %u, offset %u\n",
> +		       node->this, node->type, node->height,
> +		       node->tree->node_size, off);
> +	}
> +
> +	return is_valid;
> +}
> +
> +static inline
> +u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, =
u32 len)
> +{
> +	unsigned int node_size;
> +
> +	if (!is_bnode_offset_valid(node, off))
> +		return 0;
> +
> +	node_size =3D node->tree->node_size;
> +
> +	if ((off + len) > node_size) {
> +		u32 new_len =3D node_size - off;
> +
> +		pr_err("requested length has been corrected: "
> +		       "NODE: id %u, type %#x, height %u, "
> +		       "node_size %u, offset %u, "
> +		       "requested_len %u, corrected_len %u\n",
> +		       node->this, node->type, node->height,
> +		       node->tree->node_size, off, len, new_len);
> +
> +		return new_len;
> +	}
> +
> +	return len;
> +}
> +
>  /* btree.c */
>  extern struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
>  					btree_keycmp keycmp);

This modification makes sense but I mean the porting of slightly different
functionality. Are you working on it? Or have you missed my point?

Thanks,
Slava.

