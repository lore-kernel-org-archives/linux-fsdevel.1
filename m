Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276F38E8A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395220; cv=none; b=XjtkeTAge7RzhMiez3DQxneFpN4v/8j6ekw/og2YrIdJSMUgCUbs8JmmQ0OS3nI7puZVZLav9hUTpMoWv/71vJtw3yxNkAeg3hvQcmO7lsegMIPGqtF/Q6EZ3G3m91ElhooWo5YfwisrP7+6mQL/utKzOP5pnj71kfTpKFPL+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395220; c=relaxed/simple;
	bh=hHCEZENfCfsEpOmC0wBfWJMFm3C20nG7DjOTxirSTUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qb78tXeIZEgttgDy+r4KFRw7L/FTviJgOcTSt2BrKxew/PKXDGzpRTu70fFCnwsZ4GHPf4Q1CxqER1bYpRnffeO3rBPr9+FkwmOJIoSAjzuxMHdiX78zD5HI2VsfDIQxKyisjChAiQvfQTTpuKt+FMoHnxz/CbrsNk+pKWj+jpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=hv0PcEo8; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="hv0PcEo8"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6x1c91935047;
	Thu, 30 Jul 2026 02:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Aj3+
	ozneKRFxvyRKEW1x+foEkavllzfM2NqbtLKj8IA=; b=hv0PcEo8AAPDJ3qmRsyH
	3+KWRKhUuio5bu6v7AnsbOIMwgD7rZbWuZCbxPJ8NOtDT/6jnTzUMipJ0mF7QfZu
	3vHsZW0WXTeqgG2leuJy+YHuFK/7Aze+PS0kNPRJ77w6BASuAor/BNbvhZ+06gWE
	lwCff028FYqKbvLsbLBzqyFKUem7txf57ogPxPRAOr5qdW2T8loIUHnw0K1cQz09
	7P9wendgVQQF2uUVmf24BxrK1lwd44WBWwC/SjBvLCM7Ae8WAwMxAh2mgghG2Jea
	q0yZqxPC9eTBItVbYtNcMTqXiTV+yoGFDSs/zzZjapWZTUnHFT7gf1vSP1LKyFZq
	dA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqud416pb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 02:59:01 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e4f27f49bso168951585a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 23:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394739; x=1785999539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aj3+ozneKRFxvyRKEW1x+foEkavllzfM2NqbtLKj8IA=;
        b=jQGL4iS5jaKMPanMrKwVZ3WEqUmAwdMqyZqLQ1LwZhVvrxxbG3cZ5pCANPAcKNnH53
         qRNlwOk3m7NbJ/obXPa6a5ddqKzScOEXgTpvVCdIzGc+ye4bdKsuhCYGv6tIUwkbelVK
         Sni8CKojsQVjfr0nz1JgRpvKGvYDTCf2ANHAbd3MOnmL4xeiuSOtB1nwtd5vkT3F3xLS
         fTcczBaRHPPpru3+G+ISXRRX0wub6HcWkOteU36cCaZ1o4oin246GtNDa6yqXUOo11R4
         Nx1UL/RsdH/1TkBUIBOPD4gvGvDZXMtpwlfEb9gcuhrZO/tUzvTbWPsInxqPHEkwa0l0
         42og==
X-Forwarded-Encrypted: i=1; AHgh+RoVZOJqVJDkgr3814u38LLHYL4J7qlLDNYeFBECPPNh/Q4M9/HGqKPYnXLLky9jsiuZRLLv07pklk/J9dvR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5jIYC9AjgYku6u+kzfFOSClZ5xRN9tucMPwMaLKuYPZxpwDs
	36p06ktg/0Taod+wG0ez0jl+AN6jPhNTrD61Jx4T+w63GHWTkNi5pVa6Vzg/La7bSTwyMPf45cC
	JcpJNKqMsFZxQTFvdp3minMhRcvEa+4d41h9CPaMxvFyTFK1IEQprRu+Qin5kFo0=
X-Gm-Gg: AR+sD10kqT2Kuf9ISqlMFCMc/bvlFptc3T7SFMf1N0SgUFNWE7Cfzzp7YyfDA+FGayO
	M869S9J0+CkIJVIYGJcnbn/rNyZqc0JTimt8pmBh70mOVY/JLDg8ibFd9J8YqSS+iyJ2khD1n9W
	pazD0y9YYVLxgB2Igfko0qc114GyGg2q+s7GDqInVM5+mTFK74aDEQaeQbtvzRfqjw0aMYzB/93
	D1bXMobD5I6D92UO9ePGR3Nl5/5dI2m1iJdw3LJmB6vxt7Ji4mDd/Hyhdeuxk8KGcnQIsCnLCrU
	v9otQYq7neSiDzumfe/H53iQzNm7RZl2dFEnsyjX6rIRcDezl/MEtHD85KWPS/4MYi4WsN5Kx0S
	9YaqUx+UVJb4fChHw6LdDNG6j0iX5IRTkhRy6f2XRsWBTKw==
