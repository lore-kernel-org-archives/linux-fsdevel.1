Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9A0313267
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789265722; cv=none; b=a1QETgYytalyMWO3mFNSamrL6i3VAMtLVK3o0Tu1fmGqZ5Dp+bzaEvmT4pGDgXHv+LsTv/TrrJ77lSii3pZ1KiqfDGrNfYpdK6MdCASS/1h+BF5MLsfykNW/LdOXe0GP9/bN/3vZJVT/+hcgGoo8qmfSu1rXBOZgpXeFnTWm/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789265722; c=relaxed/simple;
	bh=pH/pHT3eyv9ohLS5X8BzRXnXn2sTO031AqbiTb+LHC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E448tvSOyStpky4oL0nsWkeZJ6XJqCeVrGNyyPAUNf5/C3+esKi+veXAlODtBAsyDrT/R+OMyKMtUV77aR5mAp0uZkG2ajHOJ+2WYggR14NqtlzBn/alezbg787ddkMkZdShje/V+X4O8XCiA1WRGWN6B3RF2FaixYlhzakDaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t0XbwN39; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t0XbwN39"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pH/pHT3eyv9ohLS5X8BzRXnXn2sTO031AqbiTb+LHC4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789265718; v=1; x=1789870518;
 b=t0XbwN397Ni5im13fTnmUhS1f3gUleWx7FEKPEJR8wLArAU/dxefilpEKMr6gIpuHuiFibX/
 02Troraj27XF94PFQr7cWub9N7Yrg3N5s1nYJOQwlpzq8iCN/kbYMKFFN5+kqQuXiuzSPr12o7a
 YuAtOyOYxmMj9b5RN4ItJwbc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 63251dd25ef417dc;
	Sun, 13 Sep 2026 02:15:10 +0000
X-Mizu-Trace-ID: 63251dd25ef417dc
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
Subject: [PATCH 2/3] kernfs: allocate the new name outside kernfs_rwsem
Date: Sat, 12 Sep 2026 19:14:52 -0700
Message-ID: <20260913021453.21507-3-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913021453.21507-1-shakeel.butt@linux.dev>
References: <20260913021453.21507-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernfs_rename_ns() calls kstrdup_const() while holding the kernfs_rwsem
write lock.  It is the only GFP_KERNEL allocation under that lock in
kernfs, so a rename can enter reclaim while every create, remove and
rename in the hierarchy waits behind it.

Copy the name before taking the lock and free the copy again if the
rename turns out not to need it.  A rename that keeps the name, hits a
collision or finds the node gone now does one extra kstrdup_const();
renames are rare.  -ENOMEM is still reported at the same point as
before, so nothing changes about which error a caller sees.

Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/dir.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8953e8a07537..3bbdd9a8acc8 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1819,6 +1819,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const struct ns_common *new_ns)
 {
 	struct kernfs_node *old_parent;
+	const char *dup_name = NULL;
 	struct kernfs_root *root;
 	const char *old_name;
 	bool reparent;
@@ -1828,6 +1829,9 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	if (!rcu_access_pointer(kn->__parent))
 		return -EINVAL;
 
+	if (new_name)
+		dup_name = kstrdup_const(new_name, GFP_KERNEL);
+
 	root = kernfs_root(kn);
 	down_write(&root->kernfs_rwsem);
 
@@ -1859,9 +1863,10 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	/* rename kernfs_node */
 	if (strcmp(old_name, new_name) != 0) {
 		error = -ENOMEM;
-		new_name = kstrdup_const(new_name, GFP_KERNEL);
-		if (!new_name)
+		if (!dup_name)
 			goto out;
+		new_name = dup_name;
+		dup_name = NULL;
 	} else {
 		new_name = NULL;
 	}
@@ -1901,6 +1906,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	error = 0;
  out:
 	up_write(&root->kernfs_rwsem);
+	kfree_const(dup_name);
 	return error;
 }
 
-- 
2.53.0-Meta

