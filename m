Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101130AAD8
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227805; cv=none; b=CCA4Co+yRBiP7DKG+VPDcrdfyXNyApdsL4ZeIXog0DuvJnmL5BTwaxTM5KVBme0KE6PHI5Kq/sapZ+zc2DZ9x+agkkH47dS8NbQkDs0ou9F1rgHR4BgQ/3zQF23WaSA0l2vWoOFLsAHo7GqLhkVSSaAmh9O6kP4M3+VZHsEzUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227805; c=relaxed/simple;
	bh=ulQA5cvJgKQcqUv21AfRSI+EJFD+UJHNlzoqx4tqBmU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nSizwGndYpu0BWbMAedPS3SgkCIMgzUoVSji5M7QPNkFwAHw2As9h7zjKZws5hvkAlGc8sn1RJDKljmrXcO6G3gsVfcULYmbXomMCwE1PJfaNVDGtzRa+EcfcPZrXwFy5Td6stabPlfyIKd7HzHYtEQr5EobsqME7uwNe/qeZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=GwSVEqYW; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="GwSVEqYW"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-67408b109e3so896542d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791227803; x=1791832603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AD8CeJIlG5hCbH4+fGlxBDHvP5Fa9LzqNq1Ik5KKPnE=;
        b=GwSVEqYWtHHC96q7n4WUPWI9F3MOO5GW3DMhHtagv6MLw8qVPMjkauq5R+GGBZaY86
         Xl4vVyFH5K92wgp/wPw91ZdwWKmr44VU+in5rQrg0MQxWTIVN9t20mdIkpaYSDIhnQWA
         QrMYQAS3MdyHUrLaW18G1G0Rl256DksndlZOnUwpwqRGsBDDnpzFxypdN2D9xmswXrGE
         wiI7H+WkcIhxnMQSWWarBslI4jK0EIT1W4ABcD1cTvq8f697JYwcA4fxq0CddaRgMHXL
         lVfqyUr0CeCsAfqq6GBzCN166EUFMxvpeAFMEDE44ecVfF7T2LAY2efctkjvM4UwDU40
         tCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227803; x=1791832603;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AD8CeJIlG5hCbH4+fGlxBDHvP5Fa9LzqNq1Ik5KKPnE=;
        b=0s81/vV3bZW33/UhnggqU2VeFTcObs/dCvL7xwbQaQHg/8FqDPyfACASdbj8ZKW+Rn
         hvunWrSgHfNgKaWiGmBPQjmzDNrS74quy9I38B3FLY2RnuAN2xAj9MFTUEH1MZaSCq13
         Fz1ycd56IUcrIJWM59K92NSzyxcwvFvtZBlvZnSL/czNlkpL7MtVNYWkSV21KTXI42dD
         pauDdQMu7ia54MdzvROYHOcSrIOd3Qp/quntFe1KaodmA/rPmSZ1WbifB/34YBaLBn4O
         OilPcDmcNEzGqDbxpbOkcftusnX188o1OsDhIa6elzIw1P/YxaG8+68FIEh5lplPduzA
         8LGA==
X-Forwarded-Encrypted: i=1; AKwUvBwXzdsgwpG20LtUpwRHlxdA6DoB9qU5D1j15YwAtoyKtsKd3UzXTpqgaiQQkfJuxOLT0r/fxBE+o7WSYdxT@vger.kernel.org
X-Gm-Message-State: AFq9FYK33Ax+MeZBk4FV2SPyPJo7zrR4aa3s/pXFPMxqgqn6A4G9632L
	0y7qyxXykmIRBLBuWCmyxrbsZA2eZlVV/pUrZkrC2rJt4j+NRtGkIqRQAjYiWrOTIUjJK7vv42a
	mbtQ56hY=
X-Gm-Gg: AYBFou1HS2KcxS8N87oj6tVmNuEXNgAk0fP+aIiTCPC2G8H+t9djEpzv/MMwjIrO51P
	S9O6pYkULUWuYeDsLF6a2Xwt6mnDhH9bEh8vPpEAuPxLaPknKNMVlMmlU9SWZBeUAQE9qk/IVCG
	dbVaM6Tvox3HqPrhfwFUCzenbMUm8phMcLcnDqXQkkmEWQLTlgOu0u60elMb6HN20HX68mixx6Q
	w1VCuemyihIAV0R9WbIAGngtSysGL4C5ymIAAvqbSOYgu9sbB7aP2fO3ZijGKLIlMdqyYpfR33h
	aKAL2w7iLkSx7wVZO10GUpdbnUJt6CotiYCbtZhCJRCdBC0sZfvdSWEp79503g82j+0b8eCop3f
	R1xlJ562iHJxXX1oxKLX+2ZBKU/g0B8Fs0jiy96DAspeb07nfTsPXVXXZB0TQzn/EsU5JPBkxix
	9pPzhr76yhi3LyaW/QrPRyUa0dmTocrUjvRgIDRNpYDpHDiu142Xwau6KhvW04pJ6xleEas6MYO
	vXaoehgq67hrzWN0yviRTAazLTX5B3owRwSWJtt5Q5bW1dYd29yh6IXZfROskX9wTmts7iW9F1m
	GMuGz6wHoSdeKPD6SqtZgQT5uQ1a6K8+fd0OFeYcqGGDA7Q+H6Mv4pZAeen+y60s
