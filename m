Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87003C3448;
	Tue, 11 Aug 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462097; cv=none; b=lXJNfKid1MTtEkon3732NTPRnXaV3zbYh8UfPaPTq3jqHzee/IZP4WUPsumeOYyIxnt6ERlgHHP0Wj+CcBUkokAlNL1dF402M3Sm5nZt00xbAx4spSBMCDkh82kAHmKHcDnauo7GcPi7y+rIYjvTNhuBovissQM+kc/nyJbwKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462097; c=relaxed/simple;
	bh=alEfNKjHn75QOeONKfhCSgPaz/2H5W5/8cuW6aJdyZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJ6e9ulMMeSh1fY3rPysTW30Up1/qmtIAD7LzFOAEwU3/I2X1zTXAm0HT7QUY5mkZakvJ+hpdu9CQzair+EsgzvTyQ2cMlUl9zIsOgergPuVy3eR5PffXO9MaCR5Vty2ZAzDjD8qGA6YHrpTMOhmTSh6JMgxOV8/wUdJGc7uQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF/KLJqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF/KLJqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DC01F00A3E;
	Tue, 11 Aug 2026 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462095;
	bh=ZOqbnGTbnp8gHK6gI4lu72AVOFkLmNDTl8IC1onEIFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eF/KLJqRJGBst06e6C09PM+yqAMHmRoRME4BL7t2AF7HxY8Y4WMou9G9aog8WAQll
	 ptoyGUxzKNoa2kXWg+luR6QhNOUTiB7vK7ha0h2McMxVjGVxqPLQwy0qMI4uTMJ1Mq
	 fxMUQ0mBDoVNBdccfoGYnHaT5DOFMa+8+dLS8peHVQR3t7mEDG5qc8OVwyPL5yu5nf
	 YUNyngbRaq7/hdLICTLZhDJnuIfdsoHARVo4IWN47u6eAhj4bdKmLVFDKyGGmcQc/X
	 VczGSgwr+TU5uv3rSlVyl5iR8SitbIGyZgXPnzZXOBwy7WelKEFDzLA4Z2uHdqin+t
	 FQ63P2VPDKrTA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:30 +0200
Subject: [PATCH 09/11] coredump: frame the coredump when COREDUMP_HEADER is
 negotiated
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-9-cd3e8b1e356d@kernel.org>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
In-Reply-To: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
To: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8790; i=brauner@kernel.org;
 h=from:subject:message-id; bh=alEfNKjHn75QOeONKfhCSgPaz/2H5W5/8cuW6aJdyZA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2ycozdPZe3pK4SHVCas4dMtErBN2bOoqXZy2cMlap
 4SX3EkpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJOMbwP+aWUXSxe4/lmh4W
 1i+PhXL7xVWPC+wqV9nS/FC0w6X9PMP/Irnb0UXWVmKqC3/1fpkpMtOUTddEo+9svfjVjzo5pxn
 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When the coredump server raises COREDUMP_HEADER every write to the
socket is prefixed with a struct coredump_frame_header in front of it
describing what follows. A header and the bytes it describes go out in
one iovec.

Both emitters write through one helper that either writes the whole
iov_iter or fails. So a single place advances the file position.
cprm->pos stays the offset in the coredump and keeps ignoring the
framing overhead. dump_skip_to() and dump_align() compute from
it. cprm->written counts what was handed to the file and so picks the
headers up. The two are the same number when the coredump isn't framed.

A hole is flushed through __dump_emit() like before. So zeroes still are
sent on the socket as actual data frames. Making holes cheap is
COREDUMP_SPARSE's job.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                                      | 114 ++++++++++++++++-----
 include/linux/coredump.h                           |   5 +
 .../selftests/coredump/coredump_test_helpers.c     |   2 +-
 3 files changed, 94 insertions(+), 27 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 6de18bc49925..364c89c5f82a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -51,7 +51,6 @@
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 #include <uapi/linux/un.h>
-#include <uapi/linux/coredump.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -753,6 +752,7 @@ static inline bool coredump_sock_send(struct file *file, struct coredump_req *re
 
 static_assert(sizeof(struct coredump_req) == COREDUMP_REQ_SIZE_VER0);
 static_assert(sizeof(struct coredump_ack) == COREDUMP_ACK_SIZE_VER0);
