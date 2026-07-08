Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3A27E05E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516752; cv=none; b=biiTb4bVCKZV06g9onlmBBjmqMj98OSDCGHHbFZh+WI3cgOmPOj0S8yl+Z8C+RBtnVOMC707vEOxtKkY73u+R7Y+4zRJPH4YLpizQYPkm1ffxXiiJWs5ABoz7BSWThrVE77cpKIk48w7q9D/BkC1fg/dxFkY+eDlFHY5hmrvtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516752; c=relaxed/simple;
	bh=khux99hI16Pmn0w2E24HzMpdPAY6JQIz65IfIUAFc6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr3+pyzavIz91M2NRbtSRh3n2x6XxwUZ2P9iQiKmoD7qlC+epHt0LRwdPrA2OAGmB/K8hflNGfBKi8tlOtc5W7+lSefvXBWHj7kWuQKQwfULBxbQu2fyQU4KaO6kkdZRKJlme0kiDV7B+ZVlAmvWUZ9MhfDRZrHdZFRunIc3sGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc4p2hwt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc4p2hwt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b966dd74so2600705e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783516749; x=1784121549; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jPTBpbiZPk6aOLJIFZQebV03tKEmWQMIwAHe9coKKdU=;
        b=hc4p2hwtUZV/MN38rBFMK45l9z03jSB91gLvMuR/1vLqep1XnTfz/Ylm2laUB5094o
         OQqrmdHIhBjMuvNjTXapC3ItNDMuMxxEfxoRhoY7QGfcuBBsP/roAK3/aYnGfgngVui+
         Wg+KXLXq3qEw6CgGUo1HX4f86uMwYG0T+zHaTxBicmEWoCYGgj6j/R+Om4jb+o0RNzsL
         0kXeeYxZIurWDKwks19GCaySvw+zUcQezRcVNpiN5dJkL/96NONlqnoIJ+OndQbTK4eA
         reE7YIkswjKjqxhLUZNXJL3wfBkETjtjXFncWxZwo0aKnd+3HUVcp78dwT2vueCRZFAo
         gDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516749; x=1784121549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPTBpbiZPk6aOLJIFZQebV03tKEmWQMIwAHe9coKKdU=;
        b=V1e490YbnGue2/50kliIV2NIhNMhc3/W19FdM2eMAhR8vDvSusxbDMogwRpMzgs6JA
         eDKp35XZUKmSe1CiXb333mdZcArfL8TMieX01IQSTVihe7sBn6BvmQn86l0T+uVPMYkV
         NshnqtHKm+a15MmVCvfl1j5455vkHDuOz7t7cgyva9m9BoBKnek5rNW+qbWfOTeb3iXd
         UgoHRe7eDeGk35Pxynei5q71aV8LhghjdlRIHZN6i+KCY+6FN4CzplFrD6OiyYWGCnOE
         JWfH/XRWmqJYmT8JlyVxqIzPKB8pg8WRP3sI34ouc7znpKmCd6TW2vRnnAkNYxcVThk4
         RCQw==
X-Forwarded-Encrypted: i=1; AHgh+RqBjC1BwSOW4MfPZLjIypn764Kh1a+rV/y9hSX7AppbZmALy4Dec0fhSaCs0CcdhO/uxkfFVqhvw2bfRnUM@vger.kernel.org
X-Gm-Message-State: AOJu0YxPueXeQ8lSzXmni6FsPFXvRGNdqEVnaRKDd6fT4JYB7buFbNPU
	OEky8gGMFD8saLKKZUHi+3YuCk8Q8hFl9hzfJGC+z70BdqfmPYiPcMT5
X-Gm-Gg: AfdE7clOKltiHJtBa3UmhLhwo1b1VkbgTm5LR1Re7IIt5tzV306hOh8E9yCTj65sUsE
	8giR7QuX4oXJdoUhWTFhIdfrdPAvQymqPPjwtHpU/VNH7imnM6t2/ckC2yX92X6hCTP2vaccz7x
	Ct0lETWvnHPIICYhaBm2aCLFDkyyI393H2Vk4tHMf9saNALDwfQ7lq/p2n57FLeY3kv81LTaMg2
	xJTqWlqf2DXX+tidYND74lYUmlv1sj+cNUasjDDf+JjMYY/Fjt1RdM/fLm04CqwPc9E8Jc/B1m0
	pACc7xdUKE3Fm6UovpphseJXjzSeABl9y5M2QsapDCnbKrWwxndN0VHy7ojtxztvt6vDGfJA8GZ
	9NFZsVNwJ+um0WD3Y06wa9V74tEZRfZTHIuqtHly/78yoolwd5Mk2ZU8Yg5E/xloAAIhMkeKLwh
	Thpx2OsfXYO4bJHHMoPpadHM9C4T8cWPhuyLrsVsYBhNhUF+QhsspTi2KDU5f+
