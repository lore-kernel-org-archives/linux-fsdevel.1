Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5E3EE1F6;
	Tue, 24 Mar 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352547; cv=none; b=eohfsSGiAC0DCCG2iYp+9EK3SdeocsJ0dqaaVPcWZ87oxcEU2uD5Wzb9KG1NILypNvDH9+HgcO+I0bN9qoFmdZ24dXQN1ya0zMcuumkeQWxf7Dxbjd27tyqDvYM/0WuhkBC73Y4ejh+xkcK9N7IR3eaCksFt9ziM05bVt72/k6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352547; c=relaxed/simple;
	bh=oaMZMVfZXvRpAbuFI4f9YLOD4YOqraHFURu3mQG7ZrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pH2cc04648KYTRXEB2Qxdpa0+k9UX7Yax4JUgiwMfRZwL7EbTBMBTeRpzGqy+7SXcdzUShEZyzCqbWDIPg7lruXXr78FNkO4leMO3X8CDHyMa4qu2CIOzv0KKU6hJZEWDCiQ9lEDQy1Ct8+ZZwTaWzh2LhSdF8N2AOchRgJejmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGg/Zwy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGg/Zwy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3578BC2BCB1;
	Tue, 24 Mar 2026 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774352547;
	bh=oaMZMVfZXvRpAbuFI4f9YLOD4YOqraHFURu3mQG7ZrA=;
	h=From:To:Cc:Subject:Date:From;
	b=tGg/Zwy1eMnlEPuMuU8RQMc3FoBbzBLA4bOkQ3/Z3G2limSDZWBu7Q3oCTPikEdqv
	 QOpjKSQatGx7zHnSwmpWb19ksUEsw+Ayyvr8wsEpoYwCBhc42ncPBpsoledz3euwUX
	 lU5AvlrM/khwHuIJNMwDlLgTCWwIQvIIyLOXUpbpx/cbctHsO2tqRmzrmll95PJRLq
	 QblliuCjXEOS9lrayagUEujcIJFpXyix7ndIVdxXd/j5+PKsC6rrRYhTO2jh9cC8uH
	 FRbk1YhyQaIq3s4TXbAgcq//Ij8a2FVGtL1EAk97xwbaqIAS34cnMcMl+78reyZD8k
	 ct7LcjHvdsPLw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] readdir: Introduce dirent_size()
Date: Tue, 24 Mar 2026 12:41:15 +0100
Message-ID: <c20d2f8f6817a39401155cfc80f0dff88df116e0.1774350128.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; i=chleroy@kernel.org; h=from:subject:message-id; bh=oaMZMVfZXvRpAbuFI4f9YLOD4YOqraHFURu3mQG7ZrA=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQeqohfc1y21e/DQ63JrSfWX6pJzj882fXL1x8+AQ4F+ SelLj8R7ihlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATWejDyLBzSnGEkuocn5Nm zW4/p7b+sRfTNrhheHD6k4MF1SePf7ZmZLioXndy1tr2X70twQYcqy+v+FfR9/+P6SXGj1kzP93 fMYkFAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

In several places in readdir.c there are calculations of the total size
of a dirent, which contains a few fixed fields plus a name field with
variable size. To add fun every dirent is of a slightly different type:
- struct old_linux_dirent
- struct linux_dirent
- struct linux_dirent64
- struct compat_old_linux_dirent
- struct compat_linux_dirent

Replace ugly size calculation by a macro called dirent_size() which
calculates the size of the structure based on the pointed type and
the name field len.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 fs/readdir.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 73707b6816e9..fb910dc2f52b 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -22,6 +22,8 @@
 #include <linux/compat.h>
 #include <linux/uaccess.h>
 
+#define dirent_size(dirent, len) offsetof(typeof(*(dirent)), d_name[len])
+
 /*
  * Some filesystems were never converted to '->iterate_shared()'
  * and their directory iterators want the inode lock held for
@@ -198,9 +200,7 @@ static bool fillonedir(struct dir_context *ctx, const char *name, int namlen,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!user_write_access_begin(dirent,
-			(unsigned long)(dirent->d_name + namlen + 1) -
-				(unsigned long)dirent))
+	if (!user_write_access_begin(dirent, dirent_size(dirent, namlen + 1)))
 		goto efault;
 	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
 	unsafe_put_user(offset, &dirent->d_offset, efault_end);
@@ -263,8 +263,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 	struct getdents_callback *buf =
 		container_of(ctx, struct getdents_callback, ctx);
 	unsigned long d_ino;
-	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
-		sizeof(long));
+	int reclen = ALIGN(dirent_size(dirent, namlen + 2), sizeof(long));
 	int prev_reclen;
 	unsigned int flags = d_type;
 
@@ -352,8 +351,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 	struct linux_dirent64 __user *dirent, *prev;
 	struct getdents_callback64 *buf =
 		container_of(ctx, struct getdents_callback64, ctx);
-	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
-		sizeof(u64));
+	int reclen = ALIGN(dirent_size(dirent, namlen + 1), sizeof(u64));
 	int prev_reclen;
 	unsigned int flags = d_type;
 
@@ -460,9 +458,7 @@ static bool compat_fillonedir(struct dir_context *ctx, const char *name,
 	}
 	buf->result++;
 	dirent = buf->dirent;
-	if (!user_write_access_begin(dirent,
-			(unsigned long)(dirent->d_name + namlen + 1) -
-				(unsigned long)dirent))
+	if (!user_write_access_begin(dirent, dirent_size(dirent, namlen + 1)))
 		goto efault;
 	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
 	unsafe_put_user(offset, &dirent->d_offset, efault_end);
@@ -519,8 +515,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 	struct compat_getdents_callback *buf =
 		container_of(ctx, struct compat_getdents_callback, ctx);
 	compat_ulong_t d_ino;
-	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
-		namlen + 2, sizeof(compat_long_t));
+	int reclen = ALIGN(dirent_size(dirent, namlen + 2), sizeof(compat_long_t));
 	int prev_reclen;
 	unsigned int flags = d_type;
 
-- 
2.49.0

