Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530284;
	b=dqBqJnerZOv66KeCfrdrPs7RZ7iFjPoIpU6EiRfPNPpMdyKwnWtU0qEVxqO8Qm23sH8j
	 r6kc93MayAf6rMkKo6m/NSsWNgbb13xA5+m+d89E5x4dFMke9g5WleMWzVpJ6O8D93UZ4
	 N18hajbOcejmok4JZ3Dg65dc28seQKwEBgqBEoX9/Dr1g8j7LpG6x2mXDlqBQW0AYJwIA
	 Sd+iQc7i5gZS78j2Rs/7LjPluo1e4nAF4vtvNlp0wWeK5NlG4plOV3UfGkHKlOHfQWKz0
	 r9TwQxovv7hwzXeAWBNnJ7hc6/DS7b6alvDUQk6qPODVCauToJse/rnP7iwvzSzonFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yvnB08mB1Yr/sTOxjBu451e6X91xT4mCIJMKnwmb83k=;
	b=sFW03MSZDdCJ60pIvuAVefndDi2r89W9gzi+z8KuaeIoWQ7Gme3k5KzOCJxlIrwuIRU7
	 astyAmrkABR0/sFxu/nst1/xl+N0I0ezo+lqBgfjtf2l9rS3spFxaCv5MpRx8yy0//9BF
	 SBb9/Ujn7NANYlkLeTHVT7vLd2ObWGSNEmekUki6cgHgK6zRAjKqXmgGWq8hzY469jC0X
	 9Ev3BR/73kLjhTZIKV8zwWA07n/n7g3Xd6ZBx7p1Utw6fPnUdvY/DsGgrW65RagEAxcZx
	 KEZidum4xLdjprEyPAHIb2WvFd5FLEbwlNsOnXygHHoQLYXKxcCj/Q5DfOU/q3enEEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VETePA8S;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743560A5BC3
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 00:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8743560A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VETePA8S
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67d8221074dso408427d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794530284; x=1795135084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvnB08mB1Yr/sTOxjBu451e6X91xT4mCIJMKnwmb83k=;
        b=VETePA8SaTBgwPLR66wcxj/CWzGZGW63wgzGCaPpKDKjyzEs9IvmpDWjHpmJl/Bfrw
         1JCHbgUiUkPp07I+aq0kzZc3Dv8jk13hDZomic25cNl3OIn4qiSfB65ItZLykcrJ6Hf9
         Ju3iElnm19xcrdrtwNAFK5elRtPYfkxbRObQLxW9TMneYKG9yMolBF3799fWxvu2qBD8
         9HrBMLxM5q7PzeV2UoSffiPZbU+lS6tCAA1baFRgnLAl0A+pGdrvbmm2CYmELQAO+vKh
         3I14/QaL2nCTo1pFaIR10Kc+O9sp9j7VN/4Kquv6AeTUPaH+B5g6l/+XvFOrzdsbnZf/
         KPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530284; x=1795135084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvnB08mB1Yr/sTOxjBu451e6X91xT4mCIJMKnwmb83k=;
        b=NLnWR4yYQrL7M3bhquLDRm8bDMpIO1dcIWu0hnWjue6SF5nhUQHncyt0NYCX0t86ct
         IHexBYMDlagn9wqmLe13yMD8ehPijY/9KTnQy36fRUNPYl688VARrkat2Ccy2kPB9QiS
         1cQgFP2FgTssL6n90AJomvaNRY3uPIUQj8NM8Qk2WogYnYHsMZ72NOHyfR47ZRvedTl9
         Ryl6MlyfHyX3OYkdKSTylxStUH7T8FZfkmKgMieDDxz0QovY3AUEnqrYZIX8FSYl5IUw
         MP41OaO6OpSsJRimQWoj9cB0YG44dT+1CvENOi53b3jC9xiV6jQf8mEt+p6IR1fLgljo
         0fDw==
X-Gm-Message-State: APuU4Z923qkOaBFW8RZxth6O7pfzKGJYIrxbyL93WjdiHR9GejfAygQ3
	w3qrk6g5cepkbpaQGdPxdx3yh0j0COZeTLkAiZBE/4OvOmJDp1D3EgumIJIId85A43w=