X-Received: by 2002:a05:600c:c84:b0:493:aa24:792b with SMTP id 5b1f17b1804b1-493e685fef8mr26304875e9.22.1783516748773;
        Wed, 08 Jul 2026 06:19:08 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e10af392sm146146785e9.2.2026.07.08.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:19:07 -0700 (PDT)
Date: Wed, 8 Jul 2026 15:18:58 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, oleg@redhat.com, josh@joshtriplett.org, Jan Kara <jack@suse.cz>, 
	jlayton@kernel.org, axboe@kernel.dk, shakeel.butt@linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
Message-ID: <rac56njg4yorvhc5oyrme6bt7ej2vs64umbqkz2np32wpjbcjj@wohli2ntub4s>
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
 <CAGudoHFGFJZ_j-osEKnLvGYGai+SKVAJKy8B_PChWms7SN7xoA@mail.gmail.com>
 <ak4rSEAwV-RoG1MO@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ak4rSEAwV-RoG1MO@gmail.com>

On Wed, Jul 08, 2026 at 05:09:19AM -0700, Breno Leitao wrote:
> On Tue, Jul 07, 2026 at 05:29:20PM +0200, Mateusz Guzik wrote:
> > On Tue, Jul 7, 2026 at 5:05 PM Breno Leitao <leitao@debian.org> wrote:
> > >
> > > TL;DR: This simplifies the pipe code, unify the page pools, reduce the
> > > code by 9 lines (not counting comments), and no regressions are seen in
> > > terms of performance.
> > >
> > 
> > This adds an additional acquire + release cycle on the mutex for every
> > write which preallocates, so I don't see how that's supposed to *not*
> > slow things down in some capacity.
> 
> Thanks a lot for the benchmark and the numbers -- a write-heavy pipe
> workload with the reader and writer on separate CPUs is exactly the case
> I wanted to make sure doesn't regress.
> 
> I double-checked it again with your test on different setups and page sizes I
> don't see the regression you are seeing: the bare-metal numbers are
> flat-to-positive at your size.
> 
> I couldn't get my hands on a Sapphire Rapids box easily, so the bare-metal runs
> are on a Cooper Lake Xeon (the same class I used for the cover letter) and
> NVIDIA Grace (arm64). Both hosts are completely idle.
> 
> 1) X86 test
> 
> CPU:  Intel(R) Xeon(R) Platinum 8321HC @ 1.40GHz (Cooper Lake)
>       1 socket / 26 cores / 2 threads = 52 CPUs
>       L3 35.8 MiB (1 instance), single NUMA node (0-51)
>       max freq == base 1.40GHz (no turbo), so the clock is steady
> 
> Bare metal, Intel(R) Xeon(R) Platinum 8321HC, your pipen.c
>    (writer on CPU0, reader on CPU1 -- separate physical cores, same
>    socket, shared L3), blocking pipe, 12 x 8s per point, median MB/s:
> 
>      PIPEN_SIZE   baseline   patched    delta
>        4096         2658       2531      -4.8%   (noise?)
>        32678        3517       3527      +0.3%   (your size -- flat)
>        65536        3072       3358      +9.3%
> 
>    4096 is a single-page write that barely touches the pool; the swing
>    there is inside the run-to-run variance (sd ~100 MB/s on a ~2600
>    median), so I read it as neutral, not a regression. At 32678/65536
>    the variance is small (sd 18-58 MB/s), so those deltas are real.
> 
> 
>  
> 2) Arm64 test:
> 
>  Machine / build:
>     - NVIDIA Grace (Neoverse-V2), 72 cores, 1 socket, no SMT,
>       single NUMA node, ~256 GB RAM
>     - Kernel using 64k pages.
> 
> Results (baseline vs patched):
> 
>   PIPEN_SIZE   pages   baseline   patched   delta    regime
>      65536       1       17759     17683    -0.4%    want=1 → pool covers it, NO extra lock (no-op)
>     131072       2       17583     19734   +12.2%    prefill + extra lock taken
>     262144       4       18781     21017   +11.9%    prefill + extra lock taken
>     524288       8       19061     20886    +9.6%    = pool max; == Similar to Guzik's 32678 (8 pages)
>    1048576      16       16842     17110    +1.6%    pool overflows; == Guzik's 65536 (16 pages)
> 
> 
> Both tests with:
> 	Kernel: linux-next 20260623 base, production .config
> 		(no KASAN / LOCKDEP / DEBUG_* / nothing useless), baseline vs the
> 		full series, both built with clang, coexisting in grub
> 	Test:   your will-it-scale test (pipen.c), PIPEN_SIZE=32678, -t 2
> 		(1 writer + 1 reader on separate cores);
> 		performance governor, writer and reader pinned to two cores
> 
> 
> You're right that there is an extra lock/unlock in the prefill path, so
> I don't want to wave your result away -- may it be specific to SPR's
> topology/cache? 
> 
> I'll also keep trying to grab a Sapphire Rapids machine so I can run your
> will-it-scale case directly on the same uarch, and check if I can reproduce
> it..
> 


