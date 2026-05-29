Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DAB3CC334
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050878; cv=none; b=urs5gQbMRIqwTBWbH8/lx6pM1TgChiYXcl2vL4431+J4GACsw/FZGm6WQNy95+ZXowMbcIpHGP9uXQlSI7qQPTOy8LRhVSFZksPLpj5jhqbZ0IH+5mFpdrXlQ/Ab/DUl1tde08kBGiE8NSH4AsW3k0MlYLanlwzhC8Rm2Mf7A5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050878; c=relaxed/simple;
	bh=D4zfUYIEN/mIaPy6DoDtc6mWSSCyswWUAMZ2tPkZ+ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEqayvfOFL6xut5JHKZdTqN9EOtg9Qq+u6TyXKUIqGPQ2Ddw7WoiqKtRuJ/7oxPwIFOLtBq9AMuS+dgwSEiopFIiTJLi7/4MiSB1eC7PJJroO/Kex5NU+FNy89IcfVl/+KSEqvvcscYwypYAhDOofm/PYTghUd1ick/k/nvJ51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRIthMbR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRIthMbR"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so14384206a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780050875; x=1780655675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3Z726G551crwtbnFq7Jxy9FfHStJjoYfTJWDW9cd50=;
        b=DRIthMbRhkXBf2hLHm93qxXWpAQlzz5do8v6lH6toRZ+QtmmLM6Wr1Hs3vzS/qSW8k
         CorBA+mGc9hYtmwG2cNj/YYps+oJd1veKQk/wAIuqREd+xKWLwhYm4AZ9KsNmsdnP6/h
         WOb860HroBlB4LE6C7zs6g4YsoWcr8UwB9CIgTpMiy0/grCKfBspuCy3GtkG4KLBG4ej
         SYndR+ttxB0rVNNlWVBr6gv6zBNMjjHoElnFFaR3K7q+Vp8IcOo8PORAsHTxYovwKPpH
         XSEA439TFnSjVLlZ2oOQzDlD4WPv07W16IKrFXV4DJDkQVSgTH3ZMzvXWEQmf5IMKy82
         TLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050875; x=1780655675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c3Z726G551crwtbnFq7Jxy9FfHStJjoYfTJWDW9cd50=;
        b=a0GBim94tIJvzaUGJ3dKohC/7PZcLkxIQb0DZFq558BP5reO/Yvf9Oh+4rb3YcGJd6
         N9x92sTnM6PV6/dQNPUXHRYs4NrrWGTAYFCpJqpQcj+5w6Kzq2bGXPyg80/tDwa4OZbx
         I+na+I5sSIMaqFArSMZEnvFnHqPQW9Jjixl0aI4QZFywm7GpAN4PObk4qG+XtaBjKe6d
         o9srBWtWGoqK1/RWg7muTitAUVQPknfu9hNQtltT85PpL7hAi/KevRpKYXJX4DCgb66z
         Ix8tSVrNHNWcAGQJ+5pusMIvRARLFUNnRrDvLhNuxDFjWBPdDdcpNknntTXxZrweyFR1
         2BAw==
X-Gm-Message-State: AOJu0YxvvexY8EPnYAq/uDik+p8B3OCl3Qh/R4wN31O00lcyA4ToHh1F
	nkfCESLZogKiK/Ecz4nWmrwY4LfM/gJ+gY0zaqWpBaHuv8C5yLWcgW2K
X-Gm-Gg: Acq92OHzbnTQBDR34u0fEF9xiB2rOtcmxaku83lganf3XtuF+YttFGCBpCzEA8602bv
	PgMmrwo8pFV8gN7JiUHz7h2LKMSdiYwdO2BacQcpaxkVubDBTYmOFJiQ/hSMh44jrn+SfTJDosr
	Z1n4kFpbTYbij0w0git1yRQ87QB708GyyJg341LWVrMoXJemGUEbWrqDSp4rTGEzkj2tYl03w6F
	8Wq3h9h6BBNcGtfjEC2XLO2JmqLJ6xFDDCyNP1h0PahVudhzhIpepmw9k5DMPeB36HcRQEiFgHu
	gBMwkXw6uQyN0OoR0hY/dBVWMn9YeORS9KMuTaMpZ8RC2msjFxntEw3nX8c01ikbhgLEDEAW6Sg
	qk+7+ErR4vl2Y02CDC4fqPN1gQlmmzK5HOAzDs80j04CO6+jqad0QINUUUTMgh+MN7cbceVT0MT
	kszyoUPTR3x5mJYQRtMS9iAS6OynPWZ8C4umlIGQSyxVdTfQ==
X-Received: by 2002:a17:90b:3a50:b0:369:a359:b192 with SMTP id 98e67ed59e1d1-36bbcc160damr2878751a91.10.1780050875433;
        Fri, 29 May 2026 03:34:35 -0700 (PDT)
Received: from gmail.com ([218.106.182.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfc90570sm1827392a91.4.2026.05.29.03.34.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 03:34:35 -0700 (PDT)
From: Yue Sun <samsun1006219@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yue Sun <samsun1006219@gmail.com>
Subject: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
Date: Fri, 29 May 2026 18:34:17 +0800
Message-ID: <20260529103428.99099-1-samsun1006219@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1d26872db999da42b2d8452ace8a98b79e569cc8.camel@dubeyko.com>
References: <1d26872db999da42b2d8452ace8a98b79e569cc8.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_mdb_commit() writes the volume bitmap while HFS_SB(sb)->mdb_bh is
locked. A crafted image can set drVBMSt so that the bitmap block resolves
to the same buffer_head as the MDB. When writeback later calls
lock_buffer() for that bitmap block, the task tries to lock mdb_bh again
and self-deadlocks in __lock_buffer().

Reject images whose volume bitmap starts at or before the MDB during
mount. Also guard the bitmap writeback path itself: if the bitmap block
would resolve to mdb_bh, force the filesystem read-only and stop bitmap
writeback before taking the buffer lock. This keeps the deadlock fix in
the MDB commit path and reuses the existing bitmap size/writeback logic.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/all/CAEkJfYMB47v1yOWHB8q2dc8kf=uj-rLO=+yMyudwPguJ8Kd3jA@mail.gmail.com/
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
---
Changes in v2:
- Add a commit-time guard before locking bitmap buffer_heads.
- Replace the mount-time byte-range check with a simple drVBMSt check.
- Reuse the existing bitmap writeback size calculation.

 fs/hfs/mdb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..53cd137892b5 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -185,6 +185,11 @@ int hfs_mdb_get(struct super_block *sb)
 		sb->s_flags |= SB_RDONLY;
 	}
 
+	if (be16_to_cpu(mdb->drVBMSt) <= HFS_MDB_BLK) {
+		pr_err("volume bitmap overlaps MDB\n");
+		return -EIO;
+	}
+
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
 	bh = sb_bread512(sb, sect, mdb2);
@@ -341,6 +346,11 @@ void hfs_mdb_commit(struct super_block *sb)
 		size = (HFS_SB(sb)->fs_ablocks + 7) / 8;
 		ptr = (u8 *)HFS_SB(sb)->bitmap;
 		while (size) {
+			if (unlikely(block == HFS_SB(sb)->mdb_bh->b_blocknr)) {
+				pr_err("volume bitmap overlaps MDB, forcing read-only\n");
+				sb->s_flags |= SB_RDONLY;
+				break;
+			}
 			bh = sb_bread(sb, block);
 			if (!bh) {
 				pr_err("unable to read volume bitmap\n");
-- 
2.34.1
