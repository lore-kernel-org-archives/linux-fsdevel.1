Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15BD2C11E4;
	Tue, 22 Sep 2026 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037132; cv=none; b=U1e7yObdUQTI7ez+rKig9HAMuUMSRKB1qTeKH5RuwaMhIXlD8ZFwHSQpZsBNimQlAwRXfUehLXO0uDS9TxLEM8aGZw0wHN2dzTokIdCJE9hFEc7bLr6oodEERFKRdkp9xonvd9GCPLb2j2HCrajNMrpwbkvWrmMbQxhIwzKtDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037132; c=relaxed/simple;
	bh=Wd3ZbLadIrxogGODGsbFUG0pKS13H7GZOCBaz6h5tGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cr+VIJgpZ07W2jd2jAQ9LBP83xCTm4tLuknDtrA2lofM348dUY2IHCu7b8+Brd1Tsgxxi5oIqEm45pnJqKwNu2jY7YsYDUPHEJmwg7C0k2a6XgKSZzmQZOBIzhS3b8IDxp7VCb4QHDo1Exe0N2T1Pzl6MYsQ2kAyhVUIBDDBKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8gwRJEM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8gwRJEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790037131; x=1821573131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wd3ZbLadIrxogGODGsbFUG0pKS13H7GZOCBaz6h5tGk=;
  b=e8gwRJEMD2FDhUkZzET52d9Xg3PWguCO3GZmlerxYbhXzecznXwhS07I
   5iY9d0AoFCCD40XfEMadkWixXa4KJf9iDdn1qtAj3g66KUYubLW35aaWp
   767szZ7n02SZNnos8xLuZ32sDW8VBOOJtyQSXluWp/XoWrjUAycct8Uat
   CJlUDDDoe/TcQHjwHYhtR+S35Y7zCdCX0R5u+KGT83c2JNW89ecrY3RY9
   pnzT2kTI6eTH4kqURpAXi3tZ1oB0hW4w+SU680lPpKvZLVpMgpYvQUioU
   flHF3uoPBFihNA0zhAlsEqVd99/PEB3WW14Y4dMiflsEpv12Tfcrv+0kn
   Q==;
X-CSE-ConnectionGUID: V7jyWxyUTS+1K/ASIbzmQA==
X-CSE-MsgGUID: fBZ5tOImTYG+eU97gKUMmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90716608"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90716608"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:32:10 -0700
X-CSE-ConnectionGUID: BDhRwhlWS2WlwcRAJYSMqg==
X-CSE-MsgGUID: /lnVmbWfSv+H+9fuhFCkJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="277671805"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2026 17:32:08 -0700
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/6] sched/cache: Fixes for cache aware scheduling
Date: Mon, 21 Sep 2026 17:37:21 -0700
Message-Id: <cover.1790035273.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is an update of the patches to fix cache aware scheduling issues
found in v7.2.

We collect the fixes in this series so it is easier to track. We have
added two new fixes for issues found since v1 of this series.

Patch 1: alb_break_llc() compares nr_pref_llc_running with
cfs.h_nr_runnable, but those count different sets - one follows queued
tasks, the other drops delay-dequeued ones.  With DELAY_DEQUEUE the
equality stops holding and active balance pulls a task off its preferred
LLC.  So fix the counter.  Reported by Zhan Xusheng:
https://lore.kernel.org/lkml/20260827135000.735138-1-zhanxusheng@xiaomi.com/

v1->v2: Minor code rearrangements in set_delayed().

Patch 2 (Lu Wang): the stopper doing active load balance builds a fresh
lb_env that doesn't inherit migration_type, so can_migrate_task() can
move a task *out* of its preferred LLC.  A new LBF_ACTIVE_LB_LLC flag
and picking the stopper callback at kick time keep the intent; passing
migration_type through the stopper would muddy delayed dequeue.  v4:
https://lore.kernel.org/lkml/20260903020656.3793626-1-wanglu.priv@gmail.com/

v1->v2: No change.

Patches 3-4 are for the use after free Hyunwoo Kim caught with KASAN:
https://lore.kernel.org/lkml/apPb-Dr4nPYuHQOK@v4bel/
account_mm_sched() reaches the stats via p->mm->sc_stat, but a task can
be switching mm on one CPU while another is inside account_mm_sched(),
so the mm and the stats inside it can go away underneath.  Locking the
rq in the mm free path felt like the wrong trade, so patch 4 pulls
sched_cache_stat out of mm_struct into a refcounted, RCU freed
sched_cache_group - just moving code - and patch 4 does the real fix:
each task takes its own reference (copy_mm(), exec_mmap(), dropped in
exit_mm()), and leverage call_rcu() to to protect
against UAF in account_mm_sched() so the group outlives any mm switch.
Zehnghui Yu also independentaly found this issue with memory poison.
https://lore.kernel.org/all/343a7e07-7fad-4979-9c9b-82ec038c293c@linux.dev/

@Hyunwoo and @Zhenhui, will appreciated you can test these patches
and add your Tested-by

Nice side effect: the group no longer follows the address space,
so a user defined group, or cgroup or numa_group could own it later.
These are also the grouping by prctl RFC's first two patches, sent here
so the fix isn't held up by that discussion.

v1->v2: Put cache aware related code in process exit/fork/copy in
its own functions

Patch 5 This patch makes sure kernel threads are excluded from cache
aware scheduling consideration.

v1->v2: Split from previous patch 3 as suggested by Peter Z.

Patch 6 is a new patch to fix an issue of undercomputing the LLC size
during CPU hot plug events.  The LLC size was used for estimating
if a process's memory footprint will fit a LLC. 
https://lore.kernel.org/all/20260916134432.11767-1-davichazbh@gmail.com/

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

Chen Yu (1):
  sched/cache: Skip kernel thread for cache aware scheduling

Davi Chaves Azevedo (1):
  sched/cache: Refresh LLC capacity across CPU hotplug

Lu Wang (1):
  sched/cache: Honor migrate_llc_task semantics in active load balance

Tim Chen (3):
  sched/cache: Keep nr_pref_llc_running in the runnable domain
  sched/cache: Decouple sched_cache_group from mm
  sched/cache: Introduce task_struct->sched_cache_grp

 drivers/base/cacheinfo.c       |  11 +-
 fs/exec.c                      |   1 +
 include/linux/mm_types.h       |  15 +-
 include/linux/sched.h          |  21 ++-
 include/linux/sched/topology.h |   4 +-
 kernel/exit.c                  |  28 +--
 kernel/fork.c                  |   2 +
 kernel/sched/build_utility.c   |   4 +
 kernel/sched/cache_sched.c     | 106 +++++++++++
 kernel/sched/fair.c            | 310 ++++++++++++++++++++++++---------
 kernel/sched/sched.h           |   3 +
 kernel/sched/topology.c        |  22 ++-
 12 files changed, 394 insertions(+), 133 deletions(-)
 create mode 100644 kernel/sched/cache_sched.c
