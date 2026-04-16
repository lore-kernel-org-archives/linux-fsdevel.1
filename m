Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95336C5AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776383578; cv=none; b=ePr33tLoZL3EvqpNXfdNMVIC2YO/SNgRtYPUi1xwi8iu4G1DvS3HQW9DVmL23qx2ZOxHlHYcrVfStF1EZKGDj6amUExk5H0BvPvm1uy++IcBh64IFOEmhQyDhi6MFGygd3URD/ityCeLAOT3l7uPCPlCs1l3HvwdRrzZh6fW2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776383578; c=relaxed/simple;
	bh=ViI0JNalIqErtgMgi5n5c14HaDrw0KS9ExyHzdMK2yE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocOuDYI3/tjZtbETKomFiv0TWla3oCebdaD4wY+Eh9ogoMKlZCVQ8pEEhBLKbG9nf/1UJVJ1j+Q7fFs+o7H2shh/o9pnU2D9UJn8EL4NqJvlk9QhCai2HF4iOtDNyr+ENEZFjdDiAeFUhUfDK6wZcmQswxhGmiaIaBagPT55fEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqjNp8YU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=svrE1ZQG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqjNp8YU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="svrE1ZQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776383575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlPn1ESBATCi14PPD7HWrz3LwYzcFB1bpvU3Z+LX7Zw=;
	b=gqjNp8YU3nOXBHV9tFhGTI9oXcbgAIQJOTL1v/ZnCbto3l4jdjl47OWMc2KY/s96YxUy0u
	SB48CBfMfVzyF8e9Nu9VbsCE2xuVU1Nrjm8DoVJnMLEI4mdAIaDpG7zyDDpxdmsmMvK1pS
	pt06nbOX0XNiYWrWG8vYM9+nYPncR3A=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-xQ2owhwXPW264VGfFGfiqQ-1; Thu, 16 Apr 2026 19:52:54 -0400
X-MC-Unique: xQ2owhwXPW264VGfFGfiqQ-1
X-Mimecast-MFC-AGG-ID: xQ2owhwXPW264VGfFGfiqQ_1776383574
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-649deeeb00fso326338d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776383574; x=1776988374; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NlPn1ESBATCi14PPD7HWrz3LwYzcFB1bpvU3Z+LX7Zw=;
        b=svrE1ZQGljGzwPJV/33UwiDgTRkzyvQcrVom8zmKknWIr1L+Q6VX5W/sbahveFrQRt
         uXcuQ0/gaZ+x6tEBcX5SkYiRJeUnMvKTWzdJuTM0YR4PO2y3LNa+vlypwfxuA/honxtJ
         RWKfUxIEiQD8+W34sY0CvCftbXqTUPK84mYYdagX4V8w6Oi2WtDnUUSI7NzlgVQlDDnq
         q19ovhAQzAWTKSc+uicSOcvSed/nf1cqxKt1B3S7gAfDqEKJYmpYexeq2tX0j+pPXhvK
         xB0fa4mB7XD4k5lS7u0KxJl00sBNVNLAST2vxMHAq5y//Hyr5lRmvbxN+I8cceD8ohwi
         zOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776383574; x=1776988374;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlPn1ESBATCi14PPD7HWrz3LwYzcFB1bpvU3Z+LX7Zw=;
        b=ieVZ8k+BKFCvH81+2wymbc65TqjRube6nQslIail//n8AVD9epktmuHdMA/T7JLIks
         Md1UOQmmww1ZXTqV9I3ZEgoQFRkOL4mQG8JnoXA0f+1Tpk2ZbOvB+RDxN/X1JXo6DjXV
         GDNr2P1qmZze7UEejmgLBIym1pJDHCAl8itRaa9PE5WV4ugiNblYjmEh4jne7DAdoqPr
         c5VWnkhnl0nfbvWlc8n7Bg4F575EZ8iDbpHS4ydvu3sgbTlvFQNfKqWNoTeBldhd5h8A
         D2xR9zHwTKVPbMkojteHk2QJLQwn8KdR3m2I/dcrmtZvxfm9MN1dzQggi/sqHPdjsuA4
         TZog==
X-Forwarded-Encrypted: i=1; AFNElJ98a9Wg9ERVf0J2KDx8RJ8kRp8J8W6+HZgI/WA+qCWzYHEqCT5D+2g2sn1xQ+K8e4BXmTJLGXPZBJdZ1gZH@vger.kernel.org
X-Gm-Message-State: AOJu0YzFz9jTZuolcAmkhFgOTw5pQky3zjnDb9S2p7ukfVX/1/vdd+8X
	UFk9dX0PNOBe30ZjbtIl6mzR8Tabw0n7o79nycx3XmigsHBbhnlTu+QiTcp6jQujZLk9Hy3w88e
	SryjtkbamjNwfSu/CIsOjGjRJdNAXD4+vK2g+nutzOENcJcnQq8ulp52Im71T3FQPIeI=
