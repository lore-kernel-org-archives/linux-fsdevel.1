Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D737DE8D;
	Thu, 21 May 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357041; cv=none; b=fK9+QhDmlcHX7e5mUdke70vh8zjwTI1+CSPmBqJuSEeSh9/XcUxw4ntn6BTLNEtrwt2mBJOd7h7joOsLj2hp0k2AdhtdIRDNa7p9Vt6uKNylTVidHy3qAW5wYQLaIp/DXKMx9JJ1HzZnTZ7LH3ioV8gLzpmgUBeE6rww39vM+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357041; c=relaxed/simple;
	bh=BnaivCo3nWJuHu7NBuJ0nPZpieQ8Pv9U1VmbiF0pj3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5Q7VK/8yisF7wgY1m2hwRNGXIjDlKnZtSJjlNWvVSq7AGR/v1SrIRjo0taEdstg8re1Uxba42XklYKPOt9qFFvTO1+3mWtEKi6IraGJxTyKSKmpp9B1vDUFSy9FR8G5Qz9pmg84eW9B0rV5pkdVK6aSue0z+u2rZPB0pSOt6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IBVJnveK; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IBVJnveK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779357030; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RaV2rZulELZ4y+OL8DOIduNWyB9+ie+XcnZR9Ss1DPc=;
	b=IBVJnveKIMxp2Q7pipH3RNlByTtSG8fb8BAASbX/n0BJOpMoxWLK4c45tPyvnQJ/bBKafZeJMZlQbB34AlehFs8T+BXvX23RIsTe162ml3NbualIiQ59Kn18RatzKpxGn9YizNzJDP+k3gjzcCk3alQi41TlGngP/kfsjqj+zZw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X3LSGLX_1779357029;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3LSGLX_1779357029 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 May 2026 17:50:30 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] writeback: drop now-unnecessary rcu_barrier() in cgroup_writeback_umount()
Date: Thu, 21 May 2026 17:50:15 +0800
Message-ID: <20260521095016.2791354-3-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
References: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
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
has no callbacks of its own to wait for.  It still drains unrelated
call_rcu() callbacks from other subsystems on busy systems, which
incidentally slows umount down; drop it.

Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fs-writeback.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6766de9f9d75..325a30cc35bf 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1248,11 +1248,6 @@ void cgroup_writeback_umount(struct super_block *sb)
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

