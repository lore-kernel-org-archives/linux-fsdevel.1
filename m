Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6323F5BC5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676025; cv=none; b=JTAFKxkaO7JqFBxtvt75IJXsNjjQk7/0egAnxsei4RpKZhSdU2N6cHyuRiRM9NUP1cp6xyae86PCeKeUQHnl/U150FH/jpKZduCZ/xqeGbH8PGHA6ojCXKiCH8/i8KW6O9N/ll4GQooVeVaKmJIfJd0+hsf61wr8ml89lFMZ0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676025; c=relaxed/simple;
	bh=OTn/NJPM1/XIz6h4f+STHHorCIubSZ3Qj/LONNAc7tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDsgU6k8r1iBwC2iaq5JUXJUkQVXoUZYxv/dnUPrOTbVy9bJXHUmZ1h9TF/6AJCd3x8I7TL2tsaeUiLW5gRGU7GvxVniwXc2aj5CHgRx9T9R2vlgsDOItKwVyMuF5aKFUvDk8j3tyeLZRRbmF7BNybfEAC2FuboWcpAPUQrArqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXT2CWXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXT2CWXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E654F1F000E9;
	Fri, 10 Jul 2026 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676024;
	bh=2/BS03uzC+ArmuTiTNxC13ftRdbeXFdsWXea4td0krI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jXT2CWXlLXDFdzIiBoKHiZDmIdLAQOnhR0r9It9sEuiJEEZgmXdoZdD+lmRh2QsqV
	 7AyfjVtUxv/2n2iEKPqdp/NNyijyoUCEHfgm/IAzHt9S3SZYSHAjNgA9AKeWZ1TeUJ
	 I0Jw/JGV2GN6H9iL1u44XyA+ihL043XQHDEASttWR7iz0uY1gmNKDdd4qlKiiuYEOB
	 gLbxLxyOPl1WzAOVMv+X1QRVXuZI4fXQzPk/9+9pfIlPokY0TG8XN5dMo+SATGL4n2
	 IR6JbNAUF9f3MxRiSfuFai3xrmF4jmILMcIqopIN0r/U4twxu1m3oM6B800pu0yjfC
	 gTGVL89t/zoYg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:13 +0200
Subject: [PATCH v3 12/24] binfmt_misc: convert the entry file to seq_file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-12-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5017; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OTn/NJPM1/XIz6h4f+STHHorCIubSZ3Qj/LONNAc7tA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7InbYpzJqfhCW6XtpqbG3vv6eUGhyyMUfgnd/Hj21
 8sPWx10OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyv4vhn57BqogM7onWe1bm
 5fXU9TZ4vY+69v7qtuZ+u/nVc797sjP8j5aPU3hdZ/X7b+DilOqvW14asO88n2u6q/nlq/RgLZZ
 6BgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Reading an entry file allocates a whole page and formats the status
into it with a chain of manually advanced sprintf() calls, silently
relying on MAX_REGISTER_LENGTH plus the hex-expanded magic and mask
always staying below PAGE_SIZE. Convert the read side to seq_file
which sizes its buffer as needed and gets rid of the open-coded
pointer arithmetic including the last bin2hex() user in the file.
The output is byte for byte identical.

seq_open() clears FMODE_PWRITE for historical reasons and would
silently turn pwrite() on entry files into -ESPIPE even though
bm_entry_write() accepts writes at any offset. Restore the flag in
bm_entry_open() the same way kernfs does for its seq_file backed
files so pwrite() keeps working.

The only user-visible difference is that seeking is now bound by
seq_lseek() instead of default_llseek(), i.e. SEEK_END stops working
on entry files, which nothing can sensibly use anyway.

The status file keeps its simple_read_from_buffer() as it only ever
returns one of two fixed strings.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 74 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 252e1f2a8347..23a2020d9266 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/hex.h>
 #include <linux/init.h>
 #include <linux/sched/mm.h>
 #include <linux/magic.h>
@@ -25,6 +24,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/rculist.h>
+#include <linux/seq_file.h>
 #include <linux/fs_context.h>
 #include <linux/syscalls.h>
 #include <linux/fs.h>
