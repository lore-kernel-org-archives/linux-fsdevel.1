Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1848C404;
	Mon, 18 May 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112453; cv=none; b=dHajLgnI8Z4XxwIy7v3vLzEDPl64/GL3PilbFF6K1WoQGYp6KcSJWLqVcWX0EBhvYY8Pi5Z0hqYvH/tdqJCIuaoqMsDkZSkV5/aOfBYY3GslgaoUikkw4zUF1LlX+Ms0WwdKL9CqSTJsuVidZoLQciQ+XlxP1BrBFjxMb7drrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112453; c=relaxed/simple;
	bh=/ndlaEm2AzEyltMY70sxtjrabu/E9dH8nM9RTfu/Tak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vhfa8smGNyoy6V4kUHTRNZBg0V5C/E31GCsDzjM7ml1jvg9KvxJkGtqHs/EAw613dgofhFKKru4qfsSkHEVZFXvWBbLSgF3pdUiSj+NMe7FAZYPvZjgCuRUEqQmbwFa/2Xy8I/E8CL9IWBStPAoHV+VNzz1rYiigFKQmUDXvKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GgW2i4FE; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GgW2i4FE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779112441; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iyGtsLCpLgT6U3DcLLhrYq5mW4nxPzvumdZHgoMpWFE=;
	b=GgW2i4FE9LTsaxeVk1bqFtjUmevpVR2FBG0QCFMf1Lr3lgf9HH6Fs82m+47+yKOy5XgWEmvI01Qk0uWnqfBF+6FVCociqVlCWvqhG9ptjZMoCA6R3xmLe0iSaMqXgHTu4R2Xc5IKeg7B1guDpxyppPjj9ZqByMgXl5+jR7LUBXk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X3AU7wL_1779112439;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3AU7wL_1779112439 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 21:54:00 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] writeback: drop now-unnecessary rcu_barrier() in cgroup_writeback_umount()
Date: Mon, 18 May 2026 21:53:48 +0800
Message-ID: <20260518135349.1187628-3-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518135349.1187628-1-libaokun@linux.alibaba.com>
References: <20260518135349.1187628-1-libaokun@linux.alibaba.com>
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

