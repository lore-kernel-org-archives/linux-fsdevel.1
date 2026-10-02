Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274274D2EFA;
	Fri,  2 Oct 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949258; cv=none; b=g+KgUEkPGqxgSdwztZvVusZEd0pyHiZAGr/dnf9cfCZ80ArCPSkLX/mqjqicRM6LAtabBPrAD7sPkF4e2Gx/fNN7nsSCxG0cTJq2SVEoBdo02ckBgd78oqvvLELI3QPjPdEENauZn0+jQBfMMltyMHgxqKpcKnkmh2GJbQWw7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949258; c=relaxed/simple;
	bh=iga2sIUW15NQ2bNekzqeJOVe/lAXTj+PjQAemwewh/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=en9lYLg7t9qh1l1rcG8MCX+Z8h0KAIm8WcEVKv8nHIIW0bg70NJmrVZdwKV8pAHAaTPTA90raJiwubEXBad0ItZY7X5ASM0S6zqBkzCHMZ44KHfKwl8XKrL6pF1fZerpFCgSe6nPBBUMOSn4c+o+21sGfp9M3rZ4WDY/Ok6rqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXC47+NV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXC47+NV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7B41F000FF;
	Fri,  2 Oct 2026 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949257;
	bh=Hi7+Xkq+97QgdoKfGZmUC9RvVS7x2y44hhPrI+Esixo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LXC47+NVwVSJyJJJNsCBW9wSfTZ7bmWNXIK36wB8Mva72WE93TkDYnmv0VkBHE5N7
	 uz+BoD9OhzUruFV0uT4UOb4SRhuxijQAIQ9PjzJ8QvCk41BIoBUl95X2lNjONqf5KJ
	 Jo9K4I8VHj0vopaKNdPtqbqVFlQtsXYUqW7Fkk9/KU0WkeO4ftTJkYn+BZUipdDUiS
	 g629A2MaI6ji2ueLkp/J/hNX1b9PuOpklBlNn0XalTcikJaG34XdqPTPLEmmxdvrKS
	 eUbDaU1lmsCA7YtGyuoRyJDmCjJq3G6xbH1iCEB3OAj8jXU0cRkKCnnKbNkHbiNvH1
	 Fg6Mzm50viWgQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:48 +0200
Subject: [PATCH 17/21] nullfs: refuse file locks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-17-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2225; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iga2sIUW15NQ2bNekzqeJOVe/lAXTj+PjQAemwewh/o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x4l/jfmYJJFxMHnQWdZv59+0mcvMbW6KS/tZ6pcN
 t+vLIbujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMrGVkmPTE75uVTumxI04T
 9beI3fIQMNrwt0KvPUJZTtpjn1DLBEaGCeUx03dxbbXneH7zR3jLX4X7+csir+Ue1d1ceV82s8e
 OAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Refuse flock() and POSIX locks on nullfs. Its one inode is the root of
every kernel thread and the following patches make it the directory
that stands in for an unmounted mount, so a lock taken through one such
directory would block the locks of every other holder and F_GETLK would
tell them the pid of the holder. Give the directory file operations of
its own: what libfs gives an empty directory plus ->lock and ->flock
that fail with ENOLCK, the way a filesystem without lock support does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nullfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index 55a04f2d7761..d90c71f5eece 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -10,6 +10,34 @@ static const struct super_operations nullfs_super_operations = {
 	.statfs	= simple_statfs,
 };
 
+static loff_t nullfs_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	/* an empty directory has two entries . and .. at offsets 0 and 1 */
+	return generic_file_llseek_size(file, offset, whence, 2, 2);
+}
+
+static int nullfs_dir_readdir(struct file *file, struct dir_context *ctx)
+{
+	dir_emit_dots(file, ctx);
+	return 0;
+}
+
+/* the one inode of nullfs is shared by every holder, so no locks on it */
+static int nullfs_nolock(struct file *file, int cmd, struct file_lock *fl)
+{
+	return -ENOLCK;
+}
+
+/* what libfs gives an empty directory, plus the refusal of file locks */
+static const struct file_operations nullfs_dir_operations = {
+	.llseek		= nullfs_dir_llseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= nullfs_dir_readdir,
+	.fsync		= noop_fsync,
+	.lock		= nullfs_nolock,
+	.flock		= nullfs_nolock,
+};
+
 static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -30,6 +58,7 @@ static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
 
 	/* nullfs is permanently empty... */
 	make_empty_dir_inode(inode);
+	inode->i_fop = &nullfs_dir_operations;
 	simple_inode_init_ts(inode);
 	inode->i_ino	= 1;
 	/* ... and immutable, reading it leaves no trace either. */

-- 
2.53.0

