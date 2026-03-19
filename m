Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E5AD5A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889313; cv=none; b=msxNxKlMz33BaF0nRsdz4RYPPS2LvMrS+Hrmpp7qsq18yy3mufuwgw8FQJEJtRqfvDf4cNN/cOBMJtZIATesTAFOpct7p59pFYyleatW9AXqx1k4RbxM11OfoVd1ML4EkILBCprEXNGsUublTIDK9vrQEjwfpGUW0g2ysTJ6inc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889313; c=relaxed/simple;
	bh=DWABQddafcuyx3yVN6mPVh+rWscmHAOztB+7tZjuLEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mk93ZfmqpX+TUvYf9uMYIvmLfp6fKKpcIOc/4ws6GWwi7y//sXJu+vQYNPGNH3CaVP6OYtJgOynSC+nLZjvUVggc+/dY3o/lFp4VOcwSTTCesMoEwDiPA6+eRySaVxvZv+r2S+0cmv72NpiFFoAchl6uBBbwPgcbyALNQpP3dQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=puLhN6N6; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="puLhN6N6"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ae222d978so686690d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 20:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773889310; x=1774494110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWssSlGpjUbtR3nCC90Y4Zeb3yvE4Z3WnrHRDivP/3g=;
        b=puLhN6N6st/Vdzhv/nbNu8jjbHGvzYn2PcUJ3mLg642QXjRIrqyzD0EyTJLPambVoM
         BrQcRYoqT5lo1Ox4XoPvSwHRuGA/O+SuJOfG1We9G7KXRl9FOg4xA1ePmwvdEpARp4qr
         r2OaL+Gd4lmBUVloJb0twalQAmPFim3ffPVJbdFy3c9P51H5+68lujI1TIwOFjEEvS/v
         hg7rqyI4rGbBh79t5AKWSkHRml5eUhm2wrW2VfXiJ6BT4ieVLD3X28A6lQp2VAHYlAFY
         uhYwMrArVSjIQBogd4yH4LBZnKGqn+sMFFQl0wuS5VXMASH3Ogw51RNjAT4iu3uVIWgU
         MAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773889310; x=1774494110;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWssSlGpjUbtR3nCC90Y4Zeb3yvE4Z3WnrHRDivP/3g=;
        b=ZjUDyu+boljgtrjQVl6OPmfKG/pMchurxpddTrKSi+wJW29I5rdkwo/8gqYEAMZrgN
         dqOFPXi3SbwjGVAheuVq3Yr37mtAJO8CRfLMDERu5BSeLcjSXdercXABZNIDh795llIh
         b6sspVutRojy/8pSg7h+nTbLZZUXCjX+oaXaUYN0d4TihO8H6AKtFEx6KDh/GgruGKry
         +r79t7YI8DdJkbqAoMDymKQWc4xaGMKk8soQrLmyhHl4+cRoZVROKV5R2foo/dYarl8m
         K/t99PIxScj7Bg7R/+jaIPPi2GajgDv/b++8wLq35sslT0Z15P9j+t0sWEaIeE9WKD2g
         FbFw==
X-Forwarded-Encrypted: i=1; AJvYcCWa142XCEeGoccMBjgwe8wf5Ax3itk3whYFPyMYhQX1nQo8RsY/BCF3cFWfCFd1cy7g238b3o+pv4zJ8Ea7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mL7FwDiztgvfDU7SIFtQG9VQXmTWRsdDkF0wrKXCnS1j6rlJ
	kk9SRdoZAcn09QsJus0X2ExJQNBdF/oat6z/y4rCotmPGqPkrQODq/OF4w/KNfLvGmM=
X-Gm-Gg: ATEYQzwdWgzsmFhiSCCTFgzqk4ep2A3kMvV4KF9yYeriozbXbIATOjFnRy+bvNXIeKo
	2me1wrPfQ7s+vA8hCtXXV2R46R15T5x3J1ALJg/3asbZS90KoXrCX4jMHbPrxFdo0ag2saSPjdo
	VclocZkDnxNVmIPh4QKjlew7K+hGK0bO+hw0daWM3g3km2zG+D63alQjQGk3keCxchCs/an1Kx+
	BbU4NEqsMxSowyRqAppLBkdaLQsaxa2vx7kVKoRSZOIMk1kyZ47uo3D9a9dd3DE8+u7M7XRXqK6
	kHY8fI68VoIre2Y4TAEYjjREhzhkyb+D0uGl8tEDLu5kUxzgovy6DRcRTJePL46D83p1hctvA/n
	TbS8tQeC+oac6l+lE4FkJMsClnpiwItHYF+SBHF0hyjCLqO0cDYXtnzOHf0kOInri4nXG8+R313
	FqHS3y7/bRssl6thf1q/CsV2LGO5UrS/A429G4YTvC6K/58txnt3K/utUHoVeB/tdxaAxQI5y+C
	Ae2bRIWZA+Vv+60oCr3b3nUbS5uit4MaXVife7parp1DZE2o08LKy35IN3XOb+COoNj+1c=
X-Received: by 2002:a53:c7cb:0:b0:64c:c616:c351 with SMTP id 956f58d0204a3-64e915ced3dmr5239397d50.40.1773889310519;
        Wed, 18 Mar 2026 20:01:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:fbb1:1a9c:e8af:d8ed? ([2600:1700:6476:1430:fbb1:1a9c:e8af:d8ed])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91c29074sm2734401d50.20.2026.03.18.20.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:01:50 -0700 (PDT)
