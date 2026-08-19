Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C563EC827;
	Wed, 19 Aug 2026 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181090; cv=none; b=k3uvxHO/Zze8vrXEJxsvTEL4Rwb4wnfOr59B4bnA0NPCX015yfzV3Hxo7zwkO+RMEQcDRpZv0tz2iitzxIEmPr9hYL4BBTzG5BDGhXhpEIkF50q6RQHYE1ETn9QhhpwU+d/Yn09gee2Nib++TMflaoyPpRzoe7iSBlGk5XzwORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181090; c=relaxed/simple;
	bh=fLCd3nX85Kl5v4I7veEWt3TUxuM0itj+Qxbh/MwEbIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRnNQmcgIZQXOQvF4iOJbISgQXG2j5N9d09hBUYow7+Ea5Hndlp3xxiHPf2HZcqigxgSoFuXzk8husGPzM6UZRLucdIaJIAqflYeEGpMBA40UKyKhbu7s1IHhUFb/EMwT1H1/C91ZujzvL1rMREuPs+Ea3TKocrNrRhaKIXWTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVpSlSgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVpSlSgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A6C1F00A3A;
	Wed, 19 Aug 2026 23:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181088;
	bh=wM6UYdp4ENAt/t8VPqpPdoKC+M8ulkEt5gJ+Zk4P9vs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bVpSlSgx86lMoZ5Yd3z4XU8Ya8S2BLCjAmTLSRZgZS/Swh7zPtIm2bQmwlyGFM4a5
	 XULsmIxOPMQkecPEBlgCHYq/KENCy1wWxRj2/fQbLyvB4mENTZa44Fu/d566nDin/+
	 jJjrfoBpXN9EU5t37weOxys0TJHMcVnKAIgn/rmbaGk8hCZIGoTXSm6vOhFydTAylI
	 mnj8X/HdkAfrCrFNptFFBszb5IMS9pe0vZ2VaMCMCdrpcKoyS0/gJR09MSAaZatJJY
	 vmoEkvVU23ub0o5m8rFA2FoZI4wUre0pr40/C8ZALZGxqIGCK/95YY/6ulNrbFkz43
	 FJPQv282yxrqg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:33 +0200
Subject: [PATCH v2 16/22] coredump: send the coredump in records if
 requested
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-16-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10247; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fLCd3nX85Kl5v4I7veEWt3TUxuM0itj+Qxbh/MwEbIc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+/131bKUPoUnjnNq5z0+4160V84TD5Lqi66XzM6
 hM+i451dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEZTnDb7a1bT8Yu3N2bLEQ
 Ei5++4L18ywT4QCF7eLVlz+suc2Uy8fwT3dV+RJ7zUe7c65fvnr11/MPoSmb/ydxJ9TH3DeXn9k
 8iQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When the coredump server raises COREDUMP_RECORDS send the coredump in
records. A record consists of a struct coredump_record_header and data.
A header and the bytes it describes go out in one iovec.

A hole is flushed through __dump_emit() like before. So zeroes still are
sent on the socket as actual data records. Making holes cheap is
COREDUMP_SPARSE's job.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                                      | 150 +++++++++++++++++----
 include/linux/coredump.h                           |   5 +
 .../selftests/coredump/coredump_test_helpers.c     |   2 +-
 3 files changed, 127 insertions(+), 30 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 6af3ff0e19a6..b1679930094c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -51,7 +51,6 @@
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 #include <uapi/linux/un.h>
-#include <uapi/linux/coredump.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -68,6 +67,7 @@
 
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
+static void dump_end_record(struct coredump_params *cprm);
 
 #define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
 /* Define a reasonable max cap */
@@ -661,6 +661,8 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
+static_assert(sizeof(struct coredump_record_header) == COREDUMP_RECORD_HEADER_SIZE_VER0);
+
 #ifdef CONFIG_UNIX
 /* af_unix halves the send buffer to size a single skb. */
 #define COREDUMP_SOCK_SNDBUF_MIN (3 * PAGE_SIZE)
@@ -803,7 +805,8 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 	struct coredump_req req = {
 		.size		= sizeof(struct coredump_req),
 		.mask		= COREDUMP_KERNEL | COREDUMP_USERSPACE |
-				  COREDUMP_REJECT | COREDUMP_WAIT,
+				  COREDUMP_REJECT | COREDUMP_WAIT |
+				  COREDUMP_RECORDS,
 		.size_ack	= sizeof(struct coredump_ack),
 	};
 	struct coredump_ack ack = {};
