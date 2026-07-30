Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677238C2DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395218; cv=none; b=l8fGb448LNr9/4JiyXn+msw2RBYYOCyCRoD29zN85+OzZ3etKG7Cu5bLTrBt+iuCZIYS08gCmo/LPsU06TEDUhBaI4HIOHbJKoXUo62dD9FQ23qqESfkX76tvhuXMsEnIXhlAlmDYv/ug7qIAKNVbBU9u3EbVeeOmkY4WbHwrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395218; c=relaxed/simple;
	bh=ZEoFDRdKJkaZHcFnJ/ZnxZn4DtJcz5dwb/qiVw90Hj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9FAGEG+6E70nqwiBnCr5Vs2jLTyYXd2KxzEOFAU6dH+SqV2dEhrPR8PuUvnmsI+9m1N3CS+kCTrsVjTLHkggu43QQA3xyxgbRnlABiDNh4sQcmpPVTIfWEI7APLnoDO8vmNEp27CBqIfEnzLOmadKVY+ypyJ49/ffiEWOH0b6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UCAOFlRP; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UCAOFlRP"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6qMGa1801161
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 02:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7lnM
	AQUAxGl0d0xuPXIIpzK+l0m5WwNxFhJZwOOAO20=; b=UCAOFlRPJWowBl3rU040
	SwZ/JO6HqMmh7w10K/pEOvfmU0vwubvQfrY+WMvRgG4Sga5moOoHKNyIzkVd5Dzu
	jqfahkydSebUt3mV4LY6uMauUWmZDaLaVG6DJ8zuquGQHjwda5DXs/HyE6Xiy76v
	8X3qvA6KXU7iaDGIIoDgLC6lxS2+oXXqSPwjDJUXSy22sYMka8CJlsgohpQfkcTW
	LpH4yJB+C/7+PoeS6rF2sFhJdG/fD89iCJNYXO8aOs2edt3Xj4Q0ig8B38u3LCbU
	WIuh7wRAr4Xj+4p4ZfApoiz+Gt7hx7vC+MQhge5/0L0nuYJb4SXiEk7ZY7OWpx4g
	Lg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqrjxt50r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 02:59:04 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e632390d2so335424085a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 23:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394743; x=1785999543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lnMAQUAxGl0d0xuPXIIpzK+l0m5WwNxFhJZwOOAO20=;
        b=SfdE1R0+aSaPL9o9cCoeqkT0U0UVJfcoHOLH9V7h3EcVx2tK2Jq85t5Y+kwiJaYRNr
         W2PweVP5hY/hbE3g/pQSZTpZ58ztx/NJ7IhriUB+6HRFRxvj+Ef/vSOhpAdz6cNJMnyl
         2nJqPQBV0chrCaD0wgj11YEKGo/8OrwBxk3u0R8eVmhVn9u6G/6qpsoFZ7UPxfQNz8Ey
         c5YpdpSyzTM8esDPRwI2bceVPA7PJQUj5kTpER41fDmuVdbDT53iBKKI93Tou0vir2Lu
         0Q9wf1i5ELtG7q/LQ0zpwHYTaXLQIzfWghFdBGNJRELbelhf6QS4RFg4fzrCcbD8ll8v
         BFWA==
X-Forwarded-Encrypted: i=1; AHgh+RpX37cia8hYEwkOr2spBmRuPZKWL44AShX5Sb5ibaCLiyMECz5XWh3DQxQM2BvfiMz+c3n8i+ZdKzGWkj5s@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPfyv10FGuf4SJ+VcEDNll/Ub0ilVQQ9F21smrRRYzlNDg0PU
	HZsxWCEr+kAxA6s5mwlOusVCR0+N884KLwPm4ZOihH6seG/Eg+WsNhvHdiyZF87tK0hfA8aGEJ5
	8K3OHeq4vJKoMBw8LJntL2oTJnmNvdAP5F8D8u4QzTuy78cvp6XYLGzHa5QcIjqo=
