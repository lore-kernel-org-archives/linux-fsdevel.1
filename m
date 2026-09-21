Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E42486439
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000172; cv=none; b=rvHirT+XqcC8EHejgLR+Pb93O2WZWzVLIg2O9UeaB7kGKlVyhejtL1qwWNLQmi1UgSZklW+nLn5HogNIQK8x96aHA9DSLhhlKGsFWfx3e/E4KFSHZcZOHDUoxd5Fez/MNoxNw/yziE1zCnesxSk45Z481JEfPHtBzbfIo3DM4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000172; c=relaxed/simple;
	bh=7oWeiAl6iaHMBViAHYW/To3IQibFR+OEdH1pVILvtv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPPDIvE3npznUVsmmoscLvJBZMQtEoFDwpABELPFkyZ7F+S4IJMJESmRcyCBr/wL3lgm/UEMC9JE++Abihsr5ZFf3K8KePZhNQgSkU9OdX1+lZAkm39hlwG1IlJdIduPylZqgXdsKe79D24w1USCJ0/QIvOlb50tDcS5vbK7NKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHzfhbBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHzfhbBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FB81F00893;
	Mon, 21 Sep 2026 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000168;
	bh=xRSzc9VjfQvQHFj//gCSD7rKwglaIPUFSM5j1lDLybM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YHzfhbBExtMmLmBcoAiFlDj/l0IddaCce3UsMG6SMZzO12a9lpkMpttNhRXeOWs+U
	 avV4L8S+HEH1TIOvuz0hW3/KcY1LuYhLfzUqWds5r8L7sK4Y7LZSUX9lq2alPy9We6
	 Vy5KvWtW/q8cGaK7q2lAl2hGYGZUvIgSTtQC+ahu/2mELkAds1j9FflFF+p+ztVDUb
	 uR3P07QKP0KeW5XtRXF5imFop+h2C+Vf9a845O69L0D8zviVdubEzZA7bYkZ7SA764
	 r2GHMNjbxbOe6D/OT9JoRvq8zzLrfKSktB1QX9BY2AaoprxO4CPFfBrq0U4CBF28ro
	 qkDV0/mDrj5mw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:37 +0200
Subject: [PATCH 09/10] file: add CLOSE_RANGE_CLOEXEC_ONLY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-9-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=5926; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7oWeiAl6iaHMBViAHYW/To3IQibFR+OEdH1pVILvtv4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOF5cOje56P/OGa8VLj6eX/l8r/fr5e+fPshTXdJs
 sic/fpW0ztKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmck2MkaH7wLEDqmzXL54N
 sfwnILkuclXHzehiKaGpd4veLZ147U4cw//YT22s5uskst2XTfBQNJEwC3M4eiJEbc+DEK6glo/
 fDjMDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

CLOSE_RANGE_CLOEXEC marks a range close-on-exec. Nothing happens to
these fds unless an exec happens. Add CLOSE_RANGE_CLOEXEC_ONLY which
closes the close-on-exec file descriptors in the range.

When combined with CLOSE_RANGE_EXCEPT it names the close-on-exec file
descriptors that are supposed to survive. Every close-on-exec fd outside
of the range is closed. File descriptors without that flag are left
alone. Whatever the caller deliberately passes down, stdio, LISTEN_FDS,
an inherited pipe, remains where it is.

The handful of close-on-exec descriptors the caller still needs for the
exec such as the executable, an error pipe, sit in a specific range.
That is what a task between clone(CLONE_FILES) and execve() actually
wants:

	clone(CLONE_FILES | CLONE_VM | CLONE_VFORK)
	child: close_range(lo, hi, CLOSE_RANGE_UNSHARE |
				   CLOSE_RANGE_CLOEXEC_ONLY |
				   CLOSE_RANGE_EXCEPT)
	child: rearrange descriptors in the now private table
	child: execve()

Between the clone and the close_range() the child holds no reference of
its own on any file because copy_files() only bumps the fdtable
refcount. So a close() in the parent takes effect immediately. The
unshare also never takes a reference on the fds it leaves behind either.

The range is expressed in the parent's numbering. So a caller that
cannot name the file descriptors it keeps contiguously picks a range
wide enough to cover them, unshares, and tidies up with a second
close_range() on the table it now owns alone. That one is cheap. To keep
nothing, name a range that cannot hold an open descriptor, e.g.
close_range(~0U, ~0U, ...).

CLOSE_RANGE_CLOEXEC and CLOSE_RANGE_CLOEXEC_ONLY are mutually exclusive.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c                        | 30 +++++++++++++++++++++++++++---
 include/uapi/linux/close_range.h |  5 +++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 8952efd2cf3a..37f0ba740c39 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -843,18 +843,29 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
 	spin_unlock(&cur_fds->file_lock);
 }
 
