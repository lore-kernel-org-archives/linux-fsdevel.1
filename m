Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840D3EDE62
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527952; cv=none; b=huQAY7AP3M69NQtbMaFpAHVSVs9fzVyhmEglhrDaJJpXjlPK3BIuCxb8DerC09zKgzkf16dGaZM25Z7Jfa2DeX3sah2xDVC2XV0oLnXe9XhLY75oKJFAn0BRSxw2wkc+w/n+iOcOp3GT23lXNAcJXseVMJSFboDdVDb6DJ6h//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527952; c=relaxed/simple;
	bh=NSjiLvE+BcinmoVSsj+5f2oh6MtEe4AN9I+zdP/v+yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcefdwIUE5czmJEq2U92uHp7szRQ1dUCGsBmS+u7AlbdtpU7bu8qs5/bMcu2aybSm+37d/V30RyDc41nBhBcOEbYiuBdzAOvMCckjS2s2g5o9undlnHJTl4dBmYB4oUXRM/lKpUgYWbi7Vz1Vi9iaW58LqM03UNGBxZm16PKYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+SCb0Ef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+SCb0Ef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625471F00A3A;
	Mon, 15 Jun 2026 12:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527951;
	bh=PUULko63qit8jx0r1x6veXdAFqElZLzGgObOWWC2ABg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h+SCb0Ef8oc4piFdgDwG1aa6DQ6shqJMxgaCv8C6OQLhfKxn2zyAko5O3BLDFXoEC
	 0p93W06htYruKva/Px4Qrjg1IPog8GQ55TBavYwsEFzQ6tvSSjJ/o7tN/U6Jx5D9iW
	 9EcigCSq+oa2THd5PX4HJhtfbhTngNT5CxIXjZXDk/jK/dUIDVhC0IaPOhu7UpytXj
	 kkFpvQZrn/X4Op/nCtO4AaAYU1RYeAcRpDZmqqCaDT4bs+ktWdACxgX/nxaqsecJ/4
	 gg7pIcVnjQvEaikqfOQNUWJhSsPD50HDgohOUQe5iaXiskqN3vj5N/v5+xrPYshMaW
	 2Q1nAL3TT7gyQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 15 Jun 2026 14:52:18 +0200
Subject: [PATCH 1/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
In-Reply-To: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-f5839
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NSjiLvE+BcinmoVSsj+5f2oh6MtEe4AN9I+zdP/v+yk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpf+1xcWcIPKttWx/w4Frfrj5/ffkL1zat2/4z8M9Hw
 47p8xs5O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiosjIsNr6RYMba+4N0eSG
 4NYLsjkVG9/fmWvyySJ7urilyTwNM0aGO10lJ4yKD77hmLijZ728yM5w3T0XvokWuN+aqLHs7h0
 NHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

vfs_tmpfile() never checked that the caller's fsuid and fsgid map into
the filesystem.  On an idmapped mount whose idmapping does not cover the
caller's fs{u,g}id, the ->tmpfile() instance initializes the new inode
through inode_init_owner(), where mapped_fsuid()/mapped_fsgid() return
INVALID_UID/INVALID_GID, and the tmpfile ends up owned by (uid_t)-1.

Every other creation path already refuses this: may_o_create() (O_CREAT)
and may_create_dentry() (mkdir, mknod, symlink, link) bail out with
-EOVERFLOW via fsuidgid_has_mapping() precisely so that an object cannot
be created with an owner the filesystem cannot represent.  An O_TMPFILE
is no exception: it is created I_LINKABLE and linkat(2) can splice it
into the namespace afterwards, so the same guarantee must hold.

Add the missing fsuidgid_has_mapping() check to vfs_tmpfile().  On a
non-idmapped mount the caller's fs{u,g}id always map in the superblock's
user namespace, so this is a no-op there and only takes effect on an
idmapped mount that does not map the caller.  It applies to every
filesystem that sets FS_ALLOW_IDMAP and implements ->tmpfile() (tmpfs,
ext4, btrfs, xfs, f2fs, ...), and to overlayfs, whose upper-layer
tmpfile creation funnels through vfs_tmpfile() via backing_tmpfile_open().

Fixes: 8e5389132ab4 ("fs: introduce fsuidgid_has_mapping() helper")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..c11fdd196b41 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4735,6 +4735,10 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	int error;
 	int open_flag = file->f_flags;
 
+	/* A tmpfile is I_LINKABLE, so guard its owner like may_o_create(). */
+	if (!fsuidgid_has_mapping(dir->i_sb, idmap))
+		return -EOVERFLOW;
+
 	/* we want directory to be writable */
 	error = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 	if (error)

-- 
2.47.3

