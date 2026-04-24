Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4C3033FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014177; cv=none; b=TU3XFxyGsn7ytS7XRniZDbxZgCC0fAaBkofDIJf5LHHiELelSUGzuOzoqEi/wJ93C3+glnmhl2gWhYthgBVgr3muGl9OazuTONs6GaPLo+8gDQ650fSuNcexHm5IEJNehOjpXEs36MTh2B5QgQAPzMLNRMRdF4xfggnGvWBTYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014177; c=relaxed/simple;
	bh=YCWTzN/i7ucHlXNg2mLVBc9k/4QhjPMBsOtk4DkUkqg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cR0XGyBjHS/mvfz1eX2K6LBqh9OegAmnUouQA2YB4qNPv2Uen9advvidA/diXG/kWPP4OqaES2ORAOOZMOX3n2IH3dY4XhIErDBVThDMF5Jdfz2JM5i6ZIDTtU2U4709F/gLaQA4tY9etcDqgcO8lgEikFEpNmjco5pzPlHuv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5EhU345; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5EhU345"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2dd1c74508cso12169335eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777014175; x=1777618975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zxJZiwOMWb+N8XiOQ98GcOFWZadlOkrX+lM5TYojf0g=;
        b=b5EhU345yPbj+6V4c5uT1CetY1x3cZsn9TWEPpFndI1gYirReesG9RFW+7Z5Gjj80m
         Y0lecuaKNAXB5rbp7A1mAhaGo5afuQbGqrDvz9BTOlBdRqRtnsiv3RWe29NDbqEKiS6v
         k7xW5/EW6WyE0KEAQyjVORWYa5zTPqscGY6at118HDAR52Hgm2BCLuM9VyznuaQ76oKl
         l+Hh89fCkch0N+BlMrdjr/JHgG5m2dV9EFc3XeOCWA+EKQqLcNiY2oL51TQxj8e5Wlg7
         1h7o89XR319ZxQfVJWJs0sG2KeCX3i1JZXdWmQVnU1Y1SbxYKMc2I85XYzcXnW2GSImE
         cZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777014175; x=1777618975;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxJZiwOMWb+N8XiOQ98GcOFWZadlOkrX+lM5TYojf0g=;
        b=m8IIpYUEe+jZeocwqITKMoWWRXSoXQcPHEcKdaXwwVmPvLuw3pFaFCZkOzPnUla8T7
         cy/RUGHxuOp6OtGXnQFpKbRH/cRhFGWL+cdKk3+Ni0AQvs7SqnEjaTU9SwlM5Zqmc7Bl
         Ll6ZxU+7RWYKQY4BSFG/DVhrtzcv+o+RY5woLvv4oR/8P7ALnH2JjuFW5JNkXyYZ8bsj
         5Ez5w1OUcCf67VBr5NHMjr2RadDXvtjwNryarjWaZno3Fij5NIE5Zs+3Pez9bZM6wX3u
         6pFmURJitP0eHxBbj5jajPW2pvinm78JswhwJUjoA+seINdWO/8LXBMSwLH2RRZtiRnt
         xycg==
X-Forwarded-Encrypted: i=1; AFNElJ8jiEmFdNpkbSBCxRR0TD+ilTHlc20w1MlCZJk+dWxTRnZrEZsFDwCMp4lMRkZdZk2cJwJMr0YL0tDJeXpa@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2KpOWJL8bqfUWUB7VFhcD1VX4tD48UWzxnPtxgAXFoxwzpTD
	yaYhz1AjL0kqrKhqkdoHnFDChm3bxGSDhNKGDjRhX0KGQbVGiL6ZmT7scqE/+mD4qXbxjR6bGuq
	j4SwHGw==
X-Received: from dlbcf6.prod.google.com ([2002:a05:7022:4586:b0:12d:b65b:1fb3])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6895:b0:12c:8e7f:1b30
 with SMTP id a92af1059eb24-12c8e7f1ca8mr10233008c88.2.1777014174940; Fri, 24
 Apr 2026 00:02:54 -0700 (PDT)
Date: Fri, 24 Apr 2026 00:02:31 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424070234.190145-1-surenb@google.com>
Subject: [PATCH 0/3] use vma locks for proc/pid/{smaps|numa_maps} reads
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

Applies over mm-unstable.

Suren Baghdasaryan (3):
  fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} under per-vma lock
  selftests/proc: ensure the test is performed at the right page
    boundary
  selftests/proc: add /proc/pid/smaps tearing tests

 fs/proc/task_mmu.c                            | 193 ++++++++++---
 tools/testing/selftests/proc/proc-maps-race.c | 254 ++++++++++++++----
 2 files changed, 354 insertions(+), 93 deletions(-)


base-commit: a22b29c0b1a2a245ef5f782d7456de3c76eb135f
-- 
2.54.0.545.g6539524ca2-goog

