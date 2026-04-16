Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8D1DED40
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308814; cv=none; b=Tqa0ftJ7wmFawPbi4XaWI0Cy0nit5F8sNf0nY10OZyG8sQy8Rrjht7qlE9DK/Jf/bG9SvCHuT+6EKhVWc4N0z8NWsI7u7Wp1gA0CvEUZtalRfA+lFbPKCyyNs/LKt8mPcgSjET+Nmk5X6Wq6u6UccEs2Xjs/UJqGGdGjKeVtTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308814; c=relaxed/simple;
	bh=2I63PklS8RTMy4ZBeNJKH5O9yBN3sFjLFkFF7J32HPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JqxpQDlrbC/+Cr/fbDPvc2erjFHxxvdUBomehbhlMJxAXmqS81tZ/D5kcDmTWxcAHOTm/poGCBct4wb69UB9VTXmKVru/uDHGJOlafMBg01497obEMZGfPhGVilJ1LNBsgC1aszjHabmSdHVFtbv6lA2efauJNa1GgusjEHEDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5xOjVjk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5xOjVjk"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so577752b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 20:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776308811; x=1776913611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLwFWID41PK+d9iSUqQXYtWXn+ddFgZMpYD1ReTw9mk=;
        b=c5xOjVjk7TuFm5MB6lwedJy1MqdOq2qCUgT2W0wTYlqXXGBxr6j4FK/7mfwTMGmO0g
         x1/W5/Fe5UpM55ONkUq4dz71yU9OMqkYvgwZOtkyXanOx0n53220JWW4Iu8xIh/4nP6y
         TiTdUe+Xr8vRs5H5/aUISLCKVV/fK9oY4ZFskeFvcGb3wRDhq3UE8s8tTSOiWBYbqM2f
         CEsKSABToJaTlls2XbSAlbihfI9g+xYsxwaVH3vEfFs6NgvXKOnf05Wf7zGkew5FR/ut
         kc2d08KaKgeFtZ4TbmSDlm92m3/XOm5yNFZeb+994Z69QBpto33gAF6Xi5TnsJBkczvg
         NBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776308811; x=1776913611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLwFWID41PK+d9iSUqQXYtWXn+ddFgZMpYD1ReTw9mk=;
        b=CqOGh2FAdlfDBX2LDp0Diouen+yLrjEy+BOhF0mPIV8FDEnJD+W/Ku3YTN0Z6F03rL
         kwpi4kcEn0GItgOU9SCczpsiDC+gl0AvtuZebsCJp61jtDyHqyv40v96J9x1objt7u50
         +esFuehvuSznuLg//CUipEgfSbPdPtnz9b9a+vy0rYMLRkF9BHhpRZwIsn53/Z5dbWxT
         XUWIO7eo6kPwF0LYA10s+VomIgQ+0RUxeckrTgYEp1Wi3PNR4zRVrrCZphjG0f130Elr
         tKUhzZMKHpaJihMweOYLxsZrxCt8fUQvJR+/htWa8ytuxvjIbkarqC+mJRiFB8wyUbFO
         k0FA==
X-Forwarded-Encrypted: i=1; AFNElJ+bfRtc/TMj/HSe7rlcHPb3pOvgkaqo0XsTpQ9BDv1lF9/G0ENw9+4aPxXqRg2Li5ewlZu6iz36L9pvDVJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJL9Ak3/jmj/B86ubTgZZCULylxuEU1Ig+oEWqXhognnU+MNk
	9YFrwv3oz/lza3kan20UtNB0s9mlBCRMlvPMmLB56cCJRMr8pQvNraJm
X-Gm-Gg: AeBDietHKOcMKq9OpqI8mWz7qFC5s9C0V5sJ5x9pH8VgWHeAMASU4fdkkdTePPj9juO
	xVgI2RWULQ33dwt5soeOL/AWZy9232cNKWnI4ZZFuQMGIiQ+6shn5HNMgS6Rzd2iIgy27a9e+NG
	44IXwjgAya0QbSD3EZ6oZZ/AH5iWrcOOcgZqq5D8xwjjH8xUfjKCWub1DSMZT/LJ3+uSVMBv03W
	C6AWr8eGAOjKM53of5zOPlbDlyh5UmiJFKh2SDUKlmI5kt3KkNVONzQVrOc26MMVEvRDj0k97gx
	Gi0NlwpbMmsDvJUbvpGEuwEIqEioPRVjR4cS+4kTM0YkR4/UJB0AtlTikmRSoCF2LQasnPHOxeP
	8SAtfrfBelfYFog1LotcK3S5L/OfPV+XsV7BNvtVh3Vc5kD6p/lLAit+0bt7evzc22us//dOYHl
	5uk8qIhcYAbuarDhF+d3LxJh1AC6pnnL577PekliJuPEuWPUxDhcCC5JQ=
X-Received: by 2002:a05:6a00:b80c:b0:82f:111:7e60 with SMTP id d2e1a72fcca58-82f0c323e1bmr25358052b3a.37.1776308810616;
        Wed, 15 Apr 2026 20:06:50 -0700 (PDT)
Received: from localhost.localdomain ([240e:694:e20:401::4])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82f67418a47sm3490993b3a.48.2026.04.15.20.06.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Apr 2026 20:06:50 -0700 (PDT)
From: Fengnan Chang <fengnanchang@gmail.com>
X-Google-Original-From: Fengnan Chang <changfengnan@bytedance.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: lidiangang@bytedance.com,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH] iomap: avoid memset iomap when iter is done
Date: Thu, 16 Apr 2026 11:06:42 +0800
Message-Id: <20260416030642.26744-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iomap_iter() finishes its iteration (returns <= 0), it is no longer
necessary to memset the entire iomap and srcmap structures.

In high-IOPS scenarios (like 4k randread NVMe polling with io_uring),
where the majority of I/Os complete in a single extent map, this wasted
memory write bandwidth, as the caller will just discard the iterator.

Use this command to test:
taskset -c 30 ./t/io_uring -p1 -d512 -b4096 -s32 -c32 -F1 -B1 -R1 -X1
-n1 -P1 /mnt/testfile
IOPS improve about 5% on ext4 and XFS.

However, we MUST still call iomap_iter_reset_iomap() to release the
folio_batch if IOMAP_F_FOLIO_BATCH is set, otherwise we leak page
references. Therefore, split the cleanup logic: always release the
folio_batch, but skip the memset() when ret <= 0.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/iomap/iter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index c04796f6e57f..91eb5e6165ff 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -15,8 +15,6 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
 	}
 
 	iter->status = 0;
-	memset(&iter->iomap, 0, sizeof(iter->iomap));
-	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
 }
 
 /* Advance the current iterator position and decrement the remaining length */
@@ -106,6 +104,9 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	if (ret <= 0)
 		return ret;
 
+	memset(&iter->iomap, 0, sizeof(iter->iomap));
+	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
+
 begin:
 	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
 			       &iter->iomap, &iter->srcmap);
-- 
2.39.5 (Apple Git-154)

