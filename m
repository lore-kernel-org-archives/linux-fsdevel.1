Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF43A4502
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689754; cv=none; b=VDKc6wEtGe6Gff0GOB8cQKjcwdekmXjoVbTw8HKr4WwCC3BziR/O6QMPSjps0ozU8od4efu8oSrwNdJjhhJhoxpufcwsydVMgFES1/TOiuqiaPdFULrsy/KKA6OicOuibHKMYoj3r+YUkw8mcMLpD6dcj9sf/aopj4rolVpzf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689754; c=relaxed/simple;
	bh=vqYjVe4t0i/AiFArpSZ9mEXLlU4rnE2ZRBBMSnozEZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PE9yb6q2E5YqOt/pUBnTgzgpy+HpUmfbr+7xn4vMO3Vkhd84grWH9V289b04rEBS0DeItC54AaVNwCXTIYPq7o/caOhV2IQ2RNftOzJmwrdjs5ytP3m8MhyRzpJ0AisBS05c1OQHVEYp5VxaWtSLp4RZb2xBJUXEEzt+m2KvrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=sX/DybFo; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="sX/DybFo"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638MtsNT2293497
	for <linux-fsdevel@vger.kernel.org>; Wed, 8 Apr 2026 19:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=S7NO
	oLpQC1gt8jjGEOFARMhStqFULmtQPTxyzd8Tw9E=; b=sX/DybFoA6nPq2/fiQXH
	P1m4akAquZ6v2+LHTPlMLkgavf+yG/DxaGshLuCrqSsAX1UsI7rsFWWkC8zKyt6R
	o1zyLIdzrtyjaUXfI/1+JiOR3R5ucwVnwPjynyuQRSoQwEj65c1m2riCbuU9eaVi
	EDGmL0+83ljeQ52xYm3+wL9pa6Pera34PDJQGRduG35WlqlTGSk2lJmjjpiHpzmk
	inX4NVoEK2SBuy2TVftA54Yy+kkL09FQ4K1GH0WO50Ld1C0sRhaPuvjbAYxv144V
	+0qQTlQqhrroAD0eG8b9WPI88SLci48x/PbC/hNlpBaytb43vk9WRZs4dD0UUI5K
	Gg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3mgu6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 19:09:10 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb706313beso22000285a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 16:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689750; x=1776294550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S7NOoLpQC1gt8jjGEOFARMhStqFULmtQPTxyzd8Tw9E=;
        b=ZWYXxdl4g/55nBkuE0thG7fp41M7B/jKZvxaxgN1CcOSxk+H46RXLSDINdUWF73UIs
         MYjPBPWWvrQOnBBjYYFDsNaazg4smmhBTXRWZtEJxxTKosMDt/c2atFis0CaZiUAys5k
         soxn+ww724jj/zhUxO8RaDWCKuq2bJnCCrhdDk/rnaaoRXaLZHlWuxHhmMu+c0LmXuLN
         pAzy98IlaPooehTTxfldSCBcBES9P2DHLxzBTFyjBcCnCahOcU40+PGcpRZ04EXkLiwn
         kbG+H+KT9PknC+6D5Vtlz1Gfu3xkD353/WjOJSCtSdtngPPFgGM7NV0AKYFLr0Vsr+T3
         FttQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaxAu6VJscqDR3waNFuiddFOKC0uZ2CstUS7hOyj94P6MQFVxBYqDZvgt6TqqYvfQHUiLTwfC1sdShSh68@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdOQOEUgjlOW1n2fWtu+qPCB75Hh3aSTQDfNsckrY6uH6etcL
	+Du518xH26l3HiC9aRk6zGz7OYacuXix3uf5vdvaRE7VF9WedWwByBJk15E5JQOoQ/YfJsqtUKi
	duCNR44EXgcshWiUyJnmdIW3vu73IJLXBggVA6YbSxy9AVRN6wTJn59Me2zsiZAI=
X-Gm-Gg: AeBDievGdm6RWqLewQl5YhWrXibR7xUCQdgjtW1WF1njJZkWY9Nuzo1Uvu1VwGUjm73
	KPn6gvJyIP4zvTCk0rJEL2M6f46woLpx52ASNF5gB1nyHBjoUQwpz20IeLkIeautZC28UtBcYa5
	sWXBdryEzVBpqR39W4yVzPlOmdM2uhaqNvo/IC89RI5dRwz0H8NOYnWbeSlr2QFhNzrxxE772RK
	/R4Ni7RMYOYLHFItmSy6zT0A7TEThwjWmfCmelIMcOTVi5ThLzUeZF7snksiY8GXtVnHTSpcJWm
	dJ7B59KTK6Z7aWQD+5PArBpdQvKMqvXuHxxMLwc4TmgckWvHHu0+NhMP5zy2slFwqB+l03XAuhx
	Okvh5NllVbI3tqnvXlhQZVPeL5TLN5hE4
X-Received: by 2002:a05:620a:2848:b0:8cf:df8b:1e5e with SMTP id af79cd13be357-8d4185c9512mr3194927185a.5.1775689749864;
        Wed, 08 Apr 2026 16:09:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2848:b0:8cf:df8b:1e5e with SMTP id af79cd13be357-8d4185c9512mr3194922385a.5.1775689749261;
        Wed, 08 Apr 2026 16:09:09 -0700 (PDT)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8dc1514d382sm125665485a.4.2026.04.08.16.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:09:08 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 08 Apr 2026 19:08:51 -0400
