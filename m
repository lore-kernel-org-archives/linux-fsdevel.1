Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550023;
	b=2nk/Rf3h9bTUw/G1lDYWJBX7LDLRGK0uK4GaldUHZPteArUOmeEH5YcAkeeUgSXmwliC
	 5wtAyT/zjLOJistVrULafIIhTRGlKp44cLYBSYLJch1TNLeISAHWoyfCqP9qiNFarzHNR
	 Dr0A2Qvs2Tj7xh26g/92ukTFoBdB3HnZ6eaFFDWbQ3HxZYrpU779M6VHW2k+nReeidEKb
	 CEv+/0yACqYG9DmsSCKJ/UhxhMiE/if/MPJUWHyNrZ+zkRilGevkjJE0m5CzOjuTn/Z6x
	 1IEMe3dm2wcJjNabhShxouyNBMd/O+15rhiNmT+B7ajSi2rG9Z3JDp7pusZDztBHByw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6HADbYKdu2xT306wyzwyhObff3FiZPnfdL83SuaIOyY=;
	b=YtgX3mgHeCzyZGUJ/nZvmmb9UUAg5gYtOp4dsBP42m9BU4RaHVN0UmDqInxuPPoz+H9r
	 mS7Vqk3pGX1NvLjt7mQuZzjZR2ZWXLCEzt69/4jbkzM/SLfzgOK36fTPStX5NY/Y8IZLO
	 xPIQyIUeHJbO4oZIcOXVeJZy4xHqya73Vbi4SEqO1FAwjFgzxWQNtvQdVCwbj+ykoMARw
	 OYLEjBa8dn7wf4diQeDMwLAhVbjS9/iWMDanGbm9cKNgPz6PJKyaNuNJpoflJrtDuBKJE
	 AsnVstU+mo8Jttdj+uOqjZN9x1lHNA5ov7BMZ8AKfkp4fOhFQYmBF9FgmIQ0Xl55WSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=t1QEptge;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B02606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B02606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=t1QEptge
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-491971ac844so4509789f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795550020; x=1796154820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6HADbYKdu2xT306wyzwyhObff3FiZPnfdL83SuaIOyY=;
        b=t1QEptgeWUV5vvPcoMi7KuXUdZ3iJM3BsXI9pLiiSIn1uVRxP+askR9LrNU3F05bRa
         5VmEoZRfanUqd5B6ZZVI/t4lsIFvN+IKyp1qwKuNDQjBkum66ZeOVtKphbs/BzyME6qi
         1TSdHgj6KVKkCTA85aUWDEzEz3XdQCRkYpctqABhSd2Cu+s1bX/pBH0OwRHPKI9jCXf7
         eEHsWy1ullx1k0tQlQZPYNF+DzkwGy2hKp9zRQfgRQTGLt0sf9Lwxgv69HHgA3M4Ez28
         f9ftGdA/9gQSAqU1a2HVbt9CZEs8tx7EzJMWc+5+jwNav0xnBNl8+lgqFNp1/VyV9dt1
         /Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550020; x=1796154820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6HADbYKdu2xT306wyzwyhObff3FiZPnfdL83SuaIOyY=;
        b=aUav2vMtTPQri0eJ4n3GUrk3VFuQZkCo9adRKG8n6oOp3vuackw/sFE2l71WbZXhFl
         GRyysO2dG2+MaF0KK0j2OitHcQ+dZTy6la1x7L1mrLwKsNh4XMk0mKpfVk5nWM2R9e51
         WXu12FWkoHbJRRWZxoaeDQ8vK5ICjD/AllViKf+FaT3XXWVjBWrNdBO3Dnox2lg1BZTm
         W0podOAb8PfbLAFtxb4MQ5aM4C6rgCitA20DOuhxRqyjEQUvw6miHocfgkDUhLTACqlV
         8W3nGuBYEcusqET42DTzhabtVM/A/J7iodhiYQeOiMx0hMwg1Sh7YQc47kUqDs7duExT
         AZQQ==
