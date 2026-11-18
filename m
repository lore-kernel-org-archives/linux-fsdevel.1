Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039324;
	b=VCvnXZNyRN8wguGM+6N6OihSU5dec8Vaq22mQT6cz1CIyKXw5IrcAYPP2DT6UHfo+G4s
	 eN62/ic/NUC6psFQzMp8IrpK/VITfAI/jc3nkdPxRoPheDuXWuAHPL8WscQl00pN70K8v
	 uxJhYGMLr7oS5dcksS/1EQLIS9XoybMjVazVSOcysjAOp+mpRmY7L7dTVgYx2LwODLD/1
	 w79wCRvC3YQBv/w/OPV3eARuvuzxGhw661dJELJ4chyTEa8kfgbLi7yl583h9lRBDUEPH
	 HyzQlATjkqXFjDI7ssGWPDBWQWOQteaca/vd7obdsjk+js7K6cgMqzuvZB/9IXNShSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039324;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XRDroY0sFver367kyPDJQmEiNfmQbEfbzCRal+gdQOs=;
	b=pyLRHtPkEBHAo53AwdMv7u4CNpYuUtByZ6jz5jrFXKJRaDgRv+yndKgt1mYkG36T0kyh
	 Ow+o7+4guPaayxHRSarZCHWUEJY3eH6ddCkymr4Q8tOQC5IIFl3/+NzjzKiv5SMllyu/a
	 YZghAunFhe49lOP18gX0VXo/LPm+9e+oRMqyPqo6W3sZJ9dydxE408P0uwMUuSTq7eryu
	 VSeK1WXc4vKSvUmrJbLmUeBdBv4HwLdFOZ0LYR1wnG+B37+ALDwR9p02gQYOBN/GJia4o
	 QsSjqN/j+9xmw29v/i4iNKETwcCZuxhzt8IeuLw/vFUHTBqHwewfZe503MUN9TQc9Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qWmNt2nF;
	arc=none smtp.remote-ip=95.215.58.117
Received: from mta1.migadu.com (out-117.mta1.migadu.com [95.215.58.117])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D077606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 22:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D077606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qWmNt2nF
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DGS02wSdxHBC/Vz45KLDoTie2ewpXny5EB7Q155fn3U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795039321; v=1; x=1795644121;
 b=qWmNt2nFPdVNIlT8raP3f2MYzRV7XMj76d6AV0d4+9VWSX2R/C++wAxcR2GXq5wDgryIW1Ue
 9DFJySq+l3uVfG3sjJ+XF0JQZ/NTiHS8Ne3Wh00uTiLz94IphqdWVn39e7cl9TrDAAZrH+Be97Q
 fCCQ0VTogtqkG8L75bJQuD5I=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0b0544c079918681;
	Wed, 18 Nov 2026 22:02:01 +0000
X-Mizu-Trace-ID: 0b0544c079918681
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Ian Kent <raven@themaw.net>,
	"T . J . Mercier" <tjmercier@google.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] kernfs: stop taking kernfs_iattr_rwsem for writing in mkdir/rmdir
Date: Wed, 18 Nov 2026 14:01:47 -0800
Message-ID: <20261118220154.2965621-1-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the Meta fleet, cgroup mkdir and rmdir can stall cgroup operations
on the whole host.  They hold cgroup_mutex and kernfs_rwsem while they
wait for kernfs_iattr_rwsem, which every path walk takes for reading,
and they take it once or twice for every file of the cgroup.  systemd,
clone3() into a cgroup, BPF queries and the OOM daemon all wait behind
them.

- Our lock monitor saw a kernfs_rwsem writer blocked on
  kernfs_iattr_rwsem several thousand times on a large number of hosts
  in 29 days (in mkdir and rmdir), for up to 1.8 s at a time.

- Under memory and CPU pressure the waits become host-wide stalls.  In
  one week, we observed several cases where the OOM daemon and the
  monitoring agent were stuck for up to 22 minutes.  In October, one
  batch job caused these stalls on a large number of hosts.  On the
  sampled hosts with current kernels, the cgroup_mutex owner was always
  waiting for kernfs_iattr_rwsem (in mkdir and rmdir).  One specific
  stall lasted 90 minutes and ended in a reboot.

The write lock is not needed for most of what it covers:

- kernfs_rwsem already serialises the parent's two counters and
  KERNFS_REMOVING (patches 3 and 4).
- The parent's times get a seqlock of their own (patch 5).
- Only inode setup needs to set a directory's i_nlink, so removal can
  clear it without the lock (patches 2 and 6).

The lock also kept times and link counts stable while getattr and
permission copied them into the shared inode.  Patches 1 and 2 make
getattr report them from the node and stop copying them, so stat()
cannot return a stale or torn value.

After the series, mkdir and rmdir take no kernfs_iattr_rwsem for
writing.  Write acquisitions, from lock_stat:

                                          before   after
  5 dummy netdevs created and removed       1850       0
  100 cgroup mkdirs and 100 rmdirs          7500       0

Latency in a VM with 8 vCPUs, while 32 threads walk cgroupfs paths
(worst of three 20 s runs; mkdir and rmdir by a SCHED_FIFO thread):

                         before                  after
                    p50     p99     max     p50    p99    max
  cgroup mkdir     2.8ms   9.0ms  20.1ms    25us   37us   84us
  cgroup rmdir     4.2ms  12.7ms  26.6ms    28us   38us  107us

A write that only needs cgroup_mutex waited up to 23 ms before and up
to 34 us after.  With 8 threads and no writer, stat() and access() on
a path whose directories have iattrs are 12-14% faster, since the
refresh copies less.

Tested with the kernfs selftests on lockdep + KASAN and KCSAN kernels;
with extra checks of link counts, times and IN_DELETE_SELF; with
concurrent mkdir/rmdir, setattr, stat, readdir and netdev churn; and
with test-only delays that force the stale stat(), lost time update,
backwards time, overwritten setattr and stat()-during-removal races.
KCSAN reports nothing new, and its set_nlink() reports from the refresh
are gone.

Based on vfs-7.5.kernfs.  It also applies to v7.4-rc3.

Shakeel Butt (6):
  kernfs: report times and link count from the node in getattr
  kernfs: don't copy times and link count into the inode on refresh
  kernfs: don't take kernfs_iattr_rwsem for the directory counters
  kernfs: don't take kernfs_iattr_rwsem to publish KERNFS_REMOVING
  kernfs: update a directory's times without kernfs_iattr_rwsem
  kernfs: don't take kernfs_iattr_rwsem in __kernfs_remove()

 fs/kernfs/dir.c             |  48 +++++---------
 fs/kernfs/inode.c           | 125 ++++++++++++++++++++++++++++++------
 fs/kernfs/kernfs-internal.h |   2 +
 3 files changed, 124 insertions(+), 51 deletions(-)


base-commit: ccf2a4692fed0fa77751d32d2690585127a152c5
-- 
2.53.1-Meta

