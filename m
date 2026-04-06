Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3649238B146
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493053; cv=none; b=OMC4zBH317Uvr9AINRSjeSLsGLruYHIBmSO8vkbkVFemN0FZQiwCMlTG/XfGc/t/0yGKjkJ8ttoF8Y4CZMg8Lj0VHbvvedzKT9nAT2To0v+jBAo+Wpg60XRQAyl+3DXQypegiTvOXPhObrJQzPXvEzVLHJcAyQpBDQFYw06VEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493053; c=relaxed/simple;
	bh=cz6c88cVbGgzSXQf7Hr2AUO1i84R6kMrVfg4g3XrRF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RN4akZ0nYoFkL8Xxm3q03/eSzfH/FpkNDxLH1dg3m4nEKUYuE4tuzvp0Ms491jyao9DmnaVDhKHRIPjJRog25r26Vjf/OUwLdgRiuqRr/urs5aQhRW/gSWRw/BoS85xjOMA9YKV9L2TQcogV1edjdh1HdqbV08cGDVGT8jKBqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGesjmXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGesjmXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1F9C4CEF7;
	Mon,  6 Apr 2026 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775493052;
	bh=cz6c88cVbGgzSXQf7Hr2AUO1i84R6kMrVfg4g3XrRF4=;
	h=From:To:Cc:Subject:Date:From;
	b=GGesjmXee/UbaoNJJldToQxA6YQmM0c81Xj8PkQ+/di50xu+KMpHen458osK5Zj3I
	 DGneUzCurMmoQA/7SC66lwojz38njUxQ+FBclgtEdrWrx+N2g71Hq/b5GHG7XbLR/0
	 W08nup5RCVBkCYXI4qQ1ICi4JwKqvv94Wb9+GEmTukx4kVNffZLVkYRrQFkwnEFP1B
	 2NyMu+NUWo4Ai8058vyxp1vWcn36gwWfBYuKWO1h/DG+tI7djA6/DX84W1+FkzAQC0
	 Yb/vjqugwUrdH8zZzb8oKQuwbuO8Hq6A4U87FCKqPry+ZPSq+RIqs5709IIhEbpHLn
	 1zGs+sR1bIlNg==
From: hubcap@kernel.org
To: torvalds@linux-foundation.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH]    bufmap: manage as folios.
Date: Mon,  6 Apr 2026 12:30:45 -0400
Message-ID: <20260406163047.1240941-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

    Orangefs userspace allocates 40 megabytes on an address that's page
    aligned.

    With this folio modification the allocation is aligned on a multiple of
    2 megabytes:
    posix_memalign(&ptr, 2097152, 41943040);

    Then userspace tries to enable Huge Pages for the range:
    madvise(ptr, 41943040, MADV_HUGEPAGE);

    Userspace provides the address of the 40 megabyte allocation to
    the Orangefs kernel module with an ioctl.

    The kernel module initializes the memory as a "bufmap" with ten
    4 megabyte "slots".

    Traditionally, the slots are manipulated a page at a time.

    This folio/bufmap modification manages the slots as folios, with
    two 2 megabyte folios per slot and data can be read into
    and out of each slot a folio at a time.

    This modification works fine with orangefs userspace lacking
    the THP focused posix_memalign and madvise settings listed above,
    each slot can end up being made of page sized folios. It also works
    if there are some, but less than 20, hugepages available. A message
    is printed in the kernel ring buffer (dmesg) at userspace start
    time that describes the folio/page ratio. As an example, I started
    orangefs and saw "Grouped 2575 folios from 10240 pages" in the ring
    buffer.

    To get the optimum ratio, 20/10240, I use these settings before
    I start the orangefs userspace:

      echo always > /sys/kernel/mm/transparent_hugepage/enabled
      echo always > /sys/kernel/mm/transparent_hugepage/defrag
      echo 30 > /proc/sys/vm/nr_hugepages

    https://docs.kernel.org/admin-guide/mm/hugetlbpage.html discusses
    hugepages and manipulating the /proc/sys/vm settings.

    Comparing the performance between the page/bufmap and the folio/bufmap
    is a mixed bag.

      - The folio/bufmap version is about 8% faster at running through the
        xfstest suite on my VMs.

       - It is easy to construct an fio test that brings the page/bufmap
         version to its knees on my dinky VM test system, with all bufmap
         slots used and I/O timeouts cascading.

       - Some smaller tests I did with fio that didn't overwhelm the
         page/bufmap version showed no performance gain with the
         folio/bufmap version on my VM.

    I suspect this change will improve performance only in some use-cases.
    I think it will be a gain when there are many concurrent IOs that
    mostly fill the bufmap. I'm working up a gcloud test for that.

    Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/orangefs-bufmap.c | 395 ++++++++++++++++++++++++++++++----
 1 file changed, 352 insertions(+), 43 deletions(-)

diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index 5dd2708cce94..6d6f9f5df8aa 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -139,9 +139,15 @@ static int get(struct slot_map *m)
 /* used to describe mapped buffers */
 struct orangefs_bufmap_desc {
 	void __user *uaddr;		/* user space address pointer */
-	struct page **page_array;	/* array of mapped pages */
-	int array_count;		/* size of above arrays */
-	struct list_head list_link;
+	struct folio **folio_array;
+	/*
+	 * folio_offsets could be needed when userspace sets custom
+	 * sizes in user_desc, or when folios aren't all backed by
+	 * 2MB THPs.
+	 */
+	size_t *folio_offsets;
+	int folio_count;
+	bool is_two_2mib_chunks;
 };
 
 static struct orangefs_bufmap {
@@ -150,8 +156,10 @@ static struct orangefs_bufmap {
 	int desc_count;
 	int total_size;
 	int page_count;
+	int folio_count;
 
 	struct page **page_array;
+	struct folio **folio_array;
 	struct orangefs_bufmap_desc *desc_array;
 
 	/* array to track usage of buffer descriptors */
@@ -174,6 +182,17 @@ orangefs_bufmap_unmap(struct orangefs_bufmap *bufmap)
 static void
 orangefs_bufmap_free(struct orangefs_bufmap *bufmap)
 {
+	int i;
+
+	if (!bufmap)
+		return;
+
+	for (i = 0; i < bufmap->desc_count; i++) {
+		kfree(bufmap->desc_array[i].folio_array);
+		kfree(bufmap->desc_array[i].folio_offsets);
+		bufmap->desc_array[i].folio_array = NULL;
+		bufmap->desc_array[i].folio_offsets = NULL;
+	}
 	kfree(bufmap->page_array);
 	kfree(bufmap->desc_array);
 	bitmap_free(bufmap->buffer_index_array);
@@ -213,8 +232,10 @@ orangefs_bufmap_alloc(struct ORANGEFS_dev_map_desc *user_desc)
 	bufmap->desc_count = user_desc->count;
 	bufmap->desc_size = user_desc->size;
 	bufmap->desc_shift = ilog2(bufmap->desc_size);
+	bufmap->page_count = bufmap->total_size / PAGE_SIZE;
 
-	bufmap->buffer_index_array = bitmap_zalloc(bufmap->desc_count, GFP_KERNEL);
+	bufmap->buffer_index_array =
+		bitmap_zalloc(bufmap->desc_count, GFP_KERNEL);
 	if (!bufmap->buffer_index_array)
 		goto out_free_bufmap;
 
@@ -223,16 +244,21 @@ orangefs_bufmap_alloc(struct ORANGEFS_dev_map_desc *user_desc)
 	if (!bufmap->desc_array)
 		goto out_free_index_array;
 
-	bufmap->page_count = bufmap->total_size / PAGE_SIZE;
-
 	/* allocate storage to track our page mappings */
 	bufmap->page_array =
 		kzalloc_objs(struct page *, bufmap->page_count);
 	if (!bufmap->page_array)
 		goto out_free_desc_array;
 
+	/* allocate folio array. */
+	bufmap->folio_array = kzalloc_objs(struct folio *, bufmap->page_count);
+	if (!bufmap->folio_array)
+		goto out_free_page_array;
+
 	return bufmap;
 
+out_free_page_array:
+	kfree(bufmap->page_array);
 out_free_desc_array:
 	kfree(bufmap->desc_array);
 out_free_index_array:
@@ -243,16 +269,64 @@ orangefs_bufmap_alloc(struct ORANGEFS_dev_map_desc *user_desc)
 	return NULL;
 }
 
-static int
-orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
-		struct ORANGEFS_dev_map_desc *user_desc)
+static int orangefs_bufmap_group_folios(struct orangefs_bufmap *bufmap)
+{
+	int i = 0;
+	int f = 0;
+	int k;
+	int num_pages;
+	struct page *page;
+	struct folio *folio;
+
+	while (i < bufmap->page_count) {
+		page = bufmap->page_array[i];
+		folio = page_folio(page);
+		num_pages = folio_nr_pages(folio);
+		gossip_debug(GOSSIP_BUFMAP_DEBUG,
+			"%s: i:%d: num_pages:%d: \n", __func__, i, num_pages);
+
+		for (k = 1; k < num_pages; k++) {
+			if (bufmap->page_array[i + k] != folio_page(folio, k)) {
+				gossip_err("%s: bad match,  i:%d: k:%d:\n",
+					__func__, i, k);
+				return -EINVAL;
+			}
+		}
+
+		bufmap->folio_array[f++] = folio;
+		i += num_pages;
+	}
+
+	bufmap->folio_count = f;
+	pr_info("%s: Grouped %d folios from %d pages.\n",
+		__func__,
+		bufmap->folio_count,
+		bufmap->page_count);
+	return 0;
+}
+
+static int orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
+				struct ORANGEFS_dev_map_desc *user_desc)
 {
 	int pages_per_desc = bufmap->desc_size / PAGE_SIZE;
-	int offset = 0, ret, i;
+	int ret;
+	int i;
+	int j;
+	int current_folio;
+	int desc_pages_needed;
+	int desc_folio_count;
+	int remaining_pages;
+	int need_avail_min;
+	int pages_assigned_to_this_desc;
+	size_t current_offset;
+	size_t adjust_offset;
+	struct folio *folio;
 
 	/* map the pages */
 	ret = pin_user_pages_fast((unsigned long)user_desc->ptr,
-			     bufmap->page_count, FOLL_WRITE, bufmap->page_array);
+		bufmap->page_count,
+		FOLL_WRITE,
+		bufmap->page_array);
 
 	if (ret < 0)
 		return ret;
