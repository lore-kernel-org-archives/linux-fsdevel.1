Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559662;
	b=vLe8a9vTkwshA6nZMDygKh9gcC5Pj0yMZTLMq/JmJgSj+IrXHfMLQUlLleJlYvsctQ87
	 ZFsdrRwNWy70LBxNG/OGzNhDrR/TNiDulXf8L2906TjLkoDlbTyZQAvPVbz5p7AHVGxcl
	 yDoRtCnue8cLMbZWLzPlAFz1S2rhqRR267HPgjeqdNHVN9E9gLa5FaScgFP/hyvUQ1tIr
	 zkl3SmsVQr7wp9DihULQhcB9ulcdxZvA7b8EIvb5dvAZ8CUX4F7DuIWS5hlr0h8FBMCzb
	 aZ/c9M3bevIMkKEbPgwoYxmEvPddTOvFH6SqR2yNhdfk1EEu3vy7OMMGXx/INtYxH1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kLQ59jC4onbwXVg0CZOgL+pik6k+x796O8ohuIxssIM=;
	b=xS9FwekK6lXK9SHtxkgKNdHtGb7ISvQIfH2H7tNwNFYoz+kjDNxjoIfC7DKQWolSEJs+
	 l84MSAzcjuXxLTgqJglg26Oz4N3icArHC3QamGtEp8tth5NgcYG14N3P2c8VW7wzcysba
	 01utAH7ni9to+x/S7PenYf4v+s19ma2k2s37+xmb5/YbTBZYz7oLPh8sgYIEowyw7RGCx
	 Wn7EQ4Q/fE8wiVErJSKzZtSvH9l9QD9VIVdK7xtSnzb8mxahEamRVrgcbmOQhGjMM2VfT
	 UQYwEOVWeKRmlVhvS+sCWqRtvo5yzVNF6op3T9qbckizNGel2PP639hOSVZLW5FdJCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xdolncDw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15716606A325;
	Sun,  1 Nov 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xdolncDw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDD51F000C1;
	Sun,  1 Nov 2026 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793559661;
	bh=kLQ59jC4onbwXVg0CZOgL+pik6k+x796O8ohuIxssIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=xdolncDwxFM9S/Dw11vf+hmkUpwJmqIzOsJcH9B6Xgwk5DZfEQnRV06U9H6pI5djJ
	 gRqMrJTRXdnX41OIVUV9EbzMevIkIQEBAN+Imto92yjXGPzz+KNqV6Hw323M5TKMxh
	 IHuQiO6gsuKgy7eRo/m/OySg1WCC9ngmhhLPWiZ0=
Date: Sun, 1 Nov 2026 11:01:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: david@kernel.org, ljs@kernel.org, jannh@google.com, liam@infradead.org,
 willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de,
 usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org,
 yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in
 /proc/pid/smaps_rollup tearing tests
Message-Id: <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
In-Reply-To: <20261101154503.3203036-1-surenb@google.com>
References: <20261101154503.3203036-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Nov 2026 07:45:03 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> Pss metrics can be affected by map count even if VMA tree stays unchanged,
> therefore tests checking VMA tree integrity can't use them. Use Rss instead
> and pre-populate the VMAs so that Rss changes if a VMA gets skipped or
> double-counted.
> 
> To ensure all test VMAs are populated with anonymous pages, remain
> mergeable across VMA operations, and do not have their Rss changed by
> memory reclaim:
> - Toggle PROT_EXEC instead of PROT_WRITE between adjacent test VMAs so
>   all test VMAs remain writable and MAP_POPULATE faults in anonymous pages
>   (rather than the shared zero page, which is not accounted in Rss).
> - Use mprotect() instead of mmap(..., MAP_FIXED) in split_vma() and
>   merge_vma() so the first page of the split VMA stays resident.
>   mprotect(..., PROT_NONE) splits the VMA without unmapping the first page
>   (pte_present() remains true for PAGE_NONE PTEs), and
>   mprotect(..., self->mod_info->prot) merges it back. Both parts of the
>   split VMA retain their non-zero Rss.
> - Lock all present pages in the child with mlockall(MCL_CURRENT |
>   MCL_FUTURE | MCL_ONFAULT) so memory pressure cannot reclaim pages and
>   alter Rss during the test.
> - In remap_vma(), unlock next_addr before mremap(..., MREMAP_DONTUNMAP)
>   so next_addr is not split, use mmap(..., MAP_FIXED) in patch_vma() to
>   merge the middle VMA back into addr, and exclude smaps_rollup tests
>   from test_maps_tearing_from_remap since remapping moves and unmaps the
>   page from next_addr.

