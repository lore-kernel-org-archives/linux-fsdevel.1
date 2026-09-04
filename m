Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AB3EBF02
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524943; cv=none; b=p8O+Ic+dyxYC8C9Gg2x1IQLnOIOi9TQ3kikY0xooXosarYo2pQZQQpe7FE6ZED7sdH1l8XeKvO4bSsjf2IHmOYAfWkfy8jNGq9PFqiNkOkWXVS14vCfrjMzb29pOGnBdliw3z2HQ84U1JzIILKCZnrfOlE5dJGHTVvWZGLWEWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524943; c=relaxed/simple;
	bh=kINVtp9Tcy1uzfSPCqgfZTuR0AXIWvwWWaRfnsIc6rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgAueJG7I0wt3kubiMotGRUK5zcTh1Y1hKljrCON3AMyOV8tzmUqGD+4ZIUxpQQxpk26nh98KhF8mcUguCOcPovnbzRCTE7GI3EncsKjOaU7NkSjGRG/gg9wDGOchpRG7+kcbfJ6IAuqq5V9DG/MdoixvqJ9xod4l9rsl32TvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EPYs0E8o; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EPYs0E8o"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1134573f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788524940; x=1789129740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkKTYWKeG6QUBS922LjHNIJ7+OwGoSgdldmULUcOoY0=;
        b=EPYs0E8o8KX/heV0KahZoy3jtMox1RXJ8SP1/dm/wPYixoCzGnwQx1dbm8QX1gjTe0
         /IAttt2/8h69bIYrLxkRcu497Xp9BDVeHkP4cK78diZLjN/cUVQYiD9Qmiw5Z9e4I7RT
         L4SE9GrUFck4RoI58lltcmxazD8cJmhq2Paeb7roDdHlTMongr4ZjRiZWeHXkmitJ+nP
         WwKivE7/ZRfGlm/5NxK7GUEx7HpracWWEqII2MrD20iGkm/3wBtlr6Y8XahZgcDNJngH
         2rNK7alhy5XbCvuUJZgBUMYBvjQvqJ5lLnPLZoeDlTMCR1DxyTtAXd/cUvNnZcZNuqEv
         mQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524940; x=1789129740;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkKTYWKeG6QUBS922LjHNIJ7+OwGoSgdldmULUcOoY0=;
        b=TVkdT6uvry0Rs4DkrpvaH5WXl285HVrycqtU+4LwhVe6pRkNPZ8nM0Aj8Hb7y+3Du2
         XnMfZez2cuKLR2bggVuE85qn2eTPE00R4LFWjS4Zl4xIapXRvJUFL8yqUKha33x4Von9
         9gaY01RrCfgwLK7JwMzGvrAlMJiVy2q0HLt2BEmA5sgPsYbjQIkVy77PHVtdeCyCbI2p
         U4ZrZTc9p5I8yA6tHtc72TYc4UeKIUgFbDeGhO7ibISZCqdwgR+AjRNYVPxGexqKwUEa
         GJBZ6xjoGP8QwGCLKTMbhjsAY9IRIFw3/G5XQwtNREV+oT2K/9jf08CLYVdwvMJdYu9k
         oA/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxdyhebz/hwlPxE0RrBNY491suTLG/KnbfHLPDOgbkcox4iDjy69mhb4irEWIUFaszVJvEZO32Fkh5ub4Ab@vger.kernel.org
X-Gm-Message-State: AFuF++k6fvZN3HoGchrVUmS2OEIEuyGkXo1ksOTA0eVXRAlVNX/dckKb
	uKtrl/7oxoIKDV+OUG7OYr5/kqBl4lcwOOhshlTeMWLzPrd0Do7m/BM/WOnnT0RT/SM=
