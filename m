Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433C57F74C
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883506; cv=none; b=eQBV8mPkqJpz8EgGCvAEpGNtDZ9XTwQDsFV5ReVCkxLkLCQ6yS0j2VtRC4sWYcQJGhsLX8EfSedk9shbhnu+TPPvc3PVhYj5lCIh0MkpOclaSPP1Hlno9FbCqrxn/RGw+LHNQTvbty03Rp39ItKqvU5TIO3rOSeIfExa6y74wl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883506; c=relaxed/simple;
	bh=wKPqxV2LJIDtPvxueXtuaqpAw1KYruaKoIfgvimOWQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBUikNoH2MpATGPcQ2FSZm/oJP5Bt3DIEkLySesw9N+4Hfg5fTAMNuWDINy4+1sdBWtZhWLRmzCA9R4CPgGXaVeBxGUDh//5mRRSQF02tCS1gJ8U0Ieo2kLCf2ztIY7cf9KAFVD5PzbuViuHpbPPqHWbuFAQCssYMs2s0xNfTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1MkJOJ9; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1MkJOJ9"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85368f1d484so227973b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883504; x=1789488304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EFc84YmPQ7APJ72znZItLC1opm46HMB1M/+k8Tjpgc0=;
        b=S1MkJOJ9Y0YkBBoQZ0KwaEZiDru6Y7Pmdke1NhTBQmx0IdmOCUFxnXgMHWVILUVUlo
         Qa5pOTV9ZoYV/i83gN91DkdLbY3R3Gd9LKA/Ar8lCGTPGRmO1H/N9SH8aE2uEMxDaO+b
         O/nYyAFvO8D3qAtlkGTH4snGcT7AoDUzWYo0teXu4MbrUGFJpq6vvThuM0HEytUydIxQ
         IOorO6lbwOeVEEpa4kNRedhE8VKIjKSZdSS3/bscmodZbvGD30T+UY9P9GKDRtlFQ6WF
         Du6+iC60dhlOelsECzOl/1cNPpWIO9BUBs6MZtI8qG5Rb3AZcvK34M8vY0uPhf393KaB
         5uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883504; x=1789488304;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EFc84YmPQ7APJ72znZItLC1opm46HMB1M/+k8Tjpgc0=;
        b=qH0y5QTWFNrnMjyzR21aWkNn69t0O/eD60O6rYwU6Z+Dh1KBUBZF5Oy5xpwQ/TxfNs
         KvNbfH+pShG5lgboaLST71JP8icYUnSYLKBcodRwvhsU50BlmwRJOgpG0HRm5c5I0Lqe
         PBCrgxNhiySF37PHJtJlymGfV1JHcnFmT4ze7I4117WLhPrDaloSUb9KLydQfzWmZEtf
         CmHrprL6bjZMDrHunoVrWs7qffWdTd8/7P1ovpRrei/KliBVhXeUaauQd19/fCzyGWwJ
         qve8SoSLEWptilKo9+M8XmuxfwscaSwFKNGRjW5rursvOK37Fq2i+gepKrmtRyVtx4sn
         PhEA==
X-Forwarded-Encrypted: i=1; AKwUvBz98qF9I5iml0yD/KV77sZjZ7L0zuU5zOfQrMUt+onAEqlugyUXHzILwv7kKYDeloZ5rvkFRfgVNmdrDkUx@vger.kernel.org
X-Gm-Message-State: AFuF++k84nQIRfk5DgVeKORM6RGIBUDTYSnBEwFcOC/D/C7ybK4mOiIw
	1QgsDe0F4kbpSaHr/8kvlhYgXlNYBdJwU4XH3JI0xdx9Mm28fDR9WY5J
X-Gm-Gg: AYBFou2WyNpCWy0VPk6pb3J1rKeDuxyaLFI33ZD2GpADLWob7+CjjrfwNr4a+R7FTEP
	fBbD9ZM8M1L53zcynBD4QBmRZNJtq2BdReI/jHF5cnOyoEeCn1WenskOiugBcuPCtAYHGvfOSCx
	/pstjnlNhFbNDJv3oljssiKCFdTtjSxUj0SC3aAk5W+8vz/S1xNizzhC1pxVLjro70G0TuvP3qc
	orYM7hqQVCHqjvV4Zre4nvpYhCfWg50Q6LnLqEqxgs9OhajEAmzAU/sV+xlA7VqCV0cuP8T7Rzr
	rGXZ/W2xpJWnhLBblzU/ZVLMzmQwEiRUU0AcCL4d/HCnry++oj3vRQbdB7Y1vn7vKqQcYgGvusX
	iJYNFZQG5yjD+nG5AdjXMQ6yf5Qnb1o/G+mMoOVrGGuB1iUHALaMK9G3mVil+jqXDQZgu2KsnDZ
	XEzVBdHso12S5aEK5awrVXLE2MA51N73bXbxIBqg+tVSe5nM2Gh5xmdl3BfY7TWi9/7VxY0WEXE
	tfgKISAwTjBWEHtRF5DZXn2Jw==
