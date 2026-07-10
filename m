Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61B3F7ABC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676033; cv=none; b=TlZYVnWUCf7d6pXXXsAOeVRzXDMtc4Ma6p06ksBC22PWAYEp9asDq2HQEqliAuMufUsMHYn1P4o+1g1LBEQBZVUm4Z8fyNawEWmTBztx93LE8PWWenM4pF+nZwpc2iwVqw5LrdPEMrVPkLpsuYHx8d1teRE8yTXxwpVuZ3STI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676033; c=relaxed/simple;
	bh=6BMjUc9w/nIbssqAzSSWbt7UQK+RLsJW5lTvcPcsYMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqdNJcwb6BvEWlRMsc5xfQcZ2Ch8yBFPlAapzYTCmGbHlsT+SxaQl8J3euExkcJ+oPyChgpohnLzFtxc7Y3Kcj5DF4O4mexq8d96MHIqDe/stz1RgHCPKpnONTcetSyXgbWXL/VaTquhfeoQAS3GlQ5wDf9stllbelzAwQRyYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9nN4dNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9nN4dNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378181F000E9;
	Fri, 10 Jul 2026 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676031;
	bh=SqI8OZlG/qEkd3Fp4TCWyuDAupA8ZhfkeksJ+xznU7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h9nN4dNQ0jab3F6gAxhlgpU6YDtlEjQVaYxnX75CJu2KkNGkwQU7L5PxDHesGc0TA
	 V1TL78BDSnCukRUitvkiBoBo+Md1wyOie/cM51dPOBPi0hOu2lxtYijx2GHdHNrVIX
	 htJ2VisZ3xc7oJLR6MyX+M1UGgywLmJ+ucAVwBuxPAtrnQjfoWi2jo+tkAJ63VFHqW
	 JyGvde/xGJzp36TQ0Qzeo6CKTnWVwoC7bqxMUTQjBI2XETAD3JZxrKCDIKcUSxZCHE
	 zRXcbgVgYwhqG8M3nGw3sT/ITVjUFGZvrecZwm6p3MN8QPpGglk6CAppQOhpv6Fb2M
	 PFACZZhtzmKvA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:17 +0200
Subject: [PATCH v3 16/24] binfmt_misc: give the parse_command() results
 names
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-16-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6BMjUc9w/nIbssqAzSSWbt7UQK+RLsJW5lTvcPcsYMI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Ilvd9T7G8T+xvhU6nbbT/vkC05Oay89af3l7LIlV
 8N3RrZ7dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE6iAjw561qlnHxAReHHTg
 XMhyK/ntvJ8vJ92o9djoy7+p71mxawnD/5rj2y/E3d65s6SS92zeriNbn4kWy8pVr2O9flz0yN5
 TPmwA
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
index 06f4849cf1ad..1f2b1d136819 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -543,9 +543,17 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
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
@@ -556,15 +564,15 @@ static int parse_command(const char __user *buffer, size_t count)
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
 
@@ -717,16 +725,13 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
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
 
@@ -866,16 +871,13 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 
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

