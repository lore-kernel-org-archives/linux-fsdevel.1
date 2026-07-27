Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27E3CAE99
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187474; cv=none; b=CUGnJLyAJQa0AhM0O/dTboCg5wt1FhXwCC/mastqTpLKOuo/DLMe+0U87d4aTla0Fe/qYR0S602UczuG+/zm9DOGUHru2F/KRRs2JiZM617Bq0h87nvvd7ckYHM0d3CdsVVzeDc0yclAHX0A/NQ8WXbv7GKhUZq477ykTQAzOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187474; c=relaxed/simple;
	bh=37DoZPkb+1W8fWCJOdx7vJRB1ZWmqFh53cazfdVPywk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuX9Pd3ft9VEX/k6jJksYApssckIP7dfXSvj+Ct/sMwxZx/9jOf4duOgftCbDYiLx0/BEmeRW6CKcL9zKj+jpRUSM07hoAIPJ0fCBp5tMYaDn56WY2t8qCsgeDMmfWQwO3Ve+9BXWWaOcMMckIlShJLuMYjTMXTMkSeSBO0/Suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLbnzESt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLbnzESt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce98cb8165so4425635ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187473; x=1785792273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCBfh4hnA0KRKUHFPOeo4GUfSXPKVLhLb/fiVOqAkG4=;
        b=RLbnzEStyKuTQwbc+Ij4DLzt3KsUz2jQXvlD/29p/YGH6+phB+0ktoA2C3qxBqfed6
         jAL61DhCx2+hVUsWyw0ofZpMtBFLIWx7DIo1B1kZh65HdAD5U9nObeK3aAUeLBzhJPJZ
         bKUT8otzU1yfp/HfJYh6xaajy6JOIPLSc7ET9WtFCCD1ilxITDWSqRnoFMxPyVTy8GsU
         1jz5D/NO94z8Dm8OpFrlTFImVvM9ch9EoZDoCo40ol2DPz0MaI5IAqjBMxepVt/IABqO
         NWAt2U2lmIYYOLjj64GNqC63h+KYNrDIe+9fNy1RBsOyRhiAs0QLfhsM5w7TG6ubRSzv
         if9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187473; x=1785792273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jCBfh4hnA0KRKUHFPOeo4GUfSXPKVLhLb/fiVOqAkG4=;
        b=flX1NmHdgIO7y+5WGE1OxdT+7abUs+4/eORgw+WSL+J7ic2NhXkLykLC2jVkSGzv/n
         ZEQqiW/88t7mZN10ZB2jxOB//prBIj+4EaYCgvEjmpGA14OPQwkEVE4haz6uVz33Dr/v
         ExALxCXKQ54dT07I0YhvU1CHKR1t3+7ibrjTUO/qB8mA0X4fYI0v9QWRyWIcnPpi0dQZ
         vy97d7eOjROb2DB8jKEqjXR65eXpSNuqBrpytVUDF4Xv8WNlRbTS0Kw8MyTpanjuQAaz
         qng9rOp42gbiIsrdKmlTyN3Lp4TZE6XvTJcLmBUvHKChlnqjzQtcrzrccZ8JnBOt4N7e
         XbAg==
X-Forwarded-Encrypted: i=1; AHgh+RoYK63rDG9k1u/TCVHA/2uSWm0QIzK1XVHqeGis9+FoZSLqqSJEJ6tDX29wlJ0ger+YkWG1V80DQHLDVcHG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0ezN6pzG3/RjKm90NkBnCq+S+Ak0k77GIEhFaO3ug9nv7bvk
	77CcQNe4EzWa6aBR2pwAGwAhgc60YtEW3ij/g/Egn6voJ9sX6sZMXkKD
X-Gm-Gg: AR+sD10Esil8U7iTnjAxUMd2nYND2Vko09C8RnA37p5+hfdhmxTeqgz1Jo8WsuI/30G
	utA+td/FddXGhs2W2U6YQ7twTWPC3cka4uwOkYh9lB3j2R6XVrr/+hSyTdnMpt9pF9T4KP751wQ
	KJ2PGLBnbBBIUA1bCV2WCuaBM4/dV2dQIAMRIe1wKJovMJZM7zU6Mucuw5hxbA9nQOXUUMjDEen
	LujO0QaXnqbK9fpi4RZ1oRxWfDKb933mqpDyPyhZg6CPtyVmT5dh8Yq3L7p+ErKddANyinqqewn
	n8PQ8h4UzOutMIoumt35kTF5WQ8CKDMIAP9MqCc26rlL1hkdDzhk4CcllT0ba66/maCzCmFXCGL
	b1hjV/SDqHyOLb0fpq7n30Y5L/aGx1JI2PRfHKEJ/d7lvfAvg/8s54uQj1hLfjgBloD9W9TYV79
	ylFMPWzUasbJ6K2rOYhvVR6RxMXIJptQrZRSljCsBx5l7T4wO/TwEpVw==
X-Received: by 2002:a17:903:1745:b0:2cb:402:70cc with SMTP id d9443c01a7336-2d0122483c1mr3309335ad.28.1785187472633;
        Mon, 27 Jul 2026 14:24:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e333bsm40730925ad.30.2026.07.27.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	tytso@mit.edu,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 03/21] iomap: use GFP_NOWAIT when application for iomap_dio_simple allocations
Date: Mon, 27 Jul 2026 14:17:40 -0700
Message-ID: <20260727211758.1116539-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727211758.1116539-1-joannelkoong@gmail.com>
References: <20260727211758.1116539-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

For non-blocking iocbs we should avoid blocking allocation where
possible, so switch to a GFP_NOWAIT allocation here.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 36c976cf0848..5c28124b9f02 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -986,6 +986,7 @@ static void iomap_dio_simple_end_io(struct bio *bio)
 ssize_t __iomap_dio_read_simple(struct kiocb *iocb, struct iov_iter *iter,
 		struct iomap_iter *iomi)
 {
+	gfp_t gfp = (iomi->flags & IOMAP_NOWAIT) ? GFP_NOWAIT : GFP_KERNEL;
 	struct iomap_dio_simple *sr;
 	unsigned int alignment;
 	struct bio *bio;
@@ -1015,7 +1016,11 @@ ssize_t __iomap_dio_read_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	bio = bio_alloc_bioset(iomi->iomap.bdev,
 			       bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS),
-			       REQ_OP_READ, GFP_KERNEL, &iomap_dio_simple_pool);
+			       REQ_OP_READ, gfp, &iomap_dio_simple_pool);
+	if (!bio) {
+		ret = -EAGAIN;
+		goto out_dio_end;
+	}
 	sr = container_of(bio, struct iomap_dio_simple, bio);
 	sr->iocb = iocb;
 	sr->dio_flags = 0;
-- 
2.52.0