X-Gm-Gg: AYBFou1JpbOAPEhmqhvtFQEm89NLlUde9ygXs5MQwxuNlXqD1aBgycEWuE0BR+6i/q5
	gFDkPJ7BlulTfFbWPTLlSVCHDDybUSV2tjhMnqM9AE3A0Ew3nnjM/pdfyxBEM51pO2e9tKsDX7n
	/8rAA6xP2ZV4HXdfvPciFSzZOvKcXZjKj0UL7Et9pFxH2xlTO0elotH04Ne9TSiD4IU1j1FkrGz
	RKcRrYflQ3uq5gFDmS6LEmnnoqnrMbJToZWY8O5nXF9JKC1fKlhgnlenYLC3jf8lGwO70iKHFGP
	a/zZfjnjx+043VeCoHCPdi8C/ogYafVHwix1V8vy/QCF1SpFoDlXRQkG3Iuk7SbOsmUimXXze0H
	qDx62R7tnpMsaNbVR8C9G8IeFQymwITYXXKbMSwWIhDn639LxTCC76mrr3bI5H7GciAuNC9iVCa
	sQJaPcLATURQ0ftvVK0ioNs/Gn+vr74pp9eHvu13kugA0CUNjrwlXWRcCaLt9RWA==
X-Received: by 2002:a05:600c:6087:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49cf81e3454mr99528635e9.4.1788524939473;
        Fri, 04 Sep 2026 05:28:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm153375065e9.4.2026.09.04.05.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:28:58 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:28:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bcrl@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, yi.zhang@huawei.com, sforshee@kernel.org,
	akpm@linux-foundation.org, rostedt@goodmis.org,
	andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, kees@kernel.org, tglx@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Convert barrier pairs to acquire/release for
 better performance
Message-ID: <apq5iLOF8lAQ_ZVU@pathway.suse.cz>
References: <20260902074805.398540-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902074805.398540-1-ruanjinjie@huawei.com>

Adding Risc-V list into Cc.

On Wed 2026-09-02 15:47:57, Jinjie Ruan wrote:
> Hi,
> 
> This series converts some existing smp_wmb()/smp_rmb() barrier pairs to
> smp_store_release()/smp_load_acquire() across various subsystems.
> 
> Background
> ==========
> 
> Many architectures support load acquire and store release instructions
> which can replace explicit memory barriers and save cycles. As noted
> in the ARM architecture reference [1]:
> 
>   "Weaker ordering requirements that are imposed by Load-Acquire and
>    Store-Release instructions allow for micro-architectural
>    optimizations, which could reduce some of the performance impacts
>    that are otherwise imposed by an explicit memory barrier.
> 
>    If the ordering requirement is satisfied using either a Load-Acquire
>    or Store-Release, then it would be preferable to use these
>    instructions instead of a DMB."
> 
> On arm64, a typical seqcount [2] read loop requires 13 cycles with DMB
> barriers. Replacing the read barrier with smp_load_acquire() reduces
> this to 8 cycles on an Ampere Altra.

I wonder if this is true on all other architectures:

  + It seems that Arm gets the gain because the instruction
    does both load/store + barrier. It helps even when
    the barrier is full.

  + Some other architectures need two instructions. One for the
    load/store and the other for the barrier. But the barrier
    is weaker, it synchronizes just reads or just writes.

For example, I see the following in riscv/include/asm/barrier.h:

<paste riscv/include/asm/barrier.h>
#define smp_mb()	RISCV_FENCE(rw, rw)
#define smp_rmb()	RISCV_FENCE(r, r)
#define smp_wmb()	RISCV_FENCE(w, w)

#define smp_store_release(p, v)						\
do {									\
	RISCV_FENCE(rw, w);						\
	WRITE_ONCE(*p, v);						\
} while (0)

#define smp_load_acquire(p)						\
({									\
	typeof(*p) ___p1 = READ_ONCE(*p);				\
	RISCV_FENCE(r, rw);						\
	___p1;								\
})
</paste riscv/include/asm/barrier.h>

I wonder whether:

  + RISCV_FENCE(r, r) is faster than RISCV_FENCE(r, rw)
  + RISCV_FENCE(w, w) is faster than RISCV_FENCE(rw, w)