@@ -857,6 +860,19 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
+	/* Records only describe a coredump the kernel writes. */
+	if ((ack.mask & COREDUMP_RECORDS) && !(ack.mask & COREDUMP_KERNEL)) {
+		coredump_sock_mark(cprm->file, COREDUMP_MARK_CONFLICTING);
+		return false;
+	}
+
+	/* Record header scratch; a bvec can't point at the stack. */
+	if (ack.mask & COREDUMP_RECORDS) {
+		cprm->record_hdr = kmalloc_obj(*cprm->record_hdr);
+		if (!cprm->record_hdr)
+			return false;
+	}
+
 	cprm->mask = ack.mask;
 	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 }
@@ -1046,7 +1062,6 @@ static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
 static bool coredump_write(struct coredump_params *cprm,
 			   const struct linux_binfmt *binfmt)
 {
-
 	if (dump_interrupted()) {
 		cprm->state |= COREDUMP_STATE_TRUNCATED;
 		return true;
@@ -1062,15 +1077,17 @@ static bool coredump_write(struct coredump_params *cprm,
 		cprm->state |= COREDUMP_STATE_TRUNCATED;
 	/*
 	 * Ensures that file size is big enough to contain the current
-	 * file postion. This prevents gdb from complaining about
+	 * file position. This prevents gdb from complaining about
 	 * a truncated file if the last "write" to the file was
-	 * dump_skip.
+	 * dump_skip. A record stream relies on it too: the flush
+	 * emits the records that cover a trailing hole.
 	 */
 	if (cprm->to_skip) {
 		cprm->to_skip--;
 		if (!dump_emit(cprm, "", 1))
 			cprm->state |= COREDUMP_STATE_TRUNCATED;
 	}
+	dump_end_record(cprm);
 	file_end_write(cprm->file);
 	free_vma_snapshot(cprm);
 	return true;
@@ -1085,6 +1102,7 @@ static void coredump_cleanup(struct core_name *cn, struct coredump_params *cprm)
 		atomic_dec(&core_pipe_count);
 	}
 	kfree(cn->corename);
+	kfree(cprm->record_hdr);
 	coredump_finish(cprm->state);
 }
 
@@ -1218,26 +1236,74 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
  * do on a core-file: use only these functions to write out all the
  * necessary info.
  */
-/* One write, never more than a page. See __dump_emit(). */
-static bool dump_emit_chunk(struct coredump_params *cprm, const void *addr,
-			    int nr)
+static bool dump_records(const struct coredump_params *cprm)
+{
+	return cprm->mask & COREDUMP_RECORDS;
+}
+
+/* Describe the next @len bytes of the coredump. Returns the header size. */
+static size_t dump_record_init(struct coredump_params *cprm,
+			       enum coredump_record_type type, u64 flags,
+			       u64 len)
+{
+	if (!dump_records(cprm))
+		return 0;
+
+	*cprm->record_hdr = (struct coredump_record_header) {
+		.size	= sizeof(*cprm->record_hdr),
+		.type	= type,
+		.flags	= flags,
+		.offset	= cprm->pos,
+		.len	= len,
+	};
+
+	return sizeof(*cprm->record_hdr);
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
 
-	if (dump_interrupted())
+	n = __kernel_write_iter(file, iter, &pos);
+	if (n != (ssize_t)count)
 		return false;
+	file->f_pos = pos;
+	cprm->written += count;
+	cprm->pos += len;
+
+	return true;
+}
+
+/* One record, never more than a page. See __dump_emit(). */
+static bool dump_emit_chunk(struct coredump_params *cprm, const void *addr,
+			    int nr)
+{
+	struct kvec kvec[2];
+	struct iov_iter iter;
+	unsigned int nseg = 0;
+	size_t hdrlen;
 
-	n = __kernel_write(file, addr, nr, &pos);
-	if (n != nr)
+	if (dump_interrupted())
 		return false;
 
-	file->f_pos = pos;
-	cprm->written += n;
-	cprm->pos += n;
+	hdrlen = dump_record_init(cprm, COREDUMP_RECORD_DATA, 0, nr);
+	if (hdrlen) {
+		kvec[nseg].iov_base = cprm->record_hdr;
+		kvec[nseg].iov_len = hdrlen;
+		nseg++;
+	}
+	kvec[nseg].iov_base = (void *)addr;
+	kvec[nseg].iov_len = nr;
+	nseg++;
 
-	return true;
+	iov_iter_kvec(&iter, ITER_SOURCE, kvec, nseg, hdrlen + nr);
+
+	return dump_write_iter(cprm, &iter, nr);
 }
 
 static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
@@ -1258,6 +1324,34 @@ static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	return true;
 }
 
