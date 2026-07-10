Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2B3F927A
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676044; cv=none; b=YsNyQMldgCyDa4W4N6wi66NwXNEZWugqv9uZv/2lHuGvgFY04n06a2j4XazgQPZ19sW53bZliniphMDvTdwqcS7lDpl25wPxTe0Ogvl8gGMRAJbeRHmpv2PByhfpPQPpUEztODDOpR/jTXE2Imz4VXETDkMleeTTwpWTobEPOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676044; c=relaxed/simple;
	bh=DxaXDtPSL/Yhx8IE2WZ2kfrmFA6eNfkRrm8ZRKyCQfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukKpdvSsIC+teZKxhEGMwrqFz7zADByOZz+IixE78Em1ovtZRwHx82fiFGfQhhB+i+znQz7cJu38ibnyTtvCMLjpoQmkyrM8/+KBUs6MpzIuzvEhAxWM5d76fRum3C3XQyHbYELjfLUUAncgYX5Ozd9r9KLDJo4PpPiwjGBXdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbjC5F66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbjC5F66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E368E1F00A3D;
	Fri, 10 Jul 2026 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676043;
	bh=Xm+j3OgjLK3HnfdON0ysf0/V6hafzJtdTjDpiV8v8kA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kbjC5F667wVKUx5SVd6rCkZBMjrEORAPXzCtMF8ZIrG6oZhdm7/5jcIK2PBwObf96
	 MGrkNEuTAuapzv0pAnoD/gwQZb/faPLmh0RuFeM2EW5nIl/74ocHmQG4J+fHnrtGc3
	 Uk/2BmtTZF1lLOON7GBzVaxlYklzLsg5xZfWwp/559pjqqzJp5+aPPAkEthxHqiQPr
	 uN00rt5b5MenS2OEUuA5GAxGILm4QvA2wsg+B4fJz8b8W5AOyadvWi76dYtk7FwDel
	 BvQs+wly0FNkV88FDJ3fBDV7YPMdwTCW5hEvKhi7JSW7EFeZt7dzrvkIY6GDBzLQhw
	 EmNhGC7KEZABA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:23 +0200
Subject: [PATCH v3 22/24] binfmt_misc: assorted small cleanups
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-22-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DxaXDtPSL/Yhx8IE2WZ2kfrmFA6eNfkRrm8ZRKyCQfw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7IkvnmP0tqS9ajbX8twFiY8bfDYxZK3caH4wViNyw
 89dCZGLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai+oXhf/ilu6qHHK5drZBc
 +ut4xf6cskqlKJ0L575cYbogvXPHKXaGf7breZboHRL3XrhLovB6ZvOJnG97pnT7cE2P0/q4/1O
 jMxMA
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
index eb56aa6a3ca2..189b9218e5a6 100644
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
 
@@ -604,7 +603,7 @@ static int bm_entry_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static struct inode *bm_get_inode(struct super_block *sb, int mode)
+static struct inode *bm_get_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *inode = new_inode(sb);
 
@@ -852,7 +851,7 @@ static ssize_t
 bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
 	struct binfmt_misc *misc;
-	char *s;
+	const char *s;
 
 	misc = i_binfmt_misc(file_inode(file));
 	s = READ_ONCE(misc->enabled) ? "enabled\n" : "disabled\n";
@@ -899,7 +898,7 @@ static void bm_put_super(struct super_block *sb)
 	put_user_ns(user_ns);
 }
 
-static const struct super_operations s_ops = {
+static const struct super_operations bm_super_ops = {
 	.statfs		= simple_statfs,
 	.evict_inode	= bm_evict_inode,
 	.put_super	= bm_put_super,
@@ -968,7 +967,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
 	if (!err)
-		sb->s_op = &s_ops;
+		sb->s_op = &bm_super_ops;
 	return err;
 }
 

-- 
2.53.0

