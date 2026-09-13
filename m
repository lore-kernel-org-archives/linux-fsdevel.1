Received: from mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302BD6FC3
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789265701; cv=none; b=t7qnLDtXLs5uKo453+d1U6EWEHzQwC7Gr+4yfbgJP0Z20SYp5oc/ogL7nyX2tsHoWc/E0E3EwwQgCuss2MLT8GNsHyYsvGXGzkc1V6sMn567M1jkt3JYACfmrxP6EN2wEiQR+ASeuD6tIRDgz0vioLwgIlMI9QYuSi3itXnegjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789265701; c=relaxed/simple;
	bh=f9osKaKHCbORU9kmAO5D0NPzzZrOZdoY2Zd76njb6g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtH/qtzqq7KB078UxnTP3c9fY6bkyfiIotGlnA1ydlBD1cBbg5cxZOEP9bnE0lBVBHa8VXNrm9WwHSkQlLdCUVq1Wmk9oXsEq4auOkV3fXbS4v0kpJDZaPbrcWV/hsWLsNWroGlctmGEhlK8WyOwWJBFtqgM09bNhFPIlrZ3rC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QaUl5m/z; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QaUl5m/z"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f9osKaKHCbORU9kmAO5D0NPzzZrOZdoY2Zd76njb6g0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789265697; v=1; x=1789870497;
 b=QaUl5m/zxcToma4U6Pv+c69Rm35wxTkAa1FLmyQAH0ylbxUYmTwpjY31rOIb/4u8poRcwH3u
 9WlqLZPgZ4zDt7Khvt1133uokxsaSW5JsxOKnyTuMALVbISZWHYBaJxItjPoQO+1w6dUuBzXZuQ
 crYfsSCeVKMx5Bl4ilbJLJRs=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bdccb29049643465;
	Sun, 13 Sep 2026 02:14:56 +0000
X-Mizu-Trace-ID: bdccb29049643465
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
Subject: [PATCH 0/3] kernfs: do less work under the kernfs_rwsem write lock
Date: Sat, 12 Sep 2026 19:14:50 -0700
Message-ID: <20260913021453.21507-1-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernfs_rwsem is per kernfs root, so sysfs and cgroupfs have one each for
the whole machine, and every create, remove and rename takes it for
writing.  Whatever a writer does while holding it, everyone else waits
for.  These three patches take work out of that section.

Patch 1: kernfs_add_one() links the node in, drops the lock, then calls
kernfs_activate(), which takes it again.  sysfs does not create nodes
deactivated, so it pays two write locks for every file and directory.
Activate before dropping the lock.  lock_stat says 1200 -> 830 write
acquisitions for creating and destroying five dummy netdevs.

Patch 2: kernfs_rename_ns() calls kstrdup_const() under the lock.  It is
the only GFP_KERNEL allocation under the write lock in kernfs, so a
rename can enter reclaim with the lock held.  Allocate before the lock.

Patch 3: kernfs_rename_ns() also frees the old name under the lock with
kfree_rcu_mightsleep().  When its batching allocation fails, which is
what happens under memory pressure, it falls back to synchronize_rcu().
A rename can then wait out a grace period with the lock held.  Free
after the unlock.

Tested with the kernfs selftests under KASAN and lockdep.

Shakeel Butt (3):
  kernfs: activate a new node without dropping kernfs_rwsem
  kernfs: allocate the new name outside kernfs_rwsem
  kernfs: free the old name outside kernfs_rwsem

 fs/kernfs/dir.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)


base-commit: 7f24d0f60b1087dbc28d68398957c18774e5a7d8
-- 
2.53.0-Meta

