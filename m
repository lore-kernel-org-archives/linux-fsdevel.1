Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F33C4B64
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207826; cv=none; b=np/orpOo5lT4rIl04hRmXNURZtM3OqWv5mkHwD3mhu8+lgKLNG3nUcCiGmCWyEZ2pGg/uiACBAkr2Ng6Bdh12DJPLwJeeaC2GGFrUJid9SATiMHOJ5KUqxlrmbJAoIRo44YRWiIRws3g6ZvvjO4ysDunmAjj6jhTf3/bjEx1M+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207826; c=relaxed/simple;
	bh=DjPv1Hn2Z3CRKTcBg45/zj1JqsU4Tj7v0CV1EfPK7ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmiLG9fbm5p929l7wwfpujF915YXpVWvN3l30PCAXZXLqtr7TjemyHJ6o/Lp29H1XOpdX3fxn4R+BA11Ezjp4WQDD5T9Qk2Rkfv/S96yxs+EoDr/yWosdsqUnztiQz+U/N5ZMUIkX/7kWal7UcHI1J6WAV4eLjnPZ3MPHJoK1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=N2pb7zkd; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ocOcil60; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="N2pb7zkd";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ocOcil60"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCUUW2037875
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=acIK
	MEYO1UcWv0TYeAF2D3GMMAsylHF/37x5XTPAOBk=; b=N2pb7zkd6/gB4LQG20M8
	FrBB/HFN86kbHsUzUCcvoy4ju3qc/CZblejDzjCS0fLcctg3i4uD888goRC8E1W/
	YIF+HBHYIJkUecusFVN5ukogINw9DISjuj9V11L42GljtPPJYcZIst5GlZs5bhyI
	92D67UIvC8SPBLTvdAxCSCdeJqENyzWAa+Q+MxyQmIWnglWYeFURN6D04c88xbj6
	u9HC3LBp4RG5mfPQs0S/PxAu2kOas8juuX/+i8V81WmhMO7ooLImHir5eZh6pfPe
	zsVFTplI+OKTgmwKY1sg2CmQM4QqBtnY0VWrgb+q4Tf1jduBkMTK4pP7nO7336BC
	kA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvh5wcrwb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:02 -0400 (EDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4afc810bfso247443a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207822; x=1790812622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=acIKMEYO1UcWv0TYeAF2D3GMMAsylHF/37x5XTPAOBk=;
        b=ocOcil60OWWDkDpDXqN737v75HtJXOdJ1Stad5mK+73yymCzo70S1VI0rIC+NXkv17
         JR6z21+eAeWhds5JJu1dJ4xjPuYLj0dTXHxY68dq154soVus55HArKkZJSRDg0Ek0cqb
         8yoYBMUfhzUZG9JbxG+axm5OcRthibCiZJMqS2W44atPpU2TvxMKVDArefKVwxYf7izd
         ACjds0QVSxIhlh7LHLIvrtpoegAvPz8gXnbS3onsK6VS3n8Lif57CSU7q9CM96SnlBpE
         d8+fJ0c2njO3xMKvk0riGZE9VCzZM5xMd8evG6q0k3RUenR8mrMHffbQt62zMWYhWQ74
         QrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207822; x=1790812622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acIKMEYO1UcWv0TYeAF2D3GMMAsylHF/37x5XTPAOBk=;
        b=KZpI89wiECbc31Gv0ZSeQcN5iCxT2iDKJny+ZMqHSQU7gHJen+yPNDcZYsqUIAJ9Wl
         1YOp/jTLQmHTN1pLg9dEhSWwXRAA31TqktaqjMBpxvRF7LK0dS1NGMKq7lQkesNHnwxO
         xOlDLl9PsfC+qFegSpIb6fi+ecexIZjbAvSIMg1CfPuBoLo+5I+ZdpPBeZVGq6llDEkm
         IlgB2oIR0287O0Rzbvq4PWvrG5+sAGcsRoZl6qOFLSk4gArjskYHp9nSm+29HaYeOLs4
         DfgRKJItBO03OUy5419qTtWUwT/IXMa/870nV52xnyDfNqKb1yUmYsY+xCQAB7DALRBP
         /RtA==
X-Forwarded-Encrypted: i=1; AKwUvBw1dWgC8aPoQS8VxW3k04DZBCh8D8f4eq9oLFu+28Ihu8X1EsIXXuHaLzT0CGqe+NtJ4tTA3J1S90pgYKYw@vger.kernel.org
X-Gm-Message-State: AFuF++lG1htIv3lmveXapMLeVYyNS0GHv2g3WBANPLUimvG/8TbUqxAD
	lATaemrZbXomWNnojyBOMPVRjN/nSwzlR4sIyfZEigpBm8qo8CsZZ8XfgHwuJ36ncihgt3tNxh+
	DdYYUomEgSGvX8l5Fm10+yTC+qU/xNGDsCrGlgC6su9vR3zLsRqTmiCGkECdf1gM=
X-Gm-Gg: AYBFou2xfZ1+BezjF1q+DkXwI8bEF72mLE2eW6JSYWcixr9a2Rw//N0x7brQzjjdM/Q
	6HmMWrkJ5PqUQ4DlwDme648c+wmdMILw0ZLbVZtGVcbu+VaiX7mEn43+vm7moB1XVJ0GwCiyqIn
	YDH0GnsqJG86s5pWuNIaGCU67DgWhMFbTuo3puSy9f2r4UXte2tJAodNdBMFSwVw25VpKTj/PnS
	CxLLe/CdaS7HgELGr57rdkQ0E+OEApk/RGcj5qBfwt71Lini/k4NvKEAC2sg4vDDHSpjpia3lbM
	bg/Lsf4aZZ+eEVriofkHn7CPq2OP6F3j3+D0J3thLR8qXdQgCkMdsek/xzY5DFJAMgv6ablULTQ
	+2E8kIUg3tRQriejswYh2v/otFNzZ+PuPT0rR0cVjExYy0A==
X-Received: by 2002:a17:90a:f94f:b0:3a0:2614:2077 with SMTP id 98e67ed59e1d1-3a098b93d4bmr460213a91.41.1790207822129;
        Wed, 23 Sep 2026 16:57:02 -0700 (PDT)
X-Received: by 2002:a17:90a:f94f:b0:3a0:2614:2077 with SMTP id 98e67ed59e1d1-3a098b93d4bmr460196a91.41.1790207821673;
        Wed, 23 Sep 2026 16:57:01 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:57:00 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:38 -0400
Subject: [PATCH v5 5/9] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-5-89e60d66eb38@columbia.edu>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
In-Reply-To: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=4628;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=DjPv1Hn2Z3CRKTcBg45/zj1JqsU4Tj7v0CV1EfPK7ro=;
 b=DdSNzfh0KBkbq0ty8HCCWgTl4/CMY6lVQ7hyEUyr2D4eNp2M/mWEC6MwbBQB34nmy3lgz4Xvr
 62qsv0NQt+WAoXE5g3v+FVMH4zL0sfQH9iXjZjxPBRG+0Ehn+bbz8h0
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: K4y331NY9wUAGX--IuN1bFxXrGaGd_Qv
X-Authority-Analysis: v=2.4 cv=DIEacCNb c=1 sm=1 tr=0 ts=6ab4674e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=DOn4q0-T8uZzdi3JsfgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX4UxtysXEIMQE
 EFQR0IEXfa5mVReps/h5RfU1H+DpJabDVW80bDAUYcUJ4wOyC6qfaSiYQBgnIOKhfgADrTHBzgz
 bEq8HvI2TlVnO/X6reOjSUxnXgT49GIUeqzUmqvbXcoX+tJs4ChH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX299Qyzj2Tl17
 YIA5tw5qTTD6YixG3RLGdtNm5EOAm//SuepuzZbdB0ruGn7//zRK9utfBOPLHgIrkdYSD89tWBZ
 v04rWHQwpnOb3VgKngW4EQ+ZFWgQIP/2C81l5Eonvn/p5zvUldihjQP8GfYV5RlqBojqpSJWnAL
 CfMJEjTVzEtzLoEBQxIPfqsugw8eyQ6TsboyqsRBhk6RZUi1WYOv7r8BrKXpiEhSac5Qpb0mm5T
 nANvAhtYV8FHJTt0cIK2uOh/Zkfw2h2Sk8ZVssFvtTFlq2yzSnMEesMOqZOrCAEWUm+6jICB1Ws
 /lfTzDncjAo+TmO162akDbOGQ8pNzBGRxZgBTccPfguP8b01H/eSD3sVBHm1DwzvRByd/LSw8F0
 PVawjHbrZWZfsoHmHgC0/qWyNlCVkPzuwk3Rgu3wtidsXa6jeFJuA+J6di5dqwutDjdA9GFXEMT
 CJrLdcn5AWYORjML5DA==
X-Proofpoint-ORIG-GUID: K4y331NY9wUAGX--IuN1bFxXrGaGd_Qv
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=10 impostorscore=10 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

On a partial page pin, __blkdev_direct_IO_simple() and
__blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC set
and leave the rest to the buffered fallback, tearing an IOCB_ATOMIC
write.

This can be triggered deterministically. A 16K pwritev2(RWF_ATOMIC)
whose last page is PROT_NONE, on a scsi_debug device with atomic_wr=1,
completes short with only three of the four pages written, violating
RWF_ATOMIC semantics.

Make bio_iov_iter_get_pages() release the pins and return -EINVAL when
a REQ_ATOMIC bio doesn't cover the whole iterator, since an atomic
write is submitted as a single bio and a short one would be torn. That
covers iomap as well, where a partially unmapped buffer could trip the
WARN_ON_ONCE() in iomap_dio_bio_iter_one(). The async block device path
currently sets REQ_ATOMIC after pinning, so set it before, and move
REQ_NOWAIT along with it.

Fixes: caf336f81b3a ("block: Add fops atomic write support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
Assisted-by: Claude:claude-fable-5
Reviewed-by: John Garry <john.garry@linux.dev>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c  | 46 ++++++++++++++++++++++++++++++----------------
 block/fops.c | 12 ++++++------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f95b63c0604a..dff84c0b54bd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1285,6 +1285,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned mem_align_mask, unsigned len_align_mask)
 {
 	iov_iter_extraction_t flags = 0;
+	int ret;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1304,34 +1305,47 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		flags |= ITER_ALLOW_P2PDMA;
 
 	do {
-		ssize_t ret;
+		ssize_t size;
 
-		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
+		size = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
 				BIO_MAX_SIZE - bio->bi_iter.bi_size,
 				&bio->bi_vcnt, bio->bi_max_vecs,
 				mem_align_mask, flags);
-		if (ret <= 0) {
-			/*
-			 * A misaligned vector fails the whole I/O.  Release any
-			 * pages pinned by earlier iterations before returning
-			 * since this bio won't be submitted to release them.
-			 */
-			if (ret == -EINVAL) {
-				bio_release_pages(bio, false);
-				bio_clear_flag(bio, BIO_PAGE_PINNED);
-				bio->bi_vcnt = 0;
-			}
+		if (size <= 0) {
+			/* A misaligned vector fails the whole I/O */
+			if (size == -EINVAL)
+				goto out_release_pages;
 			if (!bio->bi_vcnt)
-				return ret;
+				return size;
 			break;
 		}
-		bio->bi_iter.bi_size += ret;
+		bio->bi_iter.bi_size += size;
 	} while (iov_iter_count(iter) && !bio_full(bio, 0));
 
 	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
 		bio->bi_opf |= REQ_NOMERGE;
-	return bio_iov_iter_align_down(bio, iter,
+	ret = bio_iov_iter_align_down(bio, iter,
 			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
+	if (ret)
+		return ret;
+
+	/*
+	 * An atomic write is submitted as a single bio, so it has to cover
+	 * the whole iterator or it would be torn.
+	 */
+	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter))
+		goto out_release_pages;
+	return 0;
+
+out_release_pages:
+	/*
+	 * Release the pages pinned so far before failing, since this bio won't
+	 * be submitted to release them.
+	 */
+	bio_release_pages(bio, false);
+	bio_clear_flag(bio, BIO_PAGE_PINNED);
+	bio->bi_vcnt = 0;
+	return -EINVAL;
 }
 
 static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
diff --git a/block/fops.c b/block/fops.c
index f61d250e49c8..d143a664c770 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -342,6 +342,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		bio->bi_opf |= REQ_ATOMIC;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		bio->bi_opf |= REQ_NOWAIT;
+
 	/*
 	 * Users don't rely on the iterator being in any particular
 	 * state for async I/O returning -EIOCBQUEUED, hence we can
@@ -371,12 +377,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 			goto out_bio_put;
 	}
 
-	if (iocb->ki_flags & IOCB_ATOMIC)
-		bio->bi_opf |= REQ_ATOMIC;
-
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		bio->bi_opf |= REQ_NOWAIT;
-
 	if (iocb->ki_flags & IOCB_HIPRI) {
 		bio->bi_opf |= REQ_POLLED;
 		submit_bio(bio);

-- 
2.39.5