@@ -577,40 +577,47 @@ static int parse_command(const char __user *buffer, size_t count)
 
 /* generic stuff */
 
-static void entry_status(struct binfmt_misc_entry *e, char *page)
+static void bm_seq_hex(struct seq_file *m, const u8 *data, int size)
 {
-	char *dp = page;
-	const char *status = "disabled";
+	for (int i = 0; i < size; i++)
+		seq_printf(m, "%02x", data[i]);
+}
+
+static int bm_entry_show(struct seq_file *m, void *unused)
+{
+	struct binfmt_misc_entry *e = m->private;
 
 	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
-		status = "enabled";
+		seq_puts(m, "enabled\n");
+	else
+		seq_puts(m, "disabled\n");
 
-	dp += sprintf(dp, "%s\ninterpreter %s\n", status, e->interpreter);
+	seq_printf(m, "interpreter %s\n", e->interpreter);
 
 	/* print the special flags */
-	dp += sprintf(dp, "flags: ");
+	seq_puts(m, "flags: ");
 	if (e->flags & MISC_FMT_PRESERVE_ARGV0)
-		*dp++ = 'P';
+		seq_putc(m, 'P');
 	if (e->flags & MISC_FMT_OPEN_BINARY)
-		*dp++ = 'O';
+		seq_putc(m, 'O');
 	if (e->flags & MISC_FMT_CREDENTIALS)
-		*dp++ = 'C';
+		seq_putc(m, 'C');
 	if (e->flags & MISC_FMT_OPEN_FILE)
-		*dp++ = 'F';
-	*dp++ = '\n';
+		seq_putc(m, 'F');
+	seq_putc(m, '\n');
 
 	if (!test_bit(MISC_FMT_MAGIC_BIT, &e->flags)) {
-		sprintf(dp, "extension .%s\n", e->magic);
+		seq_printf(m, "extension .%s\n", e->magic);
 	} else {
-		dp += sprintf(dp, "offset %i\nmagic ", e->offset);
-		dp = bin2hex(dp, e->magic, e->size);
+		seq_printf(m, "offset %i\nmagic ", e->offset);
+		bm_seq_hex(m, e->magic, e->size);
 		if (e->mask) {
-			dp += sprintf(dp, "\nmask ");
-			dp = bin2hex(dp, e->mask, e->size);
+			seq_puts(m, "\nmask ");
+			bm_seq_hex(m, e->mask, e->size);
 		}
-		*dp++ = '\n';
-		*dp = '\0';
+		seq_putc(m, '\n');
 	}
+	return 0;
 }
 
 static struct inode *bm_get_inode(struct super_block *sb, int mode)
@@ -695,23 +702,18 @@ static void remove_binfmt_handler(struct binfmt_misc *misc,
 
 /* /<entry> */
 
-static ssize_t
-bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+static int bm_entry_open(struct inode *inode, struct file *file)
 {
-	struct binfmt_misc_entry *e = file_inode(file)->i_private;
-	ssize_t res;
-	char *page;
+	int ret;
 
-	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	entry_status(e, page);
-
-	res = simple_read_from_buffer(buf, nbytes, ppos, page, strlen(page));
+	ret = single_open(file, bm_entry_show, inode->i_private);
+	if (ret)
+		return ret;
 
-	kfree(page);
-	return res;
+	/* seq_open() clears FMODE_PWRITE, bm_entry_write() takes any offset */
+	if (file->f_mode & FMODE_WRITE)
+		file->f_mode |= FMODE_PWRITE;
+	return 0;
 }
 
 static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
@@ -759,9 +761,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 }
 
 static const struct file_operations bm_entry_operations = {
-	.read		= bm_entry_read,
+	.open		= bm_entry_open,
+	.read		= seq_read,
 	.write		= bm_entry_write,
-	.llseek		= default_llseek,
+	.llseek		= seq_lseek,
+	.release	= single_release,
 };
 
 /* /register */

-- 
2.53.0