@@ -260,7 +334,6 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
 	if (ret != bufmap->page_count) {
 		gossip_err("orangefs error: asked for %d pages, only got %d.\n",
 				bufmap->page_count, ret);
-
 		for (i = 0; i < ret; i++)
 			unpin_user_page(bufmap->page_array[i]);
 		return -ENOMEM;
@@ -275,16 +348,117 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
 	for (i = 0; i < bufmap->page_count; i++)
 		flush_dcache_page(bufmap->page_array[i]);
 
-	/* build a list of available descriptors */
-	for (offset = 0, i = 0; i < bufmap->desc_count; i++) {
-		bufmap->desc_array[i].page_array = &bufmap->page_array[offset];
-		bufmap->desc_array[i].array_count = pages_per_desc;
+	/*
+	 * Group pages into folios.
+	 */
+	ret = orangefs_bufmap_group_folios(bufmap);
+	if (ret)
+		goto unpin;
+
+	pr_info("%s: desc_size=%d bytes (%d pages per desc), total folios=%d\n",
+			__func__, bufmap->desc_size, pages_per_desc,
+			bufmap->folio_count);
+
+	current_folio = 0;
+	remaining_pages = 0;
+	current_offset = 0;
+	for (i = 0; i < bufmap->desc_count; i++) {
+		desc_pages_needed = pages_per_desc;
+		desc_folio_count = 0;
+		pages_assigned_to_this_desc = 0;
+		bufmap->desc_array[i].is_two_2mib_chunks = false;
+
+		/*
+		 * We hope there was enough memory that each desc is
+		 * covered by two THPs/folios, if not we want to keep on
+		 * working even if there's only one page per folio.
+		 */
+		bufmap->desc_array[i].folio_array =
+			kzalloc_objs(struct folio *, pages_per_desc);
+		if (!bufmap->desc_array[i].folio_array) {
+			ret = -ENOMEM;
+			goto unpin;
+		}
+
+		bufmap->desc_array[i].folio_offsets =
+			kzalloc_objs(size_t, pages_per_desc);
+		if (!bufmap->desc_array[i].folio_offsets) {
+			ret = -ENOMEM;
+			kfree(bufmap->desc_array[i].folio_array);
+			goto unpin;
+		}
+
 		bufmap->desc_array[i].uaddr =
-		    (user_desc->ptr + (i * pages_per_desc * PAGE_SIZE));
-		offset += pages_per_desc;
+			user_desc->ptr + (size_t)i * bufmap->desc_size;
+
+		/*
+		 * Accumulate folios until desc is full.
+		 */
+		while (desc_pages_needed > 0) {
+			if (remaining_pages == 0) {
+				/* shouldn't happen. */
+				if (current_folio >= bufmap->folio_count) {
+					ret = -EINVAL;
+					goto unpin;
+				}
+				folio = bufmap->folio_array[current_folio++];
+				remaining_pages = folio_nr_pages(folio);
+				current_offset = 0;
+			} else {
+				folio = bufmap->folio_array[current_folio - 1];
+			}
+
+			need_avail_min =
+				min(desc_pages_needed, remaining_pages);
+			adjust_offset = need_avail_min * PAGE_SIZE;
+
+			bufmap->desc_array[i].folio_array[desc_folio_count] =
+				folio;
+			bufmap->desc_array[i].folio_offsets[desc_folio_count] =
+				current_offset;
+			desc_folio_count++;
+			pages_assigned_to_this_desc += need_avail_min;
+			desc_pages_needed -= need_avail_min;
+			remaining_pages -= need_avail_min;
+			current_offset += adjust_offset;
+		}
+
+		/* Detect optimal case: two 2MiB folios per 4MiB slot. */
+		if (desc_folio_count == 2 &&
+		  folio_nr_pages(bufmap->desc_array[i].folio_array[0]) == 512 &&
+		  folio_nr_pages(bufmap->desc_array[i].folio_array[1]) == 512) {
+			bufmap->desc_array[i].is_two_2mib_chunks = true;
+			gossip_debug(GOSSIP_BUFMAP_DEBUG, "%s: descriptor :%d: "
+				"optimal folio/page ratio.\n", __func__, i);
+		}
+
+		bufmap->desc_array[i].folio_count = desc_folio_count;
+		gossip_debug(GOSSIP_BUFMAP_DEBUG,
+			" descriptor %d: folio_count=%d, "
+			"pages_assigned=%d (should be %d)\n",
+			i, desc_folio_count, pages_assigned_to_this_desc,
+			pages_per_desc);
 	}
 
 	return 0;
+unpin:
+	/*
+	 * rollback any allocations we got so far...
+	 * Memory pressure, like in generic/340, led me
+	 * to write the rollback this way.
+	 */
+	for (j = 0; j <= i; j++) {
+		if (bufmap->desc_array[j].folio_array) {
+			kfree(bufmap->desc_array[j].folio_array);
+			bufmap->desc_array[j].folio_array = NULL;
+		}
+		if (bufmap->desc_array[j].folio_offsets) {
+			kfree(bufmap->desc_array[j].folio_offsets);
+			bufmap->desc_array[j].folio_offsets = NULL;
+		}
+	}
+	unpin_user_pages(bufmap->page_array, bufmap->page_count);
+	return ret;
 }
 
 /*
@@ -292,6 +466,8 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
  *
  * initializes the mapped buffer interface
  *
+ * user_desc is the parameters provided by userspace for the bufmap.
+ *
  * returns 0 on success, -errno on failure
  */
 int orangefs_bufmap_initialize(struct ORANGEFS_dev_map_desc *user_desc)
@@ -300,8 +476,8 @@ int orangefs_bufmap_initialize(struct ORANGEFS_dev_map_desc *user_desc)
 	int ret = -EINVAL;
 
 	gossip_debug(GOSSIP_BUFMAP_DEBUG,
-		     "orangefs_bufmap_initialize: called (ptr ("
-		     "%p) sz (%d) cnt(%d).\n",
+		     "%s: called (ptr (" "%p) sz (%d) cnt(%d).\n",
+		     __func__,
 		     user_desc->ptr,
 		     user_desc->size,
 		     user_desc->count);
@@ -371,7 +547,7 @@ int orangefs_bufmap_initialize(struct ORANGEFS_dev_map_desc *user_desc)
 	spin_unlock(&orangefs_bufmap_lock);
 
 	gossip_debug(GOSSIP_BUFMAP_DEBUG,
-		     "orangefs_bufmap_initialize: exiting normally\n");
+		     "%s: exiting normally\n", __func__);
 	return 0;
 
 out_unmap_bufmap:
@@ -471,22 +647,88 @@ int orangefs_bufmap_copy_from_iovec(struct iov_iter *iter,
 				size_t size)
 {
 	struct orangefs_bufmap_desc *to;
-	int i;
+	size_t remaining = size;
+	int folio_index = 0;
+	struct folio *folio;
+	size_t folio_offset;
+	size_t folio_avail;
+	size_t copy_amount;
+	size_t copied;
+	void *kaddr;
+	size_t half;
+	size_t first;
+	size_t second;
+
+	to = &__orangefs_bufmap->desc_array[buffer_index];
+
+	/* shouldn't happen... */
+	if (size > 4194304) pr_info("%s: size:%ld\n", __func__, size);
 
 	gossip_debug(GOSSIP_BUFMAP_DEBUG,
-		     "%s: buffer_index:%d: size:%zu:\n",
-		     __func__, buffer_index, size);
+		"%s: buffer_index:%d size:%zu folio_count:%d\n",
+		__func__,
+		buffer_index,
+		size,
+		to->folio_count);
+
+	/* Fast path: exactly two 2 MiB folios */
+	if (to->is_two_2mib_chunks && size <= 4194304) {
+		gossip_debug(GOSSIP_BUFMAP_DEBUG,
+			"%s: fastpath hit.\n", __func__);
+		half = 2097152;		/* 2 MiB */
+		first = min(size, half);
+		second = (size > half) ? size - half : 0;
+
+		/* First 2 MiB chunk */
+		kaddr = kmap_local_folio(to->folio_array[0], 0);
+		copied = copy_from_iter(kaddr, first, iter);
+		kunmap_local(kaddr);
+		if (copied != first)
+			return -EFAULT;
 
-	to = &__orangefs_bufmap->desc_array[buffer_index];
-	for (i = 0; size; i++) {
-		struct page *page = to->page_array[i];
-		size_t n = size;
-		if (n > PAGE_SIZE)
-			n = PAGE_SIZE;
-		if (copy_page_from_iter(page, 0, n, iter) != n)
+		if (second == 0)
+			return 0;
+
+		/* Second 2 MiB chunk */
+		kaddr = kmap_local_folio(to->folio_array[1], 0);
+		copied = copy_from_iter(kaddr, second, iter);
+		kunmap_local(kaddr);
+		if (copied != second)
 			return -EFAULT;
-		size -= n;
+
+		return 0;
 	}
+
+	while (remaining > 0) {
+
+		if (unlikely(folio_index >= to->folio_count ||
+			to->folio_array[folio_index] == NULL)) {
+				gossip_err("%s: "
+				   "folio_index:%d: >= folio_count:%d: "
+		                   "(size %zu, buffer %d)\n",
+					__func__,
+					folio_index,
+					to->folio_count,
+					size,
+					buffer_index);
+				return -EFAULT;
+		}
+
+		folio = to->folio_array[folio_index];
+		folio_offset = to->folio_offsets[folio_index];
+		folio_avail = folio_nr_pages(folio) * PAGE_SIZE - folio_offset;
+		copy_amount = min(remaining, folio_avail);
+		kaddr = kmap_local_folio(folio, folio_offset);
+		copied = copy_from_iter(kaddr, copy_amount, iter);
+		kunmap_local(kaddr);
+
+		if (copied != copy_amount)
+			return -EFAULT;
+
+		remaining -= copied;
+		folio_index++;
+	}
+
 	return 0;
 }
 