Subject: [PATCH RFC v5 3/3] block: enable RWF_DONTCACHE for block devices
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-blk-dontcache-v5-3-0f080c20a96f@columbia.edu>
References: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
In-Reply-To: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775689745; l=4833;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=vqYjVe4t0i/AiFArpSZ9mEXLlU4rnE2ZRBBMSnozEZ0=;
 b=TkXe1cDpr+0h2BcgYcYMwDXJ9OzGkB0Fsjl6RdOUbuhHuLsFpdpyPcESqIE4200vy+eNNs/A+
 038SUVLSqekBHFqdXjGfViao6J1wkhHyywZ87y01bw5yaC4bwnIIKLF
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: stmSBrj6p2XGy5oVL5QnCZJ_GS0iTbKp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDIxNCBTYWx0ZWRfXywv3/VDCHLvm
 V6Ypn81oar7R7EwjTPlDAiNN2OqmPd1eM73vmx13vSSE6NrCHupNlrtv0dr3dmGnaWR2BrpGiin
 GjRGfnGUUEHWtU5dLekxl3NKcD/vVBe90zHkRlZ3UkcT4ayPBEoNCUQ4XDxeE4c61z3GljrTlc3
 3ryrbZ60zj9Gb13dFSUzELCuGc8toShFhr34y2wTNbfbMMI1ZfUa5IOu20zUp8lLkrUg9To8SJO
 8mdugxnFUxhIFmnB3Am/0SjFb+qG6XVskqhxBjCAohEDfnBLN/c6eLMYy4nRiafU8ltPSRqxiuY
 Rq/HHlcN4Jm+Wqjv7LvCMcvhDx33w8oQoIed+zgfTWk5FwCQ8ewJDgSch3KlUZNB/F8hCf0Ad0i
 27BM5kc19amcOVTI4rNbne+2F74BIGalLV+jiNz6Y0EueiRXNs9qBYykXTC0c6DXCxgOB7BWRWQ
 geCz0bJfpXCogaTkeAw==
X-Proofpoint-ORIG-GUID: stmSBrj6p2XGy5oVL5QnCZJ_GS0iTbKp
X-Authority-Analysis: v=2.4 cv=X7Fi7mTe c=1 sm=1 tr=0 ts=69d6e016 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=KmSSIXLuV57r0wwE8Y4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 priorityscore=1501 impostorscore=10 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080214

Block device buffered reads and writes already pass through
filemap_read() and iomap_file_buffered_write() respectively, both of
which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
by setting FOP_DONTCACHE in def_blk_fops.

For CONFIG_BUFFER_HEAD=y paths, add block_write_begin_iocb() which
threads the kiocb through so that buffer_head-based I/O can use
DONTCACHE behavior. The existing block_write_begin() is preserved as a
wrapper that passes a NULL iocb. Set BIO_COMPLETE_IN_TASK in
submit_bh_wbc() when the folio has dropbehind so that buffer_head
writeback completions get deferred to task context.

CONFIG_BUFFER_HEAD=n paths are handled by the previously added iomap
BIO_COMPLETE_IN_TASK support.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c                |  5 +++--
 fs/buffer.c                 | 22 +++++++++++++++++++---
 include/linux/buffer_head.h |  3 +++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 4d32785b31d9..d8165f6ba71c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -505,7 +505,8 @@ static int blkdev_write_begin(const struct kiocb *iocb,
 			      unsigned len, struct folio **foliop,
 			      void **fsdata)
 {
-	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     blkdev_get_block);
 }
 
 static int blkdev_write_end(const struct kiocb *iocb,
@@ -967,7 +968,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
 
 static __init int blkdev_init(void)
diff --git a/fs/buffer.c b/fs/buffer.c
index ed724a902657..c60c0ad6cc35 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2239,14 +2239,19 @@ EXPORT_SYMBOL(block_commit_write);
  *
  * The filesystem needs to handle block truncation upon failure.
  */
-int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+int block_write_begin_iocb(const struct kiocb *iocb,
+		struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
+	fgf_t fgp_flags = FGP_WRITEBEGIN;
 	struct folio *folio;
 	int status;
 
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
@@ -2261,6 +2266,13 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 	*foliop = folio;
 	return status;
 }
+
+int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+		struct folio **foliop, get_block_t *get_block)
+{
+	return block_write_begin_iocb(NULL, mapping, pos, len, foliop,
+				      get_block);
+}
 EXPORT_SYMBOL(block_write_begin);
 
 int block_write_end(loff_t pos, unsigned len, unsigned copied,
@@ -2589,7 +2601,8 @@ int cont_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		(*bytes)++;
 	}
 
-	return block_write_begin(mapping, pos, len, foliop, get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     get_block);
 }
 EXPORT_SYMBOL(cont_write_begin);
 
@@ -2801,6 +2814,9 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
+	if (folio_test_dropbehind(bh->b_folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
+
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index b16b88bfbc3e..ddf88ce290f2 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -260,6 +260,9 @@ int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block);
+int block_write_begin_iocb(const struct kiocb *iocb,
+		struct address_space *mapping, loff_t pos, unsigned len,
+		struct folio **foliop, get_block_t *get_block);
 int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(loff_t pos, unsigned len, unsigned copied, struct folio *);

-- 
2.39.5

