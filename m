Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808784;
	b=pYb79LNl2fsjUBktO4jVzdXaagwyhbwE8K7jpOmpsLYkLTIbgT4gP084VgOyjX+ElTfn
	 IshPagwUPIzfOTts4F4SDtgYutA+9nWrF3o2UEaPexRgYl5k86TSOWQjYAUsJBFmJSNuG
	 QbJhDv5tI1Uhxfgk8UkFHQdMmV56Fv2t9fVt2U2GuhuDTa8TsNEs+RCSo4kfwhsiiINMg
	 8O9y80GJ/2CxX6Ez4T9bYG352/beczhYX+43d0zlw7MNV4D6NQxE4g3Xs1b0K7cMlAa8W
	 eHgezMS15lBKqDoH3945uCqNCRi0ES/LtVIlOUx18UnpKMQySNNJ5V2CQT46+w0PLAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808784;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=k3mLM1wyRXEsg+PNLXtW45Wd/AVD4xoxhnOqafugdiQ=;
	b=VrMDKldtkQCr1j2FyEPAiLcBqGUEOjD3VZDTw95Sfanljadvg3yUNTM8QYM4cSdx7/5h
	 KWPQIQG/UkqjIBA1FobtQx7rM7ildk626dvqTP5tUXzTpI8+g/kytEI9Z5szM7/n3KUUO
	 JlzhY17tOOn9iGUKTkoPkBxewSRsLAHBevXyITFvVoKoTw90TyHyI1ysgXcm5XJqyiZ2z
	 0lZ0ehgzxGdpwIXV6OZ+Xhjppwxxg5VKp7N4TGylJQKRFFCJv0ENirxTtHbT9v2orjPa5
	 T1+k7NcNvvW0VsAsqX7wpk+DfjMHW8kyWD5DTFFl5duvuYHGVNBhviPl9irHksiTNmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayy9Q0Mu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8E606A31C;
	Fri, 27 Nov 2026 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayy9Q0Mu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C03D1F00924;
	Fri, 27 Nov 2026 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795808784;
	bh=k3mLM1wyRXEsg+PNLXtW45Wd/AVD4xoxhnOqafugdiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ayy9Q0MuJnX7YhI1XdSAFEYJ6S2e28R4qby8PzluI4BQ0YFOhYr0KTv7fbVo97Im/
	 mSRkHq3NiQJIY1xJ1pJPkRdUNk8scBCJe8/NqAjuttTECCKLhmFBDkv+1h3Y6Sax2X
	 sTdQp8UYr5Or8RVpRWODiqTpxeNi9Lp+znszkSItlz4OCutmyhO3ZRcpaaY+cPtcmc
	 PAx2Ab/mrzHAanNJHrfhBsUQ4AK8OceqKgDMfzfsBeT6nSHZCpuqxMTeofF19u08av
	 JkZ5N/kNKCccI0t6D4kzSwSCbwBMJ4BQ/12C49t1v67J6o4wso0UzU3uTTKHiLridj
	 GbMl9w5ZdETFQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 27 Nov 2026 19:45:43 +0000
Subject: [PATCH 4/4] fs/proc/task_mmu: write-protect only with ptrace
 attach
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mlock-madvise-mprotect-ai-fixes-v1-4-e46b2b1eb435@kernel.org>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Rheinsberg <david@readahead.eu>, Hugh Dickins <hughd@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
 Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: codalist@coda.cs.cmu.edu, linux-mm@kvack.org, 
 Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5134; i=ljs@kernel.org;
 h=from:subject:message-id; bh=LDwlOoGL+Fn5OvyHg2RGXRShc7rrh/h1bpGPWGzw/QM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5776UnsqgY2scx+B02GzrzbLIuS/0wj8LnUzS7Hh9e
 HK8XWZjRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACZypI7hf/EOM55TOmyXlYO2
 mCz+6t6xb5rhWeZHN9WPx2Qfz3gWcp+R4aPbRvGwTVnn478uz2ZXvLlzb9jsRaJ/pTZ4bTV5ckw
 xiBsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The abomination known as PM_SCAN_WP_MATCHING, which makes PAGEMAP_SCAN not
scan but mutate for eldritch uffd-wp purposes, also lacks a permission
check when scanning the mm of another process.

It defaults to PTRACE_MODE_READ, which is insufficient for this accursed
operation.

Therefore actually check for permissions correctly, and also make sure the
mm is as expected when doing so.

