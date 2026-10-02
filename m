Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A44CCDCC;
	Fri,  2 Oct 2026 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949254; cv=none; b=rNYuxwpt75pnnYs5VxWIxMhUE433EySVZCJ9vxQV9wbYj28xTpr1njCV10e3kJdwn0PhfnQbvRmUdzDMmzMXlJjXMSWU7bAlK+fVx9GK6ZCnlP9LxOKsnrB9kW71YY/RAMHZ2cbVWrFJQrobzx5894Ul77XhMIVh0G3ujN+32CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949254; c=relaxed/simple;
	bh=uScKm8O171AfM+lVYmWYS/76DX9NFsP6oUJ0Jst9uuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhVY/uBQwOleKYaHnH6VIBBUn+d0obt9xANw790IeROpuWqioKNfQyNSzKXro+OGLzOsS4N/GGEBmGgmOYaBaMlSeo987Gh0K7MHonFMznw1rFCXt32KERdix/skikPig0o+MNmHKloPAaYruAcpZkRv6bzslCfzysolcCmuuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfHyKXBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfHyKXBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A19D1F00893;
	Fri,  2 Oct 2026 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949252;
	bh=sChqgpv9qdbv0oY6ZKbudca6yP050sxLU7jj9UtU6ZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XfHyKXBotkfI5YqprCpkBMcULMZWHx/UinTnuoEIPXPExAEi+WuaYmyLFkcp0+Lj9
	 JVop3TKCSAIXJvBvbgnzfm9xqM/X7Jngnhxr8MVULxoDYM3cAeTJvNSwLn8ICjzpDd
	 G8vpBBHpLUfCK+OzFXjeJLnaWjpDX9a2C5RCEe6t7uh0Q2DroPxs9ydH/tbPDkZWNW
	 fO7Vqhjx5DlkzSpFHfp6HWOSdTKIA2c86tEJBR/+7mhX2dUz8nwTO/ooCgL4l6MlUq
	 8hCzMjDYAn/cCW0Kcb8xr0tQ8djeanKbk2XFx/Zy5mFGasdhXAlZmsl3eHxtWt1dxf
	 S1FIaH3q4Kt9A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:46 +0200
Subject: [PATCH 15/21] namespace: nothing is mounted on or written through
 knullfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-15-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uScKm8O171AfM+lVYmWYS/76DX9NFsP6oUJ0Jst9uuM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x41+ft1l9Zfa/4k/5gbuf9iZtLx71esgj5zT5q5Q
 nq1htsV1o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJeHoz/NOXjO3ictzzy/GV
 XqEHcwN7OkN22m11T8lXRbtaIuPy6xn+1/Z23o74WPyu5I2Q2ac7p+dH2d+//3Gm36FdTwJuOBs
 UcQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Mark the root of knullfs with dont_mount(). Nothing is ever mounted on
the root of a kernel thread and the following patches make that root
reachable from userspace, so say it on the dentry where it doesn't
depend on the mount being in no namespace. Let do_lock_mount() refuse
such a target before it takes the inode lock and namespace_sem. The
flag is sticky so the check needs no lock. The one under the locks
stays for a mountpoint that is being removed.

Make the mount read-only as well. Its one inode is immutable so nothing
could be changed through it anyway, but MNT_READONLY makes that visible
the usual way: EROFS instead of EPERM and ST_RDONLY in statvfs().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index d1e83cda57e6..e1b0ade95b0d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2814,6 +2814,11 @@ static void do_lock_mount(const struct path *path,
 
 		scoped_guard(mount_locked_reader) {
 			m = where_to_mount(path, &dentry, beneath);
+			/* sticky, so it takes no locks to refuse it */
+			if (unlikely(cant_mount(dentry))) {
+				res->parent = ERR_PTR(-ENOENT);
+				return;
+			}
 			if (&m->mnt != path->mnt) {
 				mntget(&m->mnt);
 				dget(dentry);
@@ -6374,6 +6379,10 @@ static void __init init_mount_tree(void)
 	knullfs = kern_mount(&nullfs_fs_type);
 	if (IS_ERR(knullfs))
 		panic("VFS: Failed to create private nullfs instance");
+	/* nothing is ever mounted on the root of a kernel thread */
+	dont_mount(knullfs->mnt_root);
+	/* and nothing is ever written through it */
+	knullfs->mnt_flags |= MNT_READONLY;
 	root.mnt	= knullfs;
 	root.dentry	= knullfs->mnt_root;
 

-- 
2.53.0