I verified the extra lock acquires *do* show up on the profile for me
(with bpftrace -e 'kprobe:osq_lock { @[kstack()] = count(); }'), so this
has to be leaving perf on the table.

However, looking at the diff it seems the extra acquires can be
trivially avoided? See below (untested, consider it an illustration of
what I mean -- if it works as is I'm fine if it gets folded into your
patchset without credit).

diff --git a/fs/pipe.c b/fs/pipe.c
index c163b05ef970..cc4be58aeb5f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -136,7 +136,7 @@ static bool anon_pipe_prealloc_push(struct anon_pipe_prealloc *prealloc,
  * shortfall outside the lock, then briefly take the lock to push the pages in.
  * anon_pipe_get_page() then drains the pool instead of allocating under the lock.
  */
-static void anon_pipe_prefill(struct pipe_inode_info *pipe, size_t total_len)
+static void anon_pipe_prefill_and_lock(struct pipe_inode_info *pipe, size_t total_len)
 {
 	struct page *pages[PIPE_PREALLOC_MAX];
 	unsigned int want, have, need, n = 0;
@@ -147,8 +147,10 @@ static void anon_pipe_prefill(struct pipe_inode_info *pipe, size_t total_len)
 	have = min_t(unsigned int, READ_ONCE(pipe->prealloc.count), want);
 	need = want - have;
 
-	if (!need)
+	if (!need) {
+		mutex_lock(&pipe->mutex);
 		return;
+	}
 
 	while (n < need) {
 		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
@@ -157,14 +159,10 @@ static void anon_pipe_prefill(struct pipe_inode_info *pipe, size_t total_len)
 			break;
 		pages[n++] = page;
 	}
-	if (!n)
-		return;
 
 	mutex_lock(&pipe->mutex);
 	while (n && anon_pipe_prealloc_push(&pipe->prealloc, pages[n - 1]))
 		n--;
-	mutex_unlock(&pipe->mutex);
-
 	/*
 	 * Just flush any extra page that got affected by the TOCTOU
 	 * effect
@@ -174,14 +172,16 @@ static void anon_pipe_prefill(struct pipe_inode_info *pipe, size_t total_len)
 }
 
 /* Trim the pool down to PIPE_PREALLOC_KEEP, freeing the excess unlocked. */
-static void anon_pipe_trim_pool(struct pipe_inode_info *pipe)
+static void anon_pipe_trim_pool_and_unlock(struct pipe_inode_info *pipe)
 {
 	struct page *excess[PIPE_PREALLOC_MAX];
 	unsigned int nexcess = 0;
 
 	/* Unlocked fast path; the count is re-checked under the lock below. */
-	if (READ_ONCE(pipe->prealloc.count) <= PIPE_PREALLOC_KEEP)
+	if (READ_ONCE(pipe->prealloc.count) <= PIPE_PREALLOC_KEEP) {
+		mutex_unlock(&pipe->mutex);
 		return;
+	}
 
 	mutex_lock(&pipe->mutex);
 	while (pipe->prealloc.count > PIPE_PREALLOC_KEEP)
@@ -469,9 +469,7 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	}
 	if (pipe_is_empty(pipe))
 		wake_next_reader = false;
-	mutex_unlock(&pipe->mutex);
-	/* Consumed buffers may have refilled the pool; trim it back. */
-	anon_pipe_trim_pool(pipe);
+	anon_pipe_trim_pool_and_unlock(pipe);
 
 	if (wake_writer)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
@@ -533,8 +531,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	anon_pipe_prefill(pipe, total_len);
-	mutex_lock(&pipe->mutex);
+	anon_pipe_prefill_and_lock(pipe, total_len);
 
 	if (!pipe->readers) {
 		if ((iocb->ki_flags & IOCB_NOSIGNAL) == 0)
@@ -657,8 +654,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 out:
 	if (pipe_is_full(pipe))
 		wake_next_writer = false;
-	mutex_unlock(&pipe->mutex);
-	anon_pipe_trim_pool(pipe);
+	anon_pipe_trim_pool_and_unlock(pipe);
 
 	/*
 	 * If we do do a wakeup event, we do a 'sync' wakeup, because we