so it might cause performance regression there...

Best Regards,
Petr

> We also observed significant barrier overhead while profiling Unxibench
> syscall test on arm64: a single getuid() call is ~8ns slower than on
> a comparable x86 system, with the dominant cost in map_id_up()'s smp_rmb(),
> which is a DMB ISHLD on arm64. Converting it to smp_load_acquire() allows
> the use of LDAR, eliminating the measurable overhead.
> 
> This motivated a broader search for existing barrier pairs that can
> be converted to the lighter acquire/release semantics.
> 
> Changes
> =======
> 
> Each patch in this series targets a specific barrier pair where the
> publish/subscribe pattern is already present:
> 
> - Writers populate data, then publish a flag/count/pointer via
>   smp_store_release()
> 
> - Readers load the flag/count/pointer via smp_load_acquire(), then
>   consume the data
> 
> This preserves the existing memory ordering guarantees while allowing
> architectures with native acquire/release instructions (e.g. arm64's
> STLR/LDAR) to avoid the cost of full one-way barriers (DMB ISHST/ISHLD).
> On architectures without native support, the generated code is
> generally no worse than the explicit barrier pair.
> 
> The conversions are mechanical and no functional change is intended.
> 
> Testing (Kunpeng HIP09 arm64 server)
> ====================================
> 
> 1. UNIXBENCH syscall
> 	Baseline: 715.27
> 	Patched:  718.83
> 	Improvement: +0.50%
> 
> 2. fs/aio (fio + null_blk, 4 jobs):
> 	Baseline: 1441k IOPS, 86.46us
> 	Patched:  1452k IOPS, 85.80us
> 	Improvement: ~0.8%
> 
> Both improvements are consistent across runs and align with the
> expected savings from replacing DMB with LDAR/STLR on arm64.
> 
> [1]: https://support.arm.com/documentation/102336/0100/Load-Acquire-and-Store-Release-instructions
> [2]: https://github.com/torvalds/linux/commit/d0dd066a0fa26d55c19ace9e89dedd9504c5bcba
> 
> Changes in v3:
> - Add Reviewed-by.
> - Split out network patch set as Kuniyuki suggested.
> - Link to v2: https://lore.kernel.org/all/20260901024234.135119-1-ruanjinjie@huawei.com/
> 
> Changes in v2:
> - Fix pre-existing issue for ext4 and 8021q [3].
> - Fix missing copy_mnt_idmap() udapte [3].
> - Drop nacked isotp patch.
> - Add test data.
> - Add Reviewed-by and update fs patch as Jan suggested.
> 
> [3]: https://sashiko.dev/#/patchset/20260825095422.3166067-1-ruanjinjie%40huawei.com
> 
> Jinjie Ruan (8):
>   user_namespace: Use acquire/release for nr_extents synchronization
>   lib/vsprintf: Use acquire/release for ptr_key publication
>   fs: aio: Use acquire/release for ring->tail publication
>   fs: Use acquire/release for fdtable resize synchronization
>   pidfs: Use test_bit_acquire() for attr flag tests
>   super: Use acquire for SB_BORN check in super_cache_count()
>   ext4: Fix out-of-bounds read in ext4_get_group_info()
>   ext4: Convert group-count barrier protocol to acquire/release
> 
>  fs/aio.c                | 10 ++++------
>  fs/ext4/balloc.c        |  2 +-
>  fs/ext4/ext4.h          | 10 +++-------
>  fs/ext4/mballoc.c       |  6 ++----
>  fs/ext4/resize.c        | 19 +++++++++++--------
>  fs/file.c               | 10 ++++------
>  fs/mnt_idmapping.c      |  5 ++---
>  fs/pidfs.c              |  6 ++----
>  fs/super.c              |  6 ++----
>  kernel/user_namespace.c | 24 +++++++++++++-----------
>  lib/vsprintf.c          | 11 ++++-------
>  11 files changed, 48 insertions(+), 61 deletions(-)
> 
> -- 
> 2.34.1
