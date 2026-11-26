Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731385;
	b=0ls+PZRgC12zVV8eNlg/DEN03NI6BsV0um2Max7IZ7GXzG3momXYwLySih6a/WED4ivm
	 PBpuuhR3N+ZbbR0IH+i+MnhzdF2L7I9WJX+5olkn+tRxHso0shUFekM8vDY6NMkf2rZpQ
	 DG+NBFnhqiXYfFCiNl3kuiOXf3KDLCZbeyv/45KjhroKnJlzoCS9HF/L3pVylyL2GJnZL
	 2cipqbRf1NJDXcZTVMmgw8def6AS7F1jbBnlVvLJ/BLNGNCxBaqRGYO659kv3yc7Gr7kU
	 fbp+2/XtlP6l1LANaF4m0n8enFfENTDjb6W2Yn+yDoGYpfoaoAKM1XrKvyUm229bshg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731385;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ErbeD08bs4Z3UNugQ3Z8mBrOAvtRPq5qN/kakvJPnyw=;
	b=ApUJwsVnKAf60SuLL0jct+vYAJ5AJ3nXOFtcYNk0D5QZBT+uNnDuWco063LsESJEDlFE
	 Hn7jYR8SDldESnb1Ry/3o7oeqOJPpFFGc276YrLjeUjaiDko5R4F+2xPjnh/BidH/TE3V
	 LpLvy5wtMrNutQnODVgo97ONy144HVtmNh4DJJckjYi5zZDnapQ3w72p2BdR43iW7gdy+
	 NJsmVaC0s5OonRw4YErxKvLzhOBMQerWY2DdslLSZgo/FYcbnkYUOo1l2QPwe6ayN5MD4
	 TlZTOHM0d0kK2md6NOlA46Pl4I05jjJ2SMkxPSovshXd/3sFDxs5qKIBiYe+WobgJCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJTylhTO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D5606A31E;
	Thu, 26 Nov 2026 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJTylhTO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697A71F000C1;
	Thu, 26 Nov 2026 22:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795731384;
	bh=ErbeD08bs4Z3UNugQ3Z8mBrOAvtRPq5qN/kakvJPnyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eJTylhTO77uVmqweW9jeEH0CGedAWV81UB+7rnKgkODoSrTJi+kZMm3Em3Qz6mtrr
	 3LeCudNBEeAygpLrhTcy0kpNYdT9LxUkYsqEw9CACZ8yjwbKJBJBZsYDQJkh9E1gzU
	 k2k6yNtgEVjshTMqqu82U3nyrukF8EYLVpMJU91dGXhazGICjF9J/NaU7CWbJ/dfnF
	 xQbNzXregjpkI6iJ5RUGu9hBK6MloWKqw264yw+7Ishw8Hh8SorRkzuYfeQn7N2atd
	 0DcDYE4//DTPATzuKEPE3HEDexeM2ojVSYQhBJ+v7tt5gxGHhU3R+9TT5ByTAa3DoB
	 UQUSlxWSzP4vA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Nov 2026 23:15:31 +0100
Subject: [PATCH 1/4] fat: add fat_tmpfile()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-work-fat-tmpfile-v1-1-3bca7b2dbc20@kernel.org>
References: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
In-Reply-To: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+mMC9T7onXw87sBt6Lva92sikXQ9wG/iIHjOv5zVhG0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzrF+/RHRG0sLAXlXOuYXhSYeC5l79p7ln/rVCn4xYm
 e631nccOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiO52RYc1suelLgnQ9lGNY
 2vf/9RD/4ZYVPkfjecb+59cip4jfTmNk6JVt3fHc5OSPmNz6Ctcy4+jLx1RNj8uEhnrv3HFl6aQ
 5bAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

FAT already knows how to deal with a file that is open but has no
directory entry. When an open file is unlinked fat_detach() resets
i_pos to 0. From then on __fat_write_inode() has nothing to write, the
data still goes to the file's cluster chain, and fat_evict_inode()
frees the chain when the last reference is put.

An O_TMPFILE is a file that starts out in that state. So build the
inode like fat_build_inode() does, from a directory entry that only
exists in memory, but don't attach it. fat_build_inode() itself can't
be used for this. It would attach the inode at i_pos 0 and the next
O_TMPFILE would find it through fat_iget().

The mode is ignored, just like in vfat_create() and msdos_create(). On
FAT it's derived from the mount options.

Nothing uses fat_tmpfile() yet. vfat and msdos need a ->link() method
first and wire it up in the following patches.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fat/fat.h   |  2 ++
 fs/fat/inode.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index a8a3ca4f465bf..cc706d89d1b96 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -423,6 +423,8 @@ extern void fat_detach(struct inode *inode);
 extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
 extern struct inode *fat_build_inode(struct super_block *sb,
 			struct msdos_dir_entry *de, loff_t i_pos);
+int fat_tmpfile(const struct mnt_idmap *idmap, struct inode *dir,
+		struct file *file, umode_t mode);
 extern int fat_fill_super(struct super_block *sb, struct fs_context *fc,
 			  void (*setup)(struct super_block *));
 extern int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 642e690632d83..1481ef1a3efac 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -626,6 +626,37 @@ struct inode *fat_build_inode(struct super_block *sb,
 
 EXPORT_SYMBOL_GPL(fat_build_inode);
 
+/* Like an open file that got unlinked: no directory entry, i_pos is 0. */
+int fat_tmpfile(const struct mnt_idmap *idmap, struct inode *dir,
+		struct file *file, umode_t mode)
+{
+	struct super_block *sb = dir->i_sb;
+	struct msdos_dir_entry de = { .attr = ATTR_ARCH };
+	struct timespec64 ts = current_time(dir);
+	struct inode *inode;
+	int err;
+
+	fat_time_unix2fat(MSDOS_SB(sb), &ts, &de.time, &de.date, &de.ctime_cs);
+	de.ctime = de.time;
+	de.cdate = de.date;
+	de.adate = de.date;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+	inode->i_ino = iunique(sb, MSDOS_ROOT_INO);
+	inode_set_iversion(inode, 1);
+	err = fat_fill_inode(inode, &de);
+	if (err) {
+		iput(inode);
+		return err;
+	}
+	insert_inode_hash(inode);
+	d_tmpfile(file, inode);
+	return finish_open_simple(file, 0);
+}
+EXPORT_SYMBOL_GPL(fat_tmpfile);
+
 static int __fat_write_inode(struct inode *inode);
 
 static int fat_sync_inode_metadata(struct inode *inode,

-- 
2.53.0

