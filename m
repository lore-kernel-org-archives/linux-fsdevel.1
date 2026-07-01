Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F1337BBD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944498; cv=none; b=Bb71h2ynVo/Va3fnSybbVu1DhCimaEjyAl6vZ6CObWK15mu1tNiGZ24GPCG12/bBa0K9Qm6X6YgfMMS74AH0GZjZCMNjbfRHDvDCU4sm4IxIp4lnc7sy5+XWjb7XKhplW3PS5CvzRa5wEeXwubAtjMyyoiSWZyGA4K5pjjYw0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944498; c=relaxed/simple;
	bh=yJOSEoy8sWsXcxdQIXpUWpA881MN+YVUpBL5IK2Xm4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sbeYRq1JH0A0JLkwGTCpbsVjR0HBPQ5RcdwMhHF4XGqdHOwwV7BbXB8uZqZiTYs7nmAlyS77IDc5L78QX05bAt3cqUcvM8VtDa+Bi4vctwlndY5BEdcr2eOJgGIwZK/QG1Z4AN8ayNQ3j4vhPmzAcARW2ZZFtENF6/OWOEbNfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=g3ikBhyz; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="g3ikBhyz"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51a868b6962so10460411cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782944495; x=1783549295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly94HkQriumv5CAnLiirr4F1XjBYwwHktI6gudLRhmE=;
        b=g3ikBhyzwnndsKk1sfOLAyyuus9MsCUwTcYpcPeNpC25BvkLHam0tPCdXgWpzOpTd1
         d81Oxmk73yWPHpeegbqZMNJuRm/6Htvd7iQnVXhVr9dyGEIhBWyy9g3l4Ohli25QYMvV
         lWVUJBgvWcj2TOPYAyo0OPMVhsNVs0YImy1PJR3CQYJisqbLqEYEmwZWaDuDK9xif7tp
         IqHq+HJansdJjIQhpxkOU/qDoYH+kkSJ5Jxo0yQRpsuY8uoHEOnw5FSxfbmujv0IaXmT
         +m519xzcvMrkJwxcEDqbwRFcCO8hwW17aQKlXbPLqchZh2KB9M/+y2WM2Qb/V5NukyzM
         inIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944495; x=1783549295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly94HkQriumv5CAnLiirr4F1XjBYwwHktI6gudLRhmE=;
        b=JS58y1kcZe6D+wl98xoZbwMu0kOgubaf8ixLMDjtvsGqg+spSNDo3QCjWhG0VrfcLR
         OHRoPST545mc+R2XHSuA8ylkyR0a38BoWGa8A+Mmf8grfn/PLrBZgH96nTZIDxY/i0Ho
         jt61BHHXCMELWMquMk4k9d610bMPwCNihJ6AgE3AJ1oLmFNJy1WV4EGolMWzaxci5R+Y
         Sof/tLaD/00cyGcvcJby3u1c7gn7c6gyhdL1h2utCbI15Cc9sMjmJuD0EHy80BHhGbUT
         f9efiyJ9m65g45dKXU9tFrNPm7RmahJ3oIqEF2gyQsALoAgxh/SZEFs1g4xCcfhqBIbL
         p3PQ==
X-Forwarded-Encrypted: i=1; AFNElJ8q2S0ozDI3XIK89dsEssUFcA6yoheLoVR8Vh4zaBpQNJfN0b8mT4M2vRJde1HRPAa0uGRoY8taaSiLRNA5@vger.kernel.org
X-Gm-Message-State: AOJu0YxP19Js0vcI2ey9COgNouDb3pMGBEApP3ehfuhP9hKZVJuRwEHa
	grY8fY31zR0dIyrYgYjZ3V1+hNxrlIxVN9Nb+Frs1WOerzugESZ9NQ8mK0gl7ahmM5A=