Thanks.  This is proving tricky.

My evolving reviewbot still isn't happy:

: This fixes the v1 RSS issues, but two things remain.
: 
: Alternating PROT_EXEC breaks with READ_IMPLIES_EXEC: both mappings
: become RWX and can merge. A syscall test produced two VMAs instead
: of 16. Could we populate everything writable, then mprotect the odd
: mappings read-only? That preserved all 16 VMAs and avoids zero pages.
: 
: Also, MCL_ONFAULT doesn't bypass RLIMIT_MEMLOCK. If mlockall() fails,
: the child asserts before CHILD_READY and the parent waits until
: timeout. Please arrange a coordinated skip for insufficient allowance.
: 
: The patched userspace test passed all six cases on an existing
: x86-64 6.18.57 kernel, with a PID-namespace adjustment. That kernel
: predates ca5480fb53fa, so this checks selftest behavior, not the
: intended kernel's procfs changes. Separate syscall tests on that
: kernel confirmed the EXEC-merging and memlock failure cases.

I said "no, do it yourself" and it came up with the below.




From: Andrew Morton <akpm@linux-foundation.org>
Subject: selftests/proc: handle personality and memlock constraints
Date: Sun, 01 Nov 2026 10:55:37 -0800

Alternating PROT_EXEC does not keep the test mappings distinct when
READ_IMPLIES_EXEC is set: both protection combinations become RWX and
adjacent mappings can merge, breaking the fixture's layout assumptions.

Populate each mapping writable, then make odd mappings read-only.  This
retains anonymous pages accounted in RSS while keeping adjacent VMAs
distinct regardless of READ_IMPLIES_EXEC.  Restore the corresponding
WRITE-based protection selection in the parent.

Restore the whole three-page destination after remapping, rather than
replacing only its middle page and relying on the remaining anonymous VMAs
to merge.  The remap test no longer compares RSS.

mlockall(MCL_CURRENT) checks the whole virtual size against the locked
memory allowance even with MCL_ONFAULT.  An insufficient allowance makes
the child exit before CHILD_READY, leaving the parent waiting until the
test times out.

Pass the locking error through the existing shared state and signal
CHILD_READY on failure.  The parent reaps the child and releases the
shared state before skipping resource or permission failures.  Check this
status before opening the child's proc files, as it may already have
exited.  Unexpected locking errors remain test failures.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: kernel test robot <yi1.lai@intel.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Vlastimil Babka <vbabka@kernel.org>
---
On top of Suren's v2 "selftests/proc: use RSS in
/proc/pid/smaps_rollup tearing tests".

Tested the userspace test on an existing x86-64 Linux 6.18.57 kernel,
using a separate PID-namespace adaptation which is not in this patch:
- All six cases passed normally and with READ_IMPLIES_EXEC enabled,
  using DURATION=1.
- All six cases skipped promptly with RLIMIT_MEMLOCK set to 64KiB or
  zero, exercising ENOMEM and EPERM respectively.
This does not validate the intended kernel's procfs changes.

 tools/testing/selftests/proc/proc-maps-race.c |   49 +++++++++++-----
 1 file changed, 36 insertions(+), 13 deletions(-)

