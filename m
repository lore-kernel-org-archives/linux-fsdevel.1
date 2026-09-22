Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4333F5B6;
	Tue, 22 Sep 2026 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037140; cv=none; b=DNsRqQt8gIzDFQY/yIehkWtj66PjI1z1Gz9KeD3cPIkKPw1CS2rKaunQ29KjsD4BBE/4l8W1ZYHelzpBU/zMRrT2Blc/7x42btKzvNAJ0Gw9GNUKqhNwxp3MW7Xe3Sf75i8l4zU+pA72XbhY+fakjNCJsCDY7ajbt91XtAa/yM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037140; c=relaxed/simple;
	bh=pOlHJ5o3h0eTKEGfK5htB/gt/IweJdH5Z9ZDtcA9SHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LKXNDIITufTSXpem7p4rYBeZ9zrxriWeUbmP9jUFCnoQlekU45jxHbWeBi1eGGjrqEkp/T+aTI6/hViIXOYeoLZnSwLvo77okQmVMGNA0CNs4JM/6vWM1LAfwuXWKzrYy1tsFbmJ8BOrY1D25/F7Or3nXwEdlnK01bfKnlgL1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhudifD4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhudifD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790037139; x=1821573139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOlHJ5o3h0eTKEGfK5htB/gt/IweJdH5Z9ZDtcA9SHU=;
  b=FhudifD4556rpGjT5Cp4KrW82omp9ZPr1vgjyNzZPOuv5G8pQKfah8Gq
   8sFZTFg2ICiuXAbayqyagGQvwKtzns6NufKwl6qq3MHVW4oofmxSdj2NU
   8I9RtsAUx1lIVonKfxFqYaEzXAJI8Vg6B5W3hmLibe0GhbY5Yxie1AD2A
   aOvXTU7PDpNHvSl66bc/JtaFmKCvMvrwvC9yG8bhfNThVy2Nr520133Zl
   kt0XuAnqNWFHjrmcPY1vE8eykoIROUQNVMJj0ITUiSVbO1/dnnOGqECEv
   P/4a5rJv8y6ato2oVnDCms2OSeZvFY1PWnBnPsuqg2b6UzvLvt7phnTrr
   w==;
X-CSE-ConnectionGUID: 2HVDypgkSkqi9/Ni2KNgmw==
X-CSE-MsgGUID: 6/Z09I8yR7+3cv9RoSXsaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90716718"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90716718"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:32:18 -0700
X-CSE-ConnectionGUID: FK5iBX5YTM+jt9J2U/V1QQ==
X-CSE-MsgGUID: dAaD2tWDQOCsMtP+fuKQ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="277671907"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2026 17:32:17 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Chen Yu <yu.c.chen@intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Vineeth Remanan Pillai <vineethr@linux.ibm.com>,
	Ricardo Neri-Calderon <ricardo.neri-calderon@linux.intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Yi Lai <yi1.lai@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH v2 5/6] sched/cache: Skip kernel thread for cache aware scheduling
Date: Mon, 21 Sep 2026 17:37:26 -0700
Message-Id: <058f0c6ea7b991c177a17de347fa3157f25489a7.1790035273.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1790035273.git.tim.c.chen@linux.intel.com>
References: <cover.1790035273.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Yu <yu.c.chen@intel.com>

Kernel thread should not be covered by cache aware scheduling as
it borrows the statistics from the user space thread. Filter the
kernel thread in account_mm_sched().

In theory a kernel thread does not have any valid
cache group, so !grp should gate the kernel thread.
Add the PF_KTHREAD check explicitly here for safety
reasons, to guard against future modifications and
to pair with task_tick_cache().

Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-aware load balancing")
Cc: stable@kernel.org #7.2.x
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e2d236be2a3..341d2f9ed72b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1805,8 +1805,14 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	/*
 	 * init_task, kthreads and user thread created
 	 * by user_mode_thread() don't have a cache group.
-	 */
-	if (!grp || !grp->pcpu_sched)
+	 * In theory a kernel thread does not have any valid
+	 * cache group, because sched_cache_fork() is not
+	 * invoked for a kernel thread - !grp should gate the
+	 * kernel thread. Add the PF_KTHREAD check explicitly
+	 * here for safety reasons, to guard against future
+	 * modifications and to pair with task_tick_cache().
+	 */
+	if (!grp || p->flags & PF_KTHREAD || !grp->pcpu_sched)
 		return;
 
 	pcpu_sched = per_cpu_ptr(grp->pcpu_sched, cpu_of(rq));
-- 
2.32.0

