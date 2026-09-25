Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0CB49EC63
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349312; cv=none; b=ribBE5tXSFfttU2GLE8ZyVMaOx44cEsV9t82Nh+GhCDBwfr6q2NZbA30AAOf2TQLayRhrX2rZCnvXBGTEgS4ElL2yyMptq5qw9etTb7KG2VRUnyeHEFN2RD5heKj8nbduzAS2WG/Y7pf5gIymbjV5LnL9HV2cBzB+kJ0pByri7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349312; c=relaxed/simple;
	bh=TUcPX6BPFFIuoOewYtKvdso3Ahzj/r+UczFEbMxrHPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqD3NOZXY4MhsiKjRmYrbIIRX8xSN4X8vPPP7DOmEvKYJeWv6JTm0jFcf4mxTh6n/h0fhESVD0exKYVVmJYWxVBrfZ5vVgvcaSrdGkCSti7tUomFkA+loG91vrxXP2dzz/bLtBdOzJ6vg6fSiDgp965Q/ttIh+n5NEtwMwBERFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhZS8Bcg; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhZS8Bcg"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b6200eb0so726257a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790349301; x=1790954101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLKdApt9asP21QJvwLlfddZLpAbZuHptRxd/Wz/bsrk=;
        b=OhZS8BcgNvRk0h6WN0ydL5nnS83eB2Jzbu7B8eSUwH8gaDgeckhq1C1xSR4U+InVb7
         yHUQZY5F+x+XlL2fGgw7zPgbKFX8m5eKzvRMYOBlf9FatUbFeXYo/+uTeyM7PYX97TV2
         iTQ93Y6dcTzTqypS6KDOI6Z9Hea3Bin7f2+jOFjZinIB3vHwF1CyNFkLhgzuGonK49CS
         DLwRUxl/ptCI3bm/XraOGIz6x+T4Pa3zS4Q1iFfjpRypHbAYk0G8ACSJsDrbYhw9oZGv
         MH9UJSqOFGPdtEoOcOGxc26g8rwzpTRD7Tg4FdHVr935FOldZRw92kZxnPB6J/CK7S+2
         A9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349301; x=1790954101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mLKdApt9asP21QJvwLlfddZLpAbZuHptRxd/Wz/bsrk=;
        b=fi6csHMiiALw2F/Rh20v4ExYIX9MgZJ9VpjNc4MMd0OZkS6N8MMpzEjgVuCbln+iOW
         ZUoL/SxhHm6VLhLNyWYmWy9d+iF4nfB6TZa9VCTBhm39wrgCSIFlUSzbVXtxERwL1j3w
         F7lS21GugnhCzUrRPkc1wlnkhsW3aS2lHw+9EVL+mkBYCvPBXYRCkrttf2sQH8OdBiiI
         ee3XuitFZ1/keV61ojkAcHOFz9Mihs5gNUXS9s175nvzwlvrHMfSpfH3baKctTpRg8m+
         hGhQ32OU5YWQa7EtSF8KAdf0/56WKTqnYmgiti5XMy9rNwsP9/iMt+Ntrb1Wix8+sGJW
         fpLQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9ReLMlHC+t7gvTxx3yDQokCgX+HIoHBGVQghbGms+vKs8qaGLoVdk4wSxcefn4TjsYYoVDoQ6ForWEOqe@vger.kernel.org
X-Gm-Message-State: AFuF++n3kUpH1HZvXBq7Y44VKk+CDQzzZAKe9Msyht3kFyTCFG4opLzg
	NxIYUNRgkt7Jy/8vuZi6bOBLtlWgTsFxC0dp6SIdswtpN6mmWMCeUUwS
