Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538F343887
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915684; cv=none; b=LjBw9wFyqfBku4HeImXLAXPcXhf6w0mbCQgrpFc0p6yBcYT40tLLUHu5BDf5JawdV3X7Q3+/Nmgx3JyPsZSWQvkNTAAhs+QWabWe7E/2jlFSY9yuwiaLfw4p4Gtvi51m+nBEiUvXxMB/2zzsWhjMmTNVGeCQURuvgumo9f7T3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915684; c=relaxed/simple;
	bh=ipUR6dbEPBmy9uhq14GIyEe4KQRS624Rt/8LIK2vngM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUv4a0S2Mq5lPWrbzpTD+MzpMDi5n5tUMvj6WpzPzIArTjTkYClAPIRX7qmSo0LIhvI7f2HK8xzuWEzYVFf5OJ3cKDfE+oVpUvollRd6IOm2wnd0ZamIMyAZ5m1349HG6S/LBxEA8m2ROU8nGrWxHtTSyTnuXC/DJzwvnmAITl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5V+xAr5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5V+xAr5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c9ed0c7fc7so5432095ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782915683; x=1783520483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geZt5mwfxGU7cGsWcrOJqyhUil97cE4hab/MkWGmHSU=;
        b=M5V+xAr5Ml0PlQFgEZ5X77JUVwsSdGRdqy6IdlfBmuHD+D8zybMbOOIMt9Dusfdy+2
         wWAZ6TOKLOEq1bF7phX40KQA48wyDpMlEkXk84qt/VaaisDLgKo3wboECGvjCQ07otNG
         v/9/NwztKUTK/2tfmugu7gGoQWbbuUZst4VjBXGCupHpYPfRA9KVMOeZG2jOh0F70gfx
         Tr9rAI64XH47bjQjWetmJEIf3fzqrr31FjvIeqrexEd9HQNLNaMbvcXnO/i0Df4ElvWG
         QPmuJ4mD4XrRuIkNI/Io9MEVwky+vY9diSExymFKRC8c4PQYAL0IeEXqoQdjxtpHNz2Z
         YbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915683; x=1783520483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=geZt5mwfxGU7cGsWcrOJqyhUil97cE4hab/MkWGmHSU=;
        b=QEq+OZmYoisJPyZiW6avXrkb7ZZDiz8InKi/qwVdUiGnnS4WpIyeorqQJ/lBPtVo1P
         QO3N6LjvRWXykkr10g8pOoDpc5b2ZIYYRi4JmriQY9KzWAHkUEzWO7bb4vAPy8M9L8ZN
         SBNXmGAHgd5QD/Zx+KrdKHIVlc2OOQPelqrow3IW8+XTACIyGhGwsv8klNcZYlNINxhA
         Cbd7Wq+HZvPzdR+FmF1JmYfcmSrPx0cKcRoEmjXOHVM8GZj1nImkR4RyKQkSOSx4YSNv
         0CI8sDEmcjGrWW0FBAP/rymXCvdeUkA5FgqLyML0fUqyxbDZIpPgJKrrnaJ0E0+ursB9
         ItkA==
X-Gm-Message-State: AOJu0YzcAJL9OJe871kyeTiTLK0E6SUoxTyxARkU1Frm2vw4TLHru6jb
	LNuFQjUtJ+FaCb3JEb9MbHf4wd7i47keOod3FC8AXTc7Sf8PBiuUaJZWtErcaEI6mDU=
X-Gm-Gg: AfdE7clQeTL7R0DTrXyXUxfoE/3SzYRAm7SEZr5E+JE+AxnxJES4/TV37Th8658ReLJ
	tbi3znQSjX/NNys77blkCNneo3aJ2sdqIhtw+whKPLxhRAA4W6zDXp9VU9nBWwWSpWupnladPv3
	EH0qHydlCfQaZYcNj5y2OrsaQrBbqfZx1d+IYbFFYtYamUZK6ySje4cRTqno2ZVr47Fo90K0CM0
	PAeRSRU0G3dO6pbTPdRhtX3guUys0u5Ij/LOgavHTwzmDgAChPovoc1yETFLIxV3mGAnVdXIyav
	rFKLofbMiba2CzU/A4W+zAM7IiS7fMrxb0qUWjfVbytHdtsqepm0fw6H5whBthDUXoUsGFcYvmq
	yJRldKbpmhWODR6MGrIgpYNrrCmPUC6O6hXJseyZFygHVC1LRAUZuoYZ7y7szMvf0v9pJj8tNxu
	Y7W6q1UraRSjaqj6hl6rIERrqNNbpCoz43
X-Received: by 2002:a05:6300:6715:b0:3bf:a0e5:999a with SMTP id adf61e73a8af0-3bfed41d909mr1937140637.48.1782915682831;
        Wed, 01 Jul 2026 07:21:22 -0700 (PDT)
Received: from DESKTOP-DK6PUT8.localdomain ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e32ef8e49sm383894a12.19.2026.07.01.07.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:21:22 -0700 (PDT)
From: yizhang089@gmail.com
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	chengzhihao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 5/6] ext4: write back partial-zeroed edges in WRITE_ZEROES
Date: Wed,  1 Jul 2026 22:20:08 +0800
Message-ID: <20260701142009.1510104-6-yizhang089@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701142009.1510104-1-yizhang089@gmail.com>
References: <20260701142009.1510104-1-yizhang089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

FALLOC_FL_WRITE_ZEROES requires that all blocks in the requested range
end up as written extents with zeroed content. For unaligned edges that
were partial-zeroed in dirty unwritten or delalloc state, the buffer
is left dirty while the underlying extent may not yet be converted to
written. As a result, a subsequent SYNC write to this range would still
trigger metadata changes, which violates the semantics of WRITE_ZEROES.

Fix this by calling filemap_write_and_wait_range() for partial-zeroed
edges to flush out the zeroed data and ensure the extent conversion
is complete.

Fixes: f4265b8d32c4 ("ext4: add FALLOC_FL_WRITE_ZEROES support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c34505765521..c083703bf704 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4791,7 +4791,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ALIGNED(offset | end, blocksize))
 		return ret;
 
-	if (((file->f_flags & O_SYNC) || IS_SYNC(inode)) && partial_zeroed) {
+	/*
+	 * In FALLOC_FL_WRITE_ZEROES mode, edges that have been partially
+	 * zeroed must be written back to ensure the entire zeroed range
+	 * is converted to the written state. In SYNC mode, writeback is
+	 * also required to persist the zeroed data to disk.
+	 */
+	if (partial_zeroed &&
+	    ((mode & FALLOC_FL_WRITE_ZEROES) ||
+	     (file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		ret = filemap_write_and_wait_range(inode->i_mapping, offset,
 						   end - 1);
 		if (ret)
-- 
2.53.0

