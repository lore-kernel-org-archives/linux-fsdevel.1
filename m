Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99B394497
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636247; cv=none; b=FPB4BJWhZYAUjFkfP3+r96f3wcJ0Nekt/wGjTE0CodUVTImIX1z2GKKHEWxUoKOthokXmmWX4wGtuJXyVtpKxap1bV1twbsbm5vIYob4mGhLtvvOuBRLiiMUwLbDTUSJiaRJzoKGQeTAdv/ai45oQaQTOzX5zpsS8ML/KNaxl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636247; c=relaxed/simple;
	bh=fwJ02z6QF7Z8Ypw2tJe56jQoymKZZbPP7tSgPbsf4HU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7kKGWfP4klwyDzOk3buNUq62OWHDc1V7tTmiw8/ozc3nCuAd/TThK2x6oGhBOXFKIEN5YyGey0dU2j+pFRWBTBWwky//4SB+9ztLwdPHedtpAUgaCaJZlCFrhN6zHpCUW5CoGHvYJLfd+n+Aq5iv/hu3QGlcgTSNwoqvH0rsog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEMjWzAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEMjWzAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCFE1F000E9;
	Thu,  9 Jul 2026 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636245;
	bh=upNfzyHTcOZqoGfd7PLX2ebYTtP5AP1hulhKJ8l1RRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZEMjWzAFHEO/IzPwBcWPZ+f/y3dGc2v05aksYZDBB2GQMv1iC379PRfVrcxiNRIst
	 4bayQi2m2kol1mewfrL6usSRfQuMSb8JZo0/BNLq+1epwE6pvNvp7hWhcMCb+tp1hr
	 6DrvK+RuoAx0HstXjLlYXeAxwhgqPh2HoJ3uyMDwXMrCt6KnyN/ovdhlTqbECV0tg/
	 c/cuOuXZgVyKrzZ23zAFxoJcmlp9hbqRBivMywl/wzQ7ZOS465FhYaw4VlGIhzrIuz
	 XRIWmhSkZEFH7SH8pb4/Spkgz3t6+th58ZTWvxQOEoU3Yzf5xs/UH+EPPm9i6W/ipn
	 Tadu8rTxkYbIg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:10 +0200
Subject: [PATCH v2 15/23] binfmt_misc: give the parse_command() results
 names
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-15-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fwJ02z6QF7Z8Ypw2tJe56jQoymKZZbPP7tSgPbsf4HU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHxbe7h12d2zlhfSb9jaz+GIt5nJwrPtR90+iX+pq
 0JqbBd6d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEhJeR4bX6kus6W7brs9tJ
 BG5X+fXzStbxS+/m9NjKbr8hv8frUgfDHz6LSydkmh6JTjqv9p7jotcWpfUnvJfsXPpPa8aD2ga
 +UnYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

parse_command() maps "0" to 1, "1" to 2 and "-1" to 3 and the write
handlers switch on those bare numbers, leaving every reader to redo
the mapping in their head. Name the commands and drop the per-case
comments that only existed to translate the numbers back.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 4172c0937161..83f84934d57c 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -539,9 +539,17 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	return ERR_PTR(-EINVAL);
 }
 
+/* Commands accepted by the /status and /<entry> files. */
+enum bm_command {
+	BM_CMD_IGNORE,	/* empty write */
+	BM_CMD_DISABLE,	/* "0" */
+	BM_CMD_ENABLE,	/* "1" */
+	BM_CMD_REMOVE,	/* "-1" */
+};
+
 /*
- * Set status of entry/binfmt_misc:
- * '1' enables, '0' disables and '-1' clears entry/binfmt_misc
+ * Parse what userspace wrote to /status or an entry file: '1' enables,
+ * '0' disables and '-1' removes the entry or all entries.
  */
 static int parse_command(const char __user *buffer, size_t count)
 {
@@ -552,15 +560,15 @@ static int parse_command(const char __user *buffer, size_t count)
 	if (copy_from_user(s, buffer, count))
 		return -EFAULT;
 	if (!count)
-		return 0;
+		return BM_CMD_IGNORE;
 	if (s[count - 1] == '\n')
 		count--;
 	if (count == 1 && s[0] == '0')
-		return 1;
+		return BM_CMD_DISABLE;
 	if (count == 1 && s[0] == '1')
-		return 2;
+		return BM_CMD_ENABLE;
 	if (count == 2 && s[0] == '-' && s[1] == '1')
-		return 3;
+		return BM_CMD_REMOVE;
 	return -EINVAL;
 }
 
@@ -713,16 +721,13 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 	int res = parse_command(buffer, count);
 
 	switch (res) {
-	case 1:
-		/* Disable this handler. */
+	case BM_CMD_DISABLE:
 		clear_bit(MISC_FMT_ENABLED_BIT, &e->flags);
 		break;
-	case 2:
-		/* Enable this handler. */
+	case BM_CMD_ENABLE:
 		set_bit(MISC_FMT_ENABLED_BIT, &e->flags);
 		break;
-	case 3:
-		/* Delete this handler. */
+	case BM_CMD_REMOVE:
 		inode = d_inode(inode->i_sb->s_root);
 		inode_lock_nested(inode, I_MUTEX_PARENT);
 
@@ -862,16 +867,13 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 
 	misc = i_binfmt_misc(file_inode(file));
 	switch (res) {
-	case 1:
-		/* Disable all handlers. */
+	case BM_CMD_DISABLE:
 		WRITE_ONCE(misc->enabled, false);
 		break;
-	case 2:
-		/* Enable all handlers. */
+	case BM_CMD_ENABLE:
 		WRITE_ONCE(misc->enabled, true);
 		break;
-	case 3:
-		/* Delete all handlers. */
+	case BM_CMD_REMOVE:
 		inode = d_inode(file_inode(file)->i_sb->s_root);
 		inode_lock_nested(inode, I_MUTEX_PARENT);
 

-- 
2.53.0

