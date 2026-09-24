Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022C326927
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224303; cv=none; b=AfEps71+XW0yRQ0Y9eF2ncE5lG0Xjn3L1CNWp2fmIhB3in6wnYO/Tnt0IMBHC3pUBPc1HaFnHQIAdRPWFJjYqAFTUvOkmHuf2h+5M8E/mGlqmtwASgjIfEQFIusfVLinQEcFy9lXbgJ4o8Q4z/nhRxOCFf15OJcf5q8tILdItKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224303; c=relaxed/simple;
	bh=DRylgV4Cx+aPGGL0RMZLnjTqy7p1IvTXsAq+fgAiGY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkPnhCBuUxUPTOB/b/W2JVOUcWn0mHrKvUusekYdaUyOsi5j0xIcBR89B3/e+laxF9TEFSvNuKi4a3xM2ga6drS+Qr1kpwHPQnSjuWzSusL+yuEc9l9Fr1uNn3Zbj8CZWw8bwjM7YzMCFOFo0Lm0NlVdqHp+2eGISRG09MfNJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJYF2I28; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJYF2I28"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1012858b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224300; x=1790829100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMjWRKOozJ8YXqfO7vP6HjijcZHrUo8rG5y9BxzpHJA=;
        b=CJYF2I28c7r402qBo5Bn+AvaVKAf6YZY4yW8m4cJFRmBLVkk8/KFOTbH6kDBCNro+r
         N8ttrqu8CtA97UDI5wMa98Wt69Xcu8odEZDjQvcTzliDHxLRWcEbzvoi7PP3tftgIuxM
         Emtmcj6sIxmlay6VoEbAP0jfBw6eHvZ5eH1fA2pgGNX/3g8RzGwjYpJ2mtCP83RLqK85
         LoHdJqRoBtAZhO1Z2SaV7pbqS838z9YyJMPX6Omm5rUFlORiNiG71Vxxs//b3M1N7kSN
         1ggiBT1MshzXVppzFzxvSwo4CfJiRl1K6k2hR2PewI8cozeUq6xxOuq/yYfoE2dXvvtQ
         9k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224300; x=1790829100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMjWRKOozJ8YXqfO7vP6HjijcZHrUo8rG5y9BxzpHJA=;
        b=OZqumwr+SinmDcv8MrmvWqlLofTIKp9ymvzUlSRvVCI108RiKALYOsqPCawl/O7C/0
         IlLgbz4gzQNfgaoyWWNg94+K/hvBfjnbeVSqn6OKW623dg983aGlJ8R0yzJDKukhlMko
         ODtF5yjqlBQCwwrmYTodM6DHgtiTFprek4T0V1ah+sJIwGgrwUonmWGy8MEuNPQwYNUZ
         AK99hrCIFqC4mwBiCDfHc8Gq18fTg1RkkjvGfbF1ka+feoPgsdcBNSypfZfgu+RX1zfr
         XIthhwmPL/pl1uMYfdlTqM9XKDBVpnMVlCkSgl2yBOelnT2Fw/TaH4jLqcBUubC/n0St
         HTxg==
X-Forwarded-Encrypted: i=1; AKwUvBzu6faxCFpi97SphMIP736F6iAjSIs9oz3Hqp09/Pc9PGLp7P/UwWkKlwrON7R2bXsftYdjGdXjuO6UZNWx@vger.kernel.org
X-Gm-Message-State: AFuF++kPottPjzphdfO+dlWQliVkH8n+YPEEnqeHmjGZLBgZtmHLTBo4
	s+vQ86PeKYNijhvjAqOhIGKU9DyfThZ5ba2Px8m2rsZd5mOcUmYqaGFV
