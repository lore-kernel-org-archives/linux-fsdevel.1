Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A213AF2
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777184844; cv=none; b=Gle3eDQJVq266d/tftTQcwdmJg5od0ZljWuMSk3Nz/jA9+QKmB6gur61ROD2KCOHUP2g/z4NQwF0LcfRUZ88KpHLl75i730Rn+e/5CwcxSF982QJYMm7sijzYGORRvkuQQNiEN0bSBx5YKw/NdYR707VEcmPGopzPg51swL3wV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777184844; c=relaxed/simple;
	bh=d6Fqfh2sqoz18f6++7aAjNYJmyLc3qb/WJce7os7Ess=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q/4+YzW5mg5z943ImkApvfSag+bck6FgCphpxdYSnorY15YJp6a07RBYhIPdPRPGkGIgJDiWU67EbgZ/r6AKShm69MwrFnIFEjvJqPD8LSZydpfQdH6SSJB6oE8Ce+5PQOLrhE/1i2HrdimKkMKeoqJTwEaN5nK5rTiRePCo36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzUfynWa; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzUfynWa"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c87ba0890so31290615c88.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 23:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777184842; x=1777789642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x3geMF9pl2AS94E2sOaM47L9pSj3O9H8NiYQAnGXwdc=;
        b=VzUfynWawI8QXb2/9z1QLeEJuf3Tr5JUOJkXItDn6PZwclOwKBQ3KNYnSLI7JGXSFq
         kZtLppnaK9Wa4y3WLBNYhuNkQrYb6NBlf0pEzbAsuDElY0p0DeN40BjnLZOmqEVgy+fP
         CzISKx19mZ2JTdpAY/1w0z5Ta9arLygmuW7tgawU2RjdAdVwWT4ptMWYlRwRgaY4YFxG
         jLBbtY3Bdf+l1T2rnBTiuHC4W2V/XzfDL+I9y6g/bj3cf71bGC7plceqIXgqgkxZzV62
         7+9eOtvx98/gK5vo5Pgxm0+L2qYDpT7TSCNqNZz/i+ttRFD5YuIEykczfl5NIu7R7AX1
         MR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777184842; x=1777789642;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3geMF9pl2AS94E2sOaM47L9pSj3O9H8NiYQAnGXwdc=;
        b=ll4s0txiPx9UY/mdKLip+4f4RdTNWDYboaYwqfdqwz21zoPsj1rXkHm28Nv1frKdGY
         NeLLrHkmE7hh9SCThC75ezQEAZ2RYVDIpLJ2WBSrkeBsGIIQnzJSj/7Zqxfqq5XFlrer
         K1Kz+8e8FnGhsp3p9UlD93CKYSYqdbadm2iwAzeUh+RP2U8MJ+0fOTfjd2Yj5H6Akj54
         jTufNoOLu12FWHIpzWPWyPjv1YCkkZQ/eNPSc7RftTB/FF/diXu/KgpHYRrXk2QFFiT1
         lHVoZpz2dvjzSWmwcy7GWoIy2Oxo45k4HNSCXMnhaNPmyjEe72SZEFEjgsX+s46fFy9F
         /WqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/udi4GhQ/oz4j9GupLOKLWrzTKPIe4q6DxGFQocTpNIZ8+ki3zl5/YGX2fwhk14hhrlhgbXWm5AHRbTq0v@vger.kernel.org
X-Gm-Message-State: AOJu0YwInqPwSwNMMlbUmPxEDt9a6WMF8RNhraTM+X9JTVGVIjIvB97z
	Bpcba+Hg2vv9uqwEYHTMzYWCfA/zKPj7rhoTQCuiKDc41yOJjfsfaaQLX5g5tsCtd0oTWbncHOA
	RXRYRxA==
X-Received: from dlbur21-n2.prod.google.com ([2002:a05:7022:ea55:20b0:12d:c516:f51])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:11c:b0:12b:ec67:3523
 with SMTP id a92af1059eb24-12c73f726eamr19447643c88.9.1777184841793; Sat, 25
 Apr 2026 23:27:21 -0700 (PDT)
Date: Sat, 25 Apr 2026 23:27:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260426062718.1238437-1-surenb@google.com>
Subject: [PATCH v2 0/3] use vma locks for proc/pid/{smaps|numa_maps} reads
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@redhat.com, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Use per-vma locks when reading /proc/pid/smaps and /proc/pid/numa_maps
similar to /proc/pid/maps to reduce contention on central mmap_lock. One
major difference between maps and smaps/numa_maps reading is that the
latter executes page table walk which can't be done under RCU due to a
possibility of sleeping. Therefore we drop RCU read lock before this walk
while keeping the VMA locked. After the walk we retake RCU read lock,
reset VMA iterator and proceed with the next VMA.

The last two patches extend /proc/pid/maps test to cover /proc/pid/smaps
reading during concurrent address space modification.

Changes since v1[1]
- moved drop_rcu earlied in smap_gather_stats to avoid sleeping under
RCU lock in shmem_swap_usage(), per Sashiko
- skip page walks for gate VMA in show_numa_map(), per Sashiko
- introduced parse_vma_line() and copy_line() helper functions to ensure
input string passed to sscanf() is always NUL-terminated, per Sashiko
- used FIXTURE_VARIANT to run both maps and smaps tests in a single
test run, per Liam R. Howlett

Applies over mm-unstable.

[1] https://lore.kernel.org/all/20260424070234.190145-1-surenb@google.com/

Suren Baghdasaryan (3):
  fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} under per-vma lock
  selftests/proc: ensure the test is performed at the right page
    boundary
  selftests/proc: add /proc/pid/smaps tearing tests

 fs/proc/task_mmu.c                            | 195 +++++++++---
 tools/testing/selftests/proc/proc-maps-race.c | 293 ++++++++++++++----
 2 files changed, 387 insertions(+), 101 deletions(-)


base-commit: 761e9fad336afb6fe2cd488c7bd522e2783064fc
-- 
2.54.0.545.g6539524ca2-goog

