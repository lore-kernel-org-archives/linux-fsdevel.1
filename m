Received: from mail-yx2-f37.google.com (mail-yx2-f37.google.com [74.125.224.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B148FF9D
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885041; cv=none; b=SecozGAEt13KsjsoKE/YKQz6aheDHeLJMYMZycxm4Pt/5UNNgzbm6nPd2mfMCfR/Eg4CGkC42cI2tPo9UHUxaLCPcAvie1Ab5p21zInm/Tn6j/ve0jbY8QOFwZfTeZ/tUztTNTm9E9VpXH0G7Rfz2la+o7fABK99ox/M1RJ5tA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885041; c=relaxed/simple;
	bh=L4IBqRb7rWfyeha61nF/ywnfHXLuWOGWg/M/Lv93Pjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZ4ULZQyIhHUIEldIDMuFqlX0WqckYyn6K+fz5hmaPuxtcXYxmVw3HZcSj3l/E8sgUC7wxUz9c5NnAfgmyLw7mY+J7lSJ2JppBnTQ0zaOHgLA0IWoaWXFfwfbLSCjkAE9bre9rpIKuqkAu+IyaNfozxObCdSAfK3agM2KaT6Vn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Dqf06vIx; arc=none smtp.client-ip=74.125.224.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Dqf06vIx"
Received: by mail-yx2-f37.google.com with SMTP id 00721157ae682-8ae10c1532eso5135607b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790885038; x=1791489838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kUFVPXrgS7Dm5sD7v5pUT8KcRW+4dKBrE+aP8P0+5YA=;
        b=Dqf06vIxY4ujU0cgihCTEZejJpTE23XAcW68G2BOzskhn0BD4vkspqkIPFPNiLvEnp
         YO4ykNhrAWmFwVuCPzAOLNqmNJvnFWtMS9x2El09kg7qbelUQ6p84vr2heSJOH6lsU1R
         DR8PQ0Xi7JYKlOom0n/9RzzoQ28e8QeMAAdexpz8gmy+aBQOkH9w8fdWWD2/7edykfK0
         hF0/QYeKY85Wk7HZ0fOMjI8/trrkxCtksyy1KXFYVxPzl3CdrmONrqsNMJVLF7+Ljcbl
         IOwhqY6FoXjht1Bs1FL7zjtyfxW0O0wU9fgKXmPB5Eimxt59UZu0efiJbtFBl5z7N7HQ
         Jq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790885038; x=1791489838;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kUFVPXrgS7Dm5sD7v5pUT8KcRW+4dKBrE+aP8P0+5YA=;
        b=veAGMZ7gTTpmO2Y+fB370HE32QsS0fLsDZunqLFWCTNOZhlIL7hcAEmVabg/O/CNEa
         Oe38wmSh2grcXXG9MkIwsC/BOCxuGGPS9F0a1j3+SOuONbylEHRwY2XxDyD0hSB1782C
         qT8K3/DMS7mFcmRh1tbD2TrmP7kk7TWBREw6cDm91V6r81nvM2H3wWXFzOSMJRx0WDJM
         ekEWlDJ9B9xDpLqnacCxv0bNJ1Owpjg2BxclUOJSepA3kNwNzgeYhp1ePEcG24u4lkIa
         zC1gxATqnHvsuzcPHI/mLkTriqd3Af7fuMXAEFnvLLMUFnyUEGwjoMzxE92NiA29JQQL
         89sA==
X-Forwarded-Encrypted: i=1; AKwUvBy+j3ZCQ+Lb/Ra0pPR4u+9HA0xAPiK8RbJ5s/Af/hJWro0YDeAsSOXCS0XYCdSYn8cnD9ANAcvtBpzKYtgD@vger.kernel.org
X-Gm-Message-State: AFq9FYLCgvdL+y/39T47taSukytq9PHJml8BrVovlDOeuRD1q8SMwjqZ
	yhmC03O42TuIZGhhXsc6KohqmNWoPzRiDTjTiZUoLv0yIsiUTR+XFg6FPs3rkaKT5TA=
X-Gm-Gg: AYBFou1RSgNeRLSbcfWJk021a7mMlzVuTtZKT0HW/KhhhOfaOk5/lcbAp4Sfdqur3n/
	80gn8Bxd+KRk8okk8XvuoyQXDMFgzU65+bzezMgZhp/7TGM3RMLM4ZH9T0dPdafKn1io4x06c6N
	ZRlkX+YQ0Z/szMQ/lDr0saWl+2zKOC0Zrg7xicA19/45+PQ4Vzj6KqPO499yXrp9Q6sCBRLaYP5
	C2NwdZEzLcalL8ssrUnw+HSqWv2ulORXsrT9Q7JxJNch7d+BZDkWEm6hVyDMnCZdpsVq8W0sNcb
	0XGVwDXo50i2x7M70t711i64hugVTSc59fCFLVmbVEvPVvPtGE8rey5etBwm/hNDWl8xoY5FAxH
	1PQS69s5HIC69VEuGJRF+76ZhZhGMJG8Dz7w58aTqmVqArk4T/XJGRyZBOUEC+jO/GxuqCGF55i
	r1MgafAlPXreA1VVL7GXxohpHnafj0v+G5EDZOxazc4XtViPntgbR2gBzipamU7vtF1GhEttyb4
	qwTjcdu9bcr6J2nl5k0aw9a7pL0DBQea2Jl13WJnFHcZswrV4CtRfpYaOEwXH7WeXtADbyFPi7E
	S8u44CsNaB84CQ+0BUi6wERW14zY0YdmzDtiUPpUuB/nYRYMbnoPPT2lSRz4I42k
X-Received: by 2002:a53:ec8f:0:b0:674:2df2:ef6c with SMTP id 956f58d0204a3-677ac03eab2mr176844d50.18.1790885038359;
        Thu, 01 Oct 2026 13:03:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:67c2:3447:e08d:9418? ([2600:1700:6476:1430:67c2:3447:e08d:9418])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677ac5ac1fdsm99545d50.13.2026.10.01.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:03:56 -0700 (PDT)
Message-ID: <d71d72862f33fd3f10c1808121eae2654250817d.camel@dubeyko.com>
Subject: Re: [PATCH v2 2/2] hfs: free cached B-tree nodes on
 hfs_btree_open() error path
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Mahmut Emin Kurhan <guvenlik@noroxi.com>, linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 13:03:52 -0700
In-Reply-To: <20260930232312.1405042-3-guvenlik@noroxi.com>
References: <ea8cfa5978a90d27e498fae626edfdae5bf84af7.camel@dubeyko.com>
	 <20260930232312.1405042-1-guvenlik@noroxi.com>
	 <20260930232312.1405042-3-guvenlik@noroxi.com>
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

On Thu, 2026-10-01 at 01:23 +0200, Mahmut Emin Kurhan wrote:
> The classic HFS driver has the same B-tree node leak as hfsplus: on
> the
> hfs_btree_open() error path after hfs_bnode_find(tree,
> HFS_TREE_HEAD), an
> errored head node left in tree->node_hash is not freed because
> free_tree:
> does a bare kfree(tree) instead of walking the hash.
>=20
> Apply the same fix: factor the node-hash freeing into
> hfs_bnode_hash_free()
> and call it from hfs_btree_close() and the hfs_btree_open() error
> path.
>=20
> Found via coverage-guided fuzzing (syzkaller + kmemleak) by Noroxi.
>=20
> Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
> ---
> =C2=A0fs/hfs/btree.c | 34 ++++++++++++++++++++--------------
> =C2=A01 file changed, 20 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 41b4e8fc9..51d1e19a4 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -131,6 +131,24 @@ static int hfs_bmap_clear_bit(struct hfs_bnode
> *node, u32 node_bit_idx)
> =C2=A0}
> =C2=A0
> =C2=A0/* Get a reference to a B*Tree and do some initial checks */
> +static void hfs_bnode_hash_free(struct hfs_btree *tree)
> +{
> +	struct hfs_bnode *node;
> +	int i;
> +
> +	for (i =3D 0; i < NODE_HASH_SIZE; i++) {
> +		while ((node =3D tree->node_hash[i])) {
> +			tree->node_hash[i] =3D node->next_hash;
> +			if (atomic_read(&node->refcnt))
> +				pr_err("node %d:%d still has %d
> user(s)!\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->cnid, node->this,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&node->refcnt));
> +			hfs_bnode_free(node);
> +			tree->node_hash_cnt--;
> +		}
> +	}
> +}
> +
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
> btree_keycmp keycmp)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> @@ -296,6 +314,7 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	tree->inode->i_mapping->a_ops =3D &hfs_aops;
> =C2=A0	iput(tree->inode);
> =C2=A0free_tree:
> +	hfs_bnode_hash_free(tree);
> =C2=A0	kfree(tree);
> =C2=A0	return NULL;
> =C2=A0}
> @@ -303,23 +322,10 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
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
> -		while ((node =3D tree->node_hash[i])) {
> -			tree->node_hash[i] =3D node->next_hash;
> -			if (atomic_read(&node->refcnt))
> -				pr_err("node %d:%d still has %d
> user(s)!\n",
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->cnid, node->this,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&node->refcnt));
> -			hfs_bnode_free(node);
> -			tree->node_hash_cnt--;
> -		}
> -	}
> +	hfs_bnode_hash_free(tree);
> =C2=A0	iput(tree->inode);
> =C2=A0	kfree(tree);
> =C2=A0}

Ditto. Now your patch conflicts with [1]. Please, base your patch on
for-next branch of HFS/HFS+ git tree [2].

Thanks,
Slava.

[1]
https://lore.kernel.org/r/20260921153729.600313-1-bruno.produit@trailofbits=
.com
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git/log/?h=3Df=
or-next
