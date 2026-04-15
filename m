Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144B344DA9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292386; cv=none; b=XNhTG0ElDTreaeILV3qm0NbL5ATJHJb0PJFCAKfq6uU4M6isY+iUVv/HAdoxlTs8zzUrklN95O5paPSV2Xm6jJ3G05xVAuVs4lM5nxSEkYOqVeIUrJ0iywksisJK29carRBsEMYEFrt5c0JH+88edh3yzNeUqdYQ9aEU4qNQJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292386; c=relaxed/simple;
	bh=DALBnQ5Lrt/efp4QYH2fALAGKKab6IcD8A7+exrGrnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBqit+ZNe+O+PyW4IEzl7oWOeDQdLOmFC2yBH+wqgZIgZGKYA364GIYl2384EqsbMsPEizfVdJt3G0n2a7pEbff6InbmTqknk9rqDXfISf+FOgMthM1RdRtrebADS4LMyWckhr9Buu+KXFgBnfIxtrJuFJAKg6SfXw9Ic9L3osU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=St94VINb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMcIUQv1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St94VINb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMcIUQv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776292383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rC25XL9+9ngPq2KdiSvSacKjuB6dsLNIk5mkxjAJQs=;
	b=St94VINbekONxzYhBf6ED2J7w+XvlAgUagj/TcX//13ql12Y5BfpMPv95FluXRkiuhSsi+
	jyjgdpVn3657NE1oc+LD2AJ5ot/GFatsbri+MOrVL48xcO5gEEPszfAFGvkW0GyKnWWiFS
	t6E9v+voSMdZNMQ0+7+yDRzzXgIgPqw=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-NNPmZOGfMyWO0Ra8CBrk7g-1; Wed, 15 Apr 2026 18:33:02 -0400
X-MC-Unique: NNPmZOGfMyWO0Ra8CBrk7g-1
X-Mimecast-MFC-AGG-ID: NNPmZOGfMyWO0Ra8CBrk7g_1776292382
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-64eb0bff77cso2966514d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776292382; x=1776897182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9rC25XL9+9ngPq2KdiSvSacKjuB6dsLNIk5mkxjAJQs=;
        b=YMcIUQv1yQ1LMIHlHljkw/2sxXJOUUHNVwNy+y/4+pGfTYGgeBCVmiR9qP6JYjU9ED
         wlVz9HzzcvpvFShb7yQNT7BWGyXvBZWRtkr9KghP8udQJs3MCq8lAGnWJNlhajotDydw
         qYTePEJsxrungTpFulXfVpeRKAuCyr+pMxJLOLAuM3WCflqW+mEVlFUrExu4ZZInlFx2
         0sABPve4iJnEU6CvHoYx8081edNI3fwacuYbbuQbkY0PcnmJCCH2oNakFdHQ9oT8rm79
         AUPxC2YQFqqpgd+y3zkRPrVl6th+CzY5W3a9roQ4qI911Ide1meWQT9Hebsh464U5/m6
         qbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292382; x=1776897182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rC25XL9+9ngPq2KdiSvSacKjuB6dsLNIk5mkxjAJQs=;
        b=T5tXWuzeoRMvDegt2305U71elkyAATGtnXSqSOqMyqYAmoI9rFqm0FGfLHIbou09wB
         7K2CNIkdhgzd9MfXuRsfBh6GSesZeiebABejxdYfVgr+CDfx5tqORrSP5U5Yhr5jNFo6
         smfSROto5qq0t5JCEKmfaK+pO9c3XFN4PqH3kTG2oSxt87dqpt2HElcCCbIMqgMzQEFM
         924OeGuCkoFrC1lBwzCdtLHyRAWLBCVg+y8f9ZJHeI+GGH/GBCAkb8Wl7jE5vK6yx8Bp
         KTVsrv9dEHPnxwaKFddcL/1P6RmV3DWojM8J4D0l3t7U9FyzsnyNFyZVeTu9F5qUuRlq
         v73w==
X-Forwarded-Encrypted: i=1; AFNElJ+wQFk61bHHXRWuHT09oUA9Eg6qpcvtlMkIMMowkpJyFHvaRNhQX3esAkQFrJgqgIsduksBT2Qq5grCu6Q+@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhV7wS0CKtBsxpUYRXHAxgQYqAlB8G2SvbyuREanyVG3wUFGU
	bCUgz7dOIlCgmRRj/PZL/eeNUTtkRjzO2HpP1hkGmz4//GseeMAF1CKLCtPwlAUOpGv4sw1Tb4X
	z+HocGWIJDP/J6sK2c2pUzpT4ojf6Vb73U/uy0f9D/5yyfPDU6YGVjhCOhsP5hu7TCz9fLjHYat
	I=