+static_assert(sizeof(struct coredump_frame_header) == COREDUMP_FRAME_HEADER_SIZE_VER0);
 static_assert(sizeof(enum coredump_mark) == sizeof(__u32));
 
 static inline bool coredump_sock_mark(struct file *file, enum coredump_mark mark)
@@ -798,7 +798,8 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 	struct coredump_req req = {
 		.size		= sizeof(struct coredump_req),
 		.mask		= COREDUMP_KERNEL | COREDUMP_USERSPACE |
-				  COREDUMP_REJECT | COREDUMP_WAIT,
+				  COREDUMP_REJECT | COREDUMP_WAIT |
+				  COREDUMP_HEADER,
 		.size_ack	= sizeof(struct coredump_ack),
 	};
 	struct coredump_ack ack = {};
@@ -847,11 +848,24 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
+	/* Framing only applies to a coredump the kernel writes. */
+	if ((ack.mask & COREDUMP_HEADER) && !(ack.mask & COREDUMP_KERNEL)) {
+		coredump_sock_mark(cprm->file, COREDUMP_MARK_CONFLICTING);
+		return false;
+	}
+
 	if (ack.spare) {
 		coredump_sock_mark(cprm->file, COREDUMP_MARK_UNSUPPORTED);
 		return false;
 	}
 
+	/* Frame header scratch; a bvec can't point at the stack. */
+	if (ack.mask & COREDUMP_HEADER) {
+		cprm->frame = kmalloc_obj(*cprm->frame);
+		if (!cprm->frame)
+			return false;
+	}
+
 	cprm->mask = ack.mask;
 	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 }
@@ -1053,9 +1067,10 @@ static bool coredump_write(struct core_name *cn,
 	cn->core_dumped = binfmt->core_dump(cprm);
 	/*
 	 * Ensures that file size is big enough to contain the current
-	 * file postion. This prevents gdb from complaining about
+	 * file position. This prevents gdb from complaining about
 	 * a truncated file if the last "write" to the file was
-	 * dump_skip.
+	 * dump_skip. A framed coredump relies on it too: the flush
+	 * emits the frames that cover a trailing hole.
 	 */
 	if (cprm->to_skip) {
 		cprm->to_skip--;
@@ -1075,6 +1090,7 @@ static void coredump_cleanup(struct core_name *cn, struct coredump_params *cprm)
 		atomic_dec(&core_pipe_count);
 	}
 	kfree(cn->corename);
+	kfree(cprm->frame);
 	coredump_finish(cn->core_dumped);
 }
 
@@ -1208,24 +1224,72 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
  * do on a core-file: use only these functions to write out all the
  * necessary info.
  */
