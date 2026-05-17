Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4723B9D9E;
	Sun, 17 May 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027754; cv=none; b=KhnXYeOdpTLlJkP0YloVVk4wvW7+qhbB9ZfZtMYixwGYtgOp0ytk92DlKFxEOfHaBK9T6VBs72TDnJO4c44dgVHSoEPAoPunpbLspDgRpU98KeRWCsnQq2qfBfJ1K1+syN9orWEo3HGx5fJwC37sMCq2CFo7trX0TwaEkdpY7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027754; c=relaxed/simple;
	bh=QcMko3k63Xe+0FVsFlSv7PxMr/AI0qeniZsIKp2nCi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lZSQC9FyN9eRD62xulEVVVh9UH83i/E3jEZ6eARCMlw3u1/XPuONuN2zGI2/EZNCoMv70C3DNoKF1MX/MC7PyLMpOrzMiLVaQXKUvZUKcXj/u2KlcLuiYTBQAcJFyMVaBUQ4jI9jNvn7wnnjKijeKWUzyu0F6WukLz+u9KItYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FbGdJABj; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FbGdJABj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779027731; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=7fqSMBgMSC8Hhhpc4cFZmk5mDtAGDUUCskiJ+Ek7stk=;
	b=FbGdJABjKjJtaHG+zTkYmgTiZc15I/qC0seFuidD7zIYGKqSDuT4ZVmRGBF40w/fcKF72787BCqIA3ndaafa6aUwEpImKH9tR2vKGf06+Xadd3c5NJfoYebJ7KyiGwGzKUfF6y7o3djtjzu61/+vjlmObwHs3vtxe9i0XKtuXT8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X31pQ78_1779027708;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X31pQ78_1779027708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 May 2026 22:22:11 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
Date: Sun, 17 May 2026 22:21:29 +0800
Message-ID: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v1:
 * Use a simple RCU-based fix (patch 1) that is easy to backport to
   older kernels; the per-sb refcount optimization is split out as a
   separate performance patch (patch 3). (Suggested by Jan Kara)

v1: https://patch.msgid.link/20260513094829.867648-1-libaokun@linux.alibaba.com

======

When a container exits, a race between cgroup_writeback_umount() and
inode_switch_wbs()/cleanup_offline_cgwb() can trigger "VFS: Busy inodes
after unmount" followed by a use-after-free on percpu counters.

There is a window between inode_prepare_wbs_switch() returning true
(having passed the SB_ACTIVE check and grabbed the inode) and the
subsequent wb_queue_isw() call.  If cgroup_writeback_umount() observes
the global isw_nr_in_flight counter as non-zero but flush_workqueue()
finds nothing queued, it returns early — leaving a held inode reference
that blocks evict_inodes() and a later iput() that hits freed percpu
counters.

Patch 1 fixes the race by extending the RCU read-side critical section
to cover the window from inode_prepare_wbs_switch() through
wb_queue_isw(), and adding synchronize_rcu() in the umount path so
that all in-flight switchers complete queueing before flush_workqueue()
runs.

Patch 2 removes the now-dead rcu_barrier() that was left over from the
old queue_rcu_work() era (removed by commit e1b849cfa6b6 ("writeback:
Avoid contention on wb->list_lock when switching inodes")).

Patch 3 replaces the global synchronize_rcu()/flush_workqueue() pair
with a per-sb counter (s_isw_nr_in_flight), eliminating the global
serialization penalty.  This also reverts the RCU extension from patch 1
since the per-sb counter makes it unnecessary.

Measured with 4 background superblocks churning cgwb switches to keep
isw_nr_in_flight non-zero, while a separate idle sb is umounted in a
loop (N=100):

Idle target umount latency under cross-sb cgwb-switch pressure:

                               p50      p95      p99      max
  patch 1+2 (synchronize_rcu) 64.4 ms  95.8 ms 101.4 ms 110.5 ms
  patch 3   (per-sb counter)   5.3 ms   6.9 ms   7.4 ms   7.7 ms
  no-pressure baseline         5.2 ms   5.9 ms   6.0 ms   6.1 ms

8 concurrent umounts of idle sbs under the same pressure (5 batches):

                                p50      p95      max
  patch 1+2 (synchronize_rcu)  57.9 ms  82.1 ms  90.0 ms
  patch 3   (per-sb counter)    7.5 ms   7.8 ms   8.0 ms

In-kernel cgroup_writeback_umount() cumulative cost over 286 calls
(bpftrace, kprobes filtered to the umount call context):

                                cgroup_writeback_umount() time
  patch 1+2 (synchronize_rcu)     8717 ms total  (~30 ms / call)
  patch 3   (per-sb counter)      1.16 ms total  (~4 us / call)

Comments and questions are, as always, welcome.

Thanks,
Baokun

Baokun Li (3):
  writeback: fix race between cgroup_writeback_umount() and
    inode_switch_wbs()
  writeback: drop now-unnecessary rcu_barrier() in
    cgroup_writeback_umount()
  writeback: use a per-sb counter to drain inode wb switches at umount

 fs/fs-writeback.c              | 52 +++++++++++++++++++---------------
 include/linux/fs/super_types.h |  8 ++++++
 2 files changed, 37 insertions(+), 23 deletions(-)

-- 
2.43.7

