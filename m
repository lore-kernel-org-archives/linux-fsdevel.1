Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943C3D8900
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564633; cv=none; b=bbYapQ+ux9a/pR1I5RD9HnQ5/2QGSS6q3w798QzXkVKtJZ3UEh6ljNlP5R3RKQjdsEEbpMf6zZwFAa8X5LXRI0UGPzp+YLC5fnMEx5tqqRd1z1tdOGlga4qbbt+k8cDzQHRhGLNNvPz1quLHLPOipWa65t74/F4z5n2KQCPXtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564633; c=relaxed/simple;
	bh=WPC3WLajC6lyDzmxrfBYM/ewFtKVfxYj5hP42xVnwJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPsmp3La2tSpZOzmgYgXY7SrjtHfYHknH6V6G0JijqF8iDt+8eyjSdtC1LIAeJzs8w31U7Fv6z1tBCOp5fuBypfnnQvdOXNpakiQCc/Bsr+PJw3BvyrOJfVqArDWfgDO9CNsPHcfBUSib6pipo+id4TtFM9YZIavAXYcioQnRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=c+F+JGTK; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=kx4moZ/7; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="c+F+JGTK";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="kx4moZ/7"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GZTwH398511
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Oct 2026 12:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=ECWs
	PXcQGz2l7luRAoCKVt0T8/C+Hf8TLwM1hRXbrhI=; b=c+F+JGTK2fOvNmDnncgZ
	HLidt4lpRen90+nXgeqFfbC4aewU6vhCWagUHB6nDBsB1TWv2CsjhGyPSwrlLbjI
	m0JB+Bzs+zLQ9FJZ78ReVYObV7jS7vq5MFU/IKENG+TZ0xVhCs58DC9QjnqtDVE5
	ATCUnsSQHQ7RdcdUSZwbwKreP9t/jt1weSJ505E1yNOaG1i431EmSOhFtw6o0NOK
	08/nza9ofNA8fjf9kEKQ7jI9hB/kSL720ppsLMtsIr1Zs7YbQ3oF856M9XuBzwpV
	2Ee6y1Io5L+DkdAd8ksPXUfZSpCE3Zre4st93xz+Nb/HBUXTMMIkiRMspti3MnBY
	UQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h6y8qbe3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 12:50:30 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5339253dc3fso145681611cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564630; x=1792169430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECWsPXcQGz2l7luRAoCKVt0T8/C+Hf8TLwM1hRXbrhI=;
        b=kx4moZ/7hkGBRWdKMTmeP3exW1MGCl20z9wBcIzJdRywKCWvtYNKIptn3B1w8oDVuX
         i0WEDQLkGV9yxV+a+CcxZVXp1NsrtiVaVVEwT4CpzXTg87O/91yYz0Kpt5WgWTbxC6nY
         oqLSC4umP0gaerzcogc6Yy1/ntY0nAQ3mgOboIn/NBljfc04OJBNFIzjDxYUcC2NKkpI
         O9HcM8Gw96B6DSqrgR7K3oGwei6bCmq7DRecCTYwnlhwQpktav9ergHQRQTBn3+Knku4
         Z4ajAZbQe91FzQKba9OsLQgc17hD6GIaPPPLHTYL7sP/3DErZ5jqOslvax883gu0Oceg
         FMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564630; x=1792169430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECWsPXcQGz2l7luRAoCKVt0T8/C+Hf8TLwM1hRXbrhI=;
        b=YxA1M1iaz91S/VcpXlzIbI4XLQB1EOJ9stVNVtEuFfaIdAf7d0P9YoSFBOrGpu5Bve
         x6D9V9XZ9ZlPOfOawj25Yswn7IzVn+DJ/lAxjzpX4MlJ314I+KtdvPOr+E8Uzd8gCk7+
         g2csTmT2R7iJoWtv1wFXQAB+Y6iwyqubhlAPDZ3UaHWPiolHlM45puQl9KLSRFQsOgCG
         SQBb8WEhFapN87aPPfrnqhGYQ50eK2e+x/XIIM6dZPwSLUhZyxEV6ES0tG/+SUHNcGOU
         kMuvkrS2ynoaVNVeR5nPVqvUqPw9OuLfrB7+XG1C1/GZJ0+nVh61KX1TKXtcNKHo7Dfy
         pb1g==
