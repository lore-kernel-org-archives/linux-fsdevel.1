Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38022F8EB0
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789265713; cv=none; b=Aagj9gc71pc6c0C2VYjqyX/hH6TSCOW/rf90qTtKVP5PyCF6FRW/fBXv+DHW5Vc0x/6VoP69anQMu9yrCzpVjL2n9RBuSPFQfXonY3cpoRoUiXoGzO6FPqEaJ9yMW8+UNr56vIvLKPaarPjF0aWZtAWJ5OYL7xKpr0k0H1NndMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789265713; c=relaxed/simple;
	bh=lLMjhtX8mQSkcteJdNHfuS1BULHYOy4nyuYAaZWcCw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLkBvsIB8fhnShz1eqXmtO7KbWvcYjDI+NSK2WpGRN0QEMnE1Z4VZNmBoqTiiceaRIZmlkR2NpVhF5yiLz2NbQuGtRA+m1MbKDVKUV/El8YwgfaEFyAAT1vSE850/UIJqEn3NdKdsgU9iubcvPFFqJeFvvdGmrla7SyM5wyWu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WfpdAdlW; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WfpdAdlW"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lLMjhtX8mQSkcteJdNHfuS1BULHYOy4nyuYAaZWcCw8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789265708; v=1; x=1789870508;
 b=WfpdAdlWBBScYJQwkKUReOvuNHQFT9ZredA9hMe/pb65w2YpBmPzjhUpylw/0CCrT0XylETe
 VT+/bjsJQZEYBhBGcvXvo/Yrx8ClCXncJXj1AOLK9eHJi+VzhHL57lAydndNZkS4ry1zuqDAgmG
 VwFeq3iCE66eYNXByJZimixk=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e3873fdc4d9fcc1f;
	Sun, 13 Sep 2026 02:15:07 +0000
X-Mizu-Trace-ID: e3873fdc4d9fcc1f
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
Subject: [PATCH 1/3] kernfs: activate a new node without dropping kernfs_rwsem
Date: Sat, 12 Sep 2026 19:14:51 -0700
Message-ID: <20260913021453.21507-2-shakeel.butt@linux.dev>
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

kernfs_add_one() links the node in, drops the kernfs_rwsem write lock,
then calls kernfs_activate(), which takes it again.  Roots that do not
set KERNFS_ROOT_CREATE_DEACTIVATED, such as sysfs, therefore pay two
write locks for every file, directory and symlink created.

A new node has no children, so kernfs_activate() would walk only that
node.  Call kernfs_activate_one() before dropping the lock instead.  Its
two WARN_ON_ONCE()s still hold: the node was just linked, and nothing
can have changed its active count yet.  This also closes the window
where a node is linked but not yet activated.

lock_stat, creating and destroying five dummy netdevs:

                                 before    after
  kernfs_rwsem write acquires     1200      830

Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/dir.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 07abf59f0264..8953e8a07537 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -30,6 +30,8 @@ static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
 
+static void kernfs_activate_one(struct kernfs_node *kn);
+
 static bool __kernfs_active(struct kernfs_node *kn)
 {
 	return atomic_read(&kn->active) >= 0;
@@ -861,7 +863,6 @@ int kernfs_add_one(struct kernfs_node *kn)
 	}
 
 	up_write(&root->kernfs_iattr_rwsem);
-	up_write(&root->kernfs_rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -869,9 +870,15 @@ int kernfs_add_one(struct kernfs_node *kn)
 	 * activating the node with kernfs_activate().  A node which hasn't
 	 * been activated is not visible to userland and its removal won't
 	 * trigger deactivation.
+	 *
+	 * @kn has no children yet, so kernfs_activate() would walk only @kn.
+	 * Do it here rather than dropping the write lock and taking it again
+	 * for every new node.
 	 */
-	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_CREATE_DEACTIVATED))
-		kernfs_activate(kn);
+	if (!(root->flags & KERNFS_ROOT_CREATE_DEACTIVATED))
+		kernfs_activate_one(kn);
+
+	up_write(&root->kernfs_rwsem);
 	return 0;
 
 out_unlock:
-- 
2.53.0-Meta

