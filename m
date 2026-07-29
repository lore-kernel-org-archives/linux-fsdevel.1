Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EED283CAF;
	Wed, 29 Jul 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319314; cv=none; b=j7FjWQJNhc0OBH9lb92fLdh5SNiyMzKez9gIMvnL7LjBgGoCX714896XtL+A7npFYRzX+8ZNzs+3RAFxBcO4Do0QlwkQXoEFpV1GJ+vJQ/xobXFhvMj8U1CCJALV32axVj1gxQZ1u0o23PyDcwVfhDG2D+3Kdm/OqWlsYqmbA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319314; c=relaxed/simple;
	bh=HRsV24apLGPOKLRoOj/KSRWFiOHBYQQ+uuvVjIhUDCs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=StoMOaaEcBeue5NeTSGr+rRuC8zfNrSsawA7/wOiaGe4iXp225AXWZP5rIoViYI8SkVZekMYvNu/pYPRmfTRn+0BNxXhQZ/S+ha3Ea2ieSbRocua6I4mC8p82EKy+si6fYbW/hzplNRA/K/feHrHSbRu1yYOvjQM4AZ2yJRrNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+5TIjJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+5TIjJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371831F000E9;
	Wed, 29 Jul 2026 10:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785319312;
	bh=dFJ8AOausgpTwPPU6noxGX2EmMcB9BeZxvWfBnwNM94=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=E+5TIjJl/I2YNcvWbQo7eJH3UtELoO32VMDDwPL8UWZ3Aby9/xfgg+Li7KRNNumL0
	 KSkThy30ohpwDljceo3m5RwsZgQKecoOh3N/zpCGq07XAqCsfHq8/TsiBs6D4yVbSU
	 opxYc6XcwmYSD8A0fEk4UXw5bbUiAF6fbX4uu7e8Zh/b+Eyj8JJErqOxsr9iuNPzA2
	 49o9k3HTabDUoK+V0N7Zmab2A/RwgrzyTKb9VZDxlf8NFf3X6DzauZA1jVKmdXCM2N
	 +MyG1wJUcMel8ypdPXgeN+Rdp0LX1Xo2bIdlTSv3bKkhsDB/D/hLe5iqUDOMaScXZM
	 +Ff/B64H+TuJw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] dcache: keep shrink_dcache_for_umount() making
 progress on busy roots
From: Christian Brauner <brauner@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260729005933.15858-1-kmehltretter@gmail.com>
References: <20260729005933.15858-1-kmehltretter@gmail.com>
Date: Wed, 29 Jul 2026 12:01:48 +0200
Message-Id: <20260729-sohlen-ballwechsel-codewort-389f639bd3ee@brauner>
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=5425; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HRsV24apLGPOKLRoOj/KSRWFiOHBYQQ+uuvVjIhUDCs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlnu87ucvZ9vHKH/uO2NW6Zr/3Yt3OfeTkz0exwrrCH
 zINHiy/1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRXbWMDK8dDy9yClmv+WjP
 y9rfdyaH9xxYpsqwO3qf8QL2eXPMkv8w/DOc6fyybs3BjwEt8RtPrO5SzfLbqCvi+CH6krRW+EW
 +WHYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Commit e9895609cb7f ("wind ->s_roots via ->d_sib instead of ->d_hash")
> moved secondary roots from ->d_hash to ->d_sib.  Secondary roots are
> now d_unhashed(), so __d_drop() returns without removing them from
> ->s_roots.  Consequently, d_drop() in do_one_tree() no longer
> guarantees progress through the list.
> 
> If a secondary root has an unexpected extra reference, do_one_tree()
> reports it, but its final dput() cannot evict it.  The root remains
> ->s_roots.first and the loop selects it forever, holding ->s_umount for
> write and repeatedly reporting the same dentry.
> 
> Before e9895609cb7f, ___d_drop() special-cased IS_ROOT dentries and
> removed them from ->s_roots regardless of their refcount.  Commit
> 9c8c10e262e0 ("more graceful recovery in umount_collect()") deliberately
> made busy dentries nonfatal: report them and finish the unmount rather
> than BUG() while holding ->s_umount.
> 
> Detaching busy secondary roots from ->s_roots restores the previous
> behavior.  A permanently leaked reference remains leaked after unmount;
> if the extra reference is only delayed, its final dput() may run after
> teardown has advanced and hit poisoned or freed filesystem state.  The
> current code avoids that late cleanup only by looping indefinitely under
> ->s_umount for a real leak.
> 
> Restore that behavior by removing each live secondary root from
> ->s_roots after taking the temporary reference.  In the normal case,
> dentry_unlist() finds ->d_sib already unhashed when eviction occurs.
> 
> Fixes: e9895609cb7f ("wind ->s_roots via ->d_sib instead of ->d_hash")
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Wouldn't it make more sense to move this into do_one_tree()?

