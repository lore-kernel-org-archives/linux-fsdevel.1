Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE113101BC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636239; cv=none; b=n7oq8R+f3xoGvWL5mD8rpPD9Fpe9zZijMgdXOkHWcHqzAJAfecUi/t3U2MsvLd0KGdGBgnxKpbOozF7It5wtqRAjNC1CDodIBGa2GfhGBCDWPMU6W+vbWUY5o9LxMEB0OZjeS5DCQd0bq4IHBeGXFH0XtdxbTSEoew5VgaIHMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636239; c=relaxed/simple;
	bh=2K4A3O9Logs+Jy5myyDQCn4B2ETcK91f2iNAY/W5zLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBUjSqWA+4NALz8A64BTdKE6pg1rjaYtzzo5YZVvf9xfnzlhwzTOC8y70cQWB79t203Cs+B9oXNskjgn4mszNMfUy+lTLc9+cDc1S2Acxvzx57kHZYdx4wZD+6ExBQ3RHpo/uucAf2iPbYHQJXHAXHlbwi5hEYyynnbOpcqY0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0dC48F0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0dC48F0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EA21F000E9;
	Thu,  9 Jul 2026 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636238;
	bh=0oFtJhVGRZT4qwD0ueAoZUMszCp8kBi9TEU7KObN/YE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g0dC48F0xoSu4CUdKPS6Swe1lKsvTBK69GsWjVqwZG0neYD4JureFmIUCkAm9F19h
	 /SKAj5aioPyBJ+hlM+1O/Wr/SO3fAID9e0OJkx8FB1ByMp8oEUiHR8P8+O0/28jH+G
	 QGjOXgnjCsXRFM8ZF/+sZCsPgCEn2iRT9dWuUFe1WV1SfdDaWRvJftgrItjPek2xba
	 OItdtWdW75hFOJOO0t0zfUDLZzoL4wCTS7I9PJM2OCUeMN20nm8SC5b9n54wtfYsQ4
	 1GJnxQ6bYAL8SefLQyOco45RmIN2SR1sSAtGjruB84JH4EU9D3RDlfykuPPVm0umFv
	 OOU2n8NlOQrVg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:06 +0200
Subject: [PATCH v2 11/23] binfmt_misc: convert the entry file to seq_file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-11-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5017; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2K4A3O9Logs+Jy5myyDQCn4B2ETcK91f2iNAY/W5zLs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHy9dXmPopSqk0cwV6UTF+e7lEcnp9RwH017k9Sie
 DyrheN0RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESeLmL4K5FzxWIeb0xZa3+C
 4Rled7v5qxR+9BtozLnlJ9lu+PTLREaGVw+2NHn87Vu47UblkjMqvdvaNtSw7X5s85l3v+7GB+w
 yjAA=
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
index 2ac82925b8ed..dac2b423280c 100644
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
@@ -573,40 +573,47 @@ static int parse_command(const char __user *buffer, size_t count)
 
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
@@ -691,23 +698,18 @@ static void remove_binfmt_handler(struct binfmt_misc *misc,
 
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
@@ -755,9 +757,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
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

