Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5724C900E
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349307; cv=none; b=kZ3jE3Ftx6gl1i+urW2TaZGi5HrqLQu7WmR5Xm0sCghQhPWgGlrIvbVK9OC8JmjOJYSr/24Yg9CKHBN42nsdlBIg4HeAJFRVMNEvYqVJ+fhH4p19PmMTn+V7k7bubi6kjwGJc0ycRiDAFZFpxRuwj/Ucr72ibfShr5gFryZ33v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349307; c=relaxed/simple;
	bh=j9pkTlsGHeFmY/FKyad5xTTYddWdSW44ocQ4QLMrD+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sR7IHJtBh4N13nsLq7GqchymtEruicYh8akxzF+ORxwPU6GVzjAU19uNdtjGEZVAw571NiaLcEAG8CjXJk0agWsqF121MAz4tjfWx3zkhp75OO6Lu5uo2GhdJYYKjK0K2zRvDIrOnlR0MKZzvsmGIfxztQUyyfzS8pfzj4spweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMFrBTqK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMFrBTqK"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso968450a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790349296; x=1790954096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mA/UazuvMtTONcduZgB5UUPaN9FLii3dQaGfMpKTCJc=;
        b=hMFrBTqK/fVfpFRVrnzHCygrVdIFQdjr5+BuRH8rwvTpPV219efTiJTnB+/MJA/Itk
         BEcFYWBY3nsQHwhHwzYuwm8x2dF0vE+HiorqxUi1NQKeOY6ZvYdgocBXND0UeLvQUUFv
         I+qnonsiYWHX4cMeH1wJiwyZIvyaSO/szKruMlSruFfi9fYLJYYYCgjM1EvD9neiMEYF
         EG/Rea89zLBcPSVPLojAJq2/6Z+XjcCuN7YoLOjfsoDYR1PebLV1/TlQzC8EU6fTH47u
         RW1V9Wh0mIPiBLStT/65R1L9XwR6qZL3I++4aR7M718+qLR6tfVg08Hvx+Lb8VB73I2L
         pn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349296; x=1790954096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mA/UazuvMtTONcduZgB5UUPaN9FLii3dQaGfMpKTCJc=;
        b=A35Vu4sgvLPwdhmWwarJZtuRkrwAtgB9bGDAG1D6fenpfFl7UHGbQi/j2F20WeNhe8
         2JFUKpOOg+3TnzTdIHofbQjUZxCFyTA/NLUUX5I2G+nN8V5ndLFYB1FhN1/iENlkrcb2
         MzmodGpviSOxrwzz34EFrjpc5vlWWlIJGnYs39IS4MO/rMysAzu0H7Ban+ppONOXXgmj
         cPybFpjl+4Mq7yo8DMBKfjccMc/G74CnQ9f8uXQnDJ2TpFlwsBX+0Ean3ndYIYmDcYfs
         +DU4eA6LM1KnFTDKwSoUaYQRF0X6/HlJZlOwerhJUvx5pgcLwQJnDjt62S3LlXZHIlpY
         AkmA==
X-Forwarded-Encrypted: i=1; AKwUvBzRUFAOIhU4SS76lltLlxosqhlEkGQLJanFgphwnqgiLfkTBsInfKQsRe4ZTsiRp2HWCjdS2JYhXrNXn2tf@vger.kernel.org
X-Gm-Message-State: AFuF++kSdMb7YPOMw7l7b6H6Z3XFXLix1CnOyUkmRKZcss1macIEBCHM
	GNu/4bDkM23CMcFm2CFApPiKTR4TckKL4T8LXBPTw3Cl0C7UpVudX7Sy
