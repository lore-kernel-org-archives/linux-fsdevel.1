Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2C55D884
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924947; cv=none; b=scnn834sjejemK4DSMm3SEHoOnSpN1J4t+06pgE/HgSgS1Mks5l3SRLo1bE0/YrwLIJMkawwUSd+k7JnToUfefQaZQO0+R+knTsnpoL9/gNDH0H3K21qyrEHAH4P8tA3X8doClXFdqqa5g+Cc4Y0Vejq6FOxy41FlAbIlr0KQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924947; c=relaxed/simple;
	bh=Yz9mg10bqVdj7cVQ9CUCuhVSPCWk27GUE+7ZZMs5kDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfWnQyYl4hDMoV74ar4HNI3fLue149uoM+xoKPEYqB/12BjQWvzpXDh628cB2KkaPGM3lWMe3lwtBsgtN9n/v/ibXCGSuTO6CKZgCxASBVJA4hh7geMcBwGyyTfo9u6IqwghW+Dsp4oz1k8lXcr/MbQ2WW0I8tR+aA676OvpnJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reXEvNR0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reXEvNR0"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4649b35bso3185258f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924941; x=1792529741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
        b=reXEvNR0/oR539rFg/mAmOONmVBwbmQ5GC0k5RqdLIb/28t4/sJhr9VlDMTRP2selU
         EI4ngzmBIR9o5vFVZS9V9CaZL5VtDAlekC5OfeqLFQdxj+RDiXxfPjoh+PtAMIyxpKNJ
         O0DFXdOF0VFWMHxoAo63DYMgxwl+rz83JhX3fFTDS/DfTNvJlOp9F83hbiiJTGFaARTZ
         JBRYoCS72lG3ocBNO8HKt0IASjzWzzMN9YA70nYzttT1XQA7iPI7j49DK8ba1DVCJZ4u
         IHzcMBO3S1gfqL1W89gg20Tv22hBES4Q4H7nzrgnZ9u3rn4yvrh8RrmjLnGBW18SAySE
         sMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924941; x=1792529741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
        b=WFCl7TkoI0KoXjdSRPednKy8apUZxRT6jt5l8xA4mlVBmPVcoVmNx2C7I1I7ZYSl8Y
         TEbtWlwFj0XhUlN4mgZ1aNbF/Ktqc8wIa7vcTk7iAvRbx1QMtBVcxcdsjxTlPeFPITRj
         LAbjv5TlGgDK9k7OLYJehQ7smv4YSERgOrA3go+467bDagkbZ9WssePrW2t8lGh5gql0
         ICPe/qnvau2pns4n3y0ypD3aBYNrU5/9lNLV7fjNrD2KeNqPpzRTFcXhFUUnRwNTsCB9
         H/rv+a3YT6+8Mnm4GWVxuz/5Jf7qhgial7OhjturEOmY867/jISACs50KRXDS8jkhLnt
         1fKg==
X-Forwarded-Encrypted: i=1; AKwUvBwl1G9JJKraxZGKKCKWWeJk+9ZzbyCJuCJhzo5ke5gQrt2WQuTGmwJhkB5+4YDwjN2ObpsQH7dqSoU+uxjV@vger.kernel.org
X-Gm-Message-State: AFq9FYIU7M06vfJlu9GGC0pRbp5X15pCd448aFuaG/OCm75+fOfB6722
	di5l7ueU7aBUTeudoUMNAxoRj/PAkOocbSSXJTSvjFgwIxsY5pX0O8gG
X-Gm-Gg: AYBFou0WRYhvMHnTUfbtr3OoC2+W5doCirWyW69/DXwHKXWVngMeKIrW7I/585OwnFN
	O+FaOuTCzUSvYT0agpg8zdkMzpxKZkR97BpO5Loq6fwMYCLcTqvzbBiQiWh9+nxE8vUuwRXMqml
	uFm1w3L6c6VuC+SP2c1b+2EipibVLQyvlPuo1Xkwx0XV6GGfTEgCjitWZT8ocwwBZtT2LTOc+oc
	kgh1hjQRFsJ3jUupC9JyKMHnZX/46M+yzrPW064AFK8Hg1PICJpyb6KfJC2QnMGGQBpKaj8m7sx
	MLkNNkDfc5980Yh4KfEKYYt+ysf85BmbP8Iy71fHvqlPvWDxMarYsiHuBbM8qZBfdmRRb/sLZc/
	nF4euHMy0bFKEBb1IsAmMcMO6Y8Cu4Ds7b98qz8e6wlGTXqaUFbpIkf79A4SuMEgkzJVylYza1X
	zXgd+pWJGRm0W8RUglXZLryi0xDnIXYl+TvJCDkqCNYZ+qBgbyMVzQMQncZBUI0m7CIatJL5phQ
	eR3wPHv1/WGHIuWOpt9ihG3qSHGrEBiLGKP97IaJHzQ7Uy+7zZao0kVxvaWReJygThxeo0I9/o8
	VvagcWODfR4=
X-Received: by 2002:a05:6000:2407:b0:487:1ddc:aaff with SMTP id ffacd0b85a97d-48dbace40cfmr24537298f8f.44.1791924941527;
        Tue, 13 Oct 2026 13:55:41 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:39 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v10 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Tue, 13 Oct 2026 21:54:55 +0100
Message-ID: <b013774568929cbc3e6fb9ed29079088a1006431.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 54774729ee67..532866a1e9b9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1458,6 +1458,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -EOPNOTSUPP;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 9ef88383b363..73d7b1ebf0b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,7 +26,8 @@ struct io_rsrc_node {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0

