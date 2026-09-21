Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1E2F7EE6
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000164; cv=none; b=uazTNbjgQTNuqkdJfW6yjGnyEHpRqTNxxm7yHvf4GZUgpc5OoMv9TYHNPEiSZUn+k/hef9JvkvGTn5a6dE33gK9KL00wg/mHbeeMzij1uEcaYLvLksHnoixFVAyV6T4XjqFmFSJOk5eR4Q2GjR6geswXw+gwEWQTUJe6S0PN1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000164; c=relaxed/simple;
	bh=LaGKGRJ6s+8YoiZf7OoN/3UIM9PEsgkcuAFhG6X+IJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQiBXUo/L9Vzgq/SImo2YCMz3CRXf/c775vAAb5plFFqea1P1h7+U/xsMPBDrORluP2ty6uy3oNQvd6kkMtiKBUZPRGtmqCuVefmWWILJ3Ee5qacFNyFCZTWnpjcYm2D4bU1oiTzUmfPLeWkeomw0TdOXPzO/SHviZj71ZjLRI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYA7Vog8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYA7Vog8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65C91F00898;
	Mon, 21 Sep 2026 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000160;
	bh=UqpToeeyv35mVbG5u0V8+vW/w6+gaYJoImkqmiQj5HE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fYA7Vog8BmxpWLuFMm2Aq2ziXOvpgQkaGWogueqTz79Ggib05novxzDbZA/V1BrKp
	 VPBV+/07XqeOnFFFfI4RbZQvvPQiBg7NUVgogSrPcYRNt3Wr8g208EiNIx1ELUFyqf
	 obW3CSbKzoNfqUrufrCOcbUa0rhYf2XUx12vnoJO+seDq048FRaIOPT4rIhUaCoau0
	 yT8GF79A3tirYYmpgAY6GxTLgj6EyVF5Pi5S7LpNPnEjuAfPZZbo61CWGAd0hMbaPa
	 VkakH+nl7J1uA2hYqB0/9g+B6rw0gRMyH6Mj12oPE864rBx2jbkxiatVknT8jgbSDK
	 t1VeG7OiuWKyw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:34 +0200
Subject: [PATCH 06/10] file: add CLOSE_RANGE_EXCEPT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-6-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=6475; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LaGKGRJ6s+8YoiZf7OoN/3UIM9PEsgkcuAFhG6X+IJQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOF5zbhVPOpw47mm1jURVTtEhYIu5ShJegqd9Fx8p
 SfnbZ9tRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQcuRn+Z7iUqe5vYOv9K6G9
 5u4394UX9p5oelB5VvHAKj9W1wbRtYwMl54tuiAa/vow+0SjTSnfWRVif/YUdgYwlZb98hSf1yn
 ECwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

close_range() operates on [fd, max_fd]. Add CLOSE_RANGE_EXCEPT. This new
flag instructs it to operate on all file descriptors outside of the
range instead.

Without any other flags that means it closes everything except the file
descriptors in the specified range. Together with CLOSE_RANGE_CLOEXEC it
marks every file descriptor except the ones in the range as
close-on-exec. With CLOSE_RANGE_UNSHARE dup_fd() never takes a reference
on what is dropped.

A task between clone(CLONE_FILES | CLONE_VM | CLONE_VFORK) and execve()
that has the descriptors for the child in one window can shed the rest
of the shared table in one call:

	close_range(lo, hi, CLOSE_RANGE_UNSHARE | CLOSE_RANGE_EXCEPT)

Nothing outside of the window is referenced by the child at any point.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c                        | 76 +++++++++++++++++++++++++++++++---------
 include/uapi/linux/close_range.h |  5 +++
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index ae7d021398dd..39651c7a992e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -794,34 +794,67 @@ static inline unsigned last_fd(struct fdtable *fdt)
 }
 
 static inline void __range_cloexec(struct files_struct *cur_fds,
-				   unsigned int fd, unsigned int max_fd)
+				   struct fd_range *range)
 {
 	struct fdtable *fdt;
+	unsigned int last;
 
-	/* make sure we're using the correct maximum value */
 	spin_lock(&cur_fds->file_lock);
 	fdt = files_fdtable(cur_fds);
-	max_fd = min(last_fd(fdt), max_fd);
-	if (fd <= max_fd)
-		bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
+	/* make sure we're using the correct maximum value */
+	last = last_fd(fdt);
+	if (!(range->flags & FD_RANGE_EXCEPT)) {
+		if (range->from <= last)
+			bitmap_set(fdt->close_on_exec, range->from,
+				   min(range->to, last) - range->from + 1);
+	} else {
+		if (range->from > 0)
+			bitmap_set(fdt->close_on_exec, 0,
+				   min(range->from - 1, last) + 1);
+		if (range->to < last)
+			bitmap_set(fdt->close_on_exec, range->to + 1,
+				   last - range->to);
+	}
 	spin_unlock(&cur_fds->file_lock);
 }
 
