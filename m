Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CF84AC14E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151306; cv=none; b=XAUx3z95O+eROj09J4ikHFNudj13YyNMz+DyBKBGhm+q//oIaLa4bLn5boiQyCUIrJauIM5KTU7n964BT7vGuKzkVs6o6kal3svVCyjUYbClrJFJWxRJFFREmq209AP2xNlOXbMKknbojjDkns0u89Bg6cVvKq5pmuFBEUxqqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151306; c=relaxed/simple;
	bh=qD/8jGcsB0PwT4vXosTJ3LKl5LQeSQQLhek2WRS6rN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aqugcg7Zrrlv2MTbhXYTBr4hKk7oQsTI7m0UJzRTVmuADFNt2e7PCALrFT5rJfpRXlYXePv5epQunDP7JHXH9EREW1b52yaOFR9Mm6WBxH1gYGeY3qu4ONw47+cTsPzH0Tw6jnrv/WlQDHtZ3R2TKLBraIBzD2Ro3nAScUi9JeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GjN+ytHY; arc=none smtp.client-ip=91.218.175.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GjN+ytHY"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qD/8jGcsB0PwT4vXosTJ3LKl5LQeSQQLhek2WRS6rN0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789151301; v=1; x=1789756101;
 b=GjN+ytHYbW42ul7UHKe9RKTQtwlbYjWUMlFkNcLyjTBTCbnyJx6/yTa1K0LjF6Vt7pzPDc6U
 cCgqKsh6/jkIf6d0IJu7XLbzf9z/a15ESaJlHQqBVLAjZiW49Yzp1EFsI8xuombdOcw2dUBKUiA
 E8IuwtFliC7dgnvOPfNShpwE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f6c6a0564a26cf05;
	Fri, 11 Sep 2026 18:28:21 +0000
X-Mizu-Trace-ID: f6c6a0564a26cf05
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <christian@brauner.io>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] kernfs: don't hold kernfs_rwsem across dir_emit()
Date: Fri, 11 Sep 2026 11:28:11 -0700
Message-ID: <20260911182815.1992483-1-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernfs_fop_readdir() takes kernfs_rwsem for reading and holds it for the
whole listing, dir_emit() included.  dir_emit() copies into a userspace
buffer, so it can fault, and under memory pressure that fault goes to
reclaim.

We are hitting this case on the Meta fleet very regularly.  Many times it
is below[1], a monitoring daemon.  It walks the cgroup tree and faults on
its own getdents(2) buffer with the lock held for reading.

	below: page allocation stall for 120 secs: order:0,
	mode:0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP)
	nodemask=(null),cpuset=hostcritical.slice,mems_allowed=0
	Call Trace:
	 <TASK>
	 dump_stack_lvl+0x5d/0x80
	 __alloc_frozen_pages_noprof+0x5f4d/0x6300
	 ? memcg_list_lru_alloc+0x73/0x320
	 ? ima_file_check+0xd0/0x7d0
	 vma_alloc_folio_noprof+0x145/0x560
	 handle_mm_fault+0x17c9/0x2720
	 ? find_vma+0x27/0x30
	 do_user_addr_fault+0x39f/0x6e0
	 exc_page_fault+0x8f/0x110
	 asm_exc_page_fault+0x22/0x30
	RIP: 0010:filldir64+0xd7/0x1a0
	[Code:/RSP:/RAX:..R15: register block elided]
	 kernfs_fop_readdir+0x2de/0x420
	 iterate_dir+0x8c/0x1f0
	 __se_sys_getdents64+0x61/0xe0
	 ? copy_page_from_iter+0x860/0x860
	 do_syscall_64+0x6a/0x250
	 entry_SYSCALL_64_after_hwframe+0x4b/0x53
	 </TASK>

kernfs_rwsem is the lock every create, remove and rename in the hierarchy
needs, and sysfs and cgroupfs have one per machine.  More importantly, the
userspace OOM killers such as systemd-oomd also traverse the cgroupfs
hierarchy and can get stuck behind below, which is stuck in reclaim.  They
are supposed to relieve memory pressure on the system, but can get stuck
themselves.

The fix is to not hold the lock across dir_emit().  Copy the name while the
lock is held, drop the lock, emit, and take it again.

That opens a window.  With the lock dropped, the entry the listing stopped
on can be removed or renamed before the listing picks up again, and readdir
only remembers its place as a name hash.  Two entries in one directory can
share a hash, so the hash alone does not say where the listing stopped.

Patch 1 makes the fallback search land after the missing entry rather than
on either side of it.  Patch 2 keeps the name of the entry the listing is
on and resumes on the full key.  Patch 3 is the fix.  Patch 4 adds tests.

Patch 1 is worth having on its own.  Without the rest, the same search can
land on the entry before the missing one and report it a second time,
between two getdents(2) calls.

The series applies to the vfs-7.4.kernfs branch of the vfs tree.

Changes since v1 [2]:
 - Split the old patch 2 in two, per Tejun.  Patch 2 adds the name copy and
   the full-key resume with the locking unchanged; patch 3 only drops the
   lock.

[1] https://github.com/facebookincubator/below
[2] https://lore.kernel.org/all/20260910003650.1680854-1-shakeel.butt@linux.dev/

Shakeel Butt (4):
  kernfs: don't repeat or skip an entry when readdir resumes
  kernfs: resume readdir on the full entry key
  kernfs: don't hold kernfs_rwsem across dir_emit()
  selftests: cover readdir resuming at a removed entry

 fs/kernfs/dir.c                               |  85 ++++++--
 .../selftests/filesystems/kernfs_test.c       | 200 ++++++++++++++++++
 2 files changed, 263 insertions(+), 22 deletions(-)


base-commit: 7f24d0f60b1087dbc28d68398957c18774e5a7d8
-- 
2.53.0-Meta