X-Received: by 2002:a05:620a:3709:b0:930:f852:6daf with SMTP id af79cd13be357-93487207b6emr145583385a.87.1785394739078;
        Wed, 29 Jul 2026 23:58:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3709:b0:930:f852:6daf with SMTP id af79cd13be357-93487207b6emr145579585a.87.1785394738610;
        Wed, 29 Jul 2026 23:58:58 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:58:57 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:51 -0400
Subject: [PATCH v7 1/5] block: introduce bio_in_atomic()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-blk-dontcache-v7-1-3e8e6850068d@columbia.edu>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
In-Reply-To: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=2716;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hHCEZENfCfsEpOmC0wBfWJMFm3C20nG7DjOTxirSTUU=;
 b=0SI7Xl8K46e0uZlTQGRMH9PF2VforZ2ADnod5gEhiUnACnwVjnxh4x+kTnl1qD5D6oyl3rPbF
 pLBs0BjnLHtCNXNT9pp0MnVsyv5sMsoS/rOivi/TnyaG9EJUxZTJlIh
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: D1p0pdNXDM52_52xEyk2TRsRyFFmR39U
X-Proofpoint-ORIG-GUID: D1p0pdNXDM52_52xEyk2TRsRyFFmR39U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX8n/lBi1Rm2GW
 ighFbrnO/G/KmAwCIqkpHI18NX33Vw2aQjledVSw42AxGN5zfdRGLJTYdsPohaRnEsGLx1H2Poy
 Tz0OLSC4esuHY25vnU8SuxbAx9eWxOLQU4hKU9JIKT10+3JVQkZN
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a6af635 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=JfrnYn6hAAAA:8 a=i_Ns0s3d_2HFdJHkmwAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX+U33px/H5tRZ
 r6JTOoPw1aAdTxYa1bsFIfBJjdzgczc7hD4DaiIZFdC9Dw9UpwALT3ZnTau3n7RI7bxKg/Uu8WL
 Uom5Kcc8hgB/N+xU2z7TPl4EKH6d6NQVTGKbqEaWviCyHaFQVgirUbFa9r8JwOQs/YdDI1lkW9R
 80ReQeiFBA1x1EBPr6mM1tLJklvakCHHh7WrJ3N2NMVuS+V5+MfAaZIVhj61IPN56lQeNi5BJL3
 54ZMqIhrF5myPcWtyQPdoxWej/5XhXtWoBnq35kpt5PuLwPXpRxPS5glw81w/DQfNCKqCbHd3yC
 dSyyjQ/NBAv44mInm9Spg0daPHfjrFFHdZapOpjNnDUgCBBF33yYrxBvcLHq06e7F9OAiRP9sk3
 bkY++q93uWUCyPA4LIA3idxlhXDDL39QLc7luGUR85BrqomCIyhXzx5/GGn1ERnaWKmQR/fFJ3+
 y4HsiWNZ/fm4tAlfONg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=10 suspectscore=0 spamscore=0
 lowpriorityscore=10 adultscore=0 bulkscore=10 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300048

Move the atomic context detection logic from erofs's z_erofs_in_atomic()
into the block layer as bio_in_atomic(). This helper returns true when
the current context is unsafe for sleeping bio completion handlers (e.g.,
hard/soft IRQ, preempt-disabled).

The logic was originally added to erofs in commit c99fab6e80b7 ("erofs:
fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC"). A
subsequent patch will use it in the block layer's bio completion
infrastructure, so move it to include/linux/bio.h where both subsystems
can share it.

Convert erofs to call the new bio_in_atomic() directly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/erofs/zdata.c    | 11 +----------
 include/linux/bio.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 74520e910259..f796bb3ef53b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1427,15 +1427,6 @@ static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
 }
 #endif
 
-/* Use (kthread_)work in atomic contexts to minimize scheduling overhead */
-static inline bool z_erofs_in_atomic(void)
-{
-	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
-		return true;
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return true;
-	return !preemptible();
-}
 
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       int bios)
@@ -1452,7 +1443,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	if (z_erofs_in_atomic()) {
+	if (bio_in_atomic()) {
 		/* See `sync_decompress` in sysfs-fs-erofs for more details */
 		if (sbi->sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8f33f717b14f..62a983758e09 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -368,6 +368,21 @@ static inline struct bio *bio_alloc(struct block_device *bdev,
 
 void submit_bio(struct bio *bio);
 
+/**
+ * bio_in_atomic - check if the current context is unsafe for bio completion
+ *
+ * Return: %true in atomic contexts (e.g. hard/soft IRQ, preempt-disabled);
+ * %false when a bio can be safely completed in the current context.
+ */
+static inline bool bio_in_atomic(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+		return true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return true;
+	return !preemptible();
+}
+
 extern void bio_endio(struct bio *);
 
 /**

-- 
2.39.5

