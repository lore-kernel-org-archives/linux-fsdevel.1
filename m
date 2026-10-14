Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C054F7CB4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975769; cv=none; b=ddUnp0wEd1SRZOB2dqzAbNPxEW1/5Z12PTs0VCO/LhMMlK7MojUi3ikyeNN3A64xk5yvRJNexAg2aDlJWhGtfAg/KVXIZIsta3sR/CMmBA1mQWkvqx9B6goJxB3zzKd1mDKZVLtPFvKVhXHdtERFwshzbCL0+O0LXQ7AgLfVANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975769; c=relaxed/simple;
	bh=Yz9mg10bqVdj7cVQ9CUCuhVSPCWk27GUE+7ZZMs5kDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BY5xlDsUG5iwA78FQqbJF9uBbqw1yvtvq2o6MCBv8pwSZF47hEngcRKeQDv9UYeRg6mmcFby8kQNUBHz2gd6qeI4wkH8vRhl7zI04gZy34fhYqD2WuxcaHiPkPGDFpuODlGfVn0O/ZEM908ySWBbqUptGeHqBpp1nO64RnR+YsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P69uopP0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P69uopP0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49ff680331aso9330055e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975759; x=1792580559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
        b=P69uopP0dGw4EOaBNSimaiFj01eeZtTBN1IzIjPctYGXGMK186M0vk1uak1vfbhoQC
         Z4f+zsvI9w8AQB+S/B67WktuHbeO4aifFH3/USoHAC1vXOCw3R8LPpeyZMpRONe+jiPB
         O4HTkJ+LZNMzsFHzYsEh+Yl0LWLLuseBNmsmShyR6tR4yuUQ/jFIpRGSIizgydVD58ZA
         4Rj1t0FIjWI7vqAXOufrWsQuWJOF0+50IM8pry+1R8j2WxScMO82jJuux0xQmRW5+Guf
         JgxxxEYU9mcdVtgbr3+oQrqjr8IBZB1JkgUMoI7oPP25Edx2aEfEfGvRoN4cSV2XO+t5
         PHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975759; x=1792580559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9CL2BRiyUp3CaHGocQHkhsGpx+V6MY3r8MUNMnInA+U=;
        b=YhyPZRoJtV0FA84EKgyU5Y9J0qNGzKuI37Ot7Et/MsfwgiEtI3J7+8eRHzDtM9cYyd
         QsqYXrL2xWAB+o7vCWEkFBilUZF3ZVe8r7wqa5Cpl2gOPm/4hFgDzcB/MkRH7MFp8bZm
         nliQfqqt187nKzbm7LD62zWHkgYDkV88/K4AW6GTnsGJPyQMLGlJT1Np77nE/F9nTcA/
         ls2+rvAnY2cESCwI1g1IMZ2GIvkkVXrOFUitdR4KCI+rAyoEZ1hjEJa6zgUJ+slQHh8P
         YEguCzUQMaLIjUcKWr/MdLT+nmCVegZzfdAeUqGLCoy4Zp7fkYP3iHh7Uhzr4PabAU+D
         2tsA==
X-Forwarded-Encrypted: i=1; AKwUvByzFxRDmEVq8Bnlc9r+yNi9B99+lrcCQXZaVxlDd1E4gE2e3/yuaviMsk96KS/2IWt29v32qMJi2pSVTwkG@vger.kernel.org
X-Gm-Message-State: AFq9FYIsqNEeI23cFNKmd0mia4fgo+3OMD7qNCP9O/1EjHs+I8SPPm30
	b0qiu03sKbCWrEK0SUbhlHpyaI1SzOQIoWBS+6vcMMfYdK4pPZLkdEOY
X-Gm-Gg: AYBFou2w3Lq3OFH89nRZVJJu9TSHxyZfaU8gAvU/flV9cSIraj9+3xrQcplC5gTNICG
	9F4bEnNBijUftVYEiUp1ZkGjcfiuXABzKsWx6TXJJxRRAGzhN5im9NLag4/DnOnisMAPc9+b60K
	n0tsX4LZ5tlZvFcsCLmd496JMh/X29VkxX04p3lIVUKToLYa6lxdh5hHjD9OYCq6/S0QkjhyN0V
	X/YHm8EuQzA6M6vegtaA0JdYgmJ0BHOkZcPje04ccB6k6ARoozxUdGIYrqLjJdhW20yeV5mUmqs
	Abpg1MRf+1SPzJMFpx6FqdELt1DmVzOhNfpv0P1Ma7QH4Cy7vswFkDNspFFd01sdX/aUycLbG2K
	On/vjpYZuC9SbE6Uc68wDnzfU2GnHrri20CjnJhylQpRmdgwhCgkxrLbintKc5c1A2fdbn2CPnO
	rXKFlgg1adAng0BwySkckHhPr2OjDRXF+vj0LD76p4AeJMPz4N3BLD4uxkSjaM94rlgB96Il65D
	T8auiAAlOFODSJXkzBKFGwWxut1Rkp3JzA2ULm8fgCBHqR8VqM+F+uHd7+5ywnaOHUhxTNF2WZ8
X-Received: by 2002:a05:600c:4747:b0:4a1:77db:45d9 with SMTP id 5b1f17b1804b1-4a18e47aa9amr321452385e9.6.1791975758979;
        Wed, 14 Oct 2026 04:02:38 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:38 -0700 (PDT)
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
Subject: [PATCH v11 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed, 14 Oct 2026 12:02:09 +0100
Message-ID: <c73c459578981e64a352e46c0db39ad46621c63a.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
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

