Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1A3F9278
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458646; cv=none; b=dZtMSfPLUOmjwiOv9E3N2xRXhDpPfITzqqgFGP1kWp9OPrsU1IlKDvG8cuDYVn5ijqAeCX35SvohTI5tvmkqhfHn5WlFIfqmFJni95NzHNomqoILSAu2N8SPAG/EeKf1wcwG64O3O2Qf2byROnk0wNIdv/ZRcUfbs0J10ZP+Y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458646; c=relaxed/simple;
	bh=VIsLR6MnQ2cCtF2zNSWuryXqb0+AoC1v+XRTD9qa3PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeNX+BSORvLg1TRCOaZffAtYR7XId/OZzT/Wz1sxVtVOVqFdiJ2AYY24ItRXCoyX9XdVBhxV0lt98oJC8MMqDiaBWAaaajZuXkfZW5XUGDc3deD/W6/Ds/MHWTtCbLt0ILWzyltUhf5W/9JEDMqHvAVItsSqTcTolPToqezL2r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQBLIVXp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQBLIVXp"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a02551822eso511776a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791458644; x=1792063444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GK/NzQ7B7TCPuEAkNeYo7IlMKawycpDaCj1cdyO7pWY=;
        b=nQBLIVXpxdscORzFo/W8vzco38ugt7bsGtKVYYiE8vBkPISpG4D9IE810w3J5a9qbm
         AI0LO9J2yTvDsyi04OGHzsGcchNF6vQwKSuscdQQ2ya0FwDTENsGTvVkGf1xHqO2H2F6
         nA/KriDnZmuxmEnqaLp/NNLfZPcIf8XNXV3xA7C0H6ARqI5Q0ShmgOssHE/Z9lkpKYu7
         THrx/WckA3ZZcaxo/9hbw4zxds8d1AXOHuQZJ9uisDoAR6XDvKptAM7EiOs0M49M4N2q
         aJsZoLQ6Koe6FMj+pXR7YwnRRQeSnaorIploK+4D5iLGXEOQaug/1U/3aX1hcAMx/zQ6
         Kvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791458644; x=1792063444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GK/NzQ7B7TCPuEAkNeYo7IlMKawycpDaCj1cdyO7pWY=;
        b=IGgd0gYrWpR80Xr3n0JEFsenv+dFZ21PXfc4h4e11J0F2JG7E6nKpCwrub769c8AZr
         BzHwrjCq8H/eJxxEX7wMgtg0EN5QRZcF+auOnzYO7vO/PCPsSG2UzFr7Z5YmzNveJb30
         YquZRPacZ2bmB0IAG0dDto4DSioNEZvGSyaONJXohUJeyZ26m67mUQOVnZBtdWezryuy
         QfsLt/Pfv7Eo1o9ixu3BMLUOW/v1spjoSGwcYjcf6ZfqDTIgO2zEk9SgP4tzfvGgwbwh
         oE380W2OWSZ9zi+S4+QB7lsYk6UcErNt/HfyQRBwR1HLDVsfnbGv6F8APJSNeuCeY1gu
         LRow==
X-Gm-Message-State: AFq9FYIHJ4QSuK5Yn4qnEokaPCm02TRwRtc/x0IKg2bBRxmSBQ9nUQDe
	1YRtzpHPfGBQma+DSbtI7Q/8oNrN5VaOjsgld5r3VEXWh47FSRcGTII0ZV6BbPM2
X-Gm-Gg: AYBFou0a/kc78tUa1lu2AG1/84visVGt1qAvKepU5rhxLwPGvMX0hwkXbhdWUB67mgJ
	WdFwQuU2/Us/88p7IpyfRrMNjTNXXmOrY/WoTbGnMuVE6fxPFyB42w4GjshvaDJ3FT7hXgcNoS9
	MGc/tgQZSzyDmuFvG7QaiuE7VgKC1irEGGxHl/+0YJq8BZKVMij4rDD4bDp1QfwDeHuYYVwBldo
	STBU3ufORb+z1FLBPeL628vuuApDdbT183JAWUej3PEdmhiz0H7iAf29C1HmGukSGvpGd/WTSL4
	/kFk2wGfZsIUFGD3lRcjHlpAj567XXjRizs5ZRFklddBvinAS3tk0mRkyLEeLWG8cC4GCxFYUA5
	rshfU6ZC7+hgzMIBusMPnRrEPmk2b31vznI81U9F7FvPaFL1HHcCLJEcVeVmko881lc/SpB0Jvn
	EFaFEJKIlulfBmUxdIJbhuRKTe2yhC6iz170SXrDCYktiAo6eLCfer+k+pGy9LGKv1qtOhfs9Sc
	UnXyo2TP6N7o+VrGkuezsgWF3s=
X-Received: by 2002:a17:90a:141:b0:3ab:1a5:cd2 with SMTP id 98e67ed59e1d1-3ab01a5236emr464701a91.35.1791458644295;
        Thu, 08 Oct 2026 04:24:04 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([167.103.3.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89d718333sm4330053a91.1.2026.10.08.04.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:24:03 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com
Subject: [PATCH] fs/qnx6: reject zero block size in MMI superblock
Date: Thu,  8 Oct 2026 16:54:41 +0530
Message-ID: <20261008112441.3957200-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malformed MMI superblock may specify a zero block size.
qnx6_mmi_fill_super() divides by this value while calculating the
second superblock offset, before sb_set_blocksize() rejects invalid
sizes. Reject zero before the division so mounting the malformed
image fails through the existing cleanup path.

Reported-by: syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6a0633f11d3fb88860bf
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
---
 fs/qnx6/super_mmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index b8afb6f388b29..960ca68207d61 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -65,6 +65,10 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	}
 
 	/* calculate second superblock blocknumber */
+	if (!fs32_to_cpu(sbi, sb1->sb_blocksize)) {
+		pr_err("invalid blocksize\n");
+		goto out;
+	}
 	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
 					fs32_to_cpu(sbi, sb1->sb_blocksize);
 
-- 
2.43.0

