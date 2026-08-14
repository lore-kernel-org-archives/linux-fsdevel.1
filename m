Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935D4756A7;
	Fri, 14 Aug 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714860; cv=none; b=kBEZrsj/NM8uVAEVl6fDXcq5Koyx7H/ql2UGxV2jHgfhD6hw9UZlF008tUTTa23J1r3XDzD4ZNSGjyA22ppPkrvAQ9n5zgLAE4yaon1cmDULCeTsgygmHWAiV6VScnRdFF6L+/wHTn/jwLLh5n4cT+/8yQO615/yoxwISbwkfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714860; c=relaxed/simple;
	bh=ZRx2o5PsFFro4QK1c59hKXc3fvpz0mSdprjX714FPK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+z8Oo0b9jtK2ja01XcIBF1Q/JsxGGpYRpIlq+RZiVMsxONrwZklrevEjYPpWE19cZj5VfXLK5+lW7IEd6R3TTAobuo+G8kT9M+MAysxzTKEm4C53QmhHILUCrlt66cIyRT+uOD/7k59/oUzgRWtUHJc9DW+0ZnbaSsRyywkUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L32qAB45; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L32qAB45"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786714844; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vkfVFVy9+aqCm2qpilkCN7J5eLMxQ6B9cWKq6CeYbKs=;
	b=L32qAB45ACWbc/VkaqbcBiBRIaILa+i68kPtfXNf3n6FaiJMJMOySysnY6k5/Nq1UPIUANvrt5DWKI6ajBXz64kWynC5mPgdty2cXMiDW3TA+nHrLLK7wp2mHYuiiqdoELZ5aBasK0H+dHzslfP6XYj7WRj81OkSB4TyXEMrVNI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X8xfu2S_1786714815;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X8xfu2S_1786714815 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Aug 2026 21:40:43 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jefflexu@linux.alibaba.com
Subject: [PATCH] cuse: wait for pending RCU callbacks on module exit
Date: Fri, 14 Aug 2026 21:40:15 +0800
Message-ID: <20260814134015.618488-1-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 053fc4f755ad ("fuse: fix UAF in rcu pathwalks"),
fuse_conn_put() frees the fuse_conn through call_rcu() rather than
synchronously.  For cuse, fc->release is cuse_fc_release(), which
lives in the cuse module.  If the module is removed before the RCU
grace period ends, the callback jumps into freed module memory:

      userspace / module unload      |        RCU softirq
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 close(/dev/cuse)                    |
  cuse_channel_release()             |
   fuse_dev_release()                |
    fuse_conn_put(fch->conn)         |
     call_rcu(delayed_release) ------+---> callback queued
                                     |
 rmmod cuse                          |
  cuse_exit()                        |
   cuse_channel_destroy()            |
   ...                               |
   return                            |
                                     |
 <module text freed>                 |
                                     |  rcu_do_batch()
                                     |   delayed_release()
                                     |    fc->release()
                                     |     -> cuse_fc_release()
                                     |        ^^^ freed text!

The freed module text is unmapped by vfree(), so the jump into the
stale callback triggers a page-fault Oops.  If the virtual address
is subsequently reused, the callback could execute unrelated code
(undefined behaviour).

Fix this by calling rcu_barrier() in cuse_exit() so that any pending
fuse_conn release callback completes before the module is removed.

Fixes: 053fc4f755ad ("fuse: fix UAF in rcu pathwalks")
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fuse/cuse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 3c15b5ba16d7..1c71783ca5a5 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -653,6 +653,11 @@ static void __exit cuse_exit(void)
 {
 	misc_deregister(&cuse_miscdev);
 	class_destroy(cuse_class);
+	/*
+	 * Wait for pending call_rcu() callbacks that call back into
+	 * this module via fc->release (cuse_fc_release).
+	 */
+	rcu_barrier();
 }
 
 module_init(cuse_init);
-- 
2.43.7