X-Gm-Gg: AYBFou3p1C7yUgiZujTK3QBbTTlA+Uxw2PYDmJXuDZ0XsIl5b0YZZpLBGq2KAyQVEcK
	qXJCrPqsga0uLjoNrXBrz/YeDNATtopUmjBpF5oMCxE2YyjX2a6KTS2BDYSh4CY5UJPplDPp0IW
	s4wHuw3MZLgUlJVT4RJ8VVjZgyp04GOo7ykL9Ub02/ge2bY1TKYp/8YNae7zcEZdDfMpeEuXNpO
	y8+mq1VemB10HzeCb+yeoGLDvX7m9PJ4G2IlyozEP29eqWEmq7j5AGM8VUmQxtCsKH7EKd2r2JC
	EvKfjdctiUdlDLcqV6wvffqz80qHZSCacCAd5EHigm4JBpnOq16XhxCH9s80tbC3+I6q9R4t2ao
	GS+hfJDnDuT8kRgAwocPe4lmEQk+8lqDcmQzisCSyPZZseF1bl/+lkN23AO98W3XS6Q4lha/t6G
	sdU/5XZyCcq684iBqxyZT606QkKe7xCxghc/UBaRAiHS3w2QddaROw1utsaSUK9SVbMAsm+9c6K
	9xU1i3hRHTaxhjJloTWE30aFHbCupLlgC24/6PHmdu0zCIiM9doHpreaHOJyqgWWeHl27/0Rhs0
	QvVQhmhOT/nWiGvRxeh9/6FU0vah+ed1mxp+GRdDFJksTsDBciJqkD53EQ0=
X-Received: by 2002:a17:90b:17ce:b0:39e:4c80:44be with SMTP id 98e67ed59e1d1-3a0bb60b2ddmr1999811a91.33.1790349300536;
        Fri, 25 Sep 2026 08:15:00 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78794f224sm1503252a12.25.2026.09.25.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:15:00 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	benquike@gmail.com,
	dlemoal@kernel.org,
	al@alarsen.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] qnx6: avoid undefined shifts in qnx6_block_map()
Date: Fri, 25 Sep 2026 23:14:49 +0800
Message-ID: <20260925151449.1517608-3-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925151449.1517608-1-matthias.goergens@gmail.com>
References: <20260925151449.1517608-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qnx6_block_map() takes each level's index from the 32-bit block number
by shifting it right by ptrbits * depth.  QNX6_PTR_MAX_LEVELS allows
five levels, and ptrbits is 7 for 512 byte blocks and 10 for 4K
blocks, so a depth-5 tree with 512 byte blocks shifts by 35 and a
depth-4 tree with 4K blocks by 40.  Such trees are deeper than any
32-bit block number needs, but the driver accepts them, and a shift by
32 or more is undefined.  UBSAN reports shift-out-of-bounds, and on
x86, which masks the shift count, files in such trees read back with
the wrong contents; at depth 5 with 512 byte blocks UBSAN also reports
index 16 out of range for di_block_ptr[].

The index bits at those offsets are zero for any 32-bit block number,
so use zero for them explicitly and walk the remaining levels as
before.  Casting the block number to u64 would not be enough: with 64K
blocks, which sb_set_blocksize() accepts on 64K-page kernels, ptrbits
is 14 and the shift reaches 70.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/qnx6/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 0dfe8a3dab83..fd61cf27b81d 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -124,8 +124,13 @@ static unsigned qnx6_block_map(struct inode *inode, unsigned no)
 	int depth = ei->di_filelevels;
 	int i;
 
+	/*
+	 * For valid levels bitdelta can reach the width of no (e.g. 35 for
+	 * 512 byte blocks at depth 5).  Index bits beyond no are zero, and
+	 * shifting by that much would be undefined.
+	 */
 	bitdelta = ptrbits * depth;
-	levelptr = no >> bitdelta;
+	levelptr = bitdelta < BITS_PER_TYPE(no) ? no >> bitdelta : 0;
 
 	if (levelptr > QNX6_NO_DIRECT_POINTERS - 1) {
 		pr_err("Requested file block number (%u) too big.", no);
@@ -141,7 +146,8 @@ static unsigned qnx6_block_map(struct inode *inode, unsigned no)
 			return 0;
 		}
 		bitdelta -= ptrbits;
-		levelptr = (no >> bitdelta) & mask;
+		levelptr = bitdelta < BITS_PER_TYPE(no) ?
+			   (no >> bitdelta) & mask : 0;
 		ptr = ((__fs32 *)bh->b_data)[levelptr];
 
 		if (!qnx6_check_blockptr(ptr)) {
-- 
2.55.0

