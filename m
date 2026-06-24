Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D43BC668
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322383; cv=none; b=M6K1yK8/C62o6iJr9CkIcS+ZCCkSqWbD5+00KtSQKB10XoTesu6W3mxmHa3NT7lFjGfW1ArFKUghUjHNSLfk2qemZU/y/ommeyHScT53KTvPruvhH9GruA+dH25jAQmb+ZFf65+GyiKVR/iGU5WxU0Whl+hs6EtMHXvCSZQUJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322383; c=relaxed/simple;
	bh=Fh9BHVIGfQ/RpNprhH8RMfglcQOp0BiJIvJASEH71yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfFDNzxGKJpK8hIOQYKKrZKtY7fwX0aoMPiAccOox0Q63S3xo1wMLD4IXPkyhWryH+QSoH1BheBNFMMyB4CvkDUTAUICi6Go864P6rFmzP0rkgK/KUCrE1IE0FKrHbOsZKqGwmvJsMT7f/8gyzo+Ykmq7kOGKstui0103ixAM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JR9XLhQ3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JR9XLhQ3"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65OEjpZb3867835
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 10:33:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=iio3hccJh+B4s2gOQB4736zZXTM3PJ1TkZjIqDtxVOQ=; b=JR9XLhQ3ntPR
	+ZhJCJTDh1AK3er5sJznNKZ4mMKekiL/8hRfqJhLYkXyHRU0butMdjmAfArwh2YO
	6+mKe628A4UFMPBEJGYxsGpUEb9kKs1dpVvlRKajp1NAWyEfizGy4aRHckE00hm7
	+EVInK24t/tw5sGxYwvOmMX9Q9eeiSVUKje/EHF2WmFSKceLAD/Tiw1zhUhYFc+Q
	nRREkZItJmBhKi2fUHwClKN3PD/LHbdNKvsWmG1XwDO14z3/HEst2nYnPXQWWNIz
	FKYC+Kx6UxCDCrYd9/ogTeIWW174ywLdFJJZvOz+Gm08M6xe5/n9H2raouZQ1Xx7
	g4Ud2WGdNg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eyumnj1e0-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 10:32:59 -0700 (PDT)
Received: from twshared11639.02.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 24 Jun 2026 17:32:59 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4863A23C452BD; Wed, 24 Jun 2026 10:09:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH v3 3/5] loop: set dma_alignment from the backing file for direct I/O
Date: Wed, 24 Jun 2026 10:09:03 -0700
Message-ID: <20260624170905.3972095-4-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624170905.3972095-1-kbusch@meta.com>
References: <20260624170905.3972095-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0Prd_wETY1FL_73zPfKbQfN0qat8gHyJ
X-Authority-Analysis: v=2.4 cv=Sq+gLvO0 c=1 sm=1 tr=0 ts=6a3c14cb cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=w3YrK2sSALtTPwlh2GsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NiBTYWx0ZWRfX3WmJXi+iots4
 VbAK0hif8FMIpjeaR23nlcHMtpwnYQcbTBbKCedXFRsm2BpHI4e22FNY65Ao72VErcBCLr/0JlU
 51EZTheqNirhEQQ9ZZiU8h/YrvOnseE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NiBTYWx0ZWRfX8VaEYgj+lGdQ
 IPwonfkLZbz+hmk822mOZVMozMGIEZqCo5kfNvfY2SvcKiSdHNj/ysvlrflKl24AOhW/a1nH4vx
 CD38lCHEaZ/oafFCpHv4kkAOw/qQWznGXqYys9nXgYaiOyT/7KlWRWkWzLYCFX9EX/uGhILUQSP
 3bF0UrmYy4levoatGgaeRjEk5yka1rUsAJI8GMjs3+gcoqz6bUGFa40OqlA2XRjMBDqzVe5+Vr6
 WQQnDLOdtqeIsJpSjJdArD5TTzT919P3j1Z0chNMKqEKvfVtDkCKD1NDcluHODiDt4wdZ6e9lDN
 eDVuXMhqj3QszCw+7VxemA0N4AHK+d0gqplW9iRqw6AioGj+DEUYK6jWLT3l76VJJWok6ZW68cy
 Ld+2I1uDb02AwF5g9B1rcFabbg8HaA==
X-Proofpoint-GUID: 0Prd_wETY1FL_73zPfKbQfN0qat8gHyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Direct I/O user pages are forwarded to the backing file unchanged, so
the backing's DMA alignment requirement applies to them. Track the
backing file's dio_mem_align and advertise it as the loop device's
dma_alignment if it is larger than the default so we advertise proper
limits and misaligned I/O is rejected early instead of being dispatched
to the backend.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/loop.c | 46 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 310de0463beb1..5fe61d542f8b7 100644
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
+	 * Use the dio alignment of the file system if provided.  The incomoing
+	 * request's bio_vec is forwarded to the backing file unchanged, so its
+	 * required memory alignment becomes the device's dma_alignment when
+	 * used for direct-io.
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
@@ -940,6 +952,19 @@ static unsigned int loop_default_blocksize(struct lo=
op_device *lo)
 	return SECTOR_SIZE;
 }
=20
+static void loop_set_dma_limit(struct loop_device *lo, struct queue_limi=
ts *lim)
+{
+	/*
+	 * Direct I/O forwards the user pages to the backing file unchanged, so
+	 * track the backing's DMA alignment requirement as the mode is toggled=
.
+	 */
+	if (lo->lo_flags & LO_FLAGS_DIRECT_IO)
+		lim->dma_alignment =3D max_t(unsigned int, lo->lo_dio_mem_align,
+					   SECTOR_SIZE - 1);
+	else
+		lim->dma_alignment =3D SECTOR_SIZE - 1;
+}
+
 static void loop_update_limits(struct loop_device *lo, struct queue_limi=
ts *lim,
 		unsigned int bsize)
 {
@@ -961,6 +986,7 @@ static void loop_update_limits(struct loop_device *lo=
, struct queue_limits *lim,
 	lim->logical_block_size =3D bsize;
 	lim->physical_block_size =3D bsize;
 	lim->io_min =3D bsize;
+	loop_set_dma_limit(lo, lim);
 	lim->features &=3D ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
 	if (file->f_op->fsync && !(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		lim->features |=3D BLK_FEAT_WRITE_CACHE;
@@ -1416,6 +1442,7 @@ static int loop_set_dio(struct loop_device *lo, uns=
igned long arg)
 {
 	bool use_dio =3D !!arg;
 	unsigned int memflags;
+	struct queue_limits lim;
=20
 	if (lo->lo_state !=3D Lo_bound)
 		return -ENXIO;
@@ -1434,6 +1461,9 @@ static int loop_set_dio(struct loop_device *lo, uns=
igned long arg)
 		lo->lo_flags |=3D LO_FLAGS_DIRECT_IO;
 	else
 		lo->lo_flags &=3D ~LO_FLAGS_DIRECT_IO;
+	lim =3D queue_limits_start_update(lo->lo_queue);
+	loop_set_dma_limit(lo, &lim);
+	queue_limits_commit_update(lo->lo_queue, &lim);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	return 0;
 }
--=20
2.53.0-Meta

