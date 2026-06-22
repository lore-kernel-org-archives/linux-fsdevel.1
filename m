Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D8340A76
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150186; cv=none; b=MIb3t8aQcLGHDb7i3KYULkW04igRzbu3cs6T3eUx+q6bXSRLuTz+IeU1Zb4vad9OJ0EeLZy7elirnvSZxjuKbpRlhphnQGx85ubfEADBRtfP0VREuT4adVnnhYYfpzDCFB/xKu1YMkKuWk2Lzc4/gXogv2jBW26ME3zEwAdLGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150186; c=relaxed/simple;
	bh=n5ksvNst397l+VMOtxSnIEmKY6BEbGxOtXQdHzzHT+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUhwHd+Cl2yVEFFOCy9eM5c9XR1wbBaLhhDWxuxTZn6mkXySumRIBQtYIcyN4Z9Zg3BE/nt9WxaGrgY0MW4XzPPjtAriZGAPySdIrEzuZyeYMSW7gTjcs5+eNT4YTrZB32Qwcwn55X95CQ6YPJ9KdeFlvbbG/e/MLHDb7QVvg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HzUQ0rkt; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HzUQ0rkt"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MHVgL62279058
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:43:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=BCEC6ojtpv/CLRv6wwQZLM4wTIQf7c5sMaYy+YbszdU=; b=HzUQ0rktxPZe
	Lw5lJ4VMOl5aYs78sQniXC+2wQEye/aR4cErQcIW6fuT49yYbL6uROoKsufkwjoj
	FNz6b2V84z7DergwmsOSYe+VF20dTUoNYkjv39CY1gfg1irSYQ4TE1/BT0//5wVx
	m84V+m6DYQAeuKL4bOmHNQTXIrzUQ88xY3495QZE2DuON5jkGDWnmF7JqSSV18wQ
	IdLzTwBAFRVSUWME+T1UZ34rsiXF6AyaM/yHzgME6/Z889XKdZMEL9/6z6cqK+NY
	k1FHNKTSALFDfd/sHW3pgfg+6B7Me095fzRi4ZWNFjdUJkyhoYEKf6cbX5Co7Fq2
	20vRZ73mdg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4excejgfac-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:43:03 -0700 (PDT)
Received: from twshared16966.02.snb1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 17:43:01 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CAB9523A15DE2; Mon, 22 Jun 2026 10:42:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/6] loop: set dma_alignment from the backing file for direct I/O
Date: Mon, 22 Jun 2026 10:42:39 -0700
Message-ID: <20260622174241.2299563-5-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260622174241.2299563-1-kbusch@meta.com>
References: <20260622174241.2299563-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfX56zCCBiOvm+/
 ZnyVvBHhS5PdJTMw0tFPRFBXZthT3FdtyyN4yN/elyxK074j6UvCE0EfPA697O04bEevsbtdwL7
 QN/G1V0dbB8H3pPfWaZNSdgfsVZRXBjYgTivskqUir5pUyRAws+rrOedqvOKLRFRqzsfO3kSpKa
 7RR2s/7oGHKJVrOLb3h8vnUZHKA9C8hS/cPeWntbAy0fM9373Z2eTzrL4K5FuTNKSy4JtUO3Lop
 FoMQxH9OiDYgTpHUbd5j6zAhI3TB3w9hTvbD7l5DloiO6xUR9wifgodpr2dCFZUf0UKd23YcX7E
 VFGnpyKrEKMvdak+Ix+H8Nucg4NIjMAlQeirF2xNTw01wx0kWS0btkljS/JG5loEpz0fXuua60R
 b5HvLE3VUN6yrhp87hCjwVYVGBlXMHXo9+yo0OvjkQIGBAm9zmZP6z0jN4frFOrE/GTZdd8rHOx
 3xmJUf/bVOoDxAPLNiQ==
X-Authority-Analysis: v=2.4 cv=T7u8ifKQ c=1 sm=1 tr=0 ts=6a397427 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=w3YrK2sSALtTPwlh2GsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfX8kfyZ2+176v5
 X0+hvUpUZ6Hcs0T6mdEMLZSWoT1IOO311FDa7hazKq2ET1obwUMBQGBAzp+OzmnNa0QivSRMdsf
 sXAfAr/QSnc6cv4DowssaO6wbfm653Y=
X-Proofpoint-ORIG-GUID: 0_x2iqBOfRhBDo6vtIh545wjXzSioUCt
X-Proofpoint-GUID: 0_x2iqBOfRhBDo6vtIh545wjXzSioUCt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Direct I/O user pages are forwarded to the backing file unchanged, so
the backing's DMA alignment requirement applies to them. Track the
backing's dio_mem_align and advertise it as the loop device's
dma_alignment so we advertise proper limits and misaligned I/O is
rejected here instead of being dispatched to the backend.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/loop.c | 50 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 310de0463beb1..7114f80ab162a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -54,6 +54,7 @@ struct loop_device {
=20
 	struct file	*lo_backing_file;
 	unsigned int	lo_min_dio_size;
+	unsigned int	lo_dio_mem_align;
 	struct block_device *lo_device;
=20
 	gfp_t		old_gfp_mask;
@@ -447,26 +448,37 @@ static void loop_reread_partitions(struct loop_devi=
ce *lo)
 			__func__, lo->lo_number, lo->lo_file_name, rc);
 }
