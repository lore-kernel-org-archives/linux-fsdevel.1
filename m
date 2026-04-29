Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596137F726
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476404; cv=none; b=GsaC8DMyy9walM1j1/leoOnmlY8Utx3UthL+KdSjsPzPqb5QQjfnfY4Tnw8mjcdhIaccf1brt8Dqri2u33qSOfnvDLgazGkEHI3q/bkyjc1hvVQ7F/IgTGTS1dnsVERudqrMQqsEnZqVUHyNHpt6qzu5JrCt3qztcTVCYROkyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476404; c=relaxed/simple;
	bh=Rg4ViyjWjJ0uH1MionkRUKz+M0sp6VZkQ9UyDJex3kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSg9daHkG0X2O/WT64gydukhYX5o1Yx7eAjUNsf9edCQCHwHilkCem85Pf6+HR1S28bEL8gUA4+APSBNA3CJVg3EhORV+ztXlGssMDcoTf2ATdkTvAbE8cXcP39feTTqVCAyCUlKufFkJw9zXmvuCkGOALy5sZgnLollhsupeZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxbT4MqG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxbT4MqG"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-446fea16729so1612767f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476393; x=1778081193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=;
        b=ZxbT4MqGYb41heJHzUNkeNrQqqbwivoko4YMr5UyQTxSL8WB1OyORAio38DxntrS6u
         auZrBgzdXlS/Zd+QO9j19xJeT986+p4M04JYGsA9Cy1qY7tyv6ZXSsqeu3lOu5KcvgSf
         bwH040Jp458XcQ78nGYH+2kcXG0HqNQhcSaQEopmU66xpyEEMarI7UgAdVTwheElzo5Z
         2HR0Fn7PnbcP6s0xfsjdbr5X0o3yQ4BN/63ISgNQnvQCaJQJJrImNwWpwl1p/TSCFX2Z
         otPWWi2MPrnCArGZBi2AILWhP9XjXJtLKVR4fjzxCf2rtAdcaSa+MtvsIi8IVnFvQkLk
         9NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476393; x=1778081193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=;
        b=nDXbeO3yOQg3cHXV7Ehl4uADtXz6IPUdLqH+A7rnk8XYK4r3TC7hlS99m1AbASm7ne
         bV59rEMGCycAYViwrPSBgbTfV8Wbom3wAZq5c7hvX/UGsvqr11pQP/oLjhABNmowxzVx
         7HL9CeTYMSBTYY5YauSkv7yK0i6Y9h5M1+fgLTHB7Fy/mWhaKefGLmdiaUtdhnnIjfZc
         OEiFIoPXzz/C8nlwO8pPhY0JrBYeircPGDgO74n8IQUIt7YNCNw/5kNmZKETzjG7monZ
         a+5xmqftEnYFcc6rfplyOfutU9DKVoGP6NstoxPo1lFjRVtHYkXEVldryi/k1PIRE4l2
         62sQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EnNqVKjglwpZXBLZanaIG951Z/v/v8Wnf8BVajh3aJcIyvBX/qXQg4F+tIKd1nWTbWcPVjBxdXfvZmEpu@vger.kernel.org
X-Gm-Message-State: AOJu0YyfyUAySmjqOgsnVV4rVEWXw4ZIyFy6b+9bvlv1cjWGzFird4KX
	uwHn541H+xJ6EmG2UO06ckDX8AoxXMjhmHN0iRP21SWyYVv45aBi6cJm
X-Gm-Gg: AeBDieuRI02bnU7SU73XoGnhrpW8rwahTXcxzSbZ+A1TWwyzsT7CbLl0fs9WzIEqxsP
	HM8Z1hg4va8eId6eKz3O7U0+YNvOf2wsQ85wtaDTpZhgIOozyPEIHZ7jGsZcy2+NAeYsfMOUx+7
	aXWP7Pe73E5/9ZYebhc8I2iD4lew9WYJwC+MlJwoburUeBC4yKT47ha4ycSaNBGcUckzo2WsmEf
	JJ0jGomJsrNQszoUgbMq1Uv7Gzlp+jfkT5Uwty+7CcKJ6UQMrV5QolTF+MLjDvZjerMYoCV4CVU
	KqOF8ovQgKXaswpWXatmHf/PleaMcVwI2zeyEx2ziW20okUX9u4MMTaqHyWdH5cbAHgNpXeSFv2
	Kp2LgoZTS/NvsYxf7ySIS6WEse86SsFel5xbVLh6BqGYhjIU7P1jWwoh+u494Vp4orZ5T073pxD
	i9jFkxtI4T1rqrl73QMUVYwQfzmBHvqazQDlFEcO/+spOQxPMU09WErQpeocnDC1lTGuvqUSEAE
	wAY98KOeMPEwu7PHLVXxxSLOEqhib7G4eo0GnTfXUly
X-Received: by 2002:a05:6000:250f:b0:43f:e41d:85f2 with SMTP id ffacd0b85a97d-4464839c9bcmr15101656f8f.2.1777476392719;
        Wed, 29 Apr 2026 08:26:32 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:32 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 03/10] block: move bvec init into __bio_clone
Date: Wed, 29 Apr 2026 16:25:49 +0100
Message-ID: <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To quote Cristoph: "Historically __bio_clone itself does not clone the
payload, just the bio. But we got rid of the callers that want to clone
a bio but not the payload long time ago". So let's move ->bi_io_vec
assignment into __bio_clone(), so we have a single point where it's set.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4d46af0cd256..0734b50d4992 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -851,6 +851,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -893,8 +894,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -914,7 +913,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.53.0