X-Gm-Gg: AYBFou1IL89a4XUA/luTGCk3FSrp/KXi37mSBpJtp6+vUDW8Al8PFo637RDNqmJrdcw
	jLd4DhnYQS5aEOrXp6fVGx5ed8/Dxfj1OBk5IcURarjg9ib1kdir6GrPRB5aNVVojQDj6B89gK/
	P1eC+FsC/SVhA3v6jhgTnEA5o17JaeD6xINy0JyN5YMEuBJ8c5O5z7vN7niQrTgaRRdjdAuWNTF
	08XNvk6EFnWIHIfSZuEK28r4l+aO7zUxZP3od2TmQrppnlCAYxk99hpgeyx3ekahrb660IBhG3M
	LGjhuu46duASKRWg5h3gn2+Hu8SqsZHMnEQm3NGYM0/RZJIIQ0ZeF+C0DBeTXbQE1/ft+wI+qXI
	Ue9wu92oGBS7YkbKbZgULkhR0dyZfnWo4+ZivAI3F4pMvEFtep8f9S1DDTOz8fPGhigvG8sZdpV
	XXUmivg3Xi9xr5qVyEBCX0//f/SVwyJWqgVP+qcSkSGMLaR4/XpY6bE2XoMNDe2RKU9mr9SXQ1m
	KqFeEd0UAlmTSVdGzV8wRcVYPomLTqLBSEODzbKT8Q65lpMxB9xvfKnoul3Io5R5rIl3Vr7Dz//
	fR29VoM11oTLOyik33XiWlUhynyfuu4jqZ64QLMs57abxlAhReBkGn9oYqg=
X-Received: by 2002:aa7:88c2:0:b0:857:72ba:ff0b with SMTP id d2e1a72fcca58-87e9917f67amr1139161b3a.19.1790224299560;
        Wed, 23 Sep 2026 21:31:39 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c1331sm2180146b3a.24.2026.09.23.21.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:39 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/6] qnx6: validate di_filelevels in qnx6_iget()
Date: Thu, 24 Sep 2026 12:31:35 +0800
Message-ID: <20260924043135.3894182-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-1-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hui,

I hit the bugs fixed by 1/6 and 3/6 while fuzzing qnx6, so I tested
your series rather than send my own fixes.  On mainline 40288c9206c1
with v2 1-6 applied:

- KASAN/UBSAN kernel under qemu: the Inode.levels = 6 fuzz image and
  two Longfile.levels = 6 images, one per active-superblock branch, no
  longer trigger the double-brelse warning.  A root inode with
  di_filelevels = 255 is rejected in qnx6_iget() without the UBSAN
  shift reports.

- Userspace fs/qnx6 build under ASan/UBSan: LeakSanitizer no longer
  reports the buffer_head leaks from qnx6_block_map() (2/6) or the
  mmi_fs error path (4/6); bad sb1 magic under SB_SILENT is rejected
  (5/6), and sb_blocksize = 0 no longer divides by zero (6/6).

- Six valid images with the same trees in both superblocks produced
  the same names, sizes and MD5 sums before and after the series.  They
  cover 512-byte and 4K blocks, zero to two indirect levels, either
  active superblock, and normal and MMI layouts.

Feel free to add:

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>

Two pre-existing problems turned up; neither needs to hold up the
series:

1. qnx6_block_map() shifts a 32-bit block index by ptrbits * depth:
   35 bits for 512-byte blocks at depth 5 and 40 for 4K blocks at
   depth 4.  Both levels are valid, but UBSAN still flags them.  At a
   bit offset of at least 32, the tree-index component is zero; the
   mapper continues with the remaining indices.  Guarding both shifts
   against the index width avoids the undefined shifts without
   rejecting either level.  A test-only u64 cast removes those two
   reports, but the images force high levels onto shallow trees and do
   not test genuine level-4 or level-5 trees.

2. When superblock #2 is newer, qnx6_fill_super() selects it in
   sbi->sb and sbi->sb_buf and releases bh1, but still uses sb1 for the
   Inode and Longfile level checks and root nodes.  Thus it reads #1's
   inode and longfilename trees through a released buffer while
   sbi->sb points to #2.  On an image whose superblocks point at
   different inode trees, old_file appears instead of new_file.
   Setting sb1 = sb2 fixes all four later uses in my tests.

I can send both as follow-ups on top of your series, or you can fold
the shift fix into 1/6.  I'm also happy to share the images.

Thanks,
Matthias
