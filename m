Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A347DD42
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207838; cv=none; b=p1Q0RD//TSUQezpX9gFakPv5INo4xAeOvLndHoq7LmynD6IiCmXkk7Y/dPzPeCvdrhDLVFy14+4FD1YIG6JYuaA/DeIx0WUGjHmE9mGpdIRttx8aHa2frzdjjEJxGc8E/CmCkKdDAUTUMaCQZvUQMWzk/kfSkO0bZYVvpAPuO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207838; c=relaxed/simple;
	bh=X3wzWg0roOO1ptF7ZnClA9IB/TZQgfMHMl8KC4TDQ/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vg1VwHGSpbYYeT/THKE80XIH3b2n3IOz5v9Vb+rXPdrzMgA0WUtplZcgm4fRjvWGPNxHAnU2OlJy0pD+sJoKcadyAZX0ZM9j8ggbIFkleSQLtUc4Blzgiu7IBbdEkfr2f+7ObpWgkp1/vyYKniBSlTnvQO2ip6vXtQ0qCGvamQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Z2MCRHl/; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=c6cIKits; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Z2MCRHl/";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="c6cIKits"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNDGIZ2934275
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=n4kk
	5mXgXhks+NNWJaLVIMvxQ7me08UQy0+SMcJDZMs=; b=Z2MCRHl/vKPc2LHq6tNc
	XiYQw6yOkzNTqDAp9gtSovJ+djDIR3yIu281WzCBIw4w/sMK3Muaqvq1LRmKhXQi
	DtjBf6/AEDdzb+NfGS07pop80K3LJxY6DsdPJ+tqhOh0DDvx5BSjUCpUKV3z/VFr
	95l8DwW75vkML3Uth12IMdTz3+vDwOY8DYG4qqR3LyQHyzOf06mVk3Jjs4eI8MSk
	aIHlLOV1H7BmPnz2YPW5KJiqDiBc/26ruL+xDJXiAoTlByG6IdSSlCF/SrcfSAgm
	pdc6gzxfeNofkDGwmbuHljjPtrXokS+tZtR9Qjdlvb1lE6sWRgTz7JsE6QJUqFc8
	nQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvh6a4h5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:07 -0400 (EDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso1979874a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207827; x=1790812627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n4kk5mXgXhks+NNWJaLVIMvxQ7me08UQy0+SMcJDZMs=;
        b=c6cIKits6iwQFGkTJ60ZxJN6j3pf3uceVMo/ZtV6fdV2Ad0LUdS16FL5ywz/IS/0Kl
         +jSzhMrLzLI4RqbXFTS+dQ2zpqoRHRXsPocgDSy7zxU0R1EfbmPUDuZMyLTheZbaMGv2
         KZezOqg0/Brwlu0TPCwygk/W4utF5WzuwDdDqvm+y//4bzA2mNqMJJczw68iUtHgmTim
         2V4IO7vreo+OzAIKc49bvnQ9xD8AiOtSuQiPgy498DTmEZHITB+j+OTdRsGGmHcZhXVi
         +YHcA2VOZ2vmbGr8HDnHYJjm+tLdWl6zmXzeLJJkeQzgUYvF9c7S55NvRDsxjfL1ZhA/
         BKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207827; x=1790812627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4kk5mXgXhks+NNWJaLVIMvxQ7me08UQy0+SMcJDZMs=;
        b=Gsq+1AVptCEZqlLW6vl4g0HxsWgUl04HSwcrdIg2zcZVL/nBwrKUEc2xOqT6ubWtY4
         tWMXKG3CwU+B/E3jC/ImXNAppr0zw5hZLG6wN/jtXP/yWRvoFTkwW5iu1iawcIJx+lTV
         yA0czXM3RSjGOmxJmkHZ5BiuZcAlsxCaROsEchcrL9rpCJV3vRd8gDltPkJcUZDlCX5g
         Y+iZcXX+DvQnH4n8r8ln99NXhJZcrBEQRdb2u+LYZzRQG7NPq5b3vST8WnWKLDYYCgq6
         zGgfn49y/3PytSp3/2CoVmBEZlVpnmL7nQ7vUAqqssssaucl+hH8yx9CJaZj/TG+DJuR
         DhgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR7bsA4zO/9adpv0pW14kO6juHQVQz8EL/azXaNVp01KWXuzbmPUIUGnIvA8HpV2l5oBfQ3JJA17ouHET6@vger.kernel.org
X-Gm-Message-State: AFuF++lmxUPtg+FNZquCN9QJuWI+5/fUAAt2iME+C9GsoXYF3i8s90kz
	bn09P8oSI2b0toXcFsrgExEXgLr6x3r0i6iWtUE4ybO/sjYTwGl4i/97cUEJOE8T8MEaKlm/i0Y
	SaYAxjCxK551VK9VDzvnAc8xQXwrwS6egi359XA31AAL0xqP2u0UJor0PHzHE4P4=
X-Gm-Gg: AYBFou05ELsILwOG03JLD2+3ovpzk+Z6cICb+4jL+XD+0e0gpBSMdoxajCNUQ/vG0m3
	N6XYZh5VC1nOUwyVPk4wpulZPt13RN6bnv1z8VbBHiaAG1baGrXAO16pe/4aiPfFoYCvJ1lTnk+
	+bE51taR+JEwewEpH8BBA5WfK7gLpns/arm85xOaNjgr08BC3oNnhCnMYrm1vt3MU2rGI9BZ4Zn
	JEY23gG+l7kxHcx9jG6QhHxoXdo23XYVt2dG7A5Mvti4sUtUkXryipUg6jGMvE294CmhugSR+wS
	tTQ+meWhArrTp1G5LsQ2bMVjkUxaJNiiVG7NckmhwWhIda9ZcEc1R+atAyzOWLnofwiMxjPqkBp
	7WW9BldEHLws3xxRUQqcDpB6SckgwcpC1ITZ27A1/e7kSgw==
X-Received: by 2002:a17:90b:48c1:b0:3a0:4023:bb09 with SMTP id 98e67ed59e1d1-3a09896f0fcmr599643a91.56.1790207827101;
        Wed, 23 Sep 2026 16:57:07 -0700 (PDT)
X-Received: by 2002:a17:90b:48c1:b0:3a0:4023:bb09 with SMTP id 98e67ed59e1d1-3a09896f0fcmr599623a91.56.1790207826584;
        Wed, 23 Sep 2026 16:57:06 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:57:06 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:41 -0400
Subject: [PATCH v5 8/9] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-8-89e60d66eb38@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=3797;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=X3wzWg0roOO1ptF7ZnClA9IB/TZQgfMHMl8KC4TDQ/E=;
 b=g4+/LTObucWvEWYZXfmJp4B6cmRKAbNTyAz0wKbmoGjCkzwVFz7bDsWDkVVnaWn5uqvP88rn4
 zjtaC1yXvB/Dk3xu1zozB9M+ot0fQCoFlZVvmBYL6IjksSdLpbLuexF
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfXwPssXC0k+C4X
 OhMbZlmjmuWk0nksq2v9CwNWu/L1TV18DPYqN3mN6aUQL2xBr8dWRRIwFVtk3E2rOJWLBzLrkqt
 EhEzaPCpDDZM1O1tvmTg5xNLTmqnyjzjqoXJClMGojqgEJfia1TX
X-Proofpoint-ORIG-GUID: PJf3BFo5Mayl-47p3J-BM6EnVaSMypNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX+vOc2yQDkjMP
 P/4OBDXpIhn9pU7dxYjxLIYrbqcUdSwvQRm14q+6TfZ5s4n1wrINdCiN6H+IQnUbCp6w3dwsrUm
 nLQpldkEdb3OpUbtlcWWiljHigpqkXrG4PUHFUa8oX3Od8WkzvTcpORClxhgVGkfAd+Ujc+eDwj
 n/SIpG+0ldreNs9zbr3mF1XFzzdqC9lP2p6ugQLRXu3XSA5jvU9+uR3Gmhx4sLZ/QuSnQM/eCxd
 DF0dJPz//rT/GpZz2nK7IKJGVtUVm+LfaLfXeRVISUbBApxFWoicgQbBMlHR43hVgK3TKfYch3J
 Jf5w6vweWwtB50CtnUeZ95bYaB6nRGYG9mrLb6RszwFM0ZQPHWgOZItQfsB//CjL2Jox1RsrNN1
 SriJ6SM1rspFOzsBaHKEQzhyOkYnVcnljOaN7DwpzPopAfepx7NN7fF1MFK0oQXAVcaBItbzvlT
 rDN+VaP4hgh0S6v5H5w==
X-Authority-Analysis: v=2.4 cv=D6nSufRj c=1 sm=1 tr=0 ts=6ab46753 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=FzqJyQ6YvfuMctRh2gUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: PJf3BFo5Mayl-47p3J-BM6EnVaSMypNB
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=10 clxscore=1015 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

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
index dff84c0b54bd..50b9f303c351 100644
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
 
@@ -1503,17 +1529,6 @@ int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen,
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