As it stands, a task may currently manipulate page tables of the remote
process, write-protecting uffd-wp marked pages, allocating page tables and
splitting THP, and invoking MMU notifiers as needed.

The check is made at the time of the ioctl against its caller, as
lock_trace() does for other /proc files, rather than at open.

A tracker which passes READ but not ATTACH on another process now gets
EACCES for PM_SCAN_WP_MATCHING, whether it opened the pagemap file itself
or was handed the descriptor.

Also update the pagemap documentation to reflect the change.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 Documentation/admin-guide/mm/pagemap.rst |  4 ++-
 fs/proc/task_mmu.c                       | 47 ++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index 77447c454632..f000296e5ab3 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -240,7 +240,9 @@ in this IOCTL:
 - Write-protect the pages. The ``PM_SCAN_WP_MATCHING`` is used to write-protect
   the pages of interest. The ``PM_SCAN_CHECK_WPASYNC`` aborts the operation if
   non-Async Write Protected pages are found. The ``PM_SCAN_WP_MATCHING`` can be
-  used with or without ``PM_SCAN_CHECK_WPASYNC``.
+  used with or without ``PM_SCAN_CHECK_WPASYNC``. On the pagemap file of another
+  process, ``PM_SCAN_WP_MATCHING`` requires that the caller is allowed to attach
+  to that process with ptrace. Otherwise the IOCTL fails with ``EACCES``.
 - Both of those operations can be combined into one atomic operation where we can
   get and write protect the pages as well.
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e3d894ed2b91..19acdddd4b23 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3120,11 +3120,41 @@ static long pagemap_scan_flush_buffer(struct pagemap_scan_private *p)
 	return n;
 }
 
-static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
+/*
+ * Ensure the caller has PTRACE_MODE_ATTACH_FSCREDS permission for wp scan, and
+ * that the file's mm still matches the process's.
+ */
+static int pagemap_scan_check_wp(struct file *file, struct mm_struct *mm)
+{
+	struct task_struct *task;
+	struct mm_struct *task_mm;
+	bool same_mm;
+
+	if (mm == current->mm)
+		return 0;
+
+	task = get_proc_task(file_inode(file));
+	if (!task)
+		return -ESRCH;
+
+	task_mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
+	put_task_struct(task);
+	if (IS_ERR(task_mm))
+		return PTR_ERR(task_mm);
+
+	same_mm = task_mm == mm;
+	mmput(task_mm);
+
+	return same_mm ? 0 : -EACCES;
+}
+
+static long do_pagemap_scan(struct file *file, unsigned long uarg)
 {
 	struct pagemap_scan_private p = {0};
+	struct mm_struct *mm = file->private_data;
 	unsigned long walk_start;
 	size_t n_ranges_out = 0;
+	bool scan_wp;
 	int ret;
 
 	if (!mmget_not_zero(mm))
@@ -3134,6 +3164,13 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 	if (ret)
 		goto out_mmput;
 
+	scan_wp = p.arg.flags & PM_SCAN_WP_MATCHING;
+	if (scan_wp) {
+		ret = pagemap_scan_check_wp(file, mm);
+		if (ret)
+			goto out_mmput;
+	}
+
 	p.masks_of_interest = p.arg.category_mask | p.arg.category_anyof_mask |
 			      p.arg.return_mask;
 	ret = pagemap_scan_init_bounce_buffer(&p);
@@ -3155,7 +3192,7 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 			break;
 
 		/* Protection change for the range is going to happen. */
-		if (p.arg.flags & PM_SCAN_WP_MATCHING) {
+		if (scan_wp) {
 			mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA, 0,
 						mm, walk_start, p.arg.end);
 			mmu_notifier_invalidate_range_start(&range);
@@ -3164,7 +3201,7 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 		ret = walk_page_range(mm, walk_start, p.arg.end,
 				      &pagemap_scan_ops, &p);
 
-		if (p.arg.flags & PM_SCAN_WP_MATCHING)
+		if (scan_wp)
 			mmu_notifier_invalidate_range_end(&range);
 
 		mmap_read_unlock(mm);
@@ -3201,11 +3238,9 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 static long do_pagemap_cmd(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
-	struct mm_struct *mm = file->private_data;
-
 	switch (cmd) {
 	case PAGEMAP_SCAN:
-		return do_pagemap_scan(mm, arg);
+		return do_pagemap_scan(file, arg);
 
 	default:
 		return -ENOIOCTLCMD;

-- 
2.56.1

