Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B74D179B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745604; cv=none; b=o8TjuDMrZT5IMLIm9Hy1VoP4b8QEXE+DtHOFgw3UiwS5bPlR4gxM+mPVndsnIug8USIyxIViYz7pCB1wuyHKI+RlbaWqY2j1sleXNlxY60UayqOdpXP9uCTVZnXUDt7q0brrSivdXhGI2UleMzq5AUQ9sIbdzWAbFK1xuE4mVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745604; c=relaxed/simple;
	bh=jBs4oYy2jX63TwbsrfniBkxZwk5PB6Cf2fYjn0xxSX0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f9qL/t1+ugeclnZo9rFxoKekLzrEL11mZfyBAnDfUEWBt2YoXD4S2VZEu89mcZu9atkExzK+zY2zlsrgoUoJaWWXWTed1wb3OJFn/PzEWzay4esirFpEh+Ohl8dgJqOoFPDOFkOSvY94LwIP2Hx9x02q6DLKj+EWOJMSU8MmnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qN/AnMTm; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qN/AnMTm"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6df0a1e18so15771005ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789745601; x=1790350401; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3o3afKIhDxvUwFzaGiZkLeSCGdh09AvtFvmwbyAEPcg=;
        b=qN/AnMTmkA7/iLLeDTlfpwlHBM8GOb1DZpcO8W9F8hxl3luHFpLjNpKni2Ltbz3ELk
         j2BvYYodnAt7jPFKnhviwL6L/uSk2Iy9Dm1IqdvZn8+jYnJlkApuw8rV5lArKwVrczIT
         RjeKF6sWyd2rHPxfJhZZWkrYjs8E2R0Uyq/TZmhNJjaK+dZYLIJ6QhGCxJ0jhmT1ynt0
         76GMjV7IjSVqFrL4PIZ1yoO/50PMHa5NNrQRoI7Gh15NQoMcolvl0AXQJRjMkzH0wZp/
         Kl3YN04HfCtwRVy4qTYtjExcbheyT7UKycwv70yH3RDiQMM68aUQPBAtiIqwv7p6D+eO
         qvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745601; x=1790350401;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3o3afKIhDxvUwFzaGiZkLeSCGdh09AvtFvmwbyAEPcg=;
        b=f/H8yB8kiXS/zsqc1NP0UsyVev+HiB4xxDfScR3Dt23ODxKfKn7uHjK9DN6wkueFQr
         ytBkJAzhs6plX0wlRYq2vVKEpsR7+6tEmE6R6seGSc5Kjf43oYcKRWiqs4KK96IY2kSU
         QeyBEMKBMwj4GJ7Njhj5qglfBsWswG1rPWcLgHq62ocsV/LGiiq530/FGem9PxNpFdNE
         4KA9QgSnQpobbLjZOGVtpPpvMnb4gXUSCBtMNXQ8mcpIZrxTsrgusU+5xUGChXHZS8gD
         3on41rsqEQhG9lTM1IJfHUl3J6NVyFBP7zH4peg2AZYZMLATzxijphfqMk9vDezszWyM
         5CtA==
X-Forwarded-Encrypted: i=1; AKwUvBybQJ0WAxluKMQHv55RxYvQ9Q+Uex5JPqZHFyQ4Rn4JJjGGjrM5rU2DAyIwPdDxN7enSojBSWhmfHbt9iSz@vger.kernel.org
X-Gm-Message-State: AFuF++n5dk+6Tq4zNvlEtFThntTMXLCz0g02aiw8C0IU+1GIQTHYy2dr
	rtPIneCarAH+JcfqqzU9ju6XVtfMMIV83OHepiAAPXr4TEF9CY1Ygv40sJRN6OkGH41iQVUH6u5
	KKT47jw==
X-Received: from pldu4.prod.google.com ([2002:a17:903:1084:b0:2dd:24d6:a74e])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:a9cb:b0:2dd:c053:e668
 with SMTP id d9443c01a7336-2ddc053e68amr2809575ad.46.1789745601208; Fri, 18
 Sep 2026 08:33:21 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:33:11 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918153318.758387-1-surenb@google.com>
Subject: [PATCH v5 0/7] read proc/pid/smaps_rollup under per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org, 
	willy@infradead.org, jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, 
	xueyuan.chen21@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

proc/pid/smaps_rollup can be read using the combination of RCU and
VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
required to safely traverse the VMA tree and VMA lock stabilizes the
VMA being processed and the pagetable walk.
Note that we have to keep the logic to drop mmap_lock on contention
because even when using per-VMA locks we might have to fall back to
holding the mmap_lock.

The first 5 patches are cleanups making later change simpler. The main
change is in patch 6. Patch 7 extends existing proc-maps-race tearing
test to verify smaps_rollup content.

Changes since v4 [1]:
Patch 2:
- Fixed warnings with CONFIG_PROC_PAGE_MONITOR=n
- Fixed a typo in the changelog
Patch 3:
- Add Reviewed-by and Acked-by, per Lorenzo Stoakes and
  David Hildenbrand
Patch 3:
- Add Reviewed-by and Acked-by, per Lorenzo Stoakes and
  David Hildenbrand

[1] https://lore.kernel.org/all/20260911194145.1781926-1-surenb@google.com/

Suren Baghdasaryan (7):
  proc/task_mmu: remove unnecessary helpers
  proc/task_mmu: remove unnecessary inlines in function definitions
  proc/task_mmu: clarify shmem mapping walk conditions in
    smap_gather_stats()
  proc/task_mmu: remove special-casing of smap_gather_stats() start
    parameter
  proc/task_mmu: change proc_get_vma() to stop returning gate VMA at the
    end
  proc/task_mmu: read proc/pid/smaps_rollup under per-vma lock
  selftests/proc: add /proc/pid/smaps_rollup tearing tests

 fs/proc/task_mmu.c                            | 341 ++++++++----------
 tools/testing/selftests/proc/proc-maps-race.c | 186 +++++++++-
 2 files changed, 336 insertions(+), 191 deletions(-)


base-commit: 854157fc9d011b8dd5a1a86a237447e28d681eb9
-- 
2.55.0.1082.g2b9226bbc0-goog