X-Gm-Gg: AfdE7cmDIc/4i7MUQe9kEdrarD9Se2o18PZPgGrQjI4m/Tun7erPW1KDJX9jcynybq1
	bdzhbF3X0WX0WJt0wHS0voEkNZf2ughGDsm+vKZIgPfqjcL0ZCFLr8FJIbt6geash4O4LcMApzB
	JUyNIc54ME+BfL/F2JS1eCQq+ttC3JVgRM2TSCnPPvEoaEFAmawyWz9h+/0cracuI80zMYtDlCp
	qRcqwyYUg54GJvvgZpjz6hauRCHln0xWItTHkihDskuahKyWT2M1Z9kyoCW/cHt4pd5o9WppAUZ
	FC+eTVfyIwb0gu0Ysws+gJfhRc1MbpZz640rvl9iHXuNvctzPUcI/tMiqF8xPGraq9Ryt2BlON8
	9CgmHglny9UhJHlEDPOsy5d8il1qtrBir/qOweE+lemJX86+e+psfqH+eg9zLdboYk/N+FPIi6o
	vU9PA0+lFybT9h2LnnwgUrZy0gOB42cUi4ANqpeuzhRL1qzjUlbN5NDeYg7cmo982r+WErg+1lJ
	Q==
X-Received: by 2002:a05:622a:1e0c:b0:51a:896c:9abc with SMTP id d75a77b69052e-51c26a6d79amr46819031cf.30.1782944495109;
        Wed, 01 Jul 2026 15:21:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d137sm9709076d6.9.2026.07.01.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:21:34 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 0/2] mm: don't apply task mempolicy to unmovable kernel allocations
Date: Wed,  1 Jul 2026 18:21:10 -0400
Message-ID: <20260701222112.2820098-1-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series stops a task's NUMA mempolicy from steering incidental,
global kernel allocations that have no real relationship to the task.

VMA-less allocations (alloc_pages(), folio_alloc(), vmalloc(), slab
refils) - fall back to the current task's mempolicy as their only
placement hint.

This sweeps in kernel memory that is not the task's:
  - unaccounted slab
  - kernel page tables
  - driver GFP_KERNEL buffers
  - one-off global structures
  - etc

On a uniform multi-socket system this is not implicitly harmful.
On a tiered-memory system a task's interleave/bind can push these
incidental allocations onto slower tiers and cause regressions.

The memory may outlive the task, or be shared by others, yet a single
task's policy dictated where it landed.  

The fix is to only follow the task policy for allocations that are
plausibly the task's:

  - movable allocations (mostly user data), and
  - allocations explicitly tied to the task via __GFP_ACCOUNT.

Everything else (unmovable and unaccounted) prefers node-local.

Cpuset still enforces any hard confinements (ALLOC_CPUSET), and
fallback allocations may still cause spillage, but this at least
prevents interleave policies from making poor placements.

Patch 1 makes page-cache placement explicit in filemap to retain
existing behavior (pagecache and metadata still end up following
the task mempolicy).  Since the metadata can be significant on
some systems, retaining this behavior will ensure there are no
surprises for existing users.

If we want to change this behavior, this patch is droppable.

Patch 2 adds the alloc_task_policy() filter for bare allocations.

Test 1: Page cache follows the task policy (unchanged)
======
A process running on node0 but bound to node1:
   (numactl --cpunodebind=0 --membind=1) writes a 1.2G file.

  membind=1 (non-local):  FilePages  node0 +0MB     node1 +1200MB
  membind=0 (control):    FilePages  node0 +1200MB  node1 +0MB 


Test 2: Incidental kernel allocations no longer follow it (changed)
======
Added a debugfs interface to do movable and kernel allocations:

 w/ --cpunodebind=0
 numactl ... --membind=1      echo 100000 > .../alloc_kernel
 numactl ... --membind=1      echo 100000 > .../alloc_movable
 numactl ... --interleave=all echo 100000 > .../alloc_kernel

                       GFP_KERNEL          GFP_HIGHUSER_MOVABLE
membind=1    base:     node1 (follows)     node1
             patched:  node0 (local)       node1 (follows)

interleave   base:     50/50 (follows)     50/50
             patched:  node0 (local)       50/50 (follows)

Movable (user) allocations are unaffected in every case.

The unmovable unaccounted kernel allocations stop following the
task policy and place node-local. With no policy set, both place
node-local as before.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

Gregory Price (2):
  mm/filemap: place page-cache folios via an explicit mempolicy
  mm/mempolicy: skip task mempolicy for unmovable unaccounted kernel
    allocations

 mm/filemap.c   |  5 ++++-
 mm/mempolicy.c | 40 ++++++++++++++++++++++++++++------------
 2 files changed, 32 insertions(+), 13 deletions(-)

--
2.53.0-Meta

