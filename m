Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538AE31355F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360275; cv=none; b=NlJgTSVXSANYzFIZ2tNr6xDV5C5ZCDNX8rxE4hFEmja+gkdbCp62Evkaa8CJzc8q7gkqq+N/CYTbYdLh9RXRx5+Jw09oraRsGE3fa3qo6OfRImpfnCDP0+PkiHgXhSfavmmoCoBZXXVOh+fD/YCC6xipdWpoMy/Y09KjUu5kPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360275; c=relaxed/simple;
	bh=MkxhB9pN0thSBk6CTuLnCuljqGMyS5Y4AlroN4IUPvA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=m6TD+qSdxEtV5/WyUnIyyp8J6RTQ5JO04mGKHhQdxf/CAN3+jswG01Yl2U6s4FuqNfVvErHO7vjDN0JmetOF/LXRNuA2qNW4D7XLY16kkouaXpvYx8XmBDsjbXqG/DGVykAFnFw0Yt0YCUc0NSt1yCjilyUZP4NsAn1smwJqCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG2m7RN5; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG2m7RN5"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso235605a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 22:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770360275; x=1770965075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lk9u4ICPZk54rPPfUJcalYjNGp53FK+yZW2KfFesx1I=;
        b=aG2m7RN5wgkYKyyZ8xKT5BSk2pG8dD2bvcF3VEZH2B9pDlVQlYuYRQLPKEQd7MtCnx
         6/1tJZkFe1goO6Zds2biXrW2vfKs/ZyAAldNv0umz/mxLODUtLELALOOePrMusgJbL0y
         7H9qSGdv3oRhVABnuucfO3xVYUw+kXgiD1RknpTalrtJJmaE2sfSXKLkkU6ct2Nd5156
         XA2YiAOt7CNXeugp9AyqzbWyRLQvLNe9G5FSwBCY9Pn5fKccwj4v05DoutbigJa81Vr7
         23HO9Tj9q21KBBLmqK/ssG2phrBu8R7yq0o9WdHQc86cc8N9BmwgfS6Y+HLnjYe0Kdfr
         Un0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770360275; x=1770965075;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk9u4ICPZk54rPPfUJcalYjNGp53FK+yZW2KfFesx1I=;
        b=rFpGHooZNn9ywMH7apNYgp4rTz1sNdwNTKBLFkxr0J9PPjW/XK9TYevtqXUSAu+raY
         TZlh2FXk8sDvLCLyvbZW3uFDHGFd0FXUT5g4O1dttvHVxBDnWHZwQqy3EMzXRFOTzuca
         zNqbivpJtOeazVybT1tCTewFKTMDA+a26BGqS2rl3rWVDvlwa4fypCOzrlRVYgqDrgvR
         T3yRNMn71qs2hpG0ys7Ju3HMFWzgzEALVHYEX3NeGP6Vb6B0HEfnsBsLAaL10MNIuqDG
         0n1GtukUUErhSKDSVSVUaYwLaYtdAot8YhNj4ZX3vf2mGGnunoQeOCBNpXTiw9bNrOl4
         Q2yg==
X-Gm-Message-State: AOJu0YwLgjx/hOsNKR9LKFf4QJuWPmSzVUOjcLquRi+tWevi0pGPkt47
	iGAHZNhGN7vLY1eqJlqIrBW6aYGJBF8ZvwyVlKgrnvGk7KgpWOB06MGw
X-Gm-Gg: AZuq6aKGwtGp73IzS83cnY6u8nOUR8jk3MY2qAz8NtkSPWPr4fYyOyj6WVW06GC5IJO
	p87A9P4yCK4smE6DIrNxA0etZ/QJg2Gk3tBVh7zuvjgxyexhZzWpwrubrHiGvpODTP3XzGcAdob
	DcJ5yyl/uNoXSihdVTB3KvLi5IFQiY5VDIAFMHRPXOl7D/E5NSM9vQbZEIksjMUq8cVfwMKK7mQ
	VmDLW316dCHdTQCtD24sYDDlgEjgfEuPIpEJoXvlNG5BWeiwlDaNVmIrI3TwwN1Uhmi43HAo0fS
	x5dFxYbBv6zRXxQINmje4CmcXHLIfW8M+L2PSCGH5I/vG9IuDSg3JpPJcLt81wSOrQlEcH2Vvxp
	xlD1jhEH9FQ4fIooN5ViHSkeDEFvjh/xA/Ad9mkPun4Y0LGn7QMCIIyo+JxCLh9JkZbOmFE4C/G
	e1V9SGjKArpRaYhuLsq4H8Pt7pUwIR0sXDlWvINH2OgKqNZnum72SsK0/3Zedg99dl
