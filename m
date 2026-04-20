Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355B2D9EDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665800; cv=none; b=X6TxrnNdVJopX37MEBX81lmPLa2Y2a4V1hmL639hRwPO5hWizXDFaDMYZxVPrWSTHO50RMzZ4O5uG6H4tu17ICTmQQyXqPGKKHbItKUb5SGgmf7zefJEQtZsoEdK0thIpHnvZOSme2R8s8McKVJ00bB5S8Zn5J37aa1sRQXNhQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665800; c=relaxed/simple;
	bh=l3l5LStnrkBdnCMkbwCq/lTh+1cpa2xztmlxm2P6lrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lzo0bVmsacNUJ1q6LIifOYAXUUievN/6ulDAhv8oPxZ4AY+YfvuG+4Cr7QRs5j3rsaXI4pDYR6s6O8sKw7ukpEhOZ9nEFlBlAJ5YfPOPznpMuffAPPc86m8ImcuFvCGGIgI15oCmWf/GyVLXsWcda42jsvvSjFKUCO8E2Zh3BWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnZ4j5QA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnZ4j5QA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fede2acso15934375ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 23:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776665798; x=1777270598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sq8jVjaQsEQ037YnID8m/bdOr18FV4DJuvGfBEXqq74=;
        b=LnZ4j5QAGU9lxr4ThzR3NWilS8l0d1Wxnb87+ltQeGp4VmTGkP9gN5//CoaAKoYHHx
         XhEfKa9+5jkhV6TNEd694cXefTyv+YmpYxugD9Xwjv2RnS7ukKlYBJNDOr/UfyNlC9nD
         FuUsTjt+39epxCjHPmNEd3I/E4gXyQczOhNluibtmjKLAU9UFa786+XIk+t/AmHJNfzD
         aenFiA/2iNIXVLBnJ/gb2WyLQu/5vk/Hphz2rHR0VGQ+H877Y5ylntnby9RvMuFoNU0J
         5NiSSFzO4ZI6lgWhNOVGfjQoME97zbyDkusHX2HJh216v663dW51mL2Q03c5TnQmv38A
         6jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776665798; x=1777270598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq8jVjaQsEQ037YnID8m/bdOr18FV4DJuvGfBEXqq74=;
        b=PBm913ImjYtKZizMjhWlr3eJ2HrJKABS3+h9trVtuenXJbGl43boLToW3XX4+G6LZt
         XQICGMrT0W0tEDbIDTkZ26UsW6lHFMAucHsZADisr+BMnSYCsBuMVZpvjp924dTSIXPc
         V4yxIDr059o2A8+oo22nkjrQXhZLCgc7+gQ0uCF6qQC73rOJEsJsV3DY63lIbArTRa7S
         Kmf8xVvzkxQrY9TkIYy48BI9uwAjOMqrXWO4DR5PNTF4TEaxznx30TQDe4Iho2oJKcZj
         kmTw0qcJ/7QCSxaMXnpyTMEfv9UHd4t+RRIMOsAovA/GpV2T6JFL+MOUQ6Gjd8H0K92F
         M5pQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gN7Xl7VZxd/G6dsmuOxm+3+FtZR/Fl9rD9/jGzFxFZL0xR4FnJnyk5ldBPVSYGAHrsjQMbQn+uAAyxZV6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hN2Ko4+23nK+Fp9jrwhxzIgQzMgIciZDzTRDOopLZGe+apht
	DxD2ua2DntVo6x9LMGv4BclFPHKoZZOhBEw5ury6QcAvWYyK/vk8mQ3Ckpo/89xmnJg=
X-Gm-Gg: AeBDietSLPBeXqyaCPwZ0TmGn2uQhqVu33VGmI8MPYchczZ5qbmt3imppMDZDg3L2IQ
	7St4fBEEHP4Q+pno98E0D2giLUT00tgrgZCWUsTbVUwAT6N42qL4CDZifPcY571+bBf0U8mK58Y
	6yZCvIS2YJ1HlMjXlOxKd5wN16KtH4Y5gUtzd5yeTxmj8+FjisCy+KHS7oVNEBmb6eKr2AvGJk+
	Bmrb2o2JDCAY4cizV+LEzkIaPlBr7YHYJXM5rtsMqJhIIj2w5eSdX5umRVo/bBU1FHBtHDWNlVe
	5vVRpslCL5fCf++wQ3x+TVFklIbxRx1vh/MRIYQOQA8tR1ZUJICtV8uAkyOYWg8RbOUhLRsamBm
	la9jYTf38CDGPmBmWa89fTpLFjKAQ8Amiok7TqhuMOazLM/JEu3IpfBNVykWxyhNaf1ehjCX/Y2
	1eqrhTJLThaWgE7Jb8R60Hp8MgW9nij0TB1Vba+CDfiFa8RWlpeGHYU5NOeeM5Iux70A==
X-Received: by 2002:a17:902:d590:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2b5f9e8e4a9mr122014005ad.1.1776665798486;
        Sun, 19 Apr 2026 23:16:38 -0700 (PDT)
Received: from localhost.localdomain ([2408:8740:c4ff:1::4])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b5fa9ff8d6sm88586055ad.1.2026.04.19.23.16.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 23:16:37 -0700 (PDT)
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
Subject: [PATCH v2] iomap: avoid memset iomap when iter is done
Date: Mon, 20 Apr 2026 14:16:30 +0800
Message-Id: <20260420061630.62077-1-changfengnan@bytedance.com>
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
 fs/iomap/iter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index c04796f6e57f..e4a29829591a 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -6,17 +6,13 @@
 #include <linux/iomap.h>
 #include "trace.h"
 
-static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
+static inline void iomap_iter_clean_fbatch(struct iomap_iter *iter)
 {
 	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
 		folio_batch_release(iter->fbatch);
 		folio_batch_reinit(iter->fbatch);
 		iter->iomap.flags &= ~IOMAP_F_FOLIO_BATCH;
 	}
-
-	iter->status = 0;
-	memset(&iter->iomap, 0, sizeof(iter->iomap));
-	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
 }
 
 /* Advance the current iterator position and decrement the remaining length */
@@ -102,10 +98,14 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 		ret = 0;
 	else
 		ret = 1;
-	iomap_iter_reset_iomap(iter);
+	iomap_iter_clean_fbatch(iter);
+	iter->status = 0;
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