+/* Next open descriptor in [fd, max_fd], or the next close-on-exec one. */
+static inline unsigned int next_open_fd(struct fdtable *fdt, unsigned int fd,
+					unsigned int max_fd,
+					struct fd_range *range)
+{
+	if (range->flags & FD_RANGE_CLOEXEC_ONLY)
+		return find_next_and_bit(fdt->open_fds, fdt->close_on_exec,
+					 max_fd + 1, fd);
+	return find_next_bit(fdt->open_fds, max_fd + 1, fd);
+}
+
 /* Next open descriptor in [fd, max_fd] that @range selects. */
 static inline unsigned int next_fd_to_close(struct fdtable *fdt,
 					    unsigned int fd, unsigned int max_fd,
 					    struct fd_range *range)
 {
-	fd = find_next_bit(fdt->open_fds, max_fd + 1, fd);
+	fd = next_open_fd(fdt, fd, max_fd, range);
 	/* Hop over the window the range keeps. */
 	if ((range->flags & FD_RANGE_EXCEPT) &&
 	    fd >= range->from && fd <= range->to) {
 		if (range->to >= max_fd)
 			return max_fd + 1;
-		fd = find_next_bit(fdt->open_fds, max_fd + 1, range->to + 1);
+		fd = next_open_fd(fdt, range->to + 1, max_fd, range);
 	}
 	return fd;
 }
@@ -911,6 +922,12 @@ static inline void __range_close(struct files_struct *files,
  * With CLOSE_RANGE_EXCEPT the range names what to leave alone instead:
  * every open file descriptor outside of [@fd, @max_fd] is closed, or
  * marked close-on-exec with CLOSE_RANGE_CLOEXEC.
+ *
+ * With CLOSE_RANGE_CLOEXEC_ONLY only file descriptors that have
+ * close-on-exec set are closed. Together with CLOSE_RANGE_EXCEPT the
+ * range names the close-on-exec file descriptors to keep. To keep none
+ * of them, name a range that cannot hold an open file descriptor, e.g.
+ * close_range(~0U, ~0U, ...).
  */
 SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		unsigned int, flags)
@@ -920,7 +937,12 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 	struct fd_range range = {fd, max_fd};
 
 	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC |
-		      CLOSE_RANGE_EXCEPT))
+		      CLOSE_RANGE_EXCEPT | CLOSE_RANGE_CLOEXEC_ONLY))
+		return -EINVAL;
+
+	/* One marks close-on-exec, the other closes what is marked. */
+	if (hweight32(flags & (CLOSE_RANGE_CLOEXEC |
+			       CLOSE_RANGE_CLOEXEC_ONLY)) > 1)
 		return -EINVAL;
 
 	if (fd > max_fd)
@@ -928,6 +950,8 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 
 	if (flags & CLOSE_RANGE_EXCEPT)
 		range.flags |= FD_RANGE_EXCEPT;
+	if (flags & CLOSE_RANGE_CLOEXEC_ONLY)
+		range.flags |= FD_RANGE_CLOEXEC_ONLY;
 
 	if ((flags & CLOSE_RANGE_UNSHARE) && atomic_read(&cur_fds->count) > 1) {
 		struct fd_range *drop = &range;
diff --git a/include/uapi/linux/close_range.h b/include/uapi/linux/close_range.h
index 39eddb3ab613..7da9ed95258a 100644
--- a/include/uapi/linux/close_range.h
+++ b/include/uapi/linux/close_range.h
@@ -9,6 +9,7 @@
 #undef CLOSE_RANGE_UNSHARE
 #undef CLOSE_RANGE_CLOEXEC
 #undef CLOSE_RANGE_EXCEPT
+#undef CLOSE_RANGE_CLOEXEC_ONLY
 
 enum close_range_flags {
 	/* Unshare the file descriptor table before closing file descriptors. */
@@ -19,12 +20,16 @@ enum close_range_flags {
 
 	/* Act on every file descriptor outside of the given range instead. */
 	CLOSE_RANGE_EXCEPT	= (1U << 3),
+
+	/* Only close file descriptors that have the FD_CLOEXEC bit set. */
+	CLOSE_RANGE_CLOEXEC_ONLY	= (1U << 4),
 };
 
 /* Keep #ifdef working and let glibc skip its own definitions. */
 #define CLOSE_RANGE_UNSHARE		CLOSE_RANGE_UNSHARE
 #define CLOSE_RANGE_CLOEXEC		CLOSE_RANGE_CLOEXEC
 #define CLOSE_RANGE_EXCEPT		CLOSE_RANGE_EXCEPT
+#define CLOSE_RANGE_CLOEXEC_ONLY	CLOSE_RANGE_CLOEXEC_ONLY
 
 #endif /* _UAPI_LINUX_CLOSE_RANGE_H */
 

-- 
2.53.0