X-Gm-Gg: AeBDieuCC7lpbYzAIobIOGdrpts/rJFkuUSZD0lHFhVu9yQzd8+x3XwpzU0wVd2/GRx
	jFxFegFk/nlYo0IZ3B2TwM+Z+UTsqsKDhIJEXBynNH2vJfu2GDJTryv3Oui7B7gurWTg6LVUBZe
	cyL7F8t59DIDwDakHkPv0wF6ehhwYfQX+jEiuw8dH20eh51EKnKyPtoACP8nGGaLPUKDu3SbYR/
	6xfDS2elV0iqT2dgcN0Y4PaNBzJBcI2D+AZgaImv1CrBtD7pEgB5CvNdfknBj0AV88U+SY5G/6u
	rNOJJ9YBOVgkBWyytVlo1QjKUKEf+CpzPC8v47mpviDgBHYECbZcuQrco8vwMHTMBUumM4rpKx5
	XpE1fEtRKwgl6IZfLgTdMpZdebkVsPsN4nrxcEK6zBNRbxzVcbKcoWmRxS1ZI2Ls=
X-Received: by 2002:a53:acd3:0:10b0:651:c71d:8a72 with SMTP id 956f58d0204a3-65310a696a8mr569801d50.49.1776383573965;
        Thu, 16 Apr 2026 16:52:53 -0700 (PDT)
X-Received: by 2002:a53:acd3:0:10b0:651:c71d:8a72 with SMTP id 956f58d0204a3-65310a696a8mr569786d50.49.1776383573567;
        Thu, 16 Apr 2026 16:52:53 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65312ffe990sm81508d50.2.2026.04.16.16.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:52:53 -0700 (PDT)
Message-ID: <2fc9bc501da67eccf45533310812d7591a12d7b7.camel@redhat.com>
Subject: Re: [PATCH v3] hfsplus: Add a sanity check for btree node size
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 slava@dubeyko.com, 	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Thu, 16 Apr 2026 16:52:51 -0700
In-Reply-To: <tencent_5ED373437A697F83A4A446B771577626CD05@qq.com>
References: <tencent_B176296323B84453B767B76D66D513600305@qq.com>
	 <tencent_5ED373437A697F83A4A446B771577626CD05@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-17 at 07:44 +0800, Edward Adam Davis wrote:
> Syzbot reported an uninit-value bug in [1] with a corrupted HFS+ image,
> during the file system mounting process, specifically while loading the
> catalog, a corrupted node_size value of 1 caused the rec_off argument
> passed to hfs_bnode_read_u16() (within hfs_bnode_find()) to be excessivel=
y
> large. Consequently, the function failed to return a valid value to
> initialize the off variable, triggering the bug [1].
>=20
> Every node starts from BTree node descriptor: struct hfs_bnode_desc.
> So, the size of node cannot be lesser than that. However, technical
> specification declares that: "The node size (which is expressed in bytes)
> must be power of two, from 512 through 32,768, inclusive." Add a check
> for btree node size base on technical specification.
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
> v1 -> v2: change check base on technical specification
> v2 -> v3: using const min size
>=20
>  fs/hfsplus/btree.c         | 2 ++
>  include/linux/hfs_common.h | 1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 761c74ccd653..394542a47e60 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -365,6 +365,8 @@ struct hfs_btree *hfs_btree_open(struct super_block *=
sb, u32 id)
>  	}
> =20
>  	size =3D tree->node_size;
> +	if (size < HFSPLUS_NODE_MINSZ || size > HFSPLUS_NODE_MXSZ)
> +		goto fail_page;
>  	if (!is_power_of_2(size))
>  		goto fail_page;
>  	if (!tree->node_count)
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> index 07dfc39630ab..45fb4c9ff9f5 100644
> --- a/include/linux/hfs_common.h
> +++ b/include/linux/hfs_common.h
> @@ -513,6 +513,7 @@ struct hfs_btree_header_rec {
>  /* HFS+ BTree misc info */
>  #define HFSPLUS_TREE_HEAD			0
>  #define HFSPLUS_NODE_MXSZ			32768
> +#define HFSPLUS_NODE_MINSZ			512
>  #define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
>  #define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
>  #define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Hea=
der node */

Looks good. Thanks a lot for the fix.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