X-Forwarded-Encrypted: i=1; AKwUvBx3VgxrKfQ3JZ6Z5GQchPWAfkEelhRsUE1/BuzRY6h524W+WhiSlwegAh5y12sX4RDeO4mILcUqD3Ny1yCi@vger.kernel.org
X-Gm-Message-State: AFuF++nMvfebLvXhDqu0ebj7AQKTmWBlZB40etJj3aqNDn/2z1R0Qlcc
	4hiDsPtxZBgQkbV5IZGsxbrXaGDS2ec/5AAM0i0OVySqQON/LwJszN+3z5LsK7NbhG+jvS+Czea
	6vjyDgxN896wdX6Hvq/Qs51P96Cbt+e68degzexm2s5TdB2MxUg1Am60/c4cdibI=
X-Gm-Gg: AYBFou1iWutDQIkHMyXnO5bin93/SzQCGRwq8zVAheMhlUshAEU0ksqBgsTmwSKcAOK
	6dfaNm1I0TnOGI+vi8ccRWQwL3BwTDGGxDW69rZUDDH7Af6flQZ0Bg29MzW47YGCQp0D/8ehvlL
	dvCMjlYBupa/4r7/1+FBvnNUyhT1tHJdqMWhOICXZ0oDMizmFbOXFkLTzOaEAiGaqQ7xXF92ZUg
	r3WTaLx1RSugmWIjERTbbLykYLLyfjDlnZ59s7gei/I/o+zNkFItIuvyIJLVyRYiCm8W2GWKKfW
	ypFEWgQBUEHnr67BjGGLrVwW7S6agEzsFNOyz53cLZZADSKF1EmD+MaymB9Mu1TBuvR6uZoadi1
	s6tPhg7hbdD9opkfKsw475+a+I+H6mp/oABGbYWPCPNZARJA=
X-Received: by 2002:a05:622a:5809:b0:535:70c5:d39 with SMTP id d75a77b69052e-5359fdf44aemr39879301cf.62.1791564629587;
        Fri, 09 Oct 2026 09:50:29 -0700 (PDT)
X-Received: by 2002:a05:622a:5809:b0:535:70c5:d39 with SMTP id d75a77b69052e-5359fdf44aemr39878711cf.62.1791564628897;
        Fri, 09 Oct 2026 09:50:28 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:28 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:16 -0400
Subject: [PATCH v6 8/9] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-8-307939c387df@columbia.edu>
References: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=3797;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=WPC3WLajC6lyDzmxrfBYM/ewFtKVfxYj5hP42xVnwJw=;
 b=6jzqSXDrOoy+QHGbmCvy3U9AmK4IjKh8EMJmiFe1GMXfqvx7b/oTlV6UMY01kXAnfx2ix/bFK
 nNTvwSL9gs5ACYB4IQhX8Xim/kfJt86cZetgoN3wCb3FiTOvnc0pxaL
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX+a9hg5l3XHUc
 3p3cr7cJ9GF+2mx1/cBqUEvtFfQ4DN2/ZsDlQPr6bjEbhITCOwp5/pEGCdSIx46zI/jOAxQHKuA
 fHFb1A38EEuqEcc6zGarvvgPKSTHsmB54RuIj/A1n9erUfymc7uFVpQgErIi+p5G2So8TBpvrl6
 F71IhfC41I+l6dkS9NEXRtHx0/A4bdqnd5X0sCrtmmbUA4wSfywnzZWDAWed8+tBtJrtB21Y3JB
 9tDStb2aEXBBqrMwSs+Eu6jPNco1adDkNb4xFIVnVj9loipyQqBTj/vpBdJcPP+1hrJVtWRQW/3
 9uT18zd95yF3PZP027ScDaaHL8qfS7nyuatE5k/gD1+NwjeBYgPIHPFRLZFS03ON5M99K3VxqpY
 p7vtw7sW8WbiiPWKsuoTeewkdjk1+JsSWgDoTg4hXboGRYwX7x8wxKuqrryiLDbGGH7sQacDpwh
 32NVHRCmJL8cHk+31cw==
