Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBD3EA976;
	Wed, 19 Aug 2026 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181095; cv=none; b=thl+KRa2sUv0eaorsF0AV9sEBxNv1W0y/wscvHgK3KyNYLuUDTcWp3EI4fr4AAcZ3XRzywaVAhB9PGNHExXV4btP3VF3tWRhZC24chrFu0H4P9mZ3B8JDSvKPZCum9l3sGd+NbddR2UC99qkjOliwTKDfCuu8QDbdKt0UGawiSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181095; c=relaxed/simple;
	bh=SaaeoMeiN9Mzcytct1cOKja7m2Y3FzATAK/meN2hUkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0kv8ob6+1iu8zxbnC17Ss55HcD5VO8nJn1+Llo+POTQWNJNHPCawlDjuspxnRU4VlZiUa+3bPx3/ZW4LhQeSr/XZNkdYjkAlnbxloiHphmUHctcBjcr7ft+xV2fOGrZir8tZxhTb4yw5p+P+oC2ae99OVdRFALmybsmtmxay4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/gkZ57m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/gkZ57m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3351F000E9;
	Wed, 19 Aug 2026 23:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181094;
	bh=72gFO+JEMFm/mE5KyMl3szngZahRJUcU2+ZTWkuKUzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l/gkZ57m6x0MVqexlIB/w3JhkEQ/mTP5nyLhU30ic1zHxAyQpA+y+AVskrHJNhiWL
	 SI2jlxBw1EjdpadUcI/2A7P8ClVic3G3yU1pobKVs/z5WXqAjKd4IdFfkSWWCM6h6Q
	 gABt5r1yAPuoRGCmxDtpQ/1Y4zl4lgYSUaQBbpMdeMQiTN/zx4rXCp1j6VuKKU73Go
	 bomiUP0HgV4440yO+vYhzrgBbGT2GMZE+iJhtzEq0RnQoCRguvwdYV2qkC58iZfyZ1
	 NxsO7LrU+v7+V4jutQEHM5GJ/MMyOXp4cjQg6nVnOrDFHGiB7iIIkE6sktM2WpceL3
	 Y4sF9a5Hopcog==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:34 +0200
Subject: [PATCH v2 17/22] coredump: describe the holes when COREDUMP_SPARSE
 is negotiated
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-17-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4977; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SaaeoMeiN9Mzcytct1cOKja7m2Y3FzATAK/meN2hUkQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+PdVFZciP6KiOziPLkjCPrt4aY2OkX5d9iajx34
 WHpM9v0jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMWM/I8Ko0T+d2zco97zmF
 vm1mDJ1xNqjz4AbuFR6Feh1RpamLORkZVrqnlC9Qy/36LDrokmhKV7HBSe1XSXxH/U5vuqau7ri
 UCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make use of COREDUMP_SPARSE. Refuse it without COREDUMP_RECORDS.

Actual holes are sent as a record with length indicating how much zero
data there was.

coredump_write() flushes a trailing hole if the coredump is done.
Instead of writing the actual byte for pipes and sockets, collapse it.
This stops wasting a header with coredump records for a single byte. So
we now only write it when the coredump can be seeked. TL;DR a trailing
hole is a zero record like any other and the records still cover the
whole coredump.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                                      | 41 +++++++++++++++++-----
 .../selftests/coredump/coredump_test_helpers.c     |  3 +-
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b1679930094c..7b568d25887c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -68,6 +68,7 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
 static void dump_end_record(struct coredump_params *cprm);
+static bool dump_flush_skip(struct coredump_params *cprm);
 
 #define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
 /* Define a reasonable max cap */
@@ -806,7 +807,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		.size		= sizeof(struct coredump_req),
 		.mask		= COREDUMP_KERNEL | COREDUMP_USERSPACE |
 				  COREDUMP_REJECT | COREDUMP_WAIT |
-				  COREDUMP_RECORDS,
+				  COREDUMP_RECORDS | COREDUMP_SPARSE,
 		.size_ack	= sizeof(struct coredump_ack),
 	};
 	struct coredump_ack ack = {};
@@ -866,6 +867,12 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
+	/* Zero records only exist inside a record stream. */
+	if ((ack.mask & COREDUMP_SPARSE) && !(ack.mask & COREDUMP_RECORDS)) {
+		coredump_sock_mark(cprm->file, COREDUMP_MARK_CONFLICTING);
+		return false;
+	}
+
 	/* Record header scratch; a bvec can't point at the stack. */
 	if (ack.mask & COREDUMP_RECORDS) {
 		cprm->record_hdr = kmalloc_obj(*cprm->record_hdr);
@@ -1076,15 +1083,21 @@ static bool coredump_write(struct coredump_params *cprm,
 	if (!binfmt->core_dump(cprm))
 		cprm->state |= COREDUMP_STATE_TRUNCATED;
 	/*
-	 * Ensures that file size is big enough to contain the current
-	 * file position. This prevents gdb from complaining about
-	 * a truncated file if the last "write" to the file was
-	 * dump_skip. A record stream relies on it too: the flush
-	 * emits the records that cover a trailing hole.
+	 * A trailing hole still has to land in the coredump. Seeking over
+	 * it doesn't grow the file, so the last byte of it is written
+	 * instead and gdb doesn't see a truncated file. Everything else
+	 * puts the hole on the wire as it flushes it.
 	 */
 	if (cprm->to_skip) {
-		cprm->to_skip--;
-		if (!dump_emit(cprm, "", 1))
+		bool flushed;
+
+		if (cprm->file->f_mode & FMODE_LSEEK) {
+			cprm->to_skip--;
+			flushed = dump_emit(cprm, "", 1);
+		} else {
+			flushed = dump_flush_skip(cprm);
+		}
+		if (!flushed)
 			cprm->state |= COREDUMP_STATE_TRUNCATED;
 	}
 	dump_end_record(cprm);
@@ -1241,6 +1254,11 @@ static bool dump_records(const struct coredump_params *cprm)
 	return cprm->mask & COREDUMP_RECORDS;
 }
 
+static bool dump_sparse(const struct coredump_params *cprm)
+{
+	return cprm->mask & COREDUMP_SPARSE;
+}
+
 /* Describe the next @len bytes of the coredump. Returns the header size. */
 static size_t dump_record_init(struct coredump_params *cprm,
 			       enum coredump_record_type type, u64 flags,
@@ -1357,6 +1375,13 @@ static bool __dump_skip(struct coredump_params *cprm, size_t nr)
 	static char zeroes[PAGE_SIZE];
 	struct file *file = cprm->file;
 
+	if (dump_sparse(cprm)) {
+		/* Hand the server the length of the hole instead of the hole itself. */
+		if (dump_interrupted())
+			return false;
+		return dump_emit_record(cprm, COREDUMP_RECORD_ZERO, 0, nr);
+	}
+
 	if (file->f_mode & FMODE_LSEEK) {
 		if (dump_interrupted() || vfs_llseek(file, nr, SEEK_CUR) < 0)
 			return false;
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 1c8658f35735..a5b9cde47239 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -275,7 +275,8 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
 /* Every option the kernel is expected to advertise in coredump_req->mask. */
 #define TEST_REQ_MASK_ALL					\
 	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
-	 COREDUMP_REJECT | COREDUMP_WAIT | COREDUMP_RECORDS)
+	 COREDUMP_REJECT | COREDUMP_WAIT |			\
+	 COREDUMP_RECORDS | COREDUMP_SPARSE)
 
 bool check_coredump_req(const struct coredump_req *req)
 {

-- 
2.53.0

