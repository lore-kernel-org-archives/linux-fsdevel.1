Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65931E84C
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955706; cv=none; b=faeW1vlUb1ghararRbb81vZ9igvVV6SG6JFAigmMECyVxCE6GxzTXAY3Y0mzB+jf+MI9jLQWXf6wyAU9wENN+Bi7EoMdi8qB0rQv0McRgJ6I60pONTaXvBggAoTLNtoFjJBWIEBh3vxu+0z7u7D0Qp8UJ6asfoiMpSu9KU1c0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955706; c=relaxed/simple;
	bh=Ijmxg5vyoQ1oIfZDFIyfZb/7YUT7Jls5Cc0/UmyMsjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D54nhVT3T3hmdhyNtChH8UDXf47zpzU3vzSSzfOETwRBgxIR8lmrzYJvP1cwFPSe093ZYRV5C3dUAM+Xf2O0JuF9kcM+9uSBXA44nv//cgVbtddnddKa3JLfT2TMXxZSkST2KxwfwUFsx5HdOA0fszz6+3psStoRVDorqnnO4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nkt7TPGR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x4AszcfE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nkt7TPGR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x4AszcfE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nkt7TPGR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x4AszcfE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nkt7TPGR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x4AszcfE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0FC76BA9F;
	Sat, 16 May 2026 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778955703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I7quuES2Nnz25cpefFp6n1Jxio6jLh72B38wnS1YO2k=;
	b=Nkt7TPGRN6tIn6Nuyva09wsTXC4GT/jptwqAEI8rJr/Q436SqJNbBOZipuPAttDtOun2dR
	KmzRMP8ccoYzYZOh0WXZUPueO7ZgPk34r8d4iWM0CkyZpzcRikdve4jOulny+cesnS5RvQ
	f+NX+qQOoRDSwj55DSYO7tpQnCBFiLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778955703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I7quuES2Nnz25cpefFp6n1Jxio6jLh72B38wnS1YO2k=;
	b=x4AszcfETqUNTj/9Bn2v+3bby3bLeyNFM6wgXxqe2J14wQORCx7fxfz97TmR1JgBSTPfva
	EnIiQ5dfzwfeX3AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nkt7TPGR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x4AszcfE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778955703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I7quuES2Nnz25cpefFp6n1Jxio6jLh72B38wnS1YO2k=;
	b=Nkt7TPGRN6tIn6Nuyva09wsTXC4GT/jptwqAEI8rJr/Q436SqJNbBOZipuPAttDtOun2dR
	KmzRMP8ccoYzYZOh0WXZUPueO7ZgPk34r8d4iWM0CkyZpzcRikdve4jOulny+cesnS5RvQ
	f+NX+qQOoRDSwj55DSYO7tpQnCBFiLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778955703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I7quuES2Nnz25cpefFp6n1Jxio6jLh72B38wnS1YO2k=;
	b=x4AszcfETqUNTj/9Bn2v+3bby3bLeyNFM6wgXxqe2J14wQORCx7fxfz97TmR1JgBSTPfva
	EnIiQ5dfzwfeX3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 385F3593A8;
	Sat, 16 May 2026 18:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U6jVCba1CGr2YQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Sat, 16 May 2026 18:21:42 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [RFC PATCH] fs/splice: allow for a way to block splice() with read-only files
Date: Sat, 16 May 2026 19:21:26 +0100
Message-ID: <20260516182126.530498-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kvack.org,kernel.org,gmail.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F0FC76BA9F
X-Spam-Level: 

Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
and Fragnasia, splicing a read-only file is fundamentally unsafe.

As such, as a mitigation, add a way for users to block splice() for
files they cannot write to. This eliminates this whole class of exploits
that use splice()+confusion in pipe/net/etc code to gain write-access to
files they can only read.

Users can simply toggle fs.splice_needs_write=1 and suddenly splice() will
refuse perfectly legal splices() from files it can only read, but not write.

For vmsplice(), make due with the address_space attached to the folio. Care
is held to make sure the operation isn't too slowed down with locks. The check
itself isn't entirely equivalent (the mapping's host can be the internal bdev
inode, etc, and not the one in /dev against which permissions are checked),
but doing it in a more correct way would require dropping from GUP-fast to
GUP, and that would be too slow.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---

Hello,

sending this out as an RFC so I can get better opinions from VFS & security
folks upstream. I wrote this out as a way to harden against all the page
cache attacks we've seen lately, that bottom out to splice() from a file
they cannot write + confusion elsewhere on the net stack/pipes/etc.

This is _obviously_ not perfect and not complete. My first (unsent) version
straight up returned -EPERM on splice() for these files. This one attempts
to retain some compatibility by only blocking the page splicing operation,
but still issuing the operation with normal copies (kindly suggested by Jan).
vmsplice() is a complicated issue, because gup_fast does not allow us access
to the VMA's vm_file. I tried hacking around it but it's not perfect (e.g you
cannot grab the mnt_idmap for the file, since we only have access to the
address_space + its host).
I'm also not a fan of having somewhat hairy MM code in the middle of
fs/splice.c but that's something we can simply hoist elsewhere as this gets
un-RFC'd. It's also missing the external-facing docs for the sysctl.

My big questions are:
1) Is this a viable way forward?
2) How hard is it to deploy for users? Could we possibly even default to this?

Lightly tested using [1], which should see (if the mitigation is enabled):

$ ./a.out
[   17.283456] splice: task a.out/275 attempted to splice a file it cannot write to.
This is disabled by the fs.splice_needs_write sysctl. If this is truly required
then disable the sysctl. Performance may be degraded.
splice = 32