X-Forwarded-Encrypted: i=1; AL+hErENin899QSnGLTZ8z0XzyR42F1OOtiM3BvBMMSIoGchC5NtoTkTaRkbUOkXZLbCSA59FDiKIv0BEBUPV0O+@vger.kernel.org
X-Gm-Message-State: APuU4Z8GEfbrcrmAnEh9rqcSYwKQi0hLrIvpLZr+5FHIBwGDQnOdMjz4
	Ak09xfEQjub8LzNdcCWLEwP8RVipuEIVSc/o/cH8ov/NSj7ZmYXSYykEuiqmle3WGEq2
X-Gm-Gg: AZFdTZcagfex1CKei/YcZ8mkYHaPhHi5P659uhQ/etMjLpoL5uIIPWQfJyJp1ttC1GS
	d5RV8ZXcGBOh5QHOZ+DLGIIo9vINHhqH9EZ1MjRjSHnXxI8aqPsqA13KC3KR5XTP2wButLsrbau
	OT2foe5XLp9RJP3HZY8zm6VyaIH17Ny+8cgKJw/vmpWeksY+Uc9DDgyqZpPlvEWonrRJ6fD2Hxi
	C5DP7Xz0HBNsvYu3DAnQ0DWuPvRFd0vaAW5qf+FQA9zu6pbPh11xs/3esxtSmIYIeAQSrM8uC1z
	Q+bHWwMcr3c6HhNZrYx6KkwOZtX6tpZ4F/i38Id5MiB2jrHLIbIbCJmFaUAUADUFYqCdZTa/xmG
	MbCjwdrkgxwSpMwkUvNxdjmJu9safk2zl3OU11sk+qCgLzXjcIxo+lRAx33OIHH5zivG07P2caq
	oRzAypw8A5xRlrvcDGFf6h0evMUCMtwvBPcCNsui17FH/9LUL9y7hh4wfuvH+ICLx0jihf6gXQ9
	SWmYcNTdzCfGKErXjt/q8r17ze839V0aARyQml4JCWZU73hvt+AInXA5O8ZHuM3ge773beoK88L
	SL85FSr5o+RCvvTdMRq5Tq1j+5AaTmbnaDzBF08v7fqZdmtdfG9ehIbBW10me4fp2Xnm3X4l7+J
	6ZHHP7sCuWvlqDTTwjP5JZOawxBz0xV4biiJS
X-Received: by 2002:a5d:64c8:0:b0:4a6:c5f4:cdf7 with SMTP id ffacd0b85a97d-4abaa976b7fmr28138906f8f.5.1795550020484;
        Tue, 24 Nov 2026 11:53:40 -0800 (PST)
Received: from alex-t14g7.lan (p200300cf572c2800fb4fa6aa0455ce36.dip0.t-ipconnect.de. [2003:cf:572c:2800:fb4f:a6aa:455:ce36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm30245471f8f.58.2026.11.24.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:53:39 -0800 (PST)
From: Alexander Mikhalitsyn <alex@amutable.com>
To: code@tyhicks.com
Cc: brauner@kernel.org,
	ecryptfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>,
	=?UTF-8?q?Frank=20Hsiao=20=E8=95=AD=E6=B3=95=E5=AE=A3?= <frankhsiao@qnap.com>,
	Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: refuse pseudo filesystems as a source
Date: Tue, 24 Nov 2026 20:53:14 +0100
Message-ID: <20261124195315.105369-1-alex@amutable.com>
X-Mailer: git-send-email 2.47.3
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

We shouldn't allow pseudo filesystems to be used as a data layer
for ecryptfs the same way as we have forbidden this in many other
places like loop, erofs, nvmet and acct [1].

Link: https://lore.kernel.org/all/20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org/ [1]
Signed-off-by: Alexander Mikhalitsyn <alex@amutable.com>
---
 fs/ecryptfs/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 5f37cddb956f..471d4aff0e7d 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -500,6 +500,12 @@ static int ecryptfs_get_tree(struct fs_context *fc)
 		goto out_free;
 	}
 
+	if (d_real_inode(path.dentry)->i_sb->s_iflags & SB_I_PSEUDO) {
+		rc = -EINVAL;
+		printk(KERN_ERR "Mounting on pseudo filesystems disallowed\n");
+		goto out_free;
+	}
+
 	if (ctx->check_ruid &&
 	    !uid_eq(d_inode(path.dentry)->i_uid, current_uid())) {
 		rc = -EPERM;
-- 
2.47.3