From 6c955dad4ba4bc1c1e47426697825d041e591d8e Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Wed, 29 Jul 2026 02:59:33 +0200
Subject: [PATCH] dcache: keep shrink_dcache_for_umount() making progress on
 busy roots

Commit e9895609cb7f ("wind ->s_roots via ->d_sib instead of ->d_hash")
moved secondary roots from ->d_hash to ->d_sib.  Secondary roots are
now d_unhashed(), so __d_drop() returns without removing them from
->s_roots.  Consequently, d_drop() in do_one_tree() no longer
guarantees progress through the list.

If a secondary root is still busy once do_one_tree() is done with it,
its final dput() cannot evict it.  The root remains ->s_roots.first
and the loop selects it forever, holding ->s_umount for write and
repeatedly reporting the same dentry.

The root does not need a leaked reference of its own for that.  Every
child pins its parent (d_alloc() takes a reference on it) and
umount_check() deliberately reports a busy descendant instead of
complaining about its ancestors, so a single leaked dentry reference
anywhere below a secondary root is enough.  For filesystems that build
->s_root with d_obtain_root() - nfs, ceph, nilfs2 snapshot mounts -
that is the entire tree.

Before e9895609cb7f, ___d_drop() special-cased IS_ROOT dentries and
removed them from ->s_roots regardless of their refcount, so the
d_drop() in do_one_tree() detached the root from the superblock no
matter what.  Commit 9c8c10e262e0 ("more graceful recovery in
umount_collect()") deliberately made busy dentries nonfatal: report
them and finish the unmount rather than BUG() while holding
->s_umount.

Restore that by detaching the root in do_one_tree() itself, next to
the d_drop() that used to do it.  That covers both callers - the
->s_roots loop and ->s_root, which for the filesystems above is a
secondary root as well.  In the normal case dentry_unlist() finds
->d_sib already unhashed when eviction occurs.

A permanently leaked reference remains leaked after unmount, as it did
before e9895609cb7f; if the extra reference is merely delayed, its
final dput() may run after teardown has advanced.  Leaving the root on
->s_roots is not an alternative: the superblock would then be freed
with a live dentry still linked into it, and that dentry's
dentry_unlist() would take ->s_roots_lock on freed memory.

Christian Brauner <brauner@kernel.org> says:
Moved the ->s_roots removal from the shrink_dcache_for_umount() loop
into do_one_tree(), so a busy ->s_root obtained from d_obtain_root() is
detached on the first pass instead of being reported a second time when
the loop picks it off ->s_roots.  Extended the commit message with the
pinned-ancestor case.

Fixes: e9895609cb7f ("wind ->s_roots via ->d_sib instead of ->d_hash")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Link: https://patch.msgid.link/20260729005933.15858-1-kmehltretter@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3e9af9de7074..aded2564b589 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1794,7 +1794,12 @@ static void do_one_tree(struct dentry *dentry)
 {
 	shrink_dcache_tree(dentry, true);
 	d_walk(dentry, dentry, umount_check);
-	d_drop(dentry);
+	spin_lock(&dentry->d_lock);
+	__d_drop(dentry);
+	// a busy root survives the dput() below; don't leave it on ->s_roots
+	if (unlikely(!hlist_unhashed(&dentry->d_sib)))
+		unlink_secondary_root(dentry);
+	spin_unlock(&dentry->d_lock);
 	dput(dentry);
 }
 
-- 
2.53.0
