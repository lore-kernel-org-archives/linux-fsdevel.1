Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12005420471
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035568; cv=none; b=EJNQu903/EMkpoW5yHmQ0Xe5efuVY8zCiYBroiZWtH0dtZHgnjcCt1AnIB1y6WElbniRufsEXyy+DETTGH/qKWFic6pCUM2ToRo2VwUnT3beQemJtchPBIT6A3FfAQ+J+YSNRBUkAVVe5UKJapYp2tBpQhDfmm7RT0uhMXKyKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035568; c=relaxed/simple;
	bh=rnhWvDAamvoYeIKRmdifnx08e4HD3+YvwIOGYnqYA4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTNMR7zjvzG5ZjAEi7EbfgcvM1+FHzM8OXWirpnvA8jDuX4yaYa8N1Rknbwc8pIDugf+m5oMR+cXucYHg7yNDxnj7dlFdcTM8OwCqGNivzCOkbOZH8aRefFINWtDA6UaE5cm9p006ZVONNVe6bvkMBJWu6LzFLY4Z5HsmZ/Jbxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pou6BHbJ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pou6BHbJ"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-758caf52714so588272137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035566; x=1786640366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ByrJwOVSq2vYDCfCPUNcQuCIafVp6X3bai0sLx612mw=;
        b=Pou6BHbJ8C0nRs23QcGZLdXsAeVbkCeZZUAlD8+PI0C3YMw4ZPeU+ag8R+lUVhQh4Q
         GktYmqZuFCQq2HPObxCy4z3hHoWjy/Za5rIhwJHGiINyx9zp5p7YCq7o0KmnLXcNVmV4
         upodZHe1S0ATqzCNqJLR9JdsSe9M38UH8S5XZgo+nE4u7UjNezwTZyUDdupXb2ywbDCd
         9uJszE3xFsH9zUxvw8ek+TkEEAYsuT/Ovt7zg8kzkXgBKmcer2wM+XjgpWKfw6Awgodn
         VrG95N7ITzH3u7i/kBFsEqQiCwvtYx/xgxVlSKpDXd06zj2ZkKbPLa9RZ7YDf8Jd2k7q
         AKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035566; x=1786640366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ByrJwOVSq2vYDCfCPUNcQuCIafVp6X3bai0sLx612mw=;
        b=bng2CgEfMql8XS+pC62boLe2AwP4srzpn4CU+p+fTnw6oARDxNRkAaurtbUP3sRP3Z
         0SySB2fpAZ1VRc3EJ14CX24Z+zWNu0eQiescbEQJ49ZKjgAVghKrjamVcqlPiCNC5/Yj
         vsggCNGIpqmvZaR8usx+S9KvTLHSMNGNlnq50uhdzruDZFlN3HIcrbBEmdJRJi6E0d62
         iFpmCi09zx7dAVjdUDwmaCwbDbtIXH7L4azhX5B379uR/J1rczZY6DDdnFzU+DXRiRQm
         zWLwheWm/IEM8kGtX5Ezd1c0t4rYlU4aLri1AunvaNVlkys6OA/NQSkcRsB1dTjhQFes
         pHtQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+a5wEj1hX4lNqtQblP4y/ZUf3pcHeTbHpJkuLcymtpYxEKUXq2lA7xsy2s10qoTRZGeY3XCZ9GQgFr9nv@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwQUwawRdVexu1s3zdxpWSjmnSf2+NwUfPgE5foBZd2MtAse+
	B8YRWaCyRawnipWMxu9QraV5UC6lS/O+ivjYkqLv6Gk3ij7uMggHg2yt
X-Gm-Gg: AR+sD12mQwAP8RGArO0qSvOGmKzt0jhoWCXXDAixNayU4sUk2S8xIO/UQnjCciEg2Q7
	sRra1yqZcsUdtIyW5lLDjcji0DX0gullVtYROGy/Ols9eJUJY5fE/rcS5za9BWj+IeyrArpz+09
	kClWFvuv3H40KbJlcdYjq4WkuuVLxARTGGfCRfsvsSjkxlvA86mstDLZM/bvjN7PiFrx9To9L1T
	dyazaNtH8A7Xe4u0qYXifO8vEPZjKi7t8SFKxsEhtYlS9T3enqsqo0dMQIzseteD5u3XaIjJ2YG
	yltZEPzuJmGkDfi5B+rHI5GGa/SGbDVeg3sjYnNQ9AriVe4iSnlDn/w7PgUfs59+D0+UySBpVni
	dZl4XwQATwZYZYWxRADb0xXZ/j1RPvRt1Mp2gplXpoRZLoctVjSD4pYQSOOs4xrvEIj3s+MRpv1
	h1dfJEdYESVS6DFdW6X5KhlEaPSmC9+WVGwyC0pDLL5KM48aDN5i4hpvVKANGOZw97MYo7vxQmo
	dCYoa4=
X-Received: by 2002:a05:6102:6c7:b0:631:28c1:154c with SMTP id ada2fe7eead31-760e9e4714cmr4097167137.9.1786035565908;
        Thu, 06 Aug 2026 09:59:25 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:25 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 07/21] buffer: detect metadata write errors with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:30 -0400
Message-ID: <2b309196b883cc8979800911a47668e225401b2c.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both places in this file that report a metadata write error to a caller do
it by testing !buffer_uptodate() after waiting for the write.  That works
only because the write completion handlers clear BH_Uptodate when the write
fails, which is what this series is removing: a buffer whose write failed
still holds the correct data, and saying otherwise makes callers rewrite,
re-read or WARN over a buffer that was never wrong.

BH_Write_EIO is the flag that actually means "the last write of this buffer
failed", and both handlers already set it via mark_buffer_write_io_error().
Test that instead.

No behaviour change: today a failed write through bh_end_write() or
bh_end_async_write() sets BH_Write_EIO and clears BH_Uptodate together, so
the two tests agree.  They stop agreeing at the end of the series, and this
one stays right.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 570ce7f495d3..aebf74abbc49 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -618,7 +618,7 @@ int mmb_sync(struct mapping_metadata_bhs *mmb)
 		}
 		spin_unlock(&mmb->lock);
 		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			err = -EIO;
 		brelse(bh);
 		spin_lock(&mmb->lock);
@@ -2743,7 +2743,7 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 
 		bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
 		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			return -EIO;
 	} else {
 		unlock_buffer(bh);
-- 
2.43.0

