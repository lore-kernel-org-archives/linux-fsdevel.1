Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB67332EC8
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114780; cv=none; b=u5sz/zPcHVYkGop4iWUX8SjvcdyXg9B8es3RqMStxg90b2dhs2kd42sHD7T7L3sWvKTqrxkszo/ms7d91pdKc1DlVkSt4LjsAW9Ms7e3Ohg/wMFNyqFQbBVOn486s1KVXWbALgtsECZ7A6WDBAaH7tvTN5sn0qdQPnKpZc1HAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114780; c=relaxed/simple;
	bh=zhwHBvxowx/CDbJvKJKLuT1kONQfkrgCboxl/nz+Drg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRgZcHcnnbfNSt70PyBPGsW90GbxXHJ5g7Y/RxHoZXBVSKWx/MosoB4hZ5+ms3EQnFJ0PEF5ye/wy3zpSgr1ULnp1lsJq6IBiURmUu1PYexS62RzqvLQ20HazevQHgljVEfD+Kr6mDW+I0TXH3Oh5QqfDnlPPGt4xBYS/1Ihkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMjQH1go; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMjQH1go"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50de80b9567so17111371cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776114778; x=1776719578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRm3QQarp6KprRAVENXxH9rbQ7MVgBtYRP8MX65QUmA=;
        b=AMjQH1goATY7LUP4WqBcAx7uObXy2Qi9B5Xhj+atCj0wOPzTi5rqvLaDmhr+7Puguk
         SEQ/THvmInMF2hH2AHJnngTTNh5N8Qrhj4GqpHqCf8W92E5udlHoSe94GDtj/+YkIJBY
         EblrsazoKIY/KCQL3NwrMKr0dwdDpaS2mLOKz+uJCfRe/6/wMuFAQXGB60HYpMjYJ1Xs
         s37v8jdO44MH/uHIZ0KcYNjDTtZ0cJ2MIXqv833v3dva47YP96NBCaXtE0ojcH1KkrHv
         0JK40uZ7a9/i0sb5Skupc2kOyLeoFIiNrcgQYE3Kr3OhWayOGy+uQ5Mlpb8Q/MNYDKyt
         X61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114778; x=1776719578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRm3QQarp6KprRAVENXxH9rbQ7MVgBtYRP8MX65QUmA=;
        b=ba6Ir0v3BQzsd6UsNkWTTzDNkY1cczJBtHPB3dXfJqQ9/OyQmCZs5Eu5IReDJSeX1P
         ayzADmBL4pNnG87DROzuKIlK8w1Mok1aa0QGUPhTV8XYsgksVUODDu3zXfl8Ebmz9yLb
         ktdCVtWAjXYAnyFO41/0kZqCrjWPGe3YrOuXvL1cBfPBqp9M0FI5dmhh5d5b2muupLfj
         DA+yXYMPfs+vusC3JHCUBIpeZc1HkREAGDVoj+v+18r9um/fSBZNpyJcHFqxDzvpOyBx
         NowwT9vZ5rsBTzT24BVMSUjPZDF0+41JCQBSNbBNWHqh/iIykwTtnK858o/AgjSuupNg
         iLkQ==
X-Gm-Message-State: AOJu0Yy7ztV3UAQBTclt6hGjBlfxgEy7EX1XR4B0+9UayNC5BhAB7J7U
	hDZHqYYfFVwP9bGtHpjjceVlPiEkWuWyr6tU4GVNIFZvVSC8PuzCBeCH
X-Gm-Gg: AeBDievPAx0PXi9da8tL6d1tSWUXnR64kGpuH4pazZ5itSEmQhrsiPDOD95AdiR1znD
	D6pr/j70dYuvh65bs/qZHq86+WqIfIWBviPzX9NfyLtGJOOLe8O5ic2FierOjVpQhqE5LCZ2Mqp
	6dmFmttf82490cXVlnOqrytCQTqwUnpBsSsGgd4JLxN9r+RTz5heGCktg2vI5TE9yXdDDa3rElg
	oTSHpMSMf94iFcAjUChbR42zBJ50/MxUQmXaZik44lh0sQSLZDwrcDeLdUECmanHaK/zHd9ncoF
	+ro7sqmC0+ph4WE9GrUZZcPEgRNa+SD1QZDpgerOE7SXOUKUO4bULTb9FSO3dx2xU47sq9VkDoj
	XCRvPbNgYVD6OyGvo9tGRTgm7Q+TmT4CNVbt1i8vG7ObxvOgge62FlKiWEZRr5WMFZEw9qkqVJt
	a+mronCwbBDWjYRyqSw6+XpsMnzjnmMYSFPgHlz6bUOtrloftDLsMWeOiMQ2fcs69UppenuEkdx
	hcPatGr5t76hSxzcNi99UFQx/XdNTg=
X-Received: by 2002:ac8:5d13:0:b0:50b:4726:f152 with SMTP id d75a77b69052e-50dd5b346demr220545431cf.8.1776114777966;
        Mon, 13 Apr 2026 14:12:57 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b3f3sm95998551cf.2.2026.04.13.14.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:12:57 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] udf: reject descriptors with oversized CRC length
Date: Mon, 13 Apr 2026 17:12:40 -0400
Message-ID: <20260413211240.853662-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udf_read_tagged() skips CRC verification when descCRCLength +
sizeof(struct tag) exceeds the block size.  A crafted UDF image can
set descCRCLength to an oversized value to bypass CRC validation
entirely; the descriptor is then accepted based solely on the 8-bit
tag checksum, which is trivially recomputable.

Reject such descriptors instead of silently accepting them.  A
legitimate single-block descriptor should never have a CRC length that
exceeds the block.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Found during a filesystem security audit.  The CRC validation
condition in udf_read_tagged() uses OR logic: the first arm
(descCRCLength too large) short-circuits the second arm (CRC
comparison), so an oversized descCRCLength causes the function to
return the buffer head without verifying the CRC.  The descriptor
is accepted based solely on the 8-bit tag checksum.

A crafted UDF image with descCRCLength set to blocksize (e.g. 2048
on a 2048-byte-block filesystem, vs the 2032 limit) in both the
main and reserve Volume Descriptor Sequences mounts successfully
with corrupted descriptor bodies.

Reproduced on UML (ARCH=um, KASAN-enabled v7.0-rc7) with a
mkudffs-generated 20 MiB image, both LVD copies patched to
descCRCLength=2040, CRC left stale, body byte flipped, tag
checksum recomputed.  Mount succeeds (MOUNT=0) with the corrupt
LVD accepted.  With this patch applied, mount fails with EINVAL
and the new "CRC length ... exceeds block size" error is logged.

Reproducer details and UML console logs available on request.

 fs/udf/misc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 0788593b6a1d..6928e378fbbd 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -230,8 +230,12 @@ struct buffer_head *udf_read_tagged(struct super_block *sb, uint32_t block,
 	}
 
 	/* Verify the descriptor CRC */
-	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize ||
-	    le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
+	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize) {
+		udf_err(sb, "block %u: CRC length %u exceeds block size\n",
+			block, le16_to_cpu(tag_p->descCRCLength));
+		goto error_out;
+	}
+	if (le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
 					bh->b_data + sizeof(struct tag),
 					le16_to_cpu(tag_p->descCRCLength)))
 		return bh;
-- 
2.53.0

