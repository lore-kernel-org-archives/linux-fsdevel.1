Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FC37CD3A;
	Thu, 21 May 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357040; cv=none; b=itQtVdYHTTFbe/zAOrkhSO/McnxsA9ttxncOvBl++mA3CRp526OasnLPt+mvUvdsPdIwkDluNytu0eEqV3bqbWetEXYuUAU9LnQgJ0OckDZF4GgYxaTL9/ykilDFP+5VmGOBC4T16rWl3lrqpGc2eJ25VEMpMuNf2Lw8PB9Wzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357040; c=relaxed/simple;
	bh=VxTa38ZvSDLATCO5Zt48j/xDz3Rs7ECODNHcg947OTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffYUTGU8QjswZZvt1E/pMleX14BrAb8SKLrOCDFZyIBSiMw/fLh6lPhdwqYkXsvYDu8UN4XP6ahko4jBksGDf7dA7XTdkUn6t4QXIeHd597bfSBSud2gSrH/t75djGTtJR7haZV/eoIL5iNEYc8o3f0zQX845tQtFDfWrQHSsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jwC443fY; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jwC443fY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779357029; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=un3cR4CaUrzDmC2mrVls3HmvXnNKfKrmD/F9F7FTF/Q=;
	b=jwC443fYHnFHeMi+k5fvsfoS4n7IPX4fb6GmlIrhkUbPhKpKUUuB73hmfjifUGRZMNzrLoR8U1rxPlo5hOIklJ0PA8+ylhdE8IgGcxaDiW/Szt4M+B3zBPx0WuWdld7+5COuTkI9CiVHIJIAOHHCtHpYWjkWQZZi0jryOsnRdKc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X3LSGGG_1779357016;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X3LSGGG_1779357016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 May 2026 17:50:28 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3]  writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
Date: Thu, 21 May 2026 17:50:13 +0800
Message-ID: <20260521095016.2791354-1-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Changes since v3:
 * Collect RVB from Jan Kara. (Thanks for your review!)
 * Patch 3: Remove stale comments. (Reported by Sashiko)

Changes since v2:
 * Collect RVB from Jan Kara. (Thanks for your review!)
 * Patch 3: switch to wake_up_var() / wait_var_event() to drain
   s_isw_nr_in_flight. (Suggested by Christian Brauner and Sashiko)
 * Polish comments and changelogs.

Changes since v1:
 * Use a simple RCU-based fix (patch 1) that is easy to backport to
   older kernels; the per-sb refcount optimization is split out as a
   separate performance patch (patch 3). (Suggested by Jan Kara)

v1: https://patch.msgid.link/20260513094829.867648-1-libaokun@linux.alibaba.com
v2: https://patch.msgid.link/20260517142147.3354909-1-libaokun@linux.alibaba.com
v3: https://patch.msgid.link/20260518135349.1187628-1-libaokun@linux.alibaba.com

======

When a container exits, a race between cgroup_writeback_umount() and
inode_switch_wbs() / cleanup_offline_cgwb() can trigger
"VFS: Busy inodes after unmount" followed by a use-after-free on
percpu counters.

There is a window between inode_prepare_wbs_switch() returning true
(having passed the SB_ACTIVE check and grabbed the inode) and the
subsequent wb_queue_isw() call.  If cgroup_writeback_umount() observes
the global isw_nr_in_flight counter as non-zero but flush_workqueue()
finds nothing queued, it returns early -- leaving a held inode
reference that blocks evict_inodes() and a later iput() that hits
freed percpu counters.

Patch 1 closes the race by extending the RCU read-side critical
section to cover the window from inode_prepare_wbs_switch() through
wb_queue_isw(), and adding synchronize_rcu() in the umount path so
that all in-flight switchers complete queueing before
flush_workqueue() runs.  rcu_barrier() is intentionally retained so
the same hunk applies cleanly to stable trees that still queue
switches via queue_rcu_work().