=20
-static unsigned int loop_query_min_dio_size(struct loop_device *lo)
+static void loop_update_dio_alignment(struct loop_device *lo)
 {
 	struct file *file =3D lo->lo_backing_file;
 	struct block_device *sb_bdev =3D file->f_mapping->host->i_sb->s_bdev;
 	struct kstat st;
=20
 	/*
-	 * Use the minimal dio alignment of the file system if provided.
+	 * Use the dio alignment of the file system if provided.  dio_offset_al=
ign
+	 * is the minimum dio size and offset; dio_mem_align is the buffer memo=
ry
+	 * alignment, kept as a mask to become the loop device's dma_alignment =
in
+	 * direct I/O mode where the buffer is handed to the backing file uncha=
nged.
 	 */
 	if (!vfs_getattr(&file->f_path, &st, STATX_DIOALIGN, 0) &&
-	    (st.result_mask & STATX_DIOALIGN))
-		return st.dio_offset_align;
+	    (st.result_mask & STATX_DIOALIGN)) {
+		lo->lo_min_dio_size =3D st.dio_offset_align;
+		lo->lo_dio_mem_align =3D st.dio_mem_align - 1;
+		return;
+	}
=20
 	/*
 	 * In a perfect world this wouldn't be needed, but as of Linux 6.13 onl=
y
 	 * a handful of file systems support the STATX_DIOALIGN flag.
 	 */
-	if (sb_bdev)
-		return bdev_logical_block_size(sb_bdev);
-	return SECTOR_SIZE;
+	if (sb_bdev) {
+		lo->lo_min_dio_size =3D bdev_logical_block_size(sb_bdev);
+		lo->lo_dio_mem_align =3D bdev_dma_alignment(sb_bdev);
+		return;
+	}
+
+	lo->lo_min_dio_size =3D SECTOR_SIZE;
+	lo->lo_dio_mem_align =3D SECTOR_SIZE - 1;
 }
=20
 static inline int is_loop_device(struct file *file)
@@ -509,7 +521,7 @@ static void loop_assign_backing_file(struct loop_devi=
ce *lo, struct file *file)
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
 	if (lo->lo_backing_file->f_flags & O_DIRECT)
 		lo->lo_flags |=3D LO_FLAGS_DIRECT_IO;
-	lo->lo_min_dio_size =3D loop_query_min_dio_size(lo);
+	loop_update_dio_alignment(lo);
 }
=20
 static int loop_check_backing_file(struct file *file)
@@ -961,6 +973,17 @@ static void loop_update_limits(struct loop_device *l=
o, struct queue_limits *lim,
 	lim->logical_block_size =3D bsize;
 	lim->physical_block_size =3D bsize;
 	lim->io_min =3D bsize;
+	/*
+	 * In direct I/O the user pages are handed to the backing file as-is, s=
o
+	 * the backing's DMA alignment requirement applies to them.  Advertise =
it
+	 * so misaligned I/O is rejected at this device's entry instead of bein=
g
+	 * dispatched to the backend.  Buffered I/O copies through the page cac=
he
+	 * and imposes no such requirement.
+	 */
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		lim->dma_alignment =3D lo->lo_dio_mem_align;
+	else
+		lim->dma_alignment =3D SECTOR_SIZE - 1;
 	lim->features &=3D ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
 	if (file->f_op->fsync && !(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		lim->features |=3D BLK_FEAT_WRITE_CACHE;
@@ -1416,6 +1439,7 @@ static int loop_set_dio(struct loop_device *lo, uns=
igned long arg)
 {
 	bool use_dio =3D !!arg;
 	unsigned int memflags;
+	struct queue_limits lim;
=20
 	if (lo->lo_state !=3D Lo_bound)
 		return -ENXIO;
@@ -1434,6 +1458,16 @@ static int loop_set_dio(struct loop_device *lo, un=
signed long arg)
 		lo->lo_flags |=3D LO_FLAGS_DIRECT_IO;
 	else
 		lo->lo_flags &=3D ~LO_FLAGS_DIRECT_IO;
+	/*
+	 * Direct I/O forwards the user pages to the backing file unchanged, so
+	 * track the backing's DMA alignment requirement as the mode is toggled=
.
+	 */
+	lim =3D queue_limits_start_update(lo->lo_queue);
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		lim.dma_alignment =3D lo->lo_dio_mem_align;
+	else
+		lim.dma_alignment =3D SECTOR_SIZE - 1;
+	queue_limits_commit_update(lo->lo_queue, &lim);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	return 0;
 }
--=20
2.52.0

