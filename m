Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F703B6340;
	Sun, 17 May 2026 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027755; cv=none; b=sIg2Nc5EIojHacddBhlIYIBNm9bxlnxb6VEGJqiJhu4bnHXAmNwKfWyOxD8iYAA1dZu1AfeYT5QGRp4m2lit9LEeXVoFUe6QNcTrlDxSMG4I+wHYrHZqef1u5osMO02imEe8X5RMJkR4ZLOcF+zsqwFS0BLAKA1jt7KX7ZRNtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027755; c=relaxed/simple;
	bh=5hY3F0Ab1d0mPnYcm8X5rkr2dRXRed9/0i2JO6zD8OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7nL8pUcplKLNZKf+7OClQcgN46KKpJdFdLgQ7IWYJRiWd20pihRpoYF/zmwBVr5LAPgOpdtaaAFYYaPIYC+oqWfWV45gFUiKRQ+lIIE05qsjvuBppAcR8xyQC3GQ1oQlCv8SzMktMmNzGGiVLEJ1eF9mn3U5GcvQOwLEf5P2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AXILGgDN; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AXILGgDN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779027733; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CfBA/2IgnyZniAFp9jsEvw4nY5aItReLADys2BWbIxs=;
	b=AXILGgDNA1nzKP5TqoNZ2dgJA0Q6PJwMe6OsTJwvXyLSoZ5XrRuY/O/59KzHubZULOdtMsLahD4Y9/k3smOWxEeZ7uzBii3RrJUxjG0IFyNxshabnPKtYBC7xNggE+YyW4t9+GbQt/slw8dMLew8lOZojfJq01ldWKYkKLVed14=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X31pQEj_1779027732;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X31pQEj_1779027732 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 May 2026 22:22:12 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] writeback: drop now-unnecessary rcu_barrier() in cgroup_writeback_umount()
Date: Sun, 17 May 2026 22:21:31 +0800
Message-ID: <20260517142147.3354909-3-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
switching inodes") replaced the queue_rcu_work() based scheduling of
inode wb switches with a plain queue_work().  Since then no switcher
goes through call_rcu(), so rcu_barrier() in cgroup_writeback_umount()
has no work to wait for and is effectively a no-op.

Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fs-writeback.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1f95ddcee363..9ae290547eb2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1246,11 +1246,6 @@ void cgroup_writeback_umount(struct super_block *sb)
 		 * will then drain it.
 		 */
 		synchronize_rcu();
-		/*
-		 * Use rcu_barrier() to wait for all pending callbacks to
-		 * ensure that all in-flight wb switches are in the workqueue.
-		 */
-		rcu_barrier();
 		flush_workqueue(isw_wq);
 	}
 }
-- 
2.43.7

