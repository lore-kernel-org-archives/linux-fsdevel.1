Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE93B0ACE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636259; cv=none; b=lQ2X47T3n3F5zUrvDc14IuTmY2Fw+eP0FOGJKqkdDb2/REQjPez6vNJ4Rz5nRvYJWXHSC87m1pXbID1U+nQVarn+tbDYQr4ZQVoh5z5H3zM8ZVearUbMh+Z4AbHvHpFr83nFI/uQPlA2jhuoe0NmrClda2pP7Z5qOy9kU66Ayhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636259; c=relaxed/simple;
	bh=TPnsqAazRKakxSbfyYI+7zYmksgk7UgLHJazmbDQvTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3kZQKPT/IZpoogHkEO/9WGqCJfl6cIvoS8ughuJiMtHOCDiMQrMZ0vnh73wwp/rRwb5PajAeq2chVyh4WXl0A9oBCebHL1mv2weF4Fe1sqf7TG0x1RZKK/crvt3SWpZXA008yyxCjKLl6IZw2hRxePp1cWLY+s11/zRN2IYALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE5kgrOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE5kgrOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3541F000E9;
	Thu,  9 Jul 2026 22:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636257;
	bh=skdAyX3970evMrszUKHQM7y2G4dAmG1JVxtNPswg6y4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dE5kgrOBcfaEPwffUaYtkQz1jiXWh3rBnQq6uGWTZXRwY+QNO+3T2cms2tHyhIRe7
	 VDucru3IgqCvSZttfAq9Ech+k6ayknA4s5x5YKNWOjLSCm+SiEEGBf/sTl+W3CEg0p
	 EcFuW+DzUMMZW3yEoVEYmc8Na0KGSRvCVqIdjwNkS9g8F7lUEuwgwelvGIy23S/dqE
	 jyGGsbhdIWm71KhgmHn2KdmPn+9H/c4W7G8gTspUVbnW9Hja1dvTm2m33bhIV5No4/
	 Ml6EQ03jQJOKS75u6+L0BYpy8Aw54+v46DZfSB8Iy2YNK1Kjh9BjpDadXEuIeTHZKk
	 kjakhjRaCiCsw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:16 +0200
Subject: [PATCH v2 21/23] binfmt_misc: assorted small cleanups
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-21-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TPnsqAazRKakxSbfyYI+7zYmksgk7UgLHJazmbDQvTs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHxbt+K25EYb+fDw6etUPjWIt85LD5mZsixV4PVFv
 oVf9hlJdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkcCTDP/MzFxtlTI5GSW2q
 Feh02fXZ99WJnt9p3748C4np+njy7B6GfzYetUyHsiWZ73tWp+i+XNN2XDnu25dbqWXTP4c55DL
 ocwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use umode_t for the mode argument of bm_get_inode(), constify the
fixed status strings in bm_status_read(), give the super_operations
the bm_ prefix everything else in this file uses, replace the stale
scanarg() comment which still described parameters and an err
variable it lost decades ago and fix the delimiter typo plus a
missing space nearby.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 6acce58ce405..4c641cacdcc9 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -291,10 +291,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 /* Command parsers */
 
 /*
- * parses and copies one argument enclosed in del from *sp to *dp,
- * recognising the \x special.
- * returns pointer to the copied argument or NULL in case of an
- * error (and sets err) or null argument length.
+ * Scan the argument starting at @s up to the delimiter @del, recognising
+ * the \x escape. Terminates the argument with a NUL and returns a pointer
+ * past it or NULL on a malformed escape.
  */
 static char *scanarg(char *s, char del)
 {
@@ -309,7 +308,7 @@ static char *scanarg(char *s, char del)
 				return NULL;
 		}
 	}
-	s[-1] ='\0';
+	s[-1] = '\0';
 	return s;
 }
 
@@ -458,7 +457,7 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 	if (copy_from_user(buf, buffer, count))
 		return ERR_PTR(-EFAULT);
 
-	del = *p++;	/* delimeter */
+	del = *p++;	/* delimiter */
 
 	pr_debug("register: delim: %#x {%c}\n", del, del);
 
@@ -600,7 +599,7 @@ static int bm_entry_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static struct inode *bm_get_inode(struct super_block *sb, int mode)
+static struct inode *bm_get_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *inode = new_inode(sb);
 
@@ -848,7 +847,7 @@ static ssize_t
 bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
 	struct binfmt_misc *misc;
-	char *s;
+	const char *s;
 
 	misc = i_binfmt_misc(file_inode(file));
 	s = READ_ONCE(misc->enabled) ? "enabled\n" : "disabled\n";
@@ -895,7 +894,7 @@ static void bm_put_super(struct super_block *sb)
 	put_user_ns(user_ns);
 }
 
-static const struct super_operations s_ops = {
+static const struct super_operations bm_super_ops = {
 	.statfs		= simple_statfs,
 	.evict_inode	= bm_evict_inode,
 	.put_super	= bm_put_super,
@@ -964,7 +963,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
 	if (!err)
-		sb->s_op = &s_ops;
+		sb->s_op = &bm_super_ops;
 	return err;
 }
 

-- 
2.53.0

