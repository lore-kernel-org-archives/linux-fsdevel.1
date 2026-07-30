Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5D344021
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394768; cv=none; b=kZevgPvZvsSXWBNuMKyM08Gmfz/Ml2Ib7z+XZ5jyLgYyI6CY83TGBvEBql7VjmtCmlcU6oz+svwi0ZsgbAN8XccsBsXh4btPwYG6YjnQpCzGpdaT6yswcdE36ieykQavi9v+EODbbnOeXeQHIy4NkSVfjBrePgA1mCi9GvUl0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394768; c=relaxed/simple;
	bh=Tk8jUyrOqQ7WXa1eqV1nq7SPxnPRM7zEp3j/WZJSWC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGPGcTpf9ixsWI68OGApjwPnfVLzEMIdlkl/P8JpSbCXb6wT+CMuIgIYKN+HU7NrjzgRWABNaMPLJ7SlEseZ1w7msdKMPPZM8th7VxPn6FMJLm0d3euKjebEwUZ2PJ+uGlTs3dU1mnpBOUZ6CEA7BcffZP5KPDJC5Bdep/bAkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=i0qRx6nS; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="i0qRx6nS"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6j15C2243668
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 02:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Wwzd
	h+lefzQ3Mewr3ag7PKLqaiugNuHuZ6D8zRZNNZY=; b=i0qRx6nSvdRp35M11yLi
	zCDL5833R4xWz9ehYcDjCN+iJy81EVfUbRN08bHwKN4Sv0jCdbucXr7pPAXPrQxg
	1n32YTlFzi84Wr18ittxMIrJzVdRnkygO8LEM7xlODihfBD+KKpFhVBicsOyZBR4
	JD+7PIf6HomtCv8bssHFR2jU/sxf0CVVHqPgBDVeubE9hqpuQG2Q/5k475unjLYu
	leSSOvM4xxdsLdk3pxUwcrvIJrrT21ENuMSN5TaP/FL7OVtRqYOQU+/M1DKF509J
	66cfLiS/MOEbOYUmN638Fpjn7j7NmlsYIk9r74XBJWePIIUuy2ZYsp95KPo8t/ry
	nw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqrjq25cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 02:59:07 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e606e8f3eso141637685a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 23:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394745; x=1785999545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wwzdh+lefzQ3Mewr3ag7PKLqaiugNuHuZ6D8zRZNNZY=;
        b=Y5fD4Ees9W2Awcrk2F1OclP+Vrpf/4x+g4aLJKU/faQ9NTxBKpWPvundLEtlWweMEp
         dCloN4XI819yBLiEdDf7oqpRQzHL2t7y+lkeM/cjLDGULwhVj6XMBFFxtazTE4uVhba6
         KjLQ/3xdbA7OiQFRrdWkY8GXUCLMGfvYWXBkd6odyTvkV4Y99L7A+dCmIfKULuKJsfNp
         W9JfPwLuGnp+SOgOS92ir1e79QegUTOqjba33ItXE/YuRcI16Ri7QPnkcEHXbDRlUBSt
         OfyIPieDTP41E3vb5C1ytY6Hve5mQ1vAcY6c9EbnB7lTt8+2VYnHS37QEzi8/NV5BQ/r
         t//Q==
X-Forwarded-Encrypted: i=1; AHgh+RoZ7+wA4eDX//FYDcB5d7L3TxvBJ6FgAAkAnrsYg6WVlGY2R6T27YOYvxQg2cuHAP6V47qfygTTeCM3j6Hu@vger.kernel.org
X-Gm-Message-State: AOJu0YzFx+LMYh1/BhFUvDCj2EqQ8cKyV3mz0x1gWZVOjXRHPOfNl8Xo
	pzy7CN2sCP7Z4hGoCW/bA53ZLqG8QON9yFk3Yaiov05pF4kq12luruYI/eitjknZq/ZltkIt7Qf
	IKPnvX0b2ZGQ5XD5n2ypuclg6KZVIxWGH4r5BMcDDPhvwbTVJGLBD7ad+4bd15PY=
