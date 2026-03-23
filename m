Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F609265629;
	Mon, 23 Mar 2026 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279072; cv=none; b=e+2thycBpopYRFefYwo0C5CaGGS77/ByI6Eb52VHV5B5dBLUPS2RLAxNWjenfOKm8jF+hIYcuKFTgfEDSgF325IVZq6LQA/0A9V9351QL1iVUfuVb2z/vSpidRrM2jQ7RdrLn0tAtliIYieKCMsm2WmqUKHnyePEBKaMFWJy0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279072; c=relaxed/simple;
	bh=bYvpYx0PcYENSoTREal7KOCcM0EXA6IHlu66fpnGw1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL+RuSam09sRWVOcjh0aAAmhztGJqLpeTqQsejuGYrtSsGl/S4HK4y1NJll1J7m22LNv8/xuXq1/2Pwoiftx25yt+q58NRi8wIpGbz3ajnRjeQP4yqQvWrl9QntvQJk0T9soys5epA8ofqK3v/7tlpkK5jML/cbyYBEXNCUkgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArCRwSjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArCRwSjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA85C4CEF7;
	Mon, 23 Mar 2026 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774279072;
	bh=bYvpYx0PcYENSoTREal7KOCcM0EXA6IHlu66fpnGw1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArCRwSjM3ElnbMt8Gcy32WO1+IpOAID+KSYhih/GnrIXaWLDRar00vCh4IFsMbYVZ
	 cwFLaQjzCfH0cJIBTfpPld2f6ARCrrF4/4U35tu9BG7qw0VCQ+BWShNey0iQjik0Os
	 2q794haVtZwgInnU5bvcsY5wk9dWxHPAaCglmfpLyvwzaFr2nLqKMWZAayg1HtB6vB
	 iuLCcbOOdobQR32PTtSACbcj7Lpm6axMYivTbEqlc0f9lL0HM9mx80JDChEWTS03z+
	 xKpbew0PA22b9yUp4+HFkNIlokisWN+01qwTi2eVXykk7cDL6z+Y0GBdC0NzNRWloY
	 ijPGHEV2hOstw==
Date: Mon, 23 Mar 2026 16:17:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in __umount_mnt
Message-ID: <20260323-nieder-blenden-fdae2cc3cf38@brauner>
References: <69bdce08.050a0220.3bf4de.0031.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fnebkd6yyhhvcsvm"
Content-Disposition: inline
In-Reply-To: <69bdce08.050a0220.3bf4de.0031.GAE@google.com>


--fnebkd6yyhhvcsvm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 20, 2026 at 03:45:28PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8e42d2514a7e Add linux-next specific files for 20260318
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10808cba580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7f5b21566f9d8af6
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16eb72da580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cb90c31a24db/disk-8e42d251.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e0c08a5de437/vmlinux-8e42d251.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d6b18a5e03f8/bzImage-8e42d251.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com

#syz test: https://github.com/brauner/linux/tree/vfs-7.1.mount 14594a141c760dd4c462b38d73406e1b48e44b84

--fnebkd6yyhhvcsvm
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mount-always-duplicate-mount.patch"

From 14594a141c760dd4c462b38d73406e1b48e44b84 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Mar 2026 15:05:07 +0100
Subject: [PATCH] mount: always duplicate mount

In the OPEN_TREE_NAMESPACE path vfs_open_tree() resolves a path via
filename_lookup() without holding namespace_lock. Between the lookup
and create_new_namespace() acquiring namespace_lock via
LOCK_MOUNT_EXACT_COPY() another thread can unmount the mount, setting
mnt->mnt_ns to NULL.

When create_new_namespace() then checks !mnt->mnt_ns it incorrectly
takes the swap-and-mntget path that was designed for fsmount()'s
detached mounts. This reuses a mount whose mnt_mp_list is in an
inconsistent state from the concurrent unmount, causing a general
protection fault in __umount_mnt() -> hlist_del_init(&mnt->mnt_mp_list)
during namespace teardown.