--- a/tools/testing/selftests/proc/proc-maps-race.c~proc-maps-race-followup
+++ a/tools/testing/selftests/proc/proc-maps-race.c
@@ -174,6 +174,7 @@ typedef bool (*vma_mod_result_check_op)(
 					struct line_content *restored_first_line);
 
 struct vma_modifier_info {
+	int mlock_error;
 	int vma_count;
 	void *addr;
 	int prot;
@@ -696,7 +697,8 @@ static inline bool remap_vma(FIXTURE_DAT
 
 static inline bool patch_vma(FIXTURE_DATA(proc_maps_race) *self)
 {
-	return mmap(self->mod_info->addr + self->page_size, self->page_size,
+	/* Replace all three pieces without relying on anon_vma merging. */
+	return mmap(self->mod_info->addr, self->page_size * 3,
 		    self->mod_info->prot,
 		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) != MAP_FAILED;
 }
@@ -757,22 +759,31 @@ FIXTURE_SETUP(proc_maps_race)
 	self->pid = fork();
 	if (!self->pid) {
 		/* Child process modifying the address space */
-		int prot = PROT_READ | PROT_WRITE;
 		int i;
 
 		for (i = 0; i < mod_info->vma_count; i++) {
-			mod_info->child_mapped_addr[i] = mmap(NULL, self->page_size * 3, prot,
+			mod_info->child_mapped_addr[i] = mmap(NULL, self->page_size * 3,
+					PROT_READ | PROT_WRITE,
 					MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
 			ASSERT_NE(mod_info->child_mapped_addr[i], MAP_FAILED);
-			/* change protection in adjacent maps to prevent merging */
-			prot ^= PROT_EXEC;
+			/*
+			 * Populate writable to get anonymous pages, then alternate
+			 * write permission even with READ_IMPLIES_EXEC enabled.
+			 */
+			if (i % 2)
+				ASSERT_EQ(mprotect(mod_info->child_mapped_addr[i],
+						   self->page_size * 3, PROT_READ), 0);
 		}
 		/*
 		 * Lock all present pages in memory so memory reclaim cannot
 		 * change RSS during the test, and use MCL_ONFAULT so
 		 * mremap() expansion does not populate new pages.
 		 */
-		ASSERT_EQ(mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT), 0);
+		if (mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT)) {
+			mod_info->mlock_error = errno;
+			signal_state(mod_info, CHILD_READY);
+			_exit(0);
+		}
 		signal_state(mod_info, CHILD_READY);
 		wait_for_state(mod_info, PARENT_READY);
 		while (true) {
@@ -799,6 +810,21 @@ FIXTURE_SETUP(proc_maps_race)
 		exit(0);
 	}
 
+	/* Check setup before opening proc files: the child may have exited. */
+	wait_for_state(mod_info, CHILD_READY);
+	if (mod_info->mlock_error) {
+		int error = mod_info->mlock_error;
+		int status;
+
+		ASSERT_EQ(waitpid(self->pid, &status, 0), self->pid);
+		pthread_cond_destroy(&mod_info->sync_cond);
+		pthread_mutex_destroy(&mod_info->sync_lock);
+		munmap(mod_info, self->shared_mem_size);
+		if (error == ENOMEM || error == EPERM || error == EAGAIN)
+			SKIP(return, "Cannot lock test mappings: %s", strerror(error));
+		ASSERT_EQ(error, 0);
+	}
+
 	switch (self->maps_file) {
 	case MAPS:
 		sprintf(fname, "/proc/%d/maps", self->pid);
@@ -815,9 +841,6 @@ FIXTURE_SETUP(proc_maps_race)
 	self->maps_fd = open(fname, O_RDONLY);
 	ASSERT_NE(self->maps_fd, -1);
 
-	/* Wait for the child to map the VMAs */
-	wait_for_state(mod_info, CHILD_READY);
-
 	/* Read first two pages */
 	self->page1.data = malloc(self->page_size);
 	ASSERT_NE(self->page1.data, NULL);
@@ -842,10 +865,10 @@ FIXTURE_SETUP(proc_maps_race)
 	for (int i = 0; i < mod_info->vma_count; i++) {
 		if (mod_info->child_mapped_addr[i] == (void *)self->last_line.start_addr) {
 			mod_info->addr = mod_info->child_mapped_addr[i];
-			mod_info->prot = PROT_READ | PROT_WRITE;
-			/* Odd VMAs have exec permission */
-			if ((i % 2) != 0)
-				mod_info->prot |= PROT_EXEC;
+			mod_info->prot = PROT_READ;
+			/* Even VMAs have write permission. */
+			if ((i % 2) == 0)
+				mod_info->prot |= PROT_WRITE;
 		} else if (mod_info->child_mapped_addr[i] == (void *)self->first_line.start_addr) {
 			mod_info->next_addr = mod_info->child_mapped_addr[i];
 		}
_