Message-ID: <43be87e694ed6fe291990226624559e7f01820d9.camel@dubeyko.com>
Subject: Re: [PATCH v7 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
	syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Date: Wed, 18 Mar 2026 20:01:48 -0700
In-Reply-To: <20260318073823.3933718-3-shardul.b@mpiricsoftware.com>
References: <20260318073823.3933718-1-shardul.b@mpiricsoftware.com>
	 <20260318073823.3933718-3-shardul.b@mpiricsoftware.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-18 at 13:08 +0530, Shardul Bankar wrote:
> Syzkaller reported an issue with corrupted HFS+ images where the b-
> tree
> allocation bitmap indicates that the header node (Node 0) is free.
> Node 0
> must always be allocated as it contains the b-tree header record and
> the
> allocation bitmap itself. Violating this invariant leads to allocator
> corruption, which cascades into kernel panics or undefined behavior
> when
> the filesystem attempts to allocate blocks.
>=20
> Prevent trusting a corrupted allocator state by adding a validation
> check
> during hfs_btree_open(). Introduce the hfs_bmap_test_bit() helper
> (utilizing the newly added map-access API) to safely verify that the
> MSB
> of the first bitmap byte (representing Node 0) is marked as
> allocated.
> The helper returns a boolean, allowing the caller to safely catch
> both
> structural IO errors and illegally cleared bits in a single check.
>=20
> If corruption is detected, print a warning identifying the specific
> corrupted tree and force the filesystem to mount read-only
> (SB_RDONLY).
> This prevents kernel panics from corrupted images while enabling data
> recovery.
>=20
> As a minor cleanup to support the warning logs, replace the verbose
> CNID
> logic with cleaner macro definitions (using official structural names
> like
> "Extents Overflow File") and a dedicated string lookup helper.
>=20
> Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3D1c8ff72d0cd8a50dfeaa
> Link:
> https://lore.kernel.org/all/20260315172005.2066677-1-shardul.b@mpiricsoft=
ware.com/
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
> =C2=A0fs/hfsplus/btree.c | 60
> ++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 60 insertions(+)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 64d168347b4b..04304f952f6b 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -185,6 +185,32 @@ static struct page *hfs_bmap_get_map_page(struct
> hfs_bnode *node, struct hfs_bma
> =C2=A0	return node->page[ctx->page_idx];
> =C2=A0}
> =C2=A0
> +/**
> + * hfs_bmap_test_bit - test a bit in the b-tree map
> + * @node: the b-tree node containing the map record
> + * @node_bit_idx: the relative bit index within the node's map
> record
> + *
> + * Returns true if set, false if clear or on failure.
> + */
> +static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32
> node_bit_idx)
> +{
> +	struct hfs_bmap_ctx ctx;
> +	struct page *page;
> +	u8 *bmap, byte, mask;
> +
> +	page =3D hfs_bmap_get_map_page(node, &ctx, node_bit_idx /
> BITS_PER_BYTE);
> +	if (IS_ERR(page))
> +		return false;
> +
> +	bmap =3D kmap_local_page(page);
> +	byte =3D bmap[ctx.off];
> +	kunmap_local(bmap);
> +
> +	mask =3D 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
> +	return (byte & mask) !=3D 0;
> +}
> +
> +
> =C2=A0/**
> =C2=A0 * hfs_bmap_clear_bit - clear a bit in the b-tree map
> =C2=A0 * @node: the b-tree node containing the map record
> @@ -218,12 +244,32 @@ static int hfs_bmap_clear_bit(struct hfs_bnode
> *node, u32 node_bit_idx)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +#define HFS_EXTENT_TREE_NAME=C2=A0 "Extents Overflow File"
> +#define HFS_CATALOG_TREE_NAME "Catalog File"
> +#define HFS_ATTR_TREE_NAME=C2=A0=C2=A0=C2=A0 "Attributes File"
> +#define HFS_UNKNOWN_TREE_NAME "Unknown B-tree"
> +
> +static const char *hfs_btree_name(u32 cnid)
> +{
> +	switch (cnid) {
> +	case HFSPLUS_EXT_CNID:
> +		return HFS_EXTENT_TREE_NAME;
> +	case HFSPLUS_CAT_CNID:
> +		return HFS_CATALOG_TREE_NAME;
> +	case HFSPLUS_ATTR_CNID:
> +		return HFS_ATTR_TREE_NAME;
> +	default:
> +		return HFS_UNKNOWN_TREE_NAME;
> +	}
> +}
> +
> =C2=A0/* Get a reference to a B*Tree and do some initial checks */
> =C2=A0struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
> =C2=A0{
> =C2=A0	struct hfs_btree *tree;
> =C2=A0	struct hfs_btree_header_rec *head;
> =C2=A0	struct address_space *mapping;
> +	struct hfs_bnode *node;
> =C2=A0	struct inode *inode;
> =C2=A0	struct page *page;
> =C2=A0	unsigned int size;
> @@ -331,6 +377,20 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0
> =C2=A0	kunmap_local(head);
> =C2=A0	put_page(page);
> +
> +	node =3D hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
> +	if (IS_ERR(node))
> +		goto free_inode;
> +
> +	if (!hfs_bmap_test_bit(node, 0)) {
> +		pr_warn("(%s): %s (cnid 0x%x) map record invalid or
> bitmap corruption detected, forcing read-only.\n",
> +				sb->s_id, hfs_btree_name(id), id);
> +		pr_warn("Run fsck.hfsplus to repair.\n");
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
> +
> +	hfs_bnode_put(node);
> +
> =C2=A0	return tree;
> =C2=A0
> =C2=A0 fail_page:

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

The xfstests run hasn't revealed any new issues.

Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
