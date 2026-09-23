Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75546D57D
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207836; cv=none; b=Sg8iQCMHoZKWh3AzGSFF6f4wbhJQTSShaKjc6ELrfLhfN9r4MWuKZoGvZ9mMqr+Vs34sunvPVi/3GwuasbhjQgrWZ6BYfyRSNHPKUD+3RsYvPkGL5uj2/yNEBGFz/c6mb6cvIQG6SIrG4jtzNoVattO+D7p4CXL17eE1lyBQGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207836; c=relaxed/simple;
	bh=eekIRUkO6xctJzh0LDxpTW7f45r0xCkvZKYTjeZsvDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MsXf+U/yxIAU+dhnGiGz//nkauZxiLXZLWvHqRQlZS0CwrRQ42FAGH0di4zwx5Ax6TntVtGzB5T9KyEy8K7BvvUi0t4ipX+a2QF8bF98TF1pIz5bmDstYwYIAw05a+p6XTehBxhZuFu3S3KuwDuG3MkMqMVKjWT06zfmVXLiI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZqFevxwT; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=j/LlkV3F; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZqFevxwT";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="j/LlkV3F"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCnLm1939789
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0qoQ
	93CRiLkSb7/te8GPJ2ac6VSP9fU3H03z6ipMMtI=; b=ZqFevxwTcBbyDpOcLaW4
	mO9UrX57vPQn2xrd0XPJ9Z/fmWZjTyXImQ4f0RMylBH3owoB63T3ReRghrAXhmvK
	pAJY+eZBp8Rh+Kf/7wzUt9i/X66+G+8FlSwTlXdV0uPNGgzqQ6bpRkqskKxvvLHg
	heXoLcS7GBtoeGRJkCLUjYhnFscr5J1x830G6jjBOhPWGeQ0oZux1U5m7CSmLce5
	hnKa61pnOiJNKXrbWkDcqVl6ujHfk9URZOe2bPrl/8epw/fLUmbgNULiLIJ7KjdP
	Gpe+rzcR5FYW+2i8fTaU4WiLldSMiLNo6wVrF+hFoSd37ZNgMaAX5wIoR5fukObL
	sQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvqtcrbrm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:06 -0400 (EDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so2232323a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207826; x=1790812626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qoQ93CRiLkSb7/te8GPJ2ac6VSP9fU3H03z6ipMMtI=;
        b=j/LlkV3FNwHLasYq2Udu/KizgIKx0yBKNowUPtf4pozk3shlQV8b2j9AzrIDzcDxLd
         0kB8mqDthQpQvjiFz/5MpUdLUXKsY10RRnsqRnAo7oTbO7Gcr2HniyZJI1HdNsqIcSWx
         DU88bCD+i0TlWZ6CcK4NZe7p1XxQcKpgaZmSKKZxv4e5SYmtjlaode2aYycLt/fgiQGu
         lj1fmh4VqYJR+PWgzXySpPQHd+QZsIo+3+FIfeMxk3eEy3AieBCE5nV4Rf4HEsv2aQLb
         Sc46DLEC1E89Ch8BpFWDlaj4MmSo/2SSC6hZ+VUm4078+Vv1kS30YkzBo8XpvrxSuaa9
         b/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207826; x=1790812626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qoQ93CRiLkSb7/te8GPJ2ac6VSP9fU3H03z6ipMMtI=;
        b=ktqN7ujFuXRchHpPVmyYhhtDRJ8fDcZQn4pFUkfsP3tNRrlff++/AlkNON0UDsJd+R
         vnKMXe6yg4dbTJzlFZpEerIRlYMgjffOZkOgCMMjKZ/ax0JqbYCrJm96Ivl0/mjENUxQ
         aI1yoiSEBl0H0yvrQBwhT2QxPsiQsfO0B8w9w4KxQY5Zm+lL+kR52qdCru8p3cQFos2H
         n6U+UXSvH4nEwfWkuOYQt6GIbv0uPvG2l+T3s75fGbR733xuW/hwGcRFwLIgxvh557ZZ
         fExdT2vvmaNjdZh/JjTszxWPaT5fNKJPipJxs8ABqJX5eBnS0R6HdBFyy82OG26rYswv
         /v8g==
X-Forwarded-Encrypted: i=1; AKwUvBzs8HJWWgmLLwZxheXlH4II2Ukmwoc82d12uPpb0+BdOfjIj/TgF/IgTefvuJqvE6Y0BWn8GAjR2lUkFscE@vger.kernel.org
X-Gm-Message-State: AFuF++nQDwussXMINx0tpRTgypKWE6Hr1v2za86HwuzPAFLpiQiaLJoF
	t52ySDb5zbSnJBPfjc+MnnZiHpjdJF2RO5rYyUC8LfOmfCHARNF4Xj+UjertjiSEmr8p8HdGKQV
	CnM1C5ZcC+4aD/SxqwtqxS0tCmnfQNpZUng4e/cjtY6wLrMvzY/5e5/m623FwU/s=
X-Gm-Gg: AYBFou1OerDt3QYmmJjmohmVqiwwBJNizVqBFkqynniqWZZ5rZNmWZXVE4+P2W5OU2d
	xPf+K7WdL24/qXWEVrdG24Vchcj05a310vASkaqyu/nuXVkO/NxZ5/N0kWyBjNQ4UmMlfadZcpg
	ME3ruSzlPAw6Kg0jhEsr+YJvRsOE8cqQoqzPMMkmTPSVofFuzdwP7qrzEGFof9gR7LiL4H/Z++k
	FY6Z1Jfwn6WG1id/X6F7i9vowndh7U0j9fKeQJ8VdQS8kIP6xSzt4FD+Da5TLan/rEfrVHrTQdh
	Icu0LOktFDYmrnho6tGpPouIesR6sYW2c+DPCr3eqB2102YfR6R6dOg2DJpWQGPsanckQyqqfcI
	EBkerUQ59DA/iY18/4XHy4QM/I5mz61RAxxtta2Q97uw9xQ==
X-Received: by 2002:a17:90b:1c92:b0:39e:6c68:c77d with SMTP id 98e67ed59e1d1-3a098e0515cmr614674a91.51.1790207825689;
        Wed, 23 Sep 2026 16:57:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1c92:b0:39e:6c68:c77d with SMTP id 98e67ed59e1d1-3a098e0515cmr614654a91.51.1790207825215;
        Wed, 23 Sep 2026 16:57:05 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:57:04 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:40 -0400
Subject: [PATCH v5 7/9] iomap: reject atomic writes in
 iomap_file_buffered_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-7-89e60d66eb38@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=1162;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eekIRUkO6xctJzh0LDxpTW7f45r0xCkvZKYTjeZsvDw=;
 b=2YSDeglgyk07rr4XCceLzHJrMpahC9wn5HyPBCzFyGWpB4A7Jm0LwTpK53X+wg/uOg2P5jPVn
 EO951ZjrUh1C4yifGSMaj539bji3K60vVy92ozbmJFDFa2hZoDofx44
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX2FxpcU5BCbUO
 Kl1x07BOPRUFL9UG7i48ZPips6HREpViwr3z5hA58PfZSV3s0kR3q9sQCAV4n+4lLiK3nUzsW60
 +QpLF6rANPxUi7o9DtxzSlYSsUwCCQ2udEdq07/zs8McB2dowaPH2wm5dmJNqis9lgRbFRoVR8F
 4SvDdohDRT2SlND5gUqGJ1aei2WAluZXxrAfX46xpCSQXzmcQOltwydrqVUPWSLtxaTHrKeB8F0
 HSPEKj38elXm0V/we57PZ/1NfDCFFeEpE6m8H6a1k/NpiSdqE/LnkUuVO33/UQeqDqs29pndsk3
 wfcqaF6G2DTT/DfGCLHTrm4BSnrPbKPFIUqhFfS6KLQYfv7AoE3rvEIwa+bOwZfAyWjFKDaNDLp
 37GZcKEBg+TrLt5yMMINMIozY8dM39ho8FgyX/Zm2kVmoLLOJKL/KmlYYo4hvzKgFqOiC2hGXy2
 XBEANexI6ALtFGoBcMg==
X-Proofpoint-GUID: RPLLxaEJm1IQmCPCIHUZ8jxjE9YncVwL
X-Proofpoint-ORIG-GUID: RPLLxaEJm1IQmCPCIHUZ8jxjE9YncVwL
X-Authority-Analysis: v=2.4 cv=LtYHWXdc c=1 sm=1 tr=0 ts=6ab46752 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=ASVHLkjgWNnnwhGXR8EA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX/+SRS/GXo/iu
 xFXYagjnk/m+knBnLImCAb73d0C7mSESQ9D66SRA/YxWBw9mcn8lbrXlSgNENE0zw3g8mfQnUdq
 fBcrb+8x3y0Wh252ix80Du5AG2rsA2+tYxBHyCHwyemPHUC21OBe
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=10 clxscore=1015 malwarescore=0 bulkscore=10 adultscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

Buffered atomic writes are not currently supported. The page cache
writes folios back independently, so it cannot guarantee that a range is
written atomically. iomap_file_buffered_write() does not check for
IOCB_ATOMIC, so a direct write that falls back to it would complete an
atomic write without atomicity. While no such case currently exists,
fail IOCB_ATOMIC writes with -EOPNOTSUPP, so that a future fallback
cannot complete an atomic write non-atomically.

Suggested-by: John Garry <john.garry@linux.dev>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/buffered-io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a5ebfda90f1..e6654cfe1cbf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1304,6 +1304,10 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 	};
 	ssize_t ret;
 
+	/* Buffered atomic writes are not supported */
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return -EOPNOTSUPP;
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
 	if (iocb->ki_flags & IOCB_DONTCACHE)

-- 
2.39.5

