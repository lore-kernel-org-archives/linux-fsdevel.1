Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E1299A82;
	Wed, 19 Aug 2026 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181053; cv=none; b=RkdanQT6mYK4gYHW59tDxLWoEw/LGn8NpIynOMphH8aFovD7csmgOkpsGrrs1ol9k2PNGxZ5vDzmSdAGLvdV070ANSRa1R/fiI/3iqwuXCNN4HM77D/hB5W7txqoxaZULmAuWFRKfhPnyKJTG5VBufiw1tMD3bW34neOCzXFN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181053; c=relaxed/simple;
	bh=YahMhih8rmcfyUDHWo+xUJvRT2IOeEUVN31aqub6Kwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2BILZa9lTdsRtACV7Vmt7fLzgGHpFjaIShxzma3C5Lo1RV/UOUdzK+xb9KwBTNwv/Ze+GgePY+LFRe5Dms4sD1YMEA7Xu4FjqlSXRQhDjIlxZo3TMrd3RDbqBzUxpBGJlM6tJ4QTriQ4qOu9iP36Uyaolwl5KHaMOTeBOIvb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIcFcM+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIcFcM+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B76A1F000E9;
	Wed, 19 Aug 2026 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181051;
	bh=exIMLt1L2itKU52nrrnmTx3w7rdobSFaYhq0fQ82NCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YIcFcM+B2Z6+seWCqxRl445ZotpwYdYtA/YcfjlFQ645iCYbLw54IVgabn9un7Rgp
	 n8KL75z6q9F6AnRaRWruscBccHOPmPpXuLb805Y+sV3SxTIEmIAIRXfEW7EH7CwW6O
	 d74XPZTGNvKoxXa3OMCHZz7xwa0n9dKECDkRxqZzdujb5rR39JTnHfX/77f23Ga2f1
	 2FhkFcV797eR2AR100h5M8cfm4xRWxs5hGNMqGSQQgcfm5Tmi21sfF4DY/Gk2LaUUg
	 gCrG+pf/UUwHGa1q7WeiJKSmMYSIEDB3i2OFsm8aeVL6hHlKp/3Bb0DPhA/tgPUOpB
	 SAuy26keKCGfA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:27 +0200
Subject: [PATCH v2 10/22] coredump: make the dump helper return bool
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-10-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6635; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YahMhih8rmcfyUDHWo+xUJvRT2IOeEUVN31aqub6Kwo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me/z2hA585q9LZ+ahZqn/q6DUXclz8XOfnEi/GBi1
 VfeBYccO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSvYLhf7aLjP38ruQGoUMX
 E19ckXvr+qf/tOCvn05vOjpnLCqfX8vwT79S6qNCkPyhnBdJC+Y933HyZ0Dbf2eek8skA32WaW/
 /wAoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The various dump helpers return one and zero. Every caller just does a
boolean test. Convert them to return an actual bool.

While at it, drop the externs.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c            | 63 ++++++++++++++++++++++++------------------------
 include/linux/coredump.h | 14 +++++------
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index cd36a72be445..d837819031ff 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1215,41 +1215,41 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
  * do on a core-file: use only these functions to write out all the
  * necessary info.
  */
-static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
 	struct file *file = cprm->file;
 	loff_t pos = file->f_pos;
 	ssize_t n;
 
 	if (cprm->written + nr > cprm->limit)
-		return 0;
+		return false;
 	if (dump_interrupted())
-		return 0;
+		return false;
 	n = __kernel_write(file, addr, nr, &pos);
 	if (n != nr)
-		return 0;
+		return false;
 	file->f_pos = pos;
 	cprm->written += n;
 	cprm->pos += n;
 
-	return 1;
+	return true;
 }
 
-static int __dump_skip(struct coredump_params *cprm, size_t nr)
+static bool __dump_skip(struct coredump_params *cprm, size_t nr)
 {
 	static char zeroes[PAGE_SIZE];
 	struct file *file = cprm->file;
 
 	if (file->f_mode & FMODE_LSEEK) {
 		if (dump_interrupted() || vfs_llseek(file, nr, SEEK_CUR) < 0)
-			return 0;
+			return false;
 		cprm->pos += nr;
-		return 1;
+		return true;
 	}
 
 	while (nr > PAGE_SIZE) {
 		if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
-			return 0;
+			return false;
 		nr -= PAGE_SIZE;
 	}
 
@@ -1257,20 +1257,20 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 }
 
 /* Flush the accumulated hole before writing data. */