X-Gm-Gg: AR+sD13XyZ9E/h+ROIzbXzhX+fFEH7JRqzcmiLngpCe+0CxCn3A3vjwFc01K3YXU3hO
	ZLwzRUqHvCOA7w6eYCJbBFZYYAKDvGdPdv6qKC2VuG08a3+u9PCijAUp7dlE6CZhJ6K7hV+mCvU
	4SxYfnuwOu8ZPy+hqqBCTYzSfDuJtuptHpV6MXhQj+LzR6U1m6d0gu/4LFCOsk4JHGx54CCWzba
	L3p3iO1qt4qu16bm1z/BKHt09JSJrWS6KyFEs0lWwAzO77pQoGdPBvCpVZZtLnpPBFOkQAz+9ok
	hej9g8zX35v03R3hPHFjboAN/p+J9+mwZ1ABOZMM7CuGejpLv/nSBNr4sq6MkNvbQVMI+valBdA
	QfNLahrq0lbFZUB0nh01P8bB9+rnNH1AyCWSHmtzlkrnHwQ==
X-Received: by 2002:a05:620a:2886:b0:8cf:c106:faca with SMTP id af79cd13be357-93485fe35d1mr140936985a.36.1785394745152;
        Wed, 29 Jul 2026 23:59:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2886:b0:8cf:c106:faca with SMTP id af79cd13be357-93485fe35d1mr140935685a.36.1785394744677;
        Wed, 29 Jul 2026 23:59:04 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:59:03 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:55 -0400
Subject: [PATCH v7 5/5] block: enable RWF_DONTCACHE for block devices
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-blk-dontcache-v7-5-3e8e6850068d@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=1234;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Tk8jUyrOqQ7WXa1eqV1nq7SPxnPRM7zEp3j/WZJSWC8=;
 b=os6OKouVgqku2jRKGVaPk1noDMT3+eXOUJzWQsRazIMJ1bPae/JGJpIYkqGCxir04AYNo7/bT
 w+Brhzebg6AAvdsxWkzbY3bN7osSNAQdnJPqVkijmqj/2VMhvYhfElf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: NTG06Bfhv825TXIFiyreM3w8UFBB-WbT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX99QnKQAkLVeU
 Q/mUVMe0BdbkR/vjfZjugBmI59PdR7qCYjpWjD9vHFG/KKw+57xVY0BGVQBK7pYXUFVL54Vl3wi
 wNzR/Gi7y44XWXJ2nhqCYWLKvSti3TFkahNnTLboT4X6QvcjQbyb
X-Authority-Analysis: v=2.4 cv=S4PpBosP c=1 sm=1 tr=0 ts=6a6af63b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=J9_MS8zF8NN3zyd_QTgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: NTG06Bfhv825TXIFiyreM3w8UFBB-WbT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX9zl2Kkn6LVTD
 N6mBSDAwYZW1MHM3twLhqSMI5uPOaIM+b7YBXfk0CzFun+Ty758S11yu6yOciNibhn8sMOiOndF
 pqJAyuXLrbo7+cAb5HAfFzAUngZGgV0FtcVkinZtE6zYQ4zz8fjMBelUqF7y4Rc6UK2nGP9bKkw
 R2+Kee5uzVYsJydvwsFmzhfNj8hMSwgL9AHozKV9EavYRC7mG5E/+sViRcP2cWq6EwkiNr4xk0Q
 /Vwisbb1pIk+Uiypv+SVHnGwEiBHdZMsyr+cB5HUN8M94aaP3hUsgIwHxkmBHJtYqCeJoRedl04
 7IlXR3QAgyANh2/9OQKy3DwnLvxo/Uu0V31zn8aqguM+4aZaFr5135BTNlIUw1QaMFwir9ViPCe
 IZFgImGloNlNlqj0AyaKbEfo+1zXN38v89tPrSRMIBrFnQ3lty0x+k2MC7KsmCxc3yOb/efRs4M
 nhsPZ4NZ5HOmnp65q5w==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=10 impostorscore=10
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300048

Block device buffered reads and writes already pass through
filemap_read() and iomap_file_buffered_write() respectively, both of
which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
by setting FOP_DONTCACHE in def_blk_fops.

For CONFIG_BUFFER_HEAD=y, writeback goes through buffer_head's
__bh_submit() which sets BIO_COMPLETE_IN_TASK on dropbehind folios. For
CONFIG_BUFFER_HEAD=n, writeback goes through iomap which handles it via
BIO_COMPLETE_IN_TASK on the ioend bio.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..8b39c53b6393 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -941,7 +941,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
 
 static __init int blkdev_init(void)

-- 
2.39.5

