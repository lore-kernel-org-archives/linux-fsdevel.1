Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311355;
	b=oRUsAPYOMRZypW3Z2IHkUVb1mdSRmVQWIrqdlTbwAlsOehlul74p3EbXHA5X01cRpu11
	 hlmqkGZ3wSVMGW4sCw9W7f6yF1bIzUDRy76XDtmhNrN57MNsYpxHJ+2qn+ZHA55WJCcjB
	 U92ediSA6gMAoNaxa6dH5w9QaaRTgAYZ0yKwmvadMAZ8kJmQxOEDBMXm3wMSvF+pdU2ix
	 u/DTQPFEE64hd0qwyPYn/LrO1M30/PMYjz4nv2CnZ7hKhnwjA7xGVFadSGGNEQq4LbME3
	 jVlQFhxwvS37tnXeW6WOqZKtPkhurVxQ1WnOa+aSsiMzeTQFD2oi1A8qZRAmeh29vQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tqi07G2NK5B5Re2GQGo+ZSlYw+c4Yb95iVdRzLGMPO4=;
	b=oIZyFV2ypMg+AehZhBvyEn/HxTG+lyXtIQc+xLwASCeGv6sTHPkMm1oHfb9B/0DwwGoo
	 YQgvjOsuHJSkd5yVtye+Cd0ogB3Xn6IK8BTW/1k2N4J8Tb7NkQbdz1zEhOmxxlxmo/JkH
	 0dNzTQnVwtLoPVUiG47MZV5ULJHB41Rx4j754Ap7kX0OXu7y4HrHSsCZU4bdGvO1Y2R+r
	 1srMeffbCqS+/Xc0C2j+n/DLs/6TuFtTgAt9PA7U0t4+HqiGrb8NByjZkzhFGbQjbXy8M
	 bH7gEcXpuFtjNGR67kpn0om7QR8JYol59nkLDQ1B1b6JyhawQZlC481K/aE74XXef4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EZAcwi7c;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EA606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 22:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B01EA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EZAcwi7c
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-1397ad3d891so9878c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311354; x=1793916154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tqi07G2NK5B5Re2GQGo+ZSlYw+c4Yb95iVdRzLGMPO4=;
        b=EZAcwi7cNjE8Z3elHqVYyVHf5F58mrbaRpdJuodzcKIs2zIDyzeNU7YF3fJi+rKU11
         ZFYQ7deGZRP3GtgLfcUnCE1CozHJud+8cYl5XZJbOTrvDbBTqaeRPT9CIr0DuNKCx3zg
         /fs75bFXju9fm5gr1oxoKpUWPXU5Y1wlETogtVrKhpEPT0Q3UWo71bmzoqdk50zxUZIn
         vI7xgGXQXCjvU7fbasOg6X0JyzcXXaNkvlS3H75K6dApI3GpGDFUzK9V44C/omMh4NzH
         wulFqIBY9jJ+0xb4Guooql37u+WPUsBrLZ1c/6G2ARHXZk8BWFQZ/Zrq8V6zhaAyTx0T
         nepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311354; x=1793916154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tqi07G2NK5B5Re2GQGo+ZSlYw+c4Yb95iVdRzLGMPO4=;
        b=2B1HYxTU04fr1u1dNa7J9gomRTxgfYV6iGdwyjE1hlX/E7qPPyBw1MfzEw7V02X+Tp
         /DcLQmkFJ8QeX89pC6R0fwDZiL023wqJril+zzKV+J/svNmTJB8vpK4GjQS7vey1kcaX
         0kVZvHg2MbwJCUOBNXflrc/44M0cpmuo8JyOevC1+T14jpKTMJ3HdWokOeqKy1sKGXCo
         qi3/PbwCmDnrfZnhm169uFqsBoJpDYqzdHkar134MRZTtTSrDsCfmjvYRoOiSYgUlAwY
         MLo+CN/U3sEueUnW5A3FPj4KcW7a1Qjtf9/wagvhodb9ATa3nnBPdxALA4QkmIYPPiPY
         N/hQ==