-static int dump_flush_skip(struct coredump_params *cprm)
+static bool dump_flush_skip(struct coredump_params *cprm)
 {
 	if (cprm->to_skip) {
 		if (!__dump_skip(cprm, cprm->to_skip))
-			return 0;
+			return false;
 		cprm->to_skip = 0;
 	}
-	return 1;
+	return true;
 }
 
-int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+bool dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
 	if (!dump_flush_skip(cprm))
-		return 0;
+		return false;
 	return __dump_emit(cprm, addr, nr);
 }
 EXPORT_SYMBOL(dump_emit);
@@ -1290,7 +1290,7 @@ void dump_skip(struct coredump_params *cprm, size_t nr)
 EXPORT_SYMBOL(dump_skip);
 
 #ifdef CONFIG_ELF_CORE
-static int dump_emit_page(struct coredump_params *cprm, struct page *page)
+static bool dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
 	struct bio_vec bvec;
 	struct iov_iter iter;
@@ -1299,25 +1299,25 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	ssize_t n;
 
 	if (!page)
-		return 0;
+		return false;
 
 	if (!dump_flush_skip(cprm))
-		return 0;
+		return false;
 	if (cprm->written + PAGE_SIZE > cprm->limit)
-		return 0;
+		return false;
 	if (dump_interrupted())
-		return 0;
+		return false;
 	pos = file->f_pos;
 	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
 	n = __kernel_write_iter(cprm->file, &iter, &pos);
 	if (n != PAGE_SIZE)
-		return 0;
+		return false;
 	file->f_pos = pos;
 	cprm->written += PAGE_SIZE;
 	cprm->pos += PAGE_SIZE;
 
-	return 1;
+	return true;
 }
 
 /*
@@ -1349,18 +1349,19 @@ static inline struct page *dump_page_copy(struct page *src, struct page *dst)
 }
 #endif
 
-int dump_user_range(struct coredump_params *cprm, unsigned long start,
-		    unsigned long len)
+bool dump_user_range(struct coredump_params *cprm, unsigned long start,
+		     unsigned long len)
 {
 	unsigned long addr;
 	struct page *dump_page;
-	int locked, ret;
+	int locked;
+	bool ret;
 
 	dump_page = dump_page_alloc();
 	if (!dump_page)
-		return 0;
+		return false;
 
-	ret = 0;
+	ret = false;
 	locked = 0;
 	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
 		struct page *page;
@@ -1384,7 +1385,7 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 				mmap_read_unlock(current->mm);
 				locked = 0;
 			}
-			int stop = !dump_emit_page(cprm, dump_page_copy(page, dump_page));
+			bool stop = !dump_emit_page(cprm, dump_page_copy(page, dump_page));
 			put_page(page);
 			if (stop)
 				goto out;
@@ -1403,7 +1404,7 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		}
 		cond_resched();
 	}
-	ret = 1;
+	ret = true;
 out:
 	if (locked)
 		mmap_read_unlock(current->mm);
@@ -1413,14 +1414,14 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 }
 #endif
 
-int dump_align(struct coredump_params *cprm, int align)
+bool dump_align(struct coredump_params *cprm, int align)
 {
 	unsigned mod = (cprm->pos + cprm->to_skip) & (align - 1);
 	if (align & (align - 1))
-		return 0;
+		return false;
 	if (mod)
 		cprm->to_skip += align - mod;
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(dump_align);
 
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index dc7a05b1bb0a..943bddfb22bf 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -43,13 +43,13 @@ extern unsigned int core_file_note_size_limit;
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
  */
-extern void dump_skip_to(struct coredump_params *cprm, unsigned long to);
-extern void dump_skip(struct coredump_params *cprm, size_t nr);
-extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
-extern int dump_align(struct coredump_params *cprm, int align);
-int dump_user_range(struct coredump_params *cprm, unsigned long start,
-		    unsigned long len);
-extern void vfs_coredump(const kernel_siginfo_t *siginfo);
+void dump_skip_to(struct coredump_params *cprm, unsigned long to);
+void dump_skip(struct coredump_params *cprm, size_t nr);
+bool dump_emit(struct coredump_params *cprm, const void *addr, int nr);
+bool dump_align(struct coredump_params *cprm, int align);
+bool dump_user_range(struct coredump_params *cprm, unsigned long start,
+		     unsigned long len);
+void vfs_coredump(const kernel_siginfo_t *siginfo);
 
 /*
  * Logging for the coredump code, ratelimited.

-- 
2.53.0