X-Gm-Gg: AR+sD13MGt0ZxVnoUWsVtIrKX4+O+Nbsqb0+VqjsLQXPpD8uKDY447zJ3j9h3w4BTH1
	0WI/qGH+oGquL4nrafAQlTbpycZJHx6iZuqDf2M7L6weHHVmMaJtiGLGpS14IK1V843w381f+bp
	18PITHXlaszPDWoNUNOJ9fHbKCxeNZ7R2y/FcvqajXbSqkViVNyOxh1/zuDrbPuw/5v1U9/GDjp
	Uu1IcacAW0NLjI4IzqYQHyh9Axx9qP1B9ei7f2FIF1345eOhgu5X3W0NiamO/UOjCC9C4wae+DK
	vZyvKxyuwZkMD6I+eJf5xMA65rvZqjuhPhefQU0cQkc0PuQwjbt8e2wPdlkhQWVzTtZbbOnKbFP
	Ax/BcdGQL+U/dKV+59mKrZoVvzFwIwfednTR6nRJuBNiDCw==
X-Received: by 2002:a05:620a:1a05:b0:92b:6805:9175 with SMTP id af79cd13be357-93486af1e68mr113647185a.61.1785394743692;
        Wed, 29 Jul 2026 23:59:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1a05:b0:92b:6805:9175 with SMTP id af79cd13be357-93486af1e68mr113645485a.61.1785394743228;
        Wed, 29 Jul 2026 23:59:03 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:59:02 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:54 -0400
Subject: [PATCH v7 4/5] buffer: set BIO_COMPLETE_IN_TASK for dropbehind
 writeback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-blk-dontcache-v7-4-3e8e6850068d@columbia.edu>
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
        Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=981;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ZEoFDRdKJkaZHcFnJ/ZnxZn4DtJcz5dwb/qiVw90Hj8=;
 b=b+UxIQsoik7/2fDHnDW0olnU1/qVCDwC00Ozr0+zhh1d0+inVyiX96cXmklJSMAHbamG5lxnQ
 vFMiJx13/y+CaUo/njnCuStF0po4vXeZjTMmpT6DPvkv37PX9GBWJ6S
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX5YzbqsiRzX1A
 FeXOn+djupAOwAAZ3hgzOgACIikVmaTswPlcMOlBrxdAMAI1lRyJsEZ+urgq+MHjH969w4Maz4X
 fSORVOsxQup8nPxW6h/Z4WMvIC5eIgQiSMHlyZAPBgCbMy5Mpm/g
X-Proofpoint-ORIG-GUID: VTCp6030G8_Y5xVOt_fukwbK3cQwrjL2
X-Proofpoint-GUID: VTCp6030G8_Y5xVOt_fukwbK3cQwrjL2
X-Authority-Analysis: v=2.4 cv=ObCoyBTY c=1 sm=1 tr=0 ts=6a6af638 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=WzT6SMHhq-VMa0lE35UA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX09c4Z4BEe245
 t7lctM9NTNIRM/jdvSjGMk8X1EtsRGW5z4lJeU/gfU+zOJ+8Rj0S439yJBFr/TUWOFtGzzWEwtw
 3FU4Zp/t5o9B7fY+QLy6DxjLnByxEVHhYnk8bttbacQo7H2y7wf2R1l0y/7e4BucMu2G9MYJmbx
 GX3F7KGLnUYcbTE+f1AGfyekzcSHh+pmwetfs/yjO2Jj4jVAsqANhSXFfqBKScgNIQCnQ4gqoWy
 4zI9G+QztZFapp+49Przv+3Bv0Q5vqSdX3+vhgEK8bMyJLgdqGNTrhredOSAQEtgrGxQpObwenF
 Jyga7aa6iWeg163pXaKv0RQDgIFK1WwN6/AEu5FGeBrQqTn3UJzaOaH+3SajYJJvgP1Ge1sNVjc
 GmB0gNr13ggjzrCFbsUd2ZBzjJUV0sFA6Vq/RESGQzxP8UQrP+GjSdtwytgGLSkjKM4zokpE4yb
 yJBZnla/yD1ry5jYHTg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=10 malwarescore=0 impostorscore=10
 adultscore=0 priorityscore=1501 lowpriorityscore=10 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300048

Set BIO_COMPLETE_IN_TASK in __bh_submit() for write bios when the folio
has dropbehind set, so that buffer_head writeback completions get
deferred to task context where folio_end_dropbehind() can safely
invalidate folios.

Read completions are not deferred since dropbehind invalidation for
reads is handled synchronously by the reader.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9af5f061a1f8..6f099847240e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1203,6 +1203,9 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
+	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
+
 	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
 		buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
 

-- 
2.39.5

