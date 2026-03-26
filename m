Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6734EF03;
	Thu, 26 Mar 2026 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489653; cv=none; b=kG/qTI+2g/xP0PsoNN7OEdw1gA5xp+Y/RvF77ZW4B62vL4bgOGQ4boUjRrAkbiA4aX0W1+sknoAPX+UFZ/2SjshjNYPq5OMmsgdSi4i4imUpFtn1hcabeHoD8uGs7frLjtCvtmNwKbqYig+cHuOIbukG/268lFdli61/fQILca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489653; c=relaxed/simple;
	bh=EW9TUvgR9VGdaSKo9kQFZS2JNfhcVmdVBa0AARxk664=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hO8osP7HPbkf7BOch0wrM4OwIyfE98/PRDSGSlVagUec+6pkepYeZcRsXYm+hc2yuGhtbKSCBp9i6wnSnzjrppNDqMlOQxZ3ZROAmsV9nqR3XV5SttCG957L832agWWPzp2WUOF1Hx2yRuzPRJDtYaFZziS39ZXX/F7weqKtI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jtj7IzO+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jtj7IzO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7919BC4CEF7;
	Thu, 26 Mar 2026 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774489653;
	bh=EW9TUvgR9VGdaSKo9kQFZS2JNfhcVmdVBa0AARxk664=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jtj7IzO+dpHanbe/iwWtGWloyTziBit4y3ySohvy9/DF+oCh3FqkDQeGT3rEusXIw
	 dCx7Nnk/JUIet4yTVIr3Ca9RumAM1HMst7c7+cxAiv84P5Oe6DzMJT658wH10XAjym
	 TXtGp+m9kQGevYT12KZ+gx7Z/PVBVF80RYs7qO1E=
Date: Wed, 25 Mar 2026 18:47:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Matthew Wilcox
 <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>, Eero Kelly
 <eero.kelly@dfinity.org>, Andrew Battat <andrew.battat@dfinity.org>, Adam
 Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] selftests/mm: add folio_split() and
 filemap_get_entry() race test
Message-Id: <20260325184731.791eda3b81cee4ad3f3ec17e@linux-foundation.org>
In-Reply-To: <20260323163717.184107-1-ziy@nvidia.com>
References: <20260323163717.184107-1-ziy@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 12:37:17 -0400 Zi Yan <ziy@nvidia.com> wrote:

> The added folio_split_race_test is a modified C port of the race condition
> test from [1]. The test creates shmem huge pages, where the main thread
> punches holes in the shmem to cause folio_split() in the kernel and
> a set of 16 threads reads the shmem to cause filemap_get_entry() in the
> kernel. filemap_get_entry() reads the folio and xarray split by
> folio_split() locklessly. The original test[2] is written in rust and uses
> memfd (shmem backed). This C port uses shmem directly and use a single
> process.
> 
> Note: the initial rust to C conversion is done by Cursor.

Thanks for the poke, I did indeed miss this.

I'll toss the previous version and its three -fixes.  {lease check that
those -fixes were incorporated here.

Here's how v5 alters mm.git.  It's quite a large update.


 tools/testing/selftests/mm/folio_split_race_test.c |   95 +++++------
 1 file changed, 44 insertions(+), 51 deletions(-)

--- a/tools/testing/selftests/mm/folio_split_race_test.c~a
+++ a/tools/testing/selftests/mm/folio_split_race_test.c
@@ -44,8 +44,8 @@ uint64_t pmd_pagesize;
 /* Shared control block: control reading threads and record stats */
 struct shared_ctl {
 	atomic_uint_fast32_t stop;
-	atomic_size_t reader_failures;
-	atomic_size_t reader_verified;
+	atomic_uint_fast64_t reader_failures;
+	atomic_uint_fast64_t reader_verified;
 	pthread_barrier_t barrier;
 };
 
@@ -59,7 +59,7 @@ static void fill_page(unsigned char *bas
 }
 
 /* Returns true if valid, false if corrupted. */
