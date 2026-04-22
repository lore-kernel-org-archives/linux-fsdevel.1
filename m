Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE91ACEDE
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776819384; cv=none; b=rwnK+DScxy85SDSDSyhtjI1O+Jxi9fW3+rSD0ZzCq/OxNwBaM/SQ+7Lt/pTbSlbnXM9LgGR9Gzv8XT0x7eHtXiYjCcJ875n+ktZguvoLKcCoce41A3DJoYnp2a7mdLKLWSYRBY6TLHzwvGSmnis5vYnlXxgebmANY0H+QEqo09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776819384; c=relaxed/simple;
	bh=IyDQ4YMZ7gjuXlvD4Q6trC7Qt8AbmucoFFcpI3+jkCc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dpZ1BGTI2ZGc00XPjr7LVNfoHtnYHzcVTbhQIBSDxHeQQ5tkvrZvYxi9eWyjfzT+DByaroIt/exk4t/gsX3ITl/ahjw9U54M/tWlYatz5Powj/f8Xz/D8ZsQh1cYtvsQ8z5rc1C3NyN0BZPwVyAcRWD35nXMEQgESgvIw1Qh+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQSOXc9C; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQSOXc9C"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so7758051eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 17:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776819382; x=1777424182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fSPQPWpwMUWLrSIOukQG9uvEUqsfb3QUUQ/25v9V8fQ=;
        b=bQSOXc9Cn+MsfaoWLCPpU94XHp9AJYWMlH5I1Q5+ExUxDHmArjNyEVkE5LJ8y/nhh0
         QRaCQZXIBTm2RbPSSA2MRGXBJ/zSTQQd2iCT8u1uXLQF7xlourhFmA4QbzRY964W+E5p
         371I+BLh+LbHhpnKfTGE96KXwkcNnkerOFQX33gZm3tMWNPKPQDmJVVWYPu1kNcLCZH7
         wzQlg/PDSU/gtztA7f7kcatb4X40ZV6graMz0WNZvXEaSiF3jvLXBdkqwYXOrUWpPqmV
         3IAyzBiN+NgfSp7x09JdDc7TPOFOJPD3etFYUejDs1dPfdQ7mckn7Yi7ntyJqgJ2408I
         /rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776819382; x=1777424182;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSPQPWpwMUWLrSIOukQG9uvEUqsfb3QUUQ/25v9V8fQ=;
        b=tJDAocPmLQWdGc8hewocGj+K3LHK0iBx+fUi07k+0jFMCVAg9h4GOLEnIZ4ToHIoeu
         d4Jhs6PIgjpZb/prZ19zyaNG7ApACum5IGob+SqvOtC3T6BgVpssJ5qD6OBTCHLjRNW4
         xo/xtEXnSlT9CMsxqVlzBIvTBPukWwNzU6LmkKNo3SBQQQCmaZDBBu4BFmlYjaG7a0TO
         XHwgdO/0AR3tTDf2WI2I9wsNnjZcUSj6EZvvZ0kwJsnliJLEbAsYhRUGl3YnVz/rQnuc
         w8TATpluwSyoCbADY0XYvVWSOEOE7vXZyZ424KbbbSq59KjT2WmtoyelGBGtDThpQnrX
         VSdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pB2DnpohQHQ4sEzSyk5TklVw4HTg3kUK9WeMATrfh1fGD6R+mvF1q67z2Cmkc3pzHg1kciHVl1PQpK7Tm@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZDNqS6inkcIyIIekLHsnFx2RNnU362MdNtPsgAqRiSl7ZgX3
	yXJjEpCnFoArLbxO4mMXFQp0sQk2M8tdiiN6MJ+4oOWBXypKyMqfGh+EnWuiQlEP+J9C15yzkFF
	ZBJCRUA==