X-Gm-Gg: AYBFou3J2fGj7SZ1qpQUHUixQ3jg58D9d+HHt21+JnhVuTtd8ED+r+Fr/xiIPxiksTQ
	8CjrsdtIquO9HubQKFM7ozDorKsN2uqUuu9pVu9x9uci/QJB9M2yRrpsSzC69kB4bwfTn+MuQoM
	ewb5KZ8pjU09NRrDXpqsYswR0WtebhY21+nnl/K+SeNd5cLAqI2jAA+gpYXQJp7jA4tekW8knjB
	xkMGCGG1sbJ8O9EH6ggPpQco0ls1qCy9X1NmM+MFwkzGT/mvGpWF7AEZlLC7K96sO3q/RNbua5U
	HwzhJfyUhsdAfVz3X319MjozCkxyokRHc2g9WcDSb+KiMWK9E/ief8n9X9ntGQC7KTLUvvbjDYv
	Do4TLByvbD/iWgh01gmnt+omJHEhVhBbyf8TKADBlMGt4qhZXLl2S3Cz3TpFrlhGu/vJwcXFbsu
	imPSGlaE5Q1I7hN3tbV/PNG2EOdg/a4Iw8KuyGHAxVkYRfqefO+/h36f5YYWDOi/YVKevTK5TXz
	R9gtbQHKW4YXW927F0OMLLqjwJF+fqG+cA5Xl8iz61piYuHEuHcdphe8JY51hUyhigSeaV30gwj
	rVkdCI8HZg80v0QK+wuuwSVh9Vs+P0PRRSqoU6I/eZvIOxENQ4XJ7I9RBJtsTvq5V0eoLYPbEZG
	daCm4IQhmdwSrIh/qtfBpz/ZKCVUObYlcm+w4UrIs9L/pmqOWHNDufn/38qqOJ1D8UlgtgQg=
X-Received: by 2002:a53:dac3:0:b0:67b:ea61:fe6 with SMTP id 956f58d0204a3-67d897ce9b6mr535293d50.106.1794530283607;
        Thu, 12 Nov 2026 16:38:03 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:3a31:6c95:5610:70f6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a59e70asm706463d50.10.2026.11.12.16.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:38:03 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 2/2] hfs: don't take inode_lock in hfs_file_fsync()
Date: Thu, 12 Nov 2026 16:37:56 -0800
Message-ID: <20261113003756.1066989-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113003756.1066989-1-slava@dubeyko.com>
References: <20261113003756.1066989-1-slava@dubeyko.com>
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

hfs_file_fsync() takes inode_lock() around the metadata part of fsync.
For HFS it is not needed, because everything done under the lock is
already serialized by other means:

- write_inode_now() ends up in hfs_write_inode(), which is also called
  by the flusher threads and by sync without holding inode_lock.
  Concurrent writeback of the same inode is serialized by the
  writeback code itself (I_SYNC), and the extent and catalog records
  are updated under the extents and catalog b-tree locks taken by
  hfs_find_init().

- flush_delayed_work() of mdb_work runs flush_mdb(), which commits the
  MDB, the alternate MDB and the volume bitmap under sbi->mdb_lock.
  This state is per-superblock, so inode_lock of one file never
  protected it anyway.

- sync_blockdev() works on the block device and needs no inode lock.

So inode_lock only serializes fsync() of an inode against write(),
truncate and setattr on the same inode, and against another fsync() of
it, without protecting any state that is not already protected, while
holding off writers of that file for the whole duration of the MDB
commit and the block device flush. Drop inode_lock()/inode_unlock()
from hfs_file_fsync().

Fixes: 02c24a82187d ("fs: push i_mutex and filemap_write_and_wait down into ->fsync() handlers")
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ef1275bbbcbb..f1122ffae712 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -773,7 +773,6 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	ret = file_write_and_wait_range(filp, start, end);
 	if (ret)
 		return ret;
-	inode_lock(inode);
 
 	/* sync the inode to buffers */
 	ret = write_inode_now(inode, 0);
@@ -785,7 +784,6 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	err = sync_blockdev(sb->s_bdev);
 	if (!ret)
 		ret = err;
-	inode_unlock(inode);
 	return ret;
 }
 
-- 
2.53.0