X-Received: by 2002:a17:902:ef45:b0:2a0:9ca7:7405 with SMTP id d9443c01a7336-2a95192a3d3mr26109155ad.36.1770360274531;
        Thu, 05 Feb 2026 22:44:34 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.207.208.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a952205e83sm16689695ad.81.2026.02.05.22.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 22:44:34 -0800 (PST)
Message-ID: <c400d2a68d87a29e17a08ed03489ca33ea46a8f4.camel@gmail.com>
Subject: Re: [PATCH v3 4/6] xfs: tag folios with AG number during buffered
 write via iomap attach hook
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Kundan Kumar <kundan.kumar@samsung.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, willy@infradead.org, mcgrof@kernel.org, 
 clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
 hch@lst.de,  ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
 cem@kernel.org,  wangyufei@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com, 
	vishak.g@samsung.com, joshi.k@samsung.com
Date: Fri, 06 Feb 2026 12:14:24 +0530
In-Reply-To: <20260116100818.7576-5-kundan.kumar@samsung.com>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	 <CGME20260116101256epcas5p2d6125a6bcad78c33f737fdc3484aca79@epcas5p2.samsung.com>
	 <20260116100818.7576-5-kundan.kumar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2026-01-16 at 15:38 +0530, Kundan Kumar wrote:
