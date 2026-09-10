Received: from mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFF17B50F
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000638; cv=none; b=jVTeLRxy56LoVi3SvaDzbQUNdOrGLTx57D8P5eV8WmFa3IZ5+5f45sh6+Z1bXJt9Add6qK9kFNvs8RcZy04tfzQVBaWU1XpDMQY/5LNT/SdN3+wkWhfQvyh+dpD8nkMu2OrM+n6YTWIiYHOek1fcSiK+Pd2eZxRTFAywyxvINfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000638; c=relaxed/simple;
	bh=KQgUiZpy/+Ysf6qqt323GLtq0wVH/I4RNHQQJIfv++M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSWVrLoFXNXhBRJIhXBMdPMZA8oB/n9ZfoVYSmhayx4upZrcPKUE+aWFHBvsy1CsbD11Vx7viRTckiHUxdFnv6ycOupjCjgRMSVFTTnowdkbK8JmdsIZF8RCKfI727EtWNWytujPL3SDZAwL19JIfGOYOcTYr1PNG/K9zkQmCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aQKPODvB; arc=none smtp.client-ip=91.218.175.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aQKPODvB"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KQgUiZpy/+Ysf6qqt323GLtq0wVH/I4RNHQQJIfv++M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789000633; v=1; x=1789605433;
 b=aQKPODvBNecXAD8UtsNt+j9b75ZHOuHJP0DHMykiGbp4lUgLpbFPL2d8yYJK4ZHfp6F0757c
 shztMseaJzSqnd1eXZApVjiJag+h4+dczeC7YNcfU4ZA0wg44p+seCKp5VvbdOfmS0HdOnSd1cI
 f8gviJSXmWKNcs3g+e0ZI5po=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f2bc02be699ad269;
	Thu, 10 Sep 2026 00:37:03 +0000
X-Mizu-Trace-ID: f2bc02be699ad269
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
Subject: [PATCH 0/3] kernfs: don't hold kernfs_rwsem across dir_emit()
Date: Wed,  9 Sep 2026 17:36:47 -0700
Message-ID: <20260910003650.1680854-1-shakeel.butt@linux.dev>
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
on can be removed before the listing picks up again.  readdir remembers its
place as a name hash, and the search for a hash that is no longer there can
land on the entry after the missing one.  That entry is then stepped over
and never reported.

So patch 1 closes that race, patch 2 is the fix, and patch 3 adds tests.

Patch 1 is worth having on its own.  Without patch 2 the same search can
land on the entry before the missing one instead, and report it a second
time, between two getdents(2) calls.

Patches 1 and 2 apply to the vfs-7.4.kernfs branch of the vfs tree.
Patch 3 applies on top of "kernfs: three standalone fixes" [2], which is
still pending on the same branch.

[1] https://github.com/facebookincubator/below
[2] https://lore.kernel.org/20260905191613.3143937-1-shakeel.butt@linux.dev/

Shakeel Butt (3):
  kernfs: don't repeat or skip an entry when readdir resumes
  kernfs: don't hold kernfs_rwsem across dir_emit()
  selftests: cover readdir resuming at a removed entry

 fs/kernfs/dir.c                               |  77 +++++--
 .../selftests/filesystems/kernfs_test.c       | 200 ++++++++++++++++++
 2 files changed, 256 insertions(+), 21 deletions(-)

-- 
2.53.0-Meta