@@ -499,23 +741,90 @@ int orangefs_bufmap_copy_to_iovec(struct iov_iter *iter,
 				    size_t size)
 {
 	struct orangefs_bufmap_desc *from;
-	int i;
+	size_t remaining = size;
+	int folio_index = 0;
+	struct folio *folio;
+	size_t folio_offset;
+	size_t folio_avail;
+	size_t copy_amount;
+	size_t copied;
+	void *kaddr;
+	size_t half;
+	size_t first;
+	size_t second;
 
 	from = &__orangefs_bufmap->desc_array[buffer_index];
+
+	/* shouldn't happen... */
+	if (size > 4194304) pr_info("%s: size:%ld\n", __func__, size);
+
 	gossip_debug(GOSSIP_BUFMAP_DEBUG,
-		     "%s: buffer_index:%d: size:%zu:\n",
-		     __func__, buffer_index, size);
+		"%s: buffer_index:%d size:%zu folio_count:%d\n",
+		__func__,
+		buffer_index,
+		size,
+		from->folio_count);
+
+	/* Fast path: exactly two 2 MiB folios */
+	if (from->is_two_2mib_chunks && size <= 4194304) {
+		gossip_debug(GOSSIP_BUFMAP_DEBUG,
+			"%s: fastpath hit.\n", __func__);
+		half = 2097152;		/* 2 MiB */
+		first = min(size, half);
+		second = (size > half) ? size - half : 0;
+		void *kaddr;
+		size_t copied;
+
+		/* First 2 MiB chunk */
+		kaddr = kmap_local_folio(from->folio_array[0], 0);
+		copied = copy_to_iter(kaddr, first, iter);
+		kunmap_local(kaddr);
+		if (copied != first)
+			return -EFAULT;
+
+		if (second == 0)
+			return 0;
+
+		/* Second 2 MiB chunk */
+		kaddr = kmap_local_folio(from->folio_array[1], 0);
+		copied = copy_to_iter(kaddr, second, iter);
+		kunmap_local(kaddr);
+		if (copied != second)
+			return -EFAULT;
 
+		return 0;
+	}
+
+	while (remaining > 0) {
+
+		if (unlikely(folio_index >= from->folio_count ||
+			from->folio_array[folio_index] == NULL)) {
+				gossip_err("%s: "
+				   "folio_index:%d: >= folio_count:%d: "
+		                   "(size %zu, buffer %d)\n",
+					__func__,
+					folio_index,
+					from->folio_count,
+					size,
+					buffer_index);
+				return -EFAULT;
+		}
 
-	for (i = 0; size; i++) {
-		struct page *page = from->page_array[i];
-		size_t n = size;
-		if (n > PAGE_SIZE)
-			n = PAGE_SIZE;
-		n = copy_page_to_iter(page, 0, n, iter);
-		if (!n)
+		folio = from->folio_array[folio_index];
+		folio_offset = from->folio_offsets[folio_index];
+		folio_avail = folio_nr_pages(folio) * PAGE_SIZE - folio_offset;
+		copy_amount = min(remaining, folio_avail);
+
+		kaddr = kmap_local_folio(folio, folio_offset);
+		copied = copy_to_iter(kaddr, copy_amount, iter);
+		kunmap_local(kaddr);
+
+		if (copied != copy_amount)
 			return -EFAULT;
-		size -= n;
+
+		remaining -= copied;
+		folio_index++;
 	}
+
 	return 0;
 }
-- 
2.53.0

