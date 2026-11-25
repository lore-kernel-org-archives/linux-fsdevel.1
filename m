Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595750;
	b=SsovNJ30GdIqyKIOejei43ip+lr+gMKEN98TSkW/2/YaS4FjmHszrF3tn+cfPLUX1/LD
	 G4U5kmNC4UOUzgG5eq1LuUCjeZlJ9X74zP3MrqFBpTKjpel9xDkV1VDR0wbt2Ngt5dcD3
	 Sy2yR68WAmwMZGmdbPkmBt/wUibwFSnRqlWlfCejB8gC+T3hgixfqlYjFknNvUSabNFBn
	 4H1Cq4gDQQHqzj64qHkpDWrp28VWWSQzhfqqyxItgfVfm89g1PEHHfMBhAI6qH8LfcOYt
	 3OIuPZlKUElcvJ9jXFhEfSAEjEXbCGe2yvH/BEEoVKXMsAmbAdHP/X8D0ZYzkpwJOWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595750;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:CMS-TYPE:cpgsPolicy:X-CFilter-Loop:
	 X-CMS-RootMailID:References;
	bh=Wy9sGLagl9a+C2HM4iwLhHQcprsmo9XW11Z1dCsCBtk=;
	b=Xj7/H+JhI10VB+hT1x58D3iUXCzcNrOPRGDsthgvCTqRQ/bnUpn8j56MBIihmz+FCfTw
	 n/w5OI9L8tbv4+6Ara4a2Ju0fyxL4EyZNzTJWSVasAfyjhHiXiXHARQfowDVrNPDkupGr
	 cmr930QZDPDe2Mehb2p2rOqrqr/FKSD3foCPREJaDvDjHawgiVgGoeUnnWEhN0/gACZ9I
	 5T1Nz1eMcoP+Rd9uZ8NT0Rq9HMwWOLrsPX9Q6cAcXnxUvo4RrVC9YAVQVTgmHhY6AhT5B
	 G2q0dEZCY7Ja0QrLVcX/UNsh11AxT8T5stH5GtMW365aOkYEDZ4epow/S7U5OqiE+sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lKIGL1dQ;
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663C606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A663C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lKIGL1dQ
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261125083548epoutp03faedc1b11d6af15cd59911911e037264~rPNHDG3ba1704417044epoutp03-
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:35:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261125083548epoutp03faedc1b11d6af15cd59911911e037264~rPNHDG3ba1704417044epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795595748;
	bh=Wy9sGLagl9a+C2HM4iwLhHQcprsmo9XW11Z1dCsCBtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKIGL1dQ1XtBPauEt+TWrDMioLQg/6I/3xk4FwIipvqwT7uZcEMKNrZzeNxb+99/Q
	 belZfLYXMKTGmoTPidxuslcaOEXJ6N7dRImYFOQEXzVps46CDBXG+qxJmwqvwrKP5W
	 gKomoVFBKu1Z8bNyNvenzPKDfATdiBZBzpo8iqCA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261125083547epcas5p2a134c0c93b98090382e0d5f14cd6e900~rPNGEl_U13005330053epcas5p2t;
	Wed, 25 Nov 2026 08:35:47 +0000 (GMT)
Received: from epdlp11prp7 (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jZCgQ1vmyz6B9m5; Wed, 25 Nov
	2026 08:35:46 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261125083545epcas5p190b274ce3e7924a927f87df293dcd382~rPNE_XO0k1553115531epcas5p1n;
	Wed, 25 Nov 2026 08:35:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261125083543epsmtip18736cbd02fa17bba29c51ecd57fb558b~rPNDPbpXH0455204552epsmtip1J;
	Wed, 25 Nov 2026 08:35:43 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: brauner@kernel.org, hch@lst.de, djwong@kernel.org, dgc@kernel.org,
	cem@kernel.org, jack@suse.cz, hans.holmberg@wdc.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v8 7/9] xfs: support write streams on realtime volumes
Date: Wed, 25 Nov 2026 14:03:11 +0530
Message-Id: <20261125083313.106334-8-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261125083313.106334-1-joshi.k@samsung.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261125083545epcas5p190b274ce3e7924a927f87df293dcd382
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261125083545epcas5p190b274ce3e7924a927f87df293dcd382
References: <20261125083313.106334-1-joshi.k@samsung.com>
	<CGME20261125083545epcas5p190b274ce3e7924a927f87df293dcd382@epcas5p1.samsung.com>

From: Anuj Gupta <anuj20.g@samsung.com>

Enable write streams on non-zoned realtime volumes that have realtime
groups, partitioning RTGs among the streams as the AG side does.

Stream based RTG selection applies to the first allocation of a file;
later ones keep using the adjacent-allocation hint so the file stays
contiguous.