X-Authority-Analysis: v=2.4 cv=EvBHPicA c=1 sm=1 tr=0 ts=6ac91b56 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=FzqJyQ6YvfuMctRh2gUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: -nKhJZyEfbu2ukCUGSdDhAgkVakqgNDa
X-Proofpoint-GUID: -nKhJZyEfbu2ukCUGSdDhAgkVakqgNDa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfXyY+SqIXg2eCF
 IhWifD3XUDJVoa5BLjvqf1DyxOWQploy68EnVkI7XCxXdcxHOp3JO99mKBeraEVFwVR/IUYVjJY
 8iQ1h59mSAN1lpEo2h+4qwDKF7CpF9bTPVFFubGnq9w9cYEqcHuv
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=10
 malwarescore=0 phishscore=0 bulkscore=10 lowpriorityscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090067

bio_iov_iter_align_down() drops trailing bvecs with unpin_user_page(),
but a bvec built by iov_iter_extract_bvecs() can span several pages of
one folio, each with its own pin. All but the first pin leak.

The partially trimmed bvec has the same problem. Shrinking bv_len does
not release the pins for the pages cut off by the trim, and
__bio_release_pages() only unpins the pages bv_len still covers at
completion.

Both issues occur only with a logical block size above PAGE_SIZE and a
large folio backing the user buffer. On a device with a 64K logical
block size, an O_DIRECT pwritev() from a hugetlb mapping that ends 16K
past a block boundary leaks one huge page per call, whether the
remainder is its own bvec or the tail of a larger one.

Unpin all pages of a dropped bvec with bvec_unpin(), and unpin the
pages trimmed off the last bvec as well. Move bvec_unpin() up and split
its page count into a helper so both sites share it.

Fixes: 20a0e6276edb ("block: align the bio after building it")
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c89a0d5d6e61..a1e9ffd5982d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1197,6 +1197,21 @@ bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter)
 	return true;
 }
 
+static unsigned int bvec_nr_pages(const struct bio_vec *bv)
+{
+	return (bv->bv_offset + bv->bv_len - 1) / PAGE_SIZE -
+		bv->bv_offset / PAGE_SIZE + 1;
+}
+
+static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
+{
+	struct folio *folio = bvec_folio(bv);
+
+	if (mark_dirty)
+		folio_mark_dirty_lock(folio);
+	unpin_user_folio(folio, bvec_nr_pages(bv));
+}
+
 /*
  * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
  * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
@@ -1206,6 +1221,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 				   struct bio_vec *bv, unsigned len_align_mask)
 {
 	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
+	unsigned int npages;
 
 	if (!nbytes)
 		return 0;
@@ -1214,14 +1230,24 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 	bio->bi_iter.bi_size -= nbytes;
 	while (nbytes >= bv->bv_len) {
 		if (bio_flagged(bio, BIO_PAGE_PINNED))
-			unpin_user_page(bv->bv_page);
+			bvec_unpin(bv, false);
 
 		if (!--bio->bi_vcnt)
 			return -EFAULT;
 		nbytes -= bv->bv_len;
 		bv--;
 	}
+
+	/*
+	 * __bio_release_pages() only unpins the pages still covered by
+	 * the trimmed bv_len. Count the pages spanned before and after
+	 * the trim and unpin the difference.
+	 */
+	npages = bvec_nr_pages(bv);
 	bv->bv_len -= nbytes;
+	npages -= bvec_nr_pages(bv);
+	if (npages && bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_folio(bvec_folio(bv), npages);
 	return 0;
 }
 
@@ -1510,17 +1536,6 @@ int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen,
 	return bio_iov_iter_bounce_read(bio, iter, maxlen, minsize);
 }
 
-static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
-{
-	struct folio *folio = bvec_folio(bv);
-	size_t nr_pages = (bv->bv_offset + bv->bv_len - 1) / PAGE_SIZE -
-			bv->bv_offset / PAGE_SIZE + 1;
-
-	if (mark_dirty)
-		folio_mark_dirty_lock(folio);
-	unpin_user_folio(folio, nr_pages);
-}
-
 static void bio_iov_iter_unbounce_read(struct bio *bio, bool is_error,
 		bool mark_dirty)
 {

-- 
2.39.5

