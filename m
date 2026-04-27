Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D3351C2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777258922; cv=none; b=rUKzo4vNc+dgUZqmNrUyid0I6LIfdPdZs0EHdXCW38Rwjxy1BH9/oK72QCY1gMBXVKFZDvYpfzCxHQVP4vmHCKb/hFwfdCyDCYvdlr3eP36VKMqLsPxjmUGiNPYeACPSym9qegole4DF1tf+FvjLciRUc9cZ5NePjhkYT5jdS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777258922; c=relaxed/simple;
	bh=p1puO37u8bFWWgJSFzDKpur60Th7Ldl2GpetpbjDBVw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XmZ+osuuYYiWvkLTsb2x3A4mBqvBEwnSOXHQdWNte91E3R8/xNgm7mOk82RVY3vMlAMmeoeJ854EJjlJdwztEsGaPenG7n0VCbHUax8es6/PGhlR1lm/GFfNxuMPnCjGiz8P5qqCiALxrL3Cmar4r7cB1Fk1AQ2sezHb7FhmOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVoSxNwi; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVoSxNwi"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so15109741eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777258919; x=1777863719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ioCKyTrZjs5zhjXH3CtGoC09/oSwp/qrBcKYJ54Avc=;
        b=mVoSxNwihIx5J3kPsBoPgF7fCdMHzf1+eumWlG+zo440leRqd9YnP0Wmn7w0M5oLTg
         PBiFNaiK6QDnSJYJaTOq/p6rr/EmvdHbPELUqKkdZ6kFG5aQG7vqEi5y7MRBsZIwa04f
         hO6ZTFUMvPt/QigUWAlQ8uSGAzvzlmsfLWVqRfFx6PPIxsfuCRwPHkCkgFsMfystYpkc
         /VcrMpfMVdo5kD0jp8s1s8i9gSibNMJYbeiEIyQfoJGkWsYk3Y50Cr9+ICMlFYEmW8Hr
         0+auSaEg4674q/YgAdXxz898wxab0IKtgNh8SvZC3mHzC/KRYOBf3/BWQLXav67ptKWO
         BRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777258919; x=1777863719;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ioCKyTrZjs5zhjXH3CtGoC09/oSwp/qrBcKYJ54Avc=;
        b=KOB6D3MeA0ju10uIKw5Zs7YZdCYJ+WyGT4X+8Ffw0NibYVuPlQ2Ftdwsd9fzcFGWA9
         vgyVX5SAotHA4BYNifHVHSfXEp0Oed5nOzGWznz9Hg5HGgfBVBIgQNsMR0VQCdaJCaOC
         2EVh0RFBXT8qv+H91H/VSTcAILwPT60Cqkq8+ScCxRUt/KPTVCEYIcPpG8lAiGD51uVA
         IqycwoUEmB2ajgz6ZYVuWH+CxzW4d4ySmt54B7av2nm+XdJJSO/1UbJmAUqs7H32h7FS
         w4igThTa6fRMkIdg4uAFCd9RkxKfGnUAaLG/1eMSXk05p48DyIGcAAiS7QVu7GTGsCic
         DaZg==
X-Forwarded-Encrypted: i=1; AFNElJ87xmbTKh1we4Dc0a0xk+7cdaCf3i84obRJFaYxdR3em0NeMvZcbApLBdQgZrNlby1qVQL9gjInTJaa79oT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DwbVN1dNmLJS8pqV9wtmZC9G/+ZrmARHHTjd2R68ihienUbx
	BW/vLsqmcpoKAlnuWQajlQ2RREXif7Uf0B6U5bTv+dnCyvcSUv4GNHpdoZ+8Vq4NLQKI3iE1V5K
	X98YmsA==
X-Received: from dlbqq3.prod.google.com ([2002:a05:7022:ed03:b0:12c:8db5:2517])
 (user=fmayle job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:12b:b0:128:cf75:42a3
 with SMTP id a92af1059eb24-12c73f99753mr21738722c88.21.1777258918488; Sun, 26
 Apr 2026 20:01:58 -0700 (PDT)
Date: Sun, 26 Apr 2026 20:01:47 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427030148.653228-1-fmayle@google.com>
Subject: [PATCH v2] mm: limit filemap_fault readahead to VMA boundaries
From: Frederick Mayle <fmayle@google.com>
To: David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <ljs@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pedro Falcato <pfalcato@suse.de>
Cc: Frederick Mayle <fmayle@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

* Introduce a new readahead_control field, max_index, as a hard limit on
  the readahead. The existing file_ra_state->size can't be used as a
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
This patch would hurt performance of a sequential faulted read of such a
mapping, the degree depending on how fragmented the VMAs are. A usage
pattern like that is likely rare and already suffering from sub-optimal
performance because, e.g., the fragmented VMAs limit the fault-around,
so each VMA boundary in a sequential faulted read would cause a minor
fault. Still, this patch would make it worse. See a previous discussion
of this topic at [1].

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
Reviewed-by: Jan Kara <jack@suse.cz>
---

This is v2 of
https://lore.kernel.org/r/20260422005608.342028-1-fmayle@google.com/

In v1 of the patch, I made a mistake and accidentally mailed twice it,
the first time without including get_maintainer.pl output, so the
mailing lists weren't CC'd. There were replies from Andrew to the first
email which aren't visible on the mailing list or lore.

Changes in v2:
  - Add Jan's Reviewed-by tag.
  - Tweak commit message wording, per Andrew
  - Change field from `unsigned long max_index` to `pgoff_t _max_index`
    and move next to `_index`, per Andrew
  - Avoid min_t, per Andrew


 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 4 ++++
 mm/readahead.c          | 6 +++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f886..6fd2a8914073 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1361,6 +1361,7 @@ struct readahead_control {
 	struct file_ra_state *ra;
 /* private: use the readahead_* accessors instead */
 	pgoff_t _index;
+	pgoff_t _max_index; /* limit readahead to _max_index, inclusive */
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
 	bool dropbehind;
@@ -1374,6 +1375,7 @@ struct readahead_control {
 		.mapping = m,						\
 		.ra = r,						\
 		._index = i,						\
+		._max_index = ULONG_MAX,				\
 	}
 
 #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..97772a05a18e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3314,6 +3314,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	bool force_thp_readahead = false;
 	unsigned short mmap_miss;
 
+	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
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
+		ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_ra(&ractl, folio, ra->ra_pages);
 	}
diff --git a/mm/readahead.c b/mm/readahead.c
index 7b05082c89ea..8c12b63ccd4a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -324,6 +324,8 @@ static void do_page_cache_ra(struct readahead_control *ractl,
 		return;
 
 	end_index = (isize - 1) >> PAGE_SHIFT;
+	if (end_index > ractl->_max_index)
+		end_index = ractl->_max_index;
 	if (index > end_index)
 		return;
 	/* Don't read past the page containing the last byte of the file */
@@ -471,7 +473,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	pgoff_t start = readahead_index(ractl);
 	pgoff_t index = start;
 	unsigned int min_order = mapping_min_folio_order(mapping);
-	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	pgoff_t limit;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	unsigned int nofs;
 	int err = 0;
@@ -484,6 +486,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		goto fallback;
 	}
 
+	limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	limit = min(limit, ractl->_max_index);
 	limit = min(limit, index + ra->size - 1);
 
 	new_order = min(mapping_max_folio_order(mapping), new_order);

base-commit: db2a1695b2b6feb071b47b72e61d0359bf1524bf
-- 
2.54.0.545.g6539524ca2-goog

