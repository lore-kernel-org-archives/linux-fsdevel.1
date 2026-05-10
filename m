Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E53B47D0
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433091; cv=none; b=qDFx55KnMxlEmtvuQepDT5YYDJlrY//Vl87Xfvhf7t0yIPaShSOo2fmlZdTZZJZw4ws2qSMW+G1sDnfR2oWOxsNMuv8BvGFWsyhewg7k8Q+GDlwN8NoF71okCG1EH3b3Ak/Y5CS9PAcMLOKP/2QRO5zJLvgBi+aw9GsWg3s1Xlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433091; c=relaxed/simple;
	bh=J0UVZS/j22fmCq/e+oGynnmq3o9/DGb8VlFN8JoeF0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahcX3IJU+SgDkqtVwX4vKa3jY31kcbURNJ2T6a5uAcdtaU1Ysnd2dPCzdcAHtFrih8Oot1vQKZteQeJAkWEP7n2yWy3ksrsaRGZGqIHm2Og91Y2Hkf9CgaeMmuhc2RgBzwFtlJILNQRWJD0NsjJhQq2plVJh0aOS0db/XXoTnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftYOohDA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftYOohDA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b95a78a11dso6318815ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778433086; x=1779037886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXD7XPslQy4RCgTc1Odfr77PlnVHB0PjTBKNtAuamEw=;
        b=ftYOohDAw/PZFAqCPCyetzrHRhI5wRzYacHFrjEolDcczVoYg5w0sPAL78qY5XSXiK
         2qivVzZj+aKhQjc6Rd3612iaEq0duds+QQGOvSI94MrFDPRCkVRXvrEncBSK3wisTmQA
         +fmiM2/FBEMhS62fL0ynPO7+UFVxB+hx3DQXf7k8wETn8hsQYH63Wbz3QB9y1mUs+47i
         g43MX5eD2eMUkJYAPuOixCiOebioEq2w/tVx8dfH77VGgxpkkdLH2I6WjMfk+IgnZj+J
         T3f5XsEP3FYCxVPkPnmTc4g/X5+2hRUu98unmeWiWhNO4uQDIJyXa49YeWj3bLht7LMZ
         XCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778433086; x=1779037886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXD7XPslQy4RCgTc1Odfr77PlnVHB0PjTBKNtAuamEw=;
        b=MMEjTxaWIA0Em0bIV7rovSkxfr8XjQQh1dPdfLfuEo7FRbc/ot2VKPqX0K23JBA13u
         N+TK3vIU8b9+pa6+CVjWNX3jmUUYWXikrSsqeiJLoVvNHfRzkM4yFA3stP5MLmHq/gNt
         J+j7qT5oqdt1Xha+IbM8CYAB4UP+PTyjV2Dxo/ybii+ndYsHgMcoiKiMc65BlQ4zf3mY
         0jpBhqiaToRK56nkFTvU6kYirgWdvGS9ju0VokoRBXqyf5lgmBP//8vtsCQ/54n/of/+
         PWVN13uld09yCy5SL8mtC3gcWnxxfKCFpnm3edNyE9lhGd/VDavsg+ZnqkdP9AIhxSxX
         x7OQ==
X-Forwarded-Encrypted: i=1; AFNElJ/a3Ewz9SkjKzlCuUIoaigIIYghcHj9LzkK950joxpNxKvIV0l+zxvmP0lJKuDdybVFVotQ+fVJtRqhrqI0@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpJD9sLODAS7ug6zhQw8WzxC1KIcOjPem1gkgVALzlbkCLrwM
	DZxNXAlAv2yAaDu/D6O5NT9fuz5YbfaByGCZPeIMAq7JL7r+UxI1o7q8GkxeTA==
X-Gm-Gg: Acq92OEskhIKmYrCcwl0anl1Y1fh763UPpomftwfuXIlw9xBjfv330LMoDkGPKgrBdC
	bG+GuXVWirxYuv/CCmsBb99uOraOllFkI6hPBC4b1lQOOtfVdssskhVdnhOnnJlvbzfkNTOVSe+
	RjRBhKdSEWGA35Buv4SfwUf1oXziak0FQdm/OoekFkQI5foakdaEBSYia+6PXFLwqULdO+cMcwa
	UljiEMGZyBr+nIYRJIkj/JRRQbYZtrP7ttiBU4s43EB0iNnaslfZ33fpVo33V9tZcgYpJipkQbk
	AyAY/IRYI/E2zUoKYK0Y+WR0bIEpgGdV/ZH+JmmM+DO1NUOp7zdkQaVgZZAcYw9Z6yuyWBcFPqJ
	C3NpZ5OWGs+VplLpmYh4luj8K8s2rK8rH6Na1gai8M63sGhyhcHAl527kfP8ZDpvOpAXYIZ4Wsm
	fCPS7/8NFZbMeUS5PG
X-Received: by 2002:a17:90b:5624:b0:368:1b68:5114 with SMTP id 98e67ed59e1d1-3681b685a6dmr1894215a91.8.1778433085916;
        Sun, 10 May 2026 10:11:25 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d623fa47sm5120690a91.3.2026.05.10.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 10:11:25 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ntfs: do not mark the volume clean from sync_fs
Date: Mon, 11 May 2026 02:11:15 +0900
Message-ID: <20260510171115.368494-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510171115.368494-1-charsyam@gmail.com>
References: <20260510171115.368494-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_sync_fs() can be called while the filesystem remains mounted
read-write, for example by sync(2) or periodic writeback. Clearing
VOLUME_IS_DIRTY from that path marks the volume clean before the mount
lifetime has ended.

If the system crashes after sync_fs() clears the bit but before unmount or
remount-read-only, the volume can be left looking clean even though a clean
shutdown did not happen. Keep the dirty bit set during sync_fs(); the
unmount and remount-read-only paths already clear it when no NTFS errors
were seen.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index e8ecc52..024d363 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1895,7 +1895,6 @@ static void ntfs_shutdown(struct super_block *sb)
 static int ntfs_sync_fs(struct super_block *sb, int wait)
 {
 	struct ntfs_volume *vol = NTFS_SB(sb);
-	int err = 0;
 
 	if (NVolShutdown(vol))
 		return -EIO;
@@ -1903,15 +1902,10 @@ static int ntfs_sync_fs(struct super_block *sb, int wait)
 	if (!wait)
 		return 0;
 
-	/* If there are some dirty buffers in the bdev inode */
-	if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
-		ntfs_warning(sb, "Failed to clear dirty bit in volume information flags.  Run chkdsk.");
-		err = -EIO;
-	}
 	sync_inodes_sb(sb);
 	sync_blockdev(sb->s_bdev);
 	blkdev_issue_flush(sb->s_bdev);
-	return err;
+	return 0;
 }
 
 /*
-- 
2.43.0

