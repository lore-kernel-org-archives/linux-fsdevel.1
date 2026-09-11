Received: from mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458A4BB269
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151318; cv=none; b=NDLOrssoS6cLn6kJrYN/INKOjNecJPPWNKoYvGab2wMNvZUF7udsbL7XRhx0krq/QBA19qiG3q6GBV5XdZHQfy+cjwnV4v0FmFaeky9aDe+K2zubqtXyeJWNh4kCEuioroyg2Sb02Jfm9CIQYEpCFR3RN0q47yuVN4JdKWPVmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151318; c=relaxed/simple;
	bh=oktkiuBrM8xYK371UCLtTRZLlcMxxdkg/b8G5LGBA/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mP3A+khbO73WHjFvIili+76gdTTj0+hVlCBvMAeHHCXiazPW9ogh76Cf84kgbYhpYdBG/IhThufTWOIuzKVLAY5eepCoWM+FQItaVeHFOIoYAx+fPfyQf2/o/AK49dtOSCcuFag3v1jm3bu6+XUDi6ccCRWlycjKwgmWg0QPgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QOhqgq8W; arc=none smtp.client-ip=91.218.175.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QOhqgq8W"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oktkiuBrM8xYK371UCLtTRZLlcMxxdkg/b8G5LGBA/A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789151314; v=1; x=1789756114;
 b=QOhqgq8W/V+KDDd8VeAaBcRExI33e+j05M0657a+xSBWW0SHBQcbhZOkTjSSFAVH8J0+EtXa
 brW04C4lGPepYi14Ob/8c05FbzlhGYPw98+Y41OSDLvLKg+H2AF93PUKt05Lkh+dglIF40OJYA+
 N84QMlulKNOOrhRXw40o2l18=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2dc3c538e624f3d1;
	Fri, 11 Sep 2026 18:28:32 +0000
X-Mizu-Trace-ID: 2dc3c538e624f3d1
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
Subject: [PATCH v2 3/4] kernfs: don't hold kernfs_rwsem across dir_emit()
Date: Fri, 11 Sep 2026 11:28:14 -0700
Message-ID: <20260911182815.1992483-4-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911182815.1992483-1-shakeel.butt@linux.dev>
References: <20260911182815.1992483-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernfs_fop_readdir() holds kernfs_rwsem for reading across the whole
listing, dir_emit() included.  dir_emit() copies to userspace, so it can
fault into reclaim while holding the lock that every create, remove and
rename in the hierarchy needs.  sysfs and cgroupfs have one per machine.

Under memory pressure the monitoring daemons fault on their own
getdents(2) buffer with it held:

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

Commit 9aab10a0249e ("kernfs: Don't re-lock kernfs_root::kernfs_rwsem in
kernfs_fop_readdir().") took the lock drop out because dir_emit() was
handed kernfs_node::name, which a rename can free.  The previous patch
emits a copy instead, so drop the lock around dir_emit().

A listing is no longer atomic within one getdents(2) call, which for
most sysfs and cgroup directories is all of it.  POSIX leaves that
unspecified for an entry added or removed since opendir(3).

Fixes: 9aab10a0249e ("kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().")
Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/dir.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6d7d9c9ba33a..cc6288d5b4cc 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -2027,10 +2027,14 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		if (!dir_emit(ctx, name, len, ino, type)) {
-			up_read(&root->kernfs_rwsem);
+		/*
+		 * dir_emit() can fault, so run it unlocked.  @pos is pinned
+		 * above and kernfs_dir_pos() rechecks it on the way back.
+		 */
+		up_read(&root->kernfs_rwsem);
+		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		}
+		down_read(&root->kernfs_rwsem);
 	}
 	up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
-- 
2.53.0-Meta