-static bool check_page(unsigned char *base, size_t page_idx)
+static bool check_page(unsigned char *base, uint64_t page_idx)
 {
 	unsigned char *page_ptr = base + page_idx * page_size;
 	uint64_t expected_idx = (uint64_t)page_idx;
@@ -68,7 +68,7 @@ static bool check_page(unsigned char *ba
 	memcpy(&got_idx, page_ptr, 8);
 
 	if (got_idx != expected_idx) {
-		size_t off;
+		uint64_t off;
 		int all_zero = 1;
 
 		for (off = 0; off < page_size; off++) {
@@ -78,15 +78,19 @@ static bool check_page(unsigned char *ba
 			}
 		}
 		if (all_zero) {
-			ksft_print_msg(
-				"CORRUPTED: page %zu (huge page %" PRIu64 ") is ALL ZEROS\n",
-				page_idx,
-				(page_idx * page_size) / pmd_pagesize);
+			ksft_print_msg("CORRUPTED: page %" PRIu64
+				       " (huge page %" PRIu64
+				       ") is ALL ZEROS\n",
+				       page_idx,
+				       (page_idx * page_size) / pmd_pagesize);
 		} else {
-			ksft_print_msg(
-				"CORRUPTED: page %zu (huge page %" PRIu64 "): expected idx %zu, got %" PRIu64 "\n",
-				page_idx, (page_idx * page_size) / pmd_pagesize,
-				page_idx, got_idx);
+			ksft_print_msg("CORRUPTED: page %" PRIu64
+				       " (huge page %" PRIu64
+				       "): expected idx %" PRIu64
+				       ", got %" PRIu64 "\n",
+				       page_idx,
+				       (page_idx * page_size) / pmd_pagesize,
+				       page_idx, got_idx);
 		}
 		return false;
 	}
@@ -97,8 +101,8 @@ struct reader_arg {
 	unsigned char *base;
 	struct shared_ctl *ctl;
 	int tid;
-	atomic_size_t *failures;
-	atomic_size_t *verified;
+	atomic_uint_fast64_t *failures;
+	atomic_uint_fast64_t *verified;
 };
 
 static void *reader_thread(void *arg)
@@ -107,9 +111,9 @@ static void *reader_thread(void *arg)
 	unsigned char *base = ra->base;
 	struct shared_ctl *ctl = ra->ctl;
 	int tid = ra->tid;
-	atomic_size_t *failures = ra->failures;
-	atomic_size_t *verified = ra->verified;
-	size_t page_idx;
+	atomic_uint_fast64_t *failures = ra->failures;
+	atomic_uint_fast64_t *verified = ra->verified;
+	uint64_t page_idx;
 
 	pthread_barrier_wait(&ctl->barrier);
 
@@ -154,14 +158,14 @@ static void create_readers(pthread_t *th
 }
 
 /* Run a single iteration. Returns total number of corrupted pages. */
-static size_t run_iteration(void)
+static uint64_t run_iteration(void)
 {
-	size_t reader_failures, reader_verified;
+	uint64_t reader_failures, reader_verified;
 	struct reader_arg args[NUM_READER_THREADS];
 	pthread_t threads[NUM_READER_THREADS];
 	unsigned char *mmap_base;
 	struct shared_ctl ctl;
-	size_t i;
+	uint64_t i;
 
 	memset(&ctl, 0, sizeof(struct shared_ctl));
 
@@ -195,7 +199,7 @@ static size_t run_iteration(void)
 		if (madvise(mmap_base + i * page_size,
 			    PUNCH_SIZE_FACTOR * page_size, MADV_REMOVE) != 0) {
 			ksft_exit_fail_msg(
-				"madvise(MADV_REMOVE) failed on page %zu: %d\n",
+				"madvise(MADV_REMOVE) failed on page %" PRIu64 ": %d\n",
 				i, errno);
 		}
 
@@ -214,7 +218,7 @@ static size_t run_iteration(void)
 	reader_verified = atomic_load_explicit(&ctl.reader_verified,
 					       memory_order_acquire);
 	if (reader_failures)
-		ksft_print_msg("Child: %zu pages verified, %zu failures\n",
+		ksft_print_msg("Child: %" PRIu64 " pages verified, %" PRIu64 " failures\n",
 			       reader_verified, reader_failures);
 
 	munmap(mmap_base, FILE_SIZE);
@@ -242,13 +246,15 @@ static void thp_settings_cleanup(void)
 int main(void)
 {
 	struct thp_settings current_settings;
-	bool failed = false;
-	size_t failures;
-	size_t iter;
+	uint64_t corrupted_pages;
+	uint64_t iter;
 
 	ksft_print_header();
 
-	if (!thp_is_enabled())
+	page_size = getpagesize();
+	pmd_pagesize = read_pmd_pagesize();
+
+	if (!thp_available() || !pmd_pagesize)
 		ksft_exit_skip("Transparent Hugepages not available\n");
 
 	if (geteuid() != 0)
@@ -268,37 +274,24 @@ int main(void)
 
 	ksft_set_plan(1);
 
-	page_size = getpagesize();
-	pmd_pagesize = read_pmd_pagesize();
-
 	ksft_print_msg("folio split race test\n");
-	ksft_print_msg("===================================================\n");
-	ksft_print_msg("Shmem size:       %" PRIu64 " MiB\n", FILE_SIZE / 1024 / 1024);
-	ksft_print_msg("Total pages:     %" PRIu64 "\n", TOTAL_PAGES);
-	ksft_print_msg("Child readers:   %d\n", NUM_READER_THREADS);
-	ksft_print_msg("Punching every %dth to %dth page\n", PUNCH_INTERVAL,
-		       PUNCH_INTERVAL + PUNCH_SIZE_FACTOR);
-	ksft_print_msg("Iterations:      %d\n", NUM_ITERATIONS);
-
-	for (iter = 1; iter <= NUM_ITERATIONS; iter++) {
-		failures = run_iteration();
-		if (failures > 0) {
-			failed = true;
-			ksft_print_msg(
-				"FAILED on iteration %zu: %zu pages corrupted by MADV_REMOVE!\n",
-				iter, failures);
+
+	for (iter = 0; iter < NUM_ITERATIONS; iter++) {
+		corrupted_pages = run_iteration();
+		if (corrupted_pages > 0)
 			break;
-		}
 	}
 
-	if (failed) {
-		ksft_test_result_fail("Test failed\n");
-		ksft_exit_fail();
-	} else {
+	if (iter < NUM_ITERATIONS)
+		ksft_test_result_fail("FAILED on iteration %" PRIu64
+				      ": %" PRIu64
+				      " pages corrupted by MADV_REMOVE!\n",
+				      iter, corrupted_pages);
+	else
 		ksft_test_result_pass("All %d iterations passed\n",
 				      NUM_ITERATIONS);
-		ksft_exit_pass();
-	}
+
+	ksft_exit(iter == NUM_ITERATIONS);
 
 	return 0;
 }
_

