Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD14AC147
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155730; cv=none; b=Wuub+mkPj2vo62ZNVyy4d9PVVphWsORfz05muBSxYqg3eV4UqxLGzbUsJ4Uw+pOILBxcQ9F3EqUky8Uyx6VYd24+Bx/3XJLoi4YCpq/CfDNe/aiCVA0Eit0zcXqXgNVUdwMqI69WO9WMqVK0AbmyncZmniYqBKZuCTK07fAJ1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155730; c=relaxed/simple;
	bh=v8OiTYvm9jLxwoItXDWbhS4/9qcPWVaZ1YVyRZglHA0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Eazuz9zuiMZmLNLBT69DClff2gH8hFimNC3usYaJLy6vsKCmmaCyY9eu+BnteNg0NdKQ5L9fOv0PiLOvChheLf9wBtVJvZziELjFqZwdJ54TbmYhrPHS1A+BqtH3HSsYe+CHKA1NfahxjiW/FtjtH3Ink98TWXIiOLAXok+cxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GONemXH4; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GONemXH4"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4c1fc9ceaso1167532a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155709; x=1789760509; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFnX3s9ttQtORT13US/ARsVw733vFoBxkxITzrUPh78=;
        b=GONemXH4RWP5RrIgHpYK33E0H+Uz7nZrMV6O4OFKWlizAyZXnoQb1DXW8txFzWvQFa
         qXO9fKR2EWl8PAW2eWCBW2hYLQxKzgwSfa1nmXwLpCxeHNHKeKq7C5PAYt5gKp8dhoVx
         rr4/Xjtms9mIaZZ/ITkMyqQw6MDuXTUpfKGfc+BuxMnlJkRUMOeAOLeBobH7bHuCcvAI
         nTHamENzupCNX9zjiq3fFRd4I72mhwFY0v3/vValQLU2aTVK4dhSLoCxvDQXjijRl69b
         GGkX5yx81Op1bhAhqjUAt7wYFkAj7OfqfkFmj7XcFMgLk0/BWfzWMcqJeJGhTBwBuA+E
         uPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155709; x=1789760509;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFnX3s9ttQtORT13US/ARsVw733vFoBxkxITzrUPh78=;
        b=rlJA42aS+ndkfLt6Yf3m1nGni8DLZQg3rUH7q4/cYfC6P1rOzIs0kDyGTDQSB0M9/j
         zEddesVLz5jEfpndB16gILhtjwvDpyLXRaEuMleZsmW/yhit5DONHDuPeKCwzM76YAfz
         he7c8WAkN4yPIK9EWqRB/bSMyjq0ABVeU7IIaendwyiM+dQBUj28eCVlfWstaBeMXKsu
         Oods28p1fEZeeOQ7D4JozDLKKbZggjZwvAABId1QM+uMx6mSVjtZutG+45MpIU2OVwqv
         tSybT0OAPk8463PH51nxmev8l3dmV4qayzpoRi9dxKgpSjb/m0FrmC/PllkO8oV9t0dl
         9Nww==
X-Forwarded-Encrypted: i=1; AKwUvBxJaqE/HLCfTJlvg2E9L6ae9lmmTobY9ptuH515bj0o2yeH4Di65GictJ1OSfEHdyGEz2RoqyNiOcCo9f+I@vger.kernel.org
X-Gm-Message-State: AFuF++nhoz0Jx2aX73zhUA7VI9LGeMnC/pkT44nSDDOxUvHhwxh7lc+g
	vPojbRb1OuBPQ42VC5DMkcYQGD+iUB8fi9zByff/0fCgeMHAlG1zWtHo/8DmmRBPxjj+OqI52Ys
	anI6a1A==
X-Received: from dld34.prod.google.com ([2002:a05:7022:322:b0:141:6ffa:3579])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3391:b0:3cc:b26a:7686
 with SMTP id adf61e73a8af0-3daed1515f5mr11763572637.6.1789155709034; Fri, 11
 Sep 2026 12:41:49 -0700 (PDT)
Date: Fri, 11 Sep 2026 12:41:38 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911194145.1781926-1-surenb@google.com>
Subject: [PATCH v4 0/7] read proc/pid/smaps_rollup under per-vma lock
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

Changes since v3 [1]:
Patch 2:
- Added Acked-by, per David Hildenbrand
Patch 3:
- Moved conversion of (start != 0) to is_partial into the next patch,
  per Lorenzo Stoakes
Patch 4:
- Moved conversion of (start != 0) to is_partial into the next patch,
  per Lorenzo Stoakes
- Converted multiple lines of arguments in modified functions to
  two-tab indents, per David Hildenbrand
- Introduced smap_gather_stats_range() for partial VMA walks,
  per Lorenzo Stoakes
Patch 5:
- Added Reviewed-by and Acked-by, per David Hildenbrand and
  Lorenzo Stoakes
- Added a comment explaining the check for SENTINEL_VMA_GATE in m_start,
  per Lorenzo Stoakes
Patch 6:
- Added Reviewed-by, per Lorenzo Stoakes
Patch 7:
- Converted multiple lines of arguments in modified functions to
  two-tab indents
- Added Acked-by, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20260910234737.1340642-1-surenb@google.com/

Patchset applies over mm-new branch.

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

 fs/proc/task_mmu.c                            | 339 ++++++++----------
 tools/testing/selftests/proc/proc-maps-race.c | 186 +++++++++-
 2 files changed, 334 insertions(+), 191 deletions(-)


base-commit: 1f78f28a2945f9e856b4ea8428ac41a6788e4b67
-- 
2.55.0.1007.g17ff1f9808-goog

