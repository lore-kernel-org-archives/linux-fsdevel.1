Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92F36212C;
	Thu, 10 Sep 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062063; cv=none; b=pcSGUE1ripH7eNXVJRAHL4Q+KF01q+Fu2HjMn5VAhnOqvqzqfXTh2vaj29RaGqoSLPbmgyY840144X0AHJJ5xBqY35yo4XxuCPfpCLvxIW7OaBIFmsDbYhZL4lpnkg0cFTq3Mc2eJ3XRO30Z+UaR9JXzOzkT2xhQXrStFJUviHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062063; c=relaxed/simple;
	bh=Pw2ile9UJm9sSX8bIRs5HbF7n8pZFfyy9pU9RW/L6dY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YXGuUfjyRGrhpJABzJYD+lEdr9PPxwmW1fz54JHIetks9L4Klvxami5t9RQnEdlg+8J+RvuTTJFql4GXtsNaviDv4eA32/9+qgeFrU2+G98OHhzg5A8/UKoQuwjPpwfuu50kMN5UKklvqTcjVbIDpmvdny2NiLVqEV1U+jKQMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcw4o46r; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcw4o46r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789062056; x=1820598056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pw2ile9UJm9sSX8bIRs5HbF7n8pZFfyy9pU9RW/L6dY=;
  b=gcw4o46rlGXZEcweavAluGM3OIbnHyz4sYib9apgKTKayWlD3H4+SHFW
   U8scg8a+R89QW6HnDPnlFDwCOlyUtSWZkAFtHU0+4grxjIfzTtvdCJTUd
   jF8uQoAAFIG9IzJMkZwt8sECm6EVaeACLvilDCavff+hL1p23wZq5KD/C
   KrJA5FYf5X7eN72wafMJJZghUukWBxLh6Es7awuu6hViFCvy5fgcTmCG6
   5Hyx9yr/HnHReutv3SLI8f+vZkNJJ+C1LKmI4xL0RThfoIFW51tcWcDnf
   MlTVDDdhgd24itLMKesB8D4hPLy07PyTGqdXwukON4qqh4S2Jgk8N+jqf
   g==;
X-CSE-ConnectionGUID: XslhPgcXTsS+kfY2bEysBQ==
X-CSE-MsgGUID: YeUKpJ2URfi6bl45qQSRaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89453770"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89453770"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 10:40:49 -0700
X-CSE-ConnectionGUID: ykw0HvrzSzSnsZLcrRAFXg==
X-CSE-MsgGUID: qRKwknrZTm6tjcrtG2htfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="275222006"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa003.jf.intel.com with ESMTP; 10 Sep 2026 10:40:49 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
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
	Chen Yu <yu.c.chen@intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] sched/cache: Fixes for cache aware scheduling
Date: Thu, 10 Sep 2026 10:46:08 -0700
Message-Id: <cover.1789061845.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Cache aware scheduling went in for v7.2 and people have found a few
things wrong with it since.  We collect the fixes in this series
so it is easier to track. Two keep tasks from
being stranded outside, or yanked away from, their preferred LLC; two
fix a use after free.  Patches 1-2 stand alone, 3 and 4 go together.

Patch 1: alb_break_llc() compares nr_pref_llc_running with
cfs.h_nr_runnable, but those count different sets - one follows queued
tasks, the other drops delay-dequeued ones.  With DELAY_DEQUEUE the
equality stops holding and active balance pulls a task off its preferred
LLC.  So fix the counter.  Reported by Zhan Xusheng:
https://lore.kernel.org/lkml/20260827135000.735138-1-zhanxusheng@xiaomi.com/

Patch 2 (Lu Wang): the stopper doing active load balance builds a fresh
lb_env that doesn't inherit migration_type, so can_migrate_task() can
move a task *out* of its preferred LLC.  A new LBF_ACTIVE_LB_LLC flag
and picking the stopper callback at kick time keep the intent; passing
migration_type through the stopper would muddy delayed dequeue.  v4:
https://lore.kernel.org/lkml/20260903020656.3793626-1-wanglu.priv@gmail.com/

Patches 3-4 are for the use after free Hyunwoo Kim caught with KASAN:
https://lore.kernel.org/lkml/apPb-Dr4nPYuHQOK@v4bel/
account_mm_sched() reaches the stats via p->mm->sc_stat, but a task can
be switching mm on one CPU while another is inside account_mm_sched(),
so the mm and the stats inside it can go away underneath.  Locking the
rq in the mm free path felt like the wrong trade, so patch 4 pulls
sched_cache_stat out of mm_struct into a refcounted, RCU freed
sched_cache_group - just moving code - and patch 5 does the real fix:
each task takes its own reference (copy_mm(), exec_mmap(), dropped in
exit_mm()), so the group outlives any mm switch.  Same Fixes: tag and
Hyunwoo's Tested-by on both; they want to go in together.

Nice side effect: the group no longer follows the address space,
so a user defined group, or cgroup or numa_group could own it later.
These are also the grouping by prctl RFC's first two patches, sent here
so the fix isn't held up by that discussion.

BTW, there are two other issues in discussion currently and need
a bit more work:
1. Incorrect donor context being passed to task_tick_cache().  
https://lore.kernel.org/lkml/20260909092901.2989564-1-sh_def@163.com/
It is currently under discussion and is not included in this series.
2. Cache aware scheduling interfering with ITMT.
https://lore.kernel.org/lkml/20260810033742.1688718-1-yu.c.chen@intel.com/
https://lore.kernel.org/lkml/2fe2c681-b748-41fa-8b56-1169c86cefbc@intel.com/ 

Applies on sched/urgent branch. 

Tim Chen and Chen Yu

Lu Wang (1):
  sched/cache: Honor migrate_llc_task semantics in active load balance

Tim Chen (3):
  sched/cache: Keep nr_pref_llc_running in the runnable domain
  sched/cache: Decouple sched_cache_group from mm
  sched/cache: Introduce task_struct->sched_cache_grp

 fs/exec.c                    |  14 ++
 include/linux/mm_types.h     |  15 +-
 include/linux/sched.h        |  11 +-
 kernel/exit.c                |  28 +++-
 kernel/fork.c                |  23 +++
 kernel/sched/build_utility.c |   4 +
 kernel/sched/cache_sched.c   |  39 +++++
 kernel/sched/fair.c          | 297 ++++++++++++++++++++++++++---------
 kernel/sched/sched.h         |   3 +
 9 files changed, 340 insertions(+), 94 deletions(-)
 create mode 100644 kernel/sched/cache_sched.c

-- 
2.32.0