[1] https://gist.github.com/heatd/277339eb25df57d1f750d7da757cf7ff

 fs/splice.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/sysctls.c | 11 +++++++
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..624e5cbd42eb 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -39,6 +39,8 @@
 
 #include "internal.h"
 
+int sysctl_splice_needs_write;
+
 /*
  * Splice doesn't support FMODE_NOWAIT. Since pipes may set this flag to
  * indicate they support non-blocking reads or writes, we must clear it
@@ -947,6 +949,36 @@ static void do_splice_eof(struct splice_desc *sd)
 		sd->splice_eof(sd);
 }
 
+static bool splice_may_read(struct file *in)
+{
+	if (READ_ONCE(sysctl_splice_needs_write)) {
+		/*
+		 * Disallow splice from files we cannot in any way write to.
+		 * This serves as a trivial mitigation for page cache splice
+		 * attacks, where attackers splice a file they cannot write to,
+		 * but can read (like /etc/passwd, or /bin/su) and, through a
+		 * complex set of logic, manage to write to these page cache
+		 * pages.
+		 * The set of checks is quite simple: if we can already write
+		 * to it, if we could write to it (by reopening), or if we
+		 * could chmod it (owner of the file), then any vulnerability
+		 * coming from this is futile, as you can already write to it
+		 * normally.
+		 */
+		if (!(in->f_mode & FMODE_WRITE) &&
+		    !inode_owner_or_capable(file_mnt_idmap(in), file_inode(in)) &&
+		    file_permission(in, MAY_WRITE)) {
+			pr_warn_once("splice: task %s/%d attempted to splice"
+			" a file it cannot write to. This is disabled by the"
+			" fs.splice_needs_write sysctl. If this is truly required"
+			" then disable the sysctl. Performance may be degraded.\n",
+			current->comm, current->pid);
+			return false;
+		}
+	}
+	return true;
+}
+
 /*
  * Callers already called rw_verify_area() on the entire range.
  * No need to call it for sub ranges.
@@ -971,11 +1003,13 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
 
 	if (unlikely(!in->f_op->splice_read))
 		return warn_unsupported(in, "read");
+
 	/*
 	 * O_DIRECT and DAX don't deal with the pagecache, so we allocate a
 	 * buffer, copy into it and splice that into the pipe.
 	 */
-	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
+	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host) ||
+	    !splice_may_read(in))
 		return copy_splice_read(in, ppos, pipe, len, flags);
 	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }
@@ -1440,10 +1474,51 @@ static ssize_t __do_splice(struct file *in, loff_t __user *off_in,
 	return ret;
 }
 
+static bool may_write_to_page(struct page *page, struct address_space **plast)
+{
+	struct folio *folio = page_folio(page);
+	struct address_space *mapping, *last = *plast;
+	struct inode *inode;
+	bool may = false;
+
+	if (!READ_ONCE(sysctl_splice_needs_write))
+		return true;
+	/*
+	 * Always fine to write to anon folios.
+	 */
+	if (folio_test_anon(folio))
+		return true;
+
+	mapping = READ_ONCE(folio->mapping);
+	WARN_ON((unsigned long) mapping & FOLIO_MAPPING_FLAGS);
+
+	/* If it is the same (locklessly), then LGTM, proceed. */
+	if (mapping == last)
+		return true;
+	/*
+	 * Else we have to recheck with the folio lock held, for mapping
+	 * stability. TODO: killable?
+	 */
+	folio_lock(folio);
+	mapping = folio_mapping(folio);
+	/* May have been truncated, etc */
+	if (!mapping)
+		goto out_lock;
+	inode = mapping->host;
+	may = inode_owner_or_capable(&nop_mnt_idmap, inode) ||
+	      inode_permission(&nop_mnt_idmap, inode, MAY_WRITE) == 0;
+	if (likely(may))
+		*plast = mapping;
+out_lock:
+	folio_unlock(folio);
+	return may;
+}
+
 static ssize_t iter_to_pipe(struct iov_iter *from,
 			    struct pipe_inode_info *pipe,
 			    unsigned int flags)
 {
+	struct address_space *last = NULL;
 	struct pipe_buffer buf = {
 		.ops = &user_page_pipe_buf_ops,
 		.flags = flags
@@ -1467,6 +1542,12 @@ static ssize_t iter_to_pipe(struct iov_iter *from,
 		for (i = 0; i < n; i++) {
 			int size = umin(left, PAGE_SIZE - start);
 
+			if (!may_write_to_page(pages[i], &last)) {
+				iov_iter_revert(from, left);
+				while (i < n)
+					put_page(pages[i++]);
+				goto out;
+			}
 			buf.page = pages[i];
 			buf.offset = start;
 			buf.len = size;
diff --git a/fs/sysctls.c b/fs/sysctls.c
index ad429dffeb4b..1fcd7c9f92d5 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -7,6 +7,8 @@
 #include <linux/init.h>
 #include <linux/sysctl.h>
 
+extern int sysctl_splice_needs_write;
+
 static const struct ctl_table fs_shared_sysctls[] = {
 	{
 		.procname	= "overflowuid",
@@ -26,6 +28,15 @@ static const struct ctl_table fs_shared_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_MAXOLDUID,
 	},
+	{
+		.procname	= "splice_needs_write",
+		.data		= &sysctl_splice_needs_write,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static int __init init_fs_sysctls(void)
-- 
2.54.0