Remove the !mnt->mnt_ns special case entirely. Instead, always
duplicate the mount:

 - For OPEN_TREE_NAMESPACE use __do_loopback() which will properly
   clone the mount or reject it via may_copy_tree() if it was
   unmounted in the race window.
 - For fsmount() use clone_mnt() directly (via the new MOUNT_COPY_NEW
   flag) since the mount is freshly created by vfs_create_mount() and
   not in any namespace so __do_loopback()'s IS_MNT_UNBINDABLE,
   may_copy_tree, and __has_locked_children checks don't apply.

Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2aebc4525cf3..090f9d951cfe 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3086,8 +3086,13 @@ static struct file *open_detached_copy(struct path *path, unsigned int flags)
 	return file;
 }
 
+enum mount_copy_flags_t {
+	MOUNT_COPY_RECURSIVE    = (1 << 0),
+	MOUNT_COPY_NEW		= (1 << 1),
+};
+
 static struct mnt_namespace *create_new_namespace(struct path *path,
-						  bool recurse)
+						  enum mount_copy_flags_t flags)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct user_namespace *user_ns = current_user_ns();
@@ -3096,7 +3101,7 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	struct path to_path;
 	struct mount *mnt;
 	unsigned int copy_flags = 0;
-	bool locked = false;
+	bool locked = false, recurse = flags & MOUNT_COPY_RECURSIVE;
 
 	if (user_ns != ns->user_ns)
 		copy_flags |= CL_SLAVE;
@@ -3135,22 +3140,10 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	 * the restrictions of creating detached bind-mounts. It has a
 	 * lot saner and simpler semantics.
 	 */
-	mnt = real_mount(path->mnt);
-	if (!mnt->mnt_ns) {
-		/*
-		 * If we're moving into a new mount namespace via
-		 * fsmount() swap the mount ids so the nullfs mount id
-		 * is the lowest in the mount namespace avoiding another
-		 * useless copy. This is fine we're not attached to any
-		 * mount namespace so the mount ids are pure decoration
-		 * at that point.
-		 */
-		swap(mnt->mnt_id_unique, new_ns_root->mnt_id_unique);
-		swap(mnt->mnt_id, new_ns_root->mnt_id);
-		mntget(&mnt->mnt);
-	} else {
+	if (flags & MOUNT_COPY_NEW)
+		mnt = clone_mnt(real_mount(path->mnt), path->dentry, copy_flags);
+	else
 		mnt = __do_loopback(path, recurse, copy_flags);
-	}
 	scoped_guard(mount_writer) {
 		if (IS_ERR(mnt)) {
 			emptied_ns = new_ns;
@@ -3179,11 +3172,12 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	return new_ns;
 }
 
-static struct file *open_new_namespace(struct path *path, bool recurse)
+static struct file *open_new_namespace(struct path *path,
+				       enum mount_copy_flags_t flags)
 {
 	struct mnt_namespace *new_ns;
 
-	new_ns = create_new_namespace(path, recurse);
+	new_ns = create_new_namespace(path, flags);
 	if (IS_ERR(new_ns))
 		return ERR_CAST(new_ns);
 	return open_namespace_file(to_ns_common(new_ns));
@@ -3232,7 +3226,7 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 		return ERR_PTR(ret);
 
 	if (flags & OPEN_TREE_NAMESPACE)
-		return open_new_namespace(&path, (flags & AT_RECURSIVE));
+		return open_new_namespace(&path, (flags & AT_RECURSIVE) ? MOUNT_COPY_RECURSIVE : 0);
 
 	if (flags & OPEN_TREE_CLONE)
 		return open_detached_copy(&path, flags);
@@ -4535,7 +4529,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 
 	if (flags & FSMOUNT_NAMESPACE)
 		return FD_ADD((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
-			      open_new_namespace(&new_path, 0));
+			      open_new_namespace(&new_path, MOUNT_COPY_NEW));
 
 	ns = alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
 	if (IS_ERR(ns))
-- 
2.47.3


--fnebkd6yyhhvcsvm--