X-Received: from dyer22.prod.google.com ([2002:a05:7300:2316:b0:2d9:e328:e0db])
 (user=fmayle job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3d19:b0:2d1:9b35:4ed3
 with SMTP id 5a478bee46e88-2e4874ea1f2mr12199282eec.28.1776819382219; Tue, 21
 Apr 2026 17:56:22 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:56:07 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260422005608.342028-1-fmayle@google.com>
Subject: [PATCH] mm: limit filemap_fault readahead to VMA boundaries
From: Frederick Mayle <fmayle@google.com>
To: David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <ljs@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Cc: Frederick Mayle <fmayle@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, 
	kernel-team@android.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a file mapping covers a strict subset of a file, an access to the
mapping can trigger readahead of file pages outside the mapped region.
Readahead is meant to prefetch pages likely to be accessed soon, but
these pages aren't accessible via the same means, so it fair to say we
don't have a good indicator they'll be accessed soon. Take an ELF file
for example: An access to the end of a program's read-only segment isn't
a sign that nearby file contents will be accessed next (they are likely
to be mapped discontiguously, or not at all). The pressure from loading
these pages into the cache can evict more useful pages.

To improve the behavior, make three changes:

* Introduce a new readahead_control option, max_index, as a hard limit
  on the readahead. The existing file_ra_state->size can't be used as a
  limit, it is more of a hint and can be increased by various
  heuristics.
* Set readahead_control->max_index to the end of the VMA in all of the
  readahead paths that can be triggered from a fault on a file mapping
  (both "sync" and "async" readahead).
* Limit the read-around range start to the VMA's start.

Note that these changes only affect readahead triggered in the context
of a fault, they do not affect readahead triggered by read syscalls. If
a user mixes the two types of accesses, the behavior is expected to be
the following: if a fault causes readahead and places a PG_readahead
marker and then a read(2) syscall hits the PG_readahead marker, the
resulting async readahead *will not* be limited to the VMA end.
Conversely, if a read(2) syscall places a PG_readahead marker and then a
fault hits the marker, the async readahead *will* be limited to the VMA
end.

There is an edge case that the above motivation glosses over: A single
file mapping might be backed by multiple VMAs. For example, a whole file
could be mapped RW, then part of the mapping made RO using mprotect.
This patch would hurt performance of a sequential read of such a
mapping, the degree depending on how fragmented the VMAs are. A usage
pattern like that is likely rare and already suffering from sub-optimal
performance because, e.g., the fragmented VMAs limit the fault-around,
so each VMA boundary in a sequential read would cause a minor fault.
Still, this would make it worse. See a previous discussion of this topic
at [1].

Tested by mapping and reading a small subset of a large file, then using
the cachestat syscall to verify the number of cached pages didn't exceed
the mapping size.

In practical scenarios, the effect depends on the specific file and
usage. Sometimes there is no effect at all, but, for some ELF files in
Android, we see ~20% fewer pages pull into the cache.

A comprehensive performance evaluation hasn't been done, but, in
addition to the anecdontal memory savings mentioned above, a benchmark
was run with fio 3.38, showing neutral looking results:

    /data/local/tmp/fio --version

    fio --name=mmap_test --ioengine=mmap --rw=read --bs=4k \
        --offset=1G --size=1G --filesize=3G --numjobs=1 \
        --filename=testfile.bin

        Before: 4366.6 MiB/s (avg of 3459, 4592, 4613, 4697, 4472)
        After:  4444.0 MiB/s (avg of 4633, 4655, 4511, 4571, 3850)
                +1.7%

    Same, with --ioengine=mmap --rw=randread

        Before: 445.6 MiB/s  (avg of 446, 447, 442, 452, 441)
        After:  447.0 MiB/s  (avg of 447, 446, 446, 451, 445)
                +0.3%

    Same, with --ioengine=psync --rw=read

        Before: 3086.6 MiB/s (avg of 3122, 3094, 3066, 3094, 3057)
        After:  3084.6 MiB/s (avg of 3039, 3103, 3103, 3084, 3094)
                -0.06%

    Same, with --ioengine=psync --rw=randread

        Before: 2226.4 MiB/s (avg of 2256, 2183, 2207, 2265, 2221)
        After:  2231.4 MiB/s (avg of 2236, 2241, 2236, 2193, 2251)
                +0.2%

[1] https://lore.kernel.org/all/ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: android-mm@google.com
Cc: kernel-team@android.com
Signed-off-by: Frederick Mayle <fmayle@google.com>
---
 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 4 ++++
 mm/readahead.c          | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f886..cc628050bc5e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1366,6 +1366,7 @@ struct readahead_control {
 	bool dropbehind;
 	bool _workingset;
 	unsigned long _pflags;
+	unsigned long max_index; /* limit readahead to i<=max_index */
 };
 
 #define DEFINE_READAHEAD(ractl, f, r, m, i)				\
@@ -1374,6 +1375,7 @@ struct readahead_control {
 		.mapping = m,						\
 		.ra = r,						\
 		._index = i,						\
+		.max_index = ULONG_MAX,					\
 	}
 
 #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..d2f6bef12f58 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3314,6 +3314,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	bool force_thp_readahead = false;
 	unsigned short mmap_miss;
 
+	ractl.max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
+
 	/* Use the readahead code, even if readahead is disabled */
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
@@ -3396,6 +3398,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * mmap read-around
 		 */
 		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
+		ra->start = max(ra->start, vmf->vma->vm_pgoff);
 		ra->size = ra->ra_pages;
 		ra->async_size = ra->ra_pages / 4;
 		ra->order = 0;
@@ -3438,6 +3441,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	}
 
 	if (folio_test_readahead(folio)) {
+		ractl.max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_ra(&ractl, folio, ra->ra_pages);
 	}
diff --git a/mm/readahead.c b/mm/readahead.c
index 7b05082c89ea..95a424b2f3a3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -324,6 +324,8 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 		return;
 
 	end_index = (isize - 1) >> PAGE_SHIFT;
+	if (end_index > ractl->max_index)
+		end_index = ractl->max_index;
 	if (index > end_index)
 		return;
 	/* Don't read past the page containing the last byte of the file */
@@ -471,7 +473,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	pgoff_t start = readahead_index(ractl);
 	pgoff_t index = start;
 	unsigned int min_order = mapping_min_folio_order(mapping);
-	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	pgoff_t limit = min_t(pgoff_t, (i_size_read(mapping->host) - 1) >> PAGE_SHIFT,
+				       ractl->max_index);
 	pgoff_t mark = index + ra->size - ra->async_size;
 	unsigned int nofs;
 	int err = 0;

base-commit: db2a1695b2b6feb071b47b72e61d0359bf1524bf
-- 
2.54.0.rc1.555.g9c883467ad-goog