> Use the iomap attach hook to tag folios with their predicted
> allocation group at write time. Mapped extents derive AG directly;
> delalloc and hole cases use a lightweight predictor.
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/xfs/xfs_iomap.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 490e12cb99be..3c927ce118fe 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -12,6 +12,9 @@
>  #include "xfs_trans_resv.h"
>  #include "xfs_mount.h"
>  #include "xfs_inode.h"
> +#include "xfs_alloc.h"
> +#include "xfs_ag.h"
> +#include "xfs_ag_resv.h"
>  #include "xfs_btree.h"
>  #include "xfs_bmap_btree.h"
>  #include "xfs_bmap.h"
> @@ -92,8 +95,119 @@ xfs_iomap_valid(
>  	return true;
>  }
>  
> +static xfs_agnumber_t
> +xfs_predict_delalloc_agno(const struct xfs_inode *ip, loff_t pos, loff_t len)
> +{
> +	struct xfs_mount *mp = ip->i_mount;
> +	xfs_agnumber_t start_agno, agno, best_agno;
> +	struct xfs_perag *pag;
Nit: Coding style - I think XFS uses a tab between the data type and the identifier and makes all
the identifier align. Something like
int			a;
struct xfs_mount	*mp;
> +
Nit: Extra blank line?
> +	xfs_extlen_t free, resv, avail;
> +	xfs_extlen_t need_fsbs, min_free_fsbs;
> +	xfs_extlen_t best_free = 0;
> +	xfs_agnumber_t agcount = mp->m_sb.sb_agcount;
Similar comment as above
> +
> +	/* RT inodes allocate from the realtime volume */
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		return XFS_INO_TO_AGNO(mp, ip->i_ino);
What are we returning for realtime volume? AG sizes and rtgroup sizes may be different, isn't it?
Can we use the above macro for both? Also, rt volume work with extents (which can be more than the
fsblock size) - so will the above work? 
> +
> +	start_agno =  XFS_INO_TO_AGNO(mp, ip->i_ino);
> +
> +	/*
> +	 * size-based minimum free requirement.
> +	 * Convert bytes to fsbs and require some slack.
> +	 */
> +	need_fsbs = XFS_B_TO_FSB(mp, (xfs_fsize_t)len);
> +	min_free_fsbs = need_fsbs + max_t(xfs_extlen_t, need_fsbs >> 2, 128);
A short comment explaining the above?
> +
> +	/*
> +	 * scan AGs starting at start_agno and wrapping.
> +	 * Pick the first AG that meets min_free_fsbs after reservations.
> +	 * Keep a "best" fallback = maximum (free - resv).
> +	 */
> +	best_agno = start_agno;
> +
> +	for (xfs_agnumber_t i = 0; i < agcount; i++) {
Maybe use for_each_perag_wrap_range or for_each_perag_wrap (defined in fs/xfs/libxfs/xfs_ag.h)?
> +		agno = (start_agno + i) % agcount;
> +		pag = xfs_perag_get(mp, agno);
> +
> +		if (!xfs_perag_initialised_agf(pag))
> +			goto next;
> +
> +		free = READ_ONCE(pag->pagf_freeblks);
> +		resv = xfs_ag_resv_needed(pag, XFS_AG_RESV_NONE);
> +
> +		if (free <= resv)
> +			goto next;
> +
> +		avail = free - resv;
> +
> +		if (avail >= min_free_fsbs) {
> +			xfs_perag_put(pag);
> +			return agno;
> +		}
> +
> +		if (avail > best_free) {
Just for my understanding - we are doing a largest fit selection, aren't we?
> +			best_free = avail;
> +			best_agno = agno;
> +		}
> +next:
> +		xfs_perag_put(pag);
> +	}
> +
> +	return best_agno;
> +}
> +
> +static inline xfs_agnumber_t xfs_ag_from_iomap(const struct xfs_mount *mp,
> +		const struct iomap *iomap,
> +		const struct xfs_inode *ip, loff_t pos, size_t len)
> +{
> +	if (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_UNWRITTEN) {
> +		/* iomap->addr is byte address on device for buffered I/O */
> +		xfs_fsblock_t fsb = XFS_BB_TO_FSBT(mp, BTOBB(iomap->addr));
> +
> +		return XFS_FSB_TO_AGNO(mp, fsb);
> +	} else if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_DELALLOC) {
> +		return xfs_predict_delalloc_agno(ip, pos, len);
> +	}
> +
> +	return XFS_INO_TO_AGNO(mp, ip->i_ino);
> +}
> +
> +static void xfs_agp_set(struct xfs_inode *ip, pgoff_t index,
> +			xfs_agnumber_t agno, u8 type)
> +{
> +	u32 packed = xfs_agp_pack((u32)agno, type, true);
> +
> +	/* store as immediate value */
> +	xa_store(&ip->i_ag_pmap, index, xa_mk_value(packed), GFP_NOFS);
Maybe nit: Unhandled return from xa_store() - It returns void *
> +
> +	/* Mark this AG as having potential dirty work */
> +	if (ip->i_ag_dirty_bitmap && (u32)agno < ip->i_ag_dirty_bits)
if agno >= i_ag_dirty_bits, then shouldn't we throw a warn or an ASSERT() or XFS_IS_CORRUPT() -
Darrick, any thoughts?
> +		set_bit((u32)agno, ip->i_ag_dirty_bitmap);
> +}
> +
> +static void
> +xfs_iomap_tag_folio(const struct iomap *iomap, struct folio *folio,
> +		loff_t pos, size_t len)
Nit: Coding style:
I think xfs functions declares 1 parameter in each line with the ")" just after the last parameter
on the same line. Look at something like xfs_swap_extent_rmap() defined in fs/xfs/xfs_bmap_util.c.
Not sure if the maintainers have hard preferences with this - so better to cross check.
> +{
> +	struct inode *inode;
> +	struct xfs_inode *ip;
> +	struct xfs_mount *mp;
> +	xfs_agnumber_t agno;
Coding style as mentioned before:
struct inode		*inode;
struct xfs_inod		*ip;

--NR 
> +
> +	inode = folio_mapping(folio)->host;
> +	ip = XFS_I(inode);
> +	mp = ip->i_mount;
> +
> +	agno = xfs_ag_from_iomap(mp, iomap, ip, pos, len);
> +
> +	xfs_agp_set(ip, folio->index, agno, (u8)iomap->type);
> +}
> +
>  const struct iomap_write_ops xfs_iomap_write_ops = {
>  	.iomap_valid		= xfs_iomap_valid,
> +	.tag_folio		= xfs_iomap_tag_folio,
>  };
>  
>  int