X-Received: by 2002:a05:6a00:4787:b0:863:2fc0:4052 with SMTP id d2e1a72fcca58-8632fc04106mr12652769b3a.2.1788883503595;
        Tue, 08 Sep 2026 09:05:03 -0700 (PDT)
Received: from o6.lan ([240e:391:e05:8d20::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153027951sm5767881b3a.40.2026.09.08.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:05:03 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: surenb@google.com
Cc: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	david@redhat.com,
	willy@infradead.org,
	jannh@google.com,
	paulmck@kernel.org,
	pfalcato@suse.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: Re: [PATCH v2 0/5] read proc/pid/smaps_rollup under per-vma lock
Date: Wed,  9 Sep 2026 00:04:52 +0800
Message-ID: <20260908160452.1548235-1-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907063918.3432401-1-surenb@google.com>
References: <20260907063918.3432401-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Sep 06, 2026 at 11:39:13PM -0700, Suren Baghdasaryan wrote:
>proc/pid/smaps_rollup can be read using the combination of RCU and
>VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
>required to safely traverse the VMA tree and VMA lock stabilizes the
>VMA being processed and the pagetable walk.
>Note that we have to keep the logic to drop mmap_lock on contention
>because even when using per-VMA locks we might have to fall back to
>holding the mmap_lock.
>

Hi Suren,

I tested this series on my arm64 24-core machine, using the same
command:

run-proc-vs-map.sh --nsamples 20 --rawdata -- \
--busyduration 2 --procfile smaps_rollup

baseline:
  Median   Minimum   Maximum
    0.132     0.121     2.600
    0.132     0.123     2.768
    0.132     0.123     2.804
    0.132     0.125     2.835
    0.132     0.125     2.837
    0.132     0.125     2.849
    0.132     0.125     2.858
    0.132     0.125     2.888
    0.132     0.130     2.894
    0.132     0.132     2.896
    0.132     0.132     2.915
    0.132     0.134     2.921
    0.132     0.134     2.927
    0.132     0.137     2.945
    0.132     0.141     2.984
    0.132     0.246     3.004
    0.132     0.270     3.381
    0.132     1.316     3.533
    0.132     1.321     3.551
    0.132     1.343     3.924

patched:
   Median   Minimum   Maximum
    0.006     0.006     1.950
    0.006     0.006     1.955
    0.006     0.006     1.955
    0.006     0.006     1.956
    0.006     0.006     1.956
    0.006     0.006     1.957
    0.006     0.006     1.958
    0.006     0.006     1.959
    0.006     0.006     1.959
    0.006     0.006     1.961
    0.006     0.006     1.962
    0.006     0.006     1.963
    0.006     0.006     1.964
    0.006     0.006     1.966
    0.006     0.006     1.969
    0.006     0.006     1.976
    0.006     0.006     1.982
    0.006     0.006     1.995
    0.006     0.006     1.996
    0.006     0.006     2.043

So the median is 0.132 -> 0.006 ms, about 22x, and the worst case
drops from 3.9 to 2.0 ms.

Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

Thanks,
Xueyuan

>The first 3 patches are cleanups making later change simpler. The main
>change is in patch 4. Patch 5 extends existing proc-maps-race tearing
>test to verify smaps_rollup content.
>
>Changes since v1 [1]
>- removed helper functions which are not needed after per-VMA locks
>became unconditional in [2];
>- added a cover letter, per Lorenzo Stoakes and David Hildenbrand;
>- removed is_mmap_lock_contended() as it's no more needed after [2],
>per David Hildenbrand;
>- fixed typos, per Lorenzo Stoakes and David Hildenbrand;
>- refactored duplicate error checks, per Lorenzo Stoakes;
>- eliminated special case of start=0 in smap_gather_stats(),
>per Lorenzo Stoakes;
>- updated comments, per Lorenzo Stoakes;
>- moved original comment about 4 possible cases when mmap lock is
>dropped into patch 4 changelog;
>- added smaps_rollup testing into proc-maps-race test.
>
>[1] https://lore.kernel.org/all/20260606015729.1837935-1-surenb@google.com/
>[2] https://lore.kernel.org/all/20260813193433.3318288-1-surenb@google.com/
>
>Suren Baghdasaryan (5):
>  proc/task_mmu: remove unnecessary helpers
>  proc/task_mmu: remove unnecessary inlines in function definitions
>  proc/task_mmu: remove special-casing of smap_gather_stats() start
>    parameter
>  proc/task_mmu: read proc/pid/smaps_rollup under per-vma lock
>  selftests/proc: add /proc/pid/smaps_rollup tearing tests
>
> fs/proc/task_mmu.c                            | 280 +++++++-----------
> tools/testing/selftests/proc/proc-maps-race.c | 187 +++++++++++-
> 2 files changed, 291 insertions(+), 176 deletions(-)
>
>
>base-commit: e3fc12b08aadde9cec7b3799ac0e0c9a1aa245c4
>-- 
>2.55.0.979.g7e5102b832-goog
>
>
