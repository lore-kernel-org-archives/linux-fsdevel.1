Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216F49C4AB;
	Tue,  8 Sep 2026 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911158; cv=none; b=LLYmgtx9L+UTx4f3GdJSSl/Sr7MzjXkf4bNCtTU7a/n7ztHZOoJS1QHrPf35BV8yIz2yjX9C95vNb5vHCP9zdKmk+Uxj0nteGTt/MkBy+0ZDLZzaSUPrzUVQyczIGw3yPafSahfukKwqCXJ5fyodApAzCmxGwjdN328vL+wOUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911158; c=relaxed/simple;
	bh=g7Ky83TgOwFbsOHyvgijjGXpRNo2425Nq4phshWzA7k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bst/v+1fgtMkYE+mUgUFRuZ0BXKBvhURtunqSj+zfkLGU7ZFR2XCP6DhJ3c+0dvhQkGVEew7wzikKxShtm52wkxu/B81AJNSlI8ffxee4NS/JIpYwUMtNz4GRj1HjWw3jNRGMgiAlCaGul6VZe9m2CA6KUZSNXtM1FY0OCRBv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LtxwYooG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LtxwYooG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8271F00A3A;
	Tue,  8 Sep 2026 23:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788911156;
	bh=YluYVMKByfxU0jhrfhAXdNg+GL+9Wi7y0AV09M0/EDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LtxwYooGM1HHVGcczPSCT9m8ZaErT53MmLnTvSFuygid+bQEwhZaASugrIOMh12pD
	 BrNacsADi+fSErVF+GHr0LqnyguMwRdXSGWtF+phvEdI9KqZvARfPvq5h/w+cB/3aZ
	 wa+Qr1QYe4BOmgodLgUdQd7EiEJygMD8PJDEeKSU=
Date: Tue, 8 Sep 2026 16:45:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro
 Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/6] mm: make MAP_PRIVATE-/dev/zero mappings truly
 anonymous
Message-Id: <20260908164555.50a996a3f716523ddc13fbfb@linux-foundation.org>
In-Reply-To: <20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org>
References: <20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 12:23:37 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Historically anonymous memory was obtained in linux by MAP_PRIVATE-mapping
> /dev/zero.
> 
> The canonical way of doing these now is mmap() specifying MAP_PRIVATE |
> MAP_ANON, but we must continue to support the legacy means of obtaining these
> mappings.
> 
> As-is these mappings are an unusual edge-case - they satisfy
> vma_is_anonymous() but have non-NULL vma->vm_file, and their page offset is
> the offset into the /dev/zero file.
> 
> Commit 93c0c8dc87f6 ("mm/rmap: use anon pgoff to track MAP_PRIVATE
> file-backed anon folios") causes all other anonymous folios to be tracked
> by their anon index (vma->vm_start >> PAGE_SHIFT at the point of first
> fault), leaving MAP_PRIVATE-/dev/zero as the outlier.
> 
> This series remedies the situation by making MAP_PRIVATE-/dev/zero mappings
> truly anonymous with !vma->vm_file and correct anonymous page offset.
> 
> It starts by bringing the memory character driver into mm/ - this file
> implements /dev/zero, /dev/mem among other things and is already (as
> clearly indicated by its name) within the remit of memory management.
> 
> By doing this, the file_is_dev_zero() function can be provided, internal to
> mm, which allows for positive identification of these mappings.
> 
> Using this, first prevent any other mappings from mapping memory
> anonymously, then make these mappings truly anonymous and eliminate all
> code in the kernel that previously had to account for these strange beasts.
> 
> Finally, it adds userland VMA tests to assert the behaviour and selftests
> to assert expected merge behaviour.

Thanks, I've updated mm-unstable to this version.

> v2:
> * Added tags (thanks everybody!)
> * Reworked comment about mappings not setting themselves anon as per David.
> * Fixed up test typo as per David.
> * Fixed up test close() as per David.

Here's how v2 altered mm.git:

--- a/mm/vma.c~b
+++ a/mm/vma.c
@@ -2801,7 +2801,7 @@ static int call_mmap_prepare(struct mmap
 	if (err)
 		return err;
 
-	/* Hooks cannot mark themselves anonymous. */
+	/* It's invalid for mmap_preprare hooks to clear vm_ops. */
 	if (!desc->vm_ops)
 		return -EINVAL;
 
--- a/tools/testing/selftests/mm/merge.c~b
+++ a/tools/testing/selftests/mm/merge.c
@@ -1381,7 +1381,7 @@ TEST_F(merge, merge_map_private_dev_zero
 	 *
 	 * With these being made truly anonymous upon mapping, they will
 	 * merge. If they were file-backed VMAs the page offsets would prevent
-	 * merge:
+	 * the merge:
 	 *
 	 * |-----||------|    |-------------|
 	 * | ptr || ptr2 | -> |     ptr     |
@@ -1389,17 +1389,11 @@ TEST_F(merge, merge_map_private_dev_zero
 	 */
 	ptr = mmap(carveout, 5 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
-	if (ptr == MAP_FAILED) {
-		close(fd_zero);
-		ASSERT_TRUE(false);
-	}
 	ptr2 = mmap(&carveout[5 * page_size], 5 * page_size,
 		   PROT_READ | PROT_WRITE, MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
-	if (ptr2 == MAP_FAILED) {
-		close(fd_zero);
-		ASSERT_TRUE(false);
-	}
 	close(fd_zero);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ASSERT_NE(ptr2, MAP_FAILED);
 
 	/* Assert that they merged. */
 	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
@@ -1430,10 +1424,7 @@ TEST_F(merge, merge_map_private_dev_zero
 	 */
 	ptr = mmap(carveout, 15 * page_size, PROT_READ | PROT_WRITE,
 		   MAP_FIXED | MAP_PRIVATE, fd_zero, 0);
-	if (ptr == MAP_FAILED) {
-		close(fd_zero);
-		ASSERT_TRUE(false);
-	}
+	ASSERT_NE(ptr, MAP_FAILED);
 	memset(ptr, 'x', 15 * page_size);
 
 	/*
_

