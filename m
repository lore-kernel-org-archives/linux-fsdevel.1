Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729AA4C33EF;
	Fri,  2 Oct 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949251; cv=none; b=ZeAif4niKFC+0enjTGyoGkoNMhncxq1asTE6hfY/0RZXOOYSORD0y44n1vM2hBZyMMtIlT/c9AB/rcAX5iVgBDjLn59/dOIFySsBCI+4pqRnOmbbhEH16d8rVOb/8992Fpnv+QVq2vsPgw+PGfwoPXfsNd2oZErWR5OelIKEYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949251; c=relaxed/simple;
	bh=9ASqwSpxsKtkennDZIpc6CoQmR8ZkjS4mlY+Ttoyt3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+Bh77IQAXu4Z/9jTudy8NhPN9aczcTNDD8l97WJxfGWJE/xsWXEY3v+lEh4SNfWTcsUArxLpNXUbkN/3Pxcp+HXReWf+lI6LharXeK5tD4Y7nF0o8WQIW8pdf2pgaiRNwyf4xlaGfNZjVC4RE5gdTXZY5glHkROQbK9qxswKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAz1RTCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAz1RTCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258B31F000FF;
	Fri,  2 Oct 2026 13:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949250;
	bh=OlIsnUHQ9qOnF5GdREK+ZWdH2W7ozITCvl0lrQxGjW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WAz1RTCnKG1y+0K/XHw4heRXXVLWjkm1pnVQV+NUorEszPleIDiHnmUUAyjwmw7w+
	 d/m5Gm72Dj1sqZA0k+2MDi3aw23KB8m6cTsFn4LXsuCtkxCG9pqTTGKuLODP2JoRz/
	 eI3vdIRMZCoBWsiljYlnzPo2ZI0dOUXQ6vS4v+HhLFHtMBV9IfjnBswg6k76sDD9oc
	 IjVo9UX6r8dENiwtNaLeK5rmdVZPbGx8cTe0L28Cmf8Ki+8rmQ+cN1cS2kIBUQcRMn
	 my+Y/r6cZGMV8u7uJNXFVILLDFxA55BwI9XejnddwDYBAIXZj8dEH/t989KcNVUwiJ
	 gNOMvpZPYuLPA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:45 +0200
Subject: [PATCH 14/21] namespace: keep the private nullfs instance in
 knullfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-14-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9ASqwSpxsKtkennDZIpc6CoQmR8ZkjS4mlY+Ttoyt3k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x7V+vT8ng++2vG/hA7NS6tlrlx/MlfmVeuEd2tn2
 r/nO3vsbkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEpr9l+M3u5qBkaJmtYdCy
 JfLx3I9nN7ndb/OU93q2aq/h7pSru84x/I9O2jtBUPv09d3fXn9y9A3xZeWT2au9R+0f4xP3/4n
 ni5gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The private nullfs instance that kernel threads are confined to is only
ever reachable through init_task's root and pwd. The following patches
point mounts at it as well, so keep it in a global.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/mount.h     |  1 +
 fs/namespace.c | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 2223fb141499..4e68e5cbc254 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -6,6 +6,7 @@
 #include <linux/fs_pin.h>
 
 extern struct file_system_type nullfs_fs_type;
+extern struct vfsmount *knullfs;
 extern struct list_head notify_list;
 
 struct mnt_namespace {
diff --git a/fs/namespace.c b/fs/namespace.c
index e116894c8667..d1e83cda57e6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -80,6 +80,7 @@ static u64 mnt_id_ctr = MNT_UNIQUE_ID_OFFSET;
 static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
 static struct kmem_cache *mnt_cache __ro_after_init;
+struct vfsmount *knullfs __ro_after_init;	/* private nullfs instance */
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
@@ -6335,7 +6336,7 @@ static void __init init_mount_tree(void)
 	 *
 	 * (1) nullfs with mount id 1
 	 * (2) mutable rootfs with mount id 2
-	 * (3) private nullfs for kthreads (SB_KERNMOUNT)
+	 * (3) private nullfs for kthreads (SB_KERNMOUNT), kept in knullfs
 	 *
 	 * with (2) mounted on top of (1). The init_task's root and pwd
 	 * are pointed at (3) so all kthreads start isolated in nullfs.
@@ -6370,11 +6371,11 @@ static void __init init_mount_tree(void)
 		init_mnt_ns.nr_mounts++;
 	}
 
-	nullfs_mnt = kern_mount(&nullfs_fs_type);
-	if (IS_ERR(nullfs_mnt))
+	knullfs = kern_mount(&nullfs_fs_type);
+	if (IS_ERR(knullfs))
 		panic("VFS: Failed to create private nullfs instance");
-	root.mnt	= nullfs_mnt;
-	root.dentry	= nullfs_mnt->mnt_root;
+	root.mnt	= knullfs;
+	root.dentry	= knullfs->mnt_root;
 
 	init_task.nsproxy->mnt_ns = &init_mnt_ns;
 	get_mnt_ns(&init_mnt_ns);

-- 
2.53.0

