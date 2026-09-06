Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DC377EAC
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Sep 2026 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709773; cv=none; b=Cldj5ELNEFPEbie2UF52pq+c6I1WnQ1/GZCpEtx/HDQb2gozZ0teCf9L7x9gWpMe/yoa0Omj9MqdDGOokhaRU6omDHr7FZYHlL3fyd4Zr5n5EAutsm/HXeq6/vZkKkvh3c+beBo5RGIOKKtH+tvY2YwvisfoJOOrpaue3nHAqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709773; c=relaxed/simple;
	bh=gLgR5hH9TpKdCjqZyFRqJNOHPp4YzoVfvrONPg729BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lp+azQPovWScWWTZT5sqCKIJBa/B+UjMVXtmnFgUFXaEvbC/B9pkbVyfWZELfg5NrJdxzyHyzQkT6o7kO5VTcdJPLpcvP5hWxQyPMKpr7v/EPyJUoEKT3jl4pJD3ssO3k2GyUhosY97fx3bmXOYJgVxER2XnnUPJ3FFF9vNFfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F33D9ilR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F33D9ilR"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so2982617a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788709770; x=1789314570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnEQOH1FPlYD+C4tmq677bqNxTEuPgTx+WW+XcbxEss=;
        b=F33D9ilRpLuhsTtwTMjjwJFdOJYYKsCC4SyzYoF0ihBSOAHt9l6nrHWWyeJnphCWIb
         bFxVhnq2IwyBFORGgg3LOhyVksM8pT9bvbANTsnqCygOpnkeiSxJxZHko39IURHHNafj
         /EzLG5BQcMLG3vi7Z0BnTJV7KZ+9GscT7fSARENeXmkROPSuWh0F1kMsoc1d4hIGCDgL
         RzvWeMot48rmEZ4tMnms0DmXhgoaFzny/X7gKYLLNM1qKlDVaWGhmMxzwcXmnv6djpjn
         mkX6YlrmbU8lHA1eURqb0L1SwnK8kjNdUzU7dro3ShIvhPIfadVYy69Z68CKJAAMVsHL
         QD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788709770; x=1789314570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnEQOH1FPlYD+C4tmq677bqNxTEuPgTx+WW+XcbxEss=;
        b=lj7Bh3pyEPZYVtaK0Nir7Kv8JEtQ1EufaIhHyrW9oTJrFmD/+/0/8ZAnFiw1bFel0g
         AUqPzpW6/7udK/T/+ebkw5qg3HmoVOcaZNzMtnXj2DVgiWsnleirUaGCyA0OAUm9qdAe
         FiBBQlr7eb8z7w1+YLlYCqA6tY3RTEF7kGYDbwp6rniwg7DClDzqNJ6gbhW7nvAc7jjf
         y9B4AdEDuYWQFXk/MBXdTVp3PM9s1Smpl81b3zY6ChS8pkQKJqbsF3LMcY2bTEqVc9Wk
         +32N1gUfwb3wpIbJ2LB7tXD4AORaws2JzGlVjGs1zWX4uBjhpX3hhjOVwbyfWl4UAoMK
         o1bA==
X-Gm-Message-State: AFuF++neFVEcPLANE+tNA/EScaiqk4efUyUl2cnoLfNvTeonmGEkCoiJ
	/uJw9ueLGz5E0ZivI2kI7jxY8n/QiUYAve47gJgKhuI3ivNdWPGujUM3
X-Gm-Gg: AYBFou34iZ2qbsgkbGsb8DvZWCpXSU8tlGJOmh2YCWvoEWe1kmQ9tBA2nVHFOB7cNZo
	diiqVTkMVBcdFHx+HDeX2h0AU/ZWer+3HvhVK/m6rjKCqkeuDj3BEE9cvJqsOU1xVjJSHtZxbfo
	icNLWcVdj8jhXncn2anEwv+fGfODx/vq2gD7tkmh7zd15c3NDhCQWqr4gd97XV/tVpWAuKlqT56
	gSKwM9VQUuYU+HKcNFczgXaIyueJRPGTNGd/KZJfL7LlaqB+Dgq91xyYzWb2QiPH14yEuGog0NP
	1MUGuuxJQSgMMYznfIryGQbqRlDe+Dj2GWicJ1aNcyQG+cZFddxVWVgE409Bumk+sR6KNBntXFh
	96KL8U//uGMkwQ44ntdSzCcViaFHLof40QW6nsNauCbZyy5Y3+pMbHN/8ItKiJD8VE633ALfIbw
	lTDUFPUDtuiZnYnxjqidX7MyxottvMxns6aKt5QHo2Rf3vHNnVFd1/1XjYJACMI1oJDGvMQKN+U
	Zu2G8f9
X-Received: by 2002:a17:90b:55cf:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39b261b1a52mr30338457a91.12.1788709770473;
        Sun, 06 Sep 2026 08:49:30 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:7bb9:b8bf:8aa8:fb0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae610e5b2sm7271765a91.0.2026.09.06.08.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:49:29 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ThangNN99 <ngocthang2710.1999@gmail.com>,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Subject: [PATCH] hfsplus: fix recursive tree_lock in hfsplus_file_extend()
Date: Sun,  6 Sep 2026 22:49:24 +0700
Message-ID: <20260906154924.94160-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_bmap_reserve() calls hfsplus_file_extend() on tree->inode with
tree->tree_lock already held.  When the tree is the extents overflow
B-tree and its own fork already claims more blocks than its eight
fork extents describe, hfsplus_file_extend() calls
hfsplus_ext_read_extent() -> hfs_find_init() on that same tree,
taking tree_lock a second time (lockdep: "possible recursive locking
... &tree->tree_lock/1").

Per the HFS+ format the extents overflow file is fully described by
its eight fork extents, so this state only arises from a corrupted
image. hfsplus_get_block() already refuses it for lookups; do the
same when growing the file.

Reported-by: syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
---
 fs/hfsplus/extents.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524d18..39920b51e08b 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -458,6 +458,15 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
+		/*
+		 * The extents overflow file can't have overflow extents of
+		 * its own; growing it here would re-enter hfs_find_init()
+		 * on the extents tree, whose tree_lock is already held.
+		 */
+		if (inode->i_ino == HFSPLUS_EXT_CNID) {
+			res = -EIO;
+			goto out;
+		}
 		res = hfsplus_ext_read_extent(inode, hip->alloc_blocks);
 		if (res)
 			goto out;
-- 
2.43.0