X-Forwarded-Encrypted: i=1; AKwUvBwm4+hJq+yRnJJy/pJl7HaWoFewhoaukdiBHNHCLf67odcHESAJZ/LlowRn10qdQp5YTQprismdSRLRIYLi@vger.kernel.org
X-Gm-Message-State: AFq9FYL4sjNluGvxHvB4l2Y/icYDjGZEOXza5OgctVm/vFtRWYGG7sQY
	TGPm1HHACkw21dgfQuA5wBtIY1N+kcL7meaq/un/OKQi+7MVnKZmxgi0
X-Gm-Gg: AYBFou1QUh0zOLq7cJjrmZCitNCuZ0zQhyqA0hQMVd5RkPe38JKAFPZBNOgReN6WnVw
	mC4esvOAMDFE56jeelPRNMONBj6gK8hJyTjUHVecHbDio9uFwJCSajAENQNaXVemxdo3CBk5yr3
	xde3b6lu9xzw3q9Uwjvn7Sg3asFTtI08wk98KF8w7mQKVJ4qrgtZ77SPBQwTdet29FORuft2kwT
	ZBCKxdnFFvwq2zZ4iJUdF16k+kKz5yZCH0I9QwpFetHeKm+iRb1nnAnZkHlcZsdUByUzsk1P214
	YkFZGUKC9ddiVehYmK7/A92TsaYA3deIhajl5NeQDKs+lkdqv7NLLaKrVXcQF0HsmfTn7TLra3m
	Ffox7Dp+Ii7wyX9m8uLbqz7cEyGGa42SEfPfZwULVLg7HPpSfsNHDu+T1Y5A4LES0u15gJ9+F6U
	Cbuac2h5c9LwSH/qv6UvTIKWxQzSAjIpeFCk/VzGBYWCzsUlGl49F9F964+Q31L9ctxM8T6a0J7
	BCctcONQ6g/RnHuSy1V4s/DvVN5RjCCHaNsvnPYAigv8BHpxypxd8UqUuS94f8NewjDK/gHxmxC
	W1QXkkM40h9PRac2vq9BsI286TyVw9oLHA/6GLklN953+Eocq9IrDCmm
X-Received: by 2002:a05:701b:4354:b0:1a2:6b9f:f7e1 with SMTP id a92af1059eb24-1ac5cb1a31bmr472033c88.14.1793311353726;
        Thu, 29 Oct 2026 15:02:33 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm1316007c88.20.2026.10.29.15.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:02:32 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fs/ntfs3: accept unchanged read-only fileattr flags
Date: Thu, 29 Oct 2026 22:02:03 +0000
Message-ID: <20261029220203.80532-1-dennylin0707@gmail.com>
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

ntfs_fileattr_get() reports casefold, compression and encryption flags,
while ntfs_fileattr_set() only accepts immutable, append and nodump.
chattr preserves the reported flags when adding or removing nodump, so
chattr +d and -d fail with EOPNOTSUPP on nocase mounts and compressed
files even though neither command requests a change to those properties.

Read the current attributes and allow reported flags to be passed back.
Continue rejecting unsupported bits that are not already present, and
keep applying only the existing mutable flags. Requests that omit
read-only flags, such as chattr =d, retain their existing behavior.

Fixes: 33f29fc7c67e ("fs/ntfs3: add fileattr support")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ntfs3/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 52e1cd969e06..af6fb438eaa8 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -134,17 +134,21 @@ int ntfs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
+	struct file_kattr old_fa = {};
 	u32 flags = fa->flags;
 	unsigned int new_fl = 0;
+	int err;
 
-	/* Avoid any operation if inode is bad. */
-	if (unlikely(is_bad_ni(ni)))
-		return -EINVAL;
+	err = ntfs_fileattr_get(dentry, &old_fa);
+	if (err)
+		return err;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
-	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL))
+	/* Accept unchanged read-only flags. */
+	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL |
+		      old_fa.flags))
 		return -EOPNOTSUPP;
 
 	if (flags & FS_IMMUTABLE_FL)