Patch 2 removes the now-dead rcu_barrier() that was left over from
the queue_rcu_work() era (replaced by plain queue_work() in commit
e1b849cfa6b6 "writeback: Avoid contention on wb->list_lock when
switching inodes").  This is mainline-only.

Patch 3 replaces the global synchronize_rcu()/flush_workqueue() pair
with a per-sb counter (s_isw_nr_in_flight) plus three small helpers
(cgroup_writeback_pin / cgroup_writeback_unpin /
cgroup_writeback_drain), eliminating the global serialization
penalty.  This also reverts the RCU extension from patch 1 since the
per-sb counter makes it unnecessary.

Performance
-----------

Measured on a 16 vCPU QEMU guest, all kernels share the same .config.
Background load: 4 ext4 superblocks each running

  while :; do
      mkdir /sys/fs/cgroup/<tag>-tmp$N
      ( echo $BASHPID > <tag>-tmp$N/cgroup.procs
        dd if=/dev/zero of=$mp/burner bs=4k count=256 conv=notrunc \
       oflag=sync)
      rmdir /sys/fs/cgroup/<tag>-tmp$N
  done

This drives both inode_switch_wbs() (different cgroups writing the
same inode) and cleanup_offline_cgwb() (dying memcgs), keeping the
global isw_nr_in_flight non-zero throughout the run.  Latencies are
wall-clock around umount(8) on a separate target sb; only the target
sb's umount is measured.

Four kernels are compared at each step of the series:

  base       pre-fix mainline
  +race      base + patch 1 (race fix, keeps rcu_barrier)
  +rmbarrier +race + patch 2 (drop rcu_barrier)
  +persb     +rmbarrier + patch 3 (per-sb counter)

Target sb runs its own cgwb churn:

                p50      p95      p99      max
  base         99.7 ms 112.9 ms 112.9 ms 127.2 ms
  +race       110.2 ms 153.8 ms 153.8 ms 160.4 ms
  +rmbarrier   67.6 ms  88.3 ms  88.3 ms  96.8 ms
  +persb        7.9 ms  10.0 ms  10.0 ms  10.1 ms

Idle target umount under cross-sb cgwb-switch pressure:

                p50      p95      p99      max
  base         92.0 ms 123.5 ms 136.5 ms 141.3 ms
  +race       118.8 ms 154.6 ms 164.7 ms 165.3 ms
  +rmbarrier   62.7 ms  95.4 ms 108.1 ms 108.6 ms
  +persb        5.3 ms   6.9 ms   7.4 ms   7.4 ms

8 concurrent umounts of idle sbs under the same pressure:

                p50      p95      p99      max
  base        137.5 ms 166.9 ms 166.9 ms 171.3 ms
  +race       162.2 ms 183.9 ms 183.9 ms 217.0 ms
  +rmbarrier   61.3 ms  99.5 ms  99.5 ms 113.7 ms
  +persb        8.1 ms   9.1 ms   9.1 ms   9.5 ms

A no-pressure baseline run (no background load) measures ~5 ms p50
across all four kernels, validating that the methodology has no
systematic bias.

In-kernel cgroup_writeback_umount() cumulative cost across the same
run (bpftrace, ~340 calls covering all four scenarios):

                                cgroup_writeback_umount() time
  base                          21240 ms total  (~62 ms / call)
  +race      (rcu_barrier+sync) 24966 ms total  (~73 ms / call)
  +rmbarrier (synchronize_rcu)  12371 ms total  (~36 ms / call)
  +persb     (per-sb counter)    1.37 ms total  ( ~4 us / call)

Under +persb the wait_var_event() condition is true on entry
whenever the target sb has nothing in flight, so synchronize_rcu()
and flush_workqueue() are never called on this path.

Notes:

  - Patch 1 adds ~10-27 ms p50 over base by introducing
    synchronize_rcu().  This is the cost of closing the race
    correctly and is paid by stable backports as well.
  - Patch 2 ("drop rcu_barrier()") was expected to be a pure cleanup
    on mainline, but actually removes a real wait: rcu_barrier()
    drains call_rcu() callbacks from *all* subsystems, and the
    cgroup teardown path keeps that pipeline busy under this
    workload.  Removing it cuts ~43-101 ms p50 on top of patch 1.
  - Patch 3 (per-sb counter) replaces the global wait entirely; the
    target sb no longer waits for activity on unrelated sbs,
    recovering near-baseline latency in all three scenarios.

Comments and questions are, as always, welcome.

Thanks,
Baokun


Baokun Li (3):
  writeback: fix race between cgroup_writeback_umount() and
    inode_switch_wbs()
  writeback: drop now-unnecessary rcu_barrier() in
    cgroup_writeback_umount()
  writeback: use a per-sb counter to drain inode wb switches at umount

 fs/fs-writeback.c              | 71 +++++++++++++++++++++-------------
 include/linux/fs/super_types.h |  8 ++++
 2 files changed, 53 insertions(+), 26 deletions(-)

-- 
2.43.7

