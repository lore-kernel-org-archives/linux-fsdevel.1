Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BF2D238A;
	Fri, 12 Jun 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277265; cv=none; b=kTpCFstKsSIv2BgTYZOgQ+HCYLXodClzvyP/obNfKVGyRUpp8FVJHNcuUL4vvcBzBYzNQfHo8FDUZXdir0O/J06XOxtEQAeAM/RK6pZNlgAH0m4GO6U2cN/ywhB/wjJnF4xG5VaFNv6rBPVSpIsPM9260hgK8JtZndfk096UcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277265; c=relaxed/simple;
	bh=FzZ4ioBI9lmm6O4blGYE4mD7TQMDNtcrrAv9zHZHkBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6WDAwy92cgKkFtCbqM7rh2axu6ExHxZfbuv4UIH6WZtI8Vn9fafv8LLza+e42KPmdUBs4MaS2JC7M2/Uwr5Rye6AVgsbkfVEZkbX5y/eFEX5uUwZ3I61Xm31OaLEbk0MYLjShvmQBhJyT7SYHwhil08Xlk44TSsRN+bEFpAQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGrDeBRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGrDeBRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718551F000E9;
	Fri, 12 Jun 2026 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277263;
	bh=Wfzpjm1QTNMP3z46eWhXGbAmjpXVp3FyCZoldBx3TzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hGrDeBRwABFZkNu8WKIQo5mNcEIpL2TklYD4e/6KI+xp0JWF38ABsnnE3kW/gAofs
	 5FmbrHj3zSR/9ImD9NYSY1NgbYgtVLupEw8qZqRmtr3Kocvsd2uLcOBbnOpt8siKT9
	 tlrFTBgam7aA5A2QQFu++7uVtnRHP8DtXEoDYjQXZMiMuTIHfXBdLSEhw9Mb8LGyI0
	 YLyuGSXn6gNhHzfNMd3Nhla2SAYTCuKxoG8w9eM5oiE5JOVJzK8TnasxIUevT47aQM
	 rT27Q0JE9OL/G3bm5q67szxEtDHH54Snw975YmN7LThftD1suYH2ejSn8RCCNtkSrs
	 ZMIuT9xC6C05w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 10/16 for v7.2] vfs writeback
Date: Fri, 12 Jun 2026 17:14:17 +0200
Message-ID: <20260612-vfs-writeback-v72-d7ca37da4512@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4137; i=brauner@kernel.org; h=from:subject:message-id; bh=FzZ4ioBI9lmm6O4blGYE4mD7TQMDNtcrrAv9zHZHkBg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKHlnXWz9Hvfi4YsPM581qiWcU5u/6ef7b8+2PfZMd 2N+/2Ty+Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJCHgw/M8TrNq1Yk9JZ8ai eBndArUO818nbXyvdGSqbK/wEtx5zpaR4b4K62mz/HX7C45y8jbyL/p2nj9gbsLPhrNsqbdmTHI O5AYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the writeback changes for this cycle:

* Fix a race between cgroup_writeback_umount() and inode_switch_wbs()

  When a container exits, a race between cgroup_writeback_umount() and
  inode_switch_wbs()/cleanup_offline_cgwb() can trigger "VFS: Busy
  inodes after unmount" followed by a use-after-free on percpu
  counters. There is a window between inode_prepare_wbs_switch()
  returning true (having passed the SB_ACTIVE check and grabbed the
  inode) and the subsequent wb_queue_isw() call: if
  cgroup_writeback_umount() observes the global isw_nr_in_flight
  counter as non-zero but flush_workqueue() finds nothing queued yet,
  it returns early - leaving a held inode reference that blocks
  evict_inodes() and a later iput() that hits freed percpu counters.

  The race is closed by covering the window from
  inode_prepare_wbs_switch() through wb_queue_isw() with an RCU
  read-side critical section and synchronizing in the umount path. On
  top of that the now-dead rcu_barrier() left over from the
  queue_rcu_work() era is removed, and the global
  synchronize_rcu()/flush_workqueue() pair is replaced with a per-sb
  in-flight counter plus pin/unpin/drain helpers so umount no longer
  serializes against switch activity on unrelated superblocks.

  Under cgroup writeback churn on a 16 vCPU guest this takes umount
  latency from ~92-138ms p50 down to ~5-8ms p50 and the cumulative
  cost of cgroup_writeback_umount() from ~62ms to ~4us per call. The
  initial race fix is kept separate and minimal so it backports
  cleanly to stable trees that still queue switches via
  queue_rcu_work().

* Improve write performance with RWF_DONTCACHE

  Dirty DONTCACHE pages are now tracked per bdi_writeback so that the
  writeback flusher can be kicked in a targeted fashion for
  IOCB_DONTCACHE writes instead of relying on global writeback, and
  the PG_dropbehind flag is preserved when a folio is split.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.writeback

for you to fetch changes up to 0275dc184aa007b260374af6d46fb15741c062a8:

  Merge patch series "mm: improve write performance with RWF_DONTCACHE" (2026-06-04 10:18:25 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.writeback

Please consider pulling these changes from the signed vfs-7.2-rc1.writeback tag.

Thanks!
Christian

----------------------------------------------------------------
Baokun Li (3):
      writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()
      writeback: drop now-unnecessary rcu_barrier() in cgroup_writeback_umount()
      writeback: use a per-sb counter to drain inode wb switches at umount

Christian Brauner (2):
      Merge patch series "writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()"
      Merge patch series "mm: improve write performance with RWF_DONTCACHE"

Jeff Layton (3):
      mm: preserve PG_dropbehind flag during folio split
      mm: track DONTCACHE dirty pages per bdi_writeback
      mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking

 fs/fs-writeback.c                | 138 +++++++++++++++++++++++++++++++--------
 include/linux/backing-dev-defs.h |   3 +
 include/linux/fs.h               |   6 +-
 include/linux/fs/super_types.h   |   8 +++
 include/trace/events/writeback.h |   3 +-
 mm/filemap.c                     |  15 ++++-
 mm/huge_memory.c                 |   1 +
 mm/page-writeback.c              |   6 ++
 8 files changed, 147 insertions(+), 33 deletions(-)
