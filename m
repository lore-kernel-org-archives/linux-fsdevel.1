Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0CD531
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708671; cv=none; b=houTwCwKrSD0VImDACIjX1Kl7yDTGFbUvY54tXpgVVBQRy68Y1rfOa8qleKu8qr/gfxYnpvvPB5/i3tm+KlxCbZjj8OHZ7MWobRUTcnF1FRF5aEdtiu61oRoF7owBiVMT9jxQlQhEz73vZYXxnwZ7mKtgo1qf/3QQSsE4XKsnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708671; c=relaxed/simple;
	bh=eBGe72e3dQKMDyfQg7oH0TDGuFQW/QXz9RONASd2y4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/1PmKzC2Da3WVngtM2gxGQ3CeLXeVuTyjBH3HkGeVYjrMqpjR/ourv5j/RWE6y3ma3K9QMC2BY9Qx7L9b+uSYpxYYLzQUdvbXBQwW+JU8R1Nvnqxc0g5rwSEzmQjXExOH+i4Qjimsr3EmlXNo/BKVJGxzD9BgYfRAtSdaC4I9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btbOake0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btbOake0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so132805555ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784708669; x=1785313469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7KANF6tVEjsUV81Y6yDQmKsFkWuakjhDXtk/OWxOjA=;
        b=btbOake0pcVAUivrXFxp/0yuUyf7h3pTvV8o6S2SSn/FsQ/xhzKuWOFrX6YMZ4Oz+o
         bQdUO1CdX1RZ+62Gs9KhufDn9UtJ71Ti7LCqlZEvzcTAW2yAq212XOgow3EPUW9Uquux
         V9HZHRxBt00wN5Oc/OyCtGrvQOBlQo11ZpgGdIXiKteSA11poE7WIjDHhgSIyg9+FxbS
         +xXwDeItAhm/4SWni0/KQzE8PzWnXMWflkYem07o7oo3z3+E256GrB4jRIp2eF9SgFtb
         P4T+vWrfH2Ahxzy5VvCw31ssesmlKPmtCMW9VOGMNx5jmAY6fu6Z4UinZNMHEoMG2yi9
         e20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708669; x=1785313469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U7KANF6tVEjsUV81Y6yDQmKsFkWuakjhDXtk/OWxOjA=;
        b=LsLoMivOe5pQ05FjB0Ue/Zkamobgg4JWVLyaByvEfAAKLcPQnHL6WezsvKKx+Ijnts
         j0x9xw+0vfHD/jfXT/+yu+YA9dbc8PJdEwEpM0OYjRkNdSWhwPhNM63pvTC0GF1B5ccE
         lwv6eg6Bkg66zAAOnfVu82QWX6Y2X4DDB8P5ZQNbszvr2I/MhH4vSlkK60gleChLWpIA
         0+9nR3Z99762bQRLkoKpK2Ep53Z+Uhuaheu3ZAvNQH6shVy+8+SuatOCpxWe0bsINbyO
         rGRoVGoGlY9cq4INK1F5gJBgDufnofSUJISdYBwyuGc+NqkuLI0EY53DL+pCHOwzt8fS
         2WqQ==
X-Gm-Message-State: AOJu0YzjThcC/NZCOSxCI7IWUD8zY3ICnnNqLkj4jgpHscKDY1G0Pj6p
	Z/7KQGxsopvNpkT82LL9+zVdQWFLzsAoOaHQbws7UU6f3ZeYRxTB4M0iGdw/ZA==
X-Gm-Gg: AR+sD1350xYxiTyPEsmyGnyZGqpJQGMsgfk9SJgohtSRZCpXjsgKv6bnyFkZ7id5SxN
	Fsoc62s5c9PLlcqDgu7wNJFBoJk4dlgX7wX7rg8Yi7ExI5GK53MtG+EU1qV/h4qEk/2I5th5Fdp
	gUNzqRiUfNhDu8pn7IkgxH3Pnal3W/MgdMyegKkl9mjOsM8qByGO4neoZoNXJdGcgNL7kC9dNO0
	8W9DwRKRrMF0fRP8+A4i3wkYSywaFgdX0D1LLeYpEF4BuxclKngx5qLAfdRvnG97Olj/adlkex8
	IfBwKePxAnuzbON7FiMwU85VfWbcVY3AP0oRsIiIAman2DnI9+CUafoTIG9ciy7bWzYvPPaP9Gs
	2XqbxjaHTjXck/+dCTQMg3Imfqd0jeBABe3F69w23p4ZCtPde6ZAs1yGZ2kHpMZDb5JUy1QTU2t
	wD60YK2P84pCxOmw==
X-Received: by 2002:a17:902:c401:b0:2c9:e69f:8b0f with SMTP id d9443c01a7336-2cf3486685bmr244760025ad.17.1784708669487;
        Wed, 22 Jul 2026 01:24:29 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efde5cfsm10729675ad.31.2026.07.22.01.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:24:28 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] udf: Fix i_lenExtents truncation on 32-bit kernels
Date: Wed, 22 Jul 2026 16:24:25 +0800
Message-ID: <20260722082425.213311-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In udf_do_extend_file() the total extent length is rounded up to a block
boundary with:

	iinfo->i_lenExtents = (iinfo->i_lenExtents + sb->s_blocksize - 1) &
			      ~(sb->s_blocksize - 1);

i_lenExtents is a __u64, but sb->s_blocksize is unsigned long.  On 32-bit
kernels unsigned long is 32-bit, so ~(sb->s_blocksize - 1) is a 32-bit
value (e.g. 0xfffff800 for a 2 KiB block) that is zero-extended in the AND,
clearing the upper 32 bits of i_lenExtents.  For UDF files whose total
extent length exceeds 4 GiB this truncates i_lenExtents when the file is
extended, corrupting the tracked extent length.

Cast the block size to 64-bit before forming the mask.  64-bit kernels are
unaffected.

Fixes: 48d6d8ff7dca ("udf: cache struct udf_inode_info")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/udf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 67bcf83758c8..c519644acfd7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -531,7 +531,7 @@ static int udf_do_extend_file(struct inode *inode,
 			  sb->s_blocksize - 1) & ~(sb->s_blocksize - 1));
 		iinfo->i_lenExtents =
 			(iinfo->i_lenExtents + sb->s_blocksize - 1) &
-			~(sb->s_blocksize - 1);
+			~((u64)sb->s_blocksize - 1);
 	}
 
 	add = 0;
-- 
2.43.0

