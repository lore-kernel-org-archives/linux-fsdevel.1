Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0F353A8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738172; cv=none; b=qoGV87m2tsqOUlfIK6PpIpGQtG4LBabZyOguZXJu92OfxxiVhIxvUxAfnd7iXQFSrWDUxhwtgVymJqIQaQj85NCYuQ+p58wZkDfU9L92xdgnsQPDf4mJalY+N3a7mcyb6+AhuhL/fkjSUN10rXe9kO1MODmLJky/9Mz5uDtkxVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738172; c=relaxed/simple;
	bh=cCh5Yyrw+WTMc8LZj6fD2Tm+WKPAQKfaSqn6wwbd9no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7ZyDj6lr04RH4xmStlXZ6F4OH+cRDBNMCZv9iTd6lPBwxQLfeOqhwQr/rWUMQwwK+V1eaFfF1e6QO9o2wFelh+NyOpCzdcTVatqTqGd4FC3AW/Y58ZolwyseOHfSx67vvU4tTWLverRcwmycm1uKraeoWelJCOqYmwtBMSp+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDp0XEMy; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDp0XEMy"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2e22e123350so15870685ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790738170; x=1791342970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvCQxPtK7+AK7DvJPFUusYMdwxE4hgp8/u1LNz01hVY=;
        b=YDp0XEMyh/5RYiT7rZNaffXMRuK7G3FPz3AXgBriNThCzs2FOTdJcBCapZuKD/krK5
         4wXkPcVkKX+ECANwQYuntiEjHaB9sorlZc9dG3GqjOUOqFTHXX4Qf6eHqWIhqexhPzH8
         Gksd8G+glexXTDABU1LuDfgY04W/i02Jzwnp3VjzPJxoPjgwy3rgYQ1vJTpBz2yBU2Sm
         akF3B2bolNjgdNUrO6wnUOqIbbxuAJB7M1hZx7urKiV6rsFXvaMRyh6/Xx4XpikqV/4m
         37wAdr1gNSCMDGSsoF31PbQFI/Omho25kgYkgVaU8/j+VLApXu4yirLbrTKsf+d3gLvz
         B+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790738170; x=1791342970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvCQxPtK7+AK7DvJPFUusYMdwxE4hgp8/u1LNz01hVY=;
        b=0//KN8PztMgA6AW7iRd5km/Id2RdAIteBHefOXe86wAnTDS1dEgx1GNbHy84lJEvLw
         Jb4UiGNSTiUm02c2ctYAlEUbnCUG/IaiCpt/jlwSwdhL3XyU8KnS12mxEAtqOdtHOuei
         BD8r9V0WQU6T/Ej4BFhzrx6oxKvsFYjbqJcMhbG0S/kRe9feboAhpbwtHrEV1+qn73Of
         IzxgFCrlXJPRa//moLlBrOIcLSi62LbkTVfdCRDeV4+ipW1gRvpWDOPC0ISneE8dDLVG
         bOm/BV9dyRTfF1yGps/mg3+GhQr4ByTVRlpyPez9fA99wk8IaI/FywBL/nMcNMCmXPEW
         coWA==
X-Forwarded-Encrypted: i=1; AKwUvBzfesun9asCig48UVWBxYIGPaiO6uq7dEWjifq5uuk4oJBe1bW0Ps1VY8SOYBa9gYO/Oj4d1rGq2ucdtyyR@vger.kernel.org
X-Gm-Message-State: AFq9FYLRHS0iZD9BcgpqFi77Cp8pNzkAaSL5SAgZHIJHpCTvUyyB0XPZ
	s2JnCtzXXYwr17HgTshODIi4kloEM50JwXMZ6aOrl39scMahcIUam1O4
X-Gm-Gg: AYBFou2HCc+LFhzBexeJdUhHAf3UcU7qyqKJ+T2iF8VPcIR5ZB52bhGYqjHfvfZ2S5G
	wwvHakEdjjRG+9LYfs5+lfNK41HNt3x2WABUt7mHSt3c6KPf5Rew/7K0OQqrnHDTbVGjb0QFKr1
	Ji25hEdEQdEwGMB92zakOqmBvPkhy+u5mCB7G2nN04UyJP1Bdui8HWIgUnpLGxStwFWNqcPeDMo
	tDYcGOoj21PqgqOlTD8GZ4ugaNoy/IIFrJFai9h7+ojeXHWTdvOb8dzPPreisWKFCyc/wOD5zAS
	tazbNgO+bFmFFwPiM+Uz/DO2/Xm/ubXWJWNWfrDcM0S0jJ8cyXwfpbZjejfIYm/pTV9kGGQZDQb
	t9ACZY16cbH45UA/7o7ZQBsuLcg3xv5skVLnfMs/R2eWpojFqsp6wKmSAEtzY3VTROo6MdOTiWA
	0n52oo4rzDXSFgEmc/BHg5DU1DpzaTK2pEZNiGpj/8AzdSAjmP6WItaFsim/8wPH0+HoGKLfaox
	FL4xac0wLqpE4p4lrmuaJJj7JOwXjr2KpurUVkGvsFxyyAyPnk/GqJ8u4hrMTE/ABMOIP0T9QWO
	G55+odlA0A==
X-Received: by 2002:a17:90b:2888:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a4d19262ddmr104610a91.58.1790738170170;
        Tue, 29 Sep 2026 20:16:10 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce1c9045sm588743a91.12.2026.09.29.20.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:16:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 03:16:04 +0000
Message-ID: <20260930031604.70544-7-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260924073920.2782917-1-benquike@gmail.com>
References: <20260924073920.2782917-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), sb1->sb_blocksize is read from disk and used as a
divisor in QNX6_SUPERBLOCK_AREA / fs32_to_cpu(sbi, sb1->sb_blocksize). If
sb1->sb_blocksize is 0, it causes a division by zero in kernel space.

Validate sb1->sb_blocksize is non-zero before performing the division and
abort mount if it is zero.

Tested in QEMU against tip of mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux")
using a loop-device reproducer mounting an image with sb_blocksize = 0:
verified that mount is rejected cleanly with -EINVAL (rc=-1 errno=22)
before division occurs.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Rebased cleanly onto upstream mainline commit 62f4c998b297.
- Added QEMU test procedure and verification details in commit message body.

 fs/qnx6/super_mmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index 5f62df30467b..5d41f028bf80 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -63,6 +63,11 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	}
 
+	if (!fs32_to_cpu(sbi, sb1->sb_blocksize)) {
+		pr_err("invalid blocksize 0 in superblock #1\n");
+		goto out;
+	}
+
 	/* calculate second superblock blocknumber */
 	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
 					fs32_to_cpu(sbi, sb1->sb_blocksize);
-- 
2.55.0.1082.g2b9226bbc0-goog