-static inline void __range_close(struct files_struct *files, unsigned int fd,
-				 unsigned int max_fd)
+/* Next open descriptor in [fd, max_fd] that @range selects. */
+static inline unsigned int next_fd_to_close(struct fdtable *fdt,
+					    unsigned int fd, unsigned int max_fd,
+					    struct fd_range *range)
+{
+	fd = find_next_bit(fdt->open_fds, max_fd + 1, fd);
+	/* Hop over the window the range keeps. */
+	if ((range->flags & FD_RANGE_EXCEPT) &&
+	    fd >= range->from && fd <= range->to) {
+		if (range->to >= max_fd)
+			return max_fd + 1;
+		fd = find_next_bit(fdt->open_fds, max_fd + 1, range->to + 1);
+	}
+	return fd;
+}
+
+static inline void __range_close(struct files_struct *files,
+				 struct fd_range *range)
 {
 	struct file *file;
 	struct fdtable *fdt;
-	unsigned n;
+	unsigned int fd, max_fd;
 
 	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
-	n = last_fd(fdt);
-	max_fd = min(max_fd, n);
+	if (range->flags & FD_RANGE_EXCEPT) {
+		/* Outside of the range means the whole table. */
+		fd = 0;
+		max_fd = last_fd(fdt);
+	} else {
+		fd = range->from;
+		max_fd = min(range->to, last_fd(fdt));
+	}
 
-	for (fd = find_next_bit(fdt->open_fds, max_fd + 1, fd);
+	for (fd = next_fd_to_close(fdt, fd, max_fd, range);
 	     fd <= max_fd;
-	     fd = find_next_bit(fdt->open_fds, max_fd + 1, fd + 1)) {
+	     fd = next_fd_to_close(fdt, fd + 1, max_fd, range)) {
 		file = file_close_fd_locked(files, fd);
 		if (file) {
 			spin_unlock(&files->file_lock);
@@ -849,21 +882,30 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
  * This closes a range of file descriptors. All file descriptors
  * from @fd up to and including @max_fd are closed.
  * Currently, errors to close a given file descriptor are ignored.
+ *
+ * With CLOSE_RANGE_EXCEPT the range names what to leave alone instead:
+ * every open file descriptor outside of [@fd, @max_fd] is closed, or
+ * marked close-on-exec with CLOSE_RANGE_CLOEXEC.
  */
 SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		unsigned int, flags)
 {
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
+	struct fd_range range = {fd, max_fd};
 
-	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))
+	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC |
+		      CLOSE_RANGE_EXCEPT))
 		return -EINVAL;
 
 	if (fd > max_fd)
 		return -EINVAL;
 
+	if (flags & CLOSE_RANGE_EXCEPT)
+		range.flags |= FD_RANGE_EXCEPT;
+
 	if ((flags & CLOSE_RANGE_UNSHARE) && atomic_read(&cur_fds->count) > 1) {
-		struct fd_range range = {fd, max_fd}, *drop = &range;
+		struct fd_range *drop = &range;
 
 		/*
 		 * If the caller requested all fds to be made cloexec we always
@@ -884,10 +926,10 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 	}
 
 	if (flags & CLOSE_RANGE_CLOEXEC) {
-		__range_cloexec(cur_fds, fd, max_fd);
+		__range_cloexec(cur_fds, &range);
 	} else if (!fds) {
-		/* If we unshared, dup_fd() left the range behind already. */
-		__range_close(cur_fds, fd, max_fd);
+		/* If we unshared, dup_fd() already left behind what we'd close. */
+		__range_close(cur_fds, &range);
 	}
 
 	if (fds) {
diff --git a/include/uapi/linux/close_range.h b/include/uapi/linux/close_range.h
index b1b637d74deb..39eddb3ab613 100644
--- a/include/uapi/linux/close_range.h
+++ b/include/uapi/linux/close_range.h
@@ -8,6 +8,7 @@
  */
 #undef CLOSE_RANGE_UNSHARE
 #undef CLOSE_RANGE_CLOEXEC
+#undef CLOSE_RANGE_EXCEPT
 
 enum close_range_flags {
 	/* Unshare the file descriptor table before closing file descriptors. */
@@ -15,11 +16,15 @@ enum close_range_flags {
 
 	/* Set the FD_CLOEXEC bit instead of closing the file descriptor. */
 	CLOSE_RANGE_CLOEXEC	= (1U << 2),
+
+	/* Act on every file descriptor outside of the given range instead. */
+	CLOSE_RANGE_EXCEPT	= (1U << 3),
 };
 
 /* Keep #ifdef working and let glibc skip its own definitions. */
 #define CLOSE_RANGE_UNSHARE		CLOSE_RANGE_UNSHARE
 #define CLOSE_RANGE_CLOEXEC		CLOSE_RANGE_CLOEXEC
+#define CLOSE_RANGE_EXCEPT		CLOSE_RANGE_EXCEPT
 
 #endif /* _UAPI_LINUX_CLOSE_RANGE_H */
 

-- 
2.53.0