X-Gm-Gg: AeBDietMfBgFF5gBSs/BVjlxGg/CIMVABo4Q0tkDLn8ozzUBSDUSbmh0ic4vQ1Ql3e3
	5DYzCrCjd8NcYQgC6RnMt0Td5Js3XU2icBkczxunSpEjnlA0y3so4kUCm8rl+teAI2HQ1VF78mD
	jX0ATU+zCKyWTHPcKr5gSnw6cL+SEryODltS3ZdCAg1H77YeEi/v1m95TOoHXkTikCKOHCVr8XD
	trE9gT7b1PInvYyri6WbS4vht7cB87GTmz50JDq2VEW1DFaoHR1GbAqK/lLEjSlt1eHn8Vq7Yvg
	auYPkSmepWd0L4rylBogWTAanSxbB8AtDUSup/Q18jHPkX+JWIm5c57NqOlPQuw3dArDbe8aiTU
	JIGihGSsdaMa8HQ4dHIxOoLewExKcHO0+BVDX7h3onM20G/5IgjjjvT7OXZ5PaB0=
X-Received: by 2002:a05:690e:dcd:b0:650:3064:4cee with SMTP id 956f58d0204a3-65198ab6de9mr24373102d50.29.1776292381740;
        Wed, 15 Apr 2026 15:33:01 -0700 (PDT)
X-Received: by 2002:a05:690e:dcd:b0:650:3064:4cee with SMTP id 956f58d0204a3-65198ab6de9mr24373093d50.29.1776292381342;
        Wed, 15 Apr 2026 15:33:01 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-652e44c08b2sm1360048d50.4.2026.04.15.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:33:00 -0700 (PDT)
Message-ID: <646f4e41c5b0ae14fa755f75fbe83837308ee35f.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: Add a sanity check for catalog btree node size
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 slava@dubeyko.com, 	syzkaller-bugs@googlegroups.com
Date: Wed, 15 Apr 2026 15:32:59 -0700
In-Reply-To: <tencent_1E9E3B1B234BA11B762595BA40BBFE33C608@qq.com>
References: <69decbd0.a00a0220.468cb.006b.GAE@google.com>
	 <tencent_1E9E3B1B234BA11B762595BA40BBFE33C608@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 16:29 +0800, Edward Adam Davis wrote:
> Syzbot reported a uninit-value bug in [1], during the file system mountin=
g
> process, specifically while loading the catalog, a corrupted node_size
> value of 1 caused the rec_off argument passed to hfs_bnode_read_u16()
> (within hfs_bnode_find()) to be excessively large. Consequently, the
> function failed to return a valid value to initialize the off variable,
> triggering the bug [1].
>=20
> To prevent similar issues, a check for the catalog btree node size has
> been added within the hfsplus_btree_open() function.
>=20
> [1]
> BUG: KMSAN: uninit-value in hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/b=
node.c:584
>  hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/bnode.c:584
>  hfsplus_btree_open+0x169a/0x1e40 fs/hfsplus/btree.c:382
>  hfsplus_fill_super+0x111f/0x2770 fs/hfsplus/super.c:553
>  get_tree_bdev_flags+0x6e6/0x920 fs/super.c:1694
>  get_tree_bdev+0x38/0x50 fs/super.c:1717
>  hfsplus_get_tree+0x35/0x40 fs/hfsplus/super.c:709
>  vfs_get_tree+0xb3/0x5d0 fs/super.c:1754
>  fc_mount fs/namespace.c:1193 [inline]
>=20
> Fixes: 8ad2c6a36ac4 ("hfsplus: validate b-tree node 0 bitmap at mount tim=
e")
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/hfsplus/btree.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 761c74ccd653..61050ffe425e 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -337,6 +337,11 @@ struct hfs_btree *hfs_btree_open(struct super_block =
*sb, u32 id)
>  			pr_err("invalid catalog btree flag\n");
>  			goto fail_page;
>  		}
> +		if (tree->node_size < 2) {

Every node starts from BTree node descriptor: struct hfs_bnode_desc. So, th=
e
size of node cannot be lesser than that. However, technical specification
declares that: "The node size (which is expressed in bytes) must be power o=
f
two, from 512 through 32,768, inclusive.". So, we can add more smart check =
here.

And, maybe, it makes sense to check the node size value at the places of us=
ing
it. What do you think?

But we have this check of node_size in hfs_btree_open() [1]:

	size =3D tree->node_size;
	if (!is_power_of_2(size))
		goto fail_page;

If node size is 1, for example, then this check should fail to execute the
hfs_btree_open(). How, finally, do we have node_size =3D=3D 1 during the
hfs_bnode_find()? I don't quite follow.

Thanks,
Slava.

> +			pr_err("invalid catalog btree node size %u\n",
> +				tree->node_size);
> +			goto fail_page;
> +		}
> =20
>  		if (test_bit(HFSPLUS_SB_HFSX, &HFSPLUS_SB(sb)->flags) &&
>  		    (head->key_type =3D=3D HFSPLUS_KEY_BINARY))

[1] https://elixir.bootlin.com/linux/v7.0/source/fs/hfsplus/btree.c#L232

