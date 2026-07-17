Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B237DE83;
	Fri, 17 Jul 2026 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317201; cv=none; b=qzDXZm/WC9EG3jYxSJJcAi0Vxs40uqCXqAQ0KYJuIqdDmKcJaW4f8pagreuv1z3eeVy/ex3aeVPdJIlVUOpJwy2ISGK+qFO1uasv5sQbHqOWEtDh5GvBw44Ankgi86n3Oa4uOZqc8I48JQpq3i1lXwwPW/UsAPNTAKZ0dzh1qD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317201; c=relaxed/simple;
	bh=2BHBvmEceLpdIMGV6pi05ueLebiOBwEM3DoGVguQTxM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tZhdDGiwqGrovZMNnEzYWC/8ueQwuZybOb8aXpD/0B58pf1R8p5uFpdeQxrjWTxMBKJlIB39x2ckCL72NRaOeHFYAlr2jvnGKhecpoPKSlxuIa4cMryFTBab0Ck6UQaaX7KH3FC3uqoucT8H5p6ndfWjl3Pzxc1xi7KpYg+rYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MwZTrKk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MwZTrKk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3D91F000E9;
	Fri, 17 Jul 2026 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784317199;
	bh=iyfkphrqCeDRYVOH+L7t1qg0gMyCglA6AMvMBV+tJlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MwZTrKk3vTa1tRaaX4wi2tiU/4Vrt4o7NMcor3OxIkZ5EFBHemIIi7ZLnr5ZdnRGf
	 gEFBn9kxOmX12rdjTPzpBi72IDFLyHRCjeG1MGX1YPD25GABaRCY4IAbi16flGaiLW
	 P+mH4TNOiikbaY+skDjOEDSsHu3LFUhXVm8KpI44=
Date: Fri, 17 Jul 2026 12:39:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, David Hildenbrand <david@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mm/mseal: further cleanups
Message-Id: <20260717123958.98f965ed7996804e6157b399@linux-foundation.org>
In-Reply-To: <20260717-mseal-fixups-v2-0-0daa0014b813@kernel.org>
References: <20260717-mseal-fixups-v2-0-0daa0014b813@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 18:27:08 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> 
> The mseal implementation is still rather confusing, so tighten things up a
> little.
> 
> The only user of do_mseal() outside of the system call is the MMAP_PAGE_ZERO
> process personality - retain better control over how mseal is utilised by
> providing mseal_mmap_page_zero() for this instead.
> 
> The comments are overly long and confusion, so cut them down so they're a lot
> clearer.
> 
> Remove confusing mm_struct params (mseal can not be used on remote mm's) and
> wrap the actual system call logic into the system call declaration.

Thanks, I've updated mm-new to this version.

> v2:
> * Added tags (thanks everyone!)
> * Abstracted mm as per David.
> * Renamed [__]mseal() to [__]mseal_range() as per Pedro.
> * Moved to reverse xmas tree declarations.
> * Tweaked commit message for 2/3.

Here's how v2 altered mm.git:

 mm/mseal.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/mm/mseal.c~b
+++ a/mm/mseal.c
@@ -18,9 +18,9 @@
 
 static bool range_contains_unmapped(unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *vma;
-	unsigned long prev_end = start;
 	VMA_ITERATOR(vmi, current->mm, start);
+	unsigned long prev_end = start;
+	struct vm_area_struct *vma;
 
 	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_start > prev_end)
@@ -32,10 +32,10 @@ static bool range_contains_unmapped(unsi
 	return prev_end < end;
 }
 
-static int __mseal(unsigned long start, unsigned long end)
+static int __mseal_range(unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *vma, *prev;
 	VMA_ITERATOR(vmi, current->mm, start);
+	struct vm_area_struct *vma, *prev;
 
 	/* We know there are no gaps so this will be non-NULL. */
 	vma = vma_iter_load(&vmi);
@@ -66,7 +66,7 @@ static int __mseal(unsigned long start,
 	return 0;
 }
 
-static int mseal(unsigned long start, unsigned long end)
+static int mseal_range(unsigned long start, unsigned long end)
 {
 	int err;
 
@@ -76,7 +76,7 @@ static int mseal(unsigned long start, un
 	if (range_contains_unmapped(start, end))
 		err = -ENOMEM;
 	else
-		err = __mseal(start, end);
+		err = __mseal_range(start, end);
 	mmap_write_unlock(current->mm);
 	return err;
 }
@@ -92,7 +92,7 @@ void mseal_mmap_page_zero(void)
 	if (WARN_ON_ONCE(!(current->personality & MMAP_PAGE_ZERO)))
 		return;
 
-	err = mseal(0, PAGE_SIZE);
+	err = mseal_range(0, PAGE_SIZE);
 	if (err)
 		pr_warn_ratelimited("pid=%d, couldn't seal address 0, ret=%d.\n",
 				    task_pid_nr(current), err);
@@ -139,5 +139,5 @@ SYSCALL_DEFINE3(mseal, unsigned long, st
 	if (end == start)
 		return 0;
 
-	return mseal(start, end);
+	return mseal_range(start, end);
 }
_