X-Received: by 2002:a05:690e:4093:b0:675:449d:3d72 with SMTP id 956f58d0204a3-677f15a6050mr281171d50.32.1791227802743;
        Mon, 05 Oct 2026 12:16:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:3aa0:911f:4e09:b45d? ([2600:1700:6476:1430:3aa0:911f:4e09:b45d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b1a214sm3304995d50.6.2026.10.05.12.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:16:40 -0700 (PDT)
Message-ID: <0eb39e561e4c81c0fe2198a2ba352ba81f8d94b7.camel@dubeyko.com>
Subject: Re: [PATCH v3 1/2] hfsplus: free cached B-tree nodes on
 hfs_btree_open() error path
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Mahmut Emin Kurhan <guvenlik@noroxi.com>, linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 12:16:37 -0700
In-Reply-To: <20261001213807.1519745-2-guvenlik@noroxi.com>
References: <0de056179e3e0a7c4ef525cdb143647b7493dc71.camel@dubeyko.com>
	 <20261001213807.1519745-1-guvenlik@noroxi.com>
	 <20261001213807.1519745-2-guvenlik@noroxi.com>
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

On Thu, 2026-10-01 at 23:38 +0200, Mahmut Emin Kurhan wrote:
> hfs_btree_open() can fail after hfs_bnode_find(tree,
> HFSPLUS_TREE_HEAD) has
> already inserted the head node into tree->node_hash.
>=20
> __hfs_bnode_create() inserts the new bnode into tree->node_hash
> before it
> reads the node pages; if a page read fails it sets HFS_BNODE_ERROR
> and
> returns the node still hashed. hfs_bnode_find() then takes its
> node_error
> path and calls hfs_bnode_put(), which only frees a node once its
> refcount
> reaches zero *and* HFS_BNODE_DELETED is set. For the errored head
> node that
> flag is not set, so it stays in tree->node_hash with a zero refcount.
>=20
> hfs_btree_open() then sees IS_ERR(node) and jumps to free_tree:,
> doing a
> bare kfree(tree). Only hfs_btree_close() walks tree->node_hash[] and
> frees
> the cached nodes, so the head node is leaked. Mounting a crafted HFS+
> image
> whose head B-tree node fails to read leaks kernel memory on every
> attempt.
>=20
> Factor the node-hash freeing out of hfs_btree_close() into a small
> helper
> hfs_bnode_hash_free() and call it from both hfs_btree_close() and the
> hfs_btree_open() error path. The helper keeps the hash_lock
> serialization
> added in commit dce0e0248205 ("hfs/hfsplus: serialize B-tree close

I think it is not good idea of mentioning this. This patch is not
upstream yet.

> against
> folio release"); on the open error path the tree has not been
> published yet,
> so the lock is uncontended but harmless.
>=20
> Found via coverage-guided fuzzing (syzkaller + kmemleak) by Noroxi.

Should we use Reported-by: tag?

>=20
> Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
> ---
> =C2=A0fs/hfsplus/btree.c | 41 +++++++++++++++++++++++------------------
> =C2=A01 file changed, 23 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index bd4dbdbc8f..2183828d5d 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -265,6 +265,27 @@ static const char *hfs_btree_name(u32 cnid)
> =C2=A0}
> =C2=A0
> =C2=A0/* Get a reference to a B*Tree and do some initial checks */

Are you sure that it is correct place for the comment?

> +static void hfs_bnode_hash_free(struct hfs_btree *tree)

Maybe, hfs_btree_free_nodes() because function lives in btree.c?

> +{
> +	struct hfs_bnode *node;
> +	int i;
> +
> +	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> +		spin_lock(&tree->hash_lock);
> +		while ((node =3D tree->node_hash[i])) {
> +			hfs_bnode_unhash(node);
> +			spin_unlock(&tree->hash_lock);
> +			if (atomic_read(&node->refcnt))
> +				pr_crit("node %d:%d still has %d
> user(s)!\n",
> +					node->tree->cnid, node-
> >this,
> +					atomic_read(&node->refcnt));
> +			hfs_bnode_free(node);
> +			spin_lock(&tree->hash_lock);
> +		}
> +		spin_unlock(&tree->hash_lock);
> +	}
> +}
> +
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> @@ -403,6 +424,7 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0	tree->inode->i_mapping->a_ops =3D &hfsplus_aops;
> =C2=A0	iput(tree->inode);
> =C2=A0 free_tree:
> +	hfs_bnode_hash_free(tree);

We have inconsistency here. The hfs_btree_close() calls
hfs_bnode_hash_free() and iput() then. Here we have opposite sequence.

Thanks,
Slava.

> =C2=A0	kfree(tree);
> =C2=A0	return NULL;
> =C2=A0}
> @@ -410,27 +432,10 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0/* Release resources used by a btree */
> =C2=A0void hfs_btree_close(struct hfs_btree *tree)
> =C2=A0{
> -	struct hfs_bnode *node;
> -	int i;
> -
> =C2=A0	if (!tree)
> =C2=A0		return;
> =C2=A0
> -	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> -		spin_lock(&tree->hash_lock);
> -		while ((node =3D tree->node_hash[i])) {
> -			hfs_bnode_unhash(node);
> -			spin_unlock(&tree->hash_lock);
> -			if (atomic_read(&node->refcnt))
> -				pr_crit("node %d:%d "
> -						"still has %d
> user(s)!\n",
> -					node->tree->cnid, node-
> >this,
> -					atomic_read(&node->refcnt));
> -			hfs_bnode_free(node);
> -			spin_lock(&tree->hash_lock);
> -		}
> -		spin_unlock(&tree->hash_lock);
> -	}
> +	hfs_bnode_hash_free(tree);
> =C2=A0	iput(tree->inode);
> =C2=A0	kfree(tree);
> =C2=A0}