+/* Send a record that stands on its own: a header and nothing else. */
+static bool dump_emit_record(struct coredump_params *cprm,
+			     enum coredump_record_type type, u64 flags, u64 len)
+{
+	struct kvec kvec;
+	struct iov_iter iter;
+	size_t hdrlen;
+
+	hdrlen = dump_record_init(cprm, type, flags, len);
+	if (!hdrlen)
+		return false;
+
+	kvec.iov_base = cprm->record_hdr;
+	kvec.iov_len = hdrlen;
+	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, hdrlen);
+
+	return dump_write_iter(cprm, &iter, len);
+}
+
+/* Close the record stream. Only a whole coredump gets an end record. */
+static void dump_end_record(struct coredump_params *cprm)
+{
+	if (cprm->state & COREDUMP_STATE_TRUNCATED)
+		return;
+
+	dump_emit_record(cprm, COREDUMP_RECORD_END, 0, 0);
+}
+
 static bool __dump_skip(struct coredump_params *cprm, size_t nr)
 {
 	static char zeroes[PAGE_SIZE];
@@ -1318,11 +1412,10 @@ EXPORT_SYMBOL(dump_skip);
 #ifdef CONFIG_ELF_CORE
 static bool dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
-	struct bio_vec bvec;
+	struct bio_vec bvec[2];
 	struct iov_iter iter;
-	struct file *file = cprm->file;
-	loff_t pos;
-	ssize_t n;
+	unsigned int nseg = 0;
+	size_t hdrlen;
 
 	if (!page)
 		return false;
@@ -1333,17 +1426,16 @@ static bool dump_emit_page(struct coredump_params *cprm, struct page *page)
 		return false;
 	if (dump_interrupted())
 		return false;
-	pos = file->f_pos;
-	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
-	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
-	n = __kernel_write_iter(cprm->file, &iter, &pos);
-	if (n != PAGE_SIZE)
-		return false;
-	file->f_pos = pos;
-	cprm->written += PAGE_SIZE;
-	cprm->pos += PAGE_SIZE;
 
-	return true;
+	/* Hand the record header to the same write as the page it describes. */
+	hdrlen = dump_record_init(cprm, COREDUMP_RECORD_DATA, 0, PAGE_SIZE);
+	if (hdrlen)
+		bvec_set_virt(&bvec[nseg++], cprm->record_hdr, hdrlen);
+	bvec_set_page(&bvec[nseg++], page, PAGE_SIZE, 0);
+
+	iov_iter_bvec(&iter, ITER_SOURCE, bvec, nseg, hdrlen + PAGE_SIZE);
+
+	return dump_write_iter(cprm, &iter, PAGE_SIZE);
 }
 
 /*
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 709388dd5659..b252bb2843b3 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/sched/coredump.h>
+#include <uapi/linux/coredump.h>
 #include <asm/siginfo.h>
 
 #ifdef CONFIG_COREDUMP
@@ -40,7 +41,11 @@ struct coredump_params {
 	u64 mask;
 	/* COREDUMP_STATE_* raised while the coredump is written. */
 	enum coredump_state state;
+	/* Record header scratch, NULL unless the coredump is a record stream. */
+	struct coredump_record_header *record_hdr;
+	/* Bytes handed to the file, record headers included. */
 	loff_t written;
+	/* Offset in the coredump, record headers excluded. */
 	loff_t pos;
 	loff_t to_skip;
 	int vma_count;
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 570fc2e005c2..1c8658f35735 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -275,7 +275,7 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
 /* Every option the kernel is expected to advertise in coredump_req->mask. */
 #define TEST_REQ_MASK_ALL					\
 	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
-	 COREDUMP_REJECT | COREDUMP_WAIT)
+	 COREDUMP_REJECT | COREDUMP_WAIT | COREDUMP_RECORDS)
 
 bool check_coredump_req(const struct coredump_req *req)
 {

-- 
2.53.0