-static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+static bool dump_framed(const struct coredump_params *cprm)
+{
+	return cprm->mask & COREDUMP_HEADER;
+}
+
+/* Describe the next @len bytes of the coredump. Returns the header size. */
+static size_t dump_frame_init(struct coredump_params *cprm,
+			      enum coredump_frame_type type, u64 len)
+{
+	if (!dump_framed(cprm))
+		return 0;
+
+	*cprm->frame = (struct coredump_frame_header) {
+		.size	= sizeof(*cprm->frame),
+		.type	= type,
+		.offset	= cprm->pos,
+		.len	= len,
+	};
+
+	return sizeof(*cprm->frame);
+}
+
+/* Write @iter whole or fail. @len is what it advances the coredump by. */
+static bool dump_write_iter(struct coredump_params *cprm, struct iov_iter *iter,
+			    size_t len)
 {
 	struct file *file = cprm->file;
+	size_t count = iov_iter_count(iter);
 	loff_t pos = file->f_pos;
 	ssize_t n;
 
+	n = __kernel_write_iter(file, iter, &pos);
+	if (n < 0 || (size_t)n != count)
+		return false;
+	file->f_pos = pos;
+	cprm->written += count;
+	cprm->pos += len;
+
+	return true;
+}
+
+static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+{
+	struct kvec kvec[2];
+	struct iov_iter iter;
+	unsigned int nseg = 0;
+	size_t hdr;
+
 	if (cprm->written + nr > cprm->limit)
 		return 0;
 	if (dump_interrupted())
 		return 0;
-	n = __kernel_write(file, addr, nr, &pos);
-	if (n != nr)
-		return 0;
-	file->f_pos = pos;
-	cprm->written += n;
-	cprm->pos += n;
 
-	return 1;
+	hdr = dump_frame_init(cprm, COREDUMP_FRAME_DATA, nr);
+	if (hdr) {
+		kvec[nseg].iov_base = cprm->frame;
+		kvec[nseg].iov_len = hdr;
+		nseg++;
+	}
+	kvec[nseg].iov_base = (void *)addr;
+	kvec[nseg].iov_len = nr;
+	nseg++;
+
+	iov_iter_kvec(&iter, ITER_SOURCE, kvec, nseg, hdr + nr);
+
+	return dump_write_iter(cprm, &iter, nr);
 }
 
 static int __dump_skip(struct coredump_params *cprm, size_t nr)
@@ -1283,11 +1347,10 @@ EXPORT_SYMBOL(dump_skip);
 #ifdef CONFIG_ELF_CORE
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
-	struct bio_vec bvec;
+	struct bio_vec bvec[2];
 	struct iov_iter iter;
-	struct file *file = cprm->file;
-	loff_t pos;
-	ssize_t n;
+	unsigned int nseg = 0;
+	size_t hdr;
 
 	if (!page)
 		return 0;
@@ -1298,17 +1361,16 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 		return 0;
 	if (dump_interrupted())
 		return 0;
-	pos = file->f_pos;
-	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
-	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
-	n = __kernel_write_iter(cprm->file, &iter, &pos);
-	if (n != PAGE_SIZE)
-		return 0;
-	file->f_pos = pos;
-	cprm->written += PAGE_SIZE;
-	cprm->pos += PAGE_SIZE;
 
-	return 1;
+	/* Hand the frame to the same write as the page it describes. */
+	hdr = dump_frame_init(cprm, COREDUMP_FRAME_DATA, PAGE_SIZE);
+	if (hdr)
+		bvec_set_virt(&bvec[nseg++], cprm->frame, hdr);
+	bvec_set_page(&bvec[nseg++], page, PAGE_SIZE, 0);
+
+	iov_iter_bvec(&iter, ITER_SOURCE, bvec, nseg, hdr + PAGE_SIZE);
+
+	return dump_write_iter(cprm, &iter, PAGE_SIZE);
 }
 
 /*
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index dc7a05b1bb0a..06ccd3046a06 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/sched/coredump.h>
+#include <uapi/linux/coredump.h>
 #include <asm/siginfo.h>
 
 #ifdef CONFIG_COREDUMP
@@ -28,7 +29,11 @@ struct coredump_params {
 	int cpu;
 	/* COREDUMP_* options negotiated with the coredump server. */
 	u64 mask;
+	/* Frame header scratch, NULL unless the coredump is framed. */
+	struct coredump_frame_header *frame;
+	/* Bytes handed to the file, frame headers included. */
 	loff_t written;
+	/* Offset in the coredump, frame headers excluded. */
 	loff_t pos;
 	loff_t to_skip;
 	int vma_count;
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index d32d96436779..bfe10bc51618 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -290,7 +290,7 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
 /* Every option the kernel is expected to advertise in coredump_req->mask. */
 #define COREDUMP_REQ_MASK_ALL					\
 	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
-	 COREDUMP_REJECT | COREDUMP_WAIT)
+	 COREDUMP_REJECT | COREDUMP_WAIT | COREDUMP_HEADER)
 
 bool check_coredump_req(const struct coredump_req *req)
 {

-- 
2.53.0

