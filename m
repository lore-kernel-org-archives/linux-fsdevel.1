Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457C30CD95;
	Tue, 11 Aug 2026 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424057; cv=none; b=MPnLkLEJcgGQ2mrn6x2AVhc7NoX4wpTS3fAtW54T+Jvmn4g2sQUdliDVIQGen5nI0g6MvWIsKF2n4MLpAhcS0jYBlH7li5Nn1TtKay35WDk4+CBACNZ/oVho/AM+TtGpD3UevtB1w9fV6vtTcHl/GvjKc8MyC2Z5ZU9TCsBbgd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424057; c=relaxed/simple;
	bh=zJnj5AcWHRy0uG3inuEbKpksIgVdVay1iNctU3gCROM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0KLpD7L9qU+y2y/5JqaP45xKun3Wi0erd5xPESzxMkUUBflR18OAW9j5h/tT3h9Bmz6jIlTWO5fnwjog5UQ4EGl1F/WllSQJVM6tDPcZ2R0fvCetEdnaVwW4zaIslV0KuNSt8gb/sdnSrJe+eRElkXdNs9ASDDcVK3IuWBEIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fZDaO79w; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fZDaO79w"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786424050; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Spt74NgA1fMWxd8WEJ3bVJechQfejG3SU8amuxa5hq4=;
	b=fZDaO79wdqMPbCFooFMq+Hz7xfh0y19oLQj1hmefNwoyrtU1CaRPBp9j0nW93YRd0MqfXCLgC3IDAsqo2+4OCe5fCG++s5Y/9CeFd/cyD6QXgiq+OINHl+ILZiIDxFpgzGePnBxA2Qc0HqCG3HZh91h2Ye9eCjSCJuDTFZLHvEo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X8nA3oU_1786424031;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X8nA3oU_1786424031 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 12:54:09 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH] fuse: reject a duplicate fd= mount option
Date: Tue, 11 Aug 2026 12:53:50 +0800
Message-ID: <20260811045350.164272-1-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_opt_fd() stored the fuse device in ctx->fud and bumped its refcount
unconditionally:

        ctx->fud = fuse_dev_grab(file);

If fd= is given twice (two fsconfig FSCONFIG_SET_FD calls), the second
call overwrites ctx->fud and grabs the new device, while the reference
taken on the first device is never released - a permanent refcount leak
that pins the first fuse_dev until reboot.

Reject a second fd= outright.  ctx is zeroed on allocation, so a non-NULL
ctx->fud reliably means the option was already processed.

Fixes: d42eb23b2ef9 ("fuse: don't require /dev/fuse fd to be kept open during mount")
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fuse/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 455c7feba057..2372e6ed333f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -791,6 +791,9 @@ static int fuse_opt_fd(struct fs_context *fsc, struct file *file)
 {
 	struct fuse_fs_context *ctx = fsc->fs_private;
 
+	if (ctx->fud)
+		return invalfc(fsc, "Multiple fd specified");
+
 	if (file->f_op != &fuse_dev_operations)
 		return invalfc(fsc, "fd is not a fuse device");
 	/*
-- 
2.43.7