Directory with realtime inherit flag reports and allocates from the
realtime pool, so that streams queried or allocated through a directory
can be used for the files created in it.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/xfs/xfs_ioctl.c   | 24 ++++++++++++++++++++----
 fs/xfs/xfs_rtalloc.c | 28 ++++++++++++++++++++++++++++
 fs/xfs/xfs_super.c   |  7 +++++++
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 48195143b812..5c07c6eb7cce 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -560,7 +560,8 @@ xfs_ioctl_setattr_xflags(
 
 	/* refuse a filestream/realtime flag change while a stream is attached */
 	if (READ_ONCE(VFS_I(ip)->i_write_stream) &&
-	    ((fa->fsx_xflags & FS_XFLAG_FILESTREAM) || rtflag))
+	    ((fa->fsx_xflags & FS_XFLAG_FILESTREAM) ||
+	     rtflag != XFS_IS_REALTIME_INODE(ip)))
 		return -EINVAL;
 
 	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
@@ -1442,17 +1443,32 @@ xfs_ioc_free_eofblocks(
 	return xfs_blockgc_free_space(mp, &icw);
 }
 
-/* Pool for the data of @inode, or NULL if it cannot use write streams. */
+/*
+ * Pool for the data of @inode, or NULL if it cannot use write streams.  A
+ * directory that passes the realtime flag on to new files uses the realtime
+ * pool, so that streams allocated through it can be set on those files.
+ */
 static struct write_stream_pool *
 xfs_write_stream_pool(
 	struct inode		*inode)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
 	struct write_stream_pool *pool = NULL;
+	bool			rt;
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
-	if (!xfs_inode_is_filestream(ip) && !XFS_IS_REALTIME_INODE(ip))
-		pool = &ip->i_mount->m_ddev_targp->bt_stream_pool;
+	if (xfs_inode_is_filestream(ip))
+		goto out_unlock;
+
+	rt = XFS_IS_REALTIME_INODE(ip) ||
+	     (S_ISDIR(inode->i_mode) &&
+	      (ip->i_diflags & XFS_DIFLAG_RTINHERIT) && mp->m_rtdev_targp);
+	if (!rt)
+		pool = &mp->m_ddev_targp->bt_stream_pool;
+	else if (!xfs_has_zoned(mp))
+		pool = &mp->m_rtdev_targp->bt_stream_pool;
+out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 	return pool;
 }
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 84efe5a8fb11..c7c3098182bb 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -2160,6 +2160,29 @@ xfs_rtallocate_align(
 	return 0;
 }
 
+static xfs_rtblock_t
+xfs_bmap_write_stream_rtbno(
+	struct xfs_inode	*ip,
+	unsigned int		stream_id)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	unsigned int		nr_rtgs = mp->m_sb.sb_rgcount;
+	unsigned int		nr_streams =
+		write_stream_pool_count(&mp->m_rtdev_targp->bt_stream_pool);
+	unsigned int		set_size = nr_rtgs / nr_streams;
+	xfs_rgnumber_t		start_rgno, target_rgno;
+	xfs_ino_t		ino = I_INO(ip);
+
+	stream_id -= 1;	/* convert from 1-based to 0-based */
+	start_rgno = stream_id * set_size;
+	if (stream_id == nr_streams - 1)
+		set_size = nr_rtgs - start_rgno;
+	target_rgno = start_rgno + do_div(ino, set_size);
+
+	return (xfs_rtblock_t)target_rgno <<
+		mp->m_groups[XG_TYPE_RTG].blklog;
+}
+
 int
 xfs_bmap_rtalloc(
 	struct xfs_bmalloca	*ap)
@@ -2174,10 +2197,13 @@ xfs_bmap_rtalloc(
 	bool			noalign = false;
 	bool			initial_user_data =
 		ap->datatype & XFS_ALLOC_INITIAL_USER_DATA;
+	unsigned int		stream_id;
 	int			error;
 
 	ASSERT(!xfs_has_zoned(ap->tp->t_mountp));
 
+	stream_id = READ_ONCE(VFS_I(ap->ip)->i_write_stream);
+
 retry:
 	error = xfs_rtallocate_align(ap, &ralen, &raminlen, &prod, &noalign);
 	if (error)
@@ -2185,6 +2211,8 @@ xfs_bmap_rtalloc(
 
 	if (xfs_bmap_adjacent(ap))
 		bno_hint = ap->blkno;
+	else if (stream_id && xfs_has_rtgroups(ap->ip->i_mount))
+		bno_hint = xfs_bmap_write_stream_rtbno(ap->ip, stream_id);
 
 	if (xfs_has_rtgroups(ap->ip->i_mount)) {
 		error = xfs_rtallocate_rtgs(ap->tp, bno_hint, raminlen, ralen,
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a541e97b580f..0a0a08eb3eb1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -637,6 +637,13 @@ xfs_setup_devices(
 		if (error)
 			return error;
 		xfs_update_bdi_rahead(mp);
+
+		if (xfs_has_rtgroups(mp) && !xfs_has_zoned(mp)) {
+			error = xfs_buftarg_init_streams(mp->m_rtdev_targp,
+					mp->m_sb.sb_rgcount);
+			if (error)
+				return error;
+		}
 	}
 
 	return 0;
-- 
2.25.1

