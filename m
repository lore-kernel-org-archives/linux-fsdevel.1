Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066813;
	b=OxVXRmWPfHgJXA50nSYVfCJn4bxQSO2bv9gxmOrZXnDr0A0cWcM7VFa+PvFaQr7hsSsy
	 iXqbtB836fy109RKZd85eXfyKIdvs88jRnV3eCp+eJtQI9Zty8v6147mvxaRP6Yw2b/I2
	 joj5g1wcfZHwIkmBm3TvH4I9rmeLs6zwlQjY5hZLSVWyHvyaYRBHt8YUSFdKrgvQOorU7
	 T+yMnP4GgAmyailGI/+vB2UvjIhixJrexbrFljHeZF/5fVrX3iHKGtLXyitpxwHxBDBrF
	 9ON1urY8prXiR4/hOHbPW0JkPv2/4OMfrx/Rz6ghYhscbgTll6s59vi9qPWItl2jQxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YrU8dwo+qObApnyB8k+0XisvH5XOHsjnHWT20h+JoTM=;
	b=5D2rBoOblCyXXlYS35t59HdaoxpcSuoU8VBTTMYAfLBIkvlWJfBN9GbGciRu5BW4jPip
	 M1ETRKkxspoOdegtAhBZPslOxd1S4rVxDMnnesSy4jsdXh46300brFgNmsDnPuSFTWcck
	 qQau85jWmK4pr72yrFSqaNvoxXxeGJbYVA1grzL3UUwBlpr9CZvPg6ltdQyRxZ5drC9Ni
	 34IdQYKxGBJa8k6mNPD0uE/j8G2M58odYDT9ynnu9fU+Fy7hx54FCUJ/L8eNVDOGSOW5b
	 Nz+70kDX26txHfpLhB3ARq2kPbKTkwzymespjG4sa4xirpozmaDX8L2I07kYrCnpS2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eItNKoKC;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC6606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 05:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10FC6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eItNKoKC
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-381d542bc29so3436660eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 21:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795066812; x=1795671612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YrU8dwo+qObApnyB8k+0XisvH5XOHsjnHWT20h+JoTM=;
        b=eItNKoKCi0OOKEyUN53A2E7NPrPnl23vAdEDt08n5d2gdZcNhIwopmPvYj5pV7vrbM
         GQv/vd9kelF3yYP1H+IY+Igo2TO6zIFbY02P5/lPijREJZnaI58kE8PmwNMQQgW6Pg91
         2CKwok02wmp6qC7GHplcxsJvDBAGsPstNE3Jk9VYigTEgLNUt8kJ2M5zwDmb7zsZivNO
         msrkV4TYDS9Jh1gVcb0z+HyfqPZsiAxAMPjyFj12Lw80xDx1CyJ1h36yP0c0ThEGPmW/
         N2Pp4Jv8DXgi3VXYSP/miQfU2KicBi6ZTEY1+cJV75bq2AbX/9c7OFdDMliQNhViGnDp
         xLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795066812; x=1795671612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YrU8dwo+qObApnyB8k+0XisvH5XOHsjnHWT20h+JoTM=;
        b=bmUqwwg306CD0OeQvqmog929tQnk6R0w6Q4Wh1ddB3t+QencciwWl7LTh+NXxVsgnB
         kN8WTNhVKuK8NAlz9aMSypqheICXpC80Ss0t881/ShOA7wakTX2D3efAEsFR9syD4H63
         dWswdnbQ3/O7Q9wbtRrvkFpUgj3UT/xvKTUrjcHFXV01yGu4Km4Ae9+4QNX7nJ2x4WDP
         8hSEFaHyyUVfGRJAE//2lRc2oSUsARNC87aOIEgMaq+yBfg6jKMKwEhlcoTiolx3BonH
         hKCzYjuD6R9VTqjU3/d7OHSlS28UAreuTuwDxgbnZjdpextyZAbqdGTde8bdw2B4q0R/
         S0xw==
X-Forwarded-Encrypted: i=1; AL+hErG52S2oQZSj0crunwMB9XsG12Qvpxg5xsLSZPrgG17fs/TTu92xe9mBh+4wVDNswLZqBnLtisIIMMYp2M82@vger.kernel.org
X-Gm-Message-State: APuU4Z9psuX+g1YsehFl+S3AUv6pKRqiG4yNJy4dB8cjgvro5+QaVsX+
	qO22D7jg00p5nGja8nAgSCtJRMRWjdcGGFp8GybKeHRtlT3IXJiTEm9B
X-Gm-Gg: AZFdTZewJkSEaBRNp/2Kssg4wOYY9hcZrpOZ/EpUZ2gsNnaVZqabQjyHuzVS9UuEmCZ
	VhhPClRl+IVVFIgTL0fYYS+sPARxdWVqOu3Wtb77i+tVT+EE7SaHqDP1ucfj0XGrvuHB08BWIZs
	c9+FRK/n/FBloGmkkera1UGXCpoiFC4+sNYJNg825W1JLMmbwAXTsQaVGFmrIvNvORpOQE92L26
	NqmPZLL+UQv8YFNkYHNQBfvz9eyQK1VsAYL6WuHtA3ImJxy88rcHAkRQwWWKoDHpfgkFzUkkE55
	O3lRE+vALQZ7EFfZkG55a5Z0aSo5ikHklUEaDW0zLU0Exu/+goqXIWmraGeE9wzO96YsYjdBNiD
	VcWwpi3NTqmwV2GLER9OcacNjFOhlOcPrANnMgcZKklaSLA+o4VwMqDl6jarRpgu+yGgFLn51hR
	vJSr4vwFijKPz7rL9JZ2QBW8j64mgOpLIXpZC2stFZtyt4/+9VN8Xf+xP01RE2YH7+ofnqsEsvv
	pxinaqSey+vqykHBKuS7SQJqZ4pfy/1E3sz850DmFoANAYb0ayty1X9RK+HGAEi1BWu19TSOsBV
	NOephtMH+PQ0ODhorUmCtjwIQtO0
X-Received: by 2002:a05:7300:b2a8:b0:375:e4de:96d3 with SMTP id 5a478bee46e88-3828171b0afmr5075315eec.31.1795066811908;
        Wed, 18 Nov 2026 21:40:11 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:98ed:c5d2:8a64:170f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6304efbsm22090590eec.7.2026.11.18.21.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 21:40:11 -0800 (PST)
From: mdshahid03@gmail.com
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v2] fs: sync: fix overflow check in sync_file_range()
Date: Thu, 19 Nov 2026 11:08:27 +0530
Message-ID: <20261119053827.69933-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use check_add_overflow() to detect overflow when calculating
the end byte of the requested range.

Reject negative offsets and lengths before performing the
addition.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 fs/sync.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4a84dd837b86..a1ef2b619cfc 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/namei.h>
+#include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/writeback.h>
 #include <linux/syscalls.h>
@@ -233,13 +234,10 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 	if (flags & ~VALID_FLAGS)
 		goto out;
 
-	endbyte = offset + nbytes;
-
-	if ((s64)offset < 0)
-		goto out;
-	if ((s64)endbyte < 0)
+	if (offset < 0 || nbytes < 0)
 		goto out;
-	if (endbyte < offset)
+
+	if (check_add_overflow(offset, nbytes, &endbyte))
 		goto out;
 
 	if (sizeof(pgoff_t) == 4) {
-- 
2.43.0