X-Gm-Gg: AYBFou0WcgYggTnAWlYi23AFmBhR+vI2nLy1sUG39z9M33LmiMxd9SQf3sDvTU+tIqv
	Nbl4/iTybFksw+TjnGmTYhWzkw9oYYVi/apX95CQZlcpoTuyilt2iQDf7XysPvYJuus+QAZZlxj
	4UQqW9TntTxp2oDnv/Y8zhYgvThLpSQGDSazBF7KBbHl4+GyoWBzcYDvEmj3Kd5dcHlapdMjmwz
	xcx5kC+ENQCduE6NaSbqcyWhq/FmHgpCSYdmIMYVVpg7hUbOdqgNxy0+XyPDd1FJol5qP3JhOgl
	Us7tdesICAvXBeokDW5cUsRp13QDISvFnLa4GM8uTXO6u7XFbsiHIfXqOrFy7kaVE7aAs1znXRK
	x/+cu95jbzN1ORXYxzZlYE+VhLWq6xo/qP68WB6k9QKrinE65AaBHLuTA7H/WGFNcF2UhLW0bQP
	0gfpC9y6nX7IM/qyJXgnpsya8rdTPedDmC1gvep0Z31y2K2Ug6Ju0E0J1rr4FpYTPqa0zzZZ1Nf
	bPbOJupDXGBXT9OABKitLUeBB0nIg2QDv3W9Z/lECvBlFDSxswsmLbBNJBIsDNtCVYTZ6ttMvhh
	yad1hSHA4mWuJERxIG3p0qpYxTr+0QN4UK7SpPaTyJnI5sYHwv0BR2/1C6o=
X-Received: by 2002:a05:6a20:3d8b:b0:3db:280:b0f with SMTP id adf61e73a8af0-3de0e77e076mr4399351637.14.1790349295598;
        Fri, 25 Sep 2026 08:14:55 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78794f224sm1503252a12.25.2026.09.25.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:14:55 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	benquike@gmail.com,
	dlemoal@kernel.org,
	al@alarsen.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] qnx6: stale superblock #1 use and undefined shifts
Date: Fri, 25 Sep 2026 23:14:47 +0800
Message-ID: <20260925151449.1517608-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two fixes came up while testing Hui Peng's qnx6 series.  Both bugs
date back to the initial qnx6 commit.  The patches apply on top of
Hui's v2 [1]; its 3/6 changes the context of 1/2 here.  His v3 [2]
does not apply to mainline, and I have replied to it separately.

1/2: when superblock #2 is the newer one, qnx6_fill_super() still
takes the inode and long filename trees from superblock #1, after
releasing its buffer.

2/2: qnx6_block_map() shifts a 32-bit block number by 32 or more bits
for depth-5 trees with 512 byte blocks and for depth-4 and depth-5
trees with 4K blocks, all of which the driver accepts.

Tested on mainline 40288c9206c1 plus Hui's v2 1-6, in a KASAN and
UBSAN kernel under qemu with generated images:

- An image whose newer superblock #2 points at a different inode tree
  lists that tree's file with 1/2 and the older tree's file without.

- Files in depth-5 (512 byte blocks) and depth-4 and depth-5 (4K
  blocks) trees read back with the contents they were generated with,
  with 2/2.
  Without it they read back with the wrong contents, and UBSAN reports
  shift-out-of-bounds.

- Six valid images (512 byte and 4K blocks, either superblock active,
  normal and MMI layouts), a depth-4 tree with 512 byte blocks and a
  depth-3 tree with 4K blocks read back identically with and without
  both patches.

[1] https://lore.kernel.org/all/20260921042511.1473629-1-benquike@gmail.com/
[2] https://lore.kernel.org/all/20260924073920.2782917-1-benquike@gmail.com/

Matthias Goergens (2):
  qnx6: use the active superblock after choosing superblock #2
  qnx6: avoid undefined shifts in qnx6_block_map()

 fs/qnx6/inode.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
prerequisite-patch-id: 46f959e08f10dc22aa50f0dcf3b666bc797e16fb
prerequisite-patch-id: d556417ccc538855b2090601ca20abd209019457
prerequisite-patch-id: 66d4e443988c07ddde054c867da5ebdbb34c2489
prerequisite-patch-id: 873f6449aef25a36fb2a66da92cc2eb4f0a23d12
prerequisite-patch-id: 51ea17033b2899bab8950a36f880154df18a4afc
prerequisite-patch-id: 0a0f17ec064751ffb6558cedfaff3be7b2a41f79
-- 
2.55.0

